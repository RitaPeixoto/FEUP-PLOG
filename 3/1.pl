
a) ?- [a|[b,c,d]] = [a,b,c,d]. --> yes 
b) ?- [a|b,c,d] = [a,b,c,d]. --> no 
c) ?- [H|T] = [apple, broccoli, refrigerator].--> H = apple T = [broccoli, refrigerator] 
d) ?- [H|T] = [a, b, c, d, e]. --> H = a T = [b, c, d, e] 
e) ?- [H|T] = [apples, bananas]. --> H = apples T = [bananas] 
f) ?- [H|T] = [a, [b,c,d]]. --> H = a T = [[b, c, d]] 
g) ?- [H|T] = [apples]. -->  H = apples T = [] 
h) ?- [H|T] = []. --> no 
i) ?- [One, Two | T] = [apple, sprouts, fridge, milk]. --> One = apple Two = sprouts T = [fridge, milk] 
j) ?- [X,Y|T] = [a|Z]. --> X = a Y = _01 T = _03 Z = [_01 | _03] 
X = a, Z = [Y|T] 
k) ?- [H|T] = [apple, Z]. --> H = apple T = [_01] Z = _01 
l) ?- [a|[b|[c|[d|[]]]]] = [a,b,c,d].  --> yes

A resposta no em b) é por causa de serem atomos e nao variaveis, entao só unificam se forem exatamente iguais e, neste caso sendo o tail b,c,d não uma lista
é falso

