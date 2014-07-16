(in-package #:scribe.output)

(defparameter *document-output* nil)

(defgeneric emit (driver op &rest args)
  (:documentation "Emit markup for one virtual op."))

(defun emit-fragments (driver fragments)
  (loop for (op arg) in fragments
     do (emit driver op arg)))

(defmacro define-driver-definer (name driver)
  `(defmacro ,name (name pattern &rest forms)
     (let ((g!args (gensym "args")))
       `(defmethod scribe.output:emit ((driver (eql ,,driver)) (op (eql ,name)) &rest ,g!args)
	  ;; XXX Ugly code
	  ,@(if pattern
		`((destructuring-bind ,pattern ,g!args
		    ,@forms))
		`((declare (ignore ,g!args))
		  ,@forms))))))
