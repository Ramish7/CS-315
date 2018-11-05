%option main
%%
= printf("ASSIGN_VAR ");
define printf("ASSIGN_DEF ");
\+= printf("ASSIGN_ADD ");
-= printf("ASSIGN_SUB ");
\*= printf("ASSIGN_MULT ");
\/= printf("ASSIGN_DIV ");
\%= printf("ASSIGN_MOD ");
\+ printf("ADD ");
- printf("SUB ");
\* printf("MULT ");
\/ printf("DIV ");
\% printf("MOD ");
&& printf("AND ");
\|@ printf("OR ");
! printf("NOT ");
\^ printf("XOR ");
> printf("GT ");
\< printf("LT ");
== printf("EQ ");
>= printf("GT-EQ ");
\<= printf("LT-EQ ");
if printf("IF ");
else printf("ELSE ");
elif printf("ELSE_IF ");
loop printf("WHILE_LOOP ");
in printf("INPUT ");
out printf("OUTPUT ");
return printf("RETURN ");
\( printf("LP ");
\) printf(" RP ");
(True|False) printf("TRUTH_VAL ");
(left|right) printf("DIRECTION ");
[0-9]+.[0-9]+ printf("FLOAT ");
[0-9]+ printf("INTEGER ");
#([a-z]|[A-Z]|[0-9]|" ")*  printf("COMMENT ");
move printf("MOVE ");
turn printf("TURN ");
grap_object printf("GRAP ");
release_object printf("RELEASE ");
send_to_master printf("SEND_MASTER ");
receive_from_master printf("RECEIVE_MASTER ");
[a-z]([A-Za-z]|[0-9]|"_")* printf("VAR ");
[A-Z]([A-Z]|[0-9]|"_")* printf("CONSTANT ");
[A-Z]([A-Za-z]|[0-9]|"_")* printf("FUNCTION ");
'([A-Za-z]|[0-9]|" ")*' printf("STRING ");