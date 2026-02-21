; scip page 220 (Local State Variables)
(define balance 100)

(define (withdraw amount)
  (if (>= balance amount)
    (begin (set! balance (- balance amount)) balance)
    "Insufficient funds")
)

(withdraw 75)


(define (new-withdraw amount)
  (let ((balance 100))
    (lambda (amount) 
      (if (>= balance amount) 
        (begin (set! balance (- balance amount)) balance)
        "Insufficient funds"
      )
    )
  )
  balance
)

(new-withdraw 25)
