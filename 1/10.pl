%comprou(pessoa, coisa)
comprou(joao, honda).
comprou(joao, uno).

%ano(coisa, ano)
ano(honda, 1997).
ano(uno, 1998).

%valor(coisa, valor)
valor(honda, 20000).
valor(uno, 7000). 


pode_vender(P, C, Y) :- comprou(P,C), ano(C, A), Y-10<A , valor(C, V), V<10000.  


/*
Crie uma regra pode_vender onde o primeiro argumento é a pessoa, o segundo o carro e o
terceiro é o ano actual (não especificar “homem” ou “carro” nas regras), onde a pessoa só pode
vender o carro se o carro for comprado por ela nos últimos 10 anos e se seu valor for menor do que
10000 Euros. 
*/