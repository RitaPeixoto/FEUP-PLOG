:-use_module(library(lists)).
:-use_module(library(clpfd)).

/*
    Pretende-se fazer a atribuição de presentes a pessoas: N presentes a distribuir por K pessoas, nao havendo qualquer  relaçao entre N e K 
    (isto é, podemos ter pessoas com mais do que um presente,ou sem presente nenhum)
*/

%1
/*
    Dominio binario: 
    numero de variaveis: n*k
    dimensao do dominio: 2
    espaço de pesquisa: 2^n*k
*/

%2
/*
    Dominio finito:
    numero de variaveis: n
    dimensao do dominio: k
    espaço de pesquisa: k^n
*/

%3
pres(N, K, Vars):-
    length(Vars, N),
    domain(Vars, 1, K),
    indices(1, Vars),
    labeling([], Vars).

indices(I, [V|Vs]):-
    V mod 2 #\= I mod 2,
    I1 is I+1,
    indices(I1, Vs).

indices(_,[]).

/*
    O programa obtém soluções em que a paridade entre os índices das pessoas e dos presentes é diferente.

*/

%4
/*
    A colocação de restriçoes anterior provoca alteraçoes no dominio das variaveis, antes da fase de pesquisa?
    O limite inferior ou superior do dominio das variáveis é alterado
    presentes de 1 a 10
    V é impar - dominio passa a ser de 2 a 10 (muda limite inferior)
    V é par - dominio passa a ser de 1 a 9 (muda limite superior)
*/

%5


constroi_binarias(I, K, Vars,[LBin|LBins]):-
    I =< K, !,
    constroi_bins(I, Vars, LBin),
    I1 is I + 1,
    constroi_binarias(I1, K, Vars, LBins).

constroi_binarias(_,_,_,[]).

constroi_bins(_,[],[]).
constroi_bins(I,[H|T],[LBinH|LBinT]):-
    I #=H #<=> LBinH,
    constroi_bins(I,T,LBinT).


%6

/*

As variaveis de decisao neste problema é uma lista em que cada indice indica em que compartimento o objeto deve ser colocado.
O seu dominio é entre 1 e o numero de compartimentos.
Olhando para o exemplo com menor solução:
Vars = [3,1,3,4,1,4]
Significa que no compartimento 3 ficam os objetos 1 e 3; no compartimento 1, os objetos 2 e 5 e no compartimento 4 os objetos 4 e 6.

A resolução do problema passa por adicionar uma restrição de volume: a soma do volume dos objetos dentro do compartimento nao pode ultrapassar o
volume do compartimento; e uma restrição de peso, cada compartimento tem que ter peso inferior ao que está imediatamente abaixo.

Prateleiras = [[Cop,Cop], [Cop,Cop]]
Objetos = [Peso-Volume,Peso-Volume,Peso-Volume]

*/

prat(Prateleiras, Objetos, Vars):-
    length(Objetos, NObjetos),
    length(Vars, NObjetos),
    append(Prateleiras, AllPrateleiras),
    length(AllPrateleiras, NPrateleiras),
    domain(Vars, 1, NPrateleiras),

    element(0, Prateleiras, N),
    length(N, NColumns),
    
    aplicarestricoes(Vars, Objetos, Prateleiras, NColumns),
    %restricoes
    labeling([], Vars),
    write(Vars).

aplicarestricoes(Vars, Objetos, Prateleiras, NColumns):-
    length(Prateleiras, NPrateleiras),
    length(Aux, NPrateleiras),
    maplist(=(0), Aux),

    getCapUsed(Vars, Objetos, Aux, Res1),
    getWUsed(Vars, Objetos, Aux, Res2),

    restricaoVolume(Res1,Prateleiras),
    restricaoPeso(1, Res2, Res2, NColumns).


getCapUsed([],[],Res,Res).
getCapUsed([_-Volume|Rest],[Shelf|Rest2], Aux, Res):-
    element(Shelf, Aux, OldCap),
    NewCap #= OldCap + Volume,
    copy_list_with_new_element(Aux, NewAux, Shelf, NewCap),
    getCapUsed(Rest, Rest2, NewAux, Res).



getWUsed([],[], Res, Res).
getWUsed([Peso - _|Rest], [Shelf|Rest2], Aux, Res):-
    element(Shelf, Aux, OldW),
    NewW #= Peso +  OldW,
    copy_list_with_new_element(Aux, NewAux, Shelf, NewW),
    getWUsed(Rest, Rest2, NewAux, Res).




restricaoVolume([],[]).
restricaoVolume([H|T], [H1|T1]):-
    H #=< H1,
    restricaoVolume(T,T1).


restricaoPeso(_, [], _, _).
restricaoPeso(N, [Peso | Rest], CapPesUsada, NCols) :-
    getDownShelf(N, CapPesUsada, NCols, PesoBaixo),
    Peso #=< PesoBaixo,
    N1 #= N + 1,
    restricaoPeso(N1, Rest, CapPesUsada, NCols).


getDownShelf(N, CapPesUsada, NCols, Element) :-
    length(CapPesUsada, NShelfs),
    Elem is N + NCols,
    (
        Elem =< NShelfs,
        element(Elem, CapPesUsada, Element)
        ;
        Element #= 1000000
    ).


/**
 * Copies list1 to list2 changing value in a given index
 */
copy_list_with_new_element([], [], _, _).

copy_list_with_new_element([E1 | R1], [E2 | R2], Index, Value) :-
    (Index #= 1 #/\ E2 #= Value) #\/ (Index #\= 1 #/\ E2 #= E1),
    NewIndex #= Index - 1,
    copy_list_with_new_element(R1, R2, NewIndex, Value).


%8
/*
As variáveis de decisao são os tempos de inicio e fim de cada tarefa, com dominio entre 1 e tempo_max.
Trata-se de um problema de escalonamento, logo pode ser resolvido através do cumulative, construindo uma lista com as tarefas e tendo como limite 
o numero de homens, tendo em conta o tempo maximo
*/


%9
objeto(piano, 3, 30).
objeto(cadeira, 1, 10).
objeto(cama, 3, 15).
objeto(mesa,2,15).
homens(4).
tempo_max(60).


furniture:-
    homens(NHomens),
    tempo_max(TempoMax),
    findall(Objeto-Homens-Tempo, objeto(Objeto, Homens, Tempo), Objetos),

    length(Objetos, NObjetos),
    length(StartTimes, NObjetos),
    length(EndTimes, NObjetos),

    domain(StartTimes, 0, TempoMax),
    domain(EndTimes, 0, TempoMax),

    maximum(Tempo, EndTimes),
    Tempo #=< TempoMax,

    getTasks(Objetos, StartTimes, EndTimes, 1, [], Tasks),
    cumulative(Tasks, [limit(NHomens)]),
    append(StartTimes, EndTimes, Vars),
    labeling([minimize(Tempo)], Vars),
    write(Tempo), nl,
    write(StartTimes),
    write(EndTimes).


getTasks([],[],[], _, Tasks, Tasks).
getTasks([_-NH-DH|DT], [SH|ST], [EH|ET], Count, Acc, Tasks):-
    append(Acc, [task(SH, DH, EH, NH, Count)],Acc1),
    Count1 is Count + 1,
    getTasks(DT, ST, ET, Count1, Acc1, Tasks).
    
    
