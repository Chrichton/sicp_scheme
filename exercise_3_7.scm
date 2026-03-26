; import account
(load "exercise_3_3.scm")


(define (make-joint account account-password my-password)
  (define result ((account 'withdraw account-password) 0))

  (if (number? result)
    (lambda (password m amount)
      (if (eq? password my-password)
        ((account m account-password) amount)
        "wrong password")
    )
    "wrong account-password"
  )
)

(make-joint account 'pw1 'my-pw)

(define joint-account (make-joint account 'pw 'my-pw))
(joint-account 'my-pw 'withdraw 30)