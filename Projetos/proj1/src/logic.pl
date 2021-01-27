:- use_module(library(lists)).


%move(+GameState, +Move, -NewGameState) 
%execution of game plays, receiving a valid move like [[RI|CI],[RF|CF]]
move([GameBoard|State], Move, NewGameState) :-
    getHeadandTail(Move, L1, L2),
    getHeadandTail(L1, Ri, Ci),
    getHeadandTail(L2, Rf, Cf),
    motionDisc([Ri|Ci], [Rf|Cf],GameBoard, NewGameBoard),
    NewGameState=[NewGameBoard|State].


%game_over(+GameStatus,-Winner) 
%verifies the end of the game, identifying the winner, 0 if none of them won, GameStatus is the initial number of yellow discs
game_over([_|T],Winner):-
    getHeadandTail(T,Player1,_),
    nth0(2, T, Nyellows),
    Aux is Nyellows/2,
    YellowsToWin is ceiling(Aux),
    getPlayerContent(Player1, 2, Player1Yellows),
    Player1Yellows >= YellowsToWin,
    Winner = 1.

game_over([_|T], Winner):-
    getHeadandTail(T,_,Player2),
    nth0(2, T, Nyellows),
    Aux is Nyellows/2,
    YellowsToWin is ceiling(Aux),
    getPlayerContent(Player2, 2, Player2Yellows),
    Player2Yellows >= YellowsToWin,
    Winner = 2.


/*---------------------------------------------- ALL ABOUT VALID MOVES ------------------------------------------------------*/

%valid_adds(+GameStat, +Player, -ValidAddings)
%get's all the places it is possible to add discs of the Player
valid_adds(GameState, Player, ValidAddings):-
    getPlayerColor(Player, Color),
    getCellsOfValue(GameState, empty, EmptyCells),
    verifyCells(Color, GameState, EmptyCells, ValidAddings).


%verifyCells(+Color, +GameState, +Cells, -ValidCells)
% takes a list of cells and returns the ones where you can place a disc without forming a signal
verifyCells(_, _, [], []).
verifyCells(Color, GameState, [H|T], [Valid|B]):-
    getHeadandTail(H, Rf, Cf),
    verifyTrafficSignal(Rf, Cf, Color, GameState, Res, _),
    Res == 1,
    Valid = H,
    verifyCells(Color, GameState, T, B).

verifyCells(Color, GameState, [_|T], List):-
    verifyCells(Color, GameState, T, List).


%valid_moves(+GameState, +Player, -ListOfMoves)
%obtains a list with possible moves
valid_moves([GameBoard|_],PlayerColor,ListOfMoves):-
    iterateBoard(GameBoard,0,0, PlayerColor,[], PlayerDiscs),
    getAllMoves(GameBoard, PlayerDiscs, ListOfMoves).

%getAllMoves(+GameState, +PlayerDiscs, -Result)
%gets All the moves for all discs of the player
getAllMoves(_, [], []).
getAllMoves(GameState, [H|T], [Current|Next]):-
    getDiscValidPlay(GameState, H, EndCells),
    reverse(H, H1),
    length(EndCells, N),
    !,
    N \= 0,
    appendT(H1, EndCells, Current),
    getAllMoves(GameState, T, Next).
        

getAllMoves(GameState, [_|T], List):-
    getAllMoves(GameState,T,List).
        

%getDiscValidPlay(+GameState, +DiscPosition, -DiscValidPlays)
%gets the valid plays of the corresponding disc
getDiscValidPlay(GameState, [R,C], DiscValidPlays):-
    canMove(GameState, C, R, UpLeft, UpRight, DownLeft, DownRight, Left, Right),
    findall(Path, generatePath(GameState, UpLeft, UpLeft,C, R, Path,[0,0], upLeft), PathsUpLeft),
    getEachList(PathsUpLeft,UpLeftCells),
    addToValidLists([],UpLeftCells,CurrentList),

    findall(Path, generatePath(GameState, UpRight, UpRight, C, R, Path,[0,0], upRight), PathsUpRight),
    getEachList(PathsUpRight,UpRightCells),
    addToValidLists(UpRightCells, CurrentList,  CurrentList1),
    
    findall(Path, generatePath(GameState, DownLeft, DownLeft,C, R, Path,[0,0], downLeft), PathsDownLeft),
    getEachList(PathsDownLeft,DownLeftCells),
    addToValidLists(DownLeftCells, CurrentList1, CurrentList2),
   
    findall(Path, generatePath(GameState, DownRight,DownRight,C, R, Path,[0,0], downRight), PathsDownRight),
    getEachList(PathsDownRight,DownRightCells),
    addToValidLists(DownRightCells, CurrentList2, CurrentList3),
    
    findall(Path, generatePath(GameState, Left, Left, C,R, Path,[0,0], left), PathsLeft),
    getEachList(PathsLeft,LeftCells),
    addToValidLists(LeftCells, CurrentList3, CurrentList4),
    
    findall(Path, generatePath(GameState, Right, Right,C, R, Path,[0,0], right), PathsRight),
    getEachList(PathsRight,RightCells),
    addToValidLists(RightCells, CurrentList4, CurrentList5),
    DiscValidPlays = CurrentList5.



