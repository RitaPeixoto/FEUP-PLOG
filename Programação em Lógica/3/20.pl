
/*eliminates elements from N to N*/

dropN(L1, N, L2):-
    auxDrop(L1,N,L2,N).

auxDrop([],_,[],_).

auxDrop([_|Xs], N, Ys,1):-
    auxDrop(Xs, N, Ys, N).

auxDrop([X|Xs], N, [X|Ys], K):-
    K > 1,
    K1 is K-1,
    auxDrop(Xs, N, Ys, K1).
