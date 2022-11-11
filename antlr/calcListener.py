# Generated from calc.g4 by ANTLR 4.8
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .calcParser import calcParser
else:
    from calcParser import calcParser

# This class defines a complete listener for a parse tree produced by calcParser.
class calcListener(ParseTreeListener):

    # Enter a parse tree produced by calcParser#AtomExpr.
    def enterAtomExpr(self, ctx:calcParser.AtomExprContext):
        pass

    # Exit a parse tree produced by calcParser#AtomExpr.
    def exitAtomExpr(self, ctx:calcParser.AtomExprContext):
        pass


    # Enter a parse tree produced by calcParser#ParenExpr.
    def enterParenExpr(self, ctx:calcParser.ParenExprContext):
        pass

    # Exit a parse tree produced by calcParser#ParenExpr.
    def exitParenExpr(self, ctx:calcParser.ParenExprContext):
        pass


    # Enter a parse tree produced by calcParser#OpExpr.
    def enterOpExpr(self, ctx:calcParser.OpExprContext):
        pass

    # Exit a parse tree produced by calcParser#OpExpr.
    def exitOpExpr(self, ctx:calcParser.OpExprContext):
        pass



del calcParser