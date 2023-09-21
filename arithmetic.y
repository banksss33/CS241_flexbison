%{
#include <stdio.h>
#include <math.h>

int yylex();
void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}
%}

%token NUMBER ADD SUBTRACT MULTIPLY DIVIDE POWER LPAREN RPAREN EOL

%left ADD SUBTRACT
%left MULTIPLY DIVIDE
%right POWER
%define api.value.type {double}
%%

input: /* empty */
     | input expr EOL { printf("Result: %.4f\n", $2); }
     ;

expr: expr ADD term       { $$ = $1 + $3; }
    | expr SUBTRACT term  { $$ = $1 - $3; }
    | term                { $$ = $1; }
    ;

term: term MULTIPLY factor { $$ = $1 * $3; }
    | term DIVIDE factor   { $$ = $1 / $3; }
    | factor { $$ = $1; }
    ;

factor: NUMBER { $$ = $1; }
      | LPAREN expr RPAREN { $$ = $2; }
      | factor POWER factor { $$ = pow($1, $3); }
      ;

%%

int main() {
    yyparse();
    return 0;
}
