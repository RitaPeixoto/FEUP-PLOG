
:-use_module(library(clpfd)).
/*
As Sras. Adams, Baker, Catt, Dodge, Ennis e a desleixada Sra. Fisk foram todas ao centro comercial
fazer compras, uma manhã. Cada uma foi directamente ao andar em que havia, o artigo que queria
comprar e cada uma delas comprou um único artigo. Compraram um livro, um vestido, uma bolsa,
uma gravata, um chapéu e um candeeiro.
 Todas as mulheres, excepto a Sra. Adams, entraram no elevador no andar térreo.
 Também entraram no elevador dois homens.
 Duas mulheres, a Sra. Catt e a que comprou a gravata, saíram no segundo andar.
 No terceiro andar era a secção de vestidos.
 Os dois homens saíram no quarto andar.
 A mulher que comprou o candeeiro saiu no quinto andar e deixou a desleixada senhora Fisk saltar
sozinha no sexto andar.
 No dia seguinte, a Sra. Baker, que recebeu a bolsa como presente, de surpresa, de uma das mulheres
que saíra no segundo andar, encontrou seu marido agradecendo a gravata que uma das outras
mulheres lhe tinha dado.
Se os livros eram vendidos no andar térreo, e a Sra. Ennis foi a sexta pessoa a sair do elevador, que
foi que cada uma dessas mulheres comprou?
*/

shopping:-
    Items = [FLivro, FVestido, FBolsa, FGravata, FChapeu, FCandeeiro],
    Mulheres = [Adams, Baker, Catt, Dodge, Ennis, Fisk],
    domain(Mulheres, 1, 6),
    domain(Items, 1, 6),
    all_distinct(Mulheres),
    
    Catt #\= FGravata,
    Baker #\= 4,
    Ennis #= 6,
    Adams #= 1,
    Catt #= 3,
    FLivro #= 1,
    FVestido #= 3,
    FBolsa #= 2,
    FGravata #= 2,
    FCandeeiro #= 6,
    FChapeu #\=4,

    labeling([], Mulheres),
    write(Mulheres).
    
