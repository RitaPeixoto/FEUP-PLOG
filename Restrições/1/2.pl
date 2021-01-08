:- use_module(library(clpfd)).
/*
Há cinco casas com cinco cores diferentes.
Em cada casa, vive uma pessoa de nacionalidade diferente, tendo uma bebida, uma marca de
cigarros e um animal favoritos. A configuração é:
 O Inglês vive na casa vermelha
 O Espanhol tem um cão
 O Norueguês vive na primeira casa a contar da esquerda
 Na casa amarela, o dono gosta de Marlboro
 O homem que fuma Chesterfields vive na casa ao lado do homem que tem uma raposa
 O Norueguês vive ao lado da casa Azul 
 O homem que fuma Winston tem uma iguana
 O fumador de Luky Strike bebe sumo de laranja
 O Ucraniano bebe chá
 O Português fuma SG Lights
 Fuma-se Marlboro na casa ao lado da casa onde há um cavalo
 Na casa verde, a bebida preferida é o café
 A casa verde é imediatamente à direita (à sua direita) da casa branca
 Bebe-se leite na casa do meio
A pergunta é: Onde vive a Zebra, e em que casa se bebe água?

*/

zebra(Zeb,Agu):-
    % Definição das Variáveis e domínios
    Sol = [Nac,Ani,Beb,Cor,Tab],
    Nac = [Ing, Esp, Nor, Ucr, Por],
    Ani = [Cao, Rap, Igu, Cav, Zeb],
    Beb = [Sum, Cha, Caf, Lei, Agu],
    Cor = [Verm,Verd,Bran,Amar,Azul],
    Tab = [Che, Win, LS, SG, Mar],
    %flatten(Sol,List),
    List = [Ing, Esp, Nor, Ucr, Por, Cao, Rap, Igu, Cav, Zeb, Sum, Cha, Caf,
    Lei, Agu, Verm,Verd,Bran,Amar,Azul,Che, Win, LS, SG, Mar],
    domain(List,1,5),
    % Colocacao das Restrições
    all_different(Nac),
    all_different(Ani),
    all_different(Beb),
    all_different(Cor),
    all_different(Tab),
    Ing #= Verm,
    Esp #= Cao,
    Nor #= 1,
    Amar #= Mar,
    abs(Che-Rap) #= 1, % Che #= Rap+1 #\/ Che #= Rap-1
    abs(Nor-Azul) #= 1,
    Win #= Igu,
    LS #= Sum,
    Ucr #= Cha,
    Por #= SG,
    abs(Mar-Cav) #= 1,
    Verd #= Caf,
    Verd #= Bran+1,
    Lei #= 3,
    % Pesquisa da solução
    labeling([],List),
    write(Sol),nl.