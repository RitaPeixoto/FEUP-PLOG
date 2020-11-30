

rotate(L1, N, L2):-
    N >= 0,
    auxRotate(N, 0, L2, L1).

rotate(L1, N, L2):-
    N < 0,
    N1 is 0 - N,
    reverse(L1, L3),
    auxRotate(N1, 0, RevL2, L3),
    reverse(RevL2, L2).



auxRotate(N, N, Acc,Acc).

auxRotate(N, C, L, [H|T]):-
    C =< N, 
    C1 is C + 1,
    append(T, [H], Acc),
    auxRotate(N, C1, L, Acc).

reverse(L1, L2):-
    rev(L1, L2, []).

rev([], Acc, Acc).
rev([H|T], L1, Acc):-
    rev(T, L1, [H|Acc]).