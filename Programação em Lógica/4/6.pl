ligacao(1, 2).
ligacao(1, 3).
ligacao(2, 4).
ligacao(3, 4).
ligacao(3,6).
ligacao(4, 6).
ligacao(5,6).


%a Calcula um caminho possivel neste caso com dimensao maxima de 5
connected(X, Y):- ligacao(X,Y); ligacao(Y,X).


path(InitialNode, FinalNode, L):-
    path(InitialNode, FinalNode, [InitialNode], L, 5).

path(InitialNode, FinalNode, List, FinalList, _) :-
    connected(InitialNode, FinalNode),
    append(List, [FinalNode], FinalList).

path(InitialNode, FinalNode,List, FinalList, N):-
    N > 0,
    connected(InitialNode, IntermediateNode),
    IntermediateNode \= FinalNode, 
    \+ member(IntermediateNode, List),
    append(List, IntermediateNode, L2),
    N2 is N-1,
    path(IntermediateNode, FinalNode, L2, FinalList, N2).



%b Calcula todos os ciclos possiveis, com comprimento  inferior a comp, desse nó

ciclos(Node, Comp, List):-
    findall(Cicle, path(Node, Node, [], Cicle, Comp), List).
