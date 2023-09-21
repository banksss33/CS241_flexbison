%{
#include "arithmetic.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}
%%
[0-9]+(\.[0-9]+)? {
    yylval = atof(yytext);
    return NUMBER;
}
"+"       { return ADD; }
"-"       { return SUBTRACT; }
"*"       { return MULTIPLY; }
"/"       { return DIVIDE; }
"**"       { return POWER; }
"("       { return LPAREN; }
")"       { return RPAREN; }
"\n"    { return EOL; }
%%

int yywrap() {
    // Indicate that there are no more input sources to process.
    return 1;
}
