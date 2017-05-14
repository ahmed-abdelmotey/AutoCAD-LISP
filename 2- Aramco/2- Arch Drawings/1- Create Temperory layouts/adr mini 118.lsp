;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; automatically create a layout with    ;;;;;;;
;;;;; needed information.                   ;;;;;;;
;;;;; designed to gets data from selected   ;;;;;;;
;;;;; polylines and create a layout with    ;;;;;;;
;;;;; the required data and renames layout  ;;;;;;;
;;;;; written by: ahmed mohamed abd-elmotey ;;;;;;;
;;;;; Date: 14-9-2015                       ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; All rights reserved  ;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; To Run Type ADR      ;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; For Help Type Ahelp  ;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Attatched:-                                              ;;
;;; 1- LayoutsToDwgs.lsp                                     ;;
;;; Created 2000-03-27                                       ;;
;;; By Jimmy Bergmark                                        ;;
;;; Copyright (C) 1997-2012 JTB World, All Rights Reserved   ;;
;;; Website: www.jtbworld.com                                ;;
;;; E-mail: info@jtbworld.com                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun settng();settings
(setq higt "10.54") ;set maximum hight
(setq mof "2+Roof") ;set maximum no. of floors
(setq mokl "mockup") ;set mock layout name
(setq th 2.5) ;Text Height
(setq ffar "100")
(setq pbet "100m")
)
(defun btyp() ;types data
	(setq bkcode (strcat (substr kk2 4 4) (substr kk2 10 1)))

		(cond
			((= bkcode "350-1")(progn 
					(setq gfar "150m{\\A1;\\H0.5x;\\S2^;}")
					(setq ffar "157m{\\A1;\\H0.5x;\\S2^;}")
					(setq anxa "32.75m{\\A1;\\H0.5x;\\S2^;}")
					(setq pbet "53m")
					(setq vcod "TOWNHOUSE 300-4BR-350 SM LOT - TYPE 1")
			))
			((= bkcode "350-2")(progn 
					(setq gfar "153m{\\A1;\\H0.5x;\\S2^;}")
					(setq ffar "153m{\\A1;\\H0.5x;\\S2^;}")
					(setq anxa "43m{\\A1;\\H0.5x;\\S2^;}")
					(setq pbet "51m")
					(setq vcod "TOWNHOUSE 300-4BR-350 SM LOT - TYPE 2")
			))
			((= bkcode "450-1")(progn 
					(setq gfar "192m{\\A1;\\H0.5x;\\S2^;}")
					(setq ffar "192m{\\A1;\\H0.5x;\\S2^;}")
					(setq anxa "41.8m{\\A1;\\H0.5x;\\S2^;}")
					(setq pbet "57.75m")
					(setq vcod "VILLA 400-5BR-450 SM LOT - TYPE 1")
			))
			((= bkcode "450-4")(progn 
					(setq gfar "203m{\\A1;\\H0.5x;\\S2^;}")
					(setq ffar "202m{\\A1;\\H0.5x;\\S2^;}")
					(setq anxa "45.5m{\\A1;\\H0.5x;\\S2^;}")
					(setq pbet "63m")
					(setq vcod "")
			))
			((= bkcode "500-1")(progn 
					(setq gfar "217m{\\A1;\\H0.5x;\\S2^;}")
					(setq ffar "213m{\\A1;\\H0.5x;\\S2^;}")
					(setq anxa "23.5m{\\A1;\\H0.5x;\\S2^;}")
					(setq pbet "66m")
					(setq vcod "VILLA 400-5BR-500 SM LOT - TYPE 1")
			))
			((= bkcode "500-3")(progn 
					(setq gfar "202.5m{\\A1;\\H0.5x;\\S2^;}")
					(setq ffar "205m{\\A1;\\H0.5x;\\S2^;}")
					(setq anxa "35.5m{\\A1;\\H0.5x;\\S2^;}")
					(setq pbet "61m")
					(setq vcod "VILLA 400-5BR-500 SM LOT - TYPE 3")
			))
			((= bkcode "500-5")(progn 
					(setq gfar "203m{\\A1;\\H0.5x;\\S2^;}")
					(setq ffar "206m{\\A1;\\H0.5x;\\S2^;}")
					(setq anxa "21.5m{\\A1;\\H0.5x;\\S2^;}")
					(setq pbet "70m")
					(setq vcod "VILLA 400-5BR-500 SM LOT - TYPE 5")
			))
			((= bkcode "600-1")(progn 
					(setq gfar "256m{\\A1;\\H0.5x;\\S2^;}")
					(setq ffar "256m{\\A1;\\H0.5x;\\S2^;}")
					(setq anxa "26.8m{\\A1;\\H0.5x;\\S2^;}")
					(setq pbet "69.5m")
					(setq vcod "VILLA 500 - 6BR- 600 SM LOT - TYPE 1")
			))
			((= bkcode "600-4")(progn 
					(setq gfar "256m{\\A1;\\H0.5x;\\S2^;}")
					(setq ffar "256m{\\A1;\\H0.5x;\\S2^;}")
					(setq anxa "26.8m{\\A1;\\H0.5x;\\S2^;}")
					(setq pbet "69.5m")
					(setq vcod "VILLA 500 - 6BR- 600 SM LOT - TYPE 4")
			))
			((= bkcode "700-3")(progn 
					(setq gfar "290m{\\A1;\\H0.5x;\\S2^;}")
					(setq ffar "292.5m{\\A1;\\H0.5x;\\S2^;}")
					(setq anxa "30m{\\A1;\\H0.5x;\\S2^;}")
					(setq pbet "76m")
					(setq vcod "VILLA 550 - 5BR- 700 SM LOT - TYPE 3")
			))
			((= bkcode "900-3")(progn 
					(setq gfar "m{\\A1;\\H0.5x;\\S2^;}")
					(setq ffar "m{\\A1;\\H0.5x;\\S2^;}")
					(setq anxa "m{\\A1;\\H0.5x;\\S2^;}")
					(setq pbet "m")
					(setq vcod "VILLA 700 - 6BR- 900 SM LOT - TYPE 3")
			))
			((= bkcode "900-4")(progn 
					(setq gfar "m{\\A1;\\H0.5x;\\S2^;}")
					(setq ffar "m{\\A1;\\H0.5x;\\S2^;}")
					(setq anxa "m{\\A1;\\H0.5x;\\S2^;}")
					(setq pbet "m")
					(setq vcod "VILLA-700-6BR- 900 SM LOT - TYPE 4")
			))
			
			(t 
				(progn
					(alert "\nThis Type Is Not Listed \nLayout will be created without: \n-First Floor Area \n-Parabet LM \n-Arch Code")
					(setq gfar "NA")
					(setq ffar "NA")
					(setq anxa "NA")
					(setq pbet "NA")
					(setq vcod "NA")
				)
			);else
		)
)
(defun ar1 () ;area of Plot Polygon
	(setq arar1 (getvar "area")) 
)
(defun leng1 () ;perimeter of block
	(setq lenglen (getvar "perimeter")) ;length of block
)
(defun calcs() ;other calculations
	;elevation = plot number
	(progn
		(setq enlist(entget gpa1))
		(setq akoko (assoc 38 enlist))
		(setq akokok (cons (cdr akoko) akokok))
		(setq kk1 (nth 0 akokok))
	)
	;block layer = block type
	(progn
		(setq enlist(entget gba2))
		(setq akokos (assoc 8 enlist))
		(setq akokoks (cons (cdr akokos) akokoks))
		(setq kk2 (nth 0 akokoks))
    )
)
(defun maketext() ;make info text
	(setq txt1 (strcat 
		(rtos kk1 2 0) "\n"
		"Residential" "\n"		
		(rtos arar1 2 1) 
		"{ m\\A1;\\H0.5x;\\S2^;}" "\n"		
		"60\%" "\n"		
		gfar  "\n"
		ffar  "\n"
		anxa "\n"		
		(rtos lenglen 2 1) "m" "\n"
		pbet 
	)) 
	(setq txt2 (strcat 
	"Plot Number" 
	"\nLand Use" 
	"\nPlot Area" 
	"\nMaximum Coverage" 
	"\nGround Floor Area" 
	"\nFirst Floor Area"
	"\nAnnex Area" 
	"\nBoundry Wall -  LM"
	"\nParapet - LM"
	))
)

