(defun run()
 (load "towers.lisp")
 (load "a-star.lisp")
 (reset-stats) ; reset the statistics
 (a-star *start-state* *operators*) ; call a-star
 *stats* ; display statistics
)
