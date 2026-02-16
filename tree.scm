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


; map function for a tree
(define (scale-tree tree factor)
  (cond 
    ((null? tree) '())
    ((not (pair? tree)) (* tree factor))
    (else (cons (scale-tree (car tree) factor) (scale-tree (cdr tree) factor)))
  )
)

(scale-tree (list 1 2 (list 3 4 5)) 10)

(scale-tree (cons '(1 2) '(3 4 5)) 2)

(list 1 2 (list 3 4 5))

