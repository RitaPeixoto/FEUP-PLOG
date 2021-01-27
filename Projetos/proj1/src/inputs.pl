:-include('utils.pl').
:-use_module(library(system)).

/*----------------------------------- REGULAR INPUT ----------------------------------------*/

%readStartCell(-Row,-Column, +GameState +PlayerColor)
readStartCell(Row, Column, GameState, Color):-
    nl,nl, write('Choose the disc you want to move: '), nl,
    read_number('Column',0,20,ReadColumn),
    read_row(RowNumber),
    (
        (
            validateCellContent(ReadColumn,RowNumber, Color, GameState),
            Row = RowNumber, 
            Column = ReadColumn
        );
        (   
            nl,nl,write('ERROR: Invalid cell.'), nl,
            readStartCell(Row,Column, GameState, Color)
        )
    ).


%readEndCell(-Row,-Column, +GameState)
readEndCell(Row, Column, GameState):-
    nl,nl, write('Choose where you want to place it: '),nl,
    read_number('Column',0,20,ReadColumn),
    read_row(RowNumber),
    write('hereee'),
    (
        (
            validateCellContent(ReadColumn,RowNumber, empty, GameState),
            Row = RowNumber, 
            Column = ReadColumn
        );
        (
            nl,nl,write('ERROR: Invalid cell.'), nl,
            readEndCell(Row,Column, GameState)  
        )
        
    ).


/*----------------------------------------- YELLOWS INPUT ---------------------------------------*/

%readYellowCell(-Row,-Column,+GameState) read row and column to place disc.
readYellowCell(Row, Column, GameState):-
    read_number('Column', 0, 20,ReadColumn),
    read_row(RowNumber),
    (
        (	  
            validateYellowCell(ReadColumn, RowNumber, GameState),
            Row=RowNumber, Column = ReadColumn
        );
        (	    
            nl,nl,write('ERROR: Invalid cell.'), nl,	
            readYellowCell(Row, Column, GameState)  	
        )	
    ).



%readOptionPlacement(-Option,+N) read option to continue or to end yellow disc placement.
readYellowPlacement(Option, N):-
    readYellowMenu(ReadOption),
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
            sleep(1),
            Option = 'c'  
        );
        ( /*invalid input */
            \+ validateOptionP(ReadOption),
            write('ERROR: Invalid option.'), nl,
            readYellowPlacement(Option,N)  
        )
    ).

/*-------------------------------------- MENU ---------------------------------------*/

%readOptionMenu(-Option) read option from main menu
readOptionMenu(Min, Max, Option):-
    read_number('Menu', Min, Max, Option).
    
read_number(Type,LowerBound, UpperBound, Number):-
    (
        (Type == 'Column', format(' > choose a column (~d-~d): ', [LowerBound, UpperBound]));
        (Type == 'Menu', write('> Insert your option: '))
    ),
    read(Number),
    get_char(_),
    Number =< UpperBound, Number >= LowerBound.
    

read_number(Type,LowerBound, UpperBound, Number):-
    write('Error: Not a valid number, try again\n'),
    read_number(Type,LowerBound, UpperBound, Number).

read_row(Number):-
    write(' > choose a row (between '' ''): '),
    read(Letter),
    get_char(_),
    rowNumber(Letter, Number).

read_row(Number):-
    write('Error: Not a valid row, try again\n'),
    read_row( Number).

    
readYellowMenu(Option):-
    write(' > Write c to continue or e to end placement (minimum of 5 yellow discs): '),
    read(Option).

        