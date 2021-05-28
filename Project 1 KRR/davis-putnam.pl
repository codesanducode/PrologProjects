:- style_check(-singleton).	
citeste(Input):-
	seeing(Stream),see('C:/Users/Sandu/Desktop/inputdp.txt'),
    read(Input),read(end_of_file),seen,see(Stream).
	
negate(n(Atom), Atom):-!.
negate(Atom, n(Atom)).

:-dynamic adev/1.
afisadev():-
	forall(adev(Atom), (write(Atom),write('/true, '))),nl.


alege_p(KB,Rezultat):-
	findall([Len,Atom], (
		member(Clauza,KB),
		member(Atom,Clauza),
		length(Clauza,Len)
	), Lista_lungimi),
	sort(Lista_lungimi, Lista_sortata),
	Lista_sortata=[H|_],H=[_,Rezultat].
		
alege_q(KB,Rezultat):-
	flatten(KB,Lista1),
	sort(Lista1, Lista_termeni),
	findall([Freq,Atom], (
		member(Atom, Lista_termeni),
		delete(Lista1,Atom,Lista2),
		length(Lista1,Len1),
		length(Lista2,Len2),
		Freq is Len1-Len2
	), Lista_freq),
	sort(Lista_freq,Lista_sortata),
	reverse(Lista_sortata,Lista_inversata),
	Lista_inversata=[H|_],H=[_,Rezultat].
		
dot(KB,Atom,Rezultat):-
	negate(Atom,Negare),
	findall(Clauza, (
		member(Clauza,KB),
		\+member(Atom,Clauza),
		\+member(Negare,Clauza)
	), Rezultat1),
	findall(Clauza2, (
		member(Clauza,KB),
		\+member(Atom,Clauza),
		member(Negare,Clauza),
		delete(Clauza,Negare,Clauza2)
	), Rezultat2),
	append(Rezultat1,Rezultat2,Rezultat).

dp1([]):-write('Yes'),nl,afisadev(),!.
dp1(KB):-
	\+member([],KB),
	alege_p(KB,Atom),
	dot(KB,Atom,Rezultat),
	write('step'),nl,
	\+member([],Rezultat),
	assertz(adev(Atom)),
	dp1(Rezultat),!.
	
dp1(KB):-
	\+member([],KB),
	alege_p(KB,Atom),
	negate(Atom,Negare),
	dot(KB,Negare,Rezultat),
	write('step'),nl,
	\+member([],Rezultat),
	retract(adev(Atom)),
	assertz(adev(Negare)),
	dp1(Rezultat).

dp2([]):-write('Yes'),nl,afisadev(),!.
dp2(KB):-
	\+member([],KB),
	alege_q(KB,Atom),
	dot(KB,Atom,Rezultat),
	write('step'),nl,
	\+member([],Rezultat),
	assertz(adev(Atom)),
	dp2(Rezultat),!.
	
dp2(KB):-
	\+member([],KB),
	alege_q(KB,Atom),
	negate(Atom,Negare),
	dot(KB,Negare,Rezultat),
	write('step'),nl,
	\+member([],Rezultat),
	retract(adev(Atom)),
	assertz(adev(Negare)),
	dp2(Rezultat).
	
davis_putnam1(KB):-retractall(adev(_)),(dp1(KB);write('No'),nl),retractall(adev(_)),!.
davis_putnam2(KB):-retractall(adev(_)),(dp2(KB);write('No'),nl),retractall(adev(_)),!.

run():-citeste(Input),davis_putnam1(Input),davis_putnam2(Input).
