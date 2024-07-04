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
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	mov	r3, r0
	strb	r3, [fp, #-5]
	ldrsb	r3, [fp, #-5]
	cmp	r3, #0
	bge	.L2
	mov	r3, #1
	b	.L3
.L2:
	mov	r3, #0
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
	strb	r3, [fp, #-5]
	ldrb	r3, [fp, #-5]
	and	r3, r3, #127
	sxtb	r3, r3
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	magnitude, .-magnitude
	.align	2
	.global	codeword_expansion
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	codeword_expansion, %function
codeword_expansion:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	mov	r3, r0
	mov	r2, r1
	strb	r3, [fp, #-13]
	mov	r3, r2
	strb	r3, [fp, #-14]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #112
	cmp	r3, #112
	bne	.L7
	mov	r3, #4096
	strh	r3, [fp, #-6]	@ movhi
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	sxth	r3, r3
	and	r3, r3, #15
	strh	r3, [fp, #-8]	@ movhi
	ldrsb	r3, [fp, #-14]
	lsl	r3, r3, #15
	sxth	r2, r3
	ldrsh	r1, [fp, #-6]
	ldrsh	r3, [fp, #-8]
	lsl	r3, r3, #8
	orr	r3, r1, r3
	lsl	r3, r3, #2
	sxth	r3, r3
	orr	r3, r3, #512
	sxth	r3, r3
	orr	r3, r2, r3
	strh	r3, [fp, #-10]	@ movhi
	ldrsh	r3, [fp, #-10]
	b	.L8
.L7:
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #96
	cmp	r3, #96
	bne	.L9
	mov	r3, #2048
	strh	r3, [fp, #-6]	@ movhi
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	sxth	r3, r3
	and	r3, r3, #15
	strh	r3, [fp, #-8]	@ movhi
	ldrsb	r3, [fp, #-14]
	lsl	r3, r3, #15
	sxth	r2, r3
	ldrsh	r1, [fp, #-6]
	ldrsh	r3, [fp, #-8]
	lsl	r3, r3, #7
	orr	r3, r1, r3
	lsl	r3, r3, #2
	sxth	r3, r3
	orr	r3, r3, #256
	sxth	r3, r3
	orr	r3, r2, r3
	strh	r3, [fp, #-10]	@ movhi
	ldrsh	r3, [fp, #-10]
	b	.L8
.L9:
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #80
	cmp	r3, #80
	bne	.L10
	mov	r3, #1024
	strh	r3, [fp, #-6]	@ movhi
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	sxth	r3, r3
	and	r3, r3, #15
	strh	r3, [fp, #-8]	@ movhi
	ldrsb	r3, [fp, #-14]
	lsl	r3, r3, #15
	sxth	r2, r3
	ldrsh	r1, [fp, #-6]
	ldrsh	r3, [fp, #-8]
	lsl	r3, r3, #6
	orr	r3, r1, r3
	lsl	r3, r3, #2
	sxth	r3, r3
	orr	r3, r3, #128
	sxth	r3, r3
	orr	r3, r2, r3
	strh	r3, [fp, #-10]	@ movhi
	ldrsh	r3, [fp, #-10]
	b	.L8
.L10:
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #64
	cmp	r3, #0
	beq	.L11
	mov	r3, #512
	strh	r3, [fp, #-6]	@ movhi
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	sxth	r3, r3
	and	r3, r3, #15
	strh	r3, [fp, #-8]	@ movhi
	ldrsb	r3, [fp, #-14]
	lsl	r3, r3, #15
	sxth	r2, r3
	ldrsh	r1, [fp, #-6]
	ldrsh	r3, [fp, #-8]
	lsl	r3, r3, #5
	orr	r3, r1, r3
	lsl	r3, r3, #2
	sxth	r3, r3
	orr	r3, r3, #64
	sxth	r3, r3
	orr	r3, r2, r3
	strh	r3, [fp, #-10]	@ movhi
	ldrsh	r3, [fp, #-10]
	b	.L8
.L11:
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #48
	cmp	r3, #48
	bne	.L12
	mov	r3, #256
	strh	r3, [fp, #-6]	@ movhi
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	sxth	r3, r3
	and	r3, r3, #15
	strh	r3, [fp, #-8]	@ movhi
	ldrsb	r3, [fp, #-14]
	lsl	r3, r3, #15
	sxth	r2, r3
	ldrsh	r1, [fp, #-6]
	ldrsh	r3, [fp, #-8]
	lsl	r3, r3, #4
	orr	r3, r1, r3
	lsl	r3, r3, #2
	sxth	r3, r3
	orr	r3, r3, #32
	sxth	r3, r3
	orr	r3, r2, r3
	strh	r3, [fp, #-10]	@ movhi
	ldrsh	r3, [fp, #-10]
	b	.L8
.L12:
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #32
	cmp	r3, #0
	beq	.L13
	mov	r3, #128
	strh	r3, [fp, #-6]	@ movhi
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	sxth	r3, r3
	and	r3, r3, #15
	strh	r3, [fp, #-8]	@ movhi
	ldrsb	r3, [fp, #-14]
	lsl	r3, r3, #15
	sxth	r2, r3
	ldrsh	r1, [fp, #-6]
	ldrsh	r3, [fp, #-8]
	lsl	r3, r3, #3
	orr	r3, r1, r3
	lsl	r3, r3, #2
	sxth	r3, r3
	orr	r3, r3, #16
	sxth	r3, r3
	orr	r3, r2, r3
	strh	r3, [fp, #-10]	@ movhi
	ldrsh	r3, [fp, #-10]
	b	.L8
.L13:
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	and	r3, r3, #16
	cmp	r3, #0
	beq	.L14
	mov	r3, #64
	strh	r3, [fp, #-6]	@ movhi
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	sxth	r3, r3
	and	r3, r3, #15
	strh	r3, [fp, #-8]	@ movhi
	ldrsb	r3, [fp, #-14]
	lsl	r3, r3, #15
	sxth	r2, r3
	ldrsh	r1, [fp, #-6]
	ldrsh	r3, [fp, #-8]
	lsl	r3, r3, #2
	orr	r3, r1, r3
	lsl	r3, r3, #2
	sxth	r3, r3
	orr	r3, r3, #8
	sxth	r3, r3
	orr	r3, r2, r3
	strh	r3, [fp, #-10]	@ movhi
	ldrsh	r3, [fp, #-10]
	b	.L8
.L14:
	mov	r3, #0
.L8:
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	codeword_expansion, .-codeword_expansion
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
	.ascii	"decompressed_out.wav\000"
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
	@ args = 0, pretend = 0, frame = 120
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #120
	str	r0, [fp, #-120]
	str	r1, [fp, #-124]
	ldr	r3, [fp, #-120]
	cmp	r3, #2
	beq	.L16
	ldr	r3, [fp, #-124]
	ldr	r3, [r3]
	mov	r1, r3
	movw	r0, #:lower16:.LC0
	movt	r0, #:upper16:.LC0
	bl	printf
	mov	r3, #1
	b	.L24
.L16:
	ldr	r3, [fp, #-124]
	add	r3, r3, #4
	ldr	r3, [r3]
	movw	r1, #:lower16:.LC1
	movt	r1, #:upper16:.LC1
	mov	r0, r3
	bl	fopen
	str	r0, [fp, #-12]
	ldr	r3, [fp, #-12]
	cmp	r3, #0
	bne	.L18
	movw	r0, #:lower16:.LC2
	movt	r0, #:upper16:.LC2
	bl	printf
.L18:
	movw	r1, #:lower16:.LC3
	movt	r1, #:upper16:.LC3
	movw	r0, #:lower16:.LC4
	movt	r0, #:upper16:.LC4
	bl	fopen
	str	r0, [fp, #-16]
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bne	.L19
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
	b	.L24
.L19:
	sub	r0, fp, #64
	ldr	r3, [fp, #-12]
	mov	r2, #1
	mov	r1, #44
	bl	fread
	sub	ip, fp, #108
	sub	lr, fp, #64
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldm	lr, {r0, r1, r2}
	stm	ip, {r0, r1, r2}
	sub	r3, fp, #64
	mov	r2, #4
	movw	r1, #:lower16:.LC6
	movt	r1, #:upper16:.LC6
	mov	r0, r3
	bl	memcmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L20
	sub	r3, fp, #64
	add	r3, r3, #8
	mov	r2, #4
	movw	r1, #:lower16:.LC7
	movt	r1, #:upper16:.LC7
	mov	r0, r3
	bl	memcmp
	mov	r3, r0
	cmp	r3, #0
	beq	.L21
.L20:
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
	b	.L24
.L21:
	mov	r3, #16
	strh	r3, [fp, #-74]	@ movhi
	ldr	r3, [fp, #-84]
	ldrh	r2, [fp, #-86]
	mul	r3, r2, r3
	lsl	r3, r3, #1
	str	r3, [fp, #-80]
	ldrh	r3, [fp, #-86]
	lsl	r3, r3, #1
	uxth	r3, r3
	strh	r3, [fp, #-76]	@ movhi
	ldr	r3, [fp, #-68]
	lsl	r3, r3, #1
	str	r3, [fp, #-68]
	ldr	r3, [fp, #-68]
	add	r3, r3, #36
	str	r3, [fp, #-104]
	sub	r0, fp, #108
	ldr	r3, [fp, #-16]
	mov	r2, #1
	mov	r1, #44
	bl	fwrite
	ldr	r3, [fp, #-28]
	mov	r2, r3
	mov	r1, #0
	ldr	r0, [fp, #-12]
	bl	fseek
	ldr	r3, [fp, #-28]
	mov	r1, r3
	movw	r0, #:lower16:.LC9
	movt	r0, #:upper16:.LC9
	bl	printf
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L22
.L23:
	ldr	r0, [fp, #-12]
	bl	fgetc
	mov	r3, r0
	strb	r3, [fp, #-17]
	ldrsb	r3, [fp, #-17]
	mov	r0, r3
	bl	sign
	mov	r3, r0
	strb	r3, [fp, #-18]
	ldrsb	r3, [fp, #-17]
	mov	r0, r3
	bl	magnitude
	mov	r3, r0
	strb	r3, [fp, #-19]
	ldrsb	r2, [fp, #-18]
	ldrsb	r3, [fp, #-19]
	mov	r1, r2
	mov	r0, r3
	bl	codeword_expansion
	mov	r3, r0
	strh	r3, [fp, #-110]	@ movhi
	sub	r0, fp, #110
	ldr	r3, [fp, #-16]
	mov	r2, #1
	mov	r1, #2
	bl	fwrite
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L22:
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-8]
	cmp	r2, r3
	bhi	.L23
	ldr	r0, [fp, #-16]
	bl	fclose
	ldr	r0, [fp, #-12]
	bl	fclose
	mov	r3, #0
.L24:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	main, .-main
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits
