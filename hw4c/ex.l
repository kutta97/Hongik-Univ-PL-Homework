%{
#include <stdio.h>
#include "y.tab.h"
extern char name[10];
%}

D	[0-9]
L	[a-zA-Z_]

%%
"int"	{return INT;}
{L}({L}|{D})*	{ strcpy(name,yytext); return IDENTIFIER; }
{D}+	{return NUMBER;}
","	{return ',';}
"{" 	{return '{';}
"}"	{return '}';}
"("	{return '(';}
")"	{return ')';}

[ \t\v\n\f]	{}
.	{return yytext[0];}
%%

int yywrap(void)
{
	return 1;
}
