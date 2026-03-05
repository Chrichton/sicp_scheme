(define random-init 1)
(define random-max #x7fffffff)
(define (rand-update x0)
  (let* ((x1 (fxxor x0 (fxarithmetic-shift-right x0 13)))
         (x2 (fxxor x1 (fxarithmetic-shift-left x1 18))))
    (fxand x2 random-max)))

(define rand
  (let ((x random-init))
    (lambda ()
      (set! x (rand-update x))
      x
    )
  )
)

(rand)
(rand)

(define (estimate-pi trials)
  (sqrt (/ 6 (monte-carlo trials cesaro-test))))
(define (cesaro-test)
  (= (gcd (rand) (rand)) 1))

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

(estimate-pi 250000)
(estimate-pi 250000)
(estimate-pi 250000)
(estimate-pi 250000)