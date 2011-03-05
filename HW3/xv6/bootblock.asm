
bootblock.o:     file format elf32-i386

Disassembly of section .text:

00007c00 <start>:
#define CR0_PE    1  // protected mode enable bit

.code16                       # Assemble for 16-bit mode
.globl start
start:
  cli                         # Disable interrupts
    7c00:	fa                   	cli    

  # Set up the important data segment registers (DS, ES, SS).
  xorw    %ax,%ax             # Segment number zero
    7c01:	31 c0                	xor    %eax,%eax
  movw    %ax,%ds             # -> Data Segment
    7c03:	8e d8                	mov    %eax,%ds
  movw    %ax,%es             # -> Extra Segment
    7c05:	8e c0                	mov    %eax,%es
  movw    %ax,%ss             # -> Stack Segment
    7c07:	8e d0                	mov    %eax,%ss

00007c09 <seta20.1>:
  # Enable A20:
  #   For backwards compatibility with the earliest PCs, physical
  #   address line 20 is tied low, so that addresses higher than
  #   1MB wrap around to zero by default.  This code undoes this.
seta20.1:
  inb     $0x64,%al               # Wait for not busy
    7c09:	e4 64                	in     $0x64,%al
  testb   $0x2,%al
    7c0b:	a8 02                	test   $0x2,%al
  jnz     seta20.1
    7c0d:	75 fa                	jne    7c09 <seta20.1>

  movb    $0xd1,%al               # 0xd1 -> port 0x64
    7c0f:	b0 d1                	mov    $0xd1,%al
  outb    %al,$0x64
    7c11:	e6 64                	out    %al,$0x64

00007c13 <seta20.2>:

seta20.2:
  inb     $0x64,%al               # Wait for not busy
    7c13:	e4 64                	in     $0x64,%al
  testb   $0x2,%al
    7c15:	a8 02                	test   $0x2,%al
  jnz     seta20.2
    7c17:	75 fa                	jne    7c13 <seta20.2>

  movb    $0xdf,%al               # 0xdf -> port 0x60
    7c19:	b0 df                	mov    $0xdf,%al
  outb    %al,$0x60
    7c1b:	e6 60                	out    %al,$0x60

  # Switch from real to protected mode, using a bootstrap GDT
  # and segment translation that makes virtual addresses 
  # identical to physical addresses, so that the 
  # effective memory map does not change during the switch.
  lgdt    gdtdesc
    7c1d:	0f 01 16             	lgdtl  (%esi)
    7c20:	78 7c                	js     7c9e <readsect+0x9>
  movl    %cr0, %eax
    7c22:	0f 20 c0             	mov    %cr0,%eax
  orl     $CR0_PE, %eax
    7c25:	66 83 c8 01          	or     $0x1,%ax
  movl    %eax, %cr0
    7c29:	0f 22 c0             	mov    %eax,%cr0
  
  # This ljmp is how you load the CS (Code Segment) register.
  # SEG_ASM produces segment descriptors with the 32-bit mode
  # flag set (the D flag), so addresses and word operands will
  # default to 32 bits after this jump.
  ljmp    $(SEG_KCODE<<3), $start32
    7c2c:	ea 31 7c 08 00 66 b8 	ljmp   $0xb866,$0x87c31

00007c31 <start32>:

.code32                       # Assemble for 32-bit mode
start32:
  # Set up the protected-mode data segment registers
  movw    $(SEG_KDATA<<3), %ax    # Our data segment selector
    7c31:	66 b8 10 00          	mov    $0x10,%ax
  movw    %ax, %ds                # -> DS: Data Segment
    7c35:	8e d8                	mov    %eax,%ds
  movw    %ax, %es                # -> ES: Extra Segment
    7c37:	8e c0                	mov    %eax,%es
  movw    %ax, %ss                # -> SS: Stack Segment
    7c39:	8e d0                	mov    %eax,%ss
  movw    $0, %ax                 # Zero segments not ready for use
    7c3b:	66 b8 00 00          	mov    $0x0,%ax
  movw    %ax, %fs                # -> FS
    7c3f:	8e e0                	mov    %eax,%fs
  movw    %ax, %gs                # -> GS
    7c41:	8e e8                	mov    %eax,%gs

  # Set up the stack pointer and call into C.
  movl    $start, %esp
    7c43:	bc 00 7c 00 00       	mov    $0x7c00,%esp
  call    bootmain
    7c48:	e8 ed 00 00 00       	call   7d3a <bootmain>

  # If bootmain returns (it shouldn't), trigger a Bochs
  # breakpoint if running under Bochs, then loop.
  movw    $0x8a00, %ax            # 0x8a00 -> port 0x8a00
    7c4d:	66 b8 00 8a          	mov    $0x8a00,%ax
  movw    %ax, %dx
    7c51:	66 89 c2             	mov    %ax,%dx
  outw    %ax, %dx
    7c54:	66 ef                	out    %ax,(%dx)
  movw    $0x8ae0, %ax            # 0x8ae0 -> port 0x8a00
    7c56:	66 b8 e0 8a          	mov    $0x8ae0,%ax
  outw    %ax, %dx
    7c5a:	66 ef                	out    %ax,(%dx)

