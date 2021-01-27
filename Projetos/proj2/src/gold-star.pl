:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(random)).

%star(+Size, +Operators, -Vars, +All, +X, +Y, +Z)
star(Size, Operators, Vars, All, X, Y, Z):-
    S is 2*Size,
    length(Vars , S),
    getNumbersDomain(Size, Domain),
    domain(Vars, 0, Domain),
    all_distinct(Vars),
    fixedRestrictions(Operators, Vars, S),
    growingRestrictions(Operators, Vars, Size),
    !,
    labeling([X,Y,Z], Vars),
    format('~w  ~w ~n',[Operators, Vars]),%write results to file or console
    (
        ((All == 0), !);
        (All == 1)
    ).

%star(+Size, +Operators, -Vars, +AllSolutions)
star(Size, Operators, Vars, All):-
    S is 2*Size,
    length(Vars , S),
    getNumbersDomain(Size, Domain),
    domain(Vars, 0, Domain),
    all_distinct(Vars),
    fixedRestrictions(Operators, Vars, S),
    growingRestrictions(Operators, Vars, Size),
    !,
    labeling([], Vars),
    format('~w  ~w ~n',[Operators, Vars]),%write results to file or console
    (
        ((All == 0), !);
        (All == 1)
    ).

%fixedRestrictions(+Operators, -Vars, +Size)
fixedRestrictions(Operators, Vars, Size):-    
    L1 is Size - 1,
    L2 is Size - 2,
    L3 is Size - 3,
    L4 is Size - 4,
    %operators
    nth0(0,Operators, O1), %operador do AB
    nth0(1, Operators, O2), %operador do BC
    nth0(3, Operators, O3), %operador DE
    nth0(L4, Operators, O4), 
    nth0(L1, Operators, O5), %operador WO4K = XO5A
    nth0(L2, Operators, O6), %operador YX (dois ultimos)

    nth0(0, Vars, A),
    nth0(1, Vars, B),
    nth0(2, Vars, C),
    nth0(3, Vars, D),
    nth0(4, Vars, E),
    nth0(L1, Vars, X),
    nth0(L2, Vars, Y),
    nth0(L3, Vars, K),
    nth0(L4, Vars, W),

    restrictions(A, O1, B, D, O3, E),
    restrictions(Y, O6, X, B, O2, C),
    restrictions(W, O4, K, X, O5, A).

%growingRestrictions(+Operators, -Vars, +Size)
growingRestrictions(_,_,3). %3 is the base case 

growingRestrictions(Operators, Vars, Size):-
    VarIndex = 2,
    growingRestrictionsAux(Operators, Vars, Size, VarIndex, 2, 5).

%growingRestrictionsAux(+Operators, -Vars, +Size, +VarIndex, +IOpIndex, +FOpIndex)
growingRestrictionsAux(Operators, Vars, Size, VarIndex, IOpIndex, FOpIndex):- %last case
    Aux is Size * 2, %number of operators
    A is Aux - 3,
    FOpIndex == A,
    applyRestriction(Operators, Vars, VarIndex, IOpIndex, FOpIndex).  

growingRestrictionsAux(Operators, Vars, Size, VarIndex, IOpIndex, FOpIndex):- %generic case
    applyRestriction(Operators, Vars, VarIndex, IOpIndex, FOpIndex),
    VarIndex1 is VarIndex + 2,  
    IOpIndex1 is IOpIndex + 2,
    FOpIndex1 is FOpIndex + 2,
    growingRestrictionsAux(Operators, Vars, Size, VarIndex1, IOpIndex1, FOpIndex1).

%applyRestriction(+Operators, -Vars, +VarIndex, +IOpIndex, +FOpIndex)
applyRestriction(Operators, Vars, VarIndex, IOpIndex, FOpIndex):-
    I1 is VarIndex + 4,
    I2 is VarIndex + 3,
    I3 is VarIndex + 1,
    nth0(I1, Vars, A), %we go descending way because we go from left to right
    nth0(I2, Vars, B),
    nth0(I3, Vars, C),% we skip one because between each equation there is a tip and the operands go around the star
    nth0(VarIndex, Vars, D),
    nth0(IOpIndex, Operators, O1),
    nth0(FOpIndex, Operators, O2),
    restrictions(A, O2, B, C, O1, D).


/*Equations will always be like (N Op N = N Op N)*/
%restrictions(+N1,+Op1,+N2, +N3,+Op2, +N4)
restrictions(N1, Op1, N2, N3, Op2, N4):-
    restrict(N1, Op1, N2, Value),
    restrict(N3, Op2, N4, Value).
    
restrict(N1, +, N2, Value):-
    N1 + N2 #= Value.

restrict(N1, -, N2, Value):-
    N1 - N2 #= Value.

restrict(N1, *, N2, Value):-
    N1 * N2 #= Value.

restrict(N1, /, N2, Value):-
    N1 #= Value * N2 .

%cehck(+Op, +List)
check(_, []).
check(Op, [Head | Tail]) :-
    Op #>= Head,
    check(Op, Tail).

%getNoOperators(+Size, -N)
getNoOperators(Size, N):-
    N is 2 * Size.

%generate operators with no restrictions
%getOperatorsNoRestrictions(-Operators, +Size)
getOperatorsNoRestrictions(Operators, Size):-
    getNoOperators(Size, N),
    length(Operators, N),
    domain(Operators, 1, 4),
    labeling([], Operators).

getOperatorsRestricted(Size,_, X, Y, Z):-
    getNoOperators(Size, N),
    length(Operators, N),
    domain(Operators, 1, 4),
    element(1, Operators, Op1),
    check(Op1, Operators),
    labeling([X,Y,Z], Operators),
    write(Operators),nl,
    fail.

%generate operators with check restriction
%getOperatorsRestricted(-Operators, +Size)
getOperatorsRestricted(Operators, Size):-
    getNoOperators(Size, N),
    length(Operators, N),
    domain(Operators, 1, 4),
    element(1, Operators, Op1),
    check(Op1, Operators),
    labeling([], Operators).

%generate random operators
%getOperatorsRandom(-Operators, +Size)
getOperatorsRandom([],0).
getOperatorsRandom([Op|Operators],Size):-
    Size > 0, 
    S is Size - 1,
    random(1,4,Op),
    getOperatorsRandom(Operators, S).

%getNumbersDomain(+Size, -Domain)
getNumbersDomain(Size, Domain):-
    Domain is 2 * Size - 1.

%numberOperatorsToSignals(+Numbers, -Signals)
numberOperatorsToSignals([],[]).
numberOperatorsToSignals([H|T], [Head|Tail]):-
    numberToSignal(H, Head),
    numberOperatorsToSignals(T, Tail).


%numberToSignal(+Number, -Signal)
numberToSignal(1, +).
numberToSignal(2, -).
numberToSignal(3, *).
numberToSignal(4, /).


test:-
    getOperatorsRestricted(Operators, 5),
    write(Operators),nl,
    fail.







