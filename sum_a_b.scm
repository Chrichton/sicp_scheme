(define (sum-a-b a b)
  (if (> a b)
      0
      (+ a (sum-a-b (+ a 1) b)) 
  )
)

(sum-a-b 1 100)