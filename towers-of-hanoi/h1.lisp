;;;;First Heursistic

;;;Estimated-Distance-From-Goal takes a state as a parameter, and returns an estimate of number of steps required to get from this state to the goal.
(defun estimated-distance-from-goal (state)
  (h1 state))

;;;H1 takes a state as parameter. It returns the number of disks on a peg other than the goal peg.
(defun h1 (state)
  (+ (length (peg-A state)) (length (peg-B state))))

