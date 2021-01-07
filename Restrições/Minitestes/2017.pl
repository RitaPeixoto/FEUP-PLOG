:-use_module(library(lists)).
:-use_module(library(clpfd)).

/*
Perguntas 1, 2 e 3 são iguais ao teste modelo
*/


%4
/*
Para os seus cozinhados natalícios, o Bonifácio dispunha de um determinado número de ovos,
com prazo de validade próximo. Este era o único recurso limitado, dispondo ele de quantidades
intermináveis de todos os outros ingredientes. Na sua lista de receitas de doces, cada receita
inclui, entre outras coisas, o tempo de preparação e o número de ovos que leva. O Bonifácio tem
um tempo limitado para cozinhar, pretende fazer 3 pratos diferentes de doce e gastar o maior
número possível de ovos de que dispõe. Usando programação em lógica com restrições, construa
um programa que determine que receitas é que o Bonifácio deve fazer. O predicado
sweet_recipes(+MaxTime,+NEggs,+RecipeTimes,+RecipeEggs,-Cookings,-Eggs) recebe o máximo de
tempo disponível (MaxTime), o número de ovos disponíveis (NEggs), os tempos (RecipeTimes) e
ovos (RecipeEggs) gastos por cada receita; devolve em Cookings os cozinhados a realizar (índices
das listas RecipeTimes/RecipeEggs) e em Eggs os ovos utilizados.

| ?- sweet_recipes(60,30,[20,50,10,20,15],[6,4,12,20,6],Cookings,Eggs).
Cookings = [1,3,5],
Eggs = 24
| ?- sweet_recipes(120,30,[20,50,10,20,15],[6,4,12,20,6],Cookings,Eggs).
Cookings = [1,2,4],
Eggs = 30
*/
sweet_recipes( MaxTime, NEggs, RecipeTimes, RecipeEggs, Cookings, Eggs):-
    length(RecipeTimes, NRecipes),
    Cookings = [R1,R2,R3],
    domain(Cookings, 1, NRecipes),
    Eggs in 1..NEggs,
    all_distinct(Cookings),
    element(R1, RecipeTimes, N1),
    element(R2, RecipeTimes, N2),
    element(R3, RecipeTimes, N3),
    Time #= N1 + N2 + N3 #/\ Time #=< MaxTime,
    
    element(R1, RecipeEggs, E1),
    element(R2, RecipeEggs, E2),
    element(R3, RecipeEggs, E3),
    Eggs #= E1 + E2 + E3,
    !,
    labeling([maximize(Eggs)], Cookings).


%5
/*
O Eleutério trabalha numa loja que corta prateleiras de madeira à medida. Para efeitos deste
exercício, consideramos apenas cortes numa dimensão (isto é, assumimos que todas as
prateleiras têm sempre a mesma largura). A páginas tantas, o Eleutério dispõe de várias pranchas,
cada qual com um determinado comprimento, e precisa de cortar um conjunto de prateleiras,
cada qual com a sua dimensão. Construa um programa, usando programação em lógica com
restrições, que determine em que prancha é que cada prateleira deve ser cortada. O predicado
cut(+Shelves,+Boards,-SelectedBoards) recebe a lista de prateleiras a cortar Shelves com a
dimensão (unidimensional) de cada uma, e a lista Boards com o comprimento de cada prancha;
devolve em SelectedBoards as pranchas a utilizar para cada prateleira.

| ?- cut([12,50,14,8,10,90,24], [100,45,70], S).
S = [2,3,3,2,1,1,2] ? ;
S = [3,3,2,3,1,1,2] ? ;
no
*/

cut(Shelves, Boards, SelectedBoards):-
    


