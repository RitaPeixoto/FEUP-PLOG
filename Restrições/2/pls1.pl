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
*/

maquinista:-
    S = [Nomes, Cidades],
    Nomes = [Revisor, Foguista, Maquinista, P1, P2, P3],
    Cidades = [Detroit, Meio, Chicago],
    Salario = [Rev, Fog, Maq, SP1, SP2, SP3],
    P1 #= Detroit, %O Sr. Rocha vive em Detroit.
    Revisor #= Meio, %O revisor vive a meio caminho entre Detroit e Chicago.
    P2 #= Chicago,
    P2 #=  Revisor,


    domain([Revisor, Foguista, Maquinista], 1, 3),
    domain([P1,P2,P3],4,6),
    domain(Cidades, 1, 3),
    all_distinct(Nomes),
    labelling([], S),
    write(S),
    fail.

????????????????????????
    


