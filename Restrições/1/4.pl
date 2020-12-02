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
 S #\= 0, M #\= 0,
 D + E #= Y+ C1*10,
 N + R + C1 #= E+ C2*10,
 E + O + C2 #= N+ C3*10,
 S + M + C3 #= O+ C4*10,
 C4 #= M,
 labeling([ff],Vars).
