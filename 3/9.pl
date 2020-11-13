%a
/*If X is not the header we call recursively, otherwise the header of the result list becomes Y*/
substitui(_,_,[],[]).

substitui(X ,Y, [X|T], [Y|L2]) :- 
    substitui(X, Y, T, L2).

substitui(X, Y, [H|T], [H|L2]) :-
    X\=H, 
    substitui(X, Y, T, L2). 


%b
/*If H is a member of L2 we no longer add it */
elimina_duplicados([],[]).

elimina_duplicados([H|T], [H|L2]) :- 
    \+ member(H, L2), 
    elimina_duplicados(T, L2).

elimina_duplicados([H|T], L2) :- 
    member(H, L2), 
    elimina_duplicados(T, L2).