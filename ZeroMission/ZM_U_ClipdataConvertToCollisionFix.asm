; The game copies the ClipdataConvertToCollision function to RAM for 
; performance reasons, however the function's switch statement got 
; compiled into a jump table with absolute addresses that jump right
; back to the code in ROM, which negates any performance advantage.
;
; This patch fixes that by replacing the jump table with a branch 
; table which doesn't jump out of RAM.
; 
; By SpineShark

.gba
.open "ZM_U.gba","ClipdataConvertToCollisionFix.gba",0x8000000

.org 0x8057F88
.area 0x44,0
    lsl     r0,r0,1
    add     pc,r0 
    nop                 ; Collision type:
    b       0x805804A   ; Air
    b       0x8057FCC   ; Solid
    b       0x8057FD4   ; LeftSteepSlope
    b       0x8057FE4   ; RightSteepSlope
    b       0x8057FF8   ; LeftUpperSlightSlope
    b       0x805800A   ; LeftLowerSlightSlope
    b       0x805801E   ; RightLowerSlightSlope
    b       0x8058034   ; RightUpperSlightSlope
    b       0x805804E   ; EnemyOnly
    b       0x8058058   ; StopEnemy
    b       0x8058062   ; Tank
    b       0x805806E   ; Door
    b       0x805804A   ; PassThroughBottom
.endarea

.close
