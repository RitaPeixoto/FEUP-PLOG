:- use_module(library(clpfd)).

/*O Problema dos CRIPTOGRAMAS consiste em atribuir dígitos decimais às letras, de modo a que a
respectiva soma seja válida. Ex:
a) puzzle(3,[0,S,E,N,D],[0,M,O,R,E],[M,O,N,E,Y]).
b) puzzle(1,[D,O,N,A,L,D],[G,E,R,A,L,D],[R,O,B,E,R,T]).
c) puzzle(2,[0,C,R,O,S,S],[0,R,O,A,D,S],[D,A,N,G,E,R]).

Falta resolver para casos genericos
*/


send(Vars):-
 Vars=[S,E,N,D,M,O,R,Y],
 domain(Vars,0,9),
 domain([C1,C2,C3,C4],0,1),
 all_distinct(Vars),
 % first letters cannot be 0
 S #\= 0, M #\= 0,
 % normal sum (SEND + MORE = MONEY), column by column
 D + E #= Y+ C1*10,
 N + R + C1 #= E+ C2*10,
 E + O + C2 #= N+ C3*10,
 S + M + C3 #= O+ C4*10,
 C4 #= M,
 labeling([ff],Vars).


/* less efficient
send(Vars):-
    Vars = [S, E, N, D, M, O, R, Y],
    % numbers are decimal
    domain(Vars, 0, 9),
    % no letter can have the same number
    all_different(Vars),
    % first letters cannot be 0
    S #\= 0, M #\= 0,
    % normal sum (SEND + MORE = MONEY)
    S*1000 + E*100 + N*10 + D + M*1000 + O*100 + R*10 + E #= M*10000 + O*1000 + N*100 + E*10 + Y,
    % find solutions
    labeling([],Vars).





*/