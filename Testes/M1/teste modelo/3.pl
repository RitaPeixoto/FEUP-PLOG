:-include('2.pl').

%patientJuri(+JuriMember)

patientJuri(JuriMember):-
    performance(X, PerformanceX),
    performance(Y, PerformanceY),
    X \= Y,
    J is JuriMember-1,
    nth1Member(J, PerformanceX,120 ),
    nth1Member(J, PerformanceY, 120).



nth1Member(1, [Element | _], Element).
nth1Member(_, [], _) :- fail.
nth1Member(Index, [_ | Rest], Element) :-
    NewIndex is Index - 1,
    nth1Member(NewIndex, Rest, Element).