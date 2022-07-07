#|
 This file is a part of trial
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.trial)

(defvar *language-change-hooks* '())
(defvar *languages* (make-hash-table :test 'equalp))
(define-global +language-data+ NIL)

(defun languages ()
  (mapcar #'pathname-utils:directory-name
          (directory (merge-pathnames "lang/*/" (root)))))


(defun language-dir (&optional (language (setting :language)))
  (merge-pathnames (make-pathname :directory `(:relative "lang" ,(string-downcase language)))
                   (root)))

(defun language-file (&optional (language (setting :language)))
  (make-pathname :name "strings" :type "lisp" :defaults (language-dir language)))

(defun language-files (&optional (language (setting :language)))
  (directory (make-pathname :name :wild :type "lisp" :defaults (language-dir language))))

(defmacro define-language-change-hook (name args &body body)
  (let ((name (mksym *package* '%language-change-hook name)))
    `(progn
       (defun ,name ,args
         ,@body)
       (pushnew ',name *language-change-hooks*))))

(defun load-language (&optional (language (setting :language)) replace)
  (let ((table (if (or replace (null +language-data+))
                   (make-hash-table :test 'eq)
                   +language-data+)))
    (v:info :trial.language "Loading language ~s from ~a" language (language-file language))
    (with-trial-io-syntax ()
      (with-open-file (stream (language-file language) :if-does-not-exist nil)
        (cond (stream
               (loop for k = (read stream NIL)
                     for v = (read stream NIL)
                     while k
                     do (setf (gethash k table) v))
               (setf (gethash language *languages*) table)
               (setf +language-data+ table))
              ((gethash language *languages*)
               (setf +language-data+ (gethash language *languages*)))
              (T
               (error "No language named ~s found." language)))
        (dolist (hook *language-change-hooks* table)
          (funcall hook language))))))

(defun save-language (&optional (language (setting :language)))
  (when +language-data+
    (v:info :trial.language "Saving language ~s to ~s" language (language-file language))
    (with-trial-io-syntax ()
      (with-open-file (stream (language-file language)
                              :direction :output
                              :if-exists :supersede)
        (loop for k being the hash-keys of +language-data+
              for v being the hash-keys of +language-data+
              do (format stream "~s ~s~%" k v))))))

(defun language-string (identifier &optional (errorp T))
  (unless +language-data+ (load-language))
  (or (gethash identifier +language-data+)
      (unless errorp (return-from language-string NIL))
      ;; Try loading again in case things changed.
      (progn (load-language)
             (gethash identifier +language-data+))
      (restart-case
          (error "No language string defined for ~s" identifier)
        (retry ()
          :report "Retry now."
          (language-string identifier))
        (use-value (value)
          :report "Supply a string to use."
          value))))

(defun (setf language-string) (string identifier)
  (unless +language-data+ (load-language))
  (check-type string string)
  (check-type identifier symbol)
  (setf (gethash identifier +language-data+) string))

(defun ensure-language-string (thing)
  (etypecase thing
    (string thing)
    (symbol (language-string thing))))

(define-setting-observer load-language :language (value)
  (load-language value))

(defun @format (destination identifier &rest args)
  (format destination "~?" (language-string identifier) args))

(defun @formats (identifier &rest args)
  (format NIL "~?" (language-string identifier) args))

(defmacro @ (identifier)
    `(language-string ',identifier))

(set-dispatch-macro-character
 #\# #\@ (lambda (s c a)
           (declare (ignore c a))
           (language-string (read s T NIL T))))
