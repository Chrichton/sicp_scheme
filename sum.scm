; SICP page 77: Formulating Abstractions
; with Higher-Order Procedures

(define (sum transform a next b)
  (if (> a b)
    0
    (+ (transform a) (sum transform (next a) next b))
  )  
)

(define (sum-squares a b)
  (define (square x) (* x x))
  (define (next x) (+ x 1))

  (sum (lambda (x) (* x x))  a next b)
)

(sum-squares 1 2)