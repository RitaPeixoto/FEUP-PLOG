:-use_module(library(lists)).
:-use_module(library(clpfd)).


/*Num certo comboio, os empregados eram três: o revisor, o foguista e o maquinista. Os seus nomes,
por ordem alfabética, eram Ferreira, Rocha e Silva. No comboio havia, também, três passageiros
com os mesmos nomes: Sr. Ferreira, Sr. Rocha e Sr. Silva São conhecidos os seguintes factos:
 O Sr. Rocha vive em Detroit.
 O revisor vive a meio caminho entre Detroit e Chicago.
 O Sr. Ferreira ganha, exactamente, 10.000 Euros por ano.
 Silva, em certa ocasião, derrotou o foguista, a jogar bilhar.
 Um vizinho do revisor, que vive numa casa ao lado da casa deste e é um dos três passageiros
mencionados, ganha exactamente o triplo do que ganha o revisor.
 O passageiro que vive em Chicago tem o mesmo nome do revisor.
Pergunta-se: Qual é o nome do maquinista?

1 - Ferreira
2 - Rocha
3 - Silva

*/

maquinista(S):-
    S = [Revisor, Foguista, Maquinista],
    domain(S, 1, 3),
    all_distinct(S),
    
    Revisor #\= 2, %revisor nao é Rocha
    Foguista #\= 3, %foguista nao é Silva

    labeling([], S).

 
    


