; SICP Book Page: 93 Interval Arithmetic

(define (add-Interval x y)
  (make-interval 
    (+ (lower-bound x) (lower-bound y))
    (+ (upper-bound x) (upper-bound y))
  )
)

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval 
      (min p1 p2 p3 p4)
      (max p1 p2 p3 p4)
    )
  )
)

(define (div-interval x y)
  (mul-interval
    x
    (make-interval 
      (/ 1.0 (upper-bound y))
      (/ 1.0 (lower-bound y))
    )
  )
)

(define (make-interval a b) (cons a b))

(define (lower-bound interval)
  (car interval)
)

(define (upper-bound interval)
  (cdr interval)
)

(define interval1 (make-interval -5 5))

(lower-bound interval1)

(upper-bound interval1)

(define (sub-interval x y)
  ;biggest interval possible -> highest value - lowest value for x - y  
  ;lowest values for {low-x, up-x} - {low-y, up-y} -> 
  ;                 {low-x - up_y, up-x - low-y}   
  (make-interval
    (- (lower-bound x) (upper-bound y))
    (- (upper-bound x) (lower-bound y) )
  )
)

(define interval2 (make-interval -7 3))

(sub-interval interval1 interval2)
