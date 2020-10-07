r(a,b). 
r(a,c). 
r(b,a). 
r(a,d).
s(b,c). 
s(b,d). 
s(c,c). 
s(d,e). 

?- r(X,Y), s(Y,Z), not(r(Y,X)), not(s(Y,Y)). 


/*
Questions:
a) X = a, Y = d, Z = e;

1º objetivo: r(X,Y)
2º obejtivo: s(Y,Z)
3º objetivo: not(r(Y,X))
4º objetivo:  not(s(Y,Y))

b)  - 1 r(a,b)
      2 s(b,c) 
      3 not(r(b,a)) false
    - 1 r(a,c)
      2 s(c,c)
      3 not(r(c,a))
      4 not(s(c,c)) false
    - 1 r(b,a)
      2 s(a,Z) not Z exists
    - 1 r(a,d)
      2 s(d,e)
      3 not(r(d,a))
      4 not(s(d,d)) true , so  X = a, Y = d, Z = e;

    3 vezes 

*/