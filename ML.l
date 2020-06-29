%{
	//includerea bibliotecilor si declararea functie yyerror
	#include <stdio.h>
	#include "y.tab.h"
	int yyerror(char*s);

%}
/*cifrele de la 0 pana 9 sau orice numar intreg ca string */
NR [0-9]+
%%
{NR}	{
	//pentru numere convertim din string in numar cu functia atoi 
	yylval.nr=atoi(yytext);
	return NR;
	}
[ \n\t] {
	//carectere tab si newline
	return yytext[0];
	}
hd		|
;		|
tl		|
null	|
last	|
rev		|
length  {
	//pentru operatii introduse returnam exact numele lor (valorile lor)
	return *yytext;
		}
[\[\]\(\)\,] {
	return yytext[0];
	}
.	{
	//daca ca intrare este un caracter care este invalid sau nu apartine in reguli de mai sus afisam un mesaj de eroare
	yyerror("caracter necunoscut");
	}
%%
/*Funcția yywrap este apelată de lex atunci când intrarea este epuizată*/
int yywrap()
{
	return (1);
}
