global alg_asm
    section .text
alg_asm:
    ;rdi -> v
    ;rsi -> N
    ;rdx -> v_min
    ;rcx -> v_max
    ;xmm0 -> vm_max

    xorpd xmm1,xmm1
    xorpd xmm2,xmm2
    xorpd xmm3,xmm3

    mov r10,0
    xor r8,r8
    xor rax,rax

    sub rcx,rdx
    cvtsi2ss xmm1,rcx
    divss xmm1,xmm0; xmm1 -> 0.4


    mov r9,rsi; Contador


bucle:
    mov eax,[rdi]
    
    movss xmm2,[rdi]

    cvtsi2ss xmm3,eax

    mulss xmm3,xmm1

    xor eax,eax

    cvtss2si eax,xmm3

    add eax,edx

    mov [rdi],eax


    add rdi,4
    add r10,1
    cmp r9,r10
    je fin

    
    jmp bucle

fin:
    ret
