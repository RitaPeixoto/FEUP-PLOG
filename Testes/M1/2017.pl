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
    timePlayingGame(Player,T, Tail).

timePlayingGame(Player, [H|T], [Head|Tail]):- 
    Head = 0,
    timePlayingGame(Player,T, Tail).

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
/*
listGamesOfCategory(Cat):-
    auxListGameOfCategory(Cat),
    !.


auxListGameOfCategory(Cat):-
    game(Name, Categories, MinAge),
    is_member(Cat, Categories),
    format('~w (~w)\n', [Name, MinAge]),
    fail.*/

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
    findall(Age,(played(Player, Game, _,_), player(_,Player, Age)), Ages),
    length(Ages, N),
    sumList(Ages,0, L),
    AverageAge is L /N.


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

:-use_module(library(lists)).
mostEffectivePlayers(Game, Players):-
    findall(Efficiency, (played(Player, Game, Hours,Percentage), Efficiency is Percentage/Hours), Aux),
    max_member(Ef, Aux),
    findall(Player, (played(Player, Game, Hours,Percentage), Efficiency is Percentage/Hours), Players).



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

Pode ser utilizada uma lista de inteiros, com distancias guardadas sequencialmente, linha a linha, representando  um dos triangulos da matriz (o de baixo), a lista seria
[0,8,0,8,2,0,7,4,3,1,0]. Para aceder a um elemento, atraves de Linha/Coluna, faz-se o seguinte:
- se coluna > linha, dar swap nos dois valores,
- caso contrario, aceder ao elemento, cujo indice (começando em 1)

*/

%12. areClose(+MaxDist, +Matrix, -Res)
excludeMirrors([],L,L).
excludeMirrors([R/Co|Re],L,Pairs):-
    (
        (
            member(R/Co,L)
            ;
            member(Co/R,L)
        ),excludeMirrors(Re,L,Pairs)
    );
    (
        append(L,[R/Co],NL),
        excludeMirrors(Re,NL,Pairs)
    ).

estaoLonge(MinDist,Matrix,Pairs):-
    findall(R/Co,(nth0(Row,Matrix,C),nth0(Col,C,Dist),Dist>=MinDist, R is Row+1,Co is Col+1),Pair),
    excludeMirrors(Pair,[],Pairs),!.
/*
13.
node(Id, Nodes, Objects).
node(1,[2],[Brasil]).
node(2,[3,5],[]).
node(3,[4,],['Irlanda']).
node(4, [], ['Niger', 'India']).
node(5, [6,7], []).
node(6, [], ['Servia', 'Franca']).
node(7,[8],['Reino Unido']).
node(8,[9],['Australia']).
node(9, [10], ['Georgia']).
node(10, [], ['StaHelena', 'Anguila']).
*/

%14. distance(+Ob1, +Ob2, +Dendogram, -Distancia)
    