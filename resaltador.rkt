;;Alan Patricio González Bernal - A01065746
;;Arturo Cristian Díaz López - A01709522


#lang racket

;; Definición de las expresiones regulares
(define strings (regexp "(\"(\\\\.|[^\\\\\"])*\")"))

(define (replace-comment s) (string-append "<span class=\"comment\">" s "</span>"))

(define System '("System" "Console" "Program"))

(define reserved-words '("abstract" "as" "base" "bool" "break" "byte" "case" "catch" "char"
                          "checked" "class" "const" "continue" "decimal" "default" "delegate"
                          "do" "double" "else" "enum" "event" "explicit" "extern" "false"
                          "finally" "fixed" "float" "for" "foreach" "goto" "if" "implicit"
                          "in" "long" "namespace" "new" "null" "object" "operator"
                          "out" "override" "params" "private" "int" "interface" "internal" "is" "lock" 
                          "protected" "public" "readonly" "ref" "return" "sbyte" "sealed" "short"
                          "sizeof" "stackalloc" "static" "string" "struct" "switch" "this" "throw"
                          "true" "try" "typeof" "uint" "ulong" "unchecked" "unsafe" "ushort"
                          "using" "using static" "virtual" "void" "volatile" "while"))

(define operators '("+" "-" "*" "/" "%" "&" "|" "^" "!" "~" "=" "<" ">" "+=" "-=" "*=" "/=" "%=" "&="
                   "|=" "^=" "<<" ">>" ">>>" "<<=" ">>=" ">>>=" "==" "!=" "<=" ">=" "&&" "||" "++"
                   "--" "?" "??"))

