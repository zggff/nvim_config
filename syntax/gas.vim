" Vim syntax file
" Language:     GNU as (AT&T) assembler for X86
" Maintainer:   Rene Koecher <info@bitspin.org>
" Last Change:  2022 Mar 07
" Version:      0.16
" Remark:       Intel and AVR compatible instructions only (for now)
" License:      BSD (3 clause), see LICENSE
"

if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

setlocal iskeyword +=%,.,-,_

syn case ignore

" symbols and labels
" - these need to appear at the top to get lowest precedence

syn match   gasLabel		/[-_$.A-Za-z0-9]\+\s*:/
syn match   gasSymbol		/\<[^; \t()]\+\>/
syn match   gasSymbolRef	/\$[-_$.A-Za-z][-_$.A-Za-z0-9]*\>/
syn match   gasSpecial		/\<[$.]\>/

" constants
syn region  gasString		start=/"/  end=/"/ skip=/\\"/
syn match   gasCharacter	/'\(?\|\\?\)/
syn match   gasDecimalNumber	/\$\?-\?\d\+/
syn match   gasBinaryNumber	/\$\?-\?0b[01]\+/
syn match   gasOctalNumber	/\$\?-\?0\d\+/
syn match   gasHexNumber	/\$\?-\?0x\x\+/
" -- TODO: gasFloatNumber

" directives
syn keyword gasDirective	.abort .ABORT .align .balignw .balignl
syn keyword gasDirective	.bundle_align_mode .bundle_lock .bundle_unlock .bss
syn keyword gasDirective	.cfi_startproc .cfi_sections .cfi_endproc .cfi_personality
syn keyword gasDirective	.cfi_lsda .cfi_def_cfa .cfi_def_cfa_register .cfi_def_cfa_offset
syn keyword gasDirective	.cfi_adjust_cfa_offset .cfi_offset .cfi_rel_offset .cfi_register
syn keyword gasDirective	.cfi_restore .cfi_undefined .cfi_same_value .cfi_remember_state
syn keyword gasDirective	.cfi_return_column .cfi_signal_frame .cfi_window_save .cfi_escape
syn keyword gasDirective	.cfi_val_encoded_addr .data .def .desc .dim .eject
syn keyword gasDirective	.else .elseif .endef .endif .endr .equ .equiv .eqv .err
syn keyword gasDirective	.error .exitm .extern .fail .file .fill .global .globl
syn keyword gasDirective	.gnu_attribute .hidden .ident .if .incbin .include .internal
syn keyword gasDirective	.irp .irpc .lcomm .lflags .line .linkonce .list .ln .loc .loc_mark_labels
syn keyword gasDirective	.local .mri .nolist .org .p2align .p2alignw .p2alignl
syn keyword gasDirective	.popsection .previous .print .protected .psize .purgem .pushsection
syn keyword gasDirective	.reloc .rept .sbttl .scl .section .set .single .size .skip .sleb128
syn keyword gasDirective	.stabd .stabn .stabs .struct .subsection
syn keyword gasDirective	.symver .tag .text .title .type .uleb128 .val .version
syn keyword gasDirective	.vtable_entry .vtable_inherit .warning .weak .weakref


syn keyword gasDirectiveStore	.byte .hword .word .int .long .double .short .float .quad .octa
syn keyword gasDirectiveStore	.string .string8 .string16 .ascii .asciz .comm .space

syn keyword gasDirectiveMacro	.altmacro .macro .noaltmacro .endm .endmacro .func .endfunc

" i*86 directives
syn keyword gasDirectiveX86	.att_syntax .intel_syntax .att_mnemonic .intel_mnemonic .code16 .code32 .code64 .lcomm

" i*86 register set
syn keyword gasRegisterX86	%rax %rbx %rcx %rdx %rdi %rsi %rsp %rbp
syn keyword gasRegisterX86	%eax %ebx %ecx %edx %ax %bx %cx %dx %ah %al %bh %bl %ch %cl %dh %dl
syn keyword gasRegisterX86	%edi %esi %esp %ebp %di %si %sp %bp %sph %spl %bph %bpl
syn keyword gasRegisterX86	%cs %ds %es %fs %gs %ss %ip %eip %rip %eflags

syn keyword gasRegisterX86	rax rbx rcx rdx rdi rsi rsp rbp
syn keyword gasRegisterX86	eax ebx ecx edx ax bx cx dx ah al bh bl ch cl dh dl
syn keyword gasRegisterX86	edi esi esp ebp di si sp bp sph spl bph bpl
syn keyword gasRegisterX86	cs ds es fs gs ss ip eip rip eflags

syn match   gasRegisterX86	/\<%r\([8-9]\|1[0-5]\)[lwd]\?\>/
syn match   gasRegisterX86	/\<r\([8-9]\|1[0-5]\)[lwd]\?\>/

" i*86 special registers
syn match gasRegisterX86Cr	/\<%cr[0-8]\>/
syn match gasRegisterX86Dr	/\<%dr[0-8]\>/
syn match gasRegisterX86Tr	/\<%tr[0-8]\>/
syn match gasRegisterX86Fp	/\<%sp\(([0-7])\)\?\>/
syn match gasRegisterX86MMX	/\<%x\?mm[0-7]\>/

syn match gasRegisterX86Cr	/\<cr[0-8]\>/
syn match gasRegisterX86Dr	/\<dr[0-8]\>/
syn match gasRegisterX86Tr	/\<tr[0-8]\>/
syn match gasRegisterX86Fp	/\<sp\(([0-7])\)\?\>/
syn match gasRegisterX86MMX	/\<x\?mm[0-7]\>/


