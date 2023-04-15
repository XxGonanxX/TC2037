;; Alan Patricio González Bernal - A01065746
;; Arturo Cristian Díaz López - A01709522
;; 14/04/23

;; Definición de comentarios en C#

#lang racket

(define html-tag (lambda (s) (string-append "<[^/>]*>" s "</[^>]*>")))

(define single-line-comment-reg-ex 
    (string-append (html-tag "//") "[^\n]*\\\n")
)

(define multiple-line-comment-reg-ex 
    (string-append (html-tag "/\\*") "(.*)" (operatorSafe "\\*/"))
)

(define comment-reg-ex 
    (regexp (string-append single-line-comment-reg-ex "|" multiple-line-comment-reg-ex))
)

(define comment-span 
    (lambda m (string-append "<span class=comments>" (first m) "</span>"))
)

(define comments 
    (lambda (s) (regexp-replace* comment-reg-ex s comment-span))
)

(provide comments)