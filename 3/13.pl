%a
lista_ate(N,L):- 
    N > 0,
    build_list(N,1,L).


build_list(0,_,[]).

build_list(N, X, [X|L]) :-
    N1 is N-1,
    X1 is X+1,
    build_list(N1, X1, L).


%b
lista_entre(N1, N2, L):-
    build_between_list(N1, N2, L).

build_between_list(N2, N2, [N2]).
build_between_list(N1, N2, [N1|L]):-
    N1 =< N2,
    N3 is N1+1,
    build_between_list(N3, N2, L).

%c
soma_list(L,Soma):- 
    sum_list_aux(L, 0, Sum).

sum_list_aux([], Acc, Acc).
sum_list_aux([H|T], Acc, Sum):-
    Acc1 is Acc+H,
    sum_list_aux(T, Acc1, Sum).


%d

par(N):- N mod 2 =:= 0.

%e 
lista_pares(N, L):-
    list_evens(N, [], L).

list_evens(0, Acc, Acc).
list_evens(N, Acc, L):-
    N > 0,
    par(N),
    N1 is N-1,
    list_evens(N1, [N|Acc], L).

list_evens(N, Acc, L):-
    N > 0,
    \+ par(N),
    N1 is N-1,
    list_evens(N1, Acc, L).



%f
lista_impares(N,L):-
    list_odds(N, [], L).

list_odds(0, Acc, Acc).
list_odds(N, Acc, L):-
    N > 0,
    N1 is N-1,
    \+ par(N),
    list_odds(N1, [N|Acc], L).

list_odds(N, Acc, L):-
    N > 0,
    N1 is N-1,
    par(N),
    list_odds(N1, Acc, L).