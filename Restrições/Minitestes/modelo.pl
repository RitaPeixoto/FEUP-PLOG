%1
:- use_module(library(lists)).
:- use_module(library(clpfd)).

%1
p1(L1,L2) :-
    gen(L1,L2),
    test(L2).

gen([],[]).
gen(L1,[X|L2]) :-
    select(X,L1,L3),
    gen(L3,L2).

test([]).
test([_]).
test([_,_]).
test([X1,X2,X3|Xs]) :-
    (X1 < X2, X2 < X3; X1 > X2, X2 > X3),
    test(Xs).

/*
O predicado gen sucede se as duas listas tiverem os mesmos elementos sem importar a ordem.
O predicado test sucede se a lista estiver ordenada em grupos de 3, pela ordem crescente ou decrescente
Portanto, p1 sucede se as duas listas contiverem os mesmos elementos e a segunda lista estiver ordenada (de forma crescente ou decrescente), Se L1 estiver instanciada
e L2 nao, entao em l2 ficara a lista L1 ordenada.
Eficiência: generate e test é ineficiente, fazendo imensos backtracking, seria melhor utilizando restrições
*/

%2
p2(L1,L2) :-
    length(L1,N),
    length(L2,N),
    %
    pos(L1,L2,Is),
    all_distinct(Is),
    %
    labeling([],Is),
    test(L2).

pos([],_,[]).
pos([X|Xs],L2,[I|Is]) :-
    element(I,L2,X),
    pos(Xs,L2,Is).

/*
Opção: As variáveis de domínio estão a ser instanciadas antes da fase de pesquisa e nem todas as restrições foram colocadas antes da fase da pesquisa.
O predicado pos é chamado antes do labeling e utiliza o predicado nth1 para instanciar valores
O predicado test é chamado depois do labeling quando devia aparecer antes porque aplica restriçoes e devia utilizar #< e #>
*/


%3
p2(L1,L2) :-
    length(L1,N),
    length(L2,N),
    %
    pos(L1,L2,Is),
    all_distinct(Is),
    test(L2),
    %
    labeling([],Is).

pos([],_,[]).
pos([X|Xs],L2,[I|Is]) :-
    element(I, L2, X),
    pos(Xs,L2,Is).

test([]).
test([_]).
test([_,_]).
test([X1,X2,X3|Xs]) :-
    (X1 #< X2 #/\ X2 #< X3) #\/ (X1 #> X2 #/\ X2 #> X3),
    test([X2,X3|Xs]).

%4
/*Para os seus cozinhados natalícios, a Paupéria dispunha de um determinado número de ovos, com prazo de validade próximo. Este era o único recurso
 limitado, dispondo ele de quantidades intermináveis de todos os outros ingredientes. Na sua lista de receitas de doces, cada receita inclui, 
 entre outras coisas, o número de ovos que leva e o tempo de preparação. A Paupéria tem um tempo limitado para cozinhar, pretende fazer 4 pratos 
 diferentes de doce e gastar o maior número possível de ovos de que dispõe. 
 O predicado receitas(+NOvos,+TempoMax,+OvosPorReceita,+TempoPorReceita,-OvosUsados,-Receitas) recebe o número de ovos disponíveis (NOvos), o
  máximo de tempo disponível (TempoMax), ovos (OvosPorReceita) e os tempos (TempoPorReceita) gastos por cada receita; devolve em OvosUsados os 
  ovos utilizados e em Receitas os cozinhados a realizar (índices das listas OvosPorReceita/TempoPorReceita).

| ?- receitas(30,100,[6,4,12,20,6],[20,50,10,20,15],OvosUsados,Receitas).
OvosUsados = 28,
Receitas = [1,2,3,5]

| ?- receitas(50,100,[6,4,12,20,6],[20,50,10,20,15],OvosUsados,Receitas).
OvosUsados = 44,
Receitas = [1,3,4,5]
*/

receitas(NOvos, TempoMax, OvosPorReceita, TempoPorReceita, OvosUsados, Receitas):-
    %dominios
    length(OvosPorReceita, L),
    Receitas = [R1,R2,R3,R4],
    domain(Receitas, 1, L),
    OvosUsados in 1..NOvos,
    all_distinct(Receitas),

    %restriçao tempo e n de receitas
    element(R1, TempoPorReceita, X1),
    element(R2, TempoPorReceita, X2),
    element(R3, TempoPorReceita, X3),
    element(R4, TempoPorReceita, X4),
    T #= X1 + X2 + X3 + X4 #/\ T #=< TempoMax,

    %restriçao dos ovos
    element(R1, OvosPorReceita, N1),
    element(R2, OvosPorReceita, N2),
    element(R3, OvosPorReceita, N3),
    element(R4, OvosPorReceita, N4),
    Ovos #= N1 + N2 + N3 + N4,    
    OvosUsados = Ovos,
    !,
    %pesquisa
    labeling([maximize(Ovos)], Receitas).

%5
/*A Miquelina tem um conjunto de presentes para embrulhar. Tem igualmente diversos rolos de papel de embrulho, já abertos, com diferentes padrões 
s de largura fixa. Para ser embrulhado, cada presente precisa de um determinado comprimento de papel. Construa um programa, usando programação em 
lógica com restrições, que determine com que rolo de papel é que cada presente deve ser embrulhado. O predicado 
embrulha(+Rolos,+Presentes,-RolosSelecionados) recebe a lista Rolos com a quantidade de papel disponível em cada rolo e a lista Presentes com a 
quantidade de papel que cada presente gasta; devolve em RolosSelecionados os rolos de papel a utilizar em cada presente.

| ?- embrulha([100,45,70], [12,50,14,8,10,90,24], S).
S = [2,3,3,2,1,1,2] ? ;
S = [3,3,2,3,1,1,2] ? ;
no
*/

embrulha(Rolos, Presentes, RolosSelecionados):-
    length(Presentes, NPresentes),
    length(Rolos, NRolos),
    length(RolosSelecionados, NPresentes),
    domain(RolosSelecionados, 1, NRolos),
    %calcular as cenas

    labeling([], RolosSelecionados).

