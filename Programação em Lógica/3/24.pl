

bubbleSort(L, S):-
    swap(L, L1).
    
/*If swap failed the list is sorted*/
bubbleSort(L, L).

/*swaps the first 2 elements of L1 if first > second or  recursively swaps tail elements*/
swap([X,Y|T],[Y,X|T]):-
    X > Y.

swap([Z|T1], [Z|T2]):-
    swap(T1,T2).