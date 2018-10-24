(defparameter *simple*
  (make-array '(3 3)
    :initial-contents '((1 3 4)(8 6 2)(7 space 5))))

(defparameter *moderate*
 (make-array '(3 3)
 :initial-contents '((2 8 1)(space 4 3)(7 6 5))))

(defparameter *difficult*
 (make-array '(3 3)
 :initial-contents '((2 8 1)(4 6 3)(space 7 5))))

(defparameter *worst*
 (make-array '(3 3)
 :initial-contents '((5 6 7)(4 space 8)(3 2 1))))

(defun run()
 (load "8puzzle.lisp")
 (load "a-star.lisp")
 (reset-stats) ; reset the statistics
 (setf *start-state* *worst*) ; set starting node
 (load "h5.lisp") ; Load the heuristic. This must
 ; be done after loading 8puzzle.lisp
 (a-star *start-state* *eight-puzzle-operators*) ; call a-star
 *stats* ; display statistics
)
