%a 
/*If the list has become empty and we had run out of elements to count it is true*/
count([], 0).

count([_|T],N):- 
    N1 is N-1, 
    count(T, N1).


/* more efficient
conta_(L, N):-
	conta(L, N, 0). 

conta_([X|L], N, Acc):- 
	Acc1 is Acc+1, 
	conta_(L, N, Acc1). 
conta_([], N, N). 

*/


%b
/*Same as before, it succeeds if it has reached the end of the list and counted exactly N elements X*/
count_elem(_, [], 0).

count_elem(X, [X|T], N):- 
    N1 is N-1, 
    count_elem(X,T, N1).

count_elem(X,[H|T], N):-
    X\=H, 
    count_elem(X,T,N).
/* more efficient
conta_elem_(X, L, N):-
	conta_elem_(X, L, N, 0).  

conta_elem_(X, [X|L], N, Acc):-
	Acc1 is Acc+1, 
	conta_elem_(X,L, N, Acc1). 

conta_elem_(X, [Y|L], N, Acc):-
	X \= Y, 
	conta_elem_(X, L, N, Acc). 

conta_elem_(X, [], N, N).


*/