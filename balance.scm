; sicp page 220 (Local State Variables)
(define balance 100)

(define (withdraw amount)
  (if (>= balance amount)
    (begin (set! balance (- balance amount)) balance)
    "Insufficient funds")
)

(withdraw 75)

;-------------------------------------------------------

(define (new-withdraw balance)
    (lambda (amount) 
      (if (>= balance amount) 
        (begin (set! balance (- balance amount)) balance)
        "Insufficient funds"
      )
  )
)

(define W1 (new-withdraw 125))

(W1 25)
