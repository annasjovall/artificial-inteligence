;;; Number of Swaps

(defun estimated-distance-from-goal (board)
    (defparameter *tboard* (copy-board board))
    (loop for i from 1 to 8 summing 
        (let* ((y (first (find-square i *tboard*)))
            (x (second (find-square i *tboard*)))
            (gy (first (find-square i *goal-state*)))
            (gx (second (find-square i *goal-state*))))
            
            (if (and (= x gx) (= y gy))
                0
                (let ()
                    (setf (aref *tboard* y x) (aref *tboard* gy gx))
                    (setf (aref *tboard* gy gx) i)
                    1)
                ))))
