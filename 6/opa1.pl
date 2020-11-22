:- op(500,xfx,na).
:- op(500,xfy,ad).
:- op(500,yfx,ae). 


/*
a) a na b ae c.
    ae(na(a,b),c)

b) a na b ad c.
    Erro

c) a ad b na c.
    ad(a,na(b,c)).

d) a na b na c.
    Erro.

e) a ad b ad c.
    ad(a, ad(b,c)).

f) a ae b ae c.
    ae(ae(a,b),c).

g) a ad b ad c na d ae e ae f.
    ad(a,ad(b,ae(ae(na(c,d),e),f))).

*/  