%generatePath(+GameState, +Counter, +Column, +Row, -Path, +LastCell, +direction) 
%generate the Path of the cell [Column,Row] that can move Counter cells in the direction direction having the lastcell being last cell
generatePath(_, 0, _, _, _,[],_, _).

generatePath(GameState, Counter, CounterInicial, Column, Row, [UpRight|Path], [LC,LR],upRight):-
    Counter > 0,
    NextColumn is Column + 1,
    NextRow is Row - 1,
    getCellContent(NextColumn, NextRow, Content, GameState),
    (
        (
            Counter == CounterInicial,
            !,
            Content == empty
        );
        (
            Counter \=CounterInicial,
            Content == empty
        )
    ),
    Counter1 is Counter - 1,
    isDifferent([NextColumn,NextRow],[LC,LR]),
    UpRight = [NextColumn,NextRow],
    !,
    generatePath(GameState, Counter1,CounterInicial, NextColumn, NextRow, Path, [Column,Row], upRight).

generatePath(GameState, Counter,CounterInicial, Column, Row, [UpRight|Path], [LC,LR],randomDirection):-
    Counter > 0,
    NextColumn is Column + 1,
    NextRow is Row - 1,
    getCellContent(NextColumn, NextRow, Content, GameState),
    Content == empty,
    Counter1 is Counter - 1,
    isDifferent([NextColumn,NextRow],[LC,LR]),
    UpRight = [NextColumn,NextRow],
    generatePath(GameState, Counter1,CounterInicial, NextColumn, NextRow, Path, [Column,Row], upRight).

generatePath(GameState, Counter,CounterInicial, Column, Row, [UpLeft|Path], [LC,LR], upLeft):-
    Counter > 0,
    NextColumn is Column - 1,
    NextRow is Row - 1,
    getCellContent(NextColumn, NextRow, Content, GameState),
    (
        (
            Counter == CounterInicial,
            !,
            Content == empty
        );
        (
            Counter \=CounterInicial,
            Content == empty
        )
    ),
    Counter1 is Counter - 1,
    isDifferent([NextColumn,NextRow],[LC,LR]),
    UpLeft = [NextColumn,NextRow],
    !,
    generatePath(GameState, Counter1,CounterInicial, NextColumn, NextRow, Path, [Column,Row], upLeft).

generatePath(GameState, Counter,CounterInicial, Column, Row, [UpLeft|Path], [LC,LR], randomDirection):-
    Counter > 0,
    NextColumn is Column - 1,
    NextRow is Row - 1,
    getCellContent(NextColumn, NextRow, Content, GameState),
    Content == empty,
    Counter1 is Counter - 1,
    isDifferent([NextColumn,NextRow],[LC,LR]),
    UpLeft = [NextColumn,NextRow],
    generatePath(GameState, Counter1,CounterInicial, NextColumn, NextRow, Path, [Column,Row], upLeft).

generatePath(GameState, Counter,CounterInicial, Column, Row, [Left|Path], [LC,LR], left):-
    Counter > 0,
    NextColumn is Column - 2,
    getCellContent(NextColumn, Row, Content, GameState),
    (
        (
            Counter == CounterInicial,
            !,
            Content == empty
        );
        (
            Counter \=CounterInicial,
            Content == empty
        )
    ),
    Counter1 is Counter - 1,
    isDifferent([NextColumn,Row],[LC,LR]),
    Left = [NextColumn,Row],
    !,
    generatePath(GameState, Counter1,CounterInicial, NextColumn, Row, Path, [Column,Row], left).

generatePath(GameState, Counter,CounterInicial, Column, Row, [Left|Path], [LC,LR], randomDirection):-
    Counter > 0,
    NextColumn is Column - 2,
    getCellContent(NextColumn, Row, Content, GameState),
    Content == empty,
    Counter1 is Counter - 1,
    isDifferent([NextColumn,Row],[LC,LR]),
    Left = [NextColumn,Row],
    generatePath(GameState, Counter1,CounterInicial, NextColumn, Row, Path, [Column,Row], left).

