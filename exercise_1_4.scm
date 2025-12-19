(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

(a-plus-abs-b 3 7)

(a-plus-abs-b 3 -7)

(define (square x)
  (* x x))

(define (f_of_squares x y f)
  (f (square x) (square y)))

(f_of_squares 3 5 *)
