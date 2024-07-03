	.file	"mu-encode.c"
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
	movw	%ax, -4(%rbp)
	cmpw	$0, -4(%rbp)
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
	movw	%ax, -4(%rbp)
	movzwl	-4(%rbp), %eax
	andw	$32767, %ax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	magnitude, .-magnitude
	.globl	codeword_compression
	.type	codeword_compression, @function
codeword_compression:
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
	movw	%dx, -20(%rbp)
	movw	%ax, -24(%rbp)
	movb	$0, -5(%rbp)
	movswl	-20(%rbp), %eax
	andl	$4096, %eax
	testl	%eax, %eax
	je	.L7
	movw	$7, -4(%rbp)
	movzwl	-20(%rbp), %eax
	sarw	$8, %ax
	andl	$15, %eax
	movw	%ax, -2(%rbp)
	movzwl	-24(%rbp), %eax
	sall	$7, %eax
	movl	%eax, %edx
	movzwl	-4(%rbp), %eax
	sall	$4, %eax
	orl	%eax, %edx
	movzwl	-2(%rbp), %eax
	orl	%edx, %eax
	movb	%al, -5(%rbp)
	movzbl	-5(%rbp), %eax
	jmp	.L8
.L7:
	movswl	-20(%rbp), %eax
	andl	$2048, %eax
	testl	%eax, %eax
	je	.L9
	movw	$6, -4(%rbp)
	movzwl	-20(%rbp), %eax
	sarw	$7, %ax
	andl	$15, %eax
	movw	%ax, -2(%rbp)
	movzwl	-24(%rbp), %eax
	sall	$7, %eax
	movl	%eax, %edx
	movzwl	-4(%rbp), %eax
	sall	$4, %eax
	orl	%eax, %edx
	movzwl	-2(%rbp), %eax
	orl	%edx, %eax
	movb	%al, -5(%rbp)
	movzbl	-5(%rbp), %eax
	jmp	.L8
.L9:
	movswl	-20(%rbp), %eax
	andl	$1024, %eax
	testl	%eax, %eax
	je	.L10
	movw	$5, -4(%rbp)
	movzwl	-20(%rbp), %eax
	sarw	$6, %ax
	andl	$15, %eax
	movw	%ax, -2(%rbp)
	movzwl	-24(%rbp), %eax
	sall	$7, %eax
	movl	%eax, %edx
	movzwl	-4(%rbp), %eax
	sall	$4, %eax
	orl	%eax, %edx
	movzwl	-2(%rbp), %eax
	orl	%edx, %eax
	movb	%al, -5(%rbp)
	movzbl	-5(%rbp), %eax
	jmp	.L8
.L10:
	movswl	-20(%rbp), %eax
	andl	$512, %eax
	testl	%eax, %eax
	je	.L11
	movw	$4, -4(%rbp)
	movzwl	-20(%rbp), %eax
	sarw	$5, %ax
	andl	$15, %eax
	movw	%ax, -2(%rbp)
	movzwl	-24(%rbp), %eax
	sall	$7, %eax
	movl	%eax, %edx
	movzwl	-4(%rbp), %eax
	sall	$4, %eax
	orl	%eax, %edx
	movzwl	-2(%rbp), %eax
	orl	%edx, %eax
	movb	%al, -5(%rbp)
	movzbl	-5(%rbp), %eax
	jmp	.L8
.L11:
	movswl	-20(%rbp), %eax
	andl	$256, %eax
	testl	%eax, %eax
	je	.L12
	movw	$3, -4(%rbp)
	movzwl	-20(%rbp), %eax
	sarw	$4, %ax
	andl	$15, %eax
	movw	%ax, -2(%rbp)
	movzwl	-24(%rbp), %eax
	sall	$7, %eax
	movl	%eax, %edx
	movzwl	-4(%rbp), %eax
	sall	$4, %eax
	orl	%eax, %edx
	movzwl	-2(%rbp), %eax
	orl	%edx, %eax
	movb	%al, -5(%rbp)
	movzbl	-5(%rbp), %eax
	jmp	.L8
.L12:
	movswl	-20(%rbp), %eax
	andl	$128, %eax
	testl	%eax, %eax
	je	.L13
	movw	$2, -4(%rbp)
	movzwl	-20(%rbp), %eax
	sarw	$3, %ax
	andl	$15, %eax
	movw	%ax, -2(%rbp)
	movzwl	-24(%rbp), %eax
	sall	$7, %eax
	movl	%eax, %edx
	movzwl	-4(%rbp), %eax
	sall	$4, %eax
	orl	%eax, %edx
	movzwl	-2(%rbp), %eax
	orl	%edx, %eax
	movb	%al, -5(%rbp)
	movzbl	-5(%rbp), %eax
	jmp	.L8