00007c5c <spin>:
spin:
  jmp     spin
    7c5c:	eb fe                	jmp    7c5c <spin>
    7c5e:	66 90                	xchg   %ax,%ax

00007c60 <gdt>:
	...
    7c68:	ff                   	(bad)  
    7c69:	ff 00                	incl   (%eax)
    7c6b:	00 00                	add    %al,(%eax)
    7c6d:	9a cf 00 ff ff 00 00 	lcall  $0x0,$0xffff00cf
    7c74:	00 92 cf 00 17 00    	add    %dl,0x1700cf(%edx)

00007c78 <gdtdesc>:
    7c78:	17                   	pop    %ss
    7c79:	00 60 7c             	add    %ah,0x7c(%eax)
    7c7c:	00 00                	add    %al,(%eax)
    7c7e:	90                   	nop    
    7c7f:	90                   	nop    

00007c80 <waitdisk>:
  entry();
}

void
waitdisk(void)
{
    7c80:	55                   	push   %ebp
    7c81:	89 e5                	mov    %esp,%ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
    7c83:	ba f7 01 00 00       	mov    $0x1f7,%edx
    7c88:	ec                   	in     (%dx),%al
  // Wait for disk ready.
  while((inb(0x1F7) & 0xC0) != 0x40)
    7c89:	25 c0 00 00 00       	and    $0xc0,%eax
    7c8e:	83 f8 40             	cmp    $0x40,%eax
    7c91:	75 f0                	jne    7c83 <waitdisk+0x3>
    ;
}
    7c93:	5d                   	pop    %ebp
    7c94:	c3                   	ret    

00007c95 <readsect>:

// Read a single sector at offset into dst.
void
readsect(void *dst, uint offset)
{
    7c95:	55                   	push   %ebp
    7c96:	89 e5                	mov    %esp,%ebp
    7c98:	57                   	push   %edi
    7c99:	53                   	push   %ebx
    7c9a:	8b 7d 08             	mov    0x8(%ebp),%edi
    7c9d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  // Issue command.
  waitdisk();
    7ca0:	e8 db ff ff ff       	call   7c80 <waitdisk>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
    7ca5:	b8 01 00 00 00       	mov    $0x1,%eax
    7caa:	ba f2 01 00 00       	mov    $0x1f2,%edx
    7caf:	ee                   	out    %al,(%dx)
  outb(0x1F5, offset >> 16);
  outb(0x1F6, (offset >> 24) | 0xE0);
  outb(0x1F7, 0x20);  // cmd 0x20 - read sectors

  // Read data.
  waitdisk();
    7cb0:	b2 f3                	mov    $0xf3,%dl
    7cb2:	89 d8                	mov    %ebx,%eax
    7cb4:	ee                   	out    %al,(%dx)
    7cb5:	89 d8                	mov    %ebx,%eax
    7cb7:	c1 e8 08             	shr    $0x8,%eax
    7cba:	b2 f4                	mov    $0xf4,%dl
    7cbc:	ee                   	out    %al,(%dx)
    7cbd:	89 d8                	mov    %ebx,%eax
    7cbf:	c1 e8 10             	shr    $0x10,%eax
    7cc2:	b2 f5                	mov    $0xf5,%dl
    7cc4:	ee                   	out    %al,(%dx)
    7cc5:	89 d8                	mov    %ebx,%eax
    7cc7:	c1 e8 18             	shr    $0x18,%eax
    7cca:	83 c8 e0             	or     $0xffffffe0,%eax
    7ccd:	b2 f6                	mov    $0xf6,%dl
    7ccf:	ee                   	out    %al,(%dx)
    7cd0:	b8 20 00 00 00       	mov    $0x20,%eax
    7cd5:	b2 f7                	mov    $0xf7,%dl
    7cd7:	ee                   	out    %al,(%dx)
    7cd8:	e8 a3 ff ff ff       	call   7c80 <waitdisk>
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
    7cdd:	ba f0 01 00 00       	mov    $0x1f0,%edx
    7ce2:	b9 80 00 00 00       	mov    $0x80,%ecx
    7ce7:	fc                   	cld    
    7ce8:	f3 6d                	rep insl (%dx),%es:(%edi)
  insl(0x1F0, dst, SECTSIZE/4);
}
    7cea:	5b                   	pop    %ebx
    7ceb:	5f                   	pop    %edi
    7cec:	5d                   	pop    %ebp
    7ced:	c3                   	ret    

