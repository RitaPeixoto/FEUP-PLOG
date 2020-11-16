ligado(a,b). 
ligado(a,c). 
ligado(b,d). 
ligado(b,e). 
ligado(b,f). 
ligado(c,g). 
ligado(d,h). 
ligado(d,i). 
ligado(f,i).
ligado(f,j).
ligado(f,k).
ligado(g,l).
ligado(g,m).
ligado(k,n).
ligado(l,o).
ligado(i,f).


%a) pesquisa em profundadidade(evitando ciclos)
dfs(InitialNode, FinalNode,Ret):-
    depth([],InitialNode,FinalNode, InvertedRet),
    invert(InvertedRet, Ret).

depth(Path, FinalNode, FinalNode, [FinalNode|Path]).

depth(Path, Node, FinalNode,Ret):-
    ligado(Node, Node1), %tem aresta
    \+ member_(Node1, Path), % evita ciclos
    depth([Node|Path], Node1, FinalNode, Ret).

%b)pesquisa em largura

bfs(InitialNode, FinalNode, Ret):-
    breadth([InitialNode], FinalNode, Ret1),
    invert(Ret1, Ret).


breadth([FinalNode|T], FinalNode, [FinalNode|T]).

breadth([T|Queue], FinalNode, Ret):-
    find_All(ExtensionToChild, extendToChild(T, ExtensionToChild),Extensions),
    concatenate(Queue,Extensions ,ExtendedQueue),
    breadth(ExtendedQueue, FinalNode, Ret).


extendToChild([N|Trajectory], [N1, N|Trajectory]):-
    ligado(N, N1),
    \+ member_(N1,Trajectory).







%utilities
member_(X,[X|_]):-
    !.

member_(X,[_|Y]):-
    member_(X,Y).

concatenate([], L,L).

concatenate([H|T], L , [H|L1]):-
    concatenate(T, L , L1).

invert([X], [X]).

invert([H|T], L):-
    invert(T, L1),
    concatenate(L1,[H], L).



find_All(X, Y, Z):- 
    bagof(X,Y,Z),
    !.

find_All(_,_,[]).

