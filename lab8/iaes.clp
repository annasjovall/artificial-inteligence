(defrule invest-in-securities-Rule-1
    (not (recommendation ?rec))
    (invest ?inv)
    (test (>= ?inv 10000))
    (college_degree yes)
    =>
    (assert (money_in_securities yes))
    (printout t "Recommendation is to invest in securities. " crlf))

(defrule invest-in-growth-stocks-Rule-2
    (not (recommendation ?rec))
    (income ?inc)
    (test (>= ?inc 40000))
    (college_degree yes)
    =>
    (assert (securitytype growth-stocks))
    (printout t "Recommendation is to invest in growth stocks. " crlf))
    

(defrule invest-in-growth-stock-Rule-3
    (not (recommendation ?rec))
    (age ?age)
    (money_in_securities yes)
    (test (< ?age 30))
    =>
    (assert (securitytype growth-stocks))
    (printout t "Recommendation is to invest in growth stocks. " crlf))
    

(defrule has-college-degree-Rule-4
    (not (recommendation ?rec))
    (age ?age)    
    (test (< ?age 30))
    =>
    (assert (college_degree yes))
    (printout t "The person has a college degree. " crlf))

(defrule invest-in-IBM-Rule-5
    (not (recommendation ?rec))
    (securitytype growth-stocks)
    =>
    (assert (recommendation IBM-stocks))
    (printout t "Recommendation is to invest in IBM stocks." crlf))

(defrule get-age
    (declare (salience 10))
    (not (recommendation ?rec))
    (not (age ?age))
    =>
    (printout t "What is your age?")
    (assert (age (read))))

(defrule get-income
    (declare (salience 10))
    (not (recommendation ?rec))
    (not (income ?inc))
    =>
    (printout t "What is your annual income?")
    (assert (income (read))))

(defrule get-invest
    (declare (salience 10))
    (not (recommendation ?rec))
    (not (invest ?inv))
    =>
    (printout t "How much do you have to invest?")
    (assert (invest (read))))

