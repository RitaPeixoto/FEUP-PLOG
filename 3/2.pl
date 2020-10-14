a) ?- lista([a,[b],c,[d]]) = lista([_|[X|X]]).


b) ?- lista([[a],[b],C])=lista([C,B,[a]]).
c) ?- lista([c,c,c])=lista([X|[X|_]]).
d) ?- lista([a,[b,c]])=lista([A,B,C]).
e) ?- [joao,gosta,peixe]=[X,Y,Z].
f) ?- [gato]= lista([X|Y]).
g) ?- [vale,dos,sinos])=[sinos,X,Y].
h) ?- [branco,Q]=[P,cavalo].
i) ?- [1,2,3,4,5,6,7]=[X,Y,Z|D]



/*


Por fazer



*/