.text	



.globl	aesni_multi_cbc_encrypt
.def	aesni_multi_cbc_encrypt;	.scl 2;	.type 32;	.endef
.p2align	5
aesni_multi_cbc_encrypt:
	movq	%rdi,8(%rsp)
	movq	%rsi,16(%rsp)
	movq	%rsp,%rax
.LSEH_begin_aesni_multi_cbc_encrypt:
	movq	%rcx,%rdi
	movq	%rdx,%rsi
	movq	%r8,%rdx


	cmpl	$2,%edx
	jb	.Lenc_non_avx
	movl	OPENSSL_ia32cap_P+4(%rip),%ecx
	testl	$268435456,%ecx
	jnz	_avx_cbc_enc_shortcut
	jmp	.Lenc_non_avx
.p2align	4
.Lenc_non_avx:
	movq	%rsp,%rax

	pushq	%rbx

	pushq	%rbp

	pushq	%r12

	pushq	%r13

	pushq	%r14

	pushq	%r15

	leaq	-168(%rsp),%rsp
	movaps	%xmm6,(%rsp)
	movaps	%xmm7,16(%rsp)
	movaps	%xmm8,32(%rsp)
	movaps	%xmm9,48(%rsp)
	movaps	%xmm10,64(%rsp)
	movaps	%xmm11,80(%rsp)
	movaps	%xmm12,96(%rsp)
	movaps	%xmm13,-104(%rax)
	movaps	%xmm14,-88(%rax)
	movaps	%xmm15,-72(%rax)






	subq	$48,%rsp
	andq	$-64,%rsp
	movq	%rax,16(%rsp)


.Lenc4x_body:
	movdqu	(%rsi),%xmm12
	leaq	120(%rsi),%rsi
	leaq	80(%rdi),%rdi

.Lenc4x_loop_grande:
	movl	%edx,24(%rsp)
	xorl	%edx,%edx

	movl	-64(%rdi),%ecx
	movq	-80(%rdi),%r8
	cmpl	%edx,%ecx
	movq	-72(%rdi),%r12
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	movdqu	-56(%rdi),%xmm2
	movl	%ecx,32(%rsp)
	cmovleq	%rsp,%r8

	movl	-24(%rdi),%ecx
	movq	-40(%rdi),%r9
	cmpl	%edx,%ecx
	movq	-32(%rdi),%r13
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	movdqu	-16(%rdi),%xmm3
	movl	%ecx,36(%rsp)
	cmovleq	%rsp,%r9

	movl	16(%rdi),%ecx
	movq	0(%rdi),%r10
	cmpl	%edx,%ecx
	movq	8(%rdi),%r14
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	movdqu	24(%rdi),%xmm4
	movl	%ecx,40(%rsp)
	cmovleq	%rsp,%r10

	movl	56(%rdi),%ecx
	movq	40(%rdi),%r11
	cmpl	%edx,%ecx
	movq	48(%rdi),%r15
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	movdqu	64(%rdi),%xmm5
	movl	%ecx,44(%rsp)
	cmovleq	%rsp,%r11
	testl	%edx,%edx
	jz	.Lenc4x_done

	movups	16-120(%rsi),%xmm1
	pxor	%xmm12,%xmm2
	movups	32-120(%rsi),%xmm0
	pxor	%xmm12,%xmm3
	movl	240-120(%rsi),%eax
	pxor	%xmm12,%xmm4
	movdqu	(%r8),%xmm6
	pxor	%xmm12,%xmm5
	movdqu	(%r9),%xmm7
	pxor	%xmm6,%xmm2
	movdqu	(%r10),%xmm8
	pxor	%xmm7,%xmm3
	movdqu	(%r11),%xmm9
	pxor	%xmm8,%xmm4
	pxor	%xmm9,%xmm5
	movdqa	32(%rsp),%xmm10
	xorq	%rbx,%rbx
	jmp	.Loop_enc4x

.p2align	5
.Loop_enc4x:
	addq	$16,%rbx
	leaq	16(%rsp),%rbp
	movl	$1,%ecx
	subq	%rbx,%rbp

.byte	102,15,56,220,209
	prefetcht0	31(%r8,%rbx,1)
	prefetcht0	31(%r9,%rbx,1)
.byte	102,15,56,220,217
	prefetcht0	31(%r10,%rbx,1)
	prefetcht0	31(%r10,%rbx,1)
.byte	102,15,56,220,225
.byte	102,15,56,220,233
	movups	48-120(%rsi),%xmm1
	cmpl	32(%rsp),%ecx
.byte	102,15,56,220,208
.byte	102,15,56,220,216
.byte	102,15,56,220,224
	cmovgeq	%rbp,%r8
	cmovgq	%rbp,%r12
.byte	102,15,56,220,232
	movups	-56(%rsi),%xmm0
	cmpl	36(%rsp),%ecx
.byte	102,15,56,220,209
.byte	102,15,56,220,217
.byte	102,15,56,220,225
	cmovgeq	%rbp,%r9
	cmovgq	%rbp,%r13
.byte	102,15,56,220,233
	movups	-40(%rsi),%xmm1
	cmpl	40(%rsp),%ecx
.byte	102,15,56,220,208
.byte	102,15,56,220,216
.byte	102,15,56,220,224
	cmovgeq	%rbp,%r10
	cmovgq	%rbp,%r14
.byte	102,15,56,220,232
	movups	-24(%rsi),%xmm0
	cmpl	44(%rsp),%ecx
.byte	102,15,56,220,209
.byte	102,15,56,220,217
.byte	102,15,56,220,225
	cmovgeq	%rbp,%r11
	cmovgq	%rbp,%r15
.byte	102,15,56,220,233
	movups	-8(%rsi),%xmm1
	movdqa	%xmm10,%xmm11
.byte	102,15,56,220,208
	prefetcht0	15(%r12,%rbx,1)
	prefetcht0	15(%r13,%rbx,1)
.byte	102,15,56,220,216
	prefetcht0	15(%r14,%rbx,1)
	prefetcht0	15(%r15,%rbx,1)
.byte	102,15,56,220,224
.byte	102,15,56,220,232
	movups	128-120(%rsi),%xmm0
	pxor	%xmm12,%xmm12

.byte	102,15,56,220,209
	pcmpgtd	%xmm12,%xmm11
	movdqu	-120(%rsi),%xmm12
.byte	102,15,56,220,217
	paddd	%xmm11,%xmm10
	movdqa	%xmm10,32(%rsp)
.byte	102,15,56,220,225
.byte	102,15,56,220,233
	movups	144-120(%rsi),%xmm1

	cmpl	$11,%eax

.byte	102,15,56,220,208
.byte	102,15,56,220,216
.byte	102,15,56,220,224
.byte	102,15,56,220,232
	movups	160-120(%rsi),%xmm0

	jb	.Lenc4x_tail

.byte	102,15,56,220,209
.byte	102,15,56,220,217
.byte	102,15,56,220,225
.byte	102,15,56,220,233
	movups	176-120(%rsi),%xmm1

.byte	102,15,56,220,208
.byte	102,15,56,220,216
.byte	102,15,56,220,224
.byte	102,15,56,220,232
	movups	192-120(%rsi),%xmm0

	je	.Lenc4x_tail

.byte	102,15,56,220,209
.byte	102,15,56,220,217
.byte	102,15,56,220,225
.byte	102,15,56,220,233
	movups	208-120(%rsi),%xmm1

.byte	102,15,56,220,208
.byte	102,15,56,220,216
.byte	102,15,56,220,224
.byte	102,15,56,220,232
	movups	224-120(%rsi),%xmm0
	jmp	.Lenc4x_tail

.p2align	5
.Lenc4x_tail:
.byte	102,15,56,220,209
.byte	102,15,56,220,217
.byte	102,15,56,220,225
.byte	102,15,56,220,233
	movdqu	(%r8,%rbx,1),%xmm6
	movdqu	16-120(%rsi),%xmm1

.byte	102,15,56,221,208
	movdqu	(%r9,%rbx,1),%xmm7
	pxor	%xmm12,%xmm6
.byte	102,15,56,221,216
	movdqu	(%r10,%rbx,1),%xmm8
	pxor	%xmm12,%xmm7
.byte	102,15,56,221,224
	movdqu	(%r11,%rbx,1),%xmm9
	pxor	%xmm12,%xmm8
