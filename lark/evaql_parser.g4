
parser grammar evaql_parser;

// SKIP

SPACE:                               [ \t\r\n]+    -> channel(HIDDEN);
SPEC_EVAQL_COMMENT:                  '/*!' .+? '*/' -> channel(EVAQLCOMMENT);
COMMENT_INPUT:                       '/*' .*? '*/' -> channel(HIDDEN);
LINE_COMMENT:                        (
                                       ('-- ' | '#') ~[\r\n]* ('\r'? '\n' | EOF)
                                       | '--' ('\r'? '\n' | EOF)
                                     ) -> channel(HIDDEN);

// Keywords
// Common Keywords

ALL:                                 'ALL';
ALTER:                               'ALTER';
AND:                                 'AND';
ANY:                                 'ANY';
ANYDIM:                              'ANYDIM';
AS:                                  'AS';
ASC:                                 'ASC';
BLOB:                                'BLOB';
BY:                                  'BY';
COLUMN:                              'COLUMN';
CREATE:                              'CREATE';
DATABASE:                            'DATABASE';
DEFAULT:                             'DEFAULT';
DELETE:                              'DELETE';
DESC:                                'DESC';
DESCRIBE:                            'DESCRIBE';
DISTINCT:                            'DISTINCT';
DROP:                                'DROP';
EXIT:                                'EXIT';
EXISTS:                              'EXISTS';
EXPLAIN:                             'EXPLAIN';
FALSE:                               'FALSE';
FROM:                                'FROM';
GROUP:                               'GROUP';
HAVING:                              'HAVING';
IF:                                  'IF';
IN:                                  'IN';
FILE:                                'FILE';
INDIR:                               'INDIR';
INTO:                                'INTO';
INDEX:                               'INDEX';
INSERT:                              'INSERT';
IS:                                  'IS';
JOIN:                                'JOIN';
KEY:                                 'KEY';
LATERAL:                             'LATERAL';
LIKE:                                'LIKE';
LIMIT:                               'LIMIT';
LOAD:                                'LOAD';
NO:                                  'NO';
NOT:                                 'NOT';
NULL_LITERAL:                        'NULL';
OFFSET:                              'OFFSET';
ON:                                  'ON';
OR:                                  'OR';
ORDER:                               'ORDER';
PATH:                                'PATH';
PRIMARY:                             'PRIMARY';
REFERENCES:                          'REFERENCES';
RENAME:                              'RENAME';
SAMPLE:                              'SAMPLE';
SELECT:                              'SELECT';
SET:                                 'SET';
SHUTDOWN:                            'SHUTDOWN';
SHOW:                                'SHOW';
SOME:                                'SOME';
TABLE:                               'TABLE';
TABLES:                              'TABLES';
TO:                                  'TO';
TRUE:                                'TRUE';
UDFS:                                'UDFS';
UNION:                               'UNION';
UNIQUE:                              'UNIQUE';
UNKNOWN:                             'UNKNOWN';
UNLOCK:                              'UNLOCK';
UNNEST:                              'UNNEST';
UNSIGNED:                            'UNSIGNED';
UPDATE:                              'UPDATE';
UPLOAD:                              'UPLOAD';
USING:                               'USING';
VALUES:                              'VALUES';
WHERE:                               'WHERE';
XOR:                                 'XOR';

// File Formats
WITH:                 'WITH';
FORMAT:               'FORMAT';
CSV:                  'CSV';
VIDEO:                'VIDEO';

// EVAQL keywords

ERROR_BOUNDS:						 'ERROR_WITHIN';
CONFIDENCE_LEVEL:					 'AT_CONFIDENCE';

// Index types
BTREE:                               'BTREE';
HASH:                                'HASH';

// Computer vision tasks

OBJECT_DETECTION:                    'OBJECT_DETECTION';
ACTION_CLASSICATION:                 'ACTION_CLASSICATION';

// DATA TYPE Keywords

