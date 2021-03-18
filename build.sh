echo "You need nasm and gcc"
nasm assembly_code_duplication.asm -f elf64 -g -o size.o
gcc -g code_duplication.c size.o