:-use_module(library(lists)).
:-use_module(library(clpfd)).


/*
O João tem um móvel para classificar seus livros. Ele tem livros com capa dura, capa comum, livros
de história, de literatura, uns em francês, outros em inglês. O móvel de João tem 8 compartimentos
como mostra a figura abaixo: 
Classifique os livros de João, respeitando estes rótulos, sabendo que João tem:
 52 livros de história, dos quais 27 estão em inglês;
 34 livros encadernados com capa dura dos quais 3 são de história e em francês;
 46 livros em inglês, a metade deles encadernados com capa comum;
 20 livros de literatura em francês;
 31 livros de literatura encadernados com capa comum.
Qual é o número de livros?


*/

livros:-
    Movel = [A, B, C, D, E, F, G, H],
    domain(Movel, 0, 100),
    all_distinct(Movel),

    A + B + C + D #= 52,
    A + C #= 27,
    B + D #= 25,
    C + D + G + H #= 34,
    D #= 3,
    A + E + C + G #= 46,
    A + E #= 23,
    C + G #= 23,
    F + H #= 20,
    E + F #=31,


    labeling([], Movel),
    write(Movel),nl,
    S is (A+B+C+D+E+F+G+H),
    write(S).
    