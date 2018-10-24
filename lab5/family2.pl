family(john,mary,c(tom,c(jim,none))).
family(fred,betty,c(alice,none)).
family(bill,sue,none).

father(X,Y) :-
  family(X,_,Children),
  among(Y,Children).

among(X,c(X,Y)).
among(X,c(_,Z)) :-
  among(X,Z).

% husband(X)
% means that X is a husband
husband(X) :-
  family(X, _, _).

% wife(X)
% means that X is a wife
wife(X) :-
  family(_, X, _).

% parent(Parent, Child)
% means Parent is a parent of child
parent(Parent, Child) :-
  father(Parent, Child).

parent(Parent, Child) :-
  family(_, Parent, Children),
  among(Child, Children).
  
% siblings(Person1, Person2)
% means Person1 is sibling of Person2
siblings(Person1, Person2) :-
  parent(P, Person1),
  parent(P, Person2),
  Person1 \== Person2.
