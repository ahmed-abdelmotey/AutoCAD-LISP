(defun c:ASD()
	(progn
	(setq tags (list "ELEVATION"))	
	(setq 
		ss (ssget)
		i 0
		amm (getreal)
	)	
	(repeat (sslength ss)
	(setq 
		obj (vlax-EName->vla-Object (ssname ss i))
		lstatts (vlax-SafeArray->list (variant-Value (vla-GetAttributes obj)))
		chng '()
	)
	(foreach atts lstatts (if (member (vla-Get-TagString atts) tags)(setq chng (cons (list atts (vla-get-textstring atts)) chng))))
	(setq aa (mapcar '(lambda (x)(list (car x) (strcat "+" (rtos (+ (atof (cadr x)) amm) 2 3)))) chng))
	(foreach k aa (vla-Put-TextString (car k) (cadr k)))	
	(setq i (1+ i))
	)
	)
)


(defun c:ASD1()
	(progn
	(setq tags (list "ELEVATION"))	
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
	(setq aa (mapcar '(lambda (x)(list (car x) (strcat "+" (rtos (+ (atof (cadr x)) 0.15) 2 3)))) chng))
	(foreach k aa (vla-Put-TextString (car k) (cadr k)))	
	(setq i (1+ i))
	)
	)
)