; =============================================================================
; ARROW MANAGEMENT. IT IS AN AGENT
; LOCAL MEMORY IS:
; +0 WORD X COORDINATE
; =============================================================================

; -----------------------------------------------------------------------------
ARWINIT
; INITIALIZES AN ARROW
; INPUT     - A0 POINTER TO THE LOCAL MEMORY
;             D1.W INITIAL X COORDINATE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            MOVE.W  D1,(A0)
            RTS
            
; -----------------------------------------------------------------------------
ARW1UPD
; UPDATE ARROW OF PLAYER 1
; INPUT     - NONE       
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            ADDQ.W  #ARROWSP,(A0)
            RTS
            
; -----------------------------------------------------------------------------
ARW2UPD
; UPDATE ARROW OF PLAYER 2
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            SUBQ.W  #ARROWSP,(A0)
            RTS
            
; -----------------------------------------------------------------------------
ARW1PLOT
; PLOTS AN ARROW OF PLAYER 1
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)
            
            SETPENC $00000000
            SETFILC #PL1FILC
            MOVE.B  #87,D0
            MOVE.W  (A0),D1
            MOVE.W  #LINESHT,D2
            MOVE.W  D1,D3
            SUB.W   #ARROWDT,D3
            MOVE.W  D2,D4
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D4
            RTS
; -----------------------------------------------------------------------------
ARW2PLOT
; PLOTS AN ARROW OF PLAYER 2
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)
            
            SETPENC $00000000
            SETFILC #PL2FILC
            MOVE.B  #87,D0
            MOVE.W  (A0),D1
            MOVE.W  #LINESHT,D2
            MOVE.W  D1,D3
            ADD.W   #ARROWDT,D3
            MOVE.W  D2,D4
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D4
            RTS



*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
