:-compile('gold-star.pl').

/*prolog:set_current_directory('/home/filipe/Documents/FEUP/PLOG-Proj/proj2').*/

/*One solution for one set of operators*/
%getASolution(+Size, +Restricted)
getASolution(Size, 0):-
    %generate operators
    getOperatorsNoRestrictions(Ops, Size),
    %translate them into symbols
    numberOperatorsToSignals(Ops, Operators),
    %call star  
    star(Size, Operators, Vars, 0),
    print_solution(Operators, Vars).

getASolution(Size, 1):-
    getOperatorsRestricted(Ops, Size),
    numberOperatorsToSignals(Ops, Operators),  
    star(Size, Operators, Vars, 0),
    print_solution(Operators, Vars).


/*All solutions for each set of operators*/
%getAllSolutions(+Size, +Restricted)
getAllSolutions(Size, 1):- %restricted
    getOperatorsRestricted(Ops, Size),
    numberOperatorsToSignals(Ops, Operators),
    star(Size, Operators, Vars, 1),fail.

/*for heuristics*/
%getAllSolutions(+Size, +Restricted, , , )
getAllSolutions(Size, 1, X, Y, Z):- %restricted
    getOperatorsRestricted(Ops, Size),
    numberOperatorsToSignals(Ops, Operators),
    star(Size, Operators, Vars, 1, X, Y, Z),fail.

getAllSolutions(Size, 0):- %unrestricted
    getOperatorsNoRestrictions(Ops, Size),
    numberOperatorsToSignals(Ops, Operators),
    star(Size, Operators, Vars, 1),fail.

/*One solution for a random configuration*/
%getRandomSolutions(+Size, +Restricted)
getRandomSolutions(Size,Restricted):-
    repeat,
    OpsSize is Size*2,
    getOperatorsRandom(Ops, OpsSize),
    numberOperatorsToSignals(Ops,Operators),
    star(Size, Operators, Vars, 0),
    print_solution(Operators, Vars).


/*One solution for each set of opertators*/
%getConfigurationSolutions(+Size, +Restricted)
getConfigurationSolutions(Size, 0):-
    getOperatorsNoRestrictions(Ops, Size),
    %translate them into symbols
    numberOperatorsToSignals(Ops, Operators),
    %call star  
    star(Size, Operators, Vars, 0),fail.

getConfigurationSolutions(Size, 1):-
    getOperatorsRestricted(Ops, Size),
    %translate them into symbols
    numberOperatorsToSignals(Ops, Operators),
    %call star  
    star(Size, Operators, Vars, 0),fail.

save_heuristics_ops:-
    left(X),
    middle(Y),
    right(Z),
    get_filename_ops(5, X, Y, Z, FileName),
    format('~w ~w ~w\n', [X, Y, Z]),
    save(getOperatorsRestricted,FileName,5,_,X,Y,Z),
    fail.

save_heuristics:-
    left(X),
    middle(Y),
    right(Z),
    get_filename(5,1,1,X,Y,Z,Filename),
    save(getAllSolutions,Filename,5,1,X,Y,Z),
    fail.

save(Predicate, File, Size, Restricted, X, Y, Z):-
    P =..[Predicate,Size,Restricted,X,Y,Z],
    open(File, write, Stream),
    current_output(COutput),
    set_output(Stream),
    statistics(walltime, [TimeSinceStart | [TimeSinceLastCall]]),
    ( P ; true ),
    statistics(walltime, [NewTimeSinceStart | [ExecutionTime]]),
    write('Execution took '), write(ExecutionTime), write(' ms.'),
    format('~w ~w ~w\n', [X, Y, Z]),
    close(Stream),
    set_output(COutput),
    write('Finished writing to file\n'),
    write('Execution took '), write(ExecutionTime), write(' ms.').

