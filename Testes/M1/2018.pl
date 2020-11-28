:-use_module(library(lists)).

%airport(Name, ICAO,Country).

airport('Aeroporto Franscisco Sa Carneiro', 'LPPR', 'Portugal').
airport('Aeroporto Humberto Delgado', 'LPPT', 'Portugal').
airport('Aeroporto Adolfo Suárez Madrid-Barajas', 'LEMD', 'Spain').
airport('Aeroporto de Paris-Charles-de-Gaulle Roissy Airport', 'LFPG', 'France').
airport('Aeroporto Internazionale di Roma-Fiumicino - Leonardo da Vinci', 'LIRF', 'Italy').


%company(ICAO,Name , Year, Country)
company('TAP', 'Tap Air Portugal', 1945, 'Portugal').
company('RYR', 'Ryanair', 1984, 'Ireland').
company('AFR', 'Société Air France, S.A', 1933, 'France').
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
    timeToMins(Departure,Dmin),
    AMins is Dmin + Duration,
    minsToTime(AMins,ArrivalTime).

timeToMins(Time, Mins):-
    Hours is Time // 100,
    HMinutes is Hours*60,
    Minutes is Time mod 100,
    Mins is HMinutes+Minutes.

minsToTime(Mins, Time):-
    Hours is Mins // 60,
    Minutes is Mins mod 60,
    Time is Hours*100+Minutes.

%countries(+Company,-ListOfCountries)
memberOf(_,[]):-fail.
memberOf(Element, [Element | _]).
memberOf(Element, [_| Rest]) :- memberOf(Element, Rest).

operates(Company, Country) :-
    company(Company, _, _, _),
    flight(_, ICAO, _, _, _, Company),
    airport(_, ICAO, Country).

operates(Company, Country) :-
    company(Company, _, _, _),
    flight(_, _, ICAO, _, _, Company),
    airport(_, ICAO, Country).

countries(Company, ListOfCountries) :-
    countries(Company, [], ListOfCountries), !.

countries(Company, Acc, ListOfCountries) :-
    operates(Company, Country),
    \+memberOf(Country, Acc),
    append(Acc, [Country], NewAcc),
    countries(Company, NewAcc, ListOfCountries).

countries(_, ListOfCountries, ListOfCountries).


pairableFlights:-
    flight(Id1,Origin, Destination, DepartureTime, Duration,_),
    flight(Id2, Destination, Destination1, DepartureTime1,Duration1,_),
    arrivalTime(Id1, T1),
    subtractF(DepartureTime1, T1, D),
    timeToMins(DepartureTime1,DepMins),
    timeToMins(T1,AMins),
    D is DepMins-AMins,
    D >= 30,
    D =< 90,
    write(Destination), write('-'), write(Id1), write('\\'), write(Id2),nl,
    fail.

pairableFlights.


%6. tripDays(+Trip, +Time, -FlightTimes,-Days)
tripDays(Trip, Time, FlightTimes, Days) :-
    tripDays(Trip, Time, [], FlightTimes, 1, Days).

tripDays([_ | []], _, FlightTimes, FlightTimes, Days, Days).

tripDays([Country, Destination | Rest], Time, Acc, FlightTimes, DaysAcc, Days) :-
    flight(Flight, Origin, Destin, DepartureTime, _, _),
    airport(_, Origin, Country),
    airport(_, Destin, Destination),
    timeToMinutes(DepartureTime, DepartureMin),
    timeToMinutes(Time, TimeMin),
    (
        DepartureMin < TimeMin + 30,
        NewDaysAcc is DaysAcc + 1
        ;
        NewDaysAcc = DaysAcc
    ),
    arrivalTime(Flight, ArrivalTime),
    append(Acc, [DepartureTime], NewAcc),
    tripDays([Destination | Rest], ArrivalTime, NewAcc, FlightTimes, NewDaysAcc, Days).






%7. avgFlightLengthFromAirport(+Airport, -AvgLength)
avgFlightLengthFromAirport(Airport, AvgLength):-
    findall(Dur, flight(_,Airport, _,_,Dur,_), Durations),
    length(Durations, N),
    sumlist(Durations, Acc),
    AvgLength is Acc/N.

    


%8. mostInternational(-ListOfCompanies)
mostInternational(ListOfCompanies) :-
    setof(Count,(company(C, _, _, _),countries(C, CompanyCountries),length(CompanyCountries, Count)),Counts), 
    max_member(MaxCount, Counts),    
    findall(Company,(company(Company, _, _, _),countries(Company, Countries),length(Countries, MaxCount)),ListOfCompanies),
    !.

%9 make_pairs(+L, +P, -S) 
make_pairs(L,P,[X-Y|Zs]):-
    select(X, L, L2),
    select(Y, L2, L3),
    G=..[P,X,Y],G,
    make_pairs(L3,P,Zs).

make_pairs([],_,[]).

dif_max_2(X,Y):-
    X < Y,
    X >= Y - 2.

%10 make_pairs(+L, +P, -S) -->  not done    
make_pairs2(L, P, R) :-
    make_pairs(L, P, [], R).

make_pairs([], _, [], _) :-
    !, fail.
make_pairs([], _, R, R).
make_pairs(L, P, CP, R) :-
    select(X, L, NL), !,
    (
        (
            find_pair(X, P, NL, Y),
            append(CP, [X-Y], NP),
            select(Y, NL, NNL),
            make_pairs(NNL, P, NP, R)
        );
        (
            make_pairs(NL, P, CP, R)
        )
    ).
    
find_pair(_, _, [], _) :-
    fail.

find_pair(X, P, [Y|Z], R) :-
    G =.. [P, X, Y],
    (
        (
            G,
            R is Y
        );
        (
            \+ G,
            find_pair(X, P, Z, R)
        )
    ).

%11 make_max_pairs(+L, +P, -S)--> not done


%12 whitoff(+N,-W) --> not done

