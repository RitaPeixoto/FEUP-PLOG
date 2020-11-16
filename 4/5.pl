

/*disponibilidade(nome, lista_dias_disponíveis). 

disp(primeiro_dia, último_dia). */

disponibilidade(pedro, [disp(2,4), disp(12,20), disp(25,28)]).


getPeopleAvailable(Day, Names):-
    disponibilidade(Person, AvailableDays),
    isAvailableAtDay(Day, AvailableDays)
    append(Person , Names,)



isAvailableAtDay(Day, [H|T]):-
    H is disp(X, Y),
    hasDay(Day, X, Y).

isAvailableAtDay(Day, [H|T]):-
    isAvailableAtDay(Day, T)


hasDay(Day, X,Y):-
    X =< Day, 
    Y >= Day.
    