.byte	102,15,56,221,232
	movdqu	32-120(%rsi),%xmm0
	pxor	%xmm12,%xmm9

	movups	%xmm2,-16(%r12,%rbx,1)
	pxor	%xmm6,%xmm2
	movups	%xmm3,-16(%r13,%rbx,1)
	pxor	%xmm7,%xmm3
	movups	%xmm4,-16(%r14,%rbx,1)
	pxor	%xmm8,%xmm4
	movups	%xmm5,-16(%r15,%rbx,1)
	pxor	%xmm9,%xmm5

	decl	%edx
	jnz	.Loop_enc4x

	movq	16(%rsp),%rax

	movl	24(%rsp),%edx











	leaq	160(%rdi),%rdi
	decl	%edx
	jnz	.Lenc4x_loop_grande

.Lenc4x_done:
	movaps	-216(%rax),%xmm6
	movaps	-200(%rax),%xmm7
	movaps	-184(%rax),%xmm8
	movaps	-168(%rax),%xmm9
	movaps	-152(%rax),%xmm10
	movaps	-136(%rax),%xmm11
	movaps	-120(%rax),%xmm12



	movq	-48(%rax),%r15

	movq	-40(%rax),%r14

	movq	-32(%rax),%r13

	movq	-24(%rax),%r12

	movq	-16(%rax),%rbp

	movq	-8(%rax),%rbx

	leaq	(%rax),%rsp

.Lenc4x_epilogue:
	movq	8(%rsp),%rdi
	movq	16(%rsp),%rsi
	.byte	0xf3,0xc3

.LSEH_end_aesni_multi_cbc_encrypt:

.globl	aesni_multi_cbc_decrypt
.def	aesni_multi_cbc_decrypt;	.scl 2;	.type 32;	.endef
.p2align	5
aesni_multi_cbc_decrypt:
	movq	%rdi,8(%rsp)
	movq	%rsi,16(%rsp)
	movq	%rsp,%rax
.LSEH_begin_aesni_multi_cbc_decrypt:
	movq	%rcx,%rdi
	movq	%rdx,%rsi
	movq	%r8,%rdx


	cmpl	$2,%edx
	jb	.Ldec_non_avx
	movl	OPENSSL_ia32cap_P+4(%rip),%ecx
	testl	$268435456,%ecx
	jnz	_avx_cbc_dec_shortcut
	jmp	.Ldec_non_avx
.p2align	4
.Ldec_non_avx:
	movq	%rsp,%rax

	pushq	%rbx

	pushq	%rbp

	pushq	%r12

	pushq	%r13

	pushq	%r14

	pushq	%r15

	leaq	-168(%rsp),%rsp
	movaps	%xmm6,(%rsp)
	movaps	%xmm7,16(%rsp)
	movaps	%xmm8,32(%rsp)
	movaps	%xmm9,48(%rsp)
	movaps	%xmm10,64(%rsp)
	movaps	%xmm11,80(%rsp)
	movaps	%xmm12,96(%rsp)
	movaps	%xmm13,-104(%rax)
	movaps	%xmm14,-88(%rax)
	movaps	%xmm15,-72(%rax)






	subq	$48,%rsp
	andq	$-64,%rsp
	movq	%rax,16(%rsp)


.Ldec4x_body:
	movdqu	(%rsi),%xmm12
	leaq	120(%rsi),%rsi
	leaq	80(%rdi),%rdi

.Ldec4x_loop_grande:
	movl	%edx,24(%rsp)
	xorl	%edx,%edx

	movl	-64(%rdi),%ecx
	movq	-80(%rdi),%r8
	cmpl	%edx,%ecx
	movq	-72(%rdi),%r12
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	movdqu	-56(%rdi),%xmm6
	movl	%ecx,32(%rsp)
	cmovleq	%rsp,%r8

	movl	-24(%rdi),%ecx
	movq	-40(%rdi),%r9
	cmpl	%edx,%ecx
	movq	-32(%rdi),%r13
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	movdqu	-16(%rdi),%xmm7
	movl	%ecx,36(%rsp)
	cmovleq	%rsp,%r9

	movl	16(%rdi),%ecx
	movq	0(%rdi),%r10
	cmpl	%edx,%ecx
	movq	8(%rdi),%r14
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	movdqu	24(%rdi),%xmm8
	movl	%ecx,40(%rsp)
	cmovleq	%rsp,%r10

	movl	56(%rdi),%ecx
	movq	40(%rdi),%r11
	cmpl	%edx,%ecx
	movq	48(%rdi),%r15
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	movdqu	64(%rdi),%xmm9
	movl	%ecx,44(%rsp)
	cmovleq	%rsp,%r11
	testl	%edx,%edx
	jz	.Ldec4x_done

	movups	16-120(%rsi),%xmm1
	movups	32-120(%rsi),%xmm0
	movl	240-120(%rsi),%eax
	movdqu	(%r8),%xmm2
	movdqu	(%r9),%xmm3
	pxor	%xmm12,%xmm2
	movdqu	(%r10),%xmm4
	pxor	%xmm12,%xmm3
	movdqu	(%r11),%xmm5
	pxor	%xmm12,%xmm4
	pxor	%xmm12,%xmm5
	movdqa	32(%rsp),%xmm10
	xorq	%rbx,%rbx
	jmp	.Loop_dec4x

.p2align	5
.Loop_dec4x:
	addq	$16,%rbx
	leaq	16(%rsp),%rbp
	movl	$1,%ecx
	subq	%rbx,%rbp

.byte	102,15,56,222,209
	prefetcht0	31(%r8,%rbx,1)
	prefetcht0	31(%r9,%rbx,1)
.byte	102,15,56,222,217
	prefetcht0	31(%r10,%rbx,1)
	prefetcht0	31(%r11,%rbx,1)
.byte	102,15,56,222,225
.byte	102,15,56,222,233
	movups	48-120(%rsi),%xmm1
	cmpl	32(%rsp),%ecx
.byte	102,15,56,222,208
.byte	102,15,56,222,216
.byte	102,15,56,222,224
	cmovgeq	%rbp,%r8
	cmovgq	%rbp,%r12
.byte	102,15,56,222,232
	movups	-56(%rsi),%xmm0
	cmpl	36(%rsp),%ecx
.byte	102,15,56,222,209
.byte	102,15,56,222,217
.byte	102,15,56,222,225
	cmovgeq	%rbp,%r9
	cmovgq	%rbp,%r13
.byte	102,15,56,222,233
	movups	-40(%rsi),%xmm1
	cmpl	40(%rsp),%ecx
.byte	102,15,56,222,208
.byte	102,15,56,222,216
.byte	102,15,56,222,224
	cmovgeq	%rbp,%r10
	cmovgq	%rbp,%r14
.byte	102,15,56,222,232
	movups	-24(%rsi),%xmm0
	cmpl	44(%rsp),%ecx
.byte	102,15,56,222,209
.byte	102,15,56,222,217
.byte	102,15,56,222,225
	cmovgeq	%rbp,%r11
	cmovgq	%rbp,%r15
.byte	102,15,56,222,233
	movups	-8(%rsi),%xmm1
	movdqa	%xmm10,%xmm11
.byte	102,15,56,222,208
	prefetcht0	15(%r12,%rbx,1)
	prefetcht0	15(%r13,%rbx,1)
.byte	102,15,56,222,216
	prefetcht0	15(%r14,%rbx,1)
	prefetcht0	15(%r15,%rbx,1)
.byte	102,15,56,222,224
.byte	102,15,56,222,232
	movups	128-120(%rsi),%xmm0
	pxor	%xmm12,%xmm12

.byte	102,15,56,222,209
	pcmpgtd	%xmm12,%xmm11
	movdqu	-120(%rsi),%xmm12
.byte	102,15,56,222,217
	paddd	%xmm11,%xmm10
	movdqa	%xmm10,32(%rsp)
.byte	102,15,56,222,225
.byte	102,15,56,222,233
	movups	144-120(%rsi),%xmm1

	cmpl	$11,%eax

.byte	102,15,56,222,208
.byte	102,15,56,222,216
.byte	102,15,56,222,224
.byte	102,15,56,222,232
	movups	160-120(%rsi),%xmm0

	jb	.Ldec4x_tail

.byte	102,15,56,222,209
.byte	102,15,56,222,217
.byte	102,15,56,222,225
.byte	102,15,56,222,233
	movups	176-120(%rsi),%xmm1

.byte	102,15,56,222,208
.byte	102,15,56,222,216
.byte	102,15,56,222,224
.byte	102,15,56,222,232
	movups	192-120(%rsi),%xmm0

	je	.Ldec4x_tail

