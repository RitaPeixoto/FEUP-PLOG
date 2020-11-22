%a
salto_cavalo(X/Y,X1/Y1):-
    (movimento(Distx,Disty); movimento(Disty,Distx)),
    X1 is X+Distx,
    Y1 is Y+Disty,
    dentro_do_tabuleiro(X1),
    dentro_do_tabuleiro(Y1).

movimento(2,1).
movimento(-2,1).
movimento(2,-1).
movimento(-2,-1).

dentro_do_tabuleiro(X):- 1 =< X, X =< 8. 

%b

trajecto_cavalo([Traj]).

trajecto_cavalo([P1,P2|Traj]):-
    salto_cavalo(P1,P2),
    trajecto_cavalo([P2|Traj]).

%c
?-trajecto_cavalo([2/1,J1,5/4,J3,J4x/8]). 
    