syn match gasRegisterAVX	/\<%ymm\([0-9]\|1[0-5]\)\>/
syn match gasRegisterAVX512	/\<%ymm\(1[6-9]\|2[0-9]\|3[0-1]\)\>/
syn match gasRegisterAVX512	/\<%zmm\([0-9]\|[1-2][0-9]\|3[0-1]\)\>/

" local label needs to be matched *after* numerics
syn match   gasLocalLabel	/\d\{1,2\}[:fb]/

" comments etc.
syn match   gasOperator		/[+-/*=|&~<>]\|<=\|>=\|<>/
syn match   gasTODO		/\<\(TODO\|FIXME\|NOTE\)\>/ contained
syn region  gasComment		start=/\/\*/ end=/\*\// contains=gasTODO
syn region  gasCommentSingle    start=/#/ end=/$/ contains=gasTODO
syn region  gasCommentSingle    start=/@/ end=/$/ contains=gasTODO
" if exists('g:gasCppComments')
	syn region  gasCommentSingle start=/\/\// end=/$/ contains=gasTODO
" endif

" ARM specific directives
syn keyword gasDirectiveStoreARM	.2byte .4byte .8byte

syn keyword gasDirectiveARM	.arch .arch_expression .arm .asciiz .cantunwind .code .cpu .dn .qn .eabi_attribute .even .extend .ldouble .fnend .fbstart .force_thumb .fpu .handlerdata .inst .inst.n .inst.w .ltorg .lmovsp .movsp .object_arch .packed .pad .personality .personalityindex .pool .req .save .setfp .secrel32 .syntax .thumb .thumb_func .thumb_set .tlsdescseq .unreq .unwind_raw .vsave

" ARM register set
" Must be defined after gasSymbol to have higher precedence
syn keyword gasRegisterARM		sp lr pc
syn match   gasRegisterARM		/\<%\?r\([0-9]\|1[0-5]\)\>/

syn keyword gasDirectiveMacroARM	.dn .dq .req .unreq .tlsdescseq

"-- Section: AMD XOP, FMA4 and CVT16 instructions (SSE5)
"-- Section: Tejas New Instructions (SSSE3)
syn keyword gasOpcode_Base		pabsb pabsbb pabsbw pabsbl pabsbq
syn keyword gasOpcode_Base		pabsw pabswb pabsww pabswl pabswq
syn keyword gasOpcode_Base		pabsd pabsdb pabsdw pabsdl pabsdq
syn keyword gasOpcode_Base		palignr palignrb palignrw palignrl palignrq
syn keyword gasOpcode_Base		phaddw phaddwb phaddww phaddwl phaddwq
syn keyword gasOpcode_Base		phaddd phadddb phadddw phadddl phadddq
syn keyword gasOpcode_Base		phaddsw phaddswb phaddsww phaddswl phaddswq
syn keyword gasOpcode_Base		phsubw phsubwb phsubww phsubwl phsubwq
syn keyword gasOpcode_Base		phsubd phsubdb phsubdw phsubdl phsubdq
syn keyword gasOpcode_Base		phsubsw phsubswb phsubsww phsubswl phsubswq
syn keyword gasOpcode_Base		pmaddubsw pmaddubswb pmaddubsww pmaddubswl pmaddubswq
syn keyword gasOpcode_Base		pmulhrsw pmulhrswb pmulhrsww pmulhrswl pmulhrswq
syn keyword gasOpcode_Base		pshufb pshufbb pshufbw pshufbl pshufbq
syn keyword gasOpcode_Base		psignb psignbb psignbw psignbl psignbq
syn keyword gasOpcode_Base		psignw psignwb psignww psignwl psignwq
syn keyword gasOpcode_Base		psignd psigndb psigndw psigndl psigndq

"-- Section: Conventional instructions
syn keyword gasOpcode_8086_Base		aaa
syn keyword gasOpcode_8086_Base		aad aadb aadw aadl aadq
syn keyword gasOpcode_8086_Base		aam aamb aamw aaml aamq
syn keyword gasOpcode_8086_Base		aas
syn keyword gasOpcode_386_Base		adc adcb adcw adcl adcq
syn keyword gasOpcode_386_Base		add addb addw addl addq
syn keyword gasOpcode_386_Base		and andb andw andl andq
syn keyword gasOpcode_286_Base		arpl
syn keyword gasOpcode_PENT_Base		bb0_reset
syn keyword gasOpcode_PENT_Base		bb1_reset
syn keyword gasOpcode_386_Base		bound boundb boundw boundl boundq
syn keyword gasOpcode_X64_Base		bsf
syn keyword gasOpcode_X64_Base		bsr
syn keyword gasOpcode_X64_Base		bswap
syn keyword gasOpcode_X64_Base		bt btb btw btl btq
syn keyword gasOpcode_X64_Base		btc btcb btcw btcl btcq
syn keyword gasOpcode_X64_Base		btr btrb btrw btrl btrq
syn keyword gasOpcode_X64_Base		bts btsb btsw btsl btsq
syn keyword gasOpcode_X64_Base		call callb callw calll callq
syn keyword gasOpcode_8086_Base		cbw
syn keyword gasOpcode_386_Base		cdq
syn keyword gasOpcode_X64_Base		cdqe
syn keyword gasOpcode_8086_Base		clc
syn keyword gasOpcode_8086_Base		cld
syn keyword gasOpcode_X64_Base		clgi
syn keyword gasOpcode_8086_Base		cli
syn keyword gasOpcode_286_Base		clts
syn keyword gasOpcode_8086_Base		cmc
syn keyword gasOpcode_386_Base		cmp cmpb cmpw cmpl cmpq
syn keyword gasOpcode_8086_Base		cmpsb
syn keyword gasOpcode_386_Base		cmpsd
syn keyword gasOpcode_X64_Base		cmpsq
syn keyword gasOpcode_8086_Base		cmpsw
syn keyword gasOpcode_X64_Base		cmpxchg
syn keyword gasOpcode_486_Base		cmpxchg486
syn keyword gasOpcode_PENT_Base		cmpxchg8b cmpxchg8bb cmpxchg8bw cmpxchg8bl cmpxchg8bq
syn keyword gasOpcode_X64_Base		cmpxchg16b cmpxchg16bb cmpxchg16bw cmpxchg16bl cmpxchg16bq
syn keyword gasOpcode_PENT_Base		cpuid
syn keyword gasOpcode_PENT_Base		cpu_read
syn keyword gasOpcode_PENT_Base		cpu_write
syn keyword gasOpcode_X64_Base		cqo
syn keyword gasOpcode_8086_Base		cwd
syn keyword gasOpcode_386_Base		cwde
syn keyword gasOpcode_8086_Base		daa
syn keyword gasOpcode_8086_Base		das
syn keyword gasOpcode_X64_Base		dec decb decw decl decq
syn keyword gasOpcode_X64_Base		div
syn keyword gasOpcode_P6_Base		dmint
syn keyword gasOpcode_PENT_MMX		emms
syn keyword gasOpcode_186_Base		enter enterb enterw enterl enterq
syn keyword gasOpcode_8086_Base		equ
syn keyword gasOpcode_8086_Base		f2xm1
syn keyword gasOpcode_8086_Base		fabs
syn keyword gasOpcode_8086_Base		fadd
syn keyword gasOpcode_8086_Base		faddp
syn keyword gasOpcode_8086_Base		fbld fbldb fbldw fbldl fbldq
syn keyword gasOpcode_8086_Base		fbstp fbstpb fbstpw fbstpl fbstpq
syn keyword gasOpcode_8086_Base		fchs
syn keyword gasOpcode_8086_Base		fclex
syn keyword gasOpcode_P6_Base		fcmovb
syn keyword gasOpcode_P6_Base		fcmovbe
syn keyword gasOpcode_P6_Base		fcmove
syn keyword gasOpcode_P6_Base		fcmovnb
syn keyword gasOpcode_P6_Base		fcmovnbe
syn keyword gasOpcode_P6_Base		fcmovne
syn keyword gasOpcode_P6_Base		fcmovnu
syn keyword gasOpcode_P6_Base		fcmovu
syn keyword gasOpcode_8086_Base		fcom
syn keyword gasOpcode_P6_Base		fcomi
syn keyword gasOpcode_P6_Base		fcomip
syn keyword gasOpcode_8086_Base		fcomp
syn keyword gasOpcode_8086_Base		fcompp
syn keyword gasOpcode_386_Base		fcos
syn keyword gasOpcode_8086_Base		fdecstp
syn keyword gasOpcode_8086_Base		fdisi
syn keyword gasOpcode_8086_Base		fdiv
syn keyword gasOpcode_8086_Base		fdivp
syn keyword gasOpcode_8086_Base		fdivr
syn keyword gasOpcode_8086_Base		fdivrp
syn keyword gasOpcode_PENT_3DNOW	femms
syn keyword gasOpcode_8086_Base		feni
syn keyword gasOpcode_8086_Base		ffree
syn keyword gasOpcode_286_Base		ffreep
syn keyword gasOpcode_8086_Base		fiadd fiaddb fiaddw fiaddl fiaddq
syn keyword gasOpcode_8086_Base		ficom ficomb ficomw ficoml ficomq
syn keyword gasOpcode_8086_Base		ficomp ficompb ficompw ficompl ficompq
syn keyword gasOpcode_8086_Base		fidiv fidivb fidivw fidivl fidivq
syn keyword gasOpcode_8086_Base		fidivr fidivrb fidivrw fidivrl fidivrq
syn keyword gasOpcode_8086_Base		fild fildb fildw fildl fildq
syn keyword gasOpcode_8086_Base		fimul fimulb fimulw fimull fimulq
syn keyword gasOpcode_8086_Base		fincstp
syn keyword gasOpcode_8086_Base		finit
syn keyword gasOpcode_8086_Base		fist fistb fistw fistl fistq
syn keyword gasOpcode_8086_Base		fistp fistpb fistpw fistpl fistpq
syn keyword gasOpcode_PRESCOTT_Base	fisttp fisttpb fisttpw fisttpl fisttpq
syn keyword gasOpcode_8086_Base		fisub fisubb fisubw fisubl fisubq
syn keyword gasOpcode_8086_Base		fisubr fisubrb fisubrw fisubrl fisubrq
syn keyword gasOpcode_8086_Base		fld
syn keyword gasOpcode_8086_Base		fld1
syn keyword gasOpcode_8086_Base		fldcw fldcwb fldcww fldcwl fldcwq
syn keyword gasOpcode_8086_Base		fldenv fldenvb fldenvw fldenvl fldenvq
syn keyword gasOpcode_8086_Base		fldl2e
syn keyword gasOpcode_8086_Base		fldl2t
syn keyword gasOpcode_8086_Base		fldlg2
syn keyword gasOpcode_8086_Base		fldln2
syn keyword gasOpcode_8086_Base		fldpi
syn keyword gasOpcode_8086_Base		fldz
syn keyword gasOpcode_8086_Base		fmul
syn keyword gasOpcode_8086_Base		fmulp
syn keyword gasOpcode_8086_Base		fnclex
syn keyword gasOpcode_8086_Base		fndisi
syn keyword gasOpcode_8086_Base		fneni
syn keyword gasOpcode_8086_Base		fninit
syn keyword gasOpcode_8086_Base		fnop
syn keyword gasOpcode_8086_Base		fnsave fnsaveb fnsavew fnsavel fnsaveq
syn keyword gasOpcode_8086_Base		fnstcw fnstcwb fnstcww fnstcwl fnstcwq
syn keyword gasOpcode_8086_Base		fnstenv fnstenvb fnstenvw fnstenvl fnstenvq
syn keyword gasOpcode_286_Base		fnstsw
syn keyword gasOpcode_8086_Base		fpatan
syn keyword gasOpcode_8086_Base		fprem
syn keyword gasOpcode_386_Base		fprem1
syn keyword gasOpcode_8086_Base		fptan
syn keyword gasOpcode_8086_Base		frndint
syn keyword gasOpcode_8086_Base		frstor frstorb frstorw frstorl frstorq
syn keyword gasOpcode_8086_Base		fsave fsaveb fsavew fsavel fsaveq
syn keyword gasOpcode_8086_Base		fscale
syn keyword gasOpcode_286_Base		fsetpm
syn keyword gasOpcode_386_Base		fsin
syn keyword gasOpcode_386_Base		fsincos
syn keyword gasOpcode_8086_Base		fsqrt
syn keyword gasOpcode_8086_Base		fst
syn keyword gasOpcode_8086_Base		fstcw fstcwb fstcww fstcwl fstcwq
syn keyword gasOpcode_8086_Base		fstenv fstenvb fstenvw fstenvl fstenvq
syn keyword gasOpcode_8086_Base		fstp
syn keyword gasOpcode_286_Base		fstsw
syn keyword gasOpcode_8086_Base		fsub
syn keyword gasOpcode_8086_Base		fsubp
syn keyword gasOpcode_8086_Base		fsubr
syn keyword gasOpcode_8086_Base		fsubrp
syn keyword gasOpcode_8086_Base		ftst
syn keyword gasOpcode_386_Base		fucom
syn keyword gasOpcode_P6_Base		fucomi
syn keyword gasOpcode_P6_Base		fucomip
syn keyword gasOpcode_386_Base		fucomp
syn keyword gasOpcode_386_Base		fucompp
syn keyword gasOpcode_8086_Base		fxam
syn keyword gasOpcode_8086_Base		fxch
syn keyword gasOpcode_8086_Base		fxtract
syn keyword gasOpcode_8086_Base		fyl2x
syn keyword gasOpcode_8086_Base		fyl2xp1
syn keyword gasOpcode_8086_Base		hlt
syn keyword gasOpcode_386_Base		ibts
syn keyword gasOpcode_386_Base		icebp
syn keyword gasOpcode_X64_Base		idiv
syn keyword gasOpcode_X64_Base		imul imulb imulw imull imulq
syn keyword gasOpcode_386_Base		in
syn keyword gasOpcode_X64_Base		inc incb incw incl incq
syn keyword gasOpcode_Base		incbin
syn keyword gasOpcode_186_Base		insb
syn keyword gasOpcode_386_Base		insd
syn keyword gasOpcode_186_Base		insw
syn keyword gasOpcode_8086_Base		int intb intw intl intq
syn keyword gasOpcode_386_Base		int01
syn keyword gasOpcode_386_Base		int1
syn keyword gasOpcode_8086_Base		int03
syn keyword gasOpcode_8086_Base		int3
syn keyword gasOpcode_8086_Base		into
syn keyword gasOpcode_486_Base		invd
syn keyword gasOpcode_486_Base		invlpg invlpgb invlpgw invlpgl invlpgq
syn keyword gasOpcode_X86_64_Base	invlpga
syn keyword gasOpcode_8086_Base		iret
syn keyword gasOpcode_386_Base		iretd
syn keyword gasOpcode_X64_Base		iretq
syn keyword gasOpcode_8086_Base		iretw
syn keyword gasOpcode_8086_Base		jcxz jcxzb jcxzw jcxzl jcxzq
syn keyword gasOpcode_386_Base		jecxz jecxzb jecxzw jecxzl jecxzq
syn keyword gasOpcode_X64_Base		jrcxz jrcxzb jrcxzw jrcxzl jrcxzq
syn keyword gasOpcode_X64_Base		jmp jmpb jmpw jmpl jmpq
syn keyword gasOpcode_IA64_Base		jmpe
syn keyword gasOpcode_8086_Base		lahf
syn keyword gasOpcode_X64_Base		lar
syn keyword gasOpcode_386_Base		lds ldsb ldsw ldsl ldsq
syn keyword gasOpcode_X64_Base		lea leab leaw leal leaq
syn keyword gasOpcode_186_Base		leave
syn keyword gasOpcode_386_Base		les lesb lesw lesl lesq
syn keyword gasOpcode_X64_Base		lfence
syn keyword gasOpcode_386_Base		lfs lfsb lfsw lfsl lfsq
syn keyword gasOpcode_286_Base		lgdt lgdtb lgdtw lgdtl lgdtq
syn keyword gasOpcode_386_Base		lgs lgsb lgsw lgsl lgsq
syn keyword gasOpcode_286_Base		lidt lidtb lidtw lidtl lidtq
syn keyword gasOpcode_286_Base		lldt
syn keyword gasOpcode_286_Base		lmsw
syn keyword gasOpcode_386_Base		loadall
syn keyword gasOpcode_286_Base		loadall286
syn keyword gasOpcode_8086_Base		lodsb
syn keyword gasOpcode_386_Base		lodsd
syn keyword gasOpcode_X64_Base		lodsq
syn keyword gasOpcode_8086_Base		lodsw
syn keyword gasOpcode_X64_Base		loop loopb loopw loopl loopq
syn keyword gasOpcode_X64_Base		loope loopeb loopew loopel loopeq
syn keyword gasOpcode_X64_Base		loopne loopneb loopnew loopnel loopneq
syn keyword gasOpcode_X64_Base		loopnz loopnzb loopnzw loopnzl loopnzq
syn keyword gasOpcode_X64_Base		loopz loopzb loopzw loopzl loopzq
syn keyword gasOpcode_X64_Base		lsl
syn keyword gasOpcode_386_Base		lss lssb lssw lssl lssq
syn keyword gasOpcode_286_Base		ltr
syn keyword gasOpcode_X64_Base		mfence
syn keyword gasOpcode_PRESCOTT_Base	monitor
syn keyword gasOpcode_386_Base		mov movb movw movl movq
syn keyword gasOpcode_X64_SSE		movd
syn keyword gasOpcode_X64_MMX		movq
syn keyword gasOpcode_8086_Base		movsb
syn keyword gasOpcode_386_Base		movsd
syn keyword gasOpcode_X64_Base		movsq
syn keyword gasOpcode_8086_Base		movsw
syn keyword gasOpcode_X64_Base		movsx
syn keyword gasOpcode_X64_Base		movsxd
syn keyword gasOpcode_X64_Base		movsx
syn keyword gasOpcode_X64_Base		movzx
syn keyword gasOpcode_X64_Base		movzbl
syn keyword gasOpcode_X64_Base		mul
syn keyword gasOpcode_PRESCOTT_Base	mwait
syn keyword gasOpcode_X64_Base		neg
syn keyword gasOpcode_X64_Base		nop
syn keyword gasOpcode_X64_Base		not
syn keyword gasOpcode_386_Base		or orb orw orl orq
syn keyword gasOpcode_386_Base		out
syn keyword gasOpcode_186_Base		outsb
syn keyword gasOpcode_386_Base		outsd
syn keyword gasOpcode_186_Base		outsw
syn keyword gasOpcode_PENT_MMX		packssdw packssdwb packssdww packssdwl packssdwq
syn keyword gasOpcode_PENT_MMX		packsswb packsswbb packsswbw packsswbl packsswbq
syn keyword gasOpcode_PENT_MMX		packuswb packuswbb packuswbw packuswbl packuswbq
syn keyword gasOpcode_PENT_MMX		paddb paddbb paddbw paddbl paddbq
syn keyword gasOpcode_PENT_MMX		paddd padddb padddw padddl padddq
syn keyword gasOpcode_PENT_MMX		paddsb paddsbb paddsbw paddsbl paddsbq
syn keyword gasOpcode_PENT_MMX		paddsiw paddsiwb paddsiww paddsiwl paddsiwq
syn keyword gasOpcode_PENT_MMX		paddsw paddswb paddsww paddswl paddswq
syn keyword gasOpcode_PENT_MMX		paddusb paddusbb paddusbw paddusbl paddusbq
syn keyword gasOpcode_PENT_MMX		paddusw padduswb paddusww padduswl padduswq
syn keyword gasOpcode_PENT_MMX		paddw paddwb paddww paddwl paddwq
syn keyword gasOpcode_PENT_MMX		pand pandb pandw pandl pandq
syn keyword gasOpcode_PENT_MMX		pandn pandnb pandnw pandnl pandnq
syn keyword gasOpcode_8086_Base		pause
syn keyword gasOpcode_PENT_MMX		paveb pavebb pavebw pavebl pavebq
syn keyword gasOpcode_PENT_3DNOW	pavgusb pavgusbb pavgusbw pavgusbl pavgusbq
syn keyword gasOpcode_PENT_MMX		pcmpeqb pcmpeqbb pcmpeqbw pcmpeqbl pcmpeqbq
syn keyword gasOpcode_PENT_MMX		pcmpeqd pcmpeqdb pcmpeqdw pcmpeqdl pcmpeqdq
syn keyword gasOpcode_PENT_MMX		pcmpeqw pcmpeqwb pcmpeqww pcmpeqwl pcmpeqwq
syn keyword gasOpcode_PENT_MMX		pcmpgtb pcmpgtbb pcmpgtbw pcmpgtbl pcmpgtbq
syn keyword gasOpcode_PENT_MMX		pcmpgtd pcmpgtdb pcmpgtdw pcmpgtdl pcmpgtdq
syn keyword gasOpcode_PENT_MMX		pcmpgtw pcmpgtwb pcmpgtww pcmpgtwl pcmpgtwq
syn keyword gasOpcode_PENT_MMX		pdistib pdistibb pdistibw pdistibl pdistibq
syn keyword gasOpcode_PENT_3DNOW	pf2id pf2idb pf2idw pf2idl pf2idq
syn keyword gasOpcode_PENT_3DNOW	pfacc pfaccb pfaccw pfaccl pfaccq
syn keyword gasOpcode_PENT_3DNOW	pfadd pfaddb pfaddw pfaddl pfaddq
syn keyword gasOpcode_PENT_3DNOW	pfcmpeq pfcmpeqb pfcmpeqw pfcmpeql pfcmpeqq
syn keyword gasOpcode_PENT_3DNOW	pfcmpge pfcmpgeb pfcmpgew pfcmpgel pfcmpgeq
syn keyword gasOpcode_PENT_3DNOW	pfcmpgt pfcmpgtb pfcmpgtw pfcmpgtl pfcmpgtq
syn keyword gasOpcode_PENT_3DNOW	pfmax pfmaxb pfmaxw pfmaxl pfmaxq
syn keyword gasOpcode_PENT_3DNOW	pfmin pfminb pfminw pfminl pfminq
syn keyword gasOpcode_PENT_3DNOW	pfmul pfmulb pfmulw pfmull pfmulq
syn keyword gasOpcode_PENT_3DNOW	pfrcp pfrcpb pfrcpw pfrcpl pfrcpq
syn keyword gasOpcode_PENT_3DNOW	pfrcpit1 pfrcpit1b pfrcpit1w pfrcpit1l pfrcpit1q
syn keyword gasOpcode_PENT_3DNOW	pfrcpit2 pfrcpit2b pfrcpit2w pfrcpit2l pfrcpit2q
syn keyword gasOpcode_PENT_3DNOW	pfrsqit1 pfrsqit1b pfrsqit1w pfrsqit1l pfrsqit1q
syn keyword gasOpcode_PENT_3DNOW	pfrsqrt pfrsqrtb pfrsqrtw pfrsqrtl pfrsqrtq
syn keyword gasOpcode_PENT_3DNOW	pfsub pfsubb pfsubw pfsubl pfsubq
syn keyword gasOpcode_PENT_3DNOW	pfsubr pfsubrb pfsubrw pfsubrl pfsubrq
syn keyword gasOpcode_PENT_3DNOW	pi2fd pi2fdb pi2fdw pi2fdl pi2fdq
syn keyword gasOpcode_PENT_MMX		pmachriw pmachriwb pmachriww pmachriwl pmachriwq
syn keyword gasOpcode_PENT_MMX		pmaddwd pmaddwdb pmaddwdw pmaddwdl pmaddwdq
syn keyword gasOpcode_PENT_MMX		pmagw pmagwb pmagww pmagwl pmagwq
syn keyword gasOpcode_PENT_MMX		pmulhriw pmulhriwb pmulhriww pmulhriwl pmulhriwq
syn keyword gasOpcode_PENT_3DNOW	pmulhrwa pmulhrwab pmulhrwaw pmulhrwal pmulhrwaq
syn keyword gasOpcode_PENT_MMX		pmulhrwc pmulhrwcb pmulhrwcw pmulhrwcl pmulhrwcq
syn keyword gasOpcode_PENT_MMX		pmulhw pmulhwb pmulhww pmulhwl pmulhwq
syn keyword gasOpcode_PENT_MMX		pmullw pmullwb pmullww pmullwl pmullwq
syn keyword gasOpcode_PENT_MMX		pmvgezb pmvgezbb pmvgezbw pmvgezbl pmvgezbq
syn keyword gasOpcode_PENT_MMX		pmvlzb pmvlzbb pmvlzbw pmvlzbl pmvlzbq
syn keyword gasOpcode_PENT_MMX		pmvnzb pmvnzbb pmvnzbw pmvnzbl pmvnzbq
syn keyword gasOpcode_PENT_MMX		pmvzb pmvzbb pmvzbw pmvzbl pmvzbq
syn keyword gasOpcode_386_Base		pop popb popw popl popq
syn keyword gasOpcode_186_Base		popa
syn keyword gasOpcode_386_Base		popal
syn keyword gasOpcode_186_Base		popaw
syn keyword gasOpcode_8086_Base		popf
syn keyword gasOpcode_386_Base		popfd popfl
syn keyword gasOpcode_X64_Base		popfq
syn keyword gasOpcode_8086_Base		popfw
syn keyword gasOpcode_PENT_MMX		por porb porw porl porq
syn keyword gasOpcode_PENT_3DNOW	prefetch prefetchb prefetchw prefetchl prefetchq
syn keyword gasOpcode_PENT_3DNOW	prefetchw prefetchwb prefetchww prefetchwl prefetchwq
syn keyword gasOpcode_PENT_MMX		pslld pslldb pslldw pslldl pslldq
syn keyword gasOpcode_PENT_MMX		psllq psllqb psllqw psllql psllqq
syn keyword gasOpcode_PENT_MMX		psllw psllwb psllww psllwl psllwq
syn keyword gasOpcode_PENT_MMX		psrad psradb psradw psradl psradq
syn keyword gasOpcode_PENT_MMX		psraw psrawb psraww psrawl psrawq
syn keyword gasOpcode_PENT_MMX		psrld psrldb psrldw psrldl psrldq
syn keyword gasOpcode_PENT_MMX		psrlq psrlqb psrlqw psrlql psrlqq
syn keyword gasOpcode_PENT_MMX		psrlw psrlwb psrlww psrlwl psrlwq
syn keyword gasOpcode_PENT_MMX		psubb psubbb psubbw psubbl psubbq
syn keyword gasOpcode_PENT_MMX		psubd psubdb psubdw psubdl psubdq
syn keyword gasOpcode_PENT_MMX		psubsb psubsbb psubsbw psubsbl psubsbq
syn keyword gasOpcode_PENT_MMX		psubsiw psubsiwb psubsiww psubsiwl psubsiwq
syn keyword gasOpcode_PENT_MMX		psubsw psubswb psubsww psubswl psubswq
syn keyword gasOpcode_PENT_MMX		psubusb psubusbb psubusbw psubusbl psubusbq
syn keyword gasOpcode_PENT_MMX		psubusw psubuswb psubusww psubuswl psubuswq
syn keyword gasOpcode_PENT_MMX		psubw psubwb psubww psubwl psubwq
syn keyword gasOpcode_PENT_MMX		punpckhbw punpckhbwb punpckhbww punpckhbwl punpckhbwq
syn keyword gasOpcode_PENT_MMX		punpckhdq punpckhdqb punpckhdqw punpckhdql punpckhdqq
syn keyword gasOpcode_PENT_MMX		punpckhwd punpckhwdb punpckhwdw punpckhwdl punpckhwdq
syn keyword gasOpcode_PENT_MMX		punpcklbw punpcklbwb punpcklbww punpcklbwl punpcklbwq
syn keyword gasOpcode_PENT_MMX		punpckldq punpckldqb punpckldqw punpckldql punpckldqq
syn keyword gasOpcode_PENT_MMX		punpcklwd punpcklwdb punpcklwdw punpcklwdl punpcklwdq
syn keyword gasOpcode_X64_Base		push pushb pushw pushl pushq
syn keyword gasOpcode_186_Base		pusha
syn keyword gasOpcode_386_Base		pushal
syn keyword gasOpcode_186_Base		pushaw
syn keyword gasOpcode_8086_Base		pushf
syn keyword gasOpcode_386_Base		pushfd
syn keyword gasOpcode_X64_Base		pushfq
syn keyword gasOpcode_8086_Base		pushfw
syn keyword gasOpcode_PENT_MMX		pxor pxorb pxorw pxorl pxorq
syn keyword gasOpcode_X64_Base		rcl rclb rclw rcll rclq
syn keyword gasOpcode_X64_Base		rcr rcrb rcrw rcrl rcrq
syn keyword gasOpcode_P6_Base		rdshr
syn keyword gasOpcode_PENT_Base		rdmsr
syn keyword gasOpcode_P6_Base		rdpmc
syn keyword gasOpcode_PENT_Base		rdtsc
syn keyword gasOpcode_X86_64_Base		rdtscp
syn keyword gasOpcode_8086_Base		ret retb retw retl retq
syn keyword gasOpcode_8086_Base		retf retfb retfw retfl retfq
syn keyword gasOpcode_8086_Base		retn retnb retnw retnl retnq
syn keyword gasOpcode_X64_Base		rol rolb rolw roll rolq
syn keyword gasOpcode_X64_Base		ror rorb rorw rorl rorq
syn keyword gasOpcode_P6_Base		rdm
syn keyword gasOpcode_486_Base		rsdc rsdcb rsdcw rsdcl rsdcq
syn keyword gasOpcode_486_Base		rsldt rsldtb rsldtw rsldtl rsldtq
syn keyword gasOpcode_PENTM_Base		rsm
syn keyword gasOpcode_486_Base		rsts rstsb rstsw rstsl rstsq
syn keyword gasOpcode_8086_Base		sahf
syn keyword gasOpcode_X64_Base		sal salb salw sall salq
syn keyword gasOpcode_8086_Base		salc
syn keyword gasOpcode_X64_Base		sar sarb sarw sarl sarq
syn keyword gasOpcode_386_Base		sbb sbbb sbbw sbbl sbbq
syn keyword gasOpcode_8086_Base		scasb
syn keyword gasOpcode_386_Base		scasd
syn keyword gasOpcode_X64_Base		scasq
syn keyword gasOpcode_8086_Base		scasw
syn keyword gasOpcode_X64_Base		sfence
syn keyword gasOpcode_286_Base		sgdt sgdtb sgdtw sgdtl sgdtq
syn keyword gasOpcode_X64_Base		shl shlb shlw shll shlq
syn keyword gasOpcode_X64_Base		shld
syn keyword gasOpcode_X64_Base		shr shrb shrw shrl shrq
syn keyword gasOpcode_X64_Base		shrd
syn keyword gasOpcode_286_Base		sidt sidtb sidtw sidtl sidtq
syn keyword gasOpcode_X64_Base		sldt
syn keyword gasOpcode_X64_Base		skinit
syn keyword gasOpcode_386_Base		smi
syn keyword gasOpcode_P6_Base		smint
syn keyword gasOpcode_486_Base		smintold
syn keyword gasOpcode_386_Base		smsw
syn keyword gasOpcode_8086_Base		stc
syn keyword gasOpcode_8086_Base		std
syn keyword gasOpcode_X64_Base		stgi
syn keyword gasOpcode_8086_Base		sti
syn keyword gasOpcode_8086_Base		stosb
syn keyword gasOpcode_386_Base		stosd stosl
syn keyword gasOpcode_X64_Base		stosq
syn keyword gasOpcode_8086_Base		stosw
syn keyword gasOpcode_X64_Base		str
syn keyword gasOpcode_386_Base		sub subb subw subl subq
syn keyword gasOpcode_486_Base		svdc svdcb svdcw svdcl svdcq
syn keyword gasOpcode_486_Base		svldt svldtb svldtw svldtl svldtq
syn keyword gasOpcode_486_Base		svts svtsb svtsw svtsl svtsq
syn keyword gasOpcode_X64_Base		swapgs
syn keyword gasOpcode_P6_Base		syscall
syn keyword gasOpcode_P6_Base		sysenter
syn keyword gasOpcode_P6_Base		sysexit
syn keyword gasOpcode_P6_Base		sysret
syn keyword gasOpcode_386_Base		test testb testw testl testq
syn keyword gasOpcode_186_Base		ud0
syn keyword gasOpcode_186_Base		ud1
syn keyword gasOpcode_186_Base		ud2b
syn keyword gasOpcode_186_Base		ud2
syn keyword gasOpcode_186_Base		ud2a
syn keyword gasOpcode_386_Base		umov
syn keyword gasOpcode_286_Base		verr
syn keyword gasOpcode_286_Base		verw
syn keyword gasOpcode_8086_Base		fwait
syn keyword gasOpcode_486_Base		wbinvd
syn keyword gasOpcode_P6_Base		wrshr
syn keyword gasOpcode_PENT_Base		wrmsr
syn keyword gasOpcode_X64_Base		xadd
syn keyword gasOpcode_386_Base		xbts
syn keyword gasOpcode_X64_Base		xchg
syn keyword gasOpcode_8086_Base		xlatb
syn keyword gasOpcode_8086_Base		xlat
syn keyword gasOpcode_386_Base		xor xorb xorw xorl xorq
syn keyword gasOpcode_X64_Base		cmovcc
syn match   gasOpcode_8086_Base		/\<j\(e\|ne\|a\|ae\|b\|be\|nbe\|g\|ge\|ng\|nge\|l\|le\|\|z\|nz\|c\|nc\|d\|nd\|o\|no\|p\|np\|s\|ns\)[bwlq]\?\>/
syn match   gasOpcode_386_Base		/\<set\(e\|ne\|a\|ae\|b\|be\|nbe\|g\|ge\|ng\|nge\|l\|le\|\|z\|nz\|c\|nc\|d\|nd\|o\|no\|p\|np\|s\|ns\)[bwlq]\?\>/


" links
hi def link gasDirectiveX86	        gasDirective
hi def link gasRegisterX86	        gasRegister
hi def link gasRegisterX86Cr	        gasRegister
hi def link gasRegisterX86Dr	        gasRegister
hi def link gasRegisterX86MMX	        gasRegister
hi def link gasRegisterAVX	        gasRegister
hi def link gasRegisterAVX512	        gasRegister
hi def link gasDirectiveARM	        gasDirective
hi def link gasRegisterARM	        gasRegister
hi def link gasDirectiveMacroARM	gasDirectiveMacro
hi def link gasDirectiveStoreARM	gasDirectiveStore

" link to defaults
hi def link gasDirective	Preproc
hi def link gasDirectiveStore	Type
hi def link gasDirectiveMacro	Macro
hi def link gasRegister		Identifier
hi def link gasString		String
hi def link gasCharacter	Character
hi def link gasBinaryNumber	Constant
hi def link gasOctalNumber	Constant
hi def link gasHexNumber	Constant
hi def link gasDecimalNumber	Constant
hi def link gasSymbol		Function
hi def link gasSymbolRef	Special
hi def link gasSpecial		Special
hi def link gasLabel		Function
hi def link gasLocalLabel	Label
hi def link gasOperator		Operator
hi def link gasTODO		Todo
hi def link gasOpcode		Keyword
hi def link gasComment		Comment
hi def link gasCommentSingle	Comment

"-- initial mapping => Keyword
func! s:MapOpcode (group, cpu, ext)
	let himap = 'Keyword'

	if exists('g:gasDisableOpcodes')
		if index(split(g:gasDisableOpcodes), a:cpu) != -1
			let himap = 'Error'
		endif
		if index(split(g:gasDisableOpcodes), a:ext) != -1
			let himap = 'Error'
		endif
	endif

	if exists('b:gasDisableOpcodes')
		if index(split(b:gasDisableOpcodes), a:cpu) != -1
			let himap = 'Error'
		endif
		if index(split(b:gasDisableOpcodes), a:ext) != -1
			let himap = 'Error'
		endif
	endif

	exe 'hi link '.a:group.' '.himap
endf

call <SID>MapOpcode('gasOpcode_186_Base'       , '186'        , 'base')
call <SID>MapOpcode('gasOpcode_286_Base'       , '286'        , 'base')
call <SID>MapOpcode('gasOpcode_3862_Base'      , '3862'       , 'base')
call <SID>MapOpcode('gasOpcode_386_Base'       , '386'        , 'base')
call <SID>MapOpcode('gasOpcode_486_Base'       , '486'        , 'base')
call <SID>MapOpcode('gasOpcode_8086_Base'      , '8086'       , 'base')
call <SID>MapOpcode('gasOpcode_X64_Base'       , 'x64'        , 'base')
call <SID>MapOpcode('gasOpcode_X86_64_Base'    , 'x64'        , 'base')

" support CPP preprocessor tags
if !exists('g:gasDisablePreproc') && !exists('b:gasDisablePreproc')
	syn case match

	syn include @cPP syntax/c.vim
	syn match   cPPLineCont "\\$" contained

	syn region  cPPPreProc start=/^\s*#\s*\(if\|else\|endif\|define\|include\)/ end=/$/ contains=@cPP,cPPLineCont
endif

" finishing touches
let b:current_syntax = "gas"

syn sync ccomment
syn sync linebreaks=1

" vim: ts=8 sw=8 :
