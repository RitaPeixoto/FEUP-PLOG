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



%1. madeItThrough(+ParticipantID)
madeItThrough( Participant):-
    performance(Participant, Times),
    auxMadeItThrough(Times).


%auxMadeItThrough(+Times)
auxMadeItThrough([]):-
    false.
auxMadeItThrough([120|_]).
    
auxMadeItThrough([_|T]):-
    auxMadeItThrough(T).


%2. juriTimes(+Participants, +JuriMember, -Times, -Total)

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


%3. patientJuri(+JuriMember)

patientJuri(JuriMember):-
    performance(X, PerformanceX),
    performance(Y, PerformanceY),
    X \= Y,
    J is JuriMember-1,
    nth1Member(J, PerformanceX,120 ),
    nth1Member(J, PerformanceY, 120).


%4. bestParticipant(+P1, +P2, -P)
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

%5
allPerfs:-  
    participant(X,_,Performance),
    performance(X, Times),
    write(X), write(':'), write(Performance), write(':'), write(Times),nl,
    fail.

%6. nSuccessfulParticipants(-T)

nSuccessfulParticipants(T):-
    findall(P,(performance(P,Times), findButton(Times)), L),
    length(L,T).
    

%findButton(+Times)
findButton([]).
findButton([120|T]):-
    findButton(T).

%7. juriFans(-juriFansList)

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

%8
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

    /*
    em vez de prefix:  firstNElements(N, Sorted, Participants).
    
    firstNElements(N, List, SubList) :- append(SubList, _, List), length(SubList, N).
    */

%9
/*
Este predicado obtém uma lista com as performances dos participantes da lista [R|Rs] cuja idade é igual ou inferior a Q.

O cut é verde, pois a função predX nunca falha, não fazendo, portanto, efeito.
*/

%10
/*
Garante que na lista L entre cada par de elementos X
	existem X elementos.
 */

%11
impoe(X,L) :-
    length(Mid,X),
    append(L1,[X|_],L), append(_,[X|Mid],L1).

langford(N, L) :-
    Length is 2 * N,
    length(L, Length),
    langford(N, L, Length).

langford(0, _, _).

langford(N, L, Length) :-
    impoe(N, L),
    N1 is N - 1,
    langford(N1, L, Length).