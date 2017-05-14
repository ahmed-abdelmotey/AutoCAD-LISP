(defun c:asd ()
(setvar "cmdecho" 0)
(setq 
	n 1 
	qqq '()
	sss '()	
	inc (repeat 256 (progn (setq qqq (cons n qqq)) (setq n (1+ n))))
	d (reverse (mapcar '(lambda (x) (cond ((< x 10)(strcat "%%00" (rtos x 2 0))) ((< x 100)(strcat "%%0" (rtos x 2 0))) (t (strcat "%%" (rtos x 2 0)))) ) qqq))
	sss (vlax-safearray->list (vlax-variant-value (vla-arrayrectangular (vlax-ename->vla-object (car (entsel))) 1 256 1 1 20 1)))
)
(mapcar '(lambda (x y) (vla-put-TextString y x)) d sss)
(setvar "cmdecho" 1)
(princ)
)
