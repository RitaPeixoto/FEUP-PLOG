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
      3 not(r(b,a)) false, back to second

    -2 s(b,d)  
     3 not(r(b,a)), false	back to the second--> back to first

    - 1 r(a,c)
      2 s(c,c)
      3 not(r(c,a))
      4 not(s(c,c)) false, back to third --> back to second --> back to first

    - 1 r(b,a)
      2 s(a,Z) false, not Z exists --> back to first
    - 1 r(a,d)
      2 s(d,e)
      3 not(r(d,a))
      4 not(s(d,d)) true , so  X = a, Y = d, Z = e;

    3 times

*/