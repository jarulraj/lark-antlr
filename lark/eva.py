from lark import Lark, Visitor, visitors
from pprint import pprint

class LarkParser(object):
    """
    Parser for EVA QL based on Lark
    """

    _instance = None
    _parser = None

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(LarkParser, cls).__new__(cls)
        return cls._instance

    def __init__(self):
        f = open("eva.lark")
        sql_grammar = f.read()
        self._parser = Lark(sql_grammar, parser="lalr")

    def parse(self, query_string: str) -> list:

        # Add semi-colon if missing
        if not query_string.endswith(";"):
            query_string += ";"

        tree = self._parser.parse(query_string)
        output = tree.pretty()
        print("Parse Tree: " + str(output))
        return tree

from typing import Union
from typing import List

class TableInfo:
    """
    stores all the table info, inspired from postgres
    """

    def __init__(self, table_name=None, schema_name=None, database_name=None):
        self._table_name = table_name
        self._schema_name = schema_name
        self._database_name = database_name
        self._table_obj = None

    @property
    def table_name(self):
        return self._table_name

    @property
    def schema_name(self):
        return self._schema_name

    @property
    def database_name(self):
        return self._database_name

    @property
    def table_obj(self):
        return self._table_obj

    @table_obj.setter
    def table_obj(self, obj):
        self._table_obj = obj

    def __str__(self):
        table_info_str = self._table_name

        return table_info_str

    def __eq__(self, other):
        if not isinstance(other, TableInfo):
            return False
        return (
            self.table_name == other.table_name
            and self.schema_name == other.schema_name
            and self.database_name == other.database_name
            and self.table_obj == other.table_obj
        )

    def __hash__(self) -> int:
        return hash(
            (
                self.table_name,
                self.schema_name,
                self.database_name,
                self.table_obj,
            )
        )



class Alias:
    def __init__(self, alias_name: str, col_names: List[str] = []) -> None:
        self._alias_name = alias_name
        self._col_names = col_names

    @property
    def alias_name(self):
        return self._alias_name

    @property
    def col_names(self):
        return self._col_names

    def __hash__(self) -> int:
        return hash((self.alias_name, tuple(self.col_names)))

    def __eq__(self, other):
        if not isinstance(other, Alias):
            return False
        return self.alias_name == other.alias_name and self.col_names == other.col_names

    def __str__(self):
        msg = f"{self.alias_name}"
        if len(self.col_names) > 0:
            msg += f"({str(self.col_names)})"
        return 


class TableRef:
    """
    Attributes:
        : can be one of the following based on the query type:
            TableInfo: expression of table name and database name,
            TableValuedExpression: lateral function calls
            SelectStatement: select statement in case of nested queries,
            JoinNode: join node in case of join queries
        sample_freq: sampling frequency for the table reference
    """

    def __init__(
        self,
        table: Union[TableInfo],
        alias: Alias = None,
        sample_freq: float = None,
    ):

        self._ref_handle = table
        self._sample_freq = sample_freq
        self.alias = alias or self.generate_alias()

    @property
    def sample_freq(self):
        return self._sample_freq

    def is_table_atom(self) -> bool:
        return isinstance(self._ref_handle, TableInfo)

    @property
    def table(self) -> TableInfo:
        assert isinstance(
            self._ref_handle, TableInfo
        ), "Expected \
                TableInfo, got {}".format(
            type(self._ref_handle)
        )
        return self._ref_handle

    def generate_alias(self) -> str:
        # create alias for the table
        # TableInfo -> table_name.lower()
        # SelectStatement -> select
        if isinstance(self._ref_handle, TableInfo):
            return Alias(self._ref_handle.table_name.lower())
        elif isinstance(self._ref_handle, SelectStatement):
            raise RuntimeError("Nested select should have alias")

    def __str__(self):
        table_ref_str = "TABLE REF:: ( {} SAMPLE FREQUENCY {})".format(
            str(self._ref_handle), str(self.sample_freq)
        )
        return table_ref_str

    def __eq__(self, other):
        if not isinstance(other, TableRef):
            return False
        return (
            self._ref_handle == other._ref_handle
            and self.alias == other.alias
            and self.sample_freq == other.sample_freq
        )

    def __hash__(self) -> int:
        return hash((self._ref_handle, self.alias, self.sample_freq))


