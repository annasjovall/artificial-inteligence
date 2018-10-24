% grandparent(Grandparent,Grandchild)
% means Grandparent is the grandparent of Grandchild
%
grandparent(Grandparent,Grandchild) :-
  parent(Grandparent,Child),
  parent(Child,Grandchild).

% siblings(Person1, Person2)
% means Person1 is the sibbling of Person2
siblings(Person1, Person2) :-
  parent(Parent, Person1),
  parent(Parent, Person2),
  Person1 \== Person2.

% older(Person1,Person2)
% means Person1 is older than Person2
older(Person1,Person2) :-
  yearOfBirth(Person1, BY1),
  yearOfBirth(Person2, BY2),
  BY1 < BY2.

% olderSibling(Person1, Person2)
% means Person1 is an older sibling of Person2
olderSibling(Person1, Person2) :-
  siblings(Person1, Person2),
  older(Person1, Person2).

% ancestor(Person1, Person2)
% means Person1 is an ancestor of Person2
ancestor(Person1, Person2) :-
  parent(Person1, Person2).

ancestor(Person1, Person2) :-
  parent(Person1, Person3),
  ancestor(Person3, Person2).

% parent(Parent, Child) means Parent is a parent of Child
%
parent(elizabeth, charles).
parent(elizabeth, andrew).
parent(elizabeth, edward).
parent(elizabeth, anne).
parent(philip, charles).
parent(philip, andrew).
parent(philip, edward).
parent(philip, anne).
parent(charles, william).
parent(charles, harry).
parent(william, george).
parent(william, charlotte).
parent(andrew, eugenie).
parent(andrew, beatrice).

% male(X) means X is male
%
male(philip).
male(charles).
male(andrew).
male(edward).
male(william).
male(george).
male(harry).

% female(X) means X is female
%
female(elizabeth).
female(anne).
female(eugenie).
female(beatrice).
female(charlotte).

% yearOfBirth(Person, Year) means yearOfBirth of Person is Year
%
yearOfBirth(elizabeth, 1925).
yearOfBirth(philip, 1921).
yearOfBirth(charles, 1948).
yearOfBirth(anne, 1950).
yearOfBirth(andrew, 1960).
yearOfBirth(edward, 1964).
yearOfBirth(george, 2013).
yearOfBirth(andrew, 1948).
yearOfBirth(william, 1982).
yearOfBirth(harry, 1984).
yearOfBirth(eugenie, 1990).
yearOfBirth(beatrice, 1988).
yearOfBirth(charlotte, 2015).
