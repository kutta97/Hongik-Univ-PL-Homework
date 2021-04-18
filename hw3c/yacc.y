%{
#include <stdio.h>
int yylex();
int intcount=0;
%}

%token NUMBER INT IDENTIFIER
%start start_state
%%
start_state:INT declaration_list ';'
		;
declaration_list:declaration_list ';' declaration
		| declaration
		;
declaration:IDENTIFIER '=' NUMBER {intcount++;}
		| IDENTIFIER {intcount++;}
		;
%%

int main(void)
{
	printf("first int count is %d\n\n", intcount);
	yyparse();
	printf("now int count is %d\n\n", intcount);
	return 0;
}

void yyerror(const char *str)
{
	fprintf(stderr, "error: %s\n", str);
}