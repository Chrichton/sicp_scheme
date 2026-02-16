(define π 3.141592653589793)

(define (area shape handler)
  (handler shape))

;; Handlers:
(define (rectangle-handler shape)
  (* (car shape) (cadr shape)))  ; (width height)

(define (circle-handler shape)
  (* (expt (car shape) 2) π))    ; (radius)

;; Usage:
(area '(3 4) rectangle-handler)  ; => 12
(area '(5) circle-handler)      ; => 78.5398...

;---------- SICP Page 186 -----------------------------------
(define (make-from-real-imag x y)
  (define (dispatch op)
    (cond ((eq? op 'real-part) x)
      ((eq? op 'imag-part) y)
      ((eq? op 'magnitude) 
        (sqrt (+ (square x) (square y)))
      )
      ((eq? op 'angle) (atan x y))
      (else (error "unknown op -- MAKE-FROM-REAL-IMAG" op))
    )
  )
  dispatch
)

; the arg is the dispatch function
(define (apply-generic op arg)
  (arg op)
)

(define z (make-from-real-imag 10 15))

(apply-generic 'real-part z)
(apply-generic 'magnitude z)
(apply-generic 'angle z)