BOOLEAN:                             'BOOLEAN';
INTEGER:                             'INTEGER';
FLOAT:                               'FLOAT';
TEXT:                                'TEXT';
NDARRAY:                             'NDARRAY';
INT8:                                'INT8';
UINT8:                               'UINT8';
INT16:                               'INT16';
INT32:                               'INT32';
INT64:                               'INT64';
UNICODE:                             'UNICODE';
BOOL:                                'BOOL';
FLOAT32:                             'FLOAT32';
FLOAT64:                             'FLOAT64';
DECIMAL:                             'DECIMAL';
STR:                                 'STR';
DATETIME:                            'DATETIME';
ANYTYPE:                             'ANYTYPE';

// Group function Keywords

AVG:                                 'AVG';
COUNT:                               'COUNT';
MAX:                                 'MAX';
MIN:                                 'MIN';
STD:                                 'STD';
SUM:                                 'SUM';
FCOUNT: 						     'FCOUNT';

// Keywords, but can be ID
// Common Keywords, but can be ID

AUTO_INCREMENT:                      'AUTO_INCREMENT';
COLUMNS:                             'COLUMNS';
HELP:                                'HELP';
TEMPTABLE:                           'TEMPTABLE';
VALUE:                               'VALUE';

// UDF
UDF:						                'UDF';
INPUT:                          'INPUT';
OUTPUT:                         'OUTPUT';
TYPE:                           'TYPE';
IMPL:                           'IMPL';

// MATERIALIZED
MATERIALIZED:                   'MATERIALIZED';
VIEW:                           'VIEW';

// Common function names

ABS:                                 'ABS';

// Operators
// Operators. Assigns

VAR_ASSIGN:                          ':=';
PLUS_ASSIGN:                         '+=';
MINUS_ASSIGN:                        '-=';
MULT_ASSIGN:                         '*=';
DIV_ASSIGN:                          '/=';
MOD_ASSIGN:                          '%=';
AND_ASSIGN:                          '&=';
XOR_ASSIGN:                          '^=';
OR_ASSIGN:                           '|=';


// Operators. Arithmetics

STAR:                                '*';
DIVIDE:                              '/';
MODULE:                              '%';
PLUS:                                '+';
MINUSMINUS:                          '--';
MINUS:                               '-';
DIV:                                 'DIV';
MOD:                                 'MOD';


// Operators. Comparation

EQUAL_SYMBOL:                        '=';
GREATER_SYMBOL:                      '>';
LESS_SYMBOL:                         '<';
EXCLAMATION_SYMBOL:                  '!';


// Operators. Bit

BIT_NOT_OP:                          '~';
BIT_OR_OP:                           '|';
BIT_AND_OP:                          '&';
BIT_XOR_OP:                          '^';

// Constructors symbols

DOT:                                 '.';
LR_BRACKET:                          '(';
RR_BRACKET:                          ')';
LR_SQ_BRACKET:                       '[';
RR_SQ_BRACKET:                       ']';
COMMA:                               ',';
SEMI:                                ';';
AT_SIGN:                             '@';
ZERO_DECIMAL:                        '0';
ONE_DECIMAL:                         '1';
TWO_DECIMAL:                         '2';
SINGLE_QUOTE_SYMB:                   '\'';
DOUBLE_QUOTE_SYMB:                   '"';
REVERSE_QUOTE_SYMB:                  '`';
COLON_SYMB:                          ':';

// Literal Primitives

STRING_LITERAL:                      DQUOTA_STRING | SQUOTA_STRING;
DECIMAL_LITERAL:                     DEC_DIGIT+;
REAL_LITERAL:                        (DEC_DIGIT+)? '.' DEC_DIGIT+
                                     | DEC_DIGIT+ '.' EXPONENT_NUM_PART
                                     | (DEC_DIGIT+)? '.' (DEC_DIGIT+ EXPONENT_NUM_PART)
                                     | DEC_DIGIT+ EXPONENT_NUM_PART;
NULL_SPEC_LITERAL:                   '\\' 'N';



