%a
substitui(_,_,[],[]).
substitui(X ,Y, [X|T], [Y|L2]) :- replace(X, Y, T, L2).
substitui(X, Y, [H|T], [H|L2]) :- X\=H, replace(X, Y, T, L2). 


%b
elimina_duplicados([],[]).
elimina_duplicados([H|T], [H|L2]) :- \+ member(H, L2), elimina_duplicados(T, L2).
elimina_duplicados([H|T], L2) :- member(H, L2), elimina_duplicados(T, L2).