:-include('manageYellows.pl').
:-include('bot.pl').
:-include('logic.pl').
:-include('player.pl').
:-include('play.pl').

/*------------------------------------------------ GAME LOOP ---------------------------------------------------------*/
%gameLoop(+Mode, +Level, +GameState)
%loop alternating from a Player1 play and a Player2 play
gameLoop(Mode, Level, GameState):-
    getPlayerTypes(Mode, TypePlayer1, TypePlayer2),
    playerTurn(TypePlayer1, 1, Level, GameState, NewGameState, Winner1),
    (
        ( Winner1 \= 0, displayWinner(Winner1) );
        (
            playerTurn(TypePlayer2, 2, Level, NewGameState, NewGameState1, Winner2),
            (
                ( Winner2 \= 0, displayWinner(Winner2) );
                (
                    gameLoop(Mode, Level,NewGameState1)
                )
            )
        )
    ).

%playerTurn(+Mode, +PlayerNumber, +Level,+GameState, -FinalGameState, -Winner)
%executes a turn of a player asking for all necessary plays
playerTurn('H', PlayerNumber, _, GameState, FinalGameState, Winner):-
    moveMyDisc(PlayerNumber, GameState, NewGameState),
    (
        ( game_over(NewGameState, Winner));
        (
            moveOpponentDisc(PlayerNumber, NewGameState, NewGameState1),
            (
                ( game_over(NewGameState1, Winner1), Winner = Winner1 );
                (
                    addMyDisc(PlayerNumber, NewGameState1, NewGameState2),
                    FinalGameState = NewGameState2,
                    (
                        (NewGameState2 == 0, Winner = 3);
                        (Winner = Winner1)
                    )
                )
            )
        )
    ).



playerTurn('C', PlayerNumber, Level, GameState, FinalGameState, Winner):-
    display_game(GameState,PlayerNumber),
    choose_move(GameState, [0,PlayerNumber], Level, Move),
    movingDiscs(0, PlayerNumber, GameState, Move, NewGameState),
    display_move(current, Move, PlayerNumber),
    (
        (
            game_over(NewGameState, Winner),
            FinalGameState = NewGameState
        );
        (
            choose_move(NewGameState, [1,PlayerNumber], Level, MoveOpp),
            movingDiscs(1, PlayerNumber, NewGameState, MoveOpp, NewGameState1),
            display_move(opponent, Move, PlayerNumber),
            (
                (
                    game_over(NewGameState1, Winner1),
                    Winner = Winner1,
                    FinalGameState = NewGameState1
                );
                (
                    choose_add(NewGameState1, PlayerNumber, Add),
                    addDisc(PlayerNumber, NewGameState1, Add, FinalGameState),
                    (
                        (FinalGameState == 0, Winner = 3);
                        (display_add(Add, PlayerNumber))
                    )
                )
            )
        )
    ),
    write('\nBOT turn done\n'),
    pressEnterToContinue.

/*------------------------------------------------ GAME  PLAYS ---------------------------------------------------------*/

%moveMyDisc(+Player, +GameState, -Res), res will be one if there was a traffic signal created
%moves one of the player discs if possible
moveMyDisc(Player, GameState, NewGameState) :-
    getPlayerColor(Player,PlayerColor),
    valid_moves(GameState, PlayerColor, ListOfMoves), %get all possible plays 
    length(ListOfMoves, N),
    (
        (
            N == 0,
            NewGameState = GameState
        );
        (
            display_game(GameState, Player),
            write('\n1. Move one of your discs'),
            inputMoveDisc(0, Player, GameState, ListOfMoves, NewGameState)
        )
    ).

%addMyDisc(+Player, +GameState,-NewGameState)
%adds one disc of the player to the board
addMyDisc(Player,GameState,NewGameState):-
    valid_adds(GameState, Player, ListOfAdds),
    display_game(GameState, Player),
    write('\n3. Add one of your discs'),
    inputAddDisc(Player, GameState, ListOfAdds, NewGameState).

%moveOpponentDisc(+Player, +GameState, -Res), res will be one if there was a traffic signal created
%move one of the discs of the players opponent
moveOpponentDisc(Player, GameState, NewGameState):-
    getOpponentColor(Player,OpponentColor),
    valid_moves(GameState, OpponentColor, ListOfMoves), %get all possible plays 
    length(ListOfMoves, N),
    (
        (
            N == 0,
            NewGameState = GameState
        );
        (
            display_game(GameState, Player),
            write('\n2. Move one of your opponent discs'),
            inputMoveDisc(1, Player, GameState, ListOfMoves, NewGameState)
        )
    ).

%getEndCells(ListOfMoves, EndCells):-
%get all possible end cells from list of moves
getEndCells([],[]).

getEndCells([H|_], [EndCells|_]):-
    getHeadandTail2(H, _, L2),
    EndCells = L2.


