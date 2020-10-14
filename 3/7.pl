
before(A, B, L1):- 
    append(_,[A|L2], L1), 
    append(_,[B|L1], L2).