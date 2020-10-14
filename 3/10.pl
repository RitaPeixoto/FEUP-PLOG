%a verdadeiro se Lista é uma lista de inteiros ordenada. 

sortedList([_]).
sortedList([H1, H2|T]):- H1 =< H2, sortedList([H2|T]).
/*
ordenada([N1,N2]):- N1 =< N2.
ordenada([N1,N2|Resto]):-
N1 =< N2,
ordenada([N2|Resto]). 

*/

%b
sorts(L, S):-
    i_sort(L, [], S).

i_sort([], Acc, Acc).

i_sort([H|T], Acc, S):-
    insert(H, Acc, NAcc),
    i_sort(T, NAcc, S).
   
insert(X, [Y|T], [Y|NT]):-
    X > Y,
    insert(X, T, NT).

insert(X, [Y|T], [X,Y|T]):-
    X =< Y.

insert(X,[],[X]).