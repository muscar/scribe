;;;; package.lisp

(defpackage #:scribe.utils
  (:use #:cl)
  (:export #:partial
	   #:split-by
	   #:join-string-list
	   #:read-while))

(defpackage #:scribe.output
  (:use #:cl)
  (:export #:*document-output*
	   #:define-driver-definer
	   #:emit
	   #:emit-fragments))

(defpackage #:scribe.output.tex
  (:use #:cl #:scribe.output)
  (:export #:emit))

(defpackage #:scribe.output.html5
  (:use #:cl #:scribe.output)
  (:export #:emit))

(defpackage #:scribe
  (:use #:cl
	#:scribe.utils
	#:scribe.output))

