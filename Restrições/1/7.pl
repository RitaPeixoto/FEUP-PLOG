:- use_module(library(clpfd)).

/*
Uma factura antiga revela que setenta e dois perus foram comprados por “-67-“ Escudos. O primeiro
e o último algarismo estão ilegíveis. Construa um programa PLR capaz de determinar quanto é que,
na época, custava cada peru
*/

precoPeru(Vars, Preco) :-
    Vars = [A,B],
    A in 1..9,
    B in 0..9,
    Preco * 72 #= A * 1000 + 670 + B,
    labeling([], Vars),
    Preco is S//72.
