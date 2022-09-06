; =============================================================================
; STATE GAME
; =============================================================================

; -----------------------------------------------------------------------------
STAINIT
; INICIALIZA STACUR Y STANEXT
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            MOVE.W  #STAINIC,(STACUR)
            MOVE.W  #STASTRT,(STANEXT)
            MOVE.W  #0,(GISINIT)
            RTS
            
; -----------------------------------------------------------------------------
STAPLOT
; PERFORMS STATE`PLOT
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0/A0,-(A7)
            CLR.L   D0
            MOVE.W  (STACUR),D0
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .PLTTBL(A0),A0
            JSR     (A0)
            MOVEM.L (A7)+,D0/A0
            RTS
.PLTTBL     DC.L    STASTRTP,STAGAMEP,STAPAUSP,STAGOVRP

; -----------------------------------------------------------------------------
STAUPD
; PERFORMS STATE UPDATE AND INIT IF NECESSARY
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0/A0,-(A7)
            CLR.L   D0
            MOVE.W  (STANEXT),D0
            
            CMP.W   (STACUR),D0
            BEQ     .DOUPD
            MOVE.W  D0,(STACUR)             ; IF STATE CHANGED, DO INIT
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .INITBL(A0),A0
            JSR     (A0)
.DOUPD      CLR.L   D0                      ; IN ANY CASE, DO UPDATE
            MOVE.W  (STACUR),D0
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .UPDTBL(A0),A0
            JSR     (A0)
            MOVEM.L (A7)+,D0/A0
            RTS
.INITBL     DC.L    STASTRTI,STAGAMEI,STAEMPTY,STAEMPTY
.UPDTBL     DC.L    STASTRTU,STAGAMEU,STAPAUSU,STAGOVRU

; -----------------------------------------------------------------------------
STAEMPTY
; EMPTY SUBROUTINE FOR CASES WITH NOTHING TO DO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - JUST A PLACEHOLDER. NOTHING TO DO.
; -----------------------------------------------------------------------------
            RTS
; -----------------------------------------------------------------------------
STAGAMEI    
; GAME STATE INITIALIZATION.
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - JUST A WRAPPER FOR PLRINIT
; -----------------------------------------------------------------------------
            BTST.B  #0,(GISINIT)
            BNE     .NOINIT           
            BRA     PLYINIT
.NOINIT     RTS
                      
; -----------------------------------------------------------------------------
STAGAMEU
; GAME STATE UPDATE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            BTST.B  #KBDBITPS,(KBDEDGE)
            BEQ     .END
            MOVE.W  #STAPAUS,(STANEXT)
            MOVE.W  #-1,(GISINIT)
.END
            JSR     PLYUPD
            BRA     AGLUPD
           
; -----------------------------------------------------------------------------
STAGAMEP
; GAME STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            JSR     PAINTBG
            JSR     PAINTTW
            JSR     PAINTFL
            JSR     AGLPLOT
            BRA     PLYPLOT
     
; -----------------------------------------------------------------------------
STASTRTI    EQU     DMMINIT
; START STATE INIT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - JUST A WRAPPER FOR DMMINIT TO RELEASE ALL MEMORY
; -----------------------------------------------------------------------------


; -----------------------------------------------------------------------------
STASTRTU
; START STATE UPDATE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            BTST.B  #KBDBITF1,(KBDEDGE)
            BEQ     .END
            MOVE.W  #STAGAME,(STANEXT)
.END        RTS

; -----------------------------------------------------------------------------
STASTRTP    EQU     PRTITLE
; START STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------


; -----------------------------------------------------------------------------
STAGOVRP
; GAME OVER STATE PLOT
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            
            MOVEM.L D0-D1/A1,-(A7)

            UTLLOCT PAUSETX,PAUSETY
            SETPENC #STITLEC
            SETFILC $00000000
            LEA     .GOVTITTLE,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D1/A1
            RTS
            
.GOVTITTLE  DC.B    'GAME OVER',0
            DS.W    0

; -----------------------------------------------------------------------------
STAGOVRU
; GAME OVER STATE UPDATE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            BTST.B  #KBDBITF1,(KBDVAL)
            BEQ     .END
            MOVE.W  #STASTRT,(STANEXT)
.END        RTS

; -----------------------------------------------------------------------------
STAPAUSP
; PAUSE STATE PLOT
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            
            MOVEM.L D0-D1/A1,-(A7)

            JSR     PAINTBG
            UTLLOCT PAUSETX,PAUSETY
            SETPENC #STITLEC
            SETFILC $00000000
            LEA     .PAUSTIT,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D1/A1
            RTS
            
.PAUSTIT    DC.B    'PAUSE',0
            DS.W    0

; -----------------------------------------------------------------------------
STAPAUSU
; PAUSE STATE UPDATE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            BTST.B  #KBDBITPS,(KBDEDGE)
            BEQ     .END
            MOVE.W  #STAGAME,(STANEXT)
.END        RTS






*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
