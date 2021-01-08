:-use_module(library(clpfd)).
:-use_module(library(lists)).


/*Uma sequência mágica de comprimento N é uma sequência de inteiros X0, X1, …, Xn-1 tal que
para todo o i=0,1,..n-1:
 Xi é um inteiro entre 0 e n-1
 O número i ocorre exactamente xi vezes na sequência.
Construa um programa em CLP para calcular sequências mágicas de comprimento n.*/


magical_sequence(N):-
    length(L, N),
    U is N -1,
    domain(L, 0, U),

    buildList(L, Count, N),

    global_cardinality(L, Count), 

    labeling([], L),
    write(L),nl.

    
buildList(L, Count, N):-
    length(Count,N),
    createList(Count, L, 0, N).

createList([],[], N, N).

createList([C|RestC], [L|LRest], Acc, Max):-
    C = Acc - L,
    Acc1 is Acc + 1,
    createList(RestC, LRest, Acc1, Max).