%addDisc(+Player,+GameState, +Add, -NewGameState)
%adds the discs and deals with all the things that are necessary to update
addDisc(Player, GameState, 0, NewGameState):-
    write('You dont have any discs left to place\n'),
    getPlayerColor(Player,PlayerColor),
    getOpponentColor(Player, OpColor),

    valid_moves(GameState, PlayerColor, ListOfMoves1),
    getEndCells(ListOfMoves1, ECells1),
    flat(ECells1,EndCells1),
    verifyCells(PlayerColor, GameState,EndCells1, L1),
    length(EndCells1, N1),
    length(L1, NL1),
    
    valid_moves(GameState, OpColor, ListOfMoves2),
    getEndCells(ListOfMoves2, ECells2),
    flat(ECells2,EndCells2),
    verifyCells(OpColor, GameState, EndCells2, L2),
    length(EndCells2, N2),
    length(L2, NL2),
    (
        (N1 == NL1, N2 == NL2, NewGameState = 0);
        ( updatePlayerCylinder(GameState, Player, [0,0], NewGameState) )%takes the cylinder off the board;
    ).

    


addDisc(Player, GameState, [Rf,Cf], NewGameState):-
    getPlayerColor(Player, Color),
    getCylinder(Color,Cylinder),
    getPlayerCylinder(GameState, Player, Ri, Ci),
    replaceCell(GameState, Rf, Cf, Cylinder, AuxGameState), %updates the cell to have a red disc with a red cylinder
    updatePlayerCylinder(AuxGameState, Player, [Rf,Cf], AuxGameState1),
    decreasePlayerDiscs(AuxGameState1, Player, AuxGameState2),
    (
        (
            validateCellContent(Ci, Ri, empty, AuxGameState2), %it means it was retrieve when a semaphore was formed
            NewGameState = AuxGameState2
        );
        (
            Ri \= 0,
            replaceCell(AuxGameState2, Ri, Ci, Color, NewGameState)
        );
        (
            Ci \= 0,
            replaceCell(AuxGameState2, Ri, Ci, Color, NewGameState)
        );
        (
            NewGameState = AuxGameState2
        )
    ).


/*------------------------------------------------ AUXILIAR PLAYS FUNCTIONS ---------------------------------------------------------*/

%inputMoveDisc(+WhichPlayer, +Player, +GameState, +ListOfMoves, -FinalGameState)
%deals with the input of the player when moving a disc
inputMoveDisc(WhichPlayer, Player, GameState, ListOfMoves, FinalGameState):-
    getColor(WhichPlayer, Player, Color),
    readStartCell(Ri, Ci, GameState, Color), %asks which disc the player wants to move
    readEndCell(Rf, Cf, GameState), %asks where the player wants to move it  
    (
        (
            moveIsValid(ListOfMoves, [[Ci,Ri], [Cf,Rf]]),
            movingDiscs(WhichPlayer, Player, GameState,[[Ri,Ci],[Rf,Cf]], FinalGameState)
        );
        (
            nl,nl,
            write('Error: Invalid move, try again!'),
            inputMoveDisc(WhichPlayer, Player, GameState, ListOfMoves, FinalGameState)
        )
    ).

%inputAddDisc(+Player, +GameState, -NewGameState)
%deals with the input of the player when adding a disc
inputAddDisc(Player, GameState, _, NewGameState):-
    getPlayerDiscs(GameState, Player, NDiscs),
    NDiscs == 0,
    addDisc(Player, GameState,0, NewGameState).

inputAddDisc(Player, GameState, ListOfAdds, NewGameState):-
    readEndCell(Rf, Cf, GameState),
    (
        (
            member([Rf,Cf], ListOfAdds),
            addDisc(Player, GameState,[Rf,Cf], NewGameState)
        );
        (
            write('\nYou cant place it here, that cell will form a traffic signal'),
            inputAddDisc(Player, GameState, ListOfAdds, NewGameState)
        )
    ).

%getColor(+CurrentMove, ?Player, ?Color)   
%get color deppending on type of move  0-> moving current player discs  1-> moving oponent discs
getColor(0,Player, Color):-
    getPlayerColor(Player,Color).

getColor(1, Player, Color):-
    getOpponentColor(Player,Color).


%movingDiscs(+PlayerColor, +GameState,-Ret), ret will be 1 if there was a traffic signal formatted
%moves the discs and deals with all the things that are necessary to update
movingDiscs(_, _, GameState, 0, GameState). /*NO MOVE ON BOT*/

movingDiscs(WhichPlayer, Player, GameState,[[Ri,Ci],[Rf,Cf]], FinalGameState):-
    move(GameState, [[Ri,Ci],[Rf,Cf]], NewGameState), %move the disc
    getColor(WhichPlayer, Player, Color),
    verifyTrafficSignal(Rf, Cf, Color, NewGameState, Res, SignalCells),%verify if a signal was formed,
    (
        (
            Res == 0,
            emptySignalCells(NewGameState, SignalCells, NewGameState1), % take the signal cells off of the board
            increasePlayerDiscs(NewGameState1,1,NewGameState2),
            increasePlayerDiscs(NewGameState2,2,NewGameState3),
            increasePlayerYellowDiscs(NewGameState3,Player,FinalGameState)
        );
        (
            FinalGameState = NewGameState
        )
    ).

