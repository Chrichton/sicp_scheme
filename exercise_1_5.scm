(define (p) (p))

(define (test x y)  
  (if (= x 0) 0 y))

(test 0 (p))

(test 0 (1))

(define (square x)
  (* x x)
)

(define (sum-of-squares x y)
  (+ (square x) (square y))
)

(define (f a)
  (sum-of-squares (+ a 1) (* a 2))
)

(f 5)
136

; applicative-order evaluation (evaluate the arguments, then apply) is used by the interpreter
(sum-of-squares (+ a 1) (* a 2))
(sum-of-squares (+ 5 1) (* 5 2))
(+ (square 6) (square 10))
(+ (* 6 6) (* 10 10))
(+ 36 100)
136

; normal-order evaluation (fully expand, then reduce)
; here (+ 5 1) and (+ 5 2) are calculated twice
(sum-of-squares (+ a 1) (* a 2))
(sum-of-squares (+ 5 1) (* 5 2))
(+ (square (+ 5 1)) (square (* 5 2)) )
(+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2)))
(+ (* 6 6) (* 10 10))
(+ 36 100)
136





