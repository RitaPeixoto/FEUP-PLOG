:-use_module(library(lists)).
:-use_module(library(clpfd)).

/*
Doze amigos encontram-se num acampamento de férias, são eles: João, Miguel, Nádia, Sílvia,
Afonso, Cristina, Geraldo, Júlio, Maria, Máximo, Manuel e Ivone. Cada um deles tem uma bebida
preferida: limonada, guaraná, whisky, vinho, champanhe, água, laranjada, café, chá, vermouth,
cerveja e vodka. Descubra qual é a bebida preferida de cada um sabendo que:
 No primeiro dia os amigos jogam Bridge. Numa das mesas estão juntos Geraldo, Júlio e os que
gostam de vodka e cerveja; na outra mesa os que bebem vermouth e chá enfrentam a Maria e
Máximo enquanto que na terceira mesa Ivone e Manuel enfrentam os que bebem café e laranjada;
 No segundo dia jogam futebol em grupos de quatro: João e Miguel dominam a equipa dos que bebem
chá e café; Júlio e Geraldo derrotam sem dificuldade a equipa dos que bebem guaraná e whisky,
enquanto que Nádia e Maria não conseguem ganhar da equipa dos que bebem laranjada e limonada;
 Os fanáticos do ténis têm somente dois campos para este desporto e jogam em duplas. Geraldo e o
que gosta de água enfrentam Máximo e o que gosta de whisky, enquanto que no outro campo João e
Sílvia enfrentam os que gostam de chá e vodka;
 No final destes feriados Júlio foi ao cinema com os que gostam de champanhe e água; Miguel foi ao
teatro com os que gostam de guaraná e vodka; o que bebe guaraná encontrou-se com Máximo e
Manuel na rua, enquanto que o que gosta de café foi nadar com Sílvia e Afonso.

*/

/*
limonada -1
guaraná-2
whisky-3
vinho-4
champanhe-5
água-6
laranjada-7
café-8
chá-9 
vermouth-10
cerveja-11
vodka-12

*/

friends:-
    Names = [Joao, Miguel, Nadia, Silvia, Afonso, Cristina, Geraldo, Julio, Maria, Maximo, Manuel, Ivone],
    domain(Names, 1, 12),
    all_distinct(Names),
    
    Geraldo#\=12 #/\ Geraldo#\=11 #/\ Geraldo#\=2  #/\ Geraldo#\=3  #/\ Geraldo#\=6 #/\ Geraldo#\=10 #/\ Geraldo#\=9 #/\ Geraldo#\=8 #/\ Geraldo#\=7 #/\ Geraldo#\=1,

    Julio#\=12  #/\ Julio#\=11  #/\ Julio#\=2  #/\ Julio#\=3  #/\ Julio#\=5  #/\ Julio#\=6 #/\ Julio#\=10 #/\ Julio#\=9 #/\ Julio#\=8 #/\ Julio#\=7 #/\ Julio#\=1,

    Maria#\=10  #/\ Maria#\=9  #/\ Maria#\=7  #/\ Maria#\=1 #/\ Maria#\=12 #/\ Maria#\=11 #/\ Maria#\=8 #/\ Maria#\=2  #/\ Maria#\=3,

    Maximo#\=10  #/\ Maximo#\=9  #/\ Maximo#\=6  #/\ Maximo#\=3 #/\ Maximo#\=2  #/\ Maximo#\=12 #/\ Maximo#\=11 #/\ Maximo#\=8 #/\ Maximo#\=7,

    Ivone#\=8  #/\ Ivone#\=7 #/\ Ivone#\=12 #/\ Ivone#\=11 #/\ Ivone#\=9 #/\ Ivone#\=8,

    Manuel#\=8 #/\ Manuel#\=7 #/\ Manuel#\=2 #/\ Manuel#\=12 #/\ Manuel#\=11 #/\ Manuel#\=9 #/\ Manuel#\=8,

    Joao#\=9 #/\ Joao#\=8 #/\ Joao#\=12 #/\ Joao#\=2  #/\ Joao#\=3 #/\ Joao#\=7  #/\ Joao#\=1#/\ Joao#\=6 ,

    Miguel#\=9 #/\ Miguel#\=8 #/\ Miguel#\=12 #/\ Miguel#\=2 #/\ Miguel#\=3 #/\ Miguel#\=7  #/\ Miguel#\=1 #/\ Miguel#\=5  #/\ Miguel#\=6,

    Nadia#\=7 #/\ Nadia#\=1 #/\ Nadia#\=9 #/\ Nadia#\=8 #/\ Nadia#\=2  #/\ Nadia#\=3,

    Silvia#\=9 #/\ Silvia#\=12 #/\ Silvia#\=8 #/\ Silvia#\=3 #/\ Silvia#\=6 #/\ Silvia#\=5 #/\ Silvia#\=2,

    Afonso#\=8 #/\ Afonso#\=6 #/\ Afonso#\=5 #/\ Afonso#\=2 #/\ Afonso#\=12 ,   
    
    !,
    labeling([], Names),
    write(Names),
    fail.
    

    