00007cee <readseg>:

// Read 'count' bytes at 'offset' from kernel into virtual address 'va'.
// Might copy more than asked.
void
readseg(uchar* va, uint count, uint offset)
{
    7cee:	55                   	push   %ebp
    7cef:	89 e5                	mov    %esp,%ebp
    7cf1:	57                   	push   %edi
    7cf2:	56                   	push   %esi
    7cf3:	53                   	push   %ebx
    7cf4:	83 ec 08             	sub    $0x8,%esp
    7cf7:	8b 55 08             	mov    0x8(%ebp),%edx
    7cfa:	8b 4d 10             	mov    0x10(%ebp),%ecx
  uchar* eva;

  eva = va + count;
    7cfd:	89 d7                	mov    %edx,%edi
    7cff:	03 7d 0c             	add    0xc(%ebp),%edi

  // Round down to sector boundary.
  va -= offset % SECTSIZE;
    7d02:	89 c8                	mov    %ecx,%eax
    7d04:	25 ff 01 00 00       	and    $0x1ff,%eax
    7d09:	89 d6                	mov    %edx,%esi
    7d0b:	29 c6                	sub    %eax,%esi
  offset = (offset / SECTSIZE) + 1;

  // If this is too slow, we could read lots of sectors at a time.
  // We'd write more to memory than asked, but it doesn't matter --
  // we load in increasing order.
  for(; va < eva; va += SECTSIZE, offset++)
    7d0d:	39 f7                	cmp    %esi,%edi
    7d0f:	76 21                	jbe    7d32 <readseg+0x44>

  // Round down to sector boundary.
  va -= offset % SECTSIZE;

  // Translate from bytes to sectors; kernel starts at sector 1.
  offset = (offset / SECTSIZE) + 1;
    7d11:	89 c8                	mov    %ecx,%eax
    7d13:	c1 e8 09             	shr    $0x9,%eax
    7d16:	8d 58 01             	lea    0x1(%eax),%ebx

  // If this is too slow, we could read lots of sectors at a time.
  // We'd write more to memory than asked, but it doesn't matter --
  // we load in increasing order.
  for(; va < eva; va += SECTSIZE, offset++)
    readsect(va, offset);
    7d19:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    7d1d:	89 34 24             	mov    %esi,(%esp)
    7d20:	e8 70 ff ff ff       	call   7c95 <readsect>
  offset = (offset / SECTSIZE) + 1;

  // If this is too slow, we could read lots of sectors at a time.
  // We'd write more to memory than asked, but it doesn't matter --
  // we load in increasing order.
  for(; va < eva; va += SECTSIZE, offset++)
    7d25:	81 c6 00 02 00 00    	add    $0x200,%esi
    7d2b:	83 c3 01             	add    $0x1,%ebx
    7d2e:	39 f7                	cmp    %esi,%edi
    7d30:	77 e7                	ja     7d19 <readseg+0x2b>
    readsect(va, offset);
}
    7d32:	83 c4 08             	add    $0x8,%esp
    7d35:	5b                   	pop    %ebx
    7d36:	5e                   	pop    %esi
    7d37:	5f                   	pop    %edi
    7d38:	5d                   	pop    %ebp
    7d39:	c3                   	ret    

00007d3a <bootmain>:

void readseg(uchar*, uint, uint);

