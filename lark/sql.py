from lark import Lark, Visitor, Transformer

sql_grammar = """
        start            : stmnt*
        stmnt            : select_stmnt            
                           | drop_stmnt
        select_stmnt     : select_clause from_clause? group_by_clause?  having_clause? order_by_clause? limit_clause? SEMICOLON

        select_clause    : "select"i selectables
        selectables      : column_name ("," column_name)*
        from_clause      : "from"i source where_clause?
        where_clause     : "where"i condition
        group_by_clause  : "group"i "by"i column_name ("," column_name)*
        having_clause    : "having"i condition
        order_by_clause  : "order"i "by" (column_name ("asc"i|"desc"i)?)*
        limit_clause     : "limit"i INTEGER_NUMBER ("offset"i INTEGER_NUMBER)?

        // NOTE: there should be no on-clause on cross join and this will have to enforced post parse
        source           : joining? table_name table_alias?     -> source
        joining          : source join_modifier? JOIN source ON condition
        
        //source           : table_name table_alias? joined_source?
        //joined_source    : join_modifier? JOIN table_name table_alias? ON condition
        join_modifier    : "inner" | ("left" "outer"?) | ("right" "outer"?) | ("full" "outer"?) | "cross"
        
        condition        : or_clause+
        or_clause        : and_clause ("or" and_clause)*
        and_clause       : predicate ("and" predicate)*

        // NOTE: order of operator should be longest tokens first
   
        predicate        : comparison ( ( EQUAL | NOT_EQUAL ) comparison )* 
        comparison       : term ( ( LESS_EQUAL | GREATER_EQUAL | LESS | GREATER ) term )* 
        term             : factor ( ( "-" | "+" ) factor )*
        factor           : unary ( ( "/" | "*" ) unary )*
        unary            : ( "!" | "-" ) unary
                         | primary
        primary          : INTEGER_NUMBER | FLOAT_NUMBER | STRING | "true" | "false" | "null"
                         | IDENTIFIER

        drop_stmnt       : "drop" "table" table_name

        FLOAT_NUMBER     : INTEGER_NUMBER "." ("0".."9")*

        column_name      : IDENTIFIER   -> column
        table_name       : IDENTIFIER   -> table
        table_alias      : IDENTIFIER

        // keywords
        // define keywords as they have higher priority
        SELECT.5           : "select"i
        FROM.5             : "from"i
        WHERE.5            : "where"i
        JOIN.5             : "join"i
        ON.5               : "on"i

        // operators
        STAR              : "*"
        LEFT_PAREN        : "("
        RIGHT_PAREN       : ")"
        LEFT_BRACKET      : "["
        RIGHT_BRACKET     : "]"
        DOT               : "."
        EQUAL             : "="
        LESS              : "<"
        GREATER           : ">"
        COMMA             : ","

        // 2-char ops
        LESS_EQUAL        : "<="
        GREATER_EQUAL     : ">="
        NOT_EQUAL         : ("<>" | "!=")

        SEMICOLON         : ";"

        IDENTIFIER       : ("_" | ("a".."z") | ("A".."Z"))* ("_" | ("a".."z") | ("A".."Z") | ("0".."9"))+

        %import common.ESCAPED_STRING   -> STRING
        %import common.SIGNED_NUMBER    -> INTEGER_NUMBER
        %import common.WS
        %ignore WS
"""

class StringTransformer(Transformer):
    """
    Placeholder transformer. May be useful later for shaping the parsed AST
    """
    word_dict = dict(
    )

    def WORD(self, word):
        pass

class SQLVisitor(Visitor):

    def __init__(self, state):
        self.state = state

    def column(self, tree):
        column_name = str(tree.children[0])
        print("column_name: " + column_name)
        return column_name

    def table(self, tree):
        table_name = str(tree.children[0])
        print("table_name: " + table_name)
        return table_name


if __name__ == '__main__':
    sql_parser = Lark(sql_grammar, parser='lalr')
    tree = sql_parser.parse("select id from foo;")
    visitor = SQLVisitor(state=None)
    visitor.visit(tree)

    a = tree.pretty()
    print(a)