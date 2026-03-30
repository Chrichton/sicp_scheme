; evaluation of params inside functions is from right to left
; (+ (f 0) (f 1)) evaluates (f 1) first and then (f 0)

(define first-call true)

(define (f p)
  (newline)
  (display "param: ")
  (display p)
  
  (if first-call
    (begin (set! first-call false) 0)
    p
  )
)

(+ (f 0) (f 1))
; result = 0

(+ (f 1) (f 0))
; result = 1