(define (factorial n)
  (define (factorial-iter counter product)
    (if (> counter n)
      product
      (factorial-iter (+ counter 1) (* counter product))
    )
  )

  (factorial-iter 1 1)
)

(factorial 5)