(define (sum-squares a b)
  (define (square a) (* a a))

  (if (> a b)
    0
    (+ (square a) (sum-squares (+ a 1) b))
  )
)

(sum-squares 1 2)