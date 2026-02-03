(define π 3.141592653589793)

(define (area shape handler)
  (handler shape))

;; Handlers:
(define (rectangle-handler shape)
  (* (car shape) (cadr shape)))  ; (width height)

(define (circle-handler shape)
  (* (expt (car shape) 2) π))    ; (radius)

;; Usage:
(area '(3 4) rectangle-handler)  ; => 12
(area '(5) circle-handler)      ; => 78.5398...

;----------------------------------------------

; message passing 
; Step 1: Define the Data Types with type tag

;; Extract the type tag from a tagged object
(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum: DATUM")))

;; Get the contents (data) of a tagged object
(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum: DATUM")))

(define (make-rational n d)
  (let ((g (gcd n d)))
    (cons 'rational  ; type tag
          (cons (/ n g) (/ d g)))))  ; contents: (numerator denominator)

(define (numer x) (car (contents x)))  ; numerator
(define (denom x) (cadr (contents x))) ; denominator

;; Complex numbers: (make-complex r i)
(define (make-complex r i)the pu
  (cons 'complex  ; type tag
        (cons r i)))  ; contents: (real imaginary)

(define (real-part x) (car (contents x)))  ; real part
(define (imag-part x) (cadr (contents x))) ; imaginary part


; Step 2: Define Methods for `+`
; We store how `+` should work for each type in a **method table** (a nested
; hash table).

;; Method table: (op type1 type2) -> procedure
;; Look up a method for (op type1 type2)
(define (get op type1 type2)
  (let ((row (assoc op *method-table*)))
    (if row
        (let ((entry (assoc type1 (cdr row))))
          (if entry
              (let ((types (car entry)))
                (if (and (equal? (car types) type1)
                         (equal? (cadr types) type2))
                    (cadr entry)
                    #f))
              #f))
        #f)))


;; Add a method for (op type1 type2)
(define (put op type1 type2 proc)
  (let ((row (assoc op *method-table*)))
    (if row
        (let ((entry (assoc type1 (cdr row))))
          (if entry
              (set-cdr! entry (cons type2 proc))
              (set-cdr! row (cons (list type1 type2 proc) (cdr row))))
          (set-cdr! row (cons (list type1 type2 proc) (cdr row))))
        (set! *method-table* (cons (list op (list type1 type2 proc))
*method-table*)))))

;; Initialize the method table
(define *method-table* '())

;; Add methods for rational + rational
(put 'add 'rational 'rational
     (lambda (x y)
       (make-rational (+ (* (numer x) (denom y))
                         (* (numer y) (denom x)))
                      (* (denom x) (denom y)))))

;; Add methods for complex + complex
(put 'add 'complex 'complex
     (lambda (x y)
       (make-complex (+ (real-part x) (real-part y))
                     (+ (imag-part x) (imag-part y)))))

;; Add method for rational + complex (and vice versa)
(put 'add 'rational 'complex
     (lambda (x y)
       (make-complex (+ (numer x) (real-part y))
                     (imag-part y))))

(put 'add 'complex 'rational
     (lambda (x y)
       (make-complex (+ (real-part x) (numer y))
                     (imag-part x))))

; ### **Step 3: Define the Generic `+` Function**
; The `+` function now **sends an "add" message** to its arguments and lets
; them handle it:

(define (+ x y)
  (apply-generic 'add x y))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op (car type-tags) (cadr type-tags))))
      (if proc
          (apply proc args)
          (error "No method for these types")))))

;### **Step 4: Test It!**
;Now we can mix rationals and complex numbers:

;; Rational + Rational
(+ (make-rational 1 2) (make-rational 1 3))
;; → (3/6) = 1/2

;; Complex + Complex
(+ (make-complex 3 4) (make-complex 1 2))
;; → (4 + 6i)

;; Rational + Complex (message-passing in action!)
(+ (make-rational 1 2) (make-complex 3 4))
;; → (3.5 + 4i)  (1/2 + 3 + 4i = 3.5 + 4i)