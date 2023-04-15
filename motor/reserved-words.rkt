;; Alan Patricio González Bernal - A01065746
;; Arturo Cristian Díaz López - A01709522
;; 14/04/23

;; Definición de palabras reservadas de C#

#lang racket

(define reserved-words-list
    '(
    "abstract" "as" "base" "bool" "break" "byte" "case" "catch" "char"
    "checked" "class" "const" "continue" "decimal" "default" "delegate"
    "do" "double" "else" "enum" "event" "explicit" "extern" "false"   
    "finally" "fixed" "float" "for" "foreach" "goto" "if" "implicit"
    "in" "long" "namespace" "new" "null" "object" "operator"
    "out" "override" "params" "private" "int" "interface" "internal" "is" "lock" 
    "protected" "public" "readonly" "ref" "return" "sbyte" "sealed" "short"
    "sizeof" "stackalloc" "static" "string" "struct" "switch" "this" "throw"
    "true" "try" "typeof" "uint" "ulong" "unchecked" "unsafe" "ushort"
    "using" "using static" "virtual" "void" "volatile" "while"
    )
)

(define reserved-words-reg-ex
    (regexp (string-append "(?![^<]*>)\\b(" (string-join (map regexp-quote reserved-words-list) "|") ")\\b"))
)

(define reserved-words-span
    (lambda m (string-append "<span class=reserved-words>" (first m) "</span>"))
)

(define reserved-words
  (lambda (s)
    (regexp-replace* reserved-words-reg-ex s reserved-words-span)
  )
)

(provide reserved-words)

