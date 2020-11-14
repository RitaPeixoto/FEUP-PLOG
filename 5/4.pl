
max(X, Y, Z, X):- 
    X > Y,
    X > Z, 
    !.
max(X, Y, Z, Y):- 
    Y > X, 
    Y > Z, 
    !.
max(_, _, Z, Z). 


/*
Programa que calcula o maior de entre três números.

Situações em que o programa nao funciona corretamente:
    - no caso de haver numeros iguais, vai ser Z considerado o maior

*/


%Versão corrigida:

max2(X, Y, Z, X):- 
    X >= Y,
    X >= Z, 
    !.
max2(X, Y, Z, Y):- 
    %Y >= X, 
    Y >= Z, 
    !.
max2(_, _, Z, Z). 