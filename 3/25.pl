
pascal(1,[1]).
pascal(2,[1,1]).

pascal(N,L):-
    N1 is N - 1,
    pascal(N1, L1),
    sumPair(L1,R),
    append([1|R],[1], L).


sumPair([H,T],[Z]):-
    Z is H + T.

sumPair([X,Y|T], Z):-
    H is X + Y,
    Z = [H|L],
    sumPair([Y|T], L).



displayPascal(N):-
    auxDisplay(N, 0).

auxDisplay(N, N).
auxDisplay(N, C):-
    C1 is C+1,
    Level is C+1,
    pascal(Level, Row),
    write(Row), nl,
    auxDisplay(N, C1).