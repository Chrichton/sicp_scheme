(define *method-table* '())

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum: DATUM")))

(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum: DATUM")))

(define (make-rational n d)
  (let ((g (gcd n d)))
    (cons 'rational (cons (/ n g) (/ d g)))))

(define (numer x) (car (contents x)))
(define (denom x) (cadr (contents x)))

(define (put op type1 type2 proc)
  (let ((row (assoc op *method-table*)))
    (if row
        (let ((entry (assoc type1 (cdr row))))
          (if entry
              (set-cdr! entry (cons type2 proc (cdr entry)))
              (set-cdr! row (cons (list type1 type2 proc) (cdr row)))))
        (set! *method-table* (cons (list op (list type1 type2 proc))
*method-table*)))

(define (get op type1 type2)
  (let ((row (assoc op *method-table*)))
    (if row
        (let ((entry (assoc type1 (cdr row))))
          (if entry
              (assoc type2 (cdr entry))
              #f))
        #f)))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op (car type-tags) (cadr type-tags))))
      (if proc
          (apply proc args)
          (error "No method for these types" type-tags)))))

(define (+ x y)
  (apply-generic 'add x y))

;; Define the addition method for rationals
(put 'add 'rational 'rational
     (lambda (x y)
       (make-rational (+ (* (numer x) (denom y))
                         (* (numer y) (denom x)))
                      (* (denom x) (denom y)))))

;### Testing the Code

;; Rational + Rational
(+ (make-rational 1 2) (make-rational 1 3))

;; Complex + Complex
(+ (make-complex 3 4) (make-complex 1 2))
;; → (4 + 6i)

;; Rational + Complex
(+ (make-rational 1 2) (make-complex 3 4))
;; → (3.5 + 4i)