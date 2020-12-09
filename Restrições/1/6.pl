:- use_module(library(clpfd)).


sol(Vars):-
    Vars = [A,B,C],
    domain(Vars, 1,9),
    A + B + C #= A * B * C,
    A #=< B, B #=< C, %eliminar simetria
    labeling([], Vars).

    
