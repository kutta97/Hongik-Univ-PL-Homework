%{
#include <stdio.h>
int preprocessor = 0;
int octal_number = 0;
int negative_decimal_number = 0;
int positive_decimal_number = 0;
int operator = 0;
int comment = 0;
int equal_sign = 0;
int lhs_bracket_sign = 0;
int rhs_bracket_sign = 0;
int wordcase1 = 0;
int wordcase2 = 0;
int word = 0;
int mark = 0;
%}

OCTAL	[0-7]
WORD	[a-zA-Z]
WHITESPACE	[\t ]
%%
^#[a-z]+	{preprocessor++;}
^0[0-7]+	{octal_number++;}
^-[0-9]+	{negative_decimal_number++;}
[0-9]+	{positive_decimal_number++;}
[A-Za-z]+	{word++;}
\n|.	{mark++;}
%%

int main() {
	yylex();
	printf("preprocessor = %d\n", preprocessor);
	printf("octal number = %d\n", octal_number);
	printf("negative decimal number = %d\n", negative_decimal_number);
	printf("positive decimal number = %d\n", positive_decimal_number);
	printf("operator = %d\n", operator);
	printf("comment = %d\n", comment);
	printf("'=' = %d\n", equal_sign);
	printf("'{' = %d\n", lhs_bracket_sign);
	printf("'}'' = %d\n", rhs_bracket_sign);
	printf("wordcase1 = %d\n", wordcase1);
	printf("wordcase2 = %d\n", wordcase2);
	printf("word = %d\n", word);
	printf("mark = %d\n", mark);
	return 0;
}

int yywrap() {
	return 1;
}