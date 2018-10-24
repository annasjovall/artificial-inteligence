;;;;Fifth Heuristic

;;;Estimated-Distance-From-Goal takes a state as a parameter, and returns an estimate of number of steps required to get from this state to the goal.
(defun estimated-distance-from-goal (state)
  (h5 state))

;;;H5 takes a state as parameter. Returns size - the correct placed disks on peg C.
(defun h5 (state)
  (- *size* (correctly-placed state)))

;;;Correctly-placed takes a state and returns the number of correct placed disks on peg C.
(defun correctly-placed (state)
  (let ((c (reverse (peg-C state)))             ;the disks on peg-C in reversed order
        (c-goal (reverse (peg-C *goal-state*))));the goal order of disks on peg-C in reversed order
    (comp-lists c c-goal)))

;;;Comp-List takes two lists of disks, c-peg and c-goal-peg. The lists are in reversed order. Returns the number of corrected placed disks on peg C (ordering matters).
(defun comp-lists (c-peg c-goal-peg)
  (cond ((null (top c-peg)) 0)
        ((null (top c-goal-peg)) 0)
        ;;If the elements are not equal, the function stops counting
        ((not (eq (top c-peg) (top c-goal-peg))) 0)
        (t (+ 1 (comp-lists (rm-top c-peg) (rm-top c-goal-peg))))))
