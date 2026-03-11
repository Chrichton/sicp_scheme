(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range)))
)

(define (estimate-integral pred x1 x2 y1 y2 trials)
  (let ((test (lambda ()
                (pred (random-in-range x1 x2)
                      (random-in-range y1 y2)))))
    (monte-carlo trials test)
  )
)

(define (predicate x y)
  (<= (+ (square (- x 5)) (square (- y 7))) (square 3))
)


(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1)
                 (+ trials-passed 1)))
          (else (iter (- trials-remaining 1)
                      trials-passed))))
  (iter trials 0))

(define fraction (estimate-integral predicate 2.0 8.0 4.0 10.0 10000))

(define pi (* fraction 4))

fraction
pi

; 1. **Rectangle Area**: (8-2) × (10-4) = 6 × 6 = 36
; 2. **Circle Area**: π × r² = π × 3² = 9π
; 3. **Ratio**: Circle area is (9π)/36 = π/4 of the rectangle area