.byte	102,15,56,222,209
.byte	102,15,56,222,217
.byte	102,15,56,222,225
.byte	102,15,56,222,233
	movups	208-120(%rsi),%xmm1

.byte	102,15,56,222,208
.byte	102,15,56,222,216
.byte	102,15,56,222,224
.byte	102,15,56,222,232
	movups	224-120(%rsi),%xmm0
	jmp	.Ldec4x_tail

.p2align	5
.Ldec4x_tail:
.byte	102,15,56,222,209
.byte	102,15,56,222,217
.byte	102,15,56,222,225
	pxor	%xmm0,%xmm6
	pxor	%xmm0,%xmm7
.byte	102,15,56,222,233
	movdqu	16-120(%rsi),%xmm1
	pxor	%xmm0,%xmm8
	pxor	%xmm0,%xmm9
	movdqu	32-120(%rsi),%xmm0

.byte	102,15,56,223,214
.byte	102,15,56,223,223
	movdqu	-16(%r8,%rbx,1),%xmm6
	movdqu	-16(%r9,%rbx,1),%xmm7
.byte	102,65,15,56,223,224
.byte	102,65,15,56,223,233
	movdqu	-16(%r10,%rbx,1),%xmm8
	movdqu	-16(%r11,%rbx,1),%xmm9

	movups	%xmm2,-16(%r12,%rbx,1)
	movdqu	(%r8,%rbx,1),%xmm2
	movups	%xmm3,-16(%r13,%rbx,1)
	movdqu	(%r9,%rbx,1),%xmm3
	pxor	%xmm12,%xmm2
	movups	%xmm4,-16(%r14,%rbx,1)
	movdqu	(%r10,%rbx,1),%xmm4
	pxor	%xmm12,%xmm3
	movups	%xmm5,-16(%r15,%rbx,1)
	movdqu	(%r11,%rbx,1),%xmm5
	pxor	%xmm12,%xmm4
	pxor	%xmm12,%xmm5

	decl	%edx
	jnz	.Loop_dec4x

	movq	16(%rsp),%rax

	movl	24(%rsp),%edx

	leaq	160(%rdi),%rdi
	decl	%edx
	jnz	.Ldec4x_loop_grande

.Ldec4x_done:
	movaps	-216(%rax),%xmm6
	movaps	-200(%rax),%xmm7
	movaps	-184(%rax),%xmm8
	movaps	-168(%rax),%xmm9
	movaps	-152(%rax),%xmm10
	movaps	-136(%rax),%xmm11
	movaps	-120(%rax),%xmm12



	movq	-48(%rax),%r15

	movq	-40(%rax),%r14

	movq	-32(%rax),%r13

	movq	-24(%rax),%r12

	movq	-16(%rax),%rbp

	movq	-8(%rax),%rbx

	leaq	(%rax),%rsp

.Ldec4x_epilogue:
	movq	8(%rsp),%rdi
	movq	16(%rsp),%rsi
	.byte	0xf3,0xc3

.LSEH_end_aesni_multi_cbc_decrypt:
.def	aesni_multi_cbc_encrypt_avx;	.scl 3;	.type 32;	.endef
.p2align	5
aesni_multi_cbc_encrypt_avx:
	movq	%rdi,8(%rsp)
	movq	%rsi,16(%rsp)
	movq	%rsp,%rax
.LSEH_begin_aesni_multi_cbc_encrypt_avx:
	movq	%rcx,%rdi
	movq	%rdx,%rsi
	movq	%r8,%rdx


_avx_cbc_enc_shortcut:
	movq	%rsp,%rax

	pushq	%rbx

	pushq	%rbp

	pushq	%r12

	pushq	%r13

	pushq	%r14

	pushq	%r15

	leaq	-168(%rsp),%rsp
	movaps	%xmm6,(%rsp)
	movaps	%xmm7,16(%rsp)
	movaps	%xmm8,32(%rsp)
	movaps	%xmm9,48(%rsp)
	movaps	%xmm10,64(%rsp)
	movaps	%xmm11,80(%rsp)
	movaps	%xmm12,-120(%rax)
	movaps	%xmm13,-104(%rax)
	movaps	%xmm14,-88(%rax)
	movaps	%xmm15,-72(%rax)








	subq	$192,%rsp
	andq	$-128,%rsp
	movq	%rax,16(%rsp)


.Lenc8x_body:
	vzeroupper
	vmovdqu	(%rsi),%xmm15
	leaq	120(%rsi),%rsi
	leaq	160(%rdi),%rdi
	shrl	$1,%edx

.Lenc8x_loop_grande:

	xorl	%edx,%edx

	movl	-144(%rdi),%ecx

	movq	-160(%rdi),%r8
	cmpl	%edx,%ecx

	movq	-152(%rdi),%rbx
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	vmovdqu	-136(%rdi),%xmm2
	movl	%ecx,32(%rsp)
	cmovleq	%rsp,%r8
	subq	%r8,%rbx
	movq	%rbx,64(%rsp)

	movl	-104(%rdi),%ecx

	movq	-120(%rdi),%r9
	cmpl	%edx,%ecx

	movq	-112(%rdi),%rbp
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	vmovdqu	-96(%rdi),%xmm3
	movl	%ecx,36(%rsp)
	cmovleq	%rsp,%r9
	subq	%r9,%rbp
	movq	%rbp,72(%rsp)

	movl	-64(%rdi),%ecx

	movq	-80(%rdi),%r10
	cmpl	%edx,%ecx

	movq	-72(%rdi),%rbp
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	vmovdqu	-56(%rdi),%xmm4
	movl	%ecx,40(%rsp)
	cmovleq	%rsp,%r10
	subq	%r10,%rbp
	movq	%rbp,80(%rsp)

	movl	-24(%rdi),%ecx

	movq	-40(%rdi),%r11
	cmpl	%edx,%ecx

	movq	-32(%rdi),%rbp
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	vmovdqu	-16(%rdi),%xmm5
	movl	%ecx,44(%rsp)
	cmovleq	%rsp,%r11
	subq	%r11,%rbp
	movq	%rbp,88(%rsp)

	movl	16(%rdi),%ecx

	movq	0(%rdi),%r12
	cmpl	%edx,%ecx

	movq	8(%rdi),%rbp
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	vmovdqu	24(%rdi),%xmm6
	movl	%ecx,48(%rsp)
	cmovleq	%rsp,%r12
	subq	%r12,%rbp
	movq	%rbp,96(%rsp)

	movl	56(%rdi),%ecx

	movq	40(%rdi),%r13
	cmpl	%edx,%ecx

	movq	48(%rdi),%rbp
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	vmovdqu	64(%rdi),%xmm7
	movl	%ecx,52(%rsp)
	cmovleq	%rsp,%r13
	subq	%r13,%rbp
	movq	%rbp,104(%rsp)

	movl	96(%rdi),%ecx

	movq	80(%rdi),%r14
	cmpl	%edx,%ecx

	movq	88(%rdi),%rbp
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	vmovdqu	104(%rdi),%xmm8
	movl	%ecx,56(%rsp)
	cmovleq	%rsp,%r14
	subq	%r14,%rbp
	movq	%rbp,112(%rsp)

	movl	136(%rdi),%ecx

	movq	120(%rdi),%r15
	cmpl	%edx,%ecx

	movq	128(%rdi),%rbp
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	vmovdqu	144(%rdi),%xmm9
	movl	%ecx,60(%rsp)
	cmovleq	%rsp,%r15
	subq	%r15,%rbp
	movq	%rbp,120(%rsp)
	testl	%edx,%edx
	jz	.Lenc8x_done

	vmovups	16-120(%rsi),%xmm1
	vmovups	32-120(%rsi),%xmm0
	movl	240-120(%rsi),%eax

	vpxor	(%r8),%xmm15,%xmm10
	leaq	128(%rsp),%rbp
	vpxor	(%r9),%xmm15,%xmm11
	vpxor	(%r10),%xmm15,%xmm12
	vpxor	(%r11),%xmm15,%xmm13
	vpxor	%xmm10,%xmm2,%xmm2
	vpxor	(%r12),%xmm15,%xmm10
	vpxor	%xmm11,%xmm3,%xmm3
	vpxor	(%r13),%xmm15,%xmm11
	vpxor	%xmm12,%xmm4,%xmm4
	vpxor	(%r14),%xmm15,%xmm12
	vpxor	%xmm13,%xmm5,%xmm5
	vpxor	(%r15),%xmm15,%xmm13
	vpxor	%xmm10,%xmm6,%xmm6
	movl	$1,%ecx
	vpxor	%xmm11,%xmm7,%xmm7
	vpxor	%xmm12,%xmm8,%xmm8
	vpxor	%xmm13,%xmm9,%xmm9
	jmp	.Loop_enc8x

