; =============================================================================
; PLAYER MANAGEMENT
; =============================================================================

; -----------------------------------------------------------------------------
PLYINIT
; INITIALIZES THE PLAYER
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            MOVE.W  #TWINITL,(LIFTW1)       ;Initializes life tower
            MOVE.W  #TWINITL,(LIFTW2)
            MOVE.W  #MONINIT,(MNYPL1)       ;Initializes money
            MOVE.W  #MONINIT,(MNYPL2)
            RTS
            
; -----------------------------------------------------------------------------
PLYUPD
; UPDATES THE PLAYER
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D2,-(A7)
            
            CLR.L   D0
            CMP     (LIFTW1),D0
            BEQ     .DIE
            CMP     (LIFTW2),D0
            BEQ     .DIE
            
            MOVE.B  (SCRCYCCT),D0
            AND     #$0F,D0                 ; EVERY 16 CYCLES
            BNE     .NOMNY                  ; GIVES MONEY
            ADD.W   #EXTRAMY,(MNYPL1)
            ADD.W   #EXTRAMY,(MNYPL2)

.NOMNY      MOVE.B  (KBDEDGE),D0
            MOVE.W  (MNYPL1),D1             ;If money <= 0, player 1 can't buy
            BLE     .UPDPL2                  
            
            BTST.L  #KBDBITLF,D0
            BEQ     .UPKEY
            SUB.W   #ESPCOST,D1             ;Branch if there isn't enough money
            BMI     .LFKYP
            SUB.W   #ESPCOST,D1
            
            MOVE.W  #AG1STRT,D3
            LEA     ESPINIT,A1
            LEA     ESP1UPD,A2
            LEA     ESP1PLOT,A3
            JSR     AGLADD                  ;New agent
            
.LFKYP      ADD.W   #ESPCOST,D1

.UPKEY      BTST.L  #KBDBITUP,D0
            BEQ     .RTKEY
            SUB.W   #ARCHCST,D1
            BMI     .UPKYP
            SUB.W   #ARCHCST,D1
            
            MOVE.W  #AG1STRT,D3
            LEA     ARCHINIT,A1
            LEA     ARCH1UPD,A2
            LEA     ARC1PLOT,A3
            JSR     AGLADD                  ;New agent
            
.UPKYP      ADD.W   #ARCHCST,D1

.RTKEY      BTST.L  #KBDBITRT,D0
            BEQ     .UPDPL2
            SUB     #ESCCOST,D1
            BMI     .RTKYP
            SUB.W   #ESCCOST,D1
            
            MOVE.W  #AG1STRT,D3
            LEA     ESCINIT,A1
            LEA     ESC1UPD,A2
            LEA     ESC1PLOT,A3
            JSR     AGLADD                  New agent  
            
.RTKYP      ADD.W   #ESCCOST,D1
            
.UPDPL2     MOVE.W  (MNYPL2),D2             ;If money <= 0, player 2 can't buy
            BLE     .END
            
            BTST.L  #KBDBITDN,D0
            BEQ     .FIRE2
            SUB.W   #ESPCOST,D2
            BMI     .DNKYP
            SUB.W   #ESPCOST,D2
            
            MOVE.W  #AG2STRT,D3
            LEA     ESPINIT,A1
            LEA     ESP2UPD,A2
            LEA     ESP2PLOT,A3
            JSR     AGLADD                  ;New agent
            
.DNKYP      ADD.W   #ESPCOST,D2

.FIRE2      BTST.L  #KBDBITF2,D0
            BEQ     .FIRE3
            SUB.W   #ARCHCST,D2
            BMI     .FIR2P
            SUB.W   #ARCHCST,D2
            
            MOVE.W  #AG2STRT,D3
            LEA     ARCHINIT,A1
            LEA     ARCH2UPD,A2
            LEA     ARC2PLOT,A3
            JSR     AGLADD                  ;New agent
            
.FIR2P      ADD.W   #ARCHCST,D2

.FIRE3      BTST.L  #KBDBITF3,D0
            BEQ     .END
            SUB.W   #ESCCOST,D2
            BMI     .FIR3P
            SUB.W   #ESCCOST,D2
            
            MOVE.W  #AG2STRT,D3
            LEA     ESCINIT,A1
            LEA     ESC2UPD,A2
            LEA     ESC2PLOT,A3
            JSR     AGLADD                  ;New agent
            
.FIR3P      ADD.W   #ESCCOST,D2
                      
.END        MOVE.W  D1,(MNYPL1)
            MOVE.W  D2,(MNYPL2)
            MOVEM.L (A7)+,D0-D2
            RTS
            
.DIE        MOVE.W  #STAGOVR,(STANEXT)      ;If life tower = 0, then GAME OVER    
            BRA     .END
            
; -----------------------------------------------------------------------------
PLYPLOT
; PLOTS THE PLAYER LIFE AND PLAYER MONEY 
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D5/A1,-(A7)
            
            SETFILC $00000000
            UTLLOCT MNYPR1X,MNYPR1Y
            CLR.L   D1                      ;Print money number of player 1
            LEA     .PRMNY,A1
            MOVE.W  (MNYPL1),D1
            MOVE.B  #17,D0
            TRAP    #15
            
            UTLLOCT MNYPR2X,MNYPR2Y
            CLR.L   D1                      ;Print money nuber of player 2
            MOVE.W  (MNYPL2),D1
            MOVE.B  #17,D0
            TRAP    #15
            
            MOVE.W  #LF1LFTX,D1
            MOVE.W  #LF1LFTY,D2
            MOVE.W  #LF1RGHX,D3
            MOVE.W  #LF1RGHY,D4
            MOVE.W  (LIFTW1),D5
            JSR     DRWLBAR1                 ;Draw the player 1 life bar
            
            MOVE.W  #LF2LFTX,D1
            MOVE.W  #LF2LFTY,D2
            MOVE.W  #LF2RGHX,D3
            MOVE.W  #LF2RGHY,D4
            MOVE.W  (LIFTW2),D5
            JSR     DRWLBAR2                 ;Draw the player 2 life bar
            
            MOVEM.L (A7)+,D0-D5/A1
            
            RTS
            
.PRMNY      DC.B    'MONEY: ',0
            DS.W    0            
            



*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
