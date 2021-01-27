:-include('utils.pl').
:-include('inputs.pl').

%placeYellowDisc(+NumberOfPlacedDiscs,+NumberOfMaximumDiscs), there must be placed at least 5 yellow discs and a maximum of 10 discs
placeYellowDisc(GameState, N1, N2, NewGameState):-
    write('Lets start by placing the yellow discs, you cannot place it on edges or corners'), 
    nl,nl,
    pressEnterToContinue,
    changeTurn(GameState, N1, N2,'c', 1, NewGameState).

%changeTurn(+GameState, +N1, +N2, +Option, +_Player, -NewGameState) ends yellow disc placement
changeTurn(GameState, N1, N2, Option, _Player, NewGameState):-
    (
        (
            N1 = N2
        );
        (
            Option = 'e'
        )
    ),
    NewGameState = GameState.

%changeTurn(+GameState, +N1, +N2, +Option, +_Player, -NewGameState) executes player turn to place yellow disc
changeTurn(GameState, N1, N2, Option, Player, NewGameState):- 
    clearScreen,
    N1 < N2,
    Option \= 'e',
    format('Player ~d ~n',[Player]),nl,
    readOptionPlacement(ReadOption, N1),
    (
        (
            ReadOption = 'e',
            changeTurn(GameState, N1, N2, 'e', _Player, NewGameState)
        );
        (
            ReadOption = 'c',
            playerPlaces(GameState, yellow, ActualGameState),

            nextPlayer(Player,NextPlayer),
            N is N1+1,

            changeTurn(ActualGameState, N, N2, ReadOption, NextPlayer, NewGameState)
        )
    ).
    
