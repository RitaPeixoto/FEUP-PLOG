:-use_module(library(lists)).
:-use_module(library(clpfd)).


/*
Um “Golomb Ruler” é um conjunto de inteiros a(1) < a(2) < … < a(n) tal que todas as diferenças
a(i)-a(j) (i>j) sejam distintas. Pode-se assumir que a(1)=0. a(n) é o comprimento do Golomb Ruler.
Para um dado número de valores, n, estamos interessados em encontrar o Golomb Ruler mais curto
(óptimo). Construir um programa em CLP para resolver este problema.

*/

golomb(N):-
    length(List, N),
    element(1, List, 0),
    domain(List, 0, N),
    domain([X, Y], 1, N),

    checkLess(List),
    checkDifference(L, 1, 1, N, AuxList),

    all_distinct(AuxList),

    labeling([], List),
    write(List).
    

/*conjunto de inteiros a(1) < a(2) < … < a(n)*/
checkLess([]).
checkLess([_]).
checkLess([A,B]):-
    A #< B.
checkLess([A,B|R]):-
    A #< B,
    checkLess([B|R]).

/*tal que todas as diferenças a(i)-a(j) (i>j) sejam distintas*/
checkDifference(_, N, _, N, _).
checkDifference(L, X, Y, N, L1):-
    Y =< X,
    N1 is Y +1,
    checkDifference(L, X, N1, N, L1).

checkDifference(L,X,N,N,[Element|R]):-
    element(X, L, First),
    element(N, L, Second),
    Element #= Second - First,
    difference(L,X,1,N,R).

checkDifference(L,X,Y,N,[Element|R]):-
    element(X, L, First),
    element(Y, L, Second),
    Element #= Second-First,
    difference(L,X,Y,N,R).
