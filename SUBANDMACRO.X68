; =============================================================================
; MACROS
; =============================================================================            

; -----------------------------------------------------------------------------
CALCPRP     MACRO
; CALCULA LA COORDENADA RX DE LA BARRA DE VIDA
; INPUT     - D5 (LIFE)
; OUTPUT    - D5
; MODIFIES  - D5
; -----------------------------------------------------------------------------
            DIVS.W  #10,D5
            ENDM     

; -----------------------------------------------------------------------------
SETPENC     MACRO
; SET PEN COLOR
; INPUT     - \1 COLOR IN FORMAT $00BBGGRR
; OUTPUT    - NONE
; MODIFIES  - D0,D1
; -----------------------------------------------------------------------------
            MOVE.B  #80,D0
            MOVE.L  \1,D1
            TRAP    #15
            ENDM

; -----------------------------------------------------------------------------
SETFILC     MACRO
; SET FILL COLOR
; INPUT     - \1 COLOR IN FORMAT $00BBGGRR
; OUTPUT    - NONE
; MODIFIES  - D0,D1
; -----------------------------------------------------------------------------
            MOVE.B  #81,D0
            MOVE.L  \1,D1
            TRAP    #15
            ENDM
            
; -----------------------------------------------------------------------------
UTLLOCT     MACRO
; WRAPPER TO TEXT POSITIONNING FROM TRAP 15
; INPUT    - \1 X, \2 Y
; OUTPUT   - NONE
; MODIFIES - D0,D1
; -----------------------------------------------------------------------------
            MOVE.W  #\1<<8|\2, D1
            MOVE.B  #11,D0
            TRAP    #15
            ENDM
                        
; =============================================================================
; SUBROUTINES
; =============================================================================

; -----------------------------------------------------------------------------
PAINTBG     
; PINTA EL FONDO DEL COLOR DEFINIDO EN CONST.68X
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)
            
            SETFILC #BCKGRFC

            MOVE.B  #87,D0
            MOVE.W  #0,D1
            MOVE.W  #0,D2
            MOVE.W  #SCRWIDTH,D3
            MOVE.W  #SCRHEIGH,D4
            TRAP    #15
         
            MOVEM.L (A7)+,D0-D4
            RTS   
            
; -----------------------------------------------------------------------------
PAINTTW     
; PINTA LAS TORRES
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)
            
            SETPENC #TWPENCO
            
            SETFILC #TWFILLC
            
            MOVE.B  #87,D0                  ;Pinta la torre 1
            MOVE.W  #TW1LFTX,D1
            MOVE.W  #TW1LFTY,D2
            MOVE.W  #TW1RGHX,D3
            MOVE.W  #TW1RGHY,D4
            TRAP    #15
            
            MOVE.W  #TW2LFTX,D1             Pinta la torre 2
            MOVE.W  #TW2LFTY,D2
            MOVE.W  #TW2RGHX,D3
            MOVE.W  #TW2RGHY,D4
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D4
            RTS
            
; -----------------------------------------------------------------------------
PAINTFL     
; PINTA EL SUELO
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)
            
            SETFILC #FLOORFC

            MOVE.B  #87,D0
            MOVE.W  #FLOORLX,D1
            MOVE.W  #FLOORLY,D2
            MOVE.W  #FLOORRX,D3
            MOVE.W  #FLOORRY,D4
            TRAP    #15

            MOVEM.L (A7)+,D0-D4
            RTS
            
; -----------------------------------------------------------------------------
PRTITLE
; IMPRIME EL TITULO DEL JUEGO
; IMPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D1/A1,-(A7)
            
            UTLLOCT STITLEX,STITLEY
            SETPENC #STITLEC
            SETFILC $00000000
            LEA     .TITSTR,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            UTLLOCT STPRESX,STPRESY
            SETPENC #STITLEC
            SETFILC $00000000
            LEA     .PRSSTR,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D1/A1
            RTS
            
.TITSTR     DC.B    'FINAL BESIEGE 68000',0
.PRSSTR     DC.B    'PRESS SPACE TO START',0
            DS.W    0
            
; -----------------------------------------------------------------------------
DRWLBAR1
; DRAWS THE LIFE BAR PLAYER 1
; INPUT     - D1, D2, D3, D4 (COORDINATES), D5 (LIFE)
; OUTPUT    - NONE
; MODIFIES  - D0, D3, D5
; -----------------------------------------------------------------------------
            MOVEM.L D0-D1,-(A7)
            SETFILC $00000000
            SETPENC #LIFFILC
            MOVEM.L (A7)+,D0-D1
            MOVE.B  #90,D0
            TRAP    #15                     
            
            CALCPRP 
            ADD.W   #LF1LFTX,D5 
            MOVE.W  D5,D3
            MOVE.B  #87,D0
            TRAP    #15
            
            RTS
            
; -----------------------------------------------------------------------------
DRWLBAR2
; DRAWS THE LIFE BAR PLAYER 2
; INPUT     - D1, D2, D3, D4 (COORDINATES), D5 (LIFE)
; OUTPUT    - NONE
; MODIFIES  - D0, D3, D5
; -----------------------------------------------------------------------------
            MOVEM.L D0-D1,-(A7)
            SETFILC $00000000
            SETPENC #LIFFILC
            MOVEM.L (A7)+,D0-D1
            MOVE.B  #90,D0
            TRAP    #15                     
            
            CALCPRP 
            ADD.W   #LF2LFTX,D5 
            MOVE.W  D5,D3
            MOVE.B  #87,D0
            TRAP    #15
            
            RTS
            



            
            
            
            



*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
