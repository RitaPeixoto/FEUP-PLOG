%cargo(cargo, pessoa)
cargo(tecnico, rogerio).
cargo(tecnico, ivone).
cargo(engenheiro, daniel).
cargo(engenheiro, isabel).
cargo(engenheiro, oscar). 
cargo(engenheiro, tomas).
cargo(engenheiro, ana).
cargo(supervisor, luis).
cargo(supervisor_chefe, sonia).
cargo(secretaria_exec, laura).
cargo(diretor, santiago).


%chefiado_por(cargo1, cargo2)
chefiado_por(tecnico, engenheiro).
chefiado_por(engenheiro, supervisor).
chefiado_por(analista, supervisor).
chefiado_por(supervisor, supervisor_chefe).
chefiado_por(supervisor_chefe, director).
chefiado_por(secretaria_exec, director). 

/*
Questions:
a)  ?- chefiado_por(tecnico, X), chefeido_por(X,Y).
    Existe alguém que é chefe do chefe dos tecnicos?

b) ?- chefiado_por(tecnico, X), cargo(X,ivone), cargo(Y,Z). 
    Há algum tecnico a ser chefiado pela ivone?

c) ?- cargo(supervisor, X); cargo(supervisor, X). 
    Quais as pessoas que são supervisoras?

d) ?- cargo(J,P), (chefiado_por(J, supervisor_chefe); chefiado_por(J, supervisor)). 
    Quais os cargos e os nomes das pessoas que são cheafiados por um supervisor ou um supervisor-chefe?

e) ?- chefiado_por(P, director), not(cargo(P, carolina)). 
    Quais os cargos chefiados pelo diretor que não são o cargo da carolina?
*/