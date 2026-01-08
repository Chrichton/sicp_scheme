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

; decide, if a symbol 'x' is inside a list 'lst'
(define (memq lst x)
  (cond 
    ((eq? lst `()) false)
    ((eq? (car lst) x) lst)
    (else (memq (cdr lst) x))
  )
)

(memq `() `a)

(memq `(a b c) `a)

(memq `(a b c) `b)

(memq `(a b c) `d)

(memq `(a b c) `())

(memq `() `())

(memq (list 1 2 3) 2)

