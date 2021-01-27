%initialBoard
initialBoard([
    [tab, tab, tab, tab, tab, tab, tab, tab, tab, tab, empty, tab, tab, tab, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, tab, tab, tab, empty, tab, empty, tab, tab, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, tab, tab, empty, tab, empty, tab, empty, tab, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab, tab, tab],
    [tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab, tab],
    [tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab],
    [tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab],
    [empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty]
]).


%intermediateBoard
intermediateBoard([
    [tab, tab, tab, tab, tab, tab, tab, tab, tab, tab, empty, tab, tab, tab, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, tab, tab, tab, empty, tab, empty, tab, tab, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, tab, tab, empty, tab, green, tab, empty, tab, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, gcyl, tab, empty, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, empty, tab, yellow, tab, empty, tab, empty, tab, empty, tab, red, tab, empty, tab, tab, tab, tab],
    [tab, tab, tab, empty, tab, yellow, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab, tab],
    [tab, tab, empty, tab, yellow, tab, red, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab],
    [tab, empty, tab, yellow, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab],
    [empty, tab, yellow, tab, empty, tab, empty, tab, empty, tab, rcyl, tab, empty, tab, empty, tab, empty, tab, green, tab, empty]
]).

%finalBoard
finalBoard([
    [tab, tab, tab, tab, tab, tab, tab, tab, tab, tab, empty, tab, tab, tab, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, tab, tab, tab, empty, tab, empty, tab, tab, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, tab, tab, empty, tab, green, tab, empty, tab, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, gcyl, tab, empty, tab, tab, tab, tab, tab],
    [tab, tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, red, tab, empty, tab, tab, tab, tab],
    [tab, tab, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab, tab],
    [tab, tab, empty, tab, empty, tab, red, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, tab],
    [tab, empty, tab, yellow, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab, empty, tab],
    [empty, tab, yellow, tab, empty, tab, empty, tab, empty, tab, rcyl, tab, empty, tab, empty, tab, empty, tab, green, tab, empty]
]).

%symbol(+BoardSymbol, -RealSymbol) puts in RealSymbol the corresponding symbol to the BoardSymbol
symbol(tab, '.').
symbol(empty, 'E').
symbol(red, 'R').
symbol(green, 'G').
symbol(gcyl, 'Z').
symbol(rcyl, 'W').
symbol(yellow, 'Y').

%letter(+N, -L) puts in L the identifier L that corresponds to N
letter(0, L) :- L='A'.
letter(1, L) :- L='B'.
letter(2, L) :- L='C'.
letter(3, L) :- L='D'.
letter(4, L) :- L='E'.
letter(5, L) :- L='F'.
letter(6, L) :- L='G'.
letter(7, L) :- L='H'.
letter(8, L) :- L='I'.
letter(9, L) :- L='J'.
letter(10, L) :- L='K'.

%display_game(+GameState, +Player) displays the game in the state GameState
display_game(Gamestate, _Player):-
    printBoard(Gamestate).

%printBoard(+GameState) prints the board
printBoard(Gamestate):-
    nl,
    write('\n|---| 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10| 11| 12| 13| 14| 15| 16| 17| 18| 19| 20|---|\n'),
    write('|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n'),
    printLines(Gamestate, 0).


%printLines(List, N) prints each Line with the corresponding line identifier N
printLines([],_).
printLines([Head|Tail], N) :-
    letter(N,L),
    write('| '),
    write(L),
    write(' | '),
    printLine(Head),
    N1 is N+1,
    printLines(Tail,N1).


%printLine(+List), prints the line that corresponds to the list sent as argument
printLine([]):-
    write('. |'),
    nl,
    write('|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n').
printLine([Head|Tail]):-
    printCell(Head),
    printLine(Tail).


%printCell(+Cell), prints the content corresponding to the symbol cell
printCell(Cell):-
    symbol(Cell,Symb),
    write(Symb),
    write(' |'),
    write(' ').




%player([id, discs color, nYellowDiscs, cylinderCollumn, cylinderRow, nDiscs])
player([1, _, 0, _, _, 10]).
player([2, _, 0, _, _, 10]).


%List with lists that represent edges and corners, places where a yellow disc cannot be placed, each list corresponds to the row and collumn of that cell
outsiders([[0,10],[1,9],[1,11],[2,8],[2,12],[3,7],[3,13],[4,6],[4,14],[5,5],[5,15],[6,4],[6,16],[7,3],[7,17],[8,2],[8,18],[9,1],[9,19],[10,0],[10,20]]). 

%yellow(N), saves in N the number of yellow Discs placed in the set up stage of the game
yellow(0).
