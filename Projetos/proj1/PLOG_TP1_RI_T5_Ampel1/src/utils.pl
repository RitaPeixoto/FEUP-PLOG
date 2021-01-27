:- use_module(library(lists)).

%cleans screen
clearScreen:-write('\e[2J').

pressEnterToContinue:-
	write('Press <Enter> to continue.'),
	waitForEnter, !.

waitForEnter:-
	get_char(_).

%nextPlayer(+Player, -NextPlayer) returns next player
nextPlayer(Player,NextPlayer):-
  NextPlayer is (Player mod 2 + 1).

%replaceCell(+[L|Ls] , +0 , +Column , +Value , +[R|Ls]) base case: we found the line to change
replaceCell([L|Ls] , 0 , Column , Value , [R|Ls]) :-
  replace_column(Column, L,  Value, R).

%replaceCell(+[L|Ls] , +Line , +Column , +Value , +[R|Ls]) find the line to change
replaceCell( [L|Ls] , Line , Column , Value , [L|Rs] ) :-
  Line > 0 ,
  Line1 is Line-1 ,
  replaceCell( Ls , Line1 , Column , Value , Rs ).

%getCellContent(+SelColumn, +SelRow, -Content, +GameState) returns the content of a line
getCellContent(SelColumn, SelRow, Content, GameState) :-
    nth0(SelRow, GameState, BoardRow),
    nth0(SelColumn, BoardRow, Content).

%replace_column(Index, List, Value, ResultList) replaces the column index of the line found in replaceCell
replace_column(Index, List, Value, ResultList) :-
    nth0(Index, List, _, X),
    nth0(Index, ResultList, Value, X).