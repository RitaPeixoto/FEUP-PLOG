:-use_module(library(lists)).
:-use_module(library(clpfd)).


/*
Doze automóveis estão parados, em fila indiana, num cruzamento com semáforos. Sabe-se que:
 Os automóveis têm a seguinte distribuição de cores: 4 amarelos, 2 verdes, 3 vermelhos e 3 azuis;
 O primeiro e o último automóvel são da mesma cor;
 O segundo e o penúltimo são da mesma cor;
 O quinto automóvel é azul;
 Todos os conjuntos de três automóveis consecutivos têm três cores distintas;
 Partindo do primeiro automóvel para o último, é possível visualizar a sequência amarelo-verdevermelho-azul uma única vez.
Qual a cor de cada um dos doze carros parados no semáforo?
*/



carros :-
    List = [A, B, C, D, 1, F, G, H, I, J, B, A],
    % Azul - 1, Amarelo - 2, Verde - 3, Vermelho - 4
    global_cardinality(List, [2-4, 3-2, 4-3, 1-3]),
    three_different(List),
    check_sequence(List, 1),
    labeling([], List),
    write(List).


/**
 * Every subsequence of three cars have 3 different colored cars
 */
three_different(List) :-
    length(List, L),
    L < 3.

three_different([A,B,C|T]) :-
    all_distinct([A,B,C]),
    three_different([B,C|T]).


/**
 * Checks if the sequence Yellow-Green-Red-Blue appears once
 */
check_sequence(List, 0):-
    length(List, L),
    L < 4.
    
check_sequence([A,B,C,D|T], Counter):-
    (A #= 2 #/\ B #= 3 #/\ C #= 4 #/\ D #= 1) #<=> Bin,
    Counter #= Counter1 + Bin,
    check_sequence([B,C,D|T],Counter1).

    