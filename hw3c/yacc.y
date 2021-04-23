%{
#include <stdio.h>
int yylex();
void yyerror(const char *s);
int function_count=0;
int operator_count=0;
int int_count=0;
int char_count=0;
int pointer_count=0;
int array_count=0;
int selection_count=0;
int loop_count=0;
int return_count=0;
%}
%token INCLUDE HEADER DEFINE
%token IDENTIFIER CONSTANT STRING_LITERAL SIZEOF
%token PTR_OP INC_OP DEC_OP LEFT_OP RIGHT_OP LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN
%token SUB_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN AND_ASSIGN
%token XOR_ASSIGN OR_ASSIGN TYPE_NAME

%token TYPEDEF EXTERN STATIC AUTO REGISTER
%token CHAR SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST VOLATILE VOID
%token STRUCT UNION ENUM ELLIPSIS

%token CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN

%start translation_unit
%%

primary_expression
	: IDENTIFIER
	| CONSTANT
	| STRING_LITERAL
	| '(' expression ')'
	;

postfix_expression
	: primary_expression
	| postfix_expression '[' expression ']'
	| postfix_expression '(' ')'
	| postfix_expression '(' argument_expression_list ')'	{ function_count++; }
	| postfix_expression '.' IDENTIFIER	{ operator_count++; }
	| postfix_expression PTR_OP IDENTIFIER	{ operator_count++; }
	| postfix_expression INC_OP	{ operator_count++; }
	| postfix_expression DEC_OP	{ operator_count++; }
	;

argument_expression_list
	: assignment_expression
	| argument_expression_list ',' assignment_expression
	;

unary_expression
	: postfix_expression
	| INC_OP unary_expression	{ operator_count++; }
	| DEC_OP unary_expression	{ operator_count++; }
	| unary_operator cast_expression
	| SIZEOF unary_expression
	| SIZEOF '(' type_name ')'
	;

unary_operator
	: '&'
	| '*'	{ operator_count++; }
	| '+'	{ operator_count++; }
	| '-'	{ operator_count++; }
	| '~'
	| '!'
	;

cast_expression
	: unary_expression
	| '(' type_name ')' cast_expression	{ operator_count++; }
	;

multiplicative_expression
	: cast_expression
	| multiplicative_expression '*' cast_expression	{ operator_count++; }
	| multiplicative_expression '/' cast_expression	{ operator_count++; }
	| multiplicative_expression '%' cast_expression	{ operator_count++; }
	;

additive_expression
	: multiplicative_expression
	| additive_expression '+' multiplicative_expression	{ operator_count++; }
	| additive_expression '-' multiplicative_expression	{ operator_count++; }
	;

shift_expression
	: additive_expression
	| shift_expression LEFT_OP additive_expression	{ operator_count++; }
	| shift_expression RIGHT_OP additive_expression	{ operator_count++; }
	;

relational_expression
	: shift_expression
	| relational_expression '<' shift_expression	{ operator_count++; }
	| relational_expression '>' shift_expression	{ operator_count++; }
	| relational_expression LE_OP shift_expression	{ operator_count++; }
	| relational_expression GE_OP shift_expression	{ operator_count++; }
	;

equality_expression
	: relational_expression
	| equality_expression EQ_OP relational_expression	{ operator_count++; }
	| equality_expression NE_OP relational_expression	{ operator_count++; }
	;

and_expression
	: equality_expression
	| and_expression '&' equality_expression	{ operator_count++; }
	;

exclusive_or_expression
	: and_expression
	| exclusive_or_expression '^' and_expression	{ operator_count++; }
	;

inclusive_or_expression
	: exclusive_or_expression
	| inclusive_or_expression '|' exclusive_or_expression	{ operator_count++; }
	;

logical_and_expression
	: inclusive_or_expression
	| logical_and_expression AND_OP inclusive_or_expression	{ operator_count++; }
	;

