%a
is_prime(N):-
    N > 1,
    prime_factors(N, 2).

prime_factors(Acc, Acc).
prime_factors(N, Acc):-
    N > Acc,
    N mod Acc =\= 0,
    Acc1 is Acc+1,
    prime_factors(N, Acc1).

%b

lista_primos(N, L)
