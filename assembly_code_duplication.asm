bits 64			

	; this is the code that sets the sizes of codes that are duplicated.

	section .text

	global size_instructions
	global ins0
	global ins1
	global ins2
	global ins3
	global ins4
	global ins5
	global ins6

	global ins7
	global ins8
	global ins9
	global ins10
	global ins11
	global ins12
	global ins13
	
	global ins14
	global last
	
size_instructions:
	push    rdi
	
	mov     qword[8+rdi],ins1 -ins0
;;; 	mov     qword[rdi],ins0

	mov     qword[24+rdi], ins2 -ins1
;;; 	mov     qword[16+rdi],ins1

    mov     qword[40+rdi], ins3 -ins2
;;;     mov     qword[32+rdi],ins2
	
	mov     qword[56+rdi], ins4 -ins3
;;;     mov     qword[48+rdi],ins3
	
    mov     qword[72+rdi], ins5 -ins4
;;;     mov     qword[64+rdi],ins4
	
    mov     qword[88+rdi], ins6 -ins5
;;;     mov     qword[80+rdi],ins5

    mov     qword[104+rdi], ins7 -ins6
;;;     mov     qword[96+rdi],ins6
	
    mov     qword[120+rdi], ins8 -ins7
;;;     mov     qword[112+rdi],ins7
	
    mov     qword[136+rdi], ins9 -ins8
;;;     mov     qword[128+rdi],ins8
	
    mov     qword[152+rdi], ins10 -ins9
;;;     mov     qword[144+rdi],ins9
	
    mov     qword[168+rdi], ins11 -ins10
;;;     mov     qword[160+rdi],ins10
	
    mov     qword[184+rdi], ins12 -ins11
;;;     mov     qword[176+rdi],ins11
	
    mov     qword[200+rdi], ins13 -ins12
;;;     mov     qword[192+rdi],ins12
	
    mov     qword[216+rdi], ins14 -ins13
;;;     mov     qword[208+rdi],ins13
	
    mov     qword[232+rdi], last -ins14
;;;     mov     qword[224+rdi],ins14

    mov     qword[248+rdi], bottom -last
;;;     mov     qword[240+rdi],last

	jmp ending
	
	ins0:
	mov    r9, [14+r8]
        add    byte[12+r8], r9b
	ins1:
	mov    r9, [2+r8]
	sub    byte[11+r8], r9b
	ins2:
	inc    byte [10+r8]
	ins3:
        dec    byte [9+r8]
	ins4:
	mov     r9, [13+r8]
	test    byte[1+r8], r9b
	ins5:
	mov     r9, [5+r8]
	mov     r10, [13+r8]
	cmovns  r10, r9
	mov     [13+r8], r10
	ins6:
	mov     r9, [12+r8]
	mov     r10, [11+r8]
        cmovg   r10, r9
	mov     [11+r8], r10
	ins7:
	mov     r9, [7+r8]
        xor     byte[8+r8], r9b	
	ins8:
	mov     r9, [4+r8]
	or      byte[6+r8], r9b
	ins9:
        mov cl, [3+r8]
	and cl, 63
	mov r10, [15+r8]
	shr  r10, cl
	mov [15+r8], r10
	ins10:
        mov cl, [2+r8]
	and cl, 63
	mov r10, [10+r8]
	shl  r10, cl
	mov [10+r8], r10
	ins11:
	mov r9, [12+r8]
	mov r10, [10+r8]
	imul r10, r9
	mov  [10+r8], r10
	ins12:
	mov r10, [8+r8]
        lea r10, [16+r8]
	mov  [8+r8], r10
	ins13:
	mov r9, [8+r8]
	mov r10, [11+r8]
	and r10, r9
	mov  [11+r8], r10
	ins14:
	mov r9, [6+r8]
	mov r10, [r9]
        add r10b, byte[2+r8]
	mov [3+r8], r10
	ending:
	pop rdi
	last:
	ret
	bottom:
