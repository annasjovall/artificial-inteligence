;;; Sum of Manhattan distances

(defun estimated-distance-from-goal (board)
    (sum-of-manhattan-distances board))

(defun sum-of-manhattan-distances (board)
 (loop for i from 1 to 8 
        summing (manhattan-distance (find-square i board)
                                    (find-square i *goal-state*))))

(defun manhattan-distance (p1 p2)
"given two lists of x-y coords, sum the difference between x's and y's"
  (+ (abs (- (first p1) (first p2)))
     (abs (- (second p1) (second p2)))))
