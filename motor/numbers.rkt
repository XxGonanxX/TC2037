;; Alan Patricio González Bernal - A01065746
;; Arturo Cristian Díaz López - A01709522
;; 14/04/23

;; Definición de números enteros y decimales en C#

(define numbers-reg-ex 
    (regexp "(\\b[0-9]+(\\.[0-9]*)?\\b)")
)

(define numbers-span
    (lambda m (string-append "<span class=numbers>" (first m) "</span>"))
)

(define numbers
    (lambda (s) (regexp-replace* numbers-reg-ex s numbers-span))
)

(provide numbers)