logical_or_expression
	: logical_and_expression
	| logical_or_expression OR_OP logical_and_expression	{ operator_count++; }
	;

conditional_expression
	: logical_or_expression
	| logical_or_expression '?' expression ':' conditional_expression
	;

assignment_expression
	: conditional_expression
	| unary_expression assignment_operator assignment_expression
	;

assignment_operator
	: '='			{ operator_count++; }
	| MUL_ASSIGN	{ operator_count++; }
	| DIV_ASSIGN	{ operator_count++; }
	| MOD_ASSIGN	{ operator_count++; }
	| ADD_ASSIGN	{ operator_count++; }
	| SUB_ASSIGN	{ operator_count++; }
	| LEFT_ASSIGN	{ operator_count++; }
	| RIGHT_ASSIGN	{ operator_count++; }
	| AND_ASSIGN	{ operator_count++; }
	| XOR_ASSIGN	{ operator_count++; }
	| OR_ASSIGN		{ operator_count++; }
	;

expression
	: assignment_expression
	| expression ',' assignment_expression
	;

constant_expression
	: conditional_expression
	;

declaration
	: declaration_specifiers ';'
	| declaration_specifiers init_declarator_list ';'
	;

declaration_specifiers
	: storage_class_specifier
	| storage_class_specifier declaration_specifiers
	| type_specifier
	| type_specifier declaration_specifiers
	| type_qualifier
	| type_qualifier declaration_specifiers
	;

init_declarator_list
	: init_declarator
	| init_declarator_list ',' init_declarator
	;

init_declarator
	: declarator
	| declarator '=' initializer	{ operator_count++; }
	;

storage_class_specifier
	: TYPEDEF
	| EXTERN
	| STATIC
	| AUTO
	| REGISTER
	;

type_specifier
	: VOID
	| CHAR	{ char_count++; }
	| SHORT
	| INT	{ int_count++; }
	| LONG
	| FLOAT
	| DOUBLE
	| SIGNED
	| UNSIGNED
	| struct_or_union_specifier
	| enum_specifier
	| TYPE_NAME
	;

struct_or_union_specifier
	: struct_or_union IDENTIFIER '{' struct_declaration_list '}'
	| struct_or_union '{' struct_declaration_list '}'
	| struct_or_union IDENTIFIER
	;

struct_or_union
	: STRUCT
	| UNION
	;

struct_declaration_list
	: struct_declaration
	| struct_declaration_list struct_declaration
	;

struct_declaration
	: specifier_qualifier_list struct_declarator_list ';'
	;

specifier_qualifier_list
	: type_specifier specifier_qualifier_list
	| type_specifier
	| type_qualifier specifier_qualifier_list
	| type_qualifier
	;

struct_declarator_list
	: struct_declarator
	| struct_declarator_list ',' struct_declarator
	;

struct_declarator
	: declarator
	| ':' constant_expression
	| declarator ':' constant_expression
	;

enum_specifier
	: ENUM '{' enumerator_list '}'
	| ENUM IDENTIFIER '{' enumerator_list '}'
	| ENUM IDENTIFIER
	;

enumerator_list
	: enumerator
	| enumerator_list ',' enumerator
	;

enumerator
	: IDENTIFIER
	| IDENTIFIER '=' constant_expression
	;

type_qualifier
	: CONST
	| VOLATILE
	;

declarator
	: pointer direct_declarator
	| direct_declarator
	;

direct_declarator
	: IDENTIFIER
	| '(' declarator ')'
	| direct_declarator '[' constant_expression ']'	{ array_count++; }
	| direct_declarator '[' ']'						{ array_count++; }
	| direct_declarator '(' parameter_type_list ')'
	| direct_declarator '(' identifier_list ')'
	| direct_declarator '(' ')'
	;

pointer
	: '*'						{ pointer_count++; }
	| '*' type_qualifier_list	{ pointer_count++; }
	| '*' pointer				{ pointer_count++; }
	| '*' type_qualifier_list pointer	{ pointer_count++; }
	;

