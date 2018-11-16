%{
 #include <stdio.h> 
 #include <stdlib.h> 
int yyerror();
int yylex();
%}

%token ASSIGN_VAR ASSIGN_DEF ASSIGN_ADD ASSIGN_SUB ASSIGN_MULT ASSIGN_DIV ASSIGN_MOD ADD SUB MULT DIV MOD AND OR NOT XOR GT LT EQ NOT_EQ GT_EQ LT_EQ IF ELSE WHILE_LOOP FOR_LOOP IN_RANGE INPUT OUTPUT RETURN LP RP LC RC TRUTH_VAL DIRECTION FLOAT INTEGER COMMENT MOVE TURN GRAP RELEASE SEND_MASTER READ_SENSOR_DATA RECEIVE_MASTER VAR CONSTANT FUNCTION STRING COMMA NL

%right ASSIGN
%union {
  int integer;
  char string[32];
}
%token <string> ERROR
%%

start: stmt_list
{ printf( "Input Program Accepted.\n");};

/* Revised BNF */
stmt_list : stmt NL
    | stmt  stmt_list
;
stmt  : expr_assign
         | function_call
	 | function_def 
	 | const_assign 
         | if_stmt 
         | while_loop_stmt
         | for_loop_stmt 
         | output 
         | primitive_fct
         | comment
;
expr_assign :VAR  assign_operator var_assign
;
assign_operator : ASSIGN_VAR 
| ASSIGN_MOD 
| ASSIGN_MULT
| ASSIGN_ADD
| ASSIGN_SUB  
| ASSIGN_DIV 
;
var_assign : expr
                   | CONSTANT
       | VAR
                   | input
       | TRUTH_VAL
       | number
                   | function_call
;
expr : 	arithmetic_stmt
 	| logical_stmt
;
arithmetic_stmt :  VAR   arithmetic_operator VAR 
    |number    arithmetic_operator number 
    |number   arithmetic_operator VAR 
    |VAR  arithmetic_operator number 

;
arithmetic_operator : ADD 
                                 | SUB 
                                 | MULT 
                                 |  DIV 
                                 | MOD
;
number :  INTEGER 
              | FLOAT
;
logical_stmt : VAR  logical_operator  VAR 
	       |empty logical_operator  VAR 
;
empty:
;
logical_operator: not_operator | and_operator  | or_operator | xor_operator
;
not_operator: NOT 
;
or_operator : OR 
;
and_operator : AND
;
xor_operator : XOR
;
input : INPUT LP STRING RP
;
function_call : FUNCTION LP params RP
;
params : param
  | param COMMA  params
;
param: VAR | number
;
function_def : ASSIGN_DEF  FUNCTION  LP args RP LC stmt_list  RETURN var_assign RC
;
args : arg
     | arg COMMA  args
;
arg : VAR
;
if_stmt:  matched 
| unmatched
;
matched : IF LP boolean RP  matched ELSE matched
              | LC stmt_list RC
;
unmatched  :IF LP boolean RP  if_stmt
                    |IF LP boolean RP  matched ELSE unmatched
;  
boolean : CONSTANT
  | relational_stmt
  | logical_stmt
;
const_assign : ASSIGN_DEF CONSTANT  TRUTH_VAL
;

relational_stmt :  VAR  relational_operator VAR  
		   | INTEGER  relational_operator VAR 
		   |VAR relational_operator INTEGER 
   |INTEGER  relational_operator INTEGER 
;

relational_operator : LT| GT | EQ| NOT_EQ | LT_EQ| GT_EQ 
;

while_loop_stmt : WHILE_LOOP  LP boolean RP LC stmt_list RC 
;

for_loop_stmt : FOR_LOOP VAR IN_RANGE  LP VAR COMMA VAR RP LC stmt_list RC 
| FOR_LOOP VAR IN_RANGE  LP VAR COMMA INTEGER RP LC stmt_list RC 
| FOR_LOOP VAR IN_RANGE  LP INTEGER COMMA INTEGER RP LC stmt_list RC 
| FOR_LOOP VAR IN_RANGE  LP INTEGER COMMA VAR RP LC stmt_list RC 
;

output : OUTPUT LP  VAR STRING VAR RP 
;
primitive_fct : move
	           | turn
           | grab_object
           | release_object
                       | read_sensor_data
                       | send_to_master
                       | receive_from_master
;
move : MOVE LP  steps_num RP 
;
steps_num : VAR
      | INTEGER 
;
turn : TURN LP degrees_num COMMA DIRECTION RP 
;
degrees_num : VAR
           | INTEGER 
;
grab_object : GRAP LP VAR RP 
;

release_object : RELEASE LP VAR RP 
;
read_sensor_data : READ_SENSOR_DATA  LP sensor_ID RP 
;
sensor_ID : VAR
                  |INTEGER  
;
send_to_master : SEND_MASTER  LP  data COMMA  master_ID RP 
;
data : number
         |VAR 
         | DIRECTION
;
master_ID : VAR 
            | INTEGER 
;
receive_from_master : RECEIVE_MASTER  LP data COMMA  master_ID RP
;
comment : COMMENT
;


%%
#include "lex.yy.c"
int lineno;
int main(void){
 return yyparse();
}
int yyerror( char *s ) { if(lineno > 0){fprintf( stderr, "%s in line: %d\n", s, lineno); }
else printf("The code is correct\n");};
