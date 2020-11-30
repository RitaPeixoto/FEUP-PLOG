f(X,Y):-
    Y is (X*X).

duplica(X,Y) :-
     Y is (2*X). 

map([],_,[]). %base case if we have no more elements to apply the function the we have the result

map([H|T],TermFunctor, [Res|ResAux]):-
    Term =..[TermFunctor, H, Res],
    Term,
    map(T, TermFunctor,ResAux).


/*
?Term =.. ?List
List is a list whose head is the functor of Term and the remaining arguments are the arguments of the term.
 Either side of the predicate may be a variable, but not both. This predicate is called‘Univ'.

Exemplo1:
Tendo
f(X,Y):-Y is X*X.
vem
?-map([2,4,8],f,L).
L=[4,16,64]
Exemplo2:
Tendo
duplica(X,Y) :- Y is 2*X.
vem
?-map([1,2,3],duplica,L).
L=[2,4,6] 

Ex: X =..[father, haran, lot] => X = father(haran, lot)



*/