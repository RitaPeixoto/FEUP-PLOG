/*
Um carteiro com pouca correspondência para entregar e muito tempo para gastar, pois cada vez
mais as pessoas utilizam o Email, estabeleceu o objectivo de terminar a sua ronda gastando o
máximo de tempo possível enquanto entregava a correspondência na sua última rua. Esta rua é
rectilínea, contendo 10 casas equidistantes a uma distância de 10 metros umas das outras. O carteiro
anda a uma velocidade mínima de 10 metros por minuto (que é a velocidade que vai utilizar ao
longo de todo o seu percurso). Começando pela casa nº1, entregou a correspondência, depois foi até
à casa nº10, depois à casa nº2, depois à nº9 e por aí em diante até terminar na casa nº6 onde lhe
ofereciam sempre café e bolo. Caminhou no total: 9+8+7+6+5+4+3+2+1 = 45 minutos.
Um dia, contudo, o muito trabalhador carteiro lembrou-se que podia fazer ainda melhor (isto é pior)
do que este percurso e elaborou um percurso ainda mais longo que mesmo assim terminava na casa
nº6. Qual foi este percurso?

*/

:-use_module(library(clpfd)).

carteiro:-
    length(Houses, 10),
    domain(Houses, 1, 10),
    all_distinct(Houses),
    element(10, Houses,6),
    calculateDist(Houses, Dist),
    labeling([maximize(Dist)], Houses),
    write('Visits houses by order '), write(Houses), nl,
	write('Spends a total of '), write(Dist), write(' minutes').

calculateDist([_],0).
calculateDist([A,B|T], Dist):-
    calculateDist([B|T], D),
    Dist #= D + abs(A-B).
    
