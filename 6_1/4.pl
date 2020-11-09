/*a) Defina o predicado functor2(Term,F,Arity) que é verdadeiro se Term é um termo cujo functor
principal tem o nome F e a aridade Arity. */


functor2(Term, F, Arity):-
    Term = ..[F|Args], 
    length(Args,Arity).

/*b) Defina o predicado arg(N,Term,Arg) que é verdadeiro se Arg é o N-ésimo argumento do termo
Term. 
nth0(?N, ?List, ?Elem, ?Rest)
Select/insert element at index. True when Elem is the N’th (0-based) element of List and Rest is the remainder (as in by select/3) of List
*/

arg(N, TermFunctor, Arg):-
    Term = ..[TermFunctor, Args],
    nth(N,Args,Arg, Rest).
/*
arg_(N,Term,Arg):- Term=..[F|Args], position(N,Args,Arg).
position(1,[X|_],X).
position(N,[_|Xs],Y):-N>1, N1 is N-1, position(N1,Xs,Y). 
*/