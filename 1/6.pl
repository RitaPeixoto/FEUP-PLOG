/*Tweety é um pássaro. Goldie é um peixe. Molie é uma minhoca. Pássaros gostam de minhocas. Gatos
gostam de peixes. Gatos gostam de pássaros. Amigos gostam uns dos outros. O meu gato é meu amigo. O
meu gato come tudo o que gosta. O meu gato chama-se Silvester.*/

bird(tweety).
fish(goldie).
worm(molie).
cat(silvester).

%friend(Person1, Person2)
friend(me, silvester).

%likes(thing1,thing2)

%Passaros gostam de minhocas.
likes(X,Y):- bird(X), worm(Y).

%Gatos gostam de peixes.
likes(X,Y):- cat(X), fish(Y).

%Gatos gostam de pássaros.
likes(X,Y):- cat(X), bird(Y).

%Amigos gostam uns dos outros
likes(X,Y):- friend(X,Y).

likes(X,Y):- friend(Y,X).

%eats(thing,food)
eats(X,Y) :- likes(X,Y), cat(X).
/*
Question:

%eats(silvester, X).

*/