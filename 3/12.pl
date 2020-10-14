
 permuted([],_).
 permuted([H|T], L) :-
    [H|T] \= L,
    member(H,L),
    permuted(T, L).