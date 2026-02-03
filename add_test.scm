;; Rational number constructor
(define (make-rational n d)
  (let ((g (gcd n d)))
    (cons 'rational (list (/ n g) (/ d g)))))  ; Using exact division

;; Accessors
(define (numer x) (cadr x))
(define (denom x) (caddr x))

;; Rational addition
(define (rational-add x y)
  (make-rational (+ (* (numer x) (denom y))
                    (* (numer y) (denom x)))
                 (* (denom x) (denom y))))

;; Override + for rational numbers
(define (+ x y)
  (if (and (pair? x) (pair? y) (eq? (car x) 'rational) (eq? (car y)
'rational))
      (rational-add x y)
      (apply original-+ x y)))

;; Save original +
(define original-+ +)

;; Test cases
(define r1 (make-rational 1 2))
(define r2 (make-rational 1 3))
(define r3 (make-rational 2 3))

;; Test 1: 1/2 + 1/3 = 5/6
(define test1 (+ r1 r2))
(if (and (= (numer test1) 5) (= (denom test1) 6))
    (display "Test 1 passed: 1/2 + 1/3 = 5/6\n")
    (display "Test 1 failed\n"))

;; Test 2: 1/2 + 2/3 = 7/6
(define test2 (+ r1 r3))
(if (and (= (numer test2) 7) (= (denom test2) 6))
    (display "Test 2 passed: 1/2 + 2/3 = 7/6\n")
    (display "Test 2 failed\n"))

;; Test 3: 2/3 + 1/3 = 1
(define test3 (+ r3 r2))
(if (and (= (numer test3) 1) (= (denom test3) 1))
    (display "Test 3 passed: 2/3 + 1/3 = 1\n")
    (display "Test 3 failed\n"))
