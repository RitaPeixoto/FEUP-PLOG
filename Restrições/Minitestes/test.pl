:- use_module(library(lists)).
:- use_module(library(clpfd)).


/*Uma escola de ginastica acrobatica pretende ter um programa que obtenha, de forma automatica, emparelhamentos de alunos para as suas aulas.
Dadas as alturas dos homens e das mulheres presentes na aula em igual número,
pretendem-se emparelhamentos em que a diferença de alturas entre o homem e a
mulher seja inferior a um delta. O homem nunca poderá ser mais baixo do que a mulher.
Construa um programa em PLR que permita obter estes emparelhamentos. Soluções
simétricas devem ser evitadas. O predicado
gym_pairs(+MenHeights,+WomenHeights,+Delta,-Pairs) recebe as alturas dos homens e
das mulheres (listas com o mesmo tamanho) e a diferença máxima de alturas; devolve
em Pairs os emparelhamentos de pessoas, identificadas pelo seu índice, que cumpram
as restrições.
gym_pairs([95,78,67,84],[65,83,75,86],10,Pairs).
Pairs = [1-4,2-3,3-1,4-2] ? ;
*/

optimal_skating_pairs(MenHeights, WomenHeights, Delta, Pairs):-
    length(MenHeights, NMen),
    length(WomenHeights, NWomen),
    NPairs is min(NMen, NWomen),
    write(NPairs),
    length(MenIndexes, NPairs),
    length(WomenIndexes, NPairs),
    length(Pairs, NPairs),
    domain(MenIndexes, 1, NPairs), 
    domain(WomenIndexes, 1, NPairs),
    all_distinct(MenIndexes), 
    all_distinct(WomenIndexes),

    getPairs(MenHeights, WomenHeights,MenIndexes, WomenIndexes, Delta,[], Pairs),
    removesymmetries(Pairs),
    append(MenIndexes, WomenIndexes, L),
    labeling([],L).


getPairs(_, _,[], [], _, Pairs, Pairs).
getPairs(MenHeights, WomenHeights, [M|Rest1], [W|Rest2], Delta, AuxPairs, Pairs):-
    element(M, MenHeights, M1),
    element(W, WomenHeights, W1),
    M1 #> W1 #/\ M1 - W1 #< Delta ,
    append(AuxPairs, [M-W], NewPairs),
    getPairs(MenHeights, WomenHeights,Rest1, Rest2, Delta, NewPairs, Pairs).

removesymmetries([_]).
removesymmetries([A1-_, B1-_ | Rest]):-
    A1 #< B1,
    removesymmetries([B1-_ | Rest]).

