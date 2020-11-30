exec(X,Y) :- p(X,Y).
exec(X,X) :- s(X).
p(X,Y) :- q(X), r(Y).
p(X,Y) :- s(X), r(Y).
q(a)
q(b).
r(c).
r(d).
s(e). 


/*
?-                  exec(X,Y)
                    /       \
                exec(X,X)  p(X,Y)
                /           /    \
             s(X)       q(X)r(Y) s(X)r(Y)
               |            /\       /\
               e           a   c     e  c
                           b   d        d
            X=e ,Y=e      X=a, Y=c   X=e Y=c
                          X=a, Y=d   X=e Y=d
                          X=b, Y=c
                          X=b, Y=d       

*/