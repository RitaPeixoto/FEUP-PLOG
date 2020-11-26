:-use_module(library(lists)).

%player(Name, UserName, Age).
player('Danny', 'Best Player Ever', 27).
player('Annie', 'Worst Player Ever', 24).
player('Harry', 'A-Star Player', 26).
player('Manny', 'The Player', 14).
player('Jonny', 'A Player', 16).



%game(Name, Categories, MinAge).
game('5 ATG', [action, adventure, open-world, multiplayer], 18).
game('Carrier Shift: Game Over', [action, fps, multiplayer, shooter], 16
).
game('Duas Botas', [action, free, strategy, moba], 12).

%played(Player, Game, HoursPlayed, PercentUnlocked)
:-dynamic played/4.
played('Best Player Ever', '5 ATG', 3, 83).
played('Worst Player Ever', '5 ATG', 52, 9).
played('The Player', 'Carrier Shift: Game Over', 44, 22).
played('A Player', 'Carrier Shift: Game Over', 48, 24).
played('A-Star Player', 'Duas Botas', 37, 16).
played('Best Player Ever', 'Duas Botas', 33, 22).



%1. achievedALot(+Player)
achievedALot(Player):-
    played(Player,_,_,P),
    P >= 80.

%2. isAgeAppropriate(+Name, +Game)

isAgeAppropriate(Name, Game):-
    game(Game,_,Age),
    player(Name,_,PAge),
    PAge >= Age.



%3. timePlayingGames(+Player,+Games, -ListOfTimes,-SumTimes)
timePlayingGames(Player, Games, ListOfTimes, SumTimes):-
    write('hi'),
    timePlayingGame(Player,Games, ListOfTimes),
    !,
    sumList(ListOfTimes,0, SumTimes).

    
timePlayingGame( _, [], []).
timePlayingGame(Player, [H|T], [Head|Tail]):-
    played(Player, H,Head,_),
    timePlayingGame(Player,T, Tail),
    timePlayingGame(Player, T, Tail).

timePlayingGame(Player, [H|T], [Head|Tail]):- 
    Head = 0,
    timePlayingGame(Player,T, Tail),
    timePlayingGame(Player, T, Tail).

sumList([],S,S).

sumList([H|T], Acc, Sum):-
    S is Acc + H,
    sumList(T, S,Sum ).



%4. listGamesOfCategory(+Cat)
listGamesOfCategory(Cat):-
	game(GameName, Categories, MinAge),
	member(Cat, Categories),
	write(GameName), write(' ('), write(MinAge), write(')\n'),
	fail.

listGamesOfCategory(_).


member(_,[]):-fail.
member(Cat,[Cat|_]).
member(Cat, [H|T]):-
    member(Cat, T).


%5. updatePlayer(+Player, +Game, +Hours, +Percentage)

updatePlayer(Player, Game, Hours, Percentage):-
    retract(played(Player, Game,CHours, CPercentage)),
    NewHours is CHours + Hours, 
    NewPercentage is CPercentage + Percentage,
    assert(played(Player, Game, NewHours, NewPercentage)).

updatePlayer(Player, Game, Hours, Percentage):-
    assert(played(Player,Game, Hours, Percentage)).


%6. fewHours(+Player, -Games)

fewHours(Player, Games):-
    fewHoursAux(Player, Games, [],[]).

fewHoursAux(Player,Games, Acc, Rest):-
    played(Player,Game, Hours,_),
    \+member(Game, Rest),
    append([Game],Rest,NewO),
    Hours < 10,
    append([Game], Acc,Acc1),
    fewHoursAux(Player,Games, Acc1, NewO).
fewHoursAux(_,Games, Games, _).


%7. ageRange(+MinRange, +MaxAge, -Players)
ageRange(MinAge, MaxAge, Players):-
    findall(Name, (player(Name, _, Age), Age>=MinAge,Age=<MaxAge), Players).


%8. averageAge(+Game, -AverageAge)
averageAge(Game, AverageAge):-
    findall(Age, (played(Player, Game, _,_), player(_,Player, Age)), Ages),
    length(Ages, N),
    calculateAverage(Ages, 0,N, AverageAge).



calculateAverage([], Acc, Length, AverageAge):-
    AverageAge is Acc / Length.

calculateAverage([H|T], Acc,Length, AverageAge):-
    A is Acc + H,
    calculateAverage(T, A, Length, AverageAge).


%9. mostEffectivePlayer(+Game, -Players)

mostEffectivePlayers(Game, Players):-
    %maior pecentagem de conclusao com menor n de horas 
    findall(Efficiency - Player, (played(Player, Game,NHours, Percentage), Efficiency is Percentage/NHours),EfficiencyList),
    sort(EfficiencyList, SortedP),
    reverse(SortedP, ReversedP),
    getMostEffective(ReversedP, Players),!.

 getMostEffective([BestEfficiency-BestPlayer|Rest], Players):-
    getMostEffectivePlayer(Rest, BestEfficiency,[BestPlayer], Players).

getMostEffectivePlayer([Player|Rest], BestEfficiency, BestList, Players):-
    Player = BestEfficiency - P,
    append(BestList, [P], NewBest),
    getMostEffectivePlayer(Rest, BestEfficiency, NewBest, Players).

getMostEffectivePlayer(_,_,Players,Players).


/*
10.
whatDoesItDo(X):-
player(Y, X, Z), !,
\+ ( played(X, G, L, M),
game(G, N, W),
W > Z ).

O predicado verifica se um jogador X apenas jogou jogos adequados à sua idade.
O cut presente é um cut verde, uma vez que é utilizado para evitar backtracking desnecessário, já que se falhar significa que encontrou um jogo para o qual o jogador nao teria idade para jogar, e,
por isso, nao e necessario verificar mais jogos pois o predicado falha.

Nomes alternativos:
whatDoesItDo seria onlyPlayedApropriateGames
X seria PlayerUserName,
Y seria PlayerName, 
Z seria PlayerAge,
G seria GameName, 
L seria PlayedHours
M seria Percentage,
N seria Cat,
W seria MinimumAge


*/

/*
11.

A matriz pode ser represntada por uma lista de listas em que cada lista é uma linha da matriz.
A lista seria


*/

%12. areClose(+MaxDist, +Matrix, -Res)

%areClose(MaxDist, Matriz, Res):-
    