global dot_product_asm
    section .text
dot_product_asm:
    ;rdi se guarda v1
    ;rsi se guarda v2
    ;rdx se guarda N

    xorpd xmm0,xmm0
    xorpd xmm1,xmm1
    xorpd xmm2,xmm2

    mov r8,rdx ; r8 tiene el N
    xor r9,r9; r9 tiene el contador

bucle:
    movss xmm0,[rdi]
    movss xmm1,[rsi]

    mulss xmm0,xmm1

    addss xmm2,xmm0

    add rdi,4
    add rsi,4

    add r9,1
    cmp r8,r9
    je fin

    jmp bucle
fin:
    movss xmm0,xmm2
    ret