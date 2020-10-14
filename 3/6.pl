%a
delete_one(X,L1, L2) :- 
    append(La,[X|Lb], L1), 
    append(La, Lb,L2).


%b
%a lista ja esta vazia
delete_all(_,[],[]).

%o head é o elemento(X) por isso nao adicionar à lista
delete_all(X, [X|T],Y) :- delete_all(X,T,Y).

%o X nao é header entao adicionamos à nova lista   
delete_all(X,[Z|T],[Z|Y]):- 
    X\=Z, 
    delete_all(X,T,Y).

%c
delete_all_list([], L1, L1).

delete_all_list([H|T], L1, L2):- 
    delete_all(H,L1, L3), 
    delete_all_list(T, L3, L2).
/*
Elimina o Header da primeira Lista da segunda e chama a funçao recursivamente com o Tail e a nova lista com o header eliminado
*/

