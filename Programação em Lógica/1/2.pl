%pilot(PilotName)
pilot('Lamb').
pilot('Besenyei').
pilot('Chambliss').
pilot('MacLean').
pilot('Mangold').
pilot('Jones').
pilot('Bonhomme').

%team(PilotName, TeamName)
team('Lamb','Breitling').
team('Besenyei','Red Bull').
team('Chambliss','Red Bull').
team('MacLean','Mediterranean Racing Team').
team('Mangold','Cobra').
team('Bonhomme','Matador').
team('Jones','Matador').

%airplane(PilotName, AirplaneName)
airplane('Lamb','MX2').
airplane('Besenyeu','Edge540').
airplane('Chambliss','Edge540').
airplane('MacLean','Edge540').
airplane('Mangold','Edge540').
airplane('Bonhomme','Edge540').
airplane('Jones','Edge540').


%circuit(City)
circuit('Istambul').
circuit('Budapest').
circuit('Porto').

%won(PilotName, City)
won('Jones', 'Porto').
won('Mangold', 'Budapest').
won('Mangold', 'Istambul').

%gates(City, Number)
gates('Istambul',9).
gates('Budapest',6).
gates('Porto',5).

%rules
wonteam(T,C):- won(P,C), team(P,T).

/*
Questions:
a) won(X,'Porto').
b) wonteam(X,'Porto'). 
c) won(P, C1), won(P, C2), C1\=C2.
d) gates(C,G), G>8.
e) airplane(P,A), A\='Edge540'.
*/
