(princ "Author: Ahmed Abd-elmotey - FEB 2016 - ahmed.abdelmotey92@gmail.com - To Run Type : RAV")
(defun c:RAV()
	(progn
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
	
	(foreach atts lstatts (if (numberp (read (vla-get-TextString atts)))(vla-Put-TextString atts (rtos (atof (vla-get-TextString atts)) 2 2))))
	(setq i (1+ i))
	)
	)
)