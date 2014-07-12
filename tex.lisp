(in-package #:scribe)

(defcommand :title (title)
  (format *document-output* "\\title{~a}~%\\maketitle~%" title))

(defcommand :para (&rest fragments)
  (emit-fragments fragments)
  (format t "~%~%"))

(defcommand :bold (text)
  (format *document-output* "\\textbf{~a}" text))

(defcommand :italic (text)
  (format *document-output* "\\emph{~a}" text))

(defcommand :raw-string (text)
  (format *document-output* "~a" text))