generatePath(GameState, Counter,CounterInicial, Column, Row, [DownLeft|Path], [LC,LR], downLeft):-
    Counter > 0,
    NextColumn is Column - 1,
    NextRow is Row + 1,
    getCellContent(NextColumn, NextRow, Content, GameState),
    (
        (
            Counter == CounterInicial,
            !,
            Content == empty
        );
        (
            Counter \=CounterInicial,
            Content == empty
        )
    ),
    Counter1 is Counter - 1,
    isDifferent([NextColumn,NextRow],[LC,LR]),
    DownLeft = [NextColumn,NextRow],
    !,
    generatePath(GameState, Counter1,CounterInicial, NextColumn, NextRow, Path, [Column,Row], downLeft).

generatePath(GameState, Counter,CounterInicial, Column, Row, [DownLeft|Path], [LC,LR], randomDirection):-
    Counter > 0,
    NextColumn is Column - 1,
    NextRow is Row + 1,
    getCellContent(NextColumn, NextRow, Content, GameState),
    Content == empty,
    Counter1 is Counter - 1,
    isDifferent([NextColumn,NextRow],[LC,LR]),
    DownLeft = [NextColumn,NextRow],
    generatePath(GameState, Counter1,CounterInicial, NextColumn, NextRow, Path, [Column,Row], downLeft).

generatePath(GameState, Counter,CounterInicial, Column, Row, [DownRight|Path], [LC,LR], downRight):-
    Counter > 0,
    NextColumn is Column + 1,
    NextRow is Row + 1,
    getCellContent(NextColumn, NextRow, Content, GameState),
    (
        (
            Counter == CounterInicial,
            !,
            Content == empty
        );
        (
            Counter \=CounterInicial,
            Content == empty
        )
    ),
    Counter1 is Counter - 1,
    isDifferent([NextColumn,NextRow],[LC,LR]),
    DownRight = [NextColumn,NextRow],
    !,
    generatePath(GameState, Counter1,CounterInicial, NextColumn, NextRow, Path, [Column,Row], downRight).

generatePath(GameState, Counter,CounterInicial, Column, Row, [DownRight|Path], [LC,LR], randomDirection):-
    Counter > 0,
    NextColumn is Column + 1,
    NextRow is Row + 1,
    getCellContent(NextColumn, NextRow, Content, GameState),
    Content == empty,
    Counter1 is Counter - 1,
    isDifferent([NextColumn,NextRow],[LC,LR]),
    DownRight = [NextColumn,NextRow],
    generatePath(GameState, Counter1,CounterInicial, NextColumn, NextRow, Path, [Column,Row], downRight).

generatePath(GameState, Counter,CounterInicial, Column, Row, [Right|Path], [LC,LR], right):-
    Counter > 0,
    NextColumn is Column + 2,
    getCellContent(NextColumn, Row, Content, GameState),
    (
        (
            Counter == CounterInicial,
            !,
            Content == empty
        );
        (
            Counter \= CounterInicial,
            Content == empty
        )
    ),
    Counter1 is Counter - 1,
    isDifferent([NextColumn,Row],[LC,LR]),
    Right = [NextColumn,Row],
    !,
    generatePath(GameState, Counter1,CounterInicial, NextColumn, Row, Path, [Column,Row], right).

generatePath(GameState, Counter,CounterInicial, Column, Row, [Right|Path], [LC,LR], randomDirection):-
    Counter > 0,
    NextColumn is Column + 2,  
    getCellContent(NextColumn, Row, Content, GameState),
    Content == empty,
    Counter1 is Counter - 1,  
    isDifferent([NextColumn,Row],[LC,LR]),
    Right = [NextColumn,Row],
    generatePath(GameState, Counter1,CounterInicial, NextColumn, Row, Path, [Column,Row], right).

generatePath(GameState, Counter,CounterInicial, Column, Row, [Right|Path], [LC,LR], PreviousState):-
    Counter > 0,
    PreviousState \= randomDirection,
    generatePath(GameState, Counter,CounterInicial, Column, Row, [Right|Path], [LC,LR], randomDirection).


%canMove(+GameState, +Column, +Row, -UpLeft, -UpRight, -DownLeft, -DownRight, -Left, -Right) 
%saves in each argument the number of cells it has to move if it starts in the argument name direction
canMove(GameState, Column, Row, UpLeft, UpRight, DownLeft, DownRight, Left, Right) :-
    moveDownLeft(GameState, Column, Row,0, FinalDownLeft),
    moveUpRight(GameState, Column, Row, 0, FinalUpRight),
    LineVerticalRight is (FinalUpRight + FinalDownLeft + 1),
    DownLeft = LineVerticalRight,
    UpRight = LineVerticalRight,

    moveUpLeft(GameState, Column, Row, 0, FinalUpLeft),
    moveDownRight(GameState, Column, Row, 0, FinalDownRight),
    LineVerticalLeft is (FinalUpLeft + FinalDownRight + 1),
    UpLeft = LineVerticalLeft,
    DownRight = LineVerticalLeft,
    
    moveLeft(GameState, Column, Row, 0, FinalLeft),
    moveRight(GameState, Column, Row, 0, FinalRight),
    LineHorizontal is (FinalLeft + FinalRight + 1),
    Left = LineHorizontal,
    Right = LineHorizontal.


