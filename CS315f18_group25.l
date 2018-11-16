/* Revised SCREW.l for project#2 */
%option yylineno
DIGIT  [0-9]
LETTER [A-Za-z]
CHAR ({DIGIT}|{LETTER}|<|>|!|@|#|$|%|^|&|*|(|)|_|+|}|{|]|[|:|\|;|,|.|/|)
COMMA ,
ALPHANUMERIC ({LETTER}|{DIGIT})
LEFT_PTH \(
RIGHT_PTH \)
LEFT_CURLY \{
RIGHT_CURLY \}
TRUTH_VAL True|False
COMMENT \#([a-z]|[A-Z]|[0-9]|" ")*
INTEGER {DIGIT}+
FLOAT {DIGIT}+.{DIGIT}+
RETURN return
LOWERCASE [a-z]
UPPERCASE [A-Z]
DIRECTION (left|right)
VAR_IDENTIFIER {LOWERCASE}([A-Za-z]|[0-9]|"_")*
CONST_IDENTIFIER {UPPERCASE}([A-Z]|[0-9]|"_")*
FUN_IDENTIFIER {UPPERCASE}([A-Za-z]|[0-9]|"_")*
STRING '([A-Za-z]|[0-9]|" ")*'
ASSIGN =
DEFINE define
ADD_ASSIGN \+=
ASSIGN_SUB -=
ASSIGN_MULT \*=
ASSIGN_DIV \/=
ASSIGN_MOD %=
ADD \+
SUB \-
MULT \*
DIV \/
MOD \%
AND \&&
OR \|@
NOT \!
XOR \^
GT > 
LT <
EQ ==
NOT_EQ !=
GT_EQ >=
LT_EQ <=
IF if
ELSE else
WHILE while
FOR for
IN_RANGE in_range
IN in
OUT out
MOVE move
TURN turn
GRAB_OBJECT grab_object
RELEASE_OBJECT release_object
SEND_TO_MASTER send_to_master
READ_SENSOR_DATA read_sensor_data
RECEIVE_FROM_MASTER receive_from_master
%%
{ASSIGN} return ASSIGN_VAR;
{DEFINE} return ASSIGN_DEF;
{ADD_ASSIGN} return ASSIGN_ADD;
{ASSIGN_SUB} return ASSIGN_SUB;
{ASSIGN_MULT} return ASSIGN_MULT;
{ASSIGN_DIV} return ASSIGN_DIV;
{ASSIGN_MOD} return ASSIGN_MOD;
{ADD} return ADD;
{SUB} return SUB;
{MULT} return MULT;
{DIV} return DIV;
{MOD} return MOD;
{AND} return AND;
{OR} return OR;
{NOT} return NOT;
{XOR} return XOR;
{GT} return GT;
{LT} return LT;
{EQ} return EQ;
{NOT_EQ} return NOT_EQ;
{GT_EQ} return GT_EQ;
{LT_EQ} return LT_EQ;
{IF} return IF;
{ELSE} return ELSE;
{WHILE} return WHILE_LOOP;
{FOR} return FOR_LOOP;
{IN_RANGE} return IN_RANGE;
{IN} return INPUT;
{OUT} return OUTPUT;
{RETURN} return RETURN;
{LEFT_PTH} return LP;
{RIGHT_PTH} return RP;
{LEFT_CURLY} return LC;
{RIGHT_CURLY} return RC;
{TRUTH_VAL} return TRUTH_VAL;
{DIRECTION} return DIRECTION;
{FLOAT} return FLOAT;
{INTEGER} return INTEGER;
{COMMENT}  return COMMENT;
{MOVE} return MOVE;
{TURN} return TURN;
{GRAB_OBJECT} return GRAP;
{RELEASE_OBJECT} return RELEASE;
{SEND_TO_MASTER} return SEND_MASTER;
{READ_SENSOR_DATA} return READ_SENSOR_DATA;
{RECEIVE_FROM_MASTER} return RECEIVE_MASTER;
{VAR_IDENTIFIER} return VAR;
{CONST_IDENTIFIER} return CONSTANT;
{FUN_IDENTIFIER} return FUNCTION;
{STRING} return STRING;
{COMMA} return COMMA;
[\t]
\n {
	extern int lineno;
	lineno++;
	return NL;
}
. { strcpy(yylval.string, yytext);
    return ERROR;
    }
%%
int yywrap(void){return 0;}
