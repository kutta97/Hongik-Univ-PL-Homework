%{
/* 정의절(definition section) */
#include <stdio.h>
int digitcount = 0;
%}
%%
	/* 규칙절(rule section) */
999	{printf("%s is appeared\n", yytext);}
([0-9])+	{digitcount++;}
\n	;
%%

/* 사용자 서브루틴절 */
int main() {
	yylex();
	printf("digitcount : %d\n", digitcount);
	return 0;
}

int yywrap() {
	return 1;
}
