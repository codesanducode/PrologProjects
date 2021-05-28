:- style_check(-singleton).	

citeste(Input):-seeing(Stream),see('C:/Users/Sandu/Desktop/input.txt'),read(Input),read(end_of_file),seen,see(Stream).

negate(n(Atom), Atom):-!.
negate(Atom, n(Atom)).

adauga(KB,Clauza,Rezultat):- \+member(Rezultat,KB),Rezultat=[Clauza|KB].

rezolva(KB,Clauza1,Clauza2,Rezultat):-
	member(Atom,Clauza1),
	negate(Atom,Negare),
	member(Negare,Clauza2),
	delete(Clauza1,Atom,Lista1),
	delete(Clauza2,Negare,Lista2),
	subtract(Lista1,Lista2,Lista3),
	merge(Lista3,Lista2,Rezultat).

recurenta(KB):- member([],KB),!.
recurenta(KB):-
	findall(R,(
		member(Clauza1,KB),
		member(Clauza2,KB),
		Clauza1\=Clauza2,
		rezolva(KB,Clauza1,Clauza2,R)),
	Clauze),append(Clauze,KB,Rezultat),sort(Rezultat,Rezultat2),write(Rezultat2),nl,
	KB\=Rezultat2,recurenta(Rezultat2).

check(X):- (\+recurenta(X),write('satisfiable'),!);write('unsatisfiable'),!.
run:- citeste(X),write(X),nl,check(X).


	
