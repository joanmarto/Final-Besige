; =============================================================================
; ARQUERO. ES UN AGENTE
; USO MEMORIA LOCAL:
; +0 WORD X COORDENADA
; +2 WORD VIDA
; =============================================================================

; -----------------------------------------------------------------------------
ARCHINIT
; INICIALIZA UN ARQUERO
; INPUT     - A0 PUNTERO A LA MEMORIA LOCAL
;             D3 COORDENADA X
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            MOVE.W  D3,(A0)
            MOVE.W  #ARCHDEF,2(A0)
            RTS

; -----------------------------------------------------------------------------
ARCH1UPD
; ACTUALIZA UN ARQUERO (JUGADOR 1) Y GENERA FLECHAS
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            CMP     #0,2(A0)                ;Si vida <= 0 el arquero muere 
            BLE     .DIE                   
            
            CMP     #TW2LFTX-50,(A0)        ;Ataque a torre
            BEQ     .ATK
            

            ADDQ.W  #1,(A0)
            
.ATK        MOVE.B  (SCRCYCCT),D0
            AND     #$0F,D0                 ; EVERY 16 CYCLES
            BNE     .NOARW                  ; NEW ARROW
           
            MOVE.W  (A0),D1
            LEA     ARWINIT,A1
            LEA     ARW1UPD,A2
            LEA     ARW1PLOT,A3
            JSR     AGLADD
            
.NOARW      RTS

.DIE        JSR     AGLKILL
            BRA     .NOARW  

; -----------------------------------------------------------------------------
ARCH2UPD
; ACTUALIZA UN ARQUERO (JUGADOR 2) Y GENERA FLECHAS
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            CMP     #0,2(A0)                ;Si vida <= 0 el escudero muere 
            BLE     .DIE                   
            
            CMP     #TW1RGHX+50,(A0)        ;Ataque a torre
            BEQ     .ATK

            SUBQ.W  #1,(A0)
           
.ATK        MOVE.B  (SCRCYCCT),D0
            AND     #$0F,D0                 ; EVERY 16 CYCLES
            BNE     .NOARW                  ; NEW ARROW

            MOVE.W  (A0),D1
            LEA     ARWINIT,A1
            LEA     ARW2UPD,A2
            LEA     ARW2PLOT,A3
            JSR     AGLADD
            
.NOARW      RTS
.DIE        JSR     AGLKILL
            BRA     .NOARW  

; -----------------------------------------------------------------------------
ARC1PLOT
; PLOT ARQUERO (JUGADOR 1)
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)
            SETPENC $00000000
            SETFILC #PL1FILC
            MOVE.W  (A0),D3
            MOVE.W  D3,D1
            SUB.W   #PLYTOEW,D1
            MOVE.W  #FLOORLY-PLYTOEH,D2
            MOVE.W  #FLOORLY,D4
            MOVE.B  #87,D0
            TRAP    #15                     ;Pinta los pies
            
            MOVE.W  D1,D3
            ADD.W   #PLYWIDT,D3
            SUB.W   #PLYHEIG,D2
            SUB.W   #PLYTOEH,D4
            TRAP    #15                     ;Pinta el cuerpo

            SUB.W   #HEADSIZ,D2
            SUB.W   #PLYHEIG,D4 
            MOVE.B  #88,D0            
            TRAP    #15                     ;Pinta la cabeza  
            
            MOVE.W  (A0),D1            
            ADD.W   #HEADSIZ/2,D2
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            ADD.W   #BOWHEIG,D4
            MOVE.B  #84,D0
            TRAP    #15                     ;Pinta el arco
            
            MOVEM.L (A7)+,D0-D4
            RTS
            
; -----------------------------------------------------------------------------
ARC2PLOT
; PLOT ARQUERO (JUGADOR 2)
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)
            SETPENC $00000000
            SETFILC #PL2FILC
            
            MOVE.W  (A0),D1
            MOVE.W  #FLOORLY-PLYTOEH,D2
            MOVE.W  D1,D3
            ADD.W   #PLYTOEW,D3
            MOVE.W  #FLOORLY,D4
            MOVE.B  #87,D0
            TRAP    #15                     ;Pinta los pies
            
            MOVE.W  D3,D1
            SUB.W   #PLYWIDT,D1
            SUB.W   #PLYHEIG,D2
            SUB.W   #PLYTOEH,D4
            TRAP    #15                     ;Pinta el cuerpo
            
            SUB.W   #HEADSIZ,D2
            SUB.W   #PLYHEIG,D4
            MOVE.B  #88,D0
            TRAP    #15                     ;Pinta la cabeza
            
            MOVE.W  (A0),D1
            MOVE.W  D1,D3
            ADD.W   #HEADSIZ/2,D2
            MOVE.W  D2,D4
            ADD.W   #BOWHEIG,D4
            MOVE.B  #84,D0
            TRAP    #15                     ;Pinta el arco
            
            MOVEM.L (A7)+,D0-D4
            RTS
            


            

*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
