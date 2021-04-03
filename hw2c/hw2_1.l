%{
#include <stdio.h>
int lovecount = 0;
%}

%%
(L|l)ove	{lovecount++;}
.|\n	;
%%

int main() {
	yylex();
	printf("number of count=%d\n", lovecount);
	return 0;
}

int yywrap() {
	return 1;
}
