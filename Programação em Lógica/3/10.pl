%a  true if the list is a list of ordered integer  

sortedList([_]).
sortedList([H1, H2|T]):- 
    H1 =< H2, 
    sortedList([H2|T]).


%b
sorts(L, S):-
    i_sort(L, [], S).

i_sort([], Acc, Acc).

i_sort([H|T], Acc, S):-
    insert(H, Acc, NAcc),
    i_sort(T, NAcc, S).
   
insert(X, [Y|T], [Y|NT]):-
    X > Y,
    insert(X, T, NT).

insert(X, [Y|T], [X,Y|T]):-
    X =< Y.

insert(X,[],[X]).



/* Gets one element from the array and delete it - inefficient way*/ 
 select(X, [Y|Xs], [Y|Zs]):- 
	 X \== Y, 
	 select(X, Xs, Zs).  
 select(X, [X|Xs], Xs). 

permutation(L1, [X|L2]):-    
	select(X, L1, K), 
  	permutation(K, L2). 

permutation([], []).   

sort1(L1, L2):-
	permutation(L1, L2),
	sortedList(L2). 

/*Insertion sort --> more efficient
Basically finds the max of the List and eliminates it from the input List adding it to the result
*/

insertion_sort(L1, L2):- 
	insertion_sort(L1, L2, []). 

insertion_sort(L1, L2, Acc):-
	find_max(L1, Max), 
	delete_val(Max, L1, New_L1), 
	insertion_sort(New_L1, L2, [Max|Acc]).  

insertion_sort([], L2, L2). 



find_max([X|L1], Y):-   
	find_max(L1,K),
	max(X,K,Y). 

find_max([X],X). 

max(X, Y, Z):-
	X =< Y,
	Z is Y. 
max(X, Y, Z):-
	X > Y,
	Z is X. 
 
delete_val(X, L1, Ans):-
	append(L2, [X|L3], L1),
	append(L2, L3, Ans). 
