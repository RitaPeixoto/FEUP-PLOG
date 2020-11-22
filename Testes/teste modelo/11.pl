impoe(X,L) :-
    length(Mid,X),
    append(L1,[X|_],L), append(_,[X|Mid],L1).



% langford(+N,-L)
langford(N, L):-
	N1 is 2*N,
	length(L, N1),
	impoe(N, L).

