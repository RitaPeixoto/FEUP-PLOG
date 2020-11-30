append([], L ,L).

append([X|L1], L2,[X|L3]) :- append(L1,L2,L3).

/*  
append([1,2,3],[3,4,5], X).          
X = [1,2,3,3,4,5] */