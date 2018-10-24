;;;; Heuristic for connect 4 game.

;;;; Created by: Anna Palmqvist Sjövall
;;;; StudentID: 19832192



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Function STATIC evaluates a position from the point of view of a particular player.  It returns a number -- the higher the number, the more desirable the position. If the state is a win we give it a high number (10000) and a loss gets a low number (-10000). The terminal state has utility 0.
;;; The heuristic for non terminal state follows: Eval = (8X_3 + 2X_2 + X_1) - (8O_3 + 2O_2 + O_1).
(defun static (board player)
  (cond ((won? board player) 50000) ;Win for the player 
        ((won? board (opposite player)) -50000) ;Win for the opposite player
        ((drawn? board) 0) ;Draw
        (t (- (board-value board player)
              (board-value board (opposite player))))))

;;; Function BOARD-VALUE accepts a board and a player returns the sum of all possible winning lines scores.
(defun board-value(board player)
  (sum
    (mapcar #'(lambda(x) (line-score board player x)) *all-c4-lines*)))

;;; Function LINE-SCORE accepts a board, player and line and returns the score of that line. If the line contains the opposite player, the score is 0. Only one player gives score 1, two players gives 4 and the rest (3 players) gets a score of 24.
(defun line-score(board player line)
  (let* ((p1 (get-pos board (first line)))
         (p2 (get-pos board (second line)))
         (p3 (get-pos board (third line)))
         (p4 (get-pos board (fourth line)))
         (pieces (list p1 p2 p3 p4 ))
         (good (count player pieces))) ;amount of players pieces in the line
    (cond ((member (opposite player) pieces) 0)
          ((= good 1) good)
          ((= good 2) (* 2 good))
          (t (* 8 good)))))

;;; Function GET-POS accepts a board and a list ij and returns the player in position (i,j), or nil if there is no player in that posiion.
(defun get-pos(board ij) 
  (let ((i (first ij))
        (j (second ij)))
    (getval board i j)))

;;; Function SUM takes a list of numbers and returns the sum of the elements of the list.
(defun sum(lis)
   (cond ((null lis) 0)
         (t (+ (car lis)
               (sum (cdr lis)))))) 

