	.arch armv7-a
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"mu-decode.c"
	.text
	.align	2
	.global	sign
	.arch armv7-a
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	sign, %function
sign:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	lsr	r0, r0, #7
	bx	lr
	.size	sign, .-sign
	.align	2
	.global	magnitude
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	magnitude, %function
magnitude:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	and	r0, r0, #127
	bx	lr
	.size	magnitude, .-magnitude
	.align	2
	.global	codeword_expansion
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	codeword_expansion, %function
codeword_expansion:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	and	r3, r0, #15
	lsl	r3, r3, #1
	and	r0, r0, #112
	lsl	r1, r1, #15
	orr	r3, r3, #33
	add	r0, r0, #2
	orr	r0, r1, r3, lsl r0
	uxth	r0, r0
	bx	lr
	.size	codeword_expansion, .-codeword_expansion
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 96
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, lr}
	cmp	r0, #2
	sub	sp, sp, #100
	mov	r3, r1
	beq	.L6
	movw	r0, #:lower16:.LC0
	ldr	r1, [r1]
	movt	r0, #:upper16:.LC0
	bl	printf
	mov	r0, #1
.L5:
	add	sp, sp, #100
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
.L6:
	movw	r1, #:lower16:.LC1
	ldr	r0, [r3, #4]
	movt	r1, #:upper16:.LC1
	bl	fopen
	subs	r5, r0, #0
	beq	.L19
.L8:
	movw	r1, #:lower16:.LC3
	movw	r0, #:lower16:.LC4
	movt	r1, #:upper16:.LC3
	movt	r0, #:upper16:.LC4
	bl	fopen
	subs	r4, r0, #0
	beq	.L20
	movw	r6, #18770
	mov	r3, r5
	mov	r2, #1
	mov	r1, #44
	add	r0, sp, #8
	bl	fread
	add	ip, sp, #8
	add	lr, sp, #52
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldm	ip, {r0, r1, r2}
	ldr	r3, [sp, #8]
	movt	r6, 17990
	cmp	r3, r6
	stm	lr, {r0, r1, r2}
	bne	.L10
	movw	r3, #16727
	ldr	r2, [sp, #16]
	movt	r3, 17750
	cmp	r2, r3
	beq	.L11
.L10:
	movw	r3, #:lower16:stderr
	movw	r0, #:lower16:.LC6
	movt	r3, #:upper16:stderr
	ldr	r3, [r3]
	mov	r2, #17
	mov	r1, #1
	movt	r0, #:upper16:.LC6
	bl	fwrite
	mov	r0, r5
	bl	fclose
	mov	r0, r4
	bl	fclose
	mov	r0, #0
	b	.L5
.L11:
	mov	ip, #16
	ldrh	r1, [sp, #74]
	ldr	r3, [sp, #76]
	ldr	r2, [sp, #92]
	mul	r3, r3, r1
	lsl	r2, r2, #1
	lsl	r3, r3, #1
	lsl	r1, r1, #1
	add	lr, r2, #36
	str	r3, [sp, #80]
	strh	r1, [sp, #84]	@ movhi
	mov	r3, r4
	str	r2, [sp, #92]
	mov	r1, #44
	mov	r2, #1
	add	r0, sp, #52
	str	lr, [sp, #56]
	strh	ip, [sp, #86]	@ movhi
	bl	fwrite
	ldr	r7, [sp, #48]
	ldr	r2, [sp, #44]
	lsr	r7, r7, #1
	mov	r1, #0
	mov	r0, r5
	bl	fseek
	cmp	r7, #0
	beq	.L12
	mov	r6, #0
.L13:
	mov	r0, r5
	bl	fgetc
	mov	r9, r0
	mov	r0, r5
	bl	fgetc
	uxtb	r3, r0
	and	r2, r3, #15
	ubfx	r8, r0, #7, #1
	lsl	r2, r2, #1
	and	r3, r3, #112
	orr	r2, r2, #33
	add	r3, r3, #2
	lsl	ip, r8, #15
	orr	ip, ip, r2, lsl r3
	mov	r2, #1
	uxtb	r1, r9
	and	lr, r1, #15
	ubfx	r9, r9, #7, #1
	lsl	lr, lr, #1
	and	r1, r1, #112
	orr	lr, lr, #33
	add	r1, r1, #2
	lsl	r9, r9, #15
	orr	r0, r9, lr, lsl r1
	mov	r3, r4
	mov	r1, #2
	strh	r0, [sp, #4]	@ movhi
	add	r0, sp, #4
	add	r6, r6, r2
	strh	ip, [sp, #6]	@ movhi
	bl	fwrite
	mov	r3, r4
	mov	r2, #1
	mov	r1, #2
	add	r0, sp, #6
	bl	fwrite
	cmp	r7, r6
	bne	.L13
.L12:
	mov	r0, r4
	bl	fclose
	mov	r0, r5
	bl	fclose
	mov	r0, #0
	b	.L5
.L20:
	movw	r3, #:lower16:stderr
	movw	r0, #:lower16:.LC5
	movt	r3, #:upper16:stderr
	ldr	r3, [r3]
	mov	r2, #26
	mov	r1, #1
	movt	r0, #:upper16:.LC5
	bl	fwrite
	mov	r0, r5
	bl	fclose
	mov	r0, r4
	b	.L5
.L19:
	movw	r0, #:lower16:.LC2
	movt	r0, #:upper16:.LC2
	bl	printf
	b	.L8
	.size	main, .-main
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Usage: %s <path/to/wav/file>\000"
	.space	3
.LC1:
	.ascii	"rb\000"
	.space	1
.LC2:
	.ascii	"Failed to open file\000"
.LC3:
	.ascii	"wb\000"
	.space	1
.LC4:
	.ascii	"decompressed_out.wav\000"
	.space	3
.LC5:
	.ascii	"Error opening output file\012\000"
	.space	1
.LC6:
	.ascii	"Invalid WAV file\012\000"
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits
