%a - deletes one element of the list
delete_one(X,L1, L2) :- 
    append(La,[X|Lb], L1), 
    append(La, Lb,L2).


%b
/* If the Head of the list is X we do not add it to the list, otherwise we add it*/
delete_all(_,[],[]).

delete_all(X, [X|T],Y) :- 
    delete_all(X,T,Y).

delete_all(X,[Z|T],[Z|Y]):- 
    X\=Z, 
    delete_all(X,T,Y).

%c
/*First deletes H from L1 and then call recursively with T and L3*/
delete_all_list([], L1, L1).

delete_all_list([H|T], L1, L2):- 
    delete_all(H,L1, L3), 
    delete_all_list(T, L3, L2).


