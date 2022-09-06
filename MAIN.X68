; =============================================================================
; TITLE    : FINAL BESIEGE
; AUTHOR   : JOAN MARTORELL Y GERMAN NUÑEZ
; CREATION : 26/11/2019
; =============================================================================

            ORG     $1000

; --- CODE INCLUDES -----------------------------------------------------------

            INCLUDE "SYSCONST.X68"          ; SYSTEM CONSTANTS
            INCLUDE "SYSTEM.X68"            ; SYSTEM CODE
            
            ; TO DO: PUT YOUR GAME-RELATED INCLUDES HERE
            
            INCLUDE "CONST.X68"             ; GAME CONSTANTS
            INCLUDE "SUBANDMACRO.X68"       ; UTIL SUBROUTINES AND MACROS
            INCLUDE "AGENTLST.X68"          ; AGENT LIST
            INCLUDE "STATES.X68"            ; GAME STATES
            INCLUDE "PLAYER.X68"            ; PLAYER MANAGEMENT
            INCLUDE "ARROW.X68"             ; ARROW MANAGEMENT
            INCLUDE "ESPADACHIN.X68"        ; SWORDMAN MANAGEMENT
            INCLUDE "ARQUERO.X68"           ; ARCHER MANAGEMENT
            INCLUDE "ESCUDO.X68"            ; SHIELD MANAGEMENT

; --- INITIALIZE --------------------------------------------------------------

START       JSR     SYSINIT
            ; TO DO: CALL GAME INITIALIZATION CODE HERE
            JSR     STAINIT
; --- UPDATE ------------------------------------------------------------------

.LOOP       TRAP    #KBDTRAP                ; READ KEYBOARD
            ; TO DO: CALL GAME UPDATE CODE HERE
            JSR     STAUPD

; --- WAIT SYNCH --------------------------------------------------------------

.WINT       TST.B   (SCRINTCT)              ; WAIT FOR INTERRUPT
            BEQ     .WINT
            CLR.B   (SCRINTCT)

; --- PLOT --------------------------------------------------------------------

            ; TO DO: CALL GAME PLOT CODE HERE
            JSR     STAPLOT
            TRAP    #SCRTRAP                ; SHOW GRAPHICS
            BRA     .LOOP
            SIMHALT

; --- VARIABLES ---------------------------------------------------------------

            INCLUDE "SYSVAR.X68"
            INCLUDE "VAR.X68"
            END    START









*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
