:-use_module(library(clpfd)).
:-use_module(library(lists)).


/*Uma sequência mágica de comprimento N é uma sequência de inteiros X0, X1, …, Xn-1 tal que
para todo o i=0,1,..n-1:
 Xi é um inteiro entre 0 e n-1
 O número i ocorre exactamente xi vezes na sequência.
Construa um programa em CLP para calcular sequências mágicas de comprimento n.*/


magical_sequence(N, L):-
    