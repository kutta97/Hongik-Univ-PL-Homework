%{
#include<stdio.h>
#include<string.h>
char name[10];
char func[10];
char call[10][10];
int i=0;
int checkfunc=0;
%}
%token IDENTIFIER NUMBER INT
%start start_state

%%
start_state
	: translation_unit
	{
		int j=0;
		for(j;j<i;j++)
		{
			printf("%s -> %s\n", func, call[j]);
		}
	}
	;
translation_unit
	: external_declaration
	| translation_unit external_declaration
	;
external_declaration
	: function
	;
function
	: INT func_name declarator compound_expression
	;
func_name
	: IDENTIFIER {strcpy(func, name);}
	;
declarator
	: '(' ')'
	| '(' parameter_list ')'
	;
parameter_list
	: parameter
	| parameter_list ','  parameter
	;
parameter
	: INT IDENTIFIER
	;
compound_expression
	: '{' '}'
	| '{' statement_list '}'
	| '{' declaration_list '}'
	| '{' declaration_list statement_list'}'
	;
statement_list
	: statement
	| statement_list statement
	;
statement
	: expression ';'
	{
		if(checkfunc == 1)
		{
			strcpy(call[i], name);
			i++;
		}
		checkfunc=0;
	}
	/*| compound_expression*/
	;
expression
	: assignment_expression
	| expression ',' assignment_expression
	;
assignment_expression
	: postfix_expression
	;
postfix_expression
	: primary_expression 
	| postfix_expression '(' ')' {checkfunc=1;}
	| postfix_expression '(' argument_expression_list ')' {checkfunc=1;}
	;
primary_expression
	: IDENTIFIER {}
	| NUMBER
	;
argument_expression_list
	: assignment_expression
	| argument_expression_list ',' assignment_expression
	;
declaration_list
	: declaration
	| declaration_list  declaration
	;
declaration
	: INT init_declaration_list ';'
	;
init_declaration_list
	: init_declarator
	| init_declaration_list ',' init_declarator
	;
init_declarator
	: declarator
	| declarator '=' initializer
	;
	
declarator
	: IDENTIFIER
	;
initializer
	: IDENTIFIER
	| NUMBER
	;


%%
int main()
{
	yyparse();
	return 0;
}
void yyerror(const char *str)
{
	fprintf(stderr, "error : %s\n", str);
}
