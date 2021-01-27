:- use_module(library(lists)).
:- include('displayBoard.pl').


/*------------------------------------------- MENU -----------------------------------------------*/

%cleans screen
clearScreen:-write('\e[2J').

%asks the user to press enter to continue
pressEnterToContinue:-
	write('Press <Enter> to continue.'),
	waitForEnter, !.

%reads the "enter" from the user
waitForEnter:-
     skip_line.

%validateOption(+Option)
%validates if the user as choosen either c or e
validateOptionP('c'). % continue
validateOptionP('e'). % end

/*------------------------------------------- LIST HANDLER -----------------------------------------------*/

%getTail(+L, -L1)
getTail([T|_], T).

%getHeadandTail(+L, -L1, -L2)
%Returns the head and tail for a list with only one element on the tail
getHeadandTail([H|T], L1, L2):-
    L1 = H,
    getTail(T, L2). 


%getHeadandTail2(+L, -L1, -L2)
%return the head and tail of a list 
getHeadandTail2([H|T], L1, L2):-
    L1 = H,
    L2 = T. 

%appendT(+L1, +L2, -Res) 
%appends L1 to L2 saving it in Res
appendT(L1, [], L1).
appendT(L1,L2,[H|T]):-
    L2 \= [],
    H = L1,
    T = L2.

%addToValidLists(+L1,+L2, -L3)
%adds L1 to L2 saving it in L3
addToValidLists([], Current, Current).
addToValidLists([H|T], L, [H|Tail]):-
    addToValidLists(T,L, Tail).

%getEachList(+L1, -L2) 
%puts the final element of each list of L1 in L2
getEachList([], []).
getEachList([H|T], [Cell|Others]):-
    last(H, FinalCell),
    Cell = FinalCell,
    getEachList(T, Others).

% flat(+NestedList, -FlatList) 
%joins lists inside of a list
flat([], []).
flat([H|T],R):-
    flat(T,T1),
    append(H,T1,R).

%max_list(+List, -Element)
%returns the max of a list
max_list([X],X).
max_list([X|Xs],S) :- max_list(Xs,Y),(X>=Y,S=X,!;S=Y).

/*------------------------------------------- CELLS -----------------------------------------------*/
%replaceCell(+GameState, +Row, +Column, +Value, -NewGameState)
%replaces the content of the cell in Row/Column with value
replaceCell([GameBoard|State], Row, Column, Value, NewGameState):-
    replaceCellAux(GameBoard,Row,Column,Value, NewGameBoard),
    NewGameState = [NewGameBoard| State].

%replaceCellAux(+[L|Ls] , +Row , +Column , +Value , +[R|Ls]) 
%base case: we found the line to change
replaceCellAux([L|Ls] , 0 , Column , Value , [R|Ls]) :-
  replace_column(Column, L,  Value, R).

replaceCellAux( [L|Ls] , Line , Column , Value , [L|Rs] ) :-
  Line > 0 ,
  Line1 is Line-1 ,
  replaceCellAux( Ls , Line1 , Column , Value , Rs ).

%getCellContent(+SelColumn, +SelRow, -Content, +GameBoard)
%gets the content of cell in Row/Column
getCellContent(SelColumn, SelRow, Content, GameBoard):-
    nth0(SelRow, GameBoard, BoardRow),
    nth0(SelColumn, BoardRow, Content).

%verifyCellContent(+SelColumn, +SelRow, +Content, +GameState)
%verify if the content of cell SelRow/SelColumn is Content
verifyCellContent(SelColumn, SelRow, Content, GameBoard):-
    getCellContent(SelColumn, SelRow, Cont, GameBoard),
    Cont == Content.


%replace_column(Index, List, Value, ResultList) 
%replaces the column index of the line found in replaceCell
replace_column(Index, List, Value, ResultList) :-
    nth0(Index, List, _, X),
    nth0(Index, ResultList, Value, X).


%isDifferent(+L1, +L2) 
%returns true if L1 is different from L2
isDifferent([A,B],[C,D]):-
    (A \= C ; B \= D),
    !.


%validateCell(+SelColumn, +SelRow, +Color, +GameState) 
%sees if the cell choosen actually matches the content that it is supposed to be
validateCellContent(SelColumn, SelRow, Cont, [GameBoard|_]):-
    getCellContent(SelColumn, SelRow, Content, GameBoard),
    !,
    Content == Cont.


