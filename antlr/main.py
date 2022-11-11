#!/usr/bin/python3
import sys
from antlr4 import *
from calcLexer import calcLexer
from calcParser import calcParser
from calcVisitor import calcVisitor

class CalcVisitor(calcVisitor):
    def visitAtomExpr(self, ctx:calcParser.AtomExprContext):
        return int(ctx.getText())

    def visitParenExpr(self, ctx:calcParser.ParenExprContext):
        return self.visit(ctx.expr())

    def visitOpExpr(self, ctx:calcParser.OpExprContext):
        l = self.visit(ctx.left)
        r = self.visit(ctx.right)

        op = ctx.op.text
        if op == '+':
            return l + r
        elif op == '-':
            return l - r
        elif op == '*':
            return l * r
        elif op == '/':
            if r == 0:
                print('divide by zero!')
                return 0
            return l / r



def calc(line) -> float:
    input_stream = InputStream(line)

    # lexing
    lexer = calcLexer(input_stream)
    stream = CommonTokenStream(lexer)

    # parsing
    parser = calcParser(stream)
    tree = parser.expr()

    # use customized visitor to traverse AST
    visitor = CalcVisitor()
    return visitor.visit(tree)


if __name__ == '__main__':
    while True:
        print(">>> ", end='')
        line = input()
        print(calc(line))
