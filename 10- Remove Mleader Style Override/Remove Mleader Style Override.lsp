(princ "Author: Ahmed Abd-elmotey - MAR 2016 - ahmed.abdelmotey92@gmail.com - To Run Type : RMSO")
(defun c:RMSO ()
	(setq ss (ssget "_x" '((0 . "MULTILEADER"))) i 0 )	
	(repeat (sslength ss)
		(setq 
			obj (vlax-EName->vla-Object (ssname ss i))
			Str (vla-get-textstring obj)
		)
		
		(if (setq Pos (vl-string-search ";" Str))
			(progn
				(setq LastPos Pos)
		 		(while (setq Pos (vl-string-search ";" Str (1+ Pos)))
					(setq LastPos Pos)
		 		)
				
				(vla-put-textstring obj (vl-string-subst "" "}" (substr Str (+ 2 LastPos))))
		 	)
		)
	(setq i (1+ i))
	)
(princ)
)