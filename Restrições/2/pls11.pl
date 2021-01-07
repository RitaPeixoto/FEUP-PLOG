:-use_module(library(lists)).
:-use_module(library(clpfd)).


/*
Seis amigos, Cláudio, David, Domingos, Francisco, Marcelo e Paulo são apaixonados por desporto.
Eles têm muita dificuldade para passear juntos nos fins de semana, pois todos praticam um desporto
diferente: ping-pong, futebol, andebol, rugby, ténis e voleibol. No fim de semana passado sabemos
que:
 Marcelo foi ver o seu cunhado (que é um dos amigos) jogar ténis.
 Francisco e Paulo foram ver um dos amigos jogar voleibol.
 Domingos não gosta de rugby, pois acha um desporto violento.
 Cláudio, Francisco e o seu amigo que joga andebol foram ver a partida de rugby.
 A única irmã de David foi ver o seu marido (que é um dos amigos) jogar futebol.
Qual o desporto preferido de cada um destes 6 amigos que são todos solteiros, excepto um?

*/

/*
ping-pong - 1
futebol - 2
andebol - 3
rugby - 4
tenis - 5
voleibol - 6

So ha um casado que é o Marcelo pela 1 e 5 e o seu cunhado é o David

*/

sports:-
    Names = [Claudio, David, Domingos, Francisco, Marcelo, Paulo],
    domain(Names, 1, 6),
    all_distinct(Names),
    
    Marcelo #\= 2, % cunhado 
    David #\= 5,
    Franciso #\= 6 #/\ Francisco #\= 4#/\ Francisco #\= 3,
    Paulo #\= 6,
    Domingos #\= 4,
    Claudio #\= 4 #/\ Claudio #\=3,




    labeling([], Names),
    write(Names),nl.
    