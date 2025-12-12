; Press start button to skip new file intro.
; This is the new code from the japanese version backported to MF_U.
; By SpineShark
.gba
.open "MF_U.gba","MF_U_PressStartToSkipIntro.gba",0x8000000

.definelabel FreeSpace, filesize("MF_U.gba") + 0x8000000

.definelabel SubGameMode1, 0x3000BE0
.definelabel GameCompletion, 0x3000014
.definelabel ChangedInput, 0x30011EC
.definelabel WrittenToBLDY, 0x300121E
.definelabel NonGameplayRam, 0x3001484

.org 0x808770E ; In NewFileIntroSubroutine
    mov     pc,r0
    mov     r1,0 ; return point
    ldsh    r1,[r2,r1]

.org 0x8087724
    .dw FreeSpace ; use existing ldr for hijack

.org FreeSpace
    ldr     r0,=SubGameMode1
    mov     r2,0
    ldsh    r1,[r0,r2]
    mov     r2,r0
; New code from MF_J:
    cmp     r1,0
    beq     @@_808866E
    cmp     r1,0xC
    beq     @@_808866E
;    ldr     r0,=GameCompletion ;\
;    ldrb    r0,[r0]            ; \
;    lsl     r0,r0,0x18         ;  check if game completed before 
;    asr     r0,r0,0x18         ;  checking if start pressed
;    cmp     r0,0               ; /
;    beq     @@_808866E         ;/
    ldr     r0,=ChangedInput
    ldrh    r1,[r0]
    mov     r0,8
    and     r0,r1
    cmp     r0,0
    beq     @@_808866E
    ldr     r0,=WrittenToBLDY
    mov     r1,0x10
    strh    r1,[r0]
    ldr     r0,=0x4000054
    strh    r1,[r0]
    ldr     r0,=NonGameplayRam
    ldr     r3,=0x20E
    add     r0,r0,r3
    strh    r7,[r0]
    mov     r0,0xC
    strh    r0,[r2]
@@_808866E:
    ldr     r3,=0x8087710 ; return address
    mov     pc,r3
    .pool

.close