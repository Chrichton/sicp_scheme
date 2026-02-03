; page 102
(define (length items)
  (if (null? items)
    0
    (+ 1 (length(cdr items)))
  )
)

(length '(1 3 5 7))


(define l (cons '(1 2) '(3 4)))
l
(length l)