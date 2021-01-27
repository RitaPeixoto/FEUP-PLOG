%readOptionMenu(-Option) read option from main menu
readOptionMenu(Option):-
    write('> Insert your option: '),
    read(ReadOption),
    (
        (
            validateOption(ReadOption),
            Option = ReadOption
        );
        (
            write('ERROR: Please enter option again.'), nl,
            readOptionMenu(Option)  
        )
    ).

%readYellowCell(-Row,-Column,+GameState) read row and column to place disc.
readYellowCell(Row, Column, GameState):-
    nl,nl, write(' > choose a column to place it:'),
    read(ReadColumn),
    nl, write(' > choose a row to place it (between '' ''):'),
    read(ReadRow),
    (
        (
            rowNumber(ReadRow,RowNumber),
            validateYellowPlacementCell([ReadColumn,RowNumber], empty, GameState),
            Row=RowNumber, Column = ReadColumn
        );
        (
            nl,nl,write('ERROR: Invalid cell.'), nl,
            readYellowCell(Row,Column, GameState)  
        )
        
    ).

%readOptionPlacement(-Option,+N) read option to continue or to end yellow disc placement.
readOptionPlacement(Option, N):-
    write(' > Write c to continue or e to end placement (minimum of 5 yellow discs)'),
    nl, write(' > Insert your option: '),
    read(ReadOption),
    (
        ( /*any option when N>=5 is valid*/
            validateOptionP(ReadOption),
            Option = ReadOption,
            N>=5
        );
        (  /*only 'c' option is valid when N=<5*/
            N=<5,
            validateOptionP(ReadOption),
            ReadOption = 'c',
            Option = ReadOption
        );
        (  /*the board has less than 5 discs, force to continue. */
            N=<5,
            validateOptionP(ReadOption),
            nl,nl,write('ERROR: Less than 5 discs on board. Please insert.'),nl,nl,
            Option = 'c'  
        );
        ( /*invalid input */
            \+ validateOptionP(ReadOption),
            write('ERROR: Invalid option.'), nl,
            readOptionPlacement(Option,N)  
        )
    ).

%validateCell(+SelColumn, +SelRow, _Content, +GameState) sees if a cell is valid.
validateCell(SelColumn, SelRow, _Content, GameState):-
    getCellContent(SelColumn, SelRow, Content, GameState),
    Content \= tab.

%validateYellowPlacementCell([+SelColumn,+SelRow], +Content, +GameState) sees if a cell is valid and empty
validateYellowPlacementCell([SelColumn,SelRow], Content, GameState):-
    getCellContent(SelColumn, SelRow, Content, GameState),
    Content = empty,
    outsiders(Outsiders),
    !,
    \+ member([SelRow,SelColumn], Outsiders).

%Placing the C piece in the place chosen by the player if possible
playerPlaces(GameState, Value, NewGameState):-
    display_game(GameState,_),
    readYellowCell(Row, Column, GameState),
    replaceCell(GameState, Row , Column , Value , NewGameState).


%rowNumber(+RowLetter, -RowNumber)
rowNumber('A',Row) :- Row=0.
rowNumber('B',Row) :- Row=1.
rowNumber('C',Row) :- Row=2.
rowNumber('D',Row) :- Row=3.
rowNumber('E',Row) :- Row=4.
rowNumber('F',Row) :- Row=5.
rowNumber('G',Row) :- Row=6.
rowNumber('H',Row) :- Row=7.
rowNumber('I',Row) :- Row=8.
rowNumber('J',Row) :- Row=9.
rowNumber('K',Row) :- Row=10.

%validateOption(+Option)
validateOption(1). % Play
validateOption(2). % Instructions
validateOption(3). % Exit
validateOptionP('c'). % continue
validateOptionP('e'). % end


%---------------------------------------- NOT USING YET -------------------------------------- 

%defineColors function to choose player colors
defineColors:-
    write('> Which player gets the red discs?(answer must be 1 or 2)'),
    read(RedPlayer),
    nl,
    write('> Which player gets the green discs?(answer must be 1 or 2)'),
    read(GreenPlayer),
    nl,
    (
        (   GreenPlayer \= RedPlayer,
            validatePlayer(RedPlayer),
            validatePlayer(GreenPlayer),
            setPlayersColor(RedPlayer,GreenPlayer)
        );

        (   
            write('Invalid choice!'), 
            nl, 
            defineColors
        )
        
    ).


%setPlayersColor(+RedPlayer, +GreenPlayer) assign color to each player
setPlayersColor(RedPlayer, GreenPlayer):-
    player(RedPlayer,_,0,_,_,10),
    retract(player(RedPlayer,_,0,_,_,10)),
    assert(player(RedPlayer,'R',0,_,_,10)),
    player(GreenPlayer,_,0,_,_,10),
    retract(player(GreenPlayer,_,0,_,_,10)),
    assert(player(GreenPlayer,'G',0,_,_,10)).

%validatePlayer(+Player)
validatePlayer(1).
validatePlayer(2). 
