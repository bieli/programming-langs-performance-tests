(defpackage :vector2d
  (:use :cl)
  (:export :make-vector2d
           :vector2d-add
           :vector2d-subtract
           :vector2d-scale
           :vector2d-magnitude
           :vector2d-normalize
           :vector2d-angle))

(in-package :vector2d)

(defstruct vector2d
  x
  y)

(defun vector2d-add (v1 v2)
  (make-vector2d
   :x (+ (vector2d-x v1) (vector2d-x v2))
   :y (+ (vector2d-y v1) (vector2d-y v2))))

(defun vector2d-subtract (v1 v2)
  (make-vector2d
   :x (- (vector2d-x v1) (vector2d-x v2))
   :y (- (vector2d-y v1) (vector2d-y v2))))

(defun vector2d-scale (v scalar)
  (make-vector2d
   :x (* (vector2d-x v) scalar)
   :y (* (vector2d-y v) scalar)))

(defun vector2d-magnitude (v)
  (sqrt (+ (expt (vector2d-x v) 2)
           (expt (vector2d-y v) 2))))

(defun vector2d-normalize (v)
  (let ((mag (vector2d-magnitude v)))
    (if (zerop mag)
        (make-vector2d :x 0.0 :y 0.0)
        (vector2d-scale v (/ 1.0 mag)))))

(defun vector2d-angle (v1 v2)
  (let* ((dot (+ (* (vector2d-x v1) (vector2d-x v2))
                 (* (vector2d-y v1) (vector2d-y v2))))
         (mag1 (vector2d-magnitude v1))
         (mag2 (vector2d-magnitude v2))
         (cos-theta (/ dot (+ (* mag1 mag2) 1e-9))))
    (* (acos cos-theta) 180.0 (/ pi))))

