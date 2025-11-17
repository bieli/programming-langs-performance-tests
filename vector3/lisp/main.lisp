(load "vector3d.lisp")
(use-package :vector3d)

(defparameter *iterations* 100000000)

(defun benchmark (label fn)
  (let ((start (get-internal-real-time)))
    (dotimes (_ *iterations*)
      (funcall fn))
    (let* ((end (get-internal-real-time))
           (elapsed (/ (- end start) internal-time-units-per-second)))
      (format t "~A: ~,8f seconds~%" label elapsed))))

(let* ((v1 (make-vector3d :x 1.0 :y 2.0 :z 3.0))
       (v2 (make-vector3d :x 4.0 :y 5.0 :z 6.0)))
  (format t "Technology: Common Lisp (SBCL)~%")
  (benchmark "Addition" (lambda () (vector3d-add v1 v2)))
  (benchmark "Subtraction" (lambda () (vector3d-subtract v1 v2)))
  (benchmark "Scaling" (lambda () (vector3d-scale v1 2.5)))
  (benchmark "Normalization" (lambda () (vector3d-normalize v1)))
  (benchmark "Angle" (lambda () (vector3d-angle v1 v2))))

