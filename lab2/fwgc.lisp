(defparameter *start-state* '(e e e e))

(defparameter *goal-state* '(w w w w))

(defparameter *operators* '(farmer-takes-self farmer-takes-wolf farmer-takes-goat farmer-takes-cabbage))

(defun make-state (f w g c)
	(list f w g c))

(defun farmer-side (state) 
	(nth 0 state))

(defun wolf-side (state)
  (nth 1 state))

(defun goat-side (state)
  (nth 2 state))

(defun cabbage-side (state)
  (nth 3 state))

(defun solution-state? (state)
	(equalp state *goal-state*))

(defun opposite (side)
	(if (eql side 'e)
			'w
			'e))

(defun safe (state)
	(cond ((and (eql (goat-side state) 
									 (wolf-side state))
							(eql (goat-side state) 
									 (opposite (farmer-side state)))) 
						nil)
				((and (eql (goat-side state) 
									 (cabbage-side state))
							(eql (goat-side state) 
									 (opposite (farmer-side state)))) 
						nil)
				(t state)))

(defun farmer-takes-self (state)
	(safe
		(make-state
			(opposite (farmer-side state))
 			(wolf-side state)
 			(goat-side state)
 			(cabbage-side state))))

(defun farmer-takes-wolf (state)
	(eql (farmer-side state)  
			 (wolf-side state))
		(safe
			(make-state
      	(opposite (farmer-side state))
      	(opposite (wolf-side state))
      	(goat-side state)
      	(cabbage-side state))))

(defun farmer-takes-goat (state)
  (eql (farmer-side state)  
       (goat-side state))
    (safe
      (make-state
        (opposite (farmer-side state))
        (wolf-side state)
        (opposite (goat-side state))
        (cabbage-side state))))

(defun farmer-takes-cabbage (state)
  (eql (farmer-side state)
       (cabbage-side state))
    (safe
      (make-state
        (opposite (farmer-side state))
        (wolf-side state)
        (goat-side state)
        (opposite (cabbage-side state)))))


