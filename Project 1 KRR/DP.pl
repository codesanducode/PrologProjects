:- style_check(-singleton).	
citeste(X,Y):-seeing(A),see('C:/Users/Sandu/Desktop/indp.txt'),
    read(X),read(Y),read(end_of_file),seen,see(A).

get_terms(X,L):-append(X,R),sort(R,L).

negate(n(A), A) :- !.
negate(A, n(A)).

dot_procedure1([],_,[]).						
dot_procedure1([H|T],P,R):-member(P,H),dot_procedure1(T,P,R),!.
dot_procedure1([H|T],P,R):-member(n(P),H),dot_procedure1(T,P,R),!.
dot_procedure1([H|T],P,[H|R]):- dot_procedure1(T,P,R).

dot_procedure2([],_,[]).
dot_procedure2([H|T],P,R):-member(P,H),dot_procedure2(T,P,R),!.
dot_procedure2([H|T],P,[R1|R]):-negate(P,Q),
    							member(Q,H),
    							delete(H,Q,R1),
    							dot_procedure2(T,P,R),!.
dot_procedure2([H|T],P,[H|R]):- dot_procedure2(T,P,R).

dot_procedure(X,P,Res):-dot_procedure1(X,P,R1),
    					dot_procedure2(X,P,R2), 
    					union(R1,R2,Res).

inp1([[n(a),b],[c,d],[n(d),b],[n(c),b],[n(b)]]). %no
inp2([[n(b),a],[n(a),b,e],[e],[a,n(e)],[n(a)]]). %no
inp3([[n(a),b],[c,f],[n(f),b],[n(c),b],[n(c)]]). %yes
inp4([[n(a),n(e),b],[n(d),e,n(b)],[n(e),f,n(b)],[f,n(a),e],[e,f,n(b)]]). %yes
inp5([[a,b],[n(a),n(b)],[n(a),b],[a,n(b)]]). %no

choose_p(X,P):-
    findall([Len, Q], (
        member(C,X),
        member(Q,C),
        length(C,Len)
    ), Lista_lungimi),
    sort(Lista_lungimi, Lista_sortata),
    Lista_sortata=[[_,P]|_].

%choose_p2(X,P):-member([P],X),!;[H|_]=X,[P|_]=H.
choose_p2(X,P):-
    get_terms(X,L),
    member(P,L),
    negate(P,Q),
    \+member(Q,L),!;
    [H|_]=X,
    [P|_]=H.

:-dynamic adev/1.
%afisadev(_,_):-forall(adev(A), (write(A),write(' = true, '))).
afisadev(A,_):-forall(adev(A), (write(A),write(' = true, '))),nl,!.

dp([]):-write('YES\n'),afisadev(_,_),!.
dp(X):-member([],X),write('No\n'),!.
dp(X):- 
    choose_p(X,P),
    dot_procedure(X,P,Res),
    assertz(adev(P)),
    dp(Res),!;
    negate(P,Q),
    dot_procedure(X,Q,Res2),
    retract(adev(P)),
    assertz(adev(Q)),
    dp(Res2),!.

dp2([]):-write('YES\n'),afisadev(_,_),!.
dp2(X):-member([],X),write('No\n'),!.
dp2(X):- 
    choose_p2(X,P),
    dot_procedure(X,P,Res),
    assertz(adev(P)),
    dp2(Res),!;
    negate(P,Q),
    dot_procedure(X,Q,Res2),
    retract(adev(P)),	
    assertz(adev(Q)),
    dp(Res2),!.

solve():-citeste(X,Y),telling(A),tell('C:/Users/Sandu/Desktop/outdp.txt'),
  		  retractall(adev(_)),dp(X),retractall(adev(_)),dp(Y),told,tell(A).