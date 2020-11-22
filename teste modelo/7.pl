:-include('2.pl').

%juriFans(-juriFansList)

juriFans(L):-
    findall(P-X, (performance(P, Times), getJuris(Times, X)), L).


getJuris(Times,X):-
    auxGetJuris(Times, X, [], 1).

auxGetJuris([], JuriList, JuriList,_).

auxGetJuris([120|T], JuriList, L,Acc):-
    append(L, [Acc], L1),
    C is Acc + 1,   
    auxGetJuris(T, JuriList, L1, C). 

auxGetJuris([H|T], JuriList, L,Acc):-
    H < 120,
    C is Acc + 1,
    auxGetJuris(T, JuriList, L, C). 



