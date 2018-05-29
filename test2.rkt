#lang racket

(require compatibility/defmacro)
(require (for-syntax "./test.rkt"))

;(define-macro (sub-a-b expr)
              ;(subst expr 'a 'b))

;(sub-a-b (lambda (a b) (+ a b)))

(define-macro (del-a expr)
              (del expr 'a))

((del-a (lambda (a b c) (+ a b c))) 1 2)

