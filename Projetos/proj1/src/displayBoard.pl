:- use_module(library(lists)).


/*-------------------------------------------------- DATA -------------------------------------------------------------*/

%initialBoard
initialBoard([[
    [tab, tab, tab, tab, tab, tab, tab, tab, tab, tab, empty, tab, tab, tab, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, tab, tab, tab, empty, tab, empty, tab, tab, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, tab, tab, empty, tab, empty, tab, empty, tab, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab, tab, tab],
    [tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab, tab],
    [tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab],
    [tab, empty, tab, empty, tab, empty, tab, empty, tab,empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab],
    [empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty]
    ],[1, red, 0, 0, 0, 20],[2, green, 0, 0, 0, 20], 0]).
%player([id, discs color, nYellowDiscs, cylinderCollumn, cylinderRow, nDiscs])

%intermediateBoard
intermediateBoard([[
    [tab, tab, tab, tab, tab, tab, tab, tab, tab, tab, empty, tab, tab, tab, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, tab, tab, tab, empty, tab, empty, tab, tab, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, tab, tab, empty, tab, green, tab, empty, tab, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, gcyl, tab, empty, tab, empty, tab, empty, tab, red, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, empty, tab, yellow, tab, red, tab, empty, tab, gcyl, tab, empty, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, empty, tab, yellow, tab, empty, tab, empty, tab, empty, tab, red, tab, empty, tab, tab, tab, tab],
    [tab, tab, tab, empty, tab, yellow, tab, empty, tab, empty, tab, empty, tab, red, tab, empty, tab, empty, tab, tab, tab],
    [tab, tab, empty, tab, yellow, tab, empty, tab, empty, tab, red, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab],
    [tab, empty, tab, yellow, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab],
    [empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, rcyl, tab, empty, tab, empty, tab, empty, tab, green, tab, empty]],
    [1, red, 0, 0, 0, 5],[2, green, 0, 0, 0, 5], 9]).

%finalBoard
finalBoard([[
    [tab, tab, tab, tab, tab, tab, tab, tab, tab, tab, empty, tab, tab, tab, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, tab, tab, tab, empty, tab, empty, tab, tab, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, tab, tab, empty, tab, green, tab, empty, tab, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, gcyl, tab, empty, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, red, tab, empty, tab, tab, tab, tab],
    [tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab, tab],
    [tab, tab, green, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab],
    [tab, empty, tab, yellow, tab, red, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab],
    [empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, rcyl, tab, empty, tab, empty, tab, empty, tab, green, tab, empty]],
    [1, red, 0, 0, 0, 5],[2, green, 0, 0, 0, 5], 9]).





%List with lists that represent edges and corners, places where a yellow disc cannot be placed, each list corresponds to the row and collumn of that cell
outsiders([[0,10],[1,9],[1,11],[2,8],[2,12],[3,7],[3,13],[4,6],[4,14],[5,5],[5,15],[6,4],[6,16],[7,3],[7,17],[8,2],[8,18],[9,1],[9,19],[10,0],[10,2],[10,4],[10,6],[10,8],[10,10],[10,12],[10,14],[10,16],[10,18],[10,20]]). 





/*--------------------------------------------------- BOARD MEANINGS ------------------------------------------------------------*/

%symbol(+BoardSymbol, -RealSymbol) 
%Puts in RealSymbol the corresponding symbol to the BoardSymbol
symbol(tab, '.').
symbol(empty, '*').
symbol(red, 'R').
symbol(green, 'G').
symbol(gcyl, 'Z').
symbol(rcyl, 'W').
symbol(yellow, 'Y').



/*------------------------------------------------- DISPLAY FUNCTIONS --------------------------------------------------------------*/

%display_game(+GameState, +Player) 
%displays the game in the state GameState
display_game([H|T], CurrentPlayer):-
    clearScreen,
    getHeadandTail(T,Player1,Player2),
    format('\n-----------------------------------------Player ~d -------------------------------------------\n',[CurrentPlayer]),
    printBoard(H),
    display_players(Player1,Player2).

displayGame(GameState):-
    printBoard(GameState).


%printBoard(+GameState) 
%prints the board
printBoard(Gamestate):-
    write('\n|---| 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10| 11| 12| 13| 14| 15| 16| 17| 18| 19| 20|---|\n'),
    write('|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n'),
    printLines(Gamestate, 0).


%printLines(List, N) 
%prints each Line with the corresponding line identifier N
printLines([],_).
printLines([Head|Tail], N) :-
    rowNumber(L,N),
    write('| '),
    write(L),
    write(' | '),
    printLine(Head),
    N1 is N+1,
    printLines(Tail,N1).


%printLine(+List)
%prints the line that corresponds to the list sent as argument
printLine([]):-
    write('. |'),
    nl,
    write('|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n').

