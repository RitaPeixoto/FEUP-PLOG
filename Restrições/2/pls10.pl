:-use_module(library(lists)).
:-use_module(library(clpfd)).

/*
Perto das eleições municipais, os líderes políticos da cidade de Xuxu organizaram, cada um, uma
reunião eleitoral. As estimativas sobre as participações da população forneceram os seguintes
resultados:
 130 pessoas participaram na reunião organizada por Armivisti, 135 na de Baratin e 65 na de
Compromis;
 No total, 200 pessoas mobilizaram-se, sendo que 30 participaram das três reuniões.
Quantas pessoas participaram numa única reunião?
*/

/*
130 - armivisti
135 - baratin
65 - compromis

-30 pessoas
total de 200 pessoas

100 -armivisti
105 - baratin
35 - compromis
total de 170 pessoas


P1 - foram so ao partido 1
P2 - "" 2
P3 - "" 3
P4 - foram a P1 e P2
P5 - foram a P1 e P3
P6 - foram a P2 e P3
*/

elections:-
    Lideres = [P1, P2, P3, P4, P5, P6],
    domain(Lideres, 1, 105),
    P1 + P4 + P5 #= 100,
    P2 + P5 + P6 #= 105,
    P3 + P4 + P6 #= 35,

    100 - P1 - P5 #= 35 - P6 - P3,
    100 - P1 - P4 #= 105 - P2 - P6,
    105 - P2 - P5 #= 35 - P4 - P3,

    P1 + P2 + P3 + P4 + P5 + P6 #= 170,
    !,
    labeling([], Lideres),
    S is (P1 + P2 + P3),
    write(S),nl.    


