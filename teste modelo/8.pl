:- use_module(library(lists)).
:-include('1.pl').
eligibleOutcome(Id,Perf,TT) :-
    performance(Id,Times),
    madeItThrough(Id),
    participant(Id,_,Perf),
    sumlist(Times,TT).



%nextPhase(+N, -Participants)
nextPhase(N, Participants):-
    setof(TT-Id-Perf,eligibleOutcome(Id, Perf, TT),L),
    reverse(L, FullParticipants),
	prefix_length(FullParticipants, Participants, N).