.L13:
	movswl	-20(%rbp), %eax
	andl	$64, %eax
	testl	%eax, %eax
	je	.L14
	movw	$1, -4(%rbp)
	movzwl	-20(%rbp), %eax
	sarw	$2, %ax
	andl	$15, %eax
	movw	%ax, -2(%rbp)
	movzwl	-24(%rbp), %eax
	sall	$7, %eax
	movl	%eax, %edx
	movzwl	-4(%rbp), %eax
	sall	$4, %eax
	orl	%eax, %edx
	movzwl	-2(%rbp), %eax
	orl	%edx, %eax
	movb	%al, -5(%rbp)
	movzbl	-5(%rbp), %eax
	jmp	.L8
.L14:
	movswl	-20(%rbp), %eax
	andl	$32, %eax
	testl	%eax, %eax
	je	.L15
	movw	$0, -4(%rbp)
	movzwl	-20(%rbp), %eax
	sarw	%ax
	andl	$15, %eax
	movw	%ax, -2(%rbp)
	movzwl	-24(%rbp), %eax
	sall	$7, %eax
	movl	%eax, %edx
	movzwl	-4(%rbp), %eax
	sall	$4, %eax
	orl	%eax, %edx
	movzwl	-2(%rbp), %eax
	orl	%edx, %eax
	movb	%al, -5(%rbp)
	movzbl	-5(%rbp), %eax
	jmp	.L8
.L15:
	movl	$0, %eax
.L8:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	codeword_compression, .-codeword_compression
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
	.string	"out.wav"
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
	subq	$176, %rsp
	movl	%edi, -164(%rbp)
	movq	%rsi, -176(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	cmpl	$2, -164(%rbp)
	je	.L17
	movq	-176(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$1, %eax
	jmp	.L25
.L17:
	movq	-176(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC1(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -128(%rbp)
	cmpq	$0, -128(%rbp)
	jne	.L19
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L19:
	leaq	.LC3(%rip), %rax
	movq	%rax, %rsi
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -120(%rbp)
	cmpq	$0, -120(%rbp)
	jne	.L20
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
	jmp	.L25
.L20:
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
	jne	.L21
	leaq	-112(%rbp), %rax
	addq	$8, %rax
	movl	$4, %edx
	leaq	.LC7(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	memcmp@PLT
	testl	%eax, %eax
	je	.L22
.L21:
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
	jmp	.L25
.L22:
	movw	$8, -30(%rbp)
	movl	-40(%rbp), %edx
	movzwl	-42(%rbp), %eax
	movzwl	%ax, %eax
	imull	%edx, %eax
	movl	%eax, -36(%rbp)
	movzwl	-42(%rbp), %eax
	movw	%ax, -32(%rbp)
	movl	-24(%rbp), %eax
	shrl	%eax
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
	movl	$0, -136(%rbp)
	movl	$0, -132(%rbp)
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
	movl	$0, -140(%rbp)
	jmp	.L23
.L24:
	movq	-128(%rbp), %rax
	movq	%rax, %rdi
	call	fgetc@PLT
	movw	%ax, -150(%rbp)
	movq	-128(%rbp), %rax
	movq	%rax, %rdi
	call	fgetc@PLT
	movw	%ax, -148(%rbp)
	movzwl	-148(%rbp), %eax
	sall	$8, %eax
	andw	$-32768, %ax
	movl	%eax, %edx
	movzwl	-148(%rbp), %eax
	sall	$6, %eax
	andw	$8128, %ax
	orl	%eax, %edx
	movzwl	-150(%rbp), %eax
	sarw	$2, %ax
	orl	%edx, %eax
	movw	%ax, -146(%rbp)
	movswl	-146(%rbp), %eax
	movl	%eax, %edi
	call	sign
	movw	%ax, -144(%rbp)
	movswl	-146(%rbp), %eax
	movl	%eax, %edi
	call	magnitude
	movw	%ax, -142(%rbp)
	movswl	-144(%rbp), %edx
	movswl	-142(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	codeword_compression
	movb	%al, -151(%rbp)
	movq	-120(%rbp), %rdx
	leaq	-151(%rbp), %rax
	movq	%rdx, %rcx
	movl	$1, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	call	fwrite@PLT
	addl	$1, -140(%rbp)
.L23:
	movl	-72(%rbp), %eax
	shrl	%eax
	movl	-140(%rbp), %edx
	cmpl	%eax, %edx
	jb	.L24
	movq	-120(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	movq	-128(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	movl	$0, %eax
.L25:
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L26
	call	__stack_chk_fail@PLT
.L26:
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
