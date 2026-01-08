(list `a `b 3)

`(a b c)

(quote (a b c))

(list `quote `(a b c))

(list `car (list `quote `(a b c)))

;empty list:
`()

()

; eq? can be used to decide if two smbols are the same
(eq? `1 `1)

; decide, if a symbol 'item' is inside a list 'lst'
(define (memq item lst)
  (cond 
    ((null? lst) false)
    ((eq? (car lst) item) lst)
    (else (memq item (cdr lst)))
  )
)

(memq `a `())

(memq `a `(a b c))

(memq `b `(a b c))

(memq `(a b c) `d)

(memq `(a b c) `())

(memq `() `())

(memq 2 (list 1 2 3))

