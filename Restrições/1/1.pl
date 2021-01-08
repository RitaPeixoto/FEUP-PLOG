:-use_module(library(clpfd)).

/*
O Problema do quadrado mágico consiste em preencher um quadrado com NxN casa, com os
números entre 1 e NxN (cada número utilizado uma única vez) de forma a que a soma das linhas,
colunas e diagonais (principais) sejam idênticas.
a) Resolva as versões 3x3 e 4x4 do problema
b) Generalize para NxN

*/


magic(Vars):-
 Vars = [A1, A2, A3, A4, A5, A6, A7, A8, A9],
 domain(Vars, 1, 9),
 %Soma is (9+1)*3//2, % Aumenta a Eficiência
 all_distinct(Vars),
 %rows
 A1 + A2 + A3 #= Soma,
 A4 + A5 + A6 #= Soma,
 A7 + A8 + A9 #= Soma,
 %columns
 A1 + A4 + A7 #= Soma,
 A2 + A5 + A8 #= Soma,
 A3 + A6 + A9 #= Soma,
 %diagonals
 A1 + A5 + A9 #= Soma,
 A3 + A5 + A7 #= Soma,
 %avoid simmetries
 A1 #< A2, A1 #< A3, A1 #< A4, A2 #< A4,
 %find solution
 labeling([],Vars).

