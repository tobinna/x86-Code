.686  ;32 bit program, uses the x86 
.model flat, C

.code
public pow_proc
pow_proc:
	push ebp
	mov ebp, esp
	push esi
	
	mov esi, [ebp+8]  
	mov ecx, [ebp+12] 
	mov eax, 1

l2:	mul esi			; eax = eax * esi
	dec ecx
	jnz l2

	mov esp, ebp
	pop ebp
	ret 


public poly_proc
poly_proc:
	push ebp
	mov ebp, esp
	push edi

	mov eax, 1
		
	mov esi, [ebp+8]  ; storing the value of 7 in this register
	mov edi, 1
	
l3:	
	push eax
	push edi
	push esi
	call pow_proc

	pop esi
	pop edi
		
	mov  edx, eax

	pop eax
	add eax, edx
	add edi, 1
	cmp edi, 4
	jne l3

	mov esp, ebp
	pop ebp
	ret 
	


public multiple_k_asm
multiple_k_asm:
	push ebp
	mov ebp, esp	
	push esi
	push ebx
	   
	mov ecx, [ebp+12] ; N
	mov esi, [ebp+20] ; array
	
	mov eax, [ebp+8]	; start of the array
	mov bx, 2
	mul bx
	add esi, eax

	xor esp, esp

l7:		
	xor edx, edx
	mov eax, [ebp+8]
	add eax, esp
	mov ebx, [ebp+16]
	div ebx
	cmp edx, 0
	jne not_divided
	mov dx, 1
	mov [esi], dx

not_divided: 
	add esi, 2
	add esp, 1
	cmp eax, ecx
	jne l7

	mov esp, ebp  ; value of base pointer back onto stack pointer
	pop ebp	
	ret


public factorial
factorial:
	push ebp
	mov ebp, esp
	mov eax, [esp+8]
	cmp eax, 1
	ja factor
	mov eax, 1
	jmp done

factor: 
	dec eax
	push eax
	call factorial
	mov ebx, [ebp+8]

	imul ebx
	
done:	
	mov esp, ebp	; value of base pointer back onto stack pointer
	pop ebp
	ret

end