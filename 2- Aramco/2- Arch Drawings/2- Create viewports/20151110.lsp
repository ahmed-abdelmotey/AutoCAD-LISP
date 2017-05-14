(defun pos (item lst)
	(setq idxlst '() idxed '() i 0)
	(repeat (length lst) (progn (setq idxlst (cons i idxlst))(setq i (+ 1 i))))
	(setq idxed (mapcar (function (lambda (a b) (cons a b))) lst (reverse idxlst)))
	(setq position (+ 1 (cdr (assoc item idxed))))
)
(defun c:crtlo()
(setq prefix (substr (car (layoutlist)) 1 21) typearea (substr (car (layoutlist)) 9 5) suffix (list "101" "102" "201") dnamep (list 807.0335 -763.5787 0.0))
(cond 
((or (= typearea "450-4") (= typearea "600-1") (= typearea "600-4") (= typearea "700-3"))(setq suffix (acad_strlsort (append (list "202") suffix))))
((= typearea "900-3")(setq suffix (acad_strlsort (append (list "103" "104" "202") suffix))))
((= typearea "900-4")(setq suffix (acad_strlsort (append (list "103" "104" "202" "203") suffix))))
)
		;defining the secoend sylable of series 200 names
		(setq ftyp (substr (car (layoutlist)) 15 1))
		(cond 
		((and (= ftyp "C")(= (length suffix)  3))(setq fname "\nSECTIONS - CONTEMPORARY"))
		((and (= ftyp "T")(= (length suffix)  3))(setq fname "\nSECTIONS - TRADITIONAL" ))
		((and (= ftyp "C")(/= (length suffix) 3))(setq fname "CONTEMPORARY"))
		((and (= ftyp "T")(/= (length suffix) 3))(setq fname "TRADITIONAL" ))
		)
;setting dname >> list of drawing names		
(cond
((= (length suffix) 3)(setq dname (list "GROUND & FIRST FLOOR PLANS" "ROOF & UPPER ROOF PLANS" (strcat "BUILDING ELEVATION &" fname))))
((= (length suffix) 4)(setq dname (list "GROUND & FIRST FLOOR PLANS" "ROOF & UPPER ROOF PLANS" (strcat "BUILDING ELEVATIONS - " fname)(strcat "BUILDING SECTIONS - " fname))))
((= (length suffix) 6)(setq dname (list "GROUND FLOOR PLAN" "FIRST FLOOR PLAN" "ROOF PLAN" "UPPER ROOF PLAN" (strcat "BUILDING ELEVATIONS - " fname)(strcat "BUILDING ELEVATIONS - " fname))))
((= (length suffix) 7)(setq dname (list "GROUND FLOOR PLAN" "FIRST FLOOR PLAN" "ROOF PLAN" "UPPER ROOF PLAN" (strcat "BUILDING ELEVATIONS - " fname)(strcat "BUILDING ELEVATIONS - " fname)(strcat "BUILDING SECTIONS - " fname))))
)
(setq dno (mapcar '(lambda (x) (strcat prefix x)) suffix))
(setq drawings (mapcar (function (lambda (a b) (cons a b))) dno dname))

(foreach i (reverse drawings)
	(progn  
		;crt layouts
		(command-s "._layout" "_c" (car (layoutlist)) (car i))
		;insrt Dwg name
		(entmake (list
			(cons 0  "MTEXT")(cons 100  "AcDbEntity")(cons 100  "AcDbMText")
			(cons 7  "Arial_8")(cons 8  "0-XREF-TB")(cons 10 dnamep)
			(cons 410 (car i))
			(cons 40 4.0); mtext height	   
			(cons 41  0.0)(cons 50  0.0)
			(cons 71  5)(cons 72  5)(cons 73  1)
			(cons 1  (cdr i)); mtext string
			(cons 44  1.0);line spacing
		))
	)
)
(command-s "._layout" "_d" (car (layoutlist)))


(foreach lName (layoutlist)
;refrences
(progn
	(setq nofplan 0)
	(foreach lay (layoutlist) (if (= "1" (substr lay 22 1))(setq nofplan (+ 1 nofplan))))
	(cond 
		((= nofplan 4)(setq dwgs (list '("100" "SITE LAYOUT") '("101" "GROUND FLOOR PLAN") '("102" "FIRST FLOOR PLAN") '("103" "ROOF PLAN") '("104" "UPPER ROOF PLAN"))))
		((= nofplan 2)(setq dwgs (list '("100" "SITE LAYOUT") '("101" "GROUND & FIRST FLOOR PLANS") '("102" "ROOF & UPPER ROOF PLANS"))))
		(t (alert (strcat "This File Has : " (rtos nofplan 2 0) "  plans" "\nPlease Check Arch Type")))
	)

	(cond 
		((>= (/ nofplan 2) (pos lName (layoutlist)))(setq tits (list (car dwgs))))
		((and (<= (/ nofplan 2) (pos lName (layoutlist)))(> (+ 1 nofplan) (pos lName (layoutlist))))
			(cond 
				((= (length dwgs) 3)(setq tits (list (nth 1 dwgs))))
				((= (length dwgs) 5)(setq tits (list (nth 1 dwgs)(nth 2 dwgs))))
			)
		)
		((< nofplan (pos lName (layoutlist)))(setq tits (cdr dwgs)))
		(t (alert "damn")) ;shud be error trapping method
	)
	(setq tits (mapcar '(lambda (x) (list (cadr x) (strcat (substr (car (layoutlist)) 1 21) (car x)))) tits))
	(setq bb '())
	(foreach x tits (setq bb (append (list (cadr x) (car x)) bb)))
	(setq newvalues (reverse bb))
	(repeat (-  8 (length newvalues))(setq newvalues (reverse (cons "" (reverse newvalues)))))
)
;put newvalues into attributes text string
(progn
(setq tags (list "REF.NAME1" "REF.NO1" "REF.NAME2" "REF.NO2" "REF.NAME3" "REF.NO3" "REF.NAME4" "REF.NO4"))
(setq obj (vlax-EName->vla-Object (ssname (ssget "x" (list (cons 0 "INSERT") (cons 2 "TB ATTERIBUTE") (cons 410 lName))) 0)))
(setq lstatts (vlax-SafeArray->list (variant-Value (vla-GetAttributes obj))))
(setq chng '())
(foreach atts lstatts (if (member (vla-Get-TagString atts) tags)(setq chng (cons atts chng))))
(setq aa (mapcar (function (lambda (a b) (cons a b))) chng (reverse newvalues)))
(foreach k aa (vla-Put-TextString (car k) (cdr k)))
;;;;
;visibility
(if (= "2" (substr lName 22 1))(progn 
;in each layout get blocks
	(setq vis (substr lName 9 5))
	(setq ss (ssget "x" (list (cons 0 "INSERT") (cons 410 lName))))
	(setq idx 0 allblocks '())
	(while (< idx (sslength ss))
		(setq allblocks (cons (vlax-EName->vla-Object (ssname ss idx)) allblocks)
			  idx (1+ idx)
		)
	)
	(foreach blk allblocks (cond 
		((= (vla-Get-EffectiveName blk) "FLOOR PLAN LEGEND")(setq a blk))
		((= (vla-Get-EffectiveName blk) "kpln arch")(setq b blk))
	))
;sec block vis -key plan-		
	(progn
		(setq lstDyns (vlax-SafeArray->list (variant-Value (vla-GetDynamicBlockProperties b))))
		(foreach dyn lstDyns
		  (if (= "Visabilityplan" (vla-Get-PropertyName dyn))(vlax-Put-Property dyn 'Value vis))
		)
	)
;sec block vis -legend-	
	(progn
		(setq lstDyns (vlax-SafeArray->list (variant-Value (vla-GetDynamicBlockProperties a))))
		(foreach dyn lstDyns
		  (if (= "LEGEND" (vla-Get-PropertyName dyn))(vlax-Put-Property dyn 'Value "ELEV"))
		)
	)
)
)
;;;;;;;;;
)
)
	(setq hmarg 100 p1 (list 409500.0 2905000.0) vbw 67.2 vbh 56.8 pointtoc (list 399.4874 -534.5941) sc 0.1)
	(setq vmarg 100 vbw 67.2 vbh 56.8)  
	(setq bkcode (substr (car (layoutlist)) 9 7)) ;>>>>>>>> Redefine
		(cond
			((= bkcode "350-1-T")(setq m+rgfct 0))
			((= bkcode "350-1-C")(setq mrgfct -1))
			((= bkcode "350-2-T")(setq mrgfct -2))
			((= bkcode "350-2-C")(setq mrgfct -3))
			((= bkcode "450-1-T")(setq mrgfct -4))
			((= bkcode "450-1-C")(setq mrgfct -5))
			((= bkcode "450-4-T")(setq mrgfct -6))
			((= bkcode "450-4-C")(setq mrgfct -7))
			((= bkcode "500-1-T")(setq mrgfct -8))
			((= bkcode "500-1-C")(setq mrgfct -9))
			((= bkcode "500-3-T")(setq mrgfct -10))
			((= bkcode "500-3-C")(setq mrgfct -11))
			((= bkcode "500-5-T")(setq mrgfct -12))
			((= bkcode "500-5-C")(setq mrgfct -13))
			((= bkcode "600-1-T")(setq mrgfct -14))
			((= bkcode "600-1-C")(setq mrgfct -15))
			((= bkcode "600-4-T")(setq mrgfct -16))
			((= bkcode "600-4-C")(setq mrgfct -17))
			((= bkcode "700-3-T")(setq mrgfct -18))
			((= bkcode "700-3-C")(setq mrgfct -19))
			((= bkcode "900-3-T")(setq mrgfct -20))
			((= bkcode "900-3-C")(setq mrgfct -21))
			((= bkcode "900-4-T")(setq mrgfct -22))
			((= bkcode "900-4-C")(setq mrgfct -23))
			(t (progn (setq mrgfct -1)))
		)
		
(foreach layoutt (layoutlist)

;pan viewport
(progn 

	(setq p2 (list (+ (car p1) vbw)(+ (cadr p1) vbh)))
	(setq doc (vla-get-activedocument (vlax-get-acad-object)) layouts (vla-get-layouts doc))
		(vla-put-activelayout doc (vla-item layouts layoutt))
        (vla-put-MSpace doc :vlax-false)
        (if (setq vpp pointtoc)
          (progn
            (if (< (car (trans p2 1 0))(car (trans p1 1 0)))(setq tmp p1 p1 p2 p2 tmp))
            (setq mp (list (/ (+ (car p1) (car p2)) 2) (/ (+ (cadr p1) (cadr p2)) 2) 0.0 ))
            (setq vpdoc (vla-get-PaperSpace doc) vp (vla-AddPViewport vpdoc (vlax-3d-point vpp)(abs (/ (- (car p2) (car p1)) sc))(abs (/ (- (cadr p2) (cadr p1)) sc))))
            (vla-display vp :vlax-true)
            (vla-put-MSpace doc :vlax-true)
            (vla-put-ActivePViewport doc vp)
            (vla-ZoomCenter (vlax-get-acad-object) (vlax-3d-point mp) 1.0 )
            (vla-put-CustomScale vp (/ 1. sc))
            (vla-put-MSpace doc :vlax-false)
		))
		(setq p1 (list (+ (car p1) hmarg) (cadr p1)))
		
)


  (if	(setq ss (ssget "_X" (list '(0 . "VIEWPORT") (cons 410 (getvar "ctab")))))
      (repeat (setq i (sslength ss))
	(setq ent (entget (ssname ss (setq i (1- i))))
	      vp  (cdr (assoc 69 ent))
	)
	(if (> vp 1)
	  (progn
	    (command "_.mspace")
	    (setvar 'CVPORT vp)
		(setq pttt1 (list 0 0))(setq pttt2 (list 0 (* mrgfct vmarg)))
	    (command "_.-PAN" pttt1 pttt2)
	  ))))
	  (command "_.pspace")
)

)