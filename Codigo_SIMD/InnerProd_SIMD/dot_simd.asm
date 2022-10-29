global dot_simd
    section .text
dot_simd:
    xorpd xmm0,xmm0
    xorpd xmm1,xmm1
    xorpd xmm2,xmm2
    xorpd xmm3,xmm3

    mov r8,rdx ; r8 tiene el N
    xor r9,r9; r9 tiene el contador

bucle:
    movaps xmm0,[rdi]
    movaps xmm1,[rsi]

    mulps xmm0,xmm1
    addps xmm2,xmm0

    add rdi,16
    add rsi,16
    add r9,4

    cmp r8,r9

    je fin
    jmp bucle

fin:
    movaps xmm3,xmm2
    shufps xmm3,xmm2,00011011b
    addps xmm2,xmm3
    movaps xmm3,xmm2
    shufps xmm3,xmm2,01001110b
    addps xmm2,xmm3
    movss xmm0,xmm2
    ret