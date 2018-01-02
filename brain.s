.section .bss
buffer: .skip 300000	#cells buffer with 30 thousands available cells
readText: .skip 1000600	#buffer for the read text of the file
loopBuffer: .skip 4024	#keep track of the nested loops start points
fileName: .skip 16
.data
format: .asciz "%s" 	#define the format of the user input

.section .text
plus: .asciz "+"	#define the commands
minus: .asciz "-"
left: .asciz "<"
right: .asciz ">"
dot: .asciz "."
comma: .asciz ","
startLoop: .asciz "["
endLoop: .asciz "]"


.global main

main:
	movq 8(%rsi), %rcx	#read the commandline file name
	movq %rcx, fileName	
	movq $2, %rax		#sys open the file
	movq fileName, %rdi
	movq $0, %rsi
	syscall
		
	push %rax		#sys read the file 
	movq %rax, %rdi
	movq $0, %rax
	leaq readText, %rsi
	movq $1000600, %rdx
	syscall

	movq $3, %rax		#sys close the file
	pop %rdi
	syscall


	movq $0, %rax	#invalid loops pointer
	movq $0, %r9	#code reading pointer
	movq $150000, %r10	#cell pointer
	movq $0, %r11	#command holder
	movq $0, %r12	#helpers
	movq $0, %r13 	#loop value holder
	movq $0, %r14	#loop end holder
	movq $0, %r15	#pointer to first loop instruction
	movq $8, %r8	#loops buffer pointer
	jmp interpret


interpret:
	jmp getCommand1		#read a command from the file
	jmp interpretCommand	#interpret the command we read
	cmpb $0, %r11b
	jne interpret
	jz terminate
	ret
#get a command from the file and transfer the control to interpretCommand
getCommand1:
	movb readText(%r9),%r11b	#read one byte from the text file
	addq $1, %r9
	cmpb $0, %r11b
	jz terminate	
	jmp interpretCommand	

#gets a command from the file and retunrs the control to the getEndOFLoop 
getCommand2:
	movb readText(%r9),%r11b	#read one byte from the text file
	addq $1, %r9
	cmpb $0, %r11b
	jbe terminate	
	jmp invalidLoopFindEnd

#find the needed action depending on the command
#ignores anything that's not a valid command
interpretCommand:
	cmpb $62, %r11b	#is it increment cell pointer
	jz incCellPointer

	cmpb $60, %r11b	#is it decrement cell pointer
	jz decCellPointer
	
	cmpb $43, %r11b	#increments the cell value
	jz incCellValue

	cmpb $45, %r11b	#decrement the cell value
	jz decCellValue

	cmpb $46, %r11b
	jz printCellValue

	cmpb $44, %r11b
	jz getCharToCell

	cmpb $91, %r11b
	jz startLoopOperation

	cmpb $93, %r11b
	jz endLoopOperation

	cmpb $0, %r11b
	jz terminate

	jmp interpret

#increments the pointer of the cell buffer
incCellPointer:
	addq $1, %r10
#	cmpq $300000, %r10
#	jg wrapDown
	jmp interpret
#wrapDown:
#	movq $0, %r10
#	jmp interpret
#decrement the pointer of the cell buffer
decCellPointer:
	subq $1, %r10
	jmp interpret

#increment the value of the cell points to by the cell pointer
incCellValue:
	addb $1, buffer(%r10)
	jmp interpret

#decrement the value of the cell points to by the cell pointer
decCellValue:
	subb $1, buffer(%r10)
	jmp interpret

#print the value we have in the cell pointed to by the cell pointer
printCellValue:
	leaq buffer(%r10), %r12	
	jmp printCharacter

#reads a char from the user
getCharToCell:
	push %rbx	#save all the registers we are using
	push %rax
	push %rdi
	push %rsi
	push %rdx
	push %r15
	push %r14
	push %r13
	push %r12
	push %r11
	push %r10
	push %r9
	push %r8

	movq $0, %rbx		#get the user input
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	leaq -8(%rbp),%rsi
	movq $format, %rdi
	movq $0, %rax
	call scanf
	movq -8(%rbp), %rbx

	movq %rbp, %rsp
	popq %rbp

	pop %r8
	pop %r9
	pop %r10
	movb %bl, buffer(%r10)	#move the user input to the buffer cell
	pop %r11
	pop %r12
	pop %r13
	pop %r14
	pop %r15
	pop %rdx
	pop %rsi
	pop %rdi		#return the values to the registers 
	pop %rax
	pop %rbx
	jmp interpret

#this function will mark the start of the loop so the control will know where to return to
#it also checks if the loop is valid
#it saves the pointer to the begining of the loop in the loop buffer
startLoopOperation:
	cmpb $0, buffer(%r10)		#check if we should loop or not
	jz invalidLoopStart
	movq %r9, %r15			#save the start of the loop pointer
	movq %r15, loopBuffer(%r8)	#save the start of the loop pointer
	addq $8, %r8			#increment loop buffer pointer
	jmp interpret

invalidLoopStart:
	addq $1, %rax			#increment the invalid loops count
invalidLoop:
	jmp getCommand2			#get the next command to find the end of the loop
invalidLoopFindEnd:
#if we find another loop start than increment the amount of needed closing tags for the loop
	cmpb startLoop, %r11b		
	jz incrementEndCounters
#if we find a loop end tag check if we need to search for more loops end
	cmpb endLoop, %r11b
	jnz invalidLoop
	jz DecrementEndCounter
	jmp interpret

DecrementEndCounter:
	subq $1, %rax
	cmpq $0, %rax
	jnz invalidLoop
	jmp interpret
	
incrementEndCounters:
	addq $1, %rax
	jmp invalidLoop

#checks if the loops needs to be stopped or continued
endLoopOperation:
#	movb buffer(%r10), %r12b
	cmpb $0, buffer(%r10)
	jz endLoopCheck
	movq %r15, %r9		#move the read from the file pointer back to the beging of the loop
	jmp interpret

#if the loops needs to be ended than make the loop start pointer have the value of the higher level loop
endLoopCheck:
	subq $16, %r8
	movq  loopBuffer(%r8), %r15
	addq $8, %r8
	jmp interpret
#exits the program
terminate:
	movq $0, %rax
	call exit

#print one character reading from the cell pointed by the cell pointer
printCharacter:	
	push %rax
	push %rdi
	push %rsi
	push %rdx
	push %r15	#save all the registers values because syscacll can change them
	push %r14
	push %r13
	push %r12
	push %r11
	push %r10
	push %r9
	push %r8

	mov $1, %rax
	mov $1, %rdi
	mov %r12, %rsi
	mov $1, %rdx
	syscall
	pop %r8
	pop %r9
	pop %r10
	pop %r11
	pop %r12
	pop %r13
	pop %r14
	pop %r15
	pop %rdx
	pop %rsi
	pop %rdi
	pop %rax
	jmp interpret


