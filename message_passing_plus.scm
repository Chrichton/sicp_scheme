;#### 1. Initialize the Method Table

(define *method-table* '())

;#### 2. Define `type-tag` and `contents`

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum: DATUM")))

(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum: DATUM")))


;#### 3. Define Data Constructors

(define (make-rational n d)
  (let ((g (gcd n d)))
    (cons 'rational (cons (/ n g) (/ d g)))))

(define (numer x) (car (contents x)))
(define (denom x) (cadr (contents x)))

(define (make-complex r i)
  (cons 'complex (cons r i)))

(define (real-part x) (car (contents x)))
(define (imag-part x) (cadr (contents x)))


;#### 4. Fix the `put` Function (Now Returns a Value)

(define (put op type1 type2 proc)
  (let ((row (assoc op *method-table*)))
    (if row
        (let ((entry (assoc type1 (cdr row))))
          (if entry
              (set-cdr! entry (cons type2 proc (cdr entry)))
              (set-cdr! row (cons (list type1 type2 proc) (cdr row)))))
        (set! *method-table* (cons (list op (list type1 type2 proc))
*method-table*)))
  #t)  ; Explicitly return a value


;#### 5. Define the `get` Function (Missing in Previous Versions)

(define (get op type1 type2)
  (let ((row (assoc op *method-table*)))
    (if row
        (let ((entry (assoc type1 (cdr row))))
          (if entry
              (assoc type2 (cdr entry))
              #f))
        #f)))


;#### 6. Define Methods for `+`

(put 'add 'rational 'rational
     (lambda (x y)
       (make-rational (+ (* (numer x) (denom y))
                         (* (numer y) (denom x)))
                      (* (denom x) (denom y)))))

(put 'add 'complex 'complex
     (lambda (x y)
       (make-complex (+ (real-part x) (real-part y))
                     (+ (imag-part x) (imag-part y)))))

(put 'add 'rational 'complex
     (lambda (x y)
       (make-complex (+ (numer x) (real-part y))
                     (imag-part y))))

(put 'add 'complex 'rational
     (lambda (x y)
       (make-complex (+ (real-part x) (numer y))
                     (imag-part x))))


;#### 7. Define `apply-generic` and `+`

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op (car type-tags) (cadr type-tags))))
      (if proc
          (apply (cdr proc) args)
          (error "No method for these types")))))

(define (+ x y)
  (apply-generic 'add x y))

;### Testing the Code

(+ (make-rational 1 2) (make-rational 1 3))
; → (5/6)

; Complex + Complex
(+ (make-complex 3 4) (make-complex 1 2))
; → (4 + 6i)

; Rational + Complex
(+ (make-rational 1 2) (make-complex 3 4))
; → (3.5 + 4i)
