fib(0,0).
fib(1,1).
fib(N, Valor):-
    N>1,
    N1 is N-1, N2 is N-2, fib(N1,V1), fib(N2, V2),
    Valor is V1 + V2.

/*
Solution:
fibonacci(0,0).
fibonacci(1,1).
fibonacci(N,F):-
N > 1,
N1 is N - 1, fibonacci(N1,F1),
N2 is N - 2, fibonacci(N2,F2),
F is F1 + F2.
*/ 