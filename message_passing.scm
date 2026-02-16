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