/*
 * Verifies if the disc in the desired cell forms form signal and if the cell is empty, Res = 1 if it's empty and doesnt forma traffic signal, 
 * Res = 0 if it forms a traffic signal, returning the list with the cells that form it
*/
%verifyTrafficSignal(+Row, Column, +PlayerColor, +GameState, -Res, -SignalCells, -hasCylinder)
/*case signal is formed going downright*/
verifyTrafficSignal(Row, Column, Color, [GameBoard|_], Res, SignalCells):-      
    Row1 is Row + 1,
    Column1 is Column + 1,
    verifyCellContent(Column1, Row1, yellow, GameBoard), %downright
    Row2 is Row + 2,
    Column2 is Column + 2,
    getCellContent(Column2, Row2, ColorX, GameBoard),
    getCylinder(Color,Cylinder),
    ColorX \= Cylinder,
    ColorX \= Color, %the disc next to the yellow has to be different color from the one the player is trying to place
    ColorX \= empty, 
    ColorX \= tab,
    ColorX \= yellow,
    SignalCells = [[Row1, Column1], [Row2, Column2], [Row, Column]],
    Res = 0.

/*case signal is formed going right*/
verifyTrafficSignal(Row, Column, Color, [GameBoard|_], Res, SignalCells):- 
    Column1 is Column + 2,
    verifyCellContent(Column1,Row, yellow, GameBoard),%right
    Column2 is Column + 4,
    getCellContent(Column2, Row, ColorX, GameBoard),
    getCylinder(Color,Cylinder),
    ColorX \= Cylinder,
    ColorX \= Color,
    ColorX \= empty, 
    ColorX \= tab,
    ColorX \= yellow,
    SignalCells = [[Row, Column1], [Row, Column2], [Row, Column]],
    Res = 0.

/*case signal is formed going upright*/
verifyTrafficSignal(Row, Column, Color, [GameBoard|_], Res, SignalCells):- 
    Row1 is Row - 1,
    Column1 is Column + 1,
    verifyCellContent( Column1,Row1, yellow, GameBoard),%upright
    Row2 is Row - 2,
    Column2 is Column + 2,
    getCellContent( Column2, Row2, ColorX, GameBoard),
    getCylinder(Color,Cylinder),
    ColorX \= Cylinder,
    ColorX \= Color,
    ColorX \= empty, 
    ColorX \= tab,
    ColorX \= yellow,
    SignalCells = [[Row1, Column1], [Row2, Column2], [Row, Column]],
    Res = 0.

/*case signal is formed going upleft*/
verifyTrafficSignal(Row, Column, Color, [GameBoard|_], Res, SignalCells):- 
    Row1 is Row - 1,
    Column1 is Column - 1,
    verifyCellContent(Column1,Row1, yellow, GameBoard),%upleft
    Row2 is Row - 2,
    Column2 is Column - 2,
    getCellContent( Column2, Row2, ColorX, GameBoard),
    getCylinder(Color,Cylinder),
    ColorX \= Cylinder,
    ColorX \= Color,
    ColorX \= empty, 
    ColorX \= tab,
    ColorX \= yellow,
    SignalCells = [[Row1, Column1], [Row2, Column2], [Row, Column]],
    Res = 0.

/*case signal is formed going left*/
verifyTrafficSignal(Row, Column, Color, [GameBoard|_], Res, SignalCells):- 
    Column1 is Column - 2,
    verifyCellContent( Column1,Row, yellow, GameBoard),%left
    Column2 is Column - 4,
    getCellContent( Column2, Row,ColorX, GameBoard),
    getCylinder(Color,Cylinder),
    ColorX \= Cylinder,
    ColorX \= Color,
    ColorX \= empty, 
    ColorX \= tab,
    ColorX \= yellow,
    SignalCells = [[Row, Column1], [Row, Column2], [Row, Column]],
    Res = 0.

/*case signal is formed going downleft*/
verifyTrafficSignal(Row, Column, Color, [GameBoard|_], Res, SignalCells):-
    Row1 is Row + 1,
    Column1 is Column - 1,
    verifyCellContent(Column1, Row1, yellow, GameBoard),%downleft
    Row2 is Row + 2,
    Column2 is Column - 2,
    getCellContent( Column2, Row2, ColorX, GameBoard),
    getCylinder(Color,Cylinder),
    ColorX \= Cylinder,
    ColorX \= Color,
    ColorX \= empty, 
    ColorX \= tab,
    ColorX \= yellow,
    SignalCells = [[Row1, Column1], [Row2, Column2], [Row, Column]],
    Res = 0.
    
/*case signal is not formed*/
verifyTrafficSignal(_, _, _, [_|_], 1, _).