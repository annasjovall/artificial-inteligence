;Extension exercises

;Question 1
(defun my-length (x)
	(cond ((null x) 0)
				(t (+ 1 (my-length (rest x))))))

;Question 2
(defun my-nth (nbr x)
	(cond ((eql nbr 0) (first x))
				(t (my-nth (- nbr 1) (rest x)))))

;Question 3
(defun backwards (x)
	(cond ((null x) ())
				(t (append (backwards (rest x)) (list (first x))))))

;Question 4
(defun smallest (x)
	(cond ((null x) ())
				((null (rest x)) (first x))
				((< (first x) (second x))
				 (smallest (cons (first x) (rest (rest x)))))
				(t (smallest (rest x)))))

;Question 5
(defun nested-backwards (x)
	(cond ((null x) ())
				((atom (first x)) ;could also write (atom (first x) append...
				 (append (nested-backwards (rest x)) (list (first x))))

				(t (append (nested-backwards (rest x)) (list (nested-backwards (first x)))))))
				
