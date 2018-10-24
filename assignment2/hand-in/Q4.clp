;;====================================================
;;  CLASSIC RUSSIAN BOOKS RECOMMENDING EXPERT SYSTEM
;;
;;  This expert system will recommend you a 
;;  classic russian book from the 19-20th century.
;;
;;
;;  Created by: Anna Palmqvist Sjövall
;;  StudentID: 19832192
;;
;;====================================================

;****************
;* 	  INTRO 	*
;****************
(defrule system-intro
	(declare (salience 20))
	=>
	(printout t crlf crlf)
	(printout "Welcome to the Classic Russian Books Recommending Expert System!" crlf)
	(printout t "_____________________________________________________________")
	(printout t crlf crlf))

(defrule get-name
	(declare (salience 19))
	(not (name ?name))
	=> 
	(printout t "What is your name?")
	(assert (name (read))))

(defrule greeting
	(declare (salience 19))
	(name ?name)
	=> 
	(printout t "Hello " ?name)
	(printout t crlf))


;****************
;*    RULES     *
;****************
(defrule read-19th-century-books
	(declare (salience 5))
	(not (recommendation ?rec))
	(easy-read n)
	=>
	(printout t "You can read a book from the 19th century (golden era)." crlf crlf)
	(assert (read-century 19)))

(defrule read-which-century-books
	(declare (salience 5))
	(not (recommendation ?rec))
	(easy-read y)
	=>
	(printout t "You will apprichiate a book from the 20th century more (silver era)." crlf crlf)
	(assert (read-century 20)))

(defrule rec-idiot
	(declare (salience 5))
	(not (recommendation ?rec))
	(read-century 19)
	(like-good-bad y)
	=>
	(printout t "You should read The Idiot by Dostoyevsky." crlf crlf)
	(assert (recommendation the-idiot)))

(defrule tol-and-dost-complicated
	(declare (salience 5))
	(not (recommendation ?rec))
	(read-century 19)
	(like-good-bad n)
	(read-book n)
	=> 
	(printout t "You might find Tolstoy and Dostoyevsky's books a bit too hard to read." crlf crlf)
	(assert (tol-dos complicated)))

(defrule still-able-to-read-complicated-tol-dos
	(declare (salience 5))
	(read-book n)
	(tiresome n)
	=>
	(assert (handle complicated)))

(defrule handle-tol-and-dos
	(declare (salience 5))
	(not (recommendation ?rec))
	(or (read-book y)
	    (handle complicated))
	=>
	(printout t "You should be able to handle Tolstoy and Dostoyevsky's more complicated works." crlf crlf)
	(assert (works complicated)))

(defrule rec-war-and-peace
	(declare (salience 5))
	(not (recommendation ?rec))
	(works complicated)
	(book-feeling 2)
	=>
	(printout t "You should read a book by Tolstoy called War and Peace." crlf crlf)
	(assert (recommendation war-and-peace)))

(defrule rec-brothers
	(declare (salience 5))
	(not (recommendation ?rec))
	(works complicated)
	(book-feeling 1)
	=>
	(printout t "You should read a book by Dostoyevsky called The Brothers Karamazov." crlf crlf)
	(assert (recommendation brothers-karamazov)))


(defrule easier-book-from-19th-century
	(declare (salience 5))
	(not (recommendation ?rec))
	(tol-dos complicated)
	(tiresome y)
	=>
	(printout t "You should read an 'easier' book from Tolstoy or Dostoyevsky." crlf crlf)
	(assert (tol-dos easy)))


(defrule rec-anna-karenia
	(declare (salience 5))
	(not (recommendation ?rec))
	(tol-dos easy)
	(romance y)
	=>
	(printout t "You should read Anna Karenia by Tolstoy." crlf crlf)
	(assert (recommendation anna-karenia)))

(defrule rec-crime-and-punishment
	(declare (salience 5))
	(not (recommendation ?rec))
	(tol-dos easy)
	(rommance n)
	=>
	(printout t "You should read Crime and Punishment by Dostoyevsky." crlf crlf)
	(assert (recommendation crime-and-punishment)))

(defrule empathize-bad-character
	(declare (salience 5))
	(not (recommendation ?rec))
	(read-century 20)
	(hate-feel-uncom ?uncomfortable)
	=>
	(assert (mind-empathizing ?uncomfortable)))

(defrule rec-lolita
	(declare (salience 5))
	(not (recommendation ?rec))
	(mind-empathizing n)
	(know-christ n)
	=>
	(printout t "You should read Lolita by Nabokov." crlf crlf)	
	(assert (recommendation lolita)))

(defrule rec-master-and-margarita
	(declare (salience 5))
	(not (recommendation ?rec))
	(or (mind-empathizing y)
		(know-christ y))
	=>
	(printout t "You should read The Master and Margarita by Boslov." crlf crlf)
	(assert (recommendation the-master)))

;****************
;*   INPUT      *
;****************
(defrule get-easy-to-read
    (not (recommendation ?rec))
    (not (easy-read ?easy))
    =>
    (printout t "Would you like a book that is easier to read? (y/n)" crlf)
    (assert (easy-read (read))))

(defrule get-hate-feel-uncom
    (not (recommendation ?rec))
    (not (hate-feel-uncom ?un))
    =>
    (printout t "Do you hate feeling uncomfortable when reading a book? (y/n)" crlf)
    (assert (hate-feel-uncom (read))))

(defrule get-like-good-bad
    (not (recommendation ?rec))
    (not (like-good-bad ?lgb))
    =>
    (printout t "Do you like good/bad and christian themes? (y/n)" crlf)
    (assert (like-good-bad (read))))


(defrule get-know-christ
    (not (recommendation ?rec))
    (not (know-christ ?kc))
    =>
    (printout t "Do you have knowledge about christianity (e.g who Pontius Pilate is? (y/n)" crlf)
    (assert (know-christ (read))))

(defrule get-read-book
    (not (recommendation ?rec))
    (not (read-book ?rb))
    =>
    (printout t "Have you read a book by Dostoyevsky or Tolstoy before? (y/n)" crlf)
    (assert (read-book (read))))

(defrule get-tiresome
    (not (recommendation ?rec))
    (not (tiresome ?tire))
    =>
    (printout t "Do you find long epic descriptions and storylines tiresome? (y/n)" crlf)
    (assert (tiresome (read))))

(defrule get-book-feeling
    (not (recommendation ?rec))
    (not (book-feeling ?bf))
    =>
    (printout t "Would you rather feel 1.nervous,afraid and extatic or 2.at ease with the universe? (1/2)" crlf)
    (assert (book-feeling (read))))

(defrule get-romance
    (not (recommendation ?rec))
    (not (romance ?rom))
    =>
    (printout t "Do you like romantic books? (y/n)" crlf)
    (assert (romance (read))))