%moveDownLeft(+GameState, +Column, +Row, +Res, -FinalDownLeft) 
%calculates the number of cells it has to move if it starts in DownLeft direction
moveDownLeft(_, 0, _, Res, Res).

moveDownLeft(_, _, 10, Res, Res).

moveDownLeft(GameState, Column, Row, Res, FinalDownLeft) :-
    C is (Column-1),
    R is (Row + 1),
    getCellContent(C,R,Content,GameState),
    Content \= empty,
    Content \= tab,
    D is (Res+1),
    moveDownLeft(GameState, C, R, D, FinalDownLeft).

moveDownLeft(GameState, Column, Row, Res, FinalDownLeft):-
    C is (Column-1),
    R is (Row + 1),
    moveDownLeft(GameState, C, R, Res, FinalDownLeft).
    

%moveDownRight(+GameState, +Column, +Row, +Res, -FinalDownRight) 
%calculates the number of cells it has to move if it starts in DownRight direction
moveDownRight(_,20 , _, Res, Res).

moveDownRight(_, _, 10, Res, Res).

    
moveDownRight(GameState, Column, Row, Res,FinalDownRight) :-
    C is Column+1,
    R is Row + 1,
    getCellContent(C, R,Content,GameState),
    Content \= empty,  
    Content \= tab,  
    D is (Res+1),
    moveDownRight(GameState, C, R, D, FinalDownRight).



moveDownRight(GameState, Column, Row, Res,FinalDownRight) :-
    C is Column+1,
    R is Row + 1,
    moveDownRight(GameState, C, R, Res, FinalDownRight).

%moveUpLeft(+GameState, +Column, +Row, +Res, -FinalUpLeft) 
%calculates the number of cells it has to move if it starts in UpLeft direction 
moveUpLeft(_,0 , _, Res, Res).

moveUpLeft(_, _, 0, Res, Res).  

moveUpLeft(GameState, Column, Row, Res, FinalUpLeft) :-
    C is Column-1,
    R is Row - 1,
    getCellContent(C, R,Content,GameState),
    Content \= empty,
    Content \= tab,
    D is (Res+1),
    moveUpLeft(GameState, C, R, D, FinalUpLeft).

moveUpLeft(GameState, Column, Row, Res, FinalUpLeft) :-
    C is Column-1,
    R is Row - 1,
    moveUpLeft(GameState, C, R, Res, FinalUpLeft).
 
  
%moveUpRight(+GameState, +Column, +Row, +Res, -FinalUpRight) 
%calculates the number of cells it has to move if it starts in UpRight direction 
moveUpRight(_, 20, _, Res, Res).

moveUpRight(_, _, 0, Res, Res).

    
moveUpRight(GameState, Column, Row, Res, FinalUpRight):-
    C is Column + 1,
    R is Row - 1,
    getCellContent(C,R,Content,GameState),
    Content \= empty,
    Content \= tab,
    U is (Res+1),
    moveUpRight(GameState, C, R, U, FinalUpRight).

moveUpRight(GameState, Column, Row, Res, FinalUpRight):-
    C is Column + 1,
    R is Row - 1,
    moveUpRight(GameState, C, R, Res, FinalUpRight).
    

%moveLeft(+GameState, Left, +Column, +Row, +Res, -FinalLeft) 
%calculates the number of cells it has to move if it starts in Left direction 
moveLeft(_, 0, _, Res, Res).

moveLeft(_, 1, _, Res, Res).

moveLeft(GameState, Column, Row, Res, FinalLeft) :-
    C is Column - 2,
    getCellContent(C,Row,Content,GameState),
    Content \= empty,
    Content \= tab,
    L is (Res+1),
    moveLeft(GameState,C,Row, L, FinalLeft).

moveLeft(GameState, Column, Row, Res, FinalLeft) :-
    C is Column - 2,
    moveLeft(GameState,C,Row, Res, FinalLeft).   

%moveRight(+GameState, +Column, +Row, +Res, -FinalRight) 
%calculates the number of cells it has to move if it starts in Right direction 
moveRight(_, 20, _, Res, Res).

moveRight(_, 19, _, Res, Res).


moveRight(GameState, Column, Row, Res, FinalRight) :-
    C is Column + 2,
    getCellContent(C,Row,Content,GameState),
    Content \= empty,
    Content \= tab,
    R is (Res+1),
    moveRight(GameState, C,Row, R, FinalRight).

moveRight(GameState, Column, Row, Res, FinalRight) :-
    C is Column + 2,
    moveRight(GameState, C,Row, Res, FinalRight).