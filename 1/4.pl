/*peru, frango, salmão, solha, cerveja, vinho verde, vinho maduro, Ana, António, Barbara, Bruno, gosta,casado, combina*/

%likes(Person, Thing)
likes('Ana','vinho verde').
likes('Barbara', 'solha').
likes('Bruno', 'cerveja').

%combines(Drink, Food)
combines('vinho verde','salmao').
combines('vinho verde','solha').
combines('vinho maduro','peru').
combines('cerveja','frango').

%married(Person, Person)
married('Ana', 'Bruno').
married('Antonio', 'Barbara').

/*
Questions:
a) married('Ana','Bruno'), likes('Ana','vinho verde'), likes('Bruno','vinho verde').
b) combines(D,'salmao').
c) combines('vinho verde',C).
*/