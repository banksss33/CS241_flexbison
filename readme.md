- flex arithmetic.l
- bison -d arithmetic.y
- gcc lex.yy.c arithmetic.tab.c -o calculator -lm -lfl
