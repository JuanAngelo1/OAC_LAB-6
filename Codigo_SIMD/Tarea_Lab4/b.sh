#!/bin/bash
# Para ejecutar archivos .sh -> bash compilar.sh

nasm -f elf64 alg_asm.asm -o alg_asm.o
nasm -f elf64 alg_asm.asm -o alg_asm.o
gcc alg_asm.o alg_simd.o lib.c -o lib.o -lm
./lib.o

#nasm -f elf64 -g alg_simd.asm -o alg_simd.o -g
#nasm -f elf64 -g alg_asm.asm -o alg_asm.o -g
#gcc alg_asm.o alg_simd.o lib.c -o lib -g -lm
#gdb lib