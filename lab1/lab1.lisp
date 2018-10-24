;;Question 1
(defun sphere-volume (radius)
	(/ (* 4 pi (expt radius 3)) 3))

;;Question 2
(defun shell-volume (inner-radius outer-radius)
	(- (sphere-volume outer-radius) (sphere-volume inner-radius)))

;;Question 3
(defun distance-between-points (x1 y1 x2 y2)
	(sqrt (+ (expt (- x2 x1) 2) 
		 (expt (- y2 y1) 2))))

;;Question 4
;Put ? after function if it is a predicate (return true or false)
(defun speeding? (kph)
	(> kph 60))

;;Question 5
(defun close? (a b)
	(< (abs (- a b)) 0.001))

;;Question 6
(defun close2? (n1 n2 limit)
        (< (abs (- n1 n2)) limit))

;;Question 7
(defun factorial (n) 
	(if (< n 1) 1 
		    (* n (factorial (- n 1))))) 

;;Question 8
(defun fibonacci (n)
	(if (= n 0) 0
		(if (= n 1) 1 
			(+ (fibonacci (- n 1)) (fibonacci (- n 2))))))

;;Question 8 - using cond
(defun fibonacci-cond (n)
    (cond ((= n 0) 0)
        ((= n 1) 1)
		(t (+ (fibonacci (- n 1)) (fibonacci (- n 2))))))

;;Question 9
(defun sqrt-newton (guess x)
	(if (good-enough? guess x)
		guess
		(sqrt-newton (improve guess x) x)))

(defun good-enough? (guess x)
	(close? (expt guess 2) x))

(defun improve (guess x)
	(average guess (/ x guess)))

;Takes two numbers, x, y and returns the average of them
(defun average (x y)
	(/ (+ x y) 2))

;;Question 10
(defun mysqrt (x)
	(sqrt-newton 20 x))

;;Extention Exercise 1
(defun factorial2 (n)
	"Implementation of factorial, pass n and 1"
	(fact-helper n 1))
#|
Help function for factorial2, recursive
|#
(defun fact-helper (count result)
	"If n is 0, return result"
	(cond ((= count 0) result)
		;If n != 0, reduce count by 1 continue recursion
		;The t ensures the last action is performed if none other would 
		(t (fact-helper (- count 1) (* count result)))))

;;Extention Exercise 2
#|
Tail recursion: Perform calculations first, then execute the recursive call, passing the results of the current step to the next recursive step. E.g. in the different factorial functions, the first one used regular recursion and the other one tail recursion. Adavantage is optimization, the program does not need to save the previous stack frame => requires less memory. However, it is harder to write.

factorial1:
	3 * factorial (2) -saves every stack frame
	2 * factorial (1)
	1 * factorial (0)
	1 * 1

	=> (1*1) * 1 * 2 * 3 

factorial2:
	fact-helper (2, 3*1)
	fact-helper (1, 2*3*1)
	fact-helper (0, 1*2*3*1)
	=> 1*2*3*1
|#

;;Extension Exercise 3
#| 
Is sqrt-newton tail recursive?
-Yes it is, we do not keep track of the previous stack frame as we calculate the new guess and then send it in to the function.

> (sqrt-newton 8 25)
2. Trace: (SQRT-NEWTON '8 '25)
3. Trace: (SQRT-NEWTON '89/16 '25)
4. Trace: (SQRT-NEWTON '14321/2848 '25)
5. Trace: (SQRT-NEWTON '407868641/81572416 '25)
5. Trace: SQRT-NEWTON ==> 407868641/81572416
4. Trace: SQRT-NEWTON ==> 407868641/81572416
3. Trace: SQRT-NEWTON ==> 407868641/81572416
2. Trace: SQRT-NEWTON ==> 407868641/81572416

-So it was not tail recursive. Perhaps it is because we return 'guess' in each layer as we go back. For factorial2, we stop everything once we reached the answer.
|#
