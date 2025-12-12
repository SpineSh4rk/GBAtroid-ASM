; Makes enemy drops fall to the ground.
; By SpineShark
.gba
.open "ZM_U.gba","DropsDrop.gba",0x8000000

@FallSpeed equ 0x10
@Buffer    equ 0x10

.definelabel @Freespace, filesize("ZM_U.gba") + 0x8000000
.definelabel @ProcessClipdata, 0x8057E7C

.org 0x8012FC8
.area 0x20,0
    ldrh    r0,[r2,2]       ; r0 = drop Y pos
    push    r0,r2,r3    
    add     r0,@FallSpeed + @Buffer
    ldrh    r1,[r2,4]       ; r1 = drop X pos
    bl      @ProcessClipdata
; r0 = clipdata at position
    pop     r1,r2,r3        ; r1 = drop Y pos
    cmp     r0,0            ; check clip == air?
    bne     @@a
    add     r1,@FallSpeed
    strh    r1,[r2,2]
@@a:
    ldr     r1,=@Freespace|1
    mov     pc,r1
    .pool
.endarea

.org @Freespace
; overwritten code
    ldrb    r0,[r2,8]
    mov     r1,1
    and     r0,r1
    cmp     r0,0
    beq     @@Return 
    ldrh    r0,[r2,6]
    sub     r0,1
    strh    r0,[r2,6]
    lsl     r0,r0,0x18
    lsr     r0,r0,0x18
    cmp     r0,0
    beq     @@Store
    cmp     r0,0x4F
    bhi     @@Return
    mov     r0,4
    eor     r0,r3
@@Store:
    strh    r0,[r2]
@@Return:
    ldr     r1,=0x8012FEA|1
    mov     pc,r1 
    .pool

.close
