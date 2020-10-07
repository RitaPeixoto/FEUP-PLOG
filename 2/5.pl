/*Escreva um predicado e_primo(N) que determine se um dado número é primo */

e_primo(2). %2 e primo
e_primo(3). %3 e primo

%um numero é primo se os seus unicos divisores forem 1 e ele próprio
e_primo(P) :- integer(P), %todos os primos sao inteiros
             P > 3, % tem que ser maior que 3, porque 1 e 2 ja se sabe que sao primos
             P mod 2 =\= 0,  %nao pode ser divisivel por 2
             \+tem_factor(P,3). %comeco de verificação se tem divisores, verifica até encontrar divisor ou o numero que verifica ao quadrado é > que o numero a ser testado
tem_factor(N,L) :- N mod L =:= 0. %se n  for divisivel por L, nao e primo
tem_factor(N,L) :- %se nao for divisivel 
                 L * L < N, %enquanto o proximo numero ao quadrado pelo qual se vai dividir for menor que o numero a testar
                 L2 is L + 2, %determina o próximo número pela qual vai dividir, que será o próximo impar
                  tem_factor(N,L2).  % testa o proximo fator
