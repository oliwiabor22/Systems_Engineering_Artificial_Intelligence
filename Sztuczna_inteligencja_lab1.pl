pierwiastek1(A,B) :-
	B is sqrt(A).

pierwiastek2(C,D) :-
	D is (C) ** (1/2).

logarytm(E,F) :-
	F is log(E).

liniowa(A,B,X) :- 
	A =\= 0,
	X is -B/A.

kwadratowa(A,B,C,X1,X2) :-
	A =\= 0,
	Delta is B**2 - 4*A*C,
	Delta >= 0,
	X1 is (-B + sqrt(Delta)) / (2*A),
	X2 is (-B - sqrt(Delta)) / (2*A).