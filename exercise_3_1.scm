(define (make-accumulator sum)
  (lambda (amount) 
    (set! sum (+ amount sum))
    sum
  )
)

(define acc (make-accumulator 42))

(acc 50)
(acc 8)