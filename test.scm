(define (fib_iter n actual-n n1 n2)
  (if (= actual-n n)
    (+ n1 n2)
    (fib_iter n (+ actual-n 1) actual-n n1)
  )
)

(fib_iter 3 2 1 0)