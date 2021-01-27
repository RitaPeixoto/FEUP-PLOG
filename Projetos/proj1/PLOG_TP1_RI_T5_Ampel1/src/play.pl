:-include('gamePlays.pl').
:-include('manageYellows.pl').
:-include('displayBoard.pl').

%main predicate of the game
play:-
    clearScreen,
    initial(GameState),
    display_game(GameState, Player).
    /*,
    placeYellowDisc(GameState, 0, 10, NewGameState),
    display_game(NewGameState, Player).*/

%initial(+GameState)
initial(GameState):-
    initialBoard(GameState).
    /*intermediateBoard(GameState).*/
    /*finalBoard(GameState).*/

