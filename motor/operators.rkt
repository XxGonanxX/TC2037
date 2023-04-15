;; Alan Patricio González Bernal - A01065746
;; Arturo Cristian Díaz López - A01709522
;; 14/04/23

;; Definición de operadores en C#

(define operators-list
    '("+" "-" "*" "/" "%" "&" "|" "^" "!" "~" "=" "<" ">" "+=" "-=" "*=" "/=" "%=" "&="
     "|=" "^=" "<<" ">>" ">>>" "<<=" ">>=" ">>>=" "==" "!=" "<=" ">=" "&&" "||" "++"
     "--" "?" "??"
     )
)

(define operators-reg-ex
    (pregexp (string-append "(" (string-join (map regexp-quote operators-list) "|") ")+"))
)

(define operators-span
    (lambda m (string-append "<span class=operators>" (first m) "</span>"))
)

(define operators
  (lambda (s) (regexp-replace* operators-reg-ex s operators-span))
)

(provide operators)