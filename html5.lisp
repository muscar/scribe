(in-package #:scribe.output.html5)

(define-driver-definer define-html5 :html5)

(define-html5 :title (title)
  (format *document-output* "<h1>~a</h1>~%" title))

(define-html5 :para (&rest fragments)
  (format *document-output* "<p>~%")
  (emit-fragments :tex fragments)
  (format *document-output* "</p>~%"))

(define-html5 :bold (text)
  (format *document-output* "<strong>~a</strong>" text))

(define-html5 :italic (text)
  (format *document-output* "<em>~a</em>" text))

(define-html5 :raw-string (text)
  (format *document-output* "~a" text))
