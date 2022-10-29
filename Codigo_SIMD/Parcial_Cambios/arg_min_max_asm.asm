global arg_min_max_asm
    section .text

arg_min_max_asm:
    ;rdi contiene la direccion de v1
    ;rsi contiene el valor de arr
    ;rdx contiene el valor de N

    xorpd xmm0,xmm0; Limpiamos el registro xmm0
    xorpd xmm1,xmm1
    xorpd xmm2,xmm2
    
    mov r12,0; Sera el contador del bucle

    mov r8,20
    mov r9,0
    cvtsi2ss xmm1,r8 ; xmm1 tiene el valor minimo
    cvtsi2ss xmm2,r9 ; xmm2 tiene el valor maximo

    mov r10,0 ; r10 tendra el valor de la posicion del minimo valor
    mov r11,0 ; r11 tendra el valor de la posicion del maximo valor
    mov r13,0
    mov r14,rdx

    ;sub rdi,4

bucle:
    
    movss xmm0,[rdi] ;Guarda el valor de rdi en xmm0, xmm0 apunta al primer valor de v1

    ucomiss xmm0,xmm2 ; Comparamos el primer elemento del arreglo con  r9=-5
    ja  mayor_que

    ucomiss xmm0,xmm1; Comparamos el primer valor del arreglo con  r8=100
    jb menor_que

    add rdi,4 ; Nos movemos al siguiente valor del arreglo
    add r12,1
    cmp r12,r14
    je fin
    
    jmp bucle

mayor_que:

    mov r11,r12
    movss xmm2,xmm0
    add rdi,4 ; Nos movemos al siguiente valor del arreglo
    add r12,1
    cmp r12,r14
    je fin
    
    jmp bucle

menor_que:
   
    mov r10,r12
    movss xmm1,xmm0
    add rdi,4 ; Nos movemos al siguiente valor del arreglo
    add r12,1
    cmp r12,r14
    je fin

    jmp bucle

fin:
    mov [rsi],r10; Guardamos el valor del menor valor del arreglo en la direccion de rdx
    add rsi,4
    mov [rsi],r11; GUardamos el valor del mayor valor del arreglo en la direccion rcx
    ret