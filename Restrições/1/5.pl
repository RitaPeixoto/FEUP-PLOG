:- use_module(library(clpfd)).

/*Doze guardas são colocados a guardar um forte com quatro salas em cada lado. Se um guarda
estiver numa sala do lado só pode ver esse lado, enquanto se estiver num canto pode ver dois lados.
O objectivo é construir um programa em PLR capaz de colocar 12 guardas no forte de forma a que
cinco guardas vigiem cada lado.
*/

/*
    |  S4_corner |     S5     |     S6     |  S7_corner |
    |     S3     |                         |     S8     |
    |     S2     |                         |     S9     |
    |  S1_corner |    S12     |    S11     | S10_corner |
*/


guards(Vars):-
    Vars = [S1_corner, S2, S3, S4_corner, S5, S6, S7_corner, S8, S9, S10_corner, S11, S12],
    % corner or side
    domain(Vars, 0, 12),
    % left side
    S1_corner + S2 + S3 + S4_corner #= 5,
    % up side
    S4_corner + S5 + S6 + S7_corner #= 5,
    % right side
    S7_corner + S8 + S9 + S10_corner #= 5,
    % down side
    S10_corner + S11 + S12 + S1_corner #= 5,
    % there are only 12 guards
    S1_corner + S2 + S3 + S4_corner + S5 + S6 + S7_corner + S8 + S9 + S10_corner + S11 + S12 #= 12,
    % find solutions
    labeling([],Vars).

