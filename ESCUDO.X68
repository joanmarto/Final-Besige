; =============================================================================
; SOLDADO CON ESCUDO. ES UN AGENTE
; USO MEMORIA LOCAL:
; +0 WORD X COORDENADA
; +2 WORD VIDA
; =============================================================================

; -----------------------------------------------------------------------------
ESCINIT
; INICIALIZA UN SOLDADO CON ESCUDO
; INPUT     - A0 PUNTERO A LA MEMORIA LOCAL
;             D3 COORDENADA X
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            MOVE.W  D3,(A0)
            MOVE.W  #ESCDEFN,2(A0)
            RTS
            
; -----------------------------------------------------------------------------
ESC1UPD
; ACTUALIZA UN SOLDADO CON ESCUDO (JUGADOR 1)
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            CMP     #0,2(A0)                ;Si vida <= 0 el escudero muere
            BLE     .DIE

            CMP     #TW2LFTX,(A0)           ;Ataque a torre
            BEQ     .ATK
            
*            MOVEM.L D0/A0,-(A7)             ;Comprueba si hay otro soldado
*            MOVE.W  (A0),D0                 ;para luchar
*            JSR     DMMFRSTO
*            CMP     #0,A0
*            BEQ     .STEP
*.LOOP       
*            SUB.W   #ESPATCK,2(A0)
*            JSR     DMMNEXTO
*            CMP     #0,A0
*            BEQ     .NOTFND
*            BRA     .LOOP
*            
*.NOTFND                 
*            MOVEM.L (A7)+,D0/A0
*            BRA     .END
*
*            
*.STEP       MOVEM.L (A7)+,D0/A0
            ADDQ.W  #1,(A0)                 ;El soldado se mueve 

.END        RTS
            
.ATK        SUB.W   #ESCATCK,(LIFTW2)
            BRA     .END
            
.DIE        JSR     AGLKILL
            BRA     .END


; -----------------------------------------------------------------------------
ESC2UPD
; ACTUALIZA UN SOLDADO CON ESCUDO (JUGADOR 2)
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            CMP     #0,2(A0)                ;Si vida <= 0 el escudero muere 
            BLE     .DIE                   
            
            CMP     #TW1RGHX,(A0)           ;Ataque a torre
            BEQ     .ATK
            
*            MOVEM.L D0/A0,-(A7)             ;Comprueba si hay soldados
*            MOVE.W  (A0),D0                 ;para atacar
*            JSR     DMMFRSTO
*            CMP     #0,A0
*            BEQ     .STEP
*.LOOP       
*            SUB.W   #ESPATCK,2(A0)
*            JSR     DMMNEXTO
*            CMP     #0,A0
*            BEQ     .NOTFND
*            BRA     .LOOP
*            
*.NOTFND                 
*            MOVEM.L (A7)+,D0/A0
*            BRA     .END
*            
*.STEP       MOVEM.L (A7)+,D0/A0
            
            SUBQ.W  #1,(A0)                 ;El soldado se mueve                 

.END        RTS
            
.ATK        SUB.W   #ESCATCK,(LIFTW1)
            BRA     .END
            
.DIE        JSR     AGLKILL
            BRA     .END  
          
; -----------------------------------------------------------------------------
ESC1PLOT
; PLOT SOLDADO CON ESCUDO (JUGADOR 1)
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
*
            SUB.W   #HEADSIZ,D2
            SUB.W   #PLYHEIG,D4
            MOVE.B  #88,D0             
            TRAP    #15                     ;Pinta la cabeza  
            
            MOVE.W  (A0),D3
            MOVE.W  D3,D1
            SUB.W   #ESCWIDT,D1
            ADD.W   #HEADSIZ/2,D2
            MOVE.W  D2,D4
            ADD.W   #ESCHEIG,D4
            TRAP    #15                     ;Pinta el escudo
            
            MOVEM.L (A7)+,D0-D4
            RTS
           
; -----------------------------------------------------------------------------
ESC2PLOT
; PLOT SOLDADO CON ESCUDO (JUGADOR 2)
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
            ADD.W   #HEADSIZ/2,D2
            MOVE.W  D1,D3
            ADD.W   #ESCWIDT,D3
            MOVE.W  D2,D4
            ADD.W   #ESCHEIG,D4
            TRAP    #15                     ;Pinta el escudo
            
            MOVEM.L (A7)+,D0-D4
            RTS
            
            



*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
