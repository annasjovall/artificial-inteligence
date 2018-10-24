(deffacts startup
 (animal dog)
 (animal cat)
 (animal duck)
 (animal turtle)
 (warm-blooded dog)
 (warm-blooded cat)
 (warm-blooded duck)
 (lays-eggs duck)
 (lays-eggs turtle)
 (child-of dog puppy)
 (child-of cat kitten)
 (child-of turtle hatchling))

(defrule mammal
 (animal ?name)
 (warm-blooded ?name)
 (not (lays-eggs ?name))
 =>
 (assert (mammal ?name))
 (printout t ?name " is a mammal" crlf))

(defrule mammal2
 (mammal ?name)
 (child-of ?name ?young)
 =>
 (assert (mammal ?young))
 (printout t ?young " is a mammal" crlf))

(defrule what-is-child
    (animal ?name)
    (not (child-of ?name ?))
    =>
    (printout t "What do you call the child of a " ?name "?")
    (assert (child-of ?name (read))))
