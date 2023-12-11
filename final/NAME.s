        .data
team:   .asciz "Team 01\n"
name1:  .asciz "maxwell\n"
name2:  .asciz "jeffery\n"
name3:  .asciz "banana\n"
out1:   .asciz "*****Print Name*****\n"
out2:   .asciz "*****End Print*****\n"
        .text
        .global NAME
NAME:   stmfd   sp!,{lr}
        ldr     ip,=team
        str     ip,[r0]
        ldr     ip,=name1
        str     ip,[r1]
        ldr     ip,=name2
        str     ip,[r2]
        ldr     ip,=name3
        str     ip,[r3]

        ldr     r0,=out1
        bl      printf

        ldr     r0,=team
        bl      printf

        ldr     r5,=team

        ldr     r0,=name1
        bl      printf

        ldr     r6,=name1

        ldr     r0,=name2
        bl      printf

        ldr     r7,=name2

        ldr     r0,=name3
        bl      printf

        ldr     r8,=name3

        ldr     r0,=out2
        bl      printf

        mov     r3,#4
        mov     r4,#4
        sbcs    r0,r3,r4
        ldmfd   sp!,{lr}
        mov     pc, lr