.p2align	5
.Loop_enc8x:
	vaesenc	%xmm1,%xmm2,%xmm2
	cmpl	32+0(%rsp),%ecx
	vaesenc	%xmm1,%xmm3,%xmm3
	prefetcht0	31(%r8)
	vaesenc	%xmm1,%xmm4,%xmm4
	vaesenc	%xmm1,%xmm5,%xmm5
	leaq	(%r8,%rbx,1),%rbx
	cmovgeq	%rsp,%r8
	vaesenc	%xmm1,%xmm6,%xmm6
	cmovgq	%rsp,%rbx
	vaesenc	%xmm1,%xmm7,%xmm7
	subq	%r8,%rbx
	vaesenc	%xmm1,%xmm8,%xmm8
	vpxor	16(%r8),%xmm15,%xmm10
	movq	%rbx,64+0(%rsp)
	vaesenc	%xmm1,%xmm9,%xmm9
	vmovups	-72(%rsi),%xmm1
	leaq	16(%r8,%rbx,1),%r8
	vmovdqu	%xmm10,0(%rbp)
	vaesenc	%xmm0,%xmm2,%xmm2
	cmpl	32+4(%rsp),%ecx
	movq	64+8(%rsp),%rbx
	vaesenc	%xmm0,%xmm3,%xmm3
	prefetcht0	31(%r9)
	vaesenc	%xmm0,%xmm4,%xmm4
	vaesenc	%xmm0,%xmm5,%xmm5
	leaq	(%r9,%rbx,1),%rbx
	cmovgeq	%rsp,%r9
	vaesenc	%xmm0,%xmm6,%xmm6
	cmovgq	%rsp,%rbx
	vaesenc	%xmm0,%xmm7,%xmm7
	subq	%r9,%rbx
	vaesenc	%xmm0,%xmm8,%xmm8
	vpxor	16(%r9),%xmm15,%xmm11
	movq	%rbx,64+8(%rsp)
	vaesenc	%xmm0,%xmm9,%xmm9
	vmovups	-56(%rsi),%xmm0
	leaq	16(%r9,%rbx,1),%r9
	vmovdqu	%xmm11,16(%rbp)
	vaesenc	%xmm1,%xmm2,%xmm2
	cmpl	32+8(%rsp),%ecx
	movq	64+16(%rsp),%rbx
	vaesenc	%xmm1,%xmm3,%xmm3
	prefetcht0	31(%r10)
	vaesenc	%xmm1,%xmm4,%xmm4
	prefetcht0	15(%r8)
	vaesenc	%xmm1,%xmm5,%xmm5
	leaq	(%r10,%rbx,1),%rbx
	cmovgeq	%rsp,%r10
	vaesenc	%xmm1,%xmm6,%xmm6
	cmovgq	%rsp,%rbx
	vaesenc	%xmm1,%xmm7,%xmm7
	subq	%r10,%rbx
	vaesenc	%xmm1,%xmm8,%xmm8
	vpxor	16(%r10),%xmm15,%xmm12
	movq	%rbx,64+16(%rsp)
	vaesenc	%xmm1,%xmm9,%xmm9
	vmovups	-40(%rsi),%xmm1
	leaq	16(%r10,%rbx,1),%r10
	vmovdqu	%xmm12,32(%rbp)
	vaesenc	%xmm0,%xmm2,%xmm2
	cmpl	32+12(%rsp),%ecx
	movq	64+24(%rsp),%rbx
	vaesenc	%xmm0,%xmm3,%xmm3
	prefetcht0	31(%r11)
	vaesenc	%xmm0,%xmm4,%xmm4
	prefetcht0	15(%r9)
	vaesenc	%xmm0,%xmm5,%xmm5
	leaq	(%r11,%rbx,1),%rbx
	cmovgeq	%rsp,%r11
	vaesenc	%xmm0,%xmm6,%xmm6
	cmovgq	%rsp,%rbx
	vaesenc	%xmm0,%xmm7,%xmm7
	subq	%r11,%rbx
	vaesenc	%xmm0,%xmm8,%xmm8
	vpxor	16(%r11),%xmm15,%xmm13
	movq	%rbx,64+24(%rsp)
	vaesenc	%xmm0,%xmm9,%xmm9
	vmovups	-24(%rsi),%xmm0
	leaq	16(%r11,%rbx,1),%r11
	vmovdqu	%xmm13,48(%rbp)
	vaesenc	%xmm1,%xmm2,%xmm2
	cmpl	32+16(%rsp),%ecx
	movq	64+32(%rsp),%rbx
	vaesenc	%xmm1,%xmm3,%xmm3
	prefetcht0	31(%r12)
	vaesenc	%xmm1,%xmm4,%xmm4
	prefetcht0	15(%r10)
	vaesenc	%xmm1,%xmm5,%xmm5
	leaq	(%r12,%rbx,1),%rbx
	cmovgeq	%rsp,%r12
	vaesenc	%xmm1,%xmm6,%xmm6
	cmovgq	%rsp,%rbx
	vaesenc	%xmm1,%xmm7,%xmm7
	subq	%r12,%rbx
	vaesenc	%xmm1,%xmm8,%xmm8
	vpxor	16(%r12),%xmm15,%xmm10
	movq	%rbx,64+32(%rsp)
	vaesenc	%xmm1,%xmm9,%xmm9
	vmovups	-8(%rsi),%xmm1
	leaq	16(%r12,%rbx,1),%r12
	vaesenc	%xmm0,%xmm2,%xmm2
	cmpl	32+20(%rsp),%ecx
	movq	64+40(%rsp),%rbx
	vaesenc	%xmm0,%xmm3,%xmm3
	prefetcht0	31(%r13)
	vaesenc	%xmm0,%xmm4,%xmm4
	prefetcht0	15(%r11)
	vaesenc	%xmm0,%xmm5,%xmm5
	leaq	(%rbx,%r13,1),%rbx
	cmovgeq	%rsp,%r13
	vaesenc	%xmm0,%xmm6,%xmm6
	cmovgq	%rsp,%rbx
	vaesenc	%xmm0,%xmm7,%xmm7
	subq	%r13,%rbx
	vaesenc	%xmm0,%xmm8,%xmm8
	vpxor	16(%r13),%xmm15,%xmm11
	movq	%rbx,64+40(%rsp)
	vaesenc	%xmm0,%xmm9,%xmm9
	vmovups	8(%rsi),%xmm0
	leaq	16(%r13,%rbx,1),%r13
	vaesenc	%xmm1,%xmm2,%xmm2
	cmpl	32+24(%rsp),%ecx
	movq	64+48(%rsp),%rbx
	vaesenc	%xmm1,%xmm3,%xmm3
	prefetcht0	31(%r14)
	vaesenc	%xmm1,%xmm4,%xmm4
	prefetcht0	15(%r12)
	vaesenc	%xmm1,%xmm5,%xmm5
	leaq	(%r14,%rbx,1),%rbx
	cmovgeq	%rsp,%r14
	vaesenc	%xmm1,%xmm6,%xmm6
	cmovgq	%rsp,%rbx
	vaesenc	%xmm1,%xmm7,%xmm7
	subq	%r14,%rbx
	vaesenc	%xmm1,%xmm8,%xmm8
	vpxor	16(%r14),%xmm15,%xmm12
	movq	%rbx,64+48(%rsp)
	vaesenc	%xmm1,%xmm9,%xmm9
	vmovups	24(%rsi),%xmm1
	leaq	16(%r14,%rbx,1),%r14
	vaesenc	%xmm0,%xmm2,%xmm2
	cmpl	32+28(%rsp),%ecx
	movq	64+56(%rsp),%rbx
	vaesenc	%xmm0,%xmm3,%xmm3
	prefetcht0	31(%r15)
	vaesenc	%xmm0,%xmm4,%xmm4
	prefetcht0	15(%r13)
	vaesenc	%xmm0,%xmm5,%xmm5
	leaq	(%r15,%rbx,1),%rbx
	cmovgeq	%rsp,%r15
	vaesenc	%xmm0,%xmm6,%xmm6
	cmovgq	%rsp,%rbx
	vaesenc	%xmm0,%xmm7,%xmm7
	subq	%r15,%rbx
	vaesenc	%xmm0,%xmm8,%xmm8
	vpxor	16(%r15),%xmm15,%xmm13
	movq	%rbx,64+56(%rsp)
	vaesenc	%xmm0,%xmm9,%xmm9
	vmovups	40(%rsi),%xmm0
	leaq	16(%r15,%rbx,1),%r15
	vmovdqu	32(%rsp),%xmm14
	prefetcht0	15(%r14)
	prefetcht0	15(%r15)
	cmpl	$11,%eax
	jb	.Lenc8x_tail

	vaesenc	%xmm1,%xmm2,%xmm2
	vaesenc	%xmm1,%xmm3,%xmm3
	vaesenc	%xmm1,%xmm4,%xmm4
	vaesenc	%xmm1,%xmm5,%xmm5
	vaesenc	%xmm1,%xmm6,%xmm6
	vaesenc	%xmm1,%xmm7,%xmm7
	vaesenc	%xmm1,%xmm8,%xmm8
	vaesenc	%xmm1,%xmm9,%xmm9
	vmovups	176-120(%rsi),%xmm1

	vaesenc	%xmm0,%xmm2,%xmm2
	vaesenc	%xmm0,%xmm3,%xmm3
	vaesenc	%xmm0,%xmm4,%xmm4
	vaesenc	%xmm0,%xmm5,%xmm5
	vaesenc	%xmm0,%xmm6,%xmm6
	vaesenc	%xmm0,%xmm7,%xmm7
	vaesenc	%xmm0,%xmm8,%xmm8
	vaesenc	%xmm0,%xmm9,%xmm9
	vmovups	192-120(%rsi),%xmm0
	je	.Lenc8x_tail

	vaesenc	%xmm1,%xmm2,%xmm2
	vaesenc	%xmm1,%xmm3,%xmm3
	vaesenc	%xmm1,%xmm4,%xmm4
	vaesenc	%xmm1,%xmm5,%xmm5
	vaesenc	%xmm1,%xmm6,%xmm6
	vaesenc	%xmm1,%xmm7,%xmm7
	vaesenc	%xmm1,%xmm8,%xmm8
	vaesenc	%xmm1,%xmm9,%xmm9
	vmovups	208-120(%rsi),%xmm1

	vaesenc	%xmm0,%xmm2,%xmm2
	vaesenc	%xmm0,%xmm3,%xmm3
	vaesenc	%xmm0,%xmm4,%xmm4
	vaesenc	%xmm0,%xmm5,%xmm5
	vaesenc	%xmm0,%xmm6,%xmm6
	vaesenc	%xmm0,%xmm7,%xmm7
	vaesenc	%xmm0,%xmm8,%xmm8
	vaesenc	%xmm0,%xmm9,%xmm9
	vmovups	224-120(%rsi),%xmm0

