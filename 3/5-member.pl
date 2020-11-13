%a
member_(E, [E|X]). %caso base é ser o head da lista
member_(E, [H|X]):- 
    E\==H, 
    member_(E,X).

/* membro(2,[1,2,3]).            
yes*/


%b - membro usando append
membro(X,L) :- 
    append(_L1, [X | _L2], L).
 /*membro(2,[1,2,3]).            
yes*/

%c - último elemento da lista
last(L,X) :- append(_,[X],L).

/*
last([1,2,3],X). 
X = 3 */



%d - n-ésimo elemento da lista
nth_membro(1, [X | T], X).
nth_membro(N, [X | T], Y):-
    N > 1,
    N1 is N - 1,
    nth_membro(N1,T, Y).



