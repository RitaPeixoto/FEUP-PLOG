:-include('2.pl').

%patientJuri(+JuriMember)

patientJuri(JuriMember):-
    performance(X, PerformanceX),
    performance(Y, PerformanceY),
    X \= Y,
    J is JuriMember-1,
    nth0(J, PerformanceX,120 ),
    nth0(J, PerformanceY, 120).
