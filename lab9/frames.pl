animal(covering, feathers).

fish(a_kind_of, animal).
fish(travel, swim).

bird(a_kind_of, animal).
bird(travel, fly).
bird(covering, feathers).

ostrich(a_kind_of, bird).
ostrich(travel, walk).

penguin(a_kind_of, bird).
penguin(travel, walk).
penguin(color, brown).

opus(a_kind_of, penguin).

canary(a_kind_of, bird).
canary(color, yellow).
canary(sound, sing).

tweety(a_kind_of, canary).
tweety(color, white).

robin(a_kind_of, bird).
robin(sound, sing).
robin(color, red).

/**
 *Gives the subclasses attribute, (overrides the superclasses attribute) 
 */
hasproperty(Frame, Slot, Value) :-
  Query =..[Frame, Slot, Value], 
  call(Query),!.

hasproperty(Frame, Slot, Value) :-
  Query =..[Frame, a_kind_of, Parent],
  call(Query),
  hasproperty(Parent, Slot, Value),!.
