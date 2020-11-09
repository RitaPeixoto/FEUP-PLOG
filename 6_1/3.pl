/*
Implemente utilizando o setof/3, o predicado mais_proximos(+Idade,-ListaProximos) que,
assumindo a existência de factos idade(Nome,Idade) para representar que um dado indivíduo
chmado Nome tem idade Idade, devolve em ListaProximos o nome dos indivíduos cuja idade é mais
próxima de Idade. 

setof(+Template, +Goal, -Set)
Equivalent to bagof/3, but sorts the result using sort/2 to get a sorted list of alternatives without duplicates.

*/
%idade(Nome, Idade)
idade(joao, 18).
idade(maria,20).
idade(jose,40).


mais_proximos(I, [N|Prox]):-
    setof(Dif-Nome, prox(I, Dif, Nome), [D1-N1|L]),
    primeiros(D1, L, Prox).

prox(I, Dif, Nome):-
    idade(Nome, Id),
    dif(I, Id, Dif).

dif(A, B, D) :-
    A>B, 
    !,
    D is A-B.
    
dif(A,B,D):-
    D is B-A.

primeiros(_,[],[]).

primeiros(D1,[D-_|_],[]) :- 
    D > D1, 
    !.
primeiros(D1,[_-N|L],[N|NL]) :- 
    primeiros(D1,L,NL). 