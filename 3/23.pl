:-use_module(library(random)).
/*Props to @afonsojramos for the solution, could not figure this out on my own*/


% a) Extraia um determinado número de elementos seleccionados aleatoriamente de uma lista. E construa uma nova lista com esses elementos 
rnd_selectN(L1, N, L2):-
    length(L1, Len1),
    Len2 is Len1-1,
    generate_rand(N, 0, Len2, RandList),
    aux_rnd_select_n(L1, RandList, Len1, 0, L2, []).

aux_rnd_select_n(_, _, Len, Len, Acc, Acc).
aux_rnd_select_n([H|T], RandList, Len, C, L2, Acc):-
    member(C, RandList),
    C1 is C+1,
    aux_rnd_select_n(T, RandList, Len, C1, L2, [H|Acc]).


aux_rnd_select_n([_|T], RandList, Len, C, L2, Acc):-
    \+ member(C, RandList),
    C1 is C+1,
    aux_rnd_select_n(T, RandList, Len, C1, L2, Acc).


generate_rand(N, LbClosed, UbOpen, L):-
    UbClosed is UbOpen + 1,
    aux_generate_rand_list(N, 0, LbClosed, UbClosed, L, []).

aux_generate_rand_list(N, N, _, _, Acc, Acc).
aux_generate_rand_list(N, C, Lb, Ub, L, Acc):-
    C < N,
    random(Lb, Ub, Rand),
    aux_add_rand(Rand, N, C, Lb, Ub, L, Acc).


aux_add_rand(Rand, N, C, Lb, Ub, L, Acc):-
    member(Rand, Acc),
    aux_generate_rand_list(N, C, Lb, Ub, L, Acc).

aux_add_rand(Rand, N, C, Lb, Ub, L, Acc):-
    \+ member(Rand, Acc),
    C1 is C+1,
    aux_generate_rand_list(N, C1, Lb, Ub, L, [Rand|Acc]).


% b) Sorteie N elementos entre 1 e M aleatoriamente e coloque-os numa lista. 
rnd_select(N, M, L):-
    M1 is M+1,
    generate_rand(N, 1, M1, L).


% c) Gere uma permutação aleatória dos elementos de uma lista
rnd_permutation(L1, L2):-
    aux_rnd_permutation(L1, L2, []).

aux_rnd_permutation([], Acc, Acc).
aux_rnd_permutation(L1, L2, Acc):-
    length(L1, Len),
    random(0, Len, Rand),
    getElement(L1, Rand, X, L),
    aux_rnd_permutation(L, L2, [X|Acc]).


getElement(L1, N, X, L2):-
    aux_get_el(L1, N, 0, X, L2, []).

aux_getElement([], _, _, _, Acc, Acc).

aux_getElement([H|T], C, C, H, L2, Acc):-
    C1 is C+1,
    aux_get_el(T, C, C1, H, L2, Acc).

aux_getElement([H|T], N, C, X, L2, Acc):-
    C1 is C+1,
    aux_get_el(T, N, C1, X, L2, [H|Acc]).