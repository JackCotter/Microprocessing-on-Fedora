	.arch armv7-a
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
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
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	mov	r3, r0
	strh	r3, [fp, #-6]	@ movhi
	ldrsh	r3, [fp, #-6]
	cmp	r3, #0
	bge	.L2
	mov	r3, #0
	b	.L3
.L2:
	mov	r3, #1
.L3:
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	sign, .-sign
	.align	2
	.global	magnitude
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	magnitude, %function
magnitude:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	mov	r3, r0
	strh	r3, [fp, #-6]	@ movhi
	ldrsh	r3, [fp, #-6]
	cmp	r3, #0
	bge	.L5
	ldrsh	r3, [fp, #-6]
	rsb	r3, r3, #0
	b	.L6
.L5:
	ldrsh	r3, [fp, #-6]
.L6:
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	magnitude, .-magnitude
	.align	2
	.global	codeword_compression
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	codeword_compression, %function
codeword_compression:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #28
	mov	r3, r0
	mov	r2, r1
	strh	r3, [fp, #-22]	@ movhi
	mov	r3, r2	@ movhi
	strh	r3, [fp, #-24]	@ movhi
	ldrh	r3, [fp, #-22]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L8
	mov	r3, #7
	str	r3, [fp, #-8]
	ldrsh	r3, [fp, #-22]
	asr	r3, r3, #8
	sxth	r3, r3
	uxth	r3, r3
	and	r3, r3, #15
	str	r3, [fp, #-12]
	ldrsh	r3, [fp, #-24]
	lsl	r2, r3, #7
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #4
	and	r3, r3, r2
	ldr	r2, [fp, #-12]
	and	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	sxtb	r3, r3
	b	.L9
.L8:
	ldrh	r3, [fp, #-22]
	and	r3, r3, #2048
	cmp	r3, #0
	beq	.L10
	mov	r3, #6
	str	r3, [fp, #-8]
	ldrsh	r3, [fp, #-22]
	asr	r3, r3, #7
	sxth	r3, r3
	uxth	r3, r3
	and	r3, r3, #15
	str	r3, [fp, #-12]
	ldrsh	r3, [fp, #-24]
	lsl	r2, r3, #7
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #4
	and	r3, r3, r2
	ldr	r2, [fp, #-12]
	and	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	sxtb	r3, r3
	b	.L9
.L10:
	ldrh	r3, [fp, #-22]
	and	r3, r3, #512
	cmp	r3, #0
	beq	.L11
	mov	r3, #4
	str	r3, [fp, #-8]
	ldrsh	r3, [fp, #-22]
	asr	r3, r3, #5
	sxth	r3, r3
	uxth	r3, r3
	and	r3, r3, #15
	str	r3, [fp, #-12]
	ldrsh	r3, [fp, #-24]
	lsl	r2, r3, #7
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #4
	and	r3, r3, r2
	ldr	r2, [fp, #-12]
	and	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	sxtb	r3, r3
	b	.L9
.L11:
	ldrh	r3, [fp, #-22]
	and	r3, r3, #256
	cmp	r3, #0
	beq	.L12
	mov	r3, #3
	str	r3, [fp, #-8]
	ldrsh	r3, [fp, #-22]
	asr	r3, r3, #4
	sxth	r3, r3
	uxth	r3, r3
	and	r3, r3, #15
	str	r3, [fp, #-12]
	ldrsh	r3, [fp, #-24]
	lsl	r2, r3, #7
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #4
	and	r3, r3, r2
	ldr	r2, [fp, #-12]
	and	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	sxtb	r3, r3
	b	.L9
.L12:
	ldrh	r3, [fp, #-22]
	and	r3, r3, #128
	cmp	r3, #0
	beq	.L13
	mov	r3, #2
	str	r3, [fp, #-8]
	ldrsh	r3, [fp, #-22]
	asr	r3, r3, #3
	sxth	r3, r3
	uxth	r3, r3
	and	r3, r3, #15
	str	r3, [fp, #-12]
	ldrsh	r3, [fp, #-24]
	lsl	r2, r3, #7
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #4
	and	r3, r3, r2
	ldr	r2, [fp, #-12]
	and	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	sxtb	r3, r3
	b	.L9
.L13:
	ldrh	r3, [fp, #-22]
	and	r3, r3, #64
	cmp	r3, #0
	beq	.L14
	mov	r3, #1
	str	r3, [fp, #-8]
	ldrsh	r3, [fp, #-22]
	asr	r3, r3, #2
	sxth	r3, r3
	uxth	r3, r3
	and	r3, r3, #15
	str	r3, [fp, #-12]
	ldrsh	r3, [fp, #-24]
	lsl	r2, r3, #7
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #4
	and	r3, r3, r2
	ldr	r2, [fp, #-12]
	and	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	sxtb	r3, r3
	b	.L9
.L14:
	ldrh	r3, [fp, #-22]
	and	r3, r3, #32
	cmp	r3, #0
	beq	.L15
	mov	r3, #0
	str	r3, [fp, #-8]
	ldrsh	r3, [fp, #-22]
	asr	r3, r3, #1
	sxth	r3, r3
	uxth	r3, r3
	and	r3, r3, #15
	str	r3, [fp, #-12]
	ldrsh	r3, [fp, #-24]
	lsl	r2, r3, #7
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #4
	and	r3, r3, r2
	ldr	r2, [fp, #-12]
	and	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	sxtb	r3, r3
	b	.L9
.L15:
	mov	r3, #0
.L9:
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	codeword_compression, .-codeword_compression
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Usage: %s <path/to/wav/file>\000"
	.align	2
.LC1:
	.ascii	"rb\000"
	.align	2
.LC2:
	.ascii	"Failed to open file\000"
	.align	2
.LC3:
	.ascii	"wb\000"
	.align	2
.LC4:
	.ascii	"out.wav\000"
	.align	2
.LC5:
	.ascii	"Error opening output file\012\000"
	.align	2
.LC6:
	.ascii	"RIFF\000"
	.align	2
.LC7:
	.ascii	"WAVE\000"
	.align	2
.LC8:
	.ascii	"Invalid WAV file\012\000"
	.align	2
.LC9:
	.ascii	"%d\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 128
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #128
	str	r0, [fp, #-128]
	str	r1, [fp, #-132]
	ldr	r3, [fp, #-128]
	cmp	r3, #2
	beq	.L17
	ldr	r3, [fp, #-132]
	ldr	r3, [r3]
	mov	r1, r3
	movw	r0, #:lower16:.LC0
	movt	r0, #:upper16:.LC0
	bl	printf
	mov	r3, #1
	b	.L25
.L17:
	ldr	r3, [fp, #-132]
	add	r3, r3, #4
	ldr	r3, [r3]
	movw	r1, #:lower16:.LC1
	movt	r1, #:upper16:.LC1
	mov	r0, r3
	bl	fopen
	str	r0, [fp, #-12]
	ldr	r3, [fp, #-12]
	cmp	r3, #0
	bne	.L19
	movw	r0, #:lower16:.LC2
	movt	r0, #:upper16:.LC2
	bl	printf
.L19:
	movw	r1, #:lower16:.LC3
	movt	r1, #:upper16:.LC3
	movw	r0, #:lower16:.LC4
	movt	r0, #:upper16:.LC4
	bl	fopen
	str	r0, [fp, #-16]
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bne	.L20
	movw	r3, #:lower16:stderr
	movt	r3, #:upper16:stderr
	ldr	r3, [r3]
	mov	r2, #26
	mov	r1, #1
	movw	r0, #:lower16:.LC5
	movt	r0, #:upper16:.LC5
	bl	fwrite
	ldr	r0, [fp, #-12]
	bl	fclose
	mov	r3, #0
	b	.L25
.L20:
	sub	r0, fp, #80
	ldr	r3, [fp, #-12]
	mov	r2, #1
	mov	r1, #44
	bl	fread
	sub	ip, fp, #124
	sub	lr, fp, #80
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldm	lr, {r0, r1, r2}
	stm	ip, {r0, r1, r2}
	sub	r3, fp, #80
	mov	r2, #4
	movw	r1, #:lower16:.LC6
	movt	r1, #:upper16:.LC6
	mov	r0, r3
	bl	memcmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L21
	sub	r3, fp, #80
	add	r3, r3, #8
	mov	r2, #4
	movw	r1, #:lower16:.LC7
	movt	r1, #:upper16:.LC7
	mov	r0, r3
	bl	memcmp
	mov	r3, r0
	cmp	r3, #0
	beq	.L22
.L21:
	movw	r3, #:lower16:stderr
	movt	r3, #:upper16:stderr
	ldr	r3, [r3]
	mov	r2, #17
	mov	r1, #1
	movw	r0, #:lower16:.LC8
	movt	r0, #:upper16:.LC8
	bl	fwrite
	ldr	r0, [fp, #-12]
	bl	fclose
	ldr	r0, [fp, #-16]
	bl	fclose
	mov	r3, #0
	b	.L25
.L22:
	mov	r3, #8
	strh	r3, [fp, #-90]	@ movhi
	ldr	r3, [fp, #-100]
	ldrh	r2, [fp, #-102]
	mul	r3, r2, r3
	str	r3, [fp, #-96]
	ldrh	r3, [fp, #-102]
	strh	r3, [fp, #-92]	@ movhi
	ldr	r3, [fp, #-84]
	lsr	r3, r3, #1
	str	r3, [fp, #-84]
	ldr	r3, [fp, #-84]
	add	r3, r3, #36
	str	r3, [fp, #-120]
	sub	r0, fp, #124
	ldr	r3, [fp, #-16]
	mov	r2, #1
	mov	r1, #44
	bl	fwrite
	mov	r3, #0
	str	r3, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-44]
	mov	r2, r3
	mov	r1, #0
	ldr	r0, [fp, #-12]
	bl	fseek
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L23
.L24:
	ldr	r0, [fp, #-12]
	bl	fgetc
	mov	r3, r0
	strh	r3, [fp, #-26]	@ movhi
	ldr	r0, [fp, #-12]
	bl	fgetc
	mov	r3, r0
	strh	r3, [fp, #-28]	@ movhi
	ldrsh	r3, [fp, #-26]
	lsl	r3, r3, #8
	sxth	r3, r3
	bic	r3, r3, #32512
	bic	r3, r3, #255
	sxth	r2, r3
	ldrsh	r3, [fp, #-26]
	lsl	r3, r3, #6
	sxth	r3, r3
	ubfx	r3, r3, #0, #13
	sxth	r3, r3
	orr	r3, r2, r3
	sxth	r2, r3
	ldrsh	r3, [fp, #-28]
	asr	r3, r3, #2
	sxth	r3, r3
	orr	r3, r2, r3
	strh	r3, [fp, #-30]	@ movhi
	ldrsh	r3, [fp, #-30]
	mov	r0, r3
	bl	sign
	mov	r3, r0
	strh	r3, [fp, #-32]	@ movhi
	ldrsh	r3, [fp, #-30]
	mov	r0, r3
	bl	magnitude
	mov	r3, r0
	strh	r3, [fp, #-34]	@ movhi
	ldrsh	r2, [fp, #-32]
	ldrsh	r3, [fp, #-34]
	mov	r1, r2
	mov	r0, r3
	bl	codeword_compression
	mov	r3, r0
	strb	r3, [fp, #-35]
	ldrsb	r3, [fp, #-35]
	mov	r1, r3
	movw	r0, #:lower16:.LC9
	movt	r0, #:upper16:.LC9
	bl	printf
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L23:
	ldr	r2, [fp, #-40]
	ldr	r3, [fp, #-8]
	cmp	r2, r3
	bhi	.L24
	mov	r3, #0
.L25:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	main, .-main
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits
