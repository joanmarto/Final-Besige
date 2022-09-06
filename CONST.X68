; =============================================================================
; GAME CONSTATS
; =============================================================================

;---GAME STATES----------------------------------------------------------------

STAINIC     EQU     -1                      
STASTRT     EQU     0                       ;Estado inicial
STAGAME     EQU     1                       ;Etado de juego
STAPAUS     EQU     2                       ;Estado de pausa
STAGOVR     EQU     3                       ;Estado game over

;---PLAYER DRAWING RELATED CONSTANTS ------------------------------------------

PLYPENC     EQU     $00000000               ;Player pen color
PL1FILC     EQU     $00FF0000               ;Player 1 fill color (BLUE)
PL2FILC     EQU     $000000FF               ;Player 2 fill color (RED)
PLYHEIG     EQU     50                      ;Player height (pixels)
PLYWIDT     EQU     20                      ;Player width (pixels)
PLYTOEH     EQU     10                      ;Player toe height (pixels)
PLYTOEW     EQU     30                      ;Player toe width (pixels)
HEADSIZ     EQU     20                      ;Player head diameter (pixels)

;---WEAPONS RELATED CONSTANTS--------------------------------------------------

ESCHEIG     EQU     50                      ;Altura escudo (pixels)
ESCWIDT     EQU     5                       ;Anchura escudo (pixels)
ARROWSP     EQU     5                       ;Velocidad flecha
ARROWDT     EQU     25                      ;Anchura flecha (pixels)
LINESHT     EQU     275                     ;Altura de los disparos
BOWHEIG     EQU     40                      ;altura

;---TOWER CONSTANTS------------------------------------------------------------

TWPENCO     EQU     $00000000               ;Tower pen color
TWFILLC     EQU     $00808080               ;Tower fill color (GRAY)
TW1LFTX     EQU     0
TW1LFTY     EQU     60
TW1RGHX     EQU     100
TW1RGHY     EQU     480
TW2LFTX     EQU     540
TW2LFTY     EQU     60
TW2RGHX     EQU     640
TW2RGHY     EQU     480
TWDOORD     EQU     120
TWINITL     EQU     1000                    ;Vida inicial     

;---BACKGROUND CONSTANTS-------------------------------------------------------

BCKGRFC     EQU     $00FFFF00               ;Background color (AQUA)

;---FLOOR CONTSNTS-------------------------------------------------------------

FLOORFC     EQU     $00008000               ;Floor color (GREEN)
FLOORLX     EQU     0                       
FLOORLY     EQU     336
FLOORRX     EQU     640
FLOORRY     EQU     480

;---TEXT CONSTANTS-------------------------------------------------------------

STITLEX     EQU     31                      ;Title X coordinate
STITLEY     EQU     5                       ;Title Y coordinate
STITLEC     EQU     $00FFFFFF               ;Title color (WHITE)
STPRESX     EQU     31                      ;Press SPACE X coordinate
STPRESY     EQU     26                      ;Press SPACE Y coordinate
PAUSETX     EQU     36                      ;Pause title X coordinate
PAUSETY     EQU     5                       ;Pause title Y coordinate
MNYPR1X     EQU     1                       ;Score player 1 X coordinate
MNYPR1Y     EQU     30                      ;Score player 1 Y coordinate
MNYPR2X     EQU     65                      ;Score player 2 X coordinate
MNYPR2Y     EQU     30                      ;Score player 2 Y coordinate

;---LIFE CONSTANTS-------------------------------------------------------------

LIFPENC     EQU     $00000000               ;Pen color life bar (BLACK)
LIFFILC     EQU     $000000FF               ;Fill color life bar (RED)
LF1LFTX     EQU     30
LF1LFTY     EQU     10
LF1RGHX     EQU     130
LF1RGHY     EQU     20
LF2LFTX     EQU     510
LF2LFTY     EQU     10
LF2RGHX     EQU     610
LF2RGHY     EQU     20

;---AGENT CONSTANTS------------------------------------------------------------

ESPDEFN     EQU     60                      ;Puntos defensa espadachin
ESPATCK     EQU     20                      ;Puntos ataque espadachin
ARCHDEF     EQU     20                      ;Puntos defensa arquero
ARCHATK     EQU     20                      ;Puntos ataque arquero
ESCDEFN     EQU     100                     ;Puntos defensa soldado con escudo
ESCATCK     EQU     10                      ;Puntos ataque soldado con escudo
ESPCOST     EQU     500                     ;Precio espadachin
ARCHCST     EQU     750                     ;Precio arquero
ESCCOST     EQU     1000                    ;Precio soldado con escudo
AG1STRT     EQU     50                      ;Coord inicio agentes del jugador 1
AG2STRT     EQU     590                     ;Coord inicio agentes del jugador 2
  
;---MONEY CONSTANTS------------------------------------------------------------

MONINIT     EQU     1000                    ;Dinero inicial 
EXTRAMY     EQU     50                      ;Dinero extra 



*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
