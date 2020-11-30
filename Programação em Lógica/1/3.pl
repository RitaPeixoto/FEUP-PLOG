/*Os Maias, livro, Eça de Queiroz, português, inglês, romance, escreveu, autor, nacionalidade, tipo, ficção */

%wrote(book, author)
wrote('Os Maias', 'Eca de Queiroz').
wrote('E urgente amar', 'Pedro Chagas Freitas').
wrote('A aia e outros contos', 'Eca de Queiroz').

%type(book, type)
type('Os Maias', romance).
type('E urgente amar', romance).
type('A aia e outros contos', fiction).

%author(author, nationality)
author('Eca de Queiroz', portuguese).
author('Pedro Chagas Freitas', portuguese).

/*
Question:
a) wrote('Os Maias',X).
b) author(A,portuguese), type(B, romance), wrote(B,A).
c) wrote(B1,A), wrote(B2,A), type(B1, fiction), type(B2, T), T\=fiction, B1\=B2.
 */

