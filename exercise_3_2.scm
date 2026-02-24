(define (make-monitored f)
  (let ((number-of-calls 0))
    (lambda (value) 
      (if (eq? value 'how-many-calls?)
        number-of-calls
        (begin (set! number-of-calls (+ number-of-calls 1)) (f value))
      )
    )
  )
)

(define s (make-monitored sqrt))

(s 100)

(s 'how-many-calls?)
