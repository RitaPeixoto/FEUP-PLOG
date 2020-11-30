
inverter([], L, L).

inverter(L, InvL) :- inverter(L,InvList, []).

inverter([X|L1], L2, L):-
    inverter(L1, L2, [X|L]).


/*
inverter(List, InvList) :- rev(List,[], InvList).

rev([H|T], S, R) :- rev(T, [H|S], R).

rev([], R, R).
*/

/*
inverter([2,3,4],X).         
X = [4,3,2] ? 
*/