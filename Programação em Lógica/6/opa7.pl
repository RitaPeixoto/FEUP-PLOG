 t(0+1, 1+0).

 t(X+0+1, X+1+0). 

 t(X+1+1, Z) :-
    t(X+1, X1),
    t(X1+1, Z). 


a) ?-t(0+1, A).
    A = 1 + 0

b) ?-t(0+1+1, B).
    X1 = 1 + 0
    B = 1 + 1 +0



c) ?-t(1+0+1+1+1, C).
    X1 = X + 1 = 1 + 0 + 1 + 1
    X1 + 1 = 1+0+1
    C = 1 + 1 + 0 
  

d) ?-t(D, 1+1+1+0). 
    X = 1+1+0+1
    X = 1 + 1 + 1 + 0
    ...
    