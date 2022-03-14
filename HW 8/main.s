;Taylor Martin 
; HW # 8 
; CS-151
; 4/15/20
; This program loops through values assigned to an array 
; in order to find the min and max values located within the array
; then once found, it will display the min and max values to the screen 
	.file	"main.cpp"
.lcomm __ZStL8__ioinit,1,1
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC0:
	.ascii "Max = \0"
LC1:
	.ascii "\12\0"
LC2:
	.ascii "Min = \0"
	.text
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
	leal	4(%esp), %ecx
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ecx
	subl	$84, %esp
	call	___main
	movl	$1, -60(%ebp)
	movl	$3, -56(%ebp)
	movl	$7, -52(%ebp)
	movl	$2, -48(%ebp)
	movl	$5, -44(%ebp)
	movl	$4, -40(%ebp)
	movl	$8, -36(%ebp)
	movl	$7, -32(%ebp)
	movl	$0, -28(%ebp)
	movl	$2, -24(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	-60(%ebp), %eax
	movl	%eax, -16(%ebp)
	movl	$0, -20(%ebp)
L5:
	cmpl	$8, -20(%ebp)
	jg	L2
	movl	-20(%ebp), %eax
	movl	-60(%ebp,%eax,4), %eax
	cmpl	-16(%ebp), %eax
	jle	L3
	movl	-20(%ebp), %eax
	movl	-60(%ebp,%eax,4), %eax
	movl	%eax, -16(%ebp)
	jmp	L4
L3:
	movl	-20(%ebp), %eax
	movl	-60(%ebp,%eax,4), %eax
	cmpl	-12(%ebp), %eax
	jge	L4
	movl	-20(%ebp), %eax
	movl	-60(%ebp,%eax,4), %eax
	movl	%eax, -12(%ebp)
L4:
	addl	$1, -20(%ebp)
	jmp	L5
L2:
	movl	$LC0, 4(%esp)
	movl	$__ZSt4cout, (%esp)
	call	__ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	%eax, %edx
	movl	-16(%ebp), %eax
	movl	%eax, (%esp)
	movl	%edx, %ecx
	call	__ZNSolsEi
	subl	$4, %esp
	movl	$LC1, 4(%esp)
	movl	%eax, (%esp)
	call	__ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$LC2, 4(%esp)
	movl	$__ZSt4cout, (%esp)
	call	__ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	movl	%edx, %ecx
	call	__ZNSolsEi
	subl	$4, %esp
	movl	$LC1, 4(%esp)
	movl	%eax, (%esp)
	call	__ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	$0, %eax
	movl	-4(%ebp), %ecx
	leave
	leal	-4(%ecx), %esp
	ret
	.def	___tcf_0;	.scl	3;	.type	32;	.endef
___tcf_0:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$__ZStL8__ioinit, %ecx
	call	__ZNSt8ios_base4InitD1Ev
	leave
	ret
	.def	__Z41__static_initialization_and_destruction_0ii;	.scl	3;	.type	32;	.endef
__Z41__static_initialization_and_destruction_0ii:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	cmpl	$1, 8(%ebp)
	jne	L10
	cmpl	$65535, 12(%ebp)
	jne	L10
	movl	$__ZStL8__ioinit, %ecx
	call	__ZNSt8ios_base4InitC1Ev
	movl	$___tcf_0, (%esp)
	call	_atexit
L10:
	nop
	leave
	ret
	.def	__GLOBAL__sub_I_main;	.scl	3;	.type	32;	.endef
__GLOBAL__sub_I_main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$65535, 4(%esp)
	movl	$1, (%esp)
	call	__Z41__static_initialization_and_destruction_0ii
	leave
	ret
	.section	.ctors,"w"
	.align 4
	.long	__GLOBAL__sub_I_main
	.ident	"GCC: (tdm-1) 5.1.0"
	.def	__ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc;	.scl	2;	.type	32;	.endef
	.def	__ZNSolsEi;	.scl	2;	.type	32;	.endef
	.def	__ZNSt8ios_base4InitD1Ev;	.scl	2;	.type	32;	.endef
	.def	__ZNSt8ios_base4InitC1Ev;	.scl	2;	.type	32;	.endef
	.def	_atexit;	.scl	2;	.type	32;	.endef
