;;;; scribe.lisp

(in-package #:scribe)

(defclass document ()
  ((title :initarg :title :type string :accessor document-title)
   (body :initform (make-array 32 :adjustable t :fill-pointer 0) :accessor document-body)))

(defun |@-reader| (s n)
  (declare (ignore n))
  (let ((category (read-while s (partial #'char/= #\{)))
	(text (read-while s (partial #'char/= #\}))))
    (if (char/= (read-char s) #\})
	(error "unexpected end of file; expecting closing }")
	(list (intern (string-upcase category) (find-package "KEYWORD"))
	      (subseq text 1)))))

(defun read-document (path)
  (with-open-file (in path)
    (let ((*readtable* (copy-readtable nil)))
      (set-macro-character #\@ #'|@-reader|)
      (loop for fragment = #1=(read-fragment in) then #1#
	 while fragment
	 nconc fragment))))

(defun read-fragment (in)
  (case (peek-char nil in nil #\Nul)
    (#\Nul nil)
    (#\@ (list (read-preserving-whitespace in nil nil)))
    (otherwise (let ((text (read-while in (partial #'char/= #\@))))
		 (mapcar #'process-raw-string (split-by text #\Newline))))))

(defun process-raw-string (text)
  (if (= (length text) 0)
      `(:break)
      `(:raw-string ,text)))

(defun raw-string-p (fragment)
  (and (consp fragment) (eq (first fragment) :raw-string)))

(defun paragraph-break-p (fragment)
  (assert (listp fragment) () "~a is not a valid fragment")
  (and (raw-string-p fragment) (= (length (second fragment)) 0)))

(defun decode-document (document)
  (let ((new-document (make-instance 'document))
	acc)
    (dolist (fragment document new-document)
      (case (first fragment)
	(:break (when acc
		  (vector-push-extend `(:para ,@(nreverse acc)) (document-body new-document))
		  (setf acc nil)))
	(:title (setf (document-title new-document) (second fragment)))
	(t (push fragment acc))))))

(defun compile-document (driver document out)
  (let ((*document-output* out))
    (emit driver :title (document-title document))
    (loop for op across (document-body document)
       do (apply #'emit driver op))))

(defun process (path &key driver)
  (compile-document driver (decode-document (read-document path)) t))
