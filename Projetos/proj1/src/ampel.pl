:-include('gamePlays.pl').

%starts the menu
play:-
	gameNameDisplay,
	mainMenu.

%displays the main menu and reads the option
mainMenu:-
    printMainMenu,
	readOptionMenu(1,3,Option),
	next(Option).

%next(+MenuNumber) changes to the next menu
next(1):-
	playerTypeMenu(Mode),
	(
		(Mode == 1, getMode(Mode, PMode),start(PMode, _));
		(Mode == 4, mainMenu);
		(Mode == 5, next(3));
		(
			getMode(Mode,PMode),
			levelMenu(Level),
			(
				(Level == 3, next(1));
				(Level == 4, next(3));
				(start(PMode, Level),nl,nl,pressEnterToContinue, mainMenu)
			)	
		)
	).

%changes to the next menu
next(2):-
	clearScreen,
	write(' ___ _  _ ___ _____ ___ _   _  ___ _____ ___ ___  _  _ ___ '),nl,
	write('|_ _| \\| / __|_   _| _ \\ | | |/ __|_   _|_ _/ _ \\| \\| / __|'),nl,
	write(' | |  .` \\__ \\ | | |   / |_| | (__  | |  | | (_) | .` \\__ \\ '),nl,
	write('|___|_|\\_|___/ |_| |_|_\\\\___/ \\___| |_| |___\\___/|_|\\_|___/'),nl,nl,
	write('**MATERIALS**        '), nl,
	write('    A triangular board with 66 connected points'), nl,
	write('    20 red discs (R) and 20 green discs (G)'), nl,
	write('    10 yellow discs (Y)'), nl,
	write('    1 red cylinder (W, represents the red disc with the cylinder) and 1 green cylinder((Z, represents the green disc with the cylinder))'), nl,
	write('                            '), nl,
	write('**RULES**                   '), nl,
	write('   1. Each player selects a color'), nl,
	write('                            '), nl,
	write('   2. Until there are AT LEAST 5 yellow discs on the board (MAX 10), the players take turns'), nl,
	write('adding a disc to an empty point NOT INCLUDING the edges or corners'), nl,
	write('                            '), nl,
	write('   3. On your turn, you must perform the following steps in order:'), nl,
	write('         - Move one of your discs if possible'), nl,
	write('         - Move one of your opponents disc if possible. You cannot move discs with cylinders in it.'), nl,
	write('         - Add one of your discs to an empty point, and put your cylinder on it'),nl,
	write('           If you had no discs to place, take your cylinder off the board'),nl,
	write('           You are NEVER ALOWED to add a disc in such a way that it directly makes a traffic signal'), nl,nl,
	pressEnterToContinue,
	mainMenu.

next(3):-
	clearScreen,nl,
	write('Thank you, hoping you enjoyed the game!'),nl,nl,nl.

%Prints the name and the authors, waiting for an enter to go to the main menu
gameNameDisplay:-
	clearScreen,
	write('     _    __  __ ____  _____ _     '), nl,
	write('    / \\  |  \\/  |  _ \\| ____| |    '), nl,
	write('   / _ \\ | |\\/| | |_) |  _| | |    '), nl,
	write('  / ___ \\| |  | |  __/| |___| |___ '), nl,
	write(' /_/   \\_\\_|  |_|_|   |_____|_____|'), nl,
	write('                                   '), nl,
	write('           Rita Peixoto            '), nl,
	write('         Filipe Recharte           '), nl,nl,
	pressEnterToContinue.



%Main menu display
printMainMenu :- 
	clearScreen,
	write('=================================='), nl,
	write('=           :: Ampel ::          ='), nl,
	write('=================================='), nl,
	write('=                                ='), nl,
	write('=   1. Play                      ='), nl,
	write('=   2. Instructions              ='), nl,
	write('=   3. Exit                      ='), nl,
	write('=                                ='), nl,
	write('=================================='), nl.


levelMenu(Op):-
	clearScreen,
	write('=================================='), nl,
	write('=           :: Ampel ::          ='), nl,
	write('=================================='), nl,
	write('=                                ='), nl,
	write('= Choose the difficulty level:   ='), nl,
	write('=                                ='), nl,
	write('=   1. Easy (Random)             ='), nl,
	write('=   2. Medium  (Greedy)          ='), nl,
	write('=   3. Previous Menu             ='), nl,
	write('=   4. Exit                      ='), nl,
	write('=                                ='), nl,
	write('=================================='), nl,
	readOptionMenu(1,4,Op).



playerTypeMenu(Op):-
	clearScreen,
	write('=================================='), nl,
	write('=           :: Ampel ::          ='), nl,
	write('=================================='), nl,
	write('=                                ='), nl,
	write('= Choose the player types:       ='), nl,
	write('=                                ='), nl,
	write('=   1. Player vs Player          ='), nl,
	write('=   2. Player vs Computer        ='), nl,
	write('=   3. Computer vs Computer      ='), nl,
	write('=   4. Previous Menu             ='), nl,
	write('=   5. Exit                      ='), nl,
	write('=                                ='), nl,
	write('=================================='), nl,
	readOptionMenu(1,6,Op).