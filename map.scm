
(define (my-map f lst)
  (if (null? lst)
    '()
    (cons (f (car lst)) (my-map f (cdr lst)))
  )
)

(my-map (lambda (x) (* x x)) (list 1 2 3 4))


(define (my-map-tail-recursive f lst)
  (let helper ((lst lst) (acc '()))
    (if (null? lst)
        (reverse acc)
        (helper (cdr lst) (cons (f (car lst)) acc)))))

(my-map-tail-recursive (lambda (x) (+ x 10)) (list 1 2 3 4))