
/*If A comes as if something is appended with to a list with A and something else(L2) we obtain L1 
then if something appended to B and L1 we obtain L2 (something else) A comes before B 
*/
before(A, B, L1):- 
    append(_,[A|L2], L1), 
    append(_,[B|L1], L2).
