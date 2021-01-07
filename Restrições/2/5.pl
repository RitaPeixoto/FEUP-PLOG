/*
Quatro carros, de cores amarelas, verde, azul, e preta, estão em fila. Sabe-se que o carro que está
imediatamente antes do carro azul é menor do que o que está imediatamente depois do carro azul;
que o carro verde é o menor de todos, que o carro verde está depois do carro azul, e que o carro
amarelo está depois do preto. A questão a resolver é a seguinte:
O primeiro carro: a) é amarelo; b) é azul; c) é preto; d) é verde; e) não pode ser determinado com
estes dados?
*/

:-use_module(library(clpfd)).

cars:-
    length(Colors, 4), domain(Colors, 1, 4), all_distinct(Colors),
    length(Sizes, 4), domain(Sizes, 1, 4), all_distinct(Sizes),
    


    /*
	Blue - 1
	Yellow - 2
	Green - 3
	Black - 4
*/
solve:-
	length(Colors, 4), domain(Colors, 1, 4), all_distinct(Colors),
	length(Sizes, 4), domain(Sizes, 1, 4), all_distinct(Sizes),

	%R1
	element(IdxBlue, Colors, 1),
	IdxBeforeBlue #= IdxBlue - 1, IdxAfterBlue #= IdxBlue + 1,
	element(IdxBeforeBlue, Sizes, SizeBeforeBlue),
	element(IdxAfterBlue, Sizes, SizeAfterBlue),
	SizeBeforeBlue #< SizeAfterBlue,

	%R2
	element(IdxGreen, Colors, 3), 
	element(IdxGreen, Sizes, 1),

	%R3
	IdxGreen #> IdxBlue,

	%R4
	element(IdxYellow, Colors, 2),
	element(IdxBlack, Colors, 4),
	IdxYellow #> IdxBlack,

	append(Sizes, Colors, Vars),
	labeling([], Vars),
	write('Queue-->'), write(Colors), nl,
	write('Sizes-->'), write(Sizes), nl, nl, fail.

solve.
