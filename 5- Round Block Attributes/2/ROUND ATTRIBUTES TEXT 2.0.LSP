(princ "Author: Ahmed Abd-elmotey - FEB 2016 - ahmed.abdelmotey92@gmail.com - To Run Type : RAV")
(defun c:RAV()
	(progn
	(setq tags (list "L1" "L2" "L4" "L6" "L7"))	
	(setq 
		ss (ssget)
		i 0
	)	
	(repeat (sslength ss)
	(setq 
		obj (vlax-EName->vla-Object (ssname ss i))
		lstatts (vlax-SafeArray->list (variant-Value (vla-GetAttributes obj)))
		chng '()
	)
	(foreach atts lstatts (if (member (vla-Get-TagString atts) tags)(setq chng (cons (list atts (vla-get-textstring atts)) chng))))
	(setq aa (mapcar '(lambda (x)(list (car x) (rtos (atof (cadr x)) 2 2))) chng))
	(foreach k aa (vla-Put-TextString (car k) (cadr k)))	
	(setq i (1+ i))
	)
	)
)