from enum import Enum, auto, unique


@unique
class StatementType(Enum):
    """
    Manages enums for all the sql-like statements supported
    """

    SELECT = (auto(),)
    CREATE = (auto(),)
    RENAME = (auto(),)
    DROP = (auto(),)
    INSERT = (auto(),)
    CREATE_UDF = (auto(),)
    LOAD_DATA = (auto(),)
    UPLOAD = (auto(),)
    CREATE_MATERIALIZED_VIEW = (auto(),)
    SHOW = (auto(),)
    DROP_UDF = auto()
    EXPLAIN = (auto(),)
    # add other types

class AbstractStatement:
    """
    Base class for all Statements
    Attributes
    ----------
    stmt_type : StatementType
        the type of this statement - Select or Insert etc
    """

    def __init__(self, stmt_type: StatementType):
        self._stmt_type = stmt_type

    @property
    def stmt_type(self):
        return self._stmt_type

    def __hash__(self) -> int:
        return hash(self.stmt_type)

class RenameTableStatement(AbstractStatement):
    """Rename Table Statement constructed after parsing the input query
    Attributes:
        old_table_ref: table reference in the rename table statement
        new_table_name: new name of the table
    """

    def __init__(self, old_table_ref: TableRef, new_table_name: TableInfo):
        super().__init__(StatementType.RENAME)
        self._old_table_ref = old_table_ref
        self._new_table_name = new_table_name

    def __str__(self) -> str:
        print_str = "RENAME TABLE {} TO {} ".format(
            self._old_table_ref, self._new_table_name
        )
        return print_str

    @property
    def old_table_ref(self):
        return self._old_table_ref

    @property
    def new_table_name(self):
        return self._new_table_name

    def __eq__(self, other):
        if not isinstance(other, RenameTableStatement):
            return False
        return (
            self.old_table_ref == other.old_table_ref
            and self.new_table_name == other.new_table_name
        )


class Interpreter(visitors.Interpreter):

    def __init__(self, source):
        super().__init__()
        self.source = source

    def start(self, tree):
        return self.visit_children(tree)

    def sql_statement(self, tree):
        return self.visit(tree.children[0])

    def rename_table(self, tree):

        #print(tree.children[0])
        #print(tree.children[1])
        #print(tree.children[2])
        #print(tree.children[3])
        #print(tree.children[4])

        old_table_info = self.visit(tree.children[2])
        new_table_info = self.visit(tree.children[4])

        return RenameTableStatement(TableRef(old_table_info), new_table_info)

        #old_table_ref = TableRef(self.visit(tree.children[1]))
        #new_table_name = self.visit(tree.children[3])
        #rename_stmt = RenameTableStatement(old_table_ref, new_table_name)

    def table_name(self, tree):
        table_name = self.visit(tree.children[0])
        return TableInfo(table_name)

    def full_id(self,tree):
        return self.visit(tree.children[0])
   
    def uid(self,tree):
        return self.visit(tree.children[0])

    def simple_id(self, tree):
        simple_id = str(tree.children[0])
        return simple_id


if __name__ == '__main__':

    parser = LarkParser()
    source = "RENAME TABLE student TO student_info"
    tree = parser.parse(source)
    output = Interpreter(source).visit(tree)


    expected_stmt = RenameTableStatement(
                        TableRef(TableInfo("student")), 
                        TableInfo("student_info")
                    )

    pprint(output[0][0])

    if(output[0][0] == expected_stmt):
        print("equal")

