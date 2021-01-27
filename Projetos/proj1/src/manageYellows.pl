:-include('inputs.pl').

%yellowsLoop(+Mode, +GameState, -FinalGameState)
%loop of players alternating where to place the yellow discs
yellowsLoop(Mode, GameState, FinalGameState):-
    getPlayerTypes(Mode, TypePlayer1, TypePlayer2),
    playerTurnY(TypePlayer1, 1, GameState, NewGameState, Done1),
    getYellowCells(NewGameState, Nyellows),
    (
        ( 
            (Done1 \= 0; Nyellows >= 10), 
            FinalGameState = NewGameState
        );
        (
            playerTurnY(TypePlayer2, 2, NewGameState, NewGameState1, Done2),
            getYellowCells(NewGameState1, Nyellows1),
            (
                ( 
                    (Done2 \= 0 ;  Nyellows1 >= 10),
                    FinalGameState = NewGameState1 
                );
                (
                    yellowsLoop(Mode, NewGameState1, FinalGameState)
                )
            )
        )
    ).


%playerTurn(+Mode, +PlayerNumber, +GameState, -NewGameState, -Done)
%for each player it is asked if he wants to continue to place and if so asks where
playerTurnY('H', PlayerNumber, GameState, NewGameState, Done):- 
    nl,nl,format('Player ~d ~n',[PlayerNumber]),nl,
    getYellowCells(GameState, Nyellows),
    readYellowPlacement(ReadOption, Nyellows),
    (
        (
            ReadOption == 'e',
            Done = 1,
            NewGameState = GameState
        );
        (
            ReadOption == 'c',
            Done = 0,
            inputYellow(GameState, PlayerNumber, NewGameState)
        )
    ).


playerTurnY('C', PlayerNumber, GameState, NewGameState, Done):- 
    format('Player ~d ~n',[PlayerNumber]),nl,
    getPossibleYellowPlaces(GameState, PossibleYellowPlaces),
    length(PossibleYellowPlaces, N),
    N1 is N-1,
    random(0, N1, K),
    nth0(K, PossibleYellowPlaces, Place),
    getHeadandTail(Place, R, C),
    replaceCell(GameState, R , C, yellow , AuxGameState),
    increaseYellowCells(AuxGameState, NewGameState),
    display_game(NewGameState, PlayerNumber),
    rowNumber(X,R),
    nl,format('Bot placed yellow at cell : [~w, ~d]', [X, C]),nl,
    Done = 0,
    pressEnterToContinue.   

%input(+GameState, +Player, -NewGameState)  
%Placing the C piece in the place chosen by the player if possible
inputYellow(GameState, Player, NewGameState):-
    display_game(GameState, Player),
    readYellowCell(Row, Column, GameState),
    replaceCell(GameState, Row , Column , yellow , AuxGameState),
    increaseYellowCells(AuxGameState, NewGameState).

%increaseYellowCells(+GameState, -NewGameState)
%increases the number of yellow placed in the board
increaseYellowCells([GameBoard|State], NewGameState):-
    getHeadandTail(State,Player1,Player2),
    nth0(2, State, Nyellows),
    NyellowsNext is Nyellows + 1,
    NewGameState = [GameBoard, Player1, Player2, NyellowsNext].

%getYellowCells(+GameState, -Nyellows)
%return the number of yellow cells stored in the game state
getYellowCells([_|State], Nyellows):-
    nth0(2, State, Nyellows).

%getPossibleYellowPLaces(+GameState, -PossibleYellowPlaces)
%returns a list with the cells where it is possible to place a yellow disc
getPossibleYellowPlaces(GameState, PossibleYellowPlaces):-
    getCellsOfValue(GameState,empty, CellDiscs),
    removeOutsider(CellDiscs, GameState, PossibleYellowPlaces).

%removeOutsider(,+GameState,-L)
%removes the cells that are outsiders(corners and edges) from the list where you can place yellow discs
removeOutsider([], _, []).

removeOutsider([H|T],GameState, [Head|Tail]):-
    getHeadandTail(H, H1, H2),
    validateYellowCell(H2, H1, GameState),
    Head = H, 
    removeOutsider(T, GameState, Tail).

removeOutsider([_|T],GameState, L):-
    removeOutsider(T, GameState, L).

