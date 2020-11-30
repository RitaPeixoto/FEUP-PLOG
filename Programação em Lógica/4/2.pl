:- use_module(library(lists)).  
:-include('./1.pl').


getFastestPath(InitialNode, FinalNode, Ret):- 
	setof(Size : Path, (dfs(InitialNode, FinalNode, Path), length(Path, Size)), L), 
	nth0(0, L, Ret).  