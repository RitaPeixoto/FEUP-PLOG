:- use_module(library(clpfd)).

/*
Um rapaz vai à Mercearia comprar um pacote de arroz, um saco de batatas, um pacote de esparguete
e uma lata de Atum. O merceeiro (que por sinal era muito careiro) diz-lhe que são 7.11€. O rapaz
paga e quando já vai a sair, o merceeiro diz-lhe: “Espera! Enganei-me e multipliquei o valor dos
produtos em vez de somar. Mas afinal somando-os dá na mesma 7.11€!”. Sabendo que o preço de
dois dos produtos eram múltiplos de 10 cêntimos e que as batatas eram mais caras do que o atum e
este mais caro do que o arroz e que o produto mais barato era o esparguete, qual era o preço de cada
um dos produtos?
*/

mercearia:-
    Produtos = [Arroz, Batatas, Esparguete, Atum],
    domain(Produtos, 1, 1000),
    Arroz * Batatas * Esparguete * Atum #= 7110000,
    sum(Produtos, #=, 711),
    Batatas #> Atum #/\ Atum #> Arroz #/\ Arroz #>Esparguete,
    labeling([], Produtos),
    write(Produtos),
    fail.
    
produtosMultiplos([],0).
produtosMultiplos([Produto|Rest], N):-
    (Produto mod 10 #= 0) #<=> B,
    N1 #= N - B,
    produtosMultiplos(Rest, N1).