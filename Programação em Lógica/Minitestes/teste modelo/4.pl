:-include('2.pl').

%bestParticipant(+P1, +P2, -P)
bestParticipant(P1, P2, P):-
    performance(P1,Performance1),
    totalPerformance(Performance1,0,X1),
    performance(P2, Performance2),
    totalPerformance(Performance2, 0,X2),
    X1 > X2,
    P = P1.

bestParticipant(P1, P2, P):-
    performance(P1,Performance1),
    totalPerformance(Performance1,0,X1),
    performance(P2, Performance2),
    totalPerformance(Performance2, 0,X2),
    X2 > X1,
    P = P2.


totalPerformance([], X, X).

totalPerformance([H|T],X1, X2):-
    X2 is X1 + H,
    totalPerformance(T, X2, X).
