
kernel:     file format elf32-i386

Disassembly of section .text:

00100000 <brelse>:
}

// Release the buffer b.
void
brelse(struct buf *b)
{
  100000:	55                   	push   %ebp
  100001:	89 e5                	mov    %esp,%ebp
  100003:	53                   	push   %ebx
  100004:	83 ec 04             	sub    $0x4,%esp
  100007:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((b->flags & B_BUSY) == 0)
  10000a:	f6 03 01             	testb  $0x1,(%ebx)
  10000d:	74 54                	je     100063 <brelse+0x63>
    panic("brelse");

  acquire(&bcache.lock);
  10000f:	c7 04 24 60 78 10 00 	movl   $0x107860,(%esp)
  100016:	e8 b5 39 00 00       	call   1039d0 <acquire>

  b->next->prev = b->prev;
  10001b:	8b 53 10             	mov    0x10(%ebx),%edx
  10001e:	8b 43 0c             	mov    0xc(%ebx),%eax
  b->next = bcache.head.next;
  b->prev = &bcache.head;
  bcache.head.next->prev = b;
  bcache.head.next = b;

  b->flags &= ~B_BUSY;
  100021:	83 23 fe             	andl   $0xfffffffe,(%ebx)
  if((b->flags & B_BUSY) == 0)
    panic("brelse");

  acquire(&bcache.lock);

  b->next->prev = b->prev;
  100024:	89 42 0c             	mov    %eax,0xc(%edx)
  b->prev->next = b->next;
  100027:	8b 43 0c             	mov    0xc(%ebx),%eax
  b->next = bcache.head.next;
  b->prev = &bcache.head;
  10002a:	c7 43 0c 84 8d 10 00 	movl   $0x108d84,0xc(%ebx)
    panic("brelse");

  acquire(&bcache.lock);

  b->next->prev = b->prev;
  b->prev->next = b->next;
  100031:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
  100034:	a1 94 8d 10 00       	mov    0x108d94,%eax
  100039:	89 43 10             	mov    %eax,0x10(%ebx)
  b->prev = &bcache.head;
  bcache.head.next->prev = b;
  10003c:	a1 94 8d 10 00       	mov    0x108d94,%eax
  bcache.head.next = b;
  100041:	89 1d 94 8d 10 00    	mov    %ebx,0x108d94

  b->next->prev = b->prev;
  b->prev->next = b->next;
  b->next = bcache.head.next;
  b->prev = &bcache.head;
  bcache.head.next->prev = b;
  100047:	89 58 0c             	mov    %ebx,0xc(%eax)
  bcache.head.next = b;

  b->flags &= ~B_BUSY;
  wakeup(b);
  10004a:	89 1c 24             	mov    %ebx,(%esp)
  10004d:	e8 6e 2f 00 00       	call   102fc0 <wakeup>

  release(&bcache.lock);
  100052:	c7 45 08 60 78 10 00 	movl   $0x107860,0x8(%ebp)
}
  100059:	83 c4 04             	add    $0x4,%esp
  10005c:	5b                   	pop    %ebx
  10005d:	5d                   	pop    %ebp
  bcache.head.next = b;

  b->flags &= ~B_BUSY;
  wakeup(b);

  release(&bcache.lock);
  10005e:	e9 2d 39 00 00       	jmp    103990 <release>
// Release the buffer b.
void
brelse(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("brelse");
  100063:	c7 04 24 60 61 10 00 	movl   $0x106160,(%esp)
  10006a:	e8 11 08 00 00       	call   100880 <panic>
  10006f:	90                   	nop    

00100070 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  100070:	55                   	push   %ebp
  100071:	89 e5                	mov    %esp,%ebp
  100073:	83 ec 08             	sub    $0x8,%esp
  100076:	8b 55 08             	mov    0x8(%ebp),%edx
  if((b->flags & B_BUSY) == 0)
  100079:	8b 02                	mov    (%edx),%eax
  10007b:	a8 01                	test   $0x1,%al
  10007d:	74 0e                	je     10008d <bwrite+0x1d>
    panic("bwrite");
  b->flags |= B_DIRTY;
  10007f:	83 c8 04             	or     $0x4,%eax
  100082:	89 02                	mov    %eax,(%edx)
  iderw(b);
  100084:	89 55 08             	mov    %edx,0x8(%ebp)
}
  100087:	c9                   	leave  
bwrite(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
  100088:	e9 d3 1d 00 00       	jmp    101e60 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("bwrite");
  10008d:	c7 04 24 67 61 10 00 	movl   $0x106167,(%esp)
  100094:	e8 e7 07 00 00       	call   100880 <panic>
  100099:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

001000a0 <bread>:
}

// Return a B_BUSY buf with the contents of the indicated disk sector.
struct buf*
bread(uint dev, uint sector)
{
  1000a0:	55                   	push   %ebp
  1000a1:	89 e5                	mov    %esp,%ebp
  1000a3:	57                   	push   %edi
  1000a4:	56                   	push   %esi
  1000a5:	53                   	push   %ebx
  1000a6:	83 ec 0c             	sub    $0xc,%esp
  1000a9:	8b 75 08             	mov    0x8(%ebp),%esi
  1000ac:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint sector)
{
  struct buf *b;

  acquire(&bcache.lock);
  1000af:	c7 04 24 60 78 10 00 	movl   $0x107860,(%esp)
  1000b6:	e8 15 39 00 00       	call   1039d0 <acquire>

 loop:
  // Try for cached block.
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
  1000bb:	8b 1d 94 8d 10 00    	mov    0x108d94,%ebx
  1000c1:	81 fb 84 8d 10 00    	cmp    $0x108d84,%ebx
  1000c7:	75 12                	jne    1000db <bread+0x3b>
  1000c9:	eb 34                	jmp    1000ff <bread+0x5f>
  1000cb:	90                   	nop    
  1000cc:	8d 74 26 00          	lea    0x0(%esi),%esi
  1000d0:	8b 5b 10             	mov    0x10(%ebx),%ebx
  1000d3:	81 fb 84 8d 10 00    	cmp    $0x108d84,%ebx
  1000d9:	74 24                	je     1000ff <bread+0x5f>
    if(b->dev == dev && b->sector == sector){
  1000db:	3b 73 04             	cmp    0x4(%ebx),%esi
  1000de:	66 90                	xchg   %ax,%ax
  1000e0:	75 ee                	jne    1000d0 <bread+0x30>
  1000e2:	3b 7b 08             	cmp    0x8(%ebx),%edi
  1000e5:	75 e9                	jne    1000d0 <bread+0x30>
      if(!(b->flags & B_BUSY)){
  1000e7:	8b 03                	mov    (%ebx),%eax
  1000e9:	a8 01                	test   $0x1,%al
  1000eb:	74 7a                	je     100167 <bread+0xc7>
        b->flags |= B_BUSY;
        release(&bcache.lock);
        return b;
      }
      sleep(b, &bcache.lock);
  1000ed:	c7 44 24 04 60 78 10 	movl   $0x107860,0x4(%esp)
  1000f4:	00 
  1000f5:	89 1c 24             	mov    %ebx,(%esp)
  1000f8:	e8 b3 2f 00 00       	call   1030b0 <sleep>
  1000fd:	eb bc                	jmp    1000bb <bread+0x1b>
      goto loop;
    }
  }

  // Allocate fresh block.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
  1000ff:	8b 1d 90 8d 10 00    	mov    0x108d90,%ebx
  100105:	81 fb 84 8d 10 00    	cmp    $0x108d84,%ebx
  10010b:	75 0e                	jne    10011b <bread+0x7b>
  10010d:	eb 4c                	jmp    10015b <bread+0xbb>
  10010f:	90                   	nop    
  100110:	8b 5b 0c             	mov    0xc(%ebx),%ebx
  100113:	81 fb 84 8d 10 00    	cmp    $0x108d84,%ebx
  100119:	74 40                	je     10015b <bread+0xbb>
    if((b->flags & B_BUSY) == 0){
  10011b:	f6 03 01             	testb  $0x1,(%ebx)
  10011e:	66 90                	xchg   %ax,%ax
  100120:	75 ee                	jne    100110 <bread+0x70>
      b->dev = dev;
  100122:	89 73 04             	mov    %esi,0x4(%ebx)
      b->sector = sector;
  100125:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = B_BUSY;
  100128:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
      release(&bcache.lock);
  10012e:	c7 04 24 60 78 10 00 	movl   $0x107860,(%esp)
  100135:	e8 56 38 00 00       	call   103990 <release>
bread(uint dev, uint sector)
{
  struct buf *b;

  b = bget(dev, sector);
  if(!(b->flags & B_VALID))
  10013a:	f6 03 02             	testb  $0x2,(%ebx)
  10013d:	74 0a                	je     100149 <bread+0xa9>
    iderw(b);
  return b;
}
  10013f:	83 c4 0c             	add    $0xc,%esp
  100142:	89 d8                	mov    %ebx,%eax
  100144:	5b                   	pop    %ebx
  100145:	5e                   	pop    %esi
  100146:	5f                   	pop    %edi
  100147:	5d                   	pop    %ebp
  100148:	c3                   	ret    
{
  struct buf *b;

  b = bget(dev, sector);
  if(!(b->flags & B_VALID))
    iderw(b);
  100149:	89 1c 24             	mov    %ebx,(%esp)
  10014c:	e8 0f 1d 00 00       	call   101e60 <iderw>
  return b;
}
  100151:	83 c4 0c             	add    $0xc,%esp
  100154:	89 d8                	mov    %ebx,%eax
  100156:	5b                   	pop    %ebx
  100157:	5e                   	pop    %esi
  100158:	5f                   	pop    %edi
  100159:	5d                   	pop    %ebp
  10015a:	c3                   	ret    
      b->flags = B_BUSY;
      release(&bcache.lock);
      return b;
    }
  }
  panic("bget: no buffers");
  10015b:	c7 04 24 6e 61 10 00 	movl   $0x10616e,(%esp)
  100162:	e8 19 07 00 00       	call   100880 <panic>
 loop:
  // Try for cached block.
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    if(b->dev == dev && b->sector == sector){
      if(!(b->flags & B_BUSY)){
        b->flags |= B_BUSY;
  100167:	83 c8 01             	or     $0x1,%eax
  10016a:	89 03                	mov    %eax,(%ebx)
        release(&bcache.lock);
  10016c:	c7 04 24 60 78 10 00 	movl   $0x107860,(%esp)
  100173:	e8 18 38 00 00       	call   103990 <release>
  100178:	eb c0                	jmp    10013a <bread+0x9a>
  10017a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100180 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
  100180:	55                   	push   %ebp
  100181:	89 e5                	mov    %esp,%ebp
  100183:	83 ec 08             	sub    $0x8,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
  100186:	c7 44 24 04 7f 61 10 	movl   $0x10617f,0x4(%esp)
  10018d:	00 
  10018e:	c7 04 24 60 78 10 00 	movl   $0x107860,(%esp)
  100195:	e8 b6 36 00 00       	call   103850 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  10019a:	ba 84 8d 10 00       	mov    $0x108d84,%edx
  10019f:	b8 94 78 10 00       	mov    $0x107894,%eax
  struct buf *b;

  initlock(&bcache.lock, "bcache");

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  1001a4:	c7 05 90 8d 10 00 84 	movl   $0x108d84,0x108d90
  1001ab:	8d 10 00 
  bcache.head.next = &bcache.head;
  1001ae:	89 15 94 8d 10 00    	mov    %edx,0x108d94
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
  1001b4:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
  1001b7:	8b 15 94 8d 10 00    	mov    0x108d94,%edx
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
    b->prev = &bcache.head;
  1001bd:	c7 40 0c 84 8d 10 00 	movl   $0x108d84,0xc(%eax)
    b->dev = -1;
  1001c4:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
    bcache.head.next = b;
  1001cb:	a3 94 8d 10 00       	mov    %eax,0x108d94
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
  1001d0:	89 42 0c             	mov    %eax,0xc(%edx)
    bcache.head.next = b;
  1001d3:	89 c2                	mov    %eax,%edx
  initlock(&bcache.lock, "bcache");

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
  1001d5:	05 18 02 00 00       	add    $0x218,%eax
  1001da:	3d 84 8d 10 00       	cmp    $0x108d84,%eax
  1001df:	75 d3                	jne    1001b4 <binit+0x34>
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
  1001e1:	c9                   	leave  
  1001e2:	c3                   	ret    
  1001e3:	90                   	nop    
  1001e4:	90                   	nop    
  1001e5:	90                   	nop    
  1001e6:	90                   	nop    
  1001e7:	90                   	nop    
  1001e8:	90                   	nop    
  1001e9:	90                   	nop    
  1001ea:	90                   	nop    
  1001eb:	90                   	nop    
  1001ec:	90                   	nop    
  1001ed:	90                   	nop    
  1001ee:	90                   	nop    
  1001ef:	90                   	nop    

001001f0 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
  1001f0:	55                   	push   %ebp
  1001f1:	89 e5                	mov    %esp,%ebp
  1001f3:	83 ec 08             	sub    $0x8,%esp
  initlock(&cons.lock, "console");
  1001f6:	c7 44 24 04 86 61 10 	movl   $0x106186,0x4(%esp)
  1001fd:	00 
  1001fe:	c7 04 24 c0 77 10 00 	movl   $0x1077c0,(%esp)
  100205:	e8 46 36 00 00       	call   103850 <initlock>
  initlock(&input.lock, "input");
  10020a:	c7 44 24 04 8e 61 10 	movl   $0x10618e,0x4(%esp)
  100211:	00 
  100212:	c7 04 24 a0 8f 10 00 	movl   $0x108fa0,(%esp)
  100219:	e8 32 36 00 00       	call   103850 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  picenable(IRQ_KBD);
  10021e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
consoleinit(void)
{
  initlock(&cons.lock, "console");
  initlock(&input.lock, "input");

  devsw[CONSOLE].write = consolewrite;
  100225:	c7 05 0c 9a 10 00 d0 	movl   $0x1003d0,0x109a0c
  10022c:	03 10 00 
  devsw[CONSOLE].read = consoleread;
  10022f:	c7 05 08 9a 10 00 10 	movl   $0x100610,0x109a08
  100236:	06 10 00 
  cons.locking = 1;
  100239:	c7 05 f4 77 10 00 01 	movl   $0x1,0x1077f4
  100240:	00 00 00 

  picenable(IRQ_KBD);
  100243:	e8 78 28 00 00       	call   102ac0 <picenable>
  ioapicenable(IRQ_KBD, 0);
  100248:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10024f:	00 
  100250:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  100257:	e8 34 1e 00 00       	call   102090 <ioapicenable>
}
  10025c:	c9                   	leave  
  10025d:	c3                   	ret    
  10025e:	66 90                	xchg   %ax,%ax

00100260 <consputc>:
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
  100260:	55                   	push   %ebp
  100261:	89 e5                	mov    %esp,%ebp
  100263:	57                   	push   %edi
  100264:	56                   	push   %esi
  100265:	89 c6                	mov    %eax,%esi
  100267:	53                   	push   %ebx
  100268:	83 ec 0c             	sub    $0xc,%esp
  if(panicked){
  10026b:	a1 a0 77 10 00       	mov    0x1077a0,%eax
  100270:	85 c0                	test   %eax,%eax
  100272:	74 03                	je     100277 <consputc+0x17>
}

static inline void
cli(void)
{
  asm volatile("cli");
  100274:	fa                   	cli    
  100275:	eb fe                	jmp    100275 <consputc+0x15>
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
  100277:	81 fe 00 01 00 00    	cmp    $0x100,%esi
  10027d:	0f 84 9f 00 00 00    	je     100322 <consputc+0xc2>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  100283:	89 34 24             	mov    %esi,(%esp)
  100286:	e8 25 4b 00 00       	call   104db0 <uartputc>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  10028b:	b9 d4 03 00 00       	mov    $0x3d4,%ecx
  100290:	b8 0e 00 00 00       	mov    $0xe,%eax
  100295:	89 ca                	mov    %ecx,%edx
  100297:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100298:	bf d5 03 00 00       	mov    $0x3d5,%edi
  10029d:	89 fa                	mov    %edi,%edx
  10029f:	ec                   	in     (%dx),%al
{
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
  1002a0:	0f b6 d8             	movzbl %al,%ebx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1002a3:	89 ca                	mov    %ecx,%edx
  1002a5:	c1 e3 08             	shl    $0x8,%ebx
  1002a8:	b8 0f 00 00 00       	mov    $0xf,%eax
  1002ad:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1002ae:	89 fa                	mov    %edi,%edx
  1002b0:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
  1002b1:	0f b6 c0             	movzbl %al,%eax
  1002b4:	09 c3                	or     %eax,%ebx

  if(c == '\n')
  1002b6:	83 fe 0a             	cmp    $0xa,%esi
  1002b9:	0f 84 eb 00 00 00    	je     1003aa <consputc+0x14a>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
  1002bf:	81 fe 00 01 00 00    	cmp    $0x100,%esi
  1002c5:	0f 84 c8 00 00 00    	je     100393 <consputc+0x133>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  1002cb:	89 f0                	mov    %esi,%eax
  1002cd:	66 25 ff 00          	and    $0xff,%ax
  1002d1:	80 cc 07             	or     $0x7,%ah
  1002d4:	66 89 84 1b 00 80 0b 	mov    %ax,0xb8000(%ebx,%ebx,1)
  1002db:	00 
  1002dc:	83 c3 01             	add    $0x1,%ebx
  
  if((pos/80) >= 24){  // Scroll up.
  1002df:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
  1002e5:	8d b4 1b 00 80 0b 00 	lea    0xb8000(%ebx,%ebx,1),%esi
  1002ec:	7f 5d                	jg     10034b <consputc+0xeb>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1002ee:	b9 d4 03 00 00       	mov    $0x3d4,%ecx
  1002f3:	b8 0e 00 00 00       	mov    $0xe,%eax
  1002f8:	89 ca                	mov    %ecx,%edx
  1002fa:	ee                   	out    %al,(%dx)
  
  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
  1002fb:	bf d5 03 00 00       	mov    $0x3d5,%edi
  100300:	89 d8                	mov    %ebx,%eax
  100302:	c1 f8 08             	sar    $0x8,%eax
  100305:	89 fa                	mov    %edi,%edx
  100307:	ee                   	out    %al,(%dx)
  100308:	b8 0f 00 00 00       	mov    $0xf,%eax
  10030d:	89 ca                	mov    %ecx,%edx
  10030f:	ee                   	out    %al,(%dx)
  100310:	89 d8                	mov    %ebx,%eax
  100312:	89 fa                	mov    %edi,%edx
  100314:	ee                   	out    %al,(%dx)
  100315:	66 c7 06 20 07       	movw   $0x720,(%esi)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
  10031a:	83 c4 0c             	add    $0xc,%esp
  10031d:	5b                   	pop    %ebx
  10031e:	5e                   	pop    %esi
  10031f:	5f                   	pop    %edi
  100320:	5d                   	pop    %ebp
  100321:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  100322:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  100329:	e8 82 4a 00 00       	call   104db0 <uartputc>
  10032e:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  100335:	e8 76 4a 00 00       	call   104db0 <uartputc>
  10033a:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  100341:	e8 6a 4a 00 00       	call   104db0 <uartputc>
  100346:	e9 40 ff ff ff       	jmp    10028b <consputc+0x2b>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  
  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
    pos -= 80;
  10034b:	83 eb 50             	sub    $0x50,%ebx
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  
  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
  10034e:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
  100355:	00 
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  100356:	8d b4 1b 00 80 0b 00 	lea    0xb8000(%ebx,%ebx,1),%esi
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  
  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
  10035d:	c7 44 24 04 a0 80 0b 	movl   $0xb80a0,0x4(%esp)
  100364:	00 
  100365:	c7 04 24 00 80 0b 00 	movl   $0xb8000,(%esp)
  10036c:	e8 6f 37 00 00       	call   103ae0 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  100371:	b8 80 07 00 00       	mov    $0x780,%eax
  100376:	29 d8                	sub    %ebx,%eax
  100378:	01 c0                	add    %eax,%eax
  10037a:	89 44 24 08          	mov    %eax,0x8(%esp)
  10037e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100385:	00 
  100386:	89 34 24             	mov    %esi,(%esp)
  100389:	e8 b2 36 00 00       	call   103a40 <memset>
  10038e:	e9 5b ff ff ff       	jmp    1002ee <consputc+0x8e>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
  100393:	85 db                	test   %ebx,%ebx
  100395:	8d b4 1b 00 80 0b 00 	lea    0xb8000(%ebx,%ebx,1),%esi
  10039c:	0f 8e 4c ff ff ff    	jle    1002ee <consputc+0x8e>
  1003a2:	83 eb 01             	sub    $0x1,%ebx
  1003a5:	e9 35 ff ff ff       	jmp    1002df <consputc+0x7f>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  1003aa:	89 d8                	mov    %ebx,%eax
  1003ac:	ba 67 66 66 66       	mov    $0x66666667,%edx
  1003b1:	f7 ea                	imul   %edx
  1003b3:	c1 ea 05             	shr    $0x5,%edx
  1003b6:	8d 14 92             	lea    (%edx,%edx,4),%edx
  1003b9:	c1 e2 04             	shl    $0x4,%edx
  1003bc:	8d 5a 50             	lea    0x50(%edx),%ebx
  1003bf:	e9 1b ff ff ff       	jmp    1002df <consputc+0x7f>
  1003c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1003ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001003d0 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
  1003d0:	55                   	push   %ebp
  1003d1:	89 e5                	mov    %esp,%ebp
  1003d3:	57                   	push   %edi
  1003d4:	56                   	push   %esi
  1003d5:	53                   	push   %ebx
  1003d6:	83 ec 0c             	sub    $0xc,%esp
  int i;

  iunlock(ip);
  1003d9:	8b 45 08             	mov    0x8(%ebp),%eax
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
  1003dc:	8b 75 10             	mov    0x10(%ebp),%esi
  1003df:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  iunlock(ip);
  1003e2:	89 04 24             	mov    %eax,(%esp)
  1003e5:	e8 b6 12 00 00       	call   1016a0 <iunlock>
  acquire(&cons.lock);
  1003ea:	c7 04 24 c0 77 10 00 	movl   $0x1077c0,(%esp)
  1003f1:	e8 da 35 00 00       	call   1039d0 <acquire>
  for(i = 0; i < n; i++)
  1003f6:	85 f6                	test   %esi,%esi
  1003f8:	7e 16                	jle    100410 <consolewrite+0x40>
  1003fa:	31 db                	xor    %ebx,%ebx
  1003fc:	8d 74 26 00          	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
  100400:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
  100404:	83 c3 01             	add    $0x1,%ebx
    consputc(buf[i] & 0xff);
  100407:	e8 54 fe ff ff       	call   100260 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
  10040c:	39 f3                	cmp    %esi,%ebx
  10040e:	75 f0                	jne    100400 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
  100410:	c7 04 24 c0 77 10 00 	movl   $0x1077c0,(%esp)
  100417:	e8 74 35 00 00       	call   103990 <release>
  ilock(ip);
  10041c:	8b 45 08             	mov    0x8(%ebp),%eax
  10041f:	89 04 24             	mov    %eax,(%esp)
  100422:	e8 99 16 00 00       	call   101ac0 <ilock>

  return n;
}
  100427:	83 c4 0c             	add    $0xc,%esp
  10042a:	89 f0                	mov    %esi,%eax
  10042c:	5b                   	pop    %ebx
  10042d:	5e                   	pop    %esi
  10042e:	5f                   	pop    %edi
  10042f:	5d                   	pop    %ebp
  100430:	c3                   	ret    
  100431:	eb 0d                	jmp    100440 <printint>
  100433:	90                   	nop    
  100434:	90                   	nop    
  100435:	90                   	nop    
  100436:	90                   	nop    
  100437:	90                   	nop    
  100438:	90                   	nop    
  100439:	90                   	nop    
  10043a:	90                   	nop    
  10043b:	90                   	nop    
  10043c:	90                   	nop    
  10043d:	90                   	nop    
  10043e:	90                   	nop    
  10043f:	90                   	nop    

00100440 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sgn)
{
  100440:	55                   	push   %ebp
  100441:	89 e5                	mov    %esp,%ebp
  100443:	57                   	push   %edi
  100444:	89 d7                	mov    %edx,%edi
  100446:	56                   	push   %esi
  100447:	53                   	push   %ebx
  100448:	83 ec 1c             	sub    $0x1c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i = 0, neg = 0;
  uint x;

  if(sgn && xx < 0){
  10044b:	85 c9                	test   %ecx,%ecx
  10044d:	74 04                	je     100453 <printint+0x13>
  10044f:	85 c0                	test   %eax,%eax
  100451:	78 55                	js     1004a8 <printint+0x68>
    neg = 1;
    x = -xx;
  } else
    x = xx;
  100453:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  10045a:	31 db                	xor    %ebx,%ebx
  10045c:	8d 75 e4             	lea    -0x1c(%ebp),%esi
  10045f:	90                   	nop    

  do{
    buf[i++] = digits[x % base];
  100460:	31 d2                	xor    %edx,%edx
  100462:	f7 f7                	div    %edi
  100464:	89 c1                	mov    %eax,%ecx
  100466:	0f b6 82 ae 61 10 00 	movzbl 0x1061ae(%edx),%eax
  10046d:	88 04 33             	mov    %al,(%ebx,%esi,1)
  100470:	83 c3 01             	add    $0x1,%ebx
  }while((x /= base) != 0);
  100473:	85 c9                	test   %ecx,%ecx
  100475:	89 c8                	mov    %ecx,%eax
  100477:	75 e7                	jne    100460 <printint+0x20>
  if(neg)
  100479:	8b 55 e0             	mov    -0x20(%ebp),%edx
  10047c:	85 d2                	test   %edx,%edx
  10047e:	74 08                	je     100488 <printint+0x48>
    buf[i++] = '-';
  100480:	c6 44 1d e4 2d       	movb   $0x2d,-0x1c(%ebp,%ebx,1)
  100485:	83 c3 01             	add    $0x1,%ebx
  100488:	8d 1c 1e             	lea    (%esi,%ebx,1),%ebx
  10048b:	90                   	nop    
  10048c:	8d 74 26 00          	lea    0x0(%esi),%esi

  while(--i >= 0)
    consputc(buf[i]);
  100490:	0f be 43 ff          	movsbl -0x1(%ebx),%eax
  100494:	83 eb 01             	sub    $0x1,%ebx
  100497:	e8 c4 fd ff ff       	call   100260 <consputc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
  10049c:	39 f3                	cmp    %esi,%ebx
  10049e:	75 f0                	jne    100490 <printint+0x50>
    consputc(buf[i]);
}
  1004a0:	83 c4 1c             	add    $0x1c,%esp
  1004a3:	5b                   	pop    %ebx
  1004a4:	5e                   	pop    %esi
  1004a5:	5f                   	pop    %edi
  1004a6:	5d                   	pop    %ebp
  1004a7:	c3                   	ret    
  int i = 0, neg = 0;
  uint x;

  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  1004a8:	f7 d8                	neg    %eax
  1004aa:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
  1004b1:	eb a7                	jmp    10045a <printint+0x1a>
  1004b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1004b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001004c0 <cprintf>:
}

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
  1004c0:	55                   	push   %ebp
  1004c1:	89 e5                	mov    %esp,%ebp
  1004c3:	57                   	push   %edi
  1004c4:	56                   	push   %esi
  1004c5:	53                   	push   %ebx
  1004c6:	83 ec 0c             	sub    $0xc,%esp
  int i, c, state, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
  1004c9:	a1 f4 77 10 00       	mov    0x1077f4,%eax
  if(locking)
  1004ce:	85 c0                	test   %eax,%eax
{
  int i, c, state, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
  1004d0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(locking)
  1004d3:	0f 85 17 01 00 00    	jne    1005f0 <cprintf+0x130>
    acquire(&cons.lock);

  argp = (uint*)(void*)(&fmt + 1);
  state = 0;
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  1004d9:	8b 7d 08             	mov    0x8(%ebp),%edi
  1004dc:	0f b6 07             	movzbl (%edi),%eax
  1004df:	85 c0                	test   %eax,%eax
  1004e1:	0f 84 82 00 00 00    	je     100569 <cprintf+0xa9>

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);

  argp = (uint*)(void*)(&fmt + 1);
  1004e7:	8d 55 0c             	lea    0xc(%ebp),%edx
  1004ea:	31 f6                	xor    %esi,%esi
  1004ec:	89 55 f0             	mov    %edx,-0x10(%ebp)
  1004ef:	eb 2f                	jmp    100520 <cprintf+0x60>
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
  1004f1:	83 fb 25             	cmp    $0x25,%ebx
  1004f4:	0f 84 a9 00 00 00    	je     1005a3 <cprintf+0xe3>
  1004fa:	83 fb 64             	cmp    $0x64,%ebx
  1004fd:	0f 84 81 00 00 00    	je     100584 <cprintf+0xc4>
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
  100503:	b8 25 00 00 00       	mov    $0x25,%eax
  100508:	e8 53 fd ff ff       	call   100260 <consputc>
      consputc(c);
  10050d:	89 d8                	mov    %ebx,%eax
  10050f:	90                   	nop    
  100510:	e8 4b fd ff ff       	call   100260 <consputc>
  if(locking)
    acquire(&cons.lock);

  argp = (uint*)(void*)(&fmt + 1);
  state = 0;
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  100515:	83 c6 01             	add    $0x1,%esi
  100518:	0f b6 04 3e          	movzbl (%esi,%edi,1),%eax
  10051c:	85 c0                	test   %eax,%eax
  10051e:	74 49                	je     100569 <cprintf+0xa9>
    if(c != '%'){
  100520:	83 f8 25             	cmp    $0x25,%eax
  100523:	75 eb                	jne    100510 <cprintf+0x50>
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
  100525:	83 c6 01             	add    $0x1,%esi
  100528:	0f b6 1c 3e          	movzbl (%esi,%edi,1),%ebx
    if(c == 0)
  10052c:	85 db                	test   %ebx,%ebx
  10052e:	74 39                	je     100569 <cprintf+0xa9>
      break;
    switch(c){
  100530:	83 fb 70             	cmp    $0x70,%ebx
  100533:	74 12                	je     100547 <cprintf+0x87>
  100535:	7e ba                	jle    1004f1 <cprintf+0x31>
  100537:	83 fb 73             	cmp    $0x73,%ebx
  10053a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100540:	74 73                	je     1005b5 <cprintf+0xf5>
  100542:	83 fb 78             	cmp    $0x78,%ebx
  100545:	75 bc                	jne    100503 <cprintf+0x43>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
  100547:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10054a:	31 c9                	xor    %ecx,%ecx
  if(locking)
    acquire(&cons.lock);

  argp = (uint*)(void*)(&fmt + 1);
  state = 0;
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  10054c:	83 c6 01             	add    $0x1,%esi
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
  10054f:	8b 02                	mov    (%edx),%eax
  100551:	83 c2 04             	add    $0x4,%edx
  100554:	89 55 f0             	mov    %edx,-0x10(%ebp)
  100557:	ba 10 00 00 00       	mov    $0x10,%edx
  10055c:	e8 df fe ff ff       	call   100440 <printint>
  if(locking)
    acquire(&cons.lock);

  argp = (uint*)(void*)(&fmt + 1);
  state = 0;
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  100561:	0f b6 04 3e          	movzbl (%esi,%edi,1),%eax
  100565:	85 c0                	test   %eax,%eax
  100567:	75 b7                	jne    100520 <cprintf+0x60>
      consputc(c);
      break;
    }
  }

  if(locking)
  100569:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  10056c:	85 c9                	test   %ecx,%ecx
  10056e:	74 0c                	je     10057c <cprintf+0xbc>
    release(&cons.lock);
  100570:	c7 04 24 c0 77 10 00 	movl   $0x1077c0,(%esp)
  100577:	e8 14 34 00 00       	call   103990 <release>
}
  10057c:	83 c4 0c             	add    $0xc,%esp
  10057f:	5b                   	pop    %ebx
  100580:	5e                   	pop    %esi
  100581:	5f                   	pop    %edi
  100582:	5d                   	pop    %ebp
  100583:	c3                   	ret    
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
    case 'd':
      printint(*argp++, 10, 1);
  100584:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100587:	b9 01 00 00 00       	mov    $0x1,%ecx
  10058c:	8b 02                	mov    (%edx),%eax
  10058e:	83 c2 04             	add    $0x4,%edx
  100591:	89 55 f0             	mov    %edx,-0x10(%ebp)
  100594:	ba 0a 00 00 00       	mov    $0xa,%edx
  100599:	e8 a2 fe ff ff       	call   100440 <printint>
  10059e:	e9 72 ff ff ff       	jmp    100515 <cprintf+0x55>
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
  1005a3:	b8 25 00 00 00       	mov    $0x25,%eax
  1005a8:	e8 b3 fc ff ff       	call   100260 <consputc>
  1005ad:	8d 76 00             	lea    0x0(%esi),%esi
  1005b0:	e9 60 ff ff ff       	jmp    100515 <cprintf+0x55>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
  1005b5:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1005b8:	8b 02                	mov    (%edx),%eax
  1005ba:	83 c2 04             	add    $0x4,%edx
  1005bd:	89 55 f0             	mov    %edx,-0x10(%ebp)
  1005c0:	ba 94 61 10 00       	mov    $0x106194,%edx
  1005c5:	85 c0                	test   %eax,%eax
  1005c7:	74 02                	je     1005cb <cprintf+0x10b>
  1005c9:	89 c2                	mov    %eax,%edx
        s = "(null)";
      for(; *s; s++)
  1005cb:	0f b6 02             	movzbl (%edx),%eax
  1005ce:	84 c0                	test   %al,%al
  1005d0:	0f 84 3f ff ff ff    	je     100515 <cprintf+0x55>
  1005d6:	89 d3                	mov    %edx,%ebx
        consputc(*s);
  1005d8:	0f be c0             	movsbl %al,%eax
  1005db:	e8 80 fc ff ff       	call   100260 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
  1005e0:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
  1005e4:	83 c3 01             	add    $0x1,%ebx
  1005e7:	84 c0                	test   %al,%al
  1005e9:	75 ed                	jne    1005d8 <cprintf+0x118>
  1005eb:	e9 25 ff ff ff       	jmp    100515 <cprintf+0x55>
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
  1005f0:	c7 04 24 c0 77 10 00 	movl   $0x1077c0,(%esp)
  1005f7:	e8 d4 33 00 00       	call   1039d0 <acquire>
  1005fc:	e9 d8 fe ff ff       	jmp    1004d9 <cprintf+0x19>
  100601:	eb 0d                	jmp    100610 <consoleread>
  100603:	90                   	nop    
  100604:	90                   	nop    
  100605:	90                   	nop    
  100606:	90                   	nop    
  100607:	90                   	nop    
  100608:	90                   	nop    
  100609:	90                   	nop    
  10060a:	90                   	nop    
  10060b:	90                   	nop    
  10060c:	90                   	nop    
  10060d:	90                   	nop    
  10060e:	90                   	nop    
  10060f:	90                   	nop    

00100610 <consoleread>:
  release(&input.lock);
}

int
consoleread(struct inode *ip, char *dst, int n)
{
  100610:	55                   	push   %ebp
  100611:	89 e5                	mov    %esp,%ebp
  100613:	57                   	push   %edi
  100614:	56                   	push   %esi
  100615:	53                   	push   %ebx
  100616:	83 ec 0c             	sub    $0xc,%esp
  100619:	8b 5d 10             	mov    0x10(%ebp),%ebx
  uint target;
  int c;

  iunlock(ip);
  10061c:	8b 45 08             	mov    0x8(%ebp),%eax
  release(&input.lock);
}

int
consoleread(struct inode *ip, char *dst, int n)
{
  10061f:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
  target = n;
  100622:	89 df                	mov    %ebx,%edi
consoleread(struct inode *ip, char *dst, int n)
{
  uint target;
  int c;

  iunlock(ip);
  100624:	89 04 24             	mov    %eax,(%esp)
  100627:	e8 74 10 00 00       	call   1016a0 <iunlock>
  target = n;
  acquire(&input.lock);
  10062c:	c7 04 24 a0 8f 10 00 	movl   $0x108fa0,(%esp)
  100633:	e8 98 33 00 00       	call   1039d0 <acquire>
  while(n > 0){
  100638:	85 db                	test   %ebx,%ebx
  10063a:	7f 26                	jg     100662 <consoleread+0x52>
  10063c:	e9 b0 00 00 00       	jmp    1006f1 <consoleread+0xe1>
    while(input.r == input.w){
      if(proc->killed){
  100641:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  100647:	8b 40 24             	mov    0x24(%eax),%eax
  10064a:	85 c0                	test   %eax,%eax
  10064c:	75 4e                	jne    10069c <consoleread+0x8c>
        release(&input.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
  10064e:	c7 44 24 04 a0 8f 10 	movl   $0x108fa0,0x4(%esp)
  100655:	00 
  100656:	c7 04 24 54 90 10 00 	movl   $0x109054,(%esp)
  10065d:	e8 4e 2a 00 00       	call   1030b0 <sleep>

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
  100662:	8b 15 54 90 10 00    	mov    0x109054,%edx
  100668:	3b 15 58 90 10 00    	cmp    0x109058,%edx
  10066e:	74 d1                	je     100641 <consoleread+0x31>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
  100670:	89 d0                	mov    %edx,%eax
  100672:	83 e0 7f             	and    $0x7f,%eax
  100675:	0f b6 88 d4 8f 10 00 	movzbl 0x108fd4(%eax),%ecx
  10067c:	8d 42 01             	lea    0x1(%edx),%eax
  10067f:	a3 54 90 10 00       	mov    %eax,0x109054
    if(c == C('D')){  // EOF
  100684:	80 f9 04             	cmp    $0x4,%cl
  100687:	74 39                	je     1006c2 <consoleread+0xb2>
        input.r--;
      }
      break;
    }
    *dst++ = c;
    --n;
  100689:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
  10068c:	80 f9 0a             	cmp    $0xa,%cl
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
  10068f:	88 0e                	mov    %cl,(%esi)
    --n;
    if(c == '\n')
  100691:	74 39                	je     1006cc <consoleread+0xbc>
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
  100693:	85 db                	test   %ebx,%ebx
  100695:	74 37                	je     1006ce <consoleread+0xbe>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
  100697:	83 c6 01             	add    $0x1,%esi
  10069a:	eb c6                	jmp    100662 <consoleread+0x52>
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
      if(proc->killed){
        release(&input.lock);
  10069c:	c7 04 24 a0 8f 10 00 	movl   $0x108fa0,(%esp)
        ilock(ip);
  1006a3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
      if(proc->killed){
        release(&input.lock);
  1006a8:	e8 e3 32 00 00       	call   103990 <release>
        ilock(ip);
  1006ad:	8b 45 08             	mov    0x8(%ebp),%eax
  1006b0:	89 04 24             	mov    %eax,(%esp)
  1006b3:	e8 08 14 00 00       	call   101ac0 <ilock>
  }
  release(&input.lock);
  ilock(ip);

  return target - n;
}
  1006b8:	83 c4 0c             	add    $0xc,%esp
  1006bb:	89 d8                	mov    %ebx,%eax
  1006bd:	5b                   	pop    %ebx
  1006be:	5e                   	pop    %esi
  1006bf:	5f                   	pop    %edi
  1006c0:	5d                   	pop    %ebp
  1006c1:	c3                   	ret    
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
  1006c2:	39 df                	cmp    %ebx,%edi
  1006c4:	76 06                	jbe    1006cc <consoleread+0xbc>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
  1006c6:	89 15 54 90 10 00    	mov    %edx,0x109054
      }
      break;
    }
    *dst++ = c;
    --n;
    if(c == '\n')
  1006cc:	29 df                	sub    %ebx,%edi
  1006ce:	89 fb                	mov    %edi,%ebx
      break;
  }
  release(&input.lock);
  1006d0:	c7 04 24 a0 8f 10 00 	movl   $0x108fa0,(%esp)
  1006d7:	e8 b4 32 00 00       	call   103990 <release>
  ilock(ip);
  1006dc:	8b 45 08             	mov    0x8(%ebp),%eax
  1006df:	89 04 24             	mov    %eax,(%esp)
  1006e2:	e8 d9 13 00 00       	call   101ac0 <ilock>

  return target - n;
}
  1006e7:	83 c4 0c             	add    $0xc,%esp
  1006ea:	89 d8                	mov    %ebx,%eax
  1006ec:	5b                   	pop    %ebx
  1006ed:	5e                   	pop    %esi
  1006ee:	5f                   	pop    %edi
  1006ef:	5d                   	pop    %ebp
  1006f0:	c3                   	ret    
  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
      if(proc->killed){
  1006f1:	31 db                	xor    %ebx,%ebx
  1006f3:	eb db                	jmp    1006d0 <consoleread+0xc0>
  1006f5:	8d 74 26 00          	lea    0x0(%esi),%esi
  1006f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00100700 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
  100700:	55                   	push   %ebp
  100701:	89 e5                	mov    %esp,%ebp
  100703:	56                   	push   %esi
  100704:	53                   	push   %ebx
  100705:	83 ec 10             	sub    $0x10,%esp
  100708:	8b 75 08             	mov    0x8(%ebp),%esi
  int c;

  acquire(&input.lock);
  10070b:	c7 04 24 a0 8f 10 00 	movl   $0x108fa0,(%esp)
  100712:	e8 b9 32 00 00       	call   1039d0 <acquire>
  while((c = getc()) >= 0){
  100717:	ff d6                	call   *%esi
  100719:	85 c0                	test   %eax,%eax
  10071b:	89 c3                	mov    %eax,%ebx
  10071d:	0f 88 a3 00 00 00    	js     1007c6 <consoleintr+0xc6>
    switch(c){
  100723:	83 fb 10             	cmp    $0x10,%ebx
  100726:	0f 84 1b 01 00 00    	je     100847 <consoleintr+0x147>
  10072c:	8d 74 26 00          	lea    0x0(%esi),%esi
  100730:	0f 8f a2 00 00 00    	jg     1007d8 <consoleintr+0xd8>
  100736:	83 fb 08             	cmp    $0x8,%ebx
  100739:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  100740:	0f 84 a0 00 00 00    	je     1007e6 <consoleintr+0xe6>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
  100746:	85 db                	test   %ebx,%ebx
  100748:	74 cd                	je     100717 <consoleintr+0x17>
  10074a:	8b 15 5c 90 10 00    	mov    0x10905c,%edx
  100750:	89 d0                	mov    %edx,%eax
  100752:	2b 05 54 90 10 00    	sub    0x109054,%eax
  100758:	83 f8 7f             	cmp    $0x7f,%eax
  10075b:	77 ba                	ja     100717 <consoleintr+0x17>
        c = (c == '\r') ? '\n' : c;
  10075d:	83 fb 0d             	cmp    $0xd,%ebx
  100760:	0f 84 ef 00 00 00    	je     100855 <consoleintr+0x155>
        input.buf[input.e++ % INPUT_BUF] = c;
  100766:	89 d0                	mov    %edx,%eax
  100768:	83 e0 7f             	and    $0x7f,%eax
  10076b:	88 98 d4 8f 10 00    	mov    %bl,0x108fd4(%eax)
  100771:	8d 42 01             	lea    0x1(%edx),%eax
  100774:	a3 5c 90 10 00       	mov    %eax,0x10905c
        consputc(c);
  100779:	89 d8                	mov    %ebx,%eax
  10077b:	e8 e0 fa ff ff       	call   100260 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
  100780:	83 fb 0a             	cmp    $0xa,%ebx
  100783:	0f 84 ea 00 00 00    	je     100873 <consoleintr+0x173>
  100789:	83 fb 04             	cmp    $0x4,%ebx
  10078c:	0f 84 e1 00 00 00    	je     100873 <consoleintr+0x173>
  100792:	a1 54 90 10 00       	mov    0x109054,%eax
  100797:	8b 15 5c 90 10 00    	mov    0x10905c,%edx
  10079d:	83 e8 80             	sub    $0xffffff80,%eax
  1007a0:	39 c2                	cmp    %eax,%edx
  1007a2:	0f 85 6f ff ff ff    	jne    100717 <consoleintr+0x17>
          input.w = input.e;
  1007a8:	89 15 58 90 10 00    	mov    %edx,0x109058
          wakeup(&input.r);
  1007ae:	c7 04 24 54 90 10 00 	movl   $0x109054,(%esp)
  1007b5:	e8 06 28 00 00       	call   102fc0 <wakeup>
consoleintr(int (*getc)(void))
{
  int c;

  acquire(&input.lock);
  while((c = getc()) >= 0){
  1007ba:	ff d6                	call   *%esi
  1007bc:	85 c0                	test   %eax,%eax
  1007be:	89 c3                	mov    %eax,%ebx
  1007c0:	0f 89 5d ff ff ff    	jns    100723 <consoleintr+0x23>
        }
      }
      break;
    }
  }
  release(&input.lock);
  1007c6:	c7 45 08 a0 8f 10 00 	movl   $0x108fa0,0x8(%ebp)
}
  1007cd:	83 c4 10             	add    $0x10,%esp
  1007d0:	5b                   	pop    %ebx
  1007d1:	5e                   	pop    %esi
  1007d2:	5d                   	pop    %ebp
        }
      }
      break;
    }
  }
  release(&input.lock);
  1007d3:	e9 b8 31 00 00       	jmp    103990 <release>
{
  int c;

  acquire(&input.lock);
  while((c = getc()) >= 0){
    switch(c){
  1007d8:	83 fb 15             	cmp    $0x15,%ebx
  1007db:	74 58                	je     100835 <consoleintr+0x135>
  1007dd:	83 fb 7f             	cmp    $0x7f,%ebx
  1007e0:	0f 85 60 ff ff ff    	jne    100746 <consoleintr+0x46>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
  1007e6:	a1 5c 90 10 00       	mov    0x10905c,%eax
  1007eb:	3b 05 58 90 10 00    	cmp    0x109058,%eax
  1007f1:	0f 84 20 ff ff ff    	je     100717 <consoleintr+0x17>
        input.e--;
  1007f7:	83 e8 01             	sub    $0x1,%eax
  1007fa:	a3 5c 90 10 00       	mov    %eax,0x10905c
        consputc(BACKSPACE);
  1007ff:	b8 00 01 00 00       	mov    $0x100,%eax
  100804:	e8 57 fa ff ff       	call   100260 <consputc>
  100809:	e9 09 ff ff ff       	jmp    100717 <consoleintr+0x17>
  10080e:	66 90                	xchg   %ax,%ax
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
  100810:	8d 50 ff             	lea    -0x1(%eax),%edx
  100813:	89 d0                	mov    %edx,%eax
  100815:	83 e0 7f             	and    $0x7f,%eax
  100818:	80 b8 d4 8f 10 00 0a 	cmpb   $0xa,0x108fd4(%eax)
  10081f:	0f 84 f2 fe ff ff    	je     100717 <consoleintr+0x17>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
  100825:	b8 00 01 00 00       	mov    $0x100,%eax
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
  10082a:	89 15 5c 90 10 00    	mov    %edx,0x10905c
        consputc(BACKSPACE);
  100830:	e8 2b fa ff ff       	call   100260 <consputc>
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
  100835:	a1 5c 90 10 00       	mov    0x10905c,%eax
  10083a:	3b 05 58 90 10 00    	cmp    0x109058,%eax
  100840:	75 ce                	jne    100810 <consoleintr+0x110>
  100842:	e9 d0 fe ff ff       	jmp    100717 <consoleintr+0x17>

  acquire(&input.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      procdump();
  100847:	e8 24 2f 00 00       	call   103770 <procdump>
  10084c:	8d 74 26 00          	lea    0x0(%esi),%esi
  100850:	e9 c2 fe ff ff       	jmp    100717 <consoleintr+0x17>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
  100855:	89 d0                	mov    %edx,%eax
  100857:	83 e0 7f             	and    $0x7f,%eax
  10085a:	c6 80 d4 8f 10 00 0a 	movb   $0xa,0x108fd4(%eax)
  100861:	8d 42 01             	lea    0x1(%edx),%eax
  100864:	a3 5c 90 10 00       	mov    %eax,0x10905c
        consputc(c);
  100869:	b8 0a 00 00 00       	mov    $0xa,%eax
  10086e:	e8 ed f9 ff ff       	call   100260 <consputc>
  100873:	8b 15 5c 90 10 00    	mov    0x10905c,%edx
  100879:	e9 2a ff ff ff       	jmp    1007a8 <consoleintr+0xa8>
  10087e:	66 90                	xchg   %ax,%ax

00100880 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
  100880:	55                   	push   %ebp
  100881:	89 e5                	mov    %esp,%ebp
  100883:	56                   	push   %esi
  100884:	53                   	push   %ebx
  100885:	83 ec 40             	sub    $0x40,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
  100888:	fa                   	cli    
  int i;
  uint pcs[10];
  
  cli();
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  100889:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  10088f:	8d 75 d0             	lea    -0x30(%ebp),%esi
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
  100892:	bb 02 00 00 00       	mov    $0x2,%ebx
{
  int i;
  uint pcs[10];
  
  cli();
  cons.locking = 0;
  100897:	c7 05 f4 77 10 00 00 	movl   $0x0,0x1077f4
  10089e:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
  1008a1:	0f b6 00             	movzbl (%eax),%eax
  1008a4:	c7 04 24 9b 61 10 00 	movl   $0x10619b,(%esp)
  1008ab:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008af:	e8 0c fc ff ff       	call   1004c0 <cprintf>
  cprintf(s);
  1008b4:	8b 45 08             	mov    0x8(%ebp),%eax
  1008b7:	89 04 24             	mov    %eax,(%esp)
  1008ba:	e8 01 fc ff ff       	call   1004c0 <cprintf>
  cprintf("\n");
  1008bf:	c7 04 24 d6 65 10 00 	movl   $0x1065d6,(%esp)
  1008c6:	e8 f5 fb ff ff       	call   1004c0 <cprintf>
  getcallerpcs(&s, pcs);
  1008cb:	8d 45 08             	lea    0x8(%ebp),%eax
  1008ce:	89 04 24             	mov    %eax,(%esp)
  1008d1:	89 74 24 04          	mov    %esi,0x4(%esp)
  1008d5:	e8 96 2f 00 00       	call   103870 <getcallerpcs>
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
  1008da:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1008dd:	c7 04 24 aa 61 10 00 	movl   $0x1061aa,(%esp)
  1008e4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008e8:	e8 d3 fb ff ff       	call   1004c0 <cprintf>
  1008ed:	8b 44 9e fc          	mov    -0x4(%esi,%ebx,4),%eax
  1008f1:	83 c3 01             	add    $0x1,%ebx
  1008f4:	c7 04 24 aa 61 10 00 	movl   $0x1061aa,(%esp)
  1008fb:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008ff:	e8 bc fb ff ff       	call   1004c0 <cprintf>
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
  100904:	83 fb 0b             	cmp    $0xb,%ebx
  100907:	75 e4                	jne    1008ed <panic+0x6d>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
  100909:	c7 05 a0 77 10 00 01 	movl   $0x1,0x1077a0
  100910:	00 00 00 
  100913:	eb fe                	jmp    100913 <panic+0x93>
  100915:	90                   	nop    
  100916:	90                   	nop    
  100917:	90                   	nop    
  100918:	90                   	nop    
  100919:	90                   	nop    
  10091a:	90                   	nop    
  10091b:	90                   	nop    
  10091c:	90                   	nop    
  10091d:	90                   	nop    
  10091e:	90                   	nop    
  10091f:	90                   	nop    

00100920 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
  100920:	55                   	push   %ebp
  100921:	89 e5                	mov    %esp,%ebp
  100923:	57                   	push   %edi
  100924:	56                   	push   %esi
  100925:	53                   	push   %ebx
  100926:	81 ec 9c 00 00 00    	sub    $0x9c,%esp
  pde_t *pgdir, *oldpgdir;

  pgdir = 0;
  sz = 0;

  if((ip = namei(path)) == 0)
  10092c:	8b 45 08             	mov    0x8(%ebp),%eax
  10092f:	89 04 24             	mov    %eax,(%esp)
  100932:	e8 19 14 00 00       	call   101d50 <namei>
  100937:	89 c3                	mov    %eax,%ebx
  100939:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10093e:	85 db                	test   %ebx,%ebx
  100940:	74 42                	je     100984 <exec+0x64>
    return -1;
  ilock(ip);
  100942:	89 1c 24             	mov    %ebx,(%esp)
  100945:	e8 76 11 00 00       	call   101ac0 <ilock>

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
  10094a:	8d 45 a0             	lea    -0x60(%ebp),%eax
  10094d:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
  100954:	00 
  100955:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  10095c:	00 
  10095d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100961:	89 1c 24             	mov    %ebx,(%esp)
  100964:	e8 f7 0a 00 00       	call   101460 <readi>
  100969:	83 f8 33             	cmp    $0x33,%eax
  10096c:	76 09                	jbe    100977 <exec+0x57>
    goto bad;
  if(elf.magic != ELF_MAGIC)
  10096e:	81 7d a0 7f 45 4c 46 	cmpl   $0x464c457f,-0x60(%ebp)
  100975:	74 18                	je     10098f <exec+0x6f>

  return 0;

 bad:
  if(pgdir) freevm(pgdir);
  iunlockput(ip);
  100977:	89 1c 24             	mov    %ebx,(%esp)
  10097a:	e8 21 11 00 00       	call   101aa0 <iunlockput>
  10097f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return -1;
}
  100984:	81 c4 9c 00 00 00    	add    $0x9c,%esp
  10098a:	5b                   	pop    %ebx
  10098b:	5e                   	pop    %esi
  10098c:	5f                   	pop    %edi
  10098d:	5d                   	pop    %ebp
  10098e:	c3                   	ret    
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
    goto bad;

  if(!(pgdir = setupkvm()))
  10098f:	e8 cc 51 00 00       	call   105b60 <setupkvm>
  100994:	85 c0                	test   %eax,%eax
  100996:	89 45 88             	mov    %eax,-0x78(%ebp)
  100999:	74 dc                	je     100977 <exec+0x57>
    goto bad;

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  10099b:	66 83 7d cc 00       	cmpw   $0x0,-0x34(%ebp)
  1009a0:	be 00 10 00 00       	mov    $0x1000,%esi
  1009a5:	8b 45 bc             	mov    -0x44(%ebp),%eax
  1009a8:	c7 45 8c 00 00 00 00 	movl   $0x0,-0x74(%ebp)
  1009af:	0f 84 d0 00 00 00    	je     100a85 <exec+0x165>
  1009b5:	89 c6                	mov    %eax,%esi
  1009b7:	31 ff                	xor    %edi,%edi
  1009b9:	c7 45 80 00 00 00 00 	movl   $0x0,-0x80(%ebp)
  1009c0:	eb 12                	jmp    1009d4 <exec+0xb4>
  1009c2:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
  1009c6:	83 c7 01             	add    $0x1,%edi
  1009c9:	39 f8                	cmp    %edi,%eax
  1009cb:	0f 8e 9a 00 00 00    	jle    100a6b <exec+0x14b>
  1009d1:	83 c6 20             	add    $0x20,%esi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
  1009d4:	8d 55 d4             	lea    -0x2c(%ebp),%edx
  1009d7:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
  1009de:	00 
  1009df:	89 74 24 08          	mov    %esi,0x8(%esp)
  1009e3:	89 54 24 04          	mov    %edx,0x4(%esp)
  1009e7:	89 1c 24             	mov    %ebx,(%esp)
  1009ea:	e8 71 0a 00 00       	call   101460 <readi>
  1009ef:	83 f8 20             	cmp    $0x20,%eax
  1009f2:	75 67                	jne    100a5b <exec+0x13b>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
  1009f4:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
  1009f8:	75 c8                	jne    1009c2 <exec+0xa2>
      continue;
    if(ph.memsz < ph.filesz)
  1009fa:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1009fd:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  100a00:	72 59                	jb     100a5b <exec+0x13b>
      goto bad;
    if(!(sz = allocuvm(pgdir, sz, ph.va + ph.memsz)))
  100a02:	03 45 dc             	add    -0x24(%ebp),%eax
  100a05:	8b 4d 80             	mov    -0x80(%ebp),%ecx
  100a08:	89 44 24 08          	mov    %eax,0x8(%esp)
  100a0c:	8b 45 88             	mov    -0x78(%ebp),%eax
  100a0f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100a13:	89 04 24             	mov    %eax,(%esp)
  100a16:	e8 e5 53 00 00       	call   105e00 <allocuvm>
  100a1b:	85 c0                	test   %eax,%eax
  100a1d:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
  100a23:	74 36                	je     100a5b <exec+0x13b>
      goto bad;
    if(!loaduvm(pgdir, (char *)ph.va, ip, ph.offset, ph.filesz))
  100a25:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100a28:	8b 55 88             	mov    -0x78(%ebp),%edx
  100a2b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  100a2f:	89 44 24 10          	mov    %eax,0x10(%esp)
  100a33:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100a36:	89 14 24             	mov    %edx,(%esp)
  100a39:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100a3d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100a40:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a44:	e8 87 54 00 00       	call   105ed0 <loaduvm>
  100a49:	85 c0                	test   %eax,%eax
  100a4b:	74 0e                	je     100a5b <exec+0x13b>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
      continue;
    if(ph.memsz < ph.filesz)
      goto bad;
    if(!(sz = allocuvm(pgdir, sz, ph.va + ph.memsz)))
  100a4d:	8b 8d 70 ff ff ff    	mov    -0x90(%ebp),%ecx
  100a53:	89 4d 80             	mov    %ecx,-0x80(%ebp)
  100a56:	e9 67 ff ff ff       	jmp    1009c2 <exec+0xa2>
  freevm(oldpgdir);

  return 0;

 bad:
  if(pgdir) freevm(pgdir);
  100a5b:	8b 7d 88             	mov    -0x78(%ebp),%edi
  100a5e:	89 3c 24             	mov    %edi,(%esp)
  100a61:	e8 5a 52 00 00       	call   105cc0 <freevm>
  100a66:	e9 0c ff ff ff       	jmp    100977 <exec+0x57>

  if(!(pgdir = setupkvm()))
    goto bad;

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100a6b:	8b 7d 80             	mov    -0x80(%ebp),%edi
  100a6e:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
  100a74:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  100a7a:	89 fe                	mov    %edi,%esi
  100a7c:	89 7d 8c             	mov    %edi,-0x74(%ebp)
  100a7f:	81 c6 00 10 00 00    	add    $0x1000,%esi
    if(!(sz = allocuvm(pgdir, sz, ph.va + ph.memsz)))
      goto bad;
    if(!loaduvm(pgdir, (char *)ph.va, ip, ph.offset, ph.filesz))
      goto bad;
  }
  iunlockput(ip);
  100a85:	89 1c 24             	mov    %ebx,(%esp)
  100a88:	e8 13 10 00 00       	call   101aa0 <iunlockput>

  // Allocate and initialize stack at sz
  sz = spbottom = PGROUNDUP(sz);
  if(!(sz = allocuvm(pgdir, sz, sz + PGSIZE)))
  100a8d:	8b 45 8c             	mov    -0x74(%ebp),%eax
  100a90:	8b 55 88             	mov    -0x78(%ebp),%edx
  100a93:	89 74 24 08          	mov    %esi,0x8(%esp)
  100a97:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a9b:	89 14 24             	mov    %edx,(%esp)
  100a9e:	e8 5d 53 00 00       	call   105e00 <allocuvm>
  100aa3:	85 c0                	test   %eax,%eax
  100aa5:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
  100aab:	74 ae                	je     100a5b <exec+0x13b>
    goto bad;
  mem = uva2ka(pgdir, (char *)spbottom);
  100aad:	8b 5d 88             	mov    -0x78(%ebp),%ebx

  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100ab0:	31 f6                	xor    %esi,%esi

  // Allocate and initialize stack at sz
  sz = spbottom = PGROUNDUP(sz);
  if(!(sz = allocuvm(pgdir, sz, sz + PGSIZE)))
    goto bad;
  mem = uva2ka(pgdir, (char *)spbottom);
  100ab2:	8b 4d 8c             	mov    -0x74(%ebp),%ecx
  100ab5:	89 1c 24             	mov    %ebx,(%esp)

  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100ab8:	31 db                	xor    %ebx,%ebx

  // Allocate and initialize stack at sz
  sz = spbottom = PGROUNDUP(sz);
  if(!(sz = allocuvm(pgdir, sz, sz + PGSIZE)))
    goto bad;
  mem = uva2ka(pgdir, (char *)spbottom);
  100aba:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100abe:	e8 4d 4f 00 00       	call   105a10 <uva2ka>

  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100ac3:	8b 7d 0c             	mov    0xc(%ebp),%edi

  // Allocate and initialize stack at sz
  sz = spbottom = PGROUNDUP(sz);
  if(!(sz = allocuvm(pgdir, sz, sz + PGSIZE)))
    goto bad;
  mem = uva2ka(pgdir, (char *)spbottom);
  100ac6:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)

  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100acc:	8b 17                	mov    (%edi),%edx
  100ace:	85 d2                	test   %edx,%edx
  100ad0:	0f 84 7c 01 00 00    	je     100c52 <exec+0x332>
    arglen += strlen(argv[argc]) + 1;
  100ad6:	89 14 24             	mov    %edx,(%esp)
  if(!(sz = allocuvm(pgdir, sz, sz + PGSIZE)))
    goto bad;
  mem = uva2ka(pgdir, (char *)spbottom);

  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100ad9:	83 c3 01             	add    $0x1,%ebx
    arglen += strlen(argv[argc]) + 1;
  100adc:	e8 5f 31 00 00       	call   103c40 <strlen>
  if(!(sz = allocuvm(pgdir, sz, sz + PGSIZE)))
    goto bad;
  mem = uva2ka(pgdir, (char *)spbottom);

  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100ae1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  100ae4:	89 9d 78 ff ff ff    	mov    %ebx,-0x88(%ebp)
  100aea:	8b 14 99             	mov    (%ecx,%ebx,4),%edx
    arglen += strlen(argv[argc]) + 1;
  100aed:	01 f0                	add    %esi,%eax
  100aef:	8d 70 01             	lea    0x1(%eax),%esi
  if(!(sz = allocuvm(pgdir, sz, sz + PGSIZE)))
    goto bad;
  mem = uva2ka(pgdir, (char *)spbottom);

  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100af2:	85 d2                	test   %edx,%edx
  100af4:	75 e0                	jne    100ad6 <exec+0x1b6>
  100af6:	89 d9                	mov    %ebx,%ecx
  100af8:	83 c0 04             	add    $0x4,%eax
  100afb:	8d 14 9d 04 00 00 00 	lea    0x4(,%ebx,4),%edx
  100b02:	83 eb 01             	sub    $0x1,%ebx
  100b05:	83 e0 fc             	and    $0xfffffffc,%eax
  100b08:	c1 e1 02             	shl    $0x2,%ecx
  100b0b:	89 5d 90             	mov    %ebx,-0x70(%ebp)
    arglen += strlen(argv[argc]) + 1;
  arglen = (arglen+3) & ~3;

  sp = sz;
  argp = sz - arglen - 4*(argc+1);
  100b0e:	8b 9d 74 ff ff ff    	mov    -0x8c(%ebp),%ebx
  100b14:	29 c3                	sub    %eax,%ebx
  100b16:	29 d3                	sub    %edx,%ebx

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp-spbottom + 4*argc) = 0;  // argv[argc]
  100b18:	8b 95 7c ff ff ff    	mov    -0x84(%ebp),%edx
  for(argc=0; argv[argc]; argc++)
    arglen += strlen(argv[argc]) + 1;
  arglen = (arglen+3) & ~3;

  sp = sz;
  argp = sz - arglen - 4*(argc+1);
  100b1e:	89 5d 84             	mov    %ebx,-0x7c(%ebp)

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp-spbottom + 4*argc) = 0;  // argv[argc]
  100b21:	01 da                	add    %ebx,%edx
  100b23:	2b 55 8c             	sub    -0x74(%ebp),%edx
  100b26:	c7 04 0a 00 00 00 00 	movl   $0x0,(%edx,%ecx,1)
  for(i=argc-1; i>=0; i--){
  100b2d:	8b 45 90             	mov    -0x70(%ebp),%eax
  100b30:	85 c0                	test   %eax,%eax
  100b32:	78 53                	js     100b87 <exec+0x267>
  100b34:	8b 45 90             	mov    -0x70(%ebp),%eax
  100b37:	8b 7d 0c             	mov    0xc(%ebp),%edi
  100b3a:	8b 9d 74 ff ff ff    	mov    -0x8c(%ebp),%ebx
  100b40:	c1 e0 02             	shl    $0x2,%eax
  100b43:	8d 34 38             	lea    (%eax,%edi,1),%esi
  100b46:	8d 3c 02             	lea    (%edx,%eax,1),%edi
    len = strlen(argv[i]) + 1;
  100b49:	8b 06                	mov    (%esi),%eax
  100b4b:	89 04 24             	mov    %eax,(%esp)
  100b4e:	e8 ed 30 00 00       	call   103c40 <strlen>
    sp -= len;
  100b53:	83 c0 01             	add    $0x1,%eax
  100b56:	29 c3                	sub    %eax,%ebx
    memmove(mem+sp-spbottom, argv[i], len);
  100b58:	89 44 24 08          	mov    %eax,0x8(%esp)
  100b5c:	8b 06                	mov    (%esi),%eax
  sp = sz;
  argp = sz - arglen - 4*(argc+1);

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp-spbottom + 4*argc) = 0;  // argv[argc]
  for(i=argc-1; i>=0; i--){
  100b5e:	83 ee 04             	sub    $0x4,%esi
    len = strlen(argv[i]) + 1;
    sp -= len;
    memmove(mem+sp-spbottom, argv[i], len);
  100b61:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b65:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  100b6b:	01 d8                	add    %ebx,%eax
  100b6d:	2b 45 8c             	sub    -0x74(%ebp),%eax
  100b70:	89 04 24             	mov    %eax,(%esp)
  100b73:	e8 68 2f 00 00       	call   103ae0 <memmove>
    *(uint*)(mem+argp-spbottom + 4*i) = sp;  // argv[i]
  100b78:	89 1f                	mov    %ebx,(%edi)
  sp = sz;
  argp = sz - arglen - 4*(argc+1);

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp-spbottom + 4*argc) = 0;  // argv[argc]
  for(i=argc-1; i>=0; i--){
  100b7a:	83 ef 04             	sub    $0x4,%edi
  100b7d:	83 6d 90 01          	subl   $0x1,-0x70(%ebp)
  100b81:	83 7d 90 ff          	cmpl   $0xffffffff,-0x70(%ebp)
  100b85:	75 c2                	jne    100b49 <exec+0x229>
  }

  // Stack frame for main(argc, argv), below arguments.
  sp = argp;
  sp -= 4;
  *(uint*)(mem+sp-spbottom) = argp;
  100b87:	8b 55 84             	mov    -0x7c(%ebp),%edx
  100b8a:	8b 8d 7c ff ff ff    	mov    -0x84(%ebp),%ecx
  sp -= 4;
  *(uint*)(mem+sp-spbottom) = argc;
  sp -= 4;
  100b90:	89 d6                	mov    %edx,%esi
  }

  // Stack frame for main(argc, argv), below arguments.
  sp = argp;
  sp -= 4;
  *(uint*)(mem+sp-spbottom) = argp;
  100b92:	8d 44 0a fc          	lea    -0x4(%edx,%ecx,1),%eax
  sp -= 4;
  *(uint*)(mem+sp-spbottom) = argc;
  sp -= 4;
  100b96:	83 ee 0c             	sub    $0xc,%esi
  }

  // Stack frame for main(argc, argv), below arguments.
  sp = argp;
  sp -= 4;
  *(uint*)(mem+sp-spbottom) = argp;
  100b99:	2b 45 8c             	sub    -0x74(%ebp),%eax
  100b9c:	89 10                	mov    %edx,(%eax)
  sp -= 4;
  *(uint*)(mem+sp-spbottom) = argc;
  100b9e:	8b 9d 78 ff ff ff    	mov    -0x88(%ebp),%ebx
  100ba4:	8d 44 0a f8          	lea    -0x8(%edx,%ecx,1),%eax
  100ba8:	2b 45 8c             	sub    -0x74(%ebp),%eax
  100bab:	89 18                	mov    %ebx,(%eax)
  sp -= 4;
  *(uint*)(mem+sp-spbottom) = 0xffffffff;   // fake return pc
  100bad:	89 c8                	mov    %ecx,%eax
  100baf:	01 f0                	add    %esi,%eax
  100bb1:	2b 45 8c             	sub    -0x74(%ebp),%eax
  100bb4:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)

  // Save program name for debugging.
  for(last=s=path; *s; s++)
  100bba:	8b 7d 08             	mov    0x8(%ebp),%edi
  100bbd:	0f b6 17             	movzbl (%edi),%edx
  100bc0:	89 f9                	mov    %edi,%ecx
  100bc2:	84 d2                	test   %dl,%dl
  100bc4:	74 1a                	je     100be0 <exec+0x2c0>
  100bc6:	89 f8                	mov    %edi,%eax
  100bc8:	83 c0 01             	add    $0x1,%eax
  100bcb:	eb 0a                	jmp    100bd7 <exec+0x2b7>
  100bcd:	0f b6 10             	movzbl (%eax),%edx
  100bd0:	83 c0 01             	add    $0x1,%eax
  100bd3:	84 d2                	test   %dl,%dl
  100bd5:	74 09                	je     100be0 <exec+0x2c0>
    if(*s == '/')
  100bd7:	80 fa 2f             	cmp    $0x2f,%dl
  100bda:	75 f1                	jne    100bcd <exec+0x2ad>
  100bdc:	89 c1                	mov    %eax,%ecx
  100bde:	eb ed                	jmp    100bcd <exec+0x2ad>
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
  100be0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  100be6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100bea:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  100bf1:	00 
  100bf2:	83 c0 6c             	add    $0x6c,%eax
  100bf5:	89 04 24             	mov    %eax,(%esp)
  100bf8:	e8 03 30 00 00       	call   103c00 <safestrcpy>

  // Commit to the user image.
  oldpgdir = proc->pgdir;
  100bfd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  proc->pgdir = pgdir;
  100c03:	8b 55 88             	mov    -0x78(%ebp),%edx
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));

  // Commit to the user image.
  oldpgdir = proc->pgdir;
  100c06:	8b 58 04             	mov    0x4(%eax),%ebx
  proc->pgdir = pgdir;
  100c09:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
  100c0c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  100c12:	8b 8d 74 ff ff ff    	mov    -0x8c(%ebp),%ecx
  100c18:	89 08                	mov    %ecx,(%eax)
  proc->tf->eip = elf.entry;  // main
  100c1a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  100c20:	8b 50 18             	mov    0x18(%eax),%edx
  100c23:	8b 45 b8             	mov    -0x48(%ebp),%eax
  100c26:	89 42 38             	mov    %eax,0x38(%edx)
  proc->tf->esp = sp;
  100c29:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  100c2f:	8b 40 18             	mov    0x18(%eax),%eax
  100c32:	89 70 44             	mov    %esi,0x44(%eax)

  switchuvm(proc); 
  100c35:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  100c3b:	89 04 24             	mov    %eax,(%esp)
  100c3e:	e8 3d 53 00 00       	call   105f80 <switchuvm>

  freevm(oldpgdir);
  100c43:	89 1c 24             	mov    %ebx,(%esp)
  100c46:	e8 75 50 00 00       	call   105cc0 <freevm>
  100c4b:	31 c0                	xor    %eax,%eax
  100c4d:	e9 32 fd ff ff       	jmp    100984 <exec+0x64>
  if(!(sz = allocuvm(pgdir, sz, sz + PGSIZE)))
    goto bad;
  mem = uva2ka(pgdir, (char *)spbottom);

  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100c52:	31 c0                	xor    %eax,%eax
  100c54:	b2 04                	mov    $0x4,%dl
  100c56:	31 c9                	xor    %ecx,%ecx
  100c58:	c7 85 78 ff ff ff 00 	movl   $0x0,-0x88(%ebp)
  100c5f:	00 00 00 
  100c62:	c7 45 90 ff ff ff ff 	movl   $0xffffffff,-0x70(%ebp)
  100c69:	e9 a0 fe ff ff       	jmp    100b0e <exec+0x1ee>
  100c6e:	90                   	nop    
  100c6f:	90                   	nop    

00100c70 <filewrite>:
}

// Write to file f.  Addr is kernel address.
int
filewrite(struct file *f, char *addr, int n)
{
  100c70:	55                   	push   %ebp
  100c71:	89 e5                	mov    %esp,%ebp
  100c73:	83 ec 28             	sub    $0x28,%esp
  100c76:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  100c79:	8b 5d 08             	mov    0x8(%ebp),%ebx
  100c7c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  100c7f:	8b 75 10             	mov    0x10(%ebp),%esi
  100c82:	89 7d fc             	mov    %edi,-0x4(%ebp)
  100c85:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int r;

  if(f->writable == 0)
  100c88:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
  100c8c:	74 54                	je     100ce2 <filewrite+0x72>
    return -1;
  if(f->type == FD_PIPE)
  100c8e:	8b 03                	mov    (%ebx),%eax
  100c90:	83 f8 01             	cmp    $0x1,%eax
  100c93:	74 54                	je     100ce9 <filewrite+0x79>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
  100c95:	83 f8 02             	cmp    $0x2,%eax
  100c98:	75 66                	jne    100d00 <filewrite+0x90>
    ilock(f->ip);
  100c9a:	8b 43 10             	mov    0x10(%ebx),%eax
  100c9d:	89 04 24             	mov    %eax,(%esp)
  100ca0:	e8 1b 0e 00 00       	call   101ac0 <ilock>
    if((r = writei(f->ip, addr, f->off, n)) > 0)
  100ca5:	89 74 24 0c          	mov    %esi,0xc(%esp)
  100ca9:	8b 43 14             	mov    0x14(%ebx),%eax
  100cac:	89 7c 24 04          	mov    %edi,0x4(%esp)
  100cb0:	89 44 24 08          	mov    %eax,0x8(%esp)
  100cb4:	8b 43 10             	mov    0x10(%ebx),%eax
  100cb7:	89 04 24             	mov    %eax,(%esp)
  100cba:	e8 71 06 00 00       	call   101330 <writei>
  100cbf:	85 c0                	test   %eax,%eax
  100cc1:	89 c6                	mov    %eax,%esi
  100cc3:	7e 03                	jle    100cc8 <filewrite+0x58>
      f->off += r;
  100cc5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
  100cc8:	8b 43 10             	mov    0x10(%ebx),%eax
  100ccb:	89 04 24             	mov    %eax,(%esp)
  100cce:	e8 cd 09 00 00       	call   1016a0 <iunlock>
    return r;
  }
  panic("filewrite");
}
  100cd3:	89 f0                	mov    %esi,%eax
  100cd5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100cd8:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100cdb:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100cde:	89 ec                	mov    %ebp,%esp
  100ce0:	5d                   	pop    %ebp
  100ce1:	c3                   	ret    
    if((r = writei(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
  100ce2:	be ff ff ff ff       	mov    $0xffffffff,%esi
  100ce7:	eb ea                	jmp    100cd3 <filewrite+0x63>
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  100ce9:	8b 43 0c             	mov    0xc(%ebx),%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
}
  100cec:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100cef:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100cf2:	8b 7d fc             	mov    -0x4(%ebp),%edi
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  100cf5:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
}
  100cf8:	89 ec                	mov    %ebp,%esp
  100cfa:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  100cfb:	e9 90 1f 00 00       	jmp    102c90 <pipewrite>
    if((r = writei(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
  100d00:	c7 04 24 bf 61 10 00 	movl   $0x1061bf,(%esp)
  100d07:	e8 74 fb ff ff       	call   100880 <panic>
  100d0c:	8d 74 26 00          	lea    0x0(%esi),%esi

00100d10 <fileread>:
}

// Read from file f.  Addr is kernel address.
int
fileread(struct file *f, char *addr, int n)
{
  100d10:	55                   	push   %ebp
  100d11:	89 e5                	mov    %esp,%ebp
  100d13:	83 ec 28             	sub    $0x28,%esp
  100d16:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  100d19:	8b 5d 08             	mov    0x8(%ebp),%ebx
  100d1c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  100d1f:	8b 75 10             	mov    0x10(%ebp),%esi
  100d22:	89 7d fc             	mov    %edi,-0x4(%ebp)
  100d25:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int r;

  if(f->readable == 0)
  100d28:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
  100d2c:	74 54                	je     100d82 <fileread+0x72>
    return -1;
  if(f->type == FD_PIPE)
  100d2e:	8b 03                	mov    (%ebx),%eax
  100d30:	83 f8 01             	cmp    $0x1,%eax
  100d33:	74 54                	je     100d89 <fileread+0x79>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
  100d35:	83 f8 02             	cmp    $0x2,%eax
  100d38:	75 66                	jne    100da0 <fileread+0x90>
    ilock(f->ip);
  100d3a:	8b 43 10             	mov    0x10(%ebx),%eax
  100d3d:	89 04 24             	mov    %eax,(%esp)
  100d40:	e8 7b 0d 00 00       	call   101ac0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
  100d45:	89 74 24 0c          	mov    %esi,0xc(%esp)
  100d49:	8b 43 14             	mov    0x14(%ebx),%eax
  100d4c:	89 7c 24 04          	mov    %edi,0x4(%esp)
  100d50:	89 44 24 08          	mov    %eax,0x8(%esp)
  100d54:	8b 43 10             	mov    0x10(%ebx),%eax
  100d57:	89 04 24             	mov    %eax,(%esp)
  100d5a:	e8 01 07 00 00       	call   101460 <readi>
  100d5f:	85 c0                	test   %eax,%eax
  100d61:	89 c6                	mov    %eax,%esi
  100d63:	7e 03                	jle    100d68 <fileread+0x58>
      f->off += r;
  100d65:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
  100d68:	8b 43 10             	mov    0x10(%ebx),%eax
  100d6b:	89 04 24             	mov    %eax,(%esp)
  100d6e:	e8 2d 09 00 00       	call   1016a0 <iunlock>
    return r;
  }
  panic("fileread");
}
  100d73:	89 f0                	mov    %esi,%eax
  100d75:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100d78:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100d7b:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100d7e:	89 ec                	mov    %ebp,%esp
  100d80:	5d                   	pop    %ebp
  100d81:	c3                   	ret    
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
  100d82:	be ff ff ff ff       	mov    $0xffffffff,%esi
  100d87:	eb ea                	jmp    100d73 <fileread+0x63>
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  100d89:	8b 43 0c             	mov    0xc(%ebx),%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
  100d8c:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100d8f:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100d92:	8b 7d fc             	mov    -0x4(%ebp),%edi
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  100d95:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
  100d98:	89 ec                	mov    %ebp,%esp
  100d9a:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  100d9b:	e9 f0 1d 00 00       	jmp    102b90 <piperead>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
  100da0:	c7 04 24 c9 61 10 00 	movl   $0x1061c9,(%esp)
  100da7:	e8 d4 fa ff ff       	call   100880 <panic>
  100dac:	8d 74 26 00          	lea    0x0(%esi),%esi

00100db0 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  100db0:	55                   	push   %ebp
  if(f->type == FD_INODE){
  100db1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  100db6:	89 e5                	mov    %esp,%ebp
  100db8:	53                   	push   %ebx
  100db9:	83 ec 14             	sub    $0x14,%esp
  100dbc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
  100dbf:	83 3b 02             	cmpl   $0x2,(%ebx)
  100dc2:	74 0c                	je     100dd0 <filestat+0x20>
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
}
  100dc4:	83 c4 14             	add    $0x14,%esp
  100dc7:	5b                   	pop    %ebx
  100dc8:	5d                   	pop    %ebp
  100dc9:	c3                   	ret    
  100dca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  if(f->type == FD_INODE){
    ilock(f->ip);
  100dd0:	8b 43 10             	mov    0x10(%ebx),%eax
  100dd3:	89 04 24             	mov    %eax,(%esp)
  100dd6:	e8 e5 0c 00 00       	call   101ac0 <ilock>
    stati(f->ip, st);
  100ddb:	8b 45 0c             	mov    0xc(%ebp),%eax
  100dde:	89 44 24 04          	mov    %eax,0x4(%esp)
  100de2:	8b 43 10             	mov    0x10(%ebx),%eax
  100de5:	89 04 24             	mov    %eax,(%esp)
  100de8:	e8 c3 01 00 00       	call   100fb0 <stati>
    iunlock(f->ip);
  100ded:	8b 43 10             	mov    0x10(%ebx),%eax
  100df0:	89 04 24             	mov    %eax,(%esp)
  100df3:	e8 a8 08 00 00       	call   1016a0 <iunlock>
    return 0;
  }
  return -1;
}
  100df8:	83 c4 14             	add    $0x14,%esp
filestat(struct file *f, struct stat *st)
{
  if(f->type == FD_INODE){
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
  100dfb:	31 c0                	xor    %eax,%eax
    return 0;
  }
  return -1;
}
  100dfd:	5b                   	pop    %ebx
  100dfe:	5d                   	pop    %ebp
  100dff:	c3                   	ret    

00100e00 <filedup>:
}

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
  100e00:	55                   	push   %ebp
  100e01:	89 e5                	mov    %esp,%ebp
  100e03:	53                   	push   %ebx
  100e04:	83 ec 04             	sub    $0x4,%esp
  100e07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
  100e0a:	c7 04 24 60 90 10 00 	movl   $0x109060,(%esp)
  100e11:	e8 ba 2b 00 00       	call   1039d0 <acquire>
  if(f->ref < 1)
  100e16:	8b 43 04             	mov    0x4(%ebx),%eax
  100e19:	85 c0                	test   %eax,%eax
  100e1b:	7e 1a                	jle    100e37 <filedup+0x37>
    panic("filedup");
  f->ref++;
  100e1d:	83 c0 01             	add    $0x1,%eax
  100e20:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
  100e23:	c7 04 24 60 90 10 00 	movl   $0x109060,(%esp)
  100e2a:	e8 61 2b 00 00       	call   103990 <release>
  return f;
}
  100e2f:	89 d8                	mov    %ebx,%eax
  100e31:	83 c4 04             	add    $0x4,%esp
  100e34:	5b                   	pop    %ebx
  100e35:	5d                   	pop    %ebp
  100e36:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  100e37:	c7 04 24 d2 61 10 00 	movl   $0x1061d2,(%esp)
  100e3e:	e8 3d fa ff ff       	call   100880 <panic>
  100e43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00100e50 <filealloc>:
}

// Allocate a file structure.
struct file*
filealloc(void)
{
  100e50:	55                   	push   %ebp
  100e51:	89 e5                	mov    %esp,%ebp
  100e53:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  100e54:	bb 94 90 10 00       	mov    $0x109094,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
  100e59:	83 ec 04             	sub    $0x4,%esp
  struct file *f;

  acquire(&ftable.lock);
  100e5c:	c7 04 24 60 90 10 00 	movl   $0x109060,(%esp)
  100e63:	e8 68 2b 00 00       	call   1039d0 <acquire>
  100e68:	eb 11                	jmp    100e7b <filealloc+0x2b>
  100e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
  100e70:	83 c3 18             	add    $0x18,%ebx
  100e73:	81 fb f4 99 10 00    	cmp    $0x1099f4,%ebx
  100e79:	74 22                	je     100e9d <filealloc+0x4d>
    if(f->ref == 0){
  100e7b:	8b 43 04             	mov    0x4(%ebx),%eax
  100e7e:	85 c0                	test   %eax,%eax
  100e80:	75 ee                	jne    100e70 <filealloc+0x20>
      f->ref = 1;
  100e82:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
  100e89:	c7 04 24 60 90 10 00 	movl   $0x109060,(%esp)
  100e90:	e8 fb 2a 00 00       	call   103990 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
  100e95:	89 d8                	mov    %ebx,%eax
  100e97:	83 c4 04             	add    $0x4,%esp
  100e9a:	5b                   	pop    %ebx
  100e9b:	5d                   	pop    %ebp
  100e9c:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
  100e9d:	c7 04 24 60 90 10 00 	movl   $0x109060,(%esp)
  100ea4:	31 db                	xor    %ebx,%ebx
  100ea6:	e8 e5 2a 00 00       	call   103990 <release>
  return 0;
}
  100eab:	89 d8                	mov    %ebx,%eax
  100ead:	83 c4 04             	add    $0x4,%esp
  100eb0:	5b                   	pop    %ebx
  100eb1:	5d                   	pop    %ebp
  100eb2:	c3                   	ret    
  100eb3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00100ec0 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
  100ec0:	55                   	push   %ebp
  100ec1:	89 e5                	mov    %esp,%ebp
  100ec3:	83 ec 28             	sub    $0x28,%esp
  100ec6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  100ec9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  100ecc:	89 75 f8             	mov    %esi,-0x8(%ebp)
  100ecf:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct file ff;

  acquire(&ftable.lock);
  100ed2:	c7 04 24 60 90 10 00 	movl   $0x109060,(%esp)
  100ed9:	e8 f2 2a 00 00       	call   1039d0 <acquire>
  if(f->ref < 1)
  100ede:	8b 43 04             	mov    0x4(%ebx),%eax
  100ee1:	85 c0                	test   %eax,%eax
  100ee3:	0f 8e 96 00 00 00    	jle    100f7f <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
  100ee9:	83 e8 01             	sub    $0x1,%eax
  100eec:	85 c0                	test   %eax,%eax
  100eee:	89 43 04             	mov    %eax,0x4(%ebx)
  100ef1:	74 1d                	je     100f10 <fileclose+0x50>
    release(&ftable.lock);
  100ef3:	c7 45 08 60 90 10 00 	movl   $0x109060,0x8(%ebp)
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
}
  100efa:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100efd:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100f00:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100f03:	89 ec                	mov    %ebp,%esp
  100f05:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
  100f06:	e9 85 2a 00 00       	jmp    103990 <release>
  100f0b:	90                   	nop    
  100f0c:	8d 74 26 00          	lea    0x0(%esi),%esi
    return;
  }
  ff = *f;
  100f10:	8b 43 10             	mov    0x10(%ebx),%eax
  100f13:	89 45 ec             	mov    %eax,-0x14(%ebp)
  100f16:	8b 53 0c             	mov    0xc(%ebx),%edx
  100f19:	89 55 f0             	mov    %edx,-0x10(%ebp)
  100f1c:	8b 33                	mov    (%ebx),%esi
  100f1e:	0f b6 7b 09          	movzbl 0x9(%ebx),%edi
  f->ref = 0;
  100f22:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
  f->type = FD_NONE;
  100f29:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  release(&ftable.lock);
  100f2f:	c7 04 24 60 90 10 00 	movl   $0x109060,(%esp)
  100f36:	e8 55 2a 00 00       	call   103990 <release>
  
  if(ff.type == FD_PIPE)
  100f3b:	83 fe 01             	cmp    $0x1,%esi
  100f3e:	74 12                	je     100f52 <fileclose+0x92>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
  100f40:	83 fe 02             	cmp    $0x2,%esi
  100f43:	74 23                	je     100f68 <fileclose+0xa8>
    iput(ff.ip);
}
  100f45:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100f48:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100f4b:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100f4e:	89 ec                	mov    %ebp,%esp
  100f50:	5d                   	pop    %ebp
  100f51:	c3                   	ret    
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  100f52:	89 fa                	mov    %edi,%edx
  100f54:	0f be c2             	movsbl %dl,%eax
  100f57:	89 44 24 04          	mov    %eax,0x4(%esp)
  100f5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100f5e:	89 04 24             	mov    %eax,(%esp)
  100f61:	e8 0a 1e 00 00       	call   102d70 <pipeclose>
  100f66:	eb dd                	jmp    100f45 <fileclose+0x85>
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  100f68:	8b 55 ec             	mov    -0x14(%ebp),%edx
}
  100f6b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100f6e:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100f71:	8b 7d fc             	mov    -0x4(%ebp),%edi
  release(&ftable.lock);
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  100f74:	89 55 08             	mov    %edx,0x8(%ebp)
}
  100f77:	89 ec                	mov    %ebp,%esp
  100f79:	5d                   	pop    %ebp
  release(&ftable.lock);
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  100f7a:	e9 f1 08 00 00       	jmp    101870 <iput>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  100f7f:	c7 04 24 da 61 10 00 	movl   $0x1061da,(%esp)
  100f86:	e8 f5 f8 ff ff       	call   100880 <panic>
  100f8b:	90                   	nop    
  100f8c:	8d 74 26 00          	lea    0x0(%esi),%esi

00100f90 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
  100f90:	55                   	push   %ebp
  100f91:	89 e5                	mov    %esp,%ebp
  100f93:	83 ec 08             	sub    $0x8,%esp
  initlock(&ftable.lock, "ftable");
  100f96:	c7 44 24 04 e4 61 10 	movl   $0x1061e4,0x4(%esp)
  100f9d:	00 
  100f9e:	c7 04 24 60 90 10 00 	movl   $0x109060,(%esp)
  100fa5:	e8 a6 28 00 00       	call   103850 <initlock>
}
  100faa:	c9                   	leave  
  100fab:	c3                   	ret    
  100fac:	90                   	nop    
  100fad:	90                   	nop    
  100fae:	90                   	nop    
  100faf:	90                   	nop    

00100fb0 <stati>:
}

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
  100fb0:	55                   	push   %ebp
  100fb1:	89 e5                	mov    %esp,%ebp
  100fb3:	8b 55 08             	mov    0x8(%ebp),%edx
  100fb6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  st->dev = ip->dev;
  100fb9:	8b 02                	mov    (%edx),%eax
  100fbb:	89 41 04             	mov    %eax,0x4(%ecx)
  st->ino = ip->inum;
  100fbe:	8b 42 04             	mov    0x4(%edx),%eax
  100fc1:	89 41 08             	mov    %eax,0x8(%ecx)
  st->type = ip->type;
  100fc4:	0f b7 42 10          	movzwl 0x10(%edx),%eax
  100fc8:	66 89 01             	mov    %ax,(%ecx)
  st->nlink = ip->nlink;
  100fcb:	0f b7 42 16          	movzwl 0x16(%edx),%eax
  100fcf:	66 89 41 0c          	mov    %ax,0xc(%ecx)
  st->size = ip->size;
  100fd3:	8b 42 18             	mov    0x18(%edx),%eax
  100fd6:	89 41 10             	mov    %eax,0x10(%ecx)
}
  100fd9:	5d                   	pop    %ebp
  100fda:	c3                   	ret    
  100fdb:	90                   	nop    
  100fdc:	8d 74 26 00          	lea    0x0(%esi),%esi

00100fe0 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  100fe0:	55                   	push   %ebp
  100fe1:	89 e5                	mov    %esp,%ebp
  100fe3:	53                   	push   %ebx
  100fe4:	83 ec 04             	sub    $0x4,%esp
  100fe7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
  100fea:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  100ff1:	e8 da 29 00 00       	call   1039d0 <acquire>
  ip->ref++;
  100ff6:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
  100ffa:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  101001:	e8 8a 29 00 00       	call   103990 <release>
  return ip;
}
  101006:	89 d8                	mov    %ebx,%eax
  101008:	83 c4 04             	add    $0x4,%esp
  10100b:	5b                   	pop    %ebx
  10100c:	5d                   	pop    %ebp
  10100d:	c3                   	ret    
  10100e:	66 90                	xchg   %ax,%ax

00101010 <iget>:

// Find the inode with number inum on device dev
// and return the in-memory copy.
static struct inode*
iget(uint dev, uint inum)
{
  101010:	55                   	push   %ebp
  101011:	89 e5                	mov    %esp,%ebp
  101013:	57                   	push   %edi
  101014:	89 c7                	mov    %eax,%edi
  101016:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);
  101017:	31 f6                	xor    %esi,%esi

// Find the inode with number inum on device dev
// and return the in-memory copy.
static struct inode*
iget(uint dev, uint inum)
{
  101019:	53                   	push   %ebx
  struct inode *ip, *empty;

  acquire(&icache.lock);
  10101a:	bb 94 9a 10 00       	mov    $0x109a94,%ebx

// Find the inode with number inum on device dev
// and return the in-memory copy.
static struct inode*
iget(uint dev, uint inum)
{
  10101f:	83 ec 0c             	sub    $0xc,%esp
  101022:	89 55 f0             	mov    %edx,-0x10(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
  101025:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  10102c:	e8 9f 29 00 00       	call   1039d0 <acquire>
  101031:	eb 0f                	jmp    101042 <iget+0x32>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
  101033:	85 f6                	test   %esi,%esi
  101035:	74 3a                	je     101071 <iget+0x61>

  acquire(&icache.lock);

  // Try for cached inode.
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  101037:	83 c3 50             	add    $0x50,%ebx
  10103a:	81 fb 34 aa 10 00    	cmp    $0x10aa34,%ebx
  101040:	74 40                	je     101082 <iget+0x72>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
  101042:	8b 43 08             	mov    0x8(%ebx),%eax
  101045:	85 c0                	test   %eax,%eax
  101047:	7e ea                	jle    101033 <iget+0x23>
  101049:	39 3b                	cmp    %edi,(%ebx)
  10104b:	75 e6                	jne    101033 <iget+0x23>
  10104d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  101050:	39 53 04             	cmp    %edx,0x4(%ebx)
  101053:	75 de                	jne    101033 <iget+0x23>
      ip->ref++;
  101055:	83 c0 01             	add    $0x1,%eax
  101058:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
  10105b:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  101062:	e8 29 29 00 00       	call   103990 <release>
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);

  return ip;
}
  101067:	83 c4 0c             	add    $0xc,%esp
  10106a:	89 d8                	mov    %ebx,%eax
  10106c:	5b                   	pop    %ebx
  10106d:	5e                   	pop    %esi
  10106e:	5f                   	pop    %edi
  10106f:	5d                   	pop    %ebp
  101070:	c3                   	ret    
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
  101071:	85 c0                	test   %eax,%eax
  101073:	75 c2                	jne    101037 <iget+0x27>
  101075:	89 de                	mov    %ebx,%esi

  acquire(&icache.lock);

  // Try for cached inode.
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  101077:	83 c3 50             	add    $0x50,%ebx
  10107a:	81 fb 34 aa 10 00    	cmp    $0x10aa34,%ebx
  101080:	75 c0                	jne    101042 <iget+0x32>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Allocate fresh inode.
  if(empty == 0)
  101082:	85 f6                	test   %esi,%esi
  101084:	74 2e                	je     1010b4 <iget+0xa4>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
  101086:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
  101088:	8b 45 f0             	mov    -0x10(%ebp),%eax
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);
  10108b:	89 f3                	mov    %esi,%ebx
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  10108d:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
  101094:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  10109b:	89 46 04             	mov    %eax,0x4(%esi)
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);
  10109e:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  1010a5:	e8 e6 28 00 00       	call   103990 <release>

  return ip;
}
  1010aa:	83 c4 0c             	add    $0xc,%esp
  1010ad:	89 d8                	mov    %ebx,%eax
  1010af:	5b                   	pop    %ebx
  1010b0:	5e                   	pop    %esi
  1010b1:	5f                   	pop    %edi
  1010b2:	5d                   	pop    %ebp
  1010b3:	c3                   	ret    
      empty = ip;
  }

  // Allocate fresh inode.
  if(empty == 0)
    panic("iget: no inodes");
  1010b4:	c7 04 24 eb 61 10 00 	movl   $0x1061eb,(%esp)
  1010bb:	e8 c0 f7 ff ff       	call   100880 <panic>

001010c0 <readsb>:
static void itrunc(struct inode*);

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
  1010c0:	55                   	push   %ebp
  1010c1:	89 e5                	mov    %esp,%ebp
  1010c3:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
  1010c6:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1010cd:	00 
static void itrunc(struct inode*);

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
  1010ce:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  1010d1:	89 75 fc             	mov    %esi,-0x4(%ebp)
  1010d4:	89 d6                	mov    %edx,%esi
  struct buf *bp;
  
  bp = bread(dev, 1);
  1010d6:	89 04 24             	mov    %eax,(%esp)
  1010d9:	e8 c2 ef ff ff       	call   1000a0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
  1010de:	89 34 24             	mov    %esi,(%esp)
  1010e1:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
  1010e8:	00 
static void
readsb(int dev, struct superblock *sb)
{
  struct buf *bp;
  
  bp = bread(dev, 1);
  1010e9:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
  1010eb:	8d 40 18             	lea    0x18(%eax),%eax
  1010ee:	89 44 24 04          	mov    %eax,0x4(%esp)
  1010f2:	e8 e9 29 00 00       	call   103ae0 <memmove>
  brelse(bp);
  1010f7:	89 1c 24             	mov    %ebx,(%esp)
  1010fa:	e8 01 ef ff ff       	call   100000 <brelse>
}
  1010ff:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  101102:	8b 75 fc             	mov    -0x4(%ebp),%esi
  101105:	89 ec                	mov    %ebp,%esp
  101107:	5d                   	pop    %ebp
  101108:	c3                   	ret    
  101109:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00101110 <iupdate>:
}

// Copy inode, which has changed, from memory to disk.
void
iupdate(struct inode *ip)
{
  101110:	55                   	push   %ebp
  101111:	89 e5                	mov    %esp,%ebp
  101113:	56                   	push   %esi
  101114:	53                   	push   %ebx
  101115:	83 ec 10             	sub    $0x10,%esp
  101118:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
  10111b:	8b 43 04             	mov    0x4(%ebx),%eax
  10111e:	c1 e8 03             	shr    $0x3,%eax
  101121:	83 c0 02             	add    $0x2,%eax
  101124:	89 44 24 04          	mov    %eax,0x4(%esp)
  101128:	8b 03                	mov    (%ebx),%eax
  10112a:	89 04 24             	mov    %eax,(%esp)
  10112d:	e8 6e ef ff ff       	call   1000a0 <bread>
  101132:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  101134:	8b 43 04             	mov    0x4(%ebx),%eax
  101137:	83 e0 07             	and    $0x7,%eax
  10113a:	c1 e0 06             	shl    $0x6,%eax
  10113d:	8d 54 06 18          	lea    0x18(%esi,%eax,1),%edx
  dip->type = ip->type;
  101141:	0f b7 43 10          	movzwl 0x10(%ebx),%eax
  101145:	66 89 02             	mov    %ax,(%edx)
  dip->major = ip->major;
  101148:	0f b7 43 12          	movzwl 0x12(%ebx),%eax
  10114c:	66 89 42 02          	mov    %ax,0x2(%edx)
  dip->minor = ip->minor;
  101150:	0f b7 43 14          	movzwl 0x14(%ebx),%eax
  101154:	66 89 42 04          	mov    %ax,0x4(%edx)
  dip->nlink = ip->nlink;
  101158:	0f b7 43 16          	movzwl 0x16(%ebx),%eax
  10115c:	66 89 42 06          	mov    %ax,0x6(%edx)
  dip->size = ip->size;
  101160:	8b 43 18             	mov    0x18(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  101163:	83 c3 1c             	add    $0x1c,%ebx
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  101166:	89 42 08             	mov    %eax,0x8(%edx)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  101169:	83 c2 0c             	add    $0xc,%edx
  10116c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  101170:	89 14 24             	mov    %edx,(%esp)
  101173:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
  10117a:	00 
  10117b:	e8 60 29 00 00       	call   103ae0 <memmove>
  bwrite(bp);
  101180:	89 34 24             	mov    %esi,(%esp)
  101183:	e8 e8 ee ff ff       	call   100070 <bwrite>
  brelse(bp);
  101188:	89 75 08             	mov    %esi,0x8(%ebp)
}
  10118b:	83 c4 10             	add    $0x10,%esp
  10118e:	5b                   	pop    %ebx
  10118f:	5e                   	pop    %esi
  101190:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  bwrite(bp);
  brelse(bp);
  101191:	e9 6a ee ff ff       	jmp    100000 <brelse>
  101196:	8d 76 00             	lea    0x0(%esi),%esi
  101199:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001011a0 <balloc>:
// Blocks. 

// Allocate a disk block.
static uint
balloc(uint dev)
{
  1011a0:	55                   	push   %ebp
  1011a1:	89 e5                	mov    %esp,%ebp
  1011a3:	57                   	push   %edi
  1011a4:	56                   	push   %esi
  1011a5:	53                   	push   %ebx
  1011a6:	83 ec 2c             	sub    $0x2c,%esp
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  1011a9:	8d 55 e8             	lea    -0x18(%ebp),%edx
// Blocks. 

// Allocate a disk block.
static uint
balloc(uint dev)
{
  1011ac:	89 45 dc             	mov    %eax,-0x24(%ebp)
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  1011af:	e8 0c ff ff ff       	call   1010c0 <readsb>
  for(b = 0; b < sb.size; b += BPB){
  1011b4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1011b7:	85 c0                	test   %eax,%eax
  1011b9:	0f 84 a6 00 00 00    	je     101265 <balloc+0xc5>
  1011bf:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    bp = bread(dev, BBLOCK(b, sb.ninodes));
  1011c6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1011c9:	31 f6                	xor    %esi,%esi
  1011cb:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1011ce:	c1 f8 1f             	sar    $0x1f,%eax
  1011d1:	c1 e8 14             	shr    $0x14,%eax
  1011d4:	03 45 e0             	add    -0x20(%ebp),%eax
  1011d7:	c1 ea 03             	shr    $0x3,%edx
  1011da:	c1 f8 0c             	sar    $0xc,%eax
  1011dd:	8d 54 02 03          	lea    0x3(%edx,%eax,1),%edx
  1011e1:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1011e4:	89 54 24 04          	mov    %edx,0x4(%esp)
  1011e8:	89 04 24             	mov    %eax,(%esp)
  1011eb:	e8 b0 ee ff ff       	call   1000a0 <bread>
  1011f0:	89 c7                	mov    %eax,%edi
  1011f2:	eb 0b                	jmp    1011ff <balloc+0x5f>
    for(bi = 0; bi < BPB; bi++){
  1011f4:	83 c6 01             	add    $0x1,%esi
  1011f7:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
  1011fd:	74 4b                	je     10124a <balloc+0xaa>
      m = 1 << (bi % 8);
  1011ff:	89 f0                	mov    %esi,%eax
  101201:	bb 01 00 00 00       	mov    $0x1,%ebx
  101206:	c1 f8 1f             	sar    $0x1f,%eax
  101209:	c1 e8 1d             	shr    $0x1d,%eax
  10120c:	8d 14 06             	lea    (%esi,%eax,1),%edx
  10120f:	89 d1                	mov    %edx,%ecx
  101211:	83 e1 07             	and    $0x7,%ecx
  101214:	29 c1                	sub    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
  101216:	c1 fa 03             	sar    $0x3,%edx
  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB; bi++){
      m = 1 << (bi % 8);
  101219:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
  10121b:	0f b6 4c 17 18       	movzbl 0x18(%edi,%edx,1),%ecx
  101220:	0f b6 c1             	movzbl %cl,%eax
  101223:	85 d8                	test   %ebx,%eax
  101225:	75 cd                	jne    1011f4 <balloc+0x54>
        bp->data[bi/8] |= m;  // Mark block in use on disk.
  101227:	09 d9                	or     %ebx,%ecx
  101229:	88 4c 17 18          	mov    %cl,0x18(%edi,%edx,1)
        bwrite(bp);
  10122d:	89 3c 24             	mov    %edi,(%esp)
  101230:	e8 3b ee ff ff       	call   100070 <bwrite>
        brelse(bp);
  101235:	89 3c 24             	mov    %edi,(%esp)
  101238:	e8 c3 ed ff ff       	call   100000 <brelse>
  10123d:	8b 45 e0             	mov    -0x20(%ebp),%eax
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
  101240:	83 c4 2c             	add    $0x2c,%esp
  101243:	5b                   	pop    %ebx
    for(bi = 0; bi < BPB; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use on disk.
        bwrite(bp);
        brelse(bp);
  101244:	01 f0                	add    %esi,%eax
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
  101246:	5e                   	pop    %esi
  101247:	5f                   	pop    %edi
  101248:	5d                   	pop    %ebp
  101249:	c3                   	ret    
        bwrite(bp);
        brelse(bp);
        return b + bi;
      }
    }
    brelse(bp);
  10124a:	89 3c 24             	mov    %edi,(%esp)
  10124d:	e8 ae ed ff ff       	call   100000 <brelse>
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
  101252:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  101259:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10125c:	39 45 e8             	cmp    %eax,-0x18(%ebp)
  10125f:	0f 87 61 ff ff ff    	ja     1011c6 <balloc+0x26>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
  101265:	c7 04 24 fb 61 10 00 	movl   $0x1061fb,(%esp)
  10126c:	e8 0f f6 ff ff       	call   100880 <panic>
  101271:	eb 0d                	jmp    101280 <bmap>
  101273:	90                   	nop    
  101274:	90                   	nop    
  101275:	90                   	nop    
  101276:	90                   	nop    
  101277:	90                   	nop    
  101278:	90                   	nop    
  101279:	90                   	nop    
  10127a:	90                   	nop    
  10127b:	90                   	nop    
  10127c:	90                   	nop    
  10127d:	90                   	nop    
  10127e:	90                   	nop    
  10127f:	90                   	nop    

00101280 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
  101280:	55                   	push   %ebp
  101281:	89 e5                	mov    %esp,%ebp
  101283:	83 ec 18             	sub    $0x18,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
  101286:	83 fa 0b             	cmp    $0xb,%edx

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
  101289:	89 75 f8             	mov    %esi,-0x8(%ebp)
  10128c:	89 d6                	mov    %edx,%esi
  10128e:	89 7d fc             	mov    %edi,-0x4(%ebp)
  101291:	89 c7                	mov    %eax,%edi
  101293:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
  101296:	77 18                	ja     1012b0 <bmap+0x30>
    if((addr = ip->addrs[bn]) == 0)
  101298:	8b 5c 90 1c          	mov    0x1c(%eax,%edx,4),%ebx
  10129c:	85 db                	test   %ebx,%ebx
  10129e:	74 46                	je     1012e6 <bmap+0x66>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
  1012a0:	89 d8                	mov    %ebx,%eax
  1012a2:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1012a5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1012a8:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1012ab:	89 ec                	mov    %ebp,%esp
  1012ad:	5d                   	pop    %ebp
  1012ae:	c3                   	ret    
  1012af:	90                   	nop    
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
  1012b0:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
  1012b3:	83 fb 7f             	cmp    $0x7f,%ebx
  1012b6:	77 64                	ja     10131c <bmap+0x9c>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
  1012b8:	8b 40 4c             	mov    0x4c(%eax),%eax
  1012bb:	85 c0                	test   %eax,%eax
  1012bd:	74 51                	je     101310 <bmap+0x90>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
  1012bf:	89 44 24 04          	mov    %eax,0x4(%esp)
  1012c3:	8b 07                	mov    (%edi),%eax
  1012c5:	89 04 24             	mov    %eax,(%esp)
  1012c8:	e8 d3 ed ff ff       	call   1000a0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
  1012cd:	8d 5c 98 18          	lea    0x18(%eax,%ebx,4),%ebx

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
  1012d1:	89 c6                	mov    %eax,%esi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
  1012d3:	89 5d f0             	mov    %ebx,-0x10(%ebp)
  1012d6:	8b 1b                	mov    (%ebx),%ebx
  1012d8:	85 db                	test   %ebx,%ebx
  1012da:	74 19                	je     1012f5 <bmap+0x75>
      a[bn] = addr = balloc(ip->dev);
      bwrite(bp);
    }
    brelse(bp);
  1012dc:	89 34 24             	mov    %esi,(%esp)
  1012df:	e8 1c ed ff ff       	call   100000 <brelse>
  1012e4:	eb ba                	jmp    1012a0 <bmap+0x20>
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
  1012e6:	8b 00                	mov    (%eax),%eax
  1012e8:	e8 b3 fe ff ff       	call   1011a0 <balloc>
  1012ed:	89 c3                	mov    %eax,%ebx
  1012ef:	89 44 b7 1c          	mov    %eax,0x1c(%edi,%esi,4)
  1012f3:	eb ab                	jmp    1012a0 <bmap+0x20>
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
  1012f5:	8b 07                	mov    (%edi),%eax
  1012f7:	e8 a4 fe ff ff       	call   1011a0 <balloc>
  1012fc:	89 c3                	mov    %eax,%ebx
  1012fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101301:	89 18                	mov    %ebx,(%eax)
      bwrite(bp);
  101303:	89 34 24             	mov    %esi,(%esp)
  101306:	e8 65 ed ff ff       	call   100070 <bwrite>
  10130b:	eb cf                	jmp    1012dc <bmap+0x5c>
  10130d:	8d 76 00             	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
  101310:	8b 07                	mov    (%edi),%eax
  101312:	e8 89 fe ff ff       	call   1011a0 <balloc>
  101317:	89 47 4c             	mov    %eax,0x4c(%edi)
  10131a:	eb a3                	jmp    1012bf <bmap+0x3f>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
  10131c:	c7 04 24 11 62 10 00 	movl   $0x106211,(%esp)
  101323:	e8 58 f5 ff ff       	call   100880 <panic>
  101328:	90                   	nop    
  101329:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00101330 <writei>:
}

// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
  101330:	55                   	push   %ebp
  101331:	89 e5                	mov    %esp,%ebp
  101333:	83 ec 28             	sub    $0x28,%esp
  101336:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  101339:	8b 45 0c             	mov    0xc(%ebp),%eax
  10133c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  10133f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  101342:	89 75 f8             	mov    %esi,-0x8(%ebp)
  101345:	8b 75 10             	mov    0x10(%ebp),%esi
  101348:	89 7d fc             	mov    %edi,-0x4(%ebp)
  10134b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  10134e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  101351:	66 83 7b 10 03       	cmpw   $0x3,0x10(%ebx)
  101356:	74 18                	je     101370 <writei+0x40>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
  101358:	39 73 18             	cmp    %esi,0x18(%ebx)
  10135b:	73 3d                	jae    10139a <writei+0x6a>

  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
  10135d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  101362:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  101365:	8b 75 f8             	mov    -0x8(%ebp),%esi
  101368:	8b 7d fc             	mov    -0x4(%ebp),%edi
  10136b:	89 ec                	mov    %ebp,%esp
  10136d:	5d                   	pop    %ebp
  10136e:	c3                   	ret    
  10136f:	90                   	nop    
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
  101370:	0f b7 43 12          	movzwl 0x12(%ebx),%eax
  101374:	66 83 f8 09          	cmp    $0x9,%ax
  101378:	77 e3                	ja     10135d <writei+0x2d>
  10137a:	98                   	cwtl   
  10137b:	8b 0c c5 04 9a 10 00 	mov    0x109a04(,%eax,8),%ecx
  101382:	85 c9                	test   %ecx,%ecx
  101384:	74 d7                	je     10135d <writei+0x2d>
      return -1;
    return devsw[ip->major].write(ip, src, n);
  101386:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
  101389:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  10138c:	8b 75 f8             	mov    -0x8(%ebp),%esi
  10138f:	8b 7d fc             	mov    -0x4(%ebp),%edi
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  101392:	89 45 10             	mov    %eax,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
  101395:	89 ec                	mov    %ebp,%esp
  101397:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  101398:	ff e1                	jmp    *%ecx
  }

  if(off > ip->size || off + n < off)
  10139a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10139d:	01 f0                	add    %esi,%eax
  10139f:	39 c6                	cmp    %eax,%esi
  1013a1:	77 ba                	ja     10135d <writei+0x2d>
    return -1;
  if(off + n > MAXFILE*BSIZE)
  1013a3:	3d 00 18 01 00       	cmp    $0x11800,%eax
  1013a8:	76 0a                	jbe    1013b4 <writei+0x84>
    n = MAXFILE*BSIZE - off;
  1013aa:	c7 45 e4 00 18 01 00 	movl   $0x11800,-0x1c(%ebp)
  1013b1:	29 75 e4             	sub    %esi,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  1013b4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1013b7:	85 d2                	test   %edx,%edx
  1013b9:	0f 84 8f 00 00 00    	je     10144e <writei+0x11e>
  1013bf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  1013c6:	89 f2                	mov    %esi,%edx
  1013c8:	89 d8                	mov    %ebx,%eax
  1013ca:	c1 ea 09             	shr    $0x9,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
  1013cd:	bf 00 02 00 00       	mov    $0x200,%edi
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  1013d2:	e8 a9 fe ff ff       	call   101280 <bmap>
  1013d7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1013db:	8b 03                	mov    (%ebx),%eax
  1013dd:	89 04 24             	mov    %eax,(%esp)
  1013e0:	e8 bb ec ff ff       	call   1000a0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
  1013e5:	89 f2                	mov    %esi,%edx
  1013e7:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  1013ed:	29 d7                	sub    %edx,%edi
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  1013ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
  1013f2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1013f5:	2b 45 ec             	sub    -0x14(%ebp),%eax
  1013f8:	39 c7                	cmp    %eax,%edi
  1013fa:	76 02                	jbe    1013fe <writei+0xce>
  1013fc:	89 c7                	mov    %eax,%edi
    memmove(bp->data + off%BSIZE, src, m);
  1013fe:	89 7c 24 08          	mov    %edi,0x8(%esp)
  101402:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  101405:	01 fe                	add    %edi,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
  101407:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  10140b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  10140e:	8d 44 11 18          	lea    0x18(%ecx,%edx,1),%eax
  101412:	89 04 24             	mov    %eax,(%esp)
  101415:	e8 c6 26 00 00       	call   103ae0 <memmove>
    bwrite(bp);
  10141a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10141d:	89 04 24             	mov    %eax,(%esp)
  101420:	e8 4b ec ff ff       	call   100070 <bwrite>
    brelse(bp);
  101425:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  101428:	89 0c 24             	mov    %ecx,(%esp)
  10142b:	e8 d0 eb ff ff       	call   100000 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  101430:	01 7d ec             	add    %edi,-0x14(%ebp)
  101433:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101436:	01 7d e8             	add    %edi,-0x18(%ebp)
  101439:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
  10143c:	77 88                	ja     1013c6 <writei+0x96>
    memmove(bp->data + off%BSIZE, src, m);
    bwrite(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
  10143e:	39 73 18             	cmp    %esi,0x18(%ebx)
  101441:	73 0b                	jae    10144e <writei+0x11e>
    ip->size = off;
  101443:	89 73 18             	mov    %esi,0x18(%ebx)
    iupdate(ip);
  101446:	89 1c 24             	mov    %ebx,(%esp)
  101449:	e8 c2 fc ff ff       	call   101110 <iupdate>
  }
  return n;
  10144e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101451:	e9 0c ff ff ff       	jmp    101362 <writei+0x32>
  101456:	8d 76 00             	lea    0x0(%esi),%esi
  101459:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00101460 <readi>:
}

// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
  101460:	55                   	push   %ebp
  101461:	89 e5                	mov    %esp,%ebp
  101463:	83 ec 28             	sub    $0x28,%esp
  101466:	89 7d fc             	mov    %edi,-0x4(%ebp)
  101469:	8b 45 0c             	mov    0xc(%ebp),%eax
  10146c:	8b 7d 08             	mov    0x8(%ebp),%edi
  10146f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  101472:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  101475:	8b 5d 10             	mov    0x10(%ebp),%ebx
  101478:	89 75 f8             	mov    %esi,-0x8(%ebp)
  10147b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  10147e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  101481:	66 83 7f 10 03       	cmpw   $0x3,0x10(%edi)
  101486:	74 19                	je     1014a1 <readi+0x41>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
  101488:	8b 47 18             	mov    0x18(%edi),%eax
  10148b:	39 d8                	cmp    %ebx,%eax
  10148d:	73 3c                	jae    1014cb <readi+0x6b>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
  10148f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  101494:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  101497:	8b 75 f8             	mov    -0x8(%ebp),%esi
  10149a:	8b 7d fc             	mov    -0x4(%ebp),%edi
  10149d:	89 ec                	mov    %ebp,%esp
  10149f:	5d                   	pop    %ebp
  1014a0:	c3                   	ret    
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
  1014a1:	0f b7 47 12          	movzwl 0x12(%edi),%eax
  1014a5:	66 83 f8 09          	cmp    $0x9,%ax
  1014a9:	77 e4                	ja     10148f <readi+0x2f>
  1014ab:	98                   	cwtl   
  1014ac:	8b 0c c5 00 9a 10 00 	mov    0x109a00(,%eax,8),%ecx
  1014b3:	85 c9                	test   %ecx,%ecx
  1014b5:	74 d8                	je     10148f <readi+0x2f>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  1014b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
  1014ba:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1014bd:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1014c0:	8b 7d fc             	mov    -0x4(%ebp),%edi
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  1014c3:	89 45 10             	mov    %eax,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
  1014c6:	89 ec                	mov    %ebp,%esp
  1014c8:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  1014c9:	ff e1                	jmp    *%ecx
  }

  if(off > ip->size || off + n < off)
  1014cb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1014ce:	01 da                	add    %ebx,%edx
  1014d0:	39 d3                	cmp    %edx,%ebx
  1014d2:	77 bb                	ja     10148f <readi+0x2f>
    return -1;
  if(off + n > ip->size)
  1014d4:	39 d0                	cmp    %edx,%eax
  1014d6:	73 05                	jae    1014dd <readi+0x7d>
    n = ip->size - off;
  1014d8:	29 d8                	sub    %ebx,%eax
  1014da:	89 45 e4             	mov    %eax,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  1014dd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  1014e0:	85 c9                	test   %ecx,%ecx
  1014e2:	74 79                	je     10155d <readi+0xfd>
  1014e4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  1014eb:	90                   	nop    
  1014ec:	8d 74 26 00          	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  1014f0:	89 da                	mov    %ebx,%edx
  1014f2:	89 f8                	mov    %edi,%eax
  1014f4:	c1 ea 09             	shr    $0x9,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
  1014f7:	be 00 02 00 00       	mov    $0x200,%esi
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  1014fc:	e8 7f fd ff ff       	call   101280 <bmap>
  101501:	89 44 24 04          	mov    %eax,0x4(%esp)
  101505:	8b 07                	mov    (%edi),%eax
  101507:	89 04 24             	mov    %eax,(%esp)
  10150a:	e8 91 eb ff ff       	call   1000a0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
  10150f:	89 da                	mov    %ebx,%edx
  101511:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  101517:	29 d6                	sub    %edx,%esi
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  101519:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
  10151c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10151f:	2b 45 ec             	sub    -0x14(%ebp),%eax
  101522:	39 c6                	cmp    %eax,%esi
  101524:	76 02                	jbe    101528 <readi+0xc8>
  101526:	89 c6                	mov    %eax,%esi
    memmove(dst, bp->data + off%BSIZE, m);
  101528:	89 74 24 08          	mov    %esi,0x8(%esp)
  10152c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  10152f:	01 f3                	add    %esi,%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
  101531:	8d 44 11 18          	lea    0x18(%ecx,%edx,1),%eax
  101535:	89 44 24 04          	mov    %eax,0x4(%esp)
  101539:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10153c:	89 04 24             	mov    %eax,(%esp)
  10153f:	e8 9c 25 00 00       	call   103ae0 <memmove>
    brelse(bp);
  101544:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  101547:	89 0c 24             	mov    %ecx,(%esp)
  10154a:	e8 b1 ea ff ff       	call   100000 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  10154f:	01 75 ec             	add    %esi,-0x14(%ebp)
  101552:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101555:	01 75 e8             	add    %esi,-0x18(%ebp)
  101558:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
  10155b:	77 93                	ja     1014f0 <readi+0x90>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
  10155d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101560:	e9 2f ff ff ff       	jmp    101494 <readi+0x34>
  101565:	8d 74 26 00          	lea    0x0(%esi),%esi
  101569:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00101570 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
  101570:	55                   	push   %ebp
  101571:	89 e5                	mov    %esp,%ebp
  101573:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
  101576:	8b 45 0c             	mov    0xc(%ebp),%eax
  101579:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  101580:	00 
  101581:	89 44 24 04          	mov    %eax,0x4(%esp)
  101585:	8b 45 08             	mov    0x8(%ebp),%eax
  101588:	89 04 24             	mov    %eax,(%esp)
  10158b:	e8 c0 25 00 00       	call   103b50 <strncmp>
}
  101590:	c9                   	leave  
  101591:	c3                   	ret    
  101592:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  101599:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001015a0 <dirlookup>:
// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
// Caller must have already locked dp.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
  1015a0:	55                   	push   %ebp
  1015a1:	89 e5                	mov    %esp,%ebp
  1015a3:	57                   	push   %edi
  1015a4:	56                   	push   %esi
  1015a5:	53                   	push   %ebx
  1015a6:	83 ec 1c             	sub    $0x1c,%esp
  1015a9:	8b 45 08             	mov    0x8(%ebp),%eax
  1015ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  1015af:	8b 4d 10             	mov    0x10(%ebp),%ecx
  1015b2:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1015b5:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  1015b8:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
  1015bb:	66 83 78 10 01       	cmpw   $0x1,0x10(%eax)
  1015c0:	0f 85 cd 00 00 00    	jne    101693 <dirlookup+0xf3>
    panic("dirlookup not DIR");
  1015c6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

  for(off = 0; off < dp->size; off += BSIZE){
  1015cd:	8b 78 18             	mov    0x18(%eax),%edi
  1015d0:	85 ff                	test   %edi,%edi
  1015d2:	0f 84 b1 00 00 00    	je     101689 <dirlookup+0xe9>
    bp = bread(dp->dev, bmap(dp, off / BSIZE));
  1015d8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1015db:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1015de:	c1 ea 09             	shr    $0x9,%edx
  1015e1:	e8 9a fc ff ff       	call   101280 <bmap>
  1015e6:	89 44 24 04          	mov    %eax,0x4(%esp)
  1015ea:	8b 55 e8             	mov    -0x18(%ebp),%edx
  1015ed:	8b 02                	mov    (%edx),%eax
  1015ef:	89 04 24             	mov    %eax,(%esp)
  1015f2:	e8 a9 ea ff ff       	call   1000a0 <bread>
    for(de = (struct dirent*)bp->data;
  1015f7:	8d 48 18             	lea    0x18(%eax),%ecx

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
    bp = bread(dp->dev, bmap(dp, off / BSIZE));
  1015fa:	89 c7                	mov    %eax,%edi
    for(de = (struct dirent*)bp->data;
        de < (struct dirent*)(bp->data + BSIZE);
  1015fc:	8d b0 18 02 00 00    	lea    0x218(%eax),%esi
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
    bp = bread(dp->dev, bmap(dp, off / BSIZE));
    for(de = (struct dirent*)bp->data;
  101602:	89 cb                	mov    %ecx,%ebx
        de < (struct dirent*)(bp->data + BSIZE);
  101604:	39 f1                	cmp    %esi,%ecx
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
    bp = bread(dp->dev, bmap(dp, off / BSIZE));
    for(de = (struct dirent*)bp->data;
  101606:	89 4d ec             	mov    %ecx,-0x14(%ebp)
        de < (struct dirent*)(bp->data + BSIZE);
  101609:	72 0c                	jb     101617 <dirlookup+0x77>
  10160b:	eb 5e                	jmp    10166b <dirlookup+0xcb>
  10160d:	8d 76 00             	lea    0x0(%esi),%esi
        de++){
  101610:	83 c3 10             	add    $0x10,%ebx
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
    bp = bread(dp->dev, bmap(dp, off / BSIZE));
    for(de = (struct dirent*)bp->data;
        de < (struct dirent*)(bp->data + BSIZE);
  101613:	39 f3                	cmp    %esi,%ebx
  101615:	73 54                	jae    10166b <dirlookup+0xcb>
        de++){
      if(de->inum == 0)
  101617:	66 83 3b 00          	cmpw   $0x0,(%ebx)
  10161b:	90                   	nop    
  10161c:	8d 74 26 00          	lea    0x0(%esi),%esi
  101620:	74 ee                	je     101610 <dirlookup+0x70>
        continue;
      if(namecmp(name, de->name) == 0){
  101622:	8d 43 02             	lea    0x2(%ebx),%eax
  101625:	89 44 24 04          	mov    %eax,0x4(%esp)
  101629:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10162c:	89 04 24             	mov    %eax,(%esp)
  10162f:	e8 3c ff ff ff       	call   101570 <namecmp>
  101634:	85 c0                	test   %eax,%eax
  101636:	75 d8                	jne    101610 <dirlookup+0x70>
        // entry matches path element
        if(poff)
  101638:	8b 75 e0             	mov    -0x20(%ebp),%esi
  10163b:	85 f6                	test   %esi,%esi
  10163d:	74 0e                	je     10164d <dirlookup+0xad>
          *poff = off + (uchar*)de - bp->data;
  10163f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  101642:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  101645:	8d 04 13             	lea    (%ebx,%edx,1),%eax
  101648:	2b 45 ec             	sub    -0x14(%ebp),%eax
  10164b:	89 01                	mov    %eax,(%ecx)
        inum = de->inum;
  10164d:	0f b7 1b             	movzwl (%ebx),%ebx
        brelse(bp);
  101650:	89 3c 24             	mov    %edi,(%esp)
  101653:	e8 a8 e9 ff ff       	call   100000 <brelse>
        return iget(dp->dev, inum);
  101658:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  10165b:	89 da                	mov    %ebx,%edx
  10165d:	8b 01                	mov    (%ecx),%eax
      }
    }
    brelse(bp);
  }
  return 0;
}
  10165f:	83 c4 1c             	add    $0x1c,%esp
  101662:	5b                   	pop    %ebx
  101663:	5e                   	pop    %esi
  101664:	5f                   	pop    %edi
  101665:	5d                   	pop    %ebp
        // entry matches path element
        if(poff)
          *poff = off + (uchar*)de - bp->data;
        inum = de->inum;
        brelse(bp);
        return iget(dp->dev, inum);
  101666:	e9 a5 f9 ff ff       	jmp    101010 <iget>
      }
    }
    brelse(bp);
  10166b:	89 3c 24             	mov    %edi,(%esp)
  10166e:	e8 8d e9 ff ff       	call   100000 <brelse>
  struct dirent *de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
  101673:	8b 45 e8             	mov    -0x18(%ebp),%eax
  101676:	81 45 f0 00 02 00 00 	addl   $0x200,-0x10(%ebp)
  10167d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  101680:	39 50 18             	cmp    %edx,0x18(%eax)
  101683:	0f 87 4f ff ff ff    	ja     1015d8 <dirlookup+0x38>
      }
    }
    brelse(bp);
  }
  return 0;
}
  101689:	83 c4 1c             	add    $0x1c,%esp
  10168c:	31 c0                	xor    %eax,%eax
  10168e:	5b                   	pop    %ebx
  10168f:	5e                   	pop    %esi
  101690:	5f                   	pop    %edi
  101691:	5d                   	pop    %ebp
  101692:	c3                   	ret    
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
  101693:	c7 04 24 24 62 10 00 	movl   $0x106224,(%esp)
  10169a:	e8 e1 f1 ff ff       	call   100880 <panic>
  10169f:	90                   	nop    

001016a0 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  1016a0:	55                   	push   %ebp
  1016a1:	89 e5                	mov    %esp,%ebp
  1016a3:	53                   	push   %ebx
  1016a4:	83 ec 04             	sub    $0x4,%esp
  1016a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
  1016aa:	85 db                	test   %ebx,%ebx
  1016ac:	74 36                	je     1016e4 <iunlock+0x44>
  1016ae:	f6 43 0c 01          	testb  $0x1,0xc(%ebx)
  1016b2:	74 30                	je     1016e4 <iunlock+0x44>
  1016b4:	8b 43 08             	mov    0x8(%ebx),%eax
  1016b7:	85 c0                	test   %eax,%eax
  1016b9:	7e 29                	jle    1016e4 <iunlock+0x44>
    panic("iunlock");

  acquire(&icache.lock);
  1016bb:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  1016c2:	e8 09 23 00 00       	call   1039d0 <acquire>
  ip->flags &= ~I_BUSY;
  1016c7:	83 63 0c fe          	andl   $0xfffffffe,0xc(%ebx)
  wakeup(ip);
  1016cb:	89 1c 24             	mov    %ebx,(%esp)
  1016ce:	e8 ed 18 00 00       	call   102fc0 <wakeup>
  release(&icache.lock);
  1016d3:	c7 45 08 60 9a 10 00 	movl   $0x109a60,0x8(%ebp)
}
  1016da:	83 c4 04             	add    $0x4,%esp
  1016dd:	5b                   	pop    %ebx
  1016de:	5d                   	pop    %ebp
    panic("iunlock");

  acquire(&icache.lock);
  ip->flags &= ~I_BUSY;
  wakeup(ip);
  release(&icache.lock);
  1016df:	e9 ac 22 00 00       	jmp    103990 <release>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
    panic("iunlock");
  1016e4:	c7 04 24 36 62 10 00 	movl   $0x106236,(%esp)
  1016eb:	e8 90 f1 ff ff       	call   100880 <panic>

001016f0 <ialloc>:
static struct inode* iget(uint dev, uint inum);

// Allocate a new inode with the given type on device dev.
struct inode*
ialloc(uint dev, short type)
{
  1016f0:	55                   	push   %ebp
  1016f1:	89 e5                	mov    %esp,%ebp
  1016f3:	57                   	push   %edi
  1016f4:	56                   	push   %esi
  1016f5:	53                   	push   %ebx
  1016f6:	83 ec 2c             	sub    $0x2c,%esp
  1016f9:	0f b7 45 0c          	movzwl 0xc(%ebp),%eax
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  1016fd:	8d 55 e8             	lea    -0x18(%ebp),%edx
static struct inode* iget(uint dev, uint inum);

// Allocate a new inode with the given type on device dev.
struct inode*
ialloc(uint dev, short type)
{
  101700:	66 89 45 de          	mov    %ax,-0x22(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  101704:	8b 45 08             	mov    0x8(%ebp),%eax
  101707:	e8 b4 f9 ff ff       	call   1010c0 <readsb>
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  10170c:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
  101710:	0f 86 8e 00 00 00    	jbe    1017a4 <ialloc+0xb4>
  101716:	bf 01 00 00 00       	mov    $0x1,%edi
  10171b:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
  101722:	eb 14                	jmp    101738 <ialloc+0x48>
      dip->type = type;
      bwrite(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  101724:	89 34 24             	mov    %esi,(%esp)
  101727:	e8 d4 e8 ff ff       	call   100000 <brelse>
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  10172c:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
  101730:	8b 7d e0             	mov    -0x20(%ebp),%edi
  101733:	39 7d f0             	cmp    %edi,-0x10(%ebp)
  101736:	76 6c                	jbe    1017a4 <ialloc+0xb4>
    bp = bread(dev, IBLOCK(inum));
  101738:	89 f8                	mov    %edi,%eax
  10173a:	c1 e8 03             	shr    $0x3,%eax
  10173d:	83 c0 02             	add    $0x2,%eax
  101740:	89 44 24 04          	mov    %eax,0x4(%esp)
  101744:	8b 45 08             	mov    0x8(%ebp),%eax
  101747:	89 04 24             	mov    %eax,(%esp)
  10174a:	e8 51 e9 ff ff       	call   1000a0 <bread>
  10174f:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + inum%IPB;
  101751:	89 f8                	mov    %edi,%eax
  101753:	83 e0 07             	and    $0x7,%eax
  101756:	c1 e0 06             	shl    $0x6,%eax
  101759:	8d 5c 06 18          	lea    0x18(%esi,%eax,1),%ebx
    if(dip->type == 0){  // a free inode
  10175d:	66 83 3b 00          	cmpw   $0x0,(%ebx)
  101761:	75 c1                	jne    101724 <ialloc+0x34>
      memset(dip, 0, sizeof(*dip));
  101763:	89 1c 24             	mov    %ebx,(%esp)
  101766:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
  10176d:	00 
  10176e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  101775:	00 
  101776:	e8 c5 22 00 00       	call   103a40 <memset>
      dip->type = type;
  10177b:	0f b7 45 de          	movzwl -0x22(%ebp),%eax
  10177f:	66 89 03             	mov    %ax,(%ebx)
      bwrite(bp);   // mark it allocated on the disk
  101782:	89 34 24             	mov    %esi,(%esp)
  101785:	e8 e6 e8 ff ff       	call   100070 <bwrite>
      brelse(bp);
  10178a:	89 34 24             	mov    %esi,(%esp)
  10178d:	e8 6e e8 ff ff       	call   100000 <brelse>
      return iget(dev, inum);
  101792:	8b 45 08             	mov    0x8(%ebp),%eax
  101795:	89 fa                	mov    %edi,%edx
  101797:	e8 74 f8 ff ff       	call   101010 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
  10179c:	83 c4 2c             	add    $0x2c,%esp
  10179f:	5b                   	pop    %ebx
  1017a0:	5e                   	pop    %esi
  1017a1:	5f                   	pop    %edi
  1017a2:	5d                   	pop    %ebp
  1017a3:	c3                   	ret    
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
  1017a4:	c7 04 24 3e 62 10 00 	movl   $0x10623e,(%esp)
  1017ab:	e8 d0 f0 ff ff       	call   100880 <panic>

001017b0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
  1017b0:	55                   	push   %ebp
  1017b1:	89 e5                	mov    %esp,%ebp
  1017b3:	57                   	push   %edi
  1017b4:	89 d7                	mov    %edx,%edi
  1017b6:	56                   	push   %esi
  1017b7:	89 c6                	mov    %eax,%esi
  1017b9:	53                   	push   %ebx
  1017ba:	83 ec 1c             	sub    $0x1c,%esp
static void
bzero(int dev, int bno)
{
  struct buf *bp;
  
  bp = bread(dev, bno);
  1017bd:	89 54 24 04          	mov    %edx,0x4(%esp)
  1017c1:	89 04 24             	mov    %eax,(%esp)
  1017c4:	e8 d7 e8 ff ff       	call   1000a0 <bread>
  memset(bp->data, 0, BSIZE);
  1017c9:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  1017d0:	00 
  1017d1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1017d8:	00 
static void
bzero(int dev, int bno)
{
  struct buf *bp;
  
  bp = bread(dev, bno);
  1017d9:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
  1017db:	8d 40 18             	lea    0x18(%eax),%eax
  1017de:	89 04 24             	mov    %eax,(%esp)
  1017e1:	e8 5a 22 00 00       	call   103a40 <memset>
  bwrite(bp);
  1017e6:	89 1c 24             	mov    %ebx,(%esp)
  1017e9:	e8 82 e8 ff ff       	call   100070 <bwrite>
  brelse(bp);
  1017ee:	89 1c 24             	mov    %ebx,(%esp)
  1017f1:	e8 0a e8 ff ff       	call   100000 <brelse>
  struct superblock sb;
  int bi, m;

  bzero(dev, b);

  readsb(dev, &sb);
  1017f6:	89 f0                	mov    %esi,%eax
  1017f8:	8d 55 e8             	lea    -0x18(%ebp),%edx
  1017fb:	e8 c0 f8 ff ff       	call   1010c0 <readsb>
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  101800:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101803:	89 fa                	mov    %edi,%edx
  101805:	c1 ea 0c             	shr    $0xc,%edx
  101808:	89 34 24             	mov    %esi,(%esp)
  bi = b % BPB;
  m = 1 << (bi % 8);
  10180b:	be 01 00 00 00       	mov    $0x1,%esi
  int bi, m;

  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  101810:	c1 e8 03             	shr    $0x3,%eax
  101813:	8d 44 10 03          	lea    0x3(%eax,%edx,1),%eax
  101817:	89 44 24 04          	mov    %eax,0x4(%esp)
  10181b:	e8 80 e8 ff ff       	call   1000a0 <bread>
  101820:	89 c3                	mov    %eax,%ebx
  bi = b % BPB;
  m = 1 << (bi % 8);
  101822:	89 f8                	mov    %edi,%eax
  101824:	25 ff 0f 00 00       	and    $0xfff,%eax
  101829:	89 c1                	mov    %eax,%ecx
  10182b:	83 e1 07             	and    $0x7,%ecx
  10182e:	d3 e6                	shl    %cl,%esi
  if((bp->data[bi/8] & m) == 0)
  101830:	89 c1                	mov    %eax,%ecx
  101832:	c1 f9 03             	sar    $0x3,%ecx
  101835:	0f b6 54 0b 18       	movzbl 0x18(%ebx,%ecx,1),%edx
  10183a:	0f b6 c2             	movzbl %dl,%eax
  10183d:	85 f0                	test   %esi,%eax
  10183f:	74 22                	je     101863 <bfree+0xb3>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;  // Mark block free on disk.
  101841:	89 f0                	mov    %esi,%eax
  101843:	f7 d0                	not    %eax
  101845:	21 d0                	and    %edx,%eax
  101847:	88 44 0b 18          	mov    %al,0x18(%ebx,%ecx,1)
  bwrite(bp);
  10184b:	89 1c 24             	mov    %ebx,(%esp)
  10184e:	e8 1d e8 ff ff       	call   100070 <bwrite>
  brelse(bp);
  101853:	89 1c 24             	mov    %ebx,(%esp)
  101856:	e8 a5 e7 ff ff       	call   100000 <brelse>
}
  10185b:	83 c4 1c             	add    $0x1c,%esp
  10185e:	5b                   	pop    %ebx
  10185f:	5e                   	pop    %esi
  101860:	5f                   	pop    %edi
  101861:	5d                   	pop    %ebp
  101862:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  101863:	c7 04 24 50 62 10 00 	movl   $0x106250,(%esp)
  10186a:	e8 11 f0 ff ff       	call   100880 <panic>
  10186f:	90                   	nop    

00101870 <iput>:
}

// Caller holds reference to unlocked ip.  Drop reference.
void
iput(struct inode *ip)
{
  101870:	55                   	push   %ebp
  101871:	89 e5                	mov    %esp,%ebp
  101873:	57                   	push   %edi
  101874:	56                   	push   %esi
  101875:	53                   	push   %ebx
  101876:	83 ec 0c             	sub    $0xc,%esp
  101879:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&icache.lock);
  10187c:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  101883:	e8 48 21 00 00       	call   1039d0 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
  101888:	83 7e 08 01          	cmpl   $0x1,0x8(%esi)
  10188c:	0f 85 9e 00 00 00    	jne    101930 <iput+0xc0>
  101892:	8b 46 0c             	mov    0xc(%esi),%eax
  101895:	a8 02                	test   $0x2,%al
  101897:	0f 84 93 00 00 00    	je     101930 <iput+0xc0>
  10189d:	66 83 7e 16 00       	cmpw   $0x0,0x16(%esi)
  1018a2:	0f 85 88 00 00 00    	jne    101930 <iput+0xc0>
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
  1018a8:	a8 01                	test   $0x1,%al
  1018aa:	0f 85 f3 00 00 00    	jne    1019a3 <iput+0x133>
      panic("iput busy");
    ip->flags |= I_BUSY;
  1018b0:	83 c8 01             	or     $0x1,%eax
    release(&icache.lock);
  1018b3:	31 db                	xor    %ebx,%ebx
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
  1018b5:	89 46 0c             	mov    %eax,0xc(%esi)
    release(&icache.lock);
  1018b8:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  1018bf:	e8 cc 20 00 00       	call   103990 <release>
  1018c4:	eb 08                	jmp    1018ce <iput+0x5e>
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
  1018c6:	83 c3 01             	add    $0x1,%ebx
  1018c9:	83 fb 0c             	cmp    $0xc,%ebx
  1018cc:	74 1f                	je     1018ed <iput+0x7d>
    if(ip->addrs[i]){
  1018ce:	8b 54 9e 1c          	mov    0x1c(%esi,%ebx,4),%edx
  1018d2:	85 d2                	test   %edx,%edx
  1018d4:	74 f0                	je     1018c6 <iput+0x56>
      bfree(ip->dev, ip->addrs[i]);
  1018d6:	8b 06                	mov    (%esi),%eax
  1018d8:	e8 d3 fe ff ff       	call   1017b0 <bfree>
      ip->addrs[i] = 0;
  1018dd:	c7 44 9e 1c 00 00 00 	movl   $0x0,0x1c(%esi,%ebx,4)
  1018e4:	00 
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
  1018e5:	83 c3 01             	add    $0x1,%ebx
  1018e8:	83 fb 0c             	cmp    $0xc,%ebx
  1018eb:	75 e1                	jne    1018ce <iput+0x5e>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
  1018ed:	8b 46 4c             	mov    0x4c(%esi),%eax
  1018f0:	85 c0                	test   %eax,%eax
  1018f2:	75 53                	jne    101947 <iput+0xd7>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  1018f4:	c7 46 18 00 00 00 00 	movl   $0x0,0x18(%esi)
  iupdate(ip);
  1018fb:	89 34 24             	mov    %esi,(%esp)
  1018fe:	e8 0d f8 ff ff       	call   101110 <iupdate>
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
    release(&icache.lock);
    itrunc(ip);
    ip->type = 0;
  101903:	66 c7 46 10 00 00    	movw   $0x0,0x10(%esi)
    iupdate(ip);
  101909:	89 34 24             	mov    %esi,(%esp)
  10190c:	e8 ff f7 ff ff       	call   101110 <iupdate>
    acquire(&icache.lock);
  101911:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  101918:	e8 b3 20 00 00       	call   1039d0 <acquire>
    ip->flags = 0;
  10191d:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    wakeup(ip);
  101924:	89 34 24             	mov    %esi,(%esp)
  101927:	e8 94 16 00 00       	call   102fc0 <wakeup>
  10192c:	8d 74 26 00          	lea    0x0(%esi),%esi
  }
  ip->ref--;
  101930:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
  101934:	c7 45 08 60 9a 10 00 	movl   $0x109a60,0x8(%ebp)
}
  10193b:	83 c4 0c             	add    $0xc,%esp
  10193e:	5b                   	pop    %ebx
  10193f:	5e                   	pop    %esi
  101940:	5f                   	pop    %edi
  101941:	5d                   	pop    %ebp
    acquire(&icache.lock);
    ip->flags = 0;
    wakeup(ip);
  }
  ip->ref--;
  release(&icache.lock);
  101942:	e9 49 20 00 00       	jmp    103990 <release>
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
  101947:	89 44 24 04          	mov    %eax,0x4(%esp)
  10194b:	8b 06                	mov    (%esi),%eax
    a = (uint*)bp->data;
  10194d:	30 db                	xor    %bl,%bl
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
  10194f:	89 04 24             	mov    %eax,(%esp)
  101952:	e8 49 e7 ff ff       	call   1000a0 <bread>
    a = (uint*)bp->data;
  101957:	89 c7                	mov    %eax,%edi
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
  101959:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
  10195c:	83 c7 18             	add    $0x18,%edi
  10195f:	31 c0                	xor    %eax,%eax
  101961:	eb 0d                	jmp    101970 <iput+0x100>
    for(j = 0; j < NINDIRECT; j++){
  101963:	83 c3 01             	add    $0x1,%ebx
  101966:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
  10196c:	89 d8                	mov    %ebx,%eax
  10196e:	74 12                	je     101982 <iput+0x112>
      if(a[j])
  101970:	8b 14 87             	mov    (%edi,%eax,4),%edx
  101973:	85 d2                	test   %edx,%edx
  101975:	74 ec                	je     101963 <iput+0xf3>
        bfree(ip->dev, a[j]);
  101977:	8b 06                	mov    (%esi),%eax
  101979:	e8 32 fe ff ff       	call   1017b0 <bfree>
  10197e:	66 90                	xchg   %ax,%ax
  101980:	eb e1                	jmp    101963 <iput+0xf3>
    }
    brelse(bp);
  101982:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101985:	89 04 24             	mov    %eax,(%esp)
  101988:	e8 73 e6 ff ff       	call   100000 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
  10198d:	8b 56 4c             	mov    0x4c(%esi),%edx
  101990:	8b 06                	mov    (%esi),%eax
  101992:	e8 19 fe ff ff       	call   1017b0 <bfree>
    ip->addrs[NDIRECT] = 0;
  101997:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  10199e:	e9 51 ff ff ff       	jmp    1018f4 <iput+0x84>
{
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
      panic("iput busy");
  1019a3:	c7 04 24 63 62 10 00 	movl   $0x106263,(%esp)
  1019aa:	e8 d1 ee ff ff       	call   100880 <panic>
  1019af:	90                   	nop    

001019b0 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
  1019b0:	55                   	push   %ebp
  1019b1:	89 e5                	mov    %esp,%ebp
  1019b3:	57                   	push   %edi
  1019b4:	56                   	push   %esi
  1019b5:	53                   	push   %ebx
  1019b6:	83 ec 2c             	sub    $0x2c,%esp
  1019b9:	8b 75 08             	mov    0x8(%ebp),%esi
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
  1019bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1019bf:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  1019c6:	00 
  1019c7:	89 34 24             	mov    %esi,(%esp)
  1019ca:	89 44 24 04          	mov    %eax,0x4(%esp)
  1019ce:	e8 cd fb ff ff       	call   1015a0 <dirlookup>
  1019d3:	85 c0                	test   %eax,%eax
  1019d5:	0f 85 98 00 00 00    	jne    101a73 <dirlink+0xc3>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
  1019db:	8b 46 18             	mov    0x18(%esi),%eax
  1019de:	85 c0                	test   %eax,%eax
  1019e0:	0f 84 9c 00 00 00    	je     101a82 <dirlink+0xd2>
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
    return -1;
  1019e6:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  1019e9:	31 db                	xor    %ebx,%ebx
  1019eb:	eb 0b                	jmp    1019f8 <dirlink+0x48>
  1019ed:	8d 76 00             	lea    0x0(%esi),%esi
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
  1019f0:	83 c3 10             	add    $0x10,%ebx
  1019f3:	39 5e 18             	cmp    %ebx,0x18(%esi)
  1019f6:	76 24                	jbe    101a1c <dirlink+0x6c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  1019f8:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  1019ff:	00 
  101a00:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  101a04:	89 7c 24 04          	mov    %edi,0x4(%esp)
  101a08:	89 34 24             	mov    %esi,(%esp)
  101a0b:	e8 50 fa ff ff       	call   101460 <readi>
  101a10:	83 f8 10             	cmp    $0x10,%eax
  101a13:	75 52                	jne    101a67 <dirlink+0xb7>
      panic("dirlink read");
    if(de.inum == 0)
  101a15:	66 83 7d e4 00       	cmpw   $0x0,-0x1c(%ebp)
  101a1a:	75 d4                	jne    1019f0 <dirlink+0x40>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  101a1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  101a1f:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  101a26:	00 
  101a27:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a2b:	8d 45 e6             	lea    -0x1a(%ebp),%eax
  101a2e:	89 04 24             	mov    %eax,(%esp)
  101a31:	e8 7a 21 00 00       	call   103bb0 <strncpy>
  de.inum = inum;
  101a36:	0f b7 45 10          	movzwl 0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101a3a:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  101a41:	00 
  101a42:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  101a46:	89 7c 24 04          	mov    %edi,0x4(%esp)
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  101a4a:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101a4e:	89 34 24             	mov    %esi,(%esp)
  101a51:	e8 da f8 ff ff       	call   101330 <writei>
    panic("dirlink");
  101a56:	31 d2                	xor    %edx,%edx
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101a58:	83 f8 10             	cmp    $0x10,%eax
  101a5b:	75 2c                	jne    101a89 <dirlink+0xd9>
    panic("dirlink");
  
  return 0;
}
  101a5d:	83 c4 2c             	add    $0x2c,%esp
  101a60:	89 d0                	mov    %edx,%eax
  101a62:	5b                   	pop    %ebx
  101a63:	5e                   	pop    %esi
  101a64:	5f                   	pop    %edi
  101a65:	5d                   	pop    %ebp
  101a66:	c3                   	ret    
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
  101a67:	c7 04 24 6d 62 10 00 	movl   $0x10626d,(%esp)
  101a6e:	e8 0d ee ff ff       	call   100880 <panic>
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
  101a73:	89 04 24             	mov    %eax,(%esp)
  101a76:	e8 f5 fd ff ff       	call   101870 <iput>
  101a7b:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  101a80:	eb db                	jmp    101a5d <dirlink+0xad>
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
  101a82:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  101a85:	31 db                	xor    %ebx,%ebx
  101a87:	eb 93                	jmp    101a1c <dirlink+0x6c>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
  101a89:	c7 04 24 1e 68 10 00 	movl   $0x10681e,(%esp)
  101a90:	e8 eb ed ff ff       	call   100880 <panic>
  101a95:	8d 74 26 00          	lea    0x0(%esi),%esi
  101a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00101aa0 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  101aa0:	55                   	push   %ebp
  101aa1:	89 e5                	mov    %esp,%ebp
  101aa3:	53                   	push   %ebx
  101aa4:	83 ec 04             	sub    $0x4,%esp
  101aa7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
  101aaa:	89 1c 24             	mov    %ebx,(%esp)
  101aad:	e8 ee fb ff ff       	call   1016a0 <iunlock>
  iput(ip);
  101ab2:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
  101ab5:	83 c4 04             	add    $0x4,%esp
  101ab8:	5b                   	pop    %ebx
  101ab9:	5d                   	pop    %ebp
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
  101aba:	e9 b1 fd ff ff       	jmp    101870 <iput>
  101abf:	90                   	nop    

00101ac0 <ilock>:
}

// Lock the given inode.
void
ilock(struct inode *ip)
{
  101ac0:	55                   	push   %ebp
  101ac1:	89 e5                	mov    %esp,%ebp
  101ac3:	56                   	push   %esi
  101ac4:	53                   	push   %ebx
  101ac5:	83 ec 10             	sub    $0x10,%esp
  101ac8:	8b 75 08             	mov    0x8(%ebp),%esi
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
  101acb:	85 f6                	test   %esi,%esi
  101acd:	0f 84 dd 00 00 00    	je     101bb0 <ilock+0xf0>
  101ad3:	8b 46 08             	mov    0x8(%esi),%eax
  101ad6:	85 c0                	test   %eax,%eax
  101ad8:	0f 8e d2 00 00 00    	jle    101bb0 <ilock+0xf0>
    panic("ilock");

  acquire(&icache.lock);
  101ade:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  101ae5:	e8 e6 1e 00 00       	call   1039d0 <acquire>
  while(ip->flags & I_BUSY)
  101aea:	8b 46 0c             	mov    0xc(%esi),%eax
  101aed:	a8 01                	test   $0x1,%al
  101aef:	74 17                	je     101b08 <ilock+0x48>
    sleep(ip, &icache.lock);
  101af1:	c7 44 24 04 60 9a 10 	movl   $0x109a60,0x4(%esp)
  101af8:	00 
  101af9:	89 34 24             	mov    %esi,(%esp)
  101afc:	e8 af 15 00 00       	call   1030b0 <sleep>

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
  101b01:	8b 46 0c             	mov    0xc(%esi),%eax
  101b04:	a8 01                	test   $0x1,%al
  101b06:	75 e9                	jne    101af1 <ilock+0x31>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
  101b08:	83 c8 01             	or     $0x1,%eax
  101b0b:	89 46 0c             	mov    %eax,0xc(%esi)
  release(&icache.lock);
  101b0e:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  101b15:	e8 76 1e 00 00       	call   103990 <release>

  if(!(ip->flags & I_VALID)){
  101b1a:	f6 46 0c 02          	testb  $0x2,0xc(%esi)
  101b1e:	74 07                	je     101b27 <ilock+0x67>
    brelse(bp);
    ip->flags |= I_VALID;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
  101b20:	83 c4 10             	add    $0x10,%esp
  101b23:	5b                   	pop    %ebx
  101b24:	5e                   	pop    %esi
  101b25:	5d                   	pop    %ebp
  101b26:	c3                   	ret    
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
  release(&icache.lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum));
  101b27:	8b 46 04             	mov    0x4(%esi),%eax
  101b2a:	c1 e8 03             	shr    $0x3,%eax
  101b2d:	83 c0 02             	add    $0x2,%eax
  101b30:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b34:	8b 06                	mov    (%esi),%eax
  101b36:	89 04 24             	mov    %eax,(%esp)
  101b39:	e8 62 e5 ff ff       	call   1000a0 <bread>
  101b3e:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + ip->inum%IPB;
  101b40:	8b 46 04             	mov    0x4(%esi),%eax
  101b43:	83 e0 07             	and    $0x7,%eax
  101b46:	c1 e0 06             	shl    $0x6,%eax
  101b49:	8d 44 03 18          	lea    0x18(%ebx,%eax,1),%eax
    ip->type = dip->type;
  101b4d:	0f b7 10             	movzwl (%eax),%edx
  101b50:	66 89 56 10          	mov    %dx,0x10(%esi)
    ip->major = dip->major;
  101b54:	0f b7 50 02          	movzwl 0x2(%eax),%edx
  101b58:	66 89 56 12          	mov    %dx,0x12(%esi)
    ip->minor = dip->minor;
  101b5c:	0f b7 50 04          	movzwl 0x4(%eax),%edx
  101b60:	66 89 56 14          	mov    %dx,0x14(%esi)
    ip->nlink = dip->nlink;
  101b64:	0f b7 50 06          	movzwl 0x6(%eax),%edx
  101b68:	66 89 56 16          	mov    %dx,0x16(%esi)
    ip->size = dip->size;
  101b6c:	8b 50 08             	mov    0x8(%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  101b6f:	83 c0 0c             	add    $0xc,%eax
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
  101b72:	89 56 18             	mov    %edx,0x18(%esi)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  101b75:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b79:	8d 46 1c             	lea    0x1c(%esi),%eax
  101b7c:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
  101b83:	00 
  101b84:	89 04 24             	mov    %eax,(%esp)
  101b87:	e8 54 1f 00 00       	call   103ae0 <memmove>
    brelse(bp);
  101b8c:	89 1c 24             	mov    %ebx,(%esp)
  101b8f:	e8 6c e4 ff ff       	call   100000 <brelse>
    ip->flags |= I_VALID;
  101b94:	83 4e 0c 02          	orl    $0x2,0xc(%esi)
    if(ip->type == 0)
  101b98:	66 83 7e 10 00       	cmpw   $0x0,0x10(%esi)
  101b9d:	75 81                	jne    101b20 <ilock+0x60>
      panic("ilock: no type");
  101b9f:	c7 04 24 80 62 10 00 	movl   $0x106280,(%esp)
  101ba6:	e8 d5 ec ff ff       	call   100880 <panic>
  101bab:	90                   	nop    
  101bac:	8d 74 26 00          	lea    0x0(%esi),%esi
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
  101bb0:	c7 04 24 7a 62 10 00 	movl   $0x10627a,(%esp)
  101bb7:	e8 c4 ec ff ff       	call   100880 <panic>
  101bbc:	8d 74 26 00          	lea    0x0(%esi),%esi

00101bc0 <namex>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
namex(char *path, int nameiparent, char *name)
{
  101bc0:	55                   	push   %ebp
  101bc1:	89 e5                	mov    %esp,%ebp
  101bc3:	57                   	push   %edi
  101bc4:	56                   	push   %esi
  101bc5:	89 c6                	mov    %eax,%esi
  101bc7:	53                   	push   %ebx
  101bc8:	83 ec 1c             	sub    $0x1c,%esp
  101bcb:	89 55 ec             	mov    %edx,-0x14(%ebp)
  101bce:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
  101bd1:	80 38 2f             	cmpb   $0x2f,(%eax)
  101bd4:	0f 84 12 01 00 00    	je     101cec <namex+0x12c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
  101bda:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  101be0:	8b 40 68             	mov    0x68(%eax),%eax
  101be3:	89 04 24             	mov    %eax,(%esp)
  101be6:	e8 f5 f3 ff ff       	call   100fe0 <idup>
  101beb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  101bee:	eb 03                	jmp    101bf3 <namex+0x33>
{
  char *s;
  int len;

  while(*path == '/')
    path++;
  101bf0:	83 c6 01             	add    $0x1,%esi
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
  101bf3:	0f b6 06             	movzbl (%esi),%eax
  101bf6:	3c 2f                	cmp    $0x2f,%al
  101bf8:	74 f6                	je     101bf0 <namex+0x30>
    path++;
  if(*path == 0)
  101bfa:	84 c0                	test   %al,%al
  101bfc:	0f 84 bb 00 00 00    	je     101cbd <namex+0xfd>
  101c02:	89 f3                	mov    %esi,%ebx
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
  101c04:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
  101c07:	0f b6 03             	movzbl (%ebx),%eax
  101c0a:	3c 2f                	cmp    $0x2f,%al
  101c0c:	74 04                	je     101c12 <namex+0x52>
  101c0e:	84 c0                	test   %al,%al
  101c10:	75 f2                	jne    101c04 <namex+0x44>
    path++;
  len = path - s;
  101c12:	89 df                	mov    %ebx,%edi
  101c14:	29 f7                	sub    %esi,%edi
  if(len >= DIRSIZ)
  101c16:	83 ff 0d             	cmp    $0xd,%edi
  101c19:	0f 8e 7f 00 00 00    	jle    101c9e <namex+0xde>
    memmove(name, s, DIRSIZ);
  101c1f:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  101c26:	00 
  101c27:	89 74 24 04          	mov    %esi,0x4(%esp)
  101c2b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  101c2e:	89 04 24             	mov    %eax,(%esp)
  101c31:	e8 aa 1e 00 00       	call   103ae0 <memmove>
  101c36:	eb 03                	jmp    101c3b <namex+0x7b>
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
    path++;
  101c38:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
  101c3b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
  101c3e:	74 f8                	je     101c38 <namex+0x78>
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
  101c40:	85 db                	test   %ebx,%ebx
  101c42:	74 79                	je     101cbd <namex+0xfd>
    ilock(ip);
  101c44:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101c47:	89 04 24             	mov    %eax,(%esp)
  101c4a:	e8 71 fe ff ff       	call   101ac0 <ilock>
    if(ip->type != T_DIR){
  101c4f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101c52:	66 83 78 10 01       	cmpw   $0x1,0x10(%eax)
  101c57:	75 79                	jne    101cd2 <namex+0x112>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
  101c59:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101c5c:	85 c0                	test   %eax,%eax
  101c5e:	74 09                	je     101c69 <namex+0xa9>
  101c60:	80 3b 00             	cmpb   $0x0,(%ebx)
  101c63:	0f 84 9a 00 00 00    	je     101d03 <namex+0x143>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
  101c69:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  101c70:	00 
  101c71:	8b 45 e8             	mov    -0x18(%ebp),%eax
  101c74:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c78:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101c7b:	89 04 24             	mov    %eax,(%esp)
  101c7e:	e8 1d f9 ff ff       	call   1015a0 <dirlookup>
  101c83:	85 c0                	test   %eax,%eax
  101c85:	89 c6                	mov    %eax,%esi
  101c87:	74 46                	je     101ccf <namex+0x10f>
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
  101c89:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101c8c:	89 04 24             	mov    %eax,(%esp)
  101c8f:	e8 0c fe ff ff       	call   101aa0 <iunlockput>
  101c94:	89 75 f0             	mov    %esi,-0x10(%ebp)
  101c97:	89 de                	mov    %ebx,%esi
  101c99:	e9 55 ff ff ff       	jmp    101bf3 <namex+0x33>
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
  101c9e:	89 7c 24 08          	mov    %edi,0x8(%esp)
  101ca2:	89 74 24 04          	mov    %esi,0x4(%esp)
  101ca6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  101ca9:	89 04 24             	mov    %eax,(%esp)
  101cac:	e8 2f 1e 00 00       	call   103ae0 <memmove>
    name[len] = 0;
  101cb1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  101cb4:	c6 04 38 00          	movb   $0x0,(%eax,%edi,1)
  101cb8:	e9 7e ff ff ff       	jmp    101c3b <namex+0x7b>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
  101cbd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101cc0:	85 c0                	test   %eax,%eax
  101cc2:	75 55                	jne    101d19 <namex+0x159>
    iput(ip);
    return 0;
  }
  return ip;
}
  101cc4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101cc7:	83 c4 1c             	add    $0x1c,%esp
  101cca:	5b                   	pop    %ebx
  101ccb:	5e                   	pop    %esi
  101ccc:	5f                   	pop    %edi
  101ccd:	5d                   	pop    %ebp
  101cce:	c3                   	ret    
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
  101ccf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101cd2:	89 04 24             	mov    %eax,(%esp)
  101cd5:	e8 c6 fd ff ff       	call   101aa0 <iunlockput>
  101cda:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
  101ce1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101ce4:	83 c4 1c             	add    $0x1c,%esp
  101ce7:	5b                   	pop    %ebx
  101ce8:	5e                   	pop    %esi
  101ce9:	5f                   	pop    %edi
  101cea:	5d                   	pop    %ebp
  101ceb:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  101cec:	ba 01 00 00 00       	mov    $0x1,%edx
  101cf1:	b8 01 00 00 00       	mov    $0x1,%eax
  101cf6:	e8 15 f3 ff ff       	call   101010 <iget>
  101cfb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  101cfe:	e9 f0 fe ff ff       	jmp    101bf3 <namex+0x33>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
  101d03:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101d06:	89 04 24             	mov    %eax,(%esp)
  101d09:	e8 92 f9 ff ff       	call   1016a0 <iunlock>
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
  101d0e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101d11:	83 c4 1c             	add    $0x1c,%esp
  101d14:	5b                   	pop    %ebx
  101d15:	5e                   	pop    %esi
  101d16:	5f                   	pop    %edi
  101d17:	5d                   	pop    %ebp
  101d18:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
  101d19:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101d1c:	89 04 24             	mov    %eax,(%esp)
  101d1f:	e8 4c fb ff ff       	call   101870 <iput>
  101d24:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  101d2b:	eb 97                	jmp    101cc4 <namex+0x104>
  101d2d:	8d 76 00             	lea    0x0(%esi),%esi

00101d30 <nameiparent>:
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
  101d30:	55                   	push   %ebp
  return namex(path, 1, name);
  101d31:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
  101d36:	89 e5                	mov    %esp,%ebp
  101d38:	8b 45 08             	mov    0x8(%ebp),%eax
  101d3b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  return namex(path, 1, name);
}
  101d3e:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
  101d3f:	e9 7c fe ff ff       	jmp    101bc0 <namex>
  101d44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101d4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00101d50 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
  101d50:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
  101d51:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
  101d53:	89 e5                	mov    %esp,%ebp
  101d55:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
  101d58:	8b 45 08             	mov    0x8(%ebp),%eax
  101d5b:	8d 4d f2             	lea    -0xe(%ebp),%ecx
  101d5e:	e8 5d fe ff ff       	call   101bc0 <namex>
}
  101d63:	c9                   	leave  
  101d64:	c3                   	ret    
  101d65:	8d 74 26 00          	lea    0x0(%esi),%esi
  101d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00101d70 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(void)
{
  101d70:	55                   	push   %ebp
  101d71:	89 e5                	mov    %esp,%ebp
  101d73:	83 ec 08             	sub    $0x8,%esp
  initlock(&icache.lock, "icache");
  101d76:	c7 44 24 04 8f 62 10 	movl   $0x10628f,0x4(%esp)
  101d7d:	00 
  101d7e:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  101d85:	e8 c6 1a 00 00       	call   103850 <initlock>
}
  101d8a:	c9                   	leave  
  101d8b:	c3                   	ret    
  101d8c:	90                   	nop    
  101d8d:	90                   	nop    
  101d8e:	90                   	nop    
  101d8f:	90                   	nop    

00101d90 <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
  101d90:	55                   	push   %ebp
  101d91:	89 c1                	mov    %eax,%ecx
  101d93:	89 e5                	mov    %esp,%ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  101d95:	ba f7 01 00 00       	mov    $0x1f7,%edx
  101d9a:	ec                   	in     (%dx),%al
  return data;
  101d9b:	0f b6 d0             	movzbl %al,%edx
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
  101d9e:	89 d0                	mov    %edx,%eax
  101da0:	25 c0 00 00 00       	and    $0xc0,%eax
  101da5:	83 f8 40             	cmp    $0x40,%eax
  101da8:	75 eb                	jne    101d95 <idewait+0x5>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
  101daa:	85 c9                	test   %ecx,%ecx
  101dac:	74 0a                	je     101db8 <idewait+0x28>
  101dae:	83 e2 21             	and    $0x21,%edx
  101db1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101db6:	75 02                	jne    101dba <idewait+0x2a>
  101db8:	31 c0                	xor    %eax,%eax
    return -1;
  return 0;
}
  101dba:	5d                   	pop    %ebp
  101dbb:	c3                   	ret    
  101dbc:	8d 74 26 00          	lea    0x0(%esi),%esi

00101dc0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  101dc0:	55                   	push   %ebp
  101dc1:	89 e5                	mov    %esp,%ebp
  101dc3:	56                   	push   %esi
  101dc4:	89 c6                	mov    %eax,%esi
  101dc6:	53                   	push   %ebx
  101dc7:	83 ec 10             	sub    $0x10,%esp
  if(b == 0)
  101dca:	85 c0                	test   %eax,%eax
  101dcc:	0f 84 81 00 00 00    	je     101e53 <idestart+0x93>
    panic("idestart");

  idewait(0);
  101dd2:	31 c0                	xor    %eax,%eax
  101dd4:	e8 b7 ff ff ff       	call   101d90 <idewait>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  101dd9:	31 c0                	xor    %eax,%eax
  101ddb:	ba f6 03 00 00       	mov    $0x3f6,%edx
  101de0:	ee                   	out    %al,(%dx)
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, 1);  // number of sectors
  outb(0x1f3, b->sector & 0xff);
  101de1:	b8 01 00 00 00       	mov    $0x1,%eax
  101de6:	ba f2 01 00 00       	mov    $0x1f2,%edx
  101deb:	ee                   	out    %al,(%dx)
  101dec:	8b 46 08             	mov    0x8(%esi),%eax
  101def:	b2 f3                	mov    $0xf3,%dl
  101df1:	ee                   	out    %al,(%dx)
  outb(0x1f4, (b->sector >> 8) & 0xff);
  outb(0x1f5, (b->sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
  101df2:	c1 e8 08             	shr    $0x8,%eax
  101df5:	b2 f4                	mov    $0xf4,%dl
  101df7:	ee                   	out    %al,(%dx)
  101df8:	c1 e8 08             	shr    $0x8,%eax
  101dfb:	b2 f5                	mov    $0xf5,%dl
  101dfd:	ee                   	out    %al,(%dx)
  101dfe:	0f b6 4e 04          	movzbl 0x4(%esi),%ecx
  101e02:	c1 e8 08             	shr    $0x8,%eax
  101e05:	bb f6 01 00 00       	mov    $0x1f6,%ebx
  101e0a:	83 e0 0f             	and    $0xf,%eax
  101e0d:	89 da                	mov    %ebx,%edx
  101e0f:	83 e1 01             	and    $0x1,%ecx
  101e12:	c1 e1 04             	shl    $0x4,%ecx
  101e15:	09 c1                	or     %eax,%ecx
  101e17:	83 c9 e0             	or     $0xffffffe0,%ecx
  101e1a:	89 c8                	mov    %ecx,%eax
  101e1c:	ee                   	out    %al,(%dx)
  101e1d:	f6 06 04             	testb  $0x4,(%esi)
  101e20:	75 12                	jne    101e34 <idestart+0x74>
  101e22:	b8 20 00 00 00       	mov    $0x20,%eax
  101e27:	ba f7 01 00 00       	mov    $0x1f7,%edx
  101e2c:	ee                   	out    %al,(%dx)
    outb(0x1f7, IDE_CMD_WRITE);
    outsl(0x1f0, b->data, 512/4);
  } else {
    outb(0x1f7, IDE_CMD_READ);
  }
}
  101e2d:	83 c4 10             	add    $0x10,%esp
  101e30:	5b                   	pop    %ebx
  101e31:	5e                   	pop    %esi
  101e32:	5d                   	pop    %ebp
  101e33:	c3                   	ret    
  101e34:	b8 30 00 00 00       	mov    $0x30,%eax
  101e39:	b2 f7                	mov    $0xf7,%dl
  101e3b:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
  101e3c:	ba f0 01 00 00       	mov    $0x1f0,%edx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  101e41:	83 c6 18             	add    $0x18,%esi
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
  101e44:	b9 80 00 00 00       	mov    $0x80,%ecx
  101e49:	fc                   	cld    
  101e4a:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  101e4c:	83 c4 10             	add    $0x10,%esp
  101e4f:	5b                   	pop    %ebx
  101e50:	5e                   	pop    %esi
  101e51:	5d                   	pop    %ebp
  101e52:	c3                   	ret    
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  101e53:	c7 04 24 96 62 10 00 	movl   $0x106296,(%esp)
  101e5a:	e8 21 ea ff ff       	call   100880 <panic>
  101e5f:	90                   	nop    

00101e60 <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
  101e60:	55                   	push   %ebp
  101e61:	89 e5                	mov    %esp,%ebp
  101e63:	53                   	push   %ebx
  101e64:	83 ec 14             	sub    $0x14,%esp
  101e67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!(b->flags & B_BUSY))
  101e6a:	8b 03                	mov    (%ebx),%eax
  101e6c:	a8 01                	test   $0x1,%al
  101e6e:	0f 84 90 00 00 00    	je     101f04 <iderw+0xa4>
    panic("iderw: buf not busy");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
  101e74:	83 e0 06             	and    $0x6,%eax
  101e77:	83 f8 02             	cmp    $0x2,%eax
  101e7a:	0f 84 90 00 00 00    	je     101f10 <iderw+0xb0>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
  101e80:	8b 53 04             	mov    0x4(%ebx),%edx
  101e83:	85 d2                	test   %edx,%edx
  101e85:	74 0d                	je     101e94 <iderw+0x34>
  101e87:	a1 38 78 10 00       	mov    0x107838,%eax
  101e8c:	85 c0                	test   %eax,%eax
  101e8e:	0f 84 88 00 00 00    	je     101f1c <iderw+0xbc>
    panic("idrw: ide disk 1 not present");

  acquire(&idelock);
  101e94:	c7 04 24 00 78 10 00 	movl   $0x107800,(%esp)
  101e9b:	e8 30 1b 00 00       	call   1039d0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)
  101ea0:	ba 34 78 10 00       	mov    $0x107834,%edx
    panic("idrw: ide disk 1 not present");

  acquire(&idelock);

  // Append b to idequeue.
  b->qnext = 0;
  101ea5:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)
  101eac:	a1 34 78 10 00       	mov    0x107834,%eax
  101eb1:	85 c0                	test   %eax,%eax
  101eb3:	74 0a                	je     101ebf <iderw+0x5f>
  101eb5:	8d 50 14             	lea    0x14(%eax),%edx
  101eb8:	8b 40 14             	mov    0x14(%eax),%eax
  101ebb:	85 c0                	test   %eax,%eax
  101ebd:	75 f6                	jne    101eb5 <iderw+0x55>
    ;
  *pp = b;
  101ebf:	89 1a                	mov    %ebx,(%edx)
  
  // Start disk if necessary.
  if(idequeue == b)
  101ec1:	39 1d 34 78 10 00    	cmp    %ebx,0x107834
  101ec7:	75 17                	jne    101ee0 <iderw+0x80>
  101ec9:	eb 30                	jmp    101efb <iderw+0x9b>
  101ecb:	90                   	nop    
  101ecc:	8d 74 26 00          	lea    0x0(%esi),%esi
    idestart(b);
  
  // Wait for request to finish.
  // Assuming will not sleep too long: ignore proc->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID) {
    sleep(b, &idelock);
  101ed0:	c7 44 24 04 00 78 10 	movl   $0x107800,0x4(%esp)
  101ed7:	00 
  101ed8:	89 1c 24             	mov    %ebx,(%esp)
  101edb:	e8 d0 11 00 00       	call   1030b0 <sleep>
  if(idequeue == b)
    idestart(b);
  
  // Wait for request to finish.
  // Assuming will not sleep too long: ignore proc->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID) {
  101ee0:	8b 03                	mov    (%ebx),%eax
  101ee2:	83 e0 06             	and    $0x6,%eax
  101ee5:	83 f8 02             	cmp    $0x2,%eax
  101ee8:	75 e6                	jne    101ed0 <iderw+0x70>
    sleep(b, &idelock);
  }

  release(&idelock);
  101eea:	c7 45 08 00 78 10 00 	movl   $0x107800,0x8(%ebp)
}
  101ef1:	83 c4 14             	add    $0x14,%esp
  101ef4:	5b                   	pop    %ebx
  101ef5:	5d                   	pop    %ebp
  // Assuming will not sleep too long: ignore proc->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID) {
    sleep(b, &idelock);
  }

  release(&idelock);
  101ef6:	e9 95 1a 00 00       	jmp    103990 <release>
    ;
  *pp = b;
  
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
  101efb:	89 d8                	mov    %ebx,%eax
  101efd:	e8 be fe ff ff       	call   101dc0 <idestart>
  101f02:	eb dc                	jmp    101ee0 <iderw+0x80>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!(b->flags & B_BUSY))
    panic("iderw: buf not busy");
  101f04:	c7 04 24 9f 62 10 00 	movl   $0x10629f,(%esp)
  101f0b:	e8 70 e9 ff ff       	call   100880 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  101f10:	c7 04 24 b3 62 10 00 	movl   $0x1062b3,(%esp)
  101f17:	e8 64 e9 ff ff       	call   100880 <panic>
  if(b->dev != 0 && !havedisk1)
    panic("idrw: ide disk 1 not present");
  101f1c:	c7 04 24 c8 62 10 00 	movl   $0x1062c8,(%esp)
  101f23:	e8 58 e9 ff ff       	call   100880 <panic>
  101f28:	90                   	nop    
  101f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00101f30 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
  101f30:	55                   	push   %ebp
  101f31:	89 e5                	mov    %esp,%ebp
  101f33:	57                   	push   %edi
  101f34:	53                   	push   %ebx
  101f35:	83 ec 10             	sub    $0x10,%esp
  struct buf *b;

  // Take first buffer off queue.
  acquire(&idelock);
  101f38:	c7 04 24 00 78 10 00 	movl   $0x107800,(%esp)
  101f3f:	e8 8c 1a 00 00       	call   1039d0 <acquire>
  if((b = idequeue) == 0){
  101f44:	8b 1d 34 78 10 00    	mov    0x107834,%ebx
  101f4a:	85 db                	test   %ebx,%ebx
  101f4c:	74 62                	je     101fb0 <ideintr+0x80>
    release(&idelock);
    cprintf("Spurious IDE interrupt.\n");
    return;
  }
  idequeue = b->qnext;
  101f4e:	8b 43 14             	mov    0x14(%ebx),%eax
  101f51:	a3 34 78 10 00       	mov    %eax,0x107834

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
  101f56:	f6 03 04             	testb  $0x4,(%ebx)
  101f59:	74 35                	je     101f90 <ideintr+0x60>
    insl(0x1f0, b->data, 512/4);
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
  101f5b:	8b 03                	mov    (%ebx),%eax
  101f5d:	83 c8 02             	or     $0x2,%eax
  101f60:	83 e0 fb             	and    $0xfffffffb,%eax
  101f63:	89 03                	mov    %eax,(%ebx)
  wakeup(b);
  101f65:	89 1c 24             	mov    %ebx,(%esp)
  101f68:	e8 53 10 00 00       	call   102fc0 <wakeup>
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
  101f6d:	a1 34 78 10 00       	mov    0x107834,%eax
  101f72:	85 c0                	test   %eax,%eax
  101f74:	74 05                	je     101f7b <ideintr+0x4b>
    idestart(idequeue);
  101f76:	e8 45 fe ff ff       	call   101dc0 <idestart>

  release(&idelock);
  101f7b:	c7 04 24 00 78 10 00 	movl   $0x107800,(%esp)
  101f82:	e8 09 1a 00 00       	call   103990 <release>
}
  101f87:	83 c4 10             	add    $0x10,%esp
  101f8a:	5b                   	pop    %ebx
  101f8b:	5f                   	pop    %edi
  101f8c:	5d                   	pop    %ebp
  101f8d:	c3                   	ret    
  101f8e:	66 90                	xchg   %ax,%ax
    return;
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
  101f90:	b8 01 00 00 00       	mov    $0x1,%eax
  101f95:	e8 f6 fd ff ff       	call   101d90 <idewait>
  101f9a:	85 c0                	test   %eax,%eax
  101f9c:	78 bd                	js     101f5b <ideintr+0x2b>
  101f9e:	8d 7b 18             	lea    0x18(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
  101fa1:	ba f0 01 00 00       	mov    $0x1f0,%edx
  101fa6:	b9 80 00 00 00       	mov    $0x80,%ecx
  101fab:	fc                   	cld    
  101fac:	f3 6d                	rep insl (%dx),%es:(%edi)
  101fae:	eb ab                	jmp    101f5b <ideintr+0x2b>
  struct buf *b;

  // Take first buffer off queue.
  acquire(&idelock);
  if((b = idequeue) == 0){
    release(&idelock);
  101fb0:	c7 04 24 00 78 10 00 	movl   $0x107800,(%esp)
  101fb7:	e8 d4 19 00 00       	call   103990 <release>
    cprintf("Spurious IDE interrupt.\n");
  101fbc:	c7 04 24 e5 62 10 00 	movl   $0x1062e5,(%esp)
  101fc3:	e8 f8 e4 ff ff       	call   1004c0 <cprintf>
  101fc8:	eb bd                	jmp    101f87 <ideintr+0x57>
  101fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00101fd0 <ideinit>:
  return 0;
}

void
ideinit(void)
{
  101fd0:	55                   	push   %ebp
  101fd1:	89 e5                	mov    %esp,%ebp
  101fd3:	83 ec 08             	sub    $0x8,%esp
  int i;

  initlock(&idelock, "ide");
  101fd6:	c7 44 24 04 fe 62 10 	movl   $0x1062fe,0x4(%esp)
  101fdd:	00 
  101fde:	c7 04 24 00 78 10 00 	movl   $0x107800,(%esp)
  101fe5:	e8 66 18 00 00       	call   103850 <initlock>
  picenable(IRQ_IDE);
  101fea:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  101ff1:	e8 ca 0a 00 00       	call   102ac0 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
  101ff6:	a1 80 b0 10 00       	mov    0x10b080,%eax
  101ffb:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  102002:	83 e8 01             	sub    $0x1,%eax
  102005:	89 44 24 04          	mov    %eax,0x4(%esp)
  102009:	e8 82 00 00 00       	call   102090 <ioapicenable>
  idewait(0);
  10200e:	31 c0                	xor    %eax,%eax
  102010:	e8 7b fd ff ff       	call   101d90 <idewait>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102015:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  10201a:	ba f6 01 00 00       	mov    $0x1f6,%edx
  10201f:	ee                   	out    %al,(%dx)
  102020:	31 c9                	xor    %ecx,%ecx
  102022:	eb 0b                	jmp    10202f <ideinit+0x5f>
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
  102024:	83 c1 01             	add    $0x1,%ecx
  102027:	81 f9 e8 03 00 00    	cmp    $0x3e8,%ecx
  10202d:	74 14                	je     102043 <ideinit+0x73>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  10202f:	ba f7 01 00 00       	mov    $0x1f7,%edx
  102034:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
  102035:	84 c0                	test   %al,%al
  102037:	74 eb                	je     102024 <ideinit+0x54>
      havedisk1 = 1;
  102039:	c7 05 38 78 10 00 01 	movl   $0x1,0x107838
  102040:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102043:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
  102048:	ba f6 01 00 00       	mov    $0x1f6,%edx
  10204d:	ee                   	out    %al,(%dx)
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
  10204e:	c9                   	leave  
  10204f:	c3                   	ret    

00102050 <ioapicread>:
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  102050:	8b 15 34 aa 10 00    	mov    0x10aa34,%edx
  uint data;
};

static uint
ioapicread(int reg)
{
  102056:	55                   	push   %ebp
  102057:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
  102059:	89 02                	mov    %eax,(%edx)
  return ioapic->data;
  10205b:	a1 34 aa 10 00       	mov    0x10aa34,%eax
}
  102060:	5d                   	pop    %ebp

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
  102061:	8b 40 10             	mov    0x10(%eax),%eax
}
  102064:	c3                   	ret    
  102065:	8d 74 26 00          	lea    0x0(%esi),%esi
  102069:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00102070 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  102070:	8b 0d 34 aa 10 00    	mov    0x10aa34,%ecx
  return ioapic->data;
}

static void
ioapicwrite(int reg, uint data)
{
  102076:	55                   	push   %ebp
  102077:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
  102079:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
  10207b:	a1 34 aa 10 00       	mov    0x10aa34,%eax
  102080:	89 50 10             	mov    %edx,0x10(%eax)
}
  102083:	5d                   	pop    %ebp
  102084:	c3                   	ret    
  102085:	8d 74 26 00          	lea    0x0(%esi),%esi
  102089:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00102090 <ioapicenable>:
  }
}

void
ioapicenable(int irq, int cpunum)
{
  102090:	55                   	push   %ebp
  102091:	89 e5                	mov    %esp,%ebp
  102093:	83 ec 08             	sub    $0x8,%esp
  102096:	89 1c 24             	mov    %ebx,(%esp)
  102099:	89 74 24 04          	mov    %esi,0x4(%esp)
  if(!ismp)
  10209d:	8b 15 84 aa 10 00    	mov    0x10aa84,%edx
  }
}

void
ioapicenable(int irq, int cpunum)
{
  1020a3:	8b 45 08             	mov    0x8(%ebp),%eax
  1020a6:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(!ismp)
  1020a9:	85 d2                	test   %edx,%edx
  1020ab:	75 0b                	jne    1020b8 <ioapicenable+0x28>
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
  1020ad:	8b 1c 24             	mov    (%esp),%ebx
  1020b0:	8b 74 24 04          	mov    0x4(%esp),%esi
  1020b4:	89 ec                	mov    %ebp,%esp
  1020b6:	5d                   	pop    %ebp
  1020b7:	c3                   	ret    
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  1020b8:	8d 34 00             	lea    (%eax,%eax,1),%esi
  1020bb:	8d 50 20             	lea    0x20(%eax),%edx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
  1020be:	c1 e3 18             	shl    $0x18,%ebx
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  1020c1:	8d 46 10             	lea    0x10(%esi),%eax
  1020c4:	e8 a7 ff ff ff       	call   102070 <ioapicwrite>
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
  1020c9:	8d 46 11             	lea    0x11(%esi),%eax
  1020cc:	89 da                	mov    %ebx,%edx
}
  1020ce:	8b 74 24 04          	mov    0x4(%esp),%esi
  1020d2:	8b 1c 24             	mov    (%esp),%ebx
  1020d5:	89 ec                	mov    %ebp,%esp
  1020d7:	5d                   	pop    %ebp

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
  1020d8:	eb 96                	jmp    102070 <ioapicwrite>
  1020da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001020e0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
  1020e0:	55                   	push   %ebp
  1020e1:	89 e5                	mov    %esp,%ebp
  1020e3:	57                   	push   %edi
  1020e4:	56                   	push   %esi
  1020e5:	53                   	push   %ebx
  1020e6:	83 ec 0c             	sub    $0xc,%esp
  int i, id, maxintr;

  if(!ismp)
  1020e9:	8b 0d 84 aa 10 00    	mov    0x10aa84,%ecx
  1020ef:	85 c9                	test   %ecx,%ecx
  1020f1:	75 0d                	jne    102100 <ioapicinit+0x20>
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
  1020f3:	83 c4 0c             	add    $0xc,%esp
  1020f6:	5b                   	pop    %ebx
  1020f7:	5e                   	pop    %esi
  1020f8:	5f                   	pop    %edi
  1020f9:	5d                   	pop    %ebp
  1020fa:	c3                   	ret    
  1020fb:	90                   	nop    
  1020fc:	8d 74 26 00          	lea    0x0(%esi),%esi

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  102100:	b8 01 00 00 00       	mov    $0x1,%eax
  int i, id, maxintr;

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  102105:	c7 05 34 aa 10 00 00 	movl   $0xfec00000,0x10aa34
  10210c:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  10210f:	e8 3c ff ff ff       	call   102050 <ioapicread>
  102114:	c1 e8 10             	shr    $0x10,%eax
  102117:	0f b6 f8             	movzbl %al,%edi
  id = ioapicread(REG_ID) >> 24;
  10211a:	31 c0                	xor    %eax,%eax
  10211c:	e8 2f ff ff ff       	call   102050 <ioapicread>
  if(id != ioapicid)
  102121:	0f b6 15 80 aa 10 00 	movzbl 0x10aa80,%edx
  102128:	c1 e8 18             	shr    $0x18,%eax
  10212b:	39 c2                	cmp    %eax,%edx
  10212d:	74 0c                	je     10213b <ioapicinit+0x5b>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
  10212f:	c7 04 24 04 63 10 00 	movl   $0x106304,(%esp)
  102136:	e8 85 e3 ff ff       	call   1004c0 <cprintf>
  10213b:	31 f6                	xor    %esi,%esi
  10213d:	bb 10 00 00 00       	mov    $0x10,%ebx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
  102142:	8d 56 20             	lea    0x20(%esi),%edx
  102145:	89 d8                	mov    %ebx,%eax
  102147:	81 ca 00 00 01 00    	or     $0x10000,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  10214d:	83 c6 01             	add    $0x1,%esi
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
  102150:	e8 1b ff ff ff       	call   102070 <ioapicwrite>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  102155:	8d 43 01             	lea    0x1(%ebx),%eax
  102158:	31 d2                	xor    %edx,%edx
  10215a:	e8 11 ff ff ff       	call   102070 <ioapicwrite>
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  10215f:	83 c3 02             	add    $0x2,%ebx
  102162:	39 f7                	cmp    %esi,%edi
  102164:	7d dc                	jge    102142 <ioapicinit+0x62>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
  102166:	83 c4 0c             	add    $0xc,%esp
  102169:	5b                   	pop    %ebx
  10216a:	5e                   	pop    %esi
  10216b:	5f                   	pop    %edi
  10216c:	5d                   	pop    %ebp
  10216d:	c3                   	ret    
  10216e:	90                   	nop    
  10216f:	90                   	nop    

00102170 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc()
{
  102170:	55                   	push   %ebp
  102171:	89 e5                	mov    %esp,%ebp
  102173:	53                   	push   %ebx
  102174:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  acquire(&kmem.lock);
  102177:	c7 04 24 40 aa 10 00 	movl   $0x10aa40,(%esp)
  10217e:	e8 4d 18 00 00       	call   1039d0 <acquire>
  r = kmem.freelist;
  102183:	8b 1d 74 aa 10 00    	mov    0x10aa74,%ebx
  if(r)
  102189:	85 db                	test   %ebx,%ebx
  10218b:	74 07                	je     102194 <kalloc+0x24>
    kmem.freelist = r->next;
  10218d:	8b 03                	mov    (%ebx),%eax
  10218f:	a3 74 aa 10 00       	mov    %eax,0x10aa74
  release(&kmem.lock);
  102194:	c7 04 24 40 aa 10 00 	movl   $0x10aa40,(%esp)
  10219b:	e8 f0 17 00 00       	call   103990 <release>
  return (char*) r;
}
  1021a0:	89 d8                	mov    %ebx,%eax
  1021a2:	83 c4 04             	add    $0x4,%esp
  1021a5:	5b                   	pop    %ebx
  1021a6:	5d                   	pop    %ebp
  1021a7:	c3                   	ret    
  1021a8:	90                   	nop    
  1021a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

001021b0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
  1021b0:	55                   	push   %ebp
  1021b1:	89 e5                	mov    %esp,%ebp
  1021b3:	53                   	push   %ebx
  1021b4:	83 ec 14             	sub    $0x14,%esp
  1021b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if(((uint) v) % PGSIZE || (uint)v < 1024*1024 || (uint)v >= PHYSTOP) 
  1021ba:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
  1021c0:	75 10                	jne    1021d2 <kfree+0x22>
  1021c2:	81 fb ff ff 0f 00    	cmp    $0xfffff,%ebx
  1021c8:	76 08                	jbe    1021d2 <kfree+0x22>
  1021ca:	81 fb ff ff ff 00    	cmp    $0xffffff,%ebx
  1021d0:	76 0e                	jbe    1021e0 <kfree+0x30>
    panic("kfree");
  1021d2:	c7 04 24 36 63 10 00 	movl   $0x106336,(%esp)
  1021d9:	e8 a2 e6 ff ff       	call   100880 <panic>
  1021de:	66 90                	xchg   %ax,%ax

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
  1021e0:	89 1c 24             	mov    %ebx,(%esp)
  1021e3:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  1021ea:	00 
  1021eb:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1021f2:	00 
  1021f3:	e8 48 18 00 00       	call   103a40 <memset>

  acquire(&kmem.lock);
  1021f8:	c7 04 24 40 aa 10 00 	movl   $0x10aa40,(%esp)
  1021ff:	e8 cc 17 00 00       	call   1039d0 <acquire>
  r = (struct run *) v;
  r->next = kmem.freelist;
  102204:	a1 74 aa 10 00       	mov    0x10aa74,%eax
  102209:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  10220b:	89 1d 74 aa 10 00    	mov    %ebx,0x10aa74
  release(&kmem.lock);
  102211:	c7 45 08 40 aa 10 00 	movl   $0x10aa40,0x8(%ebp)
}
  102218:	83 c4 14             	add    $0x14,%esp
  10221b:	5b                   	pop    %ebx
  10221c:	5d                   	pop    %ebp

  acquire(&kmem.lock);
  r = (struct run *) v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  release(&kmem.lock);
  10221d:	e9 6e 17 00 00       	jmp    103990 <release>
  102222:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  102229:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00102230 <kinit>:
} kmem;

// Initialize free list of physical pages.
void
kinit(void)
{
  102230:	55                   	push   %ebp
  102231:	89 e5                	mov    %esp,%ebp
  102233:	53                   	push   %ebx
  extern char end[];

  initlock(&kmem.lock, "kmem");
  char *p = (char*)PGROUNDUP((uint)end);
  102234:	bb 23 e8 10 00       	mov    $0x10e823,%ebx
} kmem;

// Initialize free list of physical pages.
void
kinit(void)
{
  102239:	83 ec 14             	sub    $0x14,%esp
  extern char end[];

  initlock(&kmem.lock, "kmem");
  char *p = (char*)PGROUNDUP((uint)end);
  10223c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
void
kinit(void)
{
  extern char end[];

  initlock(&kmem.lock, "kmem");
  102242:	c7 44 24 04 3c 63 10 	movl   $0x10633c,0x4(%esp)
  102249:	00 
  10224a:	c7 04 24 40 aa 10 00 	movl   $0x10aa40,(%esp)
  102251:	e8 fa 15 00 00       	call   103850 <initlock>
  char *p = (char*)PGROUNDUP((uint)end);
  for( ; p + PGSIZE - 1 < (char*) PHYSTOP; p += PGSIZE)
  102256:	8d 83 ff 0f 00 00    	lea    0xfff(%ebx),%eax
  10225c:	3d ff ff ff 00       	cmp    $0xffffff,%eax
  102261:	77 1b                	ja     10227e <kinit+0x4e>
    kfree(p);
  102263:	89 1c 24             	mov    %ebx,(%esp)
{
  extern char end[];

  initlock(&kmem.lock, "kmem");
  char *p = (char*)PGROUNDUP((uint)end);
  for( ; p + PGSIZE - 1 < (char*) PHYSTOP; p += PGSIZE)
  102266:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
  10226c:	e8 3f ff ff ff       	call   1021b0 <kfree>
{
  extern char end[];

  initlock(&kmem.lock, "kmem");
  char *p = (char*)PGROUNDUP((uint)end);
  for( ; p + PGSIZE - 1 < (char*) PHYSTOP; p += PGSIZE)
  102271:	8d 83 ff 0f 00 00    	lea    0xfff(%ebx),%eax
  102277:	3d ff ff ff 00       	cmp    $0xffffff,%eax
  10227c:	76 e5                	jbe    102263 <kinit+0x33>
    kfree(p);
}
  10227e:	83 c4 14             	add    $0x14,%esp
  102281:	5b                   	pop    %ebx
  102282:	5d                   	pop    %ebp
  102283:	c3                   	ret    
  102284:	90                   	nop    
  102285:	90                   	nop    
  102286:	90                   	nop    
  102287:	90                   	nop    
  102288:	90                   	nop    
  102289:	90                   	nop    
  10228a:	90                   	nop    
  10228b:	90                   	nop    
  10228c:	90                   	nop    
  10228d:	90                   	nop    
  10228e:	90                   	nop    
  10228f:	90                   	nop    

00102290 <kbdintr>:
  return c;
}

void
kbdintr(void)
{
  102290:	55                   	push   %ebp
  102291:	89 e5                	mov    %esp,%ebp
  102293:	83 ec 08             	sub    $0x8,%esp
  consoleintr(kbdgetc);
  102296:	c7 04 24 b0 22 10 00 	movl   $0x1022b0,(%esp)
  10229d:	e8 5e e4 ff ff       	call   100700 <consoleintr>
}
  1022a2:	c9                   	leave  
  1022a3:	c3                   	ret    
  1022a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1022aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001022b0 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
  1022b0:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1022b1:	ba 64 00 00 00       	mov    $0x64,%edx
  1022b6:	89 e5                	mov    %esp,%ebp
  1022b8:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
  1022b9:	a8 01                	test   $0x1,%al
  1022bb:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  1022c0:	74 3e                	je     102300 <kbdgetc+0x50>
  1022c2:	ba 60 00 00 00       	mov    $0x60,%edx
  1022c7:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
  1022c8:	3c e0                	cmp    $0xe0,%al
  1022ca:	0f 84 84 00 00 00    	je     102354 <kbdgetc+0xa4>
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);
  1022d0:	0f b6 c8             	movzbl %al,%ecx

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
  1022d3:	84 c9                	test   %cl,%cl
  1022d5:	79 2d                	jns    102304 <kbdgetc+0x54>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
  1022d7:	8b 15 3c 78 10 00    	mov    0x10783c,%edx
  1022dd:	f6 c2 40             	test   $0x40,%dl
  1022e0:	75 03                	jne    1022e5 <kbdgetc+0x35>
  1022e2:	83 e1 7f             	and    $0x7f,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
  1022e5:	0f b6 81 60 63 10 00 	movzbl 0x106360(%ecx),%eax
  1022ec:	83 c8 40             	or     $0x40,%eax
  1022ef:	0f b6 c0             	movzbl %al,%eax
  1022f2:	f7 d0                	not    %eax
  1022f4:	21 d0                	and    %edx,%eax
  1022f6:	31 d2                	xor    %edx,%edx
  1022f8:	a3 3c 78 10 00       	mov    %eax,0x10783c
  1022fd:	8d 76 00             	lea    0x0(%esi),%esi
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
  102300:	5d                   	pop    %ebp
  102301:	89 d0                	mov    %edx,%eax
  102303:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
  102304:	a1 3c 78 10 00       	mov    0x10783c,%eax
  102309:	a8 40                	test   $0x40,%al
  10230b:	74 0b                	je     102318 <kbdgetc+0x68>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
    shift &= ~E0ESC;
  10230d:	83 e0 bf             	and    $0xffffffbf,%eax
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
  102310:	80 c9 80             	or     $0x80,%cl
    shift &= ~E0ESC;
  102313:	a3 3c 78 10 00       	mov    %eax,0x10783c
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  102318:	0f b6 91 60 64 10 00 	movzbl 0x106460(%ecx),%edx
  10231f:	0f b6 81 60 63 10 00 	movzbl 0x106360(%ecx),%eax
  102326:	0b 05 3c 78 10 00    	or     0x10783c,%eax
  10232c:	31 d0                	xor    %edx,%eax
  c = charcode[shift & (CTL | SHIFT)][data];
  10232e:	89 c2                	mov    %eax,%edx
  102330:	83 e2 03             	and    $0x3,%edx
  if(shift & CAPSLOCK){
  102333:	a8 08                	test   $0x8,%al
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  102335:	8b 14 95 60 65 10 00 	mov    0x106560(,%edx,4),%edx
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  10233c:	a3 3c 78 10 00       	mov    %eax,0x10783c
  c = charcode[shift & (CTL | SHIFT)][data];
  102341:	0f b6 14 0a          	movzbl (%edx,%ecx,1),%edx
  if(shift & CAPSLOCK){
  102345:	74 b9                	je     102300 <kbdgetc+0x50>
    if('a' <= c && c <= 'z')
  102347:	8d 42 9f             	lea    -0x61(%edx),%eax
  10234a:	83 f8 19             	cmp    $0x19,%eax
  10234d:	77 12                	ja     102361 <kbdgetc+0xb1>
      c += 'A' - 'a';
  10234f:	83 ea 20             	sub    $0x20,%edx
  102352:	eb ac                	jmp    102300 <kbdgetc+0x50>
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
  102354:	83 0d 3c 78 10 00 40 	orl    $0x40,0x10783c
  10235b:	31 d2                	xor    %edx,%edx
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
  10235d:	5d                   	pop    %ebp
  10235e:	89 d0                	mov    %edx,%eax
  102360:	c3                   	ret    
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
  102361:	8d 42 bf             	lea    -0x41(%edx),%eax
  102364:	83 f8 19             	cmp    $0x19,%eax
  102367:	77 97                	ja     102300 <kbdgetc+0x50>
      c += 'a' - 'A';
  102369:	83 c2 20             	add    $0x20,%edx
  10236c:	eb 92                	jmp    102300 <kbdgetc+0x50>
  10236e:	90                   	nop    
  10236f:	90                   	nop    

00102370 <lapicw>:
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102370:	c1 e0 02             	shl    $0x2,%eax
  102373:	03 05 78 aa 10 00    	add    0x10aa78,%eax

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  102379:	55                   	push   %ebp
  10237a:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
  10237c:	89 10                	mov    %edx,(%eax)
  lapic[ID];  // wait for write to finish, by reading
  10237e:	a1 78 aa 10 00       	mov    0x10aa78,%eax
}
  102383:	5d                   	pop    %ebp

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  lapic[ID];  // wait for write to finish, by reading
  102384:	83 c0 20             	add    $0x20,%eax
  102387:	8b 00                	mov    (%eax),%eax
}
  102389:	c3                   	ret    
  10238a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102390 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
  102390:	a1 78 aa 10 00       	mov    0x10aa78,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
  102395:	55                   	push   %ebp
  102396:	89 e5                	mov    %esp,%ebp
  if(lapic)
  102398:	85 c0                	test   %eax,%eax
  10239a:	74 0a                	je     1023a6 <lapiceoi+0x16>
    lapicw(EOI, 0);
}
  10239c:	5d                   	pop    %ebp
// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
  10239d:	31 d2                	xor    %edx,%edx
  10239f:	b8 2c 00 00 00       	mov    $0x2c,%eax
  1023a4:	eb ca                	jmp    102370 <lapicw>
}
  1023a6:	5d                   	pop    %ebp
  1023a7:	c3                   	ret    
  1023a8:	90                   	nop    
  1023a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

001023b0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
  1023b0:	55                   	push   %ebp
  1023b1:	89 e5                	mov    %esp,%ebp
}
  1023b3:	5d                   	pop    %ebp
  1023b4:	c3                   	ret    
  1023b5:	8d 74 26 00          	lea    0x0(%esi),%esi
  1023b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001023c0 <cpunum>:
  lapicw(TPR, 0);
}

int
cpunum(void)
{
  1023c0:	55                   	push   %ebp
  1023c1:	89 e5                	mov    %esp,%ebp
  1023c3:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  1023c6:	9c                   	pushf  
  1023c7:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
  1023c8:	f6 c4 02             	test   $0x2,%ah
  1023cb:	74 12                	je     1023df <cpunum+0x1f>
    static int n;
    if(n++ == 0)
  1023cd:	a1 40 78 10 00       	mov    0x107840,%eax
  1023d2:	83 c0 01             	add    $0x1,%eax
  1023d5:	a3 40 78 10 00       	mov    %eax,0x107840
  1023da:	83 e8 01             	sub    $0x1,%eax
  1023dd:	74 14                	je     1023f3 <cpunum+0x33>
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if(lapic)
  1023df:	8b 15 78 aa 10 00    	mov    0x10aa78,%edx
  1023e5:	31 c0                	xor    %eax,%eax
  1023e7:	85 d2                	test   %edx,%edx
  1023e9:	74 06                	je     1023f1 <cpunum+0x31>
    return lapic[ID]>>24;
  1023eb:	8b 42 20             	mov    0x20(%edx),%eax
  1023ee:	c1 e8 18             	shr    $0x18,%eax
  return 0;
}
  1023f1:	c9                   	leave  
  1023f2:	c3                   	ret    
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
  1023f3:	8b 45 04             	mov    0x4(%ebp),%eax
  1023f6:	c7 04 24 70 65 10 00 	movl   $0x106570,(%esp)
  1023fd:	89 44 24 04          	mov    %eax,0x4(%esp)
  102401:	e8 ba e0 ff ff       	call   1004c0 <cprintf>
  102406:	eb d7                	jmp    1023df <cpunum+0x1f>
  102408:	90                   	nop    
  102409:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00102410 <lapicinit>:
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(int c)
{
  102410:	55                   	push   %ebp
  102411:	89 e5                	mov    %esp,%ebp
  102413:	83 ec 18             	sub    $0x18,%esp
  cprintf("lapicinit: %d 0x%x\n", c, lapic);
  102416:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  10241b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10241f:	8b 45 08             	mov    0x8(%ebp),%eax
  102422:	c7 04 24 9c 65 10 00 	movl   $0x10659c,(%esp)
  102429:	89 44 24 04          	mov    %eax,0x4(%esp)
  10242d:	e8 8e e0 ff ff       	call   1004c0 <cprintf>
  if(!lapic) 
  102432:	8b 15 78 aa 10 00    	mov    0x10aa78,%edx
  102438:	85 d2                	test   %edx,%edx
  10243a:	0f 84 ea 00 00 00    	je     10252a <lapicinit+0x11a>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
  102440:	ba 3f 01 00 00       	mov    $0x13f,%edx
  102445:	b8 3c 00 00 00       	mov    $0x3c,%eax
  10244a:	e8 21 ff ff ff       	call   102370 <lapicw>

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
  10244f:	ba 0b 00 00 00       	mov    $0xb,%edx
  102454:	b8 f8 00 00 00       	mov    $0xf8,%eax
  102459:	e8 12 ff ff ff       	call   102370 <lapicw>
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
  10245e:	ba 20 00 02 00       	mov    $0x20020,%edx
  102463:	b8 c8 00 00 00       	mov    $0xc8,%eax
  102468:	e8 03 ff ff ff       	call   102370 <lapicw>
  lapicw(TICR, 10000000); 
  10246d:	ba 80 96 98 00       	mov    $0x989680,%edx
  102472:	b8 e0 00 00 00       	mov    $0xe0,%eax
  102477:	e8 f4 fe ff ff       	call   102370 <lapicw>

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
  10247c:	ba 00 00 01 00       	mov    $0x10000,%edx
  102481:	b8 d4 00 00 00       	mov    $0xd4,%eax
  102486:	e8 e5 fe ff ff       	call   102370 <lapicw>
  lapicw(LINT1, MASKED);
  10248b:	b8 d8 00 00 00       	mov    $0xd8,%eax
  102490:	ba 00 00 01 00       	mov    $0x10000,%edx
  102495:	e8 d6 fe ff ff       	call   102370 <lapicw>

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
  10249a:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  10249f:	83 c0 30             	add    $0x30,%eax
  1024a2:	8b 00                	mov    (%eax),%eax
  1024a4:	c1 e8 10             	shr    $0x10,%eax
  1024a7:	3c 03                	cmp    $0x3,%al
  1024a9:	77 6e                	ja     102519 <lapicinit+0x109>
    lapicw(PCINT, MASKED);

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
  1024ab:	ba 33 00 00 00       	mov    $0x33,%edx
  1024b0:	b8 dc 00 00 00       	mov    $0xdc,%eax
  1024b5:	e8 b6 fe ff ff       	call   102370 <lapicw>

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
  1024ba:	31 d2                	xor    %edx,%edx
  1024bc:	b8 a0 00 00 00       	mov    $0xa0,%eax
  1024c1:	e8 aa fe ff ff       	call   102370 <lapicw>
  lapicw(ESR, 0);
  1024c6:	31 d2                	xor    %edx,%edx
  1024c8:	b8 a0 00 00 00       	mov    $0xa0,%eax
  1024cd:	e8 9e fe ff ff       	call   102370 <lapicw>

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
  1024d2:	31 d2                	xor    %edx,%edx
  1024d4:	b8 2c 00 00 00       	mov    $0x2c,%eax
  1024d9:	e8 92 fe ff ff       	call   102370 <lapicw>

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  1024de:	31 d2                	xor    %edx,%edx
  1024e0:	b8 c4 00 00 00       	mov    $0xc4,%eax
  1024e5:	e8 86 fe ff ff       	call   102370 <lapicw>
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  1024ea:	ba 00 85 08 00       	mov    $0x88500,%edx
  1024ef:	b8 c0 00 00 00       	mov    $0xc0,%eax
  1024f4:	e8 77 fe ff ff       	call   102370 <lapicw>
  while(lapic[ICRLO] & DELIVS)
  1024f9:	8b 15 78 aa 10 00    	mov    0x10aa78,%edx
  1024ff:	81 c2 00 03 00 00    	add    $0x300,%edx
  102505:	8b 02                	mov    (%edx),%eax
  102507:	f6 c4 10             	test   $0x10,%ah
  10250a:	75 f9                	jne    102505 <lapicinit+0xf5>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
  10250c:	c9                   	leave  
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
  10250d:	31 d2                	xor    %edx,%edx
  10250f:	b8 20 00 00 00       	mov    $0x20,%eax
  102514:	e9 57 fe ff ff       	jmp    102370 <lapicw>
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
    lapicw(PCINT, MASKED);
  102519:	ba 00 00 01 00       	mov    $0x10000,%edx
  10251e:	b8 d0 00 00 00       	mov    $0xd0,%eax
  102523:	e8 48 fe ff ff       	call   102370 <lapicw>
  102528:	eb 81                	jmp    1024ab <lapicinit+0x9b>
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
  10252a:	c9                   	leave  
  10252b:	c3                   	ret    
  10252c:	8d 74 26 00          	lea    0x0(%esi),%esi

00102530 <lapicstartap>:

// Start additional processor running bootstrap code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
  102530:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102531:	b8 0f 00 00 00       	mov    $0xf,%eax
  102536:	89 e5                	mov    %esp,%ebp
  102538:	ba 70 00 00 00       	mov    $0x70,%edx
  10253d:	56                   	push   %esi
  10253e:	53                   	push   %ebx
  10253f:	8b 75 0c             	mov    0xc(%ebp),%esi
  102542:	0f b6 5d 08          	movzbl 0x8(%ebp),%ebx
  102546:	ee                   	out    %al,(%dx)
  wrv[0] = 0;
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
  102547:	b8 0a 00 00 00       	mov    $0xa,%eax
  10254c:	b2 71                	mov    $0x71,%dl
  10254e:	ee                   	out    %al,(%dx)
  10254f:	c1 e3 18             	shl    $0x18,%ebx
  102552:	b8 c4 00 00 00       	mov    $0xc4,%eax
  102557:	89 da                	mov    %ebx,%edx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  outb(IO_RTC+1, 0x0A);
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
  102559:	c1 ee 04             	shr    $0x4,%esi
  10255c:	66 89 35 69 04 00 00 	mov    %si,0x469
  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
  microdelay(200);
  lapicw(ICRLO, INIT | LEVEL);
  102563:	c1 ee 08             	shr    $0x8,%esi
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  outb(IO_RTC+1, 0x0A);
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  wrv[0] = 0;
  102566:	66 c7 05 67 04 00 00 	movw   $0x0,0x467
  10256d:	00 00 
  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
  microdelay(200);
  lapicw(ICRLO, INIT | LEVEL);
  10256f:	81 ce 00 06 00 00    	or     $0x600,%esi
  wrv[0] = 0;
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
  102575:	e8 f6 fd ff ff       	call   102370 <lapicw>
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
  10257a:	ba 00 c5 00 00       	mov    $0xc500,%edx
  10257f:	b8 c0 00 00 00       	mov    $0xc0,%eax
  102584:	e8 e7 fd ff ff       	call   102370 <lapicw>
  microdelay(200);
  lapicw(ICRLO, INIT | LEVEL);
  102589:	ba 00 85 00 00       	mov    $0x8500,%edx
  10258e:	b8 c0 00 00 00       	mov    $0xc0,%eax
  102593:	e8 d8 fd ff ff       	call   102370 <lapicw>
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
  102598:	89 da                	mov    %ebx,%edx
  10259a:	b8 c4 00 00 00       	mov    $0xc4,%eax
  10259f:	e8 cc fd ff ff       	call   102370 <lapicw>
    lapicw(ICRLO, STARTUP | (addr>>12));
  1025a4:	89 f2                	mov    %esi,%edx
  1025a6:	b8 c0 00 00 00       	mov    $0xc0,%eax
  1025ab:	e8 c0 fd ff ff       	call   102370 <lapicw>
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
  1025b0:	89 da                	mov    %ebx,%edx
  1025b2:	b8 c4 00 00 00       	mov    $0xc4,%eax
  1025b7:	e8 b4 fd ff ff       	call   102370 <lapicw>
    lapicw(ICRLO, STARTUP | (addr>>12));
  1025bc:	89 f2                	mov    %esi,%edx
  1025be:	b8 c0 00 00 00       	mov    $0xc0,%eax
    microdelay(200);
  }
}
  1025c3:	5b                   	pop    %ebx
  1025c4:	5e                   	pop    %esi
  1025c5:	5d                   	pop    %ebp
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
  1025c6:	e9 a5 fd ff ff       	jmp    102370 <lapicw>
  1025cb:	90                   	nop    
  1025cc:	90                   	nop    
  1025cd:	90                   	nop    
  1025ce:	90                   	nop    
  1025cf:	90                   	nop    

001025d0 <mpmain>:
// Common CPU setup code.
// Bootstrap CPU comes here from mainc().
// Other CPUs jump here from bootother.S.
static void
mpmain(void)
{
  1025d0:	55                   	push   %ebp
  1025d1:	89 e5                	mov    %esp,%ebp
  1025d3:	53                   	push   %ebx
  1025d4:	83 ec 14             	sub    $0x14,%esp
  if(cpunum() != mpbcpu()) {
  1025d7:	e8 e4 fd ff ff       	call   1023c0 <cpunum>
  1025dc:	89 c3                	mov    %eax,%ebx
  1025de:	e8 fd 01 00 00       	call   1027e0 <mpbcpu>
  1025e3:	39 c3                	cmp    %eax,%ebx
  1025e5:	74 16                	je     1025fd <mpmain+0x2d>
    ksegment();
  1025e7:	e8 44 3a 00 00       	call   106030 <ksegment>
  1025ec:	8d 74 26 00          	lea    0x0(%esi),%esi
    lapicinit(cpunum());
  1025f0:	e8 cb fd ff ff       	call   1023c0 <cpunum>
  1025f5:	89 04 24             	mov    %eax,(%esp)
  1025f8:	e8 13 fe ff ff       	call   102410 <lapicinit>
  }
  vmenable();        // turn on paging
  1025fd:	e8 6e 33 00 00       	call   105970 <vmenable>
  cprintf("cpu%d: starting\n", cpu->id);
  102602:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  102608:	0f b6 00             	movzbl (%eax),%eax
  10260b:	c7 04 24 b0 65 10 00 	movl   $0x1065b0,(%esp)
  102612:	89 44 24 04          	mov    %eax,0x4(%esp)
  102616:	e8 a5 de ff ff       	call   1004c0 <cprintf>
  idtinit();       // load idt register
  10261b:	e8 80 24 00 00       	call   104aa0 <idtinit>
  xchg(&cpu->booted, 1);
  102620:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  102627:	b8 01 00 00 00       	mov    $0x1,%eax
  10262c:	f0 87 82 a8 00 00 00 	lock xchg %eax,0xa8(%edx)
  scheduler();     // start running processes
  102633:	e8 88 0b 00 00       	call   1031c0 <scheduler>
  102638:	90                   	nop    
  102639:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00102640 <mainc>:
  panic("jkstack");
}

void
mainc(void)
{
  102640:	55                   	push   %ebp
  102641:	89 e5                	mov    %esp,%ebp
  102643:	53                   	push   %ebx
  102644:	83 ec 14             	sub    $0x14,%esp
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
  102647:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  10264d:	0f b6 00             	movzbl (%eax),%eax
  102650:	c7 04 24 c1 65 10 00 	movl   $0x1065c1,(%esp)
  102657:	89 44 24 04          	mov    %eax,0x4(%esp)
  10265b:	e8 60 de ff ff       	call   1004c0 <cprintf>
  kvmalloc();      // initialize the kernel page table
  102660:	e8 ab 35 00 00       	call   105c10 <kvmalloc>
  pinit();         // process table
  102665:	e8 c6 11 00 00       	call   103830 <pinit>
  tvinit();        // trap vectors
  10266a:	e8 61 24 00 00       	call   104ad0 <tvinit>
  10266f:	90                   	nop    
  binit();         // buffer cache
  102670:	e8 0b db ff ff       	call   100180 <binit>
  fileinit();      // file table
  102675:	e8 16 e9 ff ff       	call   100f90 <fileinit>
  iinit();         // inode cache
  10267a:	e8 f1 f6 ff ff       	call   101d70 <iinit>
  10267f:	90                   	nop    
  ideinit();       // disk
  102680:	e8 4b f9 ff ff       	call   101fd0 <ideinit>
  if(!ismp)
  102685:	a1 84 aa 10 00       	mov    0x10aa84,%eax
  10268a:	85 c0                	test   %eax,%eax
  10268c:	0f 84 ab 00 00 00    	je     10273d <mainc+0xfd>
    timerinit();   // uniprocessor timer
  userinit();      // first user process
  102692:	e8 e9 0f 00 00       	call   103680 <userinit>
  char *stack;

  // Write bootstrap code to unused memory at 0x7000.  The linker has
  // placed the start of bootother.S there.
  code = (uchar *) 0x7000;
  memmove(code, _binary_bootother_start, (uint)_binary_bootother_size);
  102697:	c7 44 24 08 6a 00 00 	movl   $0x6a,0x8(%esp)
  10269e:	00 
  10269f:	c7 44 24 04 34 77 10 	movl   $0x107734,0x4(%esp)
  1026a6:	00 
  1026a7:	c7 04 24 00 70 00 00 	movl   $0x7000,(%esp)
  1026ae:	e8 2d 14 00 00       	call   103ae0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
  1026b3:	69 05 80 b0 10 00 bc 	imul   $0xbc,0x10b080,%eax
  1026ba:	00 00 00 
  1026bd:	05 a0 aa 10 00       	add    $0x10aaa0,%eax
  1026c2:	3d a0 aa 10 00       	cmp    $0x10aaa0,%eax
  1026c7:	76 6a                	jbe    102733 <mainc+0xf3>
  1026c9:	bb a0 aa 10 00       	mov    $0x10aaa0,%ebx
  1026ce:	66 90                	xchg   %ax,%ax
    if(c == cpus+cpunum())  // We've started already.
  1026d0:	e8 eb fc ff ff       	call   1023c0 <cpunum>
  1026d5:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
  1026db:	05 a0 aa 10 00       	add    $0x10aaa0,%eax
  1026e0:	39 d8                	cmp    %ebx,%eax
  1026e2:	74 36                	je     10271a <mainc+0xda>
      continue;

    // Fill in %esp, %eip and start code on cpu.
    stack = kalloc();
  1026e4:	e8 87 fa ff ff       	call   102170 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpmain;
  1026e9:	c7 05 f8 6f 00 00 d0 	movl   $0x1025d0,0x6ff8
  1026f0:	25 10 00 
    if(c == cpus+cpunum())  // We've started already.
      continue;

    // Fill in %esp, %eip and start code on cpu.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
  1026f3:	05 00 10 00 00       	add    $0x1000,%eax
  1026f8:	a3 fc 6f 00 00       	mov    %eax,0x6ffc
    *(void**)(code-8) = mpmain;
    lapicstartap(c->id, (uint)code);
  1026fd:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
  102704:	00 
  102705:	0f b6 03             	movzbl (%ebx),%eax
  102708:	89 04 24             	mov    %eax,(%esp)
  10270b:	e8 20 fe ff ff       	call   102530 <lapicstartap>

    // Wait for cpu to finish mpmain()
    while(c->booted == 0)
  102710:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
  102716:	85 c0                	test   %eax,%eax
  102718:	74 f6                	je     102710 <mainc+0xd0>
  // Write bootstrap code to unused memory at 0x7000.  The linker has
  // placed the start of bootother.S there.
  code = (uchar *) 0x7000;
  memmove(code, _binary_bootother_start, (uint)_binary_bootother_size);

  for(c = cpus; c < cpus+ncpu; c++){
  10271a:	69 05 80 b0 10 00 bc 	imul   $0xbc,0x10b080,%eax
  102721:	00 00 00 
  102724:	81 c3 bc 00 00 00    	add    $0xbc,%ebx
  10272a:	05 a0 aa 10 00       	add    $0x10aaa0,%eax
  10272f:	39 d8                	cmp    %ebx,%eax
  102731:	77 9d                	ja     1026d0 <mainc+0x90>
  userinit();      // first user process
  bootothers();    // start other processors

  // Finish setting up this processor in mpmain.
  mpmain();
}
  102733:	83 c4 14             	add    $0x14,%esp
  102736:	5b                   	pop    %ebx
  102737:	5d                   	pop    %ebp
    timerinit();   // uniprocessor timer
  userinit();      // first user process
  bootothers();    // start other processors

  // Finish setting up this processor in mpmain.
  mpmain();
  102738:	e9 93 fe ff ff       	jmp    1025d0 <mpmain>
  binit();         // buffer cache
  fileinit();      // file table
  iinit();         // inode cache
  ideinit();       // disk
  if(!ismp)
    timerinit();   // uniprocessor timer
  10273d:	e8 fe 22 00 00       	call   104a40 <timerinit>
  102742:	e9 4b ff ff ff       	jmp    102692 <mainc+0x52>
  102747:	89 f6                	mov    %esi,%esi
  102749:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00102750 <jkstack>:
  jkstack();       // call mainc() on a properly-allocated stack 
}

void
jkstack(void)
{
  102750:	55                   	push   %ebp
  102751:	89 e5                	mov    %esp,%ebp
  102753:	83 ec 08             	sub    $0x8,%esp
  char *kstack = kalloc();
  102756:	e8 15 fa ff ff       	call   102170 <kalloc>
  if(!kstack)
  10275b:	85 c0                	test   %eax,%eax
  10275d:	75 0c                	jne    10276b <jkstack+0x1b>
    panic("jkstack\n");
  10275f:	c7 04 24 d8 65 10 00 	movl   $0x1065d8,(%esp)
  102766:	e8 15 e1 ff ff       	call   100880 <panic>
  char *top = kstack + PGSIZE;
  asm volatile("movl %0,%%esp" : : "r" (top));
  10276b:	05 00 10 00 00       	add    $0x1000,%eax
  102770:	89 c4                	mov    %eax,%esp
  asm volatile("call mainc");
  102772:	e8 c9 fe ff ff       	call   102640 <mainc>
  panic("jkstack");
  102777:	c7 04 24 e1 65 10 00 	movl   $0x1065e1,(%esp)
  10277e:	e8 fd e0 ff ff       	call   100880 <panic>
  102783:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102789:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00102790 <main>:
void mainc(void);

// Bootstrap processor starts running C code here.
int
main(void)
{
  102790:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  102794:	83 e4 f0             	and    $0xfffffff0,%esp
  102797:	ff 71 fc             	pushl  -0x4(%ecx)
  10279a:	55                   	push   %ebp
  10279b:	89 e5                	mov    %esp,%ebp
  10279d:	51                   	push   %ecx
  10279e:	83 ec 04             	sub    $0x4,%esp
  mpinit();        // collect info about this machine
  1027a1:	e8 0a 01 00 00       	call   1028b0 <mpinit>
  lapicinit(mpbcpu());
  1027a6:	e8 35 00 00 00       	call   1027e0 <mpbcpu>
  1027ab:	89 04 24             	mov    %eax,(%esp)
  1027ae:	e8 5d fc ff ff       	call   102410 <lapicinit>
  ksegment();      // set up segments
  1027b3:	e8 78 38 00 00       	call   106030 <ksegment>
  picinit();       // interrupt controller
  1027b8:	e8 23 03 00 00       	call   102ae0 <picinit>
  1027bd:	8d 76 00             	lea    0x0(%esi),%esi
  ioapicinit();    // another interrupt controller
  1027c0:	e8 1b f9 ff ff       	call   1020e0 <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
  1027c5:	e8 26 da ff ff       	call   1001f0 <consoleinit>
  uartinit();      // serial port
  1027ca:	e8 61 26 00 00       	call   104e30 <uartinit>
  1027cf:	90                   	nop    
  kinit();         // initialize memory allocator
  1027d0:	e8 5b fa ff ff       	call   102230 <kinit>
  jkstack();       // call mainc() on a properly-allocated stack 
  1027d5:	e8 76 ff ff ff       	call   102750 <jkstack>
  1027da:	90                   	nop    
  1027db:	90                   	nop    
  1027dc:	90                   	nop    
  1027dd:	90                   	nop    
  1027de:	90                   	nop    
  1027df:	90                   	nop    

001027e0 <mpbcpu>:
uchar ioapicid;

int
mpbcpu(void)
{
  return bcpu-cpus;
  1027e0:	a1 44 78 10 00       	mov    0x107844,%eax
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
  1027e5:	55                   	push   %ebp
  1027e6:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
}
  1027e8:	5d                   	pop    %ebp
uchar ioapicid;

int
mpbcpu(void)
{
  return bcpu-cpus;
  1027e9:	2d a0 aa 10 00       	sub    $0x10aaa0,%eax
  1027ee:	c1 f8 02             	sar    $0x2,%eax
  1027f1:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
  1027f7:	c3                   	ret    
  1027f8:	90                   	nop    
  1027f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00102800 <sum>:

static uchar
sum(uchar *addr, int len)
{
  102800:	55                   	push   %ebp
  102801:	89 e5                	mov    %esp,%ebp
  102803:	56                   	push   %esi
  102804:	89 c6                	mov    %eax,%esi
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102806:	31 c0                	xor    %eax,%eax
  102808:	85 d2                	test   %edx,%edx
  return bcpu-cpus;
}

static uchar
sum(uchar *addr, int len)
{
  10280a:	53                   	push   %ebx
  10280b:	89 d3                	mov    %edx,%ebx
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  10280d:	7e 14                	jle    102823 <sum+0x23>
  10280f:	31 c9                	xor    %ecx,%ecx
  102811:	31 d2                	xor    %edx,%edx
    sum += addr[i];
  102813:	0f b6 04 31          	movzbl (%ecx,%esi,1),%eax
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102817:	83 c1 01             	add    $0x1,%ecx
    sum += addr[i];
  10281a:	01 c2                	add    %eax,%edx
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  10281c:	39 d9                	cmp    %ebx,%ecx
  10281e:	75 f3                	jne    102813 <sum+0x13>
  102820:	0f b6 c2             	movzbl %dl,%eax
    sum += addr[i];
  return sum;
}
  102823:	5b                   	pop    %ebx
  102824:	5e                   	pop    %esi
  102825:	5d                   	pop    %ebp
  102826:	c3                   	ret    
  102827:	89 f6                	mov    %esi,%esi
  102829:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00102830 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uchar *addr, int len)
{
  102830:	55                   	push   %ebp
  102831:	89 e5                	mov    %esp,%ebp
  102833:	57                   	push   %edi
  102834:	56                   	push   %esi
  102835:	89 c6                	mov    %eax,%esi
  102837:	53                   	push   %ebx
  102838:	89 d3                	mov    %edx,%ebx
  10283a:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p;

  cprintf("mpsearch1 0x%x %d\n", addr, len);
  e = addr+len;
  10283d:	8d 3c 1e             	lea    (%esi,%ebx,1),%edi
static struct mp*
mpsearch1(uchar *addr, int len)
{
  uchar *e, *p;

  cprintf("mpsearch1 0x%x %d\n", addr, len);
  102840:	89 54 24 08          	mov    %edx,0x8(%esp)
  102844:	89 44 24 04          	mov    %eax,0x4(%esp)
  102848:	c7 04 24 e9 65 10 00 	movl   $0x1065e9,(%esp)
  10284f:	e8 6c dc ff ff       	call   1004c0 <cprintf>
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
  102854:	39 fe                	cmp    %edi,%esi
  102856:	73 45                	jae    10289d <mpsearch1+0x6d>
  102858:	89 f3                	mov    %esi,%ebx
  10285a:	eb 0b                	jmp    102867 <mpsearch1+0x37>
  10285c:	8d 74 26 00          	lea    0x0(%esi),%esi
  102860:	83 c3 10             	add    $0x10,%ebx
  102863:	39 df                	cmp    %ebx,%edi
  102865:	76 36                	jbe    10289d <mpsearch1+0x6d>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  102867:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  10286e:	00 
  10286f:	c7 44 24 04 fc 65 10 	movl   $0x1065fc,0x4(%esp)
  102876:	00 
  102877:	89 1c 24             	mov    %ebx,(%esp)
  10287a:	e8 e1 11 00 00       	call   103a60 <memcmp>
  10287f:	85 c0                	test   %eax,%eax
  102881:	75 dd                	jne    102860 <mpsearch1+0x30>
  102883:	ba 10 00 00 00       	mov    $0x10,%edx
  102888:	89 d8                	mov    %ebx,%eax
  10288a:	e8 71 ff ff ff       	call   102800 <sum>
  10288f:	84 c0                	test   %al,%al
  102891:	75 cd                	jne    102860 <mpsearch1+0x30>
      return (struct mp*)p;
  return 0;
}
  102893:	83 c4 0c             	add    $0xc,%esp

  cprintf("mpsearch1 0x%x %d\n", addr, len);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  102896:	89 d8                	mov    %ebx,%eax
  return 0;
}
  102898:	5b                   	pop    %ebx
  102899:	5e                   	pop    %esi
  10289a:	5f                   	pop    %edi
  10289b:	5d                   	pop    %ebp
  10289c:	c3                   	ret    
  10289d:	83 c4 0c             	add    $0xc,%esp
{
  uchar *e, *p;

  cprintf("mpsearch1 0x%x %d\n", addr, len);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
  1028a0:	31 c0                	xor    %eax,%eax
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
  1028a2:	5b                   	pop    %ebx
  1028a3:	5e                   	pop    %esi
  1028a4:	5f                   	pop    %edi
  1028a5:	5d                   	pop    %ebp
  1028a6:	c3                   	ret    
  1028a7:	89 f6                	mov    %esi,%esi
  1028a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001028b0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
  1028b0:	55                   	push   %ebp
  1028b1:	89 e5                	mov    %esp,%ebp
  1028b3:	83 ec 28             	sub    $0x28,%esp
  1028b6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  1028b9:	89 75 f8             	mov    %esi,-0x8(%ebp)
  1028bc:	89 7d fc             	mov    %edi,-0x4(%ebp)
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar*)0x400;
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
  1028bf:	0f b6 0d 0f 04 00 00 	movzbl 0x40f,%ecx
  1028c6:	0f b6 05 0e 04 00 00 	movzbl 0x40e,%eax
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
  1028cd:	c7 05 44 78 10 00 a0 	movl   $0x10aaa0,0x107844
  1028d4:	aa 10 00 
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar*)0x400;
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
  1028d7:	c1 e1 08             	shl    $0x8,%ecx
  1028da:	09 c1                	or     %eax,%ecx
  1028dc:	c1 e1 04             	shl    $0x4,%ecx
  1028df:	85 c9                	test   %ecx,%ecx
  1028e1:	74 4e                	je     102931 <mpinit+0x81>
    if((mp = mpsearch1((uchar*)p, 1024)))
  1028e3:	ba 00 04 00 00       	mov    $0x400,%edx
  1028e8:	89 c8                	mov    %ecx,%eax
  1028ea:	e8 41 ff ff ff       	call   102830 <mpsearch1>
  1028ef:	85 c0                	test   %eax,%eax
  1028f1:	89 c6                	mov    %eax,%esi
  1028f3:	74 67                	je     10295c <mpinit+0xac>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  1028f5:	8b 5e 04             	mov    0x4(%esi),%ebx
  1028f8:	85 db                	test   %ebx,%ebx
  1028fa:	74 28                	je     102924 <mpinit+0x74>
    return 0;
  conf = (struct mpconf*)mp->physaddr;
  if(memcmp(conf, "PCMP", 4) != 0)
  1028fc:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  102903:	00 
  102904:	c7 44 24 04 01 66 10 	movl   $0x106601,0x4(%esp)
  10290b:	00 
  10290c:	89 1c 24             	mov    %ebx,(%esp)
  10290f:	e8 4c 11 00 00       	call   103a60 <memcmp>
  102914:	85 c0                	test   %eax,%eax
  102916:	75 0c                	jne    102924 <mpinit+0x74>
    return 0;
  if(conf->version != 1 && conf->version != 4)
  102918:	0f b6 43 06          	movzbl 0x6(%ebx),%eax
  10291c:	3c 01                	cmp    $0x1,%al
  10291e:	74 53                	je     102973 <mpinit+0xc3>
  102920:	3c 04                	cmp    $0x4,%al
  102922:	74 4f                	je     102973 <mpinit+0xc3>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
  102924:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  102927:	8b 75 f8             	mov    -0x8(%ebp),%esi
  10292a:	8b 7d fc             	mov    -0x4(%ebp),%edi
  10292d:	89 ec                	mov    %ebp,%esp
  10292f:	5d                   	pop    %ebp
  102930:	c3                   	ret    
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
    if((mp = mpsearch1((uchar*)p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1((uchar*)p-1024, 1024)))
  102931:	0f b6 05 14 04 00 00 	movzbl 0x414,%eax
  102938:	0f b6 15 13 04 00 00 	movzbl 0x413,%edx
  10293f:	c1 e0 08             	shl    $0x8,%eax
  102942:	09 d0                	or     %edx,%eax
  102944:	ba 00 04 00 00       	mov    $0x400,%edx
  102949:	c1 e0 0a             	shl    $0xa,%eax
  10294c:	2d 00 04 00 00       	sub    $0x400,%eax
  102951:	e8 da fe ff ff       	call   102830 <mpsearch1>
  102956:	85 c0                	test   %eax,%eax
  102958:	89 c6                	mov    %eax,%esi
  10295a:	75 99                	jne    1028f5 <mpinit+0x45>
      return mp;
  }
  return mpsearch1((uchar*)0xF0000, 0x10000);
  10295c:	ba 00 00 01 00       	mov    $0x10000,%edx
  102961:	b8 00 00 0f 00       	mov    $0xf0000,%eax
  102966:	e8 c5 fe ff ff       	call   102830 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  10296b:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1((uchar*)p-1024, 1024)))
      return mp;
  }
  return mpsearch1((uchar*)0xF0000, 0x10000);
  10296d:	89 c6                	mov    %eax,%esi
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  10296f:	75 84                	jne    1028f5 <mpinit+0x45>
  102971:	eb b1                	jmp    102924 <mpinit+0x74>
  conf = (struct mpconf*)mp->physaddr;
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
  102973:	0f b7 53 04          	movzwl 0x4(%ebx),%edx
  102977:	89 d8                	mov    %ebx,%eax
  102979:	e8 82 fe ff ff       	call   102800 <sum>
  10297e:	84 c0                	test   %al,%al
  102980:	75 a2                	jne    102924 <mpinit+0x74>
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  102982:	c7 05 84 aa 10 00 01 	movl   $0x1,0x10aa84
  102989:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
  10298c:	8b 43 24             	mov    0x24(%ebx),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  10298f:	8d 53 2c             	lea    0x2c(%ebx),%edx

  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  102992:	a3 78 aa 10 00       	mov    %eax,0x10aa78
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  102997:	0f b7 43 04          	movzwl 0x4(%ebx),%eax
  10299b:	01 c3                	add    %eax,%ebx
  10299d:	39 da                	cmp    %ebx,%edx
  10299f:	89 5d ec             	mov    %ebx,-0x14(%ebp)
  1029a2:	73 60                	jae    102a04 <mpinit+0x154>
  1029a4:	a1 44 78 10 00       	mov    0x107844,%eax
  1029a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1029ac:	8d 74 26 00          	lea    0x0(%esi),%esi
    switch(*p){
  1029b0:	0f b6 02             	movzbl (%edx),%eax
  1029b3:	3c 04                	cmp    $0x4,%al
  1029b5:	76 29                	jbe    1029e0 <mpinit+0x130>
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
  1029b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1029ba:	a3 44 78 10 00       	mov    %eax,0x107844
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
  1029bf:	0f b6 02             	movzbl (%edx),%eax
  1029c2:	c7 04 24 28 66 10 00 	movl   $0x106628,(%esp)
  1029c9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1029cd:	e8 ee da ff ff       	call   1004c0 <cprintf>
      panic("mpinit");
  1029d2:	c7 04 24 21 66 10 00 	movl   $0x106621,(%esp)
  1029d9:	e8 a2 de ff ff       	call   100880 <panic>
  1029de:	66 90                	xchg   %ax,%ax
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
  1029e0:	0f b6 c0             	movzbl %al,%eax
  1029e3:	ff 24 85 48 66 10 00 	jmp    *0x106648(,%eax,4)
      ncpu++;
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
  1029ea:	0f b6 42 01          	movzbl 0x1(%edx),%eax
      p += sizeof(struct mpioapic);
  1029ee:	83 c2 08             	add    $0x8,%edx
      ncpu++;
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
  1029f1:	a2 80 aa 10 00       	mov    %al,0x10aa80
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  1029f6:	3b 55 ec             	cmp    -0x14(%ebp),%edx
  1029f9:	72 b5                	jb     1029b0 <mpinit+0x100>
  1029fb:	8b 5d f0             	mov    -0x10(%ebp),%ebx
  1029fe:	89 1d 44 78 10 00    	mov    %ebx,0x107844
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      panic("mpinit");
    }
  }
  if(mp->imcrp){
  102a04:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
  102a08:	0f 84 16 ff ff ff    	je     102924 <mpinit+0x74>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102a0e:	b8 70 00 00 00       	mov    $0x70,%eax
  102a13:	ba 22 00 00 00       	mov    $0x22,%edx
  102a18:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102a19:	b2 23                	mov    $0x23,%dl
  102a1b:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102a1c:	83 c8 01             	or     $0x1,%eax
  102a1f:	ee                   	out    %al,(%dx)
  102a20:	e9 ff fe ff ff       	jmp    102924 <mpinit+0x74>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
  102a25:	83 c2 08             	add    $0x8,%edx
  102a28:	eb cc                	jmp    1029f6 <mpinit+0x146>
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu != proc->apicid) {
  102a2a:	0f b6 7a 01          	movzbl 0x1(%edx),%edi
  102a2e:	89 fb                	mov    %edi,%ebx
  102a30:	0f b6 cb             	movzbl %bl,%ecx
  102a33:	8b 1d 80 b0 10 00    	mov    0x10b080,%ebx
  102a39:	39 d9                	cmp    %ebx,%ecx
  102a3b:	75 2f                	jne    102a6c <mpinit+0x1bc>
        cprintf("mpinit: ncpu=%d apicpid=%d", ncpu, proc->apicid);
        panic("mpinit");
      }
      if(proc->flags & MPBOOT)
  102a3d:	f6 42 03 02          	testb  $0x2,0x3(%edx)
  102a41:	74 0e                	je     102a51 <mpinit+0x1a1>
        bcpu = &cpus[ncpu];
  102a43:	69 c1 bc 00 00 00    	imul   $0xbc,%ecx,%eax
  102a49:	05 a0 aa 10 00       	add    $0x10aaa0,%eax
  102a4e:	89 45 f0             	mov    %eax,-0x10(%ebp)
      cpus[ncpu].id = ncpu;
  102a51:	69 c1 bc 00 00 00    	imul   $0xbc,%ecx,%eax
  102a57:	89 fb                	mov    %edi,%ebx
      ncpu++;
      p += sizeof(struct mpproc);
  102a59:	83 c2 14             	add    $0x14,%edx
        cprintf("mpinit: ncpu=%d apicpid=%d", ncpu, proc->apicid);
        panic("mpinit");
      }
      if(proc->flags & MPBOOT)
        bcpu = &cpus[ncpu];
      cpus[ncpu].id = ncpu;
  102a5c:	88 98 a0 aa 10 00    	mov    %bl,0x10aaa0(%eax)
      ncpu++;
  102a62:	8d 41 01             	lea    0x1(%ecx),%eax
  102a65:	a3 80 b0 10 00       	mov    %eax,0x10b080
  102a6a:	eb 8a                	jmp    1029f6 <mpinit+0x146>
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu != proc->apicid) {
  102a6c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102a6f:	a3 44 78 10 00       	mov    %eax,0x107844
        cprintf("mpinit: ncpu=%d apicpid=%d", ncpu, proc->apicid);
  102a74:	0f b6 42 01          	movzbl 0x1(%edx),%eax
  102a78:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  102a7c:	c7 04 24 06 66 10 00 	movl   $0x106606,(%esp)
  102a83:	89 44 24 08          	mov    %eax,0x8(%esp)
  102a87:	e8 34 da ff ff       	call   1004c0 <cprintf>
        panic("mpinit");
  102a8c:	c7 04 24 21 66 10 00 	movl   $0x106621,(%esp)
  102a93:	e8 e8 dd ff ff       	call   100880 <panic>
  102a98:	90                   	nop    
  102a99:	90                   	nop    
  102a9a:	90                   	nop    
  102a9b:	90                   	nop    
  102a9c:	90                   	nop    
  102a9d:	90                   	nop    
  102a9e:	90                   	nop    
  102a9f:	90                   	nop    

00102aa0 <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
  102aa0:	55                   	push   %ebp
  102aa1:	89 c1                	mov    %eax,%ecx
  102aa3:	89 e5                	mov    %esp,%ebp
  102aa5:	ba 21 00 00 00       	mov    $0x21,%edx
  irqmask = mask;
  102aaa:	66 a3 00 73 10 00    	mov    %ax,0x107300
  102ab0:	ee                   	out    %al,(%dx)
  outb(IO_PIC1+1, mask);
  outb(IO_PIC2+1, mask >> 8);
}
  102ab1:	66 c1 e9 08          	shr    $0x8,%cx
  102ab5:	b2 a1                	mov    $0xa1,%dl
  102ab7:	89 c8                	mov    %ecx,%eax
  102ab9:	ee                   	out    %al,(%dx)
  102aba:	5d                   	pop    %ebp
  102abb:	c3                   	ret    
  102abc:	8d 74 26 00          	lea    0x0(%esi),%esi

00102ac0 <picenable>:

void
picenable(int irq)
{
  102ac0:	55                   	push   %ebp
  picsetmask(irqmask & ~(1<<irq));
  102ac1:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
  102ac6:	89 e5                	mov    %esp,%ebp
  102ac8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  picsetmask(irqmask & ~(1<<irq));
}
  102acb:	5d                   	pop    %ebp
}

void
picenable(int irq)
{
  picsetmask(irqmask & ~(1<<irq));
  102acc:	d3 c0                	rol    %cl,%eax
  102ace:	66 23 05 00 73 10 00 	and    0x107300,%ax
  102ad5:	0f b7 c0             	movzwl %ax,%eax
  102ad8:	eb c6                	jmp    102aa0 <picsetmask>
  102ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102ae0 <picinit>:
}

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
  102ae0:	55                   	push   %ebp
  102ae1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  102ae6:	89 e5                	mov    %esp,%ebp
  102ae8:	83 ec 0c             	sub    $0xc,%esp
  102aeb:	89 74 24 04          	mov    %esi,0x4(%esp)
  102aef:	be 21 00 00 00       	mov    $0x21,%esi
  102af4:	89 1c 24             	mov    %ebx,(%esp)
  102af7:	89 f2                	mov    %esi,%edx
  102af9:	89 7c 24 08          	mov    %edi,0x8(%esp)
  102afd:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
  102afe:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  102b03:	89 ca                	mov    %ecx,%edx
  102b05:	ee                   	out    %al,(%dx)
  102b06:	bf 11 00 00 00       	mov    $0x11,%edi
  102b0b:	b2 20                	mov    $0x20,%dl
  102b0d:	89 f8                	mov    %edi,%eax
  102b0f:	ee                   	out    %al,(%dx)
  102b10:	b8 20 00 00 00       	mov    $0x20,%eax
  102b15:	89 f2                	mov    %esi,%edx
  102b17:	ee                   	out    %al,(%dx)
  102b18:	b8 04 00 00 00       	mov    $0x4,%eax
  102b1d:	ee                   	out    %al,(%dx)
  102b1e:	bb 03 00 00 00       	mov    $0x3,%ebx
  102b23:	89 d8                	mov    %ebx,%eax
  102b25:	ee                   	out    %al,(%dx)
  102b26:	be a0 00 00 00       	mov    $0xa0,%esi
  102b2b:	89 f8                	mov    %edi,%eax
  102b2d:	89 f2                	mov    %esi,%edx
  102b2f:	ee                   	out    %al,(%dx)
  102b30:	b8 28 00 00 00       	mov    $0x28,%eax
  102b35:	89 ca                	mov    %ecx,%edx
  102b37:	ee                   	out    %al,(%dx)
  102b38:	b8 02 00 00 00       	mov    $0x2,%eax
  102b3d:	ee                   	out    %al,(%dx)
  102b3e:	89 d8                	mov    %ebx,%eax
  102b40:	ee                   	out    %al,(%dx)
  102b41:	b9 68 00 00 00       	mov    $0x68,%ecx
  102b46:	b2 20                	mov    $0x20,%dl
  102b48:	89 c8                	mov    %ecx,%eax
  102b4a:	ee                   	out    %al,(%dx)
  102b4b:	bb 0a 00 00 00       	mov    $0xa,%ebx
  102b50:	89 d8                	mov    %ebx,%eax
  102b52:	ee                   	out    %al,(%dx)
  102b53:	89 c8                	mov    %ecx,%eax
  102b55:	89 f2                	mov    %esi,%edx
  102b57:	ee                   	out    %al,(%dx)
  102b58:	89 d8                	mov    %ebx,%eax
  102b5a:	ee                   	out    %al,(%dx)
  102b5b:	0f b7 05 00 73 10 00 	movzwl 0x107300,%eax
  102b62:	66 83 f8 ff          	cmp    $0xffffffff,%ax
  102b66:	74 18                	je     102b80 <picinit+0xa0>
    picsetmask(irqmask);
}
  102b68:	8b 1c 24             	mov    (%esp),%ebx

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
    picsetmask(irqmask);
  102b6b:	0f b7 c0             	movzwl %ax,%eax
}
  102b6e:	8b 74 24 04          	mov    0x4(%esp),%esi
  102b72:	8b 7c 24 08          	mov    0x8(%esp),%edi
  102b76:	89 ec                	mov    %ebp,%esp
  102b78:	5d                   	pop    %ebp

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
    picsetmask(irqmask);
  102b79:	e9 22 ff ff ff       	jmp    102aa0 <picsetmask>
  102b7e:	66 90                	xchg   %ax,%ax
}
  102b80:	8b 1c 24             	mov    (%esp),%ebx
  102b83:	8b 74 24 04          	mov    0x4(%esp),%esi
  102b87:	8b 7c 24 08          	mov    0x8(%esp),%edi
  102b8b:	89 ec                	mov    %ebp,%esp
  102b8d:	5d                   	pop    %ebp
  102b8e:	c3                   	ret    
  102b8f:	90                   	nop    

00102b90 <piperead>:
  return n;
}

int
piperead(struct pipe *p, char *addr, int n)
{
  102b90:	55                   	push   %ebp
  102b91:	89 e5                	mov    %esp,%ebp
  102b93:	57                   	push   %edi
  102b94:	56                   	push   %esi
  102b95:	53                   	push   %ebx
  102b96:	83 ec 0c             	sub    $0xc,%esp
  102b99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  102b9c:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
  102b9f:	89 1c 24             	mov    %ebx,(%esp)
  102ba2:	e8 29 0e 00 00       	call   1039d0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
  102ba7:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
  102bad:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
  102bb3:	75 53                	jne    102c08 <piperead+0x78>
  102bb5:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
  102bbb:	85 d2                	test   %edx,%edx
  102bbd:	74 49                	je     102c08 <piperead+0x78>
    if(proc->killed){
  102bbf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  102bc5:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
  102bcb:	8b 40 24             	mov    0x24(%eax),%eax
  102bce:	85 c0                	test   %eax,%eax
  102bd0:	74 1c                	je     102bee <piperead+0x5e>
  102bd2:	e9 93 00 00 00       	jmp    102c6a <piperead+0xda>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
  102bd7:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
  102bdd:	85 d2                	test   %edx,%edx
  102bdf:	74 27                	je     102c08 <piperead+0x78>
    if(proc->killed){
  102be1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  102be7:	8b 48 24             	mov    0x24(%eax),%ecx
  102bea:	85 c9                	test   %ecx,%ecx
  102bec:	75 7c                	jne    102c6a <piperead+0xda>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  102bee:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  102bf2:	89 34 24             	mov    %esi,(%esp)
  102bf5:	e8 b6 04 00 00       	call   1030b0 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
  102bfa:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
  102c00:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
  102c06:	74 cf                	je     102bd7 <piperead+0x47>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
  102c08:	85 ff                	test   %edi,%edi
  102c0a:	7e 75                	jle    102c81 <piperead+0xf1>
    if(p->nread == p->nwrite)
      break;
  102c0c:	31 f6                	xor    %esi,%esi
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    if(p->nread == p->nwrite)
  102c0e:	89 c2                	mov    %eax,%edx
  102c10:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
  102c16:	75 10                	jne    102c28 <piperead+0x98>
  102c18:	eb 67                	jmp    102c81 <piperead+0xf1>
  102c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102c20:	39 93 38 02 00 00    	cmp    %edx,0x238(%ebx)
  102c26:	74 22                	je     102c4a <piperead+0xba>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  102c28:	89 d0                	mov    %edx,%eax
  102c2a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  102c2d:	83 c2 01             	add    $0x1,%edx
  102c30:	25 ff 01 00 00       	and    $0x1ff,%eax
  102c35:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
  102c3a:	88 04 0e             	mov    %al,(%esi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
  102c3d:	83 c6 01             	add    $0x1,%esi
  102c40:	39 fe                	cmp    %edi,%esi
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  102c42:	89 93 34 02 00 00    	mov    %edx,0x234(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
  102c48:	75 d6                	jne    102c20 <piperead+0x90>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  102c4a:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
  102c50:	89 04 24             	mov    %eax,(%esp)
  102c53:	e8 68 03 00 00       	call   102fc0 <wakeup>
  release(&p->lock);
  102c58:	89 1c 24             	mov    %ebx,(%esp)
  102c5b:	e8 30 0d 00 00       	call   103990 <release>
  return i;
}
  102c60:	83 c4 0c             	add    $0xc,%esp
  102c63:	89 f0                	mov    %esi,%eax
  102c65:	5b                   	pop    %ebx
  102c66:	5e                   	pop    %esi
  102c67:	5f                   	pop    %edi
  102c68:	5d                   	pop    %ebp
  102c69:	c3                   	ret    
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(proc->killed){
      release(&p->lock);
  102c6a:	89 1c 24             	mov    %ebx,(%esp)
  102c6d:	be ff ff ff ff       	mov    $0xffffffff,%esi
  102c72:	e8 19 0d 00 00       	call   103990 <release>
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
  102c77:	83 c4 0c             	add    $0xc,%esp
  102c7a:	89 f0                	mov    %esi,%eax
  102c7c:	5b                   	pop    %ebx
  102c7d:	5e                   	pop    %esi
  102c7e:	5f                   	pop    %edi
  102c7f:	5d                   	pop    %ebp
  102c80:	c3                   	ret    
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
  102c81:	31 f6                	xor    %esi,%esi
  102c83:	eb c5                	jmp    102c4a <piperead+0xba>
  102c85:	8d 74 26 00          	lea    0x0(%esi),%esi
  102c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00102c90 <pipewrite>:
    release(&p->lock);
}

int
pipewrite(struct pipe *p, char *addr, int n)
{
  102c90:	55                   	push   %ebp
  102c91:	89 e5                	mov    %esp,%ebp
  102c93:	57                   	push   %edi
  102c94:	56                   	push   %esi
  102c95:	53                   	push   %ebx
  102c96:	83 ec 1c             	sub    $0x1c,%esp
  102c99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
  102c9c:	89 1c 24             	mov    %ebx,(%esp)
  102c9f:	e8 2c 0d 00 00       	call   1039d0 <acquire>
  for(i = 0; i < n; i++){
  102ca4:	8b 45 10             	mov    0x10(%ebp),%eax
  102ca7:	85 c0                	test   %eax,%eax
  102ca9:	0f 8e 89 00 00 00    	jle    102d38 <pipewrite+0xa8>
  102caf:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
  102cb5:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
  102cbb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  102cc2:	eb 2f                	jmp    102cf3 <pipewrite+0x63>
    while(p->nwrite == p->nread + PIPESIZE) {  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
  102cc4:	8b 8b 3c 02 00 00    	mov    0x23c(%ebx),%ecx
  102cca:	85 c9                	test   %ecx,%ecx
  102ccc:	0f 84 7e 00 00 00    	je     102d50 <pipewrite+0xc0>
  102cd2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  102cd8:	8b 40 24             	mov    0x24(%eax),%eax
  102cdb:	85 c0                	test   %eax,%eax
  102cdd:	75 71                	jne    102d50 <pipewrite+0xc0>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
  102cdf:	89 3c 24             	mov    %edi,(%esp)
  102ce2:	e8 d9 02 00 00       	call   102fc0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
  102ce7:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  102ceb:	89 34 24             	mov    %esi,(%esp)
  102cee:	e8 bd 03 00 00       	call   1030b0 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE) {  //DOC: pipewrite-full
  102cf3:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
  102cf9:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
  102cff:	05 00 02 00 00       	add    $0x200,%eax
  102d04:	39 c1                	cmp    %eax,%ecx
  102d06:	74 bc                	je     102cc4 <pipewrite+0x34>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  102d08:	89 c8                	mov    %ecx,%eax
  102d0a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102d0d:	25 ff 01 00 00       	and    $0x1ff,%eax
  102d12:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102d15:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d18:	0f b6 14 02          	movzbl (%edx,%eax,1),%edx
  102d1c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102d1f:	88 54 03 34          	mov    %dl,0x34(%ebx,%eax,1)
  102d23:	8d 41 01             	lea    0x1(%ecx),%eax
  102d26:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
  102d2c:	8b 55 10             	mov    0x10(%ebp),%edx
  102d2f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  102d33:	39 55 f0             	cmp    %edx,-0x10(%ebp)
  102d36:	75 bb                	jne    102cf3 <pipewrite+0x63>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  102d38:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
  102d3e:	89 04 24             	mov    %eax,(%esp)
  102d41:	e8 7a 02 00 00       	call   102fc0 <wakeup>
  release(&p->lock);
  102d46:	89 1c 24             	mov    %ebx,(%esp)
  102d49:	e8 42 0c 00 00       	call   103990 <release>
  102d4e:	eb 0f                	jmp    102d5f <pipewrite+0xcf>

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE) {  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
        release(&p->lock);
  102d50:	89 1c 24             	mov    %ebx,(%esp)
  102d53:	e8 38 0c 00 00       	call   103990 <release>
  102d58:	c7 45 10 ff ff ff ff 	movl   $0xffffffff,0x10(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
  102d5f:	8b 45 10             	mov    0x10(%ebp),%eax
  102d62:	83 c4 1c             	add    $0x1c,%esp
  102d65:	5b                   	pop    %ebx
  102d66:	5e                   	pop    %esi
  102d67:	5f                   	pop    %edi
  102d68:	5d                   	pop    %ebp
  102d69:	c3                   	ret    
  102d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102d70 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
  102d70:	55                   	push   %ebp
  102d71:	89 e5                	mov    %esp,%ebp
  102d73:	83 ec 18             	sub    $0x18,%esp
  102d76:	89 75 fc             	mov    %esi,-0x4(%ebp)
  102d79:	8b 75 08             	mov    0x8(%ebp),%esi
  102d7c:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  102d7f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  acquire(&p->lock);
  102d82:	89 34 24             	mov    %esi,(%esp)
  102d85:	e8 46 0c 00 00       	call   1039d0 <acquire>
  if(writable){
  102d8a:	85 db                	test   %ebx,%ebx
  102d8c:	74 42                	je     102dd0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
  102d8e:	8d 86 34 02 00 00    	lea    0x234(%esi),%eax
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
  102d94:	c7 86 40 02 00 00 00 	movl   $0x0,0x240(%esi)
  102d9b:	00 00 00 
    wakeup(&p->nread);
  102d9e:	89 04 24             	mov    %eax,(%esp)
  102da1:	e8 1a 02 00 00       	call   102fc0 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0) {
  102da6:	8b 86 3c 02 00 00    	mov    0x23c(%esi),%eax
  102dac:	85 c0                	test   %eax,%eax
  102dae:	75 0a                	jne    102dba <pipeclose+0x4a>
  102db0:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
  102db6:	85 c0                	test   %eax,%eax
  102db8:	74 36                	je     102df0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
  102dba:	89 75 08             	mov    %esi,0x8(%ebp)
}
  102dbd:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  102dc0:	8b 75 fc             	mov    -0x4(%ebp),%esi
  102dc3:	89 ec                	mov    %ebp,%esp
  102dc5:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0) {
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
  102dc6:	e9 c5 0b 00 00       	jmp    103990 <release>
  102dcb:	90                   	nop    
  102dcc:	8d 74 26 00          	lea    0x0(%esi),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  102dd0:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
  102dd6:	c7 86 3c 02 00 00 00 	movl   $0x0,0x23c(%esi)
  102ddd:	00 00 00 
    wakeup(&p->nwrite);
  102de0:	89 04 24             	mov    %eax,(%esp)
  102de3:	e8 d8 01 00 00       	call   102fc0 <wakeup>
  102de8:	eb bc                	jmp    102da6 <pipeclose+0x36>
  102dea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  if(p->readopen == 0 && p->writeopen == 0) {
    release(&p->lock);
  102df0:	89 34 24             	mov    %esi,(%esp)
  102df3:	e8 98 0b 00 00       	call   103990 <release>
    kfree((char*)p);
  } else
    release(&p->lock);
}
  102df8:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0) {
    release(&p->lock);
    kfree((char*)p);
  102dfb:	89 75 08             	mov    %esi,0x8(%ebp)
  } else
    release(&p->lock);
}
  102dfe:	8b 75 fc             	mov    -0x4(%ebp),%esi
  102e01:	89 ec                	mov    %ebp,%esp
  102e03:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0) {
    release(&p->lock);
    kfree((char*)p);
  102e04:	e9 a7 f3 ff ff       	jmp    1021b0 <kfree>
  102e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00102e10 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
  102e10:	55                   	push   %ebp
  102e11:	89 e5                	mov    %esp,%ebp
  102e13:	83 ec 18             	sub    $0x18,%esp
  102e16:	89 75 f8             	mov    %esi,-0x8(%ebp)
  102e19:	8b 75 08             	mov    0x8(%ebp),%esi
  102e1c:	89 7d fc             	mov    %edi,-0x4(%ebp)
  102e1f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  102e22:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
  102e25:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
  102e2b:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
  102e31:	e8 1a e0 ff ff       	call   100e50 <filealloc>
  102e36:	85 c0                	test   %eax,%eax
  102e38:	89 06                	mov    %eax,(%esi)
  102e3a:	0f 84 92 00 00 00    	je     102ed2 <pipealloc+0xc2>
  102e40:	e8 0b e0 ff ff       	call   100e50 <filealloc>
  102e45:	85 c0                	test   %eax,%eax
  102e47:	89 07                	mov    %eax,(%edi)
  102e49:	74 79                	je     102ec4 <pipealloc+0xb4>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
  102e4b:	e8 20 f3 ff ff       	call   102170 <kalloc>
  102e50:	85 c0                	test   %eax,%eax
  102e52:	89 c3                	mov    %eax,%ebx
  102e54:	74 6e                	je     102ec4 <pipealloc+0xb4>
    goto bad;
  p->readopen = 1;
  102e56:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
  102e5d:	00 00 00 
  p->writeopen = 1;
  102e60:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
  102e67:	00 00 00 
  p->nwrite = 0;
  102e6a:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
  102e71:	00 00 00 
  p->nread = 0;
  102e74:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
  102e7b:	00 00 00 
  initlock(&p->lock, "pipe");
  102e7e:	89 04 24             	mov    %eax,(%esp)
  102e81:	c7 44 24 04 5c 66 10 	movl   $0x10665c,0x4(%esp)
  102e88:	00 
  102e89:	e8 c2 09 00 00       	call   103850 <initlock>
  (*f0)->type = FD_PIPE;
  102e8e:	8b 06                	mov    (%esi),%eax
  102e90:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
  102e96:	8b 06                	mov    (%esi),%eax
  102e98:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
  102e9c:	8b 06                	mov    (%esi),%eax
  102e9e:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
  102ea2:	8b 06                	mov    (%esi),%eax
  102ea4:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
  102ea7:	8b 07                	mov    (%edi),%eax
  102ea9:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
  102eaf:	8b 07                	mov    (%edi),%eax
  102eb1:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
  102eb5:	8b 07                	mov    (%edi),%eax
  102eb7:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
  102ebb:	8b 07                	mov    (%edi),%eax
  102ebd:	89 58 0c             	mov    %ebx,0xc(%eax)
  102ec0:	31 c0                	xor    %eax,%eax
  102ec2:	eb 19                	jmp    102edd <pipealloc+0xcd>
  return 0;
  102ec4:	8b 06                	mov    (%esi),%eax

 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
  102ec6:	85 c0                	test   %eax,%eax
  102ec8:	74 08                	je     102ed2 <pipealloc+0xc2>
    fileclose(*f0);
  102eca:	89 04 24             	mov    %eax,(%esp)
  102ecd:	e8 ee df ff ff       	call   100ec0 <fileclose>
  if(*f1)
  102ed2:	8b 17                	mov    (%edi),%edx
  102ed4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  102ed9:	85 d2                	test   %edx,%edx
  102edb:	75 0d                	jne    102eea <pipealloc+0xda>
    fileclose(*f1);
  return -1;
}
  102edd:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  102ee0:	8b 75 f8             	mov    -0x8(%ebp),%esi
  102ee3:	8b 7d fc             	mov    -0x4(%ebp),%edi
  102ee6:	89 ec                	mov    %ebp,%esp
  102ee8:	5d                   	pop    %ebp
  102ee9:	c3                   	ret    
  if(p)
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  102eea:	89 14 24             	mov    %edx,(%esp)
  102eed:	e8 ce df ff ff       	call   100ec0 <fileclose>
  102ef2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  102ef7:	eb e4                	jmp    102edd <pipealloc+0xcd>
  102ef9:	90                   	nop    
  102efa:	90                   	nop    
  102efb:	90                   	nop    
  102efc:	90                   	nop    
  102efd:	90                   	nop    
  102efe:	90                   	nop    
  102eff:	90                   	nop    

00102f00 <wakeup1>:

// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  102f00:	55                   	push   %ebp
  102f01:	31 d2                	xor    %edx,%edx
  102f03:	89 e5                	mov    %esp,%ebp
  102f05:	eb 0b                	jmp    102f12 <wakeup1+0x12>
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
  102f07:	83 c2 7c             	add    $0x7c,%edx
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  102f0a:	81 fa 00 1f 00 00    	cmp    $0x1f00,%edx
  102f10:	74 26                	je     102f38 <wakeup1+0x38>
    if(p->state == SLEEPING && p->chan == chan)
  102f12:	83 ba e0 b0 10 00 02 	cmpl   $0x2,0x10b0e0(%edx)
  102f19:	75 ec                	jne    102f07 <wakeup1+0x7>
  102f1b:	39 82 f4 b0 10 00    	cmp    %eax,0x10b0f4(%edx)
  102f21:	75 e4                	jne    102f07 <wakeup1+0x7>
      p->state = RUNNABLE;
  102f23:	c7 82 e0 b0 10 00 03 	movl   $0x3,0x10b0e0(%edx)
  102f2a:	00 00 00 
  102f2d:	83 c2 7c             	add    $0x7c,%edx
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  102f30:	81 fa 00 1f 00 00    	cmp    $0x1f00,%edx
  102f36:	75 da                	jne    102f12 <wakeup1+0x12>
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
  102f38:	5d                   	pop    %ebp
  102f39:	c3                   	ret    
  102f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102f40 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  102f40:	55                   	push   %ebp
  102f41:	89 e5                	mov    %esp,%ebp
  102f43:	53                   	push   %ebx
  102f44:	83 ec 04             	sub    $0x4,%esp
  102f47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
  102f4a:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  102f51:	e8 7a 0a 00 00       	call   1039d0 <acquire>
  102f56:	ba d4 b0 10 00       	mov    $0x10b0d4,%edx
  102f5b:	eb 0e                	jmp    102f6b <kill+0x2b>
  102f5d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  102f60:	83 c2 7c             	add    $0x7c,%edx
  102f63:	81 fa d4 cf 10 00    	cmp    $0x10cfd4,%edx
  102f69:	74 28                	je     102f93 <kill+0x53>
    if(p->pid == pid){
  102f6b:	8b 42 10             	mov    0x10(%edx),%eax
  102f6e:	39 d8                	cmp    %ebx,%eax
  102f70:	75 ee                	jne    102f60 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
  102f72:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
  102f76:	c7 42 24 01 00 00 00 	movl   $0x1,0x24(%edx)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
  102f7d:	74 2b                	je     102faa <kill+0x6a>
        p->state = RUNNABLE;
      release(&ptable.lock);
  102f7f:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  102f86:	e8 05 0a 00 00       	call   103990 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
  102f8b:	83 c4 04             	add    $0x4,%esp
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
  102f8e:	31 c0                	xor    %eax,%eax
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
  102f90:	5b                   	pop    %ebx
  102f91:	5d                   	pop    %ebp
  102f92:	c3                   	ret    
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  102f93:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  102f9a:	e8 f1 09 00 00       	call   103990 <release>
  return -1;
}
  102f9f:	83 c4 04             	add    $0x4,%esp
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  102fa2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return -1;
}
  102fa7:	5b                   	pop    %ebx
  102fa8:	5d                   	pop    %ebp
  102fa9:	c3                   	ret    
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
  102faa:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
  102fb1:	eb cc                	jmp    102f7f <kill+0x3f>
  102fb3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00102fc0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  102fc0:	55                   	push   %ebp
  102fc1:	89 e5                	mov    %esp,%ebp
  102fc3:	53                   	push   %ebx
  102fc4:	83 ec 04             	sub    $0x4,%esp
  102fc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
  102fca:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  102fd1:	e8 fa 09 00 00       	call   1039d0 <acquire>
  wakeup1(chan);
  102fd6:	89 d8                	mov    %ebx,%eax
  102fd8:	e8 23 ff ff ff       	call   102f00 <wakeup1>
  release(&ptable.lock);
  102fdd:	c7 45 08 a0 b0 10 00 	movl   $0x10b0a0,0x8(%ebp)
}
  102fe4:	83 c4 04             	add    $0x4,%esp
  102fe7:	5b                   	pop    %ebx
  102fe8:	5d                   	pop    %ebp
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
  102fe9:	e9 a2 09 00 00       	jmp    103990 <release>
  102fee:	66 90                	xchg   %ax,%ax

00102ff0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  102ff0:	55                   	push   %ebp
  102ff1:	89 e5                	mov    %esp,%ebp
  102ff3:	83 ec 08             	sub    $0x8,%esp
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
  102ff6:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  102ffd:	e8 8e 09 00 00       	call   103990 <release>
  
  // Return to "caller", actually trapret (see allocproc).
}
  103002:	c9                   	leave  
  103003:	c3                   	ret    
  103004:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10300a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00103010 <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
  103010:	55                   	push   %ebp
  103011:	89 e5                	mov    %esp,%ebp
  103013:	53                   	push   %ebx
  103014:	83 ec 14             	sub    $0x14,%esp
  int intena;

  if(!holding(&ptable.lock))
  103017:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  10301e:	e8 ad 08 00 00       	call   1038d0 <holding>
  103023:	85 c0                	test   %eax,%eax
  103025:	74 4e                	je     103075 <sched+0x65>
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
  103027:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
  10302e:	83 ba ac 00 00 00 01 	cmpl   $0x1,0xac(%edx)
  103035:	75 4a                	jne    103081 <sched+0x71>
    panic("sched locks");
  if(proc->state == RUNNING)
  103037:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
  10303e:	83 79 0c 04          	cmpl   $0x4,0xc(%ecx)
  103042:	74 49                	je     10308d <sched+0x7d>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  103044:	9c                   	pushf  
  103045:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
  103046:	f6 c4 02             	test   $0x2,%ah
  103049:	75 4e                	jne    103099 <sched+0x89>
    panic("sched interruptible");
  intena = cpu->intena;
  swtch(&proc->context, cpu->scheduler);
  10304b:	8b 42 04             	mov    0x4(%edx),%eax
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = cpu->intena;
  10304e:	8b 9a b0 00 00 00    	mov    0xb0(%edx),%ebx
  swtch(&proc->context, cpu->scheduler);
  103054:	89 44 24 04          	mov    %eax,0x4(%esp)
  103058:	8d 41 1c             	lea    0x1c(%ecx),%eax
  10305b:	89 04 24             	mov    %eax,(%esp)
  10305e:	e8 f9 0b 00 00       	call   103c5c <swtch>
  cpu->intena = intena;
  103063:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  103069:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
}
  10306f:	83 c4 14             	add    $0x14,%esp
  103072:	5b                   	pop    %ebx
  103073:	5d                   	pop    %ebp
  103074:	c3                   	ret    
sched(void)
{
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  103075:	c7 04 24 61 66 10 00 	movl   $0x106661,(%esp)
  10307c:	e8 ff d7 ff ff       	call   100880 <panic>
  if(cpu->ncli != 1)
    panic("sched locks");
  103081:	c7 04 24 73 66 10 00 	movl   $0x106673,(%esp)
  103088:	e8 f3 d7 ff ff       	call   100880 <panic>
  if(proc->state == RUNNING)
    panic("sched running");
  10308d:	c7 04 24 7f 66 10 00 	movl   $0x10667f,(%esp)
  103094:	e8 e7 d7 ff ff       	call   100880 <panic>
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  103099:	c7 04 24 8d 66 10 00 	movl   $0x10668d,(%esp)
  1030a0:	e8 db d7 ff ff       	call   100880 <panic>
  1030a5:	8d 74 26 00          	lea    0x0(%esi),%esi
  1030a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001030b0 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  1030b0:	55                   	push   %ebp
  1030b1:	89 e5                	mov    %esp,%ebp
  1030b3:	56                   	push   %esi
  1030b4:	53                   	push   %ebx
  1030b5:	83 ec 10             	sub    $0x10,%esp
  if(proc == 0)
  1030b8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  1030be:	8b 75 08             	mov    0x8(%ebp),%esi
  1030c1:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(proc == 0)
  1030c4:	85 c0                	test   %eax,%eax
  1030c6:	0f 84 8f 00 00 00    	je     10315b <sleep+0xab>
    panic("sleep");

  if(lk == 0)
  1030cc:	85 db                	test   %ebx,%ebx
  1030ce:	0f 84 93 00 00 00    	je     103167 <sleep+0xb7>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
  1030d4:	81 fb a0 b0 10 00    	cmp    $0x10b0a0,%ebx
  1030da:	74 56                	je     103132 <sleep+0x82>
    acquire(&ptable.lock);  //DOC: sleeplock1
  1030dc:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  1030e3:	e8 e8 08 00 00       	call   1039d0 <acquire>
    release(lk);
  1030e8:	89 1c 24             	mov    %ebx,(%esp)
  1030eb:	e8 a0 08 00 00       	call   103990 <release>
  }

  // Go to sleep.
  proc->chan = chan;
  1030f0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1030f6:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
  1030f9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1030ff:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
  103106:	e8 05 ff ff ff       	call   103010 <sched>

  // Tidy up.
  proc->chan = 0;
  10310b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103111:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
  103118:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  10311f:	e8 6c 08 00 00       	call   103990 <release>
    acquire(lk);
  103124:	89 5d 08             	mov    %ebx,0x8(%ebp)
  }
}
  103127:	83 c4 10             	add    $0x10,%esp
  10312a:	5b                   	pop    %ebx
  10312b:	5e                   	pop    %esi
  10312c:	5d                   	pop    %ebp
  proc->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  10312d:	e9 9e 08 00 00       	jmp    1039d0 <acquire>
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }

  // Go to sleep.
  proc->chan = chan;
  103132:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
  103135:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10313b:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
  103142:	e8 c9 fe ff ff       	call   103010 <sched>

  // Tidy up.
  proc->chan = 0;
  103147:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10314d:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
  103154:	83 c4 10             	add    $0x10,%esp
  103157:	5b                   	pop    %ebx
  103158:	5e                   	pop    %esi
  103159:	5d                   	pop    %ebp
  10315a:	c3                   	ret    
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(proc == 0)
    panic("sleep");
  10315b:	c7 04 24 a1 66 10 00 	movl   $0x1066a1,(%esp)
  103162:	e8 19 d7 ff ff       	call   100880 <panic>

  if(lk == 0)
    panic("sleep without lk");
  103167:	c7 04 24 a7 66 10 00 	movl   $0x1066a7,(%esp)
  10316e:	e8 0d d7 ff ff       	call   100880 <panic>
  103173:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103179:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103180 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  103180:	55                   	push   %ebp
  103181:	89 e5                	mov    %esp,%ebp
  103183:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
  103186:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  10318d:	e8 3e 08 00 00       	call   1039d0 <acquire>
  proc->state = RUNNABLE;
  103192:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103198:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
  10319f:	e8 6c fe ff ff       	call   103010 <sched>
  release(&ptable.lock);
  1031a4:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  1031ab:	e8 e0 07 00 00       	call   103990 <release>
}
  1031b0:	c9                   	leave  
  1031b1:	c3                   	ret    
  1031b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  1031b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001031c0 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  1031c0:	55                   	push   %ebp
  1031c1:	89 e5                	mov    %esp,%ebp
  1031c3:	53                   	push   %ebx
  1031c4:	83 ec 14             	sub    $0x14,%esp
}

static inline void
sti(void)
{
  asm volatile("sti");
  1031c7:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
  1031c8:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  1031cf:	bb d4 b0 10 00       	mov    $0x10b0d4,%ebx
  1031d4:	e8 f7 07 00 00       	call   1039d0 <acquire>
  1031d9:	eb 10                	jmp    1031eb <scheduler+0x2b>
  1031db:	90                   	nop    
  1031dc:	8d 74 26 00          	lea    0x0(%esi),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  1031e0:	83 c3 7c             	add    $0x7c,%ebx
  1031e3:	81 fb d4 cf 10 00    	cmp    $0x10cfd4,%ebx
  1031e9:	74 56                	je     103241 <scheduler+0x81>
      if(p->state != RUNNABLE)
  1031eb:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
  1031ef:	90                   	nop    
  1031f0:	75 ee                	jne    1031e0 <scheduler+0x20>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
  1031f2:	65 89 1d 04 00 00 00 	mov    %ebx,%gs:0x4
      switchuvm(p);
  1031f9:	89 1c 24             	mov    %ebx,(%esp)
  1031fc:	e8 7f 2d 00 00       	call   105f80 <switchuvm>
      p->state = RUNNING;
      swtch(&cpu->scheduler, proc->context);
  103201:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
      p->state = RUNNING;
  103207:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  10320e:	83 c3 7c             	add    $0x7c,%ebx
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
      p->state = RUNNING;
      swtch(&cpu->scheduler, proc->context);
  103211:	8b 40 1c             	mov    0x1c(%eax),%eax
  103214:	89 44 24 04          	mov    %eax,0x4(%esp)
  103218:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  10321e:	83 c0 04             	add    $0x4,%eax
  103221:	89 04 24             	mov    %eax,(%esp)
  103224:	e8 33 0a 00 00       	call   103c5c <swtch>
      switchkvm();
  103229:	e8 32 27 00 00       	call   105960 <switchkvm>
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  10322e:	81 fb d4 cf 10 00    	cmp    $0x10cfd4,%ebx
      swtch(&cpu->scheduler, proc->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
  103234:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
  10323b:	00 00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  10323f:	75 aa                	jne    1031eb <scheduler+0x2b>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
  103241:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  103248:	e8 43 07 00 00       	call   103990 <release>
  10324d:	e9 75 ff ff ff       	jmp    1031c7 <scheduler+0x7>
  103252:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  103259:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103260 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  103260:	55                   	push   %ebp
  103261:	89 e5                	mov    %esp,%ebp
  103263:	56                   	push   %esi
  103264:	53                   	push   %ebx
  103265:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
  103268:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  10326f:	e8 5c 07 00 00       	call   1039d0 <acquire>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
  103274:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10327a:	bb d4 b0 10 00       	mov    $0x10b0d4,%ebx
  10327f:	31 d2                	xor    %edx,%edx
  103281:	eb 0b                	jmp    10328e <wait+0x2e>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103283:	83 c3 7c             	add    $0x7c,%ebx
  103286:	81 fb d4 cf 10 00    	cmp    $0x10cfd4,%ebx
  10328c:	74 1b                	je     1032a9 <wait+0x49>
      if(p->parent != proc)
  10328e:	39 43 14             	cmp    %eax,0x14(%ebx)
  103291:	75 f0                	jne    103283 <wait+0x23>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
  103293:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
  103297:	74 2d                	je     1032c6 <wait+0x66>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103299:	83 c3 7c             	add    $0x7c,%ebx
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        release(&ptable.lock);
        return pid;
  10329c:	ba 01 00 00 00       	mov    $0x1,%edx

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  1032a1:	81 fb d4 cf 10 00    	cmp    $0x10cfd4,%ebx
  1032a7:	75 e5                	jne    10328e <wait+0x2e>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
  1032a9:	85 d2                	test   %edx,%edx
  1032ab:	74 6e                	je     10331b <wait+0xbb>
  1032ad:	8b 50 24             	mov    0x24(%eax),%edx
  1032b0:	85 d2                	test   %edx,%edx
  1032b2:	75 67                	jne    10331b <wait+0xbb>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  1032b4:	c7 44 24 04 a0 b0 10 	movl   $0x10b0a0,0x4(%esp)
  1032bb:	00 
  1032bc:	89 04 24             	mov    %eax,(%esp)
  1032bf:	e8 ec fd ff ff       	call   1030b0 <sleep>
  1032c4:	eb ae                	jmp    103274 <wait+0x14>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
  1032c6:	8b 43 08             	mov    0x8(%ebx),%eax
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
  1032c9:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
  1032cc:	89 04 24             	mov    %eax,(%esp)
  1032cf:	e8 dc ee ff ff       	call   1021b0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
  1032d4:	8b 43 04             	mov    0x4(%ebx),%eax
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
  1032d7:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
  1032de:	89 04 24             	mov    %eax,(%esp)
  1032e1:	e8 da 29 00 00       	call   105cc0 <freevm>
        p->state = UNUSED;
  1032e6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        p->pid = 0;
  1032ed:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
  1032f4:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
  1032fb:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
  1032ff:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        release(&ptable.lock);
  103306:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  10330d:	e8 7e 06 00 00       	call   103990 <release>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
  103312:	83 c4 10             	add    $0x10,%esp
  103315:	89 f0                	mov    %esi,%eax
  103317:	5b                   	pop    %ebx
  103318:	5e                   	pop    %esi
  103319:	5d                   	pop    %ebp
  10331a:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
  10331b:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  103322:	be ff ff ff ff       	mov    $0xffffffff,%esi
  103327:	e8 64 06 00 00       	call   103990 <release>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
  10332c:	83 c4 10             	add    $0x10,%esp
  10332f:	89 f0                	mov    %esi,%eax
  103331:	5b                   	pop    %ebx
  103332:	5e                   	pop    %esi
  103333:	5d                   	pop    %ebp
  103334:	c3                   	ret    
  103335:	8d 74 26 00          	lea    0x0(%esi),%esi
  103339:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103340 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  103340:	55                   	push   %ebp
  103341:	89 e5                	mov    %esp,%ebp
  103343:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
  103346:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10334c:	3b 05 48 78 10 00    	cmp    0x107848,%eax
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  103352:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  103355:	89 75 fc             	mov    %esi,-0x4(%ebp)
  struct proc *p;
  int fd;

  if(proc == initproc)
  103358:	75 0c                	jne    103366 <exit+0x26>
    panic("init exiting");
  10335a:	c7 04 24 b8 66 10 00 	movl   $0x1066b8,(%esp)
  103361:	e8 1a d5 ff ff       	call   100880 <panic>
  103366:	31 db                	xor    %ebx,%ebx

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
  103368:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
  10336c:	85 d2                	test   %edx,%edx
  10336e:	74 1c                	je     10338c <exit+0x4c>
      fileclose(proc->ofile[fd]);
  103370:	89 14 24             	mov    %edx,(%esp)
  103373:	e8 48 db ff ff       	call   100ec0 <fileclose>
      proc->ofile[fd] = 0;
  103378:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10337e:	c7 44 98 28 00 00 00 	movl   $0x0,0x28(%eax,%ebx,4)
  103385:	00 
  103386:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
  10338c:	83 c3 01             	add    $0x1,%ebx
  10338f:	83 fb 10             	cmp    $0x10,%ebx
  103392:	75 d4                	jne    103368 <exit+0x28>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  iput(proc->cwd);
  103394:	8b 40 68             	mov    0x68(%eax),%eax
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
  103397:	30 db                	xor    %bl,%bl
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  iput(proc->cwd);
  103399:	89 04 24             	mov    %eax,(%esp)
  10339c:	e8 cf e4 ff ff       	call   101870 <iput>
  proc->cwd = 0;
  1033a1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1033a7:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
  1033ae:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  1033b5:	e8 16 06 00 00       	call   1039d0 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
  1033ba:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1033c0:	8b 40 14             	mov    0x14(%eax),%eax
  1033c3:	e8 38 fb ff ff       	call   102f00 <wakeup1>

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
  1033c8:	8b 35 48 78 10 00    	mov    0x107848,%esi
  1033ce:	eb 0b                	jmp    1033db <exit+0x9b>
      if(p->state == ZOMBIE)
        wakeup1(initproc);
  1033d0:	83 c3 7c             	add    $0x7c,%ebx

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  1033d3:	81 fb 00 1f 00 00    	cmp    $0x1f00,%ebx
  1033d9:	74 27                	je     103402 <exit+0xc2>
    if(p->parent == proc){
  1033db:	8b 83 e8 b0 10 00    	mov    0x10b0e8(%ebx),%eax
  1033e1:	65 3b 05 04 00 00 00 	cmp    %gs:0x4,%eax
  1033e8:	75 e6                	jne    1033d0 <exit+0x90>
      p->parent = initproc;
      if(p->state == ZOMBIE)
  1033ea:	83 bb e0 b0 10 00 05 	cmpl   $0x5,0x10b0e0(%ebx)
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
  1033f1:	89 b3 e8 b0 10 00    	mov    %esi,0x10b0e8(%ebx)
      if(p->state == ZOMBIE)
  1033f7:	75 d7                	jne    1033d0 <exit+0x90>
        wakeup1(initproc);
  1033f9:	89 f0                	mov    %esi,%eax
  1033fb:	e8 00 fb ff ff       	call   102f00 <wakeup1>
  103400:	eb ce                	jmp    1033d0 <exit+0x90>
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
  103402:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103408:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
  10340f:	e8 fc fb ff ff       	call   103010 <sched>
  panic("zombie exit");
  103414:	c7 04 24 c5 66 10 00 	movl   $0x1066c5,(%esp)
  10341b:	e8 60 d4 ff ff       	call   100880 <panic>

00103420 <allocproc>:
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and return it.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  103420:	55                   	push   %ebp
  103421:	89 e5                	mov    %esp,%ebp
  103423:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  103424:	bb d4 b0 10 00       	mov    $0x10b0d4,%ebx
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and return it.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  103429:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  10342c:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  103433:	e8 98 05 00 00       	call   1039d0 <acquire>
  103438:	eb 11                	jmp    10344b <allocproc+0x2b>
  10343a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  103440:	83 c3 7c             	add    $0x7c,%ebx
  103443:	81 fb d4 cf 10 00    	cmp    $0x10cfd4,%ebx
  103449:	74 7e                	je     1034c9 <allocproc+0xa9>
    if(p->state == UNUSED)
  10344b:	8b 4b 0c             	mov    0xc(%ebx),%ecx
  10344e:	85 c9                	test   %ecx,%ecx
  103450:	75 ee                	jne    103440 <allocproc+0x20>
      goto found;
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  103452:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
  103459:	a1 04 73 10 00       	mov    0x107304,%eax
  10345e:	89 43 10             	mov    %eax,0x10(%ebx)
  103461:	83 c0 01             	add    $0x1,%eax
  103464:	a3 04 73 10 00       	mov    %eax,0x107304
  release(&ptable.lock);
  103469:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  103470:	e8 1b 05 00 00       	call   103990 <release>

  // Allocate kernel stack if possible.
  if((p->kstack = kalloc()) == 0){
  103475:	e8 f6 ec ff ff       	call   102170 <kalloc>
  10347a:	85 c0                	test   %eax,%eax
  10347c:	89 c2                	mov    %eax,%edx
  10347e:	89 43 08             	mov    %eax,0x8(%ebx)
  103481:	74 5c                	je     1034df <allocproc+0xbf>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  103483:	8d 80 b4 0f 00 00    	lea    0xfb4(%eax),%eax
  p->tf = (struct trapframe*)sp;
  103489:	89 43 18             	mov    %eax,0x18(%ebx)
  // which returns to trapret (see below).
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  10348c:	8d 82 9c 0f 00 00    	lea    0xf9c(%edx),%eax
  p->tf = (struct trapframe*)sp;
  
  // Set up new context to start executing at forkret,
  // which returns to trapret (see below).
  sp -= 4;
  *(uint*)sp = (uint)trapret;
  103492:	c7 82 b0 0f 00 00 90 	movl   $0x104a90,0xfb0(%edx)
  103499:	4a 10 00 

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  10349c:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
  10349f:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
  1034a6:	00 
  1034a7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1034ae:	00 
  1034af:	89 04 24             	mov    %eax,(%esp)
  1034b2:	e8 89 05 00 00       	call   103a40 <memset>
  p->context->eip = (uint)forkret;
  1034b7:	8b 43 1c             	mov    0x1c(%ebx),%eax
  1034ba:	c7 40 10 f0 2f 10 00 	movl   $0x102ff0,0x10(%eax)
  return p;
}
  1034c1:	89 d8                	mov    %ebx,%eax
  1034c3:	83 c4 14             	add    $0x14,%esp
  1034c6:	5b                   	pop    %ebx
  1034c7:	5d                   	pop    %ebp
  1034c8:	c3                   	ret    

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
  1034c9:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  1034d0:	31 db                	xor    %ebx,%ebx
  1034d2:	e8 b9 04 00 00       	call   103990 <release>
  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
  return p;
}
  1034d7:	89 d8                	mov    %ebx,%eax
  1034d9:	83 c4 14             	add    $0x14,%esp
  1034dc:	5b                   	pop    %ebx
  1034dd:	5d                   	pop    %ebp
  1034de:	c3                   	ret    
  p->pid = nextpid++;
  release(&ptable.lock);

  // Allocate kernel stack if possible.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
  1034df:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  1034e6:	31 db                	xor    %ebx,%ebx
  1034e8:	eb d7                	jmp    1034c1 <allocproc+0xa1>
  1034ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001034f0 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  1034f0:	55                   	push   %ebp
  1034f1:	89 e5                	mov    %esp,%ebp
  1034f3:	56                   	push   %esi
  1034f4:	53                   	push   %ebx
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
  1034f5:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  1034fa:	83 ec 10             	sub    $0x10,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
  1034fd:	e8 1e ff ff ff       	call   103420 <allocproc>
  103502:	85 c0                	test   %eax,%eax
  103504:	89 c6                	mov    %eax,%esi
  103506:	0f 84 c4 00 00 00    	je     1035d0 <fork+0xe0>
    return -1;

  // Copy process state from p.
  if(!(np->pgdir = copyuvm(proc->pgdir, proc->sz))){
  10350c:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  103513:	8b 02                	mov    (%edx),%eax
  103515:	89 44 24 04          	mov    %eax,0x4(%esp)
  103519:	8b 42 04             	mov    0x4(%edx),%eax
  10351c:	89 04 24             	mov    %eax,(%esp)
  10351f:	e8 1c 28 00 00       	call   105d40 <copyuvm>
  103524:	85 c0                	test   %eax,%eax
  103526:	89 46 04             	mov    %eax,0x4(%esi)
  103529:	0f 84 aa 00 00 00    	je     1035d9 <fork+0xe9>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = proc->sz;
  10352f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  np->parent = proc;
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
  103535:	31 db                	xor    %ebx,%ebx
    np->state = UNUSED;
    return -1;
  }
  np->sz = proc->sz;
  np->parent = proc;
  *np->tf = *proc->tf;
  103537:	8b 56 18             	mov    0x18(%esi),%edx
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = proc->sz;
  10353a:	8b 00                	mov    (%eax),%eax
  10353c:	89 06                	mov    %eax,(%esi)
  np->parent = proc;
  10353e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103544:	89 46 14             	mov    %eax,0x14(%esi)
  *np->tf = *proc->tf;
  103547:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10354d:	8b 40 18             	mov    0x18(%eax),%eax
  103550:	89 14 24             	mov    %edx,(%esp)
  103553:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
  10355a:	00 
  10355b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10355f:	e8 dc 05 00 00       	call   103b40 <memcpy>

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
  103564:	8b 46 18             	mov    0x18(%esi),%eax
  103567:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  10356e:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
  103575:	8b 44 9a 28          	mov    0x28(%edx,%ebx,4),%eax
  103579:	85 c0                	test   %eax,%eax
  10357b:	74 13                	je     103590 <fork+0xa0>
      np->ofile[i] = filedup(proc->ofile[i]);
  10357d:	89 04 24             	mov    %eax,(%esp)
  103580:	e8 7b d8 ff ff       	call   100e00 <filedup>
  103585:	89 44 9e 28          	mov    %eax,0x28(%esi,%ebx,4)
  103589:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
  103590:	83 c3 01             	add    $0x1,%ebx
  103593:	83 fb 10             	cmp    $0x10,%ebx
  103596:	75 dd                	jne    103575 <fork+0x85>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
  103598:	8b 42 68             	mov    0x68(%edx),%eax
  10359b:	89 04 24             	mov    %eax,(%esp)
  10359e:	e8 3d da ff ff       	call   100fe0 <idup>
 
  pid = np->pid;
  1035a3:	8b 5e 10             	mov    0x10(%esi),%ebx
  np->state = RUNNABLE;
  1035a6:	c7 46 0c 03 00 00 00 	movl   $0x3,0xc(%esi)
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
  1035ad:	89 46 68             	mov    %eax,0x68(%esi)
 
  pid = np->pid;
  np->state = RUNNABLE;
  safestrcpy(np->name, proc->name, sizeof(proc->name));
  1035b0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1035b6:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  1035bd:	00 
  1035be:	83 c0 6c             	add    $0x6c,%eax
  1035c1:	89 44 24 04          	mov    %eax,0x4(%esp)
  1035c5:	8d 46 6c             	lea    0x6c(%esi),%eax
  1035c8:	89 04 24             	mov    %eax,(%esp)
  1035cb:	e8 30 06 00 00       	call   103c00 <safestrcpy>
  return pid;
}
  1035d0:	83 c4 10             	add    $0x10,%esp
  1035d3:	89 d8                	mov    %ebx,%eax
  1035d5:	5b                   	pop    %ebx
  1035d6:	5e                   	pop    %esi
  1035d7:	5d                   	pop    %ebp
  1035d8:	c3                   	ret    
  if((np = allocproc()) == 0)
    return -1;

  // Copy process state from p.
  if(!(np->pgdir = copyuvm(proc->pgdir, proc->sz))){
    kfree(np->kstack);
  1035d9:	8b 46 08             	mov    0x8(%esi),%eax
  1035dc:	89 04 24             	mov    %eax,(%esp)
  1035df:	e8 cc eb ff ff       	call   1021b0 <kfree>
    np->kstack = 0;
  1035e4:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
    np->state = UNUSED;
  1035eb:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
  1035f2:	eb dc                	jmp    1035d0 <fork+0xe0>
  1035f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1035fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00103600 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  103600:	55                   	push   %ebp
  103601:	89 e5                	mov    %esp,%ebp
  103603:	83 ec 18             	sub    $0x18,%esp
  uint sz = proc->sz;
  103606:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
  if(n > 0){
  10360d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz = proc->sz;
  103611:	8b 11                	mov    (%ecx),%edx
  if(n > 0){
  103613:	7f 16                	jg     10362b <growproc+0x2b>
    if(!(sz = allocuvm(proc->pgdir, sz, sz + n)))
      return -1;
  } else if(n < 0){
  103615:	75 3b                	jne    103652 <growproc+0x52>
    if(!(sz = deallocuvm(proc->pgdir, sz, sz + n)))
      return -1;
  }
  proc->sz = sz;
  103617:	89 11                	mov    %edx,(%ecx)
  switchuvm(proc);
  103619:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10361f:	89 04 24             	mov    %eax,(%esp)
  103622:	e8 59 29 00 00       	call   105f80 <switchuvm>
  103627:	31 c0                	xor    %eax,%eax
  return 0;
}
  103629:	c9                   	leave  
  10362a:	c3                   	ret    
int
growproc(int n)
{
  uint sz = proc->sz;
  if(n > 0){
    if(!(sz = allocuvm(proc->pgdir, sz, sz + n)))
  10362b:	8b 45 08             	mov    0x8(%ebp),%eax
  10362e:	89 54 24 04          	mov    %edx,0x4(%esp)
  103632:	01 d0                	add    %edx,%eax
  103634:	89 44 24 08          	mov    %eax,0x8(%esp)
  103638:	8b 41 04             	mov    0x4(%ecx),%eax
  10363b:	89 04 24             	mov    %eax,(%esp)
  10363e:	e8 bd 27 00 00       	call   105e00 <allocuvm>
  103643:	85 c0                	test   %eax,%eax
  103645:	74 27                	je     10366e <growproc+0x6e>
  103647:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
      return -1;
  } else if(n < 0){
    if(!(sz = deallocuvm(proc->pgdir, sz, sz + n)))
  10364e:	89 c2                	mov    %eax,%edx
  103650:	eb c5                	jmp    103617 <growproc+0x17>
  103652:	8b 45 08             	mov    0x8(%ebp),%eax
  103655:	89 54 24 04          	mov    %edx,0x4(%esp)
  103659:	01 d0                	add    %edx,%eax
  10365b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10365f:	8b 41 04             	mov    0x4(%ecx),%eax
  103662:	89 04 24             	mov    %eax,(%esp)
  103665:	e8 c6 25 00 00       	call   105c30 <deallocuvm>
  10366a:	85 c0                	test   %eax,%eax
  10366c:	75 d9                	jne    103647 <growproc+0x47>
      return -1;
  }
  proc->sz = sz;
  switchuvm(proc);
  return 0;
}
  10366e:	c9                   	leave  
    if(!(sz = deallocuvm(proc->pgdir, sz, sz + n)))
      return -1;
  }
  proc->sz = sz;
  switchuvm(proc);
  return 0;
  10366f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  103674:	c3                   	ret    
  103675:	8d 74 26 00          	lea    0x0(%esi),%esi
  103679:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103680 <userinit>:
}

// Set up first user process.
void
userinit(void)
{
  103680:	55                   	push   %ebp
  103681:	89 e5                	mov    %esp,%ebp
  103683:	53                   	push   %ebx
  103684:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
  103687:	e8 94 fd ff ff       	call   103420 <allocproc>
  10368c:	89 c3                	mov    %eax,%ebx
  initproc = p;
  10368e:	a3 48 78 10 00       	mov    %eax,0x107848
  if(!(p->pgdir = setupkvm()))
  103693:	e8 c8 24 00 00       	call   105b60 <setupkvm>
  103698:	85 c0                	test   %eax,%eax
  10369a:	89 43 04             	mov    %eax,0x4(%ebx)
  10369d:	0f 84 b6 00 00 00    	je     103759 <userinit+0xd9>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  1036a3:	89 04 24             	mov    %eax,(%esp)
  1036a6:	c7 44 24 08 2c 00 00 	movl   $0x2c,0x8(%esp)
  1036ad:	00 
  1036ae:	c7 44 24 04 08 77 10 	movl   $0x107708,0x4(%esp)
  1036b5:	00 
  1036b6:	e8 15 24 00 00       	call   105ad0 <inituvm>
  p->sz = PGSIZE;
  1036bb:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
  1036c1:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
  1036c8:	00 
  1036c9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1036d0:	00 
  1036d1:	8b 43 18             	mov    0x18(%ebx),%eax
  1036d4:	89 04 24             	mov    %eax,(%esp)
  1036d7:	e8 64 03 00 00       	call   103a40 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  1036dc:	8b 43 18             	mov    0x18(%ebx),%eax
  1036df:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  1036e5:	8b 43 18             	mov    0x18(%ebx),%eax
  1036e8:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
  1036ee:	8b 53 18             	mov    0x18(%ebx),%edx
  1036f1:	0f b7 42 2c          	movzwl 0x2c(%edx),%eax
  1036f5:	66 89 42 28          	mov    %ax,0x28(%edx)
  p->tf->ss = p->tf->ds;
  1036f9:	8b 53 18             	mov    0x18(%ebx),%edx
  1036fc:	0f b7 42 2c          	movzwl 0x2c(%edx),%eax
  103700:	66 89 42 48          	mov    %ax,0x48(%edx)
  p->tf->eflags = FL_IF;
  103704:	8b 43 18             	mov    0x18(%ebx),%eax
  103707:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
  10370e:	8b 43 18             	mov    0x18(%ebx),%eax
  103711:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
  103718:	8b 43 18             	mov    0x18(%ebx),%eax
  10371b:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
  103722:	8d 43 6c             	lea    0x6c(%ebx),%eax
  103725:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  10372c:	00 
  10372d:	c7 44 24 04 ea 66 10 	movl   $0x1066ea,0x4(%esp)
  103734:	00 
  103735:	89 04 24             	mov    %eax,(%esp)
  103738:	e8 c3 04 00 00       	call   103c00 <safestrcpy>
  p->cwd = namei("/");
  10373d:	c7 04 24 f3 66 10 00 	movl   $0x1066f3,(%esp)
  103744:	e8 07 e6 ff ff       	call   101d50 <namei>

  p->state = RUNNABLE;
  103749:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");
  103750:	89 43 68             	mov    %eax,0x68(%ebx)

  p->state = RUNNABLE;
}
  103753:	83 c4 14             	add    $0x14,%esp
  103756:	5b                   	pop    %ebx
  103757:	5d                   	pop    %ebp
  103758:	c3                   	ret    
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
  initproc = p;
  if(!(p->pgdir = setupkvm()))
    panic("userinit: out of memory?");
  103759:	c7 04 24 d1 66 10 00 	movl   $0x1066d1,(%esp)
  103760:	e8 1b d1 ff ff       	call   100880 <panic>
  103765:	8d 74 26 00          	lea    0x0(%esi),%esi
  103769:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103770 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  103770:	55                   	push   %ebp
  103771:	89 e5                	mov    %esp,%ebp
  103773:	57                   	push   %edi
  103774:	56                   	push   %esi
  103775:	53                   	push   %ebx
  103776:	bb d4 b0 10 00       	mov    $0x10b0d4,%ebx
  10377b:	83 ec 4c             	sub    $0x4c,%esp
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
  10377e:	8d 7d cc             	lea    -0x34(%ebp),%edi
  103781:	eb 46                	jmp    1037c9 <procdump+0x59>
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
  103783:	8b 0c 85 34 67 10 00 	mov    0x106734(,%eax,4),%ecx
  10378a:	85 c9                	test   %ecx,%ecx
  10378c:	74 47                	je     1037d5 <procdump+0x65>
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
  10378e:	8b 53 10             	mov    0x10(%ebx),%edx
  103791:	8d 43 6c             	lea    0x6c(%ebx),%eax
  103794:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103798:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  10379c:	c7 04 24 f9 66 10 00 	movl   $0x1066f9,(%esp)
  1037a3:	89 54 24 04          	mov    %edx,0x4(%esp)
  1037a7:	e8 14 cd ff ff       	call   1004c0 <cprintf>
    if(p->state == SLEEPING){
  1037ac:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
  1037b0:	74 2a                	je     1037dc <procdump+0x6c>
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  1037b2:	c7 04 24 d6 65 10 00 	movl   $0x1065d6,(%esp)
  1037b9:	e8 02 cd ff ff       	call   1004c0 <cprintf>
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  1037be:	83 c3 7c             	add    $0x7c,%ebx
  1037c1:	81 fb d4 cf 10 00    	cmp    $0x10cfd4,%ebx
  1037c7:	74 4f                	je     103818 <procdump+0xa8>
    if(p->state == UNUSED)
  1037c9:	8b 43 0c             	mov    0xc(%ebx),%eax
  1037cc:	85 c0                	test   %eax,%eax
  1037ce:	74 ee                	je     1037be <procdump+0x4e>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
  1037d0:	83 f8 05             	cmp    $0x5,%eax
  1037d3:	76 ae                	jbe    103783 <procdump+0x13>
  1037d5:	b9 f5 66 10 00       	mov    $0x1066f5,%ecx
  1037da:	eb b2                	jmp    10378e <procdump+0x1e>
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
  1037dc:	8b 43 1c             	mov    0x1c(%ebx),%eax
  1037df:	be 01 00 00 00       	mov    $0x1,%esi
  1037e4:	89 7c 24 04          	mov    %edi,0x4(%esp)
  1037e8:	8b 40 0c             	mov    0xc(%eax),%eax
  1037eb:	83 c0 08             	add    $0x8,%eax
  1037ee:	89 04 24             	mov    %eax,(%esp)
  1037f1:	e8 7a 00 00 00       	call   103870 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
  1037f6:	8b 44 b7 fc          	mov    -0x4(%edi,%esi,4),%eax
  1037fa:	85 c0                	test   %eax,%eax
  1037fc:	74 b4                	je     1037b2 <procdump+0x42>
        cprintf(" %p", pc[i]);
  1037fe:	83 c6 01             	add    $0x1,%esi
  103801:	89 44 24 04          	mov    %eax,0x4(%esp)
  103805:	c7 04 24 aa 61 10 00 	movl   $0x1061aa,(%esp)
  10380c:	e8 af cc ff ff       	call   1004c0 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
  103811:	83 fe 0b             	cmp    $0xb,%esi
  103814:	75 e0                	jne    1037f6 <procdump+0x86>
  103816:	eb 9a                	jmp    1037b2 <procdump+0x42>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
  103818:	83 c4 4c             	add    $0x4c,%esp
  10381b:	5b                   	pop    %ebx
  10381c:	5e                   	pop    %esi
  10381d:	5f                   	pop    %edi
  10381e:	5d                   	pop    %ebp
  10381f:	90                   	nop    
  103820:	c3                   	ret    
  103821:	eb 0d                	jmp    103830 <pinit>
  103823:	90                   	nop    
  103824:	90                   	nop    
  103825:	90                   	nop    
  103826:	90                   	nop    
  103827:	90                   	nop    
  103828:	90                   	nop    
  103829:	90                   	nop    
  10382a:	90                   	nop    
  10382b:	90                   	nop    
  10382c:	90                   	nop    
  10382d:	90                   	nop    
  10382e:	90                   	nop    
  10382f:	90                   	nop    

00103830 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
  103830:	55                   	push   %ebp
  103831:	89 e5                	mov    %esp,%ebp
  103833:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");
  103836:	c7 44 24 04 02 67 10 	movl   $0x106702,0x4(%esp)
  10383d:	00 
  10383e:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  103845:	e8 06 00 00 00       	call   103850 <initlock>
}
  10384a:	c9                   	leave  
  10384b:	c3                   	ret    
  10384c:	90                   	nop    
  10384d:	90                   	nop    
  10384e:	90                   	nop    
  10384f:	90                   	nop    

00103850 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  103850:	55                   	push   %ebp
  103851:	89 e5                	mov    %esp,%ebp
  103853:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
  103856:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
  103859:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
  10385f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
  103862:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
  103869:	5d                   	pop    %ebp
  10386a:	c3                   	ret    
  10386b:	90                   	nop    
  10386c:	8d 74 26 00          	lea    0x0(%esi),%esi

00103870 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  103870:	55                   	push   %ebp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  103871:	31 c9                	xor    %ecx,%ecx
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  103873:	89 e5                	mov    %esp,%ebp
  103875:	53                   	push   %ebx
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  103876:	8b 55 08             	mov    0x8(%ebp),%edx
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  103879:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  10387c:	83 ea 08             	sub    $0x8,%edx
  10387f:	eb 02                	jmp    103883 <getcallerpcs+0x13>
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint *) 0x100000 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  103881:	89 c2                	mov    %eax,%edx
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint *) 0x100000 || ebp == (uint*)0xffffffff)
  103883:	8d 82 00 00 f0 ff    	lea    -0x100000(%edx),%eax
  103889:	3d fe ff ef ff       	cmp    $0xffeffffe,%eax
  10388e:	77 13                	ja     1038a3 <getcallerpcs+0x33>
      break;
    pcs[i] = ebp[1];     // saved %eip
  103890:	8b 42 04             	mov    0x4(%edx),%eax
  103893:	89 04 8b             	mov    %eax,(%ebx,%ecx,4)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
  103896:	83 c1 01             	add    $0x1,%ecx
    if(ebp == 0 || ebp < (uint *) 0x100000 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  103899:	8b 02                	mov    (%edx),%eax
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
  10389b:	83 f9 0a             	cmp    $0xa,%ecx
  10389e:	75 e1                	jne    103881 <getcallerpcs+0x11>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
  1038a0:	5b                   	pop    %ebx
  1038a1:	5d                   	pop    %ebp
  1038a2:	c3                   	ret    
    if(ebp == 0 || ebp < (uint *) 0x100000 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
  1038a3:	83 f9 09             	cmp    $0x9,%ecx
  1038a6:	7f f8                	jg     1038a0 <getcallerpcs+0x30>
  1038a8:	8d 04 8b             	lea    (%ebx,%ecx,4),%eax
  1038ab:	90                   	nop    
  1038ac:	8d 74 26 00          	lea    0x0(%esi),%esi
  1038b0:	83 c1 01             	add    $0x1,%ecx
    pcs[i] = 0;
  1038b3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint *) 0x100000 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
  1038b9:	83 c0 04             	add    $0x4,%eax
  1038bc:	83 f9 0a             	cmp    $0xa,%ecx
  1038bf:	75 ef                	jne    1038b0 <getcallerpcs+0x40>
    pcs[i] = 0;
}
  1038c1:	5b                   	pop    %ebx
  1038c2:	5d                   	pop    %ebp
  1038c3:	c3                   	ret    
  1038c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1038ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001038d0 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  1038d0:	55                   	push   %ebp
  return lock->locked && lock->cpu == cpu;
  1038d1:	31 c0                	xor    %eax,%eax
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  1038d3:	89 e5                	mov    %esp,%ebp
  1038d5:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu;
  1038d8:	8b 0a                	mov    (%edx),%ecx
  1038da:	85 c9                	test   %ecx,%ecx
  1038dc:	74 10                	je     1038ee <holding+0x1e>
  1038de:	8b 42 08             	mov    0x8(%edx),%eax
  1038e1:	65 3b 05 00 00 00 00 	cmp    %gs:0x0,%eax
  1038e8:	0f 94 c0             	sete   %al
  1038eb:	0f b6 c0             	movzbl %al,%eax
}
  1038ee:	5d                   	pop    %ebp
  1038ef:	c3                   	ret    

001038f0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
  1038f0:	55                   	push   %ebp
  1038f1:	89 e5                	mov    %esp,%ebp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  1038f3:	9c                   	pushf  
  1038f4:	59                   	pop    %ecx
}

static inline void
cli(void)
{
  asm volatile("cli");
  1038f5:	fa                   	cli    
  int eflags;
  
  eflags = readeflags();
  cli();
  if(cpu->ncli++ == 0)
  1038f6:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  1038fc:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
  103902:	83 c2 01             	add    $0x1,%edx
  103905:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
  10390b:	83 ea 01             	sub    $0x1,%edx
  10390e:	74 02                	je     103912 <pushcli+0x22>
    cpu->intena = eflags & FL_IF;
}
  103910:	5d                   	pop    %ebp
  103911:	c3                   	ret    
  int eflags;
  
  eflags = readeflags();
  cli();
  if(cpu->ncli++ == 0)
    cpu->intena = eflags & FL_IF;
  103912:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  103918:	81 e1 00 02 00 00    	and    $0x200,%ecx
  10391e:	89 88 b0 00 00 00    	mov    %ecx,0xb0(%eax)
}
  103924:	5d                   	pop    %ebp
  103925:	c3                   	ret    
  103926:	8d 76 00             	lea    0x0(%esi),%esi
  103929:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103930 <popcli>:

void
popcli(void)
{
  103930:	55                   	push   %ebp
  103931:	89 e5                	mov    %esp,%ebp
  103933:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  103936:	9c                   	pushf  
  103937:	58                   	pop    %eax
  if(readeflags()&FL_IF)
  103938:	f6 c4 02             	test   $0x2,%ah
  10393b:	75 36                	jne    103973 <popcli+0x43>
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
  10393d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  103943:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
  103949:	83 ea 01             	sub    $0x1,%edx
  10394c:	85 d2                	test   %edx,%edx
  10394e:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
  103954:	78 29                	js     10397f <popcli+0x4f>
    panic("popcli");
  if(cpu->ncli == 0 && cpu->intena)
  103956:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  10395c:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
  103962:	85 d2                	test   %edx,%edx
  103964:	75 0b                	jne    103971 <popcli+0x41>
  103966:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
  10396c:	85 c0                	test   %eax,%eax
  10396e:	74 01                	je     103971 <popcli+0x41>
}

static inline void
sti(void)
{
  asm volatile("sti");
  103970:	fb                   	sti    
    sti();
}
  103971:	c9                   	leave  
  103972:	c3                   	ret    

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  103973:	c7 04 24 4c 67 10 00 	movl   $0x10674c,(%esp)
  10397a:	e8 01 cf ff ff       	call   100880 <panic>
  if(--cpu->ncli < 0)
    panic("popcli");
  10397f:	c7 04 24 63 67 10 00 	movl   $0x106763,(%esp)
  103986:	e8 f5 ce ff ff       	call   100880 <panic>
  10398b:	90                   	nop    
  10398c:	8d 74 26 00          	lea    0x0(%esi),%esi

00103990 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
  103990:	55                   	push   %ebp
  103991:	89 e5                	mov    %esp,%ebp
  103993:	53                   	push   %ebx
  103994:	83 ec 04             	sub    $0x4,%esp
  103997:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
  10399a:	89 1c 24             	mov    %ebx,(%esp)
  10399d:	e8 2e ff ff ff       	call   1038d0 <holding>
  1039a2:	85 c0                	test   %eax,%eax
  1039a4:	74 1d                	je     1039c3 <release+0x33>
    panic("release");

  lk->pcs[0] = 0;
  1039a6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  1039ad:	31 c0                	xor    %eax,%eax
  lk->cpu = 0;
  1039af:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  1039b6:	f0 87 03             	lock xchg %eax,(%ebx)
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);

  popcli();
}
  1039b9:	83 c4 04             	add    $0x4,%esp
  1039bc:	5b                   	pop    %ebx
  1039bd:	5d                   	pop    %ebp
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);

  popcli();
  1039be:	e9 6d ff ff ff       	jmp    103930 <popcli>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
  1039c3:	c7 04 24 6a 67 10 00 	movl   $0x10676a,(%esp)
  1039ca:	e8 b1 ce ff ff       	call   100880 <panic>
  1039cf:	90                   	nop    

001039d0 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
  1039d0:	55                   	push   %ebp
  1039d1:	89 e5                	mov    %esp,%ebp
  1039d3:	53                   	push   %ebx
  1039d4:	83 ec 14             	sub    $0x14,%esp
  pushcli();
  1039d7:	e8 14 ff ff ff       	call   1038f0 <pushcli>
  if(holding(lk))
  1039dc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  1039df:	89 1c 24             	mov    %ebx,(%esp)
  1039e2:	e8 e9 fe ff ff       	call   1038d0 <holding>
  1039e7:	85 c0                	test   %eax,%eax
  1039e9:	74 08                	je     1039f3 <acquire+0x23>
  1039eb:	eb 39                	jmp    103a26 <acquire+0x56>
  1039ed:	8d 76 00             	lea    0x0(%esi),%esi
  1039f0:	8b 5d 08             	mov    0x8(%ebp),%ebx
  1039f3:	b8 01 00 00 00       	mov    $0x1,%eax
  1039f8:	f0 87 03             	lock xchg %eax,(%ebx)
    panic("acquire");

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
  1039fb:	85 c0                	test   %eax,%eax
  1039fd:	75 f1                	jne    1039f0 <acquire+0x20>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
  1039ff:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  103a05:	8b 55 08             	mov    0x8(%ebp),%edx
  103a08:	89 42 08             	mov    %eax,0x8(%edx)
  getcallerpcs(&lk, lk->pcs);
  103a0b:	8b 45 08             	mov    0x8(%ebp),%eax
  103a0e:	83 c0 0c             	add    $0xc,%eax
  103a11:	89 44 24 04          	mov    %eax,0x4(%esp)
  103a15:	8d 45 08             	lea    0x8(%ebp),%eax
  103a18:	89 04 24             	mov    %eax,(%esp)
  103a1b:	e8 50 fe ff ff       	call   103870 <getcallerpcs>
}
  103a20:	83 c4 14             	add    $0x14,%esp
  103a23:	5b                   	pop    %ebx
  103a24:	5d                   	pop    %ebp
  103a25:	c3                   	ret    
void
acquire(struct spinlock *lk)
{
  pushcli();
  if(holding(lk))
    panic("acquire");
  103a26:	c7 04 24 72 67 10 00 	movl   $0x106772,(%esp)
  103a2d:	e8 4e ce ff ff       	call   100880 <panic>
  103a32:	90                   	nop    
  103a33:	90                   	nop    
  103a34:	90                   	nop    
  103a35:	90                   	nop    
  103a36:	90                   	nop    
  103a37:	90                   	nop    
  103a38:	90                   	nop    
  103a39:	90                   	nop    
  103a3a:	90                   	nop    
  103a3b:	90                   	nop    
  103a3c:	90                   	nop    
  103a3d:	90                   	nop    
  103a3e:	90                   	nop    
  103a3f:	90                   	nop    

00103a40 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
  103a40:	55                   	push   %ebp
  103a41:	89 e5                	mov    %esp,%ebp
  103a43:	8b 55 08             	mov    0x8(%ebp),%edx
  103a46:	57                   	push   %edi
  103a47:	8b 45 0c             	mov    0xc(%ebp),%eax
  103a4a:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  103a4d:	89 d7                	mov    %edx,%edi
  103a4f:	fc                   	cld    
  103a50:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  103a52:	5f                   	pop    %edi
  103a53:	89 d0                	mov    %edx,%eax
  103a55:	5d                   	pop    %ebp
  103a56:	c3                   	ret    
  103a57:	89 f6                	mov    %esi,%esi
  103a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103a60 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
  103a60:	55                   	push   %ebp
  103a61:	89 e5                	mov    %esp,%ebp
  103a63:	57                   	push   %edi
  103a64:	56                   	push   %esi
  103a65:	53                   	push   %ebx
  103a66:	83 ec 04             	sub    $0x4,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  103a69:	8b 45 10             	mov    0x10(%ebp),%eax
  return dst;
}

int
memcmp(const void *v1, const void *v2, uint n)
{
  103a6c:	8b 55 08             	mov    0x8(%ebp),%edx
  103a6f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  103a72:	83 e8 01             	sub    $0x1,%eax
  103a75:	83 f8 ff             	cmp    $0xffffffff,%eax
  103a78:	74 36                	je     103ab0 <memcmp+0x50>
    if(*s1 != *s2)
  103a7a:	0f b6 32             	movzbl (%edx),%esi
  103a7d:	0f b6 0f             	movzbl (%edi),%ecx
  103a80:	89 f3                	mov    %esi,%ebx
  103a82:	88 4d f3             	mov    %cl,-0xd(%ebp)
      return *s1 - *s2;
  103a85:	89 d1                	mov    %edx,%ecx
  103a87:	89 fa                	mov    %edi,%edx
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
  103a89:	3a 5d f3             	cmp    -0xd(%ebp),%bl
  103a8c:	74 1a                	je     103aa8 <memcmp+0x48>
  103a8e:	eb 2c                	jmp    103abc <memcmp+0x5c>
  103a90:	0f b6 71 01          	movzbl 0x1(%ecx),%esi
  103a94:	83 c1 01             	add    $0x1,%ecx
  103a97:	0f b6 5a 01          	movzbl 0x1(%edx),%ebx
  103a9b:	83 c2 01             	add    $0x1,%edx
  103a9e:	88 5d f3             	mov    %bl,-0xd(%ebp)
  103aa1:	89 f3                	mov    %esi,%ebx
  103aa3:	3a 5d f3             	cmp    -0xd(%ebp),%bl
  103aa6:	75 14                	jne    103abc <memcmp+0x5c>
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  103aa8:	83 e8 01             	sub    $0x1,%eax
  103aab:	83 f8 ff             	cmp    $0xffffffff,%eax
  103aae:	75 e0                	jne    103a90 <memcmp+0x30>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
  103ab0:	83 c4 04             	add    $0x4,%esp
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  103ab3:	31 d2                	xor    %edx,%edx
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
  103ab5:	5b                   	pop    %ebx
  103ab6:	89 d0                	mov    %edx,%eax
  103ab8:	5e                   	pop    %esi
  103ab9:	5f                   	pop    %edi
  103aba:	5d                   	pop    %ebp
  103abb:	c3                   	ret    
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
  103abc:	89 f0                	mov    %esi,%eax
  103abe:	0f b6 d0             	movzbl %al,%edx
  103ac1:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
    s1++, s2++;
  }

  return 0;
}
  103ac5:	83 c4 04             	add    $0x4,%esp
  103ac8:	5b                   	pop    %ebx
  103ac9:	5e                   	pop    %esi
  103aca:	5f                   	pop    %edi
  103acb:	5d                   	pop    %ebp
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
  103acc:	29 c2                	sub    %eax,%edx
    s1++, s2++;
  }

  return 0;
}
  103ace:	89 d0                	mov    %edx,%eax
  103ad0:	c3                   	ret    
  103ad1:	eb 0d                	jmp    103ae0 <memmove>
  103ad3:	90                   	nop    
  103ad4:	90                   	nop    
  103ad5:	90                   	nop    
  103ad6:	90                   	nop    
  103ad7:	90                   	nop    
  103ad8:	90                   	nop    
  103ad9:	90                   	nop    
  103ada:	90                   	nop    
  103adb:	90                   	nop    
  103adc:	90                   	nop    
  103add:	90                   	nop    
  103ade:	90                   	nop    
  103adf:	90                   	nop    

00103ae0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
  103ae0:	55                   	push   %ebp
  103ae1:	89 e5                	mov    %esp,%ebp
  103ae3:	56                   	push   %esi
  103ae4:	53                   	push   %ebx
  103ae5:	8b 75 08             	mov    0x8(%ebp),%esi
  103ae8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  103aeb:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
  103aee:	39 f1                	cmp    %esi,%ecx
  103af0:	73 2e                	jae    103b20 <memmove+0x40>
  103af2:	8d 04 19             	lea    (%ecx,%ebx,1),%eax
  103af5:	39 c6                	cmp    %eax,%esi
  103af7:	73 27                	jae    103b20 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
  103af9:	85 db                	test   %ebx,%ebx
  103afb:	74 1a                	je     103b17 <memmove+0x37>
  103afd:	89 c2                	mov    %eax,%edx
  103aff:	29 d8                	sub    %ebx,%eax
  103b01:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
  103b04:	89 c3                	mov    %eax,%ebx
      *--d = *--s;
  103b06:	0f b6 42 ff          	movzbl -0x1(%edx),%eax
  103b0a:	83 ea 01             	sub    $0x1,%edx
  103b0d:	88 41 ff             	mov    %al,-0x1(%ecx)
  103b10:	83 e9 01             	sub    $0x1,%ecx
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
  103b13:	39 da                	cmp    %ebx,%edx
  103b15:	75 ef                	jne    103b06 <memmove+0x26>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
  103b17:	89 f0                	mov    %esi,%eax
  103b19:	5b                   	pop    %ebx
  103b1a:	5e                   	pop    %esi
  103b1b:	5d                   	pop    %ebp
  103b1c:	c3                   	ret    
  103b1d:	8d 76 00             	lea    0x0(%esi),%esi
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
  103b20:	31 d2                	xor    %edx,%edx
      *--d = *--s;
  } else
    while(n-- > 0)
  103b22:	85 db                	test   %ebx,%ebx
  103b24:	74 f1                	je     103b17 <memmove+0x37>
      *d++ = *s++;
  103b26:	0f b6 04 0a          	movzbl (%edx,%ecx,1),%eax
  103b2a:	88 04 32             	mov    %al,(%edx,%esi,1)
  103b2d:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
  103b30:	39 da                	cmp    %ebx,%edx
  103b32:	75 f2                	jne    103b26 <memmove+0x46>
      *d++ = *s++;

  return dst;
}
  103b34:	89 f0                	mov    %esi,%eax
  103b36:	5b                   	pop    %ebx
  103b37:	5e                   	pop    %esi
  103b38:	5d                   	pop    %ebp
  103b39:	c3                   	ret    
  103b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103b40 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  103b40:	55                   	push   %ebp
  103b41:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
  103b43:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
  103b44:	e9 97 ff ff ff       	jmp    103ae0 <memmove>
  103b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00103b50 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
  103b50:	55                   	push   %ebp
  103b51:	89 e5                	mov    %esp,%ebp
  103b53:	56                   	push   %esi
  103b54:	53                   	push   %ebx
  103b55:	8b 5d 10             	mov    0x10(%ebp),%ebx
  103b58:	8b 55 08             	mov    0x8(%ebp),%edx
  103b5b:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
  103b5e:	85 db                	test   %ebx,%ebx
  103b60:	74 2a                	je     103b8c <strncmp+0x3c>
  103b62:	0f b6 02             	movzbl (%edx),%eax
  103b65:	84 c0                	test   %al,%al
  103b67:	74 2b                	je     103b94 <strncmp+0x44>
  103b69:	0f b6 0e             	movzbl (%esi),%ecx
  103b6c:	38 c8                	cmp    %cl,%al
  103b6e:	74 17                	je     103b87 <strncmp+0x37>
  103b70:	eb 25                	jmp    103b97 <strncmp+0x47>
  103b72:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    n--, p++, q++;
  103b76:	83 c6 01             	add    $0x1,%esi
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
  103b79:	84 c0                	test   %al,%al
  103b7b:	74 17                	je     103b94 <strncmp+0x44>
  103b7d:	0f b6 0e             	movzbl (%esi),%ecx
  103b80:	83 c2 01             	add    $0x1,%edx
  103b83:	38 c8                	cmp    %cl,%al
  103b85:	75 10                	jne    103b97 <strncmp+0x47>
  103b87:	83 eb 01             	sub    $0x1,%ebx
  103b8a:	75 e6                	jne    103b72 <strncmp+0x22>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
  103b8c:	5b                   	pop    %ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
  103b8d:	31 d2                	xor    %edx,%edx
}
  103b8f:	5e                   	pop    %esi
  103b90:	89 d0                	mov    %edx,%eax
  103b92:	5d                   	pop    %ebp
  103b93:	c3                   	ret    
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
  103b94:	0f b6 0e             	movzbl (%esi),%ecx
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
  103b97:	0f b6 d0             	movzbl %al,%edx
  103b9a:	0f b6 c1             	movzbl %cl,%eax
}
  103b9d:	5b                   	pop    %ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
  103b9e:	29 c2                	sub    %eax,%edx
}
  103ba0:	5e                   	pop    %esi
  103ba1:	89 d0                	mov    %edx,%eax
  103ba3:	5d                   	pop    %ebp
  103ba4:	c3                   	ret    
  103ba5:	8d 74 26 00          	lea    0x0(%esi),%esi
  103ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103bb0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
  103bb0:	55                   	push   %ebp
  103bb1:	89 e5                	mov    %esp,%ebp
  103bb3:	56                   	push   %esi
  103bb4:	8b 75 08             	mov    0x8(%ebp),%esi
  103bb7:	53                   	push   %ebx
  103bb8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  103bbb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  103bbe:	89 f2                	mov    %esi,%edx
  103bc0:	eb 03                	jmp    103bc5 <strncpy+0x15>
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
  103bc2:	83 c3 01             	add    $0x1,%ebx
  103bc5:	83 e9 01             	sub    $0x1,%ecx
  103bc8:	8d 41 01             	lea    0x1(%ecx),%eax
  103bcb:	85 c0                	test   %eax,%eax
  103bcd:	7e 0c                	jle    103bdb <strncpy+0x2b>
  103bcf:	0f b6 03             	movzbl (%ebx),%eax
  103bd2:	88 02                	mov    %al,(%edx)
  103bd4:	83 c2 01             	add    $0x1,%edx
  103bd7:	84 c0                	test   %al,%al
  103bd9:	75 e7                	jne    103bc2 <strncpy+0x12>
    ;
  while(n-- > 0)
  103bdb:	85 c9                	test   %ecx,%ecx
  103bdd:	7e 0d                	jle    103bec <strncpy+0x3c>
  103bdf:	8d 04 11             	lea    (%ecx,%edx,1),%eax
    *s++ = 0;
  103be2:	c6 02 00             	movb   $0x0,(%edx)
  103be5:	83 c2 01             	add    $0x1,%edx
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
  103be8:	39 c2                	cmp    %eax,%edx
  103bea:	75 f6                	jne    103be2 <strncpy+0x32>
    *s++ = 0;
  return os;
}
  103bec:	89 f0                	mov    %esi,%eax
  103bee:	5b                   	pop    %ebx
  103bef:	5e                   	pop    %esi
  103bf0:	5d                   	pop    %ebp
  103bf1:	c3                   	ret    
  103bf2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  103bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103c00 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
  103c00:	55                   	push   %ebp
  103c01:	89 e5                	mov    %esp,%ebp
  103c03:	8b 4d 10             	mov    0x10(%ebp),%ecx
  103c06:	56                   	push   %esi
  103c07:	8b 75 08             	mov    0x8(%ebp),%esi
  103c0a:	53                   	push   %ebx
  103c0b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;
  
  os = s;
  if(n <= 0)
  103c0e:	85 c9                	test   %ecx,%ecx
  103c10:	7e 1b                	jle    103c2d <safestrcpy+0x2d>
  103c12:	89 f2                	mov    %esi,%edx
  103c14:	eb 03                	jmp    103c19 <safestrcpy+0x19>
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
  103c16:	83 c3 01             	add    $0x1,%ebx
  103c19:	83 e9 01             	sub    $0x1,%ecx
  103c1c:	74 0c                	je     103c2a <safestrcpy+0x2a>
  103c1e:	0f b6 03             	movzbl (%ebx),%eax
  103c21:	88 02                	mov    %al,(%edx)
  103c23:	83 c2 01             	add    $0x1,%edx
  103c26:	84 c0                	test   %al,%al
  103c28:	75 ec                	jne    103c16 <safestrcpy+0x16>
    ;
  *s = 0;
  103c2a:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
  103c2d:	89 f0                	mov    %esi,%eax
  103c2f:	5b                   	pop    %ebx
  103c30:	5e                   	pop    %esi
  103c31:	5d                   	pop    %ebp
  103c32:	c3                   	ret    
  103c33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103c40 <strlen>:

int
strlen(const char *s)
{
  103c40:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
  103c41:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
  103c43:	89 e5                	mov    %esp,%ebp
  103c45:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  103c48:	80 3a 00             	cmpb   $0x0,(%edx)
  103c4b:	74 0c                	je     103c59 <strlen+0x19>
  103c4d:	8d 76 00             	lea    0x0(%esi),%esi
  103c50:	83 c0 01             	add    $0x1,%eax
  103c53:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  103c57:	75 f7                	jne    103c50 <strlen+0x10>
    ;
  return n;
}
  103c59:	5d                   	pop    %ebp
  103c5a:	c3                   	ret    
  103c5b:	90                   	nop    

00103c5c <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
  103c5c:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
  103c60:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
  103c64:	55                   	push   %ebp
  pushl %ebx
  103c65:	53                   	push   %ebx
  pushl %esi
  103c66:	56                   	push   %esi
  pushl %edi
  103c67:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
  103c68:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
  103c6a:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
  103c6c:	5f                   	pop    %edi
  popl %esi
  103c6d:	5e                   	pop    %esi
  popl %ebx
  103c6e:	5b                   	pop    %ebx
  popl %ebp
  103c6f:	5d                   	pop    %ebp
  ret
  103c70:	c3                   	ret    
  103c71:	90                   	nop    
  103c72:	90                   	nop    
  103c73:	90                   	nop    
  103c74:	90                   	nop    
  103c75:	90                   	nop    
  103c76:	90                   	nop    
  103c77:	90                   	nop    
  103c78:	90                   	nop    
  103c79:	90                   	nop    
  103c7a:	90                   	nop    
  103c7b:	90                   	nop    
  103c7c:	90                   	nop    
  103c7d:	90                   	nop    
  103c7e:	90                   	nop    
  103c7f:	90                   	nop    

00103c80 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  103c80:	55                   	push   %ebp
  103c81:	89 e5                	mov    %esp,%ebp
  if(addr >= p->sz || addr+4 > p->sz)
  103c83:	8b 45 08             	mov    0x8(%ebp),%eax
  103c86:	8b 10                	mov    (%eax),%edx
  103c88:	3b 55 0c             	cmp    0xc(%ebp),%edx
  103c8b:	77 07                	ja     103c94 <fetchint+0x14>
    return -1;
  *ip = *(int*)(addr);
  return 0;
}
  103c8d:	5d                   	pop    %ebp
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
    return -1;
  *ip = *(int*)(addr);
  return 0;
  103c8e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  103c93:	c3                   	ret    

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  103c94:	8b 45 0c             	mov    0xc(%ebp),%eax
  103c97:	83 c0 04             	add    $0x4,%eax
  103c9a:	39 c2                	cmp    %eax,%edx
  103c9c:	72 ef                	jb     103c8d <fetchint+0xd>
    return -1;
  *ip = *(int*)(addr);
  103c9e:	8b 55 0c             	mov    0xc(%ebp),%edx
  103ca1:	8b 02                	mov    (%edx),%eax
  103ca3:	8b 55 10             	mov    0x10(%ebp),%edx
  103ca6:	89 02                	mov    %eax,(%edx)
  103ca8:	31 c0                	xor    %eax,%eax
  return 0;
}
  103caa:	5d                   	pop    %ebp
  103cab:	c3                   	ret    
  103cac:	8d 74 26 00          	lea    0x0(%esi),%esi

00103cb0 <fetchstr>:
// Fetch the nul-terminated string at addr from process p.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(struct proc *p, uint addr, char **pp)
{
  103cb0:	55                   	push   %ebp
  103cb1:	89 e5                	mov    %esp,%ebp
  103cb3:	8b 45 08             	mov    0x8(%ebp),%eax
  103cb6:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *s, *ep;

  if(addr >= p->sz)
  103cb9:	39 10                	cmp    %edx,(%eax)
  103cbb:	77 07                	ja     103cc4 <fetchstr+0x14>
    return -1;
  *pp = (char *) addr;
  ep = (char *) p->sz;
  for(s = *pp; s < ep; s++)
  103cbd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    if(*s == 0)
      return s - *pp;
  return -1;
}
  103cc2:	5d                   	pop    %ebp
  103cc3:	c3                   	ret    
{
  char *s, *ep;

  if(addr >= p->sz)
    return -1;
  *pp = (char *) addr;
  103cc4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  103cc7:	89 11                	mov    %edx,(%ecx)
  ep = (char *) p->sz;
  103cc9:	8b 08                	mov    (%eax),%ecx
  for(s = *pp; s < ep; s++)
  103ccb:	39 ca                	cmp    %ecx,%edx
  103ccd:	73 ee                	jae    103cbd <fetchstr+0xd>
    if(*s == 0)
  103ccf:	31 c0                	xor    %eax,%eax
  103cd1:	80 3a 00             	cmpb   $0x0,(%edx)
  103cd4:	74 ec                	je     103cc2 <fetchstr+0x12>
  103cd6:	89 d0                	mov    %edx,%eax

  if(addr >= p->sz)
    return -1;
  *pp = (char *) addr;
  ep = (char *) p->sz;
  for(s = *pp; s < ep; s++)
  103cd8:	83 c0 01             	add    $0x1,%eax
  103cdb:	39 c8                	cmp    %ecx,%eax
  103cdd:	74 de                	je     103cbd <fetchstr+0xd>
    if(*s == 0)
  103cdf:	80 38 00             	cmpb   $0x0,(%eax)
  103ce2:	75 f4                	jne    103cd8 <fetchstr+0x28>
      return s - *pp;
  return -1;
}
  103ce4:	5d                   	pop    %ebp
  if(addr >= p->sz)
    return -1;
  *pp = (char *) addr;
  ep = (char *) p->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
  103ce5:	29 d0                	sub    %edx,%eax
      return s - *pp;
  return -1;
}
  103ce7:	c3                   	ret    
  103ce8:	90                   	nop    
  103ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00103cf0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  103cf0:	55                   	push   %ebp
  103cf1:	89 e5                	mov    %esp,%ebp
  103cf3:	83 ec 0c             	sub    $0xc,%esp
  int x = fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
  103cf6:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
  103cfd:	8b 45 0c             	mov    0xc(%ebp),%eax
  103d00:	89 44 24 08          	mov    %eax,0x8(%esp)
  103d04:	8b 41 18             	mov    0x18(%ecx),%eax
  103d07:	8b 50 44             	mov    0x44(%eax),%edx
  103d0a:	8b 45 08             	mov    0x8(%ebp),%eax
  103d0d:	89 0c 24             	mov    %ecx,(%esp)
  103d10:	83 c2 04             	add    $0x4,%edx
  103d13:	8d 04 82             	lea    (%edx,%eax,4),%eax
  103d16:	89 44 24 04          	mov    %eax,0x4(%esp)
  103d1a:	e8 61 ff ff ff       	call   103c80 <fetchint>
  return x;
}
  103d1f:	c9                   	leave  
  103d20:	c3                   	ret    
  103d21:	eb 0d                	jmp    103d30 <argptr>
  103d23:	90                   	nop    
  103d24:	90                   	nop    
  103d25:	90                   	nop    
  103d26:	90                   	nop    
  103d27:	90                   	nop    
  103d28:	90                   	nop    
  103d29:	90                   	nop    
  103d2a:	90                   	nop    
  103d2b:	90                   	nop    
  103d2c:	90                   	nop    
  103d2d:	90                   	nop    
  103d2e:	90                   	nop    
  103d2f:	90                   	nop    

00103d30 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
  103d30:	55                   	push   %ebp
  103d31:	89 e5                	mov    %esp,%ebp
  103d33:	83 ec 18             	sub    $0x18,%esp
  int i;
  
  if(argint(n, &i) < 0)
  103d36:	8d 45 fc             	lea    -0x4(%ebp),%eax
  103d39:	89 44 24 04          	mov    %eax,0x4(%esp)
  103d3d:	8b 45 08             	mov    0x8(%ebp),%eax
  103d40:	89 04 24             	mov    %eax,(%esp)
  103d43:	e8 a8 ff ff ff       	call   103cf0 <argint>
  103d48:	85 c0                	test   %eax,%eax
  103d4a:	79 07                	jns    103d53 <argptr+0x23>
  // Modified by Jingyue
  if((uint)i > proc->sz || (uint)i+size > proc->sz)
    return -1;
  *pp = (char *) i;
  return 0;
}
  103d4c:	c9                   	leave  
    return -1;
  // Modified by Jingyue
  if((uint)i > proc->sz || (uint)i+size > proc->sz)
    return -1;
  *pp = (char *) i;
  return 0;
  103d4d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  103d52:	c3                   	ret    
  int i;
  
  if(argint(n, &i) < 0)
    return -1;
  // Modified by Jingyue
  if((uint)i > proc->sz || (uint)i+size > proc->sz)
  103d53:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103d59:	8b 55 fc             	mov    -0x4(%ebp),%edx
  103d5c:	8b 08                	mov    (%eax),%ecx
  103d5e:	39 ca                	cmp    %ecx,%edx
  103d60:	77 ea                	ja     103d4c <argptr+0x1c>
  103d62:	8b 45 10             	mov    0x10(%ebp),%eax
  103d65:	01 d0                	add    %edx,%eax
  103d67:	39 c1                	cmp    %eax,%ecx
  103d69:	72 e1                	jb     103d4c <argptr+0x1c>
    return -1;
  *pp = (char *) i;
  103d6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  103d6e:	89 10                	mov    %edx,(%eax)
  103d70:	31 c0                	xor    %eax,%eax
  return 0;
}
  103d72:	c9                   	leave  
  103d73:	c3                   	ret    
  103d74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103d7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00103d80 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
  103d80:	55                   	push   %ebp
  103d81:	89 e5                	mov    %esp,%ebp
  103d83:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  if(argint(n, &addr) < 0)
  103d86:	8d 45 fc             	lea    -0x4(%ebp),%eax
  103d89:	89 44 24 04          	mov    %eax,0x4(%esp)
  103d8d:	8b 45 08             	mov    0x8(%ebp),%eax
  103d90:	89 04 24             	mov    %eax,(%esp)
  103d93:	e8 58 ff ff ff       	call   103cf0 <argint>
  103d98:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  103d9d:	85 c0                	test   %eax,%eax
  103d9f:	78 1e                	js     103dbf <argstr+0x3f>
    return -1;
  return fetchstr(proc, addr, pp);
  103da1:	8b 45 0c             	mov    0xc(%ebp),%eax
  103da4:	89 44 24 08          	mov    %eax,0x8(%esp)
  103da8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103dab:	89 44 24 04          	mov    %eax,0x4(%esp)
  103daf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103db5:	89 04 24             	mov    %eax,(%esp)
  103db8:	e8 f3 fe ff ff       	call   103cb0 <fetchstr>
  103dbd:	89 c2                	mov    %eax,%edx
}
  103dbf:	c9                   	leave  
  103dc0:	89 d0                	mov    %edx,%eax
  103dc2:	c3                   	ret    
  103dc3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103dd0 <syscall>:
[SYS_uptime]  sys_uptime,
};

void
syscall(void)
{
  103dd0:	55                   	push   %ebp
  103dd1:	89 e5                	mov    %esp,%ebp
  103dd3:	53                   	push   %ebx
  103dd4:	83 ec 14             	sub    $0x14,%esp
  int num;
  
  num = proc->tf->eax;
  103dd7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103ddd:	8b 58 18             	mov    0x18(%eax),%ebx
  103de0:	8b 4b 1c             	mov    0x1c(%ebx),%ecx
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
  103de3:	83 f9 15             	cmp    $0x15,%ecx
  103de6:	77 18                	ja     103e00 <syscall+0x30>
  103de8:	8b 14 8d a0 67 10 00 	mov    0x1067a0(,%ecx,4),%edx
  103def:	85 d2                	test   %edx,%edx
  103df1:	74 0d                	je     103e00 <syscall+0x30>
    proc->tf->eax = syscalls[num]();
  103df3:	ff d2                	call   *%edx
  103df5:	89 43 1c             	mov    %eax,0x1c(%ebx)
  else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  }
}
  103df8:	83 c4 14             	add    $0x14,%esp
  103dfb:	5b                   	pop    %ebx
  103dfc:	5d                   	pop    %ebp
  103dfd:	c3                   	ret    
  103dfe:	66 90                	xchg   %ax,%ax
  
  num = proc->tf->eax;
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
    proc->tf->eax = syscalls[num]();
  else {
    cprintf("%d %s: unknown sys call %d\n",
  103e00:	8b 50 10             	mov    0x10(%eax),%edx
  103e03:	83 c0 6c             	add    $0x6c,%eax
  103e06:	89 44 24 08          	mov    %eax,0x8(%esp)
  103e0a:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  103e0e:	c7 04 24 7a 67 10 00 	movl   $0x10677a,(%esp)
  103e15:	89 54 24 04          	mov    %edx,0x4(%esp)
  103e19:	e8 a2 c6 ff ff       	call   1004c0 <cprintf>
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  103e1e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103e24:	8b 40 18             	mov    0x18(%eax),%eax
  103e27:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
  103e2e:	83 c4 14             	add    $0x14,%esp
  103e31:	5b                   	pop    %ebx
  103e32:	5d                   	pop    %ebp
  103e33:	c3                   	ret    
  103e34:	90                   	nop    
  103e35:	90                   	nop    
  103e36:	90                   	nop    
  103e37:	90                   	nop    
  103e38:	90                   	nop    
  103e39:	90                   	nop    
  103e3a:	90                   	nop    
  103e3b:	90                   	nop    
  103e3c:	90                   	nop    
  103e3d:	90                   	nop    
  103e3e:	90                   	nop    
  103e3f:	90                   	nop    

00103e40 <fdalloc>:
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
  103e40:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  103e47:	89 c1                	mov    %eax,%ecx
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
  103e49:	31 c0                	xor    %eax,%eax

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  103e4b:	55                   	push   %ebp
  103e4c:	89 e5                	mov    %esp,%ebp
  103e4e:	66 90                	xchg   %ax,%ax
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
  103e50:	83 7c 82 28 00       	cmpl   $0x0,0x28(%edx,%eax,4)
  103e55:	74 0f                	je     103e66 <fdalloc+0x26>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
  103e57:	83 c0 01             	add    $0x1,%eax
  103e5a:	83 f8 10             	cmp    $0x10,%eax
  103e5d:	75 f1                	jne    103e50 <fdalloc+0x10>
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
}
  103e5f:	5d                   	pop    %ebp
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
  103e60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
}
  103e65:	c3                   	ret    
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
  103e66:	89 4c 82 28          	mov    %ecx,0x28(%edx,%eax,4)
      return fd;
    }
  }
  return -1;
}
  103e6a:	5d                   	pop    %ebp
  103e6b:	c3                   	ret    
  103e6c:	8d 74 26 00          	lea    0x0(%esi),%esi

00103e70 <sys_pipe>:
  return exec(path, argv);
}

int
sys_pipe(void)
{
  103e70:	55                   	push   %ebp
  103e71:	89 e5                	mov    %esp,%ebp
  103e73:	53                   	push   %ebx
  103e74:	83 ec 24             	sub    $0x24,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
  103e77:	8d 45 f8             	lea    -0x8(%ebp),%eax
  103e7a:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
  103e81:	00 
  103e82:	89 44 24 04          	mov    %eax,0x4(%esp)
  103e86:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  103e8d:	e8 9e fe ff ff       	call   103d30 <argptr>
  103e92:	85 c0                	test   %eax,%eax
  103e94:	79 0b                	jns    103ea1 <sys_pipe+0x31>
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
  103e96:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  103e9b:	83 c4 24             	add    $0x24,%esp
  103e9e:	5b                   	pop    %ebx
  103e9f:	5d                   	pop    %ebp
  103ea0:	c3                   	ret    
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
  103ea1:	8d 45 f0             	lea    -0x10(%ebp),%eax
  103ea4:	89 44 24 04          	mov    %eax,0x4(%esp)
  103ea8:	8d 45 f4             	lea    -0xc(%ebp),%eax
  103eab:	89 04 24             	mov    %eax,(%esp)
  103eae:	e8 5d ef ff ff       	call   102e10 <pipealloc>
  103eb3:	85 c0                	test   %eax,%eax
  103eb5:	78 df                	js     103e96 <sys_pipe+0x26>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
  103eb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103eba:	e8 81 ff ff ff       	call   103e40 <fdalloc>
  103ebf:	85 c0                	test   %eax,%eax
  103ec1:	89 c3                	mov    %eax,%ebx
  103ec3:	78 2b                	js     103ef0 <sys_pipe+0x80>
  103ec5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103ec8:	e8 73 ff ff ff       	call   103e40 <fdalloc>
  103ecd:	85 c0                	test   %eax,%eax
  103ecf:	89 c2                	mov    %eax,%edx
  103ed1:	78 0f                	js     103ee2 <sys_pipe+0x72>
      proc->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  103ed3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103ed6:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
  103ed8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103edb:	89 50 04             	mov    %edx,0x4(%eax)
  103ede:	31 c0                	xor    %eax,%eax
  103ee0:	eb b9                	jmp    103e9b <sys_pipe+0x2b>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
  103ee2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103ee8:	c7 44 98 28 00 00 00 	movl   $0x0,0x28(%eax,%ebx,4)
  103eef:	00 
    fileclose(rf);
  103ef0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103ef3:	89 04 24             	mov    %eax,(%esp)
  103ef6:	e8 c5 cf ff ff       	call   100ec0 <fileclose>
    fileclose(wf);
  103efb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103efe:	89 04 24             	mov    %eax,(%esp)
  103f01:	e8 ba cf ff ff       	call   100ec0 <fileclose>
  103f06:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  103f0b:	eb 8e                	jmp    103e9b <sys_pipe+0x2b>
  103f0d:	8d 76 00             	lea    0x0(%esi),%esi

00103f10 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
  103f10:	55                   	push   %ebp
  103f11:	89 e5                	mov    %esp,%ebp
  103f13:	83 ec 28             	sub    $0x28,%esp
  103f16:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  103f19:	89 d3                	mov    %edx,%ebx
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
  103f1b:	8d 55 f4             	lea    -0xc(%ebp),%edx

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
  103f1e:	89 75 fc             	mov    %esi,-0x4(%ebp)
  103f21:	89 ce                	mov    %ecx,%esi
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
  103f23:	89 54 24 04          	mov    %edx,0x4(%esp)
  103f27:	89 04 24             	mov    %eax,(%esp)
  103f2a:	e8 c1 fd ff ff       	call   103cf0 <argint>
  103f2f:	85 c0                	test   %eax,%eax
  103f31:	79 0f                	jns    103f42 <argfd+0x32>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  103f33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return 0;
}
  103f38:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  103f3b:	8b 75 fc             	mov    -0x4(%ebp),%esi
  103f3e:	89 ec                	mov    %ebp,%esp
  103f40:	5d                   	pop    %ebp
  103f41:	c3                   	ret    
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
  103f42:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103f45:	83 fa 0f             	cmp    $0xf,%edx
  103f48:	77 e9                	ja     103f33 <argfd+0x23>
  103f4a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103f50:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
  103f54:	85 c9                	test   %ecx,%ecx
  103f56:	74 db                	je     103f33 <argfd+0x23>
    return -1;
  if(pfd)
  103f58:	85 db                	test   %ebx,%ebx
  103f5a:	74 02                	je     103f5e <argfd+0x4e>
    *pfd = fd;
  103f5c:	89 13                	mov    %edx,(%ebx)
  if(pf)
  103f5e:	31 c0                	xor    %eax,%eax
  103f60:	85 f6                	test   %esi,%esi
  103f62:	74 d4                	je     103f38 <argfd+0x28>
    *pf = f;
  103f64:	89 0e                	mov    %ecx,(%esi)
  103f66:	eb d0                	jmp    103f38 <argfd+0x28>
  103f68:	90                   	nop    
  103f69:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00103f70 <sys_close>:
  return filewrite(f, p, n);
}

int
sys_close(void)
{
  103f70:	55                   	push   %ebp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
  103f71:	31 c0                	xor    %eax,%eax
  return filewrite(f, p, n);
}

int
sys_close(void)
{
  103f73:	89 e5                	mov    %esp,%ebp
  103f75:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
  103f78:	8d 55 fc             	lea    -0x4(%ebp),%edx
  103f7b:	8d 4d f8             	lea    -0x8(%ebp),%ecx
  103f7e:	e8 8d ff ff ff       	call   103f10 <argfd>
  103f83:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  103f88:	85 c0                	test   %eax,%eax
  103f8a:	78 1f                	js     103fab <sys_close+0x3b>
    return -1;
  proc->ofile[fd] = 0;
  103f8c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103f8f:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  103f96:	c7 44 82 28 00 00 00 	movl   $0x0,0x28(%edx,%eax,4)
  103f9d:	00 
  fileclose(f);
  103f9e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103fa1:	89 04 24             	mov    %eax,(%esp)
  103fa4:	e8 17 cf ff ff       	call   100ec0 <fileclose>
  103fa9:	31 d2                	xor    %edx,%edx
  return 0;
}
  103fab:	c9                   	leave  
  103fac:	89 d0                	mov    %edx,%eax
  103fae:	c3                   	ret    
  103faf:	90                   	nop    

00103fb0 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
  103fb0:	55                   	push   %ebp
  103fb1:	89 e5                	mov    %esp,%ebp
  103fb3:	83 ec 78             	sub    $0x78,%esp
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0) {
  103fb6:	8d 45 f0             	lea    -0x10(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
  103fb9:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  103fbc:	89 75 f8             	mov    %esi,-0x8(%ebp)
  103fbf:	89 7d fc             	mov    %edi,-0x4(%ebp)
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0) {
  103fc2:	89 44 24 04          	mov    %eax,0x4(%esp)
  103fc6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  103fcd:	e8 ae fd ff ff       	call   103d80 <argstr>
  103fd2:	85 c0                	test   %eax,%eax
  103fd4:	79 12                	jns    103fe8 <sys_exec+0x38>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
    if(i >= NELEM(argv))
  103fd6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(proc, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
  103fdb:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  103fde:	8b 75 f8             	mov    -0x8(%ebp),%esi
  103fe1:	8b 7d fc             	mov    -0x4(%ebp),%edi
  103fe4:	89 ec                	mov    %ebp,%esp
  103fe6:	5d                   	pop    %ebp
  103fe7:	c3                   	ret    
{
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0) {
  103fe8:	8d 45 ec             	lea    -0x14(%ebp),%eax
  103feb:	89 44 24 04          	mov    %eax,0x4(%esp)
  103fef:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  103ff6:	e8 f5 fc ff ff       	call   103cf0 <argint>
  103ffb:	85 c0                	test   %eax,%eax
  103ffd:	78 d7                	js     103fd6 <sys_exec+0x26>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  103fff:	8d 7d 98             	lea    -0x68(%ebp),%edi
  104002:	31 db                	xor    %ebx,%ebx
  104004:	c7 44 24 08 50 00 00 	movl   $0x50,0x8(%esp)
  10400b:	00 
  10400c:	31 f6                	xor    %esi,%esi
  10400e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104015:	00 
  104016:	89 3c 24             	mov    %edi,(%esp)
  104019:	e8 22 fa ff ff       	call   103a40 <memset>
  10401e:	eb 27                	jmp    104047 <sys_exec+0x97>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(proc, uarg, &argv[i]) < 0)
  104020:	8d 04 b7             	lea    (%edi,%esi,4),%eax
  104023:	89 44 24 08          	mov    %eax,0x8(%esp)
  104027:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10402d:	89 54 24 04          	mov    %edx,0x4(%esp)
  104031:	89 04 24             	mov    %eax,(%esp)
  104034:	e8 77 fc ff ff       	call   103cb0 <fetchstr>
  104039:	85 c0                	test   %eax,%eax
  10403b:	78 99                	js     103fd6 <sys_exec+0x26>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0) {
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
  10403d:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
  104040:	83 fb 14             	cmp    $0x14,%ebx

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0) {
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
  104043:	89 de                	mov    %ebx,%esi
    if(i >= NELEM(argv))
  104045:	74 8f                	je     103fd6 <sys_exec+0x26>
      return -1;
    if(fetchint(proc, uargv+4*i, (int*)&uarg) < 0)
  104047:	8d 45 e8             	lea    -0x18(%ebp),%eax
  10404a:	89 44 24 08          	mov    %eax,0x8(%esp)
  10404e:	8d 04 9d 00 00 00 00 	lea    0x0(,%ebx,4),%eax
  104055:	03 45 ec             	add    -0x14(%ebp),%eax
  104058:	89 44 24 04          	mov    %eax,0x4(%esp)
  10405c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104062:	89 04 24             	mov    %eax,(%esp)
  104065:	e8 16 fc ff ff       	call   103c80 <fetchint>
  10406a:	85 c0                	test   %eax,%eax
  10406c:	0f 88 64 ff ff ff    	js     103fd6 <sys_exec+0x26>
      return -1;
    if(uarg == 0){
  104072:	8b 55 e8             	mov    -0x18(%ebp),%edx
  104075:	85 d2                	test   %edx,%edx
  104077:	75 a7                	jne    104020 <sys_exec+0x70>
      break;
    }
    if(fetchstr(proc, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
  104079:	8b 45 f0             	mov    -0x10(%ebp),%eax
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(proc, uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
  10407c:	c7 44 9d 98 00 00 00 	movl   $0x0,-0x68(%ebp,%ebx,4)
  104083:	00 
      break;
    }
    if(fetchstr(proc, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
  104084:	89 7c 24 04          	mov    %edi,0x4(%esp)
  104088:	89 04 24             	mov    %eax,(%esp)
  10408b:	e8 90 c8 ff ff       	call   100920 <exec>
  104090:	e9 46 ff ff ff       	jmp    103fdb <sys_exec+0x2b>
  104095:	8d 74 26 00          	lea    0x0(%esi),%esi
  104099:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001040a0 <sys_chdir>:
  return 0;
}

int
sys_chdir(void)
{
  1040a0:	55                   	push   %ebp
  1040a1:	89 e5                	mov    %esp,%ebp
  1040a3:	53                   	push   %ebx
  1040a4:	83 ec 24             	sub    $0x24,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
  1040a7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  1040aa:	89 44 24 04          	mov    %eax,0x4(%esp)
  1040ae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1040b5:	e8 c6 fc ff ff       	call   103d80 <argstr>
  1040ba:	85 c0                	test   %eax,%eax
  1040bc:	79 0b                	jns    1040c9 <sys_chdir+0x29>
    return -1;
  }
  iunlock(ip);
  iput(proc->cwd);
  proc->cwd = ip;
  return 0;
  1040be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1040c3:	83 c4 24             	add    $0x24,%esp
  1040c6:	5b                   	pop    %ebx
  1040c7:	5d                   	pop    %ebp
  1040c8:	c3                   	ret    
sys_chdir(void)
{
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
  1040c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1040cc:	89 04 24             	mov    %eax,(%esp)
  1040cf:	e8 7c dc ff ff       	call   101d50 <namei>
  1040d4:	85 c0                	test   %eax,%eax
  1040d6:	89 c3                	mov    %eax,%ebx
  1040d8:	74 e4                	je     1040be <sys_chdir+0x1e>
    return -1;
  ilock(ip);
  1040da:	89 04 24             	mov    %eax,(%esp)
  1040dd:	e8 de d9 ff ff       	call   101ac0 <ilock>
  if(ip->type != T_DIR){
  1040e2:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
  1040e7:	75 26                	jne    10410f <sys_chdir+0x6f>
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  1040e9:	89 1c 24             	mov    %ebx,(%esp)
  1040ec:	e8 af d5 ff ff       	call   1016a0 <iunlock>
  iput(proc->cwd);
  1040f1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1040f7:	8b 40 68             	mov    0x68(%eax),%eax
  1040fa:	89 04 24             	mov    %eax,(%esp)
  1040fd:	e8 6e d7 ff ff       	call   101870 <iput>
  proc->cwd = ip;
  104102:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104108:	89 58 68             	mov    %ebx,0x68(%eax)
  10410b:	31 c0                	xor    %eax,%eax
  10410d:	eb b4                	jmp    1040c3 <sys_chdir+0x23>

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
    return -1;
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
  10410f:	89 1c 24             	mov    %ebx,(%esp)
  104112:	e8 89 d9 ff ff       	call   101aa0 <iunlockput>
  104117:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10411c:	eb a5                	jmp    1040c3 <sys_chdir+0x23>
  10411e:	66 90                	xchg   %ax,%ax

00104120 <create>:
  return 0;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
  104120:	55                   	push   %ebp
  104121:	89 e5                	mov    %esp,%ebp
  104123:	83 ec 48             	sub    $0x48,%esp
  104126:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  104129:	8b 4d 08             	mov    0x8(%ebp),%ecx
  10412c:	89 7d fc             	mov    %edi,-0x4(%ebp)
  10412f:	89 d7                	mov    %edx,%edi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  104131:	8d 55 e2             	lea    -0x1e(%ebp),%edx
  return 0;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
  104134:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  104137:	31 db                	xor    %ebx,%ebx
  return 0;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
  104139:	89 75 f8             	mov    %esi,-0x8(%ebp)
  10413c:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  10413f:	89 54 24 04          	mov    %edx,0x4(%esp)
  104143:	89 04 24             	mov    %eax,(%esp)
  104146:	e8 e5 db ff ff       	call   101d30 <nameiparent>
  10414b:	85 c0                	test   %eax,%eax
  10414d:	89 c6                	mov    %eax,%esi
  10414f:	74 4b                	je     10419c <create+0x7c>
    return 0;
  ilock(dp);
  104151:	89 04 24             	mov    %eax,(%esp)
  104154:	e8 67 d9 ff ff       	call   101ac0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
  104159:	8d 45 f0             	lea    -0x10(%ebp),%eax
  10415c:	8d 4d e2             	lea    -0x1e(%ebp),%ecx
  10415f:	89 44 24 08          	mov    %eax,0x8(%esp)
  104163:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  104167:	89 34 24             	mov    %esi,(%esp)
  10416a:	e8 31 d4 ff ff       	call   1015a0 <dirlookup>
  10416f:	85 c0                	test   %eax,%eax
  104171:	89 c3                	mov    %eax,%ebx
  104173:	74 3b                	je     1041b0 <create+0x90>
    iunlockput(dp);
  104175:	89 34 24             	mov    %esi,(%esp)
  104178:	e8 23 d9 ff ff       	call   101aa0 <iunlockput>
    ilock(ip);
  10417d:	89 1c 24             	mov    %ebx,(%esp)
  104180:	e8 3b d9 ff ff       	call   101ac0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
  104185:	66 83 ff 02          	cmp    $0x2,%di
  104189:	75 07                	jne    104192 <create+0x72>
  10418b:	66 83 7b 10 02       	cmpw   $0x2,0x10(%ebx)
  104190:	74 0a                	je     10419c <create+0x7c>
      return ip;
    iunlockput(ip);
  104192:	89 1c 24             	mov    %ebx,(%esp)
  104195:	31 db                	xor    %ebx,%ebx
  104197:	e8 04 d9 ff ff       	call   101aa0 <iunlockput>
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);
  return ip;
}
  10419c:	89 d8                	mov    %ebx,%eax
  10419e:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1041a1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1041a4:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1041a7:	89 ec                	mov    %ebp,%esp
  1041a9:	5d                   	pop    %ebp
  1041aa:	c3                   	ret    
  1041ab:	90                   	nop    
  1041ac:	8d 74 26 00          	lea    0x0(%esi),%esi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
  1041b0:	0f bf c7             	movswl %di,%eax
  1041b3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1041b7:	8b 06                	mov    (%esi),%eax
  1041b9:	89 04 24             	mov    %eax,(%esp)
  1041bc:	e8 2f d5 ff ff       	call   1016f0 <ialloc>
  1041c1:	85 c0                	test   %eax,%eax
  1041c3:	89 c3                	mov    %eax,%ebx
  1041c5:	0f 84 9f 00 00 00    	je     10426a <create+0x14a>
    panic("create: ialloc");

  ilock(ip);
  1041cb:	89 04 24             	mov    %eax,(%esp)
  1041ce:	e8 ed d8 ff ff       	call   101ac0 <ilock>
  ip->major = major;
  1041d3:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
  1041d7:	66 89 43 12          	mov    %ax,0x12(%ebx)
  ip->minor = minor;
  1041db:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
  ip->nlink = 1;
  1041df:	66 c7 43 16 01 00    	movw   $0x1,0x16(%ebx)
  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");

  ilock(ip);
  ip->major = major;
  ip->minor = minor;
  1041e5:	66 89 53 14          	mov    %dx,0x14(%ebx)
  ip->nlink = 1;
  iupdate(ip);
  1041e9:	89 1c 24             	mov    %ebx,(%esp)
  1041ec:	e8 1f cf ff ff       	call   101110 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
  1041f1:	66 83 ef 01          	sub    $0x1,%di
  1041f5:	74 24                	je     10421b <create+0xfb>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
  1041f7:	8b 43 04             	mov    0x4(%ebx),%eax
  1041fa:	8d 4d e2             	lea    -0x1e(%ebp),%ecx
  1041fd:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  104201:	89 34 24             	mov    %esi,(%esp)
  104204:	89 44 24 08          	mov    %eax,0x8(%esp)
  104208:	e8 a3 d7 ff ff       	call   1019b0 <dirlink>
  10420d:	85 c0                	test   %eax,%eax
  10420f:	78 65                	js     104276 <create+0x156>
    panic("create: dirlink");

  iunlockput(dp);
  104211:	89 34 24             	mov    %esi,(%esp)
  104214:	e8 87 d8 ff ff       	call   101aa0 <iunlockput>
  104219:	eb 81                	jmp    10419c <create+0x7c>
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
  10421b:	66 83 46 16 01       	addw   $0x1,0x16(%esi)
    iupdate(dp);
  104220:	89 34 24             	mov    %esi,(%esp)
  104223:	e8 e8 ce ff ff       	call   101110 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
  104228:	8b 43 04             	mov    0x4(%ebx),%eax
  10422b:	c7 44 24 04 08 68 10 	movl   $0x106808,0x4(%esp)
  104232:	00 
  104233:	89 1c 24             	mov    %ebx,(%esp)
  104236:	89 44 24 08          	mov    %eax,0x8(%esp)
  10423a:	e8 71 d7 ff ff       	call   1019b0 <dirlink>
  10423f:	85 c0                	test   %eax,%eax
  104241:	78 1b                	js     10425e <create+0x13e>
  104243:	8b 46 04             	mov    0x4(%esi),%eax
  104246:	c7 44 24 04 07 68 10 	movl   $0x106807,0x4(%esp)
  10424d:	00 
  10424e:	89 1c 24             	mov    %ebx,(%esp)
  104251:	89 44 24 08          	mov    %eax,0x8(%esp)
  104255:	e8 56 d7 ff ff       	call   1019b0 <dirlink>
  10425a:	85 c0                	test   %eax,%eax
  10425c:	79 99                	jns    1041f7 <create+0xd7>
      panic("create dots");
  10425e:	c7 04 24 0a 68 10 00 	movl   $0x10680a,(%esp)
  104265:	e8 16 c6 ff ff       	call   100880 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
  10426a:	c7 04 24 f8 67 10 00 	movl   $0x1067f8,(%esp)
  104271:	e8 0a c6 ff ff       	call   100880 <panic>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
  104276:	c7 04 24 16 68 10 00 	movl   $0x106816,(%esp)
  10427d:	e8 fe c5 ff ff       	call   100880 <panic>
  104282:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  104289:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00104290 <sys_mknod>:
  return 0;
}

int
sys_mknod(void)
{
  104290:	55                   	push   %ebp
  104291:	89 e5                	mov    %esp,%ebp
  104293:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
  104296:	8d 45 fc             	lea    -0x4(%ebp),%eax
  104299:	89 44 24 04          	mov    %eax,0x4(%esp)
  10429d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1042a4:	e8 d7 fa ff ff       	call   103d80 <argstr>
  1042a9:	85 c0                	test   %eax,%eax
  1042ab:	79 07                	jns    1042b4 <sys_mknod+0x24>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0)
    return -1;
  iunlockput(ip);
  return 0;
}
  1042ad:	c9                   	leave  
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0)
    return -1;
  iunlockput(ip);
  return 0;
  1042ae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1042b3:	c3                   	ret    
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
  1042b4:	8d 45 f8             	lea    -0x8(%ebp),%eax
  1042b7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1042bb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1042c2:	e8 29 fa ff ff       	call   103cf0 <argint>
  1042c7:	85 c0                	test   %eax,%eax
  1042c9:	78 e2                	js     1042ad <sys_mknod+0x1d>
  1042cb:	8d 45 f4             	lea    -0xc(%ebp),%eax
  1042ce:	89 44 24 04          	mov    %eax,0x4(%esp)
  1042d2:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1042d9:	e8 12 fa ff ff       	call   103cf0 <argint>
  1042de:	85 c0                	test   %eax,%eax
  1042e0:	78 cb                	js     1042ad <sys_mknod+0x1d>
  1042e2:	0f bf 55 f4          	movswl -0xc(%ebp),%edx
  1042e6:	0f bf 4d f8          	movswl -0x8(%ebp),%ecx
  1042ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1042ed:	89 14 24             	mov    %edx,(%esp)
  1042f0:	ba 03 00 00 00       	mov    $0x3,%edx
  1042f5:	e8 26 fe ff ff       	call   104120 <create>
  1042fa:	85 c0                	test   %eax,%eax
  1042fc:	74 af                	je     1042ad <sys_mknod+0x1d>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0)
    return -1;
  iunlockput(ip);
  1042fe:	89 04 24             	mov    %eax,(%esp)
  104301:	e8 9a d7 ff ff       	call   101aa0 <iunlockput>
  104306:	31 c0                	xor    %eax,%eax
  return 0;
}
  104308:	c9                   	leave  
  104309:	c3                   	ret    
  10430a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104310 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
  104310:	55                   	push   %ebp
  104311:	89 e5                	mov    %esp,%ebp
  104313:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0)
  104316:	8d 45 fc             	lea    -0x4(%ebp),%eax
  104319:	89 44 24 04          	mov    %eax,0x4(%esp)
  10431d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104324:	e8 57 fa ff ff       	call   103d80 <argstr>
  104329:	85 c0                	test   %eax,%eax
  10432b:	79 07                	jns    104334 <sys_mkdir+0x24>
    return -1;
  iunlockput(ip);
  return 0;
}
  10432d:	c9                   	leave  
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0)
    return -1;
  iunlockput(ip);
  return 0;
  10432e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104333:	c3                   	ret    
sys_mkdir(void)
{
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0)
  104334:	8b 45 fc             	mov    -0x4(%ebp),%eax
  104337:	31 c9                	xor    %ecx,%ecx
  104339:	ba 01 00 00 00       	mov    $0x1,%edx
  10433e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104345:	e8 d6 fd ff ff       	call   104120 <create>
  10434a:	85 c0                	test   %eax,%eax
  10434c:	74 df                	je     10432d <sys_mkdir+0x1d>
    return -1;
  iunlockput(ip);
  10434e:	89 04 24             	mov    %eax,(%esp)
  104351:	e8 4a d7 ff ff       	call   101aa0 <iunlockput>
  104356:	31 c0                	xor    %eax,%eax
  return 0;
}
  104358:	c9                   	leave  
  104359:	c3                   	ret    
  10435a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104360 <sys_link>:
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  104360:	55                   	push   %ebp
  104361:	89 e5                	mov    %esp,%ebp
  104363:	83 ec 38             	sub    $0x38,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
  104366:	8d 45 ec             	lea    -0x14(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  104369:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  10436c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  10436f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
  104372:	89 44 24 04          	mov    %eax,0x4(%esp)
  104376:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10437d:	e8 fe f9 ff ff       	call   103d80 <argstr>
  104382:	85 c0                	test   %eax,%eax
  104384:	79 12                	jns    104398 <sys_link+0x38>
bad:
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return -1;
  104386:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  10438b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  10438e:	8b 75 f8             	mov    -0x8(%ebp),%esi
  104391:	8b 7d fc             	mov    -0x4(%ebp),%edi
  104394:	89 ec                	mov    %ebp,%esp
  104396:	5d                   	pop    %ebp
  104397:	c3                   	ret    
sys_link(void)
{
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
  104398:	8d 45 f0             	lea    -0x10(%ebp),%eax
  10439b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10439f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1043a6:	e8 d5 f9 ff ff       	call   103d80 <argstr>
  1043ab:	85 c0                	test   %eax,%eax
  1043ad:	78 d7                	js     104386 <sys_link+0x26>
    return -1;
  if((ip = namei(old)) == 0)
  1043af:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1043b2:	89 04 24             	mov    %eax,(%esp)
  1043b5:	e8 96 d9 ff ff       	call   101d50 <namei>
  1043ba:	85 c0                	test   %eax,%eax
  1043bc:	89 c3                	mov    %eax,%ebx
  1043be:	74 c6                	je     104386 <sys_link+0x26>
    return -1;
  ilock(ip);
  1043c0:	89 04 24             	mov    %eax,(%esp)
  1043c3:	e8 f8 d6 ff ff       	call   101ac0 <ilock>
  if(ip->type == T_DIR){
  1043c8:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
  1043cd:	74 58                	je     104427 <sys_link+0xc7>
    iunlockput(ip);
    return -1;
  }
  ip->nlink++;
  1043cf:	66 83 43 16 01       	addw   $0x1,0x16(%ebx)
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
  1043d4:	8d 7d de             	lea    -0x22(%ebp),%edi
  if(ip->type == T_DIR){
    iunlockput(ip);
    return -1;
  }
  ip->nlink++;
  iupdate(ip);
  1043d7:	89 1c 24             	mov    %ebx,(%esp)
  1043da:	e8 31 cd ff ff       	call   101110 <iupdate>
  iunlock(ip);
  1043df:	89 1c 24             	mov    %ebx,(%esp)
  1043e2:	e8 b9 d2 ff ff       	call   1016a0 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
  1043e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1043ea:	89 7c 24 04          	mov    %edi,0x4(%esp)
  1043ee:	89 04 24             	mov    %eax,(%esp)
  1043f1:	e8 3a d9 ff ff       	call   101d30 <nameiparent>
  1043f6:	85 c0                	test   %eax,%eax
  1043f8:	89 c6                	mov    %eax,%esi
  1043fa:	74 16                	je     104412 <sys_link+0xb2>
    goto bad;
  ilock(dp);
  1043fc:	89 04 24             	mov    %eax,(%esp)
  1043ff:	e8 bc d6 ff ff       	call   101ac0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
  104404:	8b 06                	mov    (%esi),%eax
  104406:	3b 03                	cmp    (%ebx),%eax
  104408:	74 2f                	je     104439 <sys_link+0xd9>
    iunlockput(dp);
  10440a:	89 34 24             	mov    %esi,(%esp)
  10440d:	e8 8e d6 ff ff       	call   101aa0 <iunlockput>
  iunlockput(dp);
  iput(ip);
  return 0;

bad:
  ilock(ip);
  104412:	89 1c 24             	mov    %ebx,(%esp)
  104415:	e8 a6 d6 ff ff       	call   101ac0 <ilock>
  ip->nlink--;
  10441a:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  iupdate(ip);
  10441f:	89 1c 24             	mov    %ebx,(%esp)
  104422:	e8 e9 cc ff ff       	call   101110 <iupdate>
  iunlockput(ip);
  104427:	89 1c 24             	mov    %ebx,(%esp)
  10442a:	e8 71 d6 ff ff       	call   101aa0 <iunlockput>
  10442f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104434:	e9 52 ff ff ff       	jmp    10438b <sys_link+0x2b>
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
  104439:	8b 43 04             	mov    0x4(%ebx),%eax
  10443c:	89 7c 24 04          	mov    %edi,0x4(%esp)
  104440:	89 34 24             	mov    %esi,(%esp)
  104443:	89 44 24 08          	mov    %eax,0x8(%esp)
  104447:	e8 64 d5 ff ff       	call   1019b0 <dirlink>
  10444c:	85 c0                	test   %eax,%eax
  10444e:	78 ba                	js     10440a <sys_link+0xaa>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
  104450:	89 34 24             	mov    %esi,(%esp)
  104453:	e8 48 d6 ff ff       	call   101aa0 <iunlockput>
  iput(ip);
  104458:	89 1c 24             	mov    %ebx,(%esp)
  10445b:	e8 10 d4 ff ff       	call   101870 <iput>
  104460:	31 c0                	xor    %eax,%eax
  104462:	e9 24 ff ff ff       	jmp    10438b <sys_link+0x2b>
  104467:	89 f6                	mov    %esi,%esi
  104469:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00104470 <sys_open>:
  return ip;
}

int
sys_open(void)
{
  104470:	55                   	push   %ebp
  104471:	89 e5                	mov    %esp,%ebp
  104473:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  104476:	8d 45 f0             	lea    -0x10(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
  104479:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  10447c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  10447f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  104482:	89 44 24 04          	mov    %eax,0x4(%esp)
  104486:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10448d:	e8 ee f8 ff ff       	call   103d80 <argstr>
  104492:	85 c0                	test   %eax,%eax
  104494:	79 14                	jns    1044aa <sys_open+0x3a>
  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
  104496:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
  10449b:	89 d8                	mov    %ebx,%eax
  10449d:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1044a0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1044a3:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1044a6:	89 ec                	mov    %ebp,%esp
  1044a8:	5d                   	pop    %ebp
  1044a9:	c3                   	ret    
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  1044aa:	8d 45 ec             	lea    -0x14(%ebp),%eax
  1044ad:	89 44 24 04          	mov    %eax,0x4(%esp)
  1044b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1044b8:	e8 33 f8 ff ff       	call   103cf0 <argint>
  1044bd:	85 c0                	test   %eax,%eax
  1044bf:	78 d5                	js     104496 <sys_open+0x26>
    return -1;
  if(omode & O_CREATE){
  1044c1:	f6 45 ed 02          	testb  $0x2,-0x13(%ebp)
  1044c5:	75 6b                	jne    104532 <sys_open+0xc2>
    if((ip = create(path, T_FILE, 0, 0)) == 0)
      return -1;
  } else {
    if((ip = namei(path)) == 0)
  1044c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1044ca:	89 04 24             	mov    %eax,(%esp)
  1044cd:	e8 7e d8 ff ff       	call   101d50 <namei>
  1044d2:	85 c0                	test   %eax,%eax
  1044d4:	89 c7                	mov    %eax,%edi
  1044d6:	74 be                	je     104496 <sys_open+0x26>
      return -1;
    ilock(ip);
  1044d8:	89 04 24             	mov    %eax,(%esp)
  1044db:	e8 e0 d5 ff ff       	call   101ac0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
  1044e0:	66 83 7f 10 01       	cmpw   $0x1,0x10(%edi)
  1044e5:	0f 84 82 00 00 00    	je     10456d <sys_open+0xfd>
      iunlockput(ip);
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
  1044eb:	e8 60 c9 ff ff       	call   100e50 <filealloc>
  1044f0:	85 c0                	test   %eax,%eax
  1044f2:	89 c6                	mov    %eax,%esi
  1044f4:	74 65                	je     10455b <sys_open+0xeb>
  1044f6:	e8 45 f9 ff ff       	call   103e40 <fdalloc>
  1044fb:	85 c0                	test   %eax,%eax
  1044fd:	89 c3                	mov    %eax,%ebx
  1044ff:	78 52                	js     104553 <sys_open+0xe3>
    if(f)
      fileclose(f);
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  104501:	89 3c 24             	mov    %edi,(%esp)
  104504:	e8 97 d1 ff ff       	call   1016a0 <iunlock>

  f->type = FD_INODE;
  104509:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f->ip = ip;
  10450f:	89 7e 10             	mov    %edi,0x10(%esi)
  f->off = 0;
  104512:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
  104519:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10451c:	83 f0 01             	xor    $0x1,%eax
  10451f:	83 e0 01             	and    $0x1,%eax
  104522:	88 46 08             	mov    %al,0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  104525:	f6 45 ec 03          	testb  $0x3,-0x14(%ebp)
  104529:	0f 95 46 09          	setne  0x9(%esi)
  10452d:	e9 69 ff ff ff       	jmp    10449b <sys_open+0x2b>
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
    return -1;
  if(omode & O_CREATE){
    if((ip = create(path, T_FILE, 0, 0)) == 0)
  104532:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104535:	31 c9                	xor    %ecx,%ecx
  104537:	ba 02 00 00 00       	mov    $0x2,%edx
  10453c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104543:	e8 d8 fb ff ff       	call   104120 <create>
  104548:	85 c0                	test   %eax,%eax
  10454a:	89 c7                	mov    %eax,%edi
  10454c:	75 9d                	jne    1044eb <sys_open+0x7b>
  10454e:	e9 43 ff ff ff       	jmp    104496 <sys_open+0x26>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
  104553:	89 34 24             	mov    %esi,(%esp)
  104556:	e8 65 c9 ff ff       	call   100ec0 <fileclose>
    iunlockput(ip);
  10455b:	89 3c 24             	mov    %edi,(%esp)
  10455e:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  104563:	e8 38 d5 ff ff       	call   101aa0 <iunlockput>
  104568:	e9 2e ff ff ff       	jmp    10449b <sys_open+0x2b>
      return -1;
  } else {
    if((ip = namei(path)) == 0)
      return -1;
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
  10456d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104570:	85 c0                	test   %eax,%eax
  104572:	0f 84 73 ff ff ff    	je     1044eb <sys_open+0x7b>
  104578:	eb e1                	jmp    10455b <sys_open+0xeb>
  10457a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104580 <sys_unlink>:
  return 1;
}

int
sys_unlink(void)
{
  104580:	55                   	push   %ebp
  104581:	89 e5                	mov    %esp,%ebp
  104583:	83 ec 68             	sub    $0x68,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
  104586:	8d 45 f0             	lea    -0x10(%ebp),%eax
  return 1;
}

int
sys_unlink(void)
{
  104589:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  10458c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  10458f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
  104592:	89 44 24 04          	mov    %eax,0x4(%esp)
  104596:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10459d:	e8 de f7 ff ff       	call   103d80 <argstr>
  1045a2:	85 c0                	test   %eax,%eax
  1045a4:	79 12                	jns    1045b8 <sys_unlink+0x38>
  iunlockput(dp);

  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return 0;
  1045a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1045ab:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1045ae:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1045b1:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1045b4:	89 ec                	mov    %ebp,%esp
  1045b6:	5d                   	pop    %ebp
  1045b7:	c3                   	ret    
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
  if((dp = nameiparent(path, name)) == 0)
  1045b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1045bb:	8d 5d de             	lea    -0x22(%ebp),%ebx
  1045be:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1045c2:	89 04 24             	mov    %eax,(%esp)
  1045c5:	e8 66 d7 ff ff       	call   101d30 <nameiparent>
  1045ca:	85 c0                	test   %eax,%eax
  1045cc:	89 c7                	mov    %eax,%edi
  1045ce:	74 d6                	je     1045a6 <sys_unlink+0x26>
    return -1;
  ilock(dp);
  1045d0:	89 04 24             	mov    %eax,(%esp)
  1045d3:	e8 e8 d4 ff ff       	call   101ac0 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0){
  1045d8:	c7 44 24 04 08 68 10 	movl   $0x106808,0x4(%esp)
  1045df:	00 
  1045e0:	89 1c 24             	mov    %ebx,(%esp)
  1045e3:	e8 88 cf ff ff       	call   101570 <namecmp>
  1045e8:	85 c0                	test   %eax,%eax
  1045ea:	74 14                	je     104600 <sys_unlink+0x80>
  1045ec:	c7 44 24 04 07 68 10 	movl   $0x106807,0x4(%esp)
  1045f3:	00 
  1045f4:	89 1c 24             	mov    %ebx,(%esp)
  1045f7:	e8 74 cf ff ff       	call   101570 <namecmp>
  1045fc:	85 c0                	test   %eax,%eax
  1045fe:	75 0f                	jne    10460f <sys_unlink+0x8f>

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
    iunlockput(dp);
  104600:	89 3c 24             	mov    %edi,(%esp)
  104603:	e8 98 d4 ff ff       	call   101aa0 <iunlockput>
  104608:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10460d:	eb 9c                	jmp    1045ab <sys_unlink+0x2b>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0){
    iunlockput(dp);
    return -1;
  }

  if((ip = dirlookup(dp, name, &off)) == 0){
  10460f:	8d 45 ec             	lea    -0x14(%ebp),%eax
  104612:	89 44 24 08          	mov    %eax,0x8(%esp)
  104616:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  10461a:	89 3c 24             	mov    %edi,(%esp)
  10461d:	e8 7e cf ff ff       	call   1015a0 <dirlookup>
  104622:	85 c0                	test   %eax,%eax
  104624:	89 c6                	mov    %eax,%esi
  104626:	74 d8                	je     104600 <sys_unlink+0x80>
    iunlockput(dp);
    return -1;
  }
  ilock(ip);
  104628:	89 04 24             	mov    %eax,(%esp)
  10462b:	e8 90 d4 ff ff       	call   101ac0 <ilock>

  if(ip->nlink < 1)
  104630:	66 83 7e 16 00       	cmpw   $0x0,0x16(%esi)
  104635:	0f 8e e7 00 00 00    	jle    104722 <sys_unlink+0x1a2>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
  10463b:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
  104640:	75 53                	jne    104695 <sys_unlink+0x115>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
  104642:	83 7e 18 20          	cmpl   $0x20,0x18(%esi)
  104646:	76 4d                	jbe    104695 <sys_unlink+0x115>
  104648:	bb 20 00 00 00       	mov    $0x20,%ebx
  10464d:	8d 76 00             	lea    0x0(%esi),%esi
  104650:	eb 08                	jmp    10465a <sys_unlink+0xda>
  104652:	83 c3 10             	add    $0x10,%ebx
  104655:	39 5e 18             	cmp    %ebx,0x18(%esi)
  104658:	76 3b                	jbe    104695 <sys_unlink+0x115>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  10465a:	8d 45 be             	lea    -0x42(%ebp),%eax
  10465d:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  104664:	00 
  104665:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  104669:	89 44 24 04          	mov    %eax,0x4(%esp)
  10466d:	89 34 24             	mov    %esi,(%esp)
  104670:	e8 eb cd ff ff       	call   101460 <readi>
  104675:	83 f8 10             	cmp    $0x10,%eax
  104678:	0f 85 8c 00 00 00    	jne    10470a <sys_unlink+0x18a>
      panic("isdirempty: readi");
    if(de.inum != 0)
  10467e:	66 83 7d be 00       	cmpw   $0x0,-0x42(%ebp)
  104683:	74 cd                	je     104652 <sys_unlink+0xd2>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
  104685:	89 34 24             	mov    %esi,(%esp)
  104688:	e8 13 d4 ff ff       	call   101aa0 <iunlockput>
  10468d:	8d 76 00             	lea    0x0(%esi),%esi
  104690:	e9 6b ff ff ff       	jmp    104600 <sys_unlink+0x80>
    iunlockput(dp);
    return -1;
  }

  memset(&de, 0, sizeof(de));
  104695:	8d 5d ce             	lea    -0x32(%ebp),%ebx
  104698:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  10469f:	00 
  1046a0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1046a7:	00 
  1046a8:	89 1c 24             	mov    %ebx,(%esp)
  1046ab:	e8 90 f3 ff ff       	call   103a40 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  1046b0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1046b3:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  1046ba:	00 
  1046bb:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1046bf:	89 3c 24             	mov    %edi,(%esp)
  1046c2:	89 44 24 08          	mov    %eax,0x8(%esp)
  1046c6:	e8 65 cc ff ff       	call   101330 <writei>
  1046cb:	83 f8 10             	cmp    $0x10,%eax
  1046ce:	75 46                	jne    104716 <sys_unlink+0x196>
    panic("unlink: writei");
  if(ip->type == T_DIR){
  1046d0:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
  1046d5:	74 24                	je     1046fb <sys_unlink+0x17b>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
  1046d7:	89 3c 24             	mov    %edi,(%esp)
  1046da:	e8 c1 d3 ff ff       	call   101aa0 <iunlockput>

  ip->nlink--;
  1046df:	66 83 6e 16 01       	subw   $0x1,0x16(%esi)
  iupdate(ip);
  1046e4:	89 34 24             	mov    %esi,(%esp)
  1046e7:	e8 24 ca ff ff       	call   101110 <iupdate>
  iunlockput(ip);
  1046ec:	89 34 24             	mov    %esi,(%esp)
  1046ef:	e8 ac d3 ff ff       	call   101aa0 <iunlockput>
  1046f4:	31 c0                	xor    %eax,%eax
  1046f6:	e9 b0 fe ff ff       	jmp    1045ab <sys_unlink+0x2b>

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
  1046fb:	66 83 6f 16 01       	subw   $0x1,0x16(%edi)
    iupdate(dp);
  104700:	89 3c 24             	mov    %edi,(%esp)
  104703:	e8 08 ca ff ff       	call   101110 <iupdate>
  104708:	eb cd                	jmp    1046d7 <sys_unlink+0x157>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
  10470a:	c7 04 24 38 68 10 00 	movl   $0x106838,(%esp)
  104711:	e8 6a c1 ff ff       	call   100880 <panic>
    return -1;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  104716:	c7 04 24 4a 68 10 00 	movl   $0x10684a,(%esp)
  10471d:	e8 5e c1 ff ff       	call   100880 <panic>
    return -1;
  }
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  104722:	c7 04 24 26 68 10 00 	movl   $0x106826,(%esp)
  104729:	e8 52 c1 ff ff       	call   100880 <panic>
  10472e:	66 90                	xchg   %ax,%ax

00104730 <sys_fstat>:
  return 0;
}

int
sys_fstat(void)
{
  104730:	55                   	push   %ebp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  104731:	31 d2                	xor    %edx,%edx
  return 0;
}

int
sys_fstat(void)
{
  104733:	89 e5                	mov    %esp,%ebp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  104735:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
  104737:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  10473a:	8d 4d fc             	lea    -0x4(%ebp),%ecx
  10473d:	e8 ce f7 ff ff       	call   103f10 <argfd>
  104742:	85 c0                	test   %eax,%eax
  104744:	79 07                	jns    10474d <sys_fstat+0x1d>
    return -1;
  return filestat(f, st);
}
  104746:	c9                   	leave  
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
  return filestat(f, st);
  104747:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  10474c:	c3                   	ret    
sys_fstat(void)
{
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  10474d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  104750:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
  104757:	00 
  104758:	89 44 24 04          	mov    %eax,0x4(%esp)
  10475c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104763:	e8 c8 f5 ff ff       	call   103d30 <argptr>
  104768:	85 c0                	test   %eax,%eax
  10476a:	78 da                	js     104746 <sys_fstat+0x16>
    return -1;
  return filestat(f, st);
  10476c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10476f:	89 44 24 04          	mov    %eax,0x4(%esp)
  104773:	8b 45 fc             	mov    -0x4(%ebp),%eax
  104776:	89 04 24             	mov    %eax,(%esp)
  104779:	e8 32 c6 ff ff       	call   100db0 <filestat>
}
  10477e:	c9                   	leave  
  10477f:	c3                   	ret    

00104780 <sys_write>:
  return fileread(f, p, n);
}

int
sys_write(void)
{
  104780:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  104781:	31 d2                	xor    %edx,%edx
  return fileread(f, p, n);
}

int
sys_write(void)
{
  104783:	89 e5                	mov    %esp,%ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  104785:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
  104787:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  10478a:	8d 4d fc             	lea    -0x4(%ebp),%ecx
  10478d:	e8 7e f7 ff ff       	call   103f10 <argfd>
  104792:	85 c0                	test   %eax,%eax
  104794:	79 07                	jns    10479d <sys_write+0x1d>
    return -1;
  return filewrite(f, p, n);
}
  104796:	c9                   	leave  
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
  return filewrite(f, p, n);
  104797:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  10479c:	c3                   	ret    
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  10479d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  1047a0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1047a4:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1047ab:	e8 40 f5 ff ff       	call   103cf0 <argint>
  1047b0:	85 c0                	test   %eax,%eax
  1047b2:	78 e2                	js     104796 <sys_write+0x16>
  1047b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1047b7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1047be:	89 44 24 08          	mov    %eax,0x8(%esp)
  1047c2:	8d 45 f4             	lea    -0xc(%ebp),%eax
  1047c5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1047c9:	e8 62 f5 ff ff       	call   103d30 <argptr>
  1047ce:	85 c0                	test   %eax,%eax
  1047d0:	78 c4                	js     104796 <sys_write+0x16>
    return -1;
  return filewrite(f, p, n);
  1047d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1047d5:	89 44 24 08          	mov    %eax,0x8(%esp)
  1047d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1047dc:	89 44 24 04          	mov    %eax,0x4(%esp)
  1047e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1047e3:	89 04 24             	mov    %eax,(%esp)
  1047e6:	e8 85 c4 ff ff       	call   100c70 <filewrite>
}
  1047eb:	c9                   	leave  
  1047ec:	c3                   	ret    
  1047ed:	8d 76 00             	lea    0x0(%esi),%esi

001047f0 <sys_read>:
  return fd;
}

int
sys_read(void)
{
  1047f0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  1047f1:	31 d2                	xor    %edx,%edx
  return fd;
}

int
sys_read(void)
{
  1047f3:	89 e5                	mov    %esp,%ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  1047f5:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
  1047f7:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  1047fa:	8d 4d fc             	lea    -0x4(%ebp),%ecx
  1047fd:	e8 0e f7 ff ff       	call   103f10 <argfd>
  104802:	85 c0                	test   %eax,%eax
  104804:	79 07                	jns    10480d <sys_read+0x1d>
    return -1;
  return fileread(f, p, n);
}
  104806:	c9                   	leave  
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
  return fileread(f, p, n);
  104807:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  10480c:	c3                   	ret    
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  10480d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  104810:	89 44 24 04          	mov    %eax,0x4(%esp)
  104814:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  10481b:	e8 d0 f4 ff ff       	call   103cf0 <argint>
  104820:	85 c0                	test   %eax,%eax
  104822:	78 e2                	js     104806 <sys_read+0x16>
  104824:	8b 45 f8             	mov    -0x8(%ebp),%eax
  104827:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  10482e:	89 44 24 08          	mov    %eax,0x8(%esp)
  104832:	8d 45 f4             	lea    -0xc(%ebp),%eax
  104835:	89 44 24 04          	mov    %eax,0x4(%esp)
  104839:	e8 f2 f4 ff ff       	call   103d30 <argptr>
  10483e:	85 c0                	test   %eax,%eax
  104840:	78 c4                	js     104806 <sys_read+0x16>
    return -1;
  return fileread(f, p, n);
  104842:	8b 45 f8             	mov    -0x8(%ebp),%eax
  104845:	89 44 24 08          	mov    %eax,0x8(%esp)
  104849:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10484c:	89 44 24 04          	mov    %eax,0x4(%esp)
  104850:	8b 45 fc             	mov    -0x4(%ebp),%eax
  104853:	89 04 24             	mov    %eax,(%esp)
  104856:	e8 b5 c4 ff ff       	call   100d10 <fileread>
}
  10485b:	c9                   	leave  
  10485c:	c3                   	ret    
  10485d:	8d 76 00             	lea    0x0(%esi),%esi

00104860 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
  104860:	55                   	push   %ebp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
  104861:	31 d2                	xor    %edx,%edx
  return -1;
}

int
sys_dup(void)
{
  104863:	89 e5                	mov    %esp,%ebp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
  104865:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
  104867:	53                   	push   %ebx
  104868:	83 ec 14             	sub    $0x14,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
  10486b:	8d 4d f8             	lea    -0x8(%ebp),%ecx
  10486e:	e8 9d f6 ff ff       	call   103f10 <argfd>
  104873:	85 c0                	test   %eax,%eax
  104875:	79 0d                	jns    104884 <sys_dup+0x24>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
  104877:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
  10487c:	89 d8                	mov    %ebx,%eax
  10487e:	83 c4 14             	add    $0x14,%esp
  104881:	5b                   	pop    %ebx
  104882:	5d                   	pop    %ebp
  104883:	c3                   	ret    
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
  104884:	8b 45 f8             	mov    -0x8(%ebp),%eax
  104887:	e8 b4 f5 ff ff       	call   103e40 <fdalloc>
  10488c:	85 c0                	test   %eax,%eax
  10488e:	89 c3                	mov    %eax,%ebx
  104890:	78 e5                	js     104877 <sys_dup+0x17>
    return -1;
  filedup(f);
  104892:	8b 45 f8             	mov    -0x8(%ebp),%eax
  104895:	89 04 24             	mov    %eax,(%esp)
  104898:	e8 63 c5 ff ff       	call   100e00 <filedup>
  10489d:	eb dd                	jmp    10487c <sys_dup+0x1c>
  10489f:	90                   	nop    

001048a0 <sys_getpid>:
}

int
sys_getpid(void)
{
  return proc->pid;
  1048a0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return kill(pid);
}

int
sys_getpid(void)
{
  1048a6:	55                   	push   %ebp
  1048a7:	89 e5                	mov    %esp,%ebp
  return proc->pid;
}
  1048a9:	5d                   	pop    %ebp
}

int
sys_getpid(void)
{
  return proc->pid;
  1048aa:	8b 40 10             	mov    0x10(%eax),%eax
}
  1048ad:	c3                   	ret    
  1048ae:	66 90                	xchg   %ax,%ax

001048b0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since boot.
int
sys_uptime(void)
{
  1048b0:	55                   	push   %ebp
  1048b1:	89 e5                	mov    %esp,%ebp
  1048b3:	53                   	push   %ebx
  1048b4:	83 ec 04             	sub    $0x4,%esp
  uint xticks;
  
  acquire(&tickslock);
  1048b7:	c7 04 24 e0 cf 10 00 	movl   $0x10cfe0,(%esp)
  1048be:	e8 0d f1 ff ff       	call   1039d0 <acquire>
  xticks = ticks;
  1048c3:	8b 1d 20 d8 10 00    	mov    0x10d820,%ebx
  release(&tickslock);
  1048c9:	c7 04 24 e0 cf 10 00 	movl   $0x10cfe0,(%esp)
  1048d0:	e8 bb f0 ff ff       	call   103990 <release>
  return xticks;
}
  1048d5:	83 c4 04             	add    $0x4,%esp
  1048d8:	89 d8                	mov    %ebx,%eax
  1048da:	5b                   	pop    %ebx
  1048db:	5d                   	pop    %ebp
  1048dc:	c3                   	ret    
  1048dd:	8d 76 00             	lea    0x0(%esi),%esi

001048e0 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
  1048e0:	55                   	push   %ebp
  1048e1:	89 e5                	mov    %esp,%ebp
  1048e3:	53                   	push   %ebx
  1048e4:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
  1048e7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  1048ea:	89 44 24 04          	mov    %eax,0x4(%esp)
  1048ee:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1048f5:	e8 f6 f3 ff ff       	call   103cf0 <argint>
  1048fa:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  1048ff:	85 c0                	test   %eax,%eax
  104901:	78 5b                	js     10495e <sys_sleep+0x7e>
    return -1;
  acquire(&tickslock);
  104903:	c7 04 24 e0 cf 10 00 	movl   $0x10cfe0,(%esp)
  10490a:	e8 c1 f0 ff ff       	call   1039d0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
  10490f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  uint ticks0;
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  104912:	8b 1d 20 d8 10 00    	mov    0x10d820,%ebx
  while(ticks - ticks0 < n){
  104918:	85 d2                	test   %edx,%edx
  10491a:	75 24                	jne    104940 <sys_sleep+0x60>
  10491c:	eb 48                	jmp    104966 <sys_sleep+0x86>
  10491e:	66 90                	xchg   %ax,%ax
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  104920:	c7 44 24 04 e0 cf 10 	movl   $0x10cfe0,0x4(%esp)
  104927:	00 
  104928:	c7 04 24 20 d8 10 00 	movl   $0x10d820,(%esp)
  10492f:	e8 7c e7 ff ff       	call   1030b0 <sleep>
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
  104934:	a1 20 d8 10 00       	mov    0x10d820,%eax
  104939:	29 d8                	sub    %ebx,%eax
  10493b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  10493e:	73 26                	jae    104966 <sys_sleep+0x86>
    if(proc->killed){
  104940:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104946:	8b 40 24             	mov    0x24(%eax),%eax
  104949:	85 c0                	test   %eax,%eax
  10494b:	74 d3                	je     104920 <sys_sleep+0x40>
      release(&tickslock);
  10494d:	c7 04 24 e0 cf 10 00 	movl   $0x10cfe0,(%esp)
  104954:	e8 37 f0 ff ff       	call   103990 <release>
  104959:	ba ff ff ff ff       	mov    $0xffffffff,%edx
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
  10495e:	83 c4 24             	add    $0x24,%esp
  104961:	89 d0                	mov    %edx,%eax
  104963:	5b                   	pop    %ebx
  104964:	5d                   	pop    %ebp
  104965:	c3                   	ret    
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  104966:	c7 04 24 e0 cf 10 00 	movl   $0x10cfe0,(%esp)
  10496d:	e8 1e f0 ff ff       	call   103990 <release>
  return 0;
}
  104972:	83 c4 24             	add    $0x24,%esp
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  104975:	31 d2                	xor    %edx,%edx
  return 0;
}
  104977:	5b                   	pop    %ebx
  104978:	89 d0                	mov    %edx,%eax
  10497a:	5d                   	pop    %ebp
  10497b:	c3                   	ret    
  10497c:	8d 74 26 00          	lea    0x0(%esi),%esi

00104980 <sys_sbrk>:
  return proc->pid;
}

int
sys_sbrk(void)
{
  104980:	55                   	push   %ebp
  104981:	89 e5                	mov    %esp,%ebp
  104983:	53                   	push   %ebx
  104984:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
  104987:	8d 45 f8             	lea    -0x8(%ebp),%eax
  10498a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10498e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104995:	e8 56 f3 ff ff       	call   103cf0 <argint>
  10499a:	85 c0                	test   %eax,%eax
  10499c:	79 0d                	jns    1049ab <sys_sbrk+0x2b>
    return -1;
  addr = proc->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
  10499e:	ba ff ff ff ff       	mov    $0xffffffff,%edx
}
  1049a3:	83 c4 24             	add    $0x24,%esp
  1049a6:	89 d0                	mov    %edx,%eax
  1049a8:	5b                   	pop    %ebx
  1049a9:	5d                   	pop    %ebp
  1049aa:	c3                   	ret    
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
  1049ab:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1049b1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
  1049b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1049b6:	89 04 24             	mov    %eax,(%esp)
  1049b9:	e8 42 ec ff ff       	call   103600 <growproc>
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
  1049be:	89 da                	mov    %ebx,%edx
  if(growproc(n) < 0)
  1049c0:	85 c0                	test   %eax,%eax
  1049c2:	79 df                	jns    1049a3 <sys_sbrk+0x23>
  1049c4:	eb d8                	jmp    10499e <sys_sbrk+0x1e>
  1049c6:	8d 76 00             	lea    0x0(%esi),%esi
  1049c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001049d0 <sys_kill>:
  return wait();
}

int
sys_kill(void)
{
  1049d0:	55                   	push   %ebp
  1049d1:	89 e5                	mov    %esp,%ebp
  1049d3:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
  1049d6:	8d 45 fc             	lea    -0x4(%ebp),%eax
  1049d9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1049dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1049e4:	e8 07 f3 ff ff       	call   103cf0 <argint>
  1049e9:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  1049ee:	85 c0                	test   %eax,%eax
  1049f0:	78 0d                	js     1049ff <sys_kill+0x2f>
    return -1;
  return kill(pid);
  1049f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1049f5:	89 04 24             	mov    %eax,(%esp)
  1049f8:	e8 43 e5 ff ff       	call   102f40 <kill>
  1049fd:	89 c2                	mov    %eax,%edx
}
  1049ff:	c9                   	leave  
  104a00:	89 d0                	mov    %edx,%eax
  104a02:	c3                   	ret    
  104a03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00104a10 <sys_wait>:
  return 0;  // not reached
}

int
sys_wait(void)
{
  104a10:	55                   	push   %ebp
  104a11:	89 e5                	mov    %esp,%ebp
  return wait();
}
  104a13:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
  104a14:	e9 47 e8 ff ff       	jmp    103260 <wait>
  104a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00104a20 <sys_exit>:
  return fork();
}

int
sys_exit(void)
{
  104a20:	55                   	push   %ebp
  104a21:	89 e5                	mov    %esp,%ebp
  104a23:	83 ec 08             	sub    $0x8,%esp
  exit();
  104a26:	e8 15 e9 ff ff       	call   103340 <exit>
  return 0;  // not reached
}
  104a2b:	31 c0                	xor    %eax,%eax
  104a2d:	c9                   	leave  
  104a2e:	c3                   	ret    
  104a2f:	90                   	nop    

00104a30 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  104a30:	55                   	push   %ebp
  104a31:	89 e5                	mov    %esp,%ebp
  return fork();
}
  104a33:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
  104a34:	e9 b7 ea ff ff       	jmp    1034f0 <fork>
  104a39:	90                   	nop    
  104a3a:	90                   	nop    
  104a3b:	90                   	nop    
  104a3c:	90                   	nop    
  104a3d:	90                   	nop    
  104a3e:	90                   	nop    
  104a3f:	90                   	nop    

00104a40 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
  104a40:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  104a41:	b8 34 00 00 00       	mov    $0x34,%eax
  104a46:	89 e5                	mov    %esp,%ebp
  104a48:	ba 43 00 00 00       	mov    $0x43,%edx
  104a4d:	83 ec 08             	sub    $0x8,%esp
  104a50:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  picenable(IRQ_TIMER);
  104a51:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
  104a56:	b2 40                	mov    $0x40,%dl
  104a58:	ee                   	out    %al,(%dx)
  104a59:	b8 2e 00 00 00       	mov    $0x2e,%eax
  104a5e:	ee                   	out    %al,(%dx)
  104a5f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104a66:	e8 55 e0 ff ff       	call   102ac0 <picenable>
}
  104a6b:	c9                   	leave  
  104a6c:	c3                   	ret    
  104a6d:	90                   	nop    
  104a6e:	90                   	nop    
  104a6f:	90                   	nop    

00104a70 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
  104a70:	1e                   	push   %ds
  pushl %es
  104a71:	06                   	push   %es
  pushl %fs
  104a72:	0f a0                	push   %fs
  pushl %gs
  104a74:	0f a8                	push   %gs
  pushal
  104a76:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
  104a77:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
  104a7b:	8e d8                	mov    %eax,%ds
  movw %ax, %es
  104a7d:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
  104a7f:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
  104a83:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
  104a85:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
  104a87:	54                   	push   %esp
  call trap
  104a88:	e8 d3 00 00 00       	call   104b60 <trap>
  addl $4, %esp
  104a8d:	83 c4 04             	add    $0x4,%esp

00104a90 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
  104a90:	61                   	popa   
  popl %gs
  104a91:	0f a9                	pop    %gs
  popl %fs
  104a93:	0f a1                	pop    %fs
  popl %es
  104a95:	07                   	pop    %es
  popl %ds
  104a96:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
  104a97:	83 c4 08             	add    $0x8,%esp
  iret
  104a9a:	cf                   	iret   
  104a9b:	90                   	nop    
  104a9c:	90                   	nop    
  104a9d:	90                   	nop    
  104a9e:	90                   	nop    
  104a9f:	90                   	nop    

00104aa0 <idtinit>:
  initlock(&tickslock, "time");
}

void
idtinit(void)
{
  104aa0:	55                   	push   %ebp
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
  104aa1:	b8 20 d0 10 00       	mov    $0x10d020,%eax
  104aa6:	89 e5                	mov    %esp,%ebp
  104aa8:	83 ec 10             	sub    $0x10,%esp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  104aab:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
  104ab1:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
  104ab5:	c1 e8 10             	shr    $0x10,%eax
  104ab8:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
  104abc:	8d 45 fa             	lea    -0x6(%ebp),%eax
  104abf:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
  104ac2:	c9                   	leave  
  104ac3:	c3                   	ret    
  104ac4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104aca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00104ad0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
  104ad0:	55                   	push   %ebp
  104ad1:	31 d2                	xor    %edx,%edx
  104ad3:	89 e5                	mov    %esp,%ebp
  104ad5:	83 ec 08             	sub    $0x8,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  104ad8:	8b 04 95 08 73 10 00 	mov    0x107308(,%edx,4),%eax
  104adf:	66 c7 04 d5 22 d0 10 	movw   $0x8,0x10d022(,%edx,8)
  104ae6:	00 08 00 
  104ae9:	c6 04 d5 24 d0 10 00 	movb   $0x0,0x10d024(,%edx,8)
  104af0:	00 
  104af1:	c6 04 d5 25 d0 10 00 	movb   $0x8e,0x10d025(,%edx,8)
  104af8:	8e 
  104af9:	66 89 04 d5 20 d0 10 	mov    %ax,0x10d020(,%edx,8)
  104b00:	00 
  104b01:	c1 e8 10             	shr    $0x10,%eax
  104b04:	66 89 04 d5 26 d0 10 	mov    %ax,0x10d026(,%edx,8)
  104b0b:	00 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
  104b0c:	83 c2 01             	add    $0x1,%edx
  104b0f:	81 fa 00 01 00 00    	cmp    $0x100,%edx
  104b15:	75 c1                	jne    104ad8 <tvinit+0x8>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  104b17:	a1 08 74 10 00       	mov    0x107408,%eax
  
  initlock(&tickslock, "time");
  104b1c:	c7 44 24 04 59 68 10 	movl   $0x106859,0x4(%esp)
  104b23:	00 
  104b24:	c7 04 24 e0 cf 10 00 	movl   $0x10cfe0,(%esp)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  104b2b:	66 c7 05 22 d2 10 00 	movw   $0x8,0x10d222
  104b32:	08 00 
  104b34:	66 a3 20 d2 10 00    	mov    %ax,0x10d220
  104b3a:	c1 e8 10             	shr    $0x10,%eax
  104b3d:	c6 05 24 d2 10 00 00 	movb   $0x0,0x10d224
  104b44:	c6 05 25 d2 10 00 ef 	movb   $0xef,0x10d225
  104b4b:	66 a3 26 d2 10 00    	mov    %ax,0x10d226
  
  initlock(&tickslock, "time");
  104b51:	e8 fa ec ff ff       	call   103850 <initlock>
}
  104b56:	c9                   	leave  
  104b57:	c3                   	ret    
  104b58:	90                   	nop    
  104b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00104b60 <trap>:
  lidt(idt, sizeof(idt));
}

void
trap(struct trapframe *tf)
{
  104b60:	55                   	push   %ebp
  104b61:	89 e5                	mov    %esp,%ebp
  104b63:	56                   	push   %esi
  104b64:	53                   	push   %ebx
  104b65:	83 ec 20             	sub    $0x20,%esp
  104b68:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
  104b6b:	8b 4b 30             	mov    0x30(%ebx),%ecx
  104b6e:	83 f9 40             	cmp    $0x40,%ecx
  104b71:	74 5d                	je     104bd0 <trap+0x70>
    if(proc->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  104b73:	8d 41 e0             	lea    -0x20(%ecx),%eax
  104b76:	83 f8 1f             	cmp    $0x1f,%eax
  104b79:	76 4c                	jbe    104bc7 <trap+0x67>
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
    break;
   
  default:
    if(proc == 0 || (tf->cs&3) == 0){
  104b7b:	65 8b 35 04 00 00 00 	mov    %gs:0x4,%esi
  104b82:	85 f6                	test   %esi,%esi
  104b84:	74 0a                	je     104b90 <trap+0x30>
  104b86:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
  104b8a:	0f 85 a0 01 00 00    	jne    104d30 <trap+0x1d0>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
  104b90:	0f 20 d0             	mov    %cr2,%eax
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
  104b93:	89 44 24 10          	mov    %eax,0x10(%esp)
  104b97:	8b 43 38             	mov    0x38(%ebx),%eax
  104b9a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  104b9e:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  104ba4:	0f b6 00             	movzbl (%eax),%eax
  104ba7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  104bab:	c7 04 24 88 68 10 00 	movl   $0x106888,(%esp)
  104bb2:	89 44 24 08          	mov    %eax,0x8(%esp)
  104bb6:	e8 05 b9 ff ff       	call   1004c0 <cprintf>
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
  104bbb:	c7 04 24 5e 68 10 00 	movl   $0x10685e,(%esp)
  104bc2:	e8 b9 bc ff ff       	call   100880 <panic>
    if(proc->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  104bc7:	ff 24 85 00 69 10 00 	jmp    *0x106900(,%eax,4)
  104bce:	66 90                	xchg   %ax,%ax

void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
  104bd0:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  104bd7:	8b 72 24             	mov    0x24(%edx),%esi
  104bda:	85 f6                	test   %esi,%esi
  104bdc:	0f 85 0c 01 00 00    	jne    104cee <trap+0x18e>
      exit();
    proc->tf = tf;
  104be2:	89 5a 18             	mov    %ebx,0x18(%edx)
    syscall();
  104be5:	e8 e6 f1 ff ff       	call   103dd0 <syscall>
    if(proc->killed)
  104bea:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104bf0:	8b 58 24             	mov    0x24(%eax),%ebx
  104bf3:	85 db                	test   %ebx,%ebx
  104bf5:	75 5e                	jne    104c55 <trap+0xf5>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
  104bf7:	83 c4 20             	add    $0x20,%esp
  104bfa:	5b                   	pop    %ebx
  104bfb:	5e                   	pop    %esi
  104bfc:	5d                   	pop    %ebp
  104bfd:	c3                   	ret    
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
  104bfe:	e8 2d d3 ff ff       	call   101f30 <ideintr>
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
  104c03:	e8 88 d7 ff ff       	call   102390 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
  104c08:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  104c0f:	85 d2                	test   %edx,%edx
  104c11:	74 e4                	je     104bf7 <trap+0x97>
  104c13:	8b 4a 24             	mov    0x24(%edx),%ecx
  104c16:	85 c9                	test   %ecx,%ecx
  104c18:	74 10                	je     104c2a <trap+0xca>
  104c1a:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
  104c1e:	83 e0 03             	and    $0x3,%eax
  104c21:	83 f8 03             	cmp    $0x3,%eax
  104c24:	0f 84 ed 00 00 00    	je     104d17 <trap+0x1b7>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
  104c2a:	83 7a 0c 04          	cmpl   $0x4,0xc(%edx)
  104c2e:	75 10                	jne    104c40 <trap+0xe0>
  104c30:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
  104c34:	0f 84 c5 00 00 00    	je     104cff <trap+0x19f>
  104c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
  104c40:	89 d0                	mov    %edx,%eax
  104c42:	8b 40 24             	mov    0x24(%eax),%eax
  104c45:	85 c0                	test   %eax,%eax
  104c47:	74 ae                	je     104bf7 <trap+0x97>
  104c49:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
  104c4d:	83 e0 03             	and    $0x3,%eax
  104c50:	83 f8 03             	cmp    $0x3,%eax
  104c53:	75 a2                	jne    104bf7 <trap+0x97>
    exit();
}
  104c55:	83 c4 20             	add    $0x20,%esp
  104c58:	5b                   	pop    %ebx
  104c59:	5e                   	pop    %esi
  104c5a:	5d                   	pop    %ebp
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
  104c5b:	e9 e0 e6 ff ff       	jmp    103340 <exit>
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
  104c60:	8b 43 38             	mov    0x38(%ebx),%eax
  104c63:	89 44 24 0c          	mov    %eax,0xc(%esp)
  104c67:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
  104c6b:	89 44 24 08          	mov    %eax,0x8(%esp)
  104c6f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  104c75:	0f b6 00             	movzbl (%eax),%eax
  104c78:	c7 04 24 64 68 10 00 	movl   $0x106864,(%esp)
  104c7f:	89 44 24 04          	mov    %eax,0x4(%esp)
  104c83:	e8 38 b8 ff ff       	call   1004c0 <cprintf>
  104c88:	e9 76 ff ff ff       	jmp    104c03 <trap+0xa3>
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
  104c8d:	e8 fe 00 00 00       	call   104d90 <uartintr>
    lapiceoi();
  104c92:	e8 f9 d6 ff ff       	call   102390 <lapiceoi>
  104c97:	e9 6c ff ff ff       	jmp    104c08 <trap+0xa8>
  104c9c:	8d 74 26 00          	lea    0x0(%esi),%esi
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
  104ca0:	e8 eb d5 ff ff       	call   102290 <kbdintr>
    lapiceoi();
  104ca5:	e8 e6 d6 ff ff       	call   102390 <lapiceoi>
  104caa:	e9 59 ff ff ff       	jmp    104c08 <trap+0xa8>
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
  104caf:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  104cb5:	80 38 00             	cmpb   $0x0,(%eax)
  104cb8:	0f 85 45 ff ff ff    	jne    104c03 <trap+0xa3>
      acquire(&tickslock);
  104cbe:	c7 04 24 e0 cf 10 00 	movl   $0x10cfe0,(%esp)
  104cc5:	e8 06 ed ff ff       	call   1039d0 <acquire>
      ticks++;
  104cca:	83 05 20 d8 10 00 01 	addl   $0x1,0x10d820
      wakeup(&ticks);
  104cd1:	c7 04 24 20 d8 10 00 	movl   $0x10d820,(%esp)
  104cd8:	e8 e3 e2 ff ff       	call   102fc0 <wakeup>
      release(&tickslock);
  104cdd:	c7 04 24 e0 cf 10 00 	movl   $0x10cfe0,(%esp)
  104ce4:	e8 a7 ec ff ff       	call   103990 <release>
  104ce9:	e9 15 ff ff ff       	jmp    104c03 <trap+0xa3>
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
      exit();
  104cee:	e8 4d e6 ff ff       	call   103340 <exit>
  104cf3:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  104cfa:	e9 e3 fe ff ff       	jmp    104be2 <trap+0x82>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
  104cff:	e8 7c e4 ff ff       	call   103180 <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
  104d04:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104d0a:	85 c0                	test   %eax,%eax
  104d0c:	0f 85 30 ff ff ff    	jne    104c42 <trap+0xe2>
  104d12:	e9 e0 fe ff ff       	jmp    104bf7 <trap+0x97>

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
  104d17:	e8 24 e6 ff ff       	call   103340 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
  104d1c:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  104d23:	85 d2                	test   %edx,%edx
  104d25:	0f 85 ff fe ff ff    	jne    104c2a <trap+0xca>
  104d2b:	e9 c7 fe ff ff       	jmp    104bf7 <trap+0x97>
  104d30:	0f 20 d0             	mov    %cr2,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
  104d33:	8b 56 10             	mov    0x10(%esi),%edx
  104d36:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  104d3a:	8b 43 38             	mov    0x38(%ebx),%eax
  104d3d:	89 44 24 18          	mov    %eax,0x18(%esp)
  104d41:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  104d47:	0f b6 00             	movzbl (%eax),%eax
  104d4a:	89 44 24 14          	mov    %eax,0x14(%esp)
  104d4e:	8b 43 34             	mov    0x34(%ebx),%eax
  104d51:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  104d55:	89 54 24 04          	mov    %edx,0x4(%esp)
  104d59:	c7 04 24 bc 68 10 00 	movl   $0x1068bc,(%esp)
  104d60:	89 44 24 10          	mov    %eax,0x10(%esp)
  104d64:	8d 46 6c             	lea    0x6c(%esi),%eax
  104d67:	89 44 24 08          	mov    %eax,0x8(%esp)
  104d6b:	e8 50 b7 ff ff       	call   1004c0 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
  104d70:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104d76:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  104d7d:	e9 86 fe ff ff       	jmp    104c08 <trap+0xa8>
  104d82:	90                   	nop    
  104d83:	90                   	nop    
  104d84:	90                   	nop    
  104d85:	90                   	nop    
  104d86:	90                   	nop    
  104d87:	90                   	nop    
  104d88:	90                   	nop    
  104d89:	90                   	nop    
  104d8a:	90                   	nop    
  104d8b:	90                   	nop    
  104d8c:	90                   	nop    
  104d8d:	90                   	nop    
  104d8e:	90                   	nop    
  104d8f:	90                   	nop    

00104d90 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
  104d90:	55                   	push   %ebp
  104d91:	89 e5                	mov    %esp,%ebp
  104d93:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
  104d96:	c7 04 24 00 4e 10 00 	movl   $0x104e00,(%esp)
  104d9d:	e8 5e b9 ff ff       	call   100700 <consoleintr>
}
  104da2:	c9                   	leave  
  104da3:	c3                   	ret    
  104da4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104daa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00104db0 <uartputc>:
    uartputc(*p);
}

void
uartputc(int c)
{
  104db0:	55                   	push   %ebp
  104db1:	89 e5                	mov    %esp,%ebp
  104db3:	53                   	push   %ebx
  int i;

  if(!uart)
    return;
  104db4:	31 db                	xor    %ebx,%ebx
    uartputc(*p);
}

void
uartputc(int c)
{
  104db6:	83 ec 04             	sub    $0x4,%esp
  int i;

  if(!uart)
  104db9:	a1 4c 78 10 00       	mov    0x10784c,%eax
  104dbe:	85 c0                	test   %eax,%eax
  104dc0:	75 19                	jne    104ddb <uartputc+0x2b>
  104dc2:	eb 2b                	jmp    104def <uartputc+0x3f>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
  104dc4:	83 c3 01             	add    $0x1,%ebx
    microdelay(10);
  104dc7:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  104dce:	e8 dd d5 ff ff       	call   1023b0 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
  104dd3:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
  104dd9:	74 0a                	je     104de5 <uartputc+0x35>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  104ddb:	ba fd 03 00 00       	mov    $0x3fd,%edx
  104de0:	ec                   	in     (%dx),%al
  104de1:	a8 20                	test   $0x20,%al
  104de3:	74 df                	je     104dc4 <uartputc+0x14>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  104de5:	ba f8 03 00 00       	mov    $0x3f8,%edx
  104dea:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
  104dee:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
  104def:	83 c4 04             	add    $0x4,%esp
  104df2:	5b                   	pop    %ebx
  104df3:	5d                   	pop    %ebp
  104df4:	c3                   	ret    
  104df5:	8d 74 26 00          	lea    0x0(%esi),%esi
  104df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00104e00 <uartgetc>:

static int
uartgetc(void)
{
  if(!uart)
  104e00:	8b 15 4c 78 10 00    	mov    0x10784c,%edx
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
  104e06:	55                   	push   %ebp
  104e07:	89 e5                	mov    %esp,%ebp
  if(!uart)
  104e09:	85 d2                	test   %edx,%edx
  104e0b:	75 07                	jne    104e14 <uartgetc+0x14>
    return -1;
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
  104e0d:	5d                   	pop    %ebp
{
  if(!uart)
    return -1;
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
  104e0e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104e13:	c3                   	ret    
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  104e14:	ba fd 03 00 00       	mov    $0x3fd,%edx
  104e19:	ec                   	in     (%dx),%al
static int
uartgetc(void)
{
  if(!uart)
    return -1;
  if(!(inb(COM1+5) & 0x01))
  104e1a:	a8 01                	test   $0x1,%al
  104e1c:	74 ef                	je     104e0d <uartgetc+0xd>
  104e1e:	b2 f8                	mov    $0xf8,%dl
  104e20:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
}
  104e21:	5d                   	pop    %ebp
  return data;
  104e22:	0f b6 c0             	movzbl %al,%eax
  104e25:	c3                   	ret    
  104e26:	8d 76 00             	lea    0x0(%esi),%esi
  104e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00104e30 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
  104e30:	55                   	push   %ebp
  104e31:	89 e5                	mov    %esp,%ebp
  104e33:	57                   	push   %edi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  104e34:	bf fa 03 00 00       	mov    $0x3fa,%edi
  104e39:	56                   	push   %esi
  104e3a:	89 fa                	mov    %edi,%edx
  104e3c:	53                   	push   %ebx
  104e3d:	31 db                	xor    %ebx,%ebx
  104e3f:	83 ec 0c             	sub    $0xc,%esp
  104e42:	89 d8                	mov    %ebx,%eax
  104e44:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  104e45:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
  104e4a:	b2 fb                	mov    $0xfb,%dl
  104e4c:	ee                   	out    %al,(%dx)
  104e4d:	be f8 03 00 00       	mov    $0x3f8,%esi
  104e52:	b8 0c 00 00 00       	mov    $0xc,%eax
  104e57:	89 f2                	mov    %esi,%edx
  104e59:	ee                   	out    %al,(%dx)
  104e5a:	b9 f9 03 00 00       	mov    $0x3f9,%ecx
  104e5f:	89 d8                	mov    %ebx,%eax
  104e61:	89 ca                	mov    %ecx,%edx
  104e63:	ee                   	out    %al,(%dx)
  104e64:	b8 03 00 00 00       	mov    $0x3,%eax
  104e69:	b2 fb                	mov    $0xfb,%dl
  104e6b:	ee                   	out    %al,(%dx)
  104e6c:	b2 fc                	mov    $0xfc,%dl
  104e6e:	89 d8                	mov    %ebx,%eax
  104e70:	ee                   	out    %al,(%dx)
  104e71:	b8 01 00 00 00       	mov    $0x1,%eax
  104e76:	89 ca                	mov    %ecx,%edx
  104e78:	ee                   	out    %al,(%dx)
  104e79:	b2 fd                	mov    $0xfd,%dl
  104e7b:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
  104e7c:	04 01                	add    $0x1,%al
  104e7e:	74 56                	je     104ed6 <uartinit+0xa6>
    return;
  uart = 1;
  104e80:	c7 05 4c 78 10 00 01 	movl   $0x1,0x10784c
  104e87:	00 00 00 
  104e8a:	89 fa                	mov    %edi,%edx
  104e8c:	ec                   	in     (%dx),%al
  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  104e8d:	89 f2                	mov    %esi,%edx
  104e8f:	ec                   	in     (%dx),%al
  104e90:	bb 80 69 10 00       	mov    $0x106980,%ebx

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  picenable(IRQ_COM1);
  104e95:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  104e9c:	e8 1f dc ff ff       	call   102ac0 <picenable>
  ioapicenable(IRQ_COM1, 0);
  104ea1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104ea8:	00 
  104ea9:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  104eb0:	e8 db d1 ff ff       	call   102090 <ioapicenable>
  104eb5:	b8 78 00 00 00       	mov    $0x78,%eax
  104eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
  104ec0:	0f be c0             	movsbl %al,%eax
  104ec3:	89 04 24             	mov    %eax,(%esp)
  104ec6:	e8 e5 fe ff ff       	call   104db0 <uartputc>
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
  104ecb:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
  104ecf:	83 c3 01             	add    $0x1,%ebx
  104ed2:	84 c0                	test   %al,%al
  104ed4:	75 ea                	jne    104ec0 <uartinit+0x90>
    uartputc(*p);
}
  104ed6:	83 c4 0c             	add    $0xc,%esp
  104ed9:	5b                   	pop    %ebx
  104eda:	5e                   	pop    %esi
  104edb:	5f                   	pop    %edi
  104edc:	5d                   	pop    %ebp
  104edd:	c3                   	ret    
  104ede:	90                   	nop    
  104edf:	90                   	nop    

00104ee0 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
  104ee0:	6a 00                	push   $0x0
  pushl $0
  104ee2:	6a 00                	push   $0x0
  jmp alltraps
  104ee4:	e9 87 fb ff ff       	jmp    104a70 <alltraps>

00104ee9 <vector1>:
.globl vector1
vector1:
  pushl $0
  104ee9:	6a 00                	push   $0x0
  pushl $1
  104eeb:	6a 01                	push   $0x1
  jmp alltraps
  104eed:	e9 7e fb ff ff       	jmp    104a70 <alltraps>

00104ef2 <vector2>:
.globl vector2
vector2:
  pushl $0
  104ef2:	6a 00                	push   $0x0
  pushl $2
  104ef4:	6a 02                	push   $0x2
  jmp alltraps
  104ef6:	e9 75 fb ff ff       	jmp    104a70 <alltraps>

00104efb <vector3>:
.globl vector3
vector3:
  pushl $0
  104efb:	6a 00                	push   $0x0
  pushl $3
  104efd:	6a 03                	push   $0x3
  jmp alltraps
  104eff:	e9 6c fb ff ff       	jmp    104a70 <alltraps>

00104f04 <vector4>:
.globl vector4
vector4:
  pushl $0
  104f04:	6a 00                	push   $0x0
  pushl $4
  104f06:	6a 04                	push   $0x4
  jmp alltraps
  104f08:	e9 63 fb ff ff       	jmp    104a70 <alltraps>

00104f0d <vector5>:
.globl vector5
vector5:
  pushl $0
  104f0d:	6a 00                	push   $0x0
  pushl $5
  104f0f:	6a 05                	push   $0x5
  jmp alltraps
  104f11:	e9 5a fb ff ff       	jmp    104a70 <alltraps>

00104f16 <vector6>:
.globl vector6
vector6:
  pushl $0
  104f16:	6a 00                	push   $0x0
  pushl $6
  104f18:	6a 06                	push   $0x6
  jmp alltraps
  104f1a:	e9 51 fb ff ff       	jmp    104a70 <alltraps>

00104f1f <vector7>:
.globl vector7
vector7:
  pushl $0
  104f1f:	6a 00                	push   $0x0
  pushl $7
  104f21:	6a 07                	push   $0x7
  jmp alltraps
  104f23:	e9 48 fb ff ff       	jmp    104a70 <alltraps>

00104f28 <vector8>:
.globl vector8
vector8:
  pushl $8
  104f28:	6a 08                	push   $0x8
  jmp alltraps
  104f2a:	e9 41 fb ff ff       	jmp    104a70 <alltraps>

00104f2f <vector9>:
.globl vector9
vector9:
  pushl $0
  104f2f:	6a 00                	push   $0x0
  pushl $9
  104f31:	6a 09                	push   $0x9
  jmp alltraps
  104f33:	e9 38 fb ff ff       	jmp    104a70 <alltraps>

00104f38 <vector10>:
.globl vector10
vector10:
  pushl $10
  104f38:	6a 0a                	push   $0xa
  jmp alltraps
  104f3a:	e9 31 fb ff ff       	jmp    104a70 <alltraps>

00104f3f <vector11>:
.globl vector11
vector11:
  pushl $11
  104f3f:	6a 0b                	push   $0xb
  jmp alltraps
  104f41:	e9 2a fb ff ff       	jmp    104a70 <alltraps>

00104f46 <vector12>:
.globl vector12
vector12:
  pushl $12
  104f46:	6a 0c                	push   $0xc
  jmp alltraps
  104f48:	e9 23 fb ff ff       	jmp    104a70 <alltraps>

00104f4d <vector13>:
.globl vector13
vector13:
  pushl $13
  104f4d:	6a 0d                	push   $0xd
  jmp alltraps
  104f4f:	e9 1c fb ff ff       	jmp    104a70 <alltraps>

00104f54 <vector14>:
.globl vector14
vector14:
  pushl $14
  104f54:	6a 0e                	push   $0xe
  jmp alltraps
  104f56:	e9 15 fb ff ff       	jmp    104a70 <alltraps>

00104f5b <vector15>:
.globl vector15
vector15:
  pushl $0
  104f5b:	6a 00                	push   $0x0
  pushl $15
  104f5d:	6a 0f                	push   $0xf
  jmp alltraps
  104f5f:	e9 0c fb ff ff       	jmp    104a70 <alltraps>

00104f64 <vector16>:
.globl vector16
vector16:
  pushl $0
  104f64:	6a 00                	push   $0x0
  pushl $16
  104f66:	6a 10                	push   $0x10
  jmp alltraps
  104f68:	e9 03 fb ff ff       	jmp    104a70 <alltraps>

00104f6d <vector17>:
.globl vector17
vector17:
  pushl $17
  104f6d:	6a 11                	push   $0x11
  jmp alltraps
  104f6f:	e9 fc fa ff ff       	jmp    104a70 <alltraps>

00104f74 <vector18>:
.globl vector18
vector18:
  pushl $0
  104f74:	6a 00                	push   $0x0
  pushl $18
  104f76:	6a 12                	push   $0x12
  jmp alltraps
  104f78:	e9 f3 fa ff ff       	jmp    104a70 <alltraps>

00104f7d <vector19>:
.globl vector19
vector19:
  pushl $0
  104f7d:	6a 00                	push   $0x0
  pushl $19
  104f7f:	6a 13                	push   $0x13
  jmp alltraps
  104f81:	e9 ea fa ff ff       	jmp    104a70 <alltraps>

00104f86 <vector20>:
.globl vector20
vector20:
  pushl $0
  104f86:	6a 00                	push   $0x0
  pushl $20
  104f88:	6a 14                	push   $0x14
  jmp alltraps
  104f8a:	e9 e1 fa ff ff       	jmp    104a70 <alltraps>

00104f8f <vector21>:
.globl vector21
vector21:
  pushl $0
  104f8f:	6a 00                	push   $0x0
  pushl $21
  104f91:	6a 15                	push   $0x15
  jmp alltraps
  104f93:	e9 d8 fa ff ff       	jmp    104a70 <alltraps>

00104f98 <vector22>:
.globl vector22
vector22:
  pushl $0
  104f98:	6a 00                	push   $0x0
  pushl $22
  104f9a:	6a 16                	push   $0x16
  jmp alltraps
  104f9c:	e9 cf fa ff ff       	jmp    104a70 <alltraps>

00104fa1 <vector23>:
.globl vector23
vector23:
  pushl $0
  104fa1:	6a 00                	push   $0x0
  pushl $23
  104fa3:	6a 17                	push   $0x17
  jmp alltraps
  104fa5:	e9 c6 fa ff ff       	jmp    104a70 <alltraps>

00104faa <vector24>:
.globl vector24
vector24:
  pushl $0
  104faa:	6a 00                	push   $0x0
  pushl $24
  104fac:	6a 18                	push   $0x18
  jmp alltraps
  104fae:	e9 bd fa ff ff       	jmp    104a70 <alltraps>

00104fb3 <vector25>:
.globl vector25
vector25:
  pushl $0
  104fb3:	6a 00                	push   $0x0
  pushl $25
  104fb5:	6a 19                	push   $0x19
  jmp alltraps
  104fb7:	e9 b4 fa ff ff       	jmp    104a70 <alltraps>

00104fbc <vector26>:
.globl vector26
vector26:
  pushl $0
  104fbc:	6a 00                	push   $0x0
  pushl $26
  104fbe:	6a 1a                	push   $0x1a
  jmp alltraps
  104fc0:	e9 ab fa ff ff       	jmp    104a70 <alltraps>

00104fc5 <vector27>:
.globl vector27
vector27:
  pushl $0
  104fc5:	6a 00                	push   $0x0
  pushl $27
  104fc7:	6a 1b                	push   $0x1b
  jmp alltraps
  104fc9:	e9 a2 fa ff ff       	jmp    104a70 <alltraps>

00104fce <vector28>:
.globl vector28
vector28:
  pushl $0
  104fce:	6a 00                	push   $0x0
  pushl $28
  104fd0:	6a 1c                	push   $0x1c
  jmp alltraps
  104fd2:	e9 99 fa ff ff       	jmp    104a70 <alltraps>

00104fd7 <vector29>:
.globl vector29
vector29:
  pushl $0
  104fd7:	6a 00                	push   $0x0
  pushl $29
  104fd9:	6a 1d                	push   $0x1d
  jmp alltraps
  104fdb:	e9 90 fa ff ff       	jmp    104a70 <alltraps>

00104fe0 <vector30>:
.globl vector30
vector30:
  pushl $0
  104fe0:	6a 00                	push   $0x0
  pushl $30
  104fe2:	6a 1e                	push   $0x1e
  jmp alltraps
  104fe4:	e9 87 fa ff ff       	jmp    104a70 <alltraps>

00104fe9 <vector31>:
.globl vector31
vector31:
  pushl $0
  104fe9:	6a 00                	push   $0x0
  pushl $31
  104feb:	6a 1f                	push   $0x1f
  jmp alltraps
  104fed:	e9 7e fa ff ff       	jmp    104a70 <alltraps>

00104ff2 <vector32>:
.globl vector32
vector32:
  pushl $0
  104ff2:	6a 00                	push   $0x0
  pushl $32
  104ff4:	6a 20                	push   $0x20
  jmp alltraps
  104ff6:	e9 75 fa ff ff       	jmp    104a70 <alltraps>

00104ffb <vector33>:
.globl vector33
vector33:
  pushl $0
  104ffb:	6a 00                	push   $0x0
  pushl $33
  104ffd:	6a 21                	push   $0x21
  jmp alltraps
  104fff:	e9 6c fa ff ff       	jmp    104a70 <alltraps>

00105004 <vector34>:
.globl vector34
vector34:
  pushl $0
  105004:	6a 00                	push   $0x0
  pushl $34
  105006:	6a 22                	push   $0x22
  jmp alltraps
  105008:	e9 63 fa ff ff       	jmp    104a70 <alltraps>

0010500d <vector35>:
.globl vector35
vector35:
  pushl $0
  10500d:	6a 00                	push   $0x0
  pushl $35
  10500f:	6a 23                	push   $0x23
  jmp alltraps
  105011:	e9 5a fa ff ff       	jmp    104a70 <alltraps>

00105016 <vector36>:
.globl vector36
vector36:
  pushl $0
  105016:	6a 00                	push   $0x0
  pushl $36
  105018:	6a 24                	push   $0x24
  jmp alltraps
  10501a:	e9 51 fa ff ff       	jmp    104a70 <alltraps>

0010501f <vector37>:
.globl vector37
vector37:
  pushl $0
  10501f:	6a 00                	push   $0x0
  pushl $37
  105021:	6a 25                	push   $0x25
  jmp alltraps
  105023:	e9 48 fa ff ff       	jmp    104a70 <alltraps>

00105028 <vector38>:
.globl vector38
vector38:
  pushl $0
  105028:	6a 00                	push   $0x0
  pushl $38
  10502a:	6a 26                	push   $0x26
  jmp alltraps
  10502c:	e9 3f fa ff ff       	jmp    104a70 <alltraps>

00105031 <vector39>:
.globl vector39
vector39:
  pushl $0
  105031:	6a 00                	push   $0x0
  pushl $39
  105033:	6a 27                	push   $0x27
  jmp alltraps
  105035:	e9 36 fa ff ff       	jmp    104a70 <alltraps>

0010503a <vector40>:
.globl vector40
vector40:
  pushl $0
  10503a:	6a 00                	push   $0x0
  pushl $40
  10503c:	6a 28                	push   $0x28
  jmp alltraps
  10503e:	e9 2d fa ff ff       	jmp    104a70 <alltraps>

00105043 <vector41>:
.globl vector41
vector41:
  pushl $0
  105043:	6a 00                	push   $0x0
  pushl $41
  105045:	6a 29                	push   $0x29
  jmp alltraps
  105047:	e9 24 fa ff ff       	jmp    104a70 <alltraps>

0010504c <vector42>:
.globl vector42
vector42:
  pushl $0
  10504c:	6a 00                	push   $0x0
  pushl $42
  10504e:	6a 2a                	push   $0x2a
  jmp alltraps
  105050:	e9 1b fa ff ff       	jmp    104a70 <alltraps>

00105055 <vector43>:
.globl vector43
vector43:
  pushl $0
  105055:	6a 00                	push   $0x0
  pushl $43
  105057:	6a 2b                	push   $0x2b
  jmp alltraps
  105059:	e9 12 fa ff ff       	jmp    104a70 <alltraps>

0010505e <vector44>:
.globl vector44
vector44:
  pushl $0
  10505e:	6a 00                	push   $0x0
  pushl $44
  105060:	6a 2c                	push   $0x2c
  jmp alltraps
  105062:	e9 09 fa ff ff       	jmp    104a70 <alltraps>

00105067 <vector45>:
.globl vector45
vector45:
  pushl $0
  105067:	6a 00                	push   $0x0
  pushl $45
  105069:	6a 2d                	push   $0x2d
  jmp alltraps
  10506b:	e9 00 fa ff ff       	jmp    104a70 <alltraps>

00105070 <vector46>:
.globl vector46
vector46:
  pushl $0
  105070:	6a 00                	push   $0x0
  pushl $46
  105072:	6a 2e                	push   $0x2e
  jmp alltraps
  105074:	e9 f7 f9 ff ff       	jmp    104a70 <alltraps>

00105079 <vector47>:
.globl vector47
vector47:
  pushl $0
  105079:	6a 00                	push   $0x0
  pushl $47
  10507b:	6a 2f                	push   $0x2f
  jmp alltraps
  10507d:	e9 ee f9 ff ff       	jmp    104a70 <alltraps>

00105082 <vector48>:
.globl vector48
vector48:
  pushl $0
  105082:	6a 00                	push   $0x0
  pushl $48
  105084:	6a 30                	push   $0x30
  jmp alltraps
  105086:	e9 e5 f9 ff ff       	jmp    104a70 <alltraps>

0010508b <vector49>:
.globl vector49
vector49:
  pushl $0
  10508b:	6a 00                	push   $0x0
  pushl $49
  10508d:	6a 31                	push   $0x31
  jmp alltraps
  10508f:	e9 dc f9 ff ff       	jmp    104a70 <alltraps>

00105094 <vector50>:
.globl vector50
vector50:
  pushl $0
  105094:	6a 00                	push   $0x0
  pushl $50
  105096:	6a 32                	push   $0x32
  jmp alltraps
  105098:	e9 d3 f9 ff ff       	jmp    104a70 <alltraps>

0010509d <vector51>:
.globl vector51
vector51:
  pushl $0
  10509d:	6a 00                	push   $0x0
  pushl $51
  10509f:	6a 33                	push   $0x33
  jmp alltraps
  1050a1:	e9 ca f9 ff ff       	jmp    104a70 <alltraps>

001050a6 <vector52>:
.globl vector52
vector52:
  pushl $0
  1050a6:	6a 00                	push   $0x0
  pushl $52
  1050a8:	6a 34                	push   $0x34
  jmp alltraps
  1050aa:	e9 c1 f9 ff ff       	jmp    104a70 <alltraps>

001050af <vector53>:
.globl vector53
vector53:
  pushl $0
  1050af:	6a 00                	push   $0x0
  pushl $53
  1050b1:	6a 35                	push   $0x35
  jmp alltraps
  1050b3:	e9 b8 f9 ff ff       	jmp    104a70 <alltraps>

001050b8 <vector54>:
.globl vector54
vector54:
  pushl $0
  1050b8:	6a 00                	push   $0x0
  pushl $54
  1050ba:	6a 36                	push   $0x36
  jmp alltraps
  1050bc:	e9 af f9 ff ff       	jmp    104a70 <alltraps>

001050c1 <vector55>:
.globl vector55
vector55:
  pushl $0
  1050c1:	6a 00                	push   $0x0
  pushl $55
  1050c3:	6a 37                	push   $0x37
  jmp alltraps
  1050c5:	e9 a6 f9 ff ff       	jmp    104a70 <alltraps>

001050ca <vector56>:
.globl vector56
vector56:
  pushl $0
  1050ca:	6a 00                	push   $0x0
  pushl $56
  1050cc:	6a 38                	push   $0x38
  jmp alltraps
  1050ce:	e9 9d f9 ff ff       	jmp    104a70 <alltraps>

001050d3 <vector57>:
.globl vector57
vector57:
  pushl $0
  1050d3:	6a 00                	push   $0x0
  pushl $57
  1050d5:	6a 39                	push   $0x39
  jmp alltraps
  1050d7:	e9 94 f9 ff ff       	jmp    104a70 <alltraps>

001050dc <vector58>:
.globl vector58
vector58:
  pushl $0
  1050dc:	6a 00                	push   $0x0
  pushl $58
  1050de:	6a 3a                	push   $0x3a
  jmp alltraps
  1050e0:	e9 8b f9 ff ff       	jmp    104a70 <alltraps>

001050e5 <vector59>:
.globl vector59
vector59:
  pushl $0
  1050e5:	6a 00                	push   $0x0
  pushl $59
  1050e7:	6a 3b                	push   $0x3b
  jmp alltraps
  1050e9:	e9 82 f9 ff ff       	jmp    104a70 <alltraps>

001050ee <vector60>:
.globl vector60
vector60:
  pushl $0
  1050ee:	6a 00                	push   $0x0
  pushl $60
  1050f0:	6a 3c                	push   $0x3c
  jmp alltraps
  1050f2:	e9 79 f9 ff ff       	jmp    104a70 <alltraps>

001050f7 <vector61>:
.globl vector61
vector61:
  pushl $0
  1050f7:	6a 00                	push   $0x0
  pushl $61
  1050f9:	6a 3d                	push   $0x3d
  jmp alltraps
  1050fb:	e9 70 f9 ff ff       	jmp    104a70 <alltraps>

00105100 <vector62>:
.globl vector62
vector62:
  pushl $0
  105100:	6a 00                	push   $0x0
  pushl $62
  105102:	6a 3e                	push   $0x3e
  jmp alltraps
  105104:	e9 67 f9 ff ff       	jmp    104a70 <alltraps>

00105109 <vector63>:
.globl vector63
vector63:
  pushl $0
  105109:	6a 00                	push   $0x0
  pushl $63
  10510b:	6a 3f                	push   $0x3f
  jmp alltraps
  10510d:	e9 5e f9 ff ff       	jmp    104a70 <alltraps>

00105112 <vector64>:
.globl vector64
vector64:
  pushl $0
  105112:	6a 00                	push   $0x0
  pushl $64
  105114:	6a 40                	push   $0x40
  jmp alltraps
  105116:	e9 55 f9 ff ff       	jmp    104a70 <alltraps>

0010511b <vector65>:
.globl vector65
vector65:
  pushl $0
  10511b:	6a 00                	push   $0x0
  pushl $65
  10511d:	6a 41                	push   $0x41
  jmp alltraps
  10511f:	e9 4c f9 ff ff       	jmp    104a70 <alltraps>

00105124 <vector66>:
.globl vector66
vector66:
  pushl $0
  105124:	6a 00                	push   $0x0
  pushl $66
  105126:	6a 42                	push   $0x42
  jmp alltraps
  105128:	e9 43 f9 ff ff       	jmp    104a70 <alltraps>

0010512d <vector67>:
.globl vector67
vector67:
  pushl $0
  10512d:	6a 00                	push   $0x0
  pushl $67
  10512f:	6a 43                	push   $0x43
  jmp alltraps
  105131:	e9 3a f9 ff ff       	jmp    104a70 <alltraps>

00105136 <vector68>:
.globl vector68
vector68:
  pushl $0
  105136:	6a 00                	push   $0x0
  pushl $68
  105138:	6a 44                	push   $0x44
  jmp alltraps
  10513a:	e9 31 f9 ff ff       	jmp    104a70 <alltraps>

0010513f <vector69>:
.globl vector69
vector69:
  pushl $0
  10513f:	6a 00                	push   $0x0
  pushl $69
  105141:	6a 45                	push   $0x45
  jmp alltraps
  105143:	e9 28 f9 ff ff       	jmp    104a70 <alltraps>

00105148 <vector70>:
.globl vector70
vector70:
  pushl $0
  105148:	6a 00                	push   $0x0
  pushl $70
  10514a:	6a 46                	push   $0x46
  jmp alltraps
  10514c:	e9 1f f9 ff ff       	jmp    104a70 <alltraps>

00105151 <vector71>:
.globl vector71
vector71:
  pushl $0
  105151:	6a 00                	push   $0x0
  pushl $71
  105153:	6a 47                	push   $0x47
  jmp alltraps
  105155:	e9 16 f9 ff ff       	jmp    104a70 <alltraps>

0010515a <vector72>:
.globl vector72
vector72:
  pushl $0
  10515a:	6a 00                	push   $0x0
  pushl $72
  10515c:	6a 48                	push   $0x48
  jmp alltraps
  10515e:	e9 0d f9 ff ff       	jmp    104a70 <alltraps>

00105163 <vector73>:
.globl vector73
vector73:
  pushl $0
  105163:	6a 00                	push   $0x0
  pushl $73
  105165:	6a 49                	push   $0x49
  jmp alltraps
  105167:	e9 04 f9 ff ff       	jmp    104a70 <alltraps>

0010516c <vector74>:
.globl vector74
vector74:
  pushl $0
  10516c:	6a 00                	push   $0x0
  pushl $74
  10516e:	6a 4a                	push   $0x4a
  jmp alltraps
  105170:	e9 fb f8 ff ff       	jmp    104a70 <alltraps>

00105175 <vector75>:
.globl vector75
vector75:
  pushl $0
  105175:	6a 00                	push   $0x0
  pushl $75
  105177:	6a 4b                	push   $0x4b
  jmp alltraps
  105179:	e9 f2 f8 ff ff       	jmp    104a70 <alltraps>

0010517e <vector76>:
.globl vector76
vector76:
  pushl $0
  10517e:	6a 00                	push   $0x0
  pushl $76
  105180:	6a 4c                	push   $0x4c
  jmp alltraps
  105182:	e9 e9 f8 ff ff       	jmp    104a70 <alltraps>

00105187 <vector77>:
.globl vector77
vector77:
  pushl $0
  105187:	6a 00                	push   $0x0
  pushl $77
  105189:	6a 4d                	push   $0x4d
  jmp alltraps
  10518b:	e9 e0 f8 ff ff       	jmp    104a70 <alltraps>

00105190 <vector78>:
.globl vector78
vector78:
  pushl $0
  105190:	6a 00                	push   $0x0
  pushl $78
  105192:	6a 4e                	push   $0x4e
  jmp alltraps
  105194:	e9 d7 f8 ff ff       	jmp    104a70 <alltraps>

00105199 <vector79>:
.globl vector79
vector79:
  pushl $0
  105199:	6a 00                	push   $0x0
  pushl $79
  10519b:	6a 4f                	push   $0x4f
  jmp alltraps
  10519d:	e9 ce f8 ff ff       	jmp    104a70 <alltraps>

001051a2 <vector80>:
.globl vector80
vector80:
  pushl $0
  1051a2:	6a 00                	push   $0x0
  pushl $80
  1051a4:	6a 50                	push   $0x50
  jmp alltraps
  1051a6:	e9 c5 f8 ff ff       	jmp    104a70 <alltraps>

001051ab <vector81>:
.globl vector81
vector81:
  pushl $0
  1051ab:	6a 00                	push   $0x0
  pushl $81
  1051ad:	6a 51                	push   $0x51
  jmp alltraps
  1051af:	e9 bc f8 ff ff       	jmp    104a70 <alltraps>

001051b4 <vector82>:
.globl vector82
vector82:
  pushl $0
  1051b4:	6a 00                	push   $0x0
  pushl $82
  1051b6:	6a 52                	push   $0x52
  jmp alltraps
  1051b8:	e9 b3 f8 ff ff       	jmp    104a70 <alltraps>

001051bd <vector83>:
.globl vector83
vector83:
  pushl $0
  1051bd:	6a 00                	push   $0x0
  pushl $83
  1051bf:	6a 53                	push   $0x53
  jmp alltraps
  1051c1:	e9 aa f8 ff ff       	jmp    104a70 <alltraps>

001051c6 <vector84>:
.globl vector84
vector84:
  pushl $0
  1051c6:	6a 00                	push   $0x0
  pushl $84
  1051c8:	6a 54                	push   $0x54
  jmp alltraps
  1051ca:	e9 a1 f8 ff ff       	jmp    104a70 <alltraps>

001051cf <vector85>:
.globl vector85
vector85:
  pushl $0
  1051cf:	6a 00                	push   $0x0
  pushl $85
  1051d1:	6a 55                	push   $0x55
  jmp alltraps
  1051d3:	e9 98 f8 ff ff       	jmp    104a70 <alltraps>

001051d8 <vector86>:
.globl vector86
vector86:
  pushl $0
  1051d8:	6a 00                	push   $0x0
  pushl $86
  1051da:	6a 56                	push   $0x56
  jmp alltraps
  1051dc:	e9 8f f8 ff ff       	jmp    104a70 <alltraps>

001051e1 <vector87>:
.globl vector87
vector87:
  pushl $0
  1051e1:	6a 00                	push   $0x0
  pushl $87
  1051e3:	6a 57                	push   $0x57
  jmp alltraps
  1051e5:	e9 86 f8 ff ff       	jmp    104a70 <alltraps>

001051ea <vector88>:
.globl vector88
vector88:
  pushl $0
  1051ea:	6a 00                	push   $0x0
  pushl $88
  1051ec:	6a 58                	push   $0x58
  jmp alltraps
  1051ee:	e9 7d f8 ff ff       	jmp    104a70 <alltraps>

001051f3 <vector89>:
.globl vector89
vector89:
  pushl $0
  1051f3:	6a 00                	push   $0x0
  pushl $89
  1051f5:	6a 59                	push   $0x59
  jmp alltraps
  1051f7:	e9 74 f8 ff ff       	jmp    104a70 <alltraps>

001051fc <vector90>:
.globl vector90
vector90:
  pushl $0
  1051fc:	6a 00                	push   $0x0
  pushl $90
  1051fe:	6a 5a                	push   $0x5a
  jmp alltraps
  105200:	e9 6b f8 ff ff       	jmp    104a70 <alltraps>

00105205 <vector91>:
.globl vector91
vector91:
  pushl $0
  105205:	6a 00                	push   $0x0
  pushl $91
  105207:	6a 5b                	push   $0x5b
  jmp alltraps
  105209:	e9 62 f8 ff ff       	jmp    104a70 <alltraps>

0010520e <vector92>:
.globl vector92
vector92:
  pushl $0
  10520e:	6a 00                	push   $0x0
  pushl $92
  105210:	6a 5c                	push   $0x5c
  jmp alltraps
  105212:	e9 59 f8 ff ff       	jmp    104a70 <alltraps>

00105217 <vector93>:
.globl vector93
vector93:
  pushl $0
  105217:	6a 00                	push   $0x0
  pushl $93
  105219:	6a 5d                	push   $0x5d
  jmp alltraps
  10521b:	e9 50 f8 ff ff       	jmp    104a70 <alltraps>

00105220 <vector94>:
.globl vector94
vector94:
  pushl $0
  105220:	6a 00                	push   $0x0
  pushl $94
  105222:	6a 5e                	push   $0x5e
  jmp alltraps
  105224:	e9 47 f8 ff ff       	jmp    104a70 <alltraps>

00105229 <vector95>:
.globl vector95
vector95:
  pushl $0
  105229:	6a 00                	push   $0x0
  pushl $95
  10522b:	6a 5f                	push   $0x5f
  jmp alltraps
  10522d:	e9 3e f8 ff ff       	jmp    104a70 <alltraps>

00105232 <vector96>:
.globl vector96
vector96:
  pushl $0
  105232:	6a 00                	push   $0x0
  pushl $96
  105234:	6a 60                	push   $0x60
  jmp alltraps
  105236:	e9 35 f8 ff ff       	jmp    104a70 <alltraps>

0010523b <vector97>:
.globl vector97
vector97:
  pushl $0
  10523b:	6a 00                	push   $0x0
  pushl $97
  10523d:	6a 61                	push   $0x61
  jmp alltraps
  10523f:	e9 2c f8 ff ff       	jmp    104a70 <alltraps>

00105244 <vector98>:
.globl vector98
vector98:
  pushl $0
  105244:	6a 00                	push   $0x0
  pushl $98
  105246:	6a 62                	push   $0x62
  jmp alltraps
  105248:	e9 23 f8 ff ff       	jmp    104a70 <alltraps>

0010524d <vector99>:
.globl vector99
vector99:
  pushl $0
  10524d:	6a 00                	push   $0x0
  pushl $99
  10524f:	6a 63                	push   $0x63
  jmp alltraps
  105251:	e9 1a f8 ff ff       	jmp    104a70 <alltraps>

00105256 <vector100>:
.globl vector100
vector100:
  pushl $0
  105256:	6a 00                	push   $0x0
  pushl $100
  105258:	6a 64                	push   $0x64
  jmp alltraps
  10525a:	e9 11 f8 ff ff       	jmp    104a70 <alltraps>

0010525f <vector101>:
.globl vector101
vector101:
  pushl $0
  10525f:	6a 00                	push   $0x0
  pushl $101
  105261:	6a 65                	push   $0x65
  jmp alltraps
  105263:	e9 08 f8 ff ff       	jmp    104a70 <alltraps>

00105268 <vector102>:
.globl vector102
vector102:
  pushl $0
  105268:	6a 00                	push   $0x0
  pushl $102
  10526a:	6a 66                	push   $0x66
  jmp alltraps
  10526c:	e9 ff f7 ff ff       	jmp    104a70 <alltraps>

00105271 <vector103>:
.globl vector103
vector103:
  pushl $0
  105271:	6a 00                	push   $0x0
  pushl $103
  105273:	6a 67                	push   $0x67
  jmp alltraps
  105275:	e9 f6 f7 ff ff       	jmp    104a70 <alltraps>

0010527a <vector104>:
.globl vector104
vector104:
  pushl $0
  10527a:	6a 00                	push   $0x0
  pushl $104
  10527c:	6a 68                	push   $0x68
  jmp alltraps
  10527e:	e9 ed f7 ff ff       	jmp    104a70 <alltraps>

00105283 <vector105>:
.globl vector105
vector105:
  pushl $0
  105283:	6a 00                	push   $0x0
  pushl $105
  105285:	6a 69                	push   $0x69
  jmp alltraps
  105287:	e9 e4 f7 ff ff       	jmp    104a70 <alltraps>

0010528c <vector106>:
.globl vector106
vector106:
  pushl $0
  10528c:	6a 00                	push   $0x0
  pushl $106
  10528e:	6a 6a                	push   $0x6a
  jmp alltraps
  105290:	e9 db f7 ff ff       	jmp    104a70 <alltraps>

00105295 <vector107>:
.globl vector107
vector107:
  pushl $0
  105295:	6a 00                	push   $0x0
  pushl $107
  105297:	6a 6b                	push   $0x6b
  jmp alltraps
  105299:	e9 d2 f7 ff ff       	jmp    104a70 <alltraps>

0010529e <vector108>:
.globl vector108
vector108:
  pushl $0
  10529e:	6a 00                	push   $0x0
  pushl $108
  1052a0:	6a 6c                	push   $0x6c
  jmp alltraps
  1052a2:	e9 c9 f7 ff ff       	jmp    104a70 <alltraps>

001052a7 <vector109>:
.globl vector109
vector109:
  pushl $0
  1052a7:	6a 00                	push   $0x0
  pushl $109
  1052a9:	6a 6d                	push   $0x6d
  jmp alltraps
  1052ab:	e9 c0 f7 ff ff       	jmp    104a70 <alltraps>

001052b0 <vector110>:
.globl vector110
vector110:
  pushl $0
  1052b0:	6a 00                	push   $0x0
  pushl $110
  1052b2:	6a 6e                	push   $0x6e
  jmp alltraps
  1052b4:	e9 b7 f7 ff ff       	jmp    104a70 <alltraps>

001052b9 <vector111>:
.globl vector111
vector111:
  pushl $0
  1052b9:	6a 00                	push   $0x0
  pushl $111
  1052bb:	6a 6f                	push   $0x6f
  jmp alltraps
  1052bd:	e9 ae f7 ff ff       	jmp    104a70 <alltraps>

001052c2 <vector112>:
.globl vector112
vector112:
  pushl $0
  1052c2:	6a 00                	push   $0x0
  pushl $112
  1052c4:	6a 70                	push   $0x70
  jmp alltraps
  1052c6:	e9 a5 f7 ff ff       	jmp    104a70 <alltraps>

001052cb <vector113>:
.globl vector113
vector113:
  pushl $0
  1052cb:	6a 00                	push   $0x0
  pushl $113
  1052cd:	6a 71                	push   $0x71
  jmp alltraps
  1052cf:	e9 9c f7 ff ff       	jmp    104a70 <alltraps>

001052d4 <vector114>:
.globl vector114
vector114:
  pushl $0
  1052d4:	6a 00                	push   $0x0
  pushl $114
  1052d6:	6a 72                	push   $0x72
  jmp alltraps
  1052d8:	e9 93 f7 ff ff       	jmp    104a70 <alltraps>

001052dd <vector115>:
.globl vector115
vector115:
  pushl $0
  1052dd:	6a 00                	push   $0x0
  pushl $115
  1052df:	6a 73                	push   $0x73
  jmp alltraps
  1052e1:	e9 8a f7 ff ff       	jmp    104a70 <alltraps>

001052e6 <vector116>:
.globl vector116
vector116:
  pushl $0
  1052e6:	6a 00                	push   $0x0
  pushl $116
  1052e8:	6a 74                	push   $0x74
  jmp alltraps
  1052ea:	e9 81 f7 ff ff       	jmp    104a70 <alltraps>

001052ef <vector117>:
.globl vector117
vector117:
  pushl $0
  1052ef:	6a 00                	push   $0x0
  pushl $117
  1052f1:	6a 75                	push   $0x75
  jmp alltraps
  1052f3:	e9 78 f7 ff ff       	jmp    104a70 <alltraps>

001052f8 <vector118>:
.globl vector118
vector118:
  pushl $0
  1052f8:	6a 00                	push   $0x0
  pushl $118
  1052fa:	6a 76                	push   $0x76
  jmp alltraps
  1052fc:	e9 6f f7 ff ff       	jmp    104a70 <alltraps>

00105301 <vector119>:
.globl vector119
vector119:
  pushl $0
  105301:	6a 00                	push   $0x0
  pushl $119
  105303:	6a 77                	push   $0x77
  jmp alltraps
  105305:	e9 66 f7 ff ff       	jmp    104a70 <alltraps>

0010530a <vector120>:
.globl vector120
vector120:
  pushl $0
  10530a:	6a 00                	push   $0x0
  pushl $120
  10530c:	6a 78                	push   $0x78
  jmp alltraps
  10530e:	e9 5d f7 ff ff       	jmp    104a70 <alltraps>

00105313 <vector121>:
.globl vector121
vector121:
  pushl $0
  105313:	6a 00                	push   $0x0
  pushl $121
  105315:	6a 79                	push   $0x79
  jmp alltraps
  105317:	e9 54 f7 ff ff       	jmp    104a70 <alltraps>

0010531c <vector122>:
.globl vector122
vector122:
  pushl $0
  10531c:	6a 00                	push   $0x0
  pushl $122
  10531e:	6a 7a                	push   $0x7a
  jmp alltraps
  105320:	e9 4b f7 ff ff       	jmp    104a70 <alltraps>

00105325 <vector123>:
.globl vector123
vector123:
  pushl $0
  105325:	6a 00                	push   $0x0
  pushl $123
  105327:	6a 7b                	push   $0x7b
  jmp alltraps
  105329:	e9 42 f7 ff ff       	jmp    104a70 <alltraps>

0010532e <vector124>:
.globl vector124
vector124:
  pushl $0
  10532e:	6a 00                	push   $0x0
  pushl $124
  105330:	6a 7c                	push   $0x7c
  jmp alltraps
  105332:	e9 39 f7 ff ff       	jmp    104a70 <alltraps>

00105337 <vector125>:
.globl vector125
vector125:
  pushl $0
  105337:	6a 00                	push   $0x0
  pushl $125
  105339:	6a 7d                	push   $0x7d
  jmp alltraps
  10533b:	e9 30 f7 ff ff       	jmp    104a70 <alltraps>

00105340 <vector126>:
.globl vector126
vector126:
  pushl $0
  105340:	6a 00                	push   $0x0
  pushl $126
  105342:	6a 7e                	push   $0x7e
  jmp alltraps
  105344:	e9 27 f7 ff ff       	jmp    104a70 <alltraps>

00105349 <vector127>:
.globl vector127
vector127:
  pushl $0
  105349:	6a 00                	push   $0x0
  pushl $127
  10534b:	6a 7f                	push   $0x7f
  jmp alltraps
  10534d:	e9 1e f7 ff ff       	jmp    104a70 <alltraps>

00105352 <vector128>:
.globl vector128
vector128:
  pushl $0
  105352:	6a 00                	push   $0x0
  pushl $128
  105354:	68 80 00 00 00       	push   $0x80
  jmp alltraps
  105359:	e9 12 f7 ff ff       	jmp    104a70 <alltraps>

0010535e <vector129>:
.globl vector129
vector129:
  pushl $0
  10535e:	6a 00                	push   $0x0
  pushl $129
  105360:	68 81 00 00 00       	push   $0x81
  jmp alltraps
  105365:	e9 06 f7 ff ff       	jmp    104a70 <alltraps>

0010536a <vector130>:
.globl vector130
vector130:
  pushl $0
  10536a:	6a 00                	push   $0x0
  pushl $130
  10536c:	68 82 00 00 00       	push   $0x82
  jmp alltraps
  105371:	e9 fa f6 ff ff       	jmp    104a70 <alltraps>

00105376 <vector131>:
.globl vector131
vector131:
  pushl $0
  105376:	6a 00                	push   $0x0
  pushl $131
  105378:	68 83 00 00 00       	push   $0x83
  jmp alltraps
  10537d:	e9 ee f6 ff ff       	jmp    104a70 <alltraps>

00105382 <vector132>:
.globl vector132
vector132:
  pushl $0
  105382:	6a 00                	push   $0x0
  pushl $132
  105384:	68 84 00 00 00       	push   $0x84
  jmp alltraps
  105389:	e9 e2 f6 ff ff       	jmp    104a70 <alltraps>

0010538e <vector133>:
.globl vector133
vector133:
  pushl $0
  10538e:	6a 00                	push   $0x0
  pushl $133
  105390:	68 85 00 00 00       	push   $0x85
  jmp alltraps
  105395:	e9 d6 f6 ff ff       	jmp    104a70 <alltraps>

0010539a <vector134>:
.globl vector134
vector134:
  pushl $0
  10539a:	6a 00                	push   $0x0
  pushl $134
  10539c:	68 86 00 00 00       	push   $0x86
  jmp alltraps
  1053a1:	e9 ca f6 ff ff       	jmp    104a70 <alltraps>

001053a6 <vector135>:
.globl vector135
vector135:
  pushl $0
  1053a6:	6a 00                	push   $0x0
  pushl $135
  1053a8:	68 87 00 00 00       	push   $0x87
  jmp alltraps
  1053ad:	e9 be f6 ff ff       	jmp    104a70 <alltraps>

001053b2 <vector136>:
.globl vector136
vector136:
  pushl $0
  1053b2:	6a 00                	push   $0x0
  pushl $136
  1053b4:	68 88 00 00 00       	push   $0x88
  jmp alltraps
  1053b9:	e9 b2 f6 ff ff       	jmp    104a70 <alltraps>

001053be <vector137>:
.globl vector137
vector137:
  pushl $0
  1053be:	6a 00                	push   $0x0
  pushl $137
  1053c0:	68 89 00 00 00       	push   $0x89
  jmp alltraps
  1053c5:	e9 a6 f6 ff ff       	jmp    104a70 <alltraps>

001053ca <vector138>:
.globl vector138
vector138:
  pushl $0
  1053ca:	6a 00                	push   $0x0
  pushl $138
  1053cc:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
  1053d1:	e9 9a f6 ff ff       	jmp    104a70 <alltraps>

001053d6 <vector139>:
.globl vector139
vector139:
  pushl $0
  1053d6:	6a 00                	push   $0x0
  pushl $139
  1053d8:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
  1053dd:	e9 8e f6 ff ff       	jmp    104a70 <alltraps>

001053e2 <vector140>:
.globl vector140
vector140:
  pushl $0
  1053e2:	6a 00                	push   $0x0
  pushl $140
  1053e4:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
  1053e9:	e9 82 f6 ff ff       	jmp    104a70 <alltraps>

001053ee <vector141>:
.globl vector141
vector141:
  pushl $0
  1053ee:	6a 00                	push   $0x0
  pushl $141
  1053f0:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
  1053f5:	e9 76 f6 ff ff       	jmp    104a70 <alltraps>

001053fa <vector142>:
.globl vector142
vector142:
  pushl $0
  1053fa:	6a 00                	push   $0x0
  pushl $142
  1053fc:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
  105401:	e9 6a f6 ff ff       	jmp    104a70 <alltraps>

00105406 <vector143>:
.globl vector143
vector143:
  pushl $0
  105406:	6a 00                	push   $0x0
  pushl $143
  105408:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
  10540d:	e9 5e f6 ff ff       	jmp    104a70 <alltraps>

00105412 <vector144>:
.globl vector144
vector144:
  pushl $0
  105412:	6a 00                	push   $0x0
  pushl $144
  105414:	68 90 00 00 00       	push   $0x90
  jmp alltraps
  105419:	e9 52 f6 ff ff       	jmp    104a70 <alltraps>

0010541e <vector145>:
.globl vector145
vector145:
  pushl $0
  10541e:	6a 00                	push   $0x0
  pushl $145
  105420:	68 91 00 00 00       	push   $0x91
  jmp alltraps
  105425:	e9 46 f6 ff ff       	jmp    104a70 <alltraps>

0010542a <vector146>:
.globl vector146
vector146:
  pushl $0
  10542a:	6a 00                	push   $0x0
  pushl $146
  10542c:	68 92 00 00 00       	push   $0x92
  jmp alltraps
  105431:	e9 3a f6 ff ff       	jmp    104a70 <alltraps>

00105436 <vector147>:
.globl vector147
vector147:
  pushl $0
  105436:	6a 00                	push   $0x0
  pushl $147
  105438:	68 93 00 00 00       	push   $0x93
  jmp alltraps
  10543d:	e9 2e f6 ff ff       	jmp    104a70 <alltraps>

00105442 <vector148>:
.globl vector148
vector148:
  pushl $0
  105442:	6a 00                	push   $0x0
  pushl $148
  105444:	68 94 00 00 00       	push   $0x94
  jmp alltraps
  105449:	e9 22 f6 ff ff       	jmp    104a70 <alltraps>

0010544e <vector149>:
.globl vector149
vector149:
  pushl $0
  10544e:	6a 00                	push   $0x0
  pushl $149
  105450:	68 95 00 00 00       	push   $0x95
  jmp alltraps
  105455:	e9 16 f6 ff ff       	jmp    104a70 <alltraps>

0010545a <vector150>:
.globl vector150
vector150:
  pushl $0
  10545a:	6a 00                	push   $0x0
  pushl $150
  10545c:	68 96 00 00 00       	push   $0x96
  jmp alltraps
  105461:	e9 0a f6 ff ff       	jmp    104a70 <alltraps>

00105466 <vector151>:
.globl vector151
vector151:
  pushl $0
  105466:	6a 00                	push   $0x0
  pushl $151
  105468:	68 97 00 00 00       	push   $0x97
  jmp alltraps
  10546d:	e9 fe f5 ff ff       	jmp    104a70 <alltraps>

00105472 <vector152>:
.globl vector152
vector152:
  pushl $0
  105472:	6a 00                	push   $0x0
  pushl $152
  105474:	68 98 00 00 00       	push   $0x98
  jmp alltraps
  105479:	e9 f2 f5 ff ff       	jmp    104a70 <alltraps>

0010547e <vector153>:
.globl vector153
vector153:
  pushl $0
  10547e:	6a 00                	push   $0x0
  pushl $153
  105480:	68 99 00 00 00       	push   $0x99
  jmp alltraps
  105485:	e9 e6 f5 ff ff       	jmp    104a70 <alltraps>

0010548a <vector154>:
.globl vector154
vector154:
  pushl $0
  10548a:	6a 00                	push   $0x0
  pushl $154
  10548c:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
  105491:	e9 da f5 ff ff       	jmp    104a70 <alltraps>

00105496 <vector155>:
.globl vector155
vector155:
  pushl $0
  105496:	6a 00                	push   $0x0
  pushl $155
  105498:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
  10549d:	e9 ce f5 ff ff       	jmp    104a70 <alltraps>

001054a2 <vector156>:
.globl vector156
vector156:
  pushl $0
  1054a2:	6a 00                	push   $0x0
  pushl $156
  1054a4:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
  1054a9:	e9 c2 f5 ff ff       	jmp    104a70 <alltraps>

001054ae <vector157>:
.globl vector157
vector157:
  pushl $0
  1054ae:	6a 00                	push   $0x0
  pushl $157
  1054b0:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
  1054b5:	e9 b6 f5 ff ff       	jmp    104a70 <alltraps>

001054ba <vector158>:
.globl vector158
vector158:
  pushl $0
  1054ba:	6a 00                	push   $0x0
  pushl $158
  1054bc:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
  1054c1:	e9 aa f5 ff ff       	jmp    104a70 <alltraps>

001054c6 <vector159>:
.globl vector159
vector159:
  pushl $0
  1054c6:	6a 00                	push   $0x0
  pushl $159
  1054c8:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
  1054cd:	e9 9e f5 ff ff       	jmp    104a70 <alltraps>

001054d2 <vector160>:
.globl vector160
vector160:
  pushl $0
  1054d2:	6a 00                	push   $0x0
  pushl $160
  1054d4:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
  1054d9:	e9 92 f5 ff ff       	jmp    104a70 <alltraps>

001054de <vector161>:
.globl vector161
vector161:
  pushl $0
  1054de:	6a 00                	push   $0x0
  pushl $161
  1054e0:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
  1054e5:	e9 86 f5 ff ff       	jmp    104a70 <alltraps>

001054ea <vector162>:
.globl vector162
vector162:
  pushl $0
  1054ea:	6a 00                	push   $0x0
  pushl $162
  1054ec:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
  1054f1:	e9 7a f5 ff ff       	jmp    104a70 <alltraps>

001054f6 <vector163>:
.globl vector163
vector163:
  pushl $0
  1054f6:	6a 00                	push   $0x0
  pushl $163
  1054f8:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
  1054fd:	e9 6e f5 ff ff       	jmp    104a70 <alltraps>

00105502 <vector164>:
.globl vector164
vector164:
  pushl $0
  105502:	6a 00                	push   $0x0
  pushl $164
  105504:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
  105509:	e9 62 f5 ff ff       	jmp    104a70 <alltraps>

0010550e <vector165>:
.globl vector165
vector165:
  pushl $0
  10550e:	6a 00                	push   $0x0
  pushl $165
  105510:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
  105515:	e9 56 f5 ff ff       	jmp    104a70 <alltraps>

0010551a <vector166>:
.globl vector166
vector166:
  pushl $0
  10551a:	6a 00                	push   $0x0
  pushl $166
  10551c:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
  105521:	e9 4a f5 ff ff       	jmp    104a70 <alltraps>

00105526 <vector167>:
.globl vector167
vector167:
  pushl $0
  105526:	6a 00                	push   $0x0
  pushl $167
  105528:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
  10552d:	e9 3e f5 ff ff       	jmp    104a70 <alltraps>

00105532 <vector168>:
.globl vector168
vector168:
  pushl $0
  105532:	6a 00                	push   $0x0
  pushl $168
  105534:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
  105539:	e9 32 f5 ff ff       	jmp    104a70 <alltraps>

0010553e <vector169>:
.globl vector169
vector169:
  pushl $0
  10553e:	6a 00                	push   $0x0
  pushl $169
  105540:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
  105545:	e9 26 f5 ff ff       	jmp    104a70 <alltraps>

0010554a <vector170>:
.globl vector170
vector170:
  pushl $0
  10554a:	6a 00                	push   $0x0
  pushl $170
  10554c:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
  105551:	e9 1a f5 ff ff       	jmp    104a70 <alltraps>

00105556 <vector171>:
.globl vector171
vector171:
  pushl $0
  105556:	6a 00                	push   $0x0
  pushl $171
  105558:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
  10555d:	e9 0e f5 ff ff       	jmp    104a70 <alltraps>

00105562 <vector172>:
.globl vector172
vector172:
  pushl $0
  105562:	6a 00                	push   $0x0
  pushl $172
  105564:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
  105569:	e9 02 f5 ff ff       	jmp    104a70 <alltraps>

0010556e <vector173>:
.globl vector173
vector173:
  pushl $0
  10556e:	6a 00                	push   $0x0
  pushl $173
  105570:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
  105575:	e9 f6 f4 ff ff       	jmp    104a70 <alltraps>

0010557a <vector174>:
.globl vector174
vector174:
  pushl $0
  10557a:	6a 00                	push   $0x0
  pushl $174
  10557c:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
  105581:	e9 ea f4 ff ff       	jmp    104a70 <alltraps>

00105586 <vector175>:
.globl vector175
vector175:
  pushl $0
  105586:	6a 00                	push   $0x0
  pushl $175
  105588:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
  10558d:	e9 de f4 ff ff       	jmp    104a70 <alltraps>

00105592 <vector176>:
.globl vector176
vector176:
  pushl $0
  105592:	6a 00                	push   $0x0
  pushl $176
  105594:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
  105599:	e9 d2 f4 ff ff       	jmp    104a70 <alltraps>

0010559e <vector177>:
.globl vector177
vector177:
  pushl $0
  10559e:	6a 00                	push   $0x0
  pushl $177
  1055a0:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
  1055a5:	e9 c6 f4 ff ff       	jmp    104a70 <alltraps>

001055aa <vector178>:
.globl vector178
vector178:
  pushl $0
  1055aa:	6a 00                	push   $0x0
  pushl $178
  1055ac:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
  1055b1:	e9 ba f4 ff ff       	jmp    104a70 <alltraps>

001055b6 <vector179>:
.globl vector179
vector179:
  pushl $0
  1055b6:	6a 00                	push   $0x0
  pushl $179
  1055b8:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
  1055bd:	e9 ae f4 ff ff       	jmp    104a70 <alltraps>

001055c2 <vector180>:
.globl vector180
vector180:
  pushl $0
  1055c2:	6a 00                	push   $0x0
  pushl $180
  1055c4:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
  1055c9:	e9 a2 f4 ff ff       	jmp    104a70 <alltraps>

001055ce <vector181>:
.globl vector181
vector181:
  pushl $0
  1055ce:	6a 00                	push   $0x0
  pushl $181
  1055d0:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
  1055d5:	e9 96 f4 ff ff       	jmp    104a70 <alltraps>

001055da <vector182>:
.globl vector182
vector182:
  pushl $0
  1055da:	6a 00                	push   $0x0
  pushl $182
  1055dc:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
  1055e1:	e9 8a f4 ff ff       	jmp    104a70 <alltraps>

001055e6 <vector183>:
.globl vector183
vector183:
  pushl $0
  1055e6:	6a 00                	push   $0x0
  pushl $183
  1055e8:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
  1055ed:	e9 7e f4 ff ff       	jmp    104a70 <alltraps>

001055f2 <vector184>:
.globl vector184
vector184:
  pushl $0
  1055f2:	6a 00                	push   $0x0
  pushl $184
  1055f4:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
  1055f9:	e9 72 f4 ff ff       	jmp    104a70 <alltraps>

001055fe <vector185>:
.globl vector185
vector185:
  pushl $0
  1055fe:	6a 00                	push   $0x0
  pushl $185
  105600:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
  105605:	e9 66 f4 ff ff       	jmp    104a70 <alltraps>

0010560a <vector186>:
.globl vector186
vector186:
  pushl $0
  10560a:	6a 00                	push   $0x0
  pushl $186
  10560c:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
  105611:	e9 5a f4 ff ff       	jmp    104a70 <alltraps>

00105616 <vector187>:
.globl vector187
vector187:
  pushl $0
  105616:	6a 00                	push   $0x0
  pushl $187
  105618:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
  10561d:	e9 4e f4 ff ff       	jmp    104a70 <alltraps>

00105622 <vector188>:
.globl vector188
vector188:
  pushl $0
  105622:	6a 00                	push   $0x0
  pushl $188
  105624:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
  105629:	e9 42 f4 ff ff       	jmp    104a70 <alltraps>

0010562e <vector189>:
.globl vector189
vector189:
  pushl $0
  10562e:	6a 00                	push   $0x0
  pushl $189
  105630:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
  105635:	e9 36 f4 ff ff       	jmp    104a70 <alltraps>

0010563a <vector190>:
.globl vector190
vector190:
  pushl $0
  10563a:	6a 00                	push   $0x0
  pushl $190
  10563c:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
  105641:	e9 2a f4 ff ff       	jmp    104a70 <alltraps>

00105646 <vector191>:
.globl vector191
vector191:
  pushl $0
  105646:	6a 00                	push   $0x0
  pushl $191
  105648:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
  10564d:	e9 1e f4 ff ff       	jmp    104a70 <alltraps>

00105652 <vector192>:
.globl vector192
vector192:
  pushl $0
  105652:	6a 00                	push   $0x0
  pushl $192
  105654:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
  105659:	e9 12 f4 ff ff       	jmp    104a70 <alltraps>

0010565e <vector193>:
.globl vector193
vector193:
  pushl $0
  10565e:	6a 00                	push   $0x0
  pushl $193
  105660:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
  105665:	e9 06 f4 ff ff       	jmp    104a70 <alltraps>

0010566a <vector194>:
.globl vector194
vector194:
  pushl $0
  10566a:	6a 00                	push   $0x0
  pushl $194
  10566c:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
  105671:	e9 fa f3 ff ff       	jmp    104a70 <alltraps>

00105676 <vector195>:
.globl vector195
vector195:
  pushl $0
  105676:	6a 00                	push   $0x0
  pushl $195
  105678:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
  10567d:	e9 ee f3 ff ff       	jmp    104a70 <alltraps>

00105682 <vector196>:
.globl vector196
vector196:
  pushl $0
  105682:	6a 00                	push   $0x0
  pushl $196
  105684:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
  105689:	e9 e2 f3 ff ff       	jmp    104a70 <alltraps>

0010568e <vector197>:
.globl vector197
vector197:
  pushl $0
  10568e:	6a 00                	push   $0x0
  pushl $197
  105690:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
  105695:	e9 d6 f3 ff ff       	jmp    104a70 <alltraps>

0010569a <vector198>:
.globl vector198
vector198:
  pushl $0
  10569a:	6a 00                	push   $0x0
  pushl $198
  10569c:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
  1056a1:	e9 ca f3 ff ff       	jmp    104a70 <alltraps>

001056a6 <vector199>:
.globl vector199
vector199:
  pushl $0
  1056a6:	6a 00                	push   $0x0
  pushl $199
  1056a8:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
  1056ad:	e9 be f3 ff ff       	jmp    104a70 <alltraps>

001056b2 <vector200>:
.globl vector200
vector200:
  pushl $0
  1056b2:	6a 00                	push   $0x0
  pushl $200
  1056b4:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
  1056b9:	e9 b2 f3 ff ff       	jmp    104a70 <alltraps>

001056be <vector201>:
.globl vector201
vector201:
  pushl $0
  1056be:	6a 00                	push   $0x0
  pushl $201
  1056c0:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
  1056c5:	e9 a6 f3 ff ff       	jmp    104a70 <alltraps>

001056ca <vector202>:
.globl vector202
vector202:
  pushl $0
  1056ca:	6a 00                	push   $0x0
  pushl $202
  1056cc:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
  1056d1:	e9 9a f3 ff ff       	jmp    104a70 <alltraps>

001056d6 <vector203>:
.globl vector203
vector203:
  pushl $0
  1056d6:	6a 00                	push   $0x0
  pushl $203
  1056d8:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
  1056dd:	e9 8e f3 ff ff       	jmp    104a70 <alltraps>

001056e2 <vector204>:
.globl vector204
vector204:
  pushl $0
  1056e2:	6a 00                	push   $0x0
  pushl $204
  1056e4:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
  1056e9:	e9 82 f3 ff ff       	jmp    104a70 <alltraps>

001056ee <vector205>:
.globl vector205
vector205:
  pushl $0
  1056ee:	6a 00                	push   $0x0
  pushl $205
  1056f0:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
  1056f5:	e9 76 f3 ff ff       	jmp    104a70 <alltraps>

001056fa <vector206>:
.globl vector206
vector206:
  pushl $0
  1056fa:	6a 00                	push   $0x0
  pushl $206
  1056fc:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
  105701:	e9 6a f3 ff ff       	jmp    104a70 <alltraps>

00105706 <vector207>:
.globl vector207
vector207:
  pushl $0
  105706:	6a 00                	push   $0x0
  pushl $207
  105708:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
  10570d:	e9 5e f3 ff ff       	jmp    104a70 <alltraps>

00105712 <vector208>:
.globl vector208
vector208:
  pushl $0
  105712:	6a 00                	push   $0x0
  pushl $208
  105714:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
  105719:	e9 52 f3 ff ff       	jmp    104a70 <alltraps>

0010571e <vector209>:
.globl vector209
vector209:
  pushl $0
  10571e:	6a 00                	push   $0x0
  pushl $209
  105720:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
  105725:	e9 46 f3 ff ff       	jmp    104a70 <alltraps>

0010572a <vector210>:
.globl vector210
vector210:
  pushl $0
  10572a:	6a 00                	push   $0x0
  pushl $210
  10572c:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
  105731:	e9 3a f3 ff ff       	jmp    104a70 <alltraps>

00105736 <vector211>:
.globl vector211
vector211:
  pushl $0
  105736:	6a 00                	push   $0x0
  pushl $211
  105738:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
  10573d:	e9 2e f3 ff ff       	jmp    104a70 <alltraps>

00105742 <vector212>:
.globl vector212
vector212:
  pushl $0
  105742:	6a 00                	push   $0x0
  pushl $212
  105744:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
  105749:	e9 22 f3 ff ff       	jmp    104a70 <alltraps>

0010574e <vector213>:
.globl vector213
vector213:
  pushl $0
  10574e:	6a 00                	push   $0x0
  pushl $213
  105750:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
  105755:	e9 16 f3 ff ff       	jmp    104a70 <alltraps>

0010575a <vector214>:
.globl vector214
vector214:
  pushl $0
  10575a:	6a 00                	push   $0x0
  pushl $214
  10575c:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
  105761:	e9 0a f3 ff ff       	jmp    104a70 <alltraps>

00105766 <vector215>:
.globl vector215
vector215:
  pushl $0
  105766:	6a 00                	push   $0x0
  pushl $215
  105768:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
  10576d:	e9 fe f2 ff ff       	jmp    104a70 <alltraps>

00105772 <vector216>:
.globl vector216
vector216:
  pushl $0
  105772:	6a 00                	push   $0x0
  pushl $216
  105774:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
  105779:	e9 f2 f2 ff ff       	jmp    104a70 <alltraps>

0010577e <vector217>:
.globl vector217
vector217:
  pushl $0
  10577e:	6a 00                	push   $0x0
  pushl $217
  105780:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
  105785:	e9 e6 f2 ff ff       	jmp    104a70 <alltraps>

0010578a <vector218>:
.globl vector218
vector218:
  pushl $0
  10578a:	6a 00                	push   $0x0
  pushl $218
  10578c:	68 da 00 00 00       	push   $0xda
  jmp alltraps
  105791:	e9 da f2 ff ff       	jmp    104a70 <alltraps>

00105796 <vector219>:
.globl vector219
vector219:
  pushl $0
  105796:	6a 00                	push   $0x0
  pushl $219
  105798:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
  10579d:	e9 ce f2 ff ff       	jmp    104a70 <alltraps>

001057a2 <vector220>:
.globl vector220
vector220:
  pushl $0
  1057a2:	6a 00                	push   $0x0
  pushl $220
  1057a4:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
  1057a9:	e9 c2 f2 ff ff       	jmp    104a70 <alltraps>

001057ae <vector221>:
.globl vector221
vector221:
  pushl $0
  1057ae:	6a 00                	push   $0x0
  pushl $221
  1057b0:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
  1057b5:	e9 b6 f2 ff ff       	jmp    104a70 <alltraps>

001057ba <vector222>:
.globl vector222
vector222:
  pushl $0
  1057ba:	6a 00                	push   $0x0
  pushl $222
  1057bc:	68 de 00 00 00       	push   $0xde
  jmp alltraps
  1057c1:	e9 aa f2 ff ff       	jmp    104a70 <alltraps>

001057c6 <vector223>:
.globl vector223
vector223:
  pushl $0
  1057c6:	6a 00                	push   $0x0
  pushl $223
  1057c8:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
  1057cd:	e9 9e f2 ff ff       	jmp    104a70 <alltraps>

001057d2 <vector224>:
.globl vector224
vector224:
  pushl $0
  1057d2:	6a 00                	push   $0x0
  pushl $224
  1057d4:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
  1057d9:	e9 92 f2 ff ff       	jmp    104a70 <alltraps>

001057de <vector225>:
.globl vector225
vector225:
  pushl $0
  1057de:	6a 00                	push   $0x0
  pushl $225
  1057e0:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
  1057e5:	e9 86 f2 ff ff       	jmp    104a70 <alltraps>

001057ea <vector226>:
.globl vector226
vector226:
  pushl $0
  1057ea:	6a 00                	push   $0x0
  pushl $226
  1057ec:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
  1057f1:	e9 7a f2 ff ff       	jmp    104a70 <alltraps>

001057f6 <vector227>:
.globl vector227
vector227:
  pushl $0
  1057f6:	6a 00                	push   $0x0
  pushl $227
  1057f8:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
  1057fd:	e9 6e f2 ff ff       	jmp    104a70 <alltraps>

00105802 <vector228>:
.globl vector228
vector228:
  pushl $0
  105802:	6a 00                	push   $0x0
  pushl $228
  105804:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
  105809:	e9 62 f2 ff ff       	jmp    104a70 <alltraps>

0010580e <vector229>:
.globl vector229
vector229:
  pushl $0
  10580e:	6a 00                	push   $0x0
  pushl $229
  105810:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
  105815:	e9 56 f2 ff ff       	jmp    104a70 <alltraps>

0010581a <vector230>:
.globl vector230
vector230:
  pushl $0
  10581a:	6a 00                	push   $0x0
  pushl $230
  10581c:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
  105821:	e9 4a f2 ff ff       	jmp    104a70 <alltraps>

00105826 <vector231>:
.globl vector231
vector231:
  pushl $0
  105826:	6a 00                	push   $0x0
  pushl $231
  105828:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
  10582d:	e9 3e f2 ff ff       	jmp    104a70 <alltraps>

00105832 <vector232>:
.globl vector232
vector232:
  pushl $0
  105832:	6a 00                	push   $0x0
  pushl $232
  105834:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
  105839:	e9 32 f2 ff ff       	jmp    104a70 <alltraps>

0010583e <vector233>:
.globl vector233
vector233:
  pushl $0
  10583e:	6a 00                	push   $0x0
  pushl $233
  105840:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
  105845:	e9 26 f2 ff ff       	jmp    104a70 <alltraps>

0010584a <vector234>:
.globl vector234
vector234:
  pushl $0
  10584a:	6a 00                	push   $0x0
  pushl $234
  10584c:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
  105851:	e9 1a f2 ff ff       	jmp    104a70 <alltraps>

00105856 <vector235>:
.globl vector235
vector235:
  pushl $0
  105856:	6a 00                	push   $0x0
  pushl $235
  105858:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
  10585d:	e9 0e f2 ff ff       	jmp    104a70 <alltraps>

00105862 <vector236>:
.globl vector236
vector236:
  pushl $0
  105862:	6a 00                	push   $0x0
  pushl $236
  105864:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
  105869:	e9 02 f2 ff ff       	jmp    104a70 <alltraps>

0010586e <vector237>:
.globl vector237
vector237:
  pushl $0
  10586e:	6a 00                	push   $0x0
  pushl $237
  105870:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
  105875:	e9 f6 f1 ff ff       	jmp    104a70 <alltraps>

0010587a <vector238>:
.globl vector238
vector238:
  pushl $0
  10587a:	6a 00                	push   $0x0
  pushl $238
  10587c:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
  105881:	e9 ea f1 ff ff       	jmp    104a70 <alltraps>

00105886 <vector239>:
.globl vector239
vector239:
  pushl $0
  105886:	6a 00                	push   $0x0
  pushl $239
  105888:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
  10588d:	e9 de f1 ff ff       	jmp    104a70 <alltraps>

00105892 <vector240>:
.globl vector240
vector240:
  pushl $0
  105892:	6a 00                	push   $0x0
  pushl $240
  105894:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
  105899:	e9 d2 f1 ff ff       	jmp    104a70 <alltraps>

0010589e <vector241>:
.globl vector241
vector241:
  pushl $0
  10589e:	6a 00                	push   $0x0
  pushl $241
  1058a0:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
  1058a5:	e9 c6 f1 ff ff       	jmp    104a70 <alltraps>

001058aa <vector242>:
.globl vector242
vector242:
  pushl $0
  1058aa:	6a 00                	push   $0x0
  pushl $242
  1058ac:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
  1058b1:	e9 ba f1 ff ff       	jmp    104a70 <alltraps>

001058b6 <vector243>:
.globl vector243
vector243:
  pushl $0
  1058b6:	6a 00                	push   $0x0
  pushl $243
  1058b8:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
  1058bd:	e9 ae f1 ff ff       	jmp    104a70 <alltraps>

001058c2 <vector244>:
.globl vector244
vector244:
  pushl $0
  1058c2:	6a 00                	push   $0x0
  pushl $244
  1058c4:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
  1058c9:	e9 a2 f1 ff ff       	jmp    104a70 <alltraps>

001058ce <vector245>:
.globl vector245
vector245:
  pushl $0
  1058ce:	6a 00                	push   $0x0
  pushl $245
  1058d0:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
  1058d5:	e9 96 f1 ff ff       	jmp    104a70 <alltraps>

001058da <vector246>:
.globl vector246
vector246:
  pushl $0
  1058da:	6a 00                	push   $0x0
  pushl $246
  1058dc:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
  1058e1:	e9 8a f1 ff ff       	jmp    104a70 <alltraps>

001058e6 <vector247>:
.globl vector247
vector247:
  pushl $0
  1058e6:	6a 00                	push   $0x0
  pushl $247
  1058e8:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
  1058ed:	e9 7e f1 ff ff       	jmp    104a70 <alltraps>

001058f2 <vector248>:
.globl vector248
vector248:
  pushl $0
  1058f2:	6a 00                	push   $0x0
  pushl $248
  1058f4:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
  1058f9:	e9 72 f1 ff ff       	jmp    104a70 <alltraps>

001058fe <vector249>:
.globl vector249
vector249:
  pushl $0
  1058fe:	6a 00                	push   $0x0
  pushl $249
  105900:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
  105905:	e9 66 f1 ff ff       	jmp    104a70 <alltraps>

0010590a <vector250>:
.globl vector250
vector250:
  pushl $0
  10590a:	6a 00                	push   $0x0
  pushl $250
  10590c:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
  105911:	e9 5a f1 ff ff       	jmp    104a70 <alltraps>

00105916 <vector251>:
.globl vector251
vector251:
  pushl $0
  105916:	6a 00                	push   $0x0
  pushl $251
  105918:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
  10591d:	e9 4e f1 ff ff       	jmp    104a70 <alltraps>

00105922 <vector252>:
.globl vector252
vector252:
  pushl $0
  105922:	6a 00                	push   $0x0
  pushl $252
  105924:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
  105929:	e9 42 f1 ff ff       	jmp    104a70 <alltraps>

0010592e <vector253>:
.globl vector253
vector253:
  pushl $0
  10592e:	6a 00                	push   $0x0
  pushl $253
  105930:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
  105935:	e9 36 f1 ff ff       	jmp    104a70 <alltraps>

0010593a <vector254>:
.globl vector254
vector254:
  pushl $0
  10593a:	6a 00                	push   $0x0
  pushl $254
  10593c:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
  105941:	e9 2a f1 ff ff       	jmp    104a70 <alltraps>

00105946 <vector255>:
.globl vector255
vector255:
  pushl $0
  105946:	6a 00                	push   $0x0
  pushl $255
  105948:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
  10594d:	e9 1e f1 ff ff       	jmp    104a70 <alltraps>
  105952:	90                   	nop    
  105953:	90                   	nop    
  105954:	90                   	nop    
  105955:	90                   	nop    
  105956:	90                   	nop    
  105957:	90                   	nop    
  105958:	90                   	nop    
  105959:	90                   	nop    
  10595a:	90                   	nop    
  10595b:	90                   	nop    
  10595c:	90                   	nop    
  10595d:	90                   	nop    
  10595e:	90                   	nop    
  10595f:	90                   	nop    

00105960 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm()
{
  105960:	55                   	push   %ebp
}

static inline void
lcr3(uint val) 
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
  105961:	a1 50 78 10 00       	mov    0x107850,%eax
  105966:	89 e5                	mov    %esp,%ebp
  105968:	0f 22 d8             	mov    %eax,%cr3
  lcr3(PADDR(kpgdir));   // switch to the kernel page table
}
  10596b:	5d                   	pop    %ebp
  10596c:	c3                   	ret    
  10596d:	8d 76 00             	lea    0x0(%esi),%esi

00105970 <vmenable>:
}

// Turn on paging.
void
vmenable(void)
{
  105970:	55                   	push   %ebp
  105971:	89 e5                	mov    %esp,%ebp
  uint cr0;

  switchkvm(); // load kpgdir into cr3
  105973:	e8 e8 ff ff ff       	call   105960 <switchkvm>

static inline uint
rcr0(void)
{
  uint val;
  asm volatile("movl %%cr0,%0" : "=r" (val));
  105978:	0f 20 c0             	mov    %cr0,%eax
}

static inline void
lcr0(uint val)
{
  asm volatile("movl %0,%%cr0" : : "r" (val));
  10597b:	0d 00 00 00 80       	or     $0x80000000,%eax
  105980:	0f 22 c0             	mov    %eax,%cr0
  cr0 = rcr0();
  cr0 |= CR0_PG;
  lcr0(cr0);
}
  105983:	5d                   	pop    %ebp
  105984:	c3                   	ret    
  105985:	8d 74 26 00          	lea    0x0(%esi),%esi
  105989:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00105990 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to linear address va.  If create!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int create)
{
  105990:	55                   	push   %ebp
  105991:	89 e5                	mov    %esp,%ebp
  105993:	83 ec 18             	sub    $0x18,%esp
  105996:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  105999:	89 d3                	mov    %edx,%ebx
  uint r;
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  10599b:	c1 ea 16             	shr    $0x16,%edx
// Return the address of the PTE in page table pgdir
// that corresponds to linear address va.  If create!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int create)
{
  10599e:	89 7d fc             	mov    %edi,-0x4(%ebp)
  uint r;
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  1059a1:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to linear address va.  If create!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int create)
{
  1059a4:	89 75 f8             	mov    %esi,-0x8(%ebp)
  uint r;
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
  1059a7:	8b 07                	mov    (%edi),%eax
  1059a9:	a8 01                	test   $0x1,%al
  1059ab:	74 21                	je     1059ce <walkpgdir+0x3e>
    pgtab = (pte_t*) PTE_ADDR(*pde);
  1059ad:	89 c6                	mov    %eax,%esi
  1059af:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = PADDR(r) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
  1059b5:	c1 eb 0a             	shr    $0xa,%ebx
  1059b8:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
  1059be:	8d 04 33             	lea    (%ebx,%esi,1),%eax
}
  1059c1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1059c4:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1059c7:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1059ca:	89 ec                	mov    %ebp,%esp
  1059cc:	5d                   	pop    %ebp
  1059cd:	c3                   	ret    
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*) PTE_ADDR(*pde);
  } else if(!create || !(r = (uint) kalloc()))
  1059ce:	85 c9                	test   %ecx,%ecx
  1059d0:	75 04                	jne    1059d6 <walkpgdir+0x46>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = PADDR(r) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
  1059d2:	31 c0                	xor    %eax,%eax
  1059d4:	eb eb                	jmp    1059c1 <walkpgdir+0x31>
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*) PTE_ADDR(*pde);
  } else if(!create || !(r = (uint) kalloc()))
  1059d6:	e8 95 c7 ff ff       	call   102170 <kalloc>
  1059db:	85 c0                	test   %eax,%eax
  1059dd:	8d 76 00             	lea    0x0(%esi),%esi
  1059e0:	74 f0                	je     1059d2 <walkpgdir+0x42>
    return 0;
  else {
    pgtab = (pte_t*) r;
  1059e2:	89 c6                	mov    %eax,%esi
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
  1059e4:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  1059eb:	00 
  1059ec:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1059f3:	00 
  1059f4:	89 04 24             	mov    %eax,(%esp)
  1059f7:	e8 44 e0 ff ff       	call   103a40 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = PADDR(r) | PTE_P | PTE_W | PTE_U;
  1059fc:	89 f0                	mov    %esi,%eax
  1059fe:	83 c8 07             	or     $0x7,%eax
  105a01:	89 07                	mov    %eax,(%edi)
  105a03:	eb b0                	jmp    1059b5 <walkpgdir+0x25>
  105a05:	8d 74 26 00          	lea    0x0(%esi),%esi
  105a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00105a10 <uva2ka>:
// maps to.  The result is also a kernel logical address,
// since the kernel maps the physical memory allocated to user
// processes directly.
char*
uva2ka(pde_t *pgdir, char *uva)
{    
  105a10:	55                   	push   %ebp
  pte_t *pte = walkpgdir(pgdir, uva, 0);
  105a11:	31 c9                	xor    %ecx,%ecx
// maps to.  The result is also a kernel logical address,
// since the kernel maps the physical memory allocated to user
// processes directly.
char*
uva2ka(pde_t *pgdir, char *uva)
{    
  105a13:	89 e5                	mov    %esp,%ebp
  105a15:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte = walkpgdir(pgdir, uva, 0);
  105a18:	8b 55 0c             	mov    0xc(%ebp),%edx
  105a1b:	8b 45 08             	mov    0x8(%ebp),%eax
  105a1e:	e8 6d ff ff ff       	call   105990 <walkpgdir>
  if(pte == 0) return 0;
  105a23:	31 d2                	xor    %edx,%edx
  105a25:	85 c0                	test   %eax,%eax
  105a27:	74 08                	je     105a31 <uva2ka+0x21>
  uint pa = PTE_ADDR(*pte);
  return (char *)pa;
  105a29:	8b 10                	mov    (%eax),%edx
  105a2b:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
}
  105a31:	c9                   	leave  
  105a32:	89 d0                	mov    %edx,%eax
  105a34:	c3                   	ret    
  105a35:	8d 74 26 00          	lea    0x0(%esi),%esi
  105a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00105a40 <mappages>:
// Create PTEs for linear addresses starting at la that refer to
// physical addresses starting at pa. la and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *la, uint size, uint pa, int perm)
{
  105a40:	55                   	push   %ebp
  105a41:	89 e5                	mov    %esp,%ebp
  105a43:	57                   	push   %edi
  105a44:	56                   	push   %esi
  105a45:	53                   	push   %ebx
  char *a = PGROUNDDOWN(la);
  105a46:	89 d3                	mov    %edx,%ebx
// Create PTEs for linear addresses starting at la that refer to
// physical addresses starting at pa. la and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *la, uint size, uint pa, int perm)
{
  105a48:	83 ec 0c             	sub    $0xc,%esp
  105a4b:	8b 75 08             	mov    0x8(%ebp),%esi
  char *a = PGROUNDDOWN(la);
  105a4e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for linear addresses starting at la that refer to
// physical addresses starting at pa. la and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *la, uint size, uint pa, int perm)
{
  105a54:	89 45 f0             	mov    %eax,-0x10(%ebp)
    pte_t *pte = walkpgdir(pgdir, a, 1);
    if(pte == 0)
      return 0;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
  105a57:	8b 45 0c             	mov    0xc(%ebp),%eax
// be page-aligned.
static int
mappages(pde_t *pgdir, void *la, uint size, uint pa, int perm)
{
  char *a = PGROUNDDOWN(la);
  char *last = PGROUNDDOWN(la + size - 1);
  105a5a:	8d 7c 0a ff          	lea    -0x1(%edx,%ecx,1),%edi
  105a5e:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pte_t *pte = walkpgdir(pgdir, a, 1);
    if(pte == 0)
      return 0;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
  105a64:	83 c8 01             	or     $0x1,%eax
  105a67:	89 45 ec             	mov    %eax,-0x14(%ebp)
  105a6a:	eb 20                	jmp    105a8c <mappages+0x4c>
  105a6c:	8d 74 26 00          	lea    0x0(%esi),%esi

  while(1){
    pte_t *pte = walkpgdir(pgdir, a, 1);
    if(pte == 0)
      return 0;
    if(*pte & PTE_P)
  105a70:	f6 00 01             	testb  $0x1,(%eax)
  105a73:	75 43                	jne    105ab8 <mappages+0x78>
      panic("remap");
    *pte = pa | perm | PTE_P;
  105a75:	8b 45 ec             	mov    -0x14(%ebp),%eax
  105a78:	09 f0                	or     %esi,%eax
    if(a == last)
  105a7a:	39 fb                	cmp    %edi,%ebx
    pte_t *pte = walkpgdir(pgdir, a, 1);
    if(pte == 0)
      return 0;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
  105a7c:	89 02                	mov    %eax,(%edx)
    if(a == last)
  105a7e:	74 2b                	je     105aab <mappages+0x6b>
      break;
    a += PGSIZE;
  105a80:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    pa += PGSIZE;
  105a86:	81 c6 00 10 00 00    	add    $0x1000,%esi
{
  char *a = PGROUNDDOWN(la);
  char *last = PGROUNDDOWN(la + size - 1);

  while(1){
    pte_t *pte = walkpgdir(pgdir, a, 1);
  105a8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105a8f:	89 da                	mov    %ebx,%edx
  105a91:	b9 01 00 00 00       	mov    $0x1,%ecx
  105a96:	e8 f5 fe ff ff       	call   105990 <walkpgdir>
    if(pte == 0)
  105a9b:	85 c0                	test   %eax,%eax
{
  char *a = PGROUNDDOWN(la);
  char *last = PGROUNDDOWN(la + size - 1);

  while(1){
    pte_t *pte = walkpgdir(pgdir, a, 1);
  105a9d:	89 c2                	mov    %eax,%edx
    if(pte == 0)
  105a9f:	75 cf                	jne    105a70 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 1;
}
  105aa1:	83 c4 0c             	add    $0xc,%esp
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  105aa4:	31 c0                	xor    %eax,%eax
  return 1;
}
  105aa6:	5b                   	pop    %ebx
  105aa7:	5e                   	pop    %esi
  105aa8:	5f                   	pop    %edi
  105aa9:	5d                   	pop    %ebp
  105aaa:	c3                   	ret    
  105aab:	83 c4 0c             	add    $0xc,%esp
    if(pte == 0)
      return 0;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
  105aae:	b8 01 00 00 00       	mov    $0x1,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 1;
}
  105ab3:	5b                   	pop    %ebx
  105ab4:	5e                   	pop    %esi
  105ab5:	5f                   	pop    %edi
  105ab6:	5d                   	pop    %ebp
  105ab7:	c3                   	ret    
  while(1){
    pte_t *pte = walkpgdir(pgdir, a, 1);
    if(pte == 0)
      return 0;
    if(*pte & PTE_P)
      panic("remap");
  105ab8:	c7 04 24 88 69 10 00 	movl   $0x106988,(%esp)
  105abf:	e8 bc ad ff ff       	call   100880 <panic>
  105ac4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105aca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105ad0 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
  105ad0:	55                   	push   %ebp
  105ad1:	89 e5                	mov    %esp,%ebp
  105ad3:	83 ec 28             	sub    $0x28,%esp
  105ad6:	8b 45 0c             	mov    0xc(%ebp),%eax
  105ad9:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  105adc:	89 75 f8             	mov    %esi,-0x8(%ebp)
  105adf:	8b 75 10             	mov    0x10(%ebp),%esi
  105ae2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  105ae5:	8b 7d 08             	mov    0x8(%ebp),%edi
  105ae8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  char *mem = kalloc();
  105aeb:	e8 80 c6 ff ff       	call   102170 <kalloc>
  if (sz >= PGSIZE)
  105af0:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem = kalloc();
  105af6:	89 c3                	mov    %eax,%ebx
  if (sz >= PGSIZE)
  105af8:	77 4e                	ja     105b48 <inituvm+0x78>
    panic("inituvm: more than a page");
  memset(mem, 0, PGSIZE);
  105afa:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  105b01:	00 
  105b02:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  105b09:	00 
  105b0a:	89 04 24             	mov    %eax,(%esp)
  105b0d:	e8 2e df ff ff       	call   103a40 <memset>
  mappages(pgdir, 0, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  105b12:	89 f8                	mov    %edi,%eax
  105b14:	b9 00 10 00 00       	mov    $0x1000,%ecx
  105b19:	89 1c 24             	mov    %ebx,(%esp)
  105b1c:	31 d2                	xor    %edx,%edx
  105b1e:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
  105b25:	00 
  105b26:	e8 15 ff ff ff       	call   105a40 <mappages>
  memmove(mem, init, sz);
  105b2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105b2e:	89 75 10             	mov    %esi,0x10(%ebp)
}
  105b31:	8b 7d fc             	mov    -0x4(%ebp),%edi
  char *mem = kalloc();
  if (sz >= PGSIZE)
    panic("inituvm: more than a page");
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
  105b34:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
  105b37:	8b 75 f8             	mov    -0x8(%ebp),%esi
  105b3a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  char *mem = kalloc();
  if (sz >= PGSIZE)
    panic("inituvm: more than a page");
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
  105b3d:	89 45 0c             	mov    %eax,0xc(%ebp)
}
  105b40:	89 ec                	mov    %ebp,%esp
  105b42:	5d                   	pop    %ebp
  char *mem = kalloc();
  if (sz >= PGSIZE)
    panic("inituvm: more than a page");
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
  105b43:	e9 98 df ff ff       	jmp    103ae0 <memmove>
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem = kalloc();
  if (sz >= PGSIZE)
    panic("inituvm: more than a page");
  105b48:	c7 04 24 8e 69 10 00 	movl   $0x10698e,(%esp)
  105b4f:	e8 2c ad ff ff       	call   100880 <panic>
  105b54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105b5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105b60 <setupkvm>:
}

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
  105b60:	55                   	push   %ebp
  105b61:	89 e5                	mov    %esp,%ebp
  105b63:	53                   	push   %ebx
  105b64:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;

  // Allocate page directory
  if(!(pgdir = (pde_t *) kalloc()))
  105b67:	e8 04 c6 ff ff       	call   102170 <kalloc>
  105b6c:	85 c0                	test   %eax,%eax
  105b6e:	75 10                	jne    105b80 <setupkvm+0x20>
    return 0;
  memset(pgdir, 0, PGSIZE);
  if(// Map IO space from 640K to 1Mbyte
  105b70:	31 db                	xor    %ebx,%ebx
     !mappages(pgdir, (void *)0x100000, PHYSTOP-0x100000, 0x100000, PTE_W) ||
     // Map devices such as ioapic, lapic, ...
     !mappages(pgdir, (void *)0xFE000000, 0x2000000, 0xFE000000, PTE_W))
    return 0;
  return pgdir;
}
  105b72:	89 d8                	mov    %ebx,%eax
  105b74:	83 c4 14             	add    $0x14,%esp
  105b77:	5b                   	pop    %ebx
  105b78:	5d                   	pop    %ebp
  105b79:	c3                   	ret    
  105b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
setupkvm(void)
{
  pde_t *pgdir;

  // Allocate page directory
  if(!(pgdir = (pde_t *) kalloc()))
  105b80:	89 c3                	mov    %eax,%ebx
    return 0;
  memset(pgdir, 0, PGSIZE);
  105b82:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  105b89:	00 
  105b8a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  105b91:	00 
  105b92:	89 04 24             	mov    %eax,(%esp)
  105b95:	e8 a6 de ff ff       	call   103a40 <memset>
  if(// Map IO space from 640K to 1Mbyte
  105b9a:	b9 00 00 06 00       	mov    $0x60000,%ecx
  105b9f:	ba 00 00 0a 00       	mov    $0xa0000,%edx
  105ba4:	89 d8                	mov    %ebx,%eax
  105ba6:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  105bad:	00 
  105bae:	c7 04 24 00 00 0a 00 	movl   $0xa0000,(%esp)
  105bb5:	e8 86 fe ff ff       	call   105a40 <mappages>
  105bba:	85 c0                	test   %eax,%eax
  105bbc:	74 b2                	je     105b70 <setupkvm+0x10>
  105bbe:	b9 00 00 f0 00       	mov    $0xf00000,%ecx
  105bc3:	ba 00 00 10 00       	mov    $0x100000,%edx
  105bc8:	89 d8                	mov    %ebx,%eax
  105bca:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  105bd1:	00 
  105bd2:	c7 04 24 00 00 10 00 	movl   $0x100000,(%esp)
  105bd9:	e8 62 fe ff ff       	call   105a40 <mappages>
  105bde:	85 c0                	test   %eax,%eax
  105be0:	74 8e                	je     105b70 <setupkvm+0x10>
  105be2:	b9 00 00 00 02       	mov    $0x2000000,%ecx
  105be7:	ba 00 00 00 fe       	mov    $0xfe000000,%edx
  105bec:	89 d8                	mov    %ebx,%eax
  105bee:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  105bf5:	00 
  105bf6:	c7 04 24 00 00 00 fe 	movl   $0xfe000000,(%esp)
  105bfd:	e8 3e fe ff ff       	call   105a40 <mappages>
  105c02:	85 c0                	test   %eax,%eax
  105c04:	0f 85 68 ff ff ff    	jne    105b72 <setupkvm+0x12>
  105c0a:	e9 61 ff ff ff       	jmp    105b70 <setupkvm+0x10>
  105c0f:	90                   	nop    

00105c10 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
  105c10:	55                   	push   %ebp
  105c11:	89 e5                	mov    %esp,%ebp
  105c13:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
  105c16:	e8 45 ff ff ff       	call   105b60 <setupkvm>
  105c1b:	a3 50 78 10 00       	mov    %eax,0x107850
}
  105c20:	c9                   	leave  
  105c21:	c3                   	ret    
  105c22:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  105c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00105c30 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  105c30:	55                   	push   %ebp
  105c31:	89 e5                	mov    %esp,%ebp
  105c33:	57                   	push   %edi
  105c34:	56                   	push   %esi
  105c35:	53                   	push   %ebx
  105c36:	83 ec 0c             	sub    $0xc,%esp
  char *a = (char *)PGROUNDUP(newsz);
  105c39:	8b 75 10             	mov    0x10(%ebp),%esi
  char *last = PGROUNDDOWN(oldsz - 1);
  105c3c:	8b 7d 0c             	mov    0xc(%ebp),%edi
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  char *a = (char *)PGROUNDUP(newsz);
  105c3f:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
  char *last = PGROUNDDOWN(oldsz - 1);
  105c45:	83 ef 01             	sub    $0x1,%edi
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  char *a = (char *)PGROUNDUP(newsz);
  105c48:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  char *last = PGROUNDDOWN(oldsz - 1);
  105c4e:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  for(; a <= last; a += PGSIZE){
  105c54:	39 fe                	cmp    %edi,%esi
  105c56:	77 37                	ja     105c8f <deallocuvm+0x5f>
    pte_t *pte = walkpgdir(pgdir, a, 0);
  105c58:	8b 45 08             	mov    0x8(%ebp),%eax
  105c5b:	31 c9                	xor    %ecx,%ecx
  105c5d:	89 f2                	mov    %esi,%edx
  105c5f:	e8 2c fd ff ff       	call   105990 <walkpgdir>
    if(pte && (*pte & PTE_P) != 0){
  105c64:	85 c0                	test   %eax,%eax
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  char *a = (char *)PGROUNDUP(newsz);
  char *last = PGROUNDDOWN(oldsz - 1);
  for(; a <= last; a += PGSIZE){
    pte_t *pte = walkpgdir(pgdir, a, 0);
  105c66:	89 c3                	mov    %eax,%ebx
    if(pte && (*pte & PTE_P) != 0){
  105c68:	74 1b                	je     105c85 <deallocuvm+0x55>
  105c6a:	8b 00                	mov    (%eax),%eax
  105c6c:	a8 01                	test   $0x1,%al
  105c6e:	74 15                	je     105c85 <deallocuvm+0x55>
      uint pa = PTE_ADDR(*pte);
      if(pa == 0)
  105c70:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  105c75:	74 33                	je     105caa <deallocuvm+0x7a>
        panic("kfree");
      kfree((void *) pa);
  105c77:	89 04 24             	mov    %eax,(%esp)
  105c7a:	e8 31 c5 ff ff       	call   1021b0 <kfree>
      *pte = 0;
  105c7f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  char *a = (char *)PGROUNDUP(newsz);
  char *last = PGROUNDDOWN(oldsz - 1);
  for(; a <= last; a += PGSIZE){
  105c85:	81 c6 00 10 00 00    	add    $0x1000,%esi
  105c8b:	39 f7                	cmp    %esi,%edi
  105c8d:	73 c9                	jae    105c58 <deallocuvm+0x28>
  105c8f:	8b 45 10             	mov    0x10(%ebp),%eax
  105c92:	3b 45 0c             	cmp    0xc(%ebp),%eax
  105c95:	77 08                	ja     105c9f <deallocuvm+0x6f>
      kfree((void *) pa);
      *pte = 0;
    }
  }
  return newsz < oldsz ? newsz : oldsz;
}
  105c97:	83 c4 0c             	add    $0xc,%esp
  105c9a:	5b                   	pop    %ebx
  105c9b:	5e                   	pop    %esi
  105c9c:	5f                   	pop    %edi
  105c9d:	5d                   	pop    %ebp
  105c9e:	c3                   	ret    
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  char *a = (char *)PGROUNDUP(newsz);
  char *last = PGROUNDDOWN(oldsz - 1);
  for(; a <= last; a += PGSIZE){
  105c9f:	8b 45 0c             	mov    0xc(%ebp),%eax
      kfree((void *) pa);
      *pte = 0;
    }
  }
  return newsz < oldsz ? newsz : oldsz;
}
  105ca2:	83 c4 0c             	add    $0xc,%esp
  105ca5:	5b                   	pop    %ebx
  105ca6:	5e                   	pop    %esi
  105ca7:	5f                   	pop    %edi
  105ca8:	5d                   	pop    %ebp
  105ca9:	c3                   	ret    
  for(; a <= last; a += PGSIZE){
    pte_t *pte = walkpgdir(pgdir, a, 0);
    if(pte && (*pte & PTE_P) != 0){
      uint pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
  105caa:	c7 04 24 36 63 10 00 	movl   $0x106336,(%esp)
  105cb1:	e8 ca ab ff ff       	call   100880 <panic>
  105cb6:	8d 76 00             	lea    0x0(%esi),%esi
  105cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00105cc0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
  105cc0:	55                   	push   %ebp
  105cc1:	89 e5                	mov    %esp,%ebp
  105cc3:	56                   	push   %esi
  105cc4:	53                   	push   %ebx
  105cc5:	83 ec 10             	sub    $0x10,%esp
  105cc8:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(!pgdir)
  105ccb:	85 f6                	test   %esi,%esi
  105ccd:	74 59                	je     105d28 <freevm+0x68>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, USERTOP, 0);
  105ccf:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  105cd6:	00 
  105cd7:	31 db                	xor    %ebx,%ebx
  105cd9:	c7 44 24 04 00 00 0a 	movl   $0xa0000,0x4(%esp)
  105ce0:	00 
  105ce1:	89 34 24             	mov    %esi,(%esp)
  105ce4:	e8 47 ff ff ff       	call   105c30 <deallocuvm>
  105ce9:	eb 10                	jmp    105cfb <freevm+0x3b>
  105ceb:	90                   	nop    
  105cec:	8d 74 26 00          	lea    0x0(%esi),%esi
  for(i = 0; i < NPDENTRIES; i++){
  105cf0:	83 c3 01             	add    $0x1,%ebx
  105cf3:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
  105cf9:	74 1f                	je     105d1a <freevm+0x5a>
    if(pgdir[i] & PTE_P)
  105cfb:	8b 04 9e             	mov    (%esi,%ebx,4),%eax
  105cfe:	a8 01                	test   $0x1,%al
  105d00:	74 ee                	je     105cf0 <freevm+0x30>
      kfree((void *) PTE_ADDR(pgdir[i]));
  105d02:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  uint i;

  if(!pgdir)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, USERTOP, 0);
  for(i = 0; i < NPDENTRIES; i++){
  105d07:	83 c3 01             	add    $0x1,%ebx
    if(pgdir[i] & PTE_P)
      kfree((void *) PTE_ADDR(pgdir[i]));
  105d0a:	89 04 24             	mov    %eax,(%esp)
  105d0d:	e8 9e c4 ff ff       	call   1021b0 <kfree>
  uint i;

  if(!pgdir)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, USERTOP, 0);
  for(i = 0; i < NPDENTRIES; i++){
  105d12:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
  105d18:	75 e1                	jne    105cfb <freevm+0x3b>
    if(pgdir[i] & PTE_P)
      kfree((void *) PTE_ADDR(pgdir[i]));
  }
  kfree((void *) pgdir);
  105d1a:	89 75 08             	mov    %esi,0x8(%ebp)
}
  105d1d:	83 c4 10             	add    $0x10,%esp
  105d20:	5b                   	pop    %ebx
  105d21:	5e                   	pop    %esi
  105d22:	5d                   	pop    %ebp
  deallocuvm(pgdir, USERTOP, 0);
  for(i = 0; i < NPDENTRIES; i++){
    if(pgdir[i] & PTE_P)
      kfree((void *) PTE_ADDR(pgdir[i]));
  }
  kfree((void *) pgdir);
  105d23:	e9 88 c4 ff ff       	jmp    1021b0 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(!pgdir)
    panic("freevm: no pgdir");
  105d28:	c7 04 24 a8 69 10 00 	movl   $0x1069a8,(%esp)
  105d2f:	e8 4c ab ff ff       	call   100880 <panic>
  105d34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105d3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105d40 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
  105d40:	55                   	push   %ebp
  105d41:	89 e5                	mov    %esp,%ebp
  105d43:	57                   	push   %edi
  105d44:	56                   	push   %esi
  105d45:	53                   	push   %ebx
  105d46:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d = setupkvm();
  105d49:	e8 12 fe ff ff       	call   105b60 <setupkvm>
  pte_t *pte;
  uint pa, i;
  char *mem;

  if(!d) return 0;
  105d4e:	85 c0                	test   %eax,%eax
// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
  pde_t *d = setupkvm();
  105d50:	89 45 f0             	mov    %eax,-0x10(%ebp)
  pte_t *pte;
  uint pa, i;
  char *mem;

  if(!d) return 0;
  105d53:	0f 84 84 00 00 00    	je     105ddd <copyuvm+0x9d>
  for(i = 0; i < sz; i += PGSIZE){
  105d59:	8b 45 0c             	mov    0xc(%ebp),%eax
  105d5c:	85 c0                	test   %eax,%eax
  105d5e:	74 7d                	je     105ddd <copyuvm+0x9d>
  105d60:	31 ff                	xor    %edi,%edi
  105d62:	eb 43                	jmp    105da7 <copyuvm+0x67>
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present\n");
    pa = PTE_ADDR(*pte);
    if(!(mem = kalloc()))
      goto bad;
    memmove(mem, (char *)pa, PGSIZE);
  105d64:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  105d6a:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  105d71:	00 
  105d72:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  105d76:	89 04 24             	mov    %eax,(%esp)
  105d79:	e8 62 dd ff ff       	call   103ae0 <memmove>
    if(!mappages(d, (void *)i, PGSIZE, PADDR(mem), PTE_W|PTE_U))
  105d7e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105d81:	b9 00 10 00 00       	mov    $0x1000,%ecx
  105d86:	89 fa                	mov    %edi,%edx
  105d88:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
  105d8f:	00 
  105d90:	89 34 24             	mov    %esi,(%esp)
  105d93:	e8 a8 fc ff ff       	call   105a40 <mappages>
  105d98:	85 c0                	test   %eax,%eax
  105d9a:	74 2f                	je     105dcb <copyuvm+0x8b>
  pte_t *pte;
  uint pa, i;
  char *mem;

  if(!d) return 0;
  for(i = 0; i < sz; i += PGSIZE){
  105d9c:	81 c7 00 10 00 00    	add    $0x1000,%edi
  105da2:	39 7d 0c             	cmp    %edi,0xc(%ebp)
  105da5:	76 36                	jbe    105ddd <copyuvm+0x9d>
    if(!(pte = walkpgdir(pgdir, (void *)i, 0)))
  105da7:	8b 45 08             	mov    0x8(%ebp),%eax
  105daa:	31 c9                	xor    %ecx,%ecx
  105dac:	89 fa                	mov    %edi,%edx
  105dae:	e8 dd fb ff ff       	call   105990 <walkpgdir>
  105db3:	85 c0                	test   %eax,%eax
  105db5:	74 31                	je     105de8 <copyuvm+0xa8>
      panic("copyuvm: pte should exist\n");
    if(!(*pte & PTE_P))
  105db7:	8b 18                	mov    (%eax),%ebx
  105db9:	f6 c3 01             	test   $0x1,%bl
  105dbc:	74 36                	je     105df4 <copyuvm+0xb4>
  105dbe:	66 90                	xchg   %ax,%ax
      panic("copyuvm: page not present\n");
    pa = PTE_ADDR(*pte);
    if(!(mem = kalloc()))
  105dc0:	e8 ab c3 ff ff       	call   102170 <kalloc>
  105dc5:	85 c0                	test   %eax,%eax
  105dc7:	89 c6                	mov    %eax,%esi
  105dc9:	75 99                	jne    105d64 <copyuvm+0x24>
      goto bad;
  }
  return d;

bad:
  freevm(d);
  105dcb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105dce:	89 04 24             	mov    %eax,(%esp)
  105dd1:	e8 ea fe ff ff       	call   105cc0 <freevm>
  105dd6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  return 0;
}
  105ddd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105de0:	83 c4 1c             	add    $0x1c,%esp
  105de3:	5b                   	pop    %ebx
  105de4:	5e                   	pop    %esi
  105de5:	5f                   	pop    %edi
  105de6:	5d                   	pop    %ebp
  105de7:	c3                   	ret    
  char *mem;

  if(!d) return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if(!(pte = walkpgdir(pgdir, (void *)i, 0)))
      panic("copyuvm: pte should exist\n");
  105de8:	c7 04 24 b9 69 10 00 	movl   $0x1069b9,(%esp)
  105def:	e8 8c aa ff ff       	call   100880 <panic>
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present\n");
  105df4:	c7 04 24 d4 69 10 00 	movl   $0x1069d4,(%esp)
  105dfb:	e8 80 aa ff ff       	call   100880 <panic>

00105e00 <allocuvm>:
// newsz. Allocates physical memory and page table entries. oldsz and
// newsz need not be page-aligned, nor does newsz have to be larger
// than oldsz.  Returns the new process size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  105e00:	55                   	push   %ebp
  if(newsz > USERTOP)
  105e01:	31 c0                	xor    %eax,%eax
// newsz. Allocates physical memory and page table entries. oldsz and
// newsz need not be page-aligned, nor does newsz have to be larger
// than oldsz.  Returns the new process size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  105e03:	89 e5                	mov    %esp,%ebp
  105e05:	57                   	push   %edi
  105e06:	56                   	push   %esi
  105e07:	53                   	push   %ebx
  105e08:	83 ec 0c             	sub    $0xc,%esp
  if(newsz > USERTOP)
  105e0b:	81 7d 10 00 00 0a 00 	cmpl   $0xa0000,0x10(%ebp)
  105e12:	0f 87 96 00 00 00    	ja     105eae <allocuvm+0xae>
    return 0;
  char *a = (char *)PGROUNDUP(oldsz);
  105e18:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *last = PGROUNDDOWN(newsz - 1);
  105e1b:	8b 7d 10             	mov    0x10(%ebp),%edi
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  if(newsz > USERTOP)
    return 0;
  char *a = (char *)PGROUNDUP(oldsz);
  105e1e:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
  char *last = PGROUNDDOWN(newsz - 1);
  105e24:	83 ef 01             	sub    $0x1,%edi
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  if(newsz > USERTOP)
    return 0;
  char *a = (char *)PGROUNDUP(oldsz);
  105e27:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  char *last = PGROUNDDOWN(newsz - 1);
  105e2d:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  for (; a <= last; a += PGSIZE){
  105e33:	39 fe                	cmp    %edi,%esi
  105e35:	76 45                	jbe    105e7c <allocuvm+0x7c>
  105e37:	eb 7d                	jmp    105eb6 <allocuvm+0xb6>
  105e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
  105e40:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  105e47:	00 
  105e48:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  105e4f:	00 
  105e50:	89 04 24             	mov    %eax,(%esp)
  105e53:	e8 e8 db ff ff       	call   103a40 <memset>
    mappages(pgdir, a, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  105e58:	89 f2                	mov    %esi,%edx
  105e5a:	b9 00 10 00 00       	mov    $0x1000,%ecx
  105e5f:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
  105e66:	00 
{
  if(newsz > USERTOP)
    return 0;
  char *a = (char *)PGROUNDUP(oldsz);
  char *last = PGROUNDDOWN(newsz - 1);
  for (; a <= last; a += PGSIZE){
  105e67:	81 c6 00 10 00 00    	add    $0x1000,%esi
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, a, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  105e6d:	89 1c 24             	mov    %ebx,(%esp)
  105e70:	8b 45 08             	mov    0x8(%ebp),%eax
  105e73:	e8 c8 fb ff ff       	call   105a40 <mappages>
{
  if(newsz > USERTOP)
    return 0;
  char *a = (char *)PGROUNDUP(oldsz);
  char *last = PGROUNDDOWN(newsz - 1);
  for (; a <= last; a += PGSIZE){
  105e78:	39 f7                	cmp    %esi,%edi
  105e7a:	72 3a                	jb     105eb6 <allocuvm+0xb6>
    char *mem = kalloc();
  105e7c:	e8 ef c2 ff ff       	call   102170 <kalloc>
    if(mem == 0){
  105e81:	85 c0                	test   %eax,%eax
  if(newsz > USERTOP)
    return 0;
  char *a = (char *)PGROUNDUP(oldsz);
  char *last = PGROUNDDOWN(newsz - 1);
  for (; a <= last; a += PGSIZE){
    char *mem = kalloc();
  105e83:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
  105e85:	75 b9                	jne    105e40 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
  105e87:	c7 04 24 ef 69 10 00 	movl   $0x1069ef,(%esp)
  105e8e:	e8 2d a6 ff ff       	call   1004c0 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
  105e93:	8b 45 0c             	mov    0xc(%ebp),%eax
  105e96:	89 44 24 08          	mov    %eax,0x8(%esp)
  105e9a:	8b 45 10             	mov    0x10(%ebp),%eax
  105e9d:	89 44 24 04          	mov    %eax,0x4(%esp)
  105ea1:	8b 45 08             	mov    0x8(%ebp),%eax
  105ea4:	89 04 24             	mov    %eax,(%esp)
  105ea7:	e8 84 fd ff ff       	call   105c30 <deallocuvm>
  105eac:	31 c0                	xor    %eax,%eax
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, a, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  }
  return newsz > oldsz ? newsz : oldsz;
}
  105eae:	83 c4 0c             	add    $0xc,%esp
  105eb1:	5b                   	pop    %ebx
  105eb2:	5e                   	pop    %esi
  105eb3:	5f                   	pop    %edi
  105eb4:	5d                   	pop    %ebp
  105eb5:	c3                   	ret    
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, a, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  }
  return newsz > oldsz ? newsz : oldsz;
  105eb6:	8b 45 10             	mov    0x10(%ebp),%eax
  105eb9:	3b 45 0c             	cmp    0xc(%ebp),%eax
  105ebc:	73 f0                	jae    105eae <allocuvm+0xae>
  105ebe:	8b 45 0c             	mov    0xc(%ebp),%eax
}
  105ec1:	83 c4 0c             	add    $0xc,%esp
  105ec4:	5b                   	pop    %ebx
  105ec5:	5e                   	pop    %esi
  105ec6:	5f                   	pop    %edi
  105ec7:	5d                   	pop    %ebp
  105ec8:	c3                   	ret    
  105ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00105ed0 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
  105ed0:	55                   	push   %ebp
  105ed1:	89 e5                	mov    %esp,%ebp
  105ed3:	57                   	push   %edi
  105ed4:	56                   	push   %esi
  105ed5:	53                   	push   %ebx
  105ed6:	83 ec 1c             	sub    $0x1c,%esp
  105ed9:	8b 7d 18             	mov    0x18(%ebp),%edi
  uint i, pa, n;
  pte_t *pte;

  if((uint)addr % PGSIZE != 0)
  105edc:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
  105ee3:	0f 85 82 00 00 00    	jne    105f6b <loaduvm+0x9b>
    panic("loaduvm: addr must be page aligned\n");
  105ee9:	31 f6                	xor    %esi,%esi
  for(i = 0; i < sz; i += PGSIZE){
  105eeb:	85 ff                	test   %edi,%edi
  105eed:	75 0c                	jne    105efb <loaduvm+0x2b>
  105eef:	eb 61                	jmp    105f52 <loaduvm+0x82>
  105ef1:	81 c6 00 10 00 00    	add    $0x1000,%esi
  105ef7:	39 f7                	cmp    %esi,%edi
  105ef9:	76 57                	jbe    105f52 <loaduvm+0x82>
    if(!(pte = walkpgdir(pgdir, addr+i, 0)))
  105efb:	8b 55 0c             	mov    0xc(%ebp),%edx
  105efe:	31 c9                	xor    %ecx,%ecx
  105f00:	8b 45 08             	mov    0x8(%ebp),%eax
  105f03:	01 f2                	add    %esi,%edx
  105f05:	e8 86 fa ff ff       	call   105990 <walkpgdir>
  105f0a:	85 c0                	test   %eax,%eax
  105f0c:	74 51                	je     105f5f <loaduvm+0x8f>
      panic("loaduvm: address should exist\n");
    pa = PTE_ADDR(*pte);
  105f0e:	89 fb                	mov    %edi,%ebx
  105f10:	8b 10                	mov    (%eax),%edx
  105f12:	29 f3                	sub    %esi,%ebx
    if(sz - i < PGSIZE) n = sz - i;
  105f14:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
  105f1a:	76 05                	jbe    105f21 <loaduvm+0x51>
  105f1c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    else n = PGSIZE;
    if(readi(ip, (char *)pa, offset+i, n) != n)
  105f21:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  105f25:	8b 4d 14             	mov    0x14(%ebp),%ecx
  105f28:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  105f2e:	89 54 24 04          	mov    %edx,0x4(%esp)
  105f32:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
  105f35:	89 44 24 08          	mov    %eax,0x8(%esp)
  105f39:	8b 45 10             	mov    0x10(%ebp),%eax
  105f3c:	89 04 24             	mov    %eax,(%esp)
  105f3f:	e8 1c b5 ff ff       	call   101460 <readi>
  105f44:	39 d8                	cmp    %ebx,%eax
  105f46:	74 a9                	je     105ef1 <loaduvm+0x21>
      return 0;
  }
  return 1;
}
  105f48:	83 c4 1c             	add    $0x1c,%esp
    if(!(pte = walkpgdir(pgdir, addr+i, 0)))
      panic("loaduvm: address should exist\n");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE) n = sz - i;
    else n = PGSIZE;
    if(readi(ip, (char *)pa, offset+i, n) != n)
  105f4b:	31 c0                	xor    %eax,%eax
      return 0;
  }
  return 1;
}
  105f4d:	5b                   	pop    %ebx
  105f4e:	5e                   	pop    %esi
  105f4f:	5f                   	pop    %edi
  105f50:	5d                   	pop    %ebp
  105f51:	c3                   	ret    
  105f52:	83 c4 1c             	add    $0x1c,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint)addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned\n");
  for(i = 0; i < sz; i += PGSIZE){
  105f55:	b8 01 00 00 00       	mov    $0x1,%eax
    else n = PGSIZE;
    if(readi(ip, (char *)pa, offset+i, n) != n)
      return 0;
  }
  return 1;
}
  105f5a:	5b                   	pop    %ebx
  105f5b:	5e                   	pop    %esi
  105f5c:	5f                   	pop    %edi
  105f5d:	5d                   	pop    %ebp
  105f5e:	c3                   	ret    

  if((uint)addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned\n");
  for(i = 0; i < sz; i += PGSIZE){
    if(!(pte = walkpgdir(pgdir, addr+i, 0)))
      panic("loaduvm: address should exist\n");
  105f5f:	c7 04 24 40 6a 10 00 	movl   $0x106a40,(%esp)
  105f66:	e8 15 a9 ff ff       	call   100880 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint)addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned\n");
  105f6b:	c7 04 24 1c 6a 10 00 	movl   $0x106a1c,(%esp)
  105f72:	e8 09 a9 ff ff       	call   100880 <panic>
  105f77:	89 f6                	mov    %esi,%esi
  105f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00105f80 <switchuvm>:
}

// Switch h/w page table and TSS registers to point to process p.
void
switchuvm(struct proc *p)
{
  105f80:	55                   	push   %ebp
  105f81:	89 e5                	mov    %esp,%ebp
  105f83:	53                   	push   %ebx
  105f84:	83 ec 04             	sub    $0x4,%esp
  105f87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
  105f8a:	e8 61 d9 ff ff       	call   1038f0 <pushcli>

  // Setup TSS
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
  105f8f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  105f95:	8d 48 08             	lea    0x8(%eax),%ecx
  105f98:	89 ca                	mov    %ecx,%edx
  105f9a:	c1 ea 18             	shr    $0x18,%edx
  105f9d:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
  105fa3:	89 ca                	mov    %ecx,%edx
  105fa5:	c1 ea 10             	shr    $0x10,%edx
  105fa8:	c6 80 a5 00 00 00 99 	movb   $0x99,0xa5(%eax)
  105faf:	88 90 a4 00 00 00    	mov    %dl,0xa4(%eax)
  105fb5:	c6 80 a6 00 00 00 40 	movb   $0x40,0xa6(%eax)
  105fbc:	66 89 88 a2 00 00 00 	mov    %cx,0xa2(%eax)
  105fc3:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
  105fca:	67 00 
  cpu->gdt[SEG_TSS].s = 0;
  105fcc:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  105fd2:	80 a0 a5 00 00 00 ef 	andb   $0xef,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
  105fd9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  105fdf:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
  105fe5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  105feb:	8b 50 08             	mov    0x8(%eax),%edx
  105fee:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  105ff4:	81 c2 00 10 00 00    	add    $0x1000,%edx
  105ffa:	89 50 0c             	mov    %edx,0xc(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
  105ffd:	b8 30 00 00 00       	mov    $0x30,%eax
  106002:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);

  if(p->pgdir == 0)
  106005:	8b 43 04             	mov    0x4(%ebx),%eax
  106008:	85 c0                	test   %eax,%eax
  10600a:	74 0d                	je     106019 <switchuvm+0x99>
}

static inline void
lcr3(uint val) 
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
  10600c:	0f 22 d8             	mov    %eax,%cr3
    panic("switchuvm: no pgdir\n");

  lcr3(PADDR(p->pgdir));  // switch to new address space
  popcli();
}
  10600f:	83 c4 04             	add    $0x4,%esp
  106012:	5b                   	pop    %ebx
  106013:	5d                   	pop    %ebp

  if(p->pgdir == 0)
    panic("switchuvm: no pgdir\n");

  lcr3(PADDR(p->pgdir));  // switch to new address space
  popcli();
  106014:	e9 17 d9 ff ff       	jmp    103930 <popcli>
  cpu->ts.ss0 = SEG_KDATA << 3;
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
  ltr(SEG_TSS << 3);

  if(p->pgdir == 0)
    panic("switchuvm: no pgdir\n");
  106019:	c7 04 24 07 6a 10 00 	movl   $0x106a07,(%esp)
  106020:	e8 5b a8 ff ff       	call   100880 <panic>
  106025:	8d 74 26 00          	lea    0x0(%esi),%esi
  106029:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00106030 <ksegment>:

// Set up CPU's kernel segment descriptors.
// Run once at boot time on each CPU.
void
ksegment(void)
{
  106030:	55                   	push   %ebp
  106031:	89 e5                	mov    %esp,%ebp
  106033:	83 ec 18             	sub    $0x18,%esp

  // Map virtual addresses to linear addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  106036:	e8 85 c3 ff ff       	call   1023c0 <cpunum>
  10603b:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
  106041:	05 a0 aa 10 00       	add    $0x10aaa0,%eax
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
  106046:	8d 88 b4 00 00 00    	lea    0xb4(%eax),%ecx
  10604c:	89 ca                	mov    %ecx,%edx
  10604e:	c1 ea 18             	shr    $0x18,%edx
  106051:	88 90 8f 00 00 00    	mov    %dl,0x8f(%eax)
  106057:	89 ca                	mov    %ecx,%edx
  106059:	c1 ea 10             	shr    $0x10,%edx
  10605c:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
  106062:	8d 50 70             	lea    0x70(%eax),%edx
  // Map virtual addresses to linear addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  106065:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  106069:	c6 40 7e cf          	movb   $0xcf,0x7e(%eax)
  10606d:	c6 40 7d 9a          	movb   $0x9a,0x7d(%eax)
  106071:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
  106075:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
  10607b:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  106081:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  106088:	c6 80 86 00 00 00 cf 	movb   $0xcf,0x86(%eax)
  10608f:	c6 80 85 00 00 00 92 	movb   $0x92,0x85(%eax)
  106096:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
  10609d:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
  1060a4:	00 00 
  1060a6:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
  1060ad:	ff ff 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  1060af:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  1060b6:	c6 80 96 00 00 00 cf 	movb   $0xcf,0x96(%eax)
  1060bd:	c6 80 95 00 00 00 fa 	movb   $0xfa,0x95(%eax)
  1060c4:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
  1060cb:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
  1060d2:	00 00 
  1060d4:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
  1060db:	ff ff 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
  1060dd:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)
  1060e4:	c6 80 9e 00 00 00 cf 	movb   $0xcf,0x9e(%eax)
  1060eb:	c6 80 9d 00 00 00 f2 	movb   $0xf2,0x9d(%eax)
  1060f2:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
  1060f9:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
  106100:	00 00 
  106102:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
  106109:	ff ff 

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
  10610b:	c6 80 8e 00 00 00 c0 	movb   $0xc0,0x8e(%eax)
  106112:	c6 80 8d 00 00 00 92 	movb   $0x92,0x8d(%eax)
  106119:	66 89 88 8a 00 00 00 	mov    %cx,0x8a(%eax)
  106120:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
  106127:	00 00 
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  106129:	66 c7 45 fa 37 00    	movw   $0x37,-0x6(%ebp)
  pd[1] = (uint)p;
  10612f:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
  106133:	c1 ea 10             	shr    $0x10,%edx
  106136:	66 89 55 fe          	mov    %dx,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
  10613a:	8d 55 fa             	lea    -0x6(%ebp),%edx
  10613d:	0f 01 12             	lgdtl  (%edx)
}

static inline void
loadgs(ushort v)
{
  asm volatile("movw %0, %%gs" : : "r" (v));
  106140:	ba 18 00 00 00       	mov    $0x18,%edx
  106145:	8e ea                	mov    %edx,%gs
  lgdt(c->gdt, sizeof(c->gdt));
  loadgs(SEG_KCPU << 3);
  
  // Initialize cpu-local storage.
  cpu = c;
  proc = 0;
  106147:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
  10614e:	00 00 00 00 

  lgdt(c->gdt, sizeof(c->gdt));
  loadgs(SEG_KCPU << 3);
  
  // Initialize cpu-local storage.
  cpu = c;
  106152:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
}
  106158:	c9                   	leave  
  106159:	c3                   	ret    
