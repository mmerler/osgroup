
bootother.o:     file format elf32-i386

Disassembly of section .text:

00000000 <start>:
#define CR0_PE    1  // protected mode enable bit

.code16                       # Assemble for 16-bit mode
.globl start
start:
  cli                         # Disable interrupts
   0:	fa                   	cli    

  # Set up the important data segment registers (DS, ES, SS).
  xorw    %ax,%ax             # Segment number zero
   1:	31 c0                	xor    %eax,%eax
  movw    %ax,%ds             # -> Data Segment
   3:	8e d8                	mov    %eax,%ds
  movw    %ax,%es             # -> Extra Segment
   5:	8e c0                	mov    %eax,%es
  movw    %ax,%ss             # -> Stack Segment
   7:	8e d0                	mov    %eax,%ss

  # Switch from real to protected mode, using a bootstrap GDT
  # and segment translation that makes virtual addresses 
  # identical to physical addresses, so that the 
  # effective memory map does not change during the switch.
  lgdt    gdtdesc
   9:	0f 01 16             	lgdtl  (%esi)
   c:	64 00 0f             	add    %cl,%fs:(%edi)
  movl    %cr0, %eax
   f:	20 c0                	and    %al,%al
  orl     $CR0_PE, %eax
  11:	66 83 c8 01          	or     $0x1,%ax
  movl    %eax, %cr0
  15:	0f 22 c0             	mov    %eax,%cr0

  # This ljmp is how you load the CS (Code Segment) register.
  # SEG_ASM produces segment descriptors with the 32-bit mode
  # flag set (the D flag), so addresses and word operands will
  # default to 32 bits after this jump.
  ljmp    $(SEG_KCODE<<3), $start32
  18:	ea 1d 00 08 00 66 b8 	ljmp   $0xb866,$0x8001d

0000001d <start32>:

.code32                       # Assemble for 32-bit mode
start32:
  # Set up the protected-mode data segment registers
  movw    $(SEG_KDATA<<3), %ax    # Our data segment selector
  1d:	66 b8 10 00          	mov    $0x10,%ax
  movw    %ax, %ds                # -> DS: Data Segment
  21:	8e d8                	mov    %eax,%ds
  movw    %ax, %es                # -> ES: Extra Segment
  23:	8e c0                	mov    %eax,%es
  movw    %ax, %ss                # -> SS: Stack Segment
  25:	8e d0                	mov    %eax,%ss
  movw    $0, %ax                 # Zero segments not ready for use
  27:	66 b8 00 00          	mov    $0x0,%ax
  movw    %ax, %fs                # -> FS
  2b:	8e e0                	mov    %eax,%fs
  movw    %ax, %gs                # -> GS
  2d:	8e e8                	mov    %eax,%gs

  # Set up the stack pointer and call into C.
  movl    start-4, %esp
  2f:	8b 25 fc ff ff ff    	mov    0xfffffffc,%esp
  call	*(start-8)
  35:	ff 15 f8 ff ff ff    	call   *0xfffffff8

  # If the call returns (it shouldn't), trigger a Bochs
  # breakpoint if running under Bochs, then loop.
  movw    $0x8a00, %ax            # 0x8a00 -> port 0x8a00
  3b:	66 b8 00 8a          	mov    $0x8a00,%ax
  movw    %ax, %dx
  3f:	66 89 c2             	mov    %ax,%dx
  outw    %ax, %dx
  42:	66 ef                	out    %ax,(%dx)
  movw    $0x8ae0, %ax            # 0x8ae0 -> port 0x8a00
  44:	66 b8 e0 8a          	mov    $0x8ae0,%ax
  outw    %ax, %dx
  48:	66 ef                	out    %ax,(%dx)

0000004a <spin>:
spin:
  jmp     spin
  4a:	eb fe                	jmp    4a <spin>

0000004c <gdt>:
	...
  54:	ff                   	(bad)  
  55:	ff 00                	incl   (%eax)
  57:	00 00                	add    %al,(%eax)
  59:	9a cf 00 ff ff 00 00 	lcall  $0x0,$0xffff00cf
  60:	00 92 cf 00 17 00    	add    %dl,0x1700cf(%edx)

00000064 <gdtdesc>:
  64:	17                   	pop    %ss
  65:	00 4c 00 00          	add    %cl,0x0(%eax,%eax,1)
	...
