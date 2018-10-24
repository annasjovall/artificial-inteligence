;;;;Third Heuristic

;;;Estimated-Distance-From-Goal takes a state as a parameter, and returns an estimate of number of steps required to get from this state to the goal.
(defun estimated-distance-from-goal (state)
  (h3 state))

;;;H3 takes a state as a parameter. Returns (2^k) -1, where k is the largest misplaced disk (that is, the largest disk not placed on peg C). Based on that the optimal amount of moves is (2 ^ size) - 1.
(defun h3 (state)
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
