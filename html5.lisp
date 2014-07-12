(in-package #:scribe)

(defcommand :title (title)
  (format *document-output* "<h1>~a</h1>~%" title))

(defcommand :bold (text)
  (format *document-output* "<strong>~a</strong>" text))

(defcommand :italic (text)
  (format *document-output* "<em>~a</em>" text))

(defcommand :raw-string (text)
  (format *document-output* "~a" text))

(defcommand :break ()
  (format *document-output* "<br/>~%"))
