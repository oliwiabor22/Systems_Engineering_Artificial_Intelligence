% zadanie 1

% baza faktów

osoba(oli, 20).
osoba(hania, 21).
osoba(madzia, 22).
osoba(karolina, 23).
osoba(olgusia, 24).
osoba(oliwka, 25).

mieszka_nad(oli, olgusia).
mieszka_nad(olgusia, karolina).
mieszka_nad(karolina, hania).
mieszka_nad(hania, madzia).
mieszka_nad(madzia, oliwka).

mieszka_pod(oliwka, madzia).
mieszka_pod(madzia, hania).
mieszka_pod(hania, karolina).
mieszka_pod(karolina, olgusia).
mieszka_pod(olgusia, oli).

% baza reguł

mieszka_wyzej(X,Y) :- mieszka_nad(X, Y).
mieszka_wyzej(X,Y) :- mieszka_nad(X, Z), mieszka_wyzej(Z, Y).

mieszka_nizej(X, Y) :- mieszka_pod(X, Y).
mieszka_nizej(X, Y) :- mieszka_pod(X, Z), mieszka_nizej(Z, Y).

% X mieszka_najwyżej, jeśli nie istnieje żadna osoba, która mieszka nad X
% x mieszka najniżej, jeśli nie istnieje żadna osoba, która mieszka pod X

mieszka_najwyzej(X) :- osoba(X, _), \+ mieszka_nad(_, X).
mieszka_najnizej(X) :- osoba(X, _), \+ mieszka_pod(_, X).

jest_starsza(X,Y) :- osoba(X, WX), osoba(Y, WY), WX > WY.
jest_mlodsza(X,Y) :- osoba(X, WX), osoba(Y, WY), WX < WY.

% X jest najstarsza, jeśli nie istnieje żadna osoba o wieku WY, która ma więcej lat niż X
% X jest najmłodsza, jeśli nie istnieje żadna osoba o wieku WY, która ma mniej lat niż X

jest_najstarsza(X) :- osoba(X, WX), \+ (osoba(_, WY), WY > WX).
jest_najmlodsza(X) :- osoba(X, WX), \+ (osoba(_, WY), WY < WX).

% zadanie 2

% baza faktów

mezczyzna(pawel).
mezczyzna(tomasz).
mezczyzna(kazik).
mezczyzna(michal).
mezczyzna(alek).

kobieta(anna).
kobieta(wiktoria).
kobieta(basia).
kobieta(ola).
kobieta(danuta).
kobieta(oliwia).

rodzic(kazik, ola).
rodzic(kazik, michal).
rodzic(basia, ola).
rodzic(basia, michal).
rodzic(tomasz, basia).
rodzic(wiktoria, basia).
rodzic(pawel, kazik).
rodzic(anna, kazik).
rodzic(wiktoria, danuta).
rodzic(tomasz, danuta).
rodzic(danuta, oliwia).
rodzic(alek, oliwia).

wiek(pawel, 88).
wiek(anna, 80).
wiek(tomasz, 77).
wiek(wiktoria, 70).
wiek(kazik, 55).
wiek(basia, 50).
wiek(ola, 30).
wiek(michal, 22).
wiek(danuta, 50).
wiek(alek, 55).
wiek(oliwia, 20).

% a) - (ojciec, matka), dziecko (syn, córka), dziadek, babcia, wujek, ciocia, brat, siostra, kuzyn, kuzynka

% matka lub ojciec

ojciec(X, Y) :- mezczyzna(X), rodzic(X, Y).
matka(X, Y) :- kobieta(X), rodzic(X, Y).

% dziecko

dziecko(X, Y) :- rodzic(Y, X).

% córka lub syn 

corka(X, Y) :- kobieta(X), rodzic(Y, X).
syn(X, Y) :- mezczyzna(X), rodzic(Y, X).

% rodzenstwo - ale nie może to być ta sama osoba

rodzenstwo(X, Y) :-
	rodzic(R, X),
	rodzic(R, Y),
	X \= Y.

% siostra lub brat

siostra(X, Y) :- kobieta(X), rodzenstwo(X, Y).
brat(X, Y) :- mezczyzna(X), rodzenstwo(X, Y).

% babcia lub dziadek to rodzic któregoś rodzica

babcia(X, Y) :- kobieta(X), rodzic(X, Z), rodzic(Z, Y).
dziadek(X, Y) :- mezczyzna(X), rodzic(X, Z), rodzic(Z, Y).

% ciocia lub wujek
% wujek to brat któregoś rodzica

wujek(X, Y) :- mezczyzna(X), rodzic(R, Y), brat(X, R).
% ciocia to siostra któregoś rodzica
ciocia(X, Y) :- kobieta(X), rodzic(R, Y), siostra(X, R).

% kuzynka lub kuzyn, to dziecko rodzeństwa rodzica (czyli dzieci cioci lub wujka)

kuzyn(X, Y) :- mezczyzna(X), rodzic(R, Y), rodzenstwo(R, Q), rodzic(Q, X).
kuzynka(X, Y) :- kobieta(X),  rodzic(R, Y), rodzenstwo(R, Q), rodzic(Q, X).


% b) starszy, młodszy, najstarszy, najmłodszy

% starszy

starszy(X, Y) :-
	wiek(X, WX),
	wiek(Y, WY),
	WX > WY.

% młodszy

mlodszy(X, Y) :-
	wiek(X, WX),
	wiek(Y, WY),
 	WX < WY.

% najstarszy

najstarszy(X) :-
	wiek(X, WX),
	\+ (wiek(_, WY), WY > WX).

% najmłodszy

najmlodszy(X) :-
	wiek(X, WX),
	\+ (wiek(_, WY), WY < WX).

% c) przodek, potomek, głowa rodu (mężczyzna w korzeniu drzewa genealogicznego)

% przodek

przodek(X, Y) :- rodzic(X, Y).
przodek(X, Y) :- rodzic(X, Z), przodek(Z, Y).

% potomek to odwrotność przodka
potomek(X, Y) :- przodek(Y, X).

% głowa rodu to mężczyzna w korzeniu drzewa genealogicznego - mężczyzna bez rodzica w bazie

glowa_rodu(X) :-
	mezczyzna(X),
	\+ rodzic(_, X).