;;; Nillson's sequence score

(defun estimated-distance-from-goal (board)
    (+ (sum-of-manhattan-distances board) (* 3 (sequence-score board))))

(defun manhattan-distance (p1 p2)
"given two lists of x-y coords, sum the difference between x's and y's"
  (+ (abs (- (first p1) (first p2)))
     (abs (- (second p1) (second p2)))))

(defun sum-of-manhattan-distances (board)
 (loop for i from 1 to 8 
        summing (manhattan-distance (find-square i board)
                                    (find-square i *goal-state*))))
                                    
(defun sequence-score (board)
    (loop for i from 1 to 8 summing
        (let* 
            ((y (first (find-square i board)))
            (x (second (find-square i board)))
            (next (if (= i 8) 1 (+ i 1)))
            (ny (first (find-square next board)))
            (nx (second (find-square next board))))
            
            ;(format t "~% ~a -> ~a  (~a, ~a) (~a, ~a)" i next y x ny nx)
            (cond 
                ((and (= y 0) (= x 0) (= ny 0) (= nx 1)) 0)
                ((and (= y 0) (= x 1) (= ny 0) (= nx 2)) 0)
                ((and (= y 0) (= x 2) (= ny 1) (= nx 2)) 0)
                ((and (= y 1) (= x 2) (= ny 2) (= nx 2)) 0)
                ((and (= y 2) (= x 2) (= ny 2) (= nx 1)) 0)
                ((and (= y 2) (= x 1) (= ny 2) (= nx 0)) 0)
                ((and (= y 2) (= x 0) (= ny 1) (= nx 0)) 0)
                ((and (= y 1) (= x 0) (= ny 0) (= nx 0)) 0)
                ((and (= y 1) (= x 1)) 1)
                (T 2))
        )))
