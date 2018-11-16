parser: y.tab.c
	gcc -o parser y.tab.c
y.tab.c: CS315f18_group25.y lex.yy.c
	yacc CS315f18_group25.y
lex.yy.c: CS315f18_group25.l
	lex CS315f18_group25.l
