:- use_module(library(lists)).
:- use_module(library(clpfd)).

optimal_skating_pairs( MenHeights, WomenHeights, Delta, Pairs):-
    length(MenHeights, NMen),
    length(Women, NWomen),
    minimum(Min, [NMen,NWomen]),
    NPairs in 1..Min,
    length(Men, NPairs),
    length(Women, NPairs),
    domain(Men, 1, NMen),
    domain(Women, 1, NWomen),
    all_distinct(Men),
    all_distinct(Women),

    height_restrictions(Men, Women, MenHeights, WomenHeights,Delta),
    remove_symmetries(Men),
    append(Men, Women, Vars),
    labeling([], Vars),
    make_pair(Men, Women, Pairs, []).   

height_restrictions([], [], _, _, _).
height_restrictions([M|Men], [W|Women], MenHeights, WomenHeights, Delta):-
    element(M, MenHeights, MH),
    element(W, WomenHeights, WH),
    MH #>= WH,
    Delta #>= MH - WH,
    height_restrictions(Men, Women, MenHeights, WomenHeights, Delta).

remove_symmetries([_]).
remove_symmetries([M1, M2|Men]):-
    M1 #=< M2,
    remove_symmetries([M2|Men]).

make_pair([], [], Pairs, Pairs).
make_pair([M|Men], [W|Women], Pairs, Acc):-
    append(Acc, [M-W], Acc2),
    make_pair(Men, Women, Pairs, Acc2).