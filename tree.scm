(define my-tree '((1 2) (3 4 1) (8) 9))

my-tree

(define (no-of-leafs tree)
  (cond 
    ((null? tree) 0)
    ((list? tree) (+ (no-of-leafs (car tree)) (no-of-leafs (cdr tree))))
    (else 1)
  )
)

(no-of-leafs my-tree)