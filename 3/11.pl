flats_list([],[]).

flats_list(X,[X]) :-
    atomic(X).

flats_list([H|T],L) :-
    flats_list(H, L1),
    flats_list(T,L2),
    append(L1,L2, L).


    