printLine([Head|Tail]):-
    printCell(Head),
    printLine(Tail).


%printCell(+Cell)
%prints the content corresponding to the symbol cell
printCell(Cell):-
    symbol(Cell,Symb),
    write(Symb),
    write(' |'),
    write(' ').



%displayWinner(+Winner) 
%displays the winner
displayWinner(1):-
    write('  _____  _                         __            _           _ '),nl,
    write(' |  __ \\| |                       /_ |          (_)         | |'),nl,
    write(' | |__) | | __ _ _   _  ___ _ __   | | __      ___ _ __  ___| |'),nl,
    write(' |  ___/| |/ _` | | | |/ _ \\ ''__|  | | \\ \\ /\\ / / | ''_ \\/ __| |'),nl,
    write(' | |    | | (_| | |_| |  __/ |     | |  \\ V  V /| | | | \\__ \\_|'),nl,
    write(' |_|    |_|\\__,_|\\__, |\\___|_|     |_|   \\_/\\_/ |_|_| |_|___(_)'),nl,
    write('                  __/ |                                        '),nl,
    write('                 |___/                                         '),nl.

displayWinner(2):-
    write('  _____  _                         ___             _           _ '),nl,
    write(' |  __ \\| |                       |__ \\           (_)         | |'), nl,
    write(' | |__) | | __ _ _   _  ___ _ __     ) | __      ___ _ __  ___| |'), nl,
    write(' |  ___/| |/ _` | | | |/ _ \\ ''__|   / /  \\ \\ /\\ / / | ''_ \\/ __| |'), nl,
    write(' | |    | | (_| | |_| |  __/ |     / /_   \\ V  V /| | | | \\__ \\_|'),nl,
    write(' |_|    |_|\\__,_|\\__, |\\___|_|    |____|   \\_/\\_/ |_|_| |_|___(_))'),nl,
    write('                  __/ |                                          '),nl,
    write('                 |___/                                           '),nl.

%no winner the game is over
displayWinner(3):-
    write('   _____                                            _ '),nl,
    write('  / ____|                                          | |'),nl,
    write(' | |  __  __ _ _ __ ___   ___    _____   _____ _ __| |'),nl,
    write(' | | |_ |/ _` | ''_ ` _ \\ / _ \\  / _ \\ \\ / / _ \\ ''__| |'),nl,
    write(' | |__| | (_| | | | | | |  __/ | (_) \\ V /  __/ |  |_|'),nl,
    write('  \\_____|\\__,_|_| |_| |_|\\___|  \\___/ \\_/ \\___|_|  (_)'),nl.

displayWinner(0).

%display_players(+Player1, +Player2) 
%displays the players info
display_players(Player1,Player2):-
    write('\n       Player 1                                               Player 2\n'),
    getPlayerContent(Player1,2,Yellows1),
    getPlayerContent(Player2,2,Yellows2),
    format('        Yellows: ~d                                             Yellows: ~d\n',[Yellows1,Yellows2]),
    getPlayerContent(Player1,3,Cc1),
    getPlayerContent(Player1,4,Cr1),
    getPlayerContent(Player2,3,Cc2),
    getPlayerContent(Player2,4,Cr2),
    rowNumber(Cr1L,Cr1),
    rowNumber(Cr2L,Cr2),
    format('        Cylinder: [~w,~d]                                        Cylinder: [~w,~d]\n',[Cr1L, Cc1,Cr2L,Cc2]),
    getPlayerContent(Player1,5,Reds),
    getPlayerContent(Player2,5,Greens),
    format('        Reds: ~d                                               Greens: ~d\n\n',[Reds,Greens]).

%display_move(+Opponent, +Move, +Player)
%displays the move of the player
display_move(_, 0, _).

display_move(opponent, [Start,End], Player):-
    getHeadandTail(Start,Ri,Ci),
    rowNumber(Rowi,Ri),
    getHeadandTail(End,Rf,Cf),
    rowNumber(Rowf,Rf),
    format('Player ~d moved opponent [~w,~d] to [~w,~d]',[Player,Rowi,Ci,Rowf,Cf]),nl.

display_move(current, [Start,End], Player):-
    getHeadandTail(Start,Ri,Ci),
    rowNumber(Rowi,Ri),
    getHeadandTail(End,Rf,Cf),
    rowNumber(Rowf,Rf),
    format('Player ~d moved [~w,~d] to [~w,~d]',[Player,Rowi,Ci,Rowf,Cf]),nl.

%display_add(+Move, +Player)
%display the adding to the board
display_add(0,_).
display_add(Move,Player):-
    getHeadandTail(Move,Ri,Ci),
    rowNumber(Rowi,Ri),
    format('Player ~d added disc at [~w,~d] ',[Player,Rowi,Ci]),nl.