void
bootmain(void)
{
    7d3a:	55                   	push   %ebp
    7d3b:	89 e5                	mov    %esp,%ebp
    7d3d:	57                   	push   %edi
    7d3e:	56                   	push   %esi
    7d3f:	53                   	push   %ebx
    7d40:	83 ec 0c             	sub    $0xc,%esp
  uchar* va;

  elf = (struct elfhdr*)0x10000;  // scratch space

  // Read 1st page off disk
  readseg((uchar*)elf, 4096, 0);
    7d43:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    7d4a:	00 
    7d4b:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    7d52:	00 
    7d53:	c7 04 24 00 00 01 00 	movl   $0x10000,(%esp)
    7d5a:	e8 8f ff ff ff       	call   7cee <readseg>

  // Is this an ELF executable?
  if(elf->magic != ELF_MAGIC)
    7d5f:	81 3d 00 00 01 00 7f 	cmpl   $0x464c457f,0x10000
    7d66:	45 4c 46 
    7d69:	75 68                	jne    7dd3 <bootmain+0x99>
    return;  // let bootasm.S handle error

  // Load each program segment (ignores ph flags).
  ph = (struct proghdr*)((uchar*)elf + elf->phoff);
    7d6b:	8b 1d 1c 00 01 00    	mov    0x1001c,%ebx
    7d71:	81 c3 00 00 01 00    	add    $0x10000,%ebx
  eph = ph + elf->phnum;
    7d77:	0f b7 05 2c 00 01 00 	movzwl 0x1002c,%eax
    7d7e:	c1 e0 05             	shl    $0x5,%eax
    7d81:	8d 34 18             	lea    (%eax,%ebx,1),%esi
  for(; ph < eph; ph++) {
    7d84:	39 f3                	cmp    %esi,%ebx
    7d86:	73 3f                	jae    7dc7 <bootmain+0x8d>
    va = (uchar*)(ph->va & 0xFFFFFF);
    7d88:	8b 7b 08             	mov    0x8(%ebx),%edi
    7d8b:	81 e7 ff ff ff 00    	and    $0xffffff,%edi
    readseg(va, ph->filesz, ph->offset);
    7d91:	8b 43 04             	mov    0x4(%ebx),%eax
    7d94:	89 44 24 08          	mov    %eax,0x8(%esp)
    7d98:	8b 43 10             	mov    0x10(%ebx),%eax
    7d9b:	89 44 24 04          	mov    %eax,0x4(%esp)
    7d9f:	89 3c 24             	mov    %edi,(%esp)
    7da2:	e8 47 ff ff ff       	call   7cee <readseg>
    if(ph->memsz > ph->filesz)
    7da7:	8b 53 14             	mov    0x14(%ebx),%edx
    7daa:	8b 43 10             	mov    0x10(%ebx),%eax
    7dad:	39 c2                	cmp    %eax,%edx
    7daf:	76 0f                	jbe    7dc0 <bootmain+0x86>
      stosb(va + ph->filesz, 0, ph->memsz - ph->filesz);
    7db1:	89 d1                	mov    %edx,%ecx
    7db3:	29 c1                	sub    %eax,%ecx
    7db5:	8d 3c 38             	lea    (%eax,%edi,1),%edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    7db8:	b8 00 00 00 00       	mov    $0x0,%eax
    7dbd:	fc                   	cld    
    7dbe:	f3 aa                	rep stos %al,%es:(%edi)
    return;  // let bootasm.S handle error

  // Load each program segment (ignores ph flags).
  ph = (struct proghdr*)((uchar*)elf + elf->phoff);
  eph = ph + elf->phnum;
  for(; ph < eph; ph++) {
    7dc0:	83 c3 20             	add    $0x20,%ebx
    7dc3:	39 de                	cmp    %ebx,%esi
    7dc5:	77 c1                	ja     7d88 <bootmain+0x4e>
  }

  // Call the entry point from the ELF header.
  // Does not return!
  entry = (void(*)(void))(elf->entry & 0xFFFFFF);
  entry();
    7dc7:	a1 18 00 01 00       	mov    0x10018,%eax
    7dcc:	25 ff ff ff 00       	and    $0xffffff,%eax
    7dd1:	ff d0                	call   *%eax
}
    7dd3:	83 c4 0c             	add    $0xc,%esp
    7dd6:	5b                   	pop    %ebx
    7dd7:	5e                   	pop    %esi
    7dd8:	5f                   	pop    %edi
    7dd9:	5d                   	pop    %ebp
    7dda:	c3                   	ret    
