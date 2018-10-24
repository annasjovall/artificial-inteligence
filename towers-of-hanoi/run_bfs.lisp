(defun run()
 (load "towers.lisp")
 (load "bfs.lisp")
 (reset-stats) ; reset the statistics
 (breadth-first-search *start-state* *operators*) ; call bfs
 *stats* ; display statistics
)
