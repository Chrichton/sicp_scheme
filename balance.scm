; sicp page 220 (Local State Variables)
(define balance 100)

(define (withdraw amount)
  (if (>= balance amount)
    (begin (set! balance (- balance amount)) balance)
    "Insufficient funds")
)

(withdraw 75)

;-------------------------------------------------------

(define (new-withdraw)
  (let ((balance 100))
    (lambda (amount) 
      (if (>= balance amount) 
        (begin (set! balance (- balance amount)) balance)
        "Insufficient funds"
      )
    )
  )
)

(define withdraw (new-withdraw))

(withdraw 75)
(withdraw 1200)

;-------------------------------------------------------

(define (make-withdraw balance)
  (lambda (amount) 
    (if (>= balance amount) 
      (begin (set! balance (- balance amount)) balance)
      "Insufficient funds"
    )
  )
)

(define W1 (make-withdraw 125))

(W1 25)


(define (make-account balance)
  (define (withdraw amount) 
    (if (>= balance amount) 
      (begin (set! balance (- balance amount)) balance)
      "Insufficient funds"
    )
  )

  (define (deposit amount)
    (set! balance (+ balance amount))
    balance
  )

  (define (dispatch m)
    (cond 
      ((eq? m 'withdraw) withdraw)
      ((eq? m 'deposit) deposit)
      (else ("error unknown request -- MAKE-Account" m))
    )
  )
  dispatch
)

(define acc (make-account 100))

((acc 'withdraw) 25)
((acc 'deposit) 30)