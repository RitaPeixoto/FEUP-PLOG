:- use_module(library(clpfd)).

/*Que conjuntos de três números têm a sua soma igual ao seu produto?*/
sol(Vars):-
    Vars = [A,B,C],
    domain(Vars, 1,9),
    A + B + C #= A * B * C,
    A #=< B, B #=< C, %eliminar simetria
    labeling([], Vars).

    
