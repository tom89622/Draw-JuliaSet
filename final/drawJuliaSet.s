        .data
print:  .asciz "%d\n"
maxIter:    .word 255
cx:     .word 0
cy:     .word 0
width:  .word 0
height: .word 0

num1500:   .word 1500
num4000000:.word 4000000

zx:     .word 0
zy:     .word 0
tmp:    .word 0
i:      .word 9
x:      .word 0
y:      .word 0
        .text
        .globl drawJuliaSet
drawJuliaSet:
        ldr     r4,[sp,#0]
        stmfd   sp!,{lr}
        ldr     ip,=cx
        str     r0,[ip]
        ldr     ip,=cy
        str     r1,[ip]
        ldr     ip,=width
        str     r2,[ip]
        ldr     ip,=height
        str     r3,[ip]

        ldr     r2,=width
        ldr     r2,[r2]
        ldr     r3,=height
        ldr     r3,[r3]

        mov     r5,#0
        mov     r6,#0

for1:   cmp     r5,r2
        bge     exit

        mov     r6,#0

for2:   cmp     r6,r3
        addge   r5,r5,#1
        bge     for1

        sub     r7,r5,r2, ASR #1
        mov     ip,#75
        add     ip,ip,ip,asl #2
        lsl     ip,#2
        mul     r0,r7,ip
        mov     r1,r2, ASR #1
        stmfd   sp!,{r2,r3}
        bl      __aeabi_idiv
        ldmfd   sp!,{r2,r3}
        mov     r7,r0


        sub     r8,r6,r3, ASR #1
        mov     ip,#1000
        mul     r0,r8,ip
        mov     r1,r3,ASR #1
        stmfd   sp!,{r2,r3}
        bl      __aeabi_idiv
        ldmfd   sp!,{r2,r3}
        mov     r8,r0
        mov     r9,#255
        @b       loop

loop:   mul     ip,r7,r7        @ip = zx*zx
        mul     r10,r8,r8       @r10 = zy*zy
        add     ip,ip,r10       @ip = zx*zx + zy*zy
        mov     r10,#244
        lsl     r10,#6
        add     r10,r10,#9
        lsl     r10,#8          @r10 = 4000000
        cmp     ip,r10
        bge     whileexit       @if zx*zx+zy*zy>=4000000 exit
        cmp     r9, #0          @ r9 = i
        ble     whileexit       @if i <= 0 exit

        mul     ip,r7,r7        @ip = zx*zx
        mul     r10,r8,r8       @r10 = zy*zy
        sub     ip,ip,r10       @ip = zx*zx - zy*zy
        mov     r1,#1000
        mov     r0,ip           @r0 = zx*zx - zy*zy
        stmfd   sp!,{r2,r3}
        bl      __aeabi_idiv
        ldmfd   sp!,{r2,r3}
        ldr     r1,=cx          @r0 = *cx
        ldr     r1,[r1]         @r0 = cx
        add     r10,r0,r1

        mul     r8,r8,r7
        lsl     r8,#1           @zy*2
        mov     r0,r8
        mov     r1,#1000
        stmfd   sp!,{r2,r3}
        bl      __aeabi_idiv
        ldmfd   sp!,{r2,r3}
        ldr     r1,=cy
        ldr     r1,[r1]
        add     r8,r0,r1
        mov     r7,r10

        sub     r9,r9, #1
        b       loop
whileexit:

        and     ip,r9,#0xff
        orr     r10,ip,ip,asl #8
        mvn     r10,r10
        and     r10,r10,#-1
        mov     ip,#640
        mla     ip,r6,ip,r5
        lsl     ip,#1
        strh    r10,[r4,ip]

        add     r6,r6,#1



        b       for2

exit:   mov     r0,#0
        stmfd   sp!,{lr}
        adds    r14,r0,r1
        ldmfd   sp!,{lr}
        addlt   r1,r4,r5
        mullo   r4,r3,r5
        ldmfd   sp!,{lr}
        mov     pc, lr


dive:   stmfd   sp!,{lr}
        mov     ip,#0
subtr:  subs    r0,r0,r1
        add     ip,ip,#1
        bhi     subtr
        mov     r0,ip
        ldmfd   sp!,{lr}
        mov     pc,lr

