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

DIGIT	[0-9]
WORD	[0-9A-Za-z_]
WORD_START	[A-Za-z_]
WORD_NOT_P	[0-9A-OQ-Za-oq-z_]
WORD_NOT_P_START	[A-OQ-Za-oq-z_]
%%
#(.*)\n	{preprocessor++;}
0[1-7][0-7]*	{octal_number++;}
-{DIGIT}+	{negative_decimal_number++;}
{DIGIT}+	{positive_decimal_number++;}
&{2}	{operator++;}
\|{2}	{operator++;}
(=|!|>|\<)=	{operator++;}
\+{2}	{operator++;}
\-{2}	{operator++;}
!	{operator++;}
>	{operator++;}
\<	{operator++;}
,	{operator++;}
&	{operator++;}
\*	{operator++;}
(\+|\-|\*|\/|%)	{operator++;}
"//"(.*)\n {comment++;}
"/*"([^\*]|(\*+[^\/]))*"*/" {comment++;}
=	{equal_sign++;}
\{	{lhs_bracket_sign++;}
\}	{rhs_bracket_sign++;}
{WORD_NOT_P_START}*{WORD_NOT_P}*p{WORD_NOT_P}*p{WORD_NOT_P}*	{wordcase1++;}
e{WORD}*m	{wordcase2++;}
{WORD_START}{WORD}*	{word++;}
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
	printf("'}' = %d\n", rhs_bracket_sign);
	printf("wordcase1 = %d\n", wordcase1);
	printf("wordcase2 = %d\n", wordcase2);
	printf("word = %d\n", word);
	printf("mark = %d\n", mark);
	return 0;
}

int yywrap() {
	return 1;
}