(define separators '(";" "," "." "(" ")" "[" "]" "{" "}" "<" ">" ":" "::" "..." "=>" "??"))

(define comments (regexp "(//.*|/\\*.*\\*/|/\\*.*|.*\\*/)"))

(define identifiers (regexp "[a-zA-Z_][a-zA-Z0-9_]*$"))

(define numbers (regexp "(\\b[0-9]+(\\.[0-9]*)?\\b)"))

(define (categorize-token s)
    (cond
      [(member s separators) (string-append "<span class=\"separator\">" s "</span>")]
      [(member s System) (string-append "<span class=\"System\">" s "</span>")]
      [(regexp-match comments s) (string-append "<span class=\"comment\">" s "</span>")]
      [(regexp-match numbers s) (string-append "<span class=\"number\">" s "</span>")]
      [(regexp-match strings s) (string-append "<span class=\"string\">" s "</span>")]
      [(member s reserved-words) (string-append "<span class=\"keyword\">" s "</span>")]
      [(regexp-match identifiers s) (string-append "<span class=\"identifier\">" s "</span>")]
      [(member s operators) (string-append "<span class=\"keyword\">" s "</span>")]
      [else s])
)

;;Token
(define (token-line line open-block-comment)
  (define word '())
  (define list-line '())
  (define tokenized-line '())
  (define quotes-open #f)

  (define possible-line-comment #f)
  (define open-line-comment #f)

  (define chars (regexp-split #px"" line))

     (for/last ([char chars])
      (when (and (eq? char (last chars)) (or open-line-comment open-block-comment))
        (set! list-line (append list-line (list word))))

      ; Matchea el caracter con las expresiones regulares
      (cond 
        [open-block-comment (set! word (append word (list char)))]

        [(regexp-match #rx"#" char) (set! word (append word (list char)))]

        [(regexp-match? #rx"[a-zA-Z0-9_]" char)
         (set! word (append word (list char)))]

        ; Match para los comments
        [(regexp-match #px"/" char) 
          (cond 
            [possible-line-comment 
              ((lambda () 
                (set! possible-line-comment #f)
                (set! open-line-comment #t)
                (set! word (append word (list char)))))]
            [else 
              ((lambda () 
                (set! possible-line-comment #t)
                (set! word (append word (list char)))))])]

        [open-line-comment (set! word (append word (list char)))]

        ; Matchea para los strings
        [(regexp-match? #px"\"" char)
         (cond
           [quotes-open
            ((lambda ()
               (set! quotes-open #f)
               (set! word (append word (list char)))
               (set! list-line (append list-line (list word)))
               (set! word '())))]
            [else ((lambda () 
              (set! quotes-open #t)
              (set! word (append word (list char)))))])]

        [quotes-open (set! word (append word (list char)))]

        ; Matchea los operadores
        [(regexp-match? #px"[\\.\\,\\;\\(\\)\\{\\}\\[\\]\\=\\+\\-\\*\\/\\%\\>\\<\\:]" char)
         ((lambda ()
            (set! list-line (append list-line (list word)))
            (set! word '())
            (set! word (append word (list char)))
            (set! list-line (append list-line (list word)))
            (set! word '())))]

        ; Matchea cualquier caracter
        [else
         ((lambda ()
            (set! list-line (append list-line (list word)))
            (set! word '())))])
    )

    (define tokens (map (lambda (x) (string-join x "")) list-line))

    (define (categorize-tokens tokens)
      (define (loop tokens open-block-comment)
        (cond
          [(null? tokens) '()]
          [(and (string=? (car tokens) "/*") (not open-block-comment))
            (append (list (categorize-token (car tokens))) (loop (cdr tokens) #t))]
          [(and (string=? (car tokens) "*/") open-block-comment)
            (append (list (categorize-token (car tokens))) (loop (cdr tokens) #f))]
          [open-block-comment
            (append (list (replace-comment (car tokens))) (loop (cdr tokens) #t))]
          [(string=? (car tokens) "//")
            (append (list (replace-comment (car tokens))) (loop (cdr tokens) #f))]
          [else
            (append (list (categorize-token (car tokens))) (loop (cdr tokens) #f))]))
      (loop tokens open-block-comment))

    (categorize-tokens tokens)
)

;; Función para leer un archivo
(define (read-file file-name)
    (open-input-file file-name)
)

;; Función para leer lineas
(define (read-line port)
    (read-line port)
)

;; Función para escribir un archivo
(define (write-file file-name)
    (open-output-file file-name)
)

(define input-file "main.cs")

;; Archivo de salida (output file)
(define output-file "Se logró.html")

;; Header de HTML
(define html-header
  "<!DOCTYPE html>
<html>
<head>
  <meta charset=\"utf-8\">
  <title>Resaltador siuuu</title>
  <link rel=\"stylesheet\">
</head>
<body>
  <style>

  body {
  background-color: #2b2b2b;
  color: #f8f8f2;
  font-family: Consolas, monospace;
  font-size: 14px;
  margin-left: 30px;
}

pre {
  margin: 0px;
}

span {
  display: inline-block;
}

span.keyword {
  color: #306EF2;
}

span.operator {
  color: #323DFC;
  margin: 0 -5px;
}

span.separator {
  color: #5F39E5;
  margin: 0 -3px;
}

span.identifier {
  color: #cccccc;
}

span.number {
  color: #9532FC;
}

span.string {
  color: #C430F2;
  margin-right: -3px;
}

span.comment {
  color: #30E4F2;
}

span.System {
  color: #49F2A8;
}
  
  </style>
  <pre>")

;; Foot de HTML
(define html-foot
  "</pre>
</body>
</html>")


;; Main
(define (main input-file output-file)
  (define input-lines (file->lines input-file))
  (define output-port (open-output-file output-file))
  (write-string html-header output-port)

  (define open-block-comment #f)

  (for-each (lambda (line)
              (write-string (string-append "<pre>") output-port)

              (when (not open-block-comment) 
                  (set! open-block-comment (regexp-match? #px"/\\*" line)))
                  
              (define tokens (token-line line open-block-comment))
              (define formatted-line (string-join tokens " "))

              (when open-block-comment
                  (set! open-block-comment (not (regexp-match? #px"\\*/" line))))

              (write-string (string-append formatted-line " ") output-port)
              (write-string (string-append "</pre>") output-port))
            input-lines)
  
  (write-string html-foot output-port)
  (close-output-port output-port))

(main input-file output-file)