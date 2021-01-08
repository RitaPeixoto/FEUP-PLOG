/*
O político Jorge Bosque procura reunir alguns votos para o seu partido através de estratégias menos
aconselháveis. Existem três métodos que podem ser utilizados neste campo
1) Convencer votantes individualmente. Isto gasta 2 unidades de tempo e causa uma unidade de
sofrimento;
2) Convencer grupos de votantes. Isto permite arranjar 3 votantes de uma só vez, gasta 5
unidades de tempo e causa quatro unidades de sofrimento;
No entanto há também um método não oficial:
3) Insultar grupos específicos de votantes, o que embora faça perder 10 votantes, permite
também perder 11 unidades de sofrimento, o que o faz sentir optimamente (o sofrimento dos
votantes não é considerado neste jogo…). Esta actividade gasta unicamente uma unidade de
tempo pelo que pode ser bastante útil para aliviar o sofrimento!
O Jorge Bosque sabe que necessita de 5 a 6 votantes para ganhar as eleições que se realizam daqui a
10 unidades de tempo (semanas). Que planos pode aplicar para atingir os seus objectivos?
*/

:-use_module(library(clpfd)).

%method(?methodnumber, ?timeunits, ?suferingunits, ?voters)
method(1, 2, 1, 1).
method(2, 5, 4, 3).
method(3, 1, -11, -10).


plan(N, Plans):-
    length(Plans, N),
    domain(Plans, 1, 3),
    evaluatePlan(Plans, 0, 0, 0, Tu, Su, V),
    V #>=5, V #<=6, Tu #<= 10,
    calculateCost(0, Plans, Cost),
    labeling([minimize(Cost)], Plans).


evaluatePlan([], Tu1, Su1, V1, Tu2, Su2, V2).
evaluatePlan([H|T], Tu1, Su1, V1, Tu2, Su2, V2):-
    method(H, T1, S1, V3),
    Tu is Tu1 + T1,
    Su is Su1 + S1,
    V is V1 + V3,
    evaluatePlan(T, Tu, Su, V, Tu2, Su2, V2).


calculateCost(Cost,[], Cost).
calculateCost(C1,[H|T], Cost):-
    method(H, Time, _, _),
    C is C1 + Time,
    calculateCost(C, T, Cost).


    


