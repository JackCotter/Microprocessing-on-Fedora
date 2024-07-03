	.file	"mu-decode.c"
	.text
	.globl	sign
	.type	sign, @function
sign:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, %eax
	movb	%al, -4(%rbp)
	cmpb	$0, -4(%rbp)
	jns	.L2
	movl	$1, %eax
	jmp	.L3
.L2:
	movl	$0, %eax
.L3:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	sign, .-sign
	.globl	magnitude
	.type	magnitude, @function
magnitude:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, %eax
	movb	%al, -4(%rbp)
	movzbl	-4(%rbp), %eax
	andl	$127, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	magnitude, .-magnitude
	.globl	codeword_expansion
	.type	codeword_expansion, @function
codeword_expansion:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, %edx
	movl	%esi, %eax
	movb	%dl, -20(%rbp)
	movb	%al, -24(%rbp)
	movsbl	-20(%rbp), %eax
	andl	$112, %eax
	cmpl	$112, %eax
	jne	.L7
	movw	$4096, -6(%rbp)
	movsbw	-20(%rbp), %ax
	andl	$15, %eax
	movw	%ax, -4(%rbp)
	movsbw	-24(%rbp), %ax
	sall	$15, %eax
	movl	%eax, %ecx
	movswl	-6(%rbp), %eax
	movswl	-4(%rbp), %edx
	sall	$8, %edx
	orl	%edx, %eax
	sall	$2, %eax
	orb	$2, %ah
	orl	%ecx, %eax
	movw	%ax, -2(%rbp)
	movzwl	-2(%rbp), %eax
	jmp	.L8
.L7:
	movsbl	-20(%rbp), %eax
	andl	$96, %eax
	cmpl	$96, %eax
	jne	.L9
	movw	$2048, -6(%rbp)
	movsbw	-20(%rbp), %ax
	andl	$15, %eax
	movw	%ax, -4(%rbp)
	movsbw	-24(%rbp), %ax
	sall	$15, %eax
	movl	%eax, %ecx
	movswl	-6(%rbp), %eax
	movswl	-4(%rbp), %edx
	sall	$7, %edx
	orl	%edx, %eax
	sall	$2, %eax
	orb	$1, %ah
	orl	%ecx, %eax
	movw	%ax, -2(%rbp)
	movzwl	-2(%rbp), %eax
	jmp	.L8
.L9:
	movsbl	-20(%rbp), %eax
	andl	$80, %eax
	cmpl	$80, %eax
	jne	.L10
	movw	$1024, -6(%rbp)
	movsbw	-20(%rbp), %ax
	andl	$15, %eax
	movw	%ax, -4(%rbp)
	movsbw	-24(%rbp), %ax
	sall	$15, %eax
	movl	%eax, %ecx
	movswl	-6(%rbp), %eax
	movswl	-4(%rbp), %edx
	sall	$6, %edx
	orl	%edx, %eax
	sall	$2, %eax
	orb	$-128, %al
	orl	%ecx, %eax
	movw	%ax, -2(%rbp)
	movzwl	-2(%rbp), %eax
	jmp	.L8
.L10:
	movsbl	-20(%rbp), %eax
	andl	$64, %eax
	testl	%eax, %eax
	je	.L11
	movw	$512, -6(%rbp)
	movsbw	-20(%rbp), %ax
	andl	$15, %eax
	movw	%ax, -4(%rbp)
	movsbw	-24(%rbp), %ax
	sall	$15, %eax
	movl	%eax, %ecx
	movswl	-6(%rbp), %eax
	movswl	-4(%rbp), %edx
	sall	$5, %edx
	orl	%edx, %eax
	sall	$2, %eax
	orl	$64, %eax
	orl	%ecx, %eax
	movw	%ax, -2(%rbp)
	movzwl	-2(%rbp), %eax
	jmp	.L8
.L11:
	movsbl	-20(%rbp), %eax
	andl	$48, %eax
	cmpl	$48, %eax
	jne	.L12
	movw	$256, -6(%rbp)
	movsbw	-20(%rbp), %ax
	andl	$15, %eax
	movw	%ax, -4(%rbp)
	movsbw	-24(%rbp), %ax
	sall	$15, %eax
	movl	%eax, %ecx
	movswl	-6(%rbp), %eax
	movswl	-4(%rbp), %edx
	sall	$4, %edx
	orl	%edx, %eax
	sall	$2, %eax
	orl	$32, %eax
	orl	%ecx, %eax
	movw	%ax, -2(%rbp)
	movzwl	-2(%rbp), %eax
	jmp	.L8
.L12:
	movsbl	-20(%rbp), %eax
	andl	$32, %eax
	testl	%eax, %eax
	je	.L13
	movw	$128, -6(%rbp)
	movsbw	-20(%rbp), %ax
	andl	$15, %eax
	movw	%ax, -4(%rbp)
	movsbw	-24(%rbp), %ax
	sall	$15, %eax
	movl	%eax, %ecx
	movswl	-6(%rbp), %eax
	movswl	-4(%rbp), %edx
	sall	$3, %edx
	orl	%edx, %eax
	sall	$2, %eax
	orl	$16, %eax
	orl	%ecx, %eax
	movw	%ax, -2(%rbp)
	movzwl	-2(%rbp), %eax
	jmp	.L8
