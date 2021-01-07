:-use_module(library(lists)).
:-use_module(library(clpfd)).


/*
Considere uma corrida automobilística na qual seis homens estão na frente, mas, o cronista,
emocionado pelo suspense da corrida, confunde e mistura os nomes dos corredores. É sabido que:
 O grupo consiste de seis homens, todos de nacionalidade diferentes. Há um alemão, um inglês, um
brasileiro, um espanhol, um italiano e um francês.
 Três marcas patrocinam estes seis homens; cada marca patrocina dois deles da seguinte forma:
o O n°1 e o alemão são corredores da marca La Vie Claire
o O n°5 e o brasileiro são corredores da marca Sistema-V
o O espanhol e o n°3 são corredores da marca Fagor
 Sabe-se também que:
o Os corredores n°2 e o n°6 têm vantagem no princípio do circuito Aulne enquanto que o
espanhol ficou sem gasolina
o O italiano e o francês adiantaram-se 30 segundos do corredor n°3 na terceira volta deste
circuito de 5.8 Km que deve ser repetido 11 vezes
o O n°2 e o alemão tiveram que abandonar a prova
o O n°1 ganha a corrida na frente do italiano
Quais os números, marcas e nacionalidades de cada corredor?

*/

race:-
    Men = [G, E, B, S, I, F],
    domain(Men, 1, 6),
    all_distinct(Men),

    G #\= 1 #/\ G #\= 5 #/\ G #\=3 #/\ G #\=2 #/\ G #\=4,
    B #\= 5 #/\ B #\= 1 #/\ B #\=3 #/\ B #\=4,
    S #= 4,
    I #\= 1 #/\ I #\= 3 #/\ I #\=4,
    F #\= 3 #/\ F #\=4,



    labeling([], Men),
    write(Men),nl.
      

