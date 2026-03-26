(define (make-account balance secret-password)
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

  (define (dispatch m password)
    (if (eq? password secret-password)
      (cond ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
        (else (error "Unknown request: MAKE-ACCOUNT" m))
      ) 
      (lambda (x) "Incorrect password")
    )
  )

  dispatch
)

(define account (make-account 100 'pw))

((account 'withdraw 'pw) 20)
((account 'deposit 'pw) 30)

((account 'withdraw 'pw1) 20)
((account 'deposit 'pw1) 30)