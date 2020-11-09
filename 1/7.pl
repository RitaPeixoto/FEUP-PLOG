
traduza(Codigo, Significado) :- Codigo = 1, Significado = integer_overflow.

traduza(Codigo, Significado) :- Codigo = 2, Significado = divisao_por_zero.

traduza(Codigo, Significado) :- Codigo = 3, Significado = id_desconhecido. 




/*
O que está aqui a acontecer é definir predicados em vez de factos, quando factos era a maneira correta de o fazer:

traduza(1, integer_overflow). 
traduz(2, divisao_por_zero).
traduz(3, id_desconhecido).

*/