(load "vector2d.lisp")
(use-package :vector2d)

(defparameter *iterations* 100000000)

(defun benchmark (label fn)
  (let ((start (get-internal-real-time)))
    (dotimes (_ *iterations*)
      (funcall fn))
    (let* ((end (get-internal-real-time))
           (elapsed (/ (- end start) internal-time-units-per-second)))
      (format t "~A: ~,8f seconds~%" label elapsed))))

(let* ((v1 (make-vector2d :x 1.0 :y 2.0))
       (v2 (make-vector2d :x 3.0 :y 4.0)))
  (format t "Technology: Common Lisp (SBCL)~%")
  (benchmark "Addition" (lambda () (vector2d-add v1 v2)))
  (benchmark "Subtraction" (lambda () (vector2d-subtract v1 v2)))
  (benchmark "Scaling" (lambda () (vector2d-scale v1 2.5)))
  (benchmark "Normalization" (lambda () (vector2d-normalize v1)))
  (benchmark "Angle" (lambda () (vector2d-angle v1 v2))))

