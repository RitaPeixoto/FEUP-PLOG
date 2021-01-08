:-use_module(library(lists)).
:-use_module(library(between())).
:-use_module(library(clpfd)).

%1
prog1(N, M , L1, L2):-
    length(L1, N),
    N1 is N-1,
    length(L2,N1),
    findall(E, between(1, M, E), LE),
    fill(L1, LE, LE,_),
    fill(L2, LE,_,_),
    check(L1, L2).

fill([], LEf,LEf).
fill([X|Xs], LE, LEf):-
    select(X, LE, LE_),
    fill(Xs, LE_, LEf).

check([_],[]).
check([A,B|R], [X|Xs]):-
    A + B =:= X,
    check([B|R],Xs).

/*
O predicado fill/3 recebe 2 listas: L1, que apenas se sabe o tamanho e LE, que é uma lista que compreende todos os valores entre 1 e M. Então, fill
preenche a lista que recebe com N elementos selecionados de LE e retorna em LEf os elementos restantes da lista LEf.

O predicado check/2, garante que a soma de cada dois elementos de L1 é igual ao proximo elemento de L2, que tem menos um elemento que L1 como se pode
ver em prog1.

O predicado prog1 gera duas listas, L1 com tamanho N e L2 com tamanho N-1 (predicado prog1), em que cada elemento se encontra entre 1 e M (predicado check) e que a soma de cada par
de elementos de L1 é igual ao proximo elemento de L2 (predicado check)

*/

%2
/* Os numeros vao de 1 a M, por isso tenta de 1 a M, select é executado M vezes, para N + (N-1) elementos, o que dá M^(2N-1)*/

%3
prog2(N, M, L1, L2):-
    length(L1, N),
    N1 is N-1,
    length(L2, N1),
    domain(L1, 1, M),
    domain(L2, 1, M),
    check(L1, L2),
    labeling([], L1).
/*
Falta: retirar numeros repetidos e eliminar simetrias
*/

prog2(N, M, L1, L2):-
    length(L1, N),
    N1 is N-1,
    length(L2, N1),
    domain(L1, 1, M),
    domain(L2, 1, M),
    S #= N + N1,
    length(L3,S),
    append(L1,L2,L3),
    all_distinct(L3),
    removesymmetries(L1), %remover simetrias
    checkCLP(L1, L2),%utilizar restriçoes
    labeling([], L1).


removesymmetries([X,Y|T]):-
    X #=< Y,
    removesymmetries([Y,T]).


checkCLP([_],[]).
checkCLP([A,B|R], [X|Xs]):-
    A + B #= X,
    checkCLP([B|R],Xs).

%4
/*Uma escola de ginastica acrobatica pretende ter um programa que obtenha, de forma automatica, emparelhamentos de alunos para as suas aulas.
Dadas as alturas dos homens e das mulheres presentes na aula em igual número,
pretendem-se emparelhamentos em que a diferença de alturas entre o homem e a
mulher seja inferior a um delta. O homem nunca poderá ser mais baixo do que a mulher.
Construa um programa em PLR que permita obter estes emparelhamentos. Soluções
simétricas devem ser evitadas. O predicado
gym_pairs(+MenHeights,+WomenHeights,+Delta,-Pairs) recebe as alturas dos homens e
das mulheres (listas com o mesmo tamanho) e a diferença máxima de alturas; devolve
em Pairs os emparelhamentos de pessoas, identificadas pelo seu índice, que cumpram
as restrições.*/

gym_pairs(MenHeights, WomenHeights, Delta, Pairs):-
    length(MenHeights, NPairs),
    length(WomenHeights, NPairs),
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






%5
/*
Uma escola de patinagem artistica pretende ter um programa que obtenha, de forma automatica, emparelhamentos de alunos para as suas aulas.
Dadas as alturas dos homens e das mulheres presentes na aula, pretendem-se emparelhamentos em que a diferença de alturas entre o homem e a 
mulher seja inferior a um delta. O homem nunca poderá ser mais baixo do que a mulher.
Por vezes nao é possivel emparelhar todas as pessoas presentes numa aula. Contudo, é util saber que pares é possivel formar, ficando as pessoas 
nao emparelhadas a assistir à aula.
Pode até acontecer que o numero de homens e de mulheres na aula sejam diferentes, o que inviabiliza a constituiçao de pares para todas as pessoas.
O predicado optimal_skating_pairs(+MenHeights,+WomenHeights,+Delta,-Pairs) recebe as alturas dos
homens e das mulheres (listas não necessariamente com o mesmo tamanho) e a
diferença máxima de alturas; devolve em Pairs o maior número possível de
emparelhamentos de pessoas, identificadas pelo seu índice, que cumpram as restrições.

| ?- optimal_skating_pairs([95,78,67,84],[65,83,75,80],10,Pairs).
Pairs = [2-3,3-1,4-2]
| ?- optimal_skating_pairs([95,78,67,84,65,90,77],[65,83,75,80],10,Pairs
).
Pairs = [4-4,5-1,6-2,7-3]
| ?- optimal_skating_pairs([65,83,75,80],[95,78,67,84,65,90,77],10,Pairs
).
Pairs = [1-5,2-2,3-3,4-7]
| ?- optimal_skating_pairs([95,78,67,84,65,90,77],[55,83,75,80],10,Pairs
).
Pairs = [4-4,6-2,7-3]
| ?- optimal_skating_pairs([55,83,75,80],[95,78,67,84,65,90,77],10,Pairs
).
Pairs = [2-2,3-3,4-7]

*/
    
optimal_skating_pairs(MenHeights, WomenHeights, Delta, Pairs) :-
    length(MenHeights, NMens),
    length(WomenHeights, NWomens),

    NMens =< NWomens,

    length(Men, NMens),
    domain(Men, 1, NWomens),
    all_distinct(Men),

    constraintOptimal(1, Men, MenHeights, WomenHeights, Delta, [], Pairs), !,

    labeling([], Men).


optimal_skating_pairs(MenHeights, WomenHeights, Delta, Pairs) :-
    length(MenHeights, NMens),
    length(WomenHeights, NWomens),

    length(Women, NWomens),
    domain(Women, 1, NMens),
    all_distinct(Women),

    constraintOptimal1(1, Women, MenHeights, WomenHeights, Delta, [], Pairs), !,

    labeling([], Women).


constraintOptimal(_, [], _, _, _, Pairs, Pairs).

constraintOptimal(N, [Men | Rest], MenHeights, WomenHeights, Delta, Acc, Pairs) :-
    element(N, MenHeights, MenHeight),
    element(Men, WomenHeights, WomenHeight),
    (MenHeight #>= WomenHeight #/\ MenHeight #=< WomenHeight + Delta) #<=> B,
    (
        B = 1,
        append(Acc, [N-Men], NewAcc)
        ;
        true
    ),
    N1 is N + 1,
    constraintOptimal(N1, Rest, MenHeights, WomenHeights, Delta, NewAcc, Pairs).



constraintOptimal1(_, [], _, _, _, Pairs, Pairs).

constraintOptimal1(N, [Women | Rest], MenHeights, WomenHeights, Delta, Acc, Pairs) :-
    element(N, WomenHeights, WomenHeight),
    element(Women, MenHeights, MenHeight),
    (MenHeight #>= WomenHeight #/\ MenHeight #=< WomenHeight + Delta) #<=> B,
    (
        B = 1,
        append(Acc, [Women-N], NewAcc)
        ;
        true
    ),
    N1 is N + 1,
    constraintOptimal1(N1, Rest, MenHeights, WomenHeights, Delta, NewAcc, Pairs).


