:-use_module(library(lists)).
:-use_module(library(clpfd)).


/*
Joana tem 5 tias na faixa de 70 anos, todas activas e com boa saúde. Elas atribuem esse seu estado
ao seus hobbies e hábitos de vida. Partindo das premissas abaixo, poderia determinar o nome, a
idade, o hobby, e o hábito de cada uma? Nota: Este exercício tem um pequeno erro (tente-o descobrir!)
Premissas:
 Hortênsia, que bebe tequila, é dois anos mais velha que a tia que colecciona latas de cerveja.
 A tia que resolve problemas de lógica, enquanto treina para maratona, não é Eugénia. 
 A tia Honória, que têm 74 anos, não fuma cachimbo.
 A tia Letícia, que cria piranhas, não é a tia mais velha de Joana.
 A tia que come dois ovos crus por dia, é dois anos mais nova que a tia que levanta pesos.
 A tia que bebe vodka não é a Honória
 A tia que pesca salmão tem 77 anos.


*/

tias:-
    