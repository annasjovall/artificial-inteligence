;new functions using defun
;cond (conditional branching)
(defun absolute-value (x)
	(cond ((< x 0) (* -1 x))
		  ((>= x 0) x)
		  (t x))) ;default action

(defun absolute-value2 (x)
	(if (< x 0)
		(* -1 x);if true
		x));if false

;predicate: function that returns true or false (t or nil)

(list 1 2 3 4 5) ;creates list
(car (list 1 2 3)) ;returns first elem (same as first)
(cdr (list 1 2 3)) ;returns all elem except first (same as rest)
(cons 1 (list 2 3 4 5 6)) ;adds 1 to the list (concatinates)
(append (list 1 2 3) (list 4 5 6)) ;creates new list with both elem
(nth 0 (list 1 2 3)) ;returns elem at place 0 (1 in this case)
(length (list 1 2))
(member 7 (list 1 4 7 8)) ;checks if 7 is in the list, otherwise return nil
(null (list 1 2 3)) ;checks if list is empty

(setf x 1) ;then x is 1
(defparameter *start-state* (list 0 0)) ;creates global and immutable variable *start-state*. Better style than setf.

(let temp 4) ;creates local varible temp=4
(let* ((a 2)
      (b (* a a))) ;let* allows you to use the local a in the def of local b

;When a function is passed as a parameter, the name of the function should be preceeded by a #’
(defun square (x) (* x x))
(mapcar #’square ‘(1 2 3 4 5)) ;mapcar maps a function over a list

(defstruct person
    first
    last
    age)

(defparameter *p1*
    (make-person
        :first ‘fred
        :last ‘jones
        :age 27))

(person-first *p1*)
