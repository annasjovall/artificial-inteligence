;;;; Solver for Towers of Hanoi problem, compatible with both a-star and breadth-first-search. 

;;;;Created by: Anna Palmqvist Sjövall
;;;;StudentID: 19832192



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;Represents size of puzzle
(defparameter *size* 8)

;;;Create-Array takes a size n (an integer greater or equal to 1) and creates a list with integers in acending order from n to 1. E.g. input 3 returns the list (1 2 3).
;;;Returns a list of integer elements in acending order, nil if input n < 1.
(defun create-array (n)
  (cond ((< n 1) nil)
        ((= n 1) (list 1))
        (t (append (create-array (- n 1)) (list n)))))

;;;Make-State takes a list of disks for each peg and makes a state of it.
;;;Returns the state
(defun make-state (a b c)
  (list a b c))

;;;Represents the initial state
(defparameter *start-state* (make-state (create-array *size*) () ()))
;;;Represents the goal state
(defparameter *goal-state* (make-state ()()(create-array *size*)))
;;;Represents the different possible operators
(defparameter *operators* '(move-A-to-B move-A-to-C move-B-to-A move-B-to-C move-C-to-A move-C-to-B))

;;;Legal-Move? takes arguments: from and to, which are the lists corresponding to source and destination pegs for a possible move. 
;;;Return T if the top disk on from may legally be moved to 'to', and nil otherwise.
(defun legal-move? (from to)
  (cond ((null from) nil)
        ((null to) T)
        (t (< (top from) (top to)))))

;;;Peg-A takes a state and returns the list of disks on peg A.
(defun peg-A (state)
  (first state))

;;;Peg-B takes a state and returns the list of disks on peg B.
(defun peg-B (state)
  (second state))

;;;Peg-C takes a state and returns the list of disks on peg C.
(defun peg-C (state)
  (third state))

;;;Rm-Top takes a list of disks from a peg and returns a new list without the first element.
(defun rm-top (peg)
  (cdr peg))

;;;Add-Top takes a disk(top) and a list of disks on a peg. Returns a new list of disks with the disk added first.
(defun add-top (top peg)
  (cons top peg))

;;;Top takes list of disks on a peg and returns the top disk.
(defun top (peg)
  (first peg))

;;;Bottom-disk takes a list of disks on a peg and returns the peg on the bottom. If there is no disk, null is returned.
(defun bottom-disk (peg)
  (cond ((null peg) nil)
        (t (nth (- (length peg) 1) peg))))

;;;Move-A-To-B takes a state as input. If the top disk from peg A can be legally moved to peg B this new state is returned. Otherwise returns nil.
(defun move-A-to-B (state)
  (if (legal-move? (peg-A state) (peg-B state)) 
    (make-state (rm-top (peg-A state))                     ;remove top of A
                (add-top (top (peg-A state)) (peg-B state));add top of A to B
                (peg-C state))))                           ;include pile C

;;;Move-A-To-C takes a state as input. If the top disk from peg A can be legally moved to peg C this new state is returned. Otherwise returns nil.
(defun move-A-to-C (state)
  (if (legal-move? (peg-A state) (peg-C state))
    (make-state (rm-top (peg-A state))                        ;remove top of A
                (peg-B state)                                 ;include pile B
                (add-top (top (peg-A state)) (peg-C state)))));add top of A to C

;;;Move-B-To-C takes a state as input. If the top disk from peg B can be legally moved to peg C this new state is returned. Otherwise returns nil.
(defun move-B-to-C (state)
  (if (legal-move? (peg-B state) (peg-C state))
    (make-state (peg-A state)                                 ;include pile A
                (rm-top (peg-B state))                        ;remove top of B
                (add-top (top (peg-B state)) (peg-C state)))));add top of B to C

;;;Move-B-To-A takes a state as input. If the top disk from peg B can be legally moved to peg A this new state is returned. Otherwise returns nil.
(defun move-B-to-A (state)
  (if (legal-move? (peg-B state) (peg-A state))
    (make-state (add-top (top (peg-B state)) (peg-A state));add top of B to A
                (rm-top (peg-B state))                     ;remove top of B
                (peg-C state))))                           ;include pile C

;;;Move-C-To-A takes a state as input. If the top disk from peg C can be legally moved to peg A this new state is returned. Otherwise returns nil.
(defun move-C-to-A (state)
  (if (legal-move? (peg-C state) (peg-A state))
    (make-state (add-top (top (peg-C state)) (peg-A state));add top of C to A
                (peg-B state)                              ;include pile B
                (rm-top (peg-C state)))))                  ;remove top of C

;;;Move-C-To-B takes a state as input. If the top disk from peg C can be legally moved to peg B this new state is returned. Otherwise returns nil.
(defun move-C-to-B (state)
  (if (legal-move? (peg-C state) (peg-B state))
    (make-state (peg-A state)                              ;include pile A
                (add-top (top (peg-C state)) (peg-B state));add top of C to B
                (rm-top (peg-C state)))))                  ;remove top of C

;;;Solution-State? takes a state as input. Returns T if the input state is the solution state, otherwise nil.
(defun solution-state? (state)
  (equalp state *goal-state*))

;;;Cost-Of-Applying-Operator takes a state and an operator as input parameters, and return the cost of applying the operator to that state, which is always 1. 
(defun cost-of-applying-operator (state operator) 1)

;;;Estimated-Distance-From-Goal takes a state as a parameter, and returns an estimate of number of steps required to get from this state to the goal.
(defun estimated-distance-from-goal (state) 
  (heuristic state))

;;;Heuristic takes a state as a parameter. Returns (2^k) -1, where k is the largest misplaced disk (that is, the largest disk not placed on peg C). Based on that the optimal amount of moves from the start state is (2 ^ nbr of disks) - 1 [According to Hinz, A.M. Computing (1989) 42: 133. https://doi.org/10.1007/BF02239743]
(defun heuristic (state)
  (let* ((A (peg-A state))
         (B (peg-B state))
         (a (bottom-disk A))
         (b (bottom-disk B)))
    (cond ((and (null A) (null B));Peg A and B empty (goal state)
            0)
          ((null A)               ;Peg A is empty 
            (- (expt 2 b) 1))
          ((null B)               ;Peg B is empty
            (- (expt 2 a) 1))
          ((> a b)                ;Peg A has the largest disk
            (- (expt 2 a) 1))
          (t                      ;Peg B has the largest disk
            (- (expt 2 b) 1)))))

