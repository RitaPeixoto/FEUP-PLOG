slice(L, I1, I2, Slice):-
    I is I2 + 1,
    auxSlice(L, I1, I, 1, Slice, []).

auxSlice(_,_,I2, I2, Acc,Acc).

auxSlice([H|T], I1, I2, I, Slice, Acc):-
    I >= I1, 
    I =< I2,
    N is I+1, 
    append(Acc, [H], Acc1),
    auxSlice(T, I1, I2, N, Slice, Acc1).

auxSlice([_|T], I1, I2, I, Slice, Acc):-
    N is I+1,
    auxSlice(T, I1, I2, N, Slice, Acc).