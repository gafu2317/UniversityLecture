	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0	sdk_version 14, 4
	.globl	_assign1                        ; -- Begin function assign1
	.p2align	2
_assign1:                               ; @assign1
	.cfi_startproc
; %bb.0:
	adrp	x8, _v1@GOTPAGE
	ldr	x8, [x8, _v1@GOTPAGEOFF]
	mov	w9, #10
	str	w9, [x8]
	adrp	x10, _v2@GOTPAGE
	ldr	x10, [x10, _v2@GOTPAGEOFF]
	mov	w9, #22136
	movk	w9, #4660, lsl #16
	str	w9, [x10]
	adrp	x10, _v3@GOTPAGE
	ldr	x10, [x10, _v3@GOTPAGEOFF]
	mov	w9, #11
	str	w9, [x10]
	adrp	x10, _v4@GOTPAGE
	ldr	x10, [x10, _v4@GOTPAGEOFF]
	mov	w9, #65
	strb	w9, [x10]
	adrp	x9, _v5@GOTPAGE
	ldr	x9, [x9, _v5@GOTPAGEOFF]
	str	x8, [x9]
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w8, #0
	stur	w8, [x29, #-8]                  ; 4-byte Folded Spill
	stur	wzr, [x29, #-4]
	bl	_assign1
	adrp	x8, _v1@GOTPAGE
	ldr	x8, [x8, _v1@GOTPAGEOFF]
	ldr	w8, [x8]
                                        ; implicit-def: $x12
	mov	x12, x8
	adrp	x8, _v2@GOTPAGE
	ldr	x8, [x8, _v2@GOTPAGEOFF]
	ldr	w8, [x8]
                                        ; implicit-def: $x11
	mov	x11, x8
	adrp	x8, _v3@GOTPAGE
	ldr	x8, [x8, _v3@GOTPAGEOFF]
	ldr	w9, [x8]
                                        ; implicit-def: $x8
	mov	x8, x9
	adrp	x9, _v4@GOTPAGE
	ldr	x9, [x9, _v4@GOTPAGEOFF]
	ldrsb	w10, [x9]
	mov	x9, sp
	str	x12, [x9]
	str	x11, [x9, #8]
	str	x8, [x9, #16]
                                        ; implicit-def: $x8
	mov	x8, x10
	str	x8, [x9, #24]
	adrp	x0, l_.str@PAGE
	add	x0, x0, l_.str@PAGEOFF
	bl	_printf
	adrp	x8, _v5@GOTPAGE
	ldr	x8, [x8, _v5@GOTPAGEOFF]
	ldr	x8, [x8]
	ldr	w9, [x8]
                                        ; implicit-def: $x8
	mov	x8, x9
	mov	x9, sp
	str	x8, [x9]
	adrp	x0, l_.str.1@PAGE
	add	x0, x0, l_.str.1@PAGEOFF
	bl	_printf
	ldur	w0, [x29, #-8]                  ; 4-byte Folded Reload
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.comm	_v1,4,2                         ; @v1
	.comm	_v2,4,2                         ; @v2
	.comm	_v3,4,2                         ; @v3
	.comm	_v4,1,0                         ; @v4
	.comm	_v5,8,3                         ; @v5
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"v1:%d, v2:%d, v3:%d, v4:%c\n"

l_.str.1:                               ; @.str.1
	.asciz	"v5 points to value:%d\n"

.subsections_via_symbols