.Lenc8x_tail:
	vaesenc	%xmm1,%xmm2,%xmm2
	vpxor	%xmm15,%xmm15,%xmm15
	vaesenc	%xmm1,%xmm3,%xmm3
	vaesenc	%xmm1,%xmm4,%xmm4
	vpcmpgtd	%xmm15,%xmm14,%xmm15
	vaesenc	%xmm1,%xmm5,%xmm5
	vaesenc	%xmm1,%xmm6,%xmm6
	vpaddd	%xmm14,%xmm15,%xmm15
	vmovdqu	48(%rsp),%xmm14
	vaesenc	%xmm1,%xmm7,%xmm7
	movq	64(%rsp),%rbx
	vaesenc	%xmm1,%xmm8,%xmm8
	vaesenc	%xmm1,%xmm9,%xmm9
	vmovups	16-120(%rsi),%xmm1

	vaesenclast	%xmm0,%xmm2,%xmm2
	vmovdqa	%xmm15,32(%rsp)
	vpxor	%xmm15,%xmm15,%xmm15
	vaesenclast	%xmm0,%xmm3,%xmm3
	vaesenclast	%xmm0,%xmm4,%xmm4
	vpcmpgtd	%xmm15,%xmm14,%xmm15
	vaesenclast	%xmm0,%xmm5,%xmm5
	vaesenclast	%xmm0,%xmm6,%xmm6
	vpaddd	%xmm15,%xmm14,%xmm14
	vmovdqu	-120(%rsi),%xmm15
	vaesenclast	%xmm0,%xmm7,%xmm7
	vaesenclast	%xmm0,%xmm8,%xmm8
	vmovdqa	%xmm14,48(%rsp)
	vaesenclast	%xmm0,%xmm9,%xmm9
	vmovups	32-120(%rsi),%xmm0

	vmovups	%xmm2,-16(%r8)
	subq	%rbx,%r8
	vpxor	0(%rbp),%xmm2,%xmm2
	vmovups	%xmm3,-16(%r9)
	subq	72(%rsp),%r9
	vpxor	16(%rbp),%xmm3,%xmm3
	vmovups	%xmm4,-16(%r10)
	subq	80(%rsp),%r10
	vpxor	32(%rbp),%xmm4,%xmm4
	vmovups	%xmm5,-16(%r11)
	subq	88(%rsp),%r11
	vpxor	48(%rbp),%xmm5,%xmm5
	vmovups	%xmm6,-16(%r12)
	subq	96(%rsp),%r12
	vpxor	%xmm10,%xmm6,%xmm6
	vmovups	%xmm7,-16(%r13)
	subq	104(%rsp),%r13
	vpxor	%xmm11,%xmm7,%xmm7
	vmovups	%xmm8,-16(%r14)
	subq	112(%rsp),%r14
	vpxor	%xmm12,%xmm8,%xmm8
	vmovups	%xmm9,-16(%r15)
	subq	120(%rsp),%r15
	vpxor	%xmm13,%xmm9,%xmm9

	decl	%edx
	jnz	.Loop_enc8x

	movq	16(%rsp),%rax






.Lenc8x_done:
	vzeroupper
	movaps	-216(%rax),%xmm6
	movaps	-200(%rax),%xmm7
	movaps	-184(%rax),%xmm8
	movaps	-168(%rax),%xmm9
	movaps	-152(%rax),%xmm10
	movaps	-136(%rax),%xmm11
	movaps	-120(%rax),%xmm12
	movaps	-104(%rax),%xmm13
	movaps	-88(%rax),%xmm14
	movaps	-72(%rax),%xmm15
	movq	-48(%rax),%r15

	movq	-40(%rax),%r14

	movq	-32(%rax),%r13

	movq	-24(%rax),%r12

	movq	-16(%rax),%rbp

	movq	-8(%rax),%rbx

	leaq	(%rax),%rsp

.Lenc8x_epilogue:
	movq	8(%rsp),%rdi
	movq	16(%rsp),%rsi
	.byte	0xf3,0xc3

.LSEH_end_aesni_multi_cbc_encrypt_avx:

.def	aesni_multi_cbc_decrypt_avx;	.scl 3;	.type 32;	.endef
.p2align	5
aesni_multi_cbc_decrypt_avx:
	movq	%rdi,8(%rsp)
	movq	%rsi,16(%rsp)
	movq	%rsp,%rax
.LSEH_begin_aesni_multi_cbc_decrypt_avx:
	movq	%rcx,%rdi
	movq	%rdx,%rsi
	movq	%r8,%rdx


_avx_cbc_dec_shortcut:
	movq	%rsp,%rax

	pushq	%rbx

	pushq	%rbp

	pushq	%r12

	pushq	%r13

	pushq	%r14

	pushq	%r15

	leaq	-168(%rsp),%rsp
	movaps	%xmm6,(%rsp)
	movaps	%xmm7,16(%rsp)
	movaps	%xmm8,32(%rsp)
	movaps	%xmm9,48(%rsp)
	movaps	%xmm10,64(%rsp)
	movaps	%xmm11,80(%rsp)
	movaps	%xmm12,-120(%rax)
	movaps	%xmm13,-104(%rax)
	movaps	%xmm14,-88(%rax)
	movaps	%xmm15,-72(%rax)









	subq	$256,%rsp
	andq	$-256,%rsp
	subq	$192,%rsp
	movq	%rax,16(%rsp)


.Ldec8x_body:
	vzeroupper
	vmovdqu	(%rsi),%xmm15
	leaq	120(%rsi),%rsi
	leaq	160(%rdi),%rdi
	shrl	$1,%edx

