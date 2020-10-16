produto_escalar(L1,L2, N):-
    length(L1,N1),
    length(L2, N2),
    N1 == N2,
    produto_escalar_aux(L1,L2,0,N).


produto_escalar_aux([],[], Acc, Acc).

produto_escalar_aux([H1|T1], [H2|T2], Acc, N):-
    Acc1 is Acc + H1*H2,
    produto_escalar_aux(T1, T2, Acc1, N).


