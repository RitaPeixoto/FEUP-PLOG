%a

duplica(L1, L2):-
    duplica_aux(L1, L2, []).

duplica_aux([], Acc, Acc).
duplica_aux([H|T],L2, Acc):-
    append(Acc, [H|H], Acc1),
    duplica_aux(T, L2, Acc1).

/*or*/
dup([], []).
dup([X|L], [X,X|S]):-
    dup(L, S).

%b
duplicar_N([],_,[]).
duplicar_N(L1, N, L2):-
    duplicar_N_aux(L1,N,L2, []).


duplicar_N_aux([], _, Acc, Acc).
duplicar_N_aux([H|T], N, L2, Acc):-
    build_list(H, N, List),
    append(Acc, List, L3),
    duplicar_N_aux(T, N, L2, L3).
    
build_list(X, N, L):-
    build_list_aux(X, N, N, L, []).

build_list_aux(_, _, 0, Acc, Acc).
build_list_aux(X, N, Cnt, L, Acc):-
    Cnt > 0,
    Cnt1 is Cnt-1,
    build_list_aux(X, N, Cnt1, L, [X|Acc]).


/*or*/

dup_N([X|L], N,S):-
    dup_N(L, N, S_),
    dup_elem_N(X, N, S_),
    append(S_,S_,S).

dup_N([], N, []).

dup_elem_N(X, 0, [X]).

dup_elem_N(X, N, [X|S]):-
    N > 0,
    N1 is N - 1,
    dup_elem_N(X, N1, S).