.Ldec8x_loop_grande:

	xorl	%edx,%edx

	movl	-144(%rdi),%ecx

	movq	-160(%rdi),%r8
	cmpl	%edx,%ecx

	movq	-152(%rdi),%rbx
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	vmovdqu	-136(%rdi),%xmm2
	movl	%ecx,32(%rsp)
	cmovleq	%rsp,%r8
	subq	%r8,%rbx
	movq	%rbx,64(%rsp)
	vmovdqu	%xmm2,192(%rsp)

	movl	-104(%rdi),%ecx

	movq	-120(%rdi),%r9
	cmpl	%edx,%ecx

	movq	-112(%rdi),%rbp
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	vmovdqu	-96(%rdi),%xmm3
	movl	%ecx,36(%rsp)
	cmovleq	%rsp,%r9
	subq	%r9,%rbp
	movq	%rbp,72(%rsp)
	vmovdqu	%xmm3,208(%rsp)

	movl	-64(%rdi),%ecx

	movq	-80(%rdi),%r10
	cmpl	%edx,%ecx

	movq	-72(%rdi),%rbp
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	vmovdqu	-56(%rdi),%xmm4
	movl	%ecx,40(%rsp)
	cmovleq	%rsp,%r10
	subq	%r10,%rbp
	movq	%rbp,80(%rsp)
	vmovdqu	%xmm4,224(%rsp)

	movl	-24(%rdi),%ecx

	movq	-40(%rdi),%r11
	cmpl	%edx,%ecx

	movq	-32(%rdi),%rbp
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	vmovdqu	-16(%rdi),%xmm5
	movl	%ecx,44(%rsp)
	cmovleq	%rsp,%r11
	subq	%r11,%rbp
	movq	%rbp,88(%rsp)
	vmovdqu	%xmm5,240(%rsp)

	movl	16(%rdi),%ecx

	movq	0(%rdi),%r12
	cmpl	%edx,%ecx

	movq	8(%rdi),%rbp
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	vmovdqu	24(%rdi),%xmm6
	movl	%ecx,48(%rsp)
	cmovleq	%rsp,%r12
	subq	%r12,%rbp
	movq	%rbp,96(%rsp)
	vmovdqu	%xmm6,256(%rsp)

	movl	56(%rdi),%ecx

	movq	40(%rdi),%r13
	cmpl	%edx,%ecx

	movq	48(%rdi),%rbp
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	vmovdqu	64(%rdi),%xmm7
	movl	%ecx,52(%rsp)
	cmovleq	%rsp,%r13
	subq	%r13,%rbp
	movq	%rbp,104(%rsp)
	vmovdqu	%xmm7,272(%rsp)

	movl	96(%rdi),%ecx

	movq	80(%rdi),%r14
	cmpl	%edx,%ecx

	movq	88(%rdi),%rbp
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	vmovdqu	104(%rdi),%xmm8
	movl	%ecx,56(%rsp)
	cmovleq	%rsp,%r14
	subq	%r14,%rbp
	movq	%rbp,112(%rsp)
	vmovdqu	%xmm8,288(%rsp)

	movl	136(%rdi),%ecx

	movq	120(%rdi),%r15
	cmpl	%edx,%ecx

	movq	128(%rdi),%rbp
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx

	vmovdqu	144(%rdi),%xmm9
	movl	%ecx,60(%rsp)
	cmovleq	%rsp,%r15
	subq	%r15,%rbp
	movq	%rbp,120(%rsp)
	vmovdqu	%xmm9,304(%rsp)
	testl	%edx,%edx
	jz	.Ldec8x_done

	vmovups	16-120(%rsi),%xmm1
	vmovups	32-120(%rsi),%xmm0
	movl	240-120(%rsi),%eax
	leaq	192+128(%rsp),%rbp

	vmovdqu	(%r8),%xmm2
	vmovdqu	(%r9),%xmm3
	vmovdqu	(%r10),%xmm4
	vmovdqu	(%r11),%xmm5
	vmovdqu	(%r12),%xmm6
	vmovdqu	(%r13),%xmm7
	vmovdqu	(%r14),%xmm8
	vmovdqu	(%r15),%xmm9
	vmovdqu	%xmm2,0(%rbp)
	vpxor	%xmm15,%xmm2,%xmm2
	vmovdqu	%xmm3,16(%rbp)
	vpxor	%xmm15,%xmm3,%xmm3
	vmovdqu	%xmm4,32(%rbp)
	vpxor	%xmm15,%xmm4,%xmm4
	vmovdqu	%xmm5,48(%rbp)
	vpxor	%xmm15,%xmm5,%xmm5
	vmovdqu	%xmm6,64(%rbp)
	vpxor	%xmm15,%xmm6,%xmm6
	vmovdqu	%xmm7,80(%rbp)
	vpxor	%xmm15,%xmm7,%xmm7
	vmovdqu	%xmm8,96(%rbp)
	vpxor	%xmm15,%xmm8,%xmm8
	vmovdqu	%xmm9,112(%rbp)
	vpxor	%xmm15,%xmm9,%xmm9
	xorq	$0x80,%rbp
	movl	$1,%ecx
	jmp	.Loop_dec8x

