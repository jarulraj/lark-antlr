# Generated from calc.g4 by ANTLR 4.8
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .calcParser import calcParser
else:
    from calcParser import calcParser

# This class defines a complete generic visitor for a parse tree produced by calcParser.

class calcVisitor(ParseTreeVisitor):

    # Visit a parse tree produced by calcParser#AtomExpr.
    def visitAtomExpr(self, ctx:calcParser.AtomExprContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by calcParser#ParenExpr.
    def visitParenExpr(self, ctx:calcParser.ParenExprContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by calcParser#OpExpr.
    def visitOpExpr(self, ctx:calcParser.OpExprContext):
        return self.visitChildren(ctx)



del calcParser