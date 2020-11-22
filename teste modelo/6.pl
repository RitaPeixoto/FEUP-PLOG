:-include('2.pl').

%nSuccessfulParticipants(-T)

nSuccessfulParticipants(T):-
    findall(P,(performance(P,Times), findButton(Times)), L),
    length(L,T).
    

%findButton(+Times)
findButton([]).
findButton([120|T]):-
    findButton(T).
