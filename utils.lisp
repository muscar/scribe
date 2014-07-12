(in-package #:scribe.utils)

(defun partial (func &rest args1)
  "Partially applies the fun function to args1."
  (lambda (&rest args2) (apply func (append args1 args2))))

(defun split-by (string &optional (sep #\Space))
  "Returns a list of substrings of string divided by the sep char."
  (loop for i = 0 then (1+ j)
     as j = (position sep string :start i)
     collect (subseq string i j)
     while j))

(defun join-string-list (string-list)
  "Concatenates a list of strings and puts spaces between the elements."
  (format nil "~{~A~^ ~}" string-list))

(defun read-while (in pred)
  "Returns a string of consecutive chars for which pred returns true from the in stream."
  (coerce (loop for c = (peek-char nil in nil #\Nul)
	     while (and (char/= c #\Nul) (funcall pred c))
	     collect (read-char in c))
	  'string))
