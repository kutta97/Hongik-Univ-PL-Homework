test: y.tab.c lex.yy.c
	cc y.tab.c lex.yy.c -o yacc
	./yacc < test3.c

lex.yy.c: hw3.l
	lex hw3.l

y.tab.c: hw3.y
	yacc -d hw3.y

clean : 
	rm -rf lex.yy.c yacc y.tab.h y.tab.c y.output