// Hack for dotID
// Prevent recognize string:         .123somelatin AS ((.123), FLOAT_LITERAL), ((somelatin), ID)
//  it must recoginze:               .123somelatin AS ((.), DOT), (123somelatin, ID)

DOT_ID:                              '.' ID_LITERAL;



// Identifiers

ID:                                  ID_LITERAL;
// DOUBLE_QUOTE_ID:                  '"' ~'"'+ '"';
REVERSE_QUOTE_ID:                    '`' ~'`'+ '`';
STRING_USER_NAME:                    (
                                       SQUOTA_STRING | DQUOTA_STRING
                                       | BQUOTA_STRING | ID_LITERAL
                                     ) '@'
                                     (
                                       SQUOTA_STRING | DQUOTA_STRING
                                       | BQUOTA_STRING | ID_LITERAL
                                     );
LOCAL_ID:                            '@'
                                (
                                  [A-Z0-9._$]+
                                  | SQUOTA_STRING
                                  | DQUOTA_STRING
                                  | BQUOTA_STRING
                                );
GLOBAL_ID:                           '@' '@'
                                (
                                  [A-Z0-9._$]+
                                  | BQUOTA_STRING
                                );

// Fragments for Literal primitives

fragment EXPONENT_NUM_PART:          'E' '-'? DEC_DIGIT+;
fragment ID_LITERAL:                 [A-Za-z_$0-9]*?[A-Za-z_$]+?[A-Za-z_$0-9]*;
fragment DQUOTA_STRING:              '"' ( '\\'. | '""' | ~('"'| '\\') )* '"';
fragment SQUOTA_STRING:              '\'' ('\\'. | '\'\'' | ~('\'' | '\\'))* '\'';
fragment BQUOTA_STRING:              '`' ( '\\'. | '``' | ~('`'|'\\'))* '`';
fragment DEC_DIGIT:                  [0-9];
fragment BIT_STRING_L:               'B' '\'' [01]+ '\'';


// Top Level Description

root
    : sqlStatements? MINUSMINUS? EOF
    ;

sqlStatements
    : (sqlStatement MINUSMINUS? SEMI | emptyStatement)*
    (sqlStatement (MINUSMINUS? SEMI)? | emptyStatement)
    ;

sqlStatement
    : ddlStatement | dmlStatement | utilityStatement
    ;

emptyStatement
    : SEMI
    ;

ddlStatement
    : createDatabase | createTable | createIndex | createUdf | createMaterializedView
    | dropDatabase | dropTable | dropUdf | dropIndex | renameTable
    ;

dmlStatement
    : selectStatement | insertStatement | updateStatement
    | deleteStatement | loadStatement | uploadStatement
    ;

utilityStatement
    : simpleDescribeStatement | helpStatement | showStatement
    ;

// Data Definition Language

//    Create statements

createDatabase
    : CREATE DATABASE
      ifNotExists? uid
    ;

createIndex
    : CREATE
      INDEX uid indexType?
      ON tableName indexColumnNames
    ;

createTable
    : CREATE TABLE
      ifNotExists?
      tableName createDefinitions                                  #columnCreateTable
    ;

// Rename statements
renameTable
    : RENAME TABLE
      oldtableName
      TO newtableName
    ;

// Create UDFs
createUdf
    : CREATE UDF
      ifNotExists?
      udfName
      INPUT  createDefinitions
      OUTPUT createDefinitions
      TYPE   udfType
      IMPL   udfImpl
    ;

// Create Materialized View
createMaterializedView
    : CREATE MATERIALIZED VIEW
      ifNotExists?
      tableName ('(' columns '=' uidList ')')
      AS
      selectStatement
      ;

// details
udfName
    : uid
    ;

udfType
    : uid
    ;

udfImpl
    : stringLiteral
    ;

indexType
    : USING (BTREE | HASH)
    ;

createDefinitions
    : '(' createDefinition (',' createDefinition)* ')'
    ;

createDefinition
    : uid columnDefinition                                          #columnDeclaration
    | indexColumnDefinition                                         #indexDeclaration
    ;

