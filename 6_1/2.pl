/*separa(+L,+Pred,-Lista) que dada uma lista L e um nome de um predicado
de aridade 1, devolve a lista com exactamente os mesmos elementos mas em que primeiro aparecem
todos aqueles que tornam verdadeiro o predicado. */

separa(L,TermFunctor,Res) :- 
    sepDL(L,TermFunctor,Res-Nots,Nots-[]).

sepDL([],_,P-P,N-N).%caso base, a lista ja foi processada

sepDL([H|T],TermFunctor,[V|Y]-DY,N) :- 
    Term =..[TermFunctor, H],
    Term,
    !, 
    sepDL(T,TermFunctor,Y-DY,N). %tornou o predicado verdadeiro vai continuar   

sepDL([H|T],TermFunctor,Y,[V|N]-DN) :- %caso de nao tornar o predicado verdadeiro  
    sepDL(T,TermFunctor,Y,N-DN). 