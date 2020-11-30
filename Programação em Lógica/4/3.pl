:- use_module(library(lists)).  
:-include('1.pl').


searchWithVisit(InitialNode, Path):-
    ligado(X,_),
    ligado(_,Y),
    dfs(X,Y,Path),
    allBelongTo(L, Path).

allBelongTo([H|T], Path):-
    member_(H, Path),
    allBelongTo(T, Path).

allBelongTo([], Path).