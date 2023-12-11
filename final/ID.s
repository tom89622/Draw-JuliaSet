        .data
scan_format:   .asciz "%d"
out_format:    .asciz "%d\n"
scan_format2:  .asciz "\n"
mem1:   .word 0
mem2:   .word 0
mem3:   .word 0
mem4:   .word 0
cccc:   .word 0
out1:   .asciz "*****Input ID*****\n"
out2:   .asciz "** Please Enter Member 1 ID : **\n"
out3:   .asciz "** Please Enter Member 2 ID : **\n"
out4:   .asciz "** Please Enter Member 3 ID : **\n"
out5:   .asciz "** Please Enter Command **\n"
out6:   .asciz "***** Print Team Member ID and ID Summation*****\n"
out7:   .asciz "*****End Print*****\n\n"
out8:   .asciz "\nID Summation = "
        .text
        .global ID
ID:     stmfd   sp!,{lr}
        mov     r5,r0
        mov     r6,r1
        mov     r7,r2
        mov     r8,r3

        ldr     r0,=out1
        bl      printf

        ldr     r0,=out2
        bl      printf

        mov     r1,r5
        ldr     r0,=scan_format
        bl      scanf

        ldr     r0,=out3
        bl      printf

        mov     r1,r6
        ldr     r0,=scan_format
        bl      scanf

        ldr     r0,=out4
        bl      printf

        mov     r1,r7
        ldr     r0,=scan_format
        bl      scanf

        ldr     r0,=out5
        bl      printf

        ldr     r1,=cccc
        ldr     r0,=scan_format2
        bl      scanf


        ldr     r4,=mem4
        ldr     r4,[r4]

        ldr     r0,=out6
        bl      printf

        mov     r1,r5
        ldr     r1,[r1]
        add     r4,r4,r1
        ldr     r0,=out_format
        bl      printf


        mov     r1,r6
        ldr     r1,[r1]
        add     r4,r4,r1
        ldr     r0,=out_format
        bl      printf

        mov     r1,r7
        ldr     r1,[r1]
        add     r4,r4,r1
        ldr     r0,=out_format
        bl      printf


        ldr     r0,=out8
        bl      printf


        str     r4,[r8]
        mov     r1,r4
        ldr     r0,=out_format
        bl      printf

        ldr     r0,=out7
        bl      printf


        mov     r0,#0
        ldmfd   sp!,{lr}
        mov     pc, lr
