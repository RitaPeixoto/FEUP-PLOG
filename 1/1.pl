%male(Person)
male('Aldo Burrows').
male('Lj Burrows').
male('Michael Scofield').
male('Lincoln Burrows').
female('Christina Rose Scofiel').
female('Lisa Rix').
female('Sara Tancredi').
female('Ella Scofield').


%parent(Parent, Child).
parent('Aldo Burrows', 'Lincoln Burrows').
parent('Christina Rose Scofiel', 'Lincoln Burrows').
parent('Aldo Burrows', 'Michael Scofield').
parent('Christina Rose Scofiel', 'Michael Scofield').
parent('Lisa Rix','Lj Burrows').
parent('Lincoln Burrows','Lj Burrows').
parent('Michael Scofield','Ella Scofield').
parent('Sara Tancredi','Ella Scofield').


father(P,C):- parent(P,C), male(P).
mother(P,C):- parent(P,C), female(P).
son(X,Y):- parent(Y,X), male(X).
daughter(X,Y) :- parent(Y,X), female(X).


/*
Question:
a) parent(X, 'Michael Scofield').
b) parent('Aldo Burrows', X).
*/