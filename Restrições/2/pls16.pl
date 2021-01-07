:-use_module(library(lists)).
:-use_module(library(clpfd)).



/*
Um determinado produto vende-se líquido ou em pó. Uma sondagem mostrou os seguintes
resultados:
 Um terço das pessoas interrogadas não utilizam o pó;
 Dois sétimos das pessoas interrogadas não utiliza o líquido;
 427 pessoas utilizam o líquido e o pó;
 Um quinto das pessoas interrogadas não utilizam o produto.
Quantas pessoas foram interrogadas nesta sondagem?

*/
/*
Po - 1
Liquido - 2
Po e Liquido - 3
Nenhum -4
*/


product:-
    Tipos = [P, L, Pl, Nu ],
    domain(Tipos,1,10000),
 
    (L + Nu) * 3 #= (P + L + 427 + Nu), %1
    (P + Nu) * 7 #= (P + L + 427 + Nu)*2, %2
    Nu*5 #= (P + L + N + Nu),

    labeling([], Tipos),
    S is (P + L + 427 + Nu),
    write(S),nl.
    
    