%validateYellowPlacementCell([+SelColumn,+SelRow], +Content, +GameState) 
%sees if a cell is valid and empty
validateYellowCell(SelColumn, SelRow, [GameBoard|_]):-
    getCellContent(SelColumn, SelRow, Content, GameBoard),
    !,
    Content == empty,
    outsiders(Outsiders),
    !,
    \+ member([SelRow,SelColumn], Outsiders).


%getCellsOfValue(+GameState, +Value, -CellDiscs) 
%gets the position of the discs of the player of color Color placed in the board
getCellsOfValue([GameBoard|_],Value, CellDiscs):-
    iterateBoard(GameBoard, 0, 0, Value, [], CellDiscs).

%iterateBoard(+Board, +Line, +Column, +Value, +Res, -Final) 
%iterates the board to find the discs with content = value, running for each line
iterateBoard(_ , 11 , _ , _ , Res, Res).
iterateBoard(Board , Line , Column , Value , Res, Final):-
    Line < 11,
    iterateBoardColumn(Board, Line, Column, Value, [], LineRes),
    append(Res,LineRes,Result),
    Line1 is Line + 1,
    iterateBoard(Board,Line1, 0, Value, Result, Final).

%iterateBoardColumn(+Board, +Line, +Column, +Value, Res, Final) 
%iterates each column to find the cells with content = value
iterateBoardColumn(_, _, 21, _, Res, Res).

iterateBoardColumn(Board, Line, Column, Value, Res, Final):-
    Column < 21,
    getCellContent(Column, Line, Content, Board),
    Column1 is Column + 1,
    Content == Value,
    append([[Line,Column]],Res,Result),
    iterateBoardColumn(Board,Line, Column1, Value, Result, Final).

iterateBoardColumn(Board, Line, Column, Value, Res, Final):-
    Column < 21,
    Column1 is Column + 1,
    iterateBoardColumn(Board,Line, Column1, Value, Res, Final).


/*----------------------------------- FOR GAME PLAYS -------------------------------*/

%motionDisc(+[Ri|Ci], +[Rf|Cf], +GameState, -NewGameState) 
%switches the content of this two cells 
motionDisc([Ri|Ci], [Rf|Cf], GameBoard, NewGameBoard):-
    getCellContent(Ci, Ri,ContentI,GameBoard),
    getCellContent(Cf, Rf, ContentF, GameBoard),
    replaceCellAux(GameBoard, Rf, Cf, ContentI, GameBoardAux),
    replaceCellAux(GameBoardAux, Ri, Ci, ContentF, NewGameBoard).

%rowNumber(+RowLetter, -RowNumber)
rowNumber('A',0).
rowNumber('B',1).
rowNumber('C',2).
rowNumber('D',3).
rowNumber('E',4).
rowNumber('F',5).
rowNumber('G',6).
rowNumber('H',7).
rowNumber('I',8).
rowNumber('J',9).
rowNumber('K',10).

rowNumber('a',0).
rowNumber('b',1).
rowNumber('c',2).
rowNumber('d',3).
rowNumber('e',4).
rowNumber('f',5).
rowNumber('g',6).
rowNumber('h',7).
rowNumber('i',8).
rowNumber('j',9).
rowNumber('k',10).




%emptySignalCells(+GameState, +SignalCells, -NewGameState)
%Emptys the cells in the list of signalcells
emptySignalCells([GameBoard|State], SignalCells, NewGameState):-
    emptySignalCellsAux(GameBoard,SignalCells,NewGameBoard),
    NewGameState = [NewGameBoard|State].

emptySignalCellsAux(GameBoard, [], NewGameBoard1):-
    NewGameBoard1 = GameBoard.

emptySignalCellsAux(GameBoard, [H|T], NewGameBoard1):-
    getHeadandTail(H, L1, L2),
    replaceCellAux(GameBoard , L1 , L2 , empty , NewGameBoard),
    emptySignalCellsAux(NewGameBoard, T, NewGameBoard1).

%moveIsValid(+ListOfMoves, +Move) 
%returns true if Move belongs to ListOfMoves
moveIsValid([H|_], Move):-
    getHeadandTail(H, L1,_),%the head is a list whose head is the starting cells and the tail all possible ending positions
    getHeadandTail(Move, Initial, End),
    L1 == Initial, %if the head of this list is the choosen starting cell then we need to look if the choosen end cell is a member of the valid ones
    !,
    member(End, H).

moveIsValid([_|T], Move):-
    moveIsValid(T,Move).    


%getMode(+Op, -Option)
getMode(1,'HH').
getMode(2,'HC').
getMode(3,'CC').