

/*------------------------------------------ GETS ------------------------------------------------*/

%getPlayerContent(+Player,+N,-Content)
getPlayerContent(Player,N,Content):-
  nth0(N, Player,Content).

%getOpponnetPlayer(+Id1, -Id2)
getOpponentPlayer(1, 2).
getOpponentPlayer(2, 1).
 
%getOpponnentColor(+Id, -OpponentColor)
getOpponentColor(1, 'green').
getOpponentColor(2, 'red').

%getPlayerColor(+Id, -Color)
getPlayerColor(1,'red').
getPlayerColor(2,'green').

%getPlayerTypes(Mode, TypePlayer1, TypePlayer2)
getPlayerTypes('HH', 'H', 'H').
getPlayerTypes('CC', 'C', 'C').
getPlayerTypes('HC', 'H', 'C').
getPlayerTypes('CH', 'C', 'H').

%getCylinder(+PlayerColor, -PlayerCylinder)
getCylinder('red','rcyl').
getCylinder('green','gcyl').

%getPlayerCylinder(+GameState, +Player, -Row, -Column)
getPlayerCylinder([_|T], 1, Row, Column):-
    getHeadandTail(T, Player1, _),
    getPlayerContent(Player1, 4 , Row),
    getPlayerContent(Player1 ,3, Column).

getPlayerCylinder([_|T], 2, Row, Column):-
    getHeadandTail(T, _, Player2),
    getPlayerContent(Player2, 4 , Row),
    getPlayerContent(Player2 ,3, Column).

%getPlayerDiscs(+GameState, +Player, -Discs)
getPlayerDiscs([_|T], 1, Discs):-
    getHeadandTail(T, Player1, _),
    getPlayerContent(Player1, 5 , Discs).

getPlayerDiscs([_|T], 2, Discs):-
    getHeadandTail(T, _, Player2),
    getPlayerContent(Player2, 5 , Discs).


/*------------------------------------------ UPDATES ------------------------------------------------*/

%decreasePlayerDiscs(+GameState, +Player, -NewGameState)
decreasePlayerDiscs([H|T],1,NewGameState):-
    getHeadandTail(T,Player1,Player2),
    nth0(2, T, Nyellows),
    getPlayerContent(Player1,5,Ndiscs),
    N is Ndiscs - 1,
    updatePlayerDiscs(Player1, N, NewPlayer1),
    NewGameState = [H,NewPlayer1,Player2, Nyellows].

decreasePlayerDiscs([H|T],2,NewGameState):-
    getHeadandTail(T,Player1,Player2),
    nth0(2, T, Nyellows),
    getPlayerContent(Player2,5,Ndiscs),
    N is Ndiscs - 1,
    updatePlayerDiscs(Player2, N, NewPlayer2),
    NewGameState = [H,Player1,NewPlayer2, Nyellows].

%increasePlayerDiscs(+GameState, +Player, -NewGameState)
increasePlayerDiscs([H|T],1,NewGameState):-
    getHeadandTail(T,Player1,Player2),
    nth0(2, T, Nyellows),
    getPlayerContent(Player1,5,Ndiscs),
    N is Ndiscs + 1,
    updatePlayerDiscs(Player1, N, NewPlayer1),
    NewGameState = [H,NewPlayer1,Player2, Nyellows].

increasePlayerDiscs([H|T],2,NewGameState):-
    getHeadandTail(T,Player1,Player2),
    nth0(2, T, Nyellows),
    getPlayerContent(Player2,5,Ndiscs),
    N is Ndiscs + 1,
    updatePlayerDiscs(Player2, N, NewPlayer2),
    NewGameState = [H,Player1,NewPlayer2, Nyellows].

%increasePlayerYellowDiscs(+GameState, +Player, -NewGameState)
increasePlayerYellowDiscs([H|T],1,NewGameState):-
    getHeadandTail(T,Player1,Player2),
    nth0(2, T, Nyellows),
    getPlayerContent(Player1,2,NYellowDiscs),
    N is NYellowDiscs + 1,
    replace_column(2, Player1, N, NewPlayer1),
    NewGameState = [H,NewPlayer1,Player2, Nyellows].

increasePlayerYellowDiscs([H|T], 2, NewGameState):-
    getHeadandTail(T, Player1, Player2),
    nth0(2, T, Nyellows),
    getPlayerContent(Player2,2,NYellowDiscs),
    N is NYellowDiscs + 1,
    replace_column(2, Player2, N, NewPlayer2),
    NewGameState = [H,Player1,NewPlayer2, Nyellows].

%updatePlayerCylinder(+GameState, +Player, +PreviousCell, -NewGameState)
updatePlayerCylinder([H|T], 1, [Row,Column], NewGameState):-
    getHeadandTail(T, Player1, Player2),
    nth0(2, T, Nyellows),
    replace_column(4, Player1, Row, AuxPlayer1),
    replace_column(3, AuxPlayer1, Column, NewPlayer1),
    NewGameState = [H,NewPlayer1,Player2, Nyellows].

updatePlayerCylinder([H|T], 2, [Row,Column], NewGameState):-
    getHeadandTail(T, Player1, Player2),
    nth0(2, T, Nyellows),
    replace_column(4, Player2, Row, AuxPlayer2),
    replace_column(3, AuxPlayer2, Column, NewPlayer2),
    NewGameState = [H,Player1,NewPlayer2, Nyellows].

%updatePlayerDiscs(+Player, +N, -NewPlayer)
updatePlayerDiscs(Player, N, NewPlayer):-
    replace_column(5, Player, N,NewPlayer).