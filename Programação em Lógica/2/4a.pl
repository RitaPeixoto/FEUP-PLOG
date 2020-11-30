fatorial(0,1).
fatorial(N, Valor):-
    N > 0,
    N1 is N-1, fatorial(N1, V1),
    Valor is N*V1.


%Mais eficiente para números maiores
fact(N, V):- fact(N, 1, V).
fact(0, F, F).
fact(N, Acc, V):-
    N > 0,
    N1 is N-1,
    Acc1 is Acc*N,
    fact(N1, Acc1, V).