.L13:
	movsbl	-20(%rbp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	je	.L14
	movw	$64, -6(%rbp)
	movsbw	-20(%rbp), %ax
	andl	$15, %eax
	movw	%ax, -4(%rbp)
	movsbw	-24(%rbp), %ax
	sall	$15, %eax
	movl	%eax, %ecx
	movswl	-6(%rbp), %eax
	movswl	-4(%rbp), %edx
	sall	$2, %edx
	orl	%edx, %eax
	sall	$2, %eax
	orl	$8, %eax
	orl	%ecx, %eax
	movw	%ax, -2(%rbp)
	movzwl	-2(%rbp), %eax
	jmp	.L8
.L14:
	movl	$0, %eax
.L8:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	codeword_expansion, .-codeword_expansion
	.section	.rodata
.LC0:
	.string	"Usage: %s <path/to/wav/file>"
.LC1:
	.string	"rb"
.LC2:
	.string	"Failed to open file"
.LC3:
	.string	"wb"
.LC4:
	.string	"decompressed_out.wav"
.LC5:
	.string	"Error opening output file\n"
.LC6:
	.string	"RIFF"
.LC7:
	.string	"WAVE"
.LC8:
	.string	"Invalid WAV file\n"
.LC9:
	.string	"%d"
	.text
	.globl	main
	.type	main, @function
main:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$160, %rsp
	movl	%edi, -148(%rbp)
	movq	%rsi, -160(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	cmpl	$2, -148(%rbp)
	je	.L16
	movq	-160(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$1, %eax
	jmp	.L24
.L16:
	movq	-160(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC1(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -128(%rbp)
	cmpq	$0, -128(%rbp)
	jne	.L18
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L18:
	leaq	.LC3(%rip), %rax
	movq	%rax, %rsi
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -120(%rbp)
	cmpq	$0, -120(%rbp)
	jne	.L19
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	call	fwrite@PLT
	movq	-128(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	movl	$0, %eax
	jmp	.L24
.L19:
	movq	-128(%rbp), %rdx
	leaq	-112(%rbp), %rax
	movq	%rdx, %rcx
	movl	$1, %edx
	movl	$44, %esi
	movq	%rax, %rdi
	call	fread@PLT
	movq	-112(%rbp), %rax
	movq	-104(%rbp), %rdx
	movq	%rax, -64(%rbp)
	movq	%rdx, -56(%rbp)
	movq	-96(%rbp), %rax
	movq	-88(%rbp), %rdx
	movq	%rax, -48(%rbp)
	movq	%rdx, -40(%rbp)
	movq	-84(%rbp), %rax
	movq	-76(%rbp), %rdx
	movq	%rax, -36(%rbp)
	movq	%rdx, -28(%rbp)
	leaq	-112(%rbp), %rax
	movl	$4, %edx
	leaq	.LC6(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	memcmp@PLT
	testl	%eax, %eax
	jne	.L20
	leaq	-112(%rbp), %rax
	addq	$8, %rax
	movl	$4, %edx
	leaq	.LC7(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	memcmp@PLT
	testl	%eax, %eax
	je	.L21
.L20:
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$17, %edx
	movl	$1, %esi
	leaq	.LC8(%rip), %rax
	movq	%rax, %rdi
	call	fwrite@PLT
	movq	-128(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	movq	-120(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	movl	$0, %eax
	jmp	.L24
.L21:
	movw	$16, -30(%rbp)
	movl	-40(%rbp), %edx
	movzwl	-42(%rbp), %eax
	movzwl	%ax, %eax
	imull	%edx, %eax
	addl	%eax, %eax
	movl	%eax, -36(%rbp)
	movzwl	-42(%rbp), %eax
	addl	%eax, %eax
	movw	%ax, -32(%rbp)
	movl	-24(%rbp), %eax
	addl	%eax, %eax
	movl	%eax, -24(%rbp)
	movl	-24(%rbp), %eax
	addl	$36, %eax
	movl	%eax, -60(%rbp)
	movq	-120(%rbp), %rdx
	leaq	-64(%rbp), %rax
	movq	%rdx, %rcx
	movl	$1, %edx
	movl	$44, %esi
	movq	%rax, %rdi
	call	fwrite@PLT
	movl	-76(%rbp), %eax
	movl	%eax, %edx
	movq	-128(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	fseek@PLT
	movl	-76(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC9(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -132(%rbp)
	jmp	.L22
.L23:
	movq	-128(%rbp), %rax
	movq	%rax, %rdi
	call	fgetc@PLT
	movb	%al, -137(%rbp)
	movsbl	-137(%rbp), %eax
	movl	%eax, %edi
	call	sign
	movb	%al, -136(%rbp)
	movsbl	-137(%rbp), %eax
	movl	%eax, %edi
	call	magnitude
	movb	%al, -135(%rbp)
	movsbl	-136(%rbp), %edx
	movsbl	-135(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	codeword_expansion
	movw	%ax, -134(%rbp)
	movq	-120(%rbp), %rdx
	leaq	-134(%rbp), %rax
	movq	%rdx, %rcx
	movl	$1, %edx
	movl	$2, %esi
	movq	%rax, %rdi
	call	fwrite@PLT
	addl	$1, -132(%rbp)
.L22:
	movl	-72(%rbp), %eax
	movl	-132(%rbp), %edx
	cmpl	%eax, %edx
	jb	.L23
	movq	-120(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	movq	-128(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	movl	$0, %eax
.L24:
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L25
	call	__stack_chk_fail@PLT
.L25:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 13.2.0-23ubuntu4) 13.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
