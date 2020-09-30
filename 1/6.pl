/*Tweety é um pássaro. Goldie é um peixe. Molie é uma minhoca. Pássaros gostam de minhocas. Gatos
gostam de peixes. Gatos gostam de pássaros. Amigos gostam uns dos outros. O meu gato é meu amigo. O
meu gato come tudo o que gosta. O meu gato chama-se Silvester.*/


%Animal(Type, Name)
Animal(bird,'Tweety').
Animal(fish, 'Goldie').
Animal(worm,'Molie').


%likes(thing1,thing2)
likes(bird, worm).
likes(cat, bird).
likes(friend, friend).


%friend(Person1, Person2)
friend(cat, me).


/*
????- por fazer

*/