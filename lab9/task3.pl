mammal(has-hair, yes).
mammal(lactates, yes).

elephant(a_kind_of, mammal).
elephant(tail, 1).
elephant(skin, grey).
elephant(legs, 4).
elephant(trunk, 1).

e1(a_kind_of, elephant).
e1(name, clyde).
e1(friends, clement).
e1(legs, 3).

hasproperty(Frame, Slot, Value) :-
  Query =..[Frame, Slot, Value],
  call(Query),!.

hasproperty(Frame, Slot, Value) :-
  Query =..[Frame, a_kind_of, Parent],
  call(Query),
  hasproperty(Parent, Slot, Value),!.
