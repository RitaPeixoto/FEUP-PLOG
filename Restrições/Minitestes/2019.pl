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


