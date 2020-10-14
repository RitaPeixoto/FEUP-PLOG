%a
lista_ate(N,L):- 
    N>0,
    build_list(N,1,L).


build_list(0,_,[]).

build_list(N, X, [X|L]) :-
    N1 is N-1,
    X1 is X+1,
    build_list(N1, X1, L).
