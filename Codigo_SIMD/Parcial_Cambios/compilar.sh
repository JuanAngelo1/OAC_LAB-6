#!/bin/bash
# Para ejecutar archivos .sh -> bash compilar.sh

#nasm -f elf64 arg_min_max_asm.asm -o arg_min_max_asm.o
#gcc arg_min_max_asm.o lib.c -o lib.so -lm
#./lib.so


nasm -f elf64 arg_min_max_asm.asm -o arg_min_max_asm.o
gcc -shared arg_min_max_asm.o lib.c -o lib.so
python3 plantilla.py