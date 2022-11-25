from lark import Lark, Visitor, Transformer

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
        print(output)
        return None

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

    def select_clause(self, tree):
        print(tree.pretty)


if __name__ == '__main__':

    parser = LarkParser()
    tree = parser.parse("SELECT id FROM foo;")
