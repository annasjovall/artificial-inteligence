;;;-----------------------------------------------------------------------------

;;; This file contains code for the game of tic-tac-toe.
;;; The important functions are:
;;;
;;; (deep-enough pos depth)	  t if the search has proceeded deep enough.
;;; (static pos player)		  evaluation of position pos from player's point of view.
;;; (movegen pos player)	  generate all successor positions to pos.
;;; (opposite player)		  return the opposite player.
;;; (print-board pos)		  print board position pos.
;;; (make-move pos player move) return new position based on old position and 
;;;				        player's move.
;;; (won? pos player)		  t if player has won.
;;; (drawn? pos)		 	  t if pos is a drawn position.
;;;
;;;The important variables are:
;;;
;;; *start*			the initial board configuration.
;;;
;;;These functions and variables are all called from minimax.lisp.
;;;
;;;----------------------------------------------------------------------------

;; Function NULL-BOARD creates an empty tic-tac-toe board. The board is 
;; stored as a list of nine elements.  Elements are either 'x, 'o, or nil 
;; (empty).

(defun null-board ()
  (list nil nil nil nil nil nil nil nil nil))

;; Variable *START* is the starting board position.

(defparameter *start* (null-board))


;; Variable *ttt-lines* is a list of all of the wining lines.

(defparameter *ttt-lines* '((0 1 2)
                            (3 4 5)
                            (6 7 8)
                            (0 3 6)
                            (1 4 7)
                            (2 5 8)
                            (0 4 8)
                            (2 4 6)))

;; Predicate LEGAL-MOVE? takes a board position (pos), a player (player, which 
;; is 'x or 'o), and a move (which is a number between 0 and 8). It returns 
;; T if the move is legal, and nil otherwise.

(defun legal-move? (pos player move)
   (eq (nth move pos) nil))

   
;; Function MAKE-MOVE takes a board position (pos), a player (player, which 
;; is 'x or 'o), and a move (which is a number between 0 and 8). If the move is  
;; legal it returns a new board position. Note that copy-list is a built-in function.

(defun make-move (pos player move)
 (when (legal-move? pos player move)
   (let ((b (copy-list pos)))
     (setf (nth move b) player) 
     b)))

	 
;; Function MOVEGEN takes a position and a player and generates all legal 
;; successor positions, i.e., all possible moves a player could make.

(defun movegen (pos player)
  (movegen-helper pos player '(0 1 2 3 4 5 6 7 8)))

  
;; MOVEGEN-HELPER Iterates through the complete list of moves. 
;; Whenever a legal move is found,that move is cons'ed into the list moves
(defun movegen-helper (pos player lst)
  (let ((moves ())) ; local variable moves will be used to store the list
                    ; of possible moves  
    (dolist (m lst)
      (when (legal-move? pos player m)
		(setf moves (cons (make-move pos player m) moves))))
   moves))

   
;; Function WON? returns t is pos is a winning position for player,
;; nil otherwise.

(defun won? (pos player)
  (won-helper pos player *ttt-lines*))
  
(defun won-helper (pos player win-lines)
 (let* ((line (first win-lines))
        (a (first line))
        (b (second line))
        (c (third line)))
  (cond ((null line) nil)
        ((and (eq (nth a pos) player)
		      (eq (nth b pos) player)
              (eq (nth c pos) player)) t)
		(t (won-helper pos player (rest win-lines))))))

		   
;; Function DRAWN? returns t if pos is a drawn position, i.e., if there are
;; no more moves to be made.

(defun drawn? (pos)
  (not (member nil pos)))


;; Function OPPOSITE returns 'x when given 'o, and vice-versa.

(defun opposite (player)
  (if (eq player 'x) 'o 'x))


;; Function PRINT-BOARD prints a two-dimensional representation of the board.

(defun print-board (b)
  (format t "~% ~d ~d ~d   0 1 2~% ~d ~d ~d   3 4 5~% ~d ~d ~d   6 7 8~%~%"
	  (or (nth 0 b) ".") (or (nth 1 b) ".") (or (nth 2 b) ".")
	  (or (nth 3 b) ".") (or (nth 4 b) ".") (or (nth 5 b) ".")
	  (or (nth 6 b) ".") (or (nth 7 b) ".") (or (nth 8 b) ".")))

;;; Static evaluation
;;; 1. If player wins, 10000 points
;;; 2. If opponent wins, -10000 points
;;; 3. If drawn, 0
;;; 4. Otherwise
;;;    subtract "board-value" of opponent from score of player
;;;    where board value is taken as the sum of line score for each line,
;;;    where linescore is 0 if the opponent has a piece in the line, 
;;;    and otherwise is the number of pieces you have in the line.

(defparameter *max-depth* 2)  ; must be at least 1

(defun deep-enough (pos depth)
  (or (won? pos 'x) 
      (won? pos 'o)
      (drawn? pos)
      (>= depth *max-depth*)))

(defun static (pos player)
  (cond ((won? pos player) 10000)
        ((won? pos (opposite player)) -10000)
        ((drawn? pos) 0)
        (t (- (board-value pos player)
              (board-value pos (opposite player))))))

(defun board-value(pos player)
   (sum
      (mapcar #'(lambda(x) (line-score pos player x)) *ttt-lines*)))

;; Implements Eval = 3X_2 + X_1 - (3O_2 + O_1)
(defun line-score(pos player line)
  (let* ((p1 (nth (first line) pos))
         (p2 (nth (second line) pos))
         (p3 (nth (third line) pos))
         (pieces (list p1 p2 p3))
         (good (count player pieces)))
    (cond ((member (opposite player) pieces) 0)
          ((= good 1) good) 
          (t (* 3 good))))) 
    ;(if (member (opposite player) pieces)
     ; 0
     ; good)))

	  
;; Function SUM takes a list of numbers and returns the sum of the 
;; elements of the list.
  
(defun sum(lis)
   (cond ((null lis) 0)
         (t (+ (car lis)
               (sum (cdr lis)))))) 
