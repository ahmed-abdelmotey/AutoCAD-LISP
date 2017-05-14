;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; automatically adjust refrences and    ;;;;;;;
;;;;; district keyplan hatch.               ;;;;;;;
;;;;; written by: ahmed mohamed abd-elmotey ;;;;;;;
;;;;; Date: 19-11-2015                      ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; All rights reserved  ;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; To Run Type CBD      ;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun c:cbd()
(foreach lay (layoutlist)
;references
	(setq tpname (substr lay 9 3) npre (substr lay 1 21))
	(if (= tpname "900")
		(setq newvalues 
			;input values here for type 900
			(list "GROUND FLOOR PLAN" (strcat npre "101") "FIRST FLOOR PLAN" (strcat npre "102") "ROOF PLAN" (strcat npre "103") "UPPER ROOF PLAN" (strcat npre "104"))
		)  
		(setq newvalues (list "GROUND & FIRST FLOOR PLANS" (strcat npre "101") "ROOF & UPPER ROOF PLANS" (strcat npre "102")))  ;rest of types
	)
	(repeat (-  8 (length newvalues))(setq newvalues (reverse (cons "" (reverse newvalues)))))
(progn
	(setq tags (list "REF.NAME1" "REF.NO1" "REF.NAME2" "REF.NO2" "REF.NAME3" "REF.NO3" "REF.NAME4" "REF.NO4"))
	(setq obj (vlax-EName->vla-Object (ssname (ssget "x" (list (cons 0 "INSERT") (cons 2 "TB ATTERIBUTE") (cons 410 lay))) 0)))
	(setq lstatts (vlax-SafeArray->list (variant-Value (vla-GetAttributes obj))))
	(setq chng '())
	(foreach atts lstatts (if (member (vla-Get-TagString atts) tags)(setq chng (cons atts chng))))
	(setq aa (mapcar (function (lambda (a b) (cons a b))) chng (reverse newvalues)))
	(foreach k aa (vla-Put-TextString (car k) (cdr k)))
)
;visibility change

;in each layout get blocks
	(setq vis (substr lay 1 2))
	(setq ss (ssget "x" (list (cons 0 "INSERT") (cons 410 lay))))
	(setq idx 0 allblocks '())
	(while (< idx (sslength ss))
		(setq allblocks (cons (vlax-EName->vla-Object (ssname ss idx)) allblocks)
			  idx (1+ idx)
		)
	)
	(foreach blk allblocks (cond ((= (vla-Get-EffectiveName blk) "kpln_dist")(setq a blk))))
;sec block vis -key plan-		
	(progn
		(setq lstDyns (vlax-SafeArray->list (variant-Value (vla-GetDynamicBlockProperties a))))
		(foreach dyn lstDyns
		  (if (= "Visibility1" (vla-Get-PropertyName dyn))(vlax-Put-Property dyn 'Value vis))
		)
	)
)
)