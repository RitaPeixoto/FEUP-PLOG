%a 
palindrome_rev(L):-
    invert(L,L).


%b
palindromo(L):-
    palindromo_aux(L1,[],L2), L1 == L2.

palindromo_aux([], Acc, Acc).
palindromo_aux([H1|T1], L2):-
    palindromo_aux(T, [H|Acc],L2).


