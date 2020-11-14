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



mais_proximos(Idade, L):-
	setof(Prox-Pers, proximidade(Pers, Idade, Prox), [Px-Ps|T]),
	get_mais_proximos([Px-Ps|T], Px, L, []).

proximidade(Pessoa, Idade, Diff):-
    idade(Pessoa, IdadePessoa),
    Diff is abs(Idade - IdadePessoa).

get_mais_proximos(_,_,L,L).

get_mais_proximos([Prox-Pers|T], Prox, L, Acc):-
    append(Acc,[Pers], Acc1),
    !,
    get_mais_proximos(T, Prox, L, Acc1).





