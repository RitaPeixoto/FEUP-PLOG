:-use_module(library(lists)).
:-use_module(library(clpfd)).

/*
Após uma intensa jornada de trabalho, Bernard, Daniel, Francisco, Henrique, Jaqueline e Luís
encontram-se num restaurante. Cada um deles pede um prato diferente. Sabe-se que:
 Daniel, Jaqueline e quem pediu o peixe apreciam vinho branco;
 Francisco olha com inveja para as pessoas que pediram porco e pato com laranja;
 Bernard e Daniel estão sentados na frente dos que comem omeleta e pato com laranja;
 Bernard, Francisco e Henrique pediram, cada um, um prato de carne (i.e. porco, pato ou bife).
Quem pediu o bife? E o esparguete ao alho e óleo?

*/
/*
peixe - 1
porco - 2
pato com laranja - 3
omelete - 4
bife - 5 
esparguete - 6

*/
dinner:-
    Names = [Bernard, Daniel, Francisco, Henrique, Jaqueline, Luis],
    domain(Names, 1, 6),
    all_distinct(Names),
    %Daniel, Jaqueline e quem pediu o peixe apreciam vinho branco
    Daniel #\=1 #/\  Daniel #\= 4 #/\ Daniel #\= 3,
    Jaqueline #\= 1,
    %Bernard, Francisco e Henrique pediram, cada um, um prato de carne (i.e. porco, pato ou bife)
    Francisco #= 5,%Francisco olha com inveja para as pessoas que pediram porco e pato com laranja
    Bernard #= 2 #\/ Bernard #=3,
    Henrique #= 2 #\/ Henrique #=3,
   

    !,
    labeling([], Names),
    write(Names),
    fail.
    

    