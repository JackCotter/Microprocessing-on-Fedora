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
	.file	"mu-encode.c"
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
	lsr	r0, r0, #15
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
	ubfx	r0, r0, #0, #15
	bx	lr
	.size	magnitude, .-magnitude
	.align	2
	.global	codeword_compression
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	codeword_compression, %function
codeword_compression:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	.syntax divided
@ 45 "mu-encode.c" 1
	CLZ r3, r0
@ 0 "" 2
	.arm
	.syntax unified
	sub	r2, r3, #27
	cmp	r2, #0
	sub	r3, r3, #26
	rsblt	r2, r2, #0
	cmp	r3, #0
	rsblt	r3, r3, #0
	asr	r0, r0, r2
	lsl	r3, r3, #4
	and	r3, r3, #112
	and	r0, r0, #15
	orr	r0, r0, r3
	orr	r0, r0, r1, lsl #7
	uxtb	r0, r0
	bx	lr
	.size	codeword_compression, .-codeword_compression
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	cmp	r0, #2
	sub	sp, sp, #108
	mov	r3, r1
	beq	.L6
	movw	r0, #:lower16:.LC0
	ldr	r1, [r1]
	movt	r0, #:upper16:.LC0
	bl	printf
	mov	r0, #1
.L5:
	add	sp, sp, #108
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L6:
	movw	r1, #:lower16:.LC1
	ldr	r0, [r3, #4]
	movt	r1, #:upper16:.LC1
	bl	fopen
	subs	r4, r0, #0
	beq	.L19
.L8:
	movw	r1, #:lower16:.LC3
	movw	r0, #:lower16:.LC4
	movt	r1, #:upper16:.LC3
	movt	r0, #:upper16:.LC4
	bl	fopen
	subs	r5, r0, #0
	beq	.L20
	movw	r6, #18770
	mov	r3, r4
	mov	r2, #1
	mov	r1, #44
	add	r0, sp, #16
	bl	fread
	add	ip, sp, #16
	add	lr, sp, #60
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldm	ip, {r0, r1, r2}
	ldr	r3, [sp, #16]
	movt	r6, 17990
	cmp	r3, r6
	stm	lr, {r0, r1, r2}
	bne	.L10
	movw	r3, #16727
	ldr	r2, [sp, #24]
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
	mov	r0, r4
	bl	fclose
	mov	r0, r5
	bl	fclose
	mov	r0, #0
	b	.L5
.L11:
	mov	ip, #8
	ldrh	r2, [sp, #82]
	ldr	r1, [sp, #84]
	ldr	r3, [sp, #100]
	mul	r1, r2, r1
	lsr	r3, r3, #1
	str	r3, [sp, #100]
	add	r3, r3, #36
	str	r3, [sp, #64]
	strh	r2, [sp, #92]	@ movhi
	mov	r3, r5
	mov	r2, #1
	str	r1, [sp, #88]
	add	r0, sp, #60
	mov	r1, #44
	strh	ip, [sp, #94]	@ movhi
	bl	fwrite
	ldr	r2, [sp, #52]
	mov	r1, #0
	mov	r0, r4
	bl	fseek
	ldr	r9, [sp, #56]
	lsrs	r3, r9, #2
	str	r3, [sp, #4]
	beq	.L12
	mov	r8, #65280
	mov	r7, #32768
	mov	r6, #0
	movt	r8, 255
	movt	r7, 65535
.L13:
	mov	r0, r4
	bl	fgetc
	mov	fp, r0
	mov	r0, r4
	bl	fgetc
	mov	r9, r0
	mov	r0, r4
	bl	fgetc
	mov	r10, r0
	mov	r0, r4
	bl	fgetc
	and	r2, r8, r9, lsl #8
	and	r3, r8, r0, lsl #8
	lsl	ip, r9, #6
	lsl	r0, r0, #6
	and	r1, r0, #8128
	and	r2, r2, r7
	and	ip, ip, #8128
	and	r3, r3, r7
	ubfx	fp, fp, #2, #14
	ubfx	r10, r10, #2, #14
	orr	r2, r2, ip
	orr	r3, r3, r1
	orr	r2, r2, fp
	orr	r3, r3, r10
	sxth	r2, r2
	sxth	r3, r3
	ubfx	ip, r2, #0, #14
	ubfx	r0, r3, #0, #14
	.syntax divided
@ 45 "mu-encode.c" 1
	CLZ lr, ip
@ 0 "" 2
	.arm
	.syntax unified
	sub	r1, lr, #26
	cmp	r1, #0
	sub	lr, lr, #27
	rsblt	r1, r1, #0
	cmp	lr, #0
	rsblt	lr, lr, #0
	lsl	r1, r1, #4
	and	r1, r1, #112
	asr	ip, ip, lr
	lsr	r2, r2, #31
	orr	r2, r1, r2, lsl #7
	and	ip, ip, #15
	orr	r2, ip, r2
	strb	r2, [sp, #14]
	.syntax divided
@ 45 "mu-encode.c" 1
	CLZ ip, r0
@ 0 "" 2
	.arm
	.syntax unified
	mov	r2, #1
	sub	r1, ip, #26
	cmp	r1, #0
	sub	ip, ip, #27
	rsblt	r1, r1, #0
	cmp	ip, #0
	rsblt	ip, ip, #0
	lsl	r1, r1, #4
	and	r1, r1, #112
	asr	ip, r0, ip
	lsr	r3, r3, #31
	orr	r3, r1, r3, lsl #7
	and	ip, ip, #15
	orr	ip, ip, r3
	mov	r1, r2
	mov	r3, r5
	add	r0, sp, #14
	strb	ip, [sp, #15]
	bl	fwrite
	mov	r2, #1
	mov	r3, r5
	add	r0, sp, #15
	mov	r1, r2
	add	r6, r6, r2
	bl	fwrite
	ldr	r3, [sp, #4]
	cmp	r3, r6
	bne	.L13
.L12:
	mov	r0, r5
	bl	fclose
	mov	r0, r4
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
	mov	r0, r4
	bl	fclose
	mov	r0, r5
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
	.ascii	"out.wav\000"
.LC5:
	.ascii	"Error opening output file\012\000"
	.space	1
.LC6:
	.ascii	"Invalid WAV file\012\000"
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits
