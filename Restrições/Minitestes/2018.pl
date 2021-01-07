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
    all_distinct(L1),%nao podem ser iguais 
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
gym_pairs(+MenHeights,+WomenHeights,+Delta,-Pairs):-
    length(MenHeights, NPairs),
    length(Men, NPairs),
    length(Women, NPairs),
    domain(Men, 1, NPairs),
    domain(Women, 1, NPairs),
    all_distinct(Men),
    all_distinct(Women),
    height_restrictions(Men, Women, MenHeights, WomenHeights, Delta),
    remove_symmetries(Men),
    append(Men, Women, L),
    labeling([], L),
    make_pair(Men, Women, Pairs, []).

height_restrictions([], [], _, _, _).
height_restrictions([M|Men], [W|Women], MenHeights, WomenHeights, Delta):-
    element(M, MenHeights, MH),
    element(W, WomenHeights, WH),
    MH #>= WH,
    Delta #>= MH - WH,
    height_restrictions(Men, Women, MenHeights, WomenHeights, Delta).

remove_symmetries([_]).
remove_symmetries([M1, M2|Men]):-
    M1 #=< M2,
    remove_symmetries([M2|Men]).

make_pair([], [], Pairs, Pairs).
make_pair([M|Men], [W|Women], Pairs, Acc):-
    append(Acc, [M-W], Acc2),
    make_pair(Men, Women, Pairs, Acc2).




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
    
optimal_skating_pairs( MenHeights, WomenHeights, Delta, Pairs):-
    length(MenHeights, NMen),
    length(Women, NWomen),
    minimum(Min, [NMen,NWomen]),
    NPairs 1.. Min,
    length(Men, NPairs),
    length(Women, NPairs),
    domain(Men, 1, NMen),
    domain(Women, 1, NWomen),
    all_distinct(Men),
    all_distinct(Women),

    height_restrictions(Men, Women, MenHeights, WomenHeights,Delta),
    removesymmetries(Men),
    append(Men, Women, Vars),
    labeling([], Vars),
    make_pair(Men, Women, Pairs, []).