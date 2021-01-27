:-include('play.pl').

%starts the menu
start:-
	gameNameDisplay,
	mainMenu.

%displays the main menu and reads the option
mainMenu:-
    printMainMenu,
	readOptionMenu(Option),
	next(Option).

%next(+MenuNumber) changes to the next menu
next(1):-
	play,
	mainMenu.

%changes to the next menu
next(2):-
	get_char(_),
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
	write('           You are NEVER ALOWED to add a disc in such a way that it directly makes a traffic signal'), nl,
	pressEnterToContinue,
	mainMenu.

next(3).

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