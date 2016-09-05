package rs.ac.bg.etf.pp1;

//import

import java_cup.runtime.Symbol;


%%
//direktive

%{
	//ukljucivanje informacije o poziciji tokena
	private Symbol new_symbol(int type){
		return new Symbol(type, yyline+1, yycolumn);
	}
	//ukljucivanje informacije o poziciji tokena
	private Symbol new_symbol(int type, Object value){
		return new Symbol(type, yyline+1, yycolumn, value);
	}
%}

%cup
%line
%column
%xstate COMMENT

%eofval{
	return new_symbol(sym.EOF);
%eofval}

%% 

//regularni izrazi

//da leksicki analizator ignorise sve vrste belih i kontolnih znakova

" "		{ }
"\b" 	{ }
"\t"	{ }
"\r\n"	{ }
"\f"	{ }

//za leksemu program akcija je pravljenje tokena -- yytext vraca vrednost same lekseme
"program"	{ return new_symbol(sym.PROG, yytext());}
"break"		{ return new_symbol(sym.BREAK, yytext());}
"class"		{ return new_symbol(sym.CLASS, yytext());}
"else"		{ return new_symbol(sym.ELSE, yytext());}
"const"		{ return new_symbol(sym.CONST, yytext());}
"if"		{ return new_symbol(sym.IF, yytext());}
"new"		{ return new_symbol(sym.NEW, yytext());}
"print"		{ return new_symbol(sym.PRINT, yytext());}
"read"		{ return new_symbol(sym.READ, yytext());}
"return"	{ return new_symbol(sym.RETURN, yytext());}
"void"		{ return new_symbol(sym.VOID, yytext());}
"while"		{ return new_symbol(sym.WHILE, yytext());}
"extends"	{ return new_symbol(sym.EXTENDS, yytext());}
"+"			{ return new_symbol(sym.PLUS, yytext());}
"-"			{ return new_symbol(sym.MINUS, yytext());}
"*"			{ return new_symbol(sym.MUL, yytext());}
"/"			{ return new_symbol(sym.DIV, yytext());}
"%"			{ return new_symbol(sym.PER, yytext());}
"=="		{ return new_symbol(sym.EEQUAL, yytext());}
"!="		{ return new_symbol(sym.DIFF, yytext());}
">"			{ return new_symbol(sym.BIGGER, yytext());}
">="		{ return new_symbol(sym.BEQUAL, yytext());}
"<"			{ return new_symbol(sym.LESS, yytext());}
"<="		{ return new_symbol(sym.LEQUAL, yytext());}
"&&"		{ return new_symbol(sym.AND, yytext());}
"||"		{ return new_symbol(sym.OR, yytext());}
"="			{ return new_symbol(sym.EQUAL, yytext());}
"++"		{ return new_symbol(sym.INC, yytext());}
"--"		{ return new_symbol(sym.DEC, yytext());}
";"			{ return new_symbol(sym.SEMI, yytext());}
","			{ return new_symbol(sym.COMMA, yytext());}
"."			{ return new_symbol(sym.DOTT, yytext());}
"("			{ return new_symbol(sym.LPAREN, yytext());}
")"			{ return new_symbol(sym.RPAREN, yytext());}
"["			{ return new_symbol(sym.LBRA, yytext());}
"]"			{ return new_symbol(sym.RBRA, yytext());}
"{"			{ return new_symbol(sym.LBRACE, yytext());}
"}"			{ return new_symbol(sym.RBRACE, yytext());}
"true"|"false"		{ return new_symbol(sym.BCONST, yytext());}

"//" 		{yybegin(COMMENT);}
<COMMENT> . {yybegin(COMMENT);}
<COMMENT> "\r\n"	{ yybegin(YYINITIAL); }


[0-9]+ {return new_symbol(sym.NUMBER, new Integer(yytext())); }
([a-z]|[A-Z])[a-z|A-Z|0-9|_]* {return new_symbol(sym.IDENT, yytext());} 
//"'"[\040-\176]"'" { return new_symbol(sym.CCONST, new Character(yytext().charAt(1))); }
[\"][^\"]*[\"] {return new_symbol(sym.SCONST, new String(yytext())); }
"'"[^']"'" { return new_symbol(sym.CCONST, new String(yytext())); }


. { System.err.println("Leksicka greska ("+yytext()+") u liniji "+(yyline+1)); }