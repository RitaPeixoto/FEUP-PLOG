:-use_module(library(lists)).
:-use_module(library(clpfd)).

/*
A pequena cidade de Ílhavo organizou seu primeiro grande torneio ciclístico e após a última volta
chegaram os seguintes oitos corredores: Carlos, Ricardo, Raul, Tomas, Roberto, Boris, Diego e
Luís.
Pede-se para encontrar a posição de chegada de cada um destes corredores sabendo que:
 A irmã de Boris aplaudiu seu marido, que chegou em sétimo
 Tomas chegou entre os quatro primeiros

Na manhã do torneio, Raul, Tomas e o que chegou em quarto lugar, tomaram o pequeno-almoço
juntos
 O terceiro colocado faz hoje o seu primeiro aniversário de casamento
 As esposas do primeiro e quarto colocados abraçaram seus maridos no final do torneio
 Diego, Boris e os que chegaram no sétimo e oitavo lugares estavam esgotados na chegada
 A esposa do quinto colocado é irmã de Roberto
 Raul e o quinto colocado estavam na frente dos oito corredores antes da última volta
 Carlos e Luís foram os dois primeiros a chegarem
 Luís, Ricardo e Boris são solteiros, os outros são casado
*/

torneio:-
    Names = [ Carlos, Ricardo, Raul, Tomas, Roberto, Boris, Diego, Luis],
    domain(Names, 1, 8),
    all_distinct(Names),
    Ricardo#\=7 #/\ Ricardo#\=3#/\ Ricardo#\=4#/\ Ricardo#\=1#/\ Ricardo#\=5, %9
    Boris#\=3#/\ Boris#\=4#/\ Boris#\=1#/\ Boris#\=5 #/\ Boris#\=7 #/\ Boris#\=8,%9 e 5
    Luis #=2, %8, 4
    Carlos #= 1, %8, 4
    Tomas #< 4,%2   
    Diego #\=8 #/\ Diego #\= 7, %5
    Raul #\= 5 #/\ Raul #\=4, %7
    Roberto #\= 5,

    labeling([], Names),
    write(Names).
    
    