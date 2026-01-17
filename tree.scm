(define my-tree '(200 (1 2) (3 4 1) (8) 9))

my-tree

(define (no-of-leafs tree)
  (cond 
    ((null? tree) 0)
    ((not (pair? tree)) 1)
    (else (+ (no-of-leafs (car tree)) (no-of-leafs (cdr tree))))
  )
)

(no-of-leafs my-tree)