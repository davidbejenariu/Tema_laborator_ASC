.data
	matAd: .space 1600
	n: .space 4
	nrMuchii: .space 4
	task: .space 4
	roles: .space 80
	
	role: .space 4 
	columnIndex: .space 4
	lineIndex: .space 4
	i: .space 4
	j: .space 4
	    
	left: .space 4
	right: .space 4
	
	printed: .long 0
	Q: .space 1600
	m: .space 4
	viz: .space 80
	visited: .space 4
	
	n1: .space 4
	n2: .space 4
	str: .space 100
	//cat ocupa maxim?
	len: .space 4
	    
	newLine: .asciz "\n"
	formatScanf: .asciz "%d"
	formatPrintf: .asciz "%d "
	formatPrintf0: .asciz "\nswitch malitios index %d: "
	formatPrintf01: .asciz "switch malitios index %d: "
	formatPrintf1: .asciz "host index %d; "
	formatPrintf2: .asciz "switch index %d; "
	formatPrintf3: .asciz "switch malitios index %d; "
	formatPrintf4: .asciz "controller index %d; "
	yes: .asciz "\nYes"
	no: .asciz "\nNo"
	strScan: .asciz "%s"
	strPrint: .asciz "%s"
    
.text
 
.global main
 
main:
	pushl $n
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	    
	pushl $nrMuchii
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	movl $0, i
    
et_citire_matrice:
	movl i, %ecx
	cmp %ecx, nrMuchii
	je et_citire_roles
    
	pushl $left
	pushl $formatScanf
	call scanf 
	popl %ebx
	popl %ebx
	    
	pushl $right
	pushl $formatScanf
	call scanf 
	popl %ebx
	popl %ebx
	    
	// trebuie sa completez 
	// matAd[left][right] = 1
	// left * n + right
	    
	movl left, %eax
	movl $0, %edx
	mull n
	addl right, %eax
	    
	lea matAd, %edi
	movl $1, (%edi, %eax, 4)
	    
	movl right, %eax
	movl $0, %edx
	mull n
	addl left, %eax
	    
	movl $1, (%edi, %eax, 4)
	    
	incl i
	jmp et_citire_matrice
        
et_citire_roles:
	movl $0, i
	
	et_for:
		movl i, %ecx
		cmp %ecx, n
		je et_citire_task
		
		pushl $role
		pushl $formatScanf
		call scanf
		popl %ebx
		popl %ebx
		
		movl i, %eax
		lea roles, %esi
		movl role, %ebx
		movl %ebx, (%esi, %eax, 4)
		
		incl i
		jmp et_for
	
et_citire_task:
	pushl $task
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	movl task, %ecx
	
	cmp $1, %ecx
	je et_task1
	
	cmp $2, %ecx
	je et_task2
	
	cmp $3, %ecx
	je et_task3	
	
et_task1:
	movl $0, i
	
	et_for1:
		movl i, %ecx
		cmp %ecx, n
		je et_exit
	
		lea roles, %esi
		movl (%esi, %ecx, 4), %eax
		cmp $3, %eax
		je et_malitios0
	
		incl i
		jmp et_for1
		
	et_malitios0:
		movl printed, %eax
		cmp $1, %eax
		je et_malitios1
		
		pushl i
		pushl $formatPrintf01
		call printf
		popl %ebx
		popl %ebx
		
		pushl $0
		call fflush
		popl %ebx
		
		incl printed
		
		jmp et_malitios
	
	et_malitios1:
		pushl i
		pushl $formatPrintf0
		call printf
		popl %ebx
		popl %ebx
		
		pushl $0
		call fflush
		popl %ebx
		
		jmp et_malitios
		
	et_malitios:
		movl $0, j
				
		et_for2:				
			movl j, %ecx
			cmp %ecx, n
			je et_cont
				
			movl i, %eax
			movl $0, %edx
			mull n
			addl j, %eax
			
			lea matAd, %edi
			movl (%edi, %eax, 4), %ecx
			cmp $1, %ecx
			je et_afisari
			
			incl j
			jmp et_for2
			
		et_afisari:
			movl j, %eax
			lea roles, %esi
			movl (%esi, %eax, 4), %ecx
			
			cmp $1, %ecx
			je et_afisare1
			
			cmp $2, %ecx
			je et_afisare2
			
			cmp $3, %ecx
			je et_afisare3
			
			cmp $4, %ecx
			je et_afisare4
			
		et_afisare1:
			pushl j
			pushl $formatPrintf1
			call printf
			popl %ebx
			popl %ebx
			
			pushl $0
			call fflush
			popl %ebx
			
			incl j
			jmp et_for2
		
		et_afisare2:
			pushl j
			pushl $formatPrintf2
			call printf
			popl %ebx
			popl %ebx
			
			pushl $0
			call fflush
			popl %ebx
			
			incl j
			jmp et_for2
			
		et_afisare3:
			pushl j
			pushl $formatPrintf3
			call printf
			popl %ebx
			popl %ebx
			
			pushl $0
			call fflush
			popl %ebx
			
			incl j
			jmp et_for2
			
		et_afisare4:
			pushl j
			pushl $formatPrintf4
			call printf
			popl %ebx
			popl %ebx
			
			pushl $0
			call fflush
			popl %ebx
			
			incl j
			jmp et_for2
			
		et_cont:	
			incl i
			jmp et_for1
		
