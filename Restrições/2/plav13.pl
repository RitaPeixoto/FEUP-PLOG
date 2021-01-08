:-use_module(library(lists)).
:-use_module(library(clpfd)).


/*
Um problema de escalonamento simples. O Sr. Paulino nunca acorda antes das 6h da manhã mas
necessita de acordar uma hora antes de apanhar o autocarro para o trabalho. A viagem de autocarro
demora pelo menos uma hora. O Sr. Paulino não sai do trabalho antes de trabalhar pelo menos 8
horas, após o que demora pelo mais de uma hora a chegar a casa e poder ligar a sua televisão. No
entanto o Sr. Paulino não resiste a ver pelo menos 3 horas de televisão antes de se deitar.
Utilize as variáveis: WakeUp, TakeBus1, StartWork, TakeBus2, TurnTVOn, FallASleep e construa
um escalonador para o dia do Sr. Paulino. As variáveis devem estar nos limites 1..24.

*/

paulino:-
    Vars = [WakeUp, TakeBus1, StartWork, TakeBus2, TurnTVOn, FallASleep],
    domain(Vars, 1, 24),
    WakeUp #>= 6,
    WakeUp #=< TakeBus1 - 1,
    TakeBus1 + 1 #=< StartWork,
    StartWork + 8 #=< TakeBus2,
    TakeBus2 + 1 #=< TurnTVOn,
    TurnTVOn + 3 #=< FallASleep,

    labeling([], Vars),
    write(Vars). 

