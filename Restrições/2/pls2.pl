:-use_module(library(clpfd)).



/*
Três músicos, João, António e Francisco, tocam harpa, violino e piano. Contudo, não se sabe quem
toca o quê. Sabe-se que o António não é o pianista. Mas o pianista ensaia sozinho à Terça. O João
ensaia com o Violoncelista às Quintas. Quem toca o quê?
*/


musics:-
    I = [Harpa, Violino, Piano],
    domain(I, 1, 3),
    all_distinct(I),
    Piano #\=2, 
    Piano #\=1,
    Violino #\= 1,
    labeling([], Nomes),
    write(Nomes),
    fail.
