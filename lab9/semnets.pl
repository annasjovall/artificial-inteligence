isa(bird, animal).
isa(fish, animal).
isa(ostrich, bird).
isa(penguin, bird).
isa(opus, penguin).
isa(canary, bird).
isa(tweety, bird).
isa(robin, bird).

hasprop(bird, travel, fly).
hasprop(bird, cover, feathers).
hasprop(animal, covering, skin).
hasprop(fish, travel, swim).
hasprop(ostrich, travel, walk).
hasprop(penguin, travel, walk).
hasprop(penguin, color, brown).
hasprop(tweety, color, white).
hasprop(canary, color, yellow).
hasprop(canary, sound, sing).
hasprop(robin, sound, sing).
hasprop(robin, color, red).

hasproperty(Object, Property, Value) :-
 hasprop(Object, Property, Value).

hasproperty(Object, Property, Value) :-
 isa(Object, Parent),
 hasproperty(Parent, Property, Value).