et_task2:	
	et_BFS:
		movl $1, m
		movl $0, i
		movl $1, visited
		movl $0, %eax
		
		lea viz, %esi
		movl $1, (%esi, %eax, 4)
		
		et_while:
			movl i, %ecx
			cmp %ecx, m
			je et_after
			
			lea Q, %edi
			movl (%edi, %ecx, 4), %eax
			
			lea roles, %esi
			movl (%esi, %eax, 4), %ebx
			cmp $1, %ebx
			je et_afis
			
			jmp et_while2
			
		et_afis:		
			pushl %eax
			pushl $formatPrintf1
			call printf
			popl %ebx
			popl %ebx
			
			pushl $0
			call fflush
			popl %ebx
			
			jmp et_while2
			
		et_while2:
			movl $0, j
			
			et_for4:
				movl j, %ecx
				cmp n, %ecx
				je et_prewhile
				
				lea Q, %edi
				movl i, %ebx
				movl (%edi, %ebx, 4), %eax
				movl $0, %edx
				mull n
				addl %ecx, %eax
				
				lea matAd, %edi
				movl (%edi, %eax, 4), %ebx
				cmp $1, %ebx
				je et_addQ 
				
				incl j
				jmp et_for4
				
			et_prewhile:
				incl i
				jmp et_while
				
			et_addQ:
				lea viz, %esi
				movl j, %ecx
				movl (%esi, %ecx, 4), %eax
				cmp $0, %eax
				je et_addQ1
				
				incl j
				jmp et_for4
				
			et_addQ1:
				incl visited
				
				movl m, %eax
				lea Q, %edi
				movl j, %ecx
				movl %ecx, (%edi, %eax, 4)
				incl m
				
				lea viz, %esi
				movl j, %eax
				movl $1, (%esi, %eax, 4)
				
				incl j
				jmp et_for4
				
	et_after:
		movl visited, %eax
		cmp %eax, n
		je afis_yes
		jne afis_no
		
	afis_yes:
		pushl $yes
		call printf
		popl %ebx
		
		pushl $0
		call fflush
		popl %ebx
		
		jmp et_exit
		
	afis_no:
		pushl $no
		call printf
		popl %ebx
		
		pushl $0
		call fflush
		popl %ebx
		
		jmp et_exit

et_task3:
	pushl $n1
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	pushl $n2
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	push $str
	push $strScan
	call scanf
	pop %ebx
	pop %ebx

	movl $1, m
	movl $0, i
	movl n1, %eax
	
	lea viz, %esi
	movl $1, (%esi, %eax, 4)
	
	lea Q, %edi
	movl $0, %ecx
	movl %eax, (%edi, %ecx, 4)
	
	et_while3:
		movl i, %ecx
		cmp m, %ecx
		je et_after1
			
		lea Q, %edi
		movl (%edi, %ecx, 4), %eax
		cmp n2, %eax
		je et_end
		
		movl $0, j
			
		et_for5:
			movl j, %ecx
			cmp n, %ecx
			je et_prewhile3
			
			lea Q, %edi
			movl i, %ebx
			movl (%edi, %ebx, 4), %eax
			movl $0, %edx
			mull n
			addl %ecx, %eax
				
			lea matAd, %edi
			movl (%edi, %eax, 4), %ebx
			cmp $1, %ebx
			je et_addq
			
			incl j
			jmp et_for5
			
		et_prewhile3:
			incl i
			jmp et_while3
		
		et_addq:
			lea viz, %esi
			movl j, %ecx
			movl (%esi, %ecx, 4), %eax
			cmp $0, %eax
			je et_addq1
				
			incl j
			jmp et_for5	
			
		et_addq1:
			lea roles, %esi
			movl j, %ecx
			movl (%esi, %ecx, 4), %eax
			cmp $3, %eax
			jne et_addq2
			
			incl j
			jmp et_for5
			
		et_addq2:
			movl m, %eax
			lea Q, %edi
			movl j, %ecx
			movl %ecx, (%edi, %eax, 4)
			incl m
				
			lea viz, %esi
			movl j, %eax
			movl $1, (%esi, %eax, 4)
				
			incl j
			jmp et_for5
			
	et_after1:
		lea str, %edi
		movl $0, i
		
		et_for6:
			movl i, %ecx
			movb (%edi, %ecx, 1), %al
			cmp $0, %al
			je et_after2
			
			movb %al, %ah
			addb $16, %al
			subb $97, %al
			movb $0, %ah
			movb $26, %cl
			divb %cl
			movb $97, %al
			addb %ah, %al
			
			movl i, %ecx
			movb %al, (%edi, %ecx, 1)
			
			incl i
			jmp et_for6
		
	et_after2:
		mov %ecx, len
		
		mov $4, %eax
		mov $1, %ebx
		mov $str, %ecx
		mov len, %edx
		int $0x80
		
		jmp et_exit
			
	et_end:
		lea str, %edi
		movl $0, i
		
		et_for7:
			movl i, %ecx
			movb (%edi, %ecx, 1), %al
			cmp $0, %al
			je et_end2
			
			incl i
			jmp et_for7
	
	et_end2:
		mov %ecx, len
		
		mov $4, %eax
		mov $1, %ebx
		mov $str, %ecx
		mov len, %edx
		int $0x80
		
		jmp et_exit
	
et_exit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80