type_qualifier_list
	: type_qualifier
	| type_qualifier_list type_qualifier
	;


parameter_type_list
	: parameter_list
	| parameter_list ',' ELLIPSIS
	;

parameter_list
	: parameter_declaration
	| parameter_list ',' parameter_declaration
	;

parameter_declaration
	: declaration_specifiers declarator
	| declaration_specifiers abstract_declarator
	| declaration_specifiers
	;

identifier_list
	: IDENTIFIER
	| identifier_list ',' IDENTIFIER
	;

type_name
	: specifier_qualifier_list
	| specifier_qualifier_list abstract_declarator
	;

abstract_declarator
	: pointer
	| direct_abstract_declarator
	| pointer direct_abstract_declarator
	;

direct_abstract_declarator
	: '(' abstract_declarator ')'
	| '[' ']'
	| '[' constant_expression ']'
	| direct_abstract_declarator '[' ']'
	| direct_abstract_declarator '[' constant_expression ']'
	| '(' ')'
	| '(' parameter_type_list ')'
	| direct_abstract_declarator '(' ')'
	| direct_abstract_declarator '(' parameter_type_list ')'
	;

initializer
	: assignment_expression
	| '{' initializer_list '}'
	| '{' initializer_list ',' '}'
	;

initializer_list
	: initializer
	| initializer_list ',' initializer
	;

statement
	: labeled_statement
	| compound_statement
	| expression_statement
	| selection_statement
	| iteration_statement
	| jump_statement
	;

labeled_statement
	: IDENTIFIER ':' statement
	| CASE constant_expression ':' statement
	| DEFAULT ':' statement
	;

compound_statement
	: '{' '}'
	| '{' statement_list '}'
	| '{' declaration_list '}'
	| '{' declaration_list statement_list '}'
	;

declaration_list
	: declaration
	| declaration_list declaration
	;

statement_list
	: statement
	| statement_list statement
	;

expression_statement
	: ';'
	| expression ';'
	;

selection_statement
	: IF '(' expression ')' statement					{ selection_count++; }
	| SWITCH '(' expression ')' statement				{ selection_count++; }
	;

iteration_statement
	: WHILE '(' expression ')' statement		{ loop_count++; }
	| DO statement WHILE '(' expression ')' ';'	{ loop_count++; }
	| FOR '(' expression_statement expression_statement ')' statement				{ loop_count++; }
	| FOR '(' expression_statement expression_statement expression ')' statement	{ loop_count++; }
	;

jump_statement
	: GOTO IDENTIFIER ';'
	| CONTINUE ';'
	| BREAK ';'
	| RETURN ';'			{ return_count++; }
	| RETURN expression ';'	{ return_count++; }
	;

translation_unit
	: external_declaration
	| translation_unit external_declaration
	;

external_declaration
	: function_definition
	| declaration
	| preprocessor
	;

function_definition
	: declaration_specifiers declarator declaration_list compound_statement { function_count++; }
	| declaration_specifiers declarator compound_statement { function_count++; }
	| declarator declaration_list compound_statement { function_count++; }
	| declarator compound_statement	{ function_count++; }
	;

preprocessor
	: '#' INCLUDE '<' HEADER '>'
	| '#' INCLUDE '"' HEADER '"'
	| '#' DEFINE IDENTIFIER CONSTANT
	;
%%

int main(void)
{
	yyparse();
	printf("function = %d\n", function_count);
	printf("operator = %d\n", operator_count);
	printf("int = %d\n", int_count);
	printf("char = %d\n", char_count);
	printf("pointer = %d\n", pointer_count);
	printf("array = %d\n", array_count);
	printf("selection = %d\n", selection_count);
	printf("loop = %d\n", loop_count);
	printf("return = %d\n", return_count);
	return 0;
}

void yyerror(const char *str)
{
	fprintf(stderr, "error: %s\n", str);
}