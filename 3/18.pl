%a

duplica(L1, L2):-
    duplica_aux(L1, L2, []).

duplica_aux([], Acc, Acc).
duplica_aux([H|T],L2, Acc):-
    append(Acc, [H|H], Acc1),
    duplica_aux(T, L2, Acc1).


%b
duplicar([],_,[]).
duplicar_N(L1, N, L2):-
    duplicar_n_aux(L1,N,L2, []).


duplicate_n_aux([], _, Acc, Acc).
duplicate_n_aux([H|T], N, L2, Acc):-
    build_list(H, N, DupedList),
    append(Acc, DupedList, L3),
    duplicate_n_aux(T, N, L2, L3).
    
build_list(X, N, L):-
    build_list_aux(X, N, N, L, []).

build_list_aux(_, _, 0, Acc, Acc).
build_list_aux(X, N, Cnt, L, Acc):-
    Cnt > 0,
    Cnt1 is Cnt-1,
    build_list_aux(X, N, Cnt1, L, [X|Acc]).
