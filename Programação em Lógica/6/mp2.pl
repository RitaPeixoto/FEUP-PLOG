/*separa(+L,+Pred,-Lista) que dada uma lista L e um nome de um predicado
de aridade 1, devolve a lista com exactamente os mesmos elementos mas em que primeiro aparecem
todos aqueles que tornam verdadeiro o predicado. */

separa(L,TermFunctor,Res) :- 
    sepDL(L,TermFunctor,Res-Nots,Nots-[]).

sepDL([],_,P-P,N-N).%caso base, a lista ja foi toda processada


/*Se o predicado ficou verdadeiro adiciona à cabeça do resultado o elemento*/
sepDL([H|T],TermFunctor,[H|T1]-DY,N) :- 
    Term =..[TermFunctor, H],
    Term,
    !, 
    sepDL(T,TermFunctor,T1-DY,N). %tornou o predicado verdadeiro vai continuar   

/*Se o predicado ficou falso adiciona à cabeça do nots o elemento*/
sepDL([H|T],TermFunctor,Y,[H|N]-DN) :- %caso de nao tornar o predicado verdadeiro  
    sepDL(T,TermFunctor,Y,N-DN). 