save(Predicate, File, Size, Restricted):-
    P =..[Predicate,Size,Restricted],
    open(File, write, Stream),
    current_output(COutput),
    set_output(Stream),
    statistics(walltime, [TimeSinceStart | [TimeSinceLastCall]]),
    ( P ; true ),
    statistics(walltime, [NewTimeSinceStart | [ExecutionTime]]),
    write('Execution took '), write(ExecutionTime), write(' ms.'),
    close(Stream),
    set_output(COutput),
    write('Finished writing to file\n'),
    write('Execution took '), write(ExecutionTime), write(' ms.').

print_solution(Operators, Vars):-
    format('Operators: ~w  Digits: ~w ~n',[Operators, Vars]).

run_star(Predicate, Size, Restricted):-
    P =..[Predicate,Size,Restricted],
    (P;true).

get_filename(Tips, Restricted, All, X, Y, Z, FileName):-
    number_chars(Tips, TempVar),
    atom_chars(TipsString, TempVar),
    restricted_string(Restricted, ResString),
    solutions(All, CutString),
    atom_concat(TipsString, '_tips_', Temp),
    atom_concat(Temp, ResString, Temp2),
    atom_concat(Temp2, CutString, Temp3),
    atom_concat(Temp3, '_', Temp4),
    atom_concat(Temp4, X, Temp5),
    atom_concat(Temp5, '_', Temp6),
    atom_concat(Temp6, Y, Temp7),
    atom_concat(Temp7, '_', Temp8),
    atom_concat(Temp8, Z, Temp9),
    atom_concat(Temp9, '.txt', FileName).

get_filename_ops(Tips, X, Y, Z, FileName):-
    number_chars(Tips, TempVar),
    atom_chars(TipsString, TempVar),
    atom_concat(TipsString, '_tips_ops_', Temp4),
    atom_concat(Temp4, X, Temp5),
    atom_concat(Temp5, '_', Temp6),
    atom_concat(Temp6, Y, Temp7),
    atom_concat(Temp7, '_', Temp8),
    atom_concat(Temp8, Z, Temp9),
    atom_concat(Temp9, '.txt', FileName).

restricted_string(1, 'restricted_').
solutions(1, 'all_solutions').

left(leftmost).
left(min).
left(max).
left(ff).
left(anti_first_fail).
left(occurrence).
left(ffc).
left(max_regret).
middle(step).
middle(enum).
middle(bisect).
middle(median).
middle(middle).
right(up).
right(down).

%getListElements(+List, +Elements)
getListElements(List, [E1,E2,E3,E4,E5,E6,E7,E8,E9,E10]):-
    nth0(0, List, E1),
    nth0(1, List, E2),
    nth0(2, List, E3),
    nth0(3, List, E4),
    nth0(4, List, E5),
    nth0(5, List, E6),
    nth0(6, List, E7),
    nth0(7, List, E8),
    nth0(8, List, E9),
    nth0(9, List, E10).

%print_gold_star(+NumbersList,+OperatorsList)
print_gold_star(NumbersList,OperatorsList):-
    getListElements(NumbersList, [N1,N2,N3,N4,N5,N6,N7,N8,N9,N10]),
    getListElements(OperatorsList, [O1,O2,O3,O4,O5,O6,O7,O8,O9,O10]),
    write('                          '),nl,
    format('               ~d            ', [N1]),nl,
    write('                          '),nl,
    write('                          '),nl,
    format('            ~w     ~w          ', [O10,O1]),nl,
    write('                          '),nl,
    write('                          '),nl,
    format('~d    ~w    ~d    =    ~d    ~w    ~d', [N9, O9, N10, N2, O2, N3]),nl,
    write('                          '),nl,
    write('                          '),nl,
    format('    ~w    =            =    ~w     ', [O8,O3]),nl,
    write('                          '),nl,
    format('       ~d                ~d        ', [N8,N4]),nl,
    write('                          '),nl,
    write('          =          =         '),nl,
    format('               ~d            ', [N6]),nl,
    format('    ~w                       ~w', [O7,O4]),nl,
    format('       ~w                ~w ', [O6,O5]),nl,
    write('                          '),nl,
    format('  ~d                          ~d', [N7,N5]),nl,
    write('                          ').
