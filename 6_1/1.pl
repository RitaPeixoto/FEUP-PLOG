f(X,Y):-
    Y is (X*X).

duplica(X,Y) :-
     Y is (2*X). 

my_map([],_,[]). %base case if we have no more elements to apply the function the we have the result

my_map([H|T],TermFunctor, [Res|ResAux]):-
    Term =..[TermFunctor, H, Res],
    Term,
    my_map(T, TermFunctor,ResAux).


/*
?Term =.. ?List
List is a list whose head is the functor of Term and the remaining arguments are the arguments of the term.
 Either side of the predicate may be a variable, but not both. This predicate is called‘Univ'.

*/