columnDefinition
    : dataType columnConstraint*
    ;

columnConstraint
    : nullNotnull                                                   #nullColumnConstraint
    | DEFAULT defaultValue                                          #defaultColumnConstraint
    | PRIMARY? KEY                                                  #primaryKeyColumnConstraint
    | UNIQUE KEY?                                                   #uniqueKeyColumnConstraint
    ;

indexColumnDefinition
    : INDEX uid? indexType?
      indexColumnNames                                              #simpleIndexDeclaration
    ;

//    Drop statements

dropDatabase
    : DROP DATABASE ifExists? uid
    ;

dropIndex
    : DROP INDEX
      uid ON tableName
    ;

dropTable
    : DROP TABLE ifExists?
      tables
    ;

dropUdf
    : DROP UDF ifExists?
      udfName
    ;

// Data Manipulation Language

//    Primary DML Statements

deleteStatement
    : singleDeleteStatement
    ;

insertStatement
    : INSERT
      INTO? tableName
      (
        ('(' columns '=' uidList ')')? insertStatementValue
      )
    ;

selectStatement
    : querySpecification                                            #simpleSelect
    | left '=' selectStatement UNION unionAll '=' ALL? right '=' selectStatement   #unionSelect
    ;

updateStatement
    : singleUpdateStatement
    ;


loadStatement
    : LOAD 
      FILE fileName
      INTO tableName
        (
            ('(' columns '=' uidList ')')
        )?
      (WITH fileOptions)?
    ;

fileOptions
    : FORMAT fileFormat '=' (CSV|VIDEO)
    ;

uploadStatement
    : UPLOAD
      PATH fileName
      BLOB videoBlob
      INTO tableName
        (
            ('(' columns '=' uidList ')')
        )?
      (WITH fileOptions)?
    ;

fileName
    : stringLiteral
    ;

videoBlob
    : stringLiteral
    ;

// details

insertStatementValue
    : selectStatement
    | insertFormat '=' (VALUES | VALUE)
      '(' expressionsWithDefaults ')'
        (',' '(' expressionsWithDefaults ')')*
    ;

updatedElement
    : fullColumnName '=' (expression | DEFAULT)
    ;


//    Detailed DML Statements

singleDeleteStatement
    : DELETE
    FROM tableName
      (WHERE expression)?
      orderByClause? (LIMIT decimalLiteral)?
    ;

singleUpdateStatement
    : UPDATE tableName (AS? uid)?
      SET updatedElement (',' updatedElement)*
      (WHERE expression)? orderByClause? limitClause?
    ;

// details

orderByClause
    : ORDER BY orderByExpression (',' orderByExpression)*
    ;

orderByExpression
    : expression order '=' (ASC | DESC)?
    ;
// Forcing EXPLICIT JOIN KEYWORD
tableSources
    : tableSource
    ;

//tableSources
//    : tableSource (',' tableSource)*
//    ;

tableSource
    : tableSourceItemWithSample joinPart*                #tableSourceBase
    ;

tableSourceItemWithSample
    : tableSourceItem (AS? uid)? sampleClause?
    ;

tableSourceItem
    : tableName                                         #atomTableItem
    | subqueryTableSourceItem                           #subqueryTableItem
    ;

tableValuedFunction
    : functionCall                                
    | UNNEST LR_BRACKET functionCall RR_BRACKET   
    ;

subqueryTableSourceItem
    : (
      selectStatement |
      LR_BRACKET selectStatement RR_BRACKET
      )
    ;

sampleClause
    : SAMPLE decimalLiteral
    ;


joinPart
    : JOIN tableSourceItemWithSample
      (
        ON expression
        | USING LR_BRACKET uidList RR_BRACKET
      )?                                                #innerJoin
    |
      JOIN LATERAL tableValuedFunction aliasClause?     #lateralJoin
    ;

aliasClause
    : AS? uid '(' uidList ')'
    | AS? uid
    ;


//    Select Statement's Details

