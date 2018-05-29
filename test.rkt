#!/usr/bin/racket
#lang racket

(require compatibility/defmacro)

(provide (all-defined-out))
;(defmacro addmacro (x y) (cons '+ (x y)))

;(addmacro 1 2)
(define-macro (backwards . body)
  (cons 'begin
        (reverse body)))

;from http://www.greghendershott.com/fear-of-macros/all.html
;(define-syntax (reverse-me stx)
  ;(datum->syntax stx (reverse (cdr (syntax->datum stx)))))

;(reverse-me
  ;"!"
  ;"World"
  ;"Hello "
  ;string-append)

;(define-syntax (do-backwards stx)
  ;(datum->syntax stx 
    ;(cons 'begin 
      ;(reverse (cdr (syntax->datum stx))))))

(backwards
  (println 1)
  (println 2)
  (println 3))



(define atom?
  (lambda (expr)
    (and (not (null? expr)) (not (pair? expr)))))



(define subst
  (lambda (l val repl)
    (cond
      ((null? l) l)
      ((atom? (car l))
       (cond
         ((eq? (car l) val) (cons repl (subst (cdr l) val repl)))
         (else
          (cons (car l) (subst (cdr l) val repl)))))
      (else
        (cons (subst (car l) val repl) (subst (cdr l) val repl))))))
        

;(subst '(a (b a) c d) 'a 'b)

(define del
  (lambda (l val)
    (cond
      ((null? l) l)
      ((atom? (car l))
       (cond
         ((eq? (car l) val) (del (cdr l) val))
         (else
          (cons (car l) (del (cdr l) val)))))
      (else
        (cons (del (car l) val) (del (cdr l) val))))))

; (lambda (a b) (+ a b))

(del'(a (b a) c d) 'a)

(define ab 1)
(define cb 2)
(define aa 3)

;(define-syntax do-backwards2
  ;(syntax-rules ()
    ;((do-backwards2 . a) (reverse a))))
    
;(do-backwards2
  ;(println 1)
  ;(println 2)
  ;(println 3))


;(define-syntax-rule (addsum . body))

;(define sum
  ;(lambda [l]
    ;(cond 
      ;((null? l) 0)
      ;(else
        ;(+ (car l) (sum (cdr l)))
        ;(+ (car l) (sum (cdr l)))))))

;(+ (addsum
    ;(+ 1 1)
    ;(+ 1 1)
    ;(+ 1 1))

;(define-syntax-rule (swap x y)
  ;(let ([tmp x])
    ;(set! x y)
    ;(set! y tmp)))

;(define swap2 
  ;(lambda (x y) 
    ;(let ([tmp x])
      ;(set! x y)
      ;(set! y tmp)))

;(define x 1)
;(define y 2)
;(+ (swap x y) 1)
;(println x)
;(println y)

;(define-syntax rotate
  ;(syntax-rules ()
    ;[(rotate a) (void)]
    ;[(rotate a b c ...) (begin
                          ;(swap a b)
                          ;(rotate b c ...))]))

;(define a 1)
;(define b 2)
;(define c 3)
;(define d 4)
;(rotate a b c d)
;(println `(,a ,b ,c ,d))
;(println '(a b c d))
