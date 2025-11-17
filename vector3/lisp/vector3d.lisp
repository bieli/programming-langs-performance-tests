(defpackage :vector3d
  (:use :cl)
  (:export :make-vector3d
           :vector3d-add
           :vector3d-subtract
           :vector3d-scale
           :vector3d-magnitude
           :vector3d-normalize
           :vector3d-angle))

(in-package :vector3d)

(defstruct vector3d
  x
  y
  z)

(defun vector3d-add (v1 v2)
  (make-vector3d
   :x (+ (vector3d-x v1) (vector3d-x v2))
   :y (+ (vector3d-y v1) (vector3d-y v2))
   :z (+ (vector3d-z v1) (vector3d-z v2))))

(defun vector3d-subtract (v1 v2)
  (make-vector3d
   :x (- (vector3d-x v1) (vector3d-x v2))
   :y (- (vector3d-y v1) (vector3d-y v2))
   :z (- (vector3d-z v1) (vector3d-z v2))))

(defun vector3d-scale (v scalar)
  (make-vector3d
   :x (* (vector3d-x v) scalar)
   :y (* (vector3d-y v) scalar)
   :z (* (vector3d-z v) scalar)))

(defun vector3d-magnitude (v)
  (sqrt (+ (expt (vector3d-x v) 2)
           (expt (vector3d-y v) 2)
           (expt (vector3d-z v) 2))))

(defun vector3d-normalize (v)
  (let ((mag (vector3d-magnitude v)))
    (if (zerop mag)
        (make-vector3d :x 0.0 :y 0.0 :z 0.0)
        (vector3d-scale v (/ 1.0 mag)))))

(defun vector3d-angle (v1 v2)
  (let* ((dot (+ (* (vector3d-x v1) (vector3d-x v2))
                 (* (vector3d-y v1) (vector3d-y v2))
                 (* (vector3d-z v1) (vector3d-z v2))))
         (mag1 (vector3d-magnitude v1))
         (mag2 (vector3d-magnitude v2))
         (cos-theta (/ dot (+ (* mag1 mag2) 1e-9))))
    (* (acos cos-theta) 180.0 (/ pi))))

