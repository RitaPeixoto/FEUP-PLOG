:-use_module(library(random)).

%choose_move(+GameState, [WhichPlayer, Player], +Level, -Move) 
%chooses the move to be done by the computer, depending on the difficulty level
choose_move(GameState, [WhichPlay,Player], 1, Move):-
    getColor(WhichPlay, Player, PlayerColor),
    valid_moves(GameState, PlayerColor, ListOfMoves),
    finalAllMoves(ListOfMoves,AllMoves),
    getAllBoards(WhichPlay, Player, GameState, AllMoves, AllBoards),
    length(AllBoards, L),
    (
        (
            L \= 0,
            random(0, L, Random),
            nth0(Random,AllMoves, Move)
        );
        (
            L == 0, Move = 0
        )
    ).

choose_move(GameState, [WhichPlay,Player], 2, Move):-
    getColor(WhichPlay, Player, PlayerColor),
    valid_moves(GameState, PlayerColor, ListOfMoves),
    finalAllMoves(ListOfMoves,AllMoves),
    getAllBoards(WhichPlay, Player, GameState, AllMoves, AllBoards),
    length(AllBoards, L),
    (
        (L == 0, Move = 0);
        (
            getHeadandTail2(GameState, _, T),
            N is Player-1,
            nth0(N, T, P),
            getBoardValues(AllBoards,P,Values),
            max_list(Values, M),
            nth0(X, Values,M),
            nth0(X, AllMoves, Move)
        )
    ).

%choose_add(+GameState,+Player,-Add)
%chooses a random cell for the computer to place a disc
choose_add(GameState, Player, Add):-
    valid_adds(GameState, Player, ValidAddings),
    length(ValidAddings, L),
    (
        (
            getPlayerDiscs(GameState, Player, NDiscs),
            NDiscs == 0,
            Add = 0
        );
        (
            L > 0,
            random(0, L, Random),
            nth0(Random,ValidAddings, Add)
        )
    ).

choose_add(_, _, 0).

%finalAllMoves(+ListOfMoves, -Moves)
%receives a list of moves and returns a list with every possible move in format [Initial Cell, Final Cell]
finalAllMoves(ListOfMoves, Moves):-
    allMoves(ListOfMoves, AllMoves),
    flat(AllMoves,Moves).

%allMoves(+ListOfMoves, -AllMoves)
allMoves([],[]).
allMoves([H|T], [Moves|AllMoves]):-
    allDiscMoves(H, Moves),
    allMoves(T,AllMoves).

%allDiscMoves(+ListOfMove, -Moves)
%receives a list where the head is the initial cell and tail is every end cell
%returns a list containing moves (pairs)
allDiscMoves([H|T], Moves):-
    getAllEndCells(H, T, Moves).


%getAllEndCells(+,+, -EndCells)
%joins Head (initial Cell) to every cell on tail (End Cells)
%returns a list of moves (pairs)
getAllEndCells(_, [], []).
getAllEndCells(Head, [H|T], [A|B]):-
    reverse(Head, Head1),
    reverse(H,H1),
    appendT(Head1, [H1], L1),
    append(L1, [], A),
    getAllEndCells(Head, T, B).

%getAllBoards(+GameState,+Moves,-AllBoards)
%returns the boards after aplying each move to the current gamestate
getAllBoards(_, _, _ , [], []).
getAllBoards(WhichPlay, Player, GameState, [H|T], [A|B]):-
    movingDiscs(WhichPlay, Player, GameState, H, NewGameState),
    A = NewGameState,
    getAllBoards(WhichPlay, Player, GameState, T, B).

%getBoardValues(+AllBoards, +Player, -BoardValues)
%returns a list of the value of each board on allboards
getBoardValues([],_, []).
getBoardValues([H|T], Player, [Value|RestValues]):-
    value(H, Player, Value),
    getBoardValues(T, Player,RestValues).

%value(+GameState, +Player, -Value) 
% evaluates the state of the game
value([_|T], Player, Value):-
    getHeadandTail(T, Player1, Player2),
    getPlayerContent(Player, 0, Id),
    (
        (Id == 1, NewPlayer = Player1);
        (Id == 2, NewPlayer = Player2)
    ),
    getPlayerContent(Player,2,NdiscI),
    getPlayerContent(NewPlayer,2,NdiscF),
    (
        (NdiscF > NdiscI, Value = 1);
        ( Value = 0)
    ).
    
