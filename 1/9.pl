%aluno(Aluno,Cadeira)
aluno(joao, paradigmas).
aluno(maria, paradigmas).
aluno(joel, lab2).
aluno(joel, estruturas).

%frequenta(Aluno, Universidade)
frequenta(joao, feup).
frequenta(maria, feup).
frequenta(joel, ist).

%professor(Professor, Cadeira)
professor(carlos, paradigmas).
professor(ana_paula, estruturas).
professor(pedro, lab2).

%funcionario(Funcionario, Universidade)
funcionario(pedro, ist).
funcionario(ana_paula, feup).
funcionario(carlos, feup). 




/*professorAluno(P,A):- aluno(A,C), professor(P,C).
pessoasUniversidade(T,U):- frequenta(T,U); funcionario(T,U).
colega(C1, C2):- frequenta(C1, U), frequenta(C2, U), C1 \= C2. %colega de universidade
colega(C1, C2):- aluno(C1, U), aluno(C2, U), C1 \= C2. %colega de disciplina
colega(C1, C2):- funcionario(C1, U), funcionario(C2, U), C1 \= C2.
*/

/*
Questions:

a) aluno(A, C), professor(P,C).

b) frequenta(A,X); funcionario(F,X).

c) aluno(A,X),aluno(B,X),A@<B;frequenta(A,Y),frequenta(B,Y),A@<B;funcionario(A,Z),funcionario(B,Z),A@<B.

*/
