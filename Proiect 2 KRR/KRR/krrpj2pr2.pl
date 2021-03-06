:- style_check(-singleton).
:-dynamic wm/1.

question1():- 
    write('What is patient temperature? (answer is a number)'),
    read(Inp),(Inp='stop',abort,!;Inp>38,assertz(wm(temperature)),!;!).

question2():- 
    write('For how many days has the patient been sick? (answer is a number)'),
    read(Inp),(Inp='stop',abort,!;Inp>=2,assertz(wm(sick)),!;!).

question3():-
    write('Has patient muscle pain? (answer is yes/no)'),
    read(Inp),(Inp='stop',abort,!;Inp='yes',assertz(wm(muscle_pain)),!;!).

question4():- 
    write('Has patient cough? (answer is yes/no)'),
    read(Inp),(Inp='stop',abort,!;Inp='yes',assertz(wm(cough)),!;!).


read_file(X):-
		seeing(OldStream),see('C:/Users/Sandu/Desktop/input6.txt'),
		read(X),
		read(end_of_file),
		seen,see(OldStream).
		
write_file(Out1,Out2,Out3):-
		telling(OldStream),tell('C:/Users/Sandu/Desktop/output6.txt'),
		write(Out1),nl,
		write(Out2),nl,
		write(Out3),nl,
		told,tell(OldStream).


questions:- question1,question2,question3,question4.

asses([]).
asses([H|T]):-wm(H),asses(T).

my_if(R):- R=[H|_],asses(H).

my_then(R):- R=[_|T],T=[[H|_]|_],\+wm(H),assertz(wm(H)).

run(File):-member(R,File), my_if(R),my_then(R),run(File),\+wm(pneumonia);!.

show(Out):-findall(X, wm(X), Out).

diagnostic():-wm(pneumonia),write('YES'),nl,!;write('NO'),nl,!.

reset_wm():- retractall(wm(_)).

execute:-
	read_file(File),
	show(Initial),questions,
	show(Questions),run(File),
	show(Done),diagnostic,
	write_file(Initial,Questions,Done),
	reset_wm,
	execute.


