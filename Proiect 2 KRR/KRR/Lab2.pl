to_left(X,Y):- X is Y+1.
to_right(X,Y):- to_left(Y,X).
next_to(X,Y):-to_left(X,Y).
next_to(X,Y):-to_right(X,Y).

solution(Street) :-
    Street = [
			house(1, Color1,  Nationality1,   Drink1,   Smokes1,     Pet1),
			house(2, Color2,  Nationality2,   Drink2,   Smokes2,     Pet2),
            house(3, Color3,  Nationality3,   Drink3,   Smokes3,     Pet3),
            house(4, Color4,  Nationality4,   Drink4,   Smokes4,     Pet4),
            house(5, Color5,  Nationality5,   Drink5,   Smokes5,     Pet5)],
			
			%rules
            member(house(_,   red,    british,     _,         _,     _), Street),
            member(house(A, green,          _,     _,         _,     _), Street),
            member(house(B, white,          _,     _,         _,     _), Street),
            to_left(A,B), 
            member(house(_, green,          _,coffee,         _,     _), Street),
            member(house(3,     _,          _,  milk,         _,     _), Street),
            member(house(_,yellow,          _,     _,   dunhill,     _), Street),
            member(house(1,     _,  norvegian,     _,         _,     _), Street),
            member(house(_,     _,    swedish,     _,         _,   dog), Street),
            member(house(_,     _,          _,     _,  pallmall,  bird), Street),
            member(house(C,     _,          _,     _,   malboro,     _), Street),
            member(house(D,     _,          _,     _,         _,   cat), Street),
            next_to(C,D),
            member(house(_,     _,          _,  beer,  winfield,     _), Street),
            member(house(E,     _,          _,     _,   dunhill,     _), Street),
            member(house(F,     _,          _,     _,         _, horse), Street),
            next_to(E,F),
            member(house(_,     _,     german,     _,  rothmans,     _), Street),
            member(house(G,     _,          _, water,         _,     _), Street),
            next_to(C,G),
    		member(house(_,     _,     danish,     _,         _,     _), Street),
    		member(house(_,     _,          _,   tea,         _,     _), Street),
            member(house(_,  blue,          _,     _,         _,     _), Street),
            member(house(_,     _,          _,     _,         _,  fish), Street).
                                                    
