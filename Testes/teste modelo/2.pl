:-use_module(library(lists)).

%participant(Id,Age,Performance)
participant(1234, 17, 'Pé coxinho').
participant(3423, 21, 'Programar com os pés').
participant(3788, 20, 'Sing a Bit').
participant(4865, 22, 'Pontes de esparguete').
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').


%performance(Id,Times)
performance(1234,[120,120,120,120]).
performance(3423,[32,120,45,120]).
performance(3788,[110,2,6,43]).
performance(4865,[120,120,110,120]).
performance(8937,[97,101,105,110]).


%juriTimes(+Participants, +JuriMember, -Times, -Total)

juriTimes(Participants, JuriMember, Times, Total):-
    auxJuriTimes(Participants, JuriMember, Times, 0, Total).


%auxJuriTimes(+Participants, +JuriMember, -Times, +Total, -FinalTotal)
auxJuriTimes([], _,[], Total, Total).

auxJuriTimes([H|T], JuriMember, [Head|Tail], Total, FinalTotal):-
    performance(H, Times),
    J is JuriMember - 1,
    nth1Member(J,Times, Time),
    Head = Time,
    NextTotal is Time + Total,
    auxJuriTimes(T, JuriMember, Tail, NextTotal, FinalTotal).



nth1Member(1, [Element | _], Element).
nth1Member(_, [], _) :- fail.
nth1Member(Index, [_ | Rest], Element) :-
    NewIndex is Index - 1,
    nth1Member(NewIndex, Rest, Element).