:-use_module(library(clpfd)).
/* Este problema
consiste em colocar, num tabuleiro com NxN casa, N rainhas (de xadrez), sem que nenhuma rainha
ataque uma outra rainha posicionada no tabuleiro (isto é, na horizontal, vertical ou diagonal)*/

 
%a versao 4x4
nqueens(Cols):-
 Cols = [A1,A2,A3,A4],
 domain(Cols,1,4),
 all_distinct(Cols), % A1#\=A2, A1#\A3, A1#\A4, A2#\A3, A2#\A4, A3#\A4,
 % check first Row
 A1#\=A2+1, A1#\=A2-1, A1#\=A3+2, A1#\=A3-2, A1#\=A4+3, A1#\=A4-3,
 % check second Row
 A2#\=A3+1, A2#\=A3-1, A2#\=A4+2, A2#\=A4-2,
 % check third Row
 A3#\=A4+1, A3#\=A4-1,
    % find solutions
 labeling([],Cols).



%b generico para N x N
nqueens(N,Cols):-
 length(Cols,N),
 domain(Cols,1,N),
 constrain(Cols),
 % all_distinct(Cols), % Redundante mas diminui o tempo de resolução
 labeling([],Cols).


constrain([]).
constrain([H | RCols]):-
 safe(H,RCols,1),
 constrain(RCols).


safe(_,[],_).
safe(X,[Y | T], K) :-
 noattack(X,Y,K),
 K1 is K + 1,
 safe(X,T,K1).
noattack(X,Y,K) :-
 X #\= Y,
 X + K #\= Y,
 X - K #\= Y.


% Test: nqueens(4,C).
% C = [2, 4, 1, 3] More? (;)
% C = [3, 1, 4, 2] More? (;)
% no (more) solution.
