a(a1,1).
a(a,2).
a(a3,n).
b(1,b1).
b(2,b).
b(n,b3).
c(X,Y) :- a(X,n), b(n,Y).
d(X,Y) :- a(X,n), b(Y,n).
d(X,Y) :- a(n,X), b(n,Y). 

/*
Questions:
a) ?- a(X,2). Answer: X = A
b) ?- b(X,kalamazoo). Answer: no
c) ?- c(X,b3). Answer:  X = a3
d) ?- c(X,Y). Answer: X = a3, y=b3
e) ?- d(X,Y). Answer: no
*/