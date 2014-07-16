(in-package #:scribe.output.tex)

(define-driver-definer define-tex :tex)

(define-tex :title (title)
  (format *document-output* "\\title{~a}~%\\maketitle~%~%" title))

(define-tex :para (&rest fragments)
  (emit-fragments :tex fragments)
  (format t "~%~%"))

(define-tex :bold (text)
  (format *document-output* "\\textbf{~a}" text))

(define-tex :italic (text)
  (format *document-output* "\\emph{~a}" text))

(define-tex :raw-string (text)
  (format *document-output* "~a" text))
