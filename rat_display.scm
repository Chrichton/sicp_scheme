(define (make-rat n d) (cons n d))
(define (numer x) (car x))
(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x))
)

(define one-half (make-rat 1 2))
(print-rat one-half)

one-half

(define (add-rat r1 r2)
  (make-rat 
    (+ (* (numer r1) (denom r2)) (* (numer r2) (denom r1)))
    (* (denom r1) (denom r2))
  )
)

(add-rat (make-rat 7 16) (make-rat 5 24))

;--------------- reduce rational numbers to their lowest terms. SICP Page 87

(define (make-rat n d) 
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))
  )
)

(add-rat (make-rat 7 16) (make-rat 5 24))