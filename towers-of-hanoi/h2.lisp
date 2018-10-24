;;;;Second Heuristic

;;;Estimated-Distance-From-Goal takes a state as a parameter, and returns an estimate of number of steps required to get from this state to the goal.
(defun estimated-distance-from-goal (state)
  (h2 state))

;;;H2 takes a state as parameter. Returns the number of disks on top of the largest disk
(defun h2 (state)
  (let ((A (peg-A state))
        (B (peg-B state))
        (C (peg-C state)))

    (cond ((eq *size* (bottom-disk A));Largest disk is on peg A 
             (- (length A) 1))
          ((eq *size* (bottom-disk B));Largest disk is on peg B 
             (- (length B) 1))
          ((eq *size* (bottom-disk C));Largest disk is on peg C
             (- (length C) 1)))))
