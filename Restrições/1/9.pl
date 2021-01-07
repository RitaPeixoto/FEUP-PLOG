:- use_module(library(clpfd)).


/*Como é possível escrever 1 000 000 000 como um produto de dois factores, cada um dos quais não
contendo qualquer zero?*/

zero:-
    F = [N1, N2],
    domain(F, 1, 1000000000),
    N1 * N2 #= 1000000000,
    N1 #> N2,

    Num1 = [F1, F2, F3, F4, F5, F6, F7, F8, F9, F10],
    Num2 = [F21, F22, F23, F24, F25, F26, F27, F28, F29, F210],
    domain(Num1, 0, 9),
    domain(Num2, 0, 9),

    N1 #= F1*1000000000 + F2*100000000 + F3*10000000 + F4*1000000 + F5*100000 + F6*10000 + F7*1000 + F8*100 + F9*10 + F10,
    N2 #= F21*1000000000 + F22*100000000 + F23*10000000 + F24* 1000000 + F25*100000 + F26*10000 + F27*1000 + F28*100 + F29*10 + F210,
    
    nozeros(Num1,0),
    nozeros(Num2, 0),
    
    labeling([], F),
    write(F),
    fail.
    

nozeros([], _).
nozeros([F|T], 0):-
    (F #>0) #<=>B,
    nozeros(T, B).

nozeros([F|T],1):-
    F #>0,
    nozeros(T, 1).

