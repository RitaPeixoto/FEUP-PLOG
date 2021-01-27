

%start(+Mode, +Level)
%main predicate of the game
start(Mode, Level):-
    clearScreen,
    initial(GameState),
    nl,nl,
    write('The player 1 is the one with the red discs and the player 2 the one with red discs'),nl,nl, %the first player is the one who decided to terminate the yellow placement
    yellowsLoop(Mode, GameState, NewGameState),
    gameLoop(Mode, Level, NewGameState).


%initial(-GameState)
initial(GameState):-
    initialBoard(GameState).
    /*intermediateBoard(GameState).*/
    /*finalBoard(GameState).*/

