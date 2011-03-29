
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
  100016:	e8 f5 39 00 00       	call   103a10 <acquire>

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
  10004d:	e8 ae 2f 00 00       	call   103000 <wakeup>

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
  10005e:	e9 6d 39 00 00       	jmp    1039d0 <release>
// Release the buffer b.
void
brelse(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("brelse");
  100063:	c7 04 24 a0 61 10 00 	movl   $0x1061a0,(%esp)
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
  10008d:	c7 04 24 a7 61 10 00 	movl   $0x1061a7,(%esp)
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
  1000b6:	e8 55 39 00 00       	call   103a10 <acquire>

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
  1000f8:	e8 f3 2f 00 00       	call   1030f0 <sleep>
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
  100135:	e8 96 38 00 00       	call   1039d0 <release>
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
  10015b:	c7 04 24 ae 61 10 00 	movl   $0x1061ae,(%esp)
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
  100173:	e8 58 38 00 00       	call   1039d0 <release>
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
  100186:	c7 44 24 04 bf 61 10 	movl   $0x1061bf,0x4(%esp)
  10018d:	00 
  10018e:	c7 04 24 60 78 10 00 	movl   $0x107860,(%esp)
  100195:	e8 f6 36 00 00       	call   103890 <initlock>

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
  1001f6:	c7 44 24 04 c6 61 10 	movl   $0x1061c6,0x4(%esp)
  1001fd:	00 
  1001fe:	c7 04 24 c0 77 10 00 	movl   $0x1077c0,(%esp)
  100205:	e8 86 36 00 00       	call   103890 <initlock>
  initlock(&input.lock, "input");
  10020a:	c7 44 24 04 ce 61 10 	movl   $0x1061ce,0x4(%esp)
  100211:	00 
  100212:	c7 04 24 a0 8f 10 00 	movl   $0x108fa0,(%esp)
  100219:	e8 72 36 00 00       	call   103890 <initlock>

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
  100243:	e8 b8 28 00 00       	call   102b00 <picenable>
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
  100286:	e8 65 4b 00 00       	call   104df0 <uartputc>
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
  100329:	e8 c2 4a 00 00       	call   104df0 <uartputc>
  10032e:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  100335:	e8 b6 4a 00 00       	call   104df0 <uartputc>
  10033a:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  100341:	e8 aa 4a 00 00       	call   104df0 <uartputc>
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
  10036c:	e8 af 37 00 00       	call   103b20 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  100371:	b8 80 07 00 00       	mov    $0x780,%eax
  100376:	29 d8                	sub    %ebx,%eax
  100378:	01 c0                	add    %eax,%eax
  10037a:	89 44 24 08          	mov    %eax,0x8(%esp)
  10037e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100385:	00 
  100386:	89 34 24             	mov    %esi,(%esp)
  100389:	e8 f2 36 00 00       	call   103a80 <memset>
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
  1003f1:	e8 1a 36 00 00       	call   103a10 <acquire>
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
  100417:	e8 b4 35 00 00       	call   1039d0 <release>
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
  100466:	0f b6 82 ee 61 10 00 	movzbl 0x1061ee(%edx),%eax
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
  100577:	e8 54 34 00 00       	call   1039d0 <release>
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
  1005c0:	ba d4 61 10 00       	mov    $0x1061d4,%edx
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
  1005f7:	e8 14 34 00 00       	call   103a10 <acquire>
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
  100633:	e8 d8 33 00 00       	call   103a10 <acquire>
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
  10065d:	e8 8e 2a 00 00       	call   1030f0 <sleep>

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
  1006a8:	e8 23 33 00 00       	call   1039d0 <release>
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
  1006d7:	e8 f4 32 00 00       	call   1039d0 <release>
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
  100712:	e8 f9 32 00 00       	call   103a10 <acquire>
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
  1007b5:	e8 46 28 00 00       	call   103000 <wakeup>
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
  1007d3:	e9 f8 31 00 00       	jmp    1039d0 <release>
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
  100847:	e8 64 2f 00 00       	call   1037b0 <procdump>
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
  1008a4:	c7 04 24 db 61 10 00 	movl   $0x1061db,(%esp)
  1008ab:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008af:	e8 0c fc ff ff       	call   1004c0 <cprintf>
  cprintf(s);
  1008b4:	8b 45 08             	mov    0x8(%ebp),%eax
  1008b7:	89 04 24             	mov    %eax,(%esp)
  1008ba:	e8 01 fc ff ff       	call   1004c0 <cprintf>
  cprintf("\n");
  1008bf:	c7 04 24 16 66 10 00 	movl   $0x106616,(%esp)
  1008c6:	e8 f5 fb ff ff       	call   1004c0 <cprintf>
  getcallerpcs(&s, pcs);
  1008cb:	8d 45 08             	lea    0x8(%ebp),%eax
  1008ce:	89 04 24             	mov    %eax,(%esp)
  1008d1:	89 74 24 04          	mov    %esi,0x4(%esp)
  1008d5:	e8 d6 2f 00 00       	call   1038b0 <getcallerpcs>
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
  1008da:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1008dd:	c7 04 24 ea 61 10 00 	movl   $0x1061ea,(%esp)
  1008e4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008e8:	e8 d3 fb ff ff       	call   1004c0 <cprintf>
  1008ed:	8b 44 9e fc          	mov    -0x4(%esi,%ebx,4),%eax
  1008f1:	83 c3 01             	add    $0x1,%ebx
  1008f4:	c7 04 24 ea 61 10 00 	movl   $0x1061ea,(%esp)
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
  10098f:	e8 0c 52 00 00       	call   105ba0 <setupkvm>
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
  100a16:	e8 25 54 00 00       	call   105e40 <allocuvm>
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
  100a44:	e8 c7 54 00 00       	call   105f10 <loaduvm>
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
  100a61:	e8 9a 52 00 00       	call   105d00 <freevm>
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
  100a9e:	e8 9d 53 00 00       	call   105e40 <allocuvm>
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
  100abe:	e8 8d 4f 00 00       	call   105a50 <uva2ka>

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
  100adc:	e8 9f 31 00 00       	call   103c80 <strlen>
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
  100b4e:	e8 2d 31 00 00       	call   103c80 <strlen>
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
  100b73:	e8 a8 2f 00 00       	call   103b20 <memmove>
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
  100bf8:	e8 43 30 00 00       	call   103c40 <safestrcpy>

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
  100c3e:	e8 7d 53 00 00       	call   105fc0 <switchuvm>

  freevm(oldpgdir);
  100c43:	89 1c 24             	mov    %ebx,(%esp)
  100c46:	e8 b5 50 00 00       	call   105d00 <freevm>
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
  100cfb:	e9 d0 1f 00 00       	jmp    102cd0 <pipewrite>
    if((r = writei(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
  100d00:	c7 04 24 ff 61 10 00 	movl   $0x1061ff,(%esp)
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
  100d9b:	e9 30 1e 00 00       	jmp    102bd0 <piperead>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
  100da0:	c7 04 24 09 62 10 00 	movl   $0x106209,(%esp)
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
  100e11:	e8 fa 2b 00 00       	call   103a10 <acquire>
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
  100e2a:	e8 a1 2b 00 00       	call   1039d0 <release>
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
  100e37:	c7 04 24 12 62 10 00 	movl   $0x106212,(%esp)
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
  100e63:	e8 a8 2b 00 00       	call   103a10 <acquire>
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
  100e90:	e8 3b 2b 00 00       	call   1039d0 <release>
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
  100ea6:	e8 25 2b 00 00       	call   1039d0 <release>
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
  100ed9:	e8 32 2b 00 00       	call   103a10 <acquire>
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
  100f06:	e9 c5 2a 00 00       	jmp    1039d0 <release>
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
  100f36:	e8 95 2a 00 00       	call   1039d0 <release>
  
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
  100f61:	e8 4a 1e 00 00       	call   102db0 <pipeclose>
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
  100f7f:	c7 04 24 1a 62 10 00 	movl   $0x10621a,(%esp)
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
  100f96:	c7 44 24 04 24 62 10 	movl   $0x106224,0x4(%esp)
  100f9d:	00 
  100f9e:	c7 04 24 60 90 10 00 	movl   $0x109060,(%esp)
  100fa5:	e8 e6 28 00 00       	call   103890 <initlock>
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
  100ff1:	e8 1a 2a 00 00       	call   103a10 <acquire>
  ip->ref++;
  100ff6:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
  100ffa:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  101001:	e8 ca 29 00 00       	call   1039d0 <release>
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
  10102c:	e8 df 29 00 00       	call   103a10 <acquire>
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
  101062:	e8 69 29 00 00       	call   1039d0 <release>
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
  1010a5:	e8 26 29 00 00       	call   1039d0 <release>

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
  1010b4:	c7 04 24 2b 62 10 00 	movl   $0x10622b,(%esp)
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
  1010f2:	e8 29 2a 00 00       	call   103b20 <memmove>
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
  10117b:	e8 a0 29 00 00       	call   103b20 <memmove>
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
  101265:	c7 04 24 3b 62 10 00 	movl   $0x10623b,(%esp)
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
  10131c:	c7 04 24 51 62 10 00 	movl   $0x106251,(%esp)
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
  101415:	e8 06 27 00 00       	call   103b20 <memmove>
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
  10153f:	e8 dc 25 00 00       	call   103b20 <memmove>
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
  10158b:	e8 00 26 00 00       	call   103b90 <strncmp>
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
  101693:	c7 04 24 64 62 10 00 	movl   $0x106264,(%esp)
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
  1016c2:	e8 49 23 00 00       	call   103a10 <acquire>
  ip->flags &= ~I_BUSY;
  1016c7:	83 63 0c fe          	andl   $0xfffffffe,0xc(%ebx)
  wakeup(ip);
  1016cb:	89 1c 24             	mov    %ebx,(%esp)
  1016ce:	e8 2d 19 00 00       	call   103000 <wakeup>
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
  1016df:	e9 ec 22 00 00       	jmp    1039d0 <release>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
    panic("iunlock");
  1016e4:	c7 04 24 76 62 10 00 	movl   $0x106276,(%esp)
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
  101776:	e8 05 23 00 00       	call   103a80 <memset>
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
  1017a4:	c7 04 24 7e 62 10 00 	movl   $0x10627e,(%esp)
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
  1017e1:	e8 9a 22 00 00       	call   103a80 <memset>
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
  101863:	c7 04 24 90 62 10 00 	movl   $0x106290,(%esp)
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
  101883:	e8 88 21 00 00       	call   103a10 <acquire>
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
  1018bf:	e8 0c 21 00 00       	call   1039d0 <release>
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
  101918:	e8 f3 20 00 00       	call   103a10 <acquire>
    ip->flags = 0;
  10191d:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    wakeup(ip);
  101924:	89 34 24             	mov    %esi,(%esp)
  101927:	e8 d4 16 00 00       	call   103000 <wakeup>
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
  101942:	e9 89 20 00 00       	jmp    1039d0 <release>
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
  1019a3:	c7 04 24 a3 62 10 00 	movl   $0x1062a3,(%esp)
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
  101a31:	e8 ba 21 00 00       	call   103bf0 <strncpy>
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
  101a67:	c7 04 24 ad 62 10 00 	movl   $0x1062ad,(%esp)
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
  101a89:	c7 04 24 62 68 10 00 	movl   $0x106862,(%esp)
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
  101ae5:	e8 26 1f 00 00       	call   103a10 <acquire>
  while(ip->flags & I_BUSY)
  101aea:	8b 46 0c             	mov    0xc(%esi),%eax
  101aed:	a8 01                	test   $0x1,%al
  101aef:	74 17                	je     101b08 <ilock+0x48>
    sleep(ip, &icache.lock);
  101af1:	c7 44 24 04 60 9a 10 	movl   $0x109a60,0x4(%esp)
  101af8:	00 
  101af9:	89 34 24             	mov    %esi,(%esp)
  101afc:	e8 ef 15 00 00       	call   1030f0 <sleep>

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
  101b15:	e8 b6 1e 00 00       	call   1039d0 <release>

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
  101b87:	e8 94 1f 00 00       	call   103b20 <memmove>
    brelse(bp);
  101b8c:	89 1c 24             	mov    %ebx,(%esp)
  101b8f:	e8 6c e4 ff ff       	call   100000 <brelse>
    ip->flags |= I_VALID;
  101b94:	83 4e 0c 02          	orl    $0x2,0xc(%esi)
    if(ip->type == 0)
  101b98:	66 83 7e 10 00       	cmpw   $0x0,0x10(%esi)
  101b9d:	75 81                	jne    101b20 <ilock+0x60>
      panic("ilock: no type");
  101b9f:	c7 04 24 c0 62 10 00 	movl   $0x1062c0,(%esp)
  101ba6:	e8 d5 ec ff ff       	call   100880 <panic>
  101bab:	90                   	nop    
  101bac:	8d 74 26 00          	lea    0x0(%esi),%esi
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
  101bb0:	c7 04 24 ba 62 10 00 	movl   $0x1062ba,(%esp)
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
  101c31:	e8 ea 1e 00 00       	call   103b20 <memmove>
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
  101cac:	e8 6f 1e 00 00       	call   103b20 <memmove>
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
  101d76:	c7 44 24 04 cf 62 10 	movl   $0x1062cf,0x4(%esp)
  101d7d:	00 
  101d7e:	c7 04 24 60 9a 10 00 	movl   $0x109a60,(%esp)
  101d85:	e8 06 1b 00 00       	call   103890 <initlock>
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
  101e53:	c7 04 24 d6 62 10 00 	movl   $0x1062d6,(%esp)
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
  101e9b:	e8 70 1b 00 00       	call   103a10 <acquire>

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
  101edb:	e8 10 12 00 00       	call   1030f0 <sleep>
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
  101ef6:	e9 d5 1a 00 00       	jmp    1039d0 <release>
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
  101f04:	c7 04 24 df 62 10 00 	movl   $0x1062df,(%esp)
  101f0b:	e8 70 e9 ff ff       	call   100880 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  101f10:	c7 04 24 f3 62 10 00 	movl   $0x1062f3,(%esp)
  101f17:	e8 64 e9 ff ff       	call   100880 <panic>
  if(b->dev != 0 && !havedisk1)
    panic("idrw: ide disk 1 not present");
  101f1c:	c7 04 24 08 63 10 00 	movl   $0x106308,(%esp)
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
  101f3f:	e8 cc 1a 00 00       	call   103a10 <acquire>
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
  101f68:	e8 93 10 00 00       	call   103000 <wakeup>
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
  101f6d:	a1 34 78 10 00       	mov    0x107834,%eax
  101f72:	85 c0                	test   %eax,%eax
  101f74:	74 05                	je     101f7b <ideintr+0x4b>
    idestart(idequeue);
  101f76:	e8 45 fe ff ff       	call   101dc0 <idestart>

  release(&idelock);
  101f7b:	c7 04 24 00 78 10 00 	movl   $0x107800,(%esp)
  101f82:	e8 49 1a 00 00       	call   1039d0 <release>
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
  101fb7:	e8 14 1a 00 00       	call   1039d0 <release>
    cprintf("Spurious IDE interrupt.\n");
  101fbc:	c7 04 24 25 63 10 00 	movl   $0x106325,(%esp)
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
  101fd6:	c7 44 24 04 3e 63 10 	movl   $0x10633e,0x4(%esp)
  101fdd:	00 
  101fde:	c7 04 24 00 78 10 00 	movl   $0x107800,(%esp)
  101fe5:	e8 a6 18 00 00       	call   103890 <initlock>
  picenable(IRQ_IDE);
  101fea:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  101ff1:	e8 0a 0b 00 00       	call   102b00 <picenable>
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
  10212f:	c7 04 24 44 63 10 00 	movl   $0x106344,(%esp)
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

00102170 <sys_freepages>:
}

// Count the number of free physical pages.
int
sys_freepages()
{
  102170:	55                   	push   %ebp
  102171:	89 e5                	mov    %esp,%ebp
  102173:	53                   	push   %ebx
  struct run *r;
  int num = 0;

  acquire(&kmem.lock);
  for (r = kmem.freelist; r; r = r->next)
  102174:	31 db                	xor    %ebx,%ebx
}

// Count the number of free physical pages.
int
sys_freepages()
{
  102176:	83 ec 04             	sub    $0x4,%esp
  struct run *r;
  int num = 0;

  acquire(&kmem.lock);
  102179:	c7 04 24 40 aa 10 00 	movl   $0x10aa40,(%esp)
  102180:	e8 8b 18 00 00       	call   103a10 <acquire>
  for (r = kmem.freelist; r; r = r->next)
  102185:	a1 74 aa 10 00       	mov    0x10aa74,%eax
  10218a:	85 c0                	test   %eax,%eax
  10218c:	74 0b                	je     102199 <sys_freepages+0x29>
  10218e:	66 90                	xchg   %ax,%ax
  102190:	8b 00                	mov    (%eax),%eax
    ++num;
  102192:	83 c3 01             	add    $0x1,%ebx
{
  struct run *r;
  int num = 0;

  acquire(&kmem.lock);
  for (r = kmem.freelist; r; r = r->next)
  102195:	85 c0                	test   %eax,%eax
  102197:	75 f7                	jne    102190 <sys_freepages+0x20>
    ++num;
  release(&kmem.lock);
  102199:	c7 04 24 40 aa 10 00 	movl   $0x10aa40,(%esp)
  1021a0:	e8 2b 18 00 00       	call   1039d0 <release>

  return num;
}
  1021a5:	89 d8                	mov    %ebx,%eax
  1021a7:	83 c4 04             	add    $0x4,%esp
  1021aa:	5b                   	pop    %ebx
  1021ab:	5d                   	pop    %ebp
  1021ac:	c3                   	ret    
  1021ad:	8d 76 00             	lea    0x0(%esi),%esi

001021b0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc()
{
  1021b0:	55                   	push   %ebp
  1021b1:	89 e5                	mov    %esp,%ebp
  1021b3:	53                   	push   %ebx
  1021b4:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  acquire(&kmem.lock);
  1021b7:	c7 04 24 40 aa 10 00 	movl   $0x10aa40,(%esp)
  1021be:	e8 4d 18 00 00       	call   103a10 <acquire>
  r = kmem.freelist;
  1021c3:	8b 1d 74 aa 10 00    	mov    0x10aa74,%ebx
  if(r)
  1021c9:	85 db                	test   %ebx,%ebx
  1021cb:	74 07                	je     1021d4 <kalloc+0x24>
    kmem.freelist = r->next;
  1021cd:	8b 03                	mov    (%ebx),%eax
  1021cf:	a3 74 aa 10 00       	mov    %eax,0x10aa74
  release(&kmem.lock);
  1021d4:	c7 04 24 40 aa 10 00 	movl   $0x10aa40,(%esp)
  1021db:	e8 f0 17 00 00       	call   1039d0 <release>
  return (char*) r;
}
  1021e0:	89 d8                	mov    %ebx,%eax
  1021e2:	83 c4 04             	add    $0x4,%esp
  1021e5:	5b                   	pop    %ebx
  1021e6:	5d                   	pop    %ebp
  1021e7:	c3                   	ret    
  1021e8:	90                   	nop    
  1021e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

001021f0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
  1021f0:	55                   	push   %ebp
  1021f1:	89 e5                	mov    %esp,%ebp
  1021f3:	53                   	push   %ebx
  1021f4:	83 ec 14             	sub    $0x14,%esp
  1021f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if(((uint) v) % PGSIZE || (uint)v < 1024*1024 || (uint)v >= PHYSTOP) 
  1021fa:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
  102200:	75 10                	jne    102212 <kfree+0x22>
  102202:	81 fb ff ff 0f 00    	cmp    $0xfffff,%ebx
  102208:	76 08                	jbe    102212 <kfree+0x22>
  10220a:	81 fb ff ff ff 00    	cmp    $0xffffff,%ebx
  102210:	76 0e                	jbe    102220 <kfree+0x30>
    panic("kfree");
  102212:	c7 04 24 76 63 10 00 	movl   $0x106376,(%esp)
  102219:	e8 62 e6 ff ff       	call   100880 <panic>
  10221e:	66 90                	xchg   %ax,%ax

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
  102220:	89 1c 24             	mov    %ebx,(%esp)
  102223:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  10222a:	00 
  10222b:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  102232:	00 
  102233:	e8 48 18 00 00       	call   103a80 <memset>

  acquire(&kmem.lock);
  102238:	c7 04 24 40 aa 10 00 	movl   $0x10aa40,(%esp)
  10223f:	e8 cc 17 00 00       	call   103a10 <acquire>
  r = (struct run *) v;
  r->next = kmem.freelist;
  102244:	a1 74 aa 10 00       	mov    0x10aa74,%eax
  102249:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  10224b:	89 1d 74 aa 10 00    	mov    %ebx,0x10aa74
  release(&kmem.lock);
  102251:	c7 45 08 40 aa 10 00 	movl   $0x10aa40,0x8(%ebp)
}
  102258:	83 c4 14             	add    $0x14,%esp
  10225b:	5b                   	pop    %ebx
  10225c:	5d                   	pop    %ebp

  acquire(&kmem.lock);
  r = (struct run *) v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  release(&kmem.lock);
  10225d:	e9 6e 17 00 00       	jmp    1039d0 <release>
  102262:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  102269:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00102270 <kinit>:
} kmem;

// Initialize free list of physical pages.
void
kinit(void)
{
  102270:	55                   	push   %ebp
  102271:	89 e5                	mov    %esp,%ebp
  102273:	53                   	push   %ebx
  extern char end[];

  initlock(&kmem.lock, "kmem");
  char *p = (char*)PGROUNDUP((uint)end);
  102274:	bb 23 e8 10 00       	mov    $0x10e823,%ebx
} kmem;

// Initialize free list of physical pages.
void
kinit(void)
{
  102279:	83 ec 14             	sub    $0x14,%esp
  extern char end[];

  initlock(&kmem.lock, "kmem");
  char *p = (char*)PGROUNDUP((uint)end);
  10227c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
void
kinit(void)
{
  extern char end[];

  initlock(&kmem.lock, "kmem");
  102282:	c7 44 24 04 7c 63 10 	movl   $0x10637c,0x4(%esp)
  102289:	00 
  10228a:	c7 04 24 40 aa 10 00 	movl   $0x10aa40,(%esp)
  102291:	e8 fa 15 00 00       	call   103890 <initlock>
  char *p = (char*)PGROUNDUP((uint)end);
  for( ; p + PGSIZE - 1 < (char*) PHYSTOP; p += PGSIZE)
  102296:	8d 83 ff 0f 00 00    	lea    0xfff(%ebx),%eax
  10229c:	3d ff ff ff 00       	cmp    $0xffffff,%eax
  1022a1:	77 1b                	ja     1022be <kinit+0x4e>
    kfree(p);
  1022a3:	89 1c 24             	mov    %ebx,(%esp)
{
  extern char end[];

  initlock(&kmem.lock, "kmem");
  char *p = (char*)PGROUNDUP((uint)end);
  for( ; p + PGSIZE - 1 < (char*) PHYSTOP; p += PGSIZE)
  1022a6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
  1022ac:	e8 3f ff ff ff       	call   1021f0 <kfree>
{
  extern char end[];

  initlock(&kmem.lock, "kmem");
  char *p = (char*)PGROUNDUP((uint)end);
  for( ; p + PGSIZE - 1 < (char*) PHYSTOP; p += PGSIZE)
  1022b1:	8d 83 ff 0f 00 00    	lea    0xfff(%ebx),%eax
  1022b7:	3d ff ff ff 00       	cmp    $0xffffff,%eax
  1022bc:	76 e5                	jbe    1022a3 <kinit+0x33>
    kfree(p);
}
  1022be:	83 c4 14             	add    $0x14,%esp
  1022c1:	5b                   	pop    %ebx
  1022c2:	5d                   	pop    %ebp
  1022c3:	c3                   	ret    
  1022c4:	90                   	nop    
  1022c5:	90                   	nop    
  1022c6:	90                   	nop    
  1022c7:	90                   	nop    
  1022c8:	90                   	nop    
  1022c9:	90                   	nop    
  1022ca:	90                   	nop    
  1022cb:	90                   	nop    
  1022cc:	90                   	nop    
  1022cd:	90                   	nop    
  1022ce:	90                   	nop    
  1022cf:	90                   	nop    

001022d0 <kbdintr>:
  return c;
}

void
kbdintr(void)
{
  1022d0:	55                   	push   %ebp
  1022d1:	89 e5                	mov    %esp,%ebp
  1022d3:	83 ec 08             	sub    $0x8,%esp
  consoleintr(kbdgetc);
  1022d6:	c7 04 24 f0 22 10 00 	movl   $0x1022f0,(%esp)
  1022dd:	e8 1e e4 ff ff       	call   100700 <consoleintr>
}
  1022e2:	c9                   	leave  
  1022e3:	c3                   	ret    
  1022e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1022ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001022f0 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
  1022f0:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1022f1:	ba 64 00 00 00       	mov    $0x64,%edx
  1022f6:	89 e5                	mov    %esp,%ebp
  1022f8:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
  1022f9:	a8 01                	test   $0x1,%al
  1022fb:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  102300:	74 3e                	je     102340 <kbdgetc+0x50>
  102302:	ba 60 00 00 00       	mov    $0x60,%edx
  102307:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
  102308:	3c e0                	cmp    $0xe0,%al
  10230a:	0f 84 84 00 00 00    	je     102394 <kbdgetc+0xa4>
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);
  102310:	0f b6 c8             	movzbl %al,%ecx

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
  102313:	84 c9                	test   %cl,%cl
  102315:	79 2d                	jns    102344 <kbdgetc+0x54>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
  102317:	8b 15 3c 78 10 00    	mov    0x10783c,%edx
  10231d:	f6 c2 40             	test   $0x40,%dl
  102320:	75 03                	jne    102325 <kbdgetc+0x35>
  102322:	83 e1 7f             	and    $0x7f,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
  102325:	0f b6 81 a0 63 10 00 	movzbl 0x1063a0(%ecx),%eax
  10232c:	83 c8 40             	or     $0x40,%eax
  10232f:	0f b6 c0             	movzbl %al,%eax
  102332:	f7 d0                	not    %eax
  102334:	21 d0                	and    %edx,%eax
  102336:	31 d2                	xor    %edx,%edx
  102338:	a3 3c 78 10 00       	mov    %eax,0x10783c
  10233d:	8d 76 00             	lea    0x0(%esi),%esi
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
  102340:	5d                   	pop    %ebp
  102341:	89 d0                	mov    %edx,%eax
  102343:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
  102344:	a1 3c 78 10 00       	mov    0x10783c,%eax
  102349:	a8 40                	test   $0x40,%al
  10234b:	74 0b                	je     102358 <kbdgetc+0x68>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
    shift &= ~E0ESC;
  10234d:	83 e0 bf             	and    $0xffffffbf,%eax
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
  102350:	80 c9 80             	or     $0x80,%cl
    shift &= ~E0ESC;
  102353:	a3 3c 78 10 00       	mov    %eax,0x10783c
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  102358:	0f b6 91 a0 64 10 00 	movzbl 0x1064a0(%ecx),%edx
  10235f:	0f b6 81 a0 63 10 00 	movzbl 0x1063a0(%ecx),%eax
  102366:	0b 05 3c 78 10 00    	or     0x10783c,%eax
  10236c:	31 d0                	xor    %edx,%eax
  c = charcode[shift & (CTL | SHIFT)][data];
  10236e:	89 c2                	mov    %eax,%edx
  102370:	83 e2 03             	and    $0x3,%edx
  if(shift & CAPSLOCK){
  102373:	a8 08                	test   $0x8,%al
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  102375:	8b 14 95 a0 65 10 00 	mov    0x1065a0(,%edx,4),%edx
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  10237c:	a3 3c 78 10 00       	mov    %eax,0x10783c
  c = charcode[shift & (CTL | SHIFT)][data];
  102381:	0f b6 14 0a          	movzbl (%edx,%ecx,1),%edx
  if(shift & CAPSLOCK){
  102385:	74 b9                	je     102340 <kbdgetc+0x50>
    if('a' <= c && c <= 'z')
  102387:	8d 42 9f             	lea    -0x61(%edx),%eax
  10238a:	83 f8 19             	cmp    $0x19,%eax
  10238d:	77 12                	ja     1023a1 <kbdgetc+0xb1>
      c += 'A' - 'a';
  10238f:	83 ea 20             	sub    $0x20,%edx
  102392:	eb ac                	jmp    102340 <kbdgetc+0x50>
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
  102394:	83 0d 3c 78 10 00 40 	orl    $0x40,0x10783c
  10239b:	31 d2                	xor    %edx,%edx
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
  10239d:	5d                   	pop    %ebp
  10239e:	89 d0                	mov    %edx,%eax
  1023a0:	c3                   	ret    
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
  1023a1:	8d 42 bf             	lea    -0x41(%edx),%eax
  1023a4:	83 f8 19             	cmp    $0x19,%eax
  1023a7:	77 97                	ja     102340 <kbdgetc+0x50>
      c += 'a' - 'A';
  1023a9:	83 c2 20             	add    $0x20,%edx
  1023ac:	eb 92                	jmp    102340 <kbdgetc+0x50>
  1023ae:	90                   	nop    
  1023af:	90                   	nop    

001023b0 <lapicw>:
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1023b0:	c1 e0 02             	shl    $0x2,%eax
  1023b3:	03 05 78 aa 10 00    	add    0x10aa78,%eax

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  1023b9:	55                   	push   %ebp
  1023ba:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
  1023bc:	89 10                	mov    %edx,(%eax)
  lapic[ID];  // wait for write to finish, by reading
  1023be:	a1 78 aa 10 00       	mov    0x10aa78,%eax
}
  1023c3:	5d                   	pop    %ebp

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  lapic[ID];  // wait for write to finish, by reading
  1023c4:	83 c0 20             	add    $0x20,%eax
  1023c7:	8b 00                	mov    (%eax),%eax
}
  1023c9:	c3                   	ret    
  1023ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001023d0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
  1023d0:	a1 78 aa 10 00       	mov    0x10aa78,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
  1023d5:	55                   	push   %ebp
  1023d6:	89 e5                	mov    %esp,%ebp
  if(lapic)
  1023d8:	85 c0                	test   %eax,%eax
  1023da:	74 0a                	je     1023e6 <lapiceoi+0x16>
    lapicw(EOI, 0);
}
  1023dc:	5d                   	pop    %ebp
// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
  1023dd:	31 d2                	xor    %edx,%edx
  1023df:	b8 2c 00 00 00       	mov    $0x2c,%eax
  1023e4:	eb ca                	jmp    1023b0 <lapicw>
}
  1023e6:	5d                   	pop    %ebp
  1023e7:	c3                   	ret    
  1023e8:	90                   	nop    
  1023e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

001023f0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
  1023f0:	55                   	push   %ebp
  1023f1:	89 e5                	mov    %esp,%ebp
}
  1023f3:	5d                   	pop    %ebp
  1023f4:	c3                   	ret    
  1023f5:	8d 74 26 00          	lea    0x0(%esi),%esi
  1023f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00102400 <cpunum>:
  lapicw(TPR, 0);
}

int
cpunum(void)
{
  102400:	55                   	push   %ebp
  102401:	89 e5                	mov    %esp,%ebp
  102403:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  102406:	9c                   	pushf  
  102407:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
  102408:	f6 c4 02             	test   $0x2,%ah
  10240b:	74 12                	je     10241f <cpunum+0x1f>
    static int n;
    if(n++ == 0)
  10240d:	a1 40 78 10 00       	mov    0x107840,%eax
  102412:	83 c0 01             	add    $0x1,%eax
  102415:	a3 40 78 10 00       	mov    %eax,0x107840
  10241a:	83 e8 01             	sub    $0x1,%eax
  10241d:	74 14                	je     102433 <cpunum+0x33>
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if(lapic)
  10241f:	8b 15 78 aa 10 00    	mov    0x10aa78,%edx
  102425:	31 c0                	xor    %eax,%eax
  102427:	85 d2                	test   %edx,%edx
  102429:	74 06                	je     102431 <cpunum+0x31>
    return lapic[ID]>>24;
  10242b:	8b 42 20             	mov    0x20(%edx),%eax
  10242e:	c1 e8 18             	shr    $0x18,%eax
  return 0;
}
  102431:	c9                   	leave  
  102432:	c3                   	ret    
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
  102433:	8b 45 04             	mov    0x4(%ebp),%eax
  102436:	c7 04 24 b0 65 10 00 	movl   $0x1065b0,(%esp)
  10243d:	89 44 24 04          	mov    %eax,0x4(%esp)
  102441:	e8 7a e0 ff ff       	call   1004c0 <cprintf>
  102446:	eb d7                	jmp    10241f <cpunum+0x1f>
  102448:	90                   	nop    
  102449:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00102450 <lapicinit>:
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(int c)
{
  102450:	55                   	push   %ebp
  102451:	89 e5                	mov    %esp,%ebp
  102453:	83 ec 18             	sub    $0x18,%esp
  cprintf("lapicinit: %d 0x%x\n", c, lapic);
  102456:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  10245b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10245f:	8b 45 08             	mov    0x8(%ebp),%eax
  102462:	c7 04 24 dc 65 10 00 	movl   $0x1065dc,(%esp)
  102469:	89 44 24 04          	mov    %eax,0x4(%esp)
  10246d:	e8 4e e0 ff ff       	call   1004c0 <cprintf>
  if(!lapic) 
  102472:	8b 15 78 aa 10 00    	mov    0x10aa78,%edx
  102478:	85 d2                	test   %edx,%edx
  10247a:	0f 84 ea 00 00 00    	je     10256a <lapicinit+0x11a>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
  102480:	ba 3f 01 00 00       	mov    $0x13f,%edx
  102485:	b8 3c 00 00 00       	mov    $0x3c,%eax
  10248a:	e8 21 ff ff ff       	call   1023b0 <lapicw>

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
  10248f:	ba 0b 00 00 00       	mov    $0xb,%edx
  102494:	b8 f8 00 00 00       	mov    $0xf8,%eax
  102499:	e8 12 ff ff ff       	call   1023b0 <lapicw>
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
  10249e:	ba 20 00 02 00       	mov    $0x20020,%edx
  1024a3:	b8 c8 00 00 00       	mov    $0xc8,%eax
  1024a8:	e8 03 ff ff ff       	call   1023b0 <lapicw>
  lapicw(TICR, 10000000); 
  1024ad:	ba 80 96 98 00       	mov    $0x989680,%edx
  1024b2:	b8 e0 00 00 00       	mov    $0xe0,%eax
  1024b7:	e8 f4 fe ff ff       	call   1023b0 <lapicw>

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
  1024bc:	ba 00 00 01 00       	mov    $0x10000,%edx
  1024c1:	b8 d4 00 00 00       	mov    $0xd4,%eax
  1024c6:	e8 e5 fe ff ff       	call   1023b0 <lapicw>
  lapicw(LINT1, MASKED);
  1024cb:	b8 d8 00 00 00       	mov    $0xd8,%eax
  1024d0:	ba 00 00 01 00       	mov    $0x10000,%edx
  1024d5:	e8 d6 fe ff ff       	call   1023b0 <lapicw>

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
  1024da:	a1 78 aa 10 00       	mov    0x10aa78,%eax
  1024df:	83 c0 30             	add    $0x30,%eax
  1024e2:	8b 00                	mov    (%eax),%eax
  1024e4:	c1 e8 10             	shr    $0x10,%eax
  1024e7:	3c 03                	cmp    $0x3,%al
  1024e9:	77 6e                	ja     102559 <lapicinit+0x109>
    lapicw(PCINT, MASKED);

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
  1024eb:	ba 33 00 00 00       	mov    $0x33,%edx
  1024f0:	b8 dc 00 00 00       	mov    $0xdc,%eax
  1024f5:	e8 b6 fe ff ff       	call   1023b0 <lapicw>

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
  1024fa:	31 d2                	xor    %edx,%edx
  1024fc:	b8 a0 00 00 00       	mov    $0xa0,%eax
  102501:	e8 aa fe ff ff       	call   1023b0 <lapicw>
  lapicw(ESR, 0);
  102506:	31 d2                	xor    %edx,%edx
  102508:	b8 a0 00 00 00       	mov    $0xa0,%eax
  10250d:	e8 9e fe ff ff       	call   1023b0 <lapicw>

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
  102512:	31 d2                	xor    %edx,%edx
  102514:	b8 2c 00 00 00       	mov    $0x2c,%eax
  102519:	e8 92 fe ff ff       	call   1023b0 <lapicw>

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  10251e:	31 d2                	xor    %edx,%edx
  102520:	b8 c4 00 00 00       	mov    $0xc4,%eax
  102525:	e8 86 fe ff ff       	call   1023b0 <lapicw>
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  10252a:	ba 00 85 08 00       	mov    $0x88500,%edx
  10252f:	b8 c0 00 00 00       	mov    $0xc0,%eax
  102534:	e8 77 fe ff ff       	call   1023b0 <lapicw>
  while(lapic[ICRLO] & DELIVS)
  102539:	8b 15 78 aa 10 00    	mov    0x10aa78,%edx
  10253f:	81 c2 00 03 00 00    	add    $0x300,%edx
  102545:	8b 02                	mov    (%edx),%eax
  102547:	f6 c4 10             	test   $0x10,%ah
  10254a:	75 f9                	jne    102545 <lapicinit+0xf5>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
  10254c:	c9                   	leave  
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
  10254d:	31 d2                	xor    %edx,%edx
  10254f:	b8 20 00 00 00       	mov    $0x20,%eax
  102554:	e9 57 fe ff ff       	jmp    1023b0 <lapicw>
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
    lapicw(PCINT, MASKED);
  102559:	ba 00 00 01 00       	mov    $0x10000,%edx
  10255e:	b8 d0 00 00 00       	mov    $0xd0,%eax
  102563:	e8 48 fe ff ff       	call   1023b0 <lapicw>
  102568:	eb 81                	jmp    1024eb <lapicinit+0x9b>
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
  10256a:	c9                   	leave  
  10256b:	c3                   	ret    
  10256c:	8d 74 26 00          	lea    0x0(%esi),%esi

00102570 <lapicstartap>:

// Start additional processor running bootstrap code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
  102570:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102571:	b8 0f 00 00 00       	mov    $0xf,%eax
  102576:	89 e5                	mov    %esp,%ebp
  102578:	ba 70 00 00 00       	mov    $0x70,%edx
  10257d:	56                   	push   %esi
  10257e:	53                   	push   %ebx
  10257f:	8b 75 0c             	mov    0xc(%ebp),%esi
  102582:	0f b6 5d 08          	movzbl 0x8(%ebp),%ebx
  102586:	ee                   	out    %al,(%dx)
  wrv[0] = 0;
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
  102587:	b8 0a 00 00 00       	mov    $0xa,%eax
  10258c:	b2 71                	mov    $0x71,%dl
  10258e:	ee                   	out    %al,(%dx)
  10258f:	c1 e3 18             	shl    $0x18,%ebx
  102592:	b8 c4 00 00 00       	mov    $0xc4,%eax
  102597:	89 da                	mov    %ebx,%edx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  outb(IO_RTC+1, 0x0A);
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
  102599:	c1 ee 04             	shr    $0x4,%esi
  10259c:	66 89 35 69 04 00 00 	mov    %si,0x469
  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
  microdelay(200);
  lapicw(ICRLO, INIT | LEVEL);
  1025a3:	c1 ee 08             	shr    $0x8,%esi
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  outb(IO_RTC+1, 0x0A);
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  wrv[0] = 0;
  1025a6:	66 c7 05 67 04 00 00 	movw   $0x0,0x467
  1025ad:	00 00 
  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
  microdelay(200);
  lapicw(ICRLO, INIT | LEVEL);
  1025af:	81 ce 00 06 00 00    	or     $0x600,%esi
  wrv[0] = 0;
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
  1025b5:	e8 f6 fd ff ff       	call   1023b0 <lapicw>
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
  1025ba:	ba 00 c5 00 00       	mov    $0xc500,%edx
  1025bf:	b8 c0 00 00 00       	mov    $0xc0,%eax
  1025c4:	e8 e7 fd ff ff       	call   1023b0 <lapicw>
  microdelay(200);
  lapicw(ICRLO, INIT | LEVEL);
  1025c9:	ba 00 85 00 00       	mov    $0x8500,%edx
  1025ce:	b8 c0 00 00 00       	mov    $0xc0,%eax
  1025d3:	e8 d8 fd ff ff       	call   1023b0 <lapicw>
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
  1025d8:	89 da                	mov    %ebx,%edx
  1025da:	b8 c4 00 00 00       	mov    $0xc4,%eax
  1025df:	e8 cc fd ff ff       	call   1023b0 <lapicw>
    lapicw(ICRLO, STARTUP | (addr>>12));
  1025e4:	89 f2                	mov    %esi,%edx
  1025e6:	b8 c0 00 00 00       	mov    $0xc0,%eax
  1025eb:	e8 c0 fd ff ff       	call   1023b0 <lapicw>
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
  1025f0:	89 da                	mov    %ebx,%edx
  1025f2:	b8 c4 00 00 00       	mov    $0xc4,%eax
  1025f7:	e8 b4 fd ff ff       	call   1023b0 <lapicw>
    lapicw(ICRLO, STARTUP | (addr>>12));
  1025fc:	89 f2                	mov    %esi,%edx
  1025fe:	b8 c0 00 00 00       	mov    $0xc0,%eax
    microdelay(200);
  }
}
  102603:	5b                   	pop    %ebx
  102604:	5e                   	pop    %esi
  102605:	5d                   	pop    %ebp
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
  102606:	e9 a5 fd ff ff       	jmp    1023b0 <lapicw>
  10260b:	90                   	nop    
  10260c:	90                   	nop    
  10260d:	90                   	nop    
  10260e:	90                   	nop    
  10260f:	90                   	nop    

00102610 <mpmain>:
// Common CPU setup code.
// Bootstrap CPU comes here from mainc().
// Other CPUs jump here from bootother.S.
static void
mpmain(void)
{
  102610:	55                   	push   %ebp
  102611:	89 e5                	mov    %esp,%ebp
  102613:	53                   	push   %ebx
  102614:	83 ec 14             	sub    $0x14,%esp
  if(cpunum() != mpbcpu()) {
  102617:	e8 e4 fd ff ff       	call   102400 <cpunum>
  10261c:	89 c3                	mov    %eax,%ebx
  10261e:	e8 fd 01 00 00       	call   102820 <mpbcpu>
  102623:	39 c3                	cmp    %eax,%ebx
  102625:	74 16                	je     10263d <mpmain+0x2d>
    ksegment();
  102627:	e8 44 3a 00 00       	call   106070 <ksegment>
  10262c:	8d 74 26 00          	lea    0x0(%esi),%esi
    lapicinit(cpunum());
  102630:	e8 cb fd ff ff       	call   102400 <cpunum>
  102635:	89 04 24             	mov    %eax,(%esp)
  102638:	e8 13 fe ff ff       	call   102450 <lapicinit>
  }
  vmenable();        // turn on paging
  10263d:	e8 6e 33 00 00       	call   1059b0 <vmenable>
  cprintf("cpu%d: starting\n", cpu->id);
  102642:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  102648:	0f b6 00             	movzbl (%eax),%eax
  10264b:	c7 04 24 f0 65 10 00 	movl   $0x1065f0,(%esp)
  102652:	89 44 24 04          	mov    %eax,0x4(%esp)
  102656:	e8 65 de ff ff       	call   1004c0 <cprintf>
  idtinit();       // load idt register
  10265b:	e8 80 24 00 00       	call   104ae0 <idtinit>
  xchg(&cpu->booted, 1);
  102660:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  102667:	b8 01 00 00 00       	mov    $0x1,%eax
  10266c:	f0 87 82 a8 00 00 00 	lock xchg %eax,0xa8(%edx)
  scheduler();     // start running processes
  102673:	e8 88 0b 00 00       	call   103200 <scheduler>
  102678:	90                   	nop    
  102679:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00102680 <mainc>:
  panic("jkstack");
}

void
mainc(void)
{
  102680:	55                   	push   %ebp
  102681:	89 e5                	mov    %esp,%ebp
  102683:	53                   	push   %ebx
  102684:	83 ec 14             	sub    $0x14,%esp
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
  102687:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  10268d:	0f b6 00             	movzbl (%eax),%eax
  102690:	c7 04 24 01 66 10 00 	movl   $0x106601,(%esp)
  102697:	89 44 24 04          	mov    %eax,0x4(%esp)
  10269b:	e8 20 de ff ff       	call   1004c0 <cprintf>
  kvmalloc();      // initialize the kernel page table
  1026a0:	e8 ab 35 00 00       	call   105c50 <kvmalloc>
  pinit();         // process table
  1026a5:	e8 c6 11 00 00       	call   103870 <pinit>
  tvinit();        // trap vectors
  1026aa:	e8 61 24 00 00       	call   104b10 <tvinit>
  1026af:	90                   	nop    
  binit();         // buffer cache
  1026b0:	e8 cb da ff ff       	call   100180 <binit>
  fileinit();      // file table
  1026b5:	e8 d6 e8 ff ff       	call   100f90 <fileinit>
  iinit();         // inode cache
  1026ba:	e8 b1 f6 ff ff       	call   101d70 <iinit>
  1026bf:	90                   	nop    
  ideinit();       // disk
  1026c0:	e8 0b f9 ff ff       	call   101fd0 <ideinit>
  if(!ismp)
  1026c5:	a1 84 aa 10 00       	mov    0x10aa84,%eax
  1026ca:	85 c0                	test   %eax,%eax
  1026cc:	0f 84 ab 00 00 00    	je     10277d <mainc+0xfd>
    timerinit();   // uniprocessor timer
  userinit();      // first user process
  1026d2:	e8 e9 0f 00 00       	call   1036c0 <userinit>
  char *stack;

  // Write bootstrap code to unused memory at 0x7000.  The linker has
  // placed the start of bootother.S there.
  code = (uchar *) 0x7000;
  memmove(code, _binary_bootother_start, (uint)_binary_bootother_size);
  1026d7:	c7 44 24 08 6a 00 00 	movl   $0x6a,0x8(%esp)
  1026de:	00 
  1026df:	c7 44 24 04 34 77 10 	movl   $0x107734,0x4(%esp)
  1026e6:	00 
  1026e7:	c7 04 24 00 70 00 00 	movl   $0x7000,(%esp)
  1026ee:	e8 2d 14 00 00       	call   103b20 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
  1026f3:	69 05 80 b0 10 00 bc 	imul   $0xbc,0x10b080,%eax
  1026fa:	00 00 00 
  1026fd:	05 a0 aa 10 00       	add    $0x10aaa0,%eax
  102702:	3d a0 aa 10 00       	cmp    $0x10aaa0,%eax
  102707:	76 6a                	jbe    102773 <mainc+0xf3>
  102709:	bb a0 aa 10 00       	mov    $0x10aaa0,%ebx
  10270e:	66 90                	xchg   %ax,%ax
    if(c == cpus+cpunum())  // We've started already.
  102710:	e8 eb fc ff ff       	call   102400 <cpunum>
  102715:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
  10271b:	05 a0 aa 10 00       	add    $0x10aaa0,%eax
  102720:	39 d8                	cmp    %ebx,%eax
  102722:	74 36                	je     10275a <mainc+0xda>
      continue;

    // Fill in %esp, %eip and start code on cpu.
    stack = kalloc();
  102724:	e8 87 fa ff ff       	call   1021b0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpmain;
  102729:	c7 05 f8 6f 00 00 10 	movl   $0x102610,0x6ff8
  102730:	26 10 00 
    if(c == cpus+cpunum())  // We've started already.
      continue;

    // Fill in %esp, %eip and start code on cpu.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
  102733:	05 00 10 00 00       	add    $0x1000,%eax
  102738:	a3 fc 6f 00 00       	mov    %eax,0x6ffc
    *(void**)(code-8) = mpmain;
    lapicstartap(c->id, (uint)code);
  10273d:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
  102744:	00 
  102745:	0f b6 03             	movzbl (%ebx),%eax
  102748:	89 04 24             	mov    %eax,(%esp)
  10274b:	e8 20 fe ff ff       	call   102570 <lapicstartap>

    // Wait for cpu to finish mpmain()
    while(c->booted == 0)
  102750:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
  102756:	85 c0                	test   %eax,%eax
  102758:	74 f6                	je     102750 <mainc+0xd0>
  // Write bootstrap code to unused memory at 0x7000.  The linker has
  // placed the start of bootother.S there.
  code = (uchar *) 0x7000;
  memmove(code, _binary_bootother_start, (uint)_binary_bootother_size);

  for(c = cpus; c < cpus+ncpu; c++){
  10275a:	69 05 80 b0 10 00 bc 	imul   $0xbc,0x10b080,%eax
  102761:	00 00 00 
  102764:	81 c3 bc 00 00 00    	add    $0xbc,%ebx
  10276a:	05 a0 aa 10 00       	add    $0x10aaa0,%eax
  10276f:	39 d8                	cmp    %ebx,%eax
  102771:	77 9d                	ja     102710 <mainc+0x90>
  userinit();      // first user process
  bootothers();    // start other processors

  // Finish setting up this processor in mpmain.
  mpmain();
}
  102773:	83 c4 14             	add    $0x14,%esp
  102776:	5b                   	pop    %ebx
  102777:	5d                   	pop    %ebp
    timerinit();   // uniprocessor timer
  userinit();      // first user process
  bootothers();    // start other processors

  // Finish setting up this processor in mpmain.
  mpmain();
  102778:	e9 93 fe ff ff       	jmp    102610 <mpmain>
  binit();         // buffer cache
  fileinit();      // file table
  iinit();         // inode cache
  ideinit();       // disk
  if(!ismp)
    timerinit();   // uniprocessor timer
  10277d:	e8 fe 22 00 00       	call   104a80 <timerinit>
  102782:	e9 4b ff ff ff       	jmp    1026d2 <mainc+0x52>
  102787:	89 f6                	mov    %esi,%esi
  102789:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00102790 <jkstack>:
  jkstack();       // call mainc() on a properly-allocated stack 
}

void
jkstack(void)
{
  102790:	55                   	push   %ebp
  102791:	89 e5                	mov    %esp,%ebp
  102793:	83 ec 08             	sub    $0x8,%esp
  char *kstack = kalloc();
  102796:	e8 15 fa ff ff       	call   1021b0 <kalloc>
  if(!kstack)
  10279b:	85 c0                	test   %eax,%eax
  10279d:	75 0c                	jne    1027ab <jkstack+0x1b>
    panic("jkstack\n");
  10279f:	c7 04 24 18 66 10 00 	movl   $0x106618,(%esp)
  1027a6:	e8 d5 e0 ff ff       	call   100880 <panic>
  char *top = kstack + PGSIZE;
  asm volatile("movl %0,%%esp" : : "r" (top));
  1027ab:	05 00 10 00 00       	add    $0x1000,%eax
  1027b0:	89 c4                	mov    %eax,%esp
  asm volatile("call mainc");
  1027b2:	e8 c9 fe ff ff       	call   102680 <mainc>
  panic("jkstack");
  1027b7:	c7 04 24 21 66 10 00 	movl   $0x106621,(%esp)
  1027be:	e8 bd e0 ff ff       	call   100880 <panic>
  1027c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1027c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001027d0 <main>:
void mainc(void);

// Bootstrap processor starts running C code here.
int
main(void)
{
  1027d0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  1027d4:	83 e4 f0             	and    $0xfffffff0,%esp
  1027d7:	ff 71 fc             	pushl  -0x4(%ecx)
  1027da:	55                   	push   %ebp
  1027db:	89 e5                	mov    %esp,%ebp
  1027dd:	51                   	push   %ecx
  1027de:	83 ec 04             	sub    $0x4,%esp
  mpinit();        // collect info about this machine
  1027e1:	e8 0a 01 00 00       	call   1028f0 <mpinit>
  lapicinit(mpbcpu());
  1027e6:	e8 35 00 00 00       	call   102820 <mpbcpu>
  1027eb:	89 04 24             	mov    %eax,(%esp)
  1027ee:	e8 5d fc ff ff       	call   102450 <lapicinit>
  ksegment();      // set up segments
  1027f3:	e8 78 38 00 00       	call   106070 <ksegment>
  picinit();       // interrupt controller
  1027f8:	e8 23 03 00 00       	call   102b20 <picinit>
  1027fd:	8d 76 00             	lea    0x0(%esi),%esi
  ioapicinit();    // another interrupt controller
  102800:	e8 db f8 ff ff       	call   1020e0 <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
  102805:	e8 e6 d9 ff ff       	call   1001f0 <consoleinit>
  uartinit();      // serial port
  10280a:	e8 61 26 00 00       	call   104e70 <uartinit>
  10280f:	90                   	nop    
  kinit();         // initialize memory allocator
  102810:	e8 5b fa ff ff       	call   102270 <kinit>
  jkstack();       // call mainc() on a properly-allocated stack 
  102815:	e8 76 ff ff ff       	call   102790 <jkstack>
  10281a:	90                   	nop    
  10281b:	90                   	nop    
  10281c:	90                   	nop    
  10281d:	90                   	nop    
  10281e:	90                   	nop    
  10281f:	90                   	nop    

00102820 <mpbcpu>:
uchar ioapicid;

int
mpbcpu(void)
{
  return bcpu-cpus;
  102820:	a1 44 78 10 00       	mov    0x107844,%eax
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
  102825:	55                   	push   %ebp
  102826:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
}
  102828:	5d                   	pop    %ebp
uchar ioapicid;

int
mpbcpu(void)
{
  return bcpu-cpus;
  102829:	2d a0 aa 10 00       	sub    $0x10aaa0,%eax
  10282e:	c1 f8 02             	sar    $0x2,%eax
  102831:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
  102837:	c3                   	ret    
  102838:	90                   	nop    
  102839:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00102840 <sum>:

static uchar
sum(uchar *addr, int len)
{
  102840:	55                   	push   %ebp
  102841:	89 e5                	mov    %esp,%ebp
  102843:	56                   	push   %esi
  102844:	89 c6                	mov    %eax,%esi
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102846:	31 c0                	xor    %eax,%eax
  102848:	85 d2                	test   %edx,%edx
  return bcpu-cpus;
}

static uchar
sum(uchar *addr, int len)
{
  10284a:	53                   	push   %ebx
  10284b:	89 d3                	mov    %edx,%ebx
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  10284d:	7e 14                	jle    102863 <sum+0x23>
  10284f:	31 c9                	xor    %ecx,%ecx
  102851:	31 d2                	xor    %edx,%edx
    sum += addr[i];
  102853:	0f b6 04 31          	movzbl (%ecx,%esi,1),%eax
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102857:	83 c1 01             	add    $0x1,%ecx
    sum += addr[i];
  10285a:	01 c2                	add    %eax,%edx
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  10285c:	39 d9                	cmp    %ebx,%ecx
  10285e:	75 f3                	jne    102853 <sum+0x13>
  102860:	0f b6 c2             	movzbl %dl,%eax
    sum += addr[i];
  return sum;
}
  102863:	5b                   	pop    %ebx
  102864:	5e                   	pop    %esi
  102865:	5d                   	pop    %ebp
  102866:	c3                   	ret    
  102867:	89 f6                	mov    %esi,%esi
  102869:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00102870 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uchar *addr, int len)
{
  102870:	55                   	push   %ebp
  102871:	89 e5                	mov    %esp,%ebp
  102873:	57                   	push   %edi
  102874:	56                   	push   %esi
  102875:	89 c6                	mov    %eax,%esi
  102877:	53                   	push   %ebx
  102878:	89 d3                	mov    %edx,%ebx
  10287a:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p;

  cprintf("mpsearch1 0x%x %d\n", addr, len);
  e = addr+len;
  10287d:	8d 3c 1e             	lea    (%esi,%ebx,1),%edi
static struct mp*
mpsearch1(uchar *addr, int len)
{
  uchar *e, *p;

  cprintf("mpsearch1 0x%x %d\n", addr, len);
  102880:	89 54 24 08          	mov    %edx,0x8(%esp)
  102884:	89 44 24 04          	mov    %eax,0x4(%esp)
  102888:	c7 04 24 29 66 10 00 	movl   $0x106629,(%esp)
  10288f:	e8 2c dc ff ff       	call   1004c0 <cprintf>
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
  102894:	39 fe                	cmp    %edi,%esi
  102896:	73 45                	jae    1028dd <mpsearch1+0x6d>
  102898:	89 f3                	mov    %esi,%ebx
  10289a:	eb 0b                	jmp    1028a7 <mpsearch1+0x37>
  10289c:	8d 74 26 00          	lea    0x0(%esi),%esi
  1028a0:	83 c3 10             	add    $0x10,%ebx
  1028a3:	39 df                	cmp    %ebx,%edi
  1028a5:	76 36                	jbe    1028dd <mpsearch1+0x6d>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  1028a7:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  1028ae:	00 
  1028af:	c7 44 24 04 3c 66 10 	movl   $0x10663c,0x4(%esp)
  1028b6:	00 
  1028b7:	89 1c 24             	mov    %ebx,(%esp)
  1028ba:	e8 e1 11 00 00       	call   103aa0 <memcmp>
  1028bf:	85 c0                	test   %eax,%eax
  1028c1:	75 dd                	jne    1028a0 <mpsearch1+0x30>
  1028c3:	ba 10 00 00 00       	mov    $0x10,%edx
  1028c8:	89 d8                	mov    %ebx,%eax
  1028ca:	e8 71 ff ff ff       	call   102840 <sum>
  1028cf:	84 c0                	test   %al,%al
  1028d1:	75 cd                	jne    1028a0 <mpsearch1+0x30>
      return (struct mp*)p;
  return 0;
}
  1028d3:	83 c4 0c             	add    $0xc,%esp

  cprintf("mpsearch1 0x%x %d\n", addr, len);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  1028d6:	89 d8                	mov    %ebx,%eax
  return 0;
}
  1028d8:	5b                   	pop    %ebx
  1028d9:	5e                   	pop    %esi
  1028da:	5f                   	pop    %edi
  1028db:	5d                   	pop    %ebp
  1028dc:	c3                   	ret    
  1028dd:	83 c4 0c             	add    $0xc,%esp
{
  uchar *e, *p;

  cprintf("mpsearch1 0x%x %d\n", addr, len);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
  1028e0:	31 c0                	xor    %eax,%eax
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
  1028e2:	5b                   	pop    %ebx
  1028e3:	5e                   	pop    %esi
  1028e4:	5f                   	pop    %edi
  1028e5:	5d                   	pop    %ebp
  1028e6:	c3                   	ret    
  1028e7:	89 f6                	mov    %esi,%esi
  1028e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001028f0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
  1028f0:	55                   	push   %ebp
  1028f1:	89 e5                	mov    %esp,%ebp
  1028f3:	83 ec 28             	sub    $0x28,%esp
  1028f6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  1028f9:	89 75 f8             	mov    %esi,-0x8(%ebp)
  1028fc:	89 7d fc             	mov    %edi,-0x4(%ebp)
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar*)0x400;
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
  1028ff:	0f b6 0d 0f 04 00 00 	movzbl 0x40f,%ecx
  102906:	0f b6 05 0e 04 00 00 	movzbl 0x40e,%eax
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
  10290d:	c7 05 44 78 10 00 a0 	movl   $0x10aaa0,0x107844
  102914:	aa 10 00 
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar*)0x400;
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
  102917:	c1 e1 08             	shl    $0x8,%ecx
  10291a:	09 c1                	or     %eax,%ecx
  10291c:	c1 e1 04             	shl    $0x4,%ecx
  10291f:	85 c9                	test   %ecx,%ecx
  102921:	74 4e                	je     102971 <mpinit+0x81>
    if((mp = mpsearch1((uchar*)p, 1024)))
  102923:	ba 00 04 00 00       	mov    $0x400,%edx
  102928:	89 c8                	mov    %ecx,%eax
  10292a:	e8 41 ff ff ff       	call   102870 <mpsearch1>
  10292f:	85 c0                	test   %eax,%eax
  102931:	89 c6                	mov    %eax,%esi
  102933:	74 67                	je     10299c <mpinit+0xac>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  102935:	8b 5e 04             	mov    0x4(%esi),%ebx
  102938:	85 db                	test   %ebx,%ebx
  10293a:	74 28                	je     102964 <mpinit+0x74>
    return 0;
  conf = (struct mpconf*)mp->physaddr;
  if(memcmp(conf, "PCMP", 4) != 0)
  10293c:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  102943:	00 
  102944:	c7 44 24 04 41 66 10 	movl   $0x106641,0x4(%esp)
  10294b:	00 
  10294c:	89 1c 24             	mov    %ebx,(%esp)
  10294f:	e8 4c 11 00 00       	call   103aa0 <memcmp>
  102954:	85 c0                	test   %eax,%eax
  102956:	75 0c                	jne    102964 <mpinit+0x74>
    return 0;
  if(conf->version != 1 && conf->version != 4)
  102958:	0f b6 43 06          	movzbl 0x6(%ebx),%eax
  10295c:	3c 01                	cmp    $0x1,%al
  10295e:	74 53                	je     1029b3 <mpinit+0xc3>
  102960:	3c 04                	cmp    $0x4,%al
  102962:	74 4f                	je     1029b3 <mpinit+0xc3>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
  102964:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  102967:	8b 75 f8             	mov    -0x8(%ebp),%esi
  10296a:	8b 7d fc             	mov    -0x4(%ebp),%edi
  10296d:	89 ec                	mov    %ebp,%esp
  10296f:	5d                   	pop    %ebp
  102970:	c3                   	ret    
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
    if((mp = mpsearch1((uchar*)p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1((uchar*)p-1024, 1024)))
  102971:	0f b6 05 14 04 00 00 	movzbl 0x414,%eax
  102978:	0f b6 15 13 04 00 00 	movzbl 0x413,%edx
  10297f:	c1 e0 08             	shl    $0x8,%eax
  102982:	09 d0                	or     %edx,%eax
  102984:	ba 00 04 00 00       	mov    $0x400,%edx
  102989:	c1 e0 0a             	shl    $0xa,%eax
  10298c:	2d 00 04 00 00       	sub    $0x400,%eax
  102991:	e8 da fe ff ff       	call   102870 <mpsearch1>
  102996:	85 c0                	test   %eax,%eax
  102998:	89 c6                	mov    %eax,%esi
  10299a:	75 99                	jne    102935 <mpinit+0x45>
      return mp;
  }
  return mpsearch1((uchar*)0xF0000, 0x10000);
  10299c:	ba 00 00 01 00       	mov    $0x10000,%edx
  1029a1:	b8 00 00 0f 00       	mov    $0xf0000,%eax
  1029a6:	e8 c5 fe ff ff       	call   102870 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  1029ab:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1((uchar*)p-1024, 1024)))
      return mp;
  }
  return mpsearch1((uchar*)0xF0000, 0x10000);
  1029ad:	89 c6                	mov    %eax,%esi
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  1029af:	75 84                	jne    102935 <mpinit+0x45>
  1029b1:	eb b1                	jmp    102964 <mpinit+0x74>
  conf = (struct mpconf*)mp->physaddr;
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
  1029b3:	0f b7 53 04          	movzwl 0x4(%ebx),%edx
  1029b7:	89 d8                	mov    %ebx,%eax
  1029b9:	e8 82 fe ff ff       	call   102840 <sum>
  1029be:	84 c0                	test   %al,%al
  1029c0:	75 a2                	jne    102964 <mpinit+0x74>
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  1029c2:	c7 05 84 aa 10 00 01 	movl   $0x1,0x10aa84
  1029c9:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
  1029cc:	8b 43 24             	mov    0x24(%ebx),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  1029cf:	8d 53 2c             	lea    0x2c(%ebx),%edx

  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  1029d2:	a3 78 aa 10 00       	mov    %eax,0x10aa78
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  1029d7:	0f b7 43 04          	movzwl 0x4(%ebx),%eax
  1029db:	01 c3                	add    %eax,%ebx
  1029dd:	39 da                	cmp    %ebx,%edx
  1029df:	89 5d ec             	mov    %ebx,-0x14(%ebp)
  1029e2:	73 60                	jae    102a44 <mpinit+0x154>
  1029e4:	a1 44 78 10 00       	mov    0x107844,%eax
  1029e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1029ec:	8d 74 26 00          	lea    0x0(%esi),%esi
    switch(*p){
  1029f0:	0f b6 02             	movzbl (%edx),%eax
  1029f3:	3c 04                	cmp    $0x4,%al
  1029f5:	76 29                	jbe    102a20 <mpinit+0x130>
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
  1029f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1029fa:	a3 44 78 10 00       	mov    %eax,0x107844
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
  1029ff:	0f b6 02             	movzbl (%edx),%eax
  102a02:	c7 04 24 68 66 10 00 	movl   $0x106668,(%esp)
  102a09:	89 44 24 04          	mov    %eax,0x4(%esp)
  102a0d:	e8 ae da ff ff       	call   1004c0 <cprintf>
      panic("mpinit");
  102a12:	c7 04 24 61 66 10 00 	movl   $0x106661,(%esp)
  102a19:	e8 62 de ff ff       	call   100880 <panic>
  102a1e:	66 90                	xchg   %ax,%ax
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
  102a20:	0f b6 c0             	movzbl %al,%eax
  102a23:	ff 24 85 88 66 10 00 	jmp    *0x106688(,%eax,4)
      ncpu++;
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
  102a2a:	0f b6 42 01          	movzbl 0x1(%edx),%eax
      p += sizeof(struct mpioapic);
  102a2e:	83 c2 08             	add    $0x8,%edx
      ncpu++;
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
  102a31:	a2 80 aa 10 00       	mov    %al,0x10aa80
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  102a36:	3b 55 ec             	cmp    -0x14(%ebp),%edx
  102a39:	72 b5                	jb     1029f0 <mpinit+0x100>
  102a3b:	8b 5d f0             	mov    -0x10(%ebp),%ebx
  102a3e:	89 1d 44 78 10 00    	mov    %ebx,0x107844
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      panic("mpinit");
    }
  }
  if(mp->imcrp){
  102a44:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
  102a48:	0f 84 16 ff ff ff    	je     102964 <mpinit+0x74>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102a4e:	b8 70 00 00 00       	mov    $0x70,%eax
  102a53:	ba 22 00 00 00       	mov    $0x22,%edx
  102a58:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102a59:	b2 23                	mov    $0x23,%dl
  102a5b:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102a5c:	83 c8 01             	or     $0x1,%eax
  102a5f:	ee                   	out    %al,(%dx)
  102a60:	e9 ff fe ff ff       	jmp    102964 <mpinit+0x74>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
  102a65:	83 c2 08             	add    $0x8,%edx
  102a68:	eb cc                	jmp    102a36 <mpinit+0x146>
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu != proc->apicid) {
  102a6a:	0f b6 7a 01          	movzbl 0x1(%edx),%edi
  102a6e:	89 fb                	mov    %edi,%ebx
  102a70:	0f b6 cb             	movzbl %bl,%ecx
  102a73:	8b 1d 80 b0 10 00    	mov    0x10b080,%ebx
  102a79:	39 d9                	cmp    %ebx,%ecx
  102a7b:	75 2f                	jne    102aac <mpinit+0x1bc>
        cprintf("mpinit: ncpu=%d apicpid=%d", ncpu, proc->apicid);
        panic("mpinit");
      }
      if(proc->flags & MPBOOT)
  102a7d:	f6 42 03 02          	testb  $0x2,0x3(%edx)
  102a81:	74 0e                	je     102a91 <mpinit+0x1a1>
        bcpu = &cpus[ncpu];
  102a83:	69 c1 bc 00 00 00    	imul   $0xbc,%ecx,%eax
  102a89:	05 a0 aa 10 00       	add    $0x10aaa0,%eax
  102a8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
      cpus[ncpu].id = ncpu;
  102a91:	69 c1 bc 00 00 00    	imul   $0xbc,%ecx,%eax
  102a97:	89 fb                	mov    %edi,%ebx
      ncpu++;
      p += sizeof(struct mpproc);
  102a99:	83 c2 14             	add    $0x14,%edx
        cprintf("mpinit: ncpu=%d apicpid=%d", ncpu, proc->apicid);
        panic("mpinit");
      }
      if(proc->flags & MPBOOT)
        bcpu = &cpus[ncpu];
      cpus[ncpu].id = ncpu;
  102a9c:	88 98 a0 aa 10 00    	mov    %bl,0x10aaa0(%eax)
      ncpu++;
  102aa2:	8d 41 01             	lea    0x1(%ecx),%eax
  102aa5:	a3 80 b0 10 00       	mov    %eax,0x10b080
  102aaa:	eb 8a                	jmp    102a36 <mpinit+0x146>
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu != proc->apicid) {
  102aac:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102aaf:	a3 44 78 10 00       	mov    %eax,0x107844
        cprintf("mpinit: ncpu=%d apicpid=%d", ncpu, proc->apicid);
  102ab4:	0f b6 42 01          	movzbl 0x1(%edx),%eax
  102ab8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  102abc:	c7 04 24 46 66 10 00 	movl   $0x106646,(%esp)
  102ac3:	89 44 24 08          	mov    %eax,0x8(%esp)
  102ac7:	e8 f4 d9 ff ff       	call   1004c0 <cprintf>
        panic("mpinit");
  102acc:	c7 04 24 61 66 10 00 	movl   $0x106661,(%esp)
  102ad3:	e8 a8 dd ff ff       	call   100880 <panic>
  102ad8:	90                   	nop    
  102ad9:	90                   	nop    
  102ada:	90                   	nop    
  102adb:	90                   	nop    
  102adc:	90                   	nop    
  102add:	90                   	nop    
  102ade:	90                   	nop    
  102adf:	90                   	nop    

00102ae0 <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
  102ae0:	55                   	push   %ebp
  102ae1:	89 c1                	mov    %eax,%ecx
  102ae3:	89 e5                	mov    %esp,%ebp
  102ae5:	ba 21 00 00 00       	mov    $0x21,%edx
  irqmask = mask;
  102aea:	66 a3 00 73 10 00    	mov    %ax,0x107300
  102af0:	ee                   	out    %al,(%dx)
  outb(IO_PIC1+1, mask);
  outb(IO_PIC2+1, mask >> 8);
}
  102af1:	66 c1 e9 08          	shr    $0x8,%cx
  102af5:	b2 a1                	mov    $0xa1,%dl
  102af7:	89 c8                	mov    %ecx,%eax
  102af9:	ee                   	out    %al,(%dx)
  102afa:	5d                   	pop    %ebp
  102afb:	c3                   	ret    
  102afc:	8d 74 26 00          	lea    0x0(%esi),%esi

00102b00 <picenable>:

void
picenable(int irq)
{
  102b00:	55                   	push   %ebp
  picsetmask(irqmask & ~(1<<irq));
  102b01:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
  102b06:	89 e5                	mov    %esp,%ebp
  102b08:	8b 4d 08             	mov    0x8(%ebp),%ecx
  picsetmask(irqmask & ~(1<<irq));
}
  102b0b:	5d                   	pop    %ebp
}

void
picenable(int irq)
{
  picsetmask(irqmask & ~(1<<irq));
  102b0c:	d3 c0                	rol    %cl,%eax
  102b0e:	66 23 05 00 73 10 00 	and    0x107300,%ax
  102b15:	0f b7 c0             	movzwl %ax,%eax
  102b18:	eb c6                	jmp    102ae0 <picsetmask>
  102b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102b20 <picinit>:
}

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
  102b20:	55                   	push   %ebp
  102b21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  102b26:	89 e5                	mov    %esp,%ebp
  102b28:	83 ec 0c             	sub    $0xc,%esp
  102b2b:	89 74 24 04          	mov    %esi,0x4(%esp)
  102b2f:	be 21 00 00 00       	mov    $0x21,%esi
  102b34:	89 1c 24             	mov    %ebx,(%esp)
  102b37:	89 f2                	mov    %esi,%edx
  102b39:	89 7c 24 08          	mov    %edi,0x8(%esp)
  102b3d:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
  102b3e:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  102b43:	89 ca                	mov    %ecx,%edx
  102b45:	ee                   	out    %al,(%dx)
  102b46:	bf 11 00 00 00       	mov    $0x11,%edi
  102b4b:	b2 20                	mov    $0x20,%dl
  102b4d:	89 f8                	mov    %edi,%eax
  102b4f:	ee                   	out    %al,(%dx)
  102b50:	b8 20 00 00 00       	mov    $0x20,%eax
  102b55:	89 f2                	mov    %esi,%edx
  102b57:	ee                   	out    %al,(%dx)
  102b58:	b8 04 00 00 00       	mov    $0x4,%eax
  102b5d:	ee                   	out    %al,(%dx)
  102b5e:	bb 03 00 00 00       	mov    $0x3,%ebx
  102b63:	89 d8                	mov    %ebx,%eax
  102b65:	ee                   	out    %al,(%dx)
  102b66:	be a0 00 00 00       	mov    $0xa0,%esi
  102b6b:	89 f8                	mov    %edi,%eax
  102b6d:	89 f2                	mov    %esi,%edx
  102b6f:	ee                   	out    %al,(%dx)
  102b70:	b8 28 00 00 00       	mov    $0x28,%eax
  102b75:	89 ca                	mov    %ecx,%edx
  102b77:	ee                   	out    %al,(%dx)
  102b78:	b8 02 00 00 00       	mov    $0x2,%eax
  102b7d:	ee                   	out    %al,(%dx)
  102b7e:	89 d8                	mov    %ebx,%eax
  102b80:	ee                   	out    %al,(%dx)
  102b81:	b9 68 00 00 00       	mov    $0x68,%ecx
  102b86:	b2 20                	mov    $0x20,%dl
  102b88:	89 c8                	mov    %ecx,%eax
  102b8a:	ee                   	out    %al,(%dx)
  102b8b:	bb 0a 00 00 00       	mov    $0xa,%ebx
  102b90:	89 d8                	mov    %ebx,%eax
  102b92:	ee                   	out    %al,(%dx)
  102b93:	89 c8                	mov    %ecx,%eax
  102b95:	89 f2                	mov    %esi,%edx
  102b97:	ee                   	out    %al,(%dx)
  102b98:	89 d8                	mov    %ebx,%eax
  102b9a:	ee                   	out    %al,(%dx)
  102b9b:	0f b7 05 00 73 10 00 	movzwl 0x107300,%eax
  102ba2:	66 83 f8 ff          	cmp    $0xffffffff,%ax
  102ba6:	74 18                	je     102bc0 <picinit+0xa0>
    picsetmask(irqmask);
}
  102ba8:	8b 1c 24             	mov    (%esp),%ebx

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
    picsetmask(irqmask);
  102bab:	0f b7 c0             	movzwl %ax,%eax
}
  102bae:	8b 74 24 04          	mov    0x4(%esp),%esi
  102bb2:	8b 7c 24 08          	mov    0x8(%esp),%edi
  102bb6:	89 ec                	mov    %ebp,%esp
  102bb8:	5d                   	pop    %ebp

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
    picsetmask(irqmask);
  102bb9:	e9 22 ff ff ff       	jmp    102ae0 <picsetmask>
  102bbe:	66 90                	xchg   %ax,%ax
}
  102bc0:	8b 1c 24             	mov    (%esp),%ebx
  102bc3:	8b 74 24 04          	mov    0x4(%esp),%esi
  102bc7:	8b 7c 24 08          	mov    0x8(%esp),%edi
  102bcb:	89 ec                	mov    %ebp,%esp
  102bcd:	5d                   	pop    %ebp
  102bce:	c3                   	ret    
  102bcf:	90                   	nop    

00102bd0 <piperead>:
  return n;
}

int
piperead(struct pipe *p, char *addr, int n)
{
  102bd0:	55                   	push   %ebp
  102bd1:	89 e5                	mov    %esp,%ebp
  102bd3:	57                   	push   %edi
  102bd4:	56                   	push   %esi
  102bd5:	53                   	push   %ebx
  102bd6:	83 ec 0c             	sub    $0xc,%esp
  102bd9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  102bdc:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
  102bdf:	89 1c 24             	mov    %ebx,(%esp)
  102be2:	e8 29 0e 00 00       	call   103a10 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
  102be7:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
  102bed:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
  102bf3:	75 53                	jne    102c48 <piperead+0x78>
  102bf5:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
  102bfb:	85 d2                	test   %edx,%edx
  102bfd:	74 49                	je     102c48 <piperead+0x78>
    if(proc->killed){
  102bff:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  102c05:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
  102c0b:	8b 40 24             	mov    0x24(%eax),%eax
  102c0e:	85 c0                	test   %eax,%eax
  102c10:	74 1c                	je     102c2e <piperead+0x5e>
  102c12:	e9 93 00 00 00       	jmp    102caa <piperead+0xda>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
  102c17:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
  102c1d:	85 d2                	test   %edx,%edx
  102c1f:	74 27                	je     102c48 <piperead+0x78>
    if(proc->killed){
  102c21:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  102c27:	8b 48 24             	mov    0x24(%eax),%ecx
  102c2a:	85 c9                	test   %ecx,%ecx
  102c2c:	75 7c                	jne    102caa <piperead+0xda>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  102c2e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  102c32:	89 34 24             	mov    %esi,(%esp)
  102c35:	e8 b6 04 00 00       	call   1030f0 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
  102c3a:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
  102c40:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
  102c46:	74 cf                	je     102c17 <piperead+0x47>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
  102c48:	85 ff                	test   %edi,%edi
  102c4a:	7e 75                	jle    102cc1 <piperead+0xf1>
    if(p->nread == p->nwrite)
      break;
  102c4c:	31 f6                	xor    %esi,%esi
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    if(p->nread == p->nwrite)
  102c4e:	89 c2                	mov    %eax,%edx
  102c50:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
  102c56:	75 10                	jne    102c68 <piperead+0x98>
  102c58:	eb 67                	jmp    102cc1 <piperead+0xf1>
  102c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102c60:	39 93 38 02 00 00    	cmp    %edx,0x238(%ebx)
  102c66:	74 22                	je     102c8a <piperead+0xba>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  102c68:	89 d0                	mov    %edx,%eax
  102c6a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  102c6d:	83 c2 01             	add    $0x1,%edx
  102c70:	25 ff 01 00 00       	and    $0x1ff,%eax
  102c75:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
  102c7a:	88 04 0e             	mov    %al,(%esi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
  102c7d:	83 c6 01             	add    $0x1,%esi
  102c80:	39 fe                	cmp    %edi,%esi
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  102c82:	89 93 34 02 00 00    	mov    %edx,0x234(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
  102c88:	75 d6                	jne    102c60 <piperead+0x90>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  102c8a:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
  102c90:	89 04 24             	mov    %eax,(%esp)
  102c93:	e8 68 03 00 00       	call   103000 <wakeup>
  release(&p->lock);
  102c98:	89 1c 24             	mov    %ebx,(%esp)
  102c9b:	e8 30 0d 00 00       	call   1039d0 <release>
  return i;
}
  102ca0:	83 c4 0c             	add    $0xc,%esp
  102ca3:	89 f0                	mov    %esi,%eax
  102ca5:	5b                   	pop    %ebx
  102ca6:	5e                   	pop    %esi
  102ca7:	5f                   	pop    %edi
  102ca8:	5d                   	pop    %ebp
  102ca9:	c3                   	ret    
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(proc->killed){
      release(&p->lock);
  102caa:	89 1c 24             	mov    %ebx,(%esp)
  102cad:	be ff ff ff ff       	mov    $0xffffffff,%esi
  102cb2:	e8 19 0d 00 00       	call   1039d0 <release>
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
  102cb7:	83 c4 0c             	add    $0xc,%esp
  102cba:	89 f0                	mov    %esi,%eax
  102cbc:	5b                   	pop    %ebx
  102cbd:	5e                   	pop    %esi
  102cbe:	5f                   	pop    %edi
  102cbf:	5d                   	pop    %ebp
  102cc0:	c3                   	ret    
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
  102cc1:	31 f6                	xor    %esi,%esi
  102cc3:	eb c5                	jmp    102c8a <piperead+0xba>
  102cc5:	8d 74 26 00          	lea    0x0(%esi),%esi
  102cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00102cd0 <pipewrite>:
    release(&p->lock);
}

int
pipewrite(struct pipe *p, char *addr, int n)
{
  102cd0:	55                   	push   %ebp
  102cd1:	89 e5                	mov    %esp,%ebp
  102cd3:	57                   	push   %edi
  102cd4:	56                   	push   %esi
  102cd5:	53                   	push   %ebx
  102cd6:	83 ec 1c             	sub    $0x1c,%esp
  102cd9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
  102cdc:	89 1c 24             	mov    %ebx,(%esp)
  102cdf:	e8 2c 0d 00 00       	call   103a10 <acquire>
  for(i = 0; i < n; i++){
  102ce4:	8b 45 10             	mov    0x10(%ebp),%eax
  102ce7:	85 c0                	test   %eax,%eax
  102ce9:	0f 8e 89 00 00 00    	jle    102d78 <pipewrite+0xa8>
  102cef:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
  102cf5:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
  102cfb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  102d02:	eb 2f                	jmp    102d33 <pipewrite+0x63>
    while(p->nwrite == p->nread + PIPESIZE) {  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
  102d04:	8b 8b 3c 02 00 00    	mov    0x23c(%ebx),%ecx
  102d0a:	85 c9                	test   %ecx,%ecx
  102d0c:	0f 84 7e 00 00 00    	je     102d90 <pipewrite+0xc0>
  102d12:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  102d18:	8b 40 24             	mov    0x24(%eax),%eax
  102d1b:	85 c0                	test   %eax,%eax
  102d1d:	75 71                	jne    102d90 <pipewrite+0xc0>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
  102d1f:	89 3c 24             	mov    %edi,(%esp)
  102d22:	e8 d9 02 00 00       	call   103000 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
  102d27:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  102d2b:	89 34 24             	mov    %esi,(%esp)
  102d2e:	e8 bd 03 00 00       	call   1030f0 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE) {  //DOC: pipewrite-full
  102d33:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
  102d39:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
  102d3f:	05 00 02 00 00       	add    $0x200,%eax
  102d44:	39 c1                	cmp    %eax,%ecx
  102d46:	74 bc                	je     102d04 <pipewrite+0x34>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  102d48:	89 c8                	mov    %ecx,%eax
  102d4a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102d4d:	25 ff 01 00 00       	and    $0x1ff,%eax
  102d52:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102d55:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d58:	0f b6 14 02          	movzbl (%edx,%eax,1),%edx
  102d5c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102d5f:	88 54 03 34          	mov    %dl,0x34(%ebx,%eax,1)
  102d63:	8d 41 01             	lea    0x1(%ecx),%eax
  102d66:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
  102d6c:	8b 55 10             	mov    0x10(%ebp),%edx
  102d6f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  102d73:	39 55 f0             	cmp    %edx,-0x10(%ebp)
  102d76:	75 bb                	jne    102d33 <pipewrite+0x63>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  102d78:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
  102d7e:	89 04 24             	mov    %eax,(%esp)
  102d81:	e8 7a 02 00 00       	call   103000 <wakeup>
  release(&p->lock);
  102d86:	89 1c 24             	mov    %ebx,(%esp)
  102d89:	e8 42 0c 00 00       	call   1039d0 <release>
  102d8e:	eb 0f                	jmp    102d9f <pipewrite+0xcf>

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE) {  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
        release(&p->lock);
  102d90:	89 1c 24             	mov    %ebx,(%esp)
  102d93:	e8 38 0c 00 00       	call   1039d0 <release>
  102d98:	c7 45 10 ff ff ff ff 	movl   $0xffffffff,0x10(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
  102d9f:	8b 45 10             	mov    0x10(%ebp),%eax
  102da2:	83 c4 1c             	add    $0x1c,%esp
  102da5:	5b                   	pop    %ebx
  102da6:	5e                   	pop    %esi
  102da7:	5f                   	pop    %edi
  102da8:	5d                   	pop    %ebp
  102da9:	c3                   	ret    
  102daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102db0 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
  102db0:	55                   	push   %ebp
  102db1:	89 e5                	mov    %esp,%ebp
  102db3:	83 ec 18             	sub    $0x18,%esp
  102db6:	89 75 fc             	mov    %esi,-0x4(%ebp)
  102db9:	8b 75 08             	mov    0x8(%ebp),%esi
  102dbc:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  102dbf:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  acquire(&p->lock);
  102dc2:	89 34 24             	mov    %esi,(%esp)
  102dc5:	e8 46 0c 00 00       	call   103a10 <acquire>
  if(writable){
  102dca:	85 db                	test   %ebx,%ebx
  102dcc:	74 42                	je     102e10 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
  102dce:	8d 86 34 02 00 00    	lea    0x234(%esi),%eax
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
  102dd4:	c7 86 40 02 00 00 00 	movl   $0x0,0x240(%esi)
  102ddb:	00 00 00 
    wakeup(&p->nread);
  102dde:	89 04 24             	mov    %eax,(%esp)
  102de1:	e8 1a 02 00 00       	call   103000 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0) {
  102de6:	8b 86 3c 02 00 00    	mov    0x23c(%esi),%eax
  102dec:	85 c0                	test   %eax,%eax
  102dee:	75 0a                	jne    102dfa <pipeclose+0x4a>
  102df0:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
  102df6:	85 c0                	test   %eax,%eax
  102df8:	74 36                	je     102e30 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
  102dfa:	89 75 08             	mov    %esi,0x8(%ebp)
}
  102dfd:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  102e00:	8b 75 fc             	mov    -0x4(%ebp),%esi
  102e03:	89 ec                	mov    %ebp,%esp
  102e05:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0) {
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
  102e06:	e9 c5 0b 00 00       	jmp    1039d0 <release>
  102e0b:	90                   	nop    
  102e0c:	8d 74 26 00          	lea    0x0(%esi),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  102e10:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
  102e16:	c7 86 3c 02 00 00 00 	movl   $0x0,0x23c(%esi)
  102e1d:	00 00 00 
    wakeup(&p->nwrite);
  102e20:	89 04 24             	mov    %eax,(%esp)
  102e23:	e8 d8 01 00 00       	call   103000 <wakeup>
  102e28:	eb bc                	jmp    102de6 <pipeclose+0x36>
  102e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  if(p->readopen == 0 && p->writeopen == 0) {
    release(&p->lock);
  102e30:	89 34 24             	mov    %esi,(%esp)
  102e33:	e8 98 0b 00 00       	call   1039d0 <release>
    kfree((char*)p);
  } else
    release(&p->lock);
}
  102e38:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0) {
    release(&p->lock);
    kfree((char*)p);
  102e3b:	89 75 08             	mov    %esi,0x8(%ebp)
  } else
    release(&p->lock);
}
  102e3e:	8b 75 fc             	mov    -0x4(%ebp),%esi
  102e41:	89 ec                	mov    %ebp,%esp
  102e43:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0) {
    release(&p->lock);
    kfree((char*)p);
  102e44:	e9 a7 f3 ff ff       	jmp    1021f0 <kfree>
  102e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00102e50 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
  102e50:	55                   	push   %ebp
  102e51:	89 e5                	mov    %esp,%ebp
  102e53:	83 ec 18             	sub    $0x18,%esp
  102e56:	89 75 f8             	mov    %esi,-0x8(%ebp)
  102e59:	8b 75 08             	mov    0x8(%ebp),%esi
  102e5c:	89 7d fc             	mov    %edi,-0x4(%ebp)
  102e5f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  102e62:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
  102e65:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
  102e6b:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
  102e71:	e8 da df ff ff       	call   100e50 <filealloc>
  102e76:	85 c0                	test   %eax,%eax
  102e78:	89 06                	mov    %eax,(%esi)
  102e7a:	0f 84 92 00 00 00    	je     102f12 <pipealloc+0xc2>
  102e80:	e8 cb df ff ff       	call   100e50 <filealloc>
  102e85:	85 c0                	test   %eax,%eax
  102e87:	89 07                	mov    %eax,(%edi)
  102e89:	74 79                	je     102f04 <pipealloc+0xb4>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
  102e8b:	e8 20 f3 ff ff       	call   1021b0 <kalloc>
  102e90:	85 c0                	test   %eax,%eax
  102e92:	89 c3                	mov    %eax,%ebx
  102e94:	74 6e                	je     102f04 <pipealloc+0xb4>
    goto bad;
  p->readopen = 1;
  102e96:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
  102e9d:	00 00 00 
  p->writeopen = 1;
  102ea0:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
  102ea7:	00 00 00 
  p->nwrite = 0;
  102eaa:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
  102eb1:	00 00 00 
  p->nread = 0;
  102eb4:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
  102ebb:	00 00 00 
  initlock(&p->lock, "pipe");
  102ebe:	89 04 24             	mov    %eax,(%esp)
  102ec1:	c7 44 24 04 9c 66 10 	movl   $0x10669c,0x4(%esp)
  102ec8:	00 
  102ec9:	e8 c2 09 00 00       	call   103890 <initlock>
  (*f0)->type = FD_PIPE;
  102ece:	8b 06                	mov    (%esi),%eax
  102ed0:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
  102ed6:	8b 06                	mov    (%esi),%eax
  102ed8:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
  102edc:	8b 06                	mov    (%esi),%eax
  102ede:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
  102ee2:	8b 06                	mov    (%esi),%eax
  102ee4:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
  102ee7:	8b 07                	mov    (%edi),%eax
  102ee9:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
  102eef:	8b 07                	mov    (%edi),%eax
  102ef1:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
  102ef5:	8b 07                	mov    (%edi),%eax
  102ef7:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
  102efb:	8b 07                	mov    (%edi),%eax
  102efd:	89 58 0c             	mov    %ebx,0xc(%eax)
  102f00:	31 c0                	xor    %eax,%eax
  102f02:	eb 19                	jmp    102f1d <pipealloc+0xcd>
  return 0;
  102f04:	8b 06                	mov    (%esi),%eax

 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
  102f06:	85 c0                	test   %eax,%eax
  102f08:	74 08                	je     102f12 <pipealloc+0xc2>
    fileclose(*f0);
  102f0a:	89 04 24             	mov    %eax,(%esp)
  102f0d:	e8 ae df ff ff       	call   100ec0 <fileclose>
  if(*f1)
  102f12:	8b 17                	mov    (%edi),%edx
  102f14:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  102f19:	85 d2                	test   %edx,%edx
  102f1b:	75 0d                	jne    102f2a <pipealloc+0xda>
    fileclose(*f1);
  return -1;
}
  102f1d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  102f20:	8b 75 f8             	mov    -0x8(%ebp),%esi
  102f23:	8b 7d fc             	mov    -0x4(%ebp),%edi
  102f26:	89 ec                	mov    %ebp,%esp
  102f28:	5d                   	pop    %ebp
  102f29:	c3                   	ret    
  if(p)
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  102f2a:	89 14 24             	mov    %edx,(%esp)
  102f2d:	e8 8e df ff ff       	call   100ec0 <fileclose>
  102f32:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  102f37:	eb e4                	jmp    102f1d <pipealloc+0xcd>
  102f39:	90                   	nop    
  102f3a:	90                   	nop    
  102f3b:	90                   	nop    
  102f3c:	90                   	nop    
  102f3d:	90                   	nop    
  102f3e:	90                   	nop    
  102f3f:	90                   	nop    

00102f40 <wakeup1>:

// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  102f40:	55                   	push   %ebp
  102f41:	31 d2                	xor    %edx,%edx
  102f43:	89 e5                	mov    %esp,%ebp
  102f45:	eb 0b                	jmp    102f52 <wakeup1+0x12>
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
  102f47:	83 c2 7c             	add    $0x7c,%edx
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  102f4a:	81 fa 00 1f 00 00    	cmp    $0x1f00,%edx
  102f50:	74 26                	je     102f78 <wakeup1+0x38>
    if(p->state == SLEEPING && p->chan == chan)
  102f52:	83 ba e0 b0 10 00 02 	cmpl   $0x2,0x10b0e0(%edx)
  102f59:	75 ec                	jne    102f47 <wakeup1+0x7>
  102f5b:	39 82 f4 b0 10 00    	cmp    %eax,0x10b0f4(%edx)
  102f61:	75 e4                	jne    102f47 <wakeup1+0x7>
      p->state = RUNNABLE;
  102f63:	c7 82 e0 b0 10 00 03 	movl   $0x3,0x10b0e0(%edx)
  102f6a:	00 00 00 
  102f6d:	83 c2 7c             	add    $0x7c,%edx
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  102f70:	81 fa 00 1f 00 00    	cmp    $0x1f00,%edx
  102f76:	75 da                	jne    102f52 <wakeup1+0x12>
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
  102f78:	5d                   	pop    %ebp
  102f79:	c3                   	ret    
  102f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102f80 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  102f80:	55                   	push   %ebp
  102f81:	89 e5                	mov    %esp,%ebp
  102f83:	53                   	push   %ebx
  102f84:	83 ec 04             	sub    $0x4,%esp
  102f87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
  102f8a:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  102f91:	e8 7a 0a 00 00       	call   103a10 <acquire>
  102f96:	ba d4 b0 10 00       	mov    $0x10b0d4,%edx
  102f9b:	eb 0e                	jmp    102fab <kill+0x2b>
  102f9d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  102fa0:	83 c2 7c             	add    $0x7c,%edx
  102fa3:	81 fa d4 cf 10 00    	cmp    $0x10cfd4,%edx
  102fa9:	74 28                	je     102fd3 <kill+0x53>
    if(p->pid == pid){
  102fab:	8b 42 10             	mov    0x10(%edx),%eax
  102fae:	39 d8                	cmp    %ebx,%eax
  102fb0:	75 ee                	jne    102fa0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
  102fb2:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
  102fb6:	c7 42 24 01 00 00 00 	movl   $0x1,0x24(%edx)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
  102fbd:	74 2b                	je     102fea <kill+0x6a>
        p->state = RUNNABLE;
      release(&ptable.lock);
  102fbf:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  102fc6:	e8 05 0a 00 00       	call   1039d0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
  102fcb:	83 c4 04             	add    $0x4,%esp
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
  102fce:	31 c0                	xor    %eax,%eax
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
  102fd0:	5b                   	pop    %ebx
  102fd1:	5d                   	pop    %ebp
  102fd2:	c3                   	ret    
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  102fd3:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  102fda:	e8 f1 09 00 00       	call   1039d0 <release>
  return -1;
}
  102fdf:	83 c4 04             	add    $0x4,%esp
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  102fe2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return -1;
}
  102fe7:	5b                   	pop    %ebx
  102fe8:	5d                   	pop    %ebp
  102fe9:	c3                   	ret    
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
  102fea:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
  102ff1:	eb cc                	jmp    102fbf <kill+0x3f>
  102ff3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103000 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  103000:	55                   	push   %ebp
  103001:	89 e5                	mov    %esp,%ebp
  103003:	53                   	push   %ebx
  103004:	83 ec 04             	sub    $0x4,%esp
  103007:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
  10300a:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  103011:	e8 fa 09 00 00       	call   103a10 <acquire>
  wakeup1(chan);
  103016:	89 d8                	mov    %ebx,%eax
  103018:	e8 23 ff ff ff       	call   102f40 <wakeup1>
  release(&ptable.lock);
  10301d:	c7 45 08 a0 b0 10 00 	movl   $0x10b0a0,0x8(%ebp)
}
  103024:	83 c4 04             	add    $0x4,%esp
  103027:	5b                   	pop    %ebx
  103028:	5d                   	pop    %ebp
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
  103029:	e9 a2 09 00 00       	jmp    1039d0 <release>
  10302e:	66 90                	xchg   %ax,%ax

00103030 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  103030:	55                   	push   %ebp
  103031:	89 e5                	mov    %esp,%ebp
  103033:	83 ec 08             	sub    $0x8,%esp
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
  103036:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  10303d:	e8 8e 09 00 00       	call   1039d0 <release>
  
  // Return to "caller", actually trapret (see allocproc).
}
  103042:	c9                   	leave  
  103043:	c3                   	ret    
  103044:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10304a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00103050 <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
  103050:	55                   	push   %ebp
  103051:	89 e5                	mov    %esp,%ebp
  103053:	53                   	push   %ebx
  103054:	83 ec 14             	sub    $0x14,%esp
  int intena;

  if(!holding(&ptable.lock))
  103057:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  10305e:	e8 ad 08 00 00       	call   103910 <holding>
  103063:	85 c0                	test   %eax,%eax
  103065:	74 4e                	je     1030b5 <sched+0x65>
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
  103067:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
  10306e:	83 ba ac 00 00 00 01 	cmpl   $0x1,0xac(%edx)
  103075:	75 4a                	jne    1030c1 <sched+0x71>
    panic("sched locks");
  if(proc->state == RUNNING)
  103077:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
  10307e:	83 79 0c 04          	cmpl   $0x4,0xc(%ecx)
  103082:	74 49                	je     1030cd <sched+0x7d>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  103084:	9c                   	pushf  
  103085:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
  103086:	f6 c4 02             	test   $0x2,%ah
  103089:	75 4e                	jne    1030d9 <sched+0x89>
    panic("sched interruptible");
  intena = cpu->intena;
  swtch(&proc->context, cpu->scheduler);
  10308b:	8b 42 04             	mov    0x4(%edx),%eax
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = cpu->intena;
  10308e:	8b 9a b0 00 00 00    	mov    0xb0(%edx),%ebx
  swtch(&proc->context, cpu->scheduler);
  103094:	89 44 24 04          	mov    %eax,0x4(%esp)
  103098:	8d 41 1c             	lea    0x1c(%ecx),%eax
  10309b:	89 04 24             	mov    %eax,(%esp)
  10309e:	e8 f9 0b 00 00       	call   103c9c <swtch>
  cpu->intena = intena;
  1030a3:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  1030a9:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
}
  1030af:	83 c4 14             	add    $0x14,%esp
  1030b2:	5b                   	pop    %ebx
  1030b3:	5d                   	pop    %ebp
  1030b4:	c3                   	ret    
sched(void)
{
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  1030b5:	c7 04 24 a1 66 10 00 	movl   $0x1066a1,(%esp)
  1030bc:	e8 bf d7 ff ff       	call   100880 <panic>
  if(cpu->ncli != 1)
    panic("sched locks");
  1030c1:	c7 04 24 b3 66 10 00 	movl   $0x1066b3,(%esp)
  1030c8:	e8 b3 d7 ff ff       	call   100880 <panic>
  if(proc->state == RUNNING)
    panic("sched running");
  1030cd:	c7 04 24 bf 66 10 00 	movl   $0x1066bf,(%esp)
  1030d4:	e8 a7 d7 ff ff       	call   100880 <panic>
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  1030d9:	c7 04 24 cd 66 10 00 	movl   $0x1066cd,(%esp)
  1030e0:	e8 9b d7 ff ff       	call   100880 <panic>
  1030e5:	8d 74 26 00          	lea    0x0(%esi),%esi
  1030e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001030f0 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  1030f0:	55                   	push   %ebp
  1030f1:	89 e5                	mov    %esp,%ebp
  1030f3:	56                   	push   %esi
  1030f4:	53                   	push   %ebx
  1030f5:	83 ec 10             	sub    $0x10,%esp
  if(proc == 0)
  1030f8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  1030fe:	8b 75 08             	mov    0x8(%ebp),%esi
  103101:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(proc == 0)
  103104:	85 c0                	test   %eax,%eax
  103106:	0f 84 8f 00 00 00    	je     10319b <sleep+0xab>
    panic("sleep");

  if(lk == 0)
  10310c:	85 db                	test   %ebx,%ebx
  10310e:	0f 84 93 00 00 00    	je     1031a7 <sleep+0xb7>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
  103114:	81 fb a0 b0 10 00    	cmp    $0x10b0a0,%ebx
  10311a:	74 56                	je     103172 <sleep+0x82>
    acquire(&ptable.lock);  //DOC: sleeplock1
  10311c:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  103123:	e8 e8 08 00 00       	call   103a10 <acquire>
    release(lk);
  103128:	89 1c 24             	mov    %ebx,(%esp)
  10312b:	e8 a0 08 00 00       	call   1039d0 <release>
  }

  // Go to sleep.
  proc->chan = chan;
  103130:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103136:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
  103139:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10313f:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
  103146:	e8 05 ff ff ff       	call   103050 <sched>

  // Tidy up.
  proc->chan = 0;
  10314b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103151:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
  103158:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  10315f:	e8 6c 08 00 00       	call   1039d0 <release>
    acquire(lk);
  103164:	89 5d 08             	mov    %ebx,0x8(%ebp)
  }
}
  103167:	83 c4 10             	add    $0x10,%esp
  10316a:	5b                   	pop    %ebx
  10316b:	5e                   	pop    %esi
  10316c:	5d                   	pop    %ebp
  proc->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  10316d:	e9 9e 08 00 00       	jmp    103a10 <acquire>
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }

  // Go to sleep.
  proc->chan = chan;
  103172:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
  103175:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10317b:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
  103182:	e8 c9 fe ff ff       	call   103050 <sched>

  // Tidy up.
  proc->chan = 0;
  103187:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10318d:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
  103194:	83 c4 10             	add    $0x10,%esp
  103197:	5b                   	pop    %ebx
  103198:	5e                   	pop    %esi
  103199:	5d                   	pop    %ebp
  10319a:	c3                   	ret    
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(proc == 0)
    panic("sleep");
  10319b:	c7 04 24 e1 66 10 00 	movl   $0x1066e1,(%esp)
  1031a2:	e8 d9 d6 ff ff       	call   100880 <panic>

  if(lk == 0)
    panic("sleep without lk");
  1031a7:	c7 04 24 e7 66 10 00 	movl   $0x1066e7,(%esp)
  1031ae:	e8 cd d6 ff ff       	call   100880 <panic>
  1031b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1031b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001031c0 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  1031c0:	55                   	push   %ebp
  1031c1:	89 e5                	mov    %esp,%ebp
  1031c3:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
  1031c6:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  1031cd:	e8 3e 08 00 00       	call   103a10 <acquire>
  proc->state = RUNNABLE;
  1031d2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1031d8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
  1031df:	e8 6c fe ff ff       	call   103050 <sched>
  release(&ptable.lock);
  1031e4:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  1031eb:	e8 e0 07 00 00       	call   1039d0 <release>
}
  1031f0:	c9                   	leave  
  1031f1:	c3                   	ret    
  1031f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  1031f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103200 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  103200:	55                   	push   %ebp
  103201:	89 e5                	mov    %esp,%ebp
  103203:	53                   	push   %ebx
  103204:	83 ec 14             	sub    $0x14,%esp
}

static inline void
sti(void)
{
  asm volatile("sti");
  103207:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
  103208:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  10320f:	bb d4 b0 10 00       	mov    $0x10b0d4,%ebx
  103214:	e8 f7 07 00 00       	call   103a10 <acquire>
  103219:	eb 10                	jmp    10322b <scheduler+0x2b>
  10321b:	90                   	nop    
  10321c:	8d 74 26 00          	lea    0x0(%esi),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103220:	83 c3 7c             	add    $0x7c,%ebx
  103223:	81 fb d4 cf 10 00    	cmp    $0x10cfd4,%ebx
  103229:	74 56                	je     103281 <scheduler+0x81>
      if(p->state != RUNNABLE)
  10322b:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
  10322f:	90                   	nop    
  103230:	75 ee                	jne    103220 <scheduler+0x20>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
  103232:	65 89 1d 04 00 00 00 	mov    %ebx,%gs:0x4
      switchuvm(p);
  103239:	89 1c 24             	mov    %ebx,(%esp)
  10323c:	e8 7f 2d 00 00       	call   105fc0 <switchuvm>
      p->state = RUNNING;
      swtch(&cpu->scheduler, proc->context);
  103241:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
      p->state = RUNNING;
  103247:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  10324e:	83 c3 7c             	add    $0x7c,%ebx
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
      p->state = RUNNING;
      swtch(&cpu->scheduler, proc->context);
  103251:	8b 40 1c             	mov    0x1c(%eax),%eax
  103254:	89 44 24 04          	mov    %eax,0x4(%esp)
  103258:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  10325e:	83 c0 04             	add    $0x4,%eax
  103261:	89 04 24             	mov    %eax,(%esp)
  103264:	e8 33 0a 00 00       	call   103c9c <swtch>
      switchkvm();
  103269:	e8 32 27 00 00       	call   1059a0 <switchkvm>
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  10326e:	81 fb d4 cf 10 00    	cmp    $0x10cfd4,%ebx
      swtch(&cpu->scheduler, proc->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
  103274:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
  10327b:	00 00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  10327f:	75 aa                	jne    10322b <scheduler+0x2b>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
  103281:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  103288:	e8 43 07 00 00       	call   1039d0 <release>
  10328d:	e9 75 ff ff ff       	jmp    103207 <scheduler+0x7>
  103292:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  103299:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001032a0 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  1032a0:	55                   	push   %ebp
  1032a1:	89 e5                	mov    %esp,%ebp
  1032a3:	56                   	push   %esi
  1032a4:	53                   	push   %ebx
  1032a5:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
  1032a8:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  1032af:	e8 5c 07 00 00       	call   103a10 <acquire>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
  1032b4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1032ba:	bb d4 b0 10 00       	mov    $0x10b0d4,%ebx
  1032bf:	31 d2                	xor    %edx,%edx
  1032c1:	eb 0b                	jmp    1032ce <wait+0x2e>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  1032c3:	83 c3 7c             	add    $0x7c,%ebx
  1032c6:	81 fb d4 cf 10 00    	cmp    $0x10cfd4,%ebx
  1032cc:	74 1b                	je     1032e9 <wait+0x49>
      if(p->parent != proc)
  1032ce:	39 43 14             	cmp    %eax,0x14(%ebx)
  1032d1:	75 f0                	jne    1032c3 <wait+0x23>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
  1032d3:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
  1032d7:	74 2d                	je     103306 <wait+0x66>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  1032d9:	83 c3 7c             	add    $0x7c,%ebx
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        release(&ptable.lock);
        return pid;
  1032dc:	ba 01 00 00 00       	mov    $0x1,%edx

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  1032e1:	81 fb d4 cf 10 00    	cmp    $0x10cfd4,%ebx
  1032e7:	75 e5                	jne    1032ce <wait+0x2e>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
  1032e9:	85 d2                	test   %edx,%edx
  1032eb:	74 6e                	je     10335b <wait+0xbb>
  1032ed:	8b 50 24             	mov    0x24(%eax),%edx
  1032f0:	85 d2                	test   %edx,%edx
  1032f2:	75 67                	jne    10335b <wait+0xbb>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  1032f4:	c7 44 24 04 a0 b0 10 	movl   $0x10b0a0,0x4(%esp)
  1032fb:	00 
  1032fc:	89 04 24             	mov    %eax,(%esp)
  1032ff:	e8 ec fd ff ff       	call   1030f0 <sleep>
  103304:	eb ae                	jmp    1032b4 <wait+0x14>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
  103306:	8b 43 08             	mov    0x8(%ebx),%eax
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
  103309:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
  10330c:	89 04 24             	mov    %eax,(%esp)
  10330f:	e8 dc ee ff ff       	call   1021f0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
  103314:	8b 43 04             	mov    0x4(%ebx),%eax
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
  103317:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
  10331e:	89 04 24             	mov    %eax,(%esp)
  103321:	e8 da 29 00 00       	call   105d00 <freevm>
        p->state = UNUSED;
  103326:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        p->pid = 0;
  10332d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
  103334:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
  10333b:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
  10333f:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        release(&ptable.lock);
  103346:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  10334d:	e8 7e 06 00 00       	call   1039d0 <release>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
  103352:	83 c4 10             	add    $0x10,%esp
  103355:	89 f0                	mov    %esi,%eax
  103357:	5b                   	pop    %ebx
  103358:	5e                   	pop    %esi
  103359:	5d                   	pop    %ebp
  10335a:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
  10335b:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  103362:	be ff ff ff ff       	mov    $0xffffffff,%esi
  103367:	e8 64 06 00 00       	call   1039d0 <release>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
  10336c:	83 c4 10             	add    $0x10,%esp
  10336f:	89 f0                	mov    %esi,%eax
  103371:	5b                   	pop    %ebx
  103372:	5e                   	pop    %esi
  103373:	5d                   	pop    %ebp
  103374:	c3                   	ret    
  103375:	8d 74 26 00          	lea    0x0(%esi),%esi
  103379:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103380 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  103380:	55                   	push   %ebp
  103381:	89 e5                	mov    %esp,%ebp
  103383:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
  103386:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10338c:	3b 05 48 78 10 00    	cmp    0x107848,%eax
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  103392:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  103395:	89 75 fc             	mov    %esi,-0x4(%ebp)
  struct proc *p;
  int fd;

  if(proc == initproc)
  103398:	75 0c                	jne    1033a6 <exit+0x26>
    panic("init exiting");
  10339a:	c7 04 24 f8 66 10 00 	movl   $0x1066f8,(%esp)
  1033a1:	e8 da d4 ff ff       	call   100880 <panic>
  1033a6:	31 db                	xor    %ebx,%ebx

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
  1033a8:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
  1033ac:	85 d2                	test   %edx,%edx
  1033ae:	74 1c                	je     1033cc <exit+0x4c>
      fileclose(proc->ofile[fd]);
  1033b0:	89 14 24             	mov    %edx,(%esp)
  1033b3:	e8 08 db ff ff       	call   100ec0 <fileclose>
      proc->ofile[fd] = 0;
  1033b8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1033be:	c7 44 98 28 00 00 00 	movl   $0x0,0x28(%eax,%ebx,4)
  1033c5:	00 
  1033c6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
  1033cc:	83 c3 01             	add    $0x1,%ebx
  1033cf:	83 fb 10             	cmp    $0x10,%ebx
  1033d2:	75 d4                	jne    1033a8 <exit+0x28>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  iput(proc->cwd);
  1033d4:	8b 40 68             	mov    0x68(%eax),%eax
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
  1033d7:	30 db                	xor    %bl,%bl
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  iput(proc->cwd);
  1033d9:	89 04 24             	mov    %eax,(%esp)
  1033dc:	e8 8f e4 ff ff       	call   101870 <iput>
  proc->cwd = 0;
  1033e1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1033e7:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
  1033ee:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  1033f5:	e8 16 06 00 00       	call   103a10 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
  1033fa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103400:	8b 40 14             	mov    0x14(%eax),%eax
  103403:	e8 38 fb ff ff       	call   102f40 <wakeup1>

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
  103408:	8b 35 48 78 10 00    	mov    0x107848,%esi
  10340e:	eb 0b                	jmp    10341b <exit+0x9b>
      if(p->state == ZOMBIE)
        wakeup1(initproc);
  103410:	83 c3 7c             	add    $0x7c,%ebx

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103413:	81 fb 00 1f 00 00    	cmp    $0x1f00,%ebx
  103419:	74 27                	je     103442 <exit+0xc2>
    if(p->parent == proc){
  10341b:	8b 83 e8 b0 10 00    	mov    0x10b0e8(%ebx),%eax
  103421:	65 3b 05 04 00 00 00 	cmp    %gs:0x4,%eax
  103428:	75 e6                	jne    103410 <exit+0x90>
      p->parent = initproc;
      if(p->state == ZOMBIE)
  10342a:	83 bb e0 b0 10 00 05 	cmpl   $0x5,0x10b0e0(%ebx)
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
  103431:	89 b3 e8 b0 10 00    	mov    %esi,0x10b0e8(%ebx)
      if(p->state == ZOMBIE)
  103437:	75 d7                	jne    103410 <exit+0x90>
        wakeup1(initproc);
  103439:	89 f0                	mov    %esi,%eax
  10343b:	e8 00 fb ff ff       	call   102f40 <wakeup1>
  103440:	eb ce                	jmp    103410 <exit+0x90>
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
  103442:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103448:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
  10344f:	e8 fc fb ff ff       	call   103050 <sched>
  panic("zombie exit");
  103454:	c7 04 24 05 67 10 00 	movl   $0x106705,(%esp)
  10345b:	e8 20 d4 ff ff       	call   100880 <panic>

00103460 <allocproc>:
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and return it.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  103460:	55                   	push   %ebp
  103461:	89 e5                	mov    %esp,%ebp
  103463:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  103464:	bb d4 b0 10 00       	mov    $0x10b0d4,%ebx
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and return it.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  103469:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  10346c:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  103473:	e8 98 05 00 00       	call   103a10 <acquire>
  103478:	eb 11                	jmp    10348b <allocproc+0x2b>
  10347a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  103480:	83 c3 7c             	add    $0x7c,%ebx
  103483:	81 fb d4 cf 10 00    	cmp    $0x10cfd4,%ebx
  103489:	74 7e                	je     103509 <allocproc+0xa9>
    if(p->state == UNUSED)
  10348b:	8b 4b 0c             	mov    0xc(%ebx),%ecx
  10348e:	85 c9                	test   %ecx,%ecx
  103490:	75 ee                	jne    103480 <allocproc+0x20>
      goto found;
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  103492:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
  103499:	a1 04 73 10 00       	mov    0x107304,%eax
  10349e:	89 43 10             	mov    %eax,0x10(%ebx)
  1034a1:	83 c0 01             	add    $0x1,%eax
  1034a4:	a3 04 73 10 00       	mov    %eax,0x107304
  release(&ptable.lock);
  1034a9:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  1034b0:	e8 1b 05 00 00       	call   1039d0 <release>

  // Allocate kernel stack if possible.
  if((p->kstack = kalloc()) == 0){
  1034b5:	e8 f6 ec ff ff       	call   1021b0 <kalloc>
  1034ba:	85 c0                	test   %eax,%eax
  1034bc:	89 c2                	mov    %eax,%edx
  1034be:	89 43 08             	mov    %eax,0x8(%ebx)
  1034c1:	74 5c                	je     10351f <allocproc+0xbf>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  1034c3:	8d 80 b4 0f 00 00    	lea    0xfb4(%eax),%eax
  p->tf = (struct trapframe*)sp;
  1034c9:	89 43 18             	mov    %eax,0x18(%ebx)
  // which returns to trapret (see below).
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  1034cc:	8d 82 9c 0f 00 00    	lea    0xf9c(%edx),%eax
  p->tf = (struct trapframe*)sp;
  
  // Set up new context to start executing at forkret,
  // which returns to trapret (see below).
  sp -= 4;
  *(uint*)sp = (uint)trapret;
  1034d2:	c7 82 b0 0f 00 00 d0 	movl   $0x104ad0,0xfb0(%edx)
  1034d9:	4a 10 00 

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  1034dc:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
  1034df:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
  1034e6:	00 
  1034e7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1034ee:	00 
  1034ef:	89 04 24             	mov    %eax,(%esp)
  1034f2:	e8 89 05 00 00       	call   103a80 <memset>
  p->context->eip = (uint)forkret;
  1034f7:	8b 43 1c             	mov    0x1c(%ebx),%eax
  1034fa:	c7 40 10 30 30 10 00 	movl   $0x103030,0x10(%eax)
  return p;
}
  103501:	89 d8                	mov    %ebx,%eax
  103503:	83 c4 14             	add    $0x14,%esp
  103506:	5b                   	pop    %ebx
  103507:	5d                   	pop    %ebp
  103508:	c3                   	ret    

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
  103509:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  103510:	31 db                	xor    %ebx,%ebx
  103512:	e8 b9 04 00 00       	call   1039d0 <release>
  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
  return p;
}
  103517:	89 d8                	mov    %ebx,%eax
  103519:	83 c4 14             	add    $0x14,%esp
  10351c:	5b                   	pop    %ebx
  10351d:	5d                   	pop    %ebp
  10351e:	c3                   	ret    
  p->pid = nextpid++;
  release(&ptable.lock);

  // Allocate kernel stack if possible.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
  10351f:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  103526:	31 db                	xor    %ebx,%ebx
  103528:	eb d7                	jmp    103501 <allocproc+0xa1>
  10352a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103530 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  103530:	55                   	push   %ebp
  103531:	89 e5                	mov    %esp,%ebp
  103533:	56                   	push   %esi
  103534:	53                   	push   %ebx
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
  103535:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  10353a:	83 ec 10             	sub    $0x10,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
  10353d:	e8 1e ff ff ff       	call   103460 <allocproc>
  103542:	85 c0                	test   %eax,%eax
  103544:	89 c6                	mov    %eax,%esi
  103546:	0f 84 c4 00 00 00    	je     103610 <fork+0xe0>
    return -1;

  // Copy process state from p.
  if(!(np->pgdir = copyuvm(proc->pgdir, proc->sz))){
  10354c:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  103553:	8b 02                	mov    (%edx),%eax
  103555:	89 44 24 04          	mov    %eax,0x4(%esp)
  103559:	8b 42 04             	mov    0x4(%edx),%eax
  10355c:	89 04 24             	mov    %eax,(%esp)
  10355f:	e8 1c 28 00 00       	call   105d80 <copyuvm>
  103564:	85 c0                	test   %eax,%eax
  103566:	89 46 04             	mov    %eax,0x4(%esi)
  103569:	0f 84 aa 00 00 00    	je     103619 <fork+0xe9>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = proc->sz;
  10356f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  np->parent = proc;
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
  103575:	31 db                	xor    %ebx,%ebx
    np->state = UNUSED;
    return -1;
  }
  np->sz = proc->sz;
  np->parent = proc;
  *np->tf = *proc->tf;
  103577:	8b 56 18             	mov    0x18(%esi),%edx
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = proc->sz;
  10357a:	8b 00                	mov    (%eax),%eax
  10357c:	89 06                	mov    %eax,(%esi)
  np->parent = proc;
  10357e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103584:	89 46 14             	mov    %eax,0x14(%esi)
  *np->tf = *proc->tf;
  103587:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10358d:	8b 40 18             	mov    0x18(%eax),%eax
  103590:	89 14 24             	mov    %edx,(%esp)
  103593:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
  10359a:	00 
  10359b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10359f:	e8 dc 05 00 00       	call   103b80 <memcpy>

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
  1035a4:	8b 46 18             	mov    0x18(%esi),%eax
  1035a7:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  1035ae:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
  1035b5:	8b 44 9a 28          	mov    0x28(%edx,%ebx,4),%eax
  1035b9:	85 c0                	test   %eax,%eax
  1035bb:	74 13                	je     1035d0 <fork+0xa0>
      np->ofile[i] = filedup(proc->ofile[i]);
  1035bd:	89 04 24             	mov    %eax,(%esp)
  1035c0:	e8 3b d8 ff ff       	call   100e00 <filedup>
  1035c5:	89 44 9e 28          	mov    %eax,0x28(%esi,%ebx,4)
  1035c9:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
  1035d0:	83 c3 01             	add    $0x1,%ebx
  1035d3:	83 fb 10             	cmp    $0x10,%ebx
  1035d6:	75 dd                	jne    1035b5 <fork+0x85>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
  1035d8:	8b 42 68             	mov    0x68(%edx),%eax
  1035db:	89 04 24             	mov    %eax,(%esp)
  1035de:	e8 fd d9 ff ff       	call   100fe0 <idup>
 
  pid = np->pid;
  1035e3:	8b 5e 10             	mov    0x10(%esi),%ebx
  np->state = RUNNABLE;
  1035e6:	c7 46 0c 03 00 00 00 	movl   $0x3,0xc(%esi)
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
  1035ed:	89 46 68             	mov    %eax,0x68(%esi)
 
  pid = np->pid;
  np->state = RUNNABLE;
  safestrcpy(np->name, proc->name, sizeof(proc->name));
  1035f0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1035f6:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  1035fd:	00 
  1035fe:	83 c0 6c             	add    $0x6c,%eax
  103601:	89 44 24 04          	mov    %eax,0x4(%esp)
  103605:	8d 46 6c             	lea    0x6c(%esi),%eax
  103608:	89 04 24             	mov    %eax,(%esp)
  10360b:	e8 30 06 00 00       	call   103c40 <safestrcpy>
  return pid;
}
  103610:	83 c4 10             	add    $0x10,%esp
  103613:	89 d8                	mov    %ebx,%eax
  103615:	5b                   	pop    %ebx
  103616:	5e                   	pop    %esi
  103617:	5d                   	pop    %ebp
  103618:	c3                   	ret    
  if((np = allocproc()) == 0)
    return -1;

  // Copy process state from p.
  if(!(np->pgdir = copyuvm(proc->pgdir, proc->sz))){
    kfree(np->kstack);
  103619:	8b 46 08             	mov    0x8(%esi),%eax
  10361c:	89 04 24             	mov    %eax,(%esp)
  10361f:	e8 cc eb ff ff       	call   1021f0 <kfree>
    np->kstack = 0;
  103624:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
    np->state = UNUSED;
  10362b:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
  103632:	eb dc                	jmp    103610 <fork+0xe0>
  103634:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10363a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00103640 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  103640:	55                   	push   %ebp
  103641:	89 e5                	mov    %esp,%ebp
  103643:	83 ec 18             	sub    $0x18,%esp
  uint sz = proc->sz;
  103646:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
  if(n > 0){
  10364d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz = proc->sz;
  103651:	8b 11                	mov    (%ecx),%edx
  if(n > 0){
  103653:	7f 16                	jg     10366b <growproc+0x2b>
    if(!(sz = allocuvm(proc->pgdir, sz, sz + n)))
      return -1;
  } else if(n < 0){
  103655:	75 3b                	jne    103692 <growproc+0x52>
    if(!(sz = deallocuvm(proc->pgdir, sz, sz + n)))
      return -1;
  }
  proc->sz = sz;
  103657:	89 11                	mov    %edx,(%ecx)
  switchuvm(proc);
  103659:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10365f:	89 04 24             	mov    %eax,(%esp)
  103662:	e8 59 29 00 00       	call   105fc0 <switchuvm>
  103667:	31 c0                	xor    %eax,%eax
  return 0;
}
  103669:	c9                   	leave  
  10366a:	c3                   	ret    
int
growproc(int n)
{
  uint sz = proc->sz;
  if(n > 0){
    if(!(sz = allocuvm(proc->pgdir, sz, sz + n)))
  10366b:	8b 45 08             	mov    0x8(%ebp),%eax
  10366e:	89 54 24 04          	mov    %edx,0x4(%esp)
  103672:	01 d0                	add    %edx,%eax
  103674:	89 44 24 08          	mov    %eax,0x8(%esp)
  103678:	8b 41 04             	mov    0x4(%ecx),%eax
  10367b:	89 04 24             	mov    %eax,(%esp)
  10367e:	e8 bd 27 00 00       	call   105e40 <allocuvm>
  103683:	85 c0                	test   %eax,%eax
  103685:	74 27                	je     1036ae <growproc+0x6e>
  103687:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
      return -1;
  } else if(n < 0){
    if(!(sz = deallocuvm(proc->pgdir, sz, sz + n)))
  10368e:	89 c2                	mov    %eax,%edx
  103690:	eb c5                	jmp    103657 <growproc+0x17>
  103692:	8b 45 08             	mov    0x8(%ebp),%eax
  103695:	89 54 24 04          	mov    %edx,0x4(%esp)
  103699:	01 d0                	add    %edx,%eax
  10369b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10369f:	8b 41 04             	mov    0x4(%ecx),%eax
  1036a2:	89 04 24             	mov    %eax,(%esp)
  1036a5:	e8 c6 25 00 00       	call   105c70 <deallocuvm>
  1036aa:	85 c0                	test   %eax,%eax
  1036ac:	75 d9                	jne    103687 <growproc+0x47>
      return -1;
  }
  proc->sz = sz;
  switchuvm(proc);
  return 0;
}
  1036ae:	c9                   	leave  
    if(!(sz = deallocuvm(proc->pgdir, sz, sz + n)))
      return -1;
  }
  proc->sz = sz;
  switchuvm(proc);
  return 0;
  1036af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1036b4:	c3                   	ret    
  1036b5:	8d 74 26 00          	lea    0x0(%esi),%esi
  1036b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001036c0 <userinit>:
}

// Set up first user process.
void
userinit(void)
{
  1036c0:	55                   	push   %ebp
  1036c1:	89 e5                	mov    %esp,%ebp
  1036c3:	53                   	push   %ebx
  1036c4:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
  1036c7:	e8 94 fd ff ff       	call   103460 <allocproc>
  1036cc:	89 c3                	mov    %eax,%ebx
  initproc = p;
  1036ce:	a3 48 78 10 00       	mov    %eax,0x107848
  if(!(p->pgdir = setupkvm()))
  1036d3:	e8 c8 24 00 00       	call   105ba0 <setupkvm>
  1036d8:	85 c0                	test   %eax,%eax
  1036da:	89 43 04             	mov    %eax,0x4(%ebx)
  1036dd:	0f 84 b6 00 00 00    	je     103799 <userinit+0xd9>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  1036e3:	89 04 24             	mov    %eax,(%esp)
  1036e6:	c7 44 24 08 2c 00 00 	movl   $0x2c,0x8(%esp)
  1036ed:	00 
  1036ee:	c7 44 24 04 08 77 10 	movl   $0x107708,0x4(%esp)
  1036f5:	00 
  1036f6:	e8 15 24 00 00       	call   105b10 <inituvm>
  p->sz = PGSIZE;
  1036fb:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
  103701:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
  103708:	00 
  103709:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  103710:	00 
  103711:	8b 43 18             	mov    0x18(%ebx),%eax
  103714:	89 04 24             	mov    %eax,(%esp)
  103717:	e8 64 03 00 00       	call   103a80 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  10371c:	8b 43 18             	mov    0x18(%ebx),%eax
  10371f:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  103725:	8b 43 18             	mov    0x18(%ebx),%eax
  103728:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
  10372e:	8b 53 18             	mov    0x18(%ebx),%edx
  103731:	0f b7 42 2c          	movzwl 0x2c(%edx),%eax
  103735:	66 89 42 28          	mov    %ax,0x28(%edx)
  p->tf->ss = p->tf->ds;
  103739:	8b 53 18             	mov    0x18(%ebx),%edx
  10373c:	0f b7 42 2c          	movzwl 0x2c(%edx),%eax
  103740:	66 89 42 48          	mov    %ax,0x48(%edx)
  p->tf->eflags = FL_IF;
  103744:	8b 43 18             	mov    0x18(%ebx),%eax
  103747:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
  10374e:	8b 43 18             	mov    0x18(%ebx),%eax
  103751:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
  103758:	8b 43 18             	mov    0x18(%ebx),%eax
  10375b:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
  103762:	8d 43 6c             	lea    0x6c(%ebx),%eax
  103765:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  10376c:	00 
  10376d:	c7 44 24 04 2a 67 10 	movl   $0x10672a,0x4(%esp)
  103774:	00 
  103775:	89 04 24             	mov    %eax,(%esp)
  103778:	e8 c3 04 00 00       	call   103c40 <safestrcpy>
  p->cwd = namei("/");
  10377d:	c7 04 24 33 67 10 00 	movl   $0x106733,(%esp)
  103784:	e8 c7 e5 ff ff       	call   101d50 <namei>

  p->state = RUNNABLE;
  103789:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");
  103790:	89 43 68             	mov    %eax,0x68(%ebx)

  p->state = RUNNABLE;
}
  103793:	83 c4 14             	add    $0x14,%esp
  103796:	5b                   	pop    %ebx
  103797:	5d                   	pop    %ebp
  103798:	c3                   	ret    
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
  initproc = p;
  if(!(p->pgdir = setupkvm()))
    panic("userinit: out of memory?");
  103799:	c7 04 24 11 67 10 00 	movl   $0x106711,(%esp)
  1037a0:	e8 db d0 ff ff       	call   100880 <panic>
  1037a5:	8d 74 26 00          	lea    0x0(%esi),%esi
  1037a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001037b0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  1037b0:	55                   	push   %ebp
  1037b1:	89 e5                	mov    %esp,%ebp
  1037b3:	57                   	push   %edi
  1037b4:	56                   	push   %esi
  1037b5:	53                   	push   %ebx
  1037b6:	bb d4 b0 10 00       	mov    $0x10b0d4,%ebx
  1037bb:	83 ec 4c             	sub    $0x4c,%esp
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
  1037be:	8d 7d cc             	lea    -0x34(%ebp),%edi
  1037c1:	eb 46                	jmp    103809 <procdump+0x59>
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
  1037c3:	8b 0c 85 74 67 10 00 	mov    0x106774(,%eax,4),%ecx
  1037ca:	85 c9                	test   %ecx,%ecx
  1037cc:	74 47                	je     103815 <procdump+0x65>
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
  1037ce:	8b 53 10             	mov    0x10(%ebx),%edx
  1037d1:	8d 43 6c             	lea    0x6c(%ebx),%eax
  1037d4:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1037d8:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  1037dc:	c7 04 24 39 67 10 00 	movl   $0x106739,(%esp)
  1037e3:	89 54 24 04          	mov    %edx,0x4(%esp)
  1037e7:	e8 d4 cc ff ff       	call   1004c0 <cprintf>
    if(p->state == SLEEPING){
  1037ec:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
  1037f0:	74 2a                	je     10381c <procdump+0x6c>
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  1037f2:	c7 04 24 16 66 10 00 	movl   $0x106616,(%esp)
  1037f9:	e8 c2 cc ff ff       	call   1004c0 <cprintf>
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  1037fe:	83 c3 7c             	add    $0x7c,%ebx
  103801:	81 fb d4 cf 10 00    	cmp    $0x10cfd4,%ebx
  103807:	74 4f                	je     103858 <procdump+0xa8>
    if(p->state == UNUSED)
  103809:	8b 43 0c             	mov    0xc(%ebx),%eax
  10380c:	85 c0                	test   %eax,%eax
  10380e:	74 ee                	je     1037fe <procdump+0x4e>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
  103810:	83 f8 05             	cmp    $0x5,%eax
  103813:	76 ae                	jbe    1037c3 <procdump+0x13>
  103815:	b9 35 67 10 00       	mov    $0x106735,%ecx
  10381a:	eb b2                	jmp    1037ce <procdump+0x1e>
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
  10381c:	8b 43 1c             	mov    0x1c(%ebx),%eax
  10381f:	be 01 00 00 00       	mov    $0x1,%esi
  103824:	89 7c 24 04          	mov    %edi,0x4(%esp)
  103828:	8b 40 0c             	mov    0xc(%eax),%eax
  10382b:	83 c0 08             	add    $0x8,%eax
  10382e:	89 04 24             	mov    %eax,(%esp)
  103831:	e8 7a 00 00 00       	call   1038b0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
  103836:	8b 44 b7 fc          	mov    -0x4(%edi,%esi,4),%eax
  10383a:	85 c0                	test   %eax,%eax
  10383c:	74 b4                	je     1037f2 <procdump+0x42>
        cprintf(" %p", pc[i]);
  10383e:	83 c6 01             	add    $0x1,%esi
  103841:	89 44 24 04          	mov    %eax,0x4(%esp)
  103845:	c7 04 24 ea 61 10 00 	movl   $0x1061ea,(%esp)
  10384c:	e8 6f cc ff ff       	call   1004c0 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
  103851:	83 fe 0b             	cmp    $0xb,%esi
  103854:	75 e0                	jne    103836 <procdump+0x86>
  103856:	eb 9a                	jmp    1037f2 <procdump+0x42>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
  103858:	83 c4 4c             	add    $0x4c,%esp
  10385b:	5b                   	pop    %ebx
  10385c:	5e                   	pop    %esi
  10385d:	5f                   	pop    %edi
  10385e:	5d                   	pop    %ebp
  10385f:	90                   	nop    
  103860:	c3                   	ret    
  103861:	eb 0d                	jmp    103870 <pinit>
  103863:	90                   	nop    
  103864:	90                   	nop    
  103865:	90                   	nop    
  103866:	90                   	nop    
  103867:	90                   	nop    
  103868:	90                   	nop    
  103869:	90                   	nop    
  10386a:	90                   	nop    
  10386b:	90                   	nop    
  10386c:	90                   	nop    
  10386d:	90                   	nop    
  10386e:	90                   	nop    
  10386f:	90                   	nop    

00103870 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
  103870:	55                   	push   %ebp
  103871:	89 e5                	mov    %esp,%ebp
  103873:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");
  103876:	c7 44 24 04 42 67 10 	movl   $0x106742,0x4(%esp)
  10387d:	00 
  10387e:	c7 04 24 a0 b0 10 00 	movl   $0x10b0a0,(%esp)
  103885:	e8 06 00 00 00       	call   103890 <initlock>
}
  10388a:	c9                   	leave  
  10388b:	c3                   	ret    
  10388c:	90                   	nop    
  10388d:	90                   	nop    
  10388e:	90                   	nop    
  10388f:	90                   	nop    

00103890 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  103890:	55                   	push   %ebp
  103891:	89 e5                	mov    %esp,%ebp
  103893:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
  103896:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
  103899:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
  10389f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
  1038a2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
  1038a9:	5d                   	pop    %ebp
  1038aa:	c3                   	ret    
  1038ab:	90                   	nop    
  1038ac:	8d 74 26 00          	lea    0x0(%esi),%esi

001038b0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  1038b0:	55                   	push   %ebp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  1038b1:	31 c9                	xor    %ecx,%ecx
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  1038b3:	89 e5                	mov    %esp,%ebp
  1038b5:	53                   	push   %ebx
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  1038b6:	8b 55 08             	mov    0x8(%ebp),%edx
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  1038b9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  1038bc:	83 ea 08             	sub    $0x8,%edx
  1038bf:	eb 02                	jmp    1038c3 <getcallerpcs+0x13>
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint *) 0x100000 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  1038c1:	89 c2                	mov    %eax,%edx
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint *) 0x100000 || ebp == (uint*)0xffffffff)
  1038c3:	8d 82 00 00 f0 ff    	lea    -0x100000(%edx),%eax
  1038c9:	3d fe ff ef ff       	cmp    $0xffeffffe,%eax
  1038ce:	77 13                	ja     1038e3 <getcallerpcs+0x33>
      break;
    pcs[i] = ebp[1];     // saved %eip
  1038d0:	8b 42 04             	mov    0x4(%edx),%eax
  1038d3:	89 04 8b             	mov    %eax,(%ebx,%ecx,4)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
  1038d6:	83 c1 01             	add    $0x1,%ecx
    if(ebp == 0 || ebp < (uint *) 0x100000 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  1038d9:	8b 02                	mov    (%edx),%eax
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
  1038db:	83 f9 0a             	cmp    $0xa,%ecx
  1038de:	75 e1                	jne    1038c1 <getcallerpcs+0x11>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
  1038e0:	5b                   	pop    %ebx
  1038e1:	5d                   	pop    %ebp
  1038e2:	c3                   	ret    
    if(ebp == 0 || ebp < (uint *) 0x100000 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
  1038e3:	83 f9 09             	cmp    $0x9,%ecx
  1038e6:	7f f8                	jg     1038e0 <getcallerpcs+0x30>
  1038e8:	8d 04 8b             	lea    (%ebx,%ecx,4),%eax
  1038eb:	90                   	nop    
  1038ec:	8d 74 26 00          	lea    0x0(%esi),%esi
  1038f0:	83 c1 01             	add    $0x1,%ecx
    pcs[i] = 0;
  1038f3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint *) 0x100000 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
  1038f9:	83 c0 04             	add    $0x4,%eax
  1038fc:	83 f9 0a             	cmp    $0xa,%ecx
  1038ff:	75 ef                	jne    1038f0 <getcallerpcs+0x40>
    pcs[i] = 0;
}
  103901:	5b                   	pop    %ebx
  103902:	5d                   	pop    %ebp
  103903:	c3                   	ret    
  103904:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10390a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00103910 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  103910:	55                   	push   %ebp
  return lock->locked && lock->cpu == cpu;
  103911:	31 c0                	xor    %eax,%eax
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  103913:	89 e5                	mov    %esp,%ebp
  103915:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu;
  103918:	8b 0a                	mov    (%edx),%ecx
  10391a:	85 c9                	test   %ecx,%ecx
  10391c:	74 10                	je     10392e <holding+0x1e>
  10391e:	8b 42 08             	mov    0x8(%edx),%eax
  103921:	65 3b 05 00 00 00 00 	cmp    %gs:0x0,%eax
  103928:	0f 94 c0             	sete   %al
  10392b:	0f b6 c0             	movzbl %al,%eax
}
  10392e:	5d                   	pop    %ebp
  10392f:	c3                   	ret    

00103930 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
  103930:	55                   	push   %ebp
  103931:	89 e5                	mov    %esp,%ebp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  103933:	9c                   	pushf  
  103934:	59                   	pop    %ecx
}

static inline void
cli(void)
{
  asm volatile("cli");
  103935:	fa                   	cli    
  int eflags;
  
  eflags = readeflags();
  cli();
  if(cpu->ncli++ == 0)
  103936:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  10393c:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
  103942:	83 c2 01             	add    $0x1,%edx
  103945:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
  10394b:	83 ea 01             	sub    $0x1,%edx
  10394e:	74 02                	je     103952 <pushcli+0x22>
    cpu->intena = eflags & FL_IF;
}
  103950:	5d                   	pop    %ebp
  103951:	c3                   	ret    
  int eflags;
  
  eflags = readeflags();
  cli();
  if(cpu->ncli++ == 0)
    cpu->intena = eflags & FL_IF;
  103952:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  103958:	81 e1 00 02 00 00    	and    $0x200,%ecx
  10395e:	89 88 b0 00 00 00    	mov    %ecx,0xb0(%eax)
}
  103964:	5d                   	pop    %ebp
  103965:	c3                   	ret    
  103966:	8d 76 00             	lea    0x0(%esi),%esi
  103969:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103970 <popcli>:

void
popcli(void)
{
  103970:	55                   	push   %ebp
  103971:	89 e5                	mov    %esp,%ebp
  103973:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  103976:	9c                   	pushf  
  103977:	58                   	pop    %eax
  if(readeflags()&FL_IF)
  103978:	f6 c4 02             	test   $0x2,%ah
  10397b:	75 36                	jne    1039b3 <popcli+0x43>
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
  10397d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  103983:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
  103989:	83 ea 01             	sub    $0x1,%edx
  10398c:	85 d2                	test   %edx,%edx
  10398e:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
  103994:	78 29                	js     1039bf <popcli+0x4f>
    panic("popcli");
  if(cpu->ncli == 0 && cpu->intena)
  103996:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  10399c:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
  1039a2:	85 d2                	test   %edx,%edx
  1039a4:	75 0b                	jne    1039b1 <popcli+0x41>
  1039a6:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
  1039ac:	85 c0                	test   %eax,%eax
  1039ae:	74 01                	je     1039b1 <popcli+0x41>
}

static inline void
sti(void)
{
  asm volatile("sti");
  1039b0:	fb                   	sti    
    sti();
}
  1039b1:	c9                   	leave  
  1039b2:	c3                   	ret    

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  1039b3:	c7 04 24 8c 67 10 00 	movl   $0x10678c,(%esp)
  1039ba:	e8 c1 ce ff ff       	call   100880 <panic>
  if(--cpu->ncli < 0)
    panic("popcli");
  1039bf:	c7 04 24 a3 67 10 00 	movl   $0x1067a3,(%esp)
  1039c6:	e8 b5 ce ff ff       	call   100880 <panic>
  1039cb:	90                   	nop    
  1039cc:	8d 74 26 00          	lea    0x0(%esi),%esi

001039d0 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
  1039d0:	55                   	push   %ebp
  1039d1:	89 e5                	mov    %esp,%ebp
  1039d3:	53                   	push   %ebx
  1039d4:	83 ec 04             	sub    $0x4,%esp
  1039d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
  1039da:	89 1c 24             	mov    %ebx,(%esp)
  1039dd:	e8 2e ff ff ff       	call   103910 <holding>
  1039e2:	85 c0                	test   %eax,%eax
  1039e4:	74 1d                	je     103a03 <release+0x33>
    panic("release");

  lk->pcs[0] = 0;
  1039e6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  1039ed:	31 c0                	xor    %eax,%eax
  lk->cpu = 0;
  1039ef:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  1039f6:	f0 87 03             	lock xchg %eax,(%ebx)
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);

  popcli();
}
  1039f9:	83 c4 04             	add    $0x4,%esp
  1039fc:	5b                   	pop    %ebx
  1039fd:	5d                   	pop    %ebp
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);

  popcli();
  1039fe:	e9 6d ff ff ff       	jmp    103970 <popcli>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
  103a03:	c7 04 24 aa 67 10 00 	movl   $0x1067aa,(%esp)
  103a0a:	e8 71 ce ff ff       	call   100880 <panic>
  103a0f:	90                   	nop    

00103a10 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
  103a10:	55                   	push   %ebp
  103a11:	89 e5                	mov    %esp,%ebp
  103a13:	53                   	push   %ebx
  103a14:	83 ec 14             	sub    $0x14,%esp
  pushcli();
  103a17:	e8 14 ff ff ff       	call   103930 <pushcli>
  if(holding(lk))
  103a1c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  103a1f:	89 1c 24             	mov    %ebx,(%esp)
  103a22:	e8 e9 fe ff ff       	call   103910 <holding>
  103a27:	85 c0                	test   %eax,%eax
  103a29:	74 08                	je     103a33 <acquire+0x23>
  103a2b:	eb 39                	jmp    103a66 <acquire+0x56>
  103a2d:	8d 76 00             	lea    0x0(%esi),%esi
  103a30:	8b 5d 08             	mov    0x8(%ebp),%ebx
  103a33:	b8 01 00 00 00       	mov    $0x1,%eax
  103a38:	f0 87 03             	lock xchg %eax,(%ebx)
    panic("acquire");

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
  103a3b:	85 c0                	test   %eax,%eax
  103a3d:	75 f1                	jne    103a30 <acquire+0x20>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
  103a3f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  103a45:	8b 55 08             	mov    0x8(%ebp),%edx
  103a48:	89 42 08             	mov    %eax,0x8(%edx)
  getcallerpcs(&lk, lk->pcs);
  103a4b:	8b 45 08             	mov    0x8(%ebp),%eax
  103a4e:	83 c0 0c             	add    $0xc,%eax
  103a51:	89 44 24 04          	mov    %eax,0x4(%esp)
  103a55:	8d 45 08             	lea    0x8(%ebp),%eax
  103a58:	89 04 24             	mov    %eax,(%esp)
  103a5b:	e8 50 fe ff ff       	call   1038b0 <getcallerpcs>
}
  103a60:	83 c4 14             	add    $0x14,%esp
  103a63:	5b                   	pop    %ebx
  103a64:	5d                   	pop    %ebp
  103a65:	c3                   	ret    
void
acquire(struct spinlock *lk)
{
  pushcli();
  if(holding(lk))
    panic("acquire");
  103a66:	c7 04 24 b2 67 10 00 	movl   $0x1067b2,(%esp)
  103a6d:	e8 0e ce ff ff       	call   100880 <panic>
  103a72:	90                   	nop    
  103a73:	90                   	nop    
  103a74:	90                   	nop    
  103a75:	90                   	nop    
  103a76:	90                   	nop    
  103a77:	90                   	nop    
  103a78:	90                   	nop    
  103a79:	90                   	nop    
  103a7a:	90                   	nop    
  103a7b:	90                   	nop    
  103a7c:	90                   	nop    
  103a7d:	90                   	nop    
  103a7e:	90                   	nop    
  103a7f:	90                   	nop    

00103a80 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
  103a80:	55                   	push   %ebp
  103a81:	89 e5                	mov    %esp,%ebp
  103a83:	8b 55 08             	mov    0x8(%ebp),%edx
  103a86:	57                   	push   %edi
  103a87:	8b 45 0c             	mov    0xc(%ebp),%eax
  103a8a:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  103a8d:	89 d7                	mov    %edx,%edi
  103a8f:	fc                   	cld    
  103a90:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  103a92:	5f                   	pop    %edi
  103a93:	89 d0                	mov    %edx,%eax
  103a95:	5d                   	pop    %ebp
  103a96:	c3                   	ret    
  103a97:	89 f6                	mov    %esi,%esi
  103a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103aa0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
  103aa0:	55                   	push   %ebp
  103aa1:	89 e5                	mov    %esp,%ebp
  103aa3:	57                   	push   %edi
  103aa4:	56                   	push   %esi
  103aa5:	53                   	push   %ebx
  103aa6:	83 ec 04             	sub    $0x4,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  103aa9:	8b 45 10             	mov    0x10(%ebp),%eax
  return dst;
}

int
memcmp(const void *v1, const void *v2, uint n)
{
  103aac:	8b 55 08             	mov    0x8(%ebp),%edx
  103aaf:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  103ab2:	83 e8 01             	sub    $0x1,%eax
  103ab5:	83 f8 ff             	cmp    $0xffffffff,%eax
  103ab8:	74 36                	je     103af0 <memcmp+0x50>
    if(*s1 != *s2)
  103aba:	0f b6 32             	movzbl (%edx),%esi
  103abd:	0f b6 0f             	movzbl (%edi),%ecx
  103ac0:	89 f3                	mov    %esi,%ebx
  103ac2:	88 4d f3             	mov    %cl,-0xd(%ebp)
      return *s1 - *s2;
  103ac5:	89 d1                	mov    %edx,%ecx
  103ac7:	89 fa                	mov    %edi,%edx
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
  103ac9:	3a 5d f3             	cmp    -0xd(%ebp),%bl
  103acc:	74 1a                	je     103ae8 <memcmp+0x48>
  103ace:	eb 2c                	jmp    103afc <memcmp+0x5c>
  103ad0:	0f b6 71 01          	movzbl 0x1(%ecx),%esi
  103ad4:	83 c1 01             	add    $0x1,%ecx
  103ad7:	0f b6 5a 01          	movzbl 0x1(%edx),%ebx
  103adb:	83 c2 01             	add    $0x1,%edx
  103ade:	88 5d f3             	mov    %bl,-0xd(%ebp)
  103ae1:	89 f3                	mov    %esi,%ebx
  103ae3:	3a 5d f3             	cmp    -0xd(%ebp),%bl
  103ae6:	75 14                	jne    103afc <memcmp+0x5c>
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  103ae8:	83 e8 01             	sub    $0x1,%eax
  103aeb:	83 f8 ff             	cmp    $0xffffffff,%eax
  103aee:	75 e0                	jne    103ad0 <memcmp+0x30>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
  103af0:	83 c4 04             	add    $0x4,%esp
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  103af3:	31 d2                	xor    %edx,%edx
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
  103af5:	5b                   	pop    %ebx
  103af6:	89 d0                	mov    %edx,%eax
  103af8:	5e                   	pop    %esi
  103af9:	5f                   	pop    %edi
  103afa:	5d                   	pop    %ebp
  103afb:	c3                   	ret    
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
  103afc:	89 f0                	mov    %esi,%eax
  103afe:	0f b6 d0             	movzbl %al,%edx
  103b01:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
    s1++, s2++;
  }

  return 0;
}
  103b05:	83 c4 04             	add    $0x4,%esp
  103b08:	5b                   	pop    %ebx
  103b09:	5e                   	pop    %esi
  103b0a:	5f                   	pop    %edi
  103b0b:	5d                   	pop    %ebp
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
  103b0c:	29 c2                	sub    %eax,%edx
    s1++, s2++;
  }

  return 0;
}
  103b0e:	89 d0                	mov    %edx,%eax
  103b10:	c3                   	ret    
  103b11:	eb 0d                	jmp    103b20 <memmove>
  103b13:	90                   	nop    
  103b14:	90                   	nop    
  103b15:	90                   	nop    
  103b16:	90                   	nop    
  103b17:	90                   	nop    
  103b18:	90                   	nop    
  103b19:	90                   	nop    
  103b1a:	90                   	nop    
  103b1b:	90                   	nop    
  103b1c:	90                   	nop    
  103b1d:	90                   	nop    
  103b1e:	90                   	nop    
  103b1f:	90                   	nop    

00103b20 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
  103b20:	55                   	push   %ebp
  103b21:	89 e5                	mov    %esp,%ebp
  103b23:	56                   	push   %esi
  103b24:	53                   	push   %ebx
  103b25:	8b 75 08             	mov    0x8(%ebp),%esi
  103b28:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  103b2b:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
  103b2e:	39 f1                	cmp    %esi,%ecx
  103b30:	73 2e                	jae    103b60 <memmove+0x40>
  103b32:	8d 04 19             	lea    (%ecx,%ebx,1),%eax
  103b35:	39 c6                	cmp    %eax,%esi
  103b37:	73 27                	jae    103b60 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
  103b39:	85 db                	test   %ebx,%ebx
  103b3b:	74 1a                	je     103b57 <memmove+0x37>
  103b3d:	89 c2                	mov    %eax,%edx
  103b3f:	29 d8                	sub    %ebx,%eax
  103b41:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
  103b44:	89 c3                	mov    %eax,%ebx
      *--d = *--s;
  103b46:	0f b6 42 ff          	movzbl -0x1(%edx),%eax
  103b4a:	83 ea 01             	sub    $0x1,%edx
  103b4d:	88 41 ff             	mov    %al,-0x1(%ecx)
  103b50:	83 e9 01             	sub    $0x1,%ecx
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
  103b53:	39 da                	cmp    %ebx,%edx
  103b55:	75 ef                	jne    103b46 <memmove+0x26>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
  103b57:	89 f0                	mov    %esi,%eax
  103b59:	5b                   	pop    %ebx
  103b5a:	5e                   	pop    %esi
  103b5b:	5d                   	pop    %ebp
  103b5c:	c3                   	ret    
  103b5d:	8d 76 00             	lea    0x0(%esi),%esi
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
  103b60:	31 d2                	xor    %edx,%edx
      *--d = *--s;
  } else
    while(n-- > 0)
  103b62:	85 db                	test   %ebx,%ebx
  103b64:	74 f1                	je     103b57 <memmove+0x37>
      *d++ = *s++;
  103b66:	0f b6 04 0a          	movzbl (%edx,%ecx,1),%eax
  103b6a:	88 04 32             	mov    %al,(%edx,%esi,1)
  103b6d:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
  103b70:	39 da                	cmp    %ebx,%edx
  103b72:	75 f2                	jne    103b66 <memmove+0x46>
      *d++ = *s++;

  return dst;
}
  103b74:	89 f0                	mov    %esi,%eax
  103b76:	5b                   	pop    %ebx
  103b77:	5e                   	pop    %esi
  103b78:	5d                   	pop    %ebp
  103b79:	c3                   	ret    
  103b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103b80 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  103b80:	55                   	push   %ebp
  103b81:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
  103b83:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
  103b84:	e9 97 ff ff ff       	jmp    103b20 <memmove>
  103b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00103b90 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
  103b90:	55                   	push   %ebp
  103b91:	89 e5                	mov    %esp,%ebp
  103b93:	56                   	push   %esi
  103b94:	53                   	push   %ebx
  103b95:	8b 5d 10             	mov    0x10(%ebp),%ebx
  103b98:	8b 55 08             	mov    0x8(%ebp),%edx
  103b9b:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
  103b9e:	85 db                	test   %ebx,%ebx
  103ba0:	74 2a                	je     103bcc <strncmp+0x3c>
  103ba2:	0f b6 02             	movzbl (%edx),%eax
  103ba5:	84 c0                	test   %al,%al
  103ba7:	74 2b                	je     103bd4 <strncmp+0x44>
  103ba9:	0f b6 0e             	movzbl (%esi),%ecx
  103bac:	38 c8                	cmp    %cl,%al
  103bae:	74 17                	je     103bc7 <strncmp+0x37>
  103bb0:	eb 25                	jmp    103bd7 <strncmp+0x47>
  103bb2:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    n--, p++, q++;
  103bb6:	83 c6 01             	add    $0x1,%esi
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
  103bb9:	84 c0                	test   %al,%al
  103bbb:	74 17                	je     103bd4 <strncmp+0x44>
  103bbd:	0f b6 0e             	movzbl (%esi),%ecx
  103bc0:	83 c2 01             	add    $0x1,%edx
  103bc3:	38 c8                	cmp    %cl,%al
  103bc5:	75 10                	jne    103bd7 <strncmp+0x47>
  103bc7:	83 eb 01             	sub    $0x1,%ebx
  103bca:	75 e6                	jne    103bb2 <strncmp+0x22>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
  103bcc:	5b                   	pop    %ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
  103bcd:	31 d2                	xor    %edx,%edx
}
  103bcf:	5e                   	pop    %esi
  103bd0:	89 d0                	mov    %edx,%eax
  103bd2:	5d                   	pop    %ebp
  103bd3:	c3                   	ret    
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
  103bd4:	0f b6 0e             	movzbl (%esi),%ecx
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
  103bd7:	0f b6 d0             	movzbl %al,%edx
  103bda:	0f b6 c1             	movzbl %cl,%eax
}
  103bdd:	5b                   	pop    %ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
  103bde:	29 c2                	sub    %eax,%edx
}
  103be0:	5e                   	pop    %esi
  103be1:	89 d0                	mov    %edx,%eax
  103be3:	5d                   	pop    %ebp
  103be4:	c3                   	ret    
  103be5:	8d 74 26 00          	lea    0x0(%esi),%esi
  103be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103bf0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
  103bf0:	55                   	push   %ebp
  103bf1:	89 e5                	mov    %esp,%ebp
  103bf3:	56                   	push   %esi
  103bf4:	8b 75 08             	mov    0x8(%ebp),%esi
  103bf7:	53                   	push   %ebx
  103bf8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  103bfb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  103bfe:	89 f2                	mov    %esi,%edx
  103c00:	eb 03                	jmp    103c05 <strncpy+0x15>
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
  103c02:	83 c3 01             	add    $0x1,%ebx
  103c05:	83 e9 01             	sub    $0x1,%ecx
  103c08:	8d 41 01             	lea    0x1(%ecx),%eax
  103c0b:	85 c0                	test   %eax,%eax
  103c0d:	7e 0c                	jle    103c1b <strncpy+0x2b>
  103c0f:	0f b6 03             	movzbl (%ebx),%eax
  103c12:	88 02                	mov    %al,(%edx)
  103c14:	83 c2 01             	add    $0x1,%edx
  103c17:	84 c0                	test   %al,%al
  103c19:	75 e7                	jne    103c02 <strncpy+0x12>
    ;
  while(n-- > 0)
  103c1b:	85 c9                	test   %ecx,%ecx
  103c1d:	7e 0d                	jle    103c2c <strncpy+0x3c>
  103c1f:	8d 04 11             	lea    (%ecx,%edx,1),%eax
    *s++ = 0;
  103c22:	c6 02 00             	movb   $0x0,(%edx)
  103c25:	83 c2 01             	add    $0x1,%edx
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
  103c28:	39 c2                	cmp    %eax,%edx
  103c2a:	75 f6                	jne    103c22 <strncpy+0x32>
    *s++ = 0;
  return os;
}
  103c2c:	89 f0                	mov    %esi,%eax
  103c2e:	5b                   	pop    %ebx
  103c2f:	5e                   	pop    %esi
  103c30:	5d                   	pop    %ebp
  103c31:	c3                   	ret    
  103c32:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  103c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103c40 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
  103c40:	55                   	push   %ebp
  103c41:	89 e5                	mov    %esp,%ebp
  103c43:	8b 4d 10             	mov    0x10(%ebp),%ecx
  103c46:	56                   	push   %esi
  103c47:	8b 75 08             	mov    0x8(%ebp),%esi
  103c4a:	53                   	push   %ebx
  103c4b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;
  
  os = s;
  if(n <= 0)
  103c4e:	85 c9                	test   %ecx,%ecx
  103c50:	7e 1b                	jle    103c6d <safestrcpy+0x2d>
  103c52:	89 f2                	mov    %esi,%edx
  103c54:	eb 03                	jmp    103c59 <safestrcpy+0x19>
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
  103c56:	83 c3 01             	add    $0x1,%ebx
  103c59:	83 e9 01             	sub    $0x1,%ecx
  103c5c:	74 0c                	je     103c6a <safestrcpy+0x2a>
  103c5e:	0f b6 03             	movzbl (%ebx),%eax
  103c61:	88 02                	mov    %al,(%edx)
  103c63:	83 c2 01             	add    $0x1,%edx
  103c66:	84 c0                	test   %al,%al
  103c68:	75 ec                	jne    103c56 <safestrcpy+0x16>
    ;
  *s = 0;
  103c6a:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
  103c6d:	89 f0                	mov    %esi,%eax
  103c6f:	5b                   	pop    %ebx
  103c70:	5e                   	pop    %esi
  103c71:	5d                   	pop    %ebp
  103c72:	c3                   	ret    
  103c73:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103c80 <strlen>:

int
strlen(const char *s)
{
  103c80:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
  103c81:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
  103c83:	89 e5                	mov    %esp,%ebp
  103c85:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  103c88:	80 3a 00             	cmpb   $0x0,(%edx)
  103c8b:	74 0c                	je     103c99 <strlen+0x19>
  103c8d:	8d 76 00             	lea    0x0(%esi),%esi
  103c90:	83 c0 01             	add    $0x1,%eax
  103c93:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  103c97:	75 f7                	jne    103c90 <strlen+0x10>
    ;
  return n;
}
  103c99:	5d                   	pop    %ebp
  103c9a:	c3                   	ret    
  103c9b:	90                   	nop    

00103c9c <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
  103c9c:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
  103ca0:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
  103ca4:	55                   	push   %ebp
  pushl %ebx
  103ca5:	53                   	push   %ebx
  pushl %esi
  103ca6:	56                   	push   %esi
  pushl %edi
  103ca7:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
  103ca8:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
  103caa:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
  103cac:	5f                   	pop    %edi
  popl %esi
  103cad:	5e                   	pop    %esi
  popl %ebx
  103cae:	5b                   	pop    %ebx
  popl %ebp
  103caf:	5d                   	pop    %ebp
  ret
  103cb0:	c3                   	ret    
  103cb1:	90                   	nop    
  103cb2:	90                   	nop    
  103cb3:	90                   	nop    
  103cb4:	90                   	nop    
  103cb5:	90                   	nop    
  103cb6:	90                   	nop    
  103cb7:	90                   	nop    
  103cb8:	90                   	nop    
  103cb9:	90                   	nop    
  103cba:	90                   	nop    
  103cbb:	90                   	nop    
  103cbc:	90                   	nop    
  103cbd:	90                   	nop    
  103cbe:	90                   	nop    
  103cbf:	90                   	nop    

00103cc0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  103cc0:	55                   	push   %ebp
  103cc1:	89 e5                	mov    %esp,%ebp
  if(addr >= p->sz || addr+4 > p->sz)
  103cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  103cc6:	8b 10                	mov    (%eax),%edx
  103cc8:	3b 55 0c             	cmp    0xc(%ebp),%edx
  103ccb:	77 07                	ja     103cd4 <fetchint+0x14>
    return -1;
  *ip = *(int*)(addr);
  return 0;
}
  103ccd:	5d                   	pop    %ebp
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
    return -1;
  *ip = *(int*)(addr);
  return 0;
  103cce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  103cd3:	c3                   	ret    

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  103cd4:	8b 45 0c             	mov    0xc(%ebp),%eax
  103cd7:	83 c0 04             	add    $0x4,%eax
  103cda:	39 c2                	cmp    %eax,%edx
  103cdc:	72 ef                	jb     103ccd <fetchint+0xd>
    return -1;
  *ip = *(int*)(addr);
  103cde:	8b 55 0c             	mov    0xc(%ebp),%edx
  103ce1:	8b 02                	mov    (%edx),%eax
  103ce3:	8b 55 10             	mov    0x10(%ebp),%edx
  103ce6:	89 02                	mov    %eax,(%edx)
  103ce8:	31 c0                	xor    %eax,%eax
  return 0;
}
  103cea:	5d                   	pop    %ebp
  103ceb:	c3                   	ret    
  103cec:	8d 74 26 00          	lea    0x0(%esi),%esi

00103cf0 <fetchstr>:
// Fetch the nul-terminated string at addr from process p.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(struct proc *p, uint addr, char **pp)
{
  103cf0:	55                   	push   %ebp
  103cf1:	89 e5                	mov    %esp,%ebp
  103cf3:	8b 45 08             	mov    0x8(%ebp),%eax
  103cf6:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *s, *ep;

  if(addr >= p->sz)
  103cf9:	39 10                	cmp    %edx,(%eax)
  103cfb:	77 07                	ja     103d04 <fetchstr+0x14>
    return -1;
  *pp = (char *) addr;
  ep = (char *) p->sz;
  for(s = *pp; s < ep; s++)
  103cfd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    if(*s == 0)
      return s - *pp;
  return -1;
}
  103d02:	5d                   	pop    %ebp
  103d03:	c3                   	ret    
{
  char *s, *ep;

  if(addr >= p->sz)
    return -1;
  *pp = (char *) addr;
  103d04:	8b 4d 10             	mov    0x10(%ebp),%ecx
  103d07:	89 11                	mov    %edx,(%ecx)
  ep = (char *) p->sz;
  103d09:	8b 08                	mov    (%eax),%ecx
  for(s = *pp; s < ep; s++)
  103d0b:	39 ca                	cmp    %ecx,%edx
  103d0d:	73 ee                	jae    103cfd <fetchstr+0xd>
    if(*s == 0)
  103d0f:	31 c0                	xor    %eax,%eax
  103d11:	80 3a 00             	cmpb   $0x0,(%edx)
  103d14:	74 ec                	je     103d02 <fetchstr+0x12>
  103d16:	89 d0                	mov    %edx,%eax

  if(addr >= p->sz)
    return -1;
  *pp = (char *) addr;
  ep = (char *) p->sz;
  for(s = *pp; s < ep; s++)
  103d18:	83 c0 01             	add    $0x1,%eax
  103d1b:	39 c8                	cmp    %ecx,%eax
  103d1d:	74 de                	je     103cfd <fetchstr+0xd>
    if(*s == 0)
  103d1f:	80 38 00             	cmpb   $0x0,(%eax)
  103d22:	75 f4                	jne    103d18 <fetchstr+0x28>
      return s - *pp;
  return -1;
}
  103d24:	5d                   	pop    %ebp
  if(addr >= p->sz)
    return -1;
  *pp = (char *) addr;
  ep = (char *) p->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
  103d25:	29 d0                	sub    %edx,%eax
      return s - *pp;
  return -1;
}
  103d27:	c3                   	ret    
  103d28:	90                   	nop    
  103d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00103d30 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  103d30:	55                   	push   %ebp
  103d31:	89 e5                	mov    %esp,%ebp
  103d33:	83 ec 0c             	sub    $0xc,%esp
  int x = fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
  103d36:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
  103d3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  103d40:	89 44 24 08          	mov    %eax,0x8(%esp)
  103d44:	8b 41 18             	mov    0x18(%ecx),%eax
  103d47:	8b 50 44             	mov    0x44(%eax),%edx
  103d4a:	8b 45 08             	mov    0x8(%ebp),%eax
  103d4d:	89 0c 24             	mov    %ecx,(%esp)
  103d50:	83 c2 04             	add    $0x4,%edx
  103d53:	8d 04 82             	lea    (%edx,%eax,4),%eax
  103d56:	89 44 24 04          	mov    %eax,0x4(%esp)
  103d5a:	e8 61 ff ff ff       	call   103cc0 <fetchint>
  return x;
}
  103d5f:	c9                   	leave  
  103d60:	c3                   	ret    
  103d61:	eb 0d                	jmp    103d70 <argptr>
  103d63:	90                   	nop    
  103d64:	90                   	nop    
  103d65:	90                   	nop    
  103d66:	90                   	nop    
  103d67:	90                   	nop    
  103d68:	90                   	nop    
  103d69:	90                   	nop    
  103d6a:	90                   	nop    
  103d6b:	90                   	nop    
  103d6c:	90                   	nop    
  103d6d:	90                   	nop    
  103d6e:	90                   	nop    
  103d6f:	90                   	nop    

00103d70 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
  103d70:	55                   	push   %ebp
  103d71:	89 e5                	mov    %esp,%ebp
  103d73:	83 ec 18             	sub    $0x18,%esp
  int i;
  
  if(argint(n, &i) < 0)
  103d76:	8d 45 fc             	lea    -0x4(%ebp),%eax
  103d79:	89 44 24 04          	mov    %eax,0x4(%esp)
  103d7d:	8b 45 08             	mov    0x8(%ebp),%eax
  103d80:	89 04 24             	mov    %eax,(%esp)
  103d83:	e8 a8 ff ff ff       	call   103d30 <argint>
  103d88:	85 c0                	test   %eax,%eax
  103d8a:	79 07                	jns    103d93 <argptr+0x23>
  // Modified by Jingyue
  if((uint)i > proc->sz || (uint)i+size > proc->sz)
    return -1;
  *pp = (char *) i;
  return 0;
}
  103d8c:	c9                   	leave  
    return -1;
  // Modified by Jingyue
  if((uint)i > proc->sz || (uint)i+size > proc->sz)
    return -1;
  *pp = (char *) i;
  return 0;
  103d8d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  103d92:	c3                   	ret    
  int i;
  
  if(argint(n, &i) < 0)
    return -1;
  // Modified by Jingyue
  if((uint)i > proc->sz || (uint)i+size > proc->sz)
  103d93:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103d99:	8b 55 fc             	mov    -0x4(%ebp),%edx
  103d9c:	8b 08                	mov    (%eax),%ecx
  103d9e:	39 ca                	cmp    %ecx,%edx
  103da0:	77 ea                	ja     103d8c <argptr+0x1c>
  103da2:	8b 45 10             	mov    0x10(%ebp),%eax
  103da5:	01 d0                	add    %edx,%eax
  103da7:	39 c1                	cmp    %eax,%ecx
  103da9:	72 e1                	jb     103d8c <argptr+0x1c>
    return -1;
  *pp = (char *) i;
  103dab:	8b 45 0c             	mov    0xc(%ebp),%eax
  103dae:	89 10                	mov    %edx,(%eax)
  103db0:	31 c0                	xor    %eax,%eax
  return 0;
}
  103db2:	c9                   	leave  
  103db3:	c3                   	ret    
  103db4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103dba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00103dc0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
  103dc0:	55                   	push   %ebp
  103dc1:	89 e5                	mov    %esp,%ebp
  103dc3:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  if(argint(n, &addr) < 0)
  103dc6:	8d 45 fc             	lea    -0x4(%ebp),%eax
  103dc9:	89 44 24 04          	mov    %eax,0x4(%esp)
  103dcd:	8b 45 08             	mov    0x8(%ebp),%eax
  103dd0:	89 04 24             	mov    %eax,(%esp)
  103dd3:	e8 58 ff ff ff       	call   103d30 <argint>
  103dd8:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  103ddd:	85 c0                	test   %eax,%eax
  103ddf:	78 1e                	js     103dff <argstr+0x3f>
    return -1;
  return fetchstr(proc, addr, pp);
  103de1:	8b 45 0c             	mov    0xc(%ebp),%eax
  103de4:	89 44 24 08          	mov    %eax,0x8(%esp)
  103de8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103deb:	89 44 24 04          	mov    %eax,0x4(%esp)
  103def:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103df5:	89 04 24             	mov    %eax,(%esp)
  103df8:	e8 f3 fe ff ff       	call   103cf0 <fetchstr>
  103dfd:	89 c2                	mov    %eax,%edx
}
  103dff:	c9                   	leave  
  103e00:	89 d0                	mov    %edx,%eax
  103e02:	c3                   	ret    
  103e03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103e10 <syscall>:
[SYS_freepages] sys_freepages,
};

void
syscall(void)
{
  103e10:	55                   	push   %ebp
  103e11:	89 e5                	mov    %esp,%ebp
  103e13:	53                   	push   %ebx
  103e14:	83 ec 14             	sub    $0x14,%esp
  int num;
  
  num = proc->tf->eax;
  103e17:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103e1d:	8b 58 18             	mov    0x18(%eax),%ebx
  103e20:	8b 4b 1c             	mov    0x1c(%ebx),%ecx
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
  103e23:	83 f9 16             	cmp    $0x16,%ecx
  103e26:	77 18                	ja     103e40 <syscall+0x30>
  103e28:	8b 14 8d e0 67 10 00 	mov    0x1067e0(,%ecx,4),%edx
  103e2f:	85 d2                	test   %edx,%edx
  103e31:	74 0d                	je     103e40 <syscall+0x30>
    proc->tf->eax = syscalls[num]();
  103e33:	ff d2                	call   *%edx
  103e35:	89 43 1c             	mov    %eax,0x1c(%ebx)
  else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  }
}
  103e38:	83 c4 14             	add    $0x14,%esp
  103e3b:	5b                   	pop    %ebx
  103e3c:	5d                   	pop    %ebp
  103e3d:	c3                   	ret    
  103e3e:	66 90                	xchg   %ax,%ax
  
  num = proc->tf->eax;
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
    proc->tf->eax = syscalls[num]();
  else {
    cprintf("%d %s: unknown sys call %d\n",
  103e40:	8b 50 10             	mov    0x10(%eax),%edx
  103e43:	83 c0 6c             	add    $0x6c,%eax
  103e46:	89 44 24 08          	mov    %eax,0x8(%esp)
  103e4a:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  103e4e:	c7 04 24 ba 67 10 00 	movl   $0x1067ba,(%esp)
  103e55:	89 54 24 04          	mov    %edx,0x4(%esp)
  103e59:	e8 62 c6 ff ff       	call   1004c0 <cprintf>
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  103e5e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103e64:	8b 40 18             	mov    0x18(%eax),%eax
  103e67:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
  103e6e:	83 c4 14             	add    $0x14,%esp
  103e71:	5b                   	pop    %ebx
  103e72:	5d                   	pop    %ebp
  103e73:	c3                   	ret    
  103e74:	90                   	nop    
  103e75:	90                   	nop    
  103e76:	90                   	nop    
  103e77:	90                   	nop    
  103e78:	90                   	nop    
  103e79:	90                   	nop    
  103e7a:	90                   	nop    
  103e7b:	90                   	nop    
  103e7c:	90                   	nop    
  103e7d:	90                   	nop    
  103e7e:	90                   	nop    
  103e7f:	90                   	nop    

00103e80 <fdalloc>:
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
  103e80:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  103e87:	89 c1                	mov    %eax,%ecx
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
  103e89:	31 c0                	xor    %eax,%eax

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  103e8b:	55                   	push   %ebp
  103e8c:	89 e5                	mov    %esp,%ebp
  103e8e:	66 90                	xchg   %ax,%ax
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
  103e90:	83 7c 82 28 00       	cmpl   $0x0,0x28(%edx,%eax,4)
  103e95:	74 0f                	je     103ea6 <fdalloc+0x26>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
  103e97:	83 c0 01             	add    $0x1,%eax
  103e9a:	83 f8 10             	cmp    $0x10,%eax
  103e9d:	75 f1                	jne    103e90 <fdalloc+0x10>
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
}
  103e9f:	5d                   	pop    %ebp
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
  103ea0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
}
  103ea5:	c3                   	ret    
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
  103ea6:	89 4c 82 28          	mov    %ecx,0x28(%edx,%eax,4)
      return fd;
    }
  }
  return -1;
}
  103eaa:	5d                   	pop    %ebp
  103eab:	c3                   	ret    
  103eac:	8d 74 26 00          	lea    0x0(%esi),%esi

00103eb0 <sys_pipe>:
  return exec(path, argv);
}

int
sys_pipe(void)
{
  103eb0:	55                   	push   %ebp
  103eb1:	89 e5                	mov    %esp,%ebp
  103eb3:	53                   	push   %ebx
  103eb4:	83 ec 24             	sub    $0x24,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
  103eb7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  103eba:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
  103ec1:	00 
  103ec2:	89 44 24 04          	mov    %eax,0x4(%esp)
  103ec6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  103ecd:	e8 9e fe ff ff       	call   103d70 <argptr>
  103ed2:	85 c0                	test   %eax,%eax
  103ed4:	79 0b                	jns    103ee1 <sys_pipe+0x31>
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
  103ed6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  103edb:	83 c4 24             	add    $0x24,%esp
  103ede:	5b                   	pop    %ebx
  103edf:	5d                   	pop    %ebp
  103ee0:	c3                   	ret    
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
  103ee1:	8d 45 f0             	lea    -0x10(%ebp),%eax
  103ee4:	89 44 24 04          	mov    %eax,0x4(%esp)
  103ee8:	8d 45 f4             	lea    -0xc(%ebp),%eax
  103eeb:	89 04 24             	mov    %eax,(%esp)
  103eee:	e8 5d ef ff ff       	call   102e50 <pipealloc>
  103ef3:	85 c0                	test   %eax,%eax
  103ef5:	78 df                	js     103ed6 <sys_pipe+0x26>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
  103ef7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103efa:	e8 81 ff ff ff       	call   103e80 <fdalloc>
  103eff:	85 c0                	test   %eax,%eax
  103f01:	89 c3                	mov    %eax,%ebx
  103f03:	78 2b                	js     103f30 <sys_pipe+0x80>
  103f05:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103f08:	e8 73 ff ff ff       	call   103e80 <fdalloc>
  103f0d:	85 c0                	test   %eax,%eax
  103f0f:	89 c2                	mov    %eax,%edx
  103f11:	78 0f                	js     103f22 <sys_pipe+0x72>
      proc->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  103f13:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103f16:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
  103f18:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103f1b:	89 50 04             	mov    %edx,0x4(%eax)
  103f1e:	31 c0                	xor    %eax,%eax
  103f20:	eb b9                	jmp    103edb <sys_pipe+0x2b>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
  103f22:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103f28:	c7 44 98 28 00 00 00 	movl   $0x0,0x28(%eax,%ebx,4)
  103f2f:	00 
    fileclose(rf);
  103f30:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103f33:	89 04 24             	mov    %eax,(%esp)
  103f36:	e8 85 cf ff ff       	call   100ec0 <fileclose>
    fileclose(wf);
  103f3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103f3e:	89 04 24             	mov    %eax,(%esp)
  103f41:	e8 7a cf ff ff       	call   100ec0 <fileclose>
  103f46:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  103f4b:	eb 8e                	jmp    103edb <sys_pipe+0x2b>
  103f4d:	8d 76 00             	lea    0x0(%esi),%esi

00103f50 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
  103f50:	55                   	push   %ebp
  103f51:	89 e5                	mov    %esp,%ebp
  103f53:	83 ec 28             	sub    $0x28,%esp
  103f56:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  103f59:	89 d3                	mov    %edx,%ebx
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
  103f5b:	8d 55 f4             	lea    -0xc(%ebp),%edx

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
  103f5e:	89 75 fc             	mov    %esi,-0x4(%ebp)
  103f61:	89 ce                	mov    %ecx,%esi
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
  103f63:	89 54 24 04          	mov    %edx,0x4(%esp)
  103f67:	89 04 24             	mov    %eax,(%esp)
  103f6a:	e8 c1 fd ff ff       	call   103d30 <argint>
  103f6f:	85 c0                	test   %eax,%eax
  103f71:	79 0f                	jns    103f82 <argfd+0x32>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  103f73:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return 0;
}
  103f78:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  103f7b:	8b 75 fc             	mov    -0x4(%ebp),%esi
  103f7e:	89 ec                	mov    %ebp,%esp
  103f80:	5d                   	pop    %ebp
  103f81:	c3                   	ret    
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
  103f82:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103f85:	83 fa 0f             	cmp    $0xf,%edx
  103f88:	77 e9                	ja     103f73 <argfd+0x23>
  103f8a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103f90:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
  103f94:	85 c9                	test   %ecx,%ecx
  103f96:	74 db                	je     103f73 <argfd+0x23>
    return -1;
  if(pfd)
  103f98:	85 db                	test   %ebx,%ebx
  103f9a:	74 02                	je     103f9e <argfd+0x4e>
    *pfd = fd;
  103f9c:	89 13                	mov    %edx,(%ebx)
  if(pf)
  103f9e:	31 c0                	xor    %eax,%eax
  103fa0:	85 f6                	test   %esi,%esi
  103fa2:	74 d4                	je     103f78 <argfd+0x28>
    *pf = f;
  103fa4:	89 0e                	mov    %ecx,(%esi)
  103fa6:	eb d0                	jmp    103f78 <argfd+0x28>
  103fa8:	90                   	nop    
  103fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00103fb0 <sys_close>:
  return filewrite(f, p, n);
}

int
sys_close(void)
{
  103fb0:	55                   	push   %ebp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
  103fb1:	31 c0                	xor    %eax,%eax
  return filewrite(f, p, n);
}

int
sys_close(void)
{
  103fb3:	89 e5                	mov    %esp,%ebp
  103fb5:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
  103fb8:	8d 55 fc             	lea    -0x4(%ebp),%edx
  103fbb:	8d 4d f8             	lea    -0x8(%ebp),%ecx
  103fbe:	e8 8d ff ff ff       	call   103f50 <argfd>
  103fc3:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  103fc8:	85 c0                	test   %eax,%eax
  103fca:	78 1f                	js     103feb <sys_close+0x3b>
    return -1;
  proc->ofile[fd] = 0;
  103fcc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103fcf:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  103fd6:	c7 44 82 28 00 00 00 	movl   $0x0,0x28(%edx,%eax,4)
  103fdd:	00 
  fileclose(f);
  103fde:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103fe1:	89 04 24             	mov    %eax,(%esp)
  103fe4:	e8 d7 ce ff ff       	call   100ec0 <fileclose>
  103fe9:	31 d2                	xor    %edx,%edx
  return 0;
}
  103feb:	c9                   	leave  
  103fec:	89 d0                	mov    %edx,%eax
  103fee:	c3                   	ret    
  103fef:	90                   	nop    

00103ff0 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
  103ff0:	55                   	push   %ebp
  103ff1:	89 e5                	mov    %esp,%ebp
  103ff3:	83 ec 78             	sub    $0x78,%esp
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0) {
  103ff6:	8d 45 f0             	lea    -0x10(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
  103ff9:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  103ffc:	89 75 f8             	mov    %esi,-0x8(%ebp)
  103fff:	89 7d fc             	mov    %edi,-0x4(%ebp)
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0) {
  104002:	89 44 24 04          	mov    %eax,0x4(%esp)
  104006:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10400d:	e8 ae fd ff ff       	call   103dc0 <argstr>
  104012:	85 c0                	test   %eax,%eax
  104014:	79 12                	jns    104028 <sys_exec+0x38>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
    if(i >= NELEM(argv))
  104016:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(proc, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
  10401b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  10401e:	8b 75 f8             	mov    -0x8(%ebp),%esi
  104021:	8b 7d fc             	mov    -0x4(%ebp),%edi
  104024:	89 ec                	mov    %ebp,%esp
  104026:	5d                   	pop    %ebp
  104027:	c3                   	ret    
{
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0) {
  104028:	8d 45 ec             	lea    -0x14(%ebp),%eax
  10402b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10402f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104036:	e8 f5 fc ff ff       	call   103d30 <argint>
  10403b:	85 c0                	test   %eax,%eax
  10403d:	78 d7                	js     104016 <sys_exec+0x26>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  10403f:	8d 7d 98             	lea    -0x68(%ebp),%edi
  104042:	31 db                	xor    %ebx,%ebx
  104044:	c7 44 24 08 50 00 00 	movl   $0x50,0x8(%esp)
  10404b:	00 
  10404c:	31 f6                	xor    %esi,%esi
  10404e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104055:	00 
  104056:	89 3c 24             	mov    %edi,(%esp)
  104059:	e8 22 fa ff ff       	call   103a80 <memset>
  10405e:	eb 27                	jmp    104087 <sys_exec+0x97>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(proc, uarg, &argv[i]) < 0)
  104060:	8d 04 b7             	lea    (%edi,%esi,4),%eax
  104063:	89 44 24 08          	mov    %eax,0x8(%esp)
  104067:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10406d:	89 54 24 04          	mov    %edx,0x4(%esp)
  104071:	89 04 24             	mov    %eax,(%esp)
  104074:	e8 77 fc ff ff       	call   103cf0 <fetchstr>
  104079:	85 c0                	test   %eax,%eax
  10407b:	78 99                	js     104016 <sys_exec+0x26>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0) {
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
  10407d:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
  104080:	83 fb 14             	cmp    $0x14,%ebx

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0) {
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
  104083:	89 de                	mov    %ebx,%esi
    if(i >= NELEM(argv))
  104085:	74 8f                	je     104016 <sys_exec+0x26>
      return -1;
    if(fetchint(proc, uargv+4*i, (int*)&uarg) < 0)
  104087:	8d 45 e8             	lea    -0x18(%ebp),%eax
  10408a:	89 44 24 08          	mov    %eax,0x8(%esp)
  10408e:	8d 04 9d 00 00 00 00 	lea    0x0(,%ebx,4),%eax
  104095:	03 45 ec             	add    -0x14(%ebp),%eax
  104098:	89 44 24 04          	mov    %eax,0x4(%esp)
  10409c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1040a2:	89 04 24             	mov    %eax,(%esp)
  1040a5:	e8 16 fc ff ff       	call   103cc0 <fetchint>
  1040aa:	85 c0                	test   %eax,%eax
  1040ac:	0f 88 64 ff ff ff    	js     104016 <sys_exec+0x26>
      return -1;
    if(uarg == 0){
  1040b2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  1040b5:	85 d2                	test   %edx,%edx
  1040b7:	75 a7                	jne    104060 <sys_exec+0x70>
      break;
    }
    if(fetchstr(proc, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
  1040b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(proc, uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
  1040bc:	c7 44 9d 98 00 00 00 	movl   $0x0,-0x68(%ebp,%ebx,4)
  1040c3:	00 
      break;
    }
    if(fetchstr(proc, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
  1040c4:	89 7c 24 04          	mov    %edi,0x4(%esp)
  1040c8:	89 04 24             	mov    %eax,(%esp)
  1040cb:	e8 50 c8 ff ff       	call   100920 <exec>
  1040d0:	e9 46 ff ff ff       	jmp    10401b <sys_exec+0x2b>
  1040d5:	8d 74 26 00          	lea    0x0(%esi),%esi
  1040d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001040e0 <sys_chdir>:
  return 0;
}

int
sys_chdir(void)
{
  1040e0:	55                   	push   %ebp
  1040e1:	89 e5                	mov    %esp,%ebp
  1040e3:	53                   	push   %ebx
  1040e4:	83 ec 24             	sub    $0x24,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
  1040e7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  1040ea:	89 44 24 04          	mov    %eax,0x4(%esp)
  1040ee:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1040f5:	e8 c6 fc ff ff       	call   103dc0 <argstr>
  1040fa:	85 c0                	test   %eax,%eax
  1040fc:	79 0b                	jns    104109 <sys_chdir+0x29>
    return -1;
  }
  iunlock(ip);
  iput(proc->cwd);
  proc->cwd = ip;
  return 0;
  1040fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104103:	83 c4 24             	add    $0x24,%esp
  104106:	5b                   	pop    %ebx
  104107:	5d                   	pop    %ebp
  104108:	c3                   	ret    
sys_chdir(void)
{
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
  104109:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10410c:	89 04 24             	mov    %eax,(%esp)
  10410f:	e8 3c dc ff ff       	call   101d50 <namei>
  104114:	85 c0                	test   %eax,%eax
  104116:	89 c3                	mov    %eax,%ebx
  104118:	74 e4                	je     1040fe <sys_chdir+0x1e>
    return -1;
  ilock(ip);
  10411a:	89 04 24             	mov    %eax,(%esp)
  10411d:	e8 9e d9 ff ff       	call   101ac0 <ilock>
  if(ip->type != T_DIR){
  104122:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
  104127:	75 26                	jne    10414f <sys_chdir+0x6f>
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  104129:	89 1c 24             	mov    %ebx,(%esp)
  10412c:	e8 6f d5 ff ff       	call   1016a0 <iunlock>
  iput(proc->cwd);
  104131:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104137:	8b 40 68             	mov    0x68(%eax),%eax
  10413a:	89 04 24             	mov    %eax,(%esp)
  10413d:	e8 2e d7 ff ff       	call   101870 <iput>
  proc->cwd = ip;
  104142:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104148:	89 58 68             	mov    %ebx,0x68(%eax)
  10414b:	31 c0                	xor    %eax,%eax
  10414d:	eb b4                	jmp    104103 <sys_chdir+0x23>

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
    return -1;
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
  10414f:	89 1c 24             	mov    %ebx,(%esp)
  104152:	e8 49 d9 ff ff       	call   101aa0 <iunlockput>
  104157:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10415c:	eb a5                	jmp    104103 <sys_chdir+0x23>
  10415e:	66 90                	xchg   %ax,%ax

00104160 <create>:
  return 0;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
  104160:	55                   	push   %ebp
  104161:	89 e5                	mov    %esp,%ebp
  104163:	83 ec 48             	sub    $0x48,%esp
  104166:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  104169:	8b 4d 08             	mov    0x8(%ebp),%ecx
  10416c:	89 7d fc             	mov    %edi,-0x4(%ebp)
  10416f:	89 d7                	mov    %edx,%edi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  104171:	8d 55 e2             	lea    -0x1e(%ebp),%edx
  return 0;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
  104174:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  104177:	31 db                	xor    %ebx,%ebx
  return 0;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
  104179:	89 75 f8             	mov    %esi,-0x8(%ebp)
  10417c:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  10417f:	89 54 24 04          	mov    %edx,0x4(%esp)
  104183:	89 04 24             	mov    %eax,(%esp)
  104186:	e8 a5 db ff ff       	call   101d30 <nameiparent>
  10418b:	85 c0                	test   %eax,%eax
  10418d:	89 c6                	mov    %eax,%esi
  10418f:	74 4b                	je     1041dc <create+0x7c>
    return 0;
  ilock(dp);
  104191:	89 04 24             	mov    %eax,(%esp)
  104194:	e8 27 d9 ff ff       	call   101ac0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
  104199:	8d 45 f0             	lea    -0x10(%ebp),%eax
  10419c:	8d 4d e2             	lea    -0x1e(%ebp),%ecx
  10419f:	89 44 24 08          	mov    %eax,0x8(%esp)
  1041a3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  1041a7:	89 34 24             	mov    %esi,(%esp)
  1041aa:	e8 f1 d3 ff ff       	call   1015a0 <dirlookup>
  1041af:	85 c0                	test   %eax,%eax
  1041b1:	89 c3                	mov    %eax,%ebx
  1041b3:	74 3b                	je     1041f0 <create+0x90>
    iunlockput(dp);
  1041b5:	89 34 24             	mov    %esi,(%esp)
  1041b8:	e8 e3 d8 ff ff       	call   101aa0 <iunlockput>
    ilock(ip);
  1041bd:	89 1c 24             	mov    %ebx,(%esp)
  1041c0:	e8 fb d8 ff ff       	call   101ac0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
  1041c5:	66 83 ff 02          	cmp    $0x2,%di
  1041c9:	75 07                	jne    1041d2 <create+0x72>
  1041cb:	66 83 7b 10 02       	cmpw   $0x2,0x10(%ebx)
  1041d0:	74 0a                	je     1041dc <create+0x7c>
      return ip;
    iunlockput(ip);
  1041d2:	89 1c 24             	mov    %ebx,(%esp)
  1041d5:	31 db                	xor    %ebx,%ebx
  1041d7:	e8 c4 d8 ff ff       	call   101aa0 <iunlockput>
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);
  return ip;
}
  1041dc:	89 d8                	mov    %ebx,%eax
  1041de:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1041e1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1041e4:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1041e7:	89 ec                	mov    %ebp,%esp
  1041e9:	5d                   	pop    %ebp
  1041ea:	c3                   	ret    
  1041eb:	90                   	nop    
  1041ec:	8d 74 26 00          	lea    0x0(%esi),%esi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
  1041f0:	0f bf c7             	movswl %di,%eax
  1041f3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1041f7:	8b 06                	mov    (%esi),%eax
  1041f9:	89 04 24             	mov    %eax,(%esp)
  1041fc:	e8 ef d4 ff ff       	call   1016f0 <ialloc>
  104201:	85 c0                	test   %eax,%eax
  104203:	89 c3                	mov    %eax,%ebx
  104205:	0f 84 9f 00 00 00    	je     1042aa <create+0x14a>
    panic("create: ialloc");

  ilock(ip);
  10420b:	89 04 24             	mov    %eax,(%esp)
  10420e:	e8 ad d8 ff ff       	call   101ac0 <ilock>
  ip->major = major;
  104213:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
  104217:	66 89 43 12          	mov    %ax,0x12(%ebx)
  ip->minor = minor;
  10421b:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
  ip->nlink = 1;
  10421f:	66 c7 43 16 01 00    	movw   $0x1,0x16(%ebx)
  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");

  ilock(ip);
  ip->major = major;
  ip->minor = minor;
  104225:	66 89 53 14          	mov    %dx,0x14(%ebx)
  ip->nlink = 1;
  iupdate(ip);
  104229:	89 1c 24             	mov    %ebx,(%esp)
  10422c:	e8 df ce ff ff       	call   101110 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
  104231:	66 83 ef 01          	sub    $0x1,%di
  104235:	74 24                	je     10425b <create+0xfb>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
  104237:	8b 43 04             	mov    0x4(%ebx),%eax
  10423a:	8d 4d e2             	lea    -0x1e(%ebp),%ecx
  10423d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  104241:	89 34 24             	mov    %esi,(%esp)
  104244:	89 44 24 08          	mov    %eax,0x8(%esp)
  104248:	e8 63 d7 ff ff       	call   1019b0 <dirlink>
  10424d:	85 c0                	test   %eax,%eax
  10424f:	78 65                	js     1042b6 <create+0x156>
    panic("create: dirlink");

  iunlockput(dp);
  104251:	89 34 24             	mov    %esi,(%esp)
  104254:	e8 47 d8 ff ff       	call   101aa0 <iunlockput>
  104259:	eb 81                	jmp    1041dc <create+0x7c>
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
  10425b:	66 83 46 16 01       	addw   $0x1,0x16(%esi)
    iupdate(dp);
  104260:	89 34 24             	mov    %esi,(%esp)
  104263:	e8 a8 ce ff ff       	call   101110 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
  104268:	8b 43 04             	mov    0x4(%ebx),%eax
  10426b:	c7 44 24 04 4c 68 10 	movl   $0x10684c,0x4(%esp)
  104272:	00 
  104273:	89 1c 24             	mov    %ebx,(%esp)
  104276:	89 44 24 08          	mov    %eax,0x8(%esp)
  10427a:	e8 31 d7 ff ff       	call   1019b0 <dirlink>
  10427f:	85 c0                	test   %eax,%eax
  104281:	78 1b                	js     10429e <create+0x13e>
  104283:	8b 46 04             	mov    0x4(%esi),%eax
  104286:	c7 44 24 04 4b 68 10 	movl   $0x10684b,0x4(%esp)
  10428d:	00 
  10428e:	89 1c 24             	mov    %ebx,(%esp)
  104291:	89 44 24 08          	mov    %eax,0x8(%esp)
  104295:	e8 16 d7 ff ff       	call   1019b0 <dirlink>
  10429a:	85 c0                	test   %eax,%eax
  10429c:	79 99                	jns    104237 <create+0xd7>
      panic("create dots");
  10429e:	c7 04 24 4e 68 10 00 	movl   $0x10684e,(%esp)
  1042a5:	e8 d6 c5 ff ff       	call   100880 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
  1042aa:	c7 04 24 3c 68 10 00 	movl   $0x10683c,(%esp)
  1042b1:	e8 ca c5 ff ff       	call   100880 <panic>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
  1042b6:	c7 04 24 5a 68 10 00 	movl   $0x10685a,(%esp)
  1042bd:	e8 be c5 ff ff       	call   100880 <panic>
  1042c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  1042c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001042d0 <sys_mknod>:
  return 0;
}

int
sys_mknod(void)
{
  1042d0:	55                   	push   %ebp
  1042d1:	89 e5                	mov    %esp,%ebp
  1042d3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
  1042d6:	8d 45 fc             	lea    -0x4(%ebp),%eax
  1042d9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1042dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1042e4:	e8 d7 fa ff ff       	call   103dc0 <argstr>
  1042e9:	85 c0                	test   %eax,%eax
  1042eb:	79 07                	jns    1042f4 <sys_mknod+0x24>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0)
    return -1;
  iunlockput(ip);
  return 0;
}
  1042ed:	c9                   	leave  
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0)
    return -1;
  iunlockput(ip);
  return 0;
  1042ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1042f3:	c3                   	ret    
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
  1042f4:	8d 45 f8             	lea    -0x8(%ebp),%eax
  1042f7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1042fb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104302:	e8 29 fa ff ff       	call   103d30 <argint>
  104307:	85 c0                	test   %eax,%eax
  104309:	78 e2                	js     1042ed <sys_mknod+0x1d>
  10430b:	8d 45 f4             	lea    -0xc(%ebp),%eax
  10430e:	89 44 24 04          	mov    %eax,0x4(%esp)
  104312:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  104319:	e8 12 fa ff ff       	call   103d30 <argint>
  10431e:	85 c0                	test   %eax,%eax
  104320:	78 cb                	js     1042ed <sys_mknod+0x1d>
  104322:	0f bf 55 f4          	movswl -0xc(%ebp),%edx
  104326:	0f bf 4d f8          	movswl -0x8(%ebp),%ecx
  10432a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10432d:	89 14 24             	mov    %edx,(%esp)
  104330:	ba 03 00 00 00       	mov    $0x3,%edx
  104335:	e8 26 fe ff ff       	call   104160 <create>
  10433a:	85 c0                	test   %eax,%eax
  10433c:	74 af                	je     1042ed <sys_mknod+0x1d>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0)
    return -1;
  iunlockput(ip);
  10433e:	89 04 24             	mov    %eax,(%esp)
  104341:	e8 5a d7 ff ff       	call   101aa0 <iunlockput>
  104346:	31 c0                	xor    %eax,%eax
  return 0;
}
  104348:	c9                   	leave  
  104349:	c3                   	ret    
  10434a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104350 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
  104350:	55                   	push   %ebp
  104351:	89 e5                	mov    %esp,%ebp
  104353:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0)
  104356:	8d 45 fc             	lea    -0x4(%ebp),%eax
  104359:	89 44 24 04          	mov    %eax,0x4(%esp)
  10435d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104364:	e8 57 fa ff ff       	call   103dc0 <argstr>
  104369:	85 c0                	test   %eax,%eax
  10436b:	79 07                	jns    104374 <sys_mkdir+0x24>
    return -1;
  iunlockput(ip);
  return 0;
}
  10436d:	c9                   	leave  
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0)
    return -1;
  iunlockput(ip);
  return 0;
  10436e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104373:	c3                   	ret    
sys_mkdir(void)
{
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0)
  104374:	8b 45 fc             	mov    -0x4(%ebp),%eax
  104377:	31 c9                	xor    %ecx,%ecx
  104379:	ba 01 00 00 00       	mov    $0x1,%edx
  10437e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104385:	e8 d6 fd ff ff       	call   104160 <create>
  10438a:	85 c0                	test   %eax,%eax
  10438c:	74 df                	je     10436d <sys_mkdir+0x1d>
    return -1;
  iunlockput(ip);
  10438e:	89 04 24             	mov    %eax,(%esp)
  104391:	e8 0a d7 ff ff       	call   101aa0 <iunlockput>
  104396:	31 c0                	xor    %eax,%eax
  return 0;
}
  104398:	c9                   	leave  
  104399:	c3                   	ret    
  10439a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001043a0 <sys_link>:
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  1043a0:	55                   	push   %ebp
  1043a1:	89 e5                	mov    %esp,%ebp
  1043a3:	83 ec 38             	sub    $0x38,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
  1043a6:	8d 45 ec             	lea    -0x14(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  1043a9:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  1043ac:	89 75 f8             	mov    %esi,-0x8(%ebp)
  1043af:	89 7d fc             	mov    %edi,-0x4(%ebp)
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
  1043b2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1043b6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1043bd:	e8 fe f9 ff ff       	call   103dc0 <argstr>
  1043c2:	85 c0                	test   %eax,%eax
  1043c4:	79 12                	jns    1043d8 <sys_link+0x38>
bad:
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return -1;
  1043c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1043cb:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1043ce:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1043d1:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1043d4:	89 ec                	mov    %ebp,%esp
  1043d6:	5d                   	pop    %ebp
  1043d7:	c3                   	ret    
sys_link(void)
{
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
  1043d8:	8d 45 f0             	lea    -0x10(%ebp),%eax
  1043db:	89 44 24 04          	mov    %eax,0x4(%esp)
  1043df:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1043e6:	e8 d5 f9 ff ff       	call   103dc0 <argstr>
  1043eb:	85 c0                	test   %eax,%eax
  1043ed:	78 d7                	js     1043c6 <sys_link+0x26>
    return -1;
  if((ip = namei(old)) == 0)
  1043ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1043f2:	89 04 24             	mov    %eax,(%esp)
  1043f5:	e8 56 d9 ff ff       	call   101d50 <namei>
  1043fa:	85 c0                	test   %eax,%eax
  1043fc:	89 c3                	mov    %eax,%ebx
  1043fe:	74 c6                	je     1043c6 <sys_link+0x26>
    return -1;
  ilock(ip);
  104400:	89 04 24             	mov    %eax,(%esp)
  104403:	e8 b8 d6 ff ff       	call   101ac0 <ilock>
  if(ip->type == T_DIR){
  104408:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
  10440d:	74 58                	je     104467 <sys_link+0xc7>
    iunlockput(ip);
    return -1;
  }
  ip->nlink++;
  10440f:	66 83 43 16 01       	addw   $0x1,0x16(%ebx)
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
  104414:	8d 7d de             	lea    -0x22(%ebp),%edi
  if(ip->type == T_DIR){
    iunlockput(ip);
    return -1;
  }
  ip->nlink++;
  iupdate(ip);
  104417:	89 1c 24             	mov    %ebx,(%esp)
  10441a:	e8 f1 cc ff ff       	call   101110 <iupdate>
  iunlock(ip);
  10441f:	89 1c 24             	mov    %ebx,(%esp)
  104422:	e8 79 d2 ff ff       	call   1016a0 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
  104427:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10442a:	89 7c 24 04          	mov    %edi,0x4(%esp)
  10442e:	89 04 24             	mov    %eax,(%esp)
  104431:	e8 fa d8 ff ff       	call   101d30 <nameiparent>
  104436:	85 c0                	test   %eax,%eax
  104438:	89 c6                	mov    %eax,%esi
  10443a:	74 16                	je     104452 <sys_link+0xb2>
    goto bad;
  ilock(dp);
  10443c:	89 04 24             	mov    %eax,(%esp)
  10443f:	e8 7c d6 ff ff       	call   101ac0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
  104444:	8b 06                	mov    (%esi),%eax
  104446:	3b 03                	cmp    (%ebx),%eax
  104448:	74 2f                	je     104479 <sys_link+0xd9>
    iunlockput(dp);
  10444a:	89 34 24             	mov    %esi,(%esp)
  10444d:	e8 4e d6 ff ff       	call   101aa0 <iunlockput>
  iunlockput(dp);
  iput(ip);
  return 0;

bad:
  ilock(ip);
  104452:	89 1c 24             	mov    %ebx,(%esp)
  104455:	e8 66 d6 ff ff       	call   101ac0 <ilock>
  ip->nlink--;
  10445a:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  iupdate(ip);
  10445f:	89 1c 24             	mov    %ebx,(%esp)
  104462:	e8 a9 cc ff ff       	call   101110 <iupdate>
  iunlockput(ip);
  104467:	89 1c 24             	mov    %ebx,(%esp)
  10446a:	e8 31 d6 ff ff       	call   101aa0 <iunlockput>
  10446f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104474:	e9 52 ff ff ff       	jmp    1043cb <sys_link+0x2b>
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
  104479:	8b 43 04             	mov    0x4(%ebx),%eax
  10447c:	89 7c 24 04          	mov    %edi,0x4(%esp)
  104480:	89 34 24             	mov    %esi,(%esp)
  104483:	89 44 24 08          	mov    %eax,0x8(%esp)
  104487:	e8 24 d5 ff ff       	call   1019b0 <dirlink>
  10448c:	85 c0                	test   %eax,%eax
  10448e:	78 ba                	js     10444a <sys_link+0xaa>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
  104490:	89 34 24             	mov    %esi,(%esp)
  104493:	e8 08 d6 ff ff       	call   101aa0 <iunlockput>
  iput(ip);
  104498:	89 1c 24             	mov    %ebx,(%esp)
  10449b:	e8 d0 d3 ff ff       	call   101870 <iput>
  1044a0:	31 c0                	xor    %eax,%eax
  1044a2:	e9 24 ff ff ff       	jmp    1043cb <sys_link+0x2b>
  1044a7:	89 f6                	mov    %esi,%esi
  1044a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001044b0 <sys_open>:
  return ip;
}

int
sys_open(void)
{
  1044b0:	55                   	push   %ebp
  1044b1:	89 e5                	mov    %esp,%ebp
  1044b3:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  1044b6:	8d 45 f0             	lea    -0x10(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
  1044b9:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  1044bc:	89 75 f8             	mov    %esi,-0x8(%ebp)
  1044bf:	89 7d fc             	mov    %edi,-0x4(%ebp)
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  1044c2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1044c6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1044cd:	e8 ee f8 ff ff       	call   103dc0 <argstr>
  1044d2:	85 c0                	test   %eax,%eax
  1044d4:	79 14                	jns    1044ea <sys_open+0x3a>
  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
  1044d6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
  1044db:	89 d8                	mov    %ebx,%eax
  1044dd:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1044e0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1044e3:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1044e6:	89 ec                	mov    %ebp,%esp
  1044e8:	5d                   	pop    %ebp
  1044e9:	c3                   	ret    
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  1044ea:	8d 45 ec             	lea    -0x14(%ebp),%eax
  1044ed:	89 44 24 04          	mov    %eax,0x4(%esp)
  1044f1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1044f8:	e8 33 f8 ff ff       	call   103d30 <argint>
  1044fd:	85 c0                	test   %eax,%eax
  1044ff:	78 d5                	js     1044d6 <sys_open+0x26>
    return -1;
  if(omode & O_CREATE){
  104501:	f6 45 ed 02          	testb  $0x2,-0x13(%ebp)
  104505:	75 6b                	jne    104572 <sys_open+0xc2>
    if((ip = create(path, T_FILE, 0, 0)) == 0)
      return -1;
  } else {
    if((ip = namei(path)) == 0)
  104507:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10450a:	89 04 24             	mov    %eax,(%esp)
  10450d:	e8 3e d8 ff ff       	call   101d50 <namei>
  104512:	85 c0                	test   %eax,%eax
  104514:	89 c7                	mov    %eax,%edi
  104516:	74 be                	je     1044d6 <sys_open+0x26>
      return -1;
    ilock(ip);
  104518:	89 04 24             	mov    %eax,(%esp)
  10451b:	e8 a0 d5 ff ff       	call   101ac0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
  104520:	66 83 7f 10 01       	cmpw   $0x1,0x10(%edi)
  104525:	0f 84 82 00 00 00    	je     1045ad <sys_open+0xfd>
      iunlockput(ip);
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
  10452b:	e8 20 c9 ff ff       	call   100e50 <filealloc>
  104530:	85 c0                	test   %eax,%eax
  104532:	89 c6                	mov    %eax,%esi
  104534:	74 65                	je     10459b <sys_open+0xeb>
  104536:	e8 45 f9 ff ff       	call   103e80 <fdalloc>
  10453b:	85 c0                	test   %eax,%eax
  10453d:	89 c3                	mov    %eax,%ebx
  10453f:	78 52                	js     104593 <sys_open+0xe3>
    if(f)
      fileclose(f);
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  104541:	89 3c 24             	mov    %edi,(%esp)
  104544:	e8 57 d1 ff ff       	call   1016a0 <iunlock>

  f->type = FD_INODE;
  104549:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f->ip = ip;
  10454f:	89 7e 10             	mov    %edi,0x10(%esi)
  f->off = 0;
  104552:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
  104559:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10455c:	83 f0 01             	xor    $0x1,%eax
  10455f:	83 e0 01             	and    $0x1,%eax
  104562:	88 46 08             	mov    %al,0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  104565:	f6 45 ec 03          	testb  $0x3,-0x14(%ebp)
  104569:	0f 95 46 09          	setne  0x9(%esi)
  10456d:	e9 69 ff ff ff       	jmp    1044db <sys_open+0x2b>
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
    return -1;
  if(omode & O_CREATE){
    if((ip = create(path, T_FILE, 0, 0)) == 0)
  104572:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104575:	31 c9                	xor    %ecx,%ecx
  104577:	ba 02 00 00 00       	mov    $0x2,%edx
  10457c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104583:	e8 d8 fb ff ff       	call   104160 <create>
  104588:	85 c0                	test   %eax,%eax
  10458a:	89 c7                	mov    %eax,%edi
  10458c:	75 9d                	jne    10452b <sys_open+0x7b>
  10458e:	e9 43 ff ff ff       	jmp    1044d6 <sys_open+0x26>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
  104593:	89 34 24             	mov    %esi,(%esp)
  104596:	e8 25 c9 ff ff       	call   100ec0 <fileclose>
    iunlockput(ip);
  10459b:	89 3c 24             	mov    %edi,(%esp)
  10459e:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  1045a3:	e8 f8 d4 ff ff       	call   101aa0 <iunlockput>
  1045a8:	e9 2e ff ff ff       	jmp    1044db <sys_open+0x2b>
      return -1;
  } else {
    if((ip = namei(path)) == 0)
      return -1;
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
  1045ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1045b0:	85 c0                	test   %eax,%eax
  1045b2:	0f 84 73 ff ff ff    	je     10452b <sys_open+0x7b>
  1045b8:	eb e1                	jmp    10459b <sys_open+0xeb>
  1045ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001045c0 <sys_unlink>:
  return 1;
}

int
sys_unlink(void)
{
  1045c0:	55                   	push   %ebp
  1045c1:	89 e5                	mov    %esp,%ebp
  1045c3:	83 ec 68             	sub    $0x68,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
  1045c6:	8d 45 f0             	lea    -0x10(%ebp),%eax
  return 1;
}

int
sys_unlink(void)
{
  1045c9:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  1045cc:	89 75 f8             	mov    %esi,-0x8(%ebp)
  1045cf:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
  1045d2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1045d6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1045dd:	e8 de f7 ff ff       	call   103dc0 <argstr>
  1045e2:	85 c0                	test   %eax,%eax
  1045e4:	79 12                	jns    1045f8 <sys_unlink+0x38>
  iunlockput(dp);

  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return 0;
  1045e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1045eb:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1045ee:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1045f1:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1045f4:	89 ec                	mov    %ebp,%esp
  1045f6:	5d                   	pop    %ebp
  1045f7:	c3                   	ret    
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
  if((dp = nameiparent(path, name)) == 0)
  1045f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1045fb:	8d 5d de             	lea    -0x22(%ebp),%ebx
  1045fe:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  104602:	89 04 24             	mov    %eax,(%esp)
  104605:	e8 26 d7 ff ff       	call   101d30 <nameiparent>
  10460a:	85 c0                	test   %eax,%eax
  10460c:	89 c7                	mov    %eax,%edi
  10460e:	74 d6                	je     1045e6 <sys_unlink+0x26>
    return -1;
  ilock(dp);
  104610:	89 04 24             	mov    %eax,(%esp)
  104613:	e8 a8 d4 ff ff       	call   101ac0 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0){
  104618:	c7 44 24 04 4c 68 10 	movl   $0x10684c,0x4(%esp)
  10461f:	00 
  104620:	89 1c 24             	mov    %ebx,(%esp)
  104623:	e8 48 cf ff ff       	call   101570 <namecmp>
  104628:	85 c0                	test   %eax,%eax
  10462a:	74 14                	je     104640 <sys_unlink+0x80>
  10462c:	c7 44 24 04 4b 68 10 	movl   $0x10684b,0x4(%esp)
  104633:	00 
  104634:	89 1c 24             	mov    %ebx,(%esp)
  104637:	e8 34 cf ff ff       	call   101570 <namecmp>
  10463c:	85 c0                	test   %eax,%eax
  10463e:	75 0f                	jne    10464f <sys_unlink+0x8f>

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
    iunlockput(dp);
  104640:	89 3c 24             	mov    %edi,(%esp)
  104643:	e8 58 d4 ff ff       	call   101aa0 <iunlockput>
  104648:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10464d:	eb 9c                	jmp    1045eb <sys_unlink+0x2b>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0){
    iunlockput(dp);
    return -1;
  }

  if((ip = dirlookup(dp, name, &off)) == 0){
  10464f:	8d 45 ec             	lea    -0x14(%ebp),%eax
  104652:	89 44 24 08          	mov    %eax,0x8(%esp)
  104656:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  10465a:	89 3c 24             	mov    %edi,(%esp)
  10465d:	e8 3e cf ff ff       	call   1015a0 <dirlookup>
  104662:	85 c0                	test   %eax,%eax
  104664:	89 c6                	mov    %eax,%esi
  104666:	74 d8                	je     104640 <sys_unlink+0x80>
    iunlockput(dp);
    return -1;
  }
  ilock(ip);
  104668:	89 04 24             	mov    %eax,(%esp)
  10466b:	e8 50 d4 ff ff       	call   101ac0 <ilock>

  if(ip->nlink < 1)
  104670:	66 83 7e 16 00       	cmpw   $0x0,0x16(%esi)
  104675:	0f 8e e7 00 00 00    	jle    104762 <sys_unlink+0x1a2>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
  10467b:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
  104680:	75 53                	jne    1046d5 <sys_unlink+0x115>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
  104682:	83 7e 18 20          	cmpl   $0x20,0x18(%esi)
  104686:	76 4d                	jbe    1046d5 <sys_unlink+0x115>
  104688:	bb 20 00 00 00       	mov    $0x20,%ebx
  10468d:	8d 76 00             	lea    0x0(%esi),%esi
  104690:	eb 08                	jmp    10469a <sys_unlink+0xda>
  104692:	83 c3 10             	add    $0x10,%ebx
  104695:	39 5e 18             	cmp    %ebx,0x18(%esi)
  104698:	76 3b                	jbe    1046d5 <sys_unlink+0x115>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  10469a:	8d 45 be             	lea    -0x42(%ebp),%eax
  10469d:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  1046a4:	00 
  1046a5:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  1046a9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1046ad:	89 34 24             	mov    %esi,(%esp)
  1046b0:	e8 ab cd ff ff       	call   101460 <readi>
  1046b5:	83 f8 10             	cmp    $0x10,%eax
  1046b8:	0f 85 8c 00 00 00    	jne    10474a <sys_unlink+0x18a>
      panic("isdirempty: readi");
    if(de.inum != 0)
  1046be:	66 83 7d be 00       	cmpw   $0x0,-0x42(%ebp)
  1046c3:	74 cd                	je     104692 <sys_unlink+0xd2>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
  1046c5:	89 34 24             	mov    %esi,(%esp)
  1046c8:	e8 d3 d3 ff ff       	call   101aa0 <iunlockput>
  1046cd:	8d 76 00             	lea    0x0(%esi),%esi
  1046d0:	e9 6b ff ff ff       	jmp    104640 <sys_unlink+0x80>
    iunlockput(dp);
    return -1;
  }

  memset(&de, 0, sizeof(de));
  1046d5:	8d 5d ce             	lea    -0x32(%ebp),%ebx
  1046d8:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  1046df:	00 
  1046e0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1046e7:	00 
  1046e8:	89 1c 24             	mov    %ebx,(%esp)
  1046eb:	e8 90 f3 ff ff       	call   103a80 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  1046f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1046f3:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  1046fa:	00 
  1046fb:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1046ff:	89 3c 24             	mov    %edi,(%esp)
  104702:	89 44 24 08          	mov    %eax,0x8(%esp)
  104706:	e8 25 cc ff ff       	call   101330 <writei>
  10470b:	83 f8 10             	cmp    $0x10,%eax
  10470e:	75 46                	jne    104756 <sys_unlink+0x196>
    panic("unlink: writei");
  if(ip->type == T_DIR){
  104710:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
  104715:	74 24                	je     10473b <sys_unlink+0x17b>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
  104717:	89 3c 24             	mov    %edi,(%esp)
  10471a:	e8 81 d3 ff ff       	call   101aa0 <iunlockput>

  ip->nlink--;
  10471f:	66 83 6e 16 01       	subw   $0x1,0x16(%esi)
  iupdate(ip);
  104724:	89 34 24             	mov    %esi,(%esp)
  104727:	e8 e4 c9 ff ff       	call   101110 <iupdate>
  iunlockput(ip);
  10472c:	89 34 24             	mov    %esi,(%esp)
  10472f:	e8 6c d3 ff ff       	call   101aa0 <iunlockput>
  104734:	31 c0                	xor    %eax,%eax
  104736:	e9 b0 fe ff ff       	jmp    1045eb <sys_unlink+0x2b>

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
  10473b:	66 83 6f 16 01       	subw   $0x1,0x16(%edi)
    iupdate(dp);
  104740:	89 3c 24             	mov    %edi,(%esp)
  104743:	e8 c8 c9 ff ff       	call   101110 <iupdate>
  104748:	eb cd                	jmp    104717 <sys_unlink+0x157>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
  10474a:	c7 04 24 7c 68 10 00 	movl   $0x10687c,(%esp)
  104751:	e8 2a c1 ff ff       	call   100880 <panic>
    return -1;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  104756:	c7 04 24 8e 68 10 00 	movl   $0x10688e,(%esp)
  10475d:	e8 1e c1 ff ff       	call   100880 <panic>
    return -1;
  }
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  104762:	c7 04 24 6a 68 10 00 	movl   $0x10686a,(%esp)
  104769:	e8 12 c1 ff ff       	call   100880 <panic>
  10476e:	66 90                	xchg   %ax,%ax

00104770 <sys_fstat>:
  return 0;
}

int
sys_fstat(void)
{
  104770:	55                   	push   %ebp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  104771:	31 d2                	xor    %edx,%edx
  return 0;
}

int
sys_fstat(void)
{
  104773:	89 e5                	mov    %esp,%ebp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  104775:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
  104777:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  10477a:	8d 4d fc             	lea    -0x4(%ebp),%ecx
  10477d:	e8 ce f7 ff ff       	call   103f50 <argfd>
  104782:	85 c0                	test   %eax,%eax
  104784:	79 07                	jns    10478d <sys_fstat+0x1d>
    return -1;
  return filestat(f, st);
}
  104786:	c9                   	leave  
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
  return filestat(f, st);
  104787:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  10478c:	c3                   	ret    
sys_fstat(void)
{
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  10478d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  104790:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
  104797:	00 
  104798:	89 44 24 04          	mov    %eax,0x4(%esp)
  10479c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1047a3:	e8 c8 f5 ff ff       	call   103d70 <argptr>
  1047a8:	85 c0                	test   %eax,%eax
  1047aa:	78 da                	js     104786 <sys_fstat+0x16>
    return -1;
  return filestat(f, st);
  1047ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1047af:	89 44 24 04          	mov    %eax,0x4(%esp)
  1047b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1047b6:	89 04 24             	mov    %eax,(%esp)
  1047b9:	e8 f2 c5 ff ff       	call   100db0 <filestat>
}
  1047be:	c9                   	leave  
  1047bf:	c3                   	ret    

001047c0 <sys_write>:
  return fileread(f, p, n);
}

int
sys_write(void)
{
  1047c0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  1047c1:	31 d2                	xor    %edx,%edx
  return fileread(f, p, n);
}

int
sys_write(void)
{
  1047c3:	89 e5                	mov    %esp,%ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  1047c5:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
  1047c7:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  1047ca:	8d 4d fc             	lea    -0x4(%ebp),%ecx
  1047cd:	e8 7e f7 ff ff       	call   103f50 <argfd>
  1047d2:	85 c0                	test   %eax,%eax
  1047d4:	79 07                	jns    1047dd <sys_write+0x1d>
    return -1;
  return filewrite(f, p, n);
}
  1047d6:	c9                   	leave  
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
  return filewrite(f, p, n);
  1047d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1047dc:	c3                   	ret    
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  1047dd:	8d 45 f8             	lea    -0x8(%ebp),%eax
  1047e0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1047e4:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1047eb:	e8 40 f5 ff ff       	call   103d30 <argint>
  1047f0:	85 c0                	test   %eax,%eax
  1047f2:	78 e2                	js     1047d6 <sys_write+0x16>
  1047f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1047f7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1047fe:	89 44 24 08          	mov    %eax,0x8(%esp)
  104802:	8d 45 f4             	lea    -0xc(%ebp),%eax
  104805:	89 44 24 04          	mov    %eax,0x4(%esp)
  104809:	e8 62 f5 ff ff       	call   103d70 <argptr>
  10480e:	85 c0                	test   %eax,%eax
  104810:	78 c4                	js     1047d6 <sys_write+0x16>
    return -1;
  return filewrite(f, p, n);
  104812:	8b 45 f8             	mov    -0x8(%ebp),%eax
  104815:	89 44 24 08          	mov    %eax,0x8(%esp)
  104819:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10481c:	89 44 24 04          	mov    %eax,0x4(%esp)
  104820:	8b 45 fc             	mov    -0x4(%ebp),%eax
  104823:	89 04 24             	mov    %eax,(%esp)
  104826:	e8 45 c4 ff ff       	call   100c70 <filewrite>
}
  10482b:	c9                   	leave  
  10482c:	c3                   	ret    
  10482d:	8d 76 00             	lea    0x0(%esi),%esi

00104830 <sys_read>:
  return fd;
}

int
sys_read(void)
{
  104830:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  104831:	31 d2                	xor    %edx,%edx
  return fd;
}

int
sys_read(void)
{
  104833:	89 e5                	mov    %esp,%ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  104835:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
  104837:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  10483a:	8d 4d fc             	lea    -0x4(%ebp),%ecx
  10483d:	e8 0e f7 ff ff       	call   103f50 <argfd>
  104842:	85 c0                	test   %eax,%eax
  104844:	79 07                	jns    10484d <sys_read+0x1d>
    return -1;
  return fileread(f, p, n);
}
  104846:	c9                   	leave  
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
  return fileread(f, p, n);
  104847:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  10484c:	c3                   	ret    
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  10484d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  104850:	89 44 24 04          	mov    %eax,0x4(%esp)
  104854:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  10485b:	e8 d0 f4 ff ff       	call   103d30 <argint>
  104860:	85 c0                	test   %eax,%eax
  104862:	78 e2                	js     104846 <sys_read+0x16>
  104864:	8b 45 f8             	mov    -0x8(%ebp),%eax
  104867:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  10486e:	89 44 24 08          	mov    %eax,0x8(%esp)
  104872:	8d 45 f4             	lea    -0xc(%ebp),%eax
  104875:	89 44 24 04          	mov    %eax,0x4(%esp)
  104879:	e8 f2 f4 ff ff       	call   103d70 <argptr>
  10487e:	85 c0                	test   %eax,%eax
  104880:	78 c4                	js     104846 <sys_read+0x16>
    return -1;
  return fileread(f, p, n);
  104882:	8b 45 f8             	mov    -0x8(%ebp),%eax
  104885:	89 44 24 08          	mov    %eax,0x8(%esp)
  104889:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10488c:	89 44 24 04          	mov    %eax,0x4(%esp)
  104890:	8b 45 fc             	mov    -0x4(%ebp),%eax
  104893:	89 04 24             	mov    %eax,(%esp)
  104896:	e8 75 c4 ff ff       	call   100d10 <fileread>
}
  10489b:	c9                   	leave  
  10489c:	c3                   	ret    
  10489d:	8d 76 00             	lea    0x0(%esi),%esi

001048a0 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
  1048a0:	55                   	push   %ebp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
  1048a1:	31 d2                	xor    %edx,%edx
  return -1;
}

int
sys_dup(void)
{
  1048a3:	89 e5                	mov    %esp,%ebp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
  1048a5:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
  1048a7:	53                   	push   %ebx
  1048a8:	83 ec 14             	sub    $0x14,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
  1048ab:	8d 4d f8             	lea    -0x8(%ebp),%ecx
  1048ae:	e8 9d f6 ff ff       	call   103f50 <argfd>
  1048b3:	85 c0                	test   %eax,%eax
  1048b5:	79 0d                	jns    1048c4 <sys_dup+0x24>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
  1048b7:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
  1048bc:	89 d8                	mov    %ebx,%eax
  1048be:	83 c4 14             	add    $0x14,%esp
  1048c1:	5b                   	pop    %ebx
  1048c2:	5d                   	pop    %ebp
  1048c3:	c3                   	ret    
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
  1048c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1048c7:	e8 b4 f5 ff ff       	call   103e80 <fdalloc>
  1048cc:	85 c0                	test   %eax,%eax
  1048ce:	89 c3                	mov    %eax,%ebx
  1048d0:	78 e5                	js     1048b7 <sys_dup+0x17>
    return -1;
  filedup(f);
  1048d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1048d5:	89 04 24             	mov    %eax,(%esp)
  1048d8:	e8 23 c5 ff ff       	call   100e00 <filedup>
  1048dd:	eb dd                	jmp    1048bc <sys_dup+0x1c>
  1048df:	90                   	nop    

001048e0 <sys_getpid>:
}

int
sys_getpid(void)
{
  return proc->pid;
  1048e0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return kill(pid);
}

int
sys_getpid(void)
{
  1048e6:	55                   	push   %ebp
  1048e7:	89 e5                	mov    %esp,%ebp
  return proc->pid;
}
  1048e9:	5d                   	pop    %ebp
}

int
sys_getpid(void)
{
  return proc->pid;
  1048ea:	8b 40 10             	mov    0x10(%eax),%eax
}
  1048ed:	c3                   	ret    
  1048ee:	66 90                	xchg   %ax,%ax

001048f0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since boot.
int
sys_uptime(void)
{
  1048f0:	55                   	push   %ebp
  1048f1:	89 e5                	mov    %esp,%ebp
  1048f3:	53                   	push   %ebx
  1048f4:	83 ec 04             	sub    $0x4,%esp
  uint xticks;
  
  acquire(&tickslock);
  1048f7:	c7 04 24 e0 cf 10 00 	movl   $0x10cfe0,(%esp)
  1048fe:	e8 0d f1 ff ff       	call   103a10 <acquire>
  xticks = ticks;
  104903:	8b 1d 20 d8 10 00    	mov    0x10d820,%ebx
  release(&tickslock);
  104909:	c7 04 24 e0 cf 10 00 	movl   $0x10cfe0,(%esp)
  104910:	e8 bb f0 ff ff       	call   1039d0 <release>
  return xticks;
}
  104915:	83 c4 04             	add    $0x4,%esp
  104918:	89 d8                	mov    %ebx,%eax
  10491a:	5b                   	pop    %ebx
  10491b:	5d                   	pop    %ebp
  10491c:	c3                   	ret    
  10491d:	8d 76 00             	lea    0x0(%esi),%esi

00104920 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
  104920:	55                   	push   %ebp
  104921:	89 e5                	mov    %esp,%ebp
  104923:	53                   	push   %ebx
  104924:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
  104927:	8d 45 f8             	lea    -0x8(%ebp),%eax
  10492a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10492e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104935:	e8 f6 f3 ff ff       	call   103d30 <argint>
  10493a:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  10493f:	85 c0                	test   %eax,%eax
  104941:	78 5b                	js     10499e <sys_sleep+0x7e>
    return -1;
  acquire(&tickslock);
  104943:	c7 04 24 e0 cf 10 00 	movl   $0x10cfe0,(%esp)
  10494a:	e8 c1 f0 ff ff       	call   103a10 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
  10494f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  uint ticks0;
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  104952:	8b 1d 20 d8 10 00    	mov    0x10d820,%ebx
  while(ticks - ticks0 < n){
  104958:	85 d2                	test   %edx,%edx
  10495a:	75 24                	jne    104980 <sys_sleep+0x60>
  10495c:	eb 48                	jmp    1049a6 <sys_sleep+0x86>
  10495e:	66 90                	xchg   %ax,%ax
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  104960:	c7 44 24 04 e0 cf 10 	movl   $0x10cfe0,0x4(%esp)
  104967:	00 
  104968:	c7 04 24 20 d8 10 00 	movl   $0x10d820,(%esp)
  10496f:	e8 7c e7 ff ff       	call   1030f0 <sleep>
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
  104974:	a1 20 d8 10 00       	mov    0x10d820,%eax
  104979:	29 d8                	sub    %ebx,%eax
  10497b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  10497e:	73 26                	jae    1049a6 <sys_sleep+0x86>
    if(proc->killed){
  104980:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104986:	8b 40 24             	mov    0x24(%eax),%eax
  104989:	85 c0                	test   %eax,%eax
  10498b:	74 d3                	je     104960 <sys_sleep+0x40>
      release(&tickslock);
  10498d:	c7 04 24 e0 cf 10 00 	movl   $0x10cfe0,(%esp)
  104994:	e8 37 f0 ff ff       	call   1039d0 <release>
  104999:	ba ff ff ff ff       	mov    $0xffffffff,%edx
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
  10499e:	83 c4 24             	add    $0x24,%esp
  1049a1:	89 d0                	mov    %edx,%eax
  1049a3:	5b                   	pop    %ebx
  1049a4:	5d                   	pop    %ebp
  1049a5:	c3                   	ret    
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  1049a6:	c7 04 24 e0 cf 10 00 	movl   $0x10cfe0,(%esp)
  1049ad:	e8 1e f0 ff ff       	call   1039d0 <release>
  return 0;
}
  1049b2:	83 c4 24             	add    $0x24,%esp
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  1049b5:	31 d2                	xor    %edx,%edx
  return 0;
}
  1049b7:	5b                   	pop    %ebx
  1049b8:	89 d0                	mov    %edx,%eax
  1049ba:	5d                   	pop    %ebp
  1049bb:	c3                   	ret    
  1049bc:	8d 74 26 00          	lea    0x0(%esi),%esi

001049c0 <sys_sbrk>:
  return proc->pid;
}

int
sys_sbrk(void)
{
  1049c0:	55                   	push   %ebp
  1049c1:	89 e5                	mov    %esp,%ebp
  1049c3:	53                   	push   %ebx
  1049c4:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
  1049c7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  1049ca:	89 44 24 04          	mov    %eax,0x4(%esp)
  1049ce:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1049d5:	e8 56 f3 ff ff       	call   103d30 <argint>
  1049da:	85 c0                	test   %eax,%eax
  1049dc:	79 0d                	jns    1049eb <sys_sbrk+0x2b>
    return -1;
  addr = proc->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
  1049de:	ba ff ff ff ff       	mov    $0xffffffff,%edx
}
  1049e3:	83 c4 24             	add    $0x24,%esp
  1049e6:	89 d0                	mov    %edx,%eax
  1049e8:	5b                   	pop    %ebx
  1049e9:	5d                   	pop    %ebp
  1049ea:	c3                   	ret    
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
  1049eb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1049f1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
  1049f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1049f6:	89 04 24             	mov    %eax,(%esp)
  1049f9:	e8 42 ec ff ff       	call   103640 <growproc>
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
  1049fe:	89 da                	mov    %ebx,%edx
  if(growproc(n) < 0)
  104a00:	85 c0                	test   %eax,%eax
  104a02:	79 df                	jns    1049e3 <sys_sbrk+0x23>
  104a04:	eb d8                	jmp    1049de <sys_sbrk+0x1e>
  104a06:	8d 76 00             	lea    0x0(%esi),%esi
  104a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00104a10 <sys_kill>:
  return wait();
}

int
sys_kill(void)
{
  104a10:	55                   	push   %ebp
  104a11:	89 e5                	mov    %esp,%ebp
  104a13:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
  104a16:	8d 45 fc             	lea    -0x4(%ebp),%eax
  104a19:	89 44 24 04          	mov    %eax,0x4(%esp)
  104a1d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104a24:	e8 07 f3 ff ff       	call   103d30 <argint>
  104a29:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  104a2e:	85 c0                	test   %eax,%eax
  104a30:	78 0d                	js     104a3f <sys_kill+0x2f>
    return -1;
  return kill(pid);
  104a32:	8b 45 fc             	mov    -0x4(%ebp),%eax
  104a35:	89 04 24             	mov    %eax,(%esp)
  104a38:	e8 43 e5 ff ff       	call   102f80 <kill>
  104a3d:	89 c2                	mov    %eax,%edx
}
  104a3f:	c9                   	leave  
  104a40:	89 d0                	mov    %edx,%eax
  104a42:	c3                   	ret    
  104a43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00104a50 <sys_wait>:
  return 0;  // not reached
}

int
sys_wait(void)
{
  104a50:	55                   	push   %ebp
  104a51:	89 e5                	mov    %esp,%ebp
  return wait();
}
  104a53:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
  104a54:	e9 47 e8 ff ff       	jmp    1032a0 <wait>
  104a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00104a60 <sys_exit>:
  return fork();
}

int
sys_exit(void)
{
  104a60:	55                   	push   %ebp
  104a61:	89 e5                	mov    %esp,%ebp
  104a63:	83 ec 08             	sub    $0x8,%esp
  exit();
  104a66:	e8 15 e9 ff ff       	call   103380 <exit>
  return 0;  // not reached
}
  104a6b:	31 c0                	xor    %eax,%eax
  104a6d:	c9                   	leave  
  104a6e:	c3                   	ret    
  104a6f:	90                   	nop    

00104a70 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  104a70:	55                   	push   %ebp
  104a71:	89 e5                	mov    %esp,%ebp
  return fork();
}
  104a73:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
  104a74:	e9 b7 ea ff ff       	jmp    103530 <fork>
  104a79:	90                   	nop    
  104a7a:	90                   	nop    
  104a7b:	90                   	nop    
  104a7c:	90                   	nop    
  104a7d:	90                   	nop    
  104a7e:	90                   	nop    
  104a7f:	90                   	nop    

00104a80 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
  104a80:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  104a81:	b8 34 00 00 00       	mov    $0x34,%eax
  104a86:	89 e5                	mov    %esp,%ebp
  104a88:	ba 43 00 00 00       	mov    $0x43,%edx
  104a8d:	83 ec 08             	sub    $0x8,%esp
  104a90:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  picenable(IRQ_TIMER);
  104a91:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
  104a96:	b2 40                	mov    $0x40,%dl
  104a98:	ee                   	out    %al,(%dx)
  104a99:	b8 2e 00 00 00       	mov    $0x2e,%eax
  104a9e:	ee                   	out    %al,(%dx)
  104a9f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104aa6:	e8 55 e0 ff ff       	call   102b00 <picenable>
}
  104aab:	c9                   	leave  
  104aac:	c3                   	ret    
  104aad:	90                   	nop    
  104aae:	90                   	nop    
  104aaf:	90                   	nop    

00104ab0 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
  104ab0:	1e                   	push   %ds
  pushl %es
  104ab1:	06                   	push   %es
  pushl %fs
  104ab2:	0f a0                	push   %fs
  pushl %gs
  104ab4:	0f a8                	push   %gs
  pushal
  104ab6:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
  104ab7:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
  104abb:	8e d8                	mov    %eax,%ds
  movw %ax, %es
  104abd:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
  104abf:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
  104ac3:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
  104ac5:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
  104ac7:	54                   	push   %esp
  call trap
  104ac8:	e8 d3 00 00 00       	call   104ba0 <trap>
  addl $4, %esp
  104acd:	83 c4 04             	add    $0x4,%esp

00104ad0 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
  104ad0:	61                   	popa   
  popl %gs
  104ad1:	0f a9                	pop    %gs
  popl %fs
  104ad3:	0f a1                	pop    %fs
  popl %es
  104ad5:	07                   	pop    %es
  popl %ds
  104ad6:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
  104ad7:	83 c4 08             	add    $0x8,%esp
  iret
  104ada:	cf                   	iret   
  104adb:	90                   	nop    
  104adc:	90                   	nop    
  104add:	90                   	nop    
  104ade:	90                   	nop    
  104adf:	90                   	nop    

00104ae0 <idtinit>:
  initlock(&tickslock, "time");
}

void
idtinit(void)
{
  104ae0:	55                   	push   %ebp
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
  104ae1:	b8 20 d0 10 00       	mov    $0x10d020,%eax
  104ae6:	89 e5                	mov    %esp,%ebp
  104ae8:	83 ec 10             	sub    $0x10,%esp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  104aeb:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
  104af1:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
  104af5:	c1 e8 10             	shr    $0x10,%eax
  104af8:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
  104afc:	8d 45 fa             	lea    -0x6(%ebp),%eax
  104aff:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
  104b02:	c9                   	leave  
  104b03:	c3                   	ret    
  104b04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104b0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00104b10 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
  104b10:	55                   	push   %ebp
  104b11:	31 d2                	xor    %edx,%edx
  104b13:	89 e5                	mov    %esp,%ebp
  104b15:	83 ec 08             	sub    $0x8,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  104b18:	8b 04 95 08 73 10 00 	mov    0x107308(,%edx,4),%eax
  104b1f:	66 c7 04 d5 22 d0 10 	movw   $0x8,0x10d022(,%edx,8)
  104b26:	00 08 00 
  104b29:	c6 04 d5 24 d0 10 00 	movb   $0x0,0x10d024(,%edx,8)
  104b30:	00 
  104b31:	c6 04 d5 25 d0 10 00 	movb   $0x8e,0x10d025(,%edx,8)
  104b38:	8e 
  104b39:	66 89 04 d5 20 d0 10 	mov    %ax,0x10d020(,%edx,8)
  104b40:	00 
  104b41:	c1 e8 10             	shr    $0x10,%eax
  104b44:	66 89 04 d5 26 d0 10 	mov    %ax,0x10d026(,%edx,8)
  104b4b:	00 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
  104b4c:	83 c2 01             	add    $0x1,%edx
  104b4f:	81 fa 00 01 00 00    	cmp    $0x100,%edx
  104b55:	75 c1                	jne    104b18 <tvinit+0x8>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  104b57:	a1 08 74 10 00       	mov    0x107408,%eax
  
  initlock(&tickslock, "time");
  104b5c:	c7 44 24 04 9d 68 10 	movl   $0x10689d,0x4(%esp)
  104b63:	00 
  104b64:	c7 04 24 e0 cf 10 00 	movl   $0x10cfe0,(%esp)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  104b6b:	66 c7 05 22 d2 10 00 	movw   $0x8,0x10d222
  104b72:	08 00 
  104b74:	66 a3 20 d2 10 00    	mov    %ax,0x10d220
  104b7a:	c1 e8 10             	shr    $0x10,%eax
  104b7d:	c6 05 24 d2 10 00 00 	movb   $0x0,0x10d224
  104b84:	c6 05 25 d2 10 00 ef 	movb   $0xef,0x10d225
  104b8b:	66 a3 26 d2 10 00    	mov    %ax,0x10d226
  
  initlock(&tickslock, "time");
  104b91:	e8 fa ec ff ff       	call   103890 <initlock>
}
  104b96:	c9                   	leave  
  104b97:	c3                   	ret    
  104b98:	90                   	nop    
  104b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00104ba0 <trap>:
  lidt(idt, sizeof(idt));
}

void
trap(struct trapframe *tf)
{
  104ba0:	55                   	push   %ebp
  104ba1:	89 e5                	mov    %esp,%ebp
  104ba3:	56                   	push   %esi
  104ba4:	53                   	push   %ebx
  104ba5:	83 ec 20             	sub    $0x20,%esp
  104ba8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
  104bab:	8b 4b 30             	mov    0x30(%ebx),%ecx
  104bae:	83 f9 40             	cmp    $0x40,%ecx
  104bb1:	74 5d                	je     104c10 <trap+0x70>
    if(proc->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  104bb3:	8d 41 e0             	lea    -0x20(%ecx),%eax
  104bb6:	83 f8 1f             	cmp    $0x1f,%eax
  104bb9:	76 4c                	jbe    104c07 <trap+0x67>
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
    break;
   
  default:
    if(proc == 0 || (tf->cs&3) == 0){
  104bbb:	65 8b 35 04 00 00 00 	mov    %gs:0x4,%esi
  104bc2:	85 f6                	test   %esi,%esi
  104bc4:	74 0a                	je     104bd0 <trap+0x30>
  104bc6:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
  104bca:	0f 85 a0 01 00 00    	jne    104d70 <trap+0x1d0>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
  104bd0:	0f 20 d0             	mov    %cr2,%eax
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
  104bd3:	89 44 24 10          	mov    %eax,0x10(%esp)
  104bd7:	8b 43 38             	mov    0x38(%ebx),%eax
  104bda:	89 44 24 0c          	mov    %eax,0xc(%esp)
  104bde:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  104be4:	0f b6 00             	movzbl (%eax),%eax
  104be7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  104beb:	c7 04 24 cc 68 10 00 	movl   $0x1068cc,(%esp)
  104bf2:	89 44 24 08          	mov    %eax,0x8(%esp)
  104bf6:	e8 c5 b8 ff ff       	call   1004c0 <cprintf>
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
  104bfb:	c7 04 24 a2 68 10 00 	movl   $0x1068a2,(%esp)
  104c02:	e8 79 bc ff ff       	call   100880 <panic>
    if(proc->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  104c07:	ff 24 85 44 69 10 00 	jmp    *0x106944(,%eax,4)
  104c0e:	66 90                	xchg   %ax,%ax

void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
  104c10:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  104c17:	8b 72 24             	mov    0x24(%edx),%esi
  104c1a:	85 f6                	test   %esi,%esi
  104c1c:	0f 85 0c 01 00 00    	jne    104d2e <trap+0x18e>
      exit();
    proc->tf = tf;
  104c22:	89 5a 18             	mov    %ebx,0x18(%edx)
    syscall();
  104c25:	e8 e6 f1 ff ff       	call   103e10 <syscall>
    if(proc->killed)
  104c2a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104c30:	8b 58 24             	mov    0x24(%eax),%ebx
  104c33:	85 db                	test   %ebx,%ebx
  104c35:	75 5e                	jne    104c95 <trap+0xf5>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
  104c37:	83 c4 20             	add    $0x20,%esp
  104c3a:	5b                   	pop    %ebx
  104c3b:	5e                   	pop    %esi
  104c3c:	5d                   	pop    %ebp
  104c3d:	c3                   	ret    
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
  104c3e:	e8 ed d2 ff ff       	call   101f30 <ideintr>
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
  104c43:	e8 88 d7 ff ff       	call   1023d0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
  104c48:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  104c4f:	85 d2                	test   %edx,%edx
  104c51:	74 e4                	je     104c37 <trap+0x97>
  104c53:	8b 4a 24             	mov    0x24(%edx),%ecx
  104c56:	85 c9                	test   %ecx,%ecx
  104c58:	74 10                	je     104c6a <trap+0xca>
  104c5a:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
  104c5e:	83 e0 03             	and    $0x3,%eax
  104c61:	83 f8 03             	cmp    $0x3,%eax
  104c64:	0f 84 ed 00 00 00    	je     104d57 <trap+0x1b7>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
  104c6a:	83 7a 0c 04          	cmpl   $0x4,0xc(%edx)
  104c6e:	75 10                	jne    104c80 <trap+0xe0>
  104c70:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
  104c74:	0f 84 c5 00 00 00    	je     104d3f <trap+0x19f>
  104c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
  104c80:	89 d0                	mov    %edx,%eax
  104c82:	8b 40 24             	mov    0x24(%eax),%eax
  104c85:	85 c0                	test   %eax,%eax
  104c87:	74 ae                	je     104c37 <trap+0x97>
  104c89:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
  104c8d:	83 e0 03             	and    $0x3,%eax
  104c90:	83 f8 03             	cmp    $0x3,%eax
  104c93:	75 a2                	jne    104c37 <trap+0x97>
    exit();
}
  104c95:	83 c4 20             	add    $0x20,%esp
  104c98:	5b                   	pop    %ebx
  104c99:	5e                   	pop    %esi
  104c9a:	5d                   	pop    %ebp
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
  104c9b:	e9 e0 e6 ff ff       	jmp    103380 <exit>
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
  104ca0:	8b 43 38             	mov    0x38(%ebx),%eax
  104ca3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  104ca7:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
  104cab:	89 44 24 08          	mov    %eax,0x8(%esp)
  104caf:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  104cb5:	0f b6 00             	movzbl (%eax),%eax
  104cb8:	c7 04 24 a8 68 10 00 	movl   $0x1068a8,(%esp)
  104cbf:	89 44 24 04          	mov    %eax,0x4(%esp)
  104cc3:	e8 f8 b7 ff ff       	call   1004c0 <cprintf>
  104cc8:	e9 76 ff ff ff       	jmp    104c43 <trap+0xa3>
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
  104ccd:	e8 fe 00 00 00       	call   104dd0 <uartintr>
    lapiceoi();
  104cd2:	e8 f9 d6 ff ff       	call   1023d0 <lapiceoi>
  104cd7:	e9 6c ff ff ff       	jmp    104c48 <trap+0xa8>
  104cdc:	8d 74 26 00          	lea    0x0(%esi),%esi
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
  104ce0:	e8 eb d5 ff ff       	call   1022d0 <kbdintr>
    lapiceoi();
  104ce5:	e8 e6 d6 ff ff       	call   1023d0 <lapiceoi>
  104cea:	e9 59 ff ff ff       	jmp    104c48 <trap+0xa8>
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
  104cef:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  104cf5:	80 38 00             	cmpb   $0x0,(%eax)
  104cf8:	0f 85 45 ff ff ff    	jne    104c43 <trap+0xa3>
      acquire(&tickslock);
  104cfe:	c7 04 24 e0 cf 10 00 	movl   $0x10cfe0,(%esp)
  104d05:	e8 06 ed ff ff       	call   103a10 <acquire>
      ticks++;
  104d0a:	83 05 20 d8 10 00 01 	addl   $0x1,0x10d820
      wakeup(&ticks);
  104d11:	c7 04 24 20 d8 10 00 	movl   $0x10d820,(%esp)
  104d18:	e8 e3 e2 ff ff       	call   103000 <wakeup>
      release(&tickslock);
  104d1d:	c7 04 24 e0 cf 10 00 	movl   $0x10cfe0,(%esp)
  104d24:	e8 a7 ec ff ff       	call   1039d0 <release>
  104d29:	e9 15 ff ff ff       	jmp    104c43 <trap+0xa3>
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
      exit();
  104d2e:	e8 4d e6 ff ff       	call   103380 <exit>
  104d33:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  104d3a:	e9 e3 fe ff ff       	jmp    104c22 <trap+0x82>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
  104d3f:	e8 7c e4 ff ff       	call   1031c0 <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
  104d44:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104d4a:	85 c0                	test   %eax,%eax
  104d4c:	0f 85 30 ff ff ff    	jne    104c82 <trap+0xe2>
  104d52:	e9 e0 fe ff ff       	jmp    104c37 <trap+0x97>

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
  104d57:	e8 24 e6 ff ff       	call   103380 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
  104d5c:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  104d63:	85 d2                	test   %edx,%edx
  104d65:	0f 85 ff fe ff ff    	jne    104c6a <trap+0xca>
  104d6b:	e9 c7 fe ff ff       	jmp    104c37 <trap+0x97>
  104d70:	0f 20 d0             	mov    %cr2,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
  104d73:	8b 56 10             	mov    0x10(%esi),%edx
  104d76:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  104d7a:	8b 43 38             	mov    0x38(%ebx),%eax
  104d7d:	89 44 24 18          	mov    %eax,0x18(%esp)
  104d81:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  104d87:	0f b6 00             	movzbl (%eax),%eax
  104d8a:	89 44 24 14          	mov    %eax,0x14(%esp)
  104d8e:	8b 43 34             	mov    0x34(%ebx),%eax
  104d91:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  104d95:	89 54 24 04          	mov    %edx,0x4(%esp)
  104d99:	c7 04 24 00 69 10 00 	movl   $0x106900,(%esp)
  104da0:	89 44 24 10          	mov    %eax,0x10(%esp)
  104da4:	8d 46 6c             	lea    0x6c(%esi),%eax
  104da7:	89 44 24 08          	mov    %eax,0x8(%esp)
  104dab:	e8 10 b7 ff ff       	call   1004c0 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
  104db0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104db6:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  104dbd:	e9 86 fe ff ff       	jmp    104c48 <trap+0xa8>
  104dc2:	90                   	nop    
  104dc3:	90                   	nop    
  104dc4:	90                   	nop    
  104dc5:	90                   	nop    
  104dc6:	90                   	nop    
  104dc7:	90                   	nop    
  104dc8:	90                   	nop    
  104dc9:	90                   	nop    
  104dca:	90                   	nop    
  104dcb:	90                   	nop    
  104dcc:	90                   	nop    
  104dcd:	90                   	nop    
  104dce:	90                   	nop    
  104dcf:	90                   	nop    

00104dd0 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
  104dd0:	55                   	push   %ebp
  104dd1:	89 e5                	mov    %esp,%ebp
  104dd3:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
  104dd6:	c7 04 24 40 4e 10 00 	movl   $0x104e40,(%esp)
  104ddd:	e8 1e b9 ff ff       	call   100700 <consoleintr>
}
  104de2:	c9                   	leave  
  104de3:	c3                   	ret    
  104de4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104dea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00104df0 <uartputc>:
    uartputc(*p);
}

void
uartputc(int c)
{
  104df0:	55                   	push   %ebp
  104df1:	89 e5                	mov    %esp,%ebp
  104df3:	53                   	push   %ebx
  int i;

  if(!uart)
    return;
  104df4:	31 db                	xor    %ebx,%ebx
    uartputc(*p);
}

void
uartputc(int c)
{
  104df6:	83 ec 04             	sub    $0x4,%esp
  int i;

  if(!uart)
  104df9:	a1 4c 78 10 00       	mov    0x10784c,%eax
  104dfe:	85 c0                	test   %eax,%eax
  104e00:	75 19                	jne    104e1b <uartputc+0x2b>
  104e02:	eb 2b                	jmp    104e2f <uartputc+0x3f>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
  104e04:	83 c3 01             	add    $0x1,%ebx
    microdelay(10);
  104e07:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  104e0e:	e8 dd d5 ff ff       	call   1023f0 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
  104e13:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
  104e19:	74 0a                	je     104e25 <uartputc+0x35>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  104e1b:	ba fd 03 00 00       	mov    $0x3fd,%edx
  104e20:	ec                   	in     (%dx),%al
  104e21:	a8 20                	test   $0x20,%al
  104e23:	74 df                	je     104e04 <uartputc+0x14>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  104e25:	ba f8 03 00 00       	mov    $0x3f8,%edx
  104e2a:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
  104e2e:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
  104e2f:	83 c4 04             	add    $0x4,%esp
  104e32:	5b                   	pop    %ebx
  104e33:	5d                   	pop    %ebp
  104e34:	c3                   	ret    
  104e35:	8d 74 26 00          	lea    0x0(%esi),%esi
  104e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00104e40 <uartgetc>:

static int
uartgetc(void)
{
  if(!uart)
  104e40:	8b 15 4c 78 10 00    	mov    0x10784c,%edx
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
  104e46:	55                   	push   %ebp
  104e47:	89 e5                	mov    %esp,%ebp
  if(!uart)
  104e49:	85 d2                	test   %edx,%edx
  104e4b:	75 07                	jne    104e54 <uartgetc+0x14>
    return -1;
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
  104e4d:	5d                   	pop    %ebp
{
  if(!uart)
    return -1;
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
  104e4e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104e53:	c3                   	ret    
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  104e54:	ba fd 03 00 00       	mov    $0x3fd,%edx
  104e59:	ec                   	in     (%dx),%al
static int
uartgetc(void)
{
  if(!uart)
    return -1;
  if(!(inb(COM1+5) & 0x01))
  104e5a:	a8 01                	test   $0x1,%al
  104e5c:	74 ef                	je     104e4d <uartgetc+0xd>
  104e5e:	b2 f8                	mov    $0xf8,%dl
  104e60:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
}
  104e61:	5d                   	pop    %ebp
  return data;
  104e62:	0f b6 c0             	movzbl %al,%eax
  104e65:	c3                   	ret    
  104e66:	8d 76 00             	lea    0x0(%esi),%esi
  104e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00104e70 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
  104e70:	55                   	push   %ebp
  104e71:	89 e5                	mov    %esp,%ebp
  104e73:	57                   	push   %edi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  104e74:	bf fa 03 00 00       	mov    $0x3fa,%edi
  104e79:	56                   	push   %esi
  104e7a:	89 fa                	mov    %edi,%edx
  104e7c:	53                   	push   %ebx
  104e7d:	31 db                	xor    %ebx,%ebx
  104e7f:	83 ec 0c             	sub    $0xc,%esp
  104e82:	89 d8                	mov    %ebx,%eax
  104e84:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  104e85:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
  104e8a:	b2 fb                	mov    $0xfb,%dl
  104e8c:	ee                   	out    %al,(%dx)
  104e8d:	be f8 03 00 00       	mov    $0x3f8,%esi
  104e92:	b8 0c 00 00 00       	mov    $0xc,%eax
  104e97:	89 f2                	mov    %esi,%edx
  104e99:	ee                   	out    %al,(%dx)
  104e9a:	b9 f9 03 00 00       	mov    $0x3f9,%ecx
  104e9f:	89 d8                	mov    %ebx,%eax
  104ea1:	89 ca                	mov    %ecx,%edx
  104ea3:	ee                   	out    %al,(%dx)
  104ea4:	b8 03 00 00 00       	mov    $0x3,%eax
  104ea9:	b2 fb                	mov    $0xfb,%dl
  104eab:	ee                   	out    %al,(%dx)
  104eac:	b2 fc                	mov    $0xfc,%dl
  104eae:	89 d8                	mov    %ebx,%eax
  104eb0:	ee                   	out    %al,(%dx)
  104eb1:	b8 01 00 00 00       	mov    $0x1,%eax
  104eb6:	89 ca                	mov    %ecx,%edx
  104eb8:	ee                   	out    %al,(%dx)
  104eb9:	b2 fd                	mov    $0xfd,%dl
  104ebb:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
  104ebc:	04 01                	add    $0x1,%al
  104ebe:	74 56                	je     104f16 <uartinit+0xa6>
    return;
  uart = 1;
  104ec0:	c7 05 4c 78 10 00 01 	movl   $0x1,0x10784c
  104ec7:	00 00 00 
  104eca:	89 fa                	mov    %edi,%edx
  104ecc:	ec                   	in     (%dx),%al
  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  104ecd:	89 f2                	mov    %esi,%edx
  104ecf:	ec                   	in     (%dx),%al
  104ed0:	bb c4 69 10 00       	mov    $0x1069c4,%ebx

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  picenable(IRQ_COM1);
  104ed5:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  104edc:	e8 1f dc ff ff       	call   102b00 <picenable>
  ioapicenable(IRQ_COM1, 0);
  104ee1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104ee8:	00 
  104ee9:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  104ef0:	e8 9b d1 ff ff       	call   102090 <ioapicenable>
  104ef5:	b8 78 00 00 00       	mov    $0x78,%eax
  104efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
  104f00:	0f be c0             	movsbl %al,%eax
  104f03:	89 04 24             	mov    %eax,(%esp)
  104f06:	e8 e5 fe ff ff       	call   104df0 <uartputc>
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
  104f0b:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
  104f0f:	83 c3 01             	add    $0x1,%ebx
  104f12:	84 c0                	test   %al,%al
  104f14:	75 ea                	jne    104f00 <uartinit+0x90>
    uartputc(*p);
}
  104f16:	83 c4 0c             	add    $0xc,%esp
  104f19:	5b                   	pop    %ebx
  104f1a:	5e                   	pop    %esi
  104f1b:	5f                   	pop    %edi
  104f1c:	5d                   	pop    %ebp
  104f1d:	c3                   	ret    
  104f1e:	90                   	nop    
  104f1f:	90                   	nop    

00104f20 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
  104f20:	6a 00                	push   $0x0
  pushl $0
  104f22:	6a 00                	push   $0x0
  jmp alltraps
  104f24:	e9 87 fb ff ff       	jmp    104ab0 <alltraps>

00104f29 <vector1>:
.globl vector1
vector1:
  pushl $0
  104f29:	6a 00                	push   $0x0
  pushl $1
  104f2b:	6a 01                	push   $0x1
  jmp alltraps
  104f2d:	e9 7e fb ff ff       	jmp    104ab0 <alltraps>

00104f32 <vector2>:
.globl vector2
vector2:
  pushl $0
  104f32:	6a 00                	push   $0x0
  pushl $2
  104f34:	6a 02                	push   $0x2
  jmp alltraps
  104f36:	e9 75 fb ff ff       	jmp    104ab0 <alltraps>

00104f3b <vector3>:
.globl vector3
vector3:
  pushl $0
  104f3b:	6a 00                	push   $0x0
  pushl $3
  104f3d:	6a 03                	push   $0x3
  jmp alltraps
  104f3f:	e9 6c fb ff ff       	jmp    104ab0 <alltraps>

00104f44 <vector4>:
.globl vector4
vector4:
  pushl $0
  104f44:	6a 00                	push   $0x0
  pushl $4
  104f46:	6a 04                	push   $0x4
  jmp alltraps
  104f48:	e9 63 fb ff ff       	jmp    104ab0 <alltraps>

00104f4d <vector5>:
.globl vector5
vector5:
  pushl $0
  104f4d:	6a 00                	push   $0x0
  pushl $5
  104f4f:	6a 05                	push   $0x5
  jmp alltraps
  104f51:	e9 5a fb ff ff       	jmp    104ab0 <alltraps>

00104f56 <vector6>:
.globl vector6
vector6:
  pushl $0
  104f56:	6a 00                	push   $0x0
  pushl $6
  104f58:	6a 06                	push   $0x6
  jmp alltraps
  104f5a:	e9 51 fb ff ff       	jmp    104ab0 <alltraps>

00104f5f <vector7>:
.globl vector7
vector7:
  pushl $0
  104f5f:	6a 00                	push   $0x0
  pushl $7
  104f61:	6a 07                	push   $0x7
  jmp alltraps
  104f63:	e9 48 fb ff ff       	jmp    104ab0 <alltraps>

00104f68 <vector8>:
.globl vector8
vector8:
  pushl $8
  104f68:	6a 08                	push   $0x8
  jmp alltraps
  104f6a:	e9 41 fb ff ff       	jmp    104ab0 <alltraps>

00104f6f <vector9>:
.globl vector9
vector9:
  pushl $0
  104f6f:	6a 00                	push   $0x0
  pushl $9
  104f71:	6a 09                	push   $0x9
  jmp alltraps
  104f73:	e9 38 fb ff ff       	jmp    104ab0 <alltraps>

00104f78 <vector10>:
.globl vector10
vector10:
  pushl $10
  104f78:	6a 0a                	push   $0xa
  jmp alltraps
  104f7a:	e9 31 fb ff ff       	jmp    104ab0 <alltraps>

00104f7f <vector11>:
.globl vector11
vector11:
  pushl $11
  104f7f:	6a 0b                	push   $0xb
  jmp alltraps
  104f81:	e9 2a fb ff ff       	jmp    104ab0 <alltraps>

00104f86 <vector12>:
.globl vector12
vector12:
  pushl $12
  104f86:	6a 0c                	push   $0xc
  jmp alltraps
  104f88:	e9 23 fb ff ff       	jmp    104ab0 <alltraps>

00104f8d <vector13>:
.globl vector13
vector13:
  pushl $13
  104f8d:	6a 0d                	push   $0xd
  jmp alltraps
  104f8f:	e9 1c fb ff ff       	jmp    104ab0 <alltraps>

00104f94 <vector14>:
.globl vector14
vector14:
  pushl $14
  104f94:	6a 0e                	push   $0xe
  jmp alltraps
  104f96:	e9 15 fb ff ff       	jmp    104ab0 <alltraps>

00104f9b <vector15>:
.globl vector15
vector15:
  pushl $0
  104f9b:	6a 00                	push   $0x0
  pushl $15
  104f9d:	6a 0f                	push   $0xf
  jmp alltraps
  104f9f:	e9 0c fb ff ff       	jmp    104ab0 <alltraps>

00104fa4 <vector16>:
.globl vector16
vector16:
  pushl $0
  104fa4:	6a 00                	push   $0x0
  pushl $16
  104fa6:	6a 10                	push   $0x10
  jmp alltraps
  104fa8:	e9 03 fb ff ff       	jmp    104ab0 <alltraps>

00104fad <vector17>:
.globl vector17
vector17:
  pushl $17
  104fad:	6a 11                	push   $0x11
  jmp alltraps
  104faf:	e9 fc fa ff ff       	jmp    104ab0 <alltraps>

00104fb4 <vector18>:
.globl vector18
vector18:
  pushl $0
  104fb4:	6a 00                	push   $0x0
  pushl $18
  104fb6:	6a 12                	push   $0x12
  jmp alltraps
  104fb8:	e9 f3 fa ff ff       	jmp    104ab0 <alltraps>

00104fbd <vector19>:
.globl vector19
vector19:
  pushl $0
  104fbd:	6a 00                	push   $0x0
  pushl $19
  104fbf:	6a 13                	push   $0x13
  jmp alltraps
  104fc1:	e9 ea fa ff ff       	jmp    104ab0 <alltraps>

00104fc6 <vector20>:
.globl vector20
vector20:
  pushl $0
  104fc6:	6a 00                	push   $0x0
  pushl $20
  104fc8:	6a 14                	push   $0x14
  jmp alltraps
  104fca:	e9 e1 fa ff ff       	jmp    104ab0 <alltraps>

00104fcf <vector21>:
.globl vector21
vector21:
  pushl $0
  104fcf:	6a 00                	push   $0x0
  pushl $21
  104fd1:	6a 15                	push   $0x15
  jmp alltraps
  104fd3:	e9 d8 fa ff ff       	jmp    104ab0 <alltraps>

00104fd8 <vector22>:
.globl vector22
vector22:
  pushl $0
  104fd8:	6a 00                	push   $0x0
  pushl $22
  104fda:	6a 16                	push   $0x16
  jmp alltraps
  104fdc:	e9 cf fa ff ff       	jmp    104ab0 <alltraps>

00104fe1 <vector23>:
.globl vector23
vector23:
  pushl $0
  104fe1:	6a 00                	push   $0x0
  pushl $23
  104fe3:	6a 17                	push   $0x17
  jmp alltraps
  104fe5:	e9 c6 fa ff ff       	jmp    104ab0 <alltraps>

00104fea <vector24>:
.globl vector24
vector24:
  pushl $0
  104fea:	6a 00                	push   $0x0
  pushl $24
  104fec:	6a 18                	push   $0x18
  jmp alltraps
  104fee:	e9 bd fa ff ff       	jmp    104ab0 <alltraps>

00104ff3 <vector25>:
.globl vector25
vector25:
  pushl $0
  104ff3:	6a 00                	push   $0x0
  pushl $25
  104ff5:	6a 19                	push   $0x19
  jmp alltraps
  104ff7:	e9 b4 fa ff ff       	jmp    104ab0 <alltraps>

00104ffc <vector26>:
.globl vector26
vector26:
  pushl $0
  104ffc:	6a 00                	push   $0x0
  pushl $26
  104ffe:	6a 1a                	push   $0x1a
  jmp alltraps
  105000:	e9 ab fa ff ff       	jmp    104ab0 <alltraps>

00105005 <vector27>:
.globl vector27
vector27:
  pushl $0
  105005:	6a 00                	push   $0x0
  pushl $27
  105007:	6a 1b                	push   $0x1b
  jmp alltraps
  105009:	e9 a2 fa ff ff       	jmp    104ab0 <alltraps>

0010500e <vector28>:
.globl vector28
vector28:
  pushl $0
  10500e:	6a 00                	push   $0x0
  pushl $28
  105010:	6a 1c                	push   $0x1c
  jmp alltraps
  105012:	e9 99 fa ff ff       	jmp    104ab0 <alltraps>

00105017 <vector29>:
.globl vector29
vector29:
  pushl $0
  105017:	6a 00                	push   $0x0
  pushl $29
  105019:	6a 1d                	push   $0x1d
  jmp alltraps
  10501b:	e9 90 fa ff ff       	jmp    104ab0 <alltraps>

00105020 <vector30>:
.globl vector30
vector30:
  pushl $0
  105020:	6a 00                	push   $0x0
  pushl $30
  105022:	6a 1e                	push   $0x1e
  jmp alltraps
  105024:	e9 87 fa ff ff       	jmp    104ab0 <alltraps>

00105029 <vector31>:
.globl vector31
vector31:
  pushl $0
  105029:	6a 00                	push   $0x0
  pushl $31
  10502b:	6a 1f                	push   $0x1f
  jmp alltraps
  10502d:	e9 7e fa ff ff       	jmp    104ab0 <alltraps>

00105032 <vector32>:
.globl vector32
vector32:
  pushl $0
  105032:	6a 00                	push   $0x0
  pushl $32
  105034:	6a 20                	push   $0x20
  jmp alltraps
  105036:	e9 75 fa ff ff       	jmp    104ab0 <alltraps>

0010503b <vector33>:
.globl vector33
vector33:
  pushl $0
  10503b:	6a 00                	push   $0x0
  pushl $33
  10503d:	6a 21                	push   $0x21
  jmp alltraps
  10503f:	e9 6c fa ff ff       	jmp    104ab0 <alltraps>

00105044 <vector34>:
.globl vector34
vector34:
  pushl $0
  105044:	6a 00                	push   $0x0
  pushl $34
  105046:	6a 22                	push   $0x22
  jmp alltraps
  105048:	e9 63 fa ff ff       	jmp    104ab0 <alltraps>

0010504d <vector35>:
.globl vector35
vector35:
  pushl $0
  10504d:	6a 00                	push   $0x0
  pushl $35
  10504f:	6a 23                	push   $0x23
  jmp alltraps
  105051:	e9 5a fa ff ff       	jmp    104ab0 <alltraps>

00105056 <vector36>:
.globl vector36
vector36:
  pushl $0
  105056:	6a 00                	push   $0x0
  pushl $36
  105058:	6a 24                	push   $0x24
  jmp alltraps
  10505a:	e9 51 fa ff ff       	jmp    104ab0 <alltraps>

0010505f <vector37>:
.globl vector37
vector37:
  pushl $0
  10505f:	6a 00                	push   $0x0
  pushl $37
  105061:	6a 25                	push   $0x25
  jmp alltraps
  105063:	e9 48 fa ff ff       	jmp    104ab0 <alltraps>

00105068 <vector38>:
.globl vector38
vector38:
  pushl $0
  105068:	6a 00                	push   $0x0
  pushl $38
  10506a:	6a 26                	push   $0x26
  jmp alltraps
  10506c:	e9 3f fa ff ff       	jmp    104ab0 <alltraps>

00105071 <vector39>:
.globl vector39
vector39:
  pushl $0
  105071:	6a 00                	push   $0x0
  pushl $39
  105073:	6a 27                	push   $0x27
  jmp alltraps
  105075:	e9 36 fa ff ff       	jmp    104ab0 <alltraps>

0010507a <vector40>:
.globl vector40
vector40:
  pushl $0
  10507a:	6a 00                	push   $0x0
  pushl $40
  10507c:	6a 28                	push   $0x28
  jmp alltraps
  10507e:	e9 2d fa ff ff       	jmp    104ab0 <alltraps>

00105083 <vector41>:
.globl vector41
vector41:
  pushl $0
  105083:	6a 00                	push   $0x0
  pushl $41
  105085:	6a 29                	push   $0x29
  jmp alltraps
  105087:	e9 24 fa ff ff       	jmp    104ab0 <alltraps>

0010508c <vector42>:
.globl vector42
vector42:
  pushl $0
  10508c:	6a 00                	push   $0x0
  pushl $42
  10508e:	6a 2a                	push   $0x2a
  jmp alltraps
  105090:	e9 1b fa ff ff       	jmp    104ab0 <alltraps>

00105095 <vector43>:
.globl vector43
vector43:
  pushl $0
  105095:	6a 00                	push   $0x0
  pushl $43
  105097:	6a 2b                	push   $0x2b
  jmp alltraps
  105099:	e9 12 fa ff ff       	jmp    104ab0 <alltraps>

0010509e <vector44>:
.globl vector44
vector44:
  pushl $0
  10509e:	6a 00                	push   $0x0
  pushl $44
  1050a0:	6a 2c                	push   $0x2c
  jmp alltraps
  1050a2:	e9 09 fa ff ff       	jmp    104ab0 <alltraps>

001050a7 <vector45>:
.globl vector45
vector45:
  pushl $0
  1050a7:	6a 00                	push   $0x0
  pushl $45
  1050a9:	6a 2d                	push   $0x2d
  jmp alltraps
  1050ab:	e9 00 fa ff ff       	jmp    104ab0 <alltraps>

001050b0 <vector46>:
.globl vector46
vector46:
  pushl $0
  1050b0:	6a 00                	push   $0x0
  pushl $46
  1050b2:	6a 2e                	push   $0x2e
  jmp alltraps
  1050b4:	e9 f7 f9 ff ff       	jmp    104ab0 <alltraps>

001050b9 <vector47>:
.globl vector47
vector47:
  pushl $0
  1050b9:	6a 00                	push   $0x0
  pushl $47
  1050bb:	6a 2f                	push   $0x2f
  jmp alltraps
  1050bd:	e9 ee f9 ff ff       	jmp    104ab0 <alltraps>

001050c2 <vector48>:
.globl vector48
vector48:
  pushl $0
  1050c2:	6a 00                	push   $0x0
  pushl $48
  1050c4:	6a 30                	push   $0x30
  jmp alltraps
  1050c6:	e9 e5 f9 ff ff       	jmp    104ab0 <alltraps>

001050cb <vector49>:
.globl vector49
vector49:
  pushl $0
  1050cb:	6a 00                	push   $0x0
  pushl $49
  1050cd:	6a 31                	push   $0x31
  jmp alltraps
  1050cf:	e9 dc f9 ff ff       	jmp    104ab0 <alltraps>

001050d4 <vector50>:
.globl vector50
vector50:
  pushl $0
  1050d4:	6a 00                	push   $0x0
  pushl $50
  1050d6:	6a 32                	push   $0x32
  jmp alltraps
  1050d8:	e9 d3 f9 ff ff       	jmp    104ab0 <alltraps>

001050dd <vector51>:
.globl vector51
vector51:
  pushl $0
  1050dd:	6a 00                	push   $0x0
  pushl $51
  1050df:	6a 33                	push   $0x33
  jmp alltraps
  1050e1:	e9 ca f9 ff ff       	jmp    104ab0 <alltraps>

001050e6 <vector52>:
.globl vector52
vector52:
  pushl $0
  1050e6:	6a 00                	push   $0x0
  pushl $52
  1050e8:	6a 34                	push   $0x34
  jmp alltraps
  1050ea:	e9 c1 f9 ff ff       	jmp    104ab0 <alltraps>

001050ef <vector53>:
.globl vector53
vector53:
  pushl $0
  1050ef:	6a 00                	push   $0x0
  pushl $53
  1050f1:	6a 35                	push   $0x35
  jmp alltraps
  1050f3:	e9 b8 f9 ff ff       	jmp    104ab0 <alltraps>

001050f8 <vector54>:
.globl vector54
vector54:
  pushl $0
  1050f8:	6a 00                	push   $0x0
  pushl $54
  1050fa:	6a 36                	push   $0x36
  jmp alltraps
  1050fc:	e9 af f9 ff ff       	jmp    104ab0 <alltraps>

00105101 <vector55>:
.globl vector55
vector55:
  pushl $0
  105101:	6a 00                	push   $0x0
  pushl $55
  105103:	6a 37                	push   $0x37
  jmp alltraps
  105105:	e9 a6 f9 ff ff       	jmp    104ab0 <alltraps>

0010510a <vector56>:
.globl vector56
vector56:
  pushl $0
  10510a:	6a 00                	push   $0x0
  pushl $56
  10510c:	6a 38                	push   $0x38
  jmp alltraps
  10510e:	e9 9d f9 ff ff       	jmp    104ab0 <alltraps>

00105113 <vector57>:
.globl vector57
vector57:
  pushl $0
  105113:	6a 00                	push   $0x0
  pushl $57
  105115:	6a 39                	push   $0x39
  jmp alltraps
  105117:	e9 94 f9 ff ff       	jmp    104ab0 <alltraps>

0010511c <vector58>:
.globl vector58
vector58:
  pushl $0
  10511c:	6a 00                	push   $0x0
  pushl $58
  10511e:	6a 3a                	push   $0x3a
  jmp alltraps
  105120:	e9 8b f9 ff ff       	jmp    104ab0 <alltraps>

00105125 <vector59>:
.globl vector59
vector59:
  pushl $0
  105125:	6a 00                	push   $0x0
  pushl $59
  105127:	6a 3b                	push   $0x3b
  jmp alltraps
  105129:	e9 82 f9 ff ff       	jmp    104ab0 <alltraps>

0010512e <vector60>:
.globl vector60
vector60:
  pushl $0
  10512e:	6a 00                	push   $0x0
  pushl $60
  105130:	6a 3c                	push   $0x3c
  jmp alltraps
  105132:	e9 79 f9 ff ff       	jmp    104ab0 <alltraps>

00105137 <vector61>:
.globl vector61
vector61:
  pushl $0
  105137:	6a 00                	push   $0x0
  pushl $61
  105139:	6a 3d                	push   $0x3d
  jmp alltraps
  10513b:	e9 70 f9 ff ff       	jmp    104ab0 <alltraps>

00105140 <vector62>:
.globl vector62
vector62:
  pushl $0
  105140:	6a 00                	push   $0x0
  pushl $62
  105142:	6a 3e                	push   $0x3e
  jmp alltraps
  105144:	e9 67 f9 ff ff       	jmp    104ab0 <alltraps>

00105149 <vector63>:
.globl vector63
vector63:
  pushl $0
  105149:	6a 00                	push   $0x0
  pushl $63
  10514b:	6a 3f                	push   $0x3f
  jmp alltraps
  10514d:	e9 5e f9 ff ff       	jmp    104ab0 <alltraps>

00105152 <vector64>:
.globl vector64
vector64:
  pushl $0
  105152:	6a 00                	push   $0x0
  pushl $64
  105154:	6a 40                	push   $0x40
  jmp alltraps
  105156:	e9 55 f9 ff ff       	jmp    104ab0 <alltraps>

0010515b <vector65>:
.globl vector65
vector65:
  pushl $0
  10515b:	6a 00                	push   $0x0
  pushl $65
  10515d:	6a 41                	push   $0x41
  jmp alltraps
  10515f:	e9 4c f9 ff ff       	jmp    104ab0 <alltraps>

00105164 <vector66>:
.globl vector66
vector66:
  pushl $0
  105164:	6a 00                	push   $0x0
  pushl $66
  105166:	6a 42                	push   $0x42
  jmp alltraps
  105168:	e9 43 f9 ff ff       	jmp    104ab0 <alltraps>

0010516d <vector67>:
.globl vector67
vector67:
  pushl $0
  10516d:	6a 00                	push   $0x0
  pushl $67
  10516f:	6a 43                	push   $0x43
  jmp alltraps
  105171:	e9 3a f9 ff ff       	jmp    104ab0 <alltraps>

00105176 <vector68>:
.globl vector68
vector68:
  pushl $0
  105176:	6a 00                	push   $0x0
  pushl $68
  105178:	6a 44                	push   $0x44
  jmp alltraps
  10517a:	e9 31 f9 ff ff       	jmp    104ab0 <alltraps>

0010517f <vector69>:
.globl vector69
vector69:
  pushl $0
  10517f:	6a 00                	push   $0x0
  pushl $69
  105181:	6a 45                	push   $0x45
  jmp alltraps
  105183:	e9 28 f9 ff ff       	jmp    104ab0 <alltraps>

00105188 <vector70>:
.globl vector70
vector70:
  pushl $0
  105188:	6a 00                	push   $0x0
  pushl $70
  10518a:	6a 46                	push   $0x46
  jmp alltraps
  10518c:	e9 1f f9 ff ff       	jmp    104ab0 <alltraps>

00105191 <vector71>:
.globl vector71
vector71:
  pushl $0
  105191:	6a 00                	push   $0x0
  pushl $71
  105193:	6a 47                	push   $0x47
  jmp alltraps
  105195:	e9 16 f9 ff ff       	jmp    104ab0 <alltraps>

0010519a <vector72>:
.globl vector72
vector72:
  pushl $0
  10519a:	6a 00                	push   $0x0
  pushl $72
  10519c:	6a 48                	push   $0x48
  jmp alltraps
  10519e:	e9 0d f9 ff ff       	jmp    104ab0 <alltraps>

001051a3 <vector73>:
.globl vector73
vector73:
  pushl $0
  1051a3:	6a 00                	push   $0x0
  pushl $73
  1051a5:	6a 49                	push   $0x49
  jmp alltraps
  1051a7:	e9 04 f9 ff ff       	jmp    104ab0 <alltraps>

001051ac <vector74>:
.globl vector74
vector74:
  pushl $0
  1051ac:	6a 00                	push   $0x0
  pushl $74
  1051ae:	6a 4a                	push   $0x4a
  jmp alltraps
  1051b0:	e9 fb f8 ff ff       	jmp    104ab0 <alltraps>

001051b5 <vector75>:
.globl vector75
vector75:
  pushl $0
  1051b5:	6a 00                	push   $0x0
  pushl $75
  1051b7:	6a 4b                	push   $0x4b
  jmp alltraps
  1051b9:	e9 f2 f8 ff ff       	jmp    104ab0 <alltraps>

001051be <vector76>:
.globl vector76
vector76:
  pushl $0
  1051be:	6a 00                	push   $0x0
  pushl $76
  1051c0:	6a 4c                	push   $0x4c
  jmp alltraps
  1051c2:	e9 e9 f8 ff ff       	jmp    104ab0 <alltraps>

001051c7 <vector77>:
.globl vector77
vector77:
  pushl $0
  1051c7:	6a 00                	push   $0x0
  pushl $77
  1051c9:	6a 4d                	push   $0x4d
  jmp alltraps
  1051cb:	e9 e0 f8 ff ff       	jmp    104ab0 <alltraps>

001051d0 <vector78>:
.globl vector78
vector78:
  pushl $0
  1051d0:	6a 00                	push   $0x0
  pushl $78
  1051d2:	6a 4e                	push   $0x4e
  jmp alltraps
  1051d4:	e9 d7 f8 ff ff       	jmp    104ab0 <alltraps>

001051d9 <vector79>:
.globl vector79
vector79:
  pushl $0
  1051d9:	6a 00                	push   $0x0
  pushl $79
  1051db:	6a 4f                	push   $0x4f
  jmp alltraps
  1051dd:	e9 ce f8 ff ff       	jmp    104ab0 <alltraps>

001051e2 <vector80>:
.globl vector80
vector80:
  pushl $0
  1051e2:	6a 00                	push   $0x0
  pushl $80
  1051e4:	6a 50                	push   $0x50
  jmp alltraps
  1051e6:	e9 c5 f8 ff ff       	jmp    104ab0 <alltraps>

001051eb <vector81>:
.globl vector81
vector81:
  pushl $0
  1051eb:	6a 00                	push   $0x0
  pushl $81
  1051ed:	6a 51                	push   $0x51
  jmp alltraps
  1051ef:	e9 bc f8 ff ff       	jmp    104ab0 <alltraps>

001051f4 <vector82>:
.globl vector82
vector82:
  pushl $0
  1051f4:	6a 00                	push   $0x0
  pushl $82
  1051f6:	6a 52                	push   $0x52
  jmp alltraps
  1051f8:	e9 b3 f8 ff ff       	jmp    104ab0 <alltraps>

001051fd <vector83>:
.globl vector83
vector83:
  pushl $0
  1051fd:	6a 00                	push   $0x0
  pushl $83
  1051ff:	6a 53                	push   $0x53
  jmp alltraps
  105201:	e9 aa f8 ff ff       	jmp    104ab0 <alltraps>

00105206 <vector84>:
.globl vector84
vector84:
  pushl $0
  105206:	6a 00                	push   $0x0
  pushl $84
  105208:	6a 54                	push   $0x54
  jmp alltraps
  10520a:	e9 a1 f8 ff ff       	jmp    104ab0 <alltraps>

0010520f <vector85>:
.globl vector85
vector85:
  pushl $0
  10520f:	6a 00                	push   $0x0
  pushl $85
  105211:	6a 55                	push   $0x55
  jmp alltraps
  105213:	e9 98 f8 ff ff       	jmp    104ab0 <alltraps>

00105218 <vector86>:
.globl vector86
vector86:
  pushl $0
  105218:	6a 00                	push   $0x0
  pushl $86
  10521a:	6a 56                	push   $0x56
  jmp alltraps
  10521c:	e9 8f f8 ff ff       	jmp    104ab0 <alltraps>

00105221 <vector87>:
.globl vector87
vector87:
  pushl $0
  105221:	6a 00                	push   $0x0
  pushl $87
  105223:	6a 57                	push   $0x57
  jmp alltraps
  105225:	e9 86 f8 ff ff       	jmp    104ab0 <alltraps>

0010522a <vector88>:
.globl vector88
vector88:
  pushl $0
  10522a:	6a 00                	push   $0x0
  pushl $88
  10522c:	6a 58                	push   $0x58
  jmp alltraps
  10522e:	e9 7d f8 ff ff       	jmp    104ab0 <alltraps>

00105233 <vector89>:
.globl vector89
vector89:
  pushl $0
  105233:	6a 00                	push   $0x0
  pushl $89
  105235:	6a 59                	push   $0x59
  jmp alltraps
  105237:	e9 74 f8 ff ff       	jmp    104ab0 <alltraps>

0010523c <vector90>:
.globl vector90
vector90:
  pushl $0
  10523c:	6a 00                	push   $0x0
  pushl $90
  10523e:	6a 5a                	push   $0x5a
  jmp alltraps
  105240:	e9 6b f8 ff ff       	jmp    104ab0 <alltraps>

00105245 <vector91>:
.globl vector91
vector91:
  pushl $0
  105245:	6a 00                	push   $0x0
  pushl $91
  105247:	6a 5b                	push   $0x5b
  jmp alltraps
  105249:	e9 62 f8 ff ff       	jmp    104ab0 <alltraps>

0010524e <vector92>:
.globl vector92
vector92:
  pushl $0
  10524e:	6a 00                	push   $0x0
  pushl $92
  105250:	6a 5c                	push   $0x5c
  jmp alltraps
  105252:	e9 59 f8 ff ff       	jmp    104ab0 <alltraps>

00105257 <vector93>:
.globl vector93
vector93:
  pushl $0
  105257:	6a 00                	push   $0x0
  pushl $93
  105259:	6a 5d                	push   $0x5d
  jmp alltraps
  10525b:	e9 50 f8 ff ff       	jmp    104ab0 <alltraps>

00105260 <vector94>:
.globl vector94
vector94:
  pushl $0
  105260:	6a 00                	push   $0x0
  pushl $94
  105262:	6a 5e                	push   $0x5e
  jmp alltraps
  105264:	e9 47 f8 ff ff       	jmp    104ab0 <alltraps>

00105269 <vector95>:
.globl vector95
vector95:
  pushl $0
  105269:	6a 00                	push   $0x0
  pushl $95
  10526b:	6a 5f                	push   $0x5f
  jmp alltraps
  10526d:	e9 3e f8 ff ff       	jmp    104ab0 <alltraps>

00105272 <vector96>:
.globl vector96
vector96:
  pushl $0
  105272:	6a 00                	push   $0x0
  pushl $96
  105274:	6a 60                	push   $0x60
  jmp alltraps
  105276:	e9 35 f8 ff ff       	jmp    104ab0 <alltraps>

0010527b <vector97>:
.globl vector97
vector97:
  pushl $0
  10527b:	6a 00                	push   $0x0
  pushl $97
  10527d:	6a 61                	push   $0x61
  jmp alltraps
  10527f:	e9 2c f8 ff ff       	jmp    104ab0 <alltraps>

00105284 <vector98>:
.globl vector98
vector98:
  pushl $0
  105284:	6a 00                	push   $0x0
  pushl $98
  105286:	6a 62                	push   $0x62
  jmp alltraps
  105288:	e9 23 f8 ff ff       	jmp    104ab0 <alltraps>

0010528d <vector99>:
.globl vector99
vector99:
  pushl $0
  10528d:	6a 00                	push   $0x0
  pushl $99
  10528f:	6a 63                	push   $0x63
  jmp alltraps
  105291:	e9 1a f8 ff ff       	jmp    104ab0 <alltraps>

00105296 <vector100>:
.globl vector100
vector100:
  pushl $0
  105296:	6a 00                	push   $0x0
  pushl $100
  105298:	6a 64                	push   $0x64
  jmp alltraps
  10529a:	e9 11 f8 ff ff       	jmp    104ab0 <alltraps>

0010529f <vector101>:
.globl vector101
vector101:
  pushl $0
  10529f:	6a 00                	push   $0x0
  pushl $101
  1052a1:	6a 65                	push   $0x65
  jmp alltraps
  1052a3:	e9 08 f8 ff ff       	jmp    104ab0 <alltraps>

001052a8 <vector102>:
.globl vector102
vector102:
  pushl $0
  1052a8:	6a 00                	push   $0x0
  pushl $102
  1052aa:	6a 66                	push   $0x66
  jmp alltraps
  1052ac:	e9 ff f7 ff ff       	jmp    104ab0 <alltraps>

001052b1 <vector103>:
.globl vector103
vector103:
  pushl $0
  1052b1:	6a 00                	push   $0x0
  pushl $103
  1052b3:	6a 67                	push   $0x67
  jmp alltraps
  1052b5:	e9 f6 f7 ff ff       	jmp    104ab0 <alltraps>

001052ba <vector104>:
.globl vector104
vector104:
  pushl $0
  1052ba:	6a 00                	push   $0x0
  pushl $104
  1052bc:	6a 68                	push   $0x68
  jmp alltraps
  1052be:	e9 ed f7 ff ff       	jmp    104ab0 <alltraps>

001052c3 <vector105>:
.globl vector105
vector105:
  pushl $0
  1052c3:	6a 00                	push   $0x0
  pushl $105
  1052c5:	6a 69                	push   $0x69
  jmp alltraps
  1052c7:	e9 e4 f7 ff ff       	jmp    104ab0 <alltraps>

001052cc <vector106>:
.globl vector106
vector106:
  pushl $0
  1052cc:	6a 00                	push   $0x0
  pushl $106
  1052ce:	6a 6a                	push   $0x6a
  jmp alltraps
  1052d0:	e9 db f7 ff ff       	jmp    104ab0 <alltraps>

001052d5 <vector107>:
.globl vector107
vector107:
  pushl $0
  1052d5:	6a 00                	push   $0x0
  pushl $107
  1052d7:	6a 6b                	push   $0x6b
  jmp alltraps
  1052d9:	e9 d2 f7 ff ff       	jmp    104ab0 <alltraps>

001052de <vector108>:
.globl vector108
vector108:
  pushl $0
  1052de:	6a 00                	push   $0x0
  pushl $108
  1052e0:	6a 6c                	push   $0x6c
  jmp alltraps
  1052e2:	e9 c9 f7 ff ff       	jmp    104ab0 <alltraps>

001052e7 <vector109>:
.globl vector109
vector109:
  pushl $0
  1052e7:	6a 00                	push   $0x0
  pushl $109
  1052e9:	6a 6d                	push   $0x6d
  jmp alltraps
  1052eb:	e9 c0 f7 ff ff       	jmp    104ab0 <alltraps>

001052f0 <vector110>:
.globl vector110
vector110:
  pushl $0
  1052f0:	6a 00                	push   $0x0
  pushl $110
  1052f2:	6a 6e                	push   $0x6e
  jmp alltraps
  1052f4:	e9 b7 f7 ff ff       	jmp    104ab0 <alltraps>

001052f9 <vector111>:
.globl vector111
vector111:
  pushl $0
  1052f9:	6a 00                	push   $0x0
  pushl $111
  1052fb:	6a 6f                	push   $0x6f
  jmp alltraps
  1052fd:	e9 ae f7 ff ff       	jmp    104ab0 <alltraps>

00105302 <vector112>:
.globl vector112
vector112:
  pushl $0
  105302:	6a 00                	push   $0x0
  pushl $112
  105304:	6a 70                	push   $0x70
  jmp alltraps
  105306:	e9 a5 f7 ff ff       	jmp    104ab0 <alltraps>

0010530b <vector113>:
.globl vector113
vector113:
  pushl $0
  10530b:	6a 00                	push   $0x0
  pushl $113
  10530d:	6a 71                	push   $0x71
  jmp alltraps
  10530f:	e9 9c f7 ff ff       	jmp    104ab0 <alltraps>

00105314 <vector114>:
.globl vector114
vector114:
  pushl $0
  105314:	6a 00                	push   $0x0
  pushl $114
  105316:	6a 72                	push   $0x72
  jmp alltraps
  105318:	e9 93 f7 ff ff       	jmp    104ab0 <alltraps>

0010531d <vector115>:
.globl vector115
vector115:
  pushl $0
  10531d:	6a 00                	push   $0x0
  pushl $115
  10531f:	6a 73                	push   $0x73
  jmp alltraps
  105321:	e9 8a f7 ff ff       	jmp    104ab0 <alltraps>

00105326 <vector116>:
.globl vector116
vector116:
  pushl $0
  105326:	6a 00                	push   $0x0
  pushl $116
  105328:	6a 74                	push   $0x74
  jmp alltraps
  10532a:	e9 81 f7 ff ff       	jmp    104ab0 <alltraps>

0010532f <vector117>:
.globl vector117
vector117:
  pushl $0
  10532f:	6a 00                	push   $0x0
  pushl $117
  105331:	6a 75                	push   $0x75
  jmp alltraps
  105333:	e9 78 f7 ff ff       	jmp    104ab0 <alltraps>

00105338 <vector118>:
.globl vector118
vector118:
  pushl $0
  105338:	6a 00                	push   $0x0
  pushl $118
  10533a:	6a 76                	push   $0x76
  jmp alltraps
  10533c:	e9 6f f7 ff ff       	jmp    104ab0 <alltraps>

00105341 <vector119>:
.globl vector119
vector119:
  pushl $0
  105341:	6a 00                	push   $0x0
  pushl $119
  105343:	6a 77                	push   $0x77
  jmp alltraps
  105345:	e9 66 f7 ff ff       	jmp    104ab0 <alltraps>

0010534a <vector120>:
.globl vector120
vector120:
  pushl $0
  10534a:	6a 00                	push   $0x0
  pushl $120
  10534c:	6a 78                	push   $0x78
  jmp alltraps
  10534e:	e9 5d f7 ff ff       	jmp    104ab0 <alltraps>

00105353 <vector121>:
.globl vector121
vector121:
  pushl $0
  105353:	6a 00                	push   $0x0
  pushl $121
  105355:	6a 79                	push   $0x79
  jmp alltraps
  105357:	e9 54 f7 ff ff       	jmp    104ab0 <alltraps>

0010535c <vector122>:
.globl vector122
vector122:
  pushl $0
  10535c:	6a 00                	push   $0x0
  pushl $122
  10535e:	6a 7a                	push   $0x7a
  jmp alltraps
  105360:	e9 4b f7 ff ff       	jmp    104ab0 <alltraps>

00105365 <vector123>:
.globl vector123
vector123:
  pushl $0
  105365:	6a 00                	push   $0x0
  pushl $123
  105367:	6a 7b                	push   $0x7b
  jmp alltraps
  105369:	e9 42 f7 ff ff       	jmp    104ab0 <alltraps>

0010536e <vector124>:
.globl vector124
vector124:
  pushl $0
  10536e:	6a 00                	push   $0x0
  pushl $124
  105370:	6a 7c                	push   $0x7c
  jmp alltraps
  105372:	e9 39 f7 ff ff       	jmp    104ab0 <alltraps>

00105377 <vector125>:
.globl vector125
vector125:
  pushl $0
  105377:	6a 00                	push   $0x0
  pushl $125
  105379:	6a 7d                	push   $0x7d
  jmp alltraps
  10537b:	e9 30 f7 ff ff       	jmp    104ab0 <alltraps>

00105380 <vector126>:
.globl vector126
vector126:
  pushl $0
  105380:	6a 00                	push   $0x0
  pushl $126
  105382:	6a 7e                	push   $0x7e
  jmp alltraps
  105384:	e9 27 f7 ff ff       	jmp    104ab0 <alltraps>

00105389 <vector127>:
.globl vector127
vector127:
  pushl $0
  105389:	6a 00                	push   $0x0
  pushl $127
  10538b:	6a 7f                	push   $0x7f
  jmp alltraps
  10538d:	e9 1e f7 ff ff       	jmp    104ab0 <alltraps>

00105392 <vector128>:
.globl vector128
vector128:
  pushl $0
  105392:	6a 00                	push   $0x0
  pushl $128
  105394:	68 80 00 00 00       	push   $0x80
  jmp alltraps
  105399:	e9 12 f7 ff ff       	jmp    104ab0 <alltraps>

0010539e <vector129>:
.globl vector129
vector129:
  pushl $0
  10539e:	6a 00                	push   $0x0
  pushl $129
  1053a0:	68 81 00 00 00       	push   $0x81
  jmp alltraps
  1053a5:	e9 06 f7 ff ff       	jmp    104ab0 <alltraps>

001053aa <vector130>:
.globl vector130
vector130:
  pushl $0
  1053aa:	6a 00                	push   $0x0
  pushl $130
  1053ac:	68 82 00 00 00       	push   $0x82
  jmp alltraps
  1053b1:	e9 fa f6 ff ff       	jmp    104ab0 <alltraps>

001053b6 <vector131>:
.globl vector131
vector131:
  pushl $0
  1053b6:	6a 00                	push   $0x0
  pushl $131
  1053b8:	68 83 00 00 00       	push   $0x83
  jmp alltraps
  1053bd:	e9 ee f6 ff ff       	jmp    104ab0 <alltraps>

001053c2 <vector132>:
.globl vector132
vector132:
  pushl $0
  1053c2:	6a 00                	push   $0x0
  pushl $132
  1053c4:	68 84 00 00 00       	push   $0x84
  jmp alltraps
  1053c9:	e9 e2 f6 ff ff       	jmp    104ab0 <alltraps>

001053ce <vector133>:
.globl vector133
vector133:
  pushl $0
  1053ce:	6a 00                	push   $0x0
  pushl $133
  1053d0:	68 85 00 00 00       	push   $0x85
  jmp alltraps
  1053d5:	e9 d6 f6 ff ff       	jmp    104ab0 <alltraps>

001053da <vector134>:
.globl vector134
vector134:
  pushl $0
  1053da:	6a 00                	push   $0x0
  pushl $134
  1053dc:	68 86 00 00 00       	push   $0x86
  jmp alltraps
  1053e1:	e9 ca f6 ff ff       	jmp    104ab0 <alltraps>

001053e6 <vector135>:
.globl vector135
vector135:
  pushl $0
  1053e6:	6a 00                	push   $0x0
  pushl $135
  1053e8:	68 87 00 00 00       	push   $0x87
  jmp alltraps
  1053ed:	e9 be f6 ff ff       	jmp    104ab0 <alltraps>

001053f2 <vector136>:
.globl vector136
vector136:
  pushl $0
  1053f2:	6a 00                	push   $0x0
  pushl $136
  1053f4:	68 88 00 00 00       	push   $0x88
  jmp alltraps
  1053f9:	e9 b2 f6 ff ff       	jmp    104ab0 <alltraps>

001053fe <vector137>:
.globl vector137
vector137:
  pushl $0
  1053fe:	6a 00                	push   $0x0
  pushl $137
  105400:	68 89 00 00 00       	push   $0x89
  jmp alltraps
  105405:	e9 a6 f6 ff ff       	jmp    104ab0 <alltraps>

0010540a <vector138>:
.globl vector138
vector138:
  pushl $0
  10540a:	6a 00                	push   $0x0
  pushl $138
  10540c:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
  105411:	e9 9a f6 ff ff       	jmp    104ab0 <alltraps>

00105416 <vector139>:
.globl vector139
vector139:
  pushl $0
  105416:	6a 00                	push   $0x0
  pushl $139
  105418:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
  10541d:	e9 8e f6 ff ff       	jmp    104ab0 <alltraps>

00105422 <vector140>:
.globl vector140
vector140:
  pushl $0
  105422:	6a 00                	push   $0x0
  pushl $140
  105424:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
  105429:	e9 82 f6 ff ff       	jmp    104ab0 <alltraps>

0010542e <vector141>:
.globl vector141
vector141:
  pushl $0
  10542e:	6a 00                	push   $0x0
  pushl $141
  105430:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
  105435:	e9 76 f6 ff ff       	jmp    104ab0 <alltraps>

0010543a <vector142>:
.globl vector142
vector142:
  pushl $0
  10543a:	6a 00                	push   $0x0
  pushl $142
  10543c:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
  105441:	e9 6a f6 ff ff       	jmp    104ab0 <alltraps>

00105446 <vector143>:
.globl vector143
vector143:
  pushl $0
  105446:	6a 00                	push   $0x0
  pushl $143
  105448:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
  10544d:	e9 5e f6 ff ff       	jmp    104ab0 <alltraps>

00105452 <vector144>:
.globl vector144
vector144:
  pushl $0
  105452:	6a 00                	push   $0x0
  pushl $144
  105454:	68 90 00 00 00       	push   $0x90
  jmp alltraps
  105459:	e9 52 f6 ff ff       	jmp    104ab0 <alltraps>

0010545e <vector145>:
.globl vector145
vector145:
  pushl $0
  10545e:	6a 00                	push   $0x0
  pushl $145
  105460:	68 91 00 00 00       	push   $0x91
  jmp alltraps
  105465:	e9 46 f6 ff ff       	jmp    104ab0 <alltraps>

0010546a <vector146>:
.globl vector146
vector146:
  pushl $0
  10546a:	6a 00                	push   $0x0
  pushl $146
  10546c:	68 92 00 00 00       	push   $0x92
  jmp alltraps
  105471:	e9 3a f6 ff ff       	jmp    104ab0 <alltraps>

00105476 <vector147>:
.globl vector147
vector147:
  pushl $0
  105476:	6a 00                	push   $0x0
  pushl $147
  105478:	68 93 00 00 00       	push   $0x93
  jmp alltraps
  10547d:	e9 2e f6 ff ff       	jmp    104ab0 <alltraps>

00105482 <vector148>:
.globl vector148
vector148:
  pushl $0
  105482:	6a 00                	push   $0x0
  pushl $148
  105484:	68 94 00 00 00       	push   $0x94
  jmp alltraps
  105489:	e9 22 f6 ff ff       	jmp    104ab0 <alltraps>

0010548e <vector149>:
.globl vector149
vector149:
  pushl $0
  10548e:	6a 00                	push   $0x0
  pushl $149
  105490:	68 95 00 00 00       	push   $0x95
  jmp alltraps
  105495:	e9 16 f6 ff ff       	jmp    104ab0 <alltraps>

0010549a <vector150>:
.globl vector150
vector150:
  pushl $0
  10549a:	6a 00                	push   $0x0
  pushl $150
  10549c:	68 96 00 00 00       	push   $0x96
  jmp alltraps
  1054a1:	e9 0a f6 ff ff       	jmp    104ab0 <alltraps>

001054a6 <vector151>:
.globl vector151
vector151:
  pushl $0
  1054a6:	6a 00                	push   $0x0
  pushl $151
  1054a8:	68 97 00 00 00       	push   $0x97
  jmp alltraps
  1054ad:	e9 fe f5 ff ff       	jmp    104ab0 <alltraps>

001054b2 <vector152>:
.globl vector152
vector152:
  pushl $0
  1054b2:	6a 00                	push   $0x0
  pushl $152
  1054b4:	68 98 00 00 00       	push   $0x98
  jmp alltraps
  1054b9:	e9 f2 f5 ff ff       	jmp    104ab0 <alltraps>

001054be <vector153>:
.globl vector153
vector153:
  pushl $0
  1054be:	6a 00                	push   $0x0
  pushl $153
  1054c0:	68 99 00 00 00       	push   $0x99
  jmp alltraps
  1054c5:	e9 e6 f5 ff ff       	jmp    104ab0 <alltraps>

001054ca <vector154>:
.globl vector154
vector154:
  pushl $0
  1054ca:	6a 00                	push   $0x0
  pushl $154
  1054cc:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
  1054d1:	e9 da f5 ff ff       	jmp    104ab0 <alltraps>

001054d6 <vector155>:
.globl vector155
vector155:
  pushl $0
  1054d6:	6a 00                	push   $0x0
  pushl $155
  1054d8:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
  1054dd:	e9 ce f5 ff ff       	jmp    104ab0 <alltraps>

001054e2 <vector156>:
.globl vector156
vector156:
  pushl $0
  1054e2:	6a 00                	push   $0x0
  pushl $156
  1054e4:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
  1054e9:	e9 c2 f5 ff ff       	jmp    104ab0 <alltraps>

001054ee <vector157>:
.globl vector157
vector157:
  pushl $0
  1054ee:	6a 00                	push   $0x0
  pushl $157
  1054f0:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
  1054f5:	e9 b6 f5 ff ff       	jmp    104ab0 <alltraps>

001054fa <vector158>:
.globl vector158
vector158:
  pushl $0
  1054fa:	6a 00                	push   $0x0
  pushl $158
  1054fc:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
  105501:	e9 aa f5 ff ff       	jmp    104ab0 <alltraps>

00105506 <vector159>:
.globl vector159
vector159:
  pushl $0
  105506:	6a 00                	push   $0x0
  pushl $159
  105508:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
  10550d:	e9 9e f5 ff ff       	jmp    104ab0 <alltraps>

00105512 <vector160>:
.globl vector160
vector160:
  pushl $0
  105512:	6a 00                	push   $0x0
  pushl $160
  105514:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
  105519:	e9 92 f5 ff ff       	jmp    104ab0 <alltraps>

0010551e <vector161>:
.globl vector161
vector161:
  pushl $0
  10551e:	6a 00                	push   $0x0
  pushl $161
  105520:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
  105525:	e9 86 f5 ff ff       	jmp    104ab0 <alltraps>

0010552a <vector162>:
.globl vector162
vector162:
  pushl $0
  10552a:	6a 00                	push   $0x0
  pushl $162
  10552c:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
  105531:	e9 7a f5 ff ff       	jmp    104ab0 <alltraps>

00105536 <vector163>:
.globl vector163
vector163:
  pushl $0
  105536:	6a 00                	push   $0x0
  pushl $163
  105538:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
  10553d:	e9 6e f5 ff ff       	jmp    104ab0 <alltraps>

00105542 <vector164>:
.globl vector164
vector164:
  pushl $0
  105542:	6a 00                	push   $0x0
  pushl $164
  105544:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
  105549:	e9 62 f5 ff ff       	jmp    104ab0 <alltraps>

0010554e <vector165>:
.globl vector165
vector165:
  pushl $0
  10554e:	6a 00                	push   $0x0
  pushl $165
  105550:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
  105555:	e9 56 f5 ff ff       	jmp    104ab0 <alltraps>

0010555a <vector166>:
.globl vector166
vector166:
  pushl $0
  10555a:	6a 00                	push   $0x0
  pushl $166
  10555c:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
  105561:	e9 4a f5 ff ff       	jmp    104ab0 <alltraps>

00105566 <vector167>:
.globl vector167
vector167:
  pushl $0
  105566:	6a 00                	push   $0x0
  pushl $167
  105568:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
  10556d:	e9 3e f5 ff ff       	jmp    104ab0 <alltraps>

00105572 <vector168>:
.globl vector168
vector168:
  pushl $0
  105572:	6a 00                	push   $0x0
  pushl $168
  105574:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
  105579:	e9 32 f5 ff ff       	jmp    104ab0 <alltraps>

0010557e <vector169>:
.globl vector169
vector169:
  pushl $0
  10557e:	6a 00                	push   $0x0
  pushl $169
  105580:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
  105585:	e9 26 f5 ff ff       	jmp    104ab0 <alltraps>

0010558a <vector170>:
.globl vector170
vector170:
  pushl $0
  10558a:	6a 00                	push   $0x0
  pushl $170
  10558c:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
  105591:	e9 1a f5 ff ff       	jmp    104ab0 <alltraps>

00105596 <vector171>:
.globl vector171
vector171:
  pushl $0
  105596:	6a 00                	push   $0x0
  pushl $171
  105598:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
  10559d:	e9 0e f5 ff ff       	jmp    104ab0 <alltraps>

001055a2 <vector172>:
.globl vector172
vector172:
  pushl $0
  1055a2:	6a 00                	push   $0x0
  pushl $172
  1055a4:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
  1055a9:	e9 02 f5 ff ff       	jmp    104ab0 <alltraps>

001055ae <vector173>:
.globl vector173
vector173:
  pushl $0
  1055ae:	6a 00                	push   $0x0
  pushl $173
  1055b0:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
  1055b5:	e9 f6 f4 ff ff       	jmp    104ab0 <alltraps>

001055ba <vector174>:
.globl vector174
vector174:
  pushl $0
  1055ba:	6a 00                	push   $0x0
  pushl $174
  1055bc:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
  1055c1:	e9 ea f4 ff ff       	jmp    104ab0 <alltraps>

001055c6 <vector175>:
.globl vector175
vector175:
  pushl $0
  1055c6:	6a 00                	push   $0x0
  pushl $175
  1055c8:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
  1055cd:	e9 de f4 ff ff       	jmp    104ab0 <alltraps>

001055d2 <vector176>:
.globl vector176
vector176:
  pushl $0
  1055d2:	6a 00                	push   $0x0
  pushl $176
  1055d4:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
  1055d9:	e9 d2 f4 ff ff       	jmp    104ab0 <alltraps>

001055de <vector177>:
.globl vector177
vector177:
  pushl $0
  1055de:	6a 00                	push   $0x0
  pushl $177
  1055e0:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
  1055e5:	e9 c6 f4 ff ff       	jmp    104ab0 <alltraps>

001055ea <vector178>:
.globl vector178
vector178:
  pushl $0
  1055ea:	6a 00                	push   $0x0
  pushl $178
  1055ec:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
  1055f1:	e9 ba f4 ff ff       	jmp    104ab0 <alltraps>

001055f6 <vector179>:
.globl vector179
vector179:
  pushl $0
  1055f6:	6a 00                	push   $0x0
  pushl $179
  1055f8:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
  1055fd:	e9 ae f4 ff ff       	jmp    104ab0 <alltraps>

00105602 <vector180>:
.globl vector180
vector180:
  pushl $0
  105602:	6a 00                	push   $0x0
  pushl $180
  105604:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
  105609:	e9 a2 f4 ff ff       	jmp    104ab0 <alltraps>

0010560e <vector181>:
.globl vector181
vector181:
  pushl $0
  10560e:	6a 00                	push   $0x0
  pushl $181
  105610:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
  105615:	e9 96 f4 ff ff       	jmp    104ab0 <alltraps>

0010561a <vector182>:
.globl vector182
vector182:
  pushl $0
  10561a:	6a 00                	push   $0x0
  pushl $182
  10561c:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
  105621:	e9 8a f4 ff ff       	jmp    104ab0 <alltraps>

00105626 <vector183>:
.globl vector183
vector183:
  pushl $0
  105626:	6a 00                	push   $0x0
  pushl $183
  105628:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
  10562d:	e9 7e f4 ff ff       	jmp    104ab0 <alltraps>

00105632 <vector184>:
.globl vector184
vector184:
  pushl $0
  105632:	6a 00                	push   $0x0
  pushl $184
  105634:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
  105639:	e9 72 f4 ff ff       	jmp    104ab0 <alltraps>

0010563e <vector185>:
.globl vector185
vector185:
  pushl $0
  10563e:	6a 00                	push   $0x0
  pushl $185
  105640:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
  105645:	e9 66 f4 ff ff       	jmp    104ab0 <alltraps>

0010564a <vector186>:
.globl vector186
vector186:
  pushl $0
  10564a:	6a 00                	push   $0x0
  pushl $186
  10564c:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
  105651:	e9 5a f4 ff ff       	jmp    104ab0 <alltraps>

00105656 <vector187>:
.globl vector187
vector187:
  pushl $0
  105656:	6a 00                	push   $0x0
  pushl $187
  105658:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
  10565d:	e9 4e f4 ff ff       	jmp    104ab0 <alltraps>

00105662 <vector188>:
.globl vector188
vector188:
  pushl $0
  105662:	6a 00                	push   $0x0
  pushl $188
  105664:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
  105669:	e9 42 f4 ff ff       	jmp    104ab0 <alltraps>

0010566e <vector189>:
.globl vector189
vector189:
  pushl $0
  10566e:	6a 00                	push   $0x0
  pushl $189
  105670:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
  105675:	e9 36 f4 ff ff       	jmp    104ab0 <alltraps>

0010567a <vector190>:
.globl vector190
vector190:
  pushl $0
  10567a:	6a 00                	push   $0x0
  pushl $190
  10567c:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
  105681:	e9 2a f4 ff ff       	jmp    104ab0 <alltraps>

00105686 <vector191>:
.globl vector191
vector191:
  pushl $0
  105686:	6a 00                	push   $0x0
  pushl $191
  105688:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
  10568d:	e9 1e f4 ff ff       	jmp    104ab0 <alltraps>

00105692 <vector192>:
.globl vector192
vector192:
  pushl $0
  105692:	6a 00                	push   $0x0
  pushl $192
  105694:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
  105699:	e9 12 f4 ff ff       	jmp    104ab0 <alltraps>

0010569e <vector193>:
.globl vector193
vector193:
  pushl $0
  10569e:	6a 00                	push   $0x0
  pushl $193
  1056a0:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
  1056a5:	e9 06 f4 ff ff       	jmp    104ab0 <alltraps>

001056aa <vector194>:
.globl vector194
vector194:
  pushl $0
  1056aa:	6a 00                	push   $0x0
  pushl $194
  1056ac:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
  1056b1:	e9 fa f3 ff ff       	jmp    104ab0 <alltraps>

001056b6 <vector195>:
.globl vector195
vector195:
  pushl $0
  1056b6:	6a 00                	push   $0x0
  pushl $195
  1056b8:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
  1056bd:	e9 ee f3 ff ff       	jmp    104ab0 <alltraps>

001056c2 <vector196>:
.globl vector196
vector196:
  pushl $0
  1056c2:	6a 00                	push   $0x0
  pushl $196
  1056c4:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
  1056c9:	e9 e2 f3 ff ff       	jmp    104ab0 <alltraps>

001056ce <vector197>:
.globl vector197
vector197:
  pushl $0
  1056ce:	6a 00                	push   $0x0
  pushl $197
  1056d0:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
  1056d5:	e9 d6 f3 ff ff       	jmp    104ab0 <alltraps>

001056da <vector198>:
.globl vector198
vector198:
  pushl $0
  1056da:	6a 00                	push   $0x0
  pushl $198
  1056dc:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
  1056e1:	e9 ca f3 ff ff       	jmp    104ab0 <alltraps>

001056e6 <vector199>:
.globl vector199
vector199:
  pushl $0
  1056e6:	6a 00                	push   $0x0
  pushl $199
  1056e8:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
  1056ed:	e9 be f3 ff ff       	jmp    104ab0 <alltraps>

001056f2 <vector200>:
.globl vector200
vector200:
  pushl $0
  1056f2:	6a 00                	push   $0x0
  pushl $200
  1056f4:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
  1056f9:	e9 b2 f3 ff ff       	jmp    104ab0 <alltraps>

001056fe <vector201>:
.globl vector201
vector201:
  pushl $0
  1056fe:	6a 00                	push   $0x0
  pushl $201
  105700:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
  105705:	e9 a6 f3 ff ff       	jmp    104ab0 <alltraps>

0010570a <vector202>:
.globl vector202
vector202:
  pushl $0
  10570a:	6a 00                	push   $0x0
  pushl $202
  10570c:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
  105711:	e9 9a f3 ff ff       	jmp    104ab0 <alltraps>

00105716 <vector203>:
.globl vector203
vector203:
  pushl $0
  105716:	6a 00                	push   $0x0
  pushl $203
  105718:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
  10571d:	e9 8e f3 ff ff       	jmp    104ab0 <alltraps>

00105722 <vector204>:
.globl vector204
vector204:
  pushl $0
  105722:	6a 00                	push   $0x0
  pushl $204
  105724:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
  105729:	e9 82 f3 ff ff       	jmp    104ab0 <alltraps>

0010572e <vector205>:
.globl vector205
vector205:
  pushl $0
  10572e:	6a 00                	push   $0x0
  pushl $205
  105730:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
  105735:	e9 76 f3 ff ff       	jmp    104ab0 <alltraps>

0010573a <vector206>:
.globl vector206
vector206:
  pushl $0
  10573a:	6a 00                	push   $0x0
  pushl $206
  10573c:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
  105741:	e9 6a f3 ff ff       	jmp    104ab0 <alltraps>

00105746 <vector207>:
.globl vector207
vector207:
  pushl $0
  105746:	6a 00                	push   $0x0
  pushl $207
  105748:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
  10574d:	e9 5e f3 ff ff       	jmp    104ab0 <alltraps>

00105752 <vector208>:
.globl vector208
vector208:
  pushl $0
  105752:	6a 00                	push   $0x0
  pushl $208
  105754:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
  105759:	e9 52 f3 ff ff       	jmp    104ab0 <alltraps>

0010575e <vector209>:
.globl vector209
vector209:
  pushl $0
  10575e:	6a 00                	push   $0x0
  pushl $209
  105760:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
  105765:	e9 46 f3 ff ff       	jmp    104ab0 <alltraps>

0010576a <vector210>:
.globl vector210
vector210:
  pushl $0
  10576a:	6a 00                	push   $0x0
  pushl $210
  10576c:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
  105771:	e9 3a f3 ff ff       	jmp    104ab0 <alltraps>

00105776 <vector211>:
.globl vector211
vector211:
  pushl $0
  105776:	6a 00                	push   $0x0
  pushl $211
  105778:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
  10577d:	e9 2e f3 ff ff       	jmp    104ab0 <alltraps>

00105782 <vector212>:
.globl vector212
vector212:
  pushl $0
  105782:	6a 00                	push   $0x0
  pushl $212
  105784:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
  105789:	e9 22 f3 ff ff       	jmp    104ab0 <alltraps>

0010578e <vector213>:
.globl vector213
vector213:
  pushl $0
  10578e:	6a 00                	push   $0x0
  pushl $213
  105790:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
  105795:	e9 16 f3 ff ff       	jmp    104ab0 <alltraps>

0010579a <vector214>:
.globl vector214
vector214:
  pushl $0
  10579a:	6a 00                	push   $0x0
  pushl $214
  10579c:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
  1057a1:	e9 0a f3 ff ff       	jmp    104ab0 <alltraps>

001057a6 <vector215>:
.globl vector215
vector215:
  pushl $0
  1057a6:	6a 00                	push   $0x0
  pushl $215
  1057a8:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
  1057ad:	e9 fe f2 ff ff       	jmp    104ab0 <alltraps>

001057b2 <vector216>:
.globl vector216
vector216:
  pushl $0
  1057b2:	6a 00                	push   $0x0
  pushl $216
  1057b4:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
  1057b9:	e9 f2 f2 ff ff       	jmp    104ab0 <alltraps>

001057be <vector217>:
.globl vector217
vector217:
  pushl $0
  1057be:	6a 00                	push   $0x0
  pushl $217
  1057c0:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
  1057c5:	e9 e6 f2 ff ff       	jmp    104ab0 <alltraps>

001057ca <vector218>:
.globl vector218
vector218:
  pushl $0
  1057ca:	6a 00                	push   $0x0
  pushl $218
  1057cc:	68 da 00 00 00       	push   $0xda
  jmp alltraps
  1057d1:	e9 da f2 ff ff       	jmp    104ab0 <alltraps>

001057d6 <vector219>:
.globl vector219
vector219:
  pushl $0
  1057d6:	6a 00                	push   $0x0
  pushl $219
  1057d8:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
  1057dd:	e9 ce f2 ff ff       	jmp    104ab0 <alltraps>

001057e2 <vector220>:
.globl vector220
vector220:
  pushl $0
  1057e2:	6a 00                	push   $0x0
  pushl $220
  1057e4:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
  1057e9:	e9 c2 f2 ff ff       	jmp    104ab0 <alltraps>

001057ee <vector221>:
.globl vector221
vector221:
  pushl $0
  1057ee:	6a 00                	push   $0x0
  pushl $221
  1057f0:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
  1057f5:	e9 b6 f2 ff ff       	jmp    104ab0 <alltraps>

001057fa <vector222>:
.globl vector222
vector222:
  pushl $0
  1057fa:	6a 00                	push   $0x0
  pushl $222
  1057fc:	68 de 00 00 00       	push   $0xde
  jmp alltraps
  105801:	e9 aa f2 ff ff       	jmp    104ab0 <alltraps>

00105806 <vector223>:
.globl vector223
vector223:
  pushl $0
  105806:	6a 00                	push   $0x0
  pushl $223
  105808:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
  10580d:	e9 9e f2 ff ff       	jmp    104ab0 <alltraps>

00105812 <vector224>:
.globl vector224
vector224:
  pushl $0
  105812:	6a 00                	push   $0x0
  pushl $224
  105814:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
  105819:	e9 92 f2 ff ff       	jmp    104ab0 <alltraps>

0010581e <vector225>:
.globl vector225
vector225:
  pushl $0
  10581e:	6a 00                	push   $0x0
  pushl $225
  105820:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
  105825:	e9 86 f2 ff ff       	jmp    104ab0 <alltraps>

0010582a <vector226>:
.globl vector226
vector226:
  pushl $0
  10582a:	6a 00                	push   $0x0
  pushl $226
  10582c:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
  105831:	e9 7a f2 ff ff       	jmp    104ab0 <alltraps>

00105836 <vector227>:
.globl vector227
vector227:
  pushl $0
  105836:	6a 00                	push   $0x0
  pushl $227
  105838:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
  10583d:	e9 6e f2 ff ff       	jmp    104ab0 <alltraps>

00105842 <vector228>:
.globl vector228
vector228:
  pushl $0
  105842:	6a 00                	push   $0x0
  pushl $228
  105844:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
  105849:	e9 62 f2 ff ff       	jmp    104ab0 <alltraps>

0010584e <vector229>:
.globl vector229
vector229:
  pushl $0
  10584e:	6a 00                	push   $0x0
  pushl $229
  105850:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
  105855:	e9 56 f2 ff ff       	jmp    104ab0 <alltraps>

0010585a <vector230>:
.globl vector230
vector230:
  pushl $0
  10585a:	6a 00                	push   $0x0
  pushl $230
  10585c:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
  105861:	e9 4a f2 ff ff       	jmp    104ab0 <alltraps>

00105866 <vector231>:
.globl vector231
vector231:
  pushl $0
  105866:	6a 00                	push   $0x0
  pushl $231
  105868:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
  10586d:	e9 3e f2 ff ff       	jmp    104ab0 <alltraps>

00105872 <vector232>:
.globl vector232
vector232:
  pushl $0
  105872:	6a 00                	push   $0x0
  pushl $232
  105874:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
  105879:	e9 32 f2 ff ff       	jmp    104ab0 <alltraps>

0010587e <vector233>:
.globl vector233
vector233:
  pushl $0
  10587e:	6a 00                	push   $0x0
  pushl $233
  105880:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
  105885:	e9 26 f2 ff ff       	jmp    104ab0 <alltraps>

0010588a <vector234>:
.globl vector234
vector234:
  pushl $0
  10588a:	6a 00                	push   $0x0
  pushl $234
  10588c:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
  105891:	e9 1a f2 ff ff       	jmp    104ab0 <alltraps>

00105896 <vector235>:
.globl vector235
vector235:
  pushl $0
  105896:	6a 00                	push   $0x0
  pushl $235
  105898:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
  10589d:	e9 0e f2 ff ff       	jmp    104ab0 <alltraps>

001058a2 <vector236>:
.globl vector236
vector236:
  pushl $0
  1058a2:	6a 00                	push   $0x0
  pushl $236
  1058a4:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
  1058a9:	e9 02 f2 ff ff       	jmp    104ab0 <alltraps>

001058ae <vector237>:
.globl vector237
vector237:
  pushl $0
  1058ae:	6a 00                	push   $0x0
  pushl $237
  1058b0:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
  1058b5:	e9 f6 f1 ff ff       	jmp    104ab0 <alltraps>

001058ba <vector238>:
.globl vector238
vector238:
  pushl $0
  1058ba:	6a 00                	push   $0x0
  pushl $238
  1058bc:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
  1058c1:	e9 ea f1 ff ff       	jmp    104ab0 <alltraps>

001058c6 <vector239>:
.globl vector239
vector239:
  pushl $0
  1058c6:	6a 00                	push   $0x0
  pushl $239
  1058c8:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
  1058cd:	e9 de f1 ff ff       	jmp    104ab0 <alltraps>

001058d2 <vector240>:
.globl vector240
vector240:
  pushl $0
  1058d2:	6a 00                	push   $0x0
  pushl $240
  1058d4:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
  1058d9:	e9 d2 f1 ff ff       	jmp    104ab0 <alltraps>

001058de <vector241>:
.globl vector241
vector241:
  pushl $0
  1058de:	6a 00                	push   $0x0
  pushl $241
  1058e0:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
  1058e5:	e9 c6 f1 ff ff       	jmp    104ab0 <alltraps>

001058ea <vector242>:
.globl vector242
vector242:
  pushl $0
  1058ea:	6a 00                	push   $0x0
  pushl $242
  1058ec:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
  1058f1:	e9 ba f1 ff ff       	jmp    104ab0 <alltraps>

001058f6 <vector243>:
.globl vector243
vector243:
  pushl $0
  1058f6:	6a 00                	push   $0x0
  pushl $243
  1058f8:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
  1058fd:	e9 ae f1 ff ff       	jmp    104ab0 <alltraps>

00105902 <vector244>:
.globl vector244
vector244:
  pushl $0
  105902:	6a 00                	push   $0x0
  pushl $244
  105904:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
  105909:	e9 a2 f1 ff ff       	jmp    104ab0 <alltraps>

0010590e <vector245>:
.globl vector245
vector245:
  pushl $0
  10590e:	6a 00                	push   $0x0
  pushl $245
  105910:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
  105915:	e9 96 f1 ff ff       	jmp    104ab0 <alltraps>

0010591a <vector246>:
.globl vector246
vector246:
  pushl $0
  10591a:	6a 00                	push   $0x0
  pushl $246
  10591c:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
  105921:	e9 8a f1 ff ff       	jmp    104ab0 <alltraps>

00105926 <vector247>:
.globl vector247
vector247:
  pushl $0
  105926:	6a 00                	push   $0x0
  pushl $247
  105928:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
  10592d:	e9 7e f1 ff ff       	jmp    104ab0 <alltraps>

00105932 <vector248>:
.globl vector248
vector248:
  pushl $0
  105932:	6a 00                	push   $0x0
  pushl $248
  105934:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
  105939:	e9 72 f1 ff ff       	jmp    104ab0 <alltraps>

0010593e <vector249>:
.globl vector249
vector249:
  pushl $0
  10593e:	6a 00                	push   $0x0
  pushl $249
  105940:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
  105945:	e9 66 f1 ff ff       	jmp    104ab0 <alltraps>

0010594a <vector250>:
.globl vector250
vector250:
  pushl $0
  10594a:	6a 00                	push   $0x0
  pushl $250
  10594c:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
  105951:	e9 5a f1 ff ff       	jmp    104ab0 <alltraps>

00105956 <vector251>:
.globl vector251
vector251:
  pushl $0
  105956:	6a 00                	push   $0x0
  pushl $251
  105958:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
  10595d:	e9 4e f1 ff ff       	jmp    104ab0 <alltraps>

00105962 <vector252>:
.globl vector252
vector252:
  pushl $0
  105962:	6a 00                	push   $0x0
  pushl $252
  105964:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
  105969:	e9 42 f1 ff ff       	jmp    104ab0 <alltraps>

0010596e <vector253>:
.globl vector253
vector253:
  pushl $0
  10596e:	6a 00                	push   $0x0
  pushl $253
  105970:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
  105975:	e9 36 f1 ff ff       	jmp    104ab0 <alltraps>

0010597a <vector254>:
.globl vector254
vector254:
  pushl $0
  10597a:	6a 00                	push   $0x0
  pushl $254
  10597c:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
  105981:	e9 2a f1 ff ff       	jmp    104ab0 <alltraps>

00105986 <vector255>:
.globl vector255
vector255:
  pushl $0
  105986:	6a 00                	push   $0x0
  pushl $255
  105988:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
  10598d:	e9 1e f1 ff ff       	jmp    104ab0 <alltraps>
  105992:	90                   	nop    
  105993:	90                   	nop    
  105994:	90                   	nop    
  105995:	90                   	nop    
  105996:	90                   	nop    
  105997:	90                   	nop    
  105998:	90                   	nop    
  105999:	90                   	nop    
  10599a:	90                   	nop    
  10599b:	90                   	nop    
  10599c:	90                   	nop    
  10599d:	90                   	nop    
  10599e:	90                   	nop    
  10599f:	90                   	nop    

001059a0 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm()
{
  1059a0:	55                   	push   %ebp
}

static inline void
lcr3(uint val) 
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
  1059a1:	a1 50 78 10 00       	mov    0x107850,%eax
  1059a6:	89 e5                	mov    %esp,%ebp
  1059a8:	0f 22 d8             	mov    %eax,%cr3
  lcr3(PADDR(kpgdir));   // switch to the kernel page table
}
  1059ab:	5d                   	pop    %ebp
  1059ac:	c3                   	ret    
  1059ad:	8d 76 00             	lea    0x0(%esi),%esi

001059b0 <vmenable>:
}

// Turn on paging.
void
vmenable(void)
{
  1059b0:	55                   	push   %ebp
  1059b1:	89 e5                	mov    %esp,%ebp
  uint cr0;

  switchkvm(); // load kpgdir into cr3
  1059b3:	e8 e8 ff ff ff       	call   1059a0 <switchkvm>

static inline uint
rcr0(void)
{
  uint val;
  asm volatile("movl %%cr0,%0" : "=r" (val));
  1059b8:	0f 20 c0             	mov    %cr0,%eax
}

static inline void
lcr0(uint val)
{
  asm volatile("movl %0,%%cr0" : : "r" (val));
  1059bb:	0d 00 00 00 80       	or     $0x80000000,%eax
  1059c0:	0f 22 c0             	mov    %eax,%cr0
  cr0 = rcr0();
  cr0 |= CR0_PG;
  lcr0(cr0);
}
  1059c3:	5d                   	pop    %ebp
  1059c4:	c3                   	ret    
  1059c5:	8d 74 26 00          	lea    0x0(%esi),%esi
  1059c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001059d0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to linear address va.  If create!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int create)
{
  1059d0:	55                   	push   %ebp
  1059d1:	89 e5                	mov    %esp,%ebp
  1059d3:	83 ec 18             	sub    $0x18,%esp
  1059d6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  1059d9:	89 d3                	mov    %edx,%ebx
  uint r;
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  1059db:	c1 ea 16             	shr    $0x16,%edx
// Return the address of the PTE in page table pgdir
// that corresponds to linear address va.  If create!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int create)
{
  1059de:	89 7d fc             	mov    %edi,-0x4(%ebp)
  uint r;
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  1059e1:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to linear address va.  If create!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int create)
{
  1059e4:	89 75 f8             	mov    %esi,-0x8(%ebp)
  uint r;
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
  1059e7:	8b 07                	mov    (%edi),%eax
  1059e9:	a8 01                	test   $0x1,%al
  1059eb:	74 21                	je     105a0e <walkpgdir+0x3e>
    pgtab = (pte_t*) PTE_ADDR(*pde);
  1059ed:	89 c6                	mov    %eax,%esi
  1059ef:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = PADDR(r) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
  1059f5:	c1 eb 0a             	shr    $0xa,%ebx
  1059f8:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
  1059fe:	8d 04 33             	lea    (%ebx,%esi,1),%eax
}
  105a01:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  105a04:	8b 75 f8             	mov    -0x8(%ebp),%esi
  105a07:	8b 7d fc             	mov    -0x4(%ebp),%edi
  105a0a:	89 ec                	mov    %ebp,%esp
  105a0c:	5d                   	pop    %ebp
  105a0d:	c3                   	ret    
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*) PTE_ADDR(*pde);
  } else if(!create || !(r = (uint) kalloc()))
  105a0e:	85 c9                	test   %ecx,%ecx
  105a10:	75 04                	jne    105a16 <walkpgdir+0x46>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = PADDR(r) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
  105a12:	31 c0                	xor    %eax,%eax
  105a14:	eb eb                	jmp    105a01 <walkpgdir+0x31>
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*) PTE_ADDR(*pde);
  } else if(!create || !(r = (uint) kalloc()))
  105a16:	e8 95 c7 ff ff       	call   1021b0 <kalloc>
  105a1b:	85 c0                	test   %eax,%eax
  105a1d:	8d 76 00             	lea    0x0(%esi),%esi
  105a20:	74 f0                	je     105a12 <walkpgdir+0x42>
    return 0;
  else {
    pgtab = (pte_t*) r;
  105a22:	89 c6                	mov    %eax,%esi
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
  105a24:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  105a2b:	00 
  105a2c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  105a33:	00 
  105a34:	89 04 24             	mov    %eax,(%esp)
  105a37:	e8 44 e0 ff ff       	call   103a80 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = PADDR(r) | PTE_P | PTE_W | PTE_U;
  105a3c:	89 f0                	mov    %esi,%eax
  105a3e:	83 c8 07             	or     $0x7,%eax
  105a41:	89 07                	mov    %eax,(%edi)
  105a43:	eb b0                	jmp    1059f5 <walkpgdir+0x25>
  105a45:	8d 74 26 00          	lea    0x0(%esi),%esi
  105a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00105a50 <uva2ka>:
// maps to.  The result is also a kernel logical address,
// since the kernel maps the physical memory allocated to user
// processes directly.
char*
uva2ka(pde_t *pgdir, char *uva)
{    
  105a50:	55                   	push   %ebp
  pte_t *pte = walkpgdir(pgdir, uva, 0);
  105a51:	31 c9                	xor    %ecx,%ecx
// maps to.  The result is also a kernel logical address,
// since the kernel maps the physical memory allocated to user
// processes directly.
char*
uva2ka(pde_t *pgdir, char *uva)
{    
  105a53:	89 e5                	mov    %esp,%ebp
  105a55:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte = walkpgdir(pgdir, uva, 0);
  105a58:	8b 55 0c             	mov    0xc(%ebp),%edx
  105a5b:	8b 45 08             	mov    0x8(%ebp),%eax
  105a5e:	e8 6d ff ff ff       	call   1059d0 <walkpgdir>
  if(pte == 0) return 0;
  105a63:	31 d2                	xor    %edx,%edx
  105a65:	85 c0                	test   %eax,%eax
  105a67:	74 08                	je     105a71 <uva2ka+0x21>
  uint pa = PTE_ADDR(*pte);
  return (char *)pa;
  105a69:	8b 10                	mov    (%eax),%edx
  105a6b:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
}
  105a71:	c9                   	leave  
  105a72:	89 d0                	mov    %edx,%eax
  105a74:	c3                   	ret    
  105a75:	8d 74 26 00          	lea    0x0(%esi),%esi
  105a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00105a80 <mappages>:
// Create PTEs for linear addresses starting at la that refer to
// physical addresses starting at pa. la and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *la, uint size, uint pa, int perm)
{
  105a80:	55                   	push   %ebp
  105a81:	89 e5                	mov    %esp,%ebp
  105a83:	57                   	push   %edi
  105a84:	56                   	push   %esi
  105a85:	53                   	push   %ebx
  char *a = PGROUNDDOWN(la);
  105a86:	89 d3                	mov    %edx,%ebx
// Create PTEs for linear addresses starting at la that refer to
// physical addresses starting at pa. la and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *la, uint size, uint pa, int perm)
{
  105a88:	83 ec 0c             	sub    $0xc,%esp
  105a8b:	8b 75 08             	mov    0x8(%ebp),%esi
  char *a = PGROUNDDOWN(la);
  105a8e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for linear addresses starting at la that refer to
// physical addresses starting at pa. la and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *la, uint size, uint pa, int perm)
{
  105a94:	89 45 f0             	mov    %eax,-0x10(%ebp)
    pte_t *pte = walkpgdir(pgdir, a, 1);
    if(pte == 0)
      return 0;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
  105a97:	8b 45 0c             	mov    0xc(%ebp),%eax
// be page-aligned.
static int
mappages(pde_t *pgdir, void *la, uint size, uint pa, int perm)
{
  char *a = PGROUNDDOWN(la);
  char *last = PGROUNDDOWN(la + size - 1);
  105a9a:	8d 7c 0a ff          	lea    -0x1(%edx,%ecx,1),%edi
  105a9e:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pte_t *pte = walkpgdir(pgdir, a, 1);
    if(pte == 0)
      return 0;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
  105aa4:	83 c8 01             	or     $0x1,%eax
  105aa7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  105aaa:	eb 20                	jmp    105acc <mappages+0x4c>
  105aac:	8d 74 26 00          	lea    0x0(%esi),%esi

  while(1){
    pte_t *pte = walkpgdir(pgdir, a, 1);
    if(pte == 0)
      return 0;
    if(*pte & PTE_P)
  105ab0:	f6 00 01             	testb  $0x1,(%eax)
  105ab3:	75 43                	jne    105af8 <mappages+0x78>
      panic("remap");
    *pte = pa | perm | PTE_P;
  105ab5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  105ab8:	09 f0                	or     %esi,%eax
    if(a == last)
  105aba:	39 fb                	cmp    %edi,%ebx
    pte_t *pte = walkpgdir(pgdir, a, 1);
    if(pte == 0)
      return 0;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
  105abc:	89 02                	mov    %eax,(%edx)
    if(a == last)
  105abe:	74 2b                	je     105aeb <mappages+0x6b>
      break;
    a += PGSIZE;
  105ac0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    pa += PGSIZE;
  105ac6:	81 c6 00 10 00 00    	add    $0x1000,%esi
{
  char *a = PGROUNDDOWN(la);
  char *last = PGROUNDDOWN(la + size - 1);

  while(1){
    pte_t *pte = walkpgdir(pgdir, a, 1);
  105acc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105acf:	89 da                	mov    %ebx,%edx
  105ad1:	b9 01 00 00 00       	mov    $0x1,%ecx
  105ad6:	e8 f5 fe ff ff       	call   1059d0 <walkpgdir>
    if(pte == 0)
  105adb:	85 c0                	test   %eax,%eax
{
  char *a = PGROUNDDOWN(la);
  char *last = PGROUNDDOWN(la + size - 1);

  while(1){
    pte_t *pte = walkpgdir(pgdir, a, 1);
  105add:	89 c2                	mov    %eax,%edx
    if(pte == 0)
  105adf:	75 cf                	jne    105ab0 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 1;
}
  105ae1:	83 c4 0c             	add    $0xc,%esp
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  105ae4:	31 c0                	xor    %eax,%eax
  return 1;
}
  105ae6:	5b                   	pop    %ebx
  105ae7:	5e                   	pop    %esi
  105ae8:	5f                   	pop    %edi
  105ae9:	5d                   	pop    %ebp
  105aea:	c3                   	ret    
  105aeb:	83 c4 0c             	add    $0xc,%esp
    if(pte == 0)
      return 0;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
  105aee:	b8 01 00 00 00       	mov    $0x1,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 1;
}
  105af3:	5b                   	pop    %ebx
  105af4:	5e                   	pop    %esi
  105af5:	5f                   	pop    %edi
  105af6:	5d                   	pop    %ebp
  105af7:	c3                   	ret    
  while(1){
    pte_t *pte = walkpgdir(pgdir, a, 1);
    if(pte == 0)
      return 0;
    if(*pte & PTE_P)
      panic("remap");
  105af8:	c7 04 24 cc 69 10 00 	movl   $0x1069cc,(%esp)
  105aff:	e8 7c ad ff ff       	call   100880 <panic>
  105b04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105b0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105b10 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
  105b10:	55                   	push   %ebp
  105b11:	89 e5                	mov    %esp,%ebp
  105b13:	83 ec 28             	sub    $0x28,%esp
  105b16:	8b 45 0c             	mov    0xc(%ebp),%eax
  105b19:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  105b1c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  105b1f:	8b 75 10             	mov    0x10(%ebp),%esi
  105b22:	89 7d fc             	mov    %edi,-0x4(%ebp)
  105b25:	8b 7d 08             	mov    0x8(%ebp),%edi
  105b28:	89 45 f0             	mov    %eax,-0x10(%ebp)
  char *mem = kalloc();
  105b2b:	e8 80 c6 ff ff       	call   1021b0 <kalloc>
  if (sz >= PGSIZE)
  105b30:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem = kalloc();
  105b36:	89 c3                	mov    %eax,%ebx
  if (sz >= PGSIZE)
  105b38:	77 4e                	ja     105b88 <inituvm+0x78>
    panic("inituvm: more than a page");
  memset(mem, 0, PGSIZE);
  105b3a:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  105b41:	00 
  105b42:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  105b49:	00 
  105b4a:	89 04 24             	mov    %eax,(%esp)
  105b4d:	e8 2e df ff ff       	call   103a80 <memset>
  mappages(pgdir, 0, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  105b52:	89 f8                	mov    %edi,%eax
  105b54:	b9 00 10 00 00       	mov    $0x1000,%ecx
  105b59:	89 1c 24             	mov    %ebx,(%esp)
  105b5c:	31 d2                	xor    %edx,%edx
  105b5e:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
  105b65:	00 
  105b66:	e8 15 ff ff ff       	call   105a80 <mappages>
  memmove(mem, init, sz);
  105b6b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105b6e:	89 75 10             	mov    %esi,0x10(%ebp)
}
  105b71:	8b 7d fc             	mov    -0x4(%ebp),%edi
  char *mem = kalloc();
  if (sz >= PGSIZE)
    panic("inituvm: more than a page");
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
  105b74:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
  105b77:	8b 75 f8             	mov    -0x8(%ebp),%esi
  105b7a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  char *mem = kalloc();
  if (sz >= PGSIZE)
    panic("inituvm: more than a page");
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
  105b7d:	89 45 0c             	mov    %eax,0xc(%ebp)
}
  105b80:	89 ec                	mov    %ebp,%esp
  105b82:	5d                   	pop    %ebp
  char *mem = kalloc();
  if (sz >= PGSIZE)
    panic("inituvm: more than a page");
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
  105b83:	e9 98 df ff ff       	jmp    103b20 <memmove>
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem = kalloc();
  if (sz >= PGSIZE)
    panic("inituvm: more than a page");
  105b88:	c7 04 24 d2 69 10 00 	movl   $0x1069d2,(%esp)
  105b8f:	e8 ec ac ff ff       	call   100880 <panic>
  105b94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105b9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105ba0 <setupkvm>:
}

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
  105ba0:	55                   	push   %ebp
  105ba1:	89 e5                	mov    %esp,%ebp
  105ba3:	53                   	push   %ebx
  105ba4:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;

  // Allocate page directory
  if(!(pgdir = (pde_t *) kalloc()))
  105ba7:	e8 04 c6 ff ff       	call   1021b0 <kalloc>
  105bac:	85 c0                	test   %eax,%eax
  105bae:	75 10                	jne    105bc0 <setupkvm+0x20>
    return 0;
  memset(pgdir, 0, PGSIZE);
  if(// Map IO space from 640K to 1Mbyte
  105bb0:	31 db                	xor    %ebx,%ebx
     !mappages(pgdir, (void *)0x100000, PHYSTOP-0x100000, 0x100000, PTE_W) ||
     // Map devices such as ioapic, lapic, ...
     !mappages(pgdir, (void *)0xFE000000, 0x2000000, 0xFE000000, PTE_W))
    return 0;
  return pgdir;
}
  105bb2:	89 d8                	mov    %ebx,%eax
  105bb4:	83 c4 14             	add    $0x14,%esp
  105bb7:	5b                   	pop    %ebx
  105bb8:	5d                   	pop    %ebp
  105bb9:	c3                   	ret    
  105bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
setupkvm(void)
{
  pde_t *pgdir;

  // Allocate page directory
  if(!(pgdir = (pde_t *) kalloc()))
  105bc0:	89 c3                	mov    %eax,%ebx
    return 0;
  memset(pgdir, 0, PGSIZE);
  105bc2:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  105bc9:	00 
  105bca:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  105bd1:	00 
  105bd2:	89 04 24             	mov    %eax,(%esp)
  105bd5:	e8 a6 de ff ff       	call   103a80 <memset>
  if(// Map IO space from 640K to 1Mbyte
  105bda:	b9 00 00 06 00       	mov    $0x60000,%ecx
  105bdf:	ba 00 00 0a 00       	mov    $0xa0000,%edx
  105be4:	89 d8                	mov    %ebx,%eax
  105be6:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  105bed:	00 
  105bee:	c7 04 24 00 00 0a 00 	movl   $0xa0000,(%esp)
  105bf5:	e8 86 fe ff ff       	call   105a80 <mappages>
  105bfa:	85 c0                	test   %eax,%eax
  105bfc:	74 b2                	je     105bb0 <setupkvm+0x10>
  105bfe:	b9 00 00 f0 00       	mov    $0xf00000,%ecx
  105c03:	ba 00 00 10 00       	mov    $0x100000,%edx
  105c08:	89 d8                	mov    %ebx,%eax
  105c0a:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  105c11:	00 
  105c12:	c7 04 24 00 00 10 00 	movl   $0x100000,(%esp)
  105c19:	e8 62 fe ff ff       	call   105a80 <mappages>
  105c1e:	85 c0                	test   %eax,%eax
  105c20:	74 8e                	je     105bb0 <setupkvm+0x10>
  105c22:	b9 00 00 00 02       	mov    $0x2000000,%ecx
  105c27:	ba 00 00 00 fe       	mov    $0xfe000000,%edx
  105c2c:	89 d8                	mov    %ebx,%eax
  105c2e:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  105c35:	00 
  105c36:	c7 04 24 00 00 00 fe 	movl   $0xfe000000,(%esp)
  105c3d:	e8 3e fe ff ff       	call   105a80 <mappages>
  105c42:	85 c0                	test   %eax,%eax
  105c44:	0f 85 68 ff ff ff    	jne    105bb2 <setupkvm+0x12>
  105c4a:	e9 61 ff ff ff       	jmp    105bb0 <setupkvm+0x10>
  105c4f:	90                   	nop    

00105c50 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
  105c50:	55                   	push   %ebp
  105c51:	89 e5                	mov    %esp,%ebp
  105c53:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
  105c56:	e8 45 ff ff ff       	call   105ba0 <setupkvm>
  105c5b:	a3 50 78 10 00       	mov    %eax,0x107850
}
  105c60:	c9                   	leave  
  105c61:	c3                   	ret    
  105c62:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  105c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00105c70 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  105c70:	55                   	push   %ebp
  105c71:	89 e5                	mov    %esp,%ebp
  105c73:	57                   	push   %edi
  105c74:	56                   	push   %esi
  105c75:	53                   	push   %ebx
  105c76:	83 ec 0c             	sub    $0xc,%esp
  char *a = (char *)PGROUNDUP(newsz);
  105c79:	8b 75 10             	mov    0x10(%ebp),%esi
  char *last = PGROUNDDOWN(oldsz - 1);
  105c7c:	8b 7d 0c             	mov    0xc(%ebp),%edi
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  char *a = (char *)PGROUNDUP(newsz);
  105c7f:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
  char *last = PGROUNDDOWN(oldsz - 1);
  105c85:	83 ef 01             	sub    $0x1,%edi
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  char *a = (char *)PGROUNDUP(newsz);
  105c88:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  char *last = PGROUNDDOWN(oldsz - 1);
  105c8e:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  for(; a <= last; a += PGSIZE){
  105c94:	39 fe                	cmp    %edi,%esi
  105c96:	77 37                	ja     105ccf <deallocuvm+0x5f>
    pte_t *pte = walkpgdir(pgdir, a, 0);
  105c98:	8b 45 08             	mov    0x8(%ebp),%eax
  105c9b:	31 c9                	xor    %ecx,%ecx
  105c9d:	89 f2                	mov    %esi,%edx
  105c9f:	e8 2c fd ff ff       	call   1059d0 <walkpgdir>
    if(pte && (*pte & PTE_P) != 0){
  105ca4:	85 c0                	test   %eax,%eax
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  char *a = (char *)PGROUNDUP(newsz);
  char *last = PGROUNDDOWN(oldsz - 1);
  for(; a <= last; a += PGSIZE){
    pte_t *pte = walkpgdir(pgdir, a, 0);
  105ca6:	89 c3                	mov    %eax,%ebx
    if(pte && (*pte & PTE_P) != 0){
  105ca8:	74 1b                	je     105cc5 <deallocuvm+0x55>
  105caa:	8b 00                	mov    (%eax),%eax
  105cac:	a8 01                	test   $0x1,%al
  105cae:	74 15                	je     105cc5 <deallocuvm+0x55>
      uint pa = PTE_ADDR(*pte);
      if(pa == 0)
  105cb0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  105cb5:	74 33                	je     105cea <deallocuvm+0x7a>
        panic("kfree");
      kfree((void *) pa);
  105cb7:	89 04 24             	mov    %eax,(%esp)
  105cba:	e8 31 c5 ff ff       	call   1021f0 <kfree>
      *pte = 0;
  105cbf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  char *a = (char *)PGROUNDUP(newsz);
  char *last = PGROUNDDOWN(oldsz - 1);
  for(; a <= last; a += PGSIZE){
  105cc5:	81 c6 00 10 00 00    	add    $0x1000,%esi
  105ccb:	39 f7                	cmp    %esi,%edi
  105ccd:	73 c9                	jae    105c98 <deallocuvm+0x28>
  105ccf:	8b 45 10             	mov    0x10(%ebp),%eax
  105cd2:	3b 45 0c             	cmp    0xc(%ebp),%eax
  105cd5:	77 08                	ja     105cdf <deallocuvm+0x6f>
      kfree((void *) pa);
      *pte = 0;
    }
  }
  return newsz < oldsz ? newsz : oldsz;
}
  105cd7:	83 c4 0c             	add    $0xc,%esp
  105cda:	5b                   	pop    %ebx
  105cdb:	5e                   	pop    %esi
  105cdc:	5f                   	pop    %edi
  105cdd:	5d                   	pop    %ebp
  105cde:	c3                   	ret    
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  char *a = (char *)PGROUNDUP(newsz);
  char *last = PGROUNDDOWN(oldsz - 1);
  for(; a <= last; a += PGSIZE){
  105cdf:	8b 45 0c             	mov    0xc(%ebp),%eax
      kfree((void *) pa);
      *pte = 0;
    }
  }
  return newsz < oldsz ? newsz : oldsz;
}
  105ce2:	83 c4 0c             	add    $0xc,%esp
  105ce5:	5b                   	pop    %ebx
  105ce6:	5e                   	pop    %esi
  105ce7:	5f                   	pop    %edi
  105ce8:	5d                   	pop    %ebp
  105ce9:	c3                   	ret    
  for(; a <= last; a += PGSIZE){
    pte_t *pte = walkpgdir(pgdir, a, 0);
    if(pte && (*pte & PTE_P) != 0){
      uint pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
  105cea:	c7 04 24 76 63 10 00 	movl   $0x106376,(%esp)
  105cf1:	e8 8a ab ff ff       	call   100880 <panic>
  105cf6:	8d 76 00             	lea    0x0(%esi),%esi
  105cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00105d00 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
  105d00:	55                   	push   %ebp
  105d01:	89 e5                	mov    %esp,%ebp
  105d03:	56                   	push   %esi
  105d04:	53                   	push   %ebx
  105d05:	83 ec 10             	sub    $0x10,%esp
  105d08:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(!pgdir)
  105d0b:	85 f6                	test   %esi,%esi
  105d0d:	74 59                	je     105d68 <freevm+0x68>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, USERTOP, 0);
  105d0f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  105d16:	00 
  105d17:	31 db                	xor    %ebx,%ebx
  105d19:	c7 44 24 04 00 00 0a 	movl   $0xa0000,0x4(%esp)
  105d20:	00 
  105d21:	89 34 24             	mov    %esi,(%esp)
  105d24:	e8 47 ff ff ff       	call   105c70 <deallocuvm>
  105d29:	eb 10                	jmp    105d3b <freevm+0x3b>
  105d2b:	90                   	nop    
  105d2c:	8d 74 26 00          	lea    0x0(%esi),%esi
  for(i = 0; i < NPDENTRIES; i++){
  105d30:	83 c3 01             	add    $0x1,%ebx
  105d33:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
  105d39:	74 1f                	je     105d5a <freevm+0x5a>
    if(pgdir[i] & PTE_P)
  105d3b:	8b 04 9e             	mov    (%esi,%ebx,4),%eax
  105d3e:	a8 01                	test   $0x1,%al
  105d40:	74 ee                	je     105d30 <freevm+0x30>
      kfree((void *) PTE_ADDR(pgdir[i]));
  105d42:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  uint i;

  if(!pgdir)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, USERTOP, 0);
  for(i = 0; i < NPDENTRIES; i++){
  105d47:	83 c3 01             	add    $0x1,%ebx
    if(pgdir[i] & PTE_P)
      kfree((void *) PTE_ADDR(pgdir[i]));
  105d4a:	89 04 24             	mov    %eax,(%esp)
  105d4d:	e8 9e c4 ff ff       	call   1021f0 <kfree>
  uint i;

  if(!pgdir)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, USERTOP, 0);
  for(i = 0; i < NPDENTRIES; i++){
  105d52:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
  105d58:	75 e1                	jne    105d3b <freevm+0x3b>
    if(pgdir[i] & PTE_P)
      kfree((void *) PTE_ADDR(pgdir[i]));
  }
  kfree((void *) pgdir);
  105d5a:	89 75 08             	mov    %esi,0x8(%ebp)
}
  105d5d:	83 c4 10             	add    $0x10,%esp
  105d60:	5b                   	pop    %ebx
  105d61:	5e                   	pop    %esi
  105d62:	5d                   	pop    %ebp
  deallocuvm(pgdir, USERTOP, 0);
  for(i = 0; i < NPDENTRIES; i++){
    if(pgdir[i] & PTE_P)
      kfree((void *) PTE_ADDR(pgdir[i]));
  }
  kfree((void *) pgdir);
  105d63:	e9 88 c4 ff ff       	jmp    1021f0 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(!pgdir)
    panic("freevm: no pgdir");
  105d68:	c7 04 24 ec 69 10 00 	movl   $0x1069ec,(%esp)
  105d6f:	e8 0c ab ff ff       	call   100880 <panic>
  105d74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105d7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105d80 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
  105d80:	55                   	push   %ebp
  105d81:	89 e5                	mov    %esp,%ebp
  105d83:	57                   	push   %edi
  105d84:	56                   	push   %esi
  105d85:	53                   	push   %ebx
  105d86:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d = setupkvm();
  105d89:	e8 12 fe ff ff       	call   105ba0 <setupkvm>
  pte_t *pte;
  uint pa, i;
  char *mem;

  if(!d) return 0;
  105d8e:	85 c0                	test   %eax,%eax
// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
  pde_t *d = setupkvm();
  105d90:	89 45 f0             	mov    %eax,-0x10(%ebp)
  pte_t *pte;
  uint pa, i;
  char *mem;

  if(!d) return 0;
  105d93:	0f 84 84 00 00 00    	je     105e1d <copyuvm+0x9d>
  for(i = 0; i < sz; i += PGSIZE){
  105d99:	8b 45 0c             	mov    0xc(%ebp),%eax
  105d9c:	85 c0                	test   %eax,%eax
  105d9e:	74 7d                	je     105e1d <copyuvm+0x9d>
  105da0:	31 ff                	xor    %edi,%edi
  105da2:	eb 43                	jmp    105de7 <copyuvm+0x67>
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present\n");
    pa = PTE_ADDR(*pte);
    if(!(mem = kalloc()))
      goto bad;
    memmove(mem, (char *)pa, PGSIZE);
  105da4:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  105daa:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  105db1:	00 
  105db2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  105db6:	89 04 24             	mov    %eax,(%esp)
  105db9:	e8 62 dd ff ff       	call   103b20 <memmove>
    if(!mappages(d, (void *)i, PGSIZE, PADDR(mem), PTE_W|PTE_U))
  105dbe:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105dc1:	b9 00 10 00 00       	mov    $0x1000,%ecx
  105dc6:	89 fa                	mov    %edi,%edx
  105dc8:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
  105dcf:	00 
  105dd0:	89 34 24             	mov    %esi,(%esp)
  105dd3:	e8 a8 fc ff ff       	call   105a80 <mappages>
  105dd8:	85 c0                	test   %eax,%eax
  105dda:	74 2f                	je     105e0b <copyuvm+0x8b>
  pte_t *pte;
  uint pa, i;
  char *mem;

  if(!d) return 0;
  for(i = 0; i < sz; i += PGSIZE){
  105ddc:	81 c7 00 10 00 00    	add    $0x1000,%edi
  105de2:	39 7d 0c             	cmp    %edi,0xc(%ebp)
  105de5:	76 36                	jbe    105e1d <copyuvm+0x9d>
    if(!(pte = walkpgdir(pgdir, (void *)i, 0)))
  105de7:	8b 45 08             	mov    0x8(%ebp),%eax
  105dea:	31 c9                	xor    %ecx,%ecx
  105dec:	89 fa                	mov    %edi,%edx
  105dee:	e8 dd fb ff ff       	call   1059d0 <walkpgdir>
  105df3:	85 c0                	test   %eax,%eax
  105df5:	74 31                	je     105e28 <copyuvm+0xa8>
      panic("copyuvm: pte should exist\n");
    if(!(*pte & PTE_P))
  105df7:	8b 18                	mov    (%eax),%ebx
  105df9:	f6 c3 01             	test   $0x1,%bl
  105dfc:	74 36                	je     105e34 <copyuvm+0xb4>
  105dfe:	66 90                	xchg   %ax,%ax
      panic("copyuvm: page not present\n");
    pa = PTE_ADDR(*pte);
    if(!(mem = kalloc()))
  105e00:	e8 ab c3 ff ff       	call   1021b0 <kalloc>
  105e05:	85 c0                	test   %eax,%eax
  105e07:	89 c6                	mov    %eax,%esi
  105e09:	75 99                	jne    105da4 <copyuvm+0x24>
      goto bad;
  }
  return d;

bad:
  freevm(d);
  105e0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105e0e:	89 04 24             	mov    %eax,(%esp)
  105e11:	e8 ea fe ff ff       	call   105d00 <freevm>
  105e16:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  return 0;
}
  105e1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105e20:	83 c4 1c             	add    $0x1c,%esp
  105e23:	5b                   	pop    %ebx
  105e24:	5e                   	pop    %esi
  105e25:	5f                   	pop    %edi
  105e26:	5d                   	pop    %ebp
  105e27:	c3                   	ret    
  char *mem;

  if(!d) return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if(!(pte = walkpgdir(pgdir, (void *)i, 0)))
      panic("copyuvm: pte should exist\n");
  105e28:	c7 04 24 fd 69 10 00 	movl   $0x1069fd,(%esp)
  105e2f:	e8 4c aa ff ff       	call   100880 <panic>
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present\n");
  105e34:	c7 04 24 18 6a 10 00 	movl   $0x106a18,(%esp)
  105e3b:	e8 40 aa ff ff       	call   100880 <panic>

00105e40 <allocuvm>:
// newsz. Allocates physical memory and page table entries. oldsz and
// newsz need not be page-aligned, nor does newsz have to be larger
// than oldsz.  Returns the new process size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  105e40:	55                   	push   %ebp
  if(newsz > USERTOP)
  105e41:	31 c0                	xor    %eax,%eax
// newsz. Allocates physical memory and page table entries. oldsz and
// newsz need not be page-aligned, nor does newsz have to be larger
// than oldsz.  Returns the new process size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  105e43:	89 e5                	mov    %esp,%ebp
  105e45:	57                   	push   %edi
  105e46:	56                   	push   %esi
  105e47:	53                   	push   %ebx
  105e48:	83 ec 0c             	sub    $0xc,%esp
  if(newsz > USERTOP)
  105e4b:	81 7d 10 00 00 0a 00 	cmpl   $0xa0000,0x10(%ebp)
  105e52:	0f 87 96 00 00 00    	ja     105eee <allocuvm+0xae>
    return 0;
  char *a = (char *)PGROUNDUP(oldsz);
  105e58:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *last = PGROUNDDOWN(newsz - 1);
  105e5b:	8b 7d 10             	mov    0x10(%ebp),%edi
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  if(newsz > USERTOP)
    return 0;
  char *a = (char *)PGROUNDUP(oldsz);
  105e5e:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
  char *last = PGROUNDDOWN(newsz - 1);
  105e64:	83 ef 01             	sub    $0x1,%edi
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  if(newsz > USERTOP)
    return 0;
  char *a = (char *)PGROUNDUP(oldsz);
  105e67:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  char *last = PGROUNDDOWN(newsz - 1);
  105e6d:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  for (; a <= last; a += PGSIZE){
  105e73:	39 fe                	cmp    %edi,%esi
  105e75:	76 45                	jbe    105ebc <allocuvm+0x7c>
  105e77:	eb 7d                	jmp    105ef6 <allocuvm+0xb6>
  105e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
  105e80:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  105e87:	00 
  105e88:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  105e8f:	00 
  105e90:	89 04 24             	mov    %eax,(%esp)
  105e93:	e8 e8 db ff ff       	call   103a80 <memset>
    mappages(pgdir, a, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  105e98:	89 f2                	mov    %esi,%edx
  105e9a:	b9 00 10 00 00       	mov    $0x1000,%ecx
  105e9f:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
  105ea6:	00 
{
  if(newsz > USERTOP)
    return 0;
  char *a = (char *)PGROUNDUP(oldsz);
  char *last = PGROUNDDOWN(newsz - 1);
  for (; a <= last; a += PGSIZE){
  105ea7:	81 c6 00 10 00 00    	add    $0x1000,%esi
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, a, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  105ead:	89 1c 24             	mov    %ebx,(%esp)
  105eb0:	8b 45 08             	mov    0x8(%ebp),%eax
  105eb3:	e8 c8 fb ff ff       	call   105a80 <mappages>
{
  if(newsz > USERTOP)
    return 0;
  char *a = (char *)PGROUNDUP(oldsz);
  char *last = PGROUNDDOWN(newsz - 1);
  for (; a <= last; a += PGSIZE){
  105eb8:	39 f7                	cmp    %esi,%edi
  105eba:	72 3a                	jb     105ef6 <allocuvm+0xb6>
    char *mem = kalloc();
  105ebc:	e8 ef c2 ff ff       	call   1021b0 <kalloc>
    if(mem == 0){
  105ec1:	85 c0                	test   %eax,%eax
  if(newsz > USERTOP)
    return 0;
  char *a = (char *)PGROUNDUP(oldsz);
  char *last = PGROUNDDOWN(newsz - 1);
  for (; a <= last; a += PGSIZE){
    char *mem = kalloc();
  105ec3:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
  105ec5:	75 b9                	jne    105e80 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
  105ec7:	c7 04 24 33 6a 10 00 	movl   $0x106a33,(%esp)
  105ece:	e8 ed a5 ff ff       	call   1004c0 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
  105ed3:	8b 45 0c             	mov    0xc(%ebp),%eax
  105ed6:	89 44 24 08          	mov    %eax,0x8(%esp)
  105eda:	8b 45 10             	mov    0x10(%ebp),%eax
  105edd:	89 44 24 04          	mov    %eax,0x4(%esp)
  105ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  105ee4:	89 04 24             	mov    %eax,(%esp)
  105ee7:	e8 84 fd ff ff       	call   105c70 <deallocuvm>
  105eec:	31 c0                	xor    %eax,%eax
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, a, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  }
  return newsz > oldsz ? newsz : oldsz;
}
  105eee:	83 c4 0c             	add    $0xc,%esp
  105ef1:	5b                   	pop    %ebx
  105ef2:	5e                   	pop    %esi
  105ef3:	5f                   	pop    %edi
  105ef4:	5d                   	pop    %ebp
  105ef5:	c3                   	ret    
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, a, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  }
  return newsz > oldsz ? newsz : oldsz;
  105ef6:	8b 45 10             	mov    0x10(%ebp),%eax
  105ef9:	3b 45 0c             	cmp    0xc(%ebp),%eax
  105efc:	73 f0                	jae    105eee <allocuvm+0xae>
  105efe:	8b 45 0c             	mov    0xc(%ebp),%eax
}
  105f01:	83 c4 0c             	add    $0xc,%esp
  105f04:	5b                   	pop    %ebx
  105f05:	5e                   	pop    %esi
  105f06:	5f                   	pop    %edi
  105f07:	5d                   	pop    %ebp
  105f08:	c3                   	ret    
  105f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00105f10 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
  105f10:	55                   	push   %ebp
  105f11:	89 e5                	mov    %esp,%ebp
  105f13:	57                   	push   %edi
  105f14:	56                   	push   %esi
  105f15:	53                   	push   %ebx
  105f16:	83 ec 1c             	sub    $0x1c,%esp
  105f19:	8b 7d 18             	mov    0x18(%ebp),%edi
  uint i, pa, n;
  pte_t *pte;

  if((uint)addr % PGSIZE != 0)
  105f1c:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
  105f23:	0f 85 82 00 00 00    	jne    105fab <loaduvm+0x9b>
    panic("loaduvm: addr must be page aligned\n");
  105f29:	31 f6                	xor    %esi,%esi
  for(i = 0; i < sz; i += PGSIZE){
  105f2b:	85 ff                	test   %edi,%edi
  105f2d:	75 0c                	jne    105f3b <loaduvm+0x2b>
  105f2f:	eb 61                	jmp    105f92 <loaduvm+0x82>
  105f31:	81 c6 00 10 00 00    	add    $0x1000,%esi
  105f37:	39 f7                	cmp    %esi,%edi
  105f39:	76 57                	jbe    105f92 <loaduvm+0x82>
    if(!(pte = walkpgdir(pgdir, addr+i, 0)))
  105f3b:	8b 55 0c             	mov    0xc(%ebp),%edx
  105f3e:	31 c9                	xor    %ecx,%ecx
  105f40:	8b 45 08             	mov    0x8(%ebp),%eax
  105f43:	01 f2                	add    %esi,%edx
  105f45:	e8 86 fa ff ff       	call   1059d0 <walkpgdir>
  105f4a:	85 c0                	test   %eax,%eax
  105f4c:	74 51                	je     105f9f <loaduvm+0x8f>
      panic("loaduvm: address should exist\n");
    pa = PTE_ADDR(*pte);
  105f4e:	89 fb                	mov    %edi,%ebx
  105f50:	8b 10                	mov    (%eax),%edx
  105f52:	29 f3                	sub    %esi,%ebx
    if(sz - i < PGSIZE) n = sz - i;
  105f54:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
  105f5a:	76 05                	jbe    105f61 <loaduvm+0x51>
  105f5c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    else n = PGSIZE;
    if(readi(ip, (char *)pa, offset+i, n) != n)
  105f61:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  105f65:	8b 4d 14             	mov    0x14(%ebp),%ecx
  105f68:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  105f6e:	89 54 24 04          	mov    %edx,0x4(%esp)
  105f72:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
  105f75:	89 44 24 08          	mov    %eax,0x8(%esp)
  105f79:	8b 45 10             	mov    0x10(%ebp),%eax
  105f7c:	89 04 24             	mov    %eax,(%esp)
  105f7f:	e8 dc b4 ff ff       	call   101460 <readi>
  105f84:	39 d8                	cmp    %ebx,%eax
  105f86:	74 a9                	je     105f31 <loaduvm+0x21>
      return 0;
  }
  return 1;
}
  105f88:	83 c4 1c             	add    $0x1c,%esp
    if(!(pte = walkpgdir(pgdir, addr+i, 0)))
      panic("loaduvm: address should exist\n");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE) n = sz - i;
    else n = PGSIZE;
    if(readi(ip, (char *)pa, offset+i, n) != n)
  105f8b:	31 c0                	xor    %eax,%eax
      return 0;
  }
  return 1;
}
  105f8d:	5b                   	pop    %ebx
  105f8e:	5e                   	pop    %esi
  105f8f:	5f                   	pop    %edi
  105f90:	5d                   	pop    %ebp
  105f91:	c3                   	ret    
  105f92:	83 c4 1c             	add    $0x1c,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint)addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned\n");
  for(i = 0; i < sz; i += PGSIZE){
  105f95:	b8 01 00 00 00       	mov    $0x1,%eax
    else n = PGSIZE;
    if(readi(ip, (char *)pa, offset+i, n) != n)
      return 0;
  }
  return 1;
}
  105f9a:	5b                   	pop    %ebx
  105f9b:	5e                   	pop    %esi
  105f9c:	5f                   	pop    %edi
  105f9d:	5d                   	pop    %ebp
  105f9e:	c3                   	ret    

  if((uint)addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned\n");
  for(i = 0; i < sz; i += PGSIZE){
    if(!(pte = walkpgdir(pgdir, addr+i, 0)))
      panic("loaduvm: address should exist\n");
  105f9f:	c7 04 24 84 6a 10 00 	movl   $0x106a84,(%esp)
  105fa6:	e8 d5 a8 ff ff       	call   100880 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint)addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned\n");
  105fab:	c7 04 24 60 6a 10 00 	movl   $0x106a60,(%esp)
  105fb2:	e8 c9 a8 ff ff       	call   100880 <panic>
  105fb7:	89 f6                	mov    %esi,%esi
  105fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00105fc0 <switchuvm>:
}

// Switch h/w page table and TSS registers to point to process p.
void
switchuvm(struct proc *p)
{
  105fc0:	55                   	push   %ebp
  105fc1:	89 e5                	mov    %esp,%ebp
  105fc3:	53                   	push   %ebx
  105fc4:	83 ec 04             	sub    $0x4,%esp
  105fc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
  105fca:	e8 61 d9 ff ff       	call   103930 <pushcli>

  // Setup TSS
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
  105fcf:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  105fd5:	8d 48 08             	lea    0x8(%eax),%ecx
  105fd8:	89 ca                	mov    %ecx,%edx
  105fda:	c1 ea 18             	shr    $0x18,%edx
  105fdd:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
  105fe3:	89 ca                	mov    %ecx,%edx
  105fe5:	c1 ea 10             	shr    $0x10,%edx
  105fe8:	c6 80 a5 00 00 00 99 	movb   $0x99,0xa5(%eax)
  105fef:	88 90 a4 00 00 00    	mov    %dl,0xa4(%eax)
  105ff5:	c6 80 a6 00 00 00 40 	movb   $0x40,0xa6(%eax)
  105ffc:	66 89 88 a2 00 00 00 	mov    %cx,0xa2(%eax)
  106003:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
  10600a:	67 00 
  cpu->gdt[SEG_TSS].s = 0;
  10600c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  106012:	80 a0 a5 00 00 00 ef 	andb   $0xef,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
  106019:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  10601f:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
  106025:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10602b:	8b 50 08             	mov    0x8(%eax),%edx
  10602e:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  106034:	81 c2 00 10 00 00    	add    $0x1000,%edx
  10603a:	89 50 0c             	mov    %edx,0xc(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
  10603d:	b8 30 00 00 00       	mov    $0x30,%eax
  106042:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);

  if(p->pgdir == 0)
  106045:	8b 43 04             	mov    0x4(%ebx),%eax
  106048:	85 c0                	test   %eax,%eax
  10604a:	74 0d                	je     106059 <switchuvm+0x99>
}

static inline void
lcr3(uint val) 
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
  10604c:	0f 22 d8             	mov    %eax,%cr3
    panic("switchuvm: no pgdir\n");

  lcr3(PADDR(p->pgdir));  // switch to new address space
  popcli();
}
  10604f:	83 c4 04             	add    $0x4,%esp
  106052:	5b                   	pop    %ebx
  106053:	5d                   	pop    %ebp

  if(p->pgdir == 0)
    panic("switchuvm: no pgdir\n");

  lcr3(PADDR(p->pgdir));  // switch to new address space
  popcli();
  106054:	e9 17 d9 ff ff       	jmp    103970 <popcli>
  cpu->ts.ss0 = SEG_KDATA << 3;
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
  ltr(SEG_TSS << 3);

  if(p->pgdir == 0)
    panic("switchuvm: no pgdir\n");
  106059:	c7 04 24 4b 6a 10 00 	movl   $0x106a4b,(%esp)
  106060:	e8 1b a8 ff ff       	call   100880 <panic>
  106065:	8d 74 26 00          	lea    0x0(%esi),%esi
  106069:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00106070 <ksegment>:

// Set up CPU's kernel segment descriptors.
// Run once at boot time on each CPU.
void
ksegment(void)
{
  106070:	55                   	push   %ebp
  106071:	89 e5                	mov    %esp,%ebp
  106073:	83 ec 18             	sub    $0x18,%esp

  // Map virtual addresses to linear addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  106076:	e8 85 c3 ff ff       	call   102400 <cpunum>
  10607b:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
  106081:	05 a0 aa 10 00       	add    $0x10aaa0,%eax
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
  106086:	8d 88 b4 00 00 00    	lea    0xb4(%eax),%ecx
  10608c:	89 ca                	mov    %ecx,%edx
  10608e:	c1 ea 18             	shr    $0x18,%edx
  106091:	88 90 8f 00 00 00    	mov    %dl,0x8f(%eax)
  106097:	89 ca                	mov    %ecx,%edx
  106099:	c1 ea 10             	shr    $0x10,%edx
  10609c:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
  1060a2:	8d 50 70             	lea    0x70(%eax),%edx
  // Map virtual addresses to linear addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  1060a5:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  1060a9:	c6 40 7e cf          	movb   $0xcf,0x7e(%eax)
  1060ad:	c6 40 7d 9a          	movb   $0x9a,0x7d(%eax)
  1060b1:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
  1060b5:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
  1060bb:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  1060c1:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  1060c8:	c6 80 86 00 00 00 cf 	movb   $0xcf,0x86(%eax)
  1060cf:	c6 80 85 00 00 00 92 	movb   $0x92,0x85(%eax)
  1060d6:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
  1060dd:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
  1060e4:	00 00 
  1060e6:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
  1060ed:	ff ff 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  1060ef:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  1060f6:	c6 80 96 00 00 00 cf 	movb   $0xcf,0x96(%eax)
  1060fd:	c6 80 95 00 00 00 fa 	movb   $0xfa,0x95(%eax)
  106104:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
  10610b:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
  106112:	00 00 
  106114:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
  10611b:	ff ff 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
  10611d:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)
  106124:	c6 80 9e 00 00 00 cf 	movb   $0xcf,0x9e(%eax)
  10612b:	c6 80 9d 00 00 00 f2 	movb   $0xf2,0x9d(%eax)
  106132:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
  106139:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
  106140:	00 00 
  106142:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
  106149:	ff ff 

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
  10614b:	c6 80 8e 00 00 00 c0 	movb   $0xc0,0x8e(%eax)
  106152:	c6 80 8d 00 00 00 92 	movb   $0x92,0x8d(%eax)
  106159:	66 89 88 8a 00 00 00 	mov    %cx,0x8a(%eax)
  106160:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
  106167:	00 00 
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  106169:	66 c7 45 fa 37 00    	movw   $0x37,-0x6(%ebp)
  pd[1] = (uint)p;
  10616f:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
  106173:	c1 ea 10             	shr    $0x10,%edx
  106176:	66 89 55 fe          	mov    %dx,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
  10617a:	8d 55 fa             	lea    -0x6(%ebp),%edx
  10617d:	0f 01 12             	lgdtl  (%edx)
}

static inline void
loadgs(ushort v)
{
  asm volatile("movw %0, %%gs" : : "r" (v));
  106180:	ba 18 00 00 00       	mov    $0x18,%edx
  106185:	8e ea                	mov    %edx,%gs
  lgdt(c->gdt, sizeof(c->gdt));
  loadgs(SEG_KCPU << 3);
  
  // Initialize cpu-local storage.
  cpu = c;
  proc = 0;
  106187:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
  10618e:	00 00 00 00 

  lgdt(c->gdt, sizeof(c->gdt));
  loadgs(SEG_KCPU << 3);
  
  // Initialize cpu-local storage.
  cpu = c;
  106192:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
}
  106198:	c9                   	leave  
  106199:	c3                   	ret    
