#lang racket

; some examples of macros in scheme

; example from
; https://hipster.home.xs4all.nl/lib/scheme/gauche/define-syntax-primer.txt
(define-syntax nth-value
  (syntax-rules ()
    ((nth-value n values-producing-form)
     (call-with-values
       (lambda () values-producing-form)
       (lambda all-values
         (list-ref all-values n))))))


(nth-value 1 (values 1 2 3 4))

; another example from the syntax-primer tutorial
(define-syntax please
  (syntax-rules ()
    ((please . forms) forms)))

;(please display 2)



; ----
; and now, some of my own!
; ----



; custom range
(define range
  (lambda (n)
    (cond
      ((zero? n) '())
      (else
        (cons n (range (sub1 n)))))))

; custom map
(define map2
  (lambda (f l)
    (cond
      ((null? l) '())
      (else
        (cons (f (car l)) (map2 f (cdr l)))))))

; strange range-over syntax of my own invention
; applies a function 'over' a range
(define-syntax range-over
  (syntax-rules (over)
    ((range-over f over n) (map2 f (range n)))))

(range-over add1 over 10)

; (lcomp fexpr for i in l)
; list comprehension
(define-syntax lcomp
  (syntax-rules (for in)
    ((lcomp fexpr for iter in l)
     (map2 (lambda (iter) fexpr) l))))

(lcomp (add1 i) for i in (range 10))

(lcomp (* i i) for i in (range 10))

; haskell-like lambda syntax
; (from x to fexpr )
(define-syntax from 
  (syntax-rules (to)
    ((from x to fexpr) (lambda (x) fexpr))))

(map2 (from x to (add1 x)) (range 10))
