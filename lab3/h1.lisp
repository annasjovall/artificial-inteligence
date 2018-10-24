;;; Tiles out of places
 
(defun estimated-distance-from-goal (board)
  (tiles-out-of-place board))

(defun tiles-out-of-place (board)
"Count the number of tiles out of place"
  (loop for i from 1 to 8 
        summing (if (and (= (first (find-square i board))
                            (first (find-square i *goal-state*)))
                         (= (second (find-square i board))
                            (second (find-square i *goal-state*))))
                    0
                    1)))

	 