global alg_simd
    section .text
alg_simd:
    ;rdi -> v
    ;rsi -> N
    ;rdx -> v_min
    ;rcx -> v_max
    ;xmm0 -> vm_max

    xorpd xmm1,xmm1
    xorpd xmm2,xmm2
    xorpd xmm3,xmm3

    xor r8,r8
    xor rax,rax

    cvtsi2ss xmm3,edx
    shufps xmm3,xmm3, 00000000b


    sub rcx,rdx
    cvtsi2ss xmm1,rcx
    divss xmm1,xmm0; xmm1 -> 0.4

    shufps xmm1,xmm1, 00000000b

    mov r9,rsi; N=16
    xor r10,r10; r10 -> Contador

bucle:

    movaps xmm2,[rdi]
    mulps xmm2,xmm1
    addps xmm2,xmm3

    movaps [rdi],xmm2

    add rdi,16
    add r10,4
    cmp r9,r10
    je fin

    jmp bucle

fin:
    ret