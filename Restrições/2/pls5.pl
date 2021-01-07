:-use_module(library(lists)).
:-use_module(library(clpfd)).


/*
Quatro carros, de cores amarelas, verde, azul, e preta, estão em fila. Sabe-se que o carro que está
imediatamente antes do carro azul é menor do que o que está imediatamente depois do carro azul;
que o carro verde é o menor de todos, que o carro verde está depois do carro azul, e que o carro
amarelo está depois do preto. A questão a resolver é a seguinte:
O primeiro carro: a) é amarelo; b) é azul; c) é preto; d) é verde; e) não pode ser determinado com
estes dados?

*/

%Azul,Amarelo, Verde, Preto
cars:-
    Cor = [ A, B, C, D ],    %posição = posição na fila; valor é cor
    Tam = [ E, F, G, H ],   %
    domain(Cor, 1, 4), domain(Tam, 1, 4), all_distinct(Cor), all_distinct(Tam),
    element(Index, Cor, 3), element(Index, Tam, 1),  % verde é menor
    
    element(I, Cor, 1), IndAntesAz #= I+1, IndDepoisAz #= I-1,                 % I é index do azul
    element(IndDepoisAz, Tam, TamDepois), element(IndAntesAz, Tam, TamAntes),
    TamAntes #< TamDepois, %o carro que está imediatamente antes do carro azul é menor do que o que está imediatamente depois do carro azul
    
    Index #< I,       %verde depois do azul
    element(Yellow, Cor, 2), element(Black, Cor, 4), Yellow #< Black,  %e que o carro amarelo está depois do preto
    append(Cor, Tam, Vars),
    labeling([ ], Vars),
    write('Cores: '),write(Cor),nl,
    write('Tamanhos: '),write(Tam),nl.
    