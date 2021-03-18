/* ========================================================================
   Example linux code to duplicate labeled code 
   Randomness in the output is intentional 
   code_chunk 12 is causing it; no other code_chunk should generate random results
   ======================================================================== */
#include <stdint.h>
#include <stdio.h>
#include <sys/mman.h>
#include <string.h>

#define arr_size(x) (sizeof(x)/sizeof(x[0]))

//DO NOT reorder assembly code cant adjust itself accordingly 
typedef struct Code_Chunk{
    uint8_t*    starting_point;
    uint64_t size;
} Code_Chunk;

void size_instructions(Code_Chunk* codes);

typedef void(*PlainFuncPtr)();
//codes that are registered
void ins0();
void ins1();
void ins2();
void ins3();
void ins4();
void ins5();
void ins6();
void ins7();
void ins8();
void ins9();
void ins10();
void ins11();
void ins12();
void ins13();
void ins14();
void last();

void fill_instructions(Code_Chunk* codes){
    codes[0].starting_point = ins0;
    codes[1].starting_point = ins1;
    codes[2].starting_point = ins2;
    codes[3].starting_point = ins3;
    codes[4].starting_point = ins4;
    codes[5].starting_point = ins5;
    codes[6].starting_point = ins6;
    codes[7].starting_point = ins7;
    codes[8].starting_point = ins8;
    codes[9].starting_point = ins9;
    codes[10].starting_point = ins10;
    codes[11].starting_point = ins11;
    codes[12].starting_point = ins12;
    codes[13].starting_point = ins13;
    codes[14].starting_point = ins14;
    codes[15].starting_point = last;
}
void mem_cpy(void* dst,void*src,uint64_t size){
    uint8_t* dst_b = dst, *src_b = src;
    for(uint64_t i = 0; i < size; i++){
        dst_b[i] = src_b[i];
    }
}
int main(){

    Code_Chunk codes[16];

    size_instructions(codes);
    fill_instructions(codes);

    printf("%llu\n",codes[1].size);

    int instructions[] = {11,12,13,0,0,3,1,2,2,2,2,2,2,2,2,2,15}; // last one must be ret (15)
    int length = 0, i, cursor,num_ins;
    num_ins = arr_size(instructions);
    unsigned char memory[40] = {}; //the code we are duplicating needs memory
    for(i = 0; i < num_ins; ++i){
        length += codes[instructions[i]].size;
    }
    PlainFuncPtr code_block = mmap(NULL, length, PROT_WRITE | PROT_READ ,MAP_ANONYMOUS|MAP_PRIVATE,0,0); // PROT_EXEC is not allowed alongside PROT_WRITE in some kernels
    for(i = 0, cursor = 0; i < num_ins; ++i){
        memcpy(((unsigned char* )code_block+cursor),codes[instructions[i]].starting_point, codes[instructions[i]].size);
        cursor += codes[instructions[i]].size;
    }
    mprotect(code_block, length, PROT_EXEC); // add execution rights
    {  // using the code_block we filled
        asm volatile ("mov %0, %%r8" : :"r" (memory));
        code_block();
    }
    for(i = 0; i < 10; ++i){
        printf("%d ",(int)memory[i]);
    }
    printf("\n");
    for(; i < 20; ++i){
        printf("%d ",(int)memory[i]);
    }
    printf("\n");
    for(; i < 30; ++i){
        printf("%d ",(int)memory[i]);
    }
    printf("\n");
    for(; i < 40; ++i){
        printf("%d ",(int)memory[i]);
    }
    printf("\n");

    char c;
    c = getchar();
    return c >> 7; // dont optimize out 
}
