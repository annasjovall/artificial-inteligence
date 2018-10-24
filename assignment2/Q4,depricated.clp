;;====================================================
;;  CLASSIC RUSSIAN BOOKS RECOMMENDING EXPERT SYSTEM
;;
;;  This expert system will recommend you a 
;;  classic russian book from the 19-20th century.
;;
;;====================================================

;****************
;*    RULES     *
;****************
(defrule bad-reader
    (declare (salience 5))
    (not (recommendation ?rec))
    (books-per-week ?bpw)
    (old-english ?old)
    (or (test (< ?bpw 1))
        (test (eq ?old y)))
    =>
    (printout t "You are not the greatest reader!" crlf)
    (assert (bad-reader yes)))

(defrule likes-tolstoj
    (declare (salience 5))
    (not (recommendation ?rec))
    (books-per-week ?bpw)
    (poetry ?p)
    (romantic ?r)
    (or (test (>= ?bpw 3)) ;The longest book (and perhaps slowest)
        (test (eq ?p y))
        (test (eq ?r y)))
    =>
    (printout t "You should read Anna Karenina by Leo Tolstoj (Published 1878 and ~864 pages long). 'Anna is a sophisticated woman who abandons her empty existence as the wife of Karenin and turns to Count Vronsky to fulfil her passionate nature - with tragic consequences.'" crlf)
    (assert (recommendation anna)))

(defrule likes-the-brothers-k
    (declare (salience 5))
    (not (recommendation ?rec))
    (likes-dostojevskij yes)
    (family-conflict ?family)
    (test (eq ?family y))
    =>
    (printout t "You should read The Brothers Karamazov by Fyodor Dostoyevsky (Published 1880 and ~796 pages long). 'The Brothers Karamazov is a passionate philosophical novel set in 19th century Russia, that enters deeply into the ethical debates of God, free will, and morality. It is a spiritual drama of moral struggles concerning faith, doubt, and reason, set against a modernizing Russia.'" crlf)
    (assert (recommendation brothers)))

(defrule likes-crime-and-punishment
    (declare (salience 5))
    (not (recommendation ?rec))
    (likes-dostojevskij yes)
    (christ-theme ?theme)
    (test (neq ?theme y))
    =>
    (printout t "You should read Crime and Punishment by Fyodor Dostoyevsky (Published 1866 and ~671 pages long). 'Raskolnikov, an impoverished student living in the St. Petersburg of the tsars, is determined to overreach his humanity and assert his untrammeled individual will. When he commits an act of murder and theft, he sets into motion a story that, for its excruciating suspense, its atmospheric vividness, and its depth of characterization and vision is almost unequaled in the literatures of the world.'" crlf)
    (assert (recommendation crime-punish)))

(defrule likes-lolita
    (declare (salience 5))
    (not (recommendation ?rec)) 
    (christ-theme ?theme)
    (movie-pref ?movie)
    (test (neq ?theme y))
    (or (bad-reader yes)
        (test (eq ?movie y)))
    =>
    (printout t "You should read Lolita by Vladimir Nabokov (Published 1955 and ~471 pages long. 'Humbert Humbert - scholar, aesthete and romantic - has fallen completely and utterly in love with Lolita Haze, his landlady's gum-snapping, silky skinned twelve-year-old daughter. Reluctantly agreeing to marry Mrs Haze just to be close to Lolita, Humbert suffers greatly in the pursuit of romance; but when Lo herself starts looking for attention elsewhere, he will carry her off on a desperate cross-country misadventure, all in the name of Love. Hilarious, flamboyant, heart-breaking and full of ingenious word play, Lolita is an immaculate, unforgettable masterpiece of obsession, delusion and lust.'" crlf)
    (assert (recommendation lolita)))

(defrule likes-dostojevskij
    (declare (salience 5))
    (not (recommendation ?rec))
    (bad-reader ?ans)
    (not (bad-reader yes))
    =>
    (printout t "You probably like Dostojevskijs work." crlf)
    (assert (likes-dostojevskij yes)))

(defrule likes-master-and-margarita
    (declare (salience 5)) 
    (not (recommendation ?rec))
    (absurd ?abs)
    (test (eq ?abs y))
    =>
    (printout t "You should read The Master and Margarita by Mikhail Bulgakov (Published 1967 and ~373 pages long. 'One hot spring, the devil arrives in Moscow, accompanied by a retinue that includes a beautiful naked witch and an immens talking black cat with a fondness for chess and vodka. The visitors quickly wreak havoc in a city that refuses to believe in either God or Satan. But they also bring peace to two unhappy Muscovites: one is the Master, a writer pilloried for daring to write a novel about Christ and Pontius Pilate; the other is Margarita, who loves the Master so deeply that she is willing literally to go to hell for him.'" crlf)
    (assert (recommendation master-and-margarita)))


(defrule likes-master-and-margarita2
    (declare (salience 5))
    (not (recommendation ?rec))
    (christ-theme ?theme)
    (test (eq ?theme y))
    (bad-reader yes)
    =>
    (printout t "You should read The Master and Margarita by Mikhail Bulgakov (Published 1967 and ~373 pages long. 'One hot spring, the devil arrives in Moscow, accompanied by a retinue that includes a beautiful naked witch and an immens talking black cat with a fondness for chess and vodka. The visitors quickly wreak havoc in a city that refuses to believe in either God or Satan. But they also bring peace to two unhappy Muscovites: one is the Master, a writer pilloried for daring to write a novel about Christ and Pontius Pilate; the other is Margarita, who loves the Master so deeply that she is willing literally to go to hell for him.'" crlf)
    (assert (recommendation master-and-margarita)))


;****************
;*   INPUT      *
;****************
(defrule get-movie
    (not (recommendation ?rec))
    (not (movie-pref ?movie))
    =>
    (printout t "Is it important for you that the book has been adapted into a good quality movie? (y/n)" crlf)
    (assert (movie-pref (read))))

(defrule get-absurdity
    (not (recommendation ?rec))
    (not (absurd ?abs))
    =>
    (printout t "Do you like absurd/fantasy books? (y/n)" crlf)
    (assert (absurd (read))))

(defrule get-poetry
    (not (recommendation ?rec))
    (not (poetry ?p))
    =>
    (printout t "Do you like poetry? (y/n)" crlf)
    (assert (poetry (read))))

(defrule get-romantic 
    (not (recommendation ?rec))
    (not (romantic ?fam))
    => 
    (printout t "Do you like romantic books? (y/n)" crlf)
    (assert (romantic (read))))

(defrule get-books-per-week
    (not (recommendation ?rec))
    (not (books-per-week ?bpw))
    =>
    (printout t "How many books do you read per week on average?" crlf)
    (assert (books-per-week (read))))

(defrule get-old-english
    (not (recommendation ?rec))
    (not (old-english ?english))
    =>
    (printout t "Do you think 19th century english is hard to read? (y/n)" crlf)
    (assert (old-english (read))))

(defrule get-family
    (not (recommendation ?rec))
    (not (family-conflict ?fam))
    => 
    (printout t "Do you like books about family coflicts? (y/n)" crlf)
    (assert (family-conflict (read))))

(defrule get-christian-theme
    (not (recommendation ?rec))
    (not (christ-theme ?theme))
    =>
    (printout t "Do you like books with christian themes? (y/n)" crlf)
    (assert (christ-theme (read))))

