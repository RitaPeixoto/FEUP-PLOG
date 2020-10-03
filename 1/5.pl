/*João, Maria, Ana, casa, cão, xadrez, damas, ténis, natação, 
apartamento, gato, tigre,
 homem, mulher, animal, mora_em, gosta_de, 
 jogo, desporto*/

%mora_em(tipoCasa, pessoa)
mora_em(apartamento,'Ana').
mora_em(casa, 'Joao').
mora_em(casa, 'Maria').

%gosta_de(pessoa, coisa)
gosta_de('Ana', gato).
gosta_de('Ana', natacao).
gosta_de('Ana', xadrez).
gosta_de('Ana', damas).
gosta_de('Maria', cao).
gosta_de('Maria', tenis).
gosta_de('Maria', tigre).
gosta_de('Joao', gato).
gosta_de('Joao', damas).
gosta_de('Joao', natacao).

%mulher(pessoa)
mulher('Ana').
mulher('Maria').

%homem(pessoa)
homem('Joao').

%animal(animal)
animal(tigre).
animal(cao).
animal(gato).

%desporto(desporto)
desporto(tenis).
desporto(natacao).

%jogo(jogo)
jogo(xadrez).
jogo(damas).

/*
Questions:
a) mora_em(apartamento,X), gosta_de(X,Y), animal(Y). 
b) mora_em(casa,'Joao'), mora_em(casa,'Maria'), gosta_de('Maria',X), gosta_de('Joao', Y), desporto(X), desporto(Y).
c) gosta_de(X,Y), desporto(Y), gosta_de(X,Z), jogo(Z).
d) mulher(X), gosta_de(X,tenis), gosta_de(X,tigre).
*/