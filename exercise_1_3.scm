(define (square x)
  (* x x)
)

(define (sum-max-2-squared a b c)
  (cond 
    ((and (>= a b) (>= a c) (square a)))
    ((and (>= b a) (>= b c) (square b)))
    (else (square c))
  )
)

(square 5)

(sum-max-2-squared 1 4 3)