.p2align	5
.Loop_dec8x:
	vaesdec	%xmm1,%xmm2,%xmm2
	cmpl	32+0(%rsp),%ecx
	vaesdec	%xmm1,%xmm3,%xmm3
	prefetcht0	31(%r8)
	vaesdec	%xmm1,%xmm4,%xmm4
	vaesdec	%xmm1,%xmm5,%xmm5
	leaq	(%r8,%rbx,1),%rbx
	cmovgeq	%rsp,%r8
	vaesdec	%xmm1,%xmm6,%xmm6
	cmovgq	%rsp,%rbx
	vaesdec	%xmm1,%xmm7,%xmm7
	subq	%r8,%rbx
	vaesdec	%xmm1,%xmm8,%xmm8
	vmovdqu	16(%r8),%xmm10
	movq	%rbx,64+0(%rsp)
	vaesdec	%xmm1,%xmm9,%xmm9
	vmovups	-72(%rsi),%xmm1
	leaq	16(%r8,%rbx,1),%r8
	vmovdqu	%xmm10,128(%rsp)
	vaesdec	%xmm0,%xmm2,%xmm2
	cmpl	32+4(%rsp),%ecx
	movq	64+8(%rsp),%rbx
	vaesdec	%xmm0,%xmm3,%xmm3
	prefetcht0	31(%r9)
	vaesdec	%xmm0,%xmm4,%xmm4
	vaesdec	%xmm0,%xmm5,%xmm5
	leaq	(%r9,%rbx,1),%rbx
	cmovgeq	%rsp,%r9
	vaesdec	%xmm0,%xmm6,%xmm6
	cmovgq	%rsp,%rbx
	vaesdec	%xmm0,%xmm7,%xmm7
	subq	%r9,%rbx
	vaesdec	%xmm0,%xmm8,%xmm8
	vmovdqu	16(%r9),%xmm11
	movq	%rbx,64+8(%rsp)
	vaesdec	%xmm0,%xmm9,%xmm9
	vmovups	-56(%rsi),%xmm0
	leaq	16(%r9,%rbx,1),%r9
	vmovdqu	%xmm11,144(%rsp)
	vaesdec	%xmm1,%xmm2,%xmm2
	cmpl	32+8(%rsp),%ecx
	movq	64+16(%rsp),%rbx
	vaesdec	%xmm1,%xmm3,%xmm3
	prefetcht0	31(%r10)
	vaesdec	%xmm1,%xmm4,%xmm4
	prefetcht0	15(%r8)
	vaesdec	%xmm1,%xmm5,%xmm5
	leaq	(%r10,%rbx,1),%rbx
	cmovgeq	%rsp,%r10
	vaesdec	%xmm1,%xmm6,%xmm6
	cmovgq	%rsp,%rbx
	vaesdec	%xmm1,%xmm7,%xmm7
	subq	%r10,%rbx
	vaesdec	%xmm1,%xmm8,%xmm8
	vmovdqu	16(%r10),%xmm12
	movq	%rbx,64+16(%rsp)
	vaesdec	%xmm1,%xmm9,%xmm9
	vmovups	-40(%rsi),%xmm1
	leaq	16(%r10,%rbx,1),%r10
	vmovdqu	%xmm12,160(%rsp)
	vaesdec	%xmm0,%xmm2,%xmm2
	cmpl	32+12(%rsp),%ecx
	movq	64+24(%rsp),%rbx
	vaesdec	%xmm0,%xmm3,%xmm3
	prefetcht0	31(%r11)
	vaesdec	%xmm0,%xmm4,%xmm4
	prefetcht0	15(%r9)
	vaesdec	%xmm0,%xmm5,%xmm5
	leaq	(%r11,%rbx,1),%rbx
	cmovgeq	%rsp,%r11
	vaesdec	%xmm0,%xmm6,%xmm6
	cmovgq	%rsp,%rbx
	vaesdec	%xmm0,%xmm7,%xmm7
	subq	%r11,%rbx
	vaesdec	%xmm0,%xmm8,%xmm8
	vmovdqu	16(%r11),%xmm13
	movq	%rbx,64+24(%rsp)
	vaesdec	%xmm0,%xmm9,%xmm9
	vmovups	-24(%rsi),%xmm0
	leaq	16(%r11,%rbx,1),%r11
	vmovdqu	%xmm13,176(%rsp)
	vaesdec	%xmm1,%xmm2,%xmm2
	cmpl	32+16(%rsp),%ecx
	movq	64+32(%rsp),%rbx
	vaesdec	%xmm1,%xmm3,%xmm3
	prefetcht0	31(%r12)
	vaesdec	%xmm1,%xmm4,%xmm4
	prefetcht0	15(%r10)
	vaesdec	%xmm1,%xmm5,%xmm5
	leaq	(%r12,%rbx,1),%rbx
	cmovgeq	%rsp,%r12
	vaesdec	%xmm1,%xmm6,%xmm6
	cmovgq	%rsp,%rbx
	vaesdec	%xmm1,%xmm7,%xmm7
	subq	%r12,%rbx
	vaesdec	%xmm1,%xmm8,%xmm8
	vmovdqu	16(%r12),%xmm10
	movq	%rbx,64+32(%rsp)
	vaesdec	%xmm1,%xmm9,%xmm9
	vmovups	-8(%rsi),%xmm1
	leaq	16(%r12,%rbx,1),%r12
	vaesdec	%xmm0,%xmm2,%xmm2
	cmpl	32+20(%rsp),%ecx
	movq	64+40(%rsp),%rbx
	vaesdec	%xmm0,%xmm3,%xmm3
	prefetcht0	31(%r13)
	vaesdec	%xmm0,%xmm4,%xmm4
	prefetcht0	15(%r11)
	vaesdec	%xmm0,%xmm5,%xmm5
	leaq	(%rbx,%r13,1),%rbx
	cmovgeq	%rsp,%r13
	vaesdec	%xmm0,%xmm6,%xmm6
	cmovgq	%rsp,%rbx
	vaesdec	%xmm0,%xmm7,%xmm7
	subq	%r13,%rbx
	vaesdec	%xmm0,%xmm8,%xmm8
	vmovdqu	16(%r13),%xmm11
	movq	%rbx,64+40(%rsp)
	vaesdec	%xmm0,%xmm9,%xmm9
	vmovups	8(%rsi),%xmm0
	leaq	16(%r13,%rbx,1),%r13
	vaesdec	%xmm1,%xmm2,%xmm2
	cmpl	32+24(%rsp),%ecx
	movq	64+48(%rsp),%rbx
	vaesdec	%xmm1,%xmm3,%xmm3
	prefetcht0	31(%r14)
	vaesdec	%xmm1,%xmm4,%xmm4
	prefetcht0	15(%r12)
	vaesdec	%xmm1,%xmm5,%xmm5
	leaq	(%r14,%rbx,1),%rbx
	cmovgeq	%rsp,%r14
	vaesdec	%xmm1,%xmm6,%xmm6
	cmovgq	%rsp,%rbx
	vaesdec	%xmm1,%xmm7,%xmm7
	subq	%r14,%rbx
	vaesdec	%xmm1,%xmm8,%xmm8
	vmovdqu	16(%r14),%xmm12
	movq	%rbx,64+48(%rsp)
	vaesdec	%xmm1,%xmm9,%xmm9
	vmovups	24(%rsi),%xmm1
	leaq	16(%r14,%rbx,1),%r14
	vaesdec	%xmm0,%xmm2,%xmm2
	cmpl	32+28(%rsp),%ecx
	movq	64+56(%rsp),%rbx
	vaesdec	%xmm0,%xmm3,%xmm3
	prefetcht0	31(%r15)
	vaesdec	%xmm0,%xmm4,%xmm4
	prefetcht0	15(%r13)
	vaesdec	%xmm0,%xmm5,%xmm5
	leaq	(%r15,%rbx,1),%rbx
	cmovgeq	%rsp,%r15
	vaesdec	%xmm0,%xmm6,%xmm6
	cmovgq	%rsp,%rbx
	vaesdec	%xmm0,%xmm7,%xmm7
	subq	%r15,%rbx
	vaesdec	%xmm0,%xmm8,%xmm8
	vmovdqu	16(%r15),%xmm13
	movq	%rbx,64+56(%rsp)
	vaesdec	%xmm0,%xmm9,%xmm9
	vmovups	40(%rsi),%xmm0
	leaq	16(%r15,%rbx,1),%r15
	vmovdqu	32(%rsp),%xmm14
	prefetcht0	15(%r14)
	prefetcht0	15(%r15)
	cmpl	$11,%eax
	jb	.Ldec8x_tail

	vaesdec	%xmm1,%xmm2,%xmm2
	vaesdec	%xmm1,%xmm3,%xmm3
	vaesdec	%xmm1,%xmm4,%xmm4
	vaesdec	%xmm1,%xmm5,%xmm5
	vaesdec	%xmm1,%xmm6,%xmm6
	vaesdec	%xmm1,%xmm7,%xmm7
	vaesdec	%xmm1,%xmm8,%xmm8
	vaesdec	%xmm1,%xmm9,%xmm9
	vmovups	176-120(%rsi),%xmm1

	vaesdec	%xmm0,%xmm2,%xmm2
	vaesdec	%xmm0,%xmm3,%xmm3
	vaesdec	%xmm0,%xmm4,%xmm4
	vaesdec	%xmm0,%xmm5,%xmm5
	vaesdec	%xmm0,%xmm6,%xmm6
	vaesdec	%xmm0,%xmm7,%xmm7
	vaesdec	%xmm0,%xmm8,%xmm8
	vaesdec	%xmm0,%xmm9,%xmm9
	vmovups	192-120(%rsi),%xmm0
	je	.Ldec8x_tail

	vaesdec	%xmm1,%xmm2,%xmm2
	vaesdec	%xmm1,%xmm3,%xmm3
	vaesdec	%xmm1,%xmm4,%xmm4
	vaesdec	%xmm1,%xmm5,%xmm5
	vaesdec	%xmm1,%xmm6,%xmm6
	vaesdec	%xmm1,%xmm7,%xmm7
	vaesdec	%xmm1,%xmm8,%xmm8
	vaesdec	%xmm1,%xmm9,%xmm9
	vmovups	208-120(%rsi),%xmm1

	vaesdec	%xmm0,%xmm2,%xmm2
	vaesdec	%xmm0,%xmm3,%xmm3
	vaesdec	%xmm0,%xmm4,%xmm4
	vaesdec	%xmm0,%xmm5,%xmm5
	vaesdec	%xmm0,%xmm6,%xmm6
	vaesdec	%xmm0,%xmm7,%xmm7
	vaesdec	%xmm0,%xmm8,%xmm8
	vaesdec	%xmm0,%xmm9,%xmm9
	vmovups	224-120(%rsi),%xmm0

