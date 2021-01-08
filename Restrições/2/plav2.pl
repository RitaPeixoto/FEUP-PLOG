:-use_module(library(lists)).
:-use_module(library(clpfd)).

/*
Os números 1 e 19 devem ser colocados no padrão seguinte:
 A,B,C
 D,E,F,G
 H,I,J,K,L,
 M,N,O,P,
 Q,R,S
De forma que a soma de todas as diagonais seja igual:
A+B+C = D+E+F+G = ... = Q+R+S = 38
A+D+H = B+E+I+M = ... = L+P+S = 38
C+G+L = B+F+K+P = ... = H+M+Q = 38
Construir um programa em CLP para resolver o problema.

*/
magical_hexagon:-
    List = [A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S],
    domain(List, 1, 19),
    all_distinct(List),

    A + B + C #= 38,
    D + E + F + G #= 38,
    H + I + J + K + L #= 38,
    M + N + O + P #= 38,
    Q + R + S #= 38,
    A + D + H #= 38,
    B + E + I + M #= 38,
    C + F + J + N + Q #= 38,
    G + K + O + R #= 38,
    L + P + S #= 38,
    C + G + L #= 38,
    B + F + K + P #=38,
    A + E + J + O + S #= 38,
    D + I + N + R #= 38,
    H + M + Q #= 38,


    labeling([], List),
    write(List). 

    