queryExpression
    : '(' querySpecification ')'
    | '(' queryExpression ')'
    ;

querySpecification
    : SELECT selectElements
      fromClause orderByClause? limitClause?
      errorBoundsExpression? confidenceLevelExpression?
    ;

// details

selectElements
    : (star '=' '*' | selectElement ) (',' selectElement)*
    ;

selectElement
    : fullId '.' '*'                                                #selectStarElement
    | fullColumnName (AS? uid)?                                     #selectColumnElement
    | functionCall (AS? uid)?                                       #selectFunctionElement
    | (LOCAL_ID VAR_ASSIGN)? expression (AS? uid)?                  #selectExpressionElement
    ;

fromClause
    : FROM tableSources
      (WHERE whereExpr '=' expression)?
      (
        GROUP BY
        groupByItem (',' groupByItem)*
      )?
      (HAVING havingExpr '=' expression)?
    ;

groupByItem
    : expression order '=' (ASC | DESC)?
    ;

limitClause
    : LIMIT
    (
      (offset'='decimalLiteral ',')? limit'='decimalLiteral
      | limit'='decimalLiteral OFFSET offset'='decimalLiteral
    )
    ;

errorBoundsExpression
	: ERROR_BOUNDS REAL_LITERAL
	;

confidenceLevelExpression
	: CONFIDENCE_LEVEL REAL_LITERAL
	;

//    Other administrative statements

shutdownStatement
    : SHUTDOWN
    ;

// Utility Statements


simpleDescribeStatement
    : DESCRIBE tableName
    ;

helpStatement
    : HELP STRING_LITERAL
    ;

showStatement
    : SHOW (UDFS | TABLES)
    ;

// Common Clauses

//    DB Objects

fullId
    : uid (DOT_ID | '.' uid)?
    ;

tableName
    : fullId
    ;
oldtableName
    : fullId
    ;
newtableName
    : fullId
    ;

fullColumnName
    : uid (dottedId dottedId? )?
    ;

indexColumnName
    : uid ('(' decimalLiteral ')')? sortType'='(ASC | DESC)?
    ;

userName
    : STRING_USER_NAME | ID;

uuidSet
    : decimalLiteral '-' decimalLiteral '-' decimalLiteral
      '-' decimalLiteral '-' decimalLiteral
      (':' decimalLiteral '-' decimalLiteral)+
    ;

uid
    : simpleId
    //| DOUBLE_QUOTE_ID
    | REVERSE_QUOTE_ID
    ;

simpleId
    : ID
    ;

dottedId
    : DOT_ID
    | '.' uid
    ;


//    Literals

decimalLiteral
    : DECIMAL_LITERAL | ZERO_DECIMAL | ONE_DECIMAL | TWO_DECIMAL | ANYDIM
    ;

stringLiteral
    : STRING_LITERAL
    ;

booleanLiteral
    : TRUE | FALSE;

nullNotnull
    : NOT? (NULL_LITERAL | NULL_SPEC_LITERAL)
    ;

arrayLiteral
    : LR_SQ_BRACKET  constant (',' constant)* RR_SQ_BRACKET
    | LR_SQ_BRACKET RR_SQ_BRACKET
    ;

constant
    : stringLiteral | decimalLiteral
    | '-' decimalLiteral
    | booleanLiteral
    | REAL_LITERAL
    | NOT? nullLiteral'='(NULL_LITERAL | NULL_SPEC_LITERAL)
    | arrayLiteral
    ;


//    Data Types

arrayType
    : INT8 | UINT8 | INT16 | INT32 | INT64
    | UNICODE | BOOL
    | FLOAT32 | FLOAT64 | DECIMAL
    | STR | DATETIME | ANYTYPE
    ;

dataType
    : BOOLEAN                                         #simpleDataType
    | TEXT lengthOneDimension?                        #dimensionDataType
    | INTEGER UNSIGNED?                               #integerDataType
    | FLOAT lengthTwoDimension? UNSIGNED?             #dimensionDataType
    | NDARRAY arrayType? lengthDimensionList?         #arrayDataType
    | ANYTYPE                                         #anyDataType
    ;

