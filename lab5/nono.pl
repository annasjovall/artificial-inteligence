nation(nono).
nation(america).
american(west).
enemy(nono, america).
owns(nono, m1).
missile(m1).

sells(west, X, nono) :-
  owns(nono, X),
  missile(X).

weapon(X) :-
  missile(X).

hostile(X) :-
  enemy(X, america).

criminal(Country) :-
  american(Country),
  weapon(Y),
  nation(Z),
  hostile(Z),
  sells(Country, Y, Z).
