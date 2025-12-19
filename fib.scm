(define (fib-definition n)
  (cond 
    ((= n 0) 0)
    ((= n 1) 1)
    (else (+ (fib-definition (- n 1)) (fib-definition (- n 2))))
  )  
)

(fib-definition 7)

(define (fib n)
  (define (fib_iter actual-n n1 n2)
    (if (= actual-n n)
      (+ n1 n2)
      (fib_iter (+ actual-n 1) actual-n n1)
    )
  )

  (fib_iter 2 1 0)
)

(fib 3)