%airport(Name, ICAO,Country).

airport('Aeroporto Franscisco Sa Carneiro', 'LPPR', 'Portugal').
airport('Aeroporto Humberto Delgado', 'LPPT', 'Portugal').
airport('Aeroporto Adolfo Suárez Madrid-Barajas', 'LEMD', 'Spain').
airport('Aeroporto de Paris-Charles-de-Gaulle Roissy Airport', 'LFPG', 'France').
airport('Aeroporto Internazionale di Roma-Fiumicino - Leonardo da Vinci', 'LIRF', 'Italy').


%company(ICAO,Name , Year, Country)
company('TAP', 'Tap Air Portugal', 1945, 'Portugal').
company('RYR', 'Ryanair', 1984, 'Ireland').
compamny('AFR', 'Société Air France, S.A', 1933, 'France').
company('BAW', 'British Airways', 1974, 'United Kingdom').


%flight(Designation, Origin , Destination, DepartureTime, Duration, Company)
flight('TP1923', 'LPPR', 'LPPT', 1115, 55, 'TAP').
flight('TP1968', 'LPPT', 'LPPR', 2235, 55, 'TAP').
flight('TP842', 'LPPT', 'LIRF', 1450, 195, 'TAP').
flight('TP843', 'LIRF', 'LPPT', 1935, 195, 'TAP').
flight('FR5483', 'LPPR', 'LEMD', 630, 105, 'RYR').
flight('FR5484', 'LEMD', 'LPPR', 1935, 105, 'RYR').
flight('AF1024', 'LFPG', 'LPPT', 940, 155, 'AFR').
flight('AF1025', 'LPPT', 'LFPG', 1310, 155, 'AFR').

%1h30 = 90min
short(Flight):- 
    flight(Flight, _,_,_,Duration,_),
    Duration < 90.


%shorter(+Flight1, +Flight2,-ShorterFlight)
shorter(Flight1, Flight2, ShorterFlight):-
    flight(Flight1,_,_,_,D1,_),
    flight(Flight2,_,_,_,D2,_),
    D1 < D2,
    ShorterFlight = Flight1.
shorter(Flight1, Flight2, ShorterFlight):-
    flight(Flight1,_,_,_,D1,_),
    flight(Flight2,_,_,_,D2,_),
    D1 > D2,
    ShorterFlight = Flight2.

%arrivalTime(+Flight,-ArrivalTime)
arrivalTime(Flight, ArrivalTime):-
    flight(Flight, _,_, Departure, Duration, _),
    Minutes is Departure mod 100,
    TotalMinutes is Minutes + Duration,
    Min is TotalMinutes mod 60,
    Hours = TotalMinutes // 60,
    ArrivalTime is Departure + Hours*100 - Minutes + Min.

%countries(+Company,-ListOfCountries)
countries(Company, ListOfCountries):-
    auxCountries(Company, [], ListOfCountries).

auxCountries(Company, Aux, ListOfCountries):-
    flight(_,Origin,Destination,_,_,Company),
    airport(_,Origin, Country1),
    airport(_, Destination, Country2),
    addCountries(Country1, Country2, Aux, ListOfCountries),
    write(ListOfCountries),
    fail.

countries(_, ListOfCountries).

addCountries(C1, C2, Aux,ListOfCountries):-
    \+member(C1, Aux),
    append(C1, Aux, L),
    \+member(C2, L),
    append(C2, L, ListOfCountries).

/*
member(_,[]).
member(X,[X|T]).
member(X,[H|T]):-
    member(X, T).
*/
pairableFlights:-
    flight(Id1,Origin, Destination, DepartureTime, Duration,_),
    flight(Id2, Destination, Destination1, DepartureTime1,Duration1,_),
    arrivalTime(Id1, T1),
    subtractF(DepartureTime1, T1, D),
   /* D >= 30,
    D =< 90,*/
    write(Destination), write('-'), write(Id1), write('\\'), write(Id2),nl,fail.

subtractF(DepartureTime1, T1, D):-
    write(DepartureTime1),nl,
    write(T1),nl,
    Aux is DepartureTime1 - T1, 
    write(Aux),nl.


  /*  flight(Flight, _,_, Departure, Duration, _),
    Minutes is Departure mod 100,
    TotalMinutes is Minutes + Duration,
    Min is TotalMinutes mod 60,
    Hours = TotalMinutes // 60,
    ArrivalTime is Departure + Hours*100 - Minutes + Min.*/