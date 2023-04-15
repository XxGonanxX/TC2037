;; Alan Patricio González Bernal - A01065746
;; Arturo Cristian Díaz López - A01709522
;; 14/04/23

;; Definición de strings en C#

#lang racket

(define strings-reg-ex (regexp "(\"(\\\\.|[^\\\\\"])*\")"))

(lambda m (string-append "<span class=strings>" (first m) "</span>"))

(define strings-span (lambda m (string-append "<span class=strings>" (first m) "</span>")))

(define strings (lambda (s) (regexp-replace* strings-reg-ex s strings-span)))

(provide strings)