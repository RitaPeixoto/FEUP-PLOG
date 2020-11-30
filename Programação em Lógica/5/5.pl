
unificavel([], T, []).

unificavel([H1|T1], T, L2):-
    H1 \= T,  % not H1=T
    !,
    unificavel(T1, T, L2).

unificavel([H1|T1], T, [H1|T2]):-
    unificavel(T1, T, T2).



/*
Ex:
?- unificavel([X,b,t(Y)],t(a),L).
L=[X,t(Y)] 

*/