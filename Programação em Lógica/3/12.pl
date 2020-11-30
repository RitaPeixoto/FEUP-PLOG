/*
Example of a permutation:
L1 = [1,2,3]
L2 = [X,Y,Z]
X = 1, Y = 2, Z = 3
X = 1, Y = 3, Z = 2
X = 2, Y = 3, Z = 1,
X = 2, Y = 1, Z = 3,
X = 3, Y = 1, Z = 2,
X = 3, Y = 2, Z = 1

*/

 permuted([],_).
 permuted([H|T], L) :-
    [H|T] \= L,
    member(H,L),
   permuted(T, L).