lengthOneDimension
    : '(' decimalLiteral ')'
    ;

lengthTwoDimension
    : '(' decimalLiteral ',' decimalLiteral ')'
    ;

lengthDimensionList
    : '(' ( decimalLiteral  ',')* decimalLiteral ')'
    ;

//    Common Lists

uidList
    : uid (',' uid)*
    ;

tables
    : tableName (',' tableName)*
    ;

indexColumnNames
    : '(' indexColumnName (',' indexColumnName)* ')'
    ;

expressions
    : expression (',' expression)*
    ;

expressionsWithDefaults
    : expressionOrDefault (',' expressionOrDefault)*
    ;


//    Common Expressions

defaultValue
    : NULL_LITERAL
    | constant
    ;

expressionOrDefault
    : expression | DEFAULT
    ;

ifExists
    : IF EXISTS;

ifNotExists
    : IF NOT EXISTS;


//    Functions

functionCall
    : udfFunction                                              #udfFunctionCall
    | aggregateWindowedFunction                                #aggregateFunctionCall
    ;

udfFunction
    : simpleId '(' functionArgs ')' dottedId?
    ;


aggregateWindowedFunction
    : (AVG | MAX | MIN | SUM)
      '(' aggregator'='(ALL | DISTINCT)? functionArg ')'
    | COUNT '(' (starArg'=''*' | aggregator'='ALL? functionArg) ')'
    ;

functionArgs
    : (constant | fullColumnName | functionCall | expression)
    (
      ','
      (constant | fullColumnName | functionCall | expression)
    )*
    ;

functionArg
    : constant | fullColumnName | functionCall | expression
    ;


//    Expressions, predicates

// Simplified approach for expression
expression
    : notOperator'='(NOT | '!') expression                            #notExpression
    | expression logicalOperator expression                         #logicalExpression
    | predicate IS NOT? testValue'='(TRUE | FALSE | UNKNOWN)          #isExpression
    | predicate                                                     #predicateExpression
    ;

predicate
    : predicate NOT? IN '(' (selectStatement | expressions) ')'     #inPredicate
    | predicate IS nullNotnull                                      #isNullPredicate
    | left'='predicate comparisonOperator right'='predicate             #binaryComparisonPredicate
    | predicate comparisonOperator
      quantifier'='(ALL | ANY | SOME) '(' selectStatement ')'         #subqueryComparisonPredicate
    | predicate NOT? LIKE predicate (STRING_LITERAL)?               #likePredicate
    | (LOCAL_ID VAR_ASSIGN)? expressionAtom                         #expressionAtomPredicate
    ;


// Add in ASTVisitor nullNotnull in constant
expressionAtom
    : constant                                                      #constantExpressionAtom
    | fullColumnName                                                #fullColumnNameExpressionAtom
    | functionCall                                                  #functionCallExpressionAtom
    | unaryOperator expressionAtom                                  #unaryExpressionAtom
    | '(' expression (',' expression)* ')'                          #nestedExpressionAtom
    | '(' selectStatement ')'                                       #subqueryExpessionAtom
    | left'='expressionAtom bitOperator right'='expressionAtom          #bitExpressionAtom
    | left'='expressionAtom mathOperator right'='expressionAtom         #mathExpressionAtom
    ;

unaryOperator
    : '!' | '~' | '+' | '-' | NOT
    ;

comparisonOperator
    : '=' | '>' | '<' | '<' '=' | '>' '='
    | '<' '>' | '!' '=' | '<' '=' '>'
    | '@' '>' | '<' '@'
    ;

logicalOperator
    : AND | '&' '&' | XOR | OR | '|' '|'
    ;

bitOperator
    : '<' '<' | '>' '>' | '&' | '^' | '|'
    ;

mathOperator
    : '*' | '/' | '%' | DIV | MOD | '+' | '-' | '--'
    ;
