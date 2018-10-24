(deffacts startup
    (animal-has webbed-feet)
    (animal-has feathers))

(defrule duck
    (animal-is duck)
    =>
    (assert (sound-is quack)))

(defrule is-it-a-duck
    (animal-has webbed-feet)
    (animal-has feathers)
    =>
    (assert (animal-is duck)))

