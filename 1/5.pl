/*João, Maria, Ana, casa, cão, xadrez, damas, ténis, natação, apartamento, gato, tigre, homem, mulher, animal, mora_em, gosta_de, jogo, desporto*/

%lives(houseType, Person)
lives(apartment,'Ana').
lives(house, 'Joao').
lives(house, 'Maria').

%Likes(Person, thing)
likes('Ana', animals).
likes('Maria', tigers).
likes('Maria', tenis).
likes('Joao', basquetball).
likes('Joao', games).

%isASport(sport)
isASport(tenis).
isASport(basquetball).

%gender(Person, gender)
gender('Ana', female).
gender('Joao', male).
gender('Maria', female).



/*
Questions:
a) lives(apartment,P), likes(P, animals).
b) ???? -por fazer
c) likes(P, S), isASport(S), likes(P,games).
d)gender(P,female),likes(P, tenis), likes(P, tigers).
*/