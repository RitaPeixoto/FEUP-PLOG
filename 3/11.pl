
/*A flat list is one list that taken a nested list becomes  list with all the elements of the nested list in the same level
*/

flats_list([],[]).

flats_list(X,[X]) :-
    atomic(X).

flats_list([H|T],L) :-
    flats_list(H, L1),
    flats_list(T,L2),
    append(L1,L2, L).


    