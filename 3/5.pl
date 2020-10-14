%a
member_(E, [E|X]). %caso base é ser o head da lista
member_(E, [H|X]):- 
    E\==H, 
    member_(E,X).
/* membro(2,[1,2,3]).            
yes*/


%b 
membro(X,L) :- append(_L1, [X | _L2], L).
 /*membro(2,[1,2,3]).            
yes*/

%c
last(L,X) :- append(_,[X],L).

/*
last([1,2,3],X). 
X = 3 */



%d
nth_membro(1, [X | T], X).
nth_membro(N, [X | T], Y):-
    N > 1,
    N1 is N - 1,
    nth_mebro(N1,T, Y).



