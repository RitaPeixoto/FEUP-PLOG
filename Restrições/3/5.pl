:-use_module(library(lists)).
:-use_module(library(clpfd)).

/*
Um jovem casal, João e Maria, pretendem dividir as tarefas domésticas de modo que cada um tenha
apenas 2 tarefas, minimizando o tempo total gasto nelas. A eficiência deles varia com as tarefas,
sendo o tempo gasto por semana por cada nas 4 tarefas previstas apresentado na tabela abaixo.
    Compras Cozinha Lavagem Limpeza
Maria 4.5 7.8 3.6 2.9
João 4.9 7.2 4.3 3.1
*/

tasks:-
    Maria = [45, 78, 36, 29],
    Joao = [49,  72, 43, 31],
    Tarefas = [M1, M2, J1, J2],
    domain(Tarefas, 1, 4),
    all_distinct(Tarefas),

    element(M1, Maria, X1),
    element(M2, Maria, X2),
    element(J1, Joao, X3),
    element(J2, Joao, X4),
     
    Sum #= X1 + X2 + X3 + X4,
    labeling([minimize(Sum)], Tarefas),
    write(Tarefas).
    
    
    
    