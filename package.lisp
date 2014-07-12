;;;; package.lisp

(defpackage #:scribe.utils
  (:use #:cl)
  (:export #:partial
	   #:split-by
	   #:join-string-list
	   #:read-while))

(defpackage #:scribe
  (:use #:cl
	#:scribe.utils))

