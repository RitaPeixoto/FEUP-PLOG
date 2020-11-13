%a
runLength(L1,L2):-
    auxRunLength(L1, L2, []).


auxRunLength([],Acc,Acc).

auxRunLength([H|T], L , Acc):-
    countOccurrences(H, [H|T],C),
    discard([H|T],L1, C),
    append(Acc, [[C,H]], Acc1),
    auxRunLength(L1,L ,Acc1).

/*Count occurrences*/
countOccurrences(X, L, C):-
    auxCount(X, L, C, 0).

auxCount(_,[], Acc, Acc).
auxCount(X, [H|_],Acc, Acc):-
    X \= H.

auxCount(X, [X|T], C, Acc):-
    Acc1 is Acc + 1,
    auxCount(X,T, C, Acc1).
/*--------------------------*/
/* Discards the number of counted occurences of an element*/
discard(L1, L2, C):-
    auxDiscard(L1, L2, C, 0).

auxDiscard(L, L, C, C). 
auxDiscard([_|T], L2, C, N):-
    N1 is N+1,
    auxDiscard(T, L2, C, N1).

/*------------------------------------*/


%b - modified version of previous questions where if an element only appears once is copied to the result list
modifiedRunlength(L1, L2):-
    auxModifiedRunlength(L1, L2, []).

auxModifiedRunlength([], Acc, Acc).

auxModifiedRunlength([H|T], L, Acc):-
    countOccurrences(H, [H|T], C),
    discard([H|T], L1, C),
    C > 1,
    append(Acc, [[C,H]], Acc1),
    auxModifiedRunlength(L1, L, Acc1).

auxModifiedRunlength([H|T], L, Acc):-
    countOccurrences(H, [H|T], C),
    discard([H|T], L1, C),
    C == 1,
    append(Acc, [H], Acc1),
    auxModifiedRunlength(L1, L, Acc1).



%c decompress list length

decompress(L1,L2):-
    auxDecompress(L1, L2, []).

auxDecompress([], Acc, Acc).

auxDecompress([[HCnt|H]|T], L, Acc):-
    buildList(X, HCnt, Head),
    extend(Head,Acc, Acc1),
    auxDecompress(T,L,Acc1).


/*Extend L2 with the elements of L1*/
extend(L1, L2, L3):-
    auxExtend(L1, L2, L3, L2).

auxExtend([], _, Acc, Acc).

auxExtend([H|T], L2,L3, Acc):-
    append(Acc, [H], Acc1),
    auxExtend(T, L2, L3,Acc1).

/*Build a list with N X elements*/
buildList(X, N, L):-
    auxBuildList(X, N, 0, L , []).

auxBuildList(_,N, N, Acc, Acc).
auxBuildList(X, N, C, L, Acc):-
    C =< N, 
    append(X, Acc, Acc1),
    C1 is C + 1,
    auxBuildList(X, N, C1, L, Acc1).



%modified decompress
modifiedDecompress(L1, L2):-
    auxModifiedDecompress(L1, L2, []).

auxModifiedDecompress([], Acc, Acc).

auxModifiedDecompress([], Acc, Acc).

auxModifiedDecompress([[C|X]|T], L, Acc):-
    build_list(X, C, Head),
    extend(Head, Acc, Acc1),
    auxModifiedDecompress(T, L, Acc1).

auxModifiedDecompress([X|T], L, Acc):-
    extend([X], Acc, Acc1),
    auxModifiedDecompress(T, L, Acc1).

