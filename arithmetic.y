%{
#include <stdio.h>
#include <math.h>

int yylex();
void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}
%}

%token NUMBER ADD SUBTRACT MULTIPLY DIVIDE POWER LPAREN RPAREN EOL /* เพิ่ม TOKEN จาก flex */

%left ADD SUBTRACT
%left MULTIPLY DIVIDE
%right POWER
%define api.value.type {double}
%% 

input: /* empty */
     | input expr EOL { printf("Result: %.4f\n", $2); } /*ทำการแสดงผลเมื่อเจอ TOKEN EOL*/
     ;

expr: expr ADD term       { $$ = $1 + $3; } /*การบวก*/
    | expr SUBTRACT term  { $$ = $1 - $3; } /*การลบ*/
    | term                { $$ = $1; } /*รับค่าจาก term*/
    ;

term: term MULTIPLY factor { $$ = $1 * $3; } /*การคูณ*/
    | term DIVIDE factor   { $$ = $1 / $3; } /*การหาร*/
    | factor { $$ = $1; } /*รับค่าจาก factor*/
    ;

factor: NUMBER { $$ = $1; }
      | LPAREN expr RPAREN { $$ = $2; } /*วงเล็บ*/
      | factor POWER factor { $$ = pow($1, $3); } /* ยกกำลัง */
      ;

%%

int main() {
    yyparse();
    return 0;
}
