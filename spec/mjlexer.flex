package rs.ac.bg.etf.pp1;

import java_cup.runtime.Symbol;

%%

%{

	// ukljucivanje informacije o poziciji tokena
	private Symbol new_symbol(int type) {
		return new Symbol(type, yyline+1, yycolumn);
	}
	
	// ukljucivanje informacije o poziciji tokena
	private Symbol new_symbol(int type, Object value) {
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

" " 	{ }
"\b" 	{ }
"\t" 	{ }
"\r\n" 	{ }
"\f" 	{ }

"program" {return new_symbol(sym.PROGRAM, yytext());}
"break" {return new_symbol(sym.BREAK, yytext());}
"class" {return new_symbol(sym.CLASS, yytext());}
"else" {return new_symbol(sym.ELSE, yytext());}
"const"   	{ return new_symbol(sym.CONST, yytext()); }
"if" {return new_symbol(sym.IF, yytext());}
"new" {return new_symbol(sym.NEW, yytext());}
"print" {return new_symbol(sym.PRINT, yytext());}
"read" {return new_symbol(sym.READ, yytext());}
"return" {return new_symbol(sym.RETURN, yytext());}
"void" {return new_symbol(sym.VOID, yytext());}
"for" {return new_symbol(sym.FOR, yytext());}
"extends" {return new_symbol(sym.EXTENDS, yytext());}
"continue" {return new_symbol(sym.CONTINUE, yytext());}
"static" {return new_symbol(sym.STATIC, yytext());}

"+" {return new_symbol(sym.PLUS, yytext());}
"-" {return new_symbol(sym.MINUS, yytext());}
"*" {return new_symbol(sym.MUL, yytext());}
"/" {return new_symbol(sym.DIV, yytext());}
"%" {return new_symbol(sym.MOD, yytext());}
"==" {return new_symbol(sym.EEQUAL, yytext());}
"!=" {return new_symbol(sym.NOTEQUAL, yytext());}
">" {return new_symbol(sym.GRT, yytext());}
">=" {return new_symbol(sym.EGRT, yytext());}
"<" {return new_symbol(sym.LESS, yytext());}
"<=" {return new_symbol(sym.ELESS, yytext());}
"&&" {return new_symbol(sym.AND, yytext());}
"||" {return new_symbol(sym.OR, yytext());}
"=" {return new_symbol(sym.EQUAL, yytext());}
"+=" {return new_symbol(sym.PLUSEQ, yytext());}
"-=" {return new_symbol(sym.MINUSEQ, yytext());}
"*=" {return new_symbol(sym.MULEQ, yytext());}
"/=" {return new_symbol(sym.DIVEQ, yytext());}
"%=" {return new_symbol(sym.MODEQ, yytext());}
"++" {return new_symbol(sym.INC, yytext());}
"--" {return new_symbol(sym.DEC, yytext());}
";" {return new_symbol(sym.SEMI, yytext());}
"," {return new_symbol(sym.COMMA, yytext());}
"." {return new_symbol(sym.DOT, yytext());}
"(" {return new_symbol(sym.LPAREN, yytext());}
")" {return new_symbol(sym.RPAREN, yytext());}
"[" {return new_symbol(sym.LSQUARE, yytext());}
"]" {return new_symbol(sym.RSQUARE, yytext());}
"{" {return new_symbol(sym.LBRACE, yytext());}
"}" {return new_symbol(sym.RBRACE, yytext());}

"//" 		     { yybegin(COMMENT); }
<COMMENT> .      { yybegin(COMMENT); }
<COMMENT> "\r\n" { yybegin(YYINITIAL); }

"true"|"false"  	{ return new_symbol(sym.BOOLCONST,new Boolean(yytext())); }
[0-9]+  { return new_symbol(sym.NUMCONST, new Integer (yytext())); }
([a-z]|[A-Z])[a-z|A-Z|0-9|_]* 	{return new_symbol (sym.IDENT, yytext()); }
"'"[\040-\176]"'" {return new_symbol(sym.CHARCONST, new Character(yytext().charAt(1)));}
. { System.err.println("Leksicka greska ("+yytext()+") u liniji "+(yyline+1) + ", na mestu " + yycolumn + "."); }






