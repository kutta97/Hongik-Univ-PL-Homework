%{
#include <stdio.h>
#include "y.tab.h"
%}

D	[0-9]
L	[a-zA-Z]
%%
"int"	{return INT;}
{L}({L}|{D})*	{return IDENTIFIER;}
{D}+	{return NUMBER;}
"="	{return '=';}
";"	{return ';';}
","	{return ',';}
[\t\v\n\f .]	{;}
%%

int yywrap(void){
	return 1;
}