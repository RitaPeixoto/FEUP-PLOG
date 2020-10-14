inverter(List, InvList) :- rev(List,[], InvList).

rev([H|T], S, R) :- rev(T, [H|S], R).

rev([], R, R).


/*
inverter([2,3,4],X).         
X = [4,3,2] ? 
*/