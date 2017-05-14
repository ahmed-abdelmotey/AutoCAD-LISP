(princ "Author: Ahmed Abd-elmotey - MAR 2016 - ahmed.abdelmotey92@gmail.com - To Run Type : RBLK")
(defun c:rblk()
	(setq 
		ss (ssget "x" (list (cons 0 "insert")))
		i 0
		blks '()
	)
	;get old values
	(repeat (sslength ss)
		(progn 
			(setq obj (vlax-ename->vla-object (ssname ss i)))
			(if 
				(= (vla-get-effectivename obj) "ASAS")
				(progn
					(setq 			
						lstatts (vlax-SafeArray->list (variant-Value (vla-GetAttributes obj)))
						pt (vlax-variant-value (vla-get-InsertionPoint obj))
					)
					(foreach atts lstatts (if (= (vla-Get-TagString atts) "ELEVATION")(setq elev (vla-get-textstring atts))))
					(foreach atts lstatts (if (= (vla-Get-TagString atts) "LEVEL")(setq lvl (vla-get-textstring atts))))	
					(setq blks (cons (list pt (strcat "+" (substr elev 7 (- (strlen elev) 5))) lvl) blks))
					(setq oldblks (cons obj oldblks))
					
				)
			)
		)		
		(setq i (1+ i))
	)
	(setq coblk (vlax-ename->vla-object (car (entsel))))
	;copy new blocks
	(foreach blk blks
		(progn
			(setq 
				newobj (vla-copy coblk)
				newatts (vlax-SafeArray->list (variant-Value (vla-GetAttributes newobj)))
			)
			(vla-move newobj (vlax-variant-value (vla-get-InsertionPoint coblk)) (car blk))
			(foreach att newatts (if (= (vla-Get-TagString att) "ELEVATION")(setq elev (vla-put-textstring att (cadr blk)))))
			(foreach att newatts (if (= (vla-Get-TagString att) "LEVEL")(setq lvl (vla-put-textstring att (caddr blk)))))
		)
	)
	(foreach oldblk oldblks (vla-erase oldblk))
)