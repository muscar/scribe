;;;; scribe.asd

(asdf:defsystem #:scribe
  :serial t
  :description "Describe scribe here"
  :author "Alex Muscar"
  :license "MIT"
  :components ((:file "package")
	       (:file "utils")
	       (:file "output")
	       (:file "tex")
	       (:file "html5")
               (:file "scribe")))