.Ldec8x_tail:
	vaesdec	%xmm1,%xmm2,%xmm2
	vpxor	%xmm15,%xmm15,%xmm15
	vaesdec	%xmm1,%xmm3,%xmm3
	vaesdec	%xmm1,%xmm4,%xmm4
	vpcmpgtd	%xmm15,%xmm14,%xmm15
	vaesdec	%xmm1,%xmm5,%xmm5
	vaesdec	%xmm1,%xmm6,%xmm6
	vpaddd	%xmm14,%xmm15,%xmm15
	vmovdqu	48(%rsp),%xmm14
	vaesdec	%xmm1,%xmm7,%xmm7
	movq	64(%rsp),%rbx
	vaesdec	%xmm1,%xmm8,%xmm8
	vaesdec	%xmm1,%xmm9,%xmm9
	vmovups	16-120(%rsi),%xmm1

	vaesdeclast	%xmm0,%xmm2,%xmm2
	vmovdqa	%xmm15,32(%rsp)
	vpxor	%xmm15,%xmm15,%xmm15
	vaesdeclast	%xmm0,%xmm3,%xmm3
	vpxor	0(%rbp),%xmm2,%xmm2
	vaesdeclast	%xmm0,%xmm4,%xmm4
	vpxor	16(%rbp),%xmm3,%xmm3
	vpcmpgtd	%xmm15,%xmm14,%xmm15
	vaesdeclast	%xmm0,%xmm5,%xmm5
	vpxor	32(%rbp),%xmm4,%xmm4
	vaesdeclast	%xmm0,%xmm6,%xmm6
	vpxor	48(%rbp),%xmm5,%xmm5
	vpaddd	%xmm15,%xmm14,%xmm14
	vmovdqu	-120(%rsi),%xmm15
	vaesdeclast	%xmm0,%xmm7,%xmm7
	vpxor	64(%rbp),%xmm6,%xmm6
	vaesdeclast	%xmm0,%xmm8,%xmm8
	vpxor	80(%rbp),%xmm7,%xmm7
	vmovdqa	%xmm14,48(%rsp)
	vaesdeclast	%xmm0,%xmm9,%xmm9
	vpxor	96(%rbp),%xmm8,%xmm8
	vmovups	32-120(%rsi),%xmm0

	vmovups	%xmm2,-16(%r8)
	subq	%rbx,%r8
	vmovdqu	128+0(%rsp),%xmm2
	vpxor	112(%rbp),%xmm9,%xmm9
	vmovups	%xmm3,-16(%r9)
	subq	72(%rsp),%r9
	vmovdqu	%xmm2,0(%rbp)
	vpxor	%xmm15,%xmm2,%xmm2
	vmovdqu	128+16(%rsp),%xmm3
	vmovups	%xmm4,-16(%r10)
	subq	80(%rsp),%r10
	vmovdqu	%xmm3,16(%rbp)
	vpxor	%xmm15,%xmm3,%xmm3
	vmovdqu	128+32(%rsp),%xmm4
	vmovups	%xmm5,-16(%r11)
	subq	88(%rsp),%r11
	vmovdqu	%xmm4,32(%rbp)
	vpxor	%xmm15,%xmm4,%xmm4
	vmovdqu	128+48(%rsp),%xmm5
	vmovups	%xmm6,-16(%r12)
	subq	96(%rsp),%r12
	vmovdqu	%xmm5,48(%rbp)
	vpxor	%xmm15,%xmm5,%xmm5
	vmovdqu	%xmm10,64(%rbp)
	vpxor	%xmm10,%xmm15,%xmm6
	vmovups	%xmm7,-16(%r13)
	subq	104(%rsp),%r13
	vmovdqu	%xmm11,80(%rbp)
	vpxor	%xmm11,%xmm15,%xmm7
	vmovups	%xmm8,-16(%r14)
	subq	112(%rsp),%r14
	vmovdqu	%xmm12,96(%rbp)
	vpxor	%xmm12,%xmm15,%xmm8
	vmovups	%xmm9,-16(%r15)
	subq	120(%rsp),%r15
	vmovdqu	%xmm13,112(%rbp)
	vpxor	%xmm13,%xmm15,%xmm9

	xorq	$128,%rbp
	decl	%edx
	jnz	.Loop_dec8x

	movq	16(%rsp),%rax






.Ldec8x_done:
	vzeroupper
	movaps	-216(%rax),%xmm6
	movaps	-200(%rax),%xmm7
	movaps	-184(%rax),%xmm8
	movaps	-168(%rax),%xmm9
	movaps	-152(%rax),%xmm10
	movaps	-136(%rax),%xmm11
	movaps	-120(%rax),%xmm12
	movaps	-104(%rax),%xmm13
	movaps	-88(%rax),%xmm14
	movaps	-72(%rax),%xmm15
	movq	-48(%rax),%r15

	movq	-40(%rax),%r14

	movq	-32(%rax),%r13

	movq	-24(%rax),%r12

	movq	-16(%rax),%rbp

	movq	-8(%rax),%rbx

	leaq	(%rax),%rsp

.Ldec8x_epilogue:
	movq	8(%rsp),%rdi
	movq	16(%rsp),%rsi
	.byte	0xf3,0xc3

.LSEH_end_aesni_multi_cbc_decrypt_avx:

.def	se_handler;	.scl 3;	.type 32;	.endef
.p2align	4
se_handler:
	pushq	%rsi
	pushq	%rdi
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	pushfq
	subq	$64,%rsp

	movq	120(%r8),%rax
	movq	248(%r8),%rbx

	movq	8(%r9),%rsi
	movq	56(%r9),%r11

	movl	0(%r11),%r10d
	leaq	(%rsi,%r10,1),%r10
	cmpq	%r10,%rbx
	jb	.Lin_prologue

	movq	152(%r8),%rax

	movl	4(%r11),%r10d
	leaq	(%rsi,%r10,1),%r10
	cmpq	%r10,%rbx
	jae	.Lin_prologue

	movq	16(%rax),%rax

	movq	-8(%rax),%rbx
	movq	-16(%rax),%rbp
	movq	-24(%rax),%r12
	movq	-32(%rax),%r13
	movq	-40(%rax),%r14
	movq	-48(%rax),%r15
	movq	%rbx,144(%r8)
	movq	%rbp,160(%r8)
	movq	%r12,216(%r8)
	movq	%r13,224(%r8)
	movq	%r14,232(%r8)
	movq	%r15,240(%r8)

	leaq	-56-160(%rax),%rsi
	leaq	512(%r8),%rdi
	movl	$20,%ecx
.long	0xa548f3fc

.Lin_prologue:
	movq	8(%rax),%rdi
	movq	16(%rax),%rsi
	movq	%rax,152(%r8)
	movq	%rsi,168(%r8)
	movq	%rdi,176(%r8)

	movq	40(%r9),%rdi
	movq	%r8,%rsi
	movl	$154,%ecx
.long	0xa548f3fc

	movq	%r9,%rsi
	xorq	%rcx,%rcx
	movq	8(%rsi),%rdx
	movq	0(%rsi),%r8
	movq	16(%rsi),%r9
	movq	40(%rsi),%r10
	leaq	56(%rsi),%r11
	leaq	24(%rsi),%r12
	movq	%r10,32(%rsp)
	movq	%r11,40(%rsp)
	movq	%r12,48(%rsp)
	movq	%rcx,56(%rsp)
	call	*__imp_RtlVirtualUnwind(%rip)

	movl	$1,%eax
	addq	$64,%rsp
	popfq
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	popq	%rdi
	popq	%rsi
	.byte	0xf3,0xc3


.section	.pdata
.p2align	2
.rva	.LSEH_begin_aesni_multi_cbc_encrypt
.rva	.LSEH_end_aesni_multi_cbc_encrypt
.rva	.LSEH_info_aesni_multi_cbc_encrypt
.rva	.LSEH_begin_aesni_multi_cbc_decrypt
.rva	.LSEH_end_aesni_multi_cbc_decrypt
.rva	.LSEH_info_aesni_multi_cbc_decrypt
.rva	.LSEH_begin_aesni_multi_cbc_encrypt_avx
.rva	.LSEH_end_aesni_multi_cbc_encrypt_avx
.rva	.LSEH_info_aesni_multi_cbc_encrypt_avx
.rva	.LSEH_begin_aesni_multi_cbc_decrypt_avx
.rva	.LSEH_end_aesni_multi_cbc_decrypt_avx
.rva	.LSEH_info_aesni_multi_cbc_decrypt_avx
.section	.xdata
.p2align	3
.LSEH_info_aesni_multi_cbc_encrypt:
.byte	9,0,0,0
.rva	se_handler
.rva	.Lenc4x_body,.Lenc4x_epilogue
.LSEH_info_aesni_multi_cbc_decrypt:
.byte	9,0,0,0
.rva	se_handler
.rva	.Ldec4x_body,.Ldec4x_epilogue
.LSEH_info_aesni_multi_cbc_encrypt_avx:
.byte	9,0,0,0
.rva	se_handler
.rva	.Lenc8x_body,.Lenc8x_epilogue
.LSEH_info_aesni_multi_cbc_decrypt_avx:
.byte	9,0,0,0
.rva	se_handler
.rva	.Ldec8x_body,.Ldec8x_epilogue