(defun ctabtxt() ;define layout name working
	(setq plnm (rtos kk1 2 0))
	(cond
	((= (strlen plnm) 2)
	(setq plnm (strcat "0" plnm)))
	((= (strlen plnm) 1)
	(setq plnm (strcat "00" plnm)))
	)
	(setq newl (strcat 
	(substr kk2 1 3) "0" plnm "-" (substr kk2 4 4) (substr kk2 10 1) "-" (substr kk2 8 1) "S-DD-A100"
	))
)
(defun crtcode()
			(setq pvc (list 803.0112 -748.5897 0.0))
			(entmake (list
				(cons 0  "MTEXT")
				(cons 100  "AcDbEntity")
				(cons 8  "0-XREF-TB")
				(cons 100  "AcDbMText")
				(cons 10 pvc)
				(cons 40 4.0); mtext height	   
				(cons 41  0.0);mtext box width (I use 0.0 always)
				(cons 50  0.0); mtext rotation angle
				(cons 71  5)
				(cons 72  5)
				(cons 1  vcod); mtext string
				(cons 7  "Arial_8")
				(cons 73  1)
				(cons 44  1.0);line spacing
			))
)
(defun kplndist()
		(vl-load-com)
		(setq vis (strcat "DISTRICT " (substr (getvar "ctab") 2 1)))
		(setq 	ss        (ssget "C" '(863.0514 -272.6000) '(747.2432 -353.1844) (list (cons 0 "INSERT")))
				lstBNames (list "kpln arch")
				idx       0
		)
		(if ss
			(progn
			  (while (< idx (sslength ss))
				(setq obj (vlax-EName->vla-Object (ssname ss idx))
					  idx (1+ idx)
				)
				(if (member (vla-Get-EffectiveName obj) lstBNames)
				  (progn
					(setq lstDyns (vlax-SafeArray->list (variant-Value (vla-GetDynamicBlockProperties obj))))
					(foreach dyn lstDyns
					  (if (= "Visabilityplan" (vla-Get-PropertyName dyn))(vlax-Put-Property dyn 'Value vis))
					)
		)))))
)
(defun locond ()
	(setq strMyLayout newl)
	(setq lstLayouts (layoutlist))


	(if (member strMyLayout lstLayouts)
		(alert "\nLayout Exists, Nothing will be created")
		(progn 
			(command "._layout" "_c" mokl newl)
			;switch to created layout !!!!!!
			(command "._layout" "_s" newl)
			(maketext)
			(crtcode)
			(kplndist)
		)
	)
)

(defun c:adr () ; to run type ADR
(settng)	
(setvar "cmdecho" 0)

;selection reset
(setq gpa1 nil)
(setq gba2 nil)

;Selection
(while (= nil gpa1)
(setq gpa1 
	(car 
		(entsel "\nSelect Plot polyline: ")
	)
))
(command "area" "o" gpa1)
(ar1) ; Area Calculation


(while (= nil gba2)
(setq gba2 
	(car 
		(entsel "\nSelect Block polyline: ")
	) 
))
;performing calculations
(leng1) ;perimeter calculation
(calcs)
(btyp)

;getting layout name
(ctabtxt)

;creating layout conditional statment !!!!!
(locond)

;switch back to model
(setvar "ctab" "model")

;selection reset
(setq gpa1 nil)
(setq gba2 nil)


(setvar "cmdecho" 1)

(princ) ;exit silently
)
(defun c:lo2d  ; to run type LO2D
(/ errexit undox olderr oldcmdecho fn path
                          msg msg2 fileprefix i j)
  (defun errexit (s)
    (princ "\nError:  ")
    (princ s)
    (restore)
  )

  (defun undox ()
    (command "._undo" "_E")
    (setvar "cmdecho" oldcmdecho)
    (setq *error* olderr)
    (princ)
  )

  (setq olderr  *error*
        restore undox
        *error* errexit
  )
  (setq oldcmdecho (getvar "cmdecho"))
  (setvar "cmdecho" 0)
  (defun DelAllLayouts (Keeper / TabName)
    (vlax-for Layout
                     (vla-get-Layouts
                       (vla-get-activedocument (vlax-get-acad-object))
                     )
      (if
        (and
          (/= (setq TabName (strcase (vla-get-name layout))) "MODEL")
          (/= TabName (strcase Keeper))
        )
         (vla-delete layout)
      )
    )
  )

  (vl-load-com)
  (setq msg "" msg2 "" i 0 j 0)
  (command "._undo" "_BE")
  (setq fileprefix (getstring "Enter filename prefix: "))
  (foreach lay (layoutlist)
    (if (and (/= lay "Model") (> (vla-get-count (vla-get-block (vla-Item (vla-get-Layouts (vla-get-activedocument (vlax-get-acad-object))) lay))) 1))
      (progn
        (command "_.undo" "_M")
        (DelAllLayouts lay)
        (setvar "tilemode" 1)
        (command "_.ucs" "_w")
        (setvar "tilemode" 0)
        (setq path (getvar "DWGPREFIX"))
        (setq fn (strcat path fileprefix lay ".dwg"))
        (if (findfile fn)
          (progn
            (command "_.-wblock" fn "_Y")
            (if (equal 1 (logand 1 (getvar "cmdactive")))
              (progn
                (setq i (1+ i) msg (strcat msg "\n" fn))
                (command "*")
              )
              (setq j (1+ j) msg2 (strcat msg2 "\n" fn))
            )
          )
          (progn
            (command "_.-wblock" fn "*")
            (setq i (1+ i)  msg (strcat msg "\n" fn))
          )
        )
        (if (equal 1 (logand 1 (getvar "cmdactive")))
          (command "_N")
        )
        (command "_.undo" "_B")
      )
    )
  )
  (if (/= msg "")
    (progn
      (if (= i 1)
        (prompt "\nFollowing drawing was created:")
        (prompt "\nFollowing drawings were created:")
      )
      (prompt msg)
    )
  )
  (if (/= msg2 "")
    (progn
      (if (= j 1)
        (prompt "\nFollowing drawing was NOT created:")
        (prompt "\nFollowing drawings were NOT created:")
      )
      (prompt msg2)
    )
  )
  (command "._undo" "_E")
  (textscr)
  (restore)
  (princ)
)