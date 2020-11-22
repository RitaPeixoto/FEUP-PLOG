:-include('2.pl').


allPerfs:-  
    participant(X,_,Performance),
    performance(X, Times),
    write(X), write(':'), write(Performance), write(':'), write(Times),nl,
    fail.
