%{
//includem bibliotecile si functiile ca sa nu dea warning compilatorul
#include <stdio.h>
#include <string.h>
int dim=0;
int produs=1;
int suma=0;
int k=0;
int yyparse();
int yylex();
int yyerror(char*s);
%}
/*pentru intrarea lista declaram un sir de dimensiunea 30, numerele sunt de tipul int*/
%union{
	int sir[30];
	int nr;
	}
%start stat
/*tipul NR e de tipul nr care e int*/
%token <nr> NR;
/*tipul numere e de tipul sir*/
%type <sir> numere;
%type <sir> program;
%%

stat:
	| stat program '\n'
	| stat program '\t'
	| stat program ' ';
/*intrarea hd care afiseaza capul unei liste*/
program :'hd' '[' numere ']' ';'
	{
		$$[0]=1;
		$$[1]=$3[1];
		printf("%d \n",$$[1]);
		dim=0;
	}
/*intrarea length care calculeaza lungimea unei liste*/
|'length' '[' numere ']' ';'
	{
		$3[0]=dim;
		printf("%d\n",$3[0]);
		dim=0;
	}
|'length' '['  ']' ';'
	{

		printf("0\n");
		dim=0;
	}
/*intrarea null pentru lista vida*/
|'null' '['  ']' ';'
	{
		printf("true\n");
		dim=0;
	}
/*intrarea null pentru lista nevida*/
|'null' '[' numere ']' ';'
	{
		printf("false\n");
		dim=0;
	}
/*intrarea last care afiseaza care e ultimul element din lista*/
|'last' '[' numere ']' ';'
	{
		$$[0]=1;
		$$[1]=$3[dim-1];
		printf("%d \n",$$[1]);
		dim=0;
	}
/*intrarea tl(tail) - coada listei*/
|'tl' '[' numere ']' ';'
	{
		$3[0]=dim;
		$$[0]=dim-1;
		for(k=1;k<$3[0];k++)
		{
			$$[k]=$3[k+1];
		}
		//afisare 
		printf("[");
		for(k=1;k<$$[0];k++)
		{
			printf("%d,",$$[k]);
		}
		printf("%d] \n",$$[$$[0]]);
		dim=0;
	}
/*intrarea rev (lista nevida)- inversarea listei*/
|'rev' '[' numere ']' ';'
	{

		int i=0;
		for(k=dim;k>=0;k--)
		{
			$$[i++]=$3[k];
		}
		//afisare
		printf("["); 
		for(k=0;k<dim;k++)
		{
			if (k!=dim-1)
				printf("%d,",$$[k]);
			else
				printf("%d",$$[k]);
		}
		printf("]\n");
		dim=0;
	}
/*intrarea rev (lista vida)- inversarea listei*/
|'rev' '['  ']' ';'
	{

		printf("[]");
		dim=0;
	}
/*daca in interiorul listei sunt numere, incrementam dimensiunea listei*/
numere:numere ',' NR
	{
		dim++;
		$$[dim]=$3;
	}
	|NR
	{
		dim++;
		$$[dim]=$1;
	}
	;
%%
/*functia yyerror va afisa syntax error daca intrarea nu e in regula*/
int yyerror(char *s)
{
	printf("%s \n",s);
}
int main()
{
	return yyparse();
}
