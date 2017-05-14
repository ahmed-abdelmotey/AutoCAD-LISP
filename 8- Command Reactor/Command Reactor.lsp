
; Load the Visual LISP library
(vl-load-com)
; Check to see if our custom command reactors have been loaded into the current drawing
(if (= hyp-rctCmds nil)
; Add the command reactors and the custom callbacks
	(setq hyp-rctCmds 	
		(vlr-command-reactor nil 
			'(
				(:vlr-commandCancelled . hyp-cmdAbort)
				(:vlr-commandEnded . hyp-cmdAbort)
				(:vlr-commandFailed . hyp-cmdAbort)
				(:vlr-commandWillStart . hyp-cmdStart)
			)
		)
	)
	(alert "already loaded")
)
; Callbackused when a command is started
(defun hyp-cmdStart (param1 param2 / currentlayer layername)

	; Store the current layer in a global variable
	(setq hyp-gClayer (getvar "clayer"))

	;check to see what command has been started, the
	; command name is stored in the param2 variable
	(cond
	; If either the QDIM command
	; is active the set the current layer to Dimensions
		( 
			;Dimentions
			(or
				(= (car param2) "DIMALIGNED")
				(= (car param2) "DIMANGULAR")
				(= (car param2) "DIMBASELINE")
				(= (car param2) "DIMCONTINUE")
				(= (car param2) "DIMDIAMETER")
				(= (car param2) "DIMLINEAR")
				(= (car param2) "DIMORDINATE")
				(= (car param2) "DIMRADIUS")
				(= (car param2) "QDIM")
				(= (car param2) "DIM")
			)
			(setq layername "L-ANNO-DIMS")
			(if 
				(= nil (tblsearch "layer" layername))
				(progn
					(entmake (list (cons 0 "LAYER")
						 (cons 100 "AcDbSymbolTableRecord")
						 (cons 100 "AcDbLayerTableRecord")
						 (cons 2 layername)
						 (cons 70 0))
					)
					(setvar "clayer" layername)
				)
				(setvar "clayer" layername)
			)
		)
		( 
			;leaders
			(or
				(= (car param2) "LEADER")
				(= (car param2) "QLEADER")
			)
			(setq layername "L-ANNO-LEDR")
			(if 
				(= nil (tblsearch "layer" layername))
				(progn
					(entmake (list (cons 0 "LAYER")
						 (cons 100 "AcDbSymbolTableRecord")
						 (cons 100 "AcDbLayerTableRecord")
						 (cons 2 layername)
						 (cons 70 0))
					)
					(setvar "clayer" layername)
				)
				(setvar "clayer" layername)
			)
		)
		( 
			;Text
			(or
				(= (car param2) "TEXT")
				(= (car param2) "TTEXT")
				(= (car param2) "DTEXT")
				(= (car param2) "MTEXT")
			)
			(setq layername "L-ANNO-TEXT")
			(if 
				(= nil (tblsearch "layer" layername))
				(progn
					(entmake (list (cons 0 "LAYER")
						 (cons 100 "AcDbSymbolTableRecord")
						 (cons 100 "AcDbLayerTableRecord")
						 (cons 2 layername)
						 (cons 70 0))
					)
					(setvar "clayer" layername)
				)
				(setvar "clayer" layername)
			)
		)
; Add more here

;;;;;;;;;;;;;;;
		( 
			(or
				(= (car param2) "LAYER")
				(= (car param2) "-LAYER")
			)
			(setq hyp-gClayer nil);Clear the global variable to allow the layer command to change the current layer
		)
	)
)
(defun hyp-cmdAbort (param1 param2)

	; Check to see if our global variable has a value if it does the set the current layer
	(if 
		(and (/= hyp-gClayer nil)(/= (strcase (getvar "clayer")) (strcase hyp-gClayer)))
		(setvar "clayer" hyp-gClayer)
	)
	; Clear the global variable
	(setq hyp-gClayer nil)
)