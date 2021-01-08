:- use_module(library(lists)).
:- use_module(library(clpfd)).

/*
O Franquelim gosta de reciclar. Descobriu que tem na sua posse um determinado número de embalagens de iogurte vazias. Tem também
um livro que mostra como realizar diversos objetos com tais embalagens, onde para cada objeto consta um custo estimado do material
adicional que é preciso comprar (entre cola, tinta, etc.) e o número de embalagens de iogurte que leva. O Franquelim tem um orçamento
limitado para comprar esses materiais, pretende realizar 3 objetos diferentes e utilizar o máximo possível de embalagens de iogurte de que
dispõe. Usando programação em lógica com restrições, construa um programa que determine que objetos é que o Franquelim deve fazer.
O predicado build(+Budget,+NPacks,+ObjectCosts,+ObjectPacks,-Objects,-UsedPacks) recebe o orçamento disponível (Budget), o
número de embalagens de iogurte disponíveis (NPacks), os custos de material (ObjectCosts) e embalagens (ObjectPacks) necessários por
cada objeto; devolve em Objects os objetos a construir (índices das listas ObjectCosts/ObjectPacks) e em UsedPacks o número de
embalagens utilizadas.

| ?- build(60,30,[20,50,10,20,15],[6,4,12,20,6],Objects,UsedPacks).
Objects = [1,3,5],
UsedPacks = 24
| ?- build(120,30,[20,50,10,20,15],[6,4,12,20,6],Objects,UsedPacks).
Objects = [1,2,4],
UsedPacks = 30
*/

build(Budget, NPacks, ObjectCosts, ObjectPacks, Objects, UsedPacks):-
    Objects = [U1, U2, U3],
    length(Objects,NObjetos),
    domain(Objects, 1, NObjetos),
    all_distinct(Objects),
    UsedPacks in 1..NPacks,

    element(U1, ObjectCosts, C1),
    element(U2, ObjectCosts, C2),
    element(U3, ObjectCosts, C3),
    Total #= C1 + C2 + C3 #/\ Total #=< Budget,

    element(U1, ObjectPacks, N1),
    element(U2, ObjectPacks, N2),
    element(U3, ObjectPacks, N3),
    UsedPacks #= N1 + N2 + N3 #/\ UsedPacks #=< NPacks,

    labeling([maximize(UsedPacks)], Objects).


