;;;;Fourth Heuristic

;;;Estimated-Distance-From-Goal takes a state as a parameter, and returns an estimate of number of steps required to get from this state to the goal.
(defun estimated-distance-from-goal (state)
  (h4 state))

;;;H4 takes a state as a parameter. Returns 2^(k-1), where k is the largest misplaced disk (that is, the largest disk not placed on peg C). Based on that the optimal amount of moves is (2 ^ size) - 1.
(defun h4 (state)
  (let* ((A (peg-A state))
         (B (peg-B state))
         (a (bottom-disk A))
         (b (bottom-disk B)))
    (cond ((and (null A) (null B)) ;Both Peg A and B empty 
            0)
          ((null a)                ;Only Peg A empty
            (expt 2 (- b 1)))
          ((null b)                ;Only Peg B empty
            (expt 2 (- a 1)))
          ((< a b)                 ;Peg B has the largest disk
            (expt 2 (- b 1)))
          (t                       ;Peg A has the largest disk
            (expt 2 (- a 1))))))
