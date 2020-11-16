:- use_module(library(lists)).  
:-include('1.pl').


getAllPaths(InitialNode, FinalNode, AllPaths):-
    findall(Path,dfs(InitialNode, FinalNode, Path), AllPaths).

    