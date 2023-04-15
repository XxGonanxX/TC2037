;; Alan Patricio González Bernal - A01065746
;; Arturo Cristian Díaz López - A01709522
;; 14/04/23

;; Creación del archivo main

#lang racket

(require "motor/comments.rkt")
(require "motor/numbers.rkt")
(require "motor/operators.rkt")
(require "motor/reserved-words.rkt")

(define (show-execution-time proc)
  (define start (current-inexact-milliseconds))(proc)
  (define end (current-inexact-milliseconds))
  (displayln (format "Tiempo de ejecución: ~a ms" (- end start)))
)

(define input-file "input.txt")

(define highlight (reserved-words (comments (operators (numbers input)))))

(define output
    (string-append
        "   <!DOCTYPE html>
            <html>
            <head>
                <meta charset=\"utf-8\">
                <link rel='stylesheet' href='styles.css'> 
                <title>Actividad 3.4</title>
            </head>
            <style>
                span *{color:inherit !important}
            </style><pre>"
            highlight
            "</pre>"
    )
)

(define output-file (open-output-file "main.html" #:exists 'replace))
(write-string output output-file)
(close-output-port output-file)