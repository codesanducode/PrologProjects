:- style_check(-singleton).
:-dynamic answer/1.
question1():- 
    write('What is patient temperature? (answer is a number)'),read(Inp),
	(Inp = 'stop',abort,!;Inp>38,assertz(answer([temperature])),!;!).

question2():- 
    write('For how many days has the patient been sick? (answer is a number)'),read(Inp),
	(Inp = 'stop',abort,!;Inp>=2,assertz(answer([sick])),!;!).

question3():- 
    write('Has patient cough? (answer is yes/no)'),read(Inp),
	(Inp = 'stop',abort,!;Inp = 'yes',assertz(answer([cough])),!;!).

questions(Out):- question1(),question2(),question3(),findall(X,answer(X),Out).

read_file(X):-
		seeing(OldStream),see('C:/Users/Sandu/Desktop/input5.txt'),
		read(X),read(end_of_file),
		seen,see(OldStream).
		
negate(n(A), A) :- !.
negate(A, n(A)).

negate_all([],R,R).
negate_all([H|T],R,R1):-negate(H,P),negate_all(T,[P|R],R1).

member_all([],R).
member_all([H|T],R):-member(H,R),member_all(T,R).

backchaining([],_):-write('backchaining: Pacient has pneumonia'),nl,!.
backchaining([H|T],Kb):-
    member(R,Kb),member(H,R),
    delete(R,H,R1),
    negate_all(R1,[],R2),
    append(R2,T,R3),
    backchaining(R3,Kb).

forwardchaining(G,S,Kb):-member(pneumonia,S),write('forwardchaining: Pacient has pneumonia'),nl,!.
forwardchaining(G,S,Kb):-
    member(R,Kb),member(H,R),
    delete(R,H,R1),
    negate_all(R1,[],R2),
    member_all(R2,S),
    \+member(H,S),
    append([H],S,S1),
    forwardchaining(G,S1,Kb).


solve():- read_file(F), questions(A), append(F,A,Kb),flatten(A,S),
	(backchaining([pneumonia],Kb),!;write('backchaining: Pacient DOESNT have pneumonia'),nl),
	(forwardchaining(pneumonia,S,Kb),!;write('forwardchaining: Pacient DOESNT have pneumonia'),nl),nl,
	retractall(answer(_)),
	solve.    
    
    
    