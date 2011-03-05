
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
  10000f:	c7 04 24 00 8e 10 00 	movl   $0x108e00,(%esp)
  100016:	e8 75 3c 00 00       	call   103c90 <acquire>

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
  10002a:	c7 43 0c 24 a3 10 00 	movl   $0x10a324,0xc(%ebx)
    panic("brelse");

  acquire(&bcache.lock);

  b->next->prev = b->prev;
  b->prev->next = b->next;
  100031:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
  100034:	a1 34 a3 10 00       	mov    0x10a334,%eax
  100039:	89 43 10             	mov    %eax,0x10(%ebx)
  b->prev = &bcache.head;
  bcache.head.next->prev = b;
  10003c:	a1 34 a3 10 00       	mov    0x10a334,%eax
  bcache.head.next = b;
  100041:	89 1d 34 a3 10 00    	mov    %ebx,0x10a334

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
  10004d:	e8 ce 2f 00 00       	call   103020 <wakeup>

  release(&bcache.lock);
  100052:	c7 45 08 00 8e 10 00 	movl   $0x108e00,0x8(%ebp)
}
  100059:	83 c4 04             	add    $0x4,%esp
  10005c:	5b                   	pop    %ebx
  10005d:	5d                   	pop    %ebp
  bcache.head.next = b;

  b->flags &= ~B_BUSY;
  wakeup(b);

  release(&bcache.lock);
  10005e:	e9 ed 3b 00 00       	jmp    103c50 <release>
// Release the buffer b.
void
brelse(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("brelse");
  100063:	c7 04 24 60 6c 10 00 	movl   $0x106c60,(%esp)
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
  100088:	e9 03 1e 00 00       	jmp    101e90 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("bwrite");
  10008d:	c7 04 24 67 6c 10 00 	movl   $0x106c67,(%esp)
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
  1000af:	c7 04 24 00 8e 10 00 	movl   $0x108e00,(%esp)
  1000b6:	e8 d5 3b 00 00       	call   103c90 <acquire>

 loop:
  // Try for cached block.
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
  1000bb:	8b 1d 34 a3 10 00    	mov    0x10a334,%ebx
  1000c1:	81 fb 24 a3 10 00    	cmp    $0x10a324,%ebx
  1000c7:	75 12                	jne    1000db <bread+0x3b>
  1000c9:	eb 34                	jmp    1000ff <bread+0x5f>
  1000cb:	90                   	nop    
  1000cc:	8d 74 26 00          	lea    0x0(%esi),%esi
  1000d0:	8b 5b 10             	mov    0x10(%ebx),%ebx
  1000d3:	81 fb 24 a3 10 00    	cmp    $0x10a324,%ebx
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
  1000ed:	c7 44 24 04 00 8e 10 	movl   $0x108e00,0x4(%esp)
  1000f4:	00 
  1000f5:	89 1c 24             	mov    %ebx,(%esp)
  1000f8:	e8 83 30 00 00       	call   103180 <sleep>
  1000fd:	eb bc                	jmp    1000bb <bread+0x1b>
      goto loop;
    }
  }

  // Allocate fresh block.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
  1000ff:	8b 1d 30 a3 10 00    	mov    0x10a330,%ebx
  100105:	81 fb 24 a3 10 00    	cmp    $0x10a324,%ebx
  10010b:	75 0e                	jne    10011b <bread+0x7b>
  10010d:	eb 4c                	jmp    10015b <bread+0xbb>
  10010f:	90                   	nop    
  100110:	8b 5b 0c             	mov    0xc(%ebx),%ebx
  100113:	81 fb 24 a3 10 00    	cmp    $0x10a324,%ebx
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
  10012e:	c7 04 24 00 8e 10 00 	movl   $0x108e00,(%esp)
  100135:	e8 16 3b 00 00       	call   103c50 <release>
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
  10014c:	e8 3f 1d 00 00       	call   101e90 <iderw>
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
  10015b:	c7 04 24 6e 6c 10 00 	movl   $0x106c6e,(%esp)
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
  10016c:	c7 04 24 00 8e 10 00 	movl   $0x108e00,(%esp)
  100173:	e8 d8 3a 00 00       	call   103c50 <release>
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
  100186:	c7 44 24 04 7f 6c 10 	movl   $0x106c7f,0x4(%esp)
  10018d:	00 
  10018e:	c7 04 24 00 8e 10 00 	movl   $0x108e00,(%esp)
  100195:	e8 76 39 00 00       	call   103b10 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  10019a:	ba 24 a3 10 00       	mov    $0x10a324,%edx
  10019f:	b8 34 8e 10 00       	mov    $0x108e34,%eax
  struct buf *b;

  initlock(&bcache.lock, "bcache");

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  1001a4:	c7 05 30 a3 10 00 24 	movl   $0x10a324,0x10a330
  1001ab:	a3 10 00 
  bcache.head.next = &bcache.head;
  1001ae:	89 15 34 a3 10 00    	mov    %edx,0x10a334
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
  1001b4:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
  1001b7:	8b 15 34 a3 10 00    	mov    0x10a334,%edx
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
    b->prev = &bcache.head;
  1001bd:	c7 40 0c 24 a3 10 00 	movl   $0x10a324,0xc(%eax)
    b->dev = -1;
  1001c4:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
    bcache.head.next = b;
  1001cb:	a3 34 a3 10 00       	mov    %eax,0x10a334
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
  1001da:	3d 24 a3 10 00       	cmp    $0x10a324,%eax
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
  1001f6:	c7 44 24 04 86 6c 10 	movl   $0x106c86,0x4(%esp)
  1001fd:	00 
  1001fe:	c7 04 24 60 8d 10 00 	movl   $0x108d60,(%esp)
  100205:	e8 06 39 00 00       	call   103b10 <initlock>
  initlock(&input.lock, "input");
  10020a:	c7 44 24 04 8e 6c 10 	movl   $0x106c8e,0x4(%esp)
  100211:	00 
  100212:	c7 04 24 40 a5 10 00 	movl   $0x10a540,(%esp)
  100219:	e8 f2 38 00 00       	call   103b10 <initlock>

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
  100225:	c7 05 ac af 10 00 d0 	movl   $0x1003d0,0x10afac
  10022c:	03 10 00 
  devsw[CONSOLE].read = consoleread;
  10022f:	c7 05 a8 af 10 00 10 	movl   $0x100610,0x10afa8
  100236:	06 10 00 
  cons.locking = 1;
  100239:	c7 05 94 8d 10 00 01 	movl   $0x1,0x108d94
  100240:	00 00 00 

  picenable(IRQ_KBD);
  100243:	e8 a8 28 00 00       	call   102af0 <picenable>
  ioapicenable(IRQ_KBD, 0);
  100248:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10024f:	00 
  100250:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  100257:	e8 64 1e 00 00       	call   1020c0 <ioapicenable>
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
  10026b:	a1 40 8d 10 00       	mov    0x108d40,%eax
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
  100286:	e8 65 55 00 00       	call   1057f0 <uartputc>
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
  100329:	e8 c2 54 00 00       	call   1057f0 <uartputc>
  10032e:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  100335:	e8 b6 54 00 00       	call   1057f0 <uartputc>
  10033a:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  100341:	e8 aa 54 00 00       	call   1057f0 <uartputc>
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
  10036c:	e8 2f 3a 00 00       	call   103da0 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  100371:	b8 80 07 00 00       	mov    $0x780,%eax
  100376:	29 d8                	sub    %ebx,%eax
  100378:	01 c0                	add    %eax,%eax
  10037a:	89 44 24 08          	mov    %eax,0x8(%esp)
  10037e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100385:	00 
  100386:	89 34 24             	mov    %esi,(%esp)
  100389:	e8 72 39 00 00       	call   103d00 <memset>
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
  1003e5:	e8 d6 12 00 00       	call   1016c0 <iunlock>
  acquire(&cons.lock);
  1003ea:	c7 04 24 60 8d 10 00 	movl   $0x108d60,(%esp)
  1003f1:	e8 9a 38 00 00       	call   103c90 <acquire>
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
  100410:	c7 04 24 60 8d 10 00 	movl   $0x108d60,(%esp)
  100417:	e8 34 38 00 00       	call   103c50 <release>
  ilock(ip);
  10041c:	8b 45 08             	mov    0x8(%ebp),%eax
  10041f:	89 04 24             	mov    %eax,(%esp)
  100422:	e8 b9 16 00 00       	call   101ae0 <ilock>

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
  100466:	0f b6 82 ae 6c 10 00 	movzbl 0x106cae(%edx),%eax
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
  1004c9:	a1 94 8d 10 00       	mov    0x108d94,%eax
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
  100570:	c7 04 24 60 8d 10 00 	movl   $0x108d60,(%esp)
  100577:	e8 d4 36 00 00       	call   103c50 <release>
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
  1005c0:	ba 94 6c 10 00       	mov    $0x106c94,%edx
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
  1005f0:	c7 04 24 60 8d 10 00 	movl   $0x108d60,(%esp)
  1005f7:	e8 94 36 00 00       	call   103c90 <acquire>
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
  100627:	e8 94 10 00 00       	call   1016c0 <iunlock>
  target = n;
  acquire(&input.lock);
  10062c:	c7 04 24 40 a5 10 00 	movl   $0x10a540,(%esp)
  100633:	e8 58 36 00 00       	call   103c90 <acquire>
  while(n > 0){
  100638:	85 db                	test   %ebx,%ebx
  10063a:	7f 2c                	jg     100668 <consoleread+0x58>
  10063c:	e9 b6 00 00 00       	jmp    1006f7 <consoleread+0xe7>
    while(input.r == input.w){
      if(proc->common->killed){
  100641:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  100647:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  10064d:	8b 40 4c             	mov    0x4c(%eax),%eax
  100650:	85 c0                	test   %eax,%eax
  100652:	75 4e                	jne    1006a2 <consoleread+0x92>
        release(&input.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
  100654:	c7 44 24 04 40 a5 10 	movl   $0x10a540,0x4(%esp)
  10065b:	00 
  10065c:	c7 04 24 f4 a5 10 00 	movl   $0x10a5f4,(%esp)
  100663:	e8 18 2b 00 00       	call   103180 <sleep>

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
  100668:	8b 15 f4 a5 10 00    	mov    0x10a5f4,%edx
  10066e:	3b 15 f8 a5 10 00    	cmp    0x10a5f8,%edx
  100674:	74 cb                	je     100641 <consoleread+0x31>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
  100676:	89 d0                	mov    %edx,%eax
  100678:	83 e0 7f             	and    $0x7f,%eax
  10067b:	0f b6 88 74 a5 10 00 	movzbl 0x10a574(%eax),%ecx
  100682:	8d 42 01             	lea    0x1(%edx),%eax
  100685:	a3 f4 a5 10 00       	mov    %eax,0x10a5f4
    if(c == C('D')){  // EOF
  10068a:	80 f9 04             	cmp    $0x4,%cl
  10068d:	74 39                	je     1006c8 <consoleread+0xb8>
        input.r--;
      }
      break;
    }
    *dst++ = c;
    --n;
  10068f:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
  100692:	80 f9 0a             	cmp    $0xa,%cl
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
  100695:	88 0e                	mov    %cl,(%esi)
    --n;
    if(c == '\n')
  100697:	74 39                	je     1006d2 <consoleread+0xc2>
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
  100699:	85 db                	test   %ebx,%ebx
  10069b:	74 37                	je     1006d4 <consoleread+0xc4>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
  10069d:	83 c6 01             	add    $0x1,%esi
  1006a0:	eb c6                	jmp    100668 <consoleread+0x58>
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
      if(proc->common->killed){
        release(&input.lock);
  1006a2:	c7 04 24 40 a5 10 00 	movl   $0x10a540,(%esp)
        ilock(ip);
  1006a9:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
      if(proc->common->killed){
        release(&input.lock);
  1006ae:	e8 9d 35 00 00       	call   103c50 <release>
        ilock(ip);
  1006b3:	8b 45 08             	mov    0x8(%ebp),%eax
  1006b6:	89 04 24             	mov    %eax,(%esp)
  1006b9:	e8 22 14 00 00       	call   101ae0 <ilock>
  }
  release(&input.lock);
  ilock(ip);

  return target - n;
}
  1006be:	83 c4 0c             	add    $0xc,%esp
  1006c1:	89 d8                	mov    %ebx,%eax
  1006c3:	5b                   	pop    %ebx
  1006c4:	5e                   	pop    %esi
  1006c5:	5f                   	pop    %edi
  1006c6:	5d                   	pop    %ebp
  1006c7:	c3                   	ret    
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
  1006c8:	39 df                	cmp    %ebx,%edi
  1006ca:	76 06                	jbe    1006d2 <consoleread+0xc2>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
  1006cc:	89 15 f4 a5 10 00    	mov    %edx,0x10a5f4
      }
      break;
    }
    *dst++ = c;
    --n;
    if(c == '\n')
  1006d2:	29 df                	sub    %ebx,%edi
  1006d4:	89 fb                	mov    %edi,%ebx
      break;
  }
  release(&input.lock);
  1006d6:	c7 04 24 40 a5 10 00 	movl   $0x10a540,(%esp)
  1006dd:	e8 6e 35 00 00       	call   103c50 <release>
  ilock(ip);
  1006e2:	8b 45 08             	mov    0x8(%ebp),%eax
  1006e5:	89 04 24             	mov    %eax,(%esp)
  1006e8:	e8 f3 13 00 00       	call   101ae0 <ilock>

  return target - n;
}
  1006ed:	83 c4 0c             	add    $0xc,%esp
  1006f0:	89 d8                	mov    %ebx,%eax
  1006f2:	5b                   	pop    %ebx
  1006f3:	5e                   	pop    %esi
  1006f4:	5f                   	pop    %edi
  1006f5:	5d                   	pop    %ebp
  1006f6:	c3                   	ret    
  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
      if(proc->common->killed){
  1006f7:	31 db                	xor    %ebx,%ebx
  1006f9:	eb db                	jmp    1006d6 <consoleread+0xc6>
  1006fb:	90                   	nop    
  1006fc:	8d 74 26 00          	lea    0x0(%esi),%esi

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
  10070b:	c7 04 24 40 a5 10 00 	movl   $0x10a540,(%esp)
  100712:	e8 79 35 00 00       	call   103c90 <acquire>
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
  10074a:	8b 15 fc a5 10 00    	mov    0x10a5fc,%edx
  100750:	89 d0                	mov    %edx,%eax
  100752:	2b 05 f4 a5 10 00    	sub    0x10a5f4,%eax
  100758:	83 f8 7f             	cmp    $0x7f,%eax
  10075b:	77 ba                	ja     100717 <consoleintr+0x17>
        c = (c == '\r') ? '\n' : c;
  10075d:	83 fb 0d             	cmp    $0xd,%ebx
  100760:	0f 84 ef 00 00 00    	je     100855 <consoleintr+0x155>
        input.buf[input.e++ % INPUT_BUF] = c;
  100766:	89 d0                	mov    %edx,%eax
  100768:	83 e0 7f             	and    $0x7f,%eax
  10076b:	88 98 74 a5 10 00    	mov    %bl,0x10a574(%eax)
  100771:	8d 42 01             	lea    0x1(%edx),%eax
  100774:	a3 fc a5 10 00       	mov    %eax,0x10a5fc
        consputc(c);
  100779:	89 d8                	mov    %ebx,%eax
  10077b:	e8 e0 fa ff ff       	call   100260 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
  100780:	83 fb 0a             	cmp    $0xa,%ebx
  100783:	0f 84 ea 00 00 00    	je     100873 <consoleintr+0x173>
  100789:	83 fb 04             	cmp    $0x4,%ebx
  10078c:	0f 84 e1 00 00 00    	je     100873 <consoleintr+0x173>
  100792:	a1 f4 a5 10 00       	mov    0x10a5f4,%eax
  100797:	8b 15 fc a5 10 00    	mov    0x10a5fc,%edx
  10079d:	83 e8 80             	sub    $0xffffff80,%eax
  1007a0:	39 c2                	cmp    %eax,%edx
  1007a2:	0f 85 6f ff ff ff    	jne    100717 <consoleintr+0x17>
          input.w = input.e;
  1007a8:	89 15 f8 a5 10 00    	mov    %edx,0x10a5f8
          wakeup(&input.r);
  1007ae:	c7 04 24 f4 a5 10 00 	movl   $0x10a5f4,(%esp)
  1007b5:	e8 66 28 00 00       	call   103020 <wakeup>
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
  1007c6:	c7 45 08 40 a5 10 00 	movl   $0x10a540,0x8(%ebp)
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
  1007d3:	e9 78 34 00 00       	jmp    103c50 <release>
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
  1007e6:	a1 fc a5 10 00       	mov    0x10a5fc,%eax
  1007eb:	3b 05 f8 a5 10 00    	cmp    0x10a5f8,%eax
  1007f1:	0f 84 20 ff ff ff    	je     100717 <consoleintr+0x17>
        input.e--;
  1007f7:	83 e8 01             	sub    $0x1,%eax
  1007fa:	a3 fc a5 10 00       	mov    %eax,0x10a5fc
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
  100818:	80 b8 74 a5 10 00 0a 	cmpb   $0xa,0x10a574(%eax)
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
  10082a:	89 15 fc a5 10 00    	mov    %edx,0x10a5fc
        consputc(BACKSPACE);
  100830:	e8 2b fa ff ff       	call   100260 <consputc>
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
  100835:	a1 fc a5 10 00       	mov    0x10a5fc,%eax
  10083a:	3b 05 f8 a5 10 00    	cmp    0x10a5f8,%eax
  100840:	75 ce                	jne    100810 <consoleintr+0x110>
  100842:	e9 d0 fe ff ff       	jmp    100717 <consoleintr+0x17>

  acquire(&input.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      procdump();
  100847:	e8 d4 31 00 00       	call   103a20 <procdump>
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
  10085a:	c6 80 74 a5 10 00 0a 	movb   $0xa,0x10a574(%eax)
  100861:	8d 42 01             	lea    0x1(%edx),%eax
  100864:	a3 fc a5 10 00       	mov    %eax,0x10a5fc
        consputc(c);
  100869:	b8 0a 00 00 00       	mov    $0xa,%eax
  10086e:	e8 ed f9 ff ff       	call   100260 <consputc>
  100873:	8b 15 fc a5 10 00    	mov    0x10a5fc,%edx
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
  100897:	c7 05 94 8d 10 00 00 	movl   $0x0,0x108d94
  10089e:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
  1008a1:	0f b6 00             	movzbl (%eax),%eax
  1008a4:	c7 04 24 9b 6c 10 00 	movl   $0x106c9b,(%esp)
  1008ab:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008af:	e8 0c fc ff ff       	call   1004c0 <cprintf>
  cprintf(s);
  1008b4:	8b 45 08             	mov    0x8(%ebp),%eax
  1008b7:	89 04 24             	mov    %eax,(%esp)
  1008ba:	e8 01 fc ff ff       	call   1004c0 <cprintf>
  cprintf("\n");
  1008bf:	c7 04 24 d6 70 10 00 	movl   $0x1070d6,(%esp)
  1008c6:	e8 f5 fb ff ff       	call   1004c0 <cprintf>
  getcallerpcs(&s, pcs);
  1008cb:	8d 45 08             	lea    0x8(%ebp),%eax
  1008ce:	89 04 24             	mov    %eax,(%esp)
  1008d1:	89 74 24 04          	mov    %esi,0x4(%esp)
  1008d5:	e8 56 32 00 00       	call   103b30 <getcallerpcs>
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
  1008da:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1008dd:	c7 04 24 aa 6c 10 00 	movl   $0x106caa,(%esp)
  1008e4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008e8:	e8 d3 fb ff ff       	call   1004c0 <cprintf>
  1008ed:	8b 44 9e fc          	mov    -0x4(%esi,%ebx,4),%eax
  1008f1:	83 c3 01             	add    $0x1,%ebx
  1008f4:	c7 04 24 aa 6c 10 00 	movl   $0x106caa,(%esp)
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
  100909:	c7 05 40 8d 10 00 01 	movl   $0x1,0x108d40
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
  100932:	e8 49 14 00 00       	call   101d80 <namei>
  100937:	89 c3                	mov    %eax,%ebx
  100939:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10093e:	85 db                	test   %ebx,%ebx
  100940:	74 42                	je     100984 <exec+0x64>
    return -1;
  ilock(ip);
  100942:	89 1c 24             	mov    %ebx,(%esp)
  100945:	e8 96 11 00 00       	call   101ae0 <ilock>

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
  10094a:	8d 45 a0             	lea    -0x60(%ebp),%eax
  10094d:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
  100954:	00 
  100955:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  10095c:	00 
  10095d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100961:	89 1c 24             	mov    %ebx,(%esp)
  100964:	e8 17 0b 00 00       	call   101480 <readi>
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
  10097a:	e8 41 11 00 00       	call   101ac0 <iunlockput>
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
  10098f:	e8 0c 5c 00 00       	call   1065a0 <setupkvm>
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
  1009ea:	e8 91 0a 00 00       	call   101480 <readi>
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
  100a16:	e8 25 5e 00 00       	call   106840 <allocuvm>
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
  100a44:	e8 c7 5e 00 00       	call   106910 <loaduvm>
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
  100a61:	e8 9a 5c 00 00       	call   106700 <freevm>
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
  100a88:	e8 33 10 00 00       	call   101ac0 <iunlockput>

  // Allocate and initialize stack at sz
  sz = spbottom = PGROUNDUP(sz);
  if(!(sz = allocuvm(pgdir, sz, sz + PGSIZE)))
  100a8d:	8b 45 8c             	mov    -0x74(%ebp),%eax
  100a90:	8b 55 88             	mov    -0x78(%ebp),%edx
  100a93:	89 74 24 08          	mov    %esi,0x8(%esp)
  100a97:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a9b:	89 14 24             	mov    %edx,(%esp)
  100a9e:	e8 9d 5d 00 00       	call   106840 <allocuvm>
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
  100abe:	e8 8d 59 00 00       	call   106450 <uva2ka>

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
  100ad0:	0f 84 90 01 00 00    	je     100c66 <exec+0x346>
    arglen += strlen(argv[argc]) + 1;
  100ad6:	89 14 24             	mov    %edx,(%esp)
  if(!(sz = allocuvm(pgdir, sz, sz + PGSIZE)))
    goto bad;
  mem = uva2ka(pgdir, (char *)spbottom);

  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100ad9:	83 c3 01             	add    $0x1,%ebx
    arglen += strlen(argv[argc]) + 1;
  100adc:	e8 1f 34 00 00       	call   103f00 <strlen>
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
  100b26:	c7 04 11 00 00 00 00 	movl   $0x0,(%ecx,%edx,1)
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
  100b4e:	e8 ad 33 00 00       	call   103f00 <strlen>
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
  100b73:	e8 28 32 00 00       	call   103da0 <memmove>
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
  100bf2:	05 a8 00 00 00       	add    $0xa8,%eax
  100bf7:	89 04 24             	mov    %eax,(%esp)
  100bfa:	e8 c1 32 00 00       	call   103ec0 <safestrcpy>

  // Commit to the user image.
  oldpgdir = proc->common->pgdir;
  100bff:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  proc->common->pgdir = pgdir;
  100c05:	8b 55 88             	mov    -0x78(%ebp),%edx
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));

  // Commit to the user image.
  oldpgdir = proc->common->pgdir;
  100c08:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  100c0e:	8b 58 04             	mov    0x4(%eax),%ebx
  proc->common->pgdir = pgdir;
  100c11:	89 50 04             	mov    %edx,0x4(%eax)
  proc->common->sz = sz;
  100c14:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  100c1a:	8b 8d 74 ff ff ff    	mov    -0x8c(%ebp),%ecx
  100c20:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  100c26:	89 08                	mov    %ecx,(%eax)
  proc->tf->eip = elf.entry;  // main
  100c28:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  100c2e:	8b 90 9c 00 00 00    	mov    0x9c(%eax),%edx
  100c34:	8b 45 b8             	mov    -0x48(%ebp),%eax
  100c37:	89 42 38             	mov    %eax,0x38(%edx)
  proc->tf->esp = sp;
  100c3a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  100c40:	8b 80 9c 00 00 00    	mov    0x9c(%eax),%eax
  100c46:	89 70 44             	mov    %esi,0x44(%eax)

  switchuvm(proc); 
  100c49:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  100c4f:	89 04 24             	mov    %eax,(%esp)
  100c52:	e8 69 5d 00 00       	call   1069c0 <switchuvm>

  freevm(oldpgdir);
  100c57:	89 1c 24             	mov    %ebx,(%esp)
  100c5a:	e8 a1 5a 00 00       	call   106700 <freevm>
  100c5f:	31 c0                	xor    %eax,%eax
  100c61:	e9 1e fd ff ff       	jmp    100984 <exec+0x64>
  if(!(sz = allocuvm(pgdir, sz, sz + PGSIZE)))
    goto bad;
  mem = uva2ka(pgdir, (char *)spbottom);

  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100c66:	31 c0                	xor    %eax,%eax
  100c68:	b2 04                	mov    $0x4,%dl
  100c6a:	31 c9                	xor    %ecx,%ecx
  100c6c:	c7 85 78 ff ff ff 00 	movl   $0x0,-0x88(%ebp)
  100c73:	00 00 00 
  100c76:	c7 45 90 ff ff ff ff 	movl   $0xffffffff,-0x70(%ebp)
  100c7d:	e9 8c fe ff ff       	jmp    100b0e <exec+0x1ee>
  100c82:	90                   	nop    
  100c83:	90                   	nop    
  100c84:	90                   	nop    
  100c85:	90                   	nop    
  100c86:	90                   	nop    
  100c87:	90                   	nop    
  100c88:	90                   	nop    
  100c89:	90                   	nop    
  100c8a:	90                   	nop    
  100c8b:	90                   	nop    
  100c8c:	90                   	nop    
  100c8d:	90                   	nop    
  100c8e:	90                   	nop    
  100c8f:	90                   	nop    

00100c90 <filewrite>:
}

// Write to file f.  Addr is kernel address.
int
filewrite(struct file *f, char *addr, int n)
{
  100c90:	55                   	push   %ebp
  100c91:	89 e5                	mov    %esp,%ebp
  100c93:	83 ec 28             	sub    $0x28,%esp
  100c96:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  100c99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  100c9c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  100c9f:	8b 75 10             	mov    0x10(%ebp),%esi
  100ca2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  100ca5:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int r;

  if(f->writable == 0)
  100ca8:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
  100cac:	74 54                	je     100d02 <filewrite+0x72>
    return -1;
  if(f->type == FD_PIPE)
  100cae:	8b 03                	mov    (%ebx),%eax
  100cb0:	83 f8 01             	cmp    $0x1,%eax
  100cb3:	74 54                	je     100d09 <filewrite+0x79>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
  100cb5:	83 f8 02             	cmp    $0x2,%eax
  100cb8:	75 66                	jne    100d20 <filewrite+0x90>
    ilock(f->ip);
  100cba:	8b 43 10             	mov    0x10(%ebx),%eax
  100cbd:	89 04 24             	mov    %eax,(%esp)
  100cc0:	e8 1b 0e 00 00       	call   101ae0 <ilock>
    if((r = writei(f->ip, addr, f->off, n)) > 0)
  100cc5:	89 74 24 0c          	mov    %esi,0xc(%esp)
  100cc9:	8b 43 14             	mov    0x14(%ebx),%eax
  100ccc:	89 7c 24 04          	mov    %edi,0x4(%esp)
  100cd0:	89 44 24 08          	mov    %eax,0x8(%esp)
  100cd4:	8b 43 10             	mov    0x10(%ebx),%eax
  100cd7:	89 04 24             	mov    %eax,(%esp)
  100cda:	e8 71 06 00 00       	call   101350 <writei>
  100cdf:	85 c0                	test   %eax,%eax
  100ce1:	89 c6                	mov    %eax,%esi
  100ce3:	7e 03                	jle    100ce8 <filewrite+0x58>
      f->off += r;
  100ce5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
  100ce8:	8b 43 10             	mov    0x10(%ebx),%eax
  100ceb:	89 04 24             	mov    %eax,(%esp)
  100cee:	e8 cd 09 00 00       	call   1016c0 <iunlock>
    return r;
  }
  panic("filewrite");
}
  100cf3:	89 f0                	mov    %esi,%eax
  100cf5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100cf8:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100cfb:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100cfe:	89 ec                	mov    %ebp,%esp
  100d00:	5d                   	pop    %ebp
  100d01:	c3                   	ret    
    if((r = writei(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
  100d02:	be ff ff ff ff       	mov    $0xffffffff,%esi
  100d07:	eb ea                	jmp    100cf3 <filewrite+0x63>
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  100d09:	8b 43 0c             	mov    0xc(%ebx),%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
}
  100d0c:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100d0f:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100d12:	8b 7d fc             	mov    -0x4(%ebp),%edi
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  100d15:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
}
  100d18:	89 ec                	mov    %ebp,%esp
  100d1a:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  100d1b:	e9 b0 1f 00 00       	jmp    102cd0 <pipewrite>
    if((r = writei(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
  100d20:	c7 04 24 bf 6c 10 00 	movl   $0x106cbf,(%esp)
  100d27:	e8 54 fb ff ff       	call   100880 <panic>
  100d2c:	8d 74 26 00          	lea    0x0(%esi),%esi

00100d30 <fileread>:
}

// Read from file f.  Addr is kernel address.
int
fileread(struct file *f, char *addr, int n)
{
  100d30:	55                   	push   %ebp
  100d31:	89 e5                	mov    %esp,%ebp
  100d33:	83 ec 28             	sub    $0x28,%esp
  100d36:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  100d39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  100d3c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  100d3f:	8b 75 10             	mov    0x10(%ebp),%esi
  100d42:	89 7d fc             	mov    %edi,-0x4(%ebp)
  100d45:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int r;

  if(f->readable == 0)
  100d48:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
  100d4c:	74 54                	je     100da2 <fileread+0x72>
    return -1;
  if(f->type == FD_PIPE)
  100d4e:	8b 03                	mov    (%ebx),%eax
  100d50:	83 f8 01             	cmp    $0x1,%eax
  100d53:	74 54                	je     100da9 <fileread+0x79>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
  100d55:	83 f8 02             	cmp    $0x2,%eax
  100d58:	75 66                	jne    100dc0 <fileread+0x90>
    ilock(f->ip);
  100d5a:	8b 43 10             	mov    0x10(%ebx),%eax
  100d5d:	89 04 24             	mov    %eax,(%esp)
  100d60:	e8 7b 0d 00 00       	call   101ae0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
  100d65:	89 74 24 0c          	mov    %esi,0xc(%esp)
  100d69:	8b 43 14             	mov    0x14(%ebx),%eax
  100d6c:	89 7c 24 04          	mov    %edi,0x4(%esp)
  100d70:	89 44 24 08          	mov    %eax,0x8(%esp)
  100d74:	8b 43 10             	mov    0x10(%ebx),%eax
  100d77:	89 04 24             	mov    %eax,(%esp)
  100d7a:	e8 01 07 00 00       	call   101480 <readi>
  100d7f:	85 c0                	test   %eax,%eax
  100d81:	89 c6                	mov    %eax,%esi
  100d83:	7e 03                	jle    100d88 <fileread+0x58>
      f->off += r;
  100d85:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
  100d88:	8b 43 10             	mov    0x10(%ebx),%eax
  100d8b:	89 04 24             	mov    %eax,(%esp)
  100d8e:	e8 2d 09 00 00       	call   1016c0 <iunlock>
    return r;
  }
  panic("fileread");
}
  100d93:	89 f0                	mov    %esi,%eax
  100d95:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100d98:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100d9b:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100d9e:	89 ec                	mov    %ebp,%esp
  100da0:	5d                   	pop    %ebp
  100da1:	c3                   	ret    
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
  100da2:	be ff ff ff ff       	mov    $0xffffffff,%esi
  100da7:	eb ea                	jmp    100d93 <fileread+0x63>
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  100da9:	8b 43 0c             	mov    0xc(%ebx),%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
  100dac:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100daf:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100db2:	8b 7d fc             	mov    -0x4(%ebp),%edi
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  100db5:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
  100db8:	89 ec                	mov    %ebp,%esp
  100dba:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  100dbb:	e9 00 1e 00 00       	jmp    102bc0 <piperead>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
  100dc0:	c7 04 24 c9 6c 10 00 	movl   $0x106cc9,(%esp)
  100dc7:	e8 b4 fa ff ff       	call   100880 <panic>
  100dcc:	8d 74 26 00          	lea    0x0(%esi),%esi

00100dd0 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  100dd0:	55                   	push   %ebp
  if(f->type == FD_INODE){
  100dd1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  100dd6:	89 e5                	mov    %esp,%ebp
  100dd8:	53                   	push   %ebx
  100dd9:	83 ec 14             	sub    $0x14,%esp
  100ddc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
  100ddf:	83 3b 02             	cmpl   $0x2,(%ebx)
  100de2:	74 0c                	je     100df0 <filestat+0x20>
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
}
  100de4:	83 c4 14             	add    $0x14,%esp
  100de7:	5b                   	pop    %ebx
  100de8:	5d                   	pop    %ebp
  100de9:	c3                   	ret    
  100dea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  if(f->type == FD_INODE){
    ilock(f->ip);
  100df0:	8b 43 10             	mov    0x10(%ebx),%eax
  100df3:	89 04 24             	mov    %eax,(%esp)
  100df6:	e8 e5 0c 00 00       	call   101ae0 <ilock>
    stati(f->ip, st);
  100dfb:	8b 45 0c             	mov    0xc(%ebp),%eax
  100dfe:	89 44 24 04          	mov    %eax,0x4(%esp)
  100e02:	8b 43 10             	mov    0x10(%ebx),%eax
  100e05:	89 04 24             	mov    %eax,(%esp)
  100e08:	e8 c3 01 00 00       	call   100fd0 <stati>
    iunlock(f->ip);
  100e0d:	8b 43 10             	mov    0x10(%ebx),%eax
  100e10:	89 04 24             	mov    %eax,(%esp)
  100e13:	e8 a8 08 00 00       	call   1016c0 <iunlock>
    return 0;
  }
  return -1;
}
  100e18:	83 c4 14             	add    $0x14,%esp
filestat(struct file *f, struct stat *st)
{
  if(f->type == FD_INODE){
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
  100e1b:	31 c0                	xor    %eax,%eax
    return 0;
  }
  return -1;
}
  100e1d:	5b                   	pop    %ebx
  100e1e:	5d                   	pop    %ebp
  100e1f:	c3                   	ret    

00100e20 <filedup>:
}

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
  100e20:	55                   	push   %ebp
  100e21:	89 e5                	mov    %esp,%ebp
  100e23:	53                   	push   %ebx
  100e24:	83 ec 04             	sub    $0x4,%esp
  100e27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
  100e2a:	c7 04 24 00 a6 10 00 	movl   $0x10a600,(%esp)
  100e31:	e8 5a 2e 00 00       	call   103c90 <acquire>
  if(f->ref < 1)
  100e36:	8b 43 04             	mov    0x4(%ebx),%eax
  100e39:	85 c0                	test   %eax,%eax
  100e3b:	7e 1a                	jle    100e57 <filedup+0x37>
    panic("filedup");
  f->ref++;
  100e3d:	83 c0 01             	add    $0x1,%eax
  100e40:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
  100e43:	c7 04 24 00 a6 10 00 	movl   $0x10a600,(%esp)
  100e4a:	e8 01 2e 00 00       	call   103c50 <release>
  return f;
}
  100e4f:	89 d8                	mov    %ebx,%eax
  100e51:	83 c4 04             	add    $0x4,%esp
  100e54:	5b                   	pop    %ebx
  100e55:	5d                   	pop    %ebp
  100e56:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  100e57:	c7 04 24 d2 6c 10 00 	movl   $0x106cd2,(%esp)
  100e5e:	e8 1d fa ff ff       	call   100880 <panic>
  100e63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00100e70 <filealloc>:
}

// Allocate a file structure.
struct file*
filealloc(void)
{
  100e70:	55                   	push   %ebp
  100e71:	89 e5                	mov    %esp,%ebp
  100e73:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  100e74:	bb 34 a6 10 00       	mov    $0x10a634,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
  100e79:	83 ec 04             	sub    $0x4,%esp
  struct file *f;

  acquire(&ftable.lock);
  100e7c:	c7 04 24 00 a6 10 00 	movl   $0x10a600,(%esp)
  100e83:	e8 08 2e 00 00       	call   103c90 <acquire>
  100e88:	eb 11                	jmp    100e9b <filealloc+0x2b>
  100e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
  100e90:	83 c3 18             	add    $0x18,%ebx
  100e93:	81 fb 94 af 10 00    	cmp    $0x10af94,%ebx
  100e99:	74 22                	je     100ebd <filealloc+0x4d>
    if(f->ref == 0){
  100e9b:	8b 43 04             	mov    0x4(%ebx),%eax
  100e9e:	85 c0                	test   %eax,%eax
  100ea0:	75 ee                	jne    100e90 <filealloc+0x20>
      f->ref = 1;
  100ea2:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
  100ea9:	c7 04 24 00 a6 10 00 	movl   $0x10a600,(%esp)
  100eb0:	e8 9b 2d 00 00       	call   103c50 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
  100eb5:	89 d8                	mov    %ebx,%eax
  100eb7:	83 c4 04             	add    $0x4,%esp
  100eba:	5b                   	pop    %ebx
  100ebb:	5d                   	pop    %ebp
  100ebc:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
  100ebd:	c7 04 24 00 a6 10 00 	movl   $0x10a600,(%esp)
  100ec4:	31 db                	xor    %ebx,%ebx
  100ec6:	e8 85 2d 00 00       	call   103c50 <release>
  return 0;
}
  100ecb:	89 d8                	mov    %ebx,%eax
  100ecd:	83 c4 04             	add    $0x4,%esp
  100ed0:	5b                   	pop    %ebx
  100ed1:	5d                   	pop    %ebp
  100ed2:	c3                   	ret    
  100ed3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00100ee0 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
  100ee0:	55                   	push   %ebp
  100ee1:	89 e5                	mov    %esp,%ebp
  100ee3:	83 ec 28             	sub    $0x28,%esp
  100ee6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  100ee9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  100eec:	89 75 f8             	mov    %esi,-0x8(%ebp)
  100eef:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct file ff;

  acquire(&ftable.lock);
  100ef2:	c7 04 24 00 a6 10 00 	movl   $0x10a600,(%esp)
  100ef9:	e8 92 2d 00 00       	call   103c90 <acquire>
  if(f->ref < 1)
  100efe:	8b 43 04             	mov    0x4(%ebx),%eax
  100f01:	85 c0                	test   %eax,%eax
  100f03:	0f 8e 96 00 00 00    	jle    100f9f <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
  100f09:	83 e8 01             	sub    $0x1,%eax
  100f0c:	85 c0                	test   %eax,%eax
  100f0e:	89 43 04             	mov    %eax,0x4(%ebx)
  100f11:	74 1d                	je     100f30 <fileclose+0x50>
    release(&ftable.lock);
  100f13:	c7 45 08 00 a6 10 00 	movl   $0x10a600,0x8(%ebp)
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
}
  100f1a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100f1d:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100f20:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100f23:	89 ec                	mov    %ebp,%esp
  100f25:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
  100f26:	e9 25 2d 00 00       	jmp    103c50 <release>
  100f2b:	90                   	nop    
  100f2c:	8d 74 26 00          	lea    0x0(%esi),%esi
    return;
  }
  ff = *f;
  100f30:	8b 43 10             	mov    0x10(%ebx),%eax
  100f33:	89 45 ec             	mov    %eax,-0x14(%ebp)
  100f36:	8b 53 0c             	mov    0xc(%ebx),%edx
  100f39:	89 55 f0             	mov    %edx,-0x10(%ebp)
  100f3c:	8b 33                	mov    (%ebx),%esi
  100f3e:	0f b6 7b 09          	movzbl 0x9(%ebx),%edi
  f->ref = 0;
  100f42:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
  f->type = FD_NONE;
  100f49:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  release(&ftable.lock);
  100f4f:	c7 04 24 00 a6 10 00 	movl   $0x10a600,(%esp)
  100f56:	e8 f5 2c 00 00       	call   103c50 <release>
  
  if(ff.type == FD_PIPE)
  100f5b:	83 fe 01             	cmp    $0x1,%esi
  100f5e:	74 12                	je     100f72 <fileclose+0x92>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
  100f60:	83 fe 02             	cmp    $0x2,%esi
  100f63:	74 23                	je     100f88 <fileclose+0xa8>
    iput(ff.ip);
}
  100f65:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100f68:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100f6b:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100f6e:	89 ec                	mov    %ebp,%esp
  100f70:	5d                   	pop    %ebp
  100f71:	c3                   	ret    
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  100f72:	89 fa                	mov    %edi,%edx
  100f74:	0f be c2             	movsbl %dl,%eax
  100f77:	89 44 24 04          	mov    %eax,0x4(%esp)
  100f7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100f7e:	89 04 24             	mov    %eax,(%esp)
  100f81:	e8 2a 1e 00 00       	call   102db0 <pipeclose>
  100f86:	eb dd                	jmp    100f65 <fileclose+0x85>
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  100f88:	8b 55 ec             	mov    -0x14(%ebp),%edx
}
  100f8b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100f8e:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100f91:	8b 7d fc             	mov    -0x4(%ebp),%edi
  release(&ftable.lock);
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  100f94:	89 55 08             	mov    %edx,0x8(%ebp)
}
  100f97:	89 ec                	mov    %ebp,%esp
  100f99:	5d                   	pop    %ebp
  release(&ftable.lock);
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  100f9a:	e9 f1 08 00 00       	jmp    101890 <iput>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  100f9f:	c7 04 24 da 6c 10 00 	movl   $0x106cda,(%esp)
  100fa6:	e8 d5 f8 ff ff       	call   100880 <panic>
  100fab:	90                   	nop    
  100fac:	8d 74 26 00          	lea    0x0(%esi),%esi

00100fb0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
  100fb0:	55                   	push   %ebp
  100fb1:	89 e5                	mov    %esp,%ebp
  100fb3:	83 ec 08             	sub    $0x8,%esp
  initlock(&ftable.lock, "ftable");
  100fb6:	c7 44 24 04 e4 6c 10 	movl   $0x106ce4,0x4(%esp)
  100fbd:	00 
  100fbe:	c7 04 24 00 a6 10 00 	movl   $0x10a600,(%esp)
  100fc5:	e8 46 2b 00 00       	call   103b10 <initlock>
}
  100fca:	c9                   	leave  
  100fcb:	c3                   	ret    
  100fcc:	90                   	nop    
  100fcd:	90                   	nop    
  100fce:	90                   	nop    
  100fcf:	90                   	nop    

00100fd0 <stati>:
}

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
  100fd0:	55                   	push   %ebp
  100fd1:	89 e5                	mov    %esp,%ebp
  100fd3:	8b 55 08             	mov    0x8(%ebp),%edx
  100fd6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  st->dev = ip->dev;
  100fd9:	8b 02                	mov    (%edx),%eax
  100fdb:	89 41 04             	mov    %eax,0x4(%ecx)
  st->ino = ip->inum;
  100fde:	8b 42 04             	mov    0x4(%edx),%eax
  100fe1:	89 41 08             	mov    %eax,0x8(%ecx)
  st->type = ip->type;
  100fe4:	0f b7 42 10          	movzwl 0x10(%edx),%eax
  100fe8:	66 89 01             	mov    %ax,(%ecx)
  st->nlink = ip->nlink;
  100feb:	0f b7 42 16          	movzwl 0x16(%edx),%eax
  100fef:	66 89 41 0c          	mov    %ax,0xc(%ecx)
  st->size = ip->size;
  100ff3:	8b 42 18             	mov    0x18(%edx),%eax
  100ff6:	89 41 10             	mov    %eax,0x10(%ecx)
}
  100ff9:	5d                   	pop    %ebp
  100ffa:	c3                   	ret    
  100ffb:	90                   	nop    
  100ffc:	8d 74 26 00          	lea    0x0(%esi),%esi

00101000 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  101000:	55                   	push   %ebp
  101001:	89 e5                	mov    %esp,%ebp
  101003:	53                   	push   %ebx
  101004:	83 ec 04             	sub    $0x4,%esp
  101007:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
  10100a:	c7 04 24 00 b0 10 00 	movl   $0x10b000,(%esp)
  101011:	e8 7a 2c 00 00       	call   103c90 <acquire>
  ip->ref++;
  101016:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
  10101a:	c7 04 24 00 b0 10 00 	movl   $0x10b000,(%esp)
  101021:	e8 2a 2c 00 00       	call   103c50 <release>
  return ip;
}
  101026:	89 d8                	mov    %ebx,%eax
  101028:	83 c4 04             	add    $0x4,%esp
  10102b:	5b                   	pop    %ebx
  10102c:	5d                   	pop    %ebp
  10102d:	c3                   	ret    
  10102e:	66 90                	xchg   %ax,%ax

00101030 <iget>:

// Find the inode with number inum on device dev
// and return the in-memory copy.
static struct inode*
iget(uint dev, uint inum)
{
  101030:	55                   	push   %ebp
  101031:	89 e5                	mov    %esp,%ebp
  101033:	57                   	push   %edi
  101034:	89 c7                	mov    %eax,%edi
  101036:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);
  101037:	31 f6                	xor    %esi,%esi

// Find the inode with number inum on device dev
// and return the in-memory copy.
static struct inode*
iget(uint dev, uint inum)
{
  101039:	53                   	push   %ebx
  struct inode *ip, *empty;

  acquire(&icache.lock);
  10103a:	bb 34 b0 10 00       	mov    $0x10b034,%ebx

// Find the inode with number inum on device dev
// and return the in-memory copy.
static struct inode*
iget(uint dev, uint inum)
{
  10103f:	83 ec 0c             	sub    $0xc,%esp
  101042:	89 55 f0             	mov    %edx,-0x10(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
  101045:	c7 04 24 00 b0 10 00 	movl   $0x10b000,(%esp)
  10104c:	e8 3f 2c 00 00       	call   103c90 <acquire>
  101051:	eb 0f                	jmp    101062 <iget+0x32>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
  101053:	85 f6                	test   %esi,%esi
  101055:	74 3a                	je     101091 <iget+0x61>

  acquire(&icache.lock);

  // Try for cached inode.
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  101057:	83 c3 50             	add    $0x50,%ebx
  10105a:	81 fb d4 bf 10 00    	cmp    $0x10bfd4,%ebx
  101060:	74 40                	je     1010a2 <iget+0x72>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
  101062:	8b 43 08             	mov    0x8(%ebx),%eax
  101065:	85 c0                	test   %eax,%eax
  101067:	7e ea                	jle    101053 <iget+0x23>
  101069:	39 3b                	cmp    %edi,(%ebx)
  10106b:	75 e6                	jne    101053 <iget+0x23>
  10106d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  101070:	39 53 04             	cmp    %edx,0x4(%ebx)
  101073:	75 de                	jne    101053 <iget+0x23>
      ip->ref++;
  101075:	83 c0 01             	add    $0x1,%eax
  101078:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
  10107b:	c7 04 24 00 b0 10 00 	movl   $0x10b000,(%esp)
  101082:	e8 c9 2b 00 00       	call   103c50 <release>
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);

  return ip;
}
  101087:	83 c4 0c             	add    $0xc,%esp
  10108a:	89 d8                	mov    %ebx,%eax
  10108c:	5b                   	pop    %ebx
  10108d:	5e                   	pop    %esi
  10108e:	5f                   	pop    %edi
  10108f:	5d                   	pop    %ebp
  101090:	c3                   	ret    
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
  101091:	85 c0                	test   %eax,%eax
  101093:	75 c2                	jne    101057 <iget+0x27>
  101095:	89 de                	mov    %ebx,%esi

  acquire(&icache.lock);

  // Try for cached inode.
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  101097:	83 c3 50             	add    $0x50,%ebx
  10109a:	81 fb d4 bf 10 00    	cmp    $0x10bfd4,%ebx
  1010a0:	75 c0                	jne    101062 <iget+0x32>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Allocate fresh inode.
  if(empty == 0)
  1010a2:	85 f6                	test   %esi,%esi
  1010a4:	74 2e                	je     1010d4 <iget+0xa4>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
  1010a6:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
  1010a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);
  1010ab:	89 f3                	mov    %esi,%ebx
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  1010ad:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
  1010b4:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  1010bb:	89 46 04             	mov    %eax,0x4(%esi)
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);
  1010be:	c7 04 24 00 b0 10 00 	movl   $0x10b000,(%esp)
  1010c5:	e8 86 2b 00 00       	call   103c50 <release>

  return ip;
}
  1010ca:	83 c4 0c             	add    $0xc,%esp
  1010cd:	89 d8                	mov    %ebx,%eax
  1010cf:	5b                   	pop    %ebx
  1010d0:	5e                   	pop    %esi
  1010d1:	5f                   	pop    %edi
  1010d2:	5d                   	pop    %ebp
  1010d3:	c3                   	ret    
      empty = ip;
  }

  // Allocate fresh inode.
  if(empty == 0)
    panic("iget: no inodes");
  1010d4:	c7 04 24 eb 6c 10 00 	movl   $0x106ceb,(%esp)
  1010db:	e8 a0 f7 ff ff       	call   100880 <panic>

001010e0 <readsb>:
static void itrunc(struct inode*);

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
  1010e0:	55                   	push   %ebp
  1010e1:	89 e5                	mov    %esp,%ebp
  1010e3:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
  1010e6:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1010ed:	00 
static void itrunc(struct inode*);

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
  1010ee:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  1010f1:	89 75 fc             	mov    %esi,-0x4(%ebp)
  1010f4:	89 d6                	mov    %edx,%esi
  struct buf *bp;
  
  bp = bread(dev, 1);
  1010f6:	89 04 24             	mov    %eax,(%esp)
  1010f9:	e8 a2 ef ff ff       	call   1000a0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
  1010fe:	89 34 24             	mov    %esi,(%esp)
  101101:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
  101108:	00 
static void
readsb(int dev, struct superblock *sb)
{
  struct buf *bp;
  
  bp = bread(dev, 1);
  101109:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
  10110b:	8d 40 18             	lea    0x18(%eax),%eax
  10110e:	89 44 24 04          	mov    %eax,0x4(%esp)
  101112:	e8 89 2c 00 00       	call   103da0 <memmove>
  brelse(bp);
  101117:	89 1c 24             	mov    %ebx,(%esp)
  10111a:	e8 e1 ee ff ff       	call   100000 <brelse>
}
  10111f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  101122:	8b 75 fc             	mov    -0x4(%ebp),%esi
  101125:	89 ec                	mov    %ebp,%esp
  101127:	5d                   	pop    %ebp
  101128:	c3                   	ret    
  101129:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00101130 <iupdate>:
}

// Copy inode, which has changed, from memory to disk.
void
iupdate(struct inode *ip)
{
  101130:	55                   	push   %ebp
  101131:	89 e5                	mov    %esp,%ebp
  101133:	56                   	push   %esi
  101134:	53                   	push   %ebx
  101135:	83 ec 10             	sub    $0x10,%esp
  101138:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
  10113b:	8b 43 04             	mov    0x4(%ebx),%eax
  10113e:	c1 e8 03             	shr    $0x3,%eax
  101141:	83 c0 02             	add    $0x2,%eax
  101144:	89 44 24 04          	mov    %eax,0x4(%esp)
  101148:	8b 03                	mov    (%ebx),%eax
  10114a:	89 04 24             	mov    %eax,(%esp)
  10114d:	e8 4e ef ff ff       	call   1000a0 <bread>
  101152:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  101154:	8b 43 04             	mov    0x4(%ebx),%eax
  101157:	83 e0 07             	and    $0x7,%eax
  10115a:	c1 e0 06             	shl    $0x6,%eax
  10115d:	8d 54 06 18          	lea    0x18(%esi,%eax,1),%edx
  dip->type = ip->type;
  101161:	0f b7 43 10          	movzwl 0x10(%ebx),%eax
  101165:	66 89 02             	mov    %ax,(%edx)
  dip->major = ip->major;
  101168:	0f b7 43 12          	movzwl 0x12(%ebx),%eax
  10116c:	66 89 42 02          	mov    %ax,0x2(%edx)
  dip->minor = ip->minor;
  101170:	0f b7 43 14          	movzwl 0x14(%ebx),%eax
  101174:	66 89 42 04          	mov    %ax,0x4(%edx)
  dip->nlink = ip->nlink;
  101178:	0f b7 43 16          	movzwl 0x16(%ebx),%eax
  10117c:	66 89 42 06          	mov    %ax,0x6(%edx)
  dip->size = ip->size;
  101180:	8b 43 18             	mov    0x18(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  101183:	83 c3 1c             	add    $0x1c,%ebx
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  101186:	89 42 08             	mov    %eax,0x8(%edx)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  101189:	83 c2 0c             	add    $0xc,%edx
  10118c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  101190:	89 14 24             	mov    %edx,(%esp)
  101193:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
  10119a:	00 
  10119b:	e8 00 2c 00 00       	call   103da0 <memmove>
  bwrite(bp);
  1011a0:	89 34 24             	mov    %esi,(%esp)
  1011a3:	e8 c8 ee ff ff       	call   100070 <bwrite>
  brelse(bp);
  1011a8:	89 75 08             	mov    %esi,0x8(%ebp)
}
  1011ab:	83 c4 10             	add    $0x10,%esp
  1011ae:	5b                   	pop    %ebx
  1011af:	5e                   	pop    %esi
  1011b0:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  bwrite(bp);
  brelse(bp);
  1011b1:	e9 4a ee ff ff       	jmp    100000 <brelse>
  1011b6:	8d 76 00             	lea    0x0(%esi),%esi
  1011b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001011c0 <balloc>:
// Blocks. 

// Allocate a disk block.
static uint
balloc(uint dev)
{
  1011c0:	55                   	push   %ebp
  1011c1:	89 e5                	mov    %esp,%ebp
  1011c3:	57                   	push   %edi
  1011c4:	56                   	push   %esi
  1011c5:	53                   	push   %ebx
  1011c6:	83 ec 2c             	sub    $0x2c,%esp
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  1011c9:	8d 55 e8             	lea    -0x18(%ebp),%edx
// Blocks. 

// Allocate a disk block.
static uint
balloc(uint dev)
{
  1011cc:	89 45 dc             	mov    %eax,-0x24(%ebp)
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  1011cf:	e8 0c ff ff ff       	call   1010e0 <readsb>
  for(b = 0; b < sb.size; b += BPB){
  1011d4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1011d7:	85 c0                	test   %eax,%eax
  1011d9:	0f 84 a6 00 00 00    	je     101285 <balloc+0xc5>
  1011df:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    bp = bread(dev, BBLOCK(b, sb.ninodes));
  1011e6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1011e9:	31 f6                	xor    %esi,%esi
  1011eb:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1011ee:	c1 f8 1f             	sar    $0x1f,%eax
  1011f1:	c1 e8 14             	shr    $0x14,%eax
  1011f4:	03 45 e0             	add    -0x20(%ebp),%eax
  1011f7:	c1 ea 03             	shr    $0x3,%edx
  1011fa:	c1 f8 0c             	sar    $0xc,%eax
  1011fd:	8d 54 02 03          	lea    0x3(%edx,%eax,1),%edx
  101201:	8b 45 dc             	mov    -0x24(%ebp),%eax
  101204:	89 54 24 04          	mov    %edx,0x4(%esp)
  101208:	89 04 24             	mov    %eax,(%esp)
  10120b:	e8 90 ee ff ff       	call   1000a0 <bread>
  101210:	89 c7                	mov    %eax,%edi
  101212:	eb 0b                	jmp    10121f <balloc+0x5f>
    for(bi = 0; bi < BPB; bi++){
  101214:	83 c6 01             	add    $0x1,%esi
  101217:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
  10121d:	74 4b                	je     10126a <balloc+0xaa>
      m = 1 << (bi % 8);
  10121f:	89 f0                	mov    %esi,%eax
  101221:	bb 01 00 00 00       	mov    $0x1,%ebx
  101226:	c1 f8 1f             	sar    $0x1f,%eax
  101229:	c1 e8 1d             	shr    $0x1d,%eax
  10122c:	8d 14 06             	lea    (%esi,%eax,1),%edx
  10122f:	89 d1                	mov    %edx,%ecx
  101231:	83 e1 07             	and    $0x7,%ecx
  101234:	29 c1                	sub    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
  101236:	c1 fa 03             	sar    $0x3,%edx
  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB; bi++){
      m = 1 << (bi % 8);
  101239:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
  10123b:	0f b6 4c 17 18       	movzbl 0x18(%edi,%edx,1),%ecx
  101240:	0f b6 c1             	movzbl %cl,%eax
  101243:	85 d8                	test   %ebx,%eax
  101245:	75 cd                	jne    101214 <balloc+0x54>
        bp->data[bi/8] |= m;  // Mark block in use on disk.
  101247:	09 d9                	or     %ebx,%ecx
  101249:	88 4c 17 18          	mov    %cl,0x18(%edi,%edx,1)
        bwrite(bp);
  10124d:	89 3c 24             	mov    %edi,(%esp)
  101250:	e8 1b ee ff ff       	call   100070 <bwrite>
        brelse(bp);
  101255:	89 3c 24             	mov    %edi,(%esp)
  101258:	e8 a3 ed ff ff       	call   100000 <brelse>
  10125d:	8b 45 e0             	mov    -0x20(%ebp),%eax
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
  101260:	83 c4 2c             	add    $0x2c,%esp
  101263:	5b                   	pop    %ebx
    for(bi = 0; bi < BPB; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use on disk.
        bwrite(bp);
        brelse(bp);
  101264:	01 f0                	add    %esi,%eax
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
  101266:	5e                   	pop    %esi
  101267:	5f                   	pop    %edi
  101268:	5d                   	pop    %ebp
  101269:	c3                   	ret    
        bwrite(bp);
        brelse(bp);
        return b + bi;
      }
    }
    brelse(bp);
  10126a:	89 3c 24             	mov    %edi,(%esp)
  10126d:	e8 8e ed ff ff       	call   100000 <brelse>
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
  101272:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  101279:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10127c:	39 45 e8             	cmp    %eax,-0x18(%ebp)
  10127f:	0f 87 61 ff ff ff    	ja     1011e6 <balloc+0x26>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
  101285:	c7 04 24 fb 6c 10 00 	movl   $0x106cfb,(%esp)
  10128c:	e8 ef f5 ff ff       	call   100880 <panic>
  101291:	eb 0d                	jmp    1012a0 <bmap>
  101293:	90                   	nop    
  101294:	90                   	nop    
  101295:	90                   	nop    
  101296:	90                   	nop    
  101297:	90                   	nop    
  101298:	90                   	nop    
  101299:	90                   	nop    
  10129a:	90                   	nop    
  10129b:	90                   	nop    
  10129c:	90                   	nop    
  10129d:	90                   	nop    
  10129e:	90                   	nop    
  10129f:	90                   	nop    

001012a0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
  1012a0:	55                   	push   %ebp
  1012a1:	89 e5                	mov    %esp,%ebp
  1012a3:	83 ec 18             	sub    $0x18,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
  1012a6:	83 fa 0b             	cmp    $0xb,%edx

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
  1012a9:	89 75 f8             	mov    %esi,-0x8(%ebp)
  1012ac:	89 d6                	mov    %edx,%esi
  1012ae:	89 7d fc             	mov    %edi,-0x4(%ebp)
  1012b1:	89 c7                	mov    %eax,%edi
  1012b3:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
  1012b6:	77 18                	ja     1012d0 <bmap+0x30>
    if((addr = ip->addrs[bn]) == 0)
  1012b8:	8b 5c 90 1c          	mov    0x1c(%eax,%edx,4),%ebx
  1012bc:	85 db                	test   %ebx,%ebx
  1012be:	74 46                	je     101306 <bmap+0x66>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
  1012c0:	89 d8                	mov    %ebx,%eax
  1012c2:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1012c5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1012c8:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1012cb:	89 ec                	mov    %ebp,%esp
  1012cd:	5d                   	pop    %ebp
  1012ce:	c3                   	ret    
  1012cf:	90                   	nop    
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
  1012d0:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
  1012d3:	83 fb 7f             	cmp    $0x7f,%ebx
  1012d6:	77 64                	ja     10133c <bmap+0x9c>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
  1012d8:	8b 40 4c             	mov    0x4c(%eax),%eax
  1012db:	85 c0                	test   %eax,%eax
  1012dd:	74 51                	je     101330 <bmap+0x90>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
  1012df:	89 44 24 04          	mov    %eax,0x4(%esp)
  1012e3:	8b 07                	mov    (%edi),%eax
  1012e5:	89 04 24             	mov    %eax,(%esp)
  1012e8:	e8 b3 ed ff ff       	call   1000a0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
  1012ed:	8d 5c 98 18          	lea    0x18(%eax,%ebx,4),%ebx

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
  1012f1:	89 c6                	mov    %eax,%esi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
  1012f3:	89 5d f0             	mov    %ebx,-0x10(%ebp)
  1012f6:	8b 1b                	mov    (%ebx),%ebx
  1012f8:	85 db                	test   %ebx,%ebx
  1012fa:	74 19                	je     101315 <bmap+0x75>
      a[bn] = addr = balloc(ip->dev);
      bwrite(bp);
    }
    brelse(bp);
  1012fc:	89 34 24             	mov    %esi,(%esp)
  1012ff:	e8 fc ec ff ff       	call   100000 <brelse>
  101304:	eb ba                	jmp    1012c0 <bmap+0x20>
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
  101306:	8b 00                	mov    (%eax),%eax
  101308:	e8 b3 fe ff ff       	call   1011c0 <balloc>
  10130d:	89 c3                	mov    %eax,%ebx
  10130f:	89 44 b7 1c          	mov    %eax,0x1c(%edi,%esi,4)
  101313:	eb ab                	jmp    1012c0 <bmap+0x20>
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
  101315:	8b 07                	mov    (%edi),%eax
  101317:	e8 a4 fe ff ff       	call   1011c0 <balloc>
  10131c:	89 c3                	mov    %eax,%ebx
  10131e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101321:	89 18                	mov    %ebx,(%eax)
      bwrite(bp);
  101323:	89 34 24             	mov    %esi,(%esp)
  101326:	e8 45 ed ff ff       	call   100070 <bwrite>
  10132b:	eb cf                	jmp    1012fc <bmap+0x5c>
  10132d:	8d 76 00             	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
  101330:	8b 07                	mov    (%edi),%eax
  101332:	e8 89 fe ff ff       	call   1011c0 <balloc>
  101337:	89 47 4c             	mov    %eax,0x4c(%edi)
  10133a:	eb a3                	jmp    1012df <bmap+0x3f>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
  10133c:	c7 04 24 11 6d 10 00 	movl   $0x106d11,(%esp)
  101343:	e8 38 f5 ff ff       	call   100880 <panic>
  101348:	90                   	nop    
  101349:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00101350 <writei>:
}

// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
  101350:	55                   	push   %ebp
  101351:	89 e5                	mov    %esp,%ebp
  101353:	83 ec 28             	sub    $0x28,%esp
  101356:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  101359:	8b 45 0c             	mov    0xc(%ebp),%eax
  10135c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  10135f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  101362:	89 75 f8             	mov    %esi,-0x8(%ebp)
  101365:	8b 75 10             	mov    0x10(%ebp),%esi
  101368:	89 7d fc             	mov    %edi,-0x4(%ebp)
  10136b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  10136e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  101371:	66 83 7b 10 03       	cmpw   $0x3,0x10(%ebx)
  101376:	74 18                	je     101390 <writei+0x40>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
  101378:	39 73 18             	cmp    %esi,0x18(%ebx)
  10137b:	73 3d                	jae    1013ba <writei+0x6a>

  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
  10137d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  101382:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  101385:	8b 75 f8             	mov    -0x8(%ebp),%esi
  101388:	8b 7d fc             	mov    -0x4(%ebp),%edi
  10138b:	89 ec                	mov    %ebp,%esp
  10138d:	5d                   	pop    %ebp
  10138e:	c3                   	ret    
  10138f:	90                   	nop    
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
  101390:	0f b7 43 12          	movzwl 0x12(%ebx),%eax
  101394:	66 83 f8 09          	cmp    $0x9,%ax
  101398:	77 e3                	ja     10137d <writei+0x2d>
  10139a:	98                   	cwtl   
  10139b:	8b 0c c5 a4 af 10 00 	mov    0x10afa4(,%eax,8),%ecx
  1013a2:	85 c9                	test   %ecx,%ecx
  1013a4:	74 d7                	je     10137d <writei+0x2d>
      return -1;
    return devsw[ip->major].write(ip, src, n);
  1013a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
  1013a9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1013ac:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1013af:	8b 7d fc             	mov    -0x4(%ebp),%edi
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  1013b2:	89 45 10             	mov    %eax,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
  1013b5:	89 ec                	mov    %ebp,%esp
  1013b7:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  1013b8:	ff e1                	jmp    *%ecx
  }

  if(off > ip->size || off + n < off)
  1013ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1013bd:	01 f0                	add    %esi,%eax
  1013bf:	39 c6                	cmp    %eax,%esi
  1013c1:	77 ba                	ja     10137d <writei+0x2d>
    return -1;
  if(off + n > MAXFILE*BSIZE)
  1013c3:	3d 00 18 01 00       	cmp    $0x11800,%eax
  1013c8:	76 0a                	jbe    1013d4 <writei+0x84>
    n = MAXFILE*BSIZE - off;
  1013ca:	c7 45 e4 00 18 01 00 	movl   $0x11800,-0x1c(%ebp)
  1013d1:	29 75 e4             	sub    %esi,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  1013d4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1013d7:	85 d2                	test   %edx,%edx
  1013d9:	0f 84 8f 00 00 00    	je     10146e <writei+0x11e>
  1013df:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  1013e6:	89 f2                	mov    %esi,%edx
  1013e8:	89 d8                	mov    %ebx,%eax
  1013ea:	c1 ea 09             	shr    $0x9,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
  1013ed:	bf 00 02 00 00       	mov    $0x200,%edi
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  1013f2:	e8 a9 fe ff ff       	call   1012a0 <bmap>
  1013f7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1013fb:	8b 03                	mov    (%ebx),%eax
  1013fd:	89 04 24             	mov    %eax,(%esp)
  101400:	e8 9b ec ff ff       	call   1000a0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
  101405:	89 f2                	mov    %esi,%edx
  101407:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  10140d:	29 d7                	sub    %edx,%edi
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  10140f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
  101412:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101415:	2b 45 ec             	sub    -0x14(%ebp),%eax
  101418:	39 c7                	cmp    %eax,%edi
  10141a:	76 02                	jbe    10141e <writei+0xce>
  10141c:	89 c7                	mov    %eax,%edi
    memmove(bp->data + off%BSIZE, src, m);
  10141e:	89 7c 24 08          	mov    %edi,0x8(%esp)
  101422:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  101425:	01 fe                	add    %edi,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
  101427:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  10142b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  10142e:	8d 44 11 18          	lea    0x18(%ecx,%edx,1),%eax
  101432:	89 04 24             	mov    %eax,(%esp)
  101435:	e8 66 29 00 00       	call   103da0 <memmove>
    bwrite(bp);
  10143a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10143d:	89 04 24             	mov    %eax,(%esp)
  101440:	e8 2b ec ff ff       	call   100070 <bwrite>
    brelse(bp);
  101445:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  101448:	89 0c 24             	mov    %ecx,(%esp)
  10144b:	e8 b0 eb ff ff       	call   100000 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  101450:	01 7d ec             	add    %edi,-0x14(%ebp)
  101453:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101456:	01 7d e8             	add    %edi,-0x18(%ebp)
  101459:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
  10145c:	77 88                	ja     1013e6 <writei+0x96>
    memmove(bp->data + off%BSIZE, src, m);
    bwrite(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
  10145e:	39 73 18             	cmp    %esi,0x18(%ebx)
  101461:	73 0b                	jae    10146e <writei+0x11e>
    ip->size = off;
  101463:	89 73 18             	mov    %esi,0x18(%ebx)
    iupdate(ip);
  101466:	89 1c 24             	mov    %ebx,(%esp)
  101469:	e8 c2 fc ff ff       	call   101130 <iupdate>
  }
  return n;
  10146e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101471:	e9 0c ff ff ff       	jmp    101382 <writei+0x32>
  101476:	8d 76 00             	lea    0x0(%esi),%esi
  101479:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00101480 <readi>:
}

// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
  101480:	55                   	push   %ebp
  101481:	89 e5                	mov    %esp,%ebp
  101483:	83 ec 28             	sub    $0x28,%esp
  101486:	89 7d fc             	mov    %edi,-0x4(%ebp)
  101489:	8b 45 0c             	mov    0xc(%ebp),%eax
  10148c:	8b 7d 08             	mov    0x8(%ebp),%edi
  10148f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  101492:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  101495:	8b 5d 10             	mov    0x10(%ebp),%ebx
  101498:	89 75 f8             	mov    %esi,-0x8(%ebp)
  10149b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  10149e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  1014a1:	66 83 7f 10 03       	cmpw   $0x3,0x10(%edi)
  1014a6:	74 19                	je     1014c1 <readi+0x41>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
  1014a8:	8b 47 18             	mov    0x18(%edi),%eax
  1014ab:	39 d8                	cmp    %ebx,%eax
  1014ad:	73 3c                	jae    1014eb <readi+0x6b>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
  1014af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1014b4:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1014b7:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1014ba:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1014bd:	89 ec                	mov    %ebp,%esp
  1014bf:	5d                   	pop    %ebp
  1014c0:	c3                   	ret    
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
  1014c1:	0f b7 47 12          	movzwl 0x12(%edi),%eax
  1014c5:	66 83 f8 09          	cmp    $0x9,%ax
  1014c9:	77 e4                	ja     1014af <readi+0x2f>
  1014cb:	98                   	cwtl   
  1014cc:	8b 0c c5 a0 af 10 00 	mov    0x10afa0(,%eax,8),%ecx
  1014d3:	85 c9                	test   %ecx,%ecx
  1014d5:	74 d8                	je     1014af <readi+0x2f>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  1014d7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
  1014da:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1014dd:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1014e0:	8b 7d fc             	mov    -0x4(%ebp),%edi
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  1014e3:	89 45 10             	mov    %eax,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
  1014e6:	89 ec                	mov    %ebp,%esp
  1014e8:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  1014e9:	ff e1                	jmp    *%ecx
  }

  if(off > ip->size || off + n < off)
  1014eb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1014ee:	01 da                	add    %ebx,%edx
  1014f0:	39 d3                	cmp    %edx,%ebx
  1014f2:	77 bb                	ja     1014af <readi+0x2f>
    return -1;
  if(off + n > ip->size)
  1014f4:	39 d0                	cmp    %edx,%eax
  1014f6:	73 05                	jae    1014fd <readi+0x7d>
    n = ip->size - off;
  1014f8:	29 d8                	sub    %ebx,%eax
  1014fa:	89 45 e4             	mov    %eax,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  1014fd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  101500:	85 c9                	test   %ecx,%ecx
  101502:	74 79                	je     10157d <readi+0xfd>
  101504:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  10150b:	90                   	nop    
  10150c:	8d 74 26 00          	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  101510:	89 da                	mov    %ebx,%edx
  101512:	89 f8                	mov    %edi,%eax
  101514:	c1 ea 09             	shr    $0x9,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
  101517:	be 00 02 00 00       	mov    $0x200,%esi
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  10151c:	e8 7f fd ff ff       	call   1012a0 <bmap>
  101521:	89 44 24 04          	mov    %eax,0x4(%esp)
  101525:	8b 07                	mov    (%edi),%eax
  101527:	89 04 24             	mov    %eax,(%esp)
  10152a:	e8 71 eb ff ff       	call   1000a0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
  10152f:	89 da                	mov    %ebx,%edx
  101531:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  101537:	29 d6                	sub    %edx,%esi
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  101539:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
  10153c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10153f:	2b 45 ec             	sub    -0x14(%ebp),%eax
  101542:	39 c6                	cmp    %eax,%esi
  101544:	76 02                	jbe    101548 <readi+0xc8>
  101546:	89 c6                	mov    %eax,%esi
    memmove(dst, bp->data + off%BSIZE, m);
  101548:	89 74 24 08          	mov    %esi,0x8(%esp)
  10154c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  10154f:	01 f3                	add    %esi,%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
  101551:	8d 44 11 18          	lea    0x18(%ecx,%edx,1),%eax
  101555:	89 44 24 04          	mov    %eax,0x4(%esp)
  101559:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10155c:	89 04 24             	mov    %eax,(%esp)
  10155f:	e8 3c 28 00 00       	call   103da0 <memmove>
    brelse(bp);
  101564:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  101567:	89 0c 24             	mov    %ecx,(%esp)
  10156a:	e8 91 ea ff ff       	call   100000 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  10156f:	01 75 ec             	add    %esi,-0x14(%ebp)
  101572:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101575:	01 75 e8             	add    %esi,-0x18(%ebp)
  101578:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
  10157b:	77 93                	ja     101510 <readi+0x90>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
  10157d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101580:	e9 2f ff ff ff       	jmp    1014b4 <readi+0x34>
  101585:	8d 74 26 00          	lea    0x0(%esi),%esi
  101589:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00101590 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
  101590:	55                   	push   %ebp
  101591:	89 e5                	mov    %esp,%ebp
  101593:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
  101596:	8b 45 0c             	mov    0xc(%ebp),%eax
  101599:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  1015a0:	00 
  1015a1:	89 44 24 04          	mov    %eax,0x4(%esp)
  1015a5:	8b 45 08             	mov    0x8(%ebp),%eax
  1015a8:	89 04 24             	mov    %eax,(%esp)
  1015ab:	e8 60 28 00 00       	call   103e10 <strncmp>
}
  1015b0:	c9                   	leave  
  1015b1:	c3                   	ret    
  1015b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  1015b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001015c0 <dirlookup>:
// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
// Caller must have already locked dp.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
  1015c0:	55                   	push   %ebp
  1015c1:	89 e5                	mov    %esp,%ebp
  1015c3:	57                   	push   %edi
  1015c4:	56                   	push   %esi
  1015c5:	53                   	push   %ebx
  1015c6:	83 ec 1c             	sub    $0x1c,%esp
  1015c9:	8b 45 08             	mov    0x8(%ebp),%eax
  1015cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  1015cf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  1015d2:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1015d5:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  1015d8:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
  1015db:	66 83 78 10 01       	cmpw   $0x1,0x10(%eax)
  1015e0:	0f 85 cd 00 00 00    	jne    1016b3 <dirlookup+0xf3>
    panic("dirlookup not DIR");
  1015e6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

  for(off = 0; off < dp->size; off += BSIZE){
  1015ed:	8b 78 18             	mov    0x18(%eax),%edi
  1015f0:	85 ff                	test   %edi,%edi
  1015f2:	0f 84 b1 00 00 00    	je     1016a9 <dirlookup+0xe9>
    bp = bread(dp->dev, bmap(dp, off / BSIZE));
  1015f8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1015fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1015fe:	c1 ea 09             	shr    $0x9,%edx
  101601:	e8 9a fc ff ff       	call   1012a0 <bmap>
  101606:	89 44 24 04          	mov    %eax,0x4(%esp)
  10160a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  10160d:	8b 02                	mov    (%edx),%eax
  10160f:	89 04 24             	mov    %eax,(%esp)
  101612:	e8 89 ea ff ff       	call   1000a0 <bread>
    for(de = (struct dirent*)bp->data;
  101617:	8d 48 18             	lea    0x18(%eax),%ecx

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
    bp = bread(dp->dev, bmap(dp, off / BSIZE));
  10161a:	89 c7                	mov    %eax,%edi
    for(de = (struct dirent*)bp->data;
        de < (struct dirent*)(bp->data + BSIZE);
  10161c:	8d b0 18 02 00 00    	lea    0x218(%eax),%esi
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
    bp = bread(dp->dev, bmap(dp, off / BSIZE));
    for(de = (struct dirent*)bp->data;
  101622:	89 cb                	mov    %ecx,%ebx
        de < (struct dirent*)(bp->data + BSIZE);
  101624:	39 f1                	cmp    %esi,%ecx
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
    bp = bread(dp->dev, bmap(dp, off / BSIZE));
    for(de = (struct dirent*)bp->data;
  101626:	89 4d ec             	mov    %ecx,-0x14(%ebp)
        de < (struct dirent*)(bp->data + BSIZE);
  101629:	72 0c                	jb     101637 <dirlookup+0x77>
  10162b:	eb 5e                	jmp    10168b <dirlookup+0xcb>
  10162d:	8d 76 00             	lea    0x0(%esi),%esi
        de++){
  101630:	83 c3 10             	add    $0x10,%ebx
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
    bp = bread(dp->dev, bmap(dp, off / BSIZE));
    for(de = (struct dirent*)bp->data;
        de < (struct dirent*)(bp->data + BSIZE);
  101633:	39 f3                	cmp    %esi,%ebx
  101635:	73 54                	jae    10168b <dirlookup+0xcb>
        de++){
      if(de->inum == 0)
  101637:	66 83 3b 00          	cmpw   $0x0,(%ebx)
  10163b:	90                   	nop    
  10163c:	8d 74 26 00          	lea    0x0(%esi),%esi
  101640:	74 ee                	je     101630 <dirlookup+0x70>
        continue;
      if(namecmp(name, de->name) == 0){
  101642:	8d 43 02             	lea    0x2(%ebx),%eax
  101645:	89 44 24 04          	mov    %eax,0x4(%esp)
  101649:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10164c:	89 04 24             	mov    %eax,(%esp)
  10164f:	e8 3c ff ff ff       	call   101590 <namecmp>
  101654:	85 c0                	test   %eax,%eax
  101656:	75 d8                	jne    101630 <dirlookup+0x70>
        // entry matches path element
        if(poff)
  101658:	8b 75 e0             	mov    -0x20(%ebp),%esi
  10165b:	85 f6                	test   %esi,%esi
  10165d:	74 0e                	je     10166d <dirlookup+0xad>
          *poff = off + (uchar*)de - bp->data;
  10165f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  101662:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  101665:	8d 04 13             	lea    (%ebx,%edx,1),%eax
  101668:	2b 45 ec             	sub    -0x14(%ebp),%eax
  10166b:	89 01                	mov    %eax,(%ecx)
        inum = de->inum;
  10166d:	0f b7 1b             	movzwl (%ebx),%ebx
        brelse(bp);
  101670:	89 3c 24             	mov    %edi,(%esp)
  101673:	e8 88 e9 ff ff       	call   100000 <brelse>
        return iget(dp->dev, inum);
  101678:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  10167b:	89 da                	mov    %ebx,%edx
  10167d:	8b 01                	mov    (%ecx),%eax
      }
    }
    brelse(bp);
  }
  return 0;
}
  10167f:	83 c4 1c             	add    $0x1c,%esp
  101682:	5b                   	pop    %ebx
  101683:	5e                   	pop    %esi
  101684:	5f                   	pop    %edi
  101685:	5d                   	pop    %ebp
        // entry matches path element
        if(poff)
          *poff = off + (uchar*)de - bp->data;
        inum = de->inum;
        brelse(bp);
        return iget(dp->dev, inum);
  101686:	e9 a5 f9 ff ff       	jmp    101030 <iget>
      }
    }
    brelse(bp);
  10168b:	89 3c 24             	mov    %edi,(%esp)
  10168e:	e8 6d e9 ff ff       	call   100000 <brelse>
  struct dirent *de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
  101693:	8b 45 e8             	mov    -0x18(%ebp),%eax
  101696:	81 45 f0 00 02 00 00 	addl   $0x200,-0x10(%ebp)
  10169d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1016a0:	39 50 18             	cmp    %edx,0x18(%eax)
  1016a3:	0f 87 4f ff ff ff    	ja     1015f8 <dirlookup+0x38>
      }
    }
    brelse(bp);
  }
  return 0;
}
  1016a9:	83 c4 1c             	add    $0x1c,%esp
  1016ac:	31 c0                	xor    %eax,%eax
  1016ae:	5b                   	pop    %ebx
  1016af:	5e                   	pop    %esi
  1016b0:	5f                   	pop    %edi
  1016b1:	5d                   	pop    %ebp
  1016b2:	c3                   	ret    
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
  1016b3:	c7 04 24 24 6d 10 00 	movl   $0x106d24,(%esp)
  1016ba:	e8 c1 f1 ff ff       	call   100880 <panic>
  1016bf:	90                   	nop    

001016c0 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  1016c0:	55                   	push   %ebp
  1016c1:	89 e5                	mov    %esp,%ebp
  1016c3:	53                   	push   %ebx
  1016c4:	83 ec 04             	sub    $0x4,%esp
  1016c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
  1016ca:	85 db                	test   %ebx,%ebx
  1016cc:	74 36                	je     101704 <iunlock+0x44>
  1016ce:	f6 43 0c 01          	testb  $0x1,0xc(%ebx)
  1016d2:	74 30                	je     101704 <iunlock+0x44>
  1016d4:	8b 43 08             	mov    0x8(%ebx),%eax
  1016d7:	85 c0                	test   %eax,%eax
  1016d9:	7e 29                	jle    101704 <iunlock+0x44>
    panic("iunlock");

  acquire(&icache.lock);
  1016db:	c7 04 24 00 b0 10 00 	movl   $0x10b000,(%esp)
  1016e2:	e8 a9 25 00 00       	call   103c90 <acquire>
  ip->flags &= ~I_BUSY;
  1016e7:	83 63 0c fe          	andl   $0xfffffffe,0xc(%ebx)
  wakeup(ip);
  1016eb:	89 1c 24             	mov    %ebx,(%esp)
  1016ee:	e8 2d 19 00 00       	call   103020 <wakeup>
  release(&icache.lock);
  1016f3:	c7 45 08 00 b0 10 00 	movl   $0x10b000,0x8(%ebp)
}
  1016fa:	83 c4 04             	add    $0x4,%esp
  1016fd:	5b                   	pop    %ebx
  1016fe:	5d                   	pop    %ebp
    panic("iunlock");

  acquire(&icache.lock);
  ip->flags &= ~I_BUSY;
  wakeup(ip);
  release(&icache.lock);
  1016ff:	e9 4c 25 00 00       	jmp    103c50 <release>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
    panic("iunlock");
  101704:	c7 04 24 36 6d 10 00 	movl   $0x106d36,(%esp)
  10170b:	e8 70 f1 ff ff       	call   100880 <panic>

00101710 <ialloc>:
static struct inode* iget(uint dev, uint inum);

// Allocate a new inode with the given type on device dev.
struct inode*
ialloc(uint dev, short type)
{
  101710:	55                   	push   %ebp
  101711:	89 e5                	mov    %esp,%ebp
  101713:	57                   	push   %edi
  101714:	56                   	push   %esi
  101715:	53                   	push   %ebx
  101716:	83 ec 2c             	sub    $0x2c,%esp
  101719:	0f b7 45 0c          	movzwl 0xc(%ebp),%eax
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  10171d:	8d 55 e8             	lea    -0x18(%ebp),%edx
static struct inode* iget(uint dev, uint inum);

// Allocate a new inode with the given type on device dev.
struct inode*
ialloc(uint dev, short type)
{
  101720:	66 89 45 de          	mov    %ax,-0x22(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  101724:	8b 45 08             	mov    0x8(%ebp),%eax
  101727:	e8 b4 f9 ff ff       	call   1010e0 <readsb>
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  10172c:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
  101730:	0f 86 8e 00 00 00    	jbe    1017c4 <ialloc+0xb4>
  101736:	bf 01 00 00 00       	mov    $0x1,%edi
  10173b:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
  101742:	eb 14                	jmp    101758 <ialloc+0x48>
      dip->type = type;
      bwrite(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  101744:	89 34 24             	mov    %esi,(%esp)
  101747:	e8 b4 e8 ff ff       	call   100000 <brelse>
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  10174c:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
  101750:	8b 7d e0             	mov    -0x20(%ebp),%edi
  101753:	39 7d f0             	cmp    %edi,-0x10(%ebp)
  101756:	76 6c                	jbe    1017c4 <ialloc+0xb4>
    bp = bread(dev, IBLOCK(inum));
  101758:	89 f8                	mov    %edi,%eax
  10175a:	c1 e8 03             	shr    $0x3,%eax
  10175d:	83 c0 02             	add    $0x2,%eax
  101760:	89 44 24 04          	mov    %eax,0x4(%esp)
  101764:	8b 45 08             	mov    0x8(%ebp),%eax
  101767:	89 04 24             	mov    %eax,(%esp)
  10176a:	e8 31 e9 ff ff       	call   1000a0 <bread>
  10176f:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + inum%IPB;
  101771:	89 f8                	mov    %edi,%eax
  101773:	83 e0 07             	and    $0x7,%eax
  101776:	c1 e0 06             	shl    $0x6,%eax
  101779:	8d 5c 06 18          	lea    0x18(%esi,%eax,1),%ebx
    if(dip->type == 0){  // a free inode
  10177d:	66 83 3b 00          	cmpw   $0x0,(%ebx)
  101781:	75 c1                	jne    101744 <ialloc+0x34>
      memset(dip, 0, sizeof(*dip));
  101783:	89 1c 24             	mov    %ebx,(%esp)
  101786:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
  10178d:	00 
  10178e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  101795:	00 
  101796:	e8 65 25 00 00       	call   103d00 <memset>
      dip->type = type;
  10179b:	0f b7 45 de          	movzwl -0x22(%ebp),%eax
  10179f:	66 89 03             	mov    %ax,(%ebx)
      bwrite(bp);   // mark it allocated on the disk
  1017a2:	89 34 24             	mov    %esi,(%esp)
  1017a5:	e8 c6 e8 ff ff       	call   100070 <bwrite>
      brelse(bp);
  1017aa:	89 34 24             	mov    %esi,(%esp)
  1017ad:	e8 4e e8 ff ff       	call   100000 <brelse>
      return iget(dev, inum);
  1017b2:	8b 45 08             	mov    0x8(%ebp),%eax
  1017b5:	89 fa                	mov    %edi,%edx
  1017b7:	e8 74 f8 ff ff       	call   101030 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
  1017bc:	83 c4 2c             	add    $0x2c,%esp
  1017bf:	5b                   	pop    %ebx
  1017c0:	5e                   	pop    %esi
  1017c1:	5f                   	pop    %edi
  1017c2:	5d                   	pop    %ebp
  1017c3:	c3                   	ret    
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
  1017c4:	c7 04 24 3e 6d 10 00 	movl   $0x106d3e,(%esp)
  1017cb:	e8 b0 f0 ff ff       	call   100880 <panic>

001017d0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
  1017d0:	55                   	push   %ebp
  1017d1:	89 e5                	mov    %esp,%ebp
  1017d3:	57                   	push   %edi
  1017d4:	89 d7                	mov    %edx,%edi
  1017d6:	56                   	push   %esi
  1017d7:	89 c6                	mov    %eax,%esi
  1017d9:	53                   	push   %ebx
  1017da:	83 ec 1c             	sub    $0x1c,%esp
static void
bzero(int dev, int bno)
{
  struct buf *bp;
  
  bp = bread(dev, bno);
  1017dd:	89 54 24 04          	mov    %edx,0x4(%esp)
  1017e1:	89 04 24             	mov    %eax,(%esp)
  1017e4:	e8 b7 e8 ff ff       	call   1000a0 <bread>
  memset(bp->data, 0, BSIZE);
  1017e9:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  1017f0:	00 
  1017f1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1017f8:	00 
static void
bzero(int dev, int bno)
{
  struct buf *bp;
  
  bp = bread(dev, bno);
  1017f9:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
  1017fb:	8d 40 18             	lea    0x18(%eax),%eax
  1017fe:	89 04 24             	mov    %eax,(%esp)
  101801:	e8 fa 24 00 00       	call   103d00 <memset>
  bwrite(bp);
  101806:	89 1c 24             	mov    %ebx,(%esp)
  101809:	e8 62 e8 ff ff       	call   100070 <bwrite>
  brelse(bp);
  10180e:	89 1c 24             	mov    %ebx,(%esp)
  101811:	e8 ea e7 ff ff       	call   100000 <brelse>
  struct superblock sb;
  int bi, m;

  bzero(dev, b);

  readsb(dev, &sb);
  101816:	89 f0                	mov    %esi,%eax
  101818:	8d 55 e8             	lea    -0x18(%ebp),%edx
  10181b:	e8 c0 f8 ff ff       	call   1010e0 <readsb>
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  101820:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101823:	89 fa                	mov    %edi,%edx
  101825:	c1 ea 0c             	shr    $0xc,%edx
  101828:	89 34 24             	mov    %esi,(%esp)
  bi = b % BPB;
  m = 1 << (bi % 8);
  10182b:	be 01 00 00 00       	mov    $0x1,%esi
  int bi, m;

  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  101830:	c1 e8 03             	shr    $0x3,%eax
  101833:	8d 44 10 03          	lea    0x3(%eax,%edx,1),%eax
  101837:	89 44 24 04          	mov    %eax,0x4(%esp)
  10183b:	e8 60 e8 ff ff       	call   1000a0 <bread>
  101840:	89 c3                	mov    %eax,%ebx
  bi = b % BPB;
  m = 1 << (bi % 8);
  101842:	89 f8                	mov    %edi,%eax
  101844:	25 ff 0f 00 00       	and    $0xfff,%eax
  101849:	89 c1                	mov    %eax,%ecx
  10184b:	83 e1 07             	and    $0x7,%ecx
  10184e:	d3 e6                	shl    %cl,%esi
  if((bp->data[bi/8] & m) == 0)
  101850:	89 c1                	mov    %eax,%ecx
  101852:	c1 f9 03             	sar    $0x3,%ecx
  101855:	0f b6 54 0b 18       	movzbl 0x18(%ebx,%ecx,1),%edx
  10185a:	0f b6 c2             	movzbl %dl,%eax
  10185d:	85 f0                	test   %esi,%eax
  10185f:	74 22                	je     101883 <bfree+0xb3>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;  // Mark block free on disk.
  101861:	89 f0                	mov    %esi,%eax
  101863:	f7 d0                	not    %eax
  101865:	21 d0                	and    %edx,%eax
  101867:	88 44 0b 18          	mov    %al,0x18(%ebx,%ecx,1)
  bwrite(bp);
  10186b:	89 1c 24             	mov    %ebx,(%esp)
  10186e:	e8 fd e7 ff ff       	call   100070 <bwrite>
  brelse(bp);
  101873:	89 1c 24             	mov    %ebx,(%esp)
  101876:	e8 85 e7 ff ff       	call   100000 <brelse>
}
  10187b:	83 c4 1c             	add    $0x1c,%esp
  10187e:	5b                   	pop    %ebx
  10187f:	5e                   	pop    %esi
  101880:	5f                   	pop    %edi
  101881:	5d                   	pop    %ebp
  101882:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  101883:	c7 04 24 50 6d 10 00 	movl   $0x106d50,(%esp)
  10188a:	e8 f1 ef ff ff       	call   100880 <panic>
  10188f:	90                   	nop    

00101890 <iput>:
}

// Caller holds reference to unlocked ip.  Drop reference.
void
iput(struct inode *ip)
{
  101890:	55                   	push   %ebp
  101891:	89 e5                	mov    %esp,%ebp
  101893:	57                   	push   %edi
  101894:	56                   	push   %esi
  101895:	53                   	push   %ebx
  101896:	83 ec 0c             	sub    $0xc,%esp
  101899:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&icache.lock);
  10189c:	c7 04 24 00 b0 10 00 	movl   $0x10b000,(%esp)
  1018a3:	e8 e8 23 00 00       	call   103c90 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
  1018a8:	83 7e 08 01          	cmpl   $0x1,0x8(%esi)
  1018ac:	0f 85 9e 00 00 00    	jne    101950 <iput+0xc0>
  1018b2:	8b 46 0c             	mov    0xc(%esi),%eax
  1018b5:	a8 02                	test   $0x2,%al
  1018b7:	0f 84 93 00 00 00    	je     101950 <iput+0xc0>
  1018bd:	66 83 7e 16 00       	cmpw   $0x0,0x16(%esi)
  1018c2:	0f 85 88 00 00 00    	jne    101950 <iput+0xc0>
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
  1018c8:	a8 01                	test   $0x1,%al
  1018ca:	0f 85 f3 00 00 00    	jne    1019c3 <iput+0x133>
      panic("iput busy");
    ip->flags |= I_BUSY;
  1018d0:	83 c8 01             	or     $0x1,%eax
    release(&icache.lock);
  1018d3:	31 db                	xor    %ebx,%ebx
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
  1018d5:	89 46 0c             	mov    %eax,0xc(%esi)
    release(&icache.lock);
  1018d8:	c7 04 24 00 b0 10 00 	movl   $0x10b000,(%esp)
  1018df:	e8 6c 23 00 00       	call   103c50 <release>
  1018e4:	eb 08                	jmp    1018ee <iput+0x5e>
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
  1018e6:	83 c3 01             	add    $0x1,%ebx
  1018e9:	83 fb 0c             	cmp    $0xc,%ebx
  1018ec:	74 1f                	je     10190d <iput+0x7d>
    if(ip->addrs[i]){
  1018ee:	8b 54 9e 1c          	mov    0x1c(%esi,%ebx,4),%edx
  1018f2:	85 d2                	test   %edx,%edx
  1018f4:	74 f0                	je     1018e6 <iput+0x56>
      bfree(ip->dev, ip->addrs[i]);
  1018f6:	8b 06                	mov    (%esi),%eax
  1018f8:	e8 d3 fe ff ff       	call   1017d0 <bfree>
      ip->addrs[i] = 0;
  1018fd:	c7 44 9e 1c 00 00 00 	movl   $0x0,0x1c(%esi,%ebx,4)
  101904:	00 
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
  101905:	83 c3 01             	add    $0x1,%ebx
  101908:	83 fb 0c             	cmp    $0xc,%ebx
  10190b:	75 e1                	jne    1018ee <iput+0x5e>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
  10190d:	8b 46 4c             	mov    0x4c(%esi),%eax
  101910:	85 c0                	test   %eax,%eax
  101912:	75 53                	jne    101967 <iput+0xd7>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  101914:	c7 46 18 00 00 00 00 	movl   $0x0,0x18(%esi)
  iupdate(ip);
  10191b:	89 34 24             	mov    %esi,(%esp)
  10191e:	e8 0d f8 ff ff       	call   101130 <iupdate>
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
    release(&icache.lock);
    itrunc(ip);
    ip->type = 0;
  101923:	66 c7 46 10 00 00    	movw   $0x0,0x10(%esi)
    iupdate(ip);
  101929:	89 34 24             	mov    %esi,(%esp)
  10192c:	e8 ff f7 ff ff       	call   101130 <iupdate>
    acquire(&icache.lock);
  101931:	c7 04 24 00 b0 10 00 	movl   $0x10b000,(%esp)
  101938:	e8 53 23 00 00       	call   103c90 <acquire>
    ip->flags = 0;
  10193d:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    wakeup(ip);
  101944:	89 34 24             	mov    %esi,(%esp)
  101947:	e8 d4 16 00 00       	call   103020 <wakeup>
  10194c:	8d 74 26 00          	lea    0x0(%esi),%esi
  }
  ip->ref--;
  101950:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
  101954:	c7 45 08 00 b0 10 00 	movl   $0x10b000,0x8(%ebp)
}
  10195b:	83 c4 0c             	add    $0xc,%esp
  10195e:	5b                   	pop    %ebx
  10195f:	5e                   	pop    %esi
  101960:	5f                   	pop    %edi
  101961:	5d                   	pop    %ebp
    acquire(&icache.lock);
    ip->flags = 0;
    wakeup(ip);
  }
  ip->ref--;
  release(&icache.lock);
  101962:	e9 e9 22 00 00       	jmp    103c50 <release>
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
  101967:	89 44 24 04          	mov    %eax,0x4(%esp)
  10196b:	8b 06                	mov    (%esi),%eax
    a = (uint*)bp->data;
  10196d:	30 db                	xor    %bl,%bl
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
  10196f:	89 04 24             	mov    %eax,(%esp)
  101972:	e8 29 e7 ff ff       	call   1000a0 <bread>
    a = (uint*)bp->data;
  101977:	89 c7                	mov    %eax,%edi
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
  101979:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
  10197c:	83 c7 18             	add    $0x18,%edi
  10197f:	31 c0                	xor    %eax,%eax
  101981:	eb 0d                	jmp    101990 <iput+0x100>
    for(j = 0; j < NINDIRECT; j++){
  101983:	83 c3 01             	add    $0x1,%ebx
  101986:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
  10198c:	89 d8                	mov    %ebx,%eax
  10198e:	74 12                	je     1019a2 <iput+0x112>
      if(a[j])
  101990:	8b 14 87             	mov    (%edi,%eax,4),%edx
  101993:	85 d2                	test   %edx,%edx
  101995:	74 ec                	je     101983 <iput+0xf3>
        bfree(ip->dev, a[j]);
  101997:	8b 06                	mov    (%esi),%eax
  101999:	e8 32 fe ff ff       	call   1017d0 <bfree>
  10199e:	66 90                	xchg   %ax,%ax
  1019a0:	eb e1                	jmp    101983 <iput+0xf3>
    }
    brelse(bp);
  1019a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1019a5:	89 04 24             	mov    %eax,(%esp)
  1019a8:	e8 53 e6 ff ff       	call   100000 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
  1019ad:	8b 56 4c             	mov    0x4c(%esi),%edx
  1019b0:	8b 06                	mov    (%esi),%eax
  1019b2:	e8 19 fe ff ff       	call   1017d0 <bfree>
    ip->addrs[NDIRECT] = 0;
  1019b7:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  1019be:	e9 51 ff ff ff       	jmp    101914 <iput+0x84>
{
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
      panic("iput busy");
  1019c3:	c7 04 24 63 6d 10 00 	movl   $0x106d63,(%esp)
  1019ca:	e8 b1 ee ff ff       	call   100880 <panic>
  1019cf:	90                   	nop    

001019d0 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
  1019d0:	55                   	push   %ebp
  1019d1:	89 e5                	mov    %esp,%ebp
  1019d3:	57                   	push   %edi
  1019d4:	56                   	push   %esi
  1019d5:	53                   	push   %ebx
  1019d6:	83 ec 2c             	sub    $0x2c,%esp
  1019d9:	8b 75 08             	mov    0x8(%ebp),%esi
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
  1019dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1019df:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  1019e6:	00 
  1019e7:	89 34 24             	mov    %esi,(%esp)
  1019ea:	89 44 24 04          	mov    %eax,0x4(%esp)
  1019ee:	e8 cd fb ff ff       	call   1015c0 <dirlookup>
  1019f3:	85 c0                	test   %eax,%eax
  1019f5:	0f 85 98 00 00 00    	jne    101a93 <dirlink+0xc3>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
  1019fb:	8b 46 18             	mov    0x18(%esi),%eax
  1019fe:	85 c0                	test   %eax,%eax
  101a00:	0f 84 9c 00 00 00    	je     101aa2 <dirlink+0xd2>
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
    return -1;
  101a06:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  101a09:	31 db                	xor    %ebx,%ebx
  101a0b:	eb 0b                	jmp    101a18 <dirlink+0x48>
  101a0d:	8d 76 00             	lea    0x0(%esi),%esi
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
  101a10:	83 c3 10             	add    $0x10,%ebx
  101a13:	39 5e 18             	cmp    %ebx,0x18(%esi)
  101a16:	76 24                	jbe    101a3c <dirlink+0x6c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101a18:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  101a1f:	00 
  101a20:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  101a24:	89 7c 24 04          	mov    %edi,0x4(%esp)
  101a28:	89 34 24             	mov    %esi,(%esp)
  101a2b:	e8 50 fa ff ff       	call   101480 <readi>
  101a30:	83 f8 10             	cmp    $0x10,%eax
  101a33:	75 52                	jne    101a87 <dirlink+0xb7>
      panic("dirlink read");
    if(de.inum == 0)
  101a35:	66 83 7d e4 00       	cmpw   $0x0,-0x1c(%ebp)
  101a3a:	75 d4                	jne    101a10 <dirlink+0x40>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  101a3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  101a3f:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  101a46:	00 
  101a47:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a4b:	8d 45 e6             	lea    -0x1a(%ebp),%eax
  101a4e:	89 04 24             	mov    %eax,(%esp)
  101a51:	e8 1a 24 00 00       	call   103e70 <strncpy>
  de.inum = inum;
  101a56:	0f b7 45 10          	movzwl 0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101a5a:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  101a61:	00 
  101a62:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  101a66:	89 7c 24 04          	mov    %edi,0x4(%esp)
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  101a6a:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101a6e:	89 34 24             	mov    %esi,(%esp)
  101a71:	e8 da f8 ff ff       	call   101350 <writei>
    panic("dirlink");
  101a76:	31 d2                	xor    %edx,%edx
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101a78:	83 f8 10             	cmp    $0x10,%eax
  101a7b:	75 2c                	jne    101aa9 <dirlink+0xd9>
    panic("dirlink");
  
  return 0;
}
  101a7d:	83 c4 2c             	add    $0x2c,%esp
  101a80:	89 d0                	mov    %edx,%eax
  101a82:	5b                   	pop    %ebx
  101a83:	5e                   	pop    %esi
  101a84:	5f                   	pop    %edi
  101a85:	5d                   	pop    %ebp
  101a86:	c3                   	ret    
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
  101a87:	c7 04 24 6d 6d 10 00 	movl   $0x106d6d,(%esp)
  101a8e:	e8 ed ed ff ff       	call   100880 <panic>
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
  101a93:	89 04 24             	mov    %eax,(%esp)
  101a96:	e8 f5 fd ff ff       	call   101890 <iput>
  101a9b:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  101aa0:	eb db                	jmp    101a7d <dirlink+0xad>
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
  101aa2:	8d 7d e4             	lea    -0x1c(%ebp),%edi
  101aa5:	31 db                	xor    %ebx,%ebx
  101aa7:	eb 93                	jmp    101a3c <dirlink+0x6c>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
  101aa9:	c7 04 24 52 73 10 00 	movl   $0x107352,(%esp)
  101ab0:	e8 cb ed ff ff       	call   100880 <panic>
  101ab5:	8d 74 26 00          	lea    0x0(%esi),%esi
  101ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00101ac0 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  101ac0:	55                   	push   %ebp
  101ac1:	89 e5                	mov    %esp,%ebp
  101ac3:	53                   	push   %ebx
  101ac4:	83 ec 04             	sub    $0x4,%esp
  101ac7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
  101aca:	89 1c 24             	mov    %ebx,(%esp)
  101acd:	e8 ee fb ff ff       	call   1016c0 <iunlock>
  iput(ip);
  101ad2:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
  101ad5:	83 c4 04             	add    $0x4,%esp
  101ad8:	5b                   	pop    %ebx
  101ad9:	5d                   	pop    %ebp
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
  101ada:	e9 b1 fd ff ff       	jmp    101890 <iput>
  101adf:	90                   	nop    

00101ae0 <ilock>:
}

// Lock the given inode.
void
ilock(struct inode *ip)
{
  101ae0:	55                   	push   %ebp
  101ae1:	89 e5                	mov    %esp,%ebp
  101ae3:	56                   	push   %esi
  101ae4:	53                   	push   %ebx
  101ae5:	83 ec 10             	sub    $0x10,%esp
  101ae8:	8b 75 08             	mov    0x8(%ebp),%esi
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
  101aeb:	85 f6                	test   %esi,%esi
  101aed:	0f 84 dd 00 00 00    	je     101bd0 <ilock+0xf0>
  101af3:	8b 46 08             	mov    0x8(%esi),%eax
  101af6:	85 c0                	test   %eax,%eax
  101af8:	0f 8e d2 00 00 00    	jle    101bd0 <ilock+0xf0>
    panic("ilock");

  acquire(&icache.lock);
  101afe:	c7 04 24 00 b0 10 00 	movl   $0x10b000,(%esp)
  101b05:	e8 86 21 00 00       	call   103c90 <acquire>
  while(ip->flags & I_BUSY)
  101b0a:	8b 46 0c             	mov    0xc(%esi),%eax
  101b0d:	a8 01                	test   $0x1,%al
  101b0f:	74 17                	je     101b28 <ilock+0x48>
    sleep(ip, &icache.lock);
  101b11:	c7 44 24 04 00 b0 10 	movl   $0x10b000,0x4(%esp)
  101b18:	00 
  101b19:	89 34 24             	mov    %esi,(%esp)
  101b1c:	e8 5f 16 00 00       	call   103180 <sleep>

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
  101b21:	8b 46 0c             	mov    0xc(%esi),%eax
  101b24:	a8 01                	test   $0x1,%al
  101b26:	75 e9                	jne    101b11 <ilock+0x31>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
  101b28:	83 c8 01             	or     $0x1,%eax
  101b2b:	89 46 0c             	mov    %eax,0xc(%esi)
  release(&icache.lock);
  101b2e:	c7 04 24 00 b0 10 00 	movl   $0x10b000,(%esp)
  101b35:	e8 16 21 00 00       	call   103c50 <release>

  if(!(ip->flags & I_VALID)){
  101b3a:	f6 46 0c 02          	testb  $0x2,0xc(%esi)
  101b3e:	74 07                	je     101b47 <ilock+0x67>
    brelse(bp);
    ip->flags |= I_VALID;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
  101b40:	83 c4 10             	add    $0x10,%esp
  101b43:	5b                   	pop    %ebx
  101b44:	5e                   	pop    %esi
  101b45:	5d                   	pop    %ebp
  101b46:	c3                   	ret    
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
  release(&icache.lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum));
  101b47:	8b 46 04             	mov    0x4(%esi),%eax
  101b4a:	c1 e8 03             	shr    $0x3,%eax
  101b4d:	83 c0 02             	add    $0x2,%eax
  101b50:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b54:	8b 06                	mov    (%esi),%eax
  101b56:	89 04 24             	mov    %eax,(%esp)
  101b59:	e8 42 e5 ff ff       	call   1000a0 <bread>
  101b5e:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + ip->inum%IPB;
  101b60:	8b 46 04             	mov    0x4(%esi),%eax
  101b63:	83 e0 07             	and    $0x7,%eax
  101b66:	c1 e0 06             	shl    $0x6,%eax
  101b69:	8d 44 03 18          	lea    0x18(%ebx,%eax,1),%eax
    ip->type = dip->type;
  101b6d:	0f b7 10             	movzwl (%eax),%edx
  101b70:	66 89 56 10          	mov    %dx,0x10(%esi)
    ip->major = dip->major;
  101b74:	0f b7 50 02          	movzwl 0x2(%eax),%edx
  101b78:	66 89 56 12          	mov    %dx,0x12(%esi)
    ip->minor = dip->minor;
  101b7c:	0f b7 50 04          	movzwl 0x4(%eax),%edx
  101b80:	66 89 56 14          	mov    %dx,0x14(%esi)
    ip->nlink = dip->nlink;
  101b84:	0f b7 50 06          	movzwl 0x6(%eax),%edx
  101b88:	66 89 56 16          	mov    %dx,0x16(%esi)
    ip->size = dip->size;
  101b8c:	8b 50 08             	mov    0x8(%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  101b8f:	83 c0 0c             	add    $0xc,%eax
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
  101b92:	89 56 18             	mov    %edx,0x18(%esi)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  101b95:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b99:	8d 46 1c             	lea    0x1c(%esi),%eax
  101b9c:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
  101ba3:	00 
  101ba4:	89 04 24             	mov    %eax,(%esp)
  101ba7:	e8 f4 21 00 00       	call   103da0 <memmove>
    brelse(bp);
  101bac:	89 1c 24             	mov    %ebx,(%esp)
  101baf:	e8 4c e4 ff ff       	call   100000 <brelse>
    ip->flags |= I_VALID;
  101bb4:	83 4e 0c 02          	orl    $0x2,0xc(%esi)
    if(ip->type == 0)
  101bb8:	66 83 7e 10 00       	cmpw   $0x0,0x10(%esi)
  101bbd:	75 81                	jne    101b40 <ilock+0x60>
      panic("ilock: no type");
  101bbf:	c7 04 24 80 6d 10 00 	movl   $0x106d80,(%esp)
  101bc6:	e8 b5 ec ff ff       	call   100880 <panic>
  101bcb:	90                   	nop    
  101bcc:	8d 74 26 00          	lea    0x0(%esi),%esi
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
  101bd0:	c7 04 24 7a 6d 10 00 	movl   $0x106d7a,(%esp)
  101bd7:	e8 a4 ec ff ff       	call   100880 <panic>
  101bdc:	8d 74 26 00          	lea    0x0(%esi),%esi

00101be0 <namex>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
namex(char *path, int nameiparent, char *name)
{
  101be0:	55                   	push   %ebp
  101be1:	89 e5                	mov    %esp,%ebp
  101be3:	57                   	push   %edi
  101be4:	56                   	push   %esi
  101be5:	89 c6                	mov    %eax,%esi
  101be7:	53                   	push   %ebx
  101be8:	83 ec 1c             	sub    $0x1c,%esp
  101beb:	89 55 ec             	mov    %edx,-0x14(%ebp)
  101bee:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
  101bf1:	80 38 2f             	cmpb   $0x2f,(%eax)
  101bf4:	0f 84 17 01 00 00    	je     101d11 <namex+0x131>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->common->cwd);
  101bfa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  101c00:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  101c06:	8b 40 48             	mov    0x48(%eax),%eax
  101c09:	89 04 24             	mov    %eax,(%esp)
  101c0c:	e8 ef f3 ff ff       	call   101000 <idup>
  101c11:	89 45 f0             	mov    %eax,-0x10(%ebp)
  101c14:	eb 03                	jmp    101c19 <namex+0x39>
{
  char *s;
  int len;

  while(*path == '/')
    path++;
  101c16:	83 c6 01             	add    $0x1,%esi
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
  101c19:	0f b6 06             	movzbl (%esi),%eax
  101c1c:	3c 2f                	cmp    $0x2f,%al
  101c1e:	74 f6                	je     101c16 <namex+0x36>
    path++;
  if(*path == 0)
  101c20:	84 c0                	test   %al,%al
  101c22:	0f 84 ba 00 00 00    	je     101ce2 <namex+0x102>
  101c28:	89 f3                	mov    %esi,%ebx
  101c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
  101c30:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
  101c33:	0f b6 03             	movzbl (%ebx),%eax
  101c36:	3c 2f                	cmp    $0x2f,%al
  101c38:	74 04                	je     101c3e <namex+0x5e>
  101c3a:	84 c0                	test   %al,%al
  101c3c:	75 f2                	jne    101c30 <namex+0x50>
    path++;
  len = path - s;
  101c3e:	89 df                	mov    %ebx,%edi
  101c40:	29 f7                	sub    %esi,%edi
  if(len >= DIRSIZ)
  101c42:	83 ff 0d             	cmp    $0xd,%edi
  101c45:	7e 7f                	jle    101cc6 <namex+0xe6>
    memmove(name, s, DIRSIZ);
  101c47:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  101c4e:	00 
  101c4f:	89 74 24 04          	mov    %esi,0x4(%esp)
  101c53:	8b 45 e8             	mov    -0x18(%ebp),%eax
  101c56:	89 04 24             	mov    %eax,(%esp)
  101c59:	e8 42 21 00 00       	call   103da0 <memmove>
  101c5e:	eb 03                	jmp    101c63 <namex+0x83>
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
    path++;
  101c60:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
  101c63:	80 3b 2f             	cmpb   $0x2f,(%ebx)
  101c66:	74 f8                	je     101c60 <namex+0x80>
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->common->cwd);

  while((path = skipelem(path, name)) != 0){
  101c68:	85 db                	test   %ebx,%ebx
  101c6a:	74 76                	je     101ce2 <namex+0x102>
    ilock(ip);
  101c6c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101c6f:	89 04 24             	mov    %eax,(%esp)
  101c72:	e8 69 fe ff ff       	call   101ae0 <ilock>
    if(ip->type != T_DIR){
  101c77:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101c7a:	66 83 78 10 01       	cmpw   $0x1,0x10(%eax)
  101c7f:	75 76                	jne    101cf7 <namex+0x117>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
  101c81:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101c84:	85 c0                	test   %eax,%eax
  101c86:	74 09                	je     101c91 <namex+0xb1>
  101c88:	80 3b 00             	cmpb   $0x0,(%ebx)
  101c8b:	0f 84 97 00 00 00    	je     101d28 <namex+0x148>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
  101c91:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  101c98:	00 
  101c99:	8b 45 e8             	mov    -0x18(%ebp),%eax
  101c9c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ca0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101ca3:	89 04 24             	mov    %eax,(%esp)
  101ca6:	e8 15 f9 ff ff       	call   1015c0 <dirlookup>
  101cab:	85 c0                	test   %eax,%eax
  101cad:	89 c6                	mov    %eax,%esi
  101caf:	74 43                	je     101cf4 <namex+0x114>
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
  101cb1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101cb4:	89 04 24             	mov    %eax,(%esp)
  101cb7:	e8 04 fe ff ff       	call   101ac0 <iunlockput>
  101cbc:	89 75 f0             	mov    %esi,-0x10(%ebp)
  101cbf:	89 de                	mov    %ebx,%esi
  101cc1:	e9 53 ff ff ff       	jmp    101c19 <namex+0x39>
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
  101cc6:	89 7c 24 08          	mov    %edi,0x8(%esp)
  101cca:	89 74 24 04          	mov    %esi,0x4(%esp)
  101cce:	8b 45 e8             	mov    -0x18(%ebp),%eax
  101cd1:	89 04 24             	mov    %eax,(%esp)
  101cd4:	e8 c7 20 00 00       	call   103da0 <memmove>
    name[len] = 0;
  101cd9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  101cdc:	c6 04 38 00          	movb   $0x0,(%eax,%edi,1)
  101ce0:	eb 81                	jmp    101c63 <namex+0x83>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
  101ce2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101ce5:	85 c0                	test   %eax,%eax
  101ce7:	75 55                	jne    101d3e <namex+0x15e>
    iput(ip);
    return 0;
  }
  return ip;
}
  101ce9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101cec:	83 c4 1c             	add    $0x1c,%esp
  101cef:	5b                   	pop    %ebx
  101cf0:	5e                   	pop    %esi
  101cf1:	5f                   	pop    %edi
  101cf2:	5d                   	pop    %ebp
  101cf3:	c3                   	ret    
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
  101cf4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101cf7:	89 04 24             	mov    %eax,(%esp)
  101cfa:	e8 c1 fd ff ff       	call   101ac0 <iunlockput>
  101cff:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
  101d06:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101d09:	83 c4 1c             	add    $0x1c,%esp
  101d0c:	5b                   	pop    %ebx
  101d0d:	5e                   	pop    %esi
  101d0e:	5f                   	pop    %edi
  101d0f:	5d                   	pop    %ebp
  101d10:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  101d11:	ba 01 00 00 00       	mov    $0x1,%edx
  101d16:	b8 01 00 00 00       	mov    $0x1,%eax
  101d1b:	e8 10 f3 ff ff       	call   101030 <iget>
  101d20:	89 45 f0             	mov    %eax,-0x10(%ebp)
  101d23:	e9 f1 fe ff ff       	jmp    101c19 <namex+0x39>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
  101d28:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101d2b:	89 04 24             	mov    %eax,(%esp)
  101d2e:	e8 8d f9 ff ff       	call   1016c0 <iunlock>
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
  101d33:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101d36:	83 c4 1c             	add    $0x1c,%esp
  101d39:	5b                   	pop    %ebx
  101d3a:	5e                   	pop    %esi
  101d3b:	5f                   	pop    %edi
  101d3c:	5d                   	pop    %ebp
  101d3d:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
  101d3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101d41:	89 04 24             	mov    %eax,(%esp)
  101d44:	e8 47 fb ff ff       	call   101890 <iput>
  101d49:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  101d50:	eb 97                	jmp    101ce9 <namex+0x109>
  101d52:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  101d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00101d60 <nameiparent>:
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
  101d60:	55                   	push   %ebp
  return namex(path, 1, name);
  101d61:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
  101d66:	89 e5                	mov    %esp,%ebp
  101d68:	8b 45 08             	mov    0x8(%ebp),%eax
  101d6b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  return namex(path, 1, name);
}
  101d6e:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
  101d6f:	e9 6c fe ff ff       	jmp    101be0 <namex>
  101d74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101d7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00101d80 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
  101d80:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
  101d81:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
  101d83:	89 e5                	mov    %esp,%ebp
  101d85:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
  101d88:	8b 45 08             	mov    0x8(%ebp),%eax
  101d8b:	8d 4d f2             	lea    -0xe(%ebp),%ecx
  101d8e:	e8 4d fe ff ff       	call   101be0 <namex>
}
  101d93:	c9                   	leave  
  101d94:	c3                   	ret    
  101d95:	8d 74 26 00          	lea    0x0(%esi),%esi
  101d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00101da0 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(void)
{
  101da0:	55                   	push   %ebp
  101da1:	89 e5                	mov    %esp,%ebp
  101da3:	83 ec 08             	sub    $0x8,%esp
  initlock(&icache.lock, "icache");
  101da6:	c7 44 24 04 8f 6d 10 	movl   $0x106d8f,0x4(%esp)
  101dad:	00 
  101dae:	c7 04 24 00 b0 10 00 	movl   $0x10b000,(%esp)
  101db5:	e8 56 1d 00 00       	call   103b10 <initlock>
}
  101dba:	c9                   	leave  
  101dbb:	c3                   	ret    
  101dbc:	90                   	nop    
  101dbd:	90                   	nop    
  101dbe:	90                   	nop    
  101dbf:	90                   	nop    

00101dc0 <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
  101dc0:	55                   	push   %ebp
  101dc1:	89 c1                	mov    %eax,%ecx
  101dc3:	89 e5                	mov    %esp,%ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  101dc5:	ba f7 01 00 00       	mov    $0x1f7,%edx
  101dca:	ec                   	in     (%dx),%al
  return data;
  101dcb:	0f b6 d0             	movzbl %al,%edx
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
  101dce:	89 d0                	mov    %edx,%eax
  101dd0:	25 c0 00 00 00       	and    $0xc0,%eax
  101dd5:	83 f8 40             	cmp    $0x40,%eax
  101dd8:	75 eb                	jne    101dc5 <idewait+0x5>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
  101dda:	85 c9                	test   %ecx,%ecx
  101ddc:	74 0a                	je     101de8 <idewait+0x28>
  101dde:	83 e2 21             	and    $0x21,%edx
  101de1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101de6:	75 02                	jne    101dea <idewait+0x2a>
  101de8:	31 c0                	xor    %eax,%eax
    return -1;
  return 0;
}
  101dea:	5d                   	pop    %ebp
  101deb:	c3                   	ret    
  101dec:	8d 74 26 00          	lea    0x0(%esi),%esi

00101df0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  101df0:	55                   	push   %ebp
  101df1:	89 e5                	mov    %esp,%ebp
  101df3:	56                   	push   %esi
  101df4:	89 c6                	mov    %eax,%esi
  101df6:	53                   	push   %ebx
  101df7:	83 ec 10             	sub    $0x10,%esp
  if(b == 0)
  101dfa:	85 c0                	test   %eax,%eax
  101dfc:	0f 84 81 00 00 00    	je     101e83 <idestart+0x93>
    panic("idestart");

  idewait(0);
  101e02:	31 c0                	xor    %eax,%eax
  101e04:	e8 b7 ff ff ff       	call   101dc0 <idewait>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  101e09:	31 c0                	xor    %eax,%eax
  101e0b:	ba f6 03 00 00       	mov    $0x3f6,%edx
  101e10:	ee                   	out    %al,(%dx)
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, 1);  // number of sectors
  outb(0x1f3, b->sector & 0xff);
  101e11:	b8 01 00 00 00       	mov    $0x1,%eax
  101e16:	ba f2 01 00 00       	mov    $0x1f2,%edx
  101e1b:	ee                   	out    %al,(%dx)
  101e1c:	8b 46 08             	mov    0x8(%esi),%eax
  101e1f:	b2 f3                	mov    $0xf3,%dl
  101e21:	ee                   	out    %al,(%dx)
  outb(0x1f4, (b->sector >> 8) & 0xff);
  outb(0x1f5, (b->sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
  101e22:	c1 e8 08             	shr    $0x8,%eax
  101e25:	b2 f4                	mov    $0xf4,%dl
  101e27:	ee                   	out    %al,(%dx)
  101e28:	c1 e8 08             	shr    $0x8,%eax
  101e2b:	b2 f5                	mov    $0xf5,%dl
  101e2d:	ee                   	out    %al,(%dx)
  101e2e:	0f b6 4e 04          	movzbl 0x4(%esi),%ecx
  101e32:	c1 e8 08             	shr    $0x8,%eax
  101e35:	bb f6 01 00 00       	mov    $0x1f6,%ebx
  101e3a:	83 e0 0f             	and    $0xf,%eax
  101e3d:	89 da                	mov    %ebx,%edx
  101e3f:	83 e1 01             	and    $0x1,%ecx
  101e42:	c1 e1 04             	shl    $0x4,%ecx
  101e45:	09 c1                	or     %eax,%ecx
  101e47:	83 c9 e0             	or     $0xffffffe0,%ecx
  101e4a:	89 c8                	mov    %ecx,%eax
  101e4c:	ee                   	out    %al,(%dx)
  101e4d:	f6 06 04             	testb  $0x4,(%esi)
  101e50:	75 12                	jne    101e64 <idestart+0x74>
  101e52:	b8 20 00 00 00       	mov    $0x20,%eax
  101e57:	ba f7 01 00 00       	mov    $0x1f7,%edx
  101e5c:	ee                   	out    %al,(%dx)
    outb(0x1f7, IDE_CMD_WRITE);
    outsl(0x1f0, b->data, 512/4);
  } else {
    outb(0x1f7, IDE_CMD_READ);
  }
}
  101e5d:	83 c4 10             	add    $0x10,%esp
  101e60:	5b                   	pop    %ebx
  101e61:	5e                   	pop    %esi
  101e62:	5d                   	pop    %ebp
  101e63:	c3                   	ret    
  101e64:	b8 30 00 00 00       	mov    $0x30,%eax
  101e69:	b2 f7                	mov    $0xf7,%dl
  101e6b:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
  101e6c:	ba f0 01 00 00       	mov    $0x1f0,%edx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  101e71:	83 c6 18             	add    $0x18,%esi
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
  101e74:	b9 80 00 00 00       	mov    $0x80,%ecx
  101e79:	fc                   	cld    
  101e7a:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  101e7c:	83 c4 10             	add    $0x10,%esp
  101e7f:	5b                   	pop    %ebx
  101e80:	5e                   	pop    %esi
  101e81:	5d                   	pop    %ebp
  101e82:	c3                   	ret    
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  101e83:	c7 04 24 96 6d 10 00 	movl   $0x106d96,(%esp)
  101e8a:	e8 f1 e9 ff ff       	call   100880 <panic>
  101e8f:	90                   	nop    

00101e90 <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
  101e90:	55                   	push   %ebp
  101e91:	89 e5                	mov    %esp,%ebp
  101e93:	53                   	push   %ebx
  101e94:	83 ec 14             	sub    $0x14,%esp
  101e97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!(b->flags & B_BUSY))
  101e9a:	8b 03                	mov    (%ebx),%eax
  101e9c:	a8 01                	test   $0x1,%al
  101e9e:	0f 84 90 00 00 00    	je     101f34 <iderw+0xa4>
    panic("iderw: buf not busy");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
  101ea4:	83 e0 06             	and    $0x6,%eax
  101ea7:	83 f8 02             	cmp    $0x2,%eax
  101eaa:	0f 84 90 00 00 00    	je     101f40 <iderw+0xb0>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
  101eb0:	8b 53 04             	mov    0x4(%ebx),%edx
  101eb3:	85 d2                	test   %edx,%edx
  101eb5:	74 0d                	je     101ec4 <iderw+0x34>
  101eb7:	a1 d8 8d 10 00       	mov    0x108dd8,%eax
  101ebc:	85 c0                	test   %eax,%eax
  101ebe:	0f 84 88 00 00 00    	je     101f4c <iderw+0xbc>
    panic("idrw: ide disk 1 not present");

  acquire(&idelock);
  101ec4:	c7 04 24 a0 8d 10 00 	movl   $0x108da0,(%esp)
  101ecb:	e8 c0 1d 00 00       	call   103c90 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)
  101ed0:	ba d4 8d 10 00       	mov    $0x108dd4,%edx
    panic("idrw: ide disk 1 not present");

  acquire(&idelock);

  // Append b to idequeue.
  b->qnext = 0;
  101ed5:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)
  101edc:	a1 d4 8d 10 00       	mov    0x108dd4,%eax
  101ee1:	85 c0                	test   %eax,%eax
  101ee3:	74 0a                	je     101eef <iderw+0x5f>
  101ee5:	8d 50 14             	lea    0x14(%eax),%edx
  101ee8:	8b 40 14             	mov    0x14(%eax),%eax
  101eeb:	85 c0                	test   %eax,%eax
  101eed:	75 f6                	jne    101ee5 <iderw+0x55>
    ;
  *pp = b;
  101eef:	89 1a                	mov    %ebx,(%edx)
  
  // Start disk if necessary.
  if(idequeue == b)
  101ef1:	39 1d d4 8d 10 00    	cmp    %ebx,0x108dd4
  101ef7:	75 17                	jne    101f10 <iderw+0x80>
  101ef9:	eb 30                	jmp    101f2b <iderw+0x9b>
  101efb:	90                   	nop    
  101efc:	8d 74 26 00          	lea    0x0(%esi),%esi
    idestart(b);
  
  // Wait for request to finish.
  // Assuming will not sleep too long: ignore proc->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID) {
    sleep(b, &idelock);
  101f00:	c7 44 24 04 a0 8d 10 	movl   $0x108da0,0x4(%esp)
  101f07:	00 
  101f08:	89 1c 24             	mov    %ebx,(%esp)
  101f0b:	e8 70 12 00 00       	call   103180 <sleep>
  if(idequeue == b)
    idestart(b);
  
  // Wait for request to finish.
  // Assuming will not sleep too long: ignore proc->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID) {
  101f10:	8b 03                	mov    (%ebx),%eax
  101f12:	83 e0 06             	and    $0x6,%eax
  101f15:	83 f8 02             	cmp    $0x2,%eax
  101f18:	75 e6                	jne    101f00 <iderw+0x70>
    sleep(b, &idelock);
  }

  release(&idelock);
  101f1a:	c7 45 08 a0 8d 10 00 	movl   $0x108da0,0x8(%ebp)
}
  101f21:	83 c4 14             	add    $0x14,%esp
  101f24:	5b                   	pop    %ebx
  101f25:	5d                   	pop    %ebp
  // Assuming will not sleep too long: ignore proc->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID) {
    sleep(b, &idelock);
  }

  release(&idelock);
  101f26:	e9 25 1d 00 00       	jmp    103c50 <release>
    ;
  *pp = b;
  
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
  101f2b:	89 d8                	mov    %ebx,%eax
  101f2d:	e8 be fe ff ff       	call   101df0 <idestart>
  101f32:	eb dc                	jmp    101f10 <iderw+0x80>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!(b->flags & B_BUSY))
    panic("iderw: buf not busy");
  101f34:	c7 04 24 9f 6d 10 00 	movl   $0x106d9f,(%esp)
  101f3b:	e8 40 e9 ff ff       	call   100880 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  101f40:	c7 04 24 b3 6d 10 00 	movl   $0x106db3,(%esp)
  101f47:	e8 34 e9 ff ff       	call   100880 <panic>
  if(b->dev != 0 && !havedisk1)
    panic("idrw: ide disk 1 not present");
  101f4c:	c7 04 24 c8 6d 10 00 	movl   $0x106dc8,(%esp)
  101f53:	e8 28 e9 ff ff       	call   100880 <panic>
  101f58:	90                   	nop    
  101f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00101f60 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
  101f60:	55                   	push   %ebp
  101f61:	89 e5                	mov    %esp,%ebp
  101f63:	57                   	push   %edi
  101f64:	53                   	push   %ebx
  101f65:	83 ec 10             	sub    $0x10,%esp
  struct buf *b;

  // Take first buffer off queue.
  acquire(&idelock);
  101f68:	c7 04 24 a0 8d 10 00 	movl   $0x108da0,(%esp)
  101f6f:	e8 1c 1d 00 00       	call   103c90 <acquire>
  if((b = idequeue) == 0){
  101f74:	8b 1d d4 8d 10 00    	mov    0x108dd4,%ebx
  101f7a:	85 db                	test   %ebx,%ebx
  101f7c:	74 62                	je     101fe0 <ideintr+0x80>
    release(&idelock);
    cprintf("Spurious IDE interrupt.\n");
    return;
  }
  idequeue = b->qnext;
  101f7e:	8b 43 14             	mov    0x14(%ebx),%eax
  101f81:	a3 d4 8d 10 00       	mov    %eax,0x108dd4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
  101f86:	f6 03 04             	testb  $0x4,(%ebx)
  101f89:	74 35                	je     101fc0 <ideintr+0x60>
    insl(0x1f0, b->data, 512/4);
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
  101f8b:	8b 03                	mov    (%ebx),%eax
  101f8d:	83 c8 02             	or     $0x2,%eax
  101f90:	83 e0 fb             	and    $0xfffffffb,%eax
  101f93:	89 03                	mov    %eax,(%ebx)
  wakeup(b);
  101f95:	89 1c 24             	mov    %ebx,(%esp)
  101f98:	e8 83 10 00 00       	call   103020 <wakeup>
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
  101f9d:	a1 d4 8d 10 00       	mov    0x108dd4,%eax
  101fa2:	85 c0                	test   %eax,%eax
  101fa4:	74 05                	je     101fab <ideintr+0x4b>
    idestart(idequeue);
  101fa6:	e8 45 fe ff ff       	call   101df0 <idestart>

  release(&idelock);
  101fab:	c7 04 24 a0 8d 10 00 	movl   $0x108da0,(%esp)
  101fb2:	e8 99 1c 00 00       	call   103c50 <release>
}
  101fb7:	83 c4 10             	add    $0x10,%esp
  101fba:	5b                   	pop    %ebx
  101fbb:	5f                   	pop    %edi
  101fbc:	5d                   	pop    %ebp
  101fbd:	c3                   	ret    
  101fbe:	66 90                	xchg   %ax,%ax
    return;
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
  101fc0:	b8 01 00 00 00       	mov    $0x1,%eax
  101fc5:	e8 f6 fd ff ff       	call   101dc0 <idewait>
  101fca:	85 c0                	test   %eax,%eax
  101fcc:	78 bd                	js     101f8b <ideintr+0x2b>
  101fce:	8d 7b 18             	lea    0x18(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
  101fd1:	ba f0 01 00 00       	mov    $0x1f0,%edx
  101fd6:	b9 80 00 00 00       	mov    $0x80,%ecx
  101fdb:	fc                   	cld    
  101fdc:	f3 6d                	rep insl (%dx),%es:(%edi)
  101fde:	eb ab                	jmp    101f8b <ideintr+0x2b>
  struct buf *b;

  // Take first buffer off queue.
  acquire(&idelock);
  if((b = idequeue) == 0){
    release(&idelock);
  101fe0:	c7 04 24 a0 8d 10 00 	movl   $0x108da0,(%esp)
  101fe7:	e8 64 1c 00 00       	call   103c50 <release>
    cprintf("Spurious IDE interrupt.\n");
  101fec:	c7 04 24 e5 6d 10 00 	movl   $0x106de5,(%esp)
  101ff3:	e8 c8 e4 ff ff       	call   1004c0 <cprintf>
  101ff8:	eb bd                	jmp    101fb7 <ideintr+0x57>
  101ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102000 <ideinit>:
  return 0;
}

void
ideinit(void)
{
  102000:	55                   	push   %ebp
  102001:	89 e5                	mov    %esp,%ebp
  102003:	83 ec 08             	sub    $0x8,%esp
  int i;

  initlock(&idelock, "ide");
  102006:	c7 44 24 04 fe 6d 10 	movl   $0x106dfe,0x4(%esp)
  10200d:	00 
  10200e:	c7 04 24 a0 8d 10 00 	movl   $0x108da0,(%esp)
  102015:	e8 f6 1a 00 00       	call   103b10 <initlock>
  picenable(IRQ_IDE);
  10201a:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  102021:	e8 ca 0a 00 00       	call   102af0 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
  102026:	a1 20 c6 10 00       	mov    0x10c620,%eax
  10202b:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  102032:	83 e8 01             	sub    $0x1,%eax
  102035:	89 44 24 04          	mov    %eax,0x4(%esp)
  102039:	e8 82 00 00 00       	call   1020c0 <ioapicenable>
  idewait(0);
  10203e:	31 c0                	xor    %eax,%eax
  102040:	e8 7b fd ff ff       	call   101dc0 <idewait>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102045:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  10204a:	ba f6 01 00 00       	mov    $0x1f6,%edx
  10204f:	ee                   	out    %al,(%dx)
  102050:	31 c9                	xor    %ecx,%ecx
  102052:	eb 0b                	jmp    10205f <ideinit+0x5f>
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
  102054:	83 c1 01             	add    $0x1,%ecx
  102057:	81 f9 e8 03 00 00    	cmp    $0x3e8,%ecx
  10205d:	74 14                	je     102073 <ideinit+0x73>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  10205f:	ba f7 01 00 00       	mov    $0x1f7,%edx
  102064:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
  102065:	84 c0                	test   %al,%al
  102067:	74 eb                	je     102054 <ideinit+0x54>
      havedisk1 = 1;
  102069:	c7 05 d8 8d 10 00 01 	movl   $0x1,0x108dd8
  102070:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102073:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
  102078:	ba f6 01 00 00       	mov    $0x1f6,%edx
  10207d:	ee                   	out    %al,(%dx)
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
  10207e:	c9                   	leave  
  10207f:	c3                   	ret    

00102080 <ioapicread>:
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  102080:	8b 15 d4 bf 10 00    	mov    0x10bfd4,%edx
  uint data;
};

static uint
ioapicread(int reg)
{
  102086:	55                   	push   %ebp
  102087:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
  102089:	89 02                	mov    %eax,(%edx)
  return ioapic->data;
  10208b:	a1 d4 bf 10 00       	mov    0x10bfd4,%eax
}
  102090:	5d                   	pop    %ebp

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
  102091:	8b 40 10             	mov    0x10(%eax),%eax
}
  102094:	c3                   	ret    
  102095:	8d 74 26 00          	lea    0x0(%esi),%esi
  102099:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001020a0 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  1020a0:	8b 0d d4 bf 10 00    	mov    0x10bfd4,%ecx
  return ioapic->data;
}

static void
ioapicwrite(int reg, uint data)
{
  1020a6:	55                   	push   %ebp
  1020a7:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
  1020a9:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
  1020ab:	a1 d4 bf 10 00       	mov    0x10bfd4,%eax
  1020b0:	89 50 10             	mov    %edx,0x10(%eax)
}
  1020b3:	5d                   	pop    %ebp
  1020b4:	c3                   	ret    
  1020b5:	8d 74 26 00          	lea    0x0(%esi),%esi
  1020b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001020c0 <ioapicenable>:
  }
}

void
ioapicenable(int irq, int cpunum)
{
  1020c0:	55                   	push   %ebp
  1020c1:	89 e5                	mov    %esp,%ebp
  1020c3:	83 ec 08             	sub    $0x8,%esp
  1020c6:	89 1c 24             	mov    %ebx,(%esp)
  1020c9:	89 74 24 04          	mov    %esi,0x4(%esp)
  if(!ismp)
  1020cd:	8b 15 24 c0 10 00    	mov    0x10c024,%edx
  }
}

void
ioapicenable(int irq, int cpunum)
{
  1020d3:	8b 45 08             	mov    0x8(%ebp),%eax
  1020d6:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(!ismp)
  1020d9:	85 d2                	test   %edx,%edx
  1020db:	75 0b                	jne    1020e8 <ioapicenable+0x28>
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
  1020dd:	8b 1c 24             	mov    (%esp),%ebx
  1020e0:	8b 74 24 04          	mov    0x4(%esp),%esi
  1020e4:	89 ec                	mov    %ebp,%esp
  1020e6:	5d                   	pop    %ebp
  1020e7:	c3                   	ret    
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  1020e8:	8d 34 00             	lea    (%eax,%eax,1),%esi
  1020eb:	8d 50 20             	lea    0x20(%eax),%edx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
  1020ee:	c1 e3 18             	shl    $0x18,%ebx
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  1020f1:	8d 46 10             	lea    0x10(%esi),%eax
  1020f4:	e8 a7 ff ff ff       	call   1020a0 <ioapicwrite>
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
  1020f9:	8d 46 11             	lea    0x11(%esi),%eax
  1020fc:	89 da                	mov    %ebx,%edx
}
  1020fe:	8b 74 24 04          	mov    0x4(%esp),%esi
  102102:	8b 1c 24             	mov    (%esp),%ebx
  102105:	89 ec                	mov    %ebp,%esp
  102107:	5d                   	pop    %ebp

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
  102108:	eb 96                	jmp    1020a0 <ioapicwrite>
  10210a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102110 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
  102110:	55                   	push   %ebp
  102111:	89 e5                	mov    %esp,%ebp
  102113:	57                   	push   %edi
  102114:	56                   	push   %esi
  102115:	53                   	push   %ebx
  102116:	83 ec 0c             	sub    $0xc,%esp
  int i, id, maxintr;

  if(!ismp)
  102119:	8b 0d 24 c0 10 00    	mov    0x10c024,%ecx
  10211f:	85 c9                	test   %ecx,%ecx
  102121:	75 0d                	jne    102130 <ioapicinit+0x20>
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
  102123:	83 c4 0c             	add    $0xc,%esp
  102126:	5b                   	pop    %ebx
  102127:	5e                   	pop    %esi
  102128:	5f                   	pop    %edi
  102129:	5d                   	pop    %ebp
  10212a:	c3                   	ret    
  10212b:	90                   	nop    
  10212c:	8d 74 26 00          	lea    0x0(%esi),%esi

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  102130:	b8 01 00 00 00       	mov    $0x1,%eax
  int i, id, maxintr;

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  102135:	c7 05 d4 bf 10 00 00 	movl   $0xfec00000,0x10bfd4
  10213c:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  10213f:	e8 3c ff ff ff       	call   102080 <ioapicread>
  102144:	c1 e8 10             	shr    $0x10,%eax
  102147:	0f b6 f8             	movzbl %al,%edi
  id = ioapicread(REG_ID) >> 24;
  10214a:	31 c0                	xor    %eax,%eax
  10214c:	e8 2f ff ff ff       	call   102080 <ioapicread>
  if(id != ioapicid)
  102151:	0f b6 15 20 c0 10 00 	movzbl 0x10c020,%edx
  102158:	c1 e8 18             	shr    $0x18,%eax
  10215b:	39 c2                	cmp    %eax,%edx
  10215d:	74 0c                	je     10216b <ioapicinit+0x5b>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
  10215f:	c7 04 24 04 6e 10 00 	movl   $0x106e04,(%esp)
  102166:	e8 55 e3 ff ff       	call   1004c0 <cprintf>
  10216b:	31 f6                	xor    %esi,%esi
  10216d:	bb 10 00 00 00       	mov    $0x10,%ebx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
  102172:	8d 56 20             	lea    0x20(%esi),%edx
  102175:	89 d8                	mov    %ebx,%eax
  102177:	81 ca 00 00 01 00    	or     $0x10000,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  10217d:	83 c6 01             	add    $0x1,%esi
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
  102180:	e8 1b ff ff ff       	call   1020a0 <ioapicwrite>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  102185:	8d 43 01             	lea    0x1(%ebx),%eax
  102188:	31 d2                	xor    %edx,%edx
  10218a:	e8 11 ff ff ff       	call   1020a0 <ioapicwrite>
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  10218f:	83 c3 02             	add    $0x2,%ebx
  102192:	39 f7                	cmp    %esi,%edi
  102194:	7d dc                	jge    102172 <ioapicinit+0x62>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
  102196:	83 c4 0c             	add    $0xc,%esp
  102199:	5b                   	pop    %ebx
  10219a:	5e                   	pop    %esi
  10219b:	5f                   	pop    %edi
  10219c:	5d                   	pop    %ebp
  10219d:	c3                   	ret    
  10219e:	90                   	nop    
  10219f:	90                   	nop    

001021a0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc()
{
  1021a0:	55                   	push   %ebp
  1021a1:	89 e5                	mov    %esp,%ebp
  1021a3:	53                   	push   %ebx
  1021a4:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  acquire(&kmem.lock);
  1021a7:	c7 04 24 e0 bf 10 00 	movl   $0x10bfe0,(%esp)
  1021ae:	e8 dd 1a 00 00       	call   103c90 <acquire>
  r = kmem.freelist;
  1021b3:	8b 1d 14 c0 10 00    	mov    0x10c014,%ebx
  if(r)
  1021b9:	85 db                	test   %ebx,%ebx
  1021bb:	74 07                	je     1021c4 <kalloc+0x24>
    kmem.freelist = r->next;
  1021bd:	8b 03                	mov    (%ebx),%eax
  1021bf:	a3 14 c0 10 00       	mov    %eax,0x10c014
  release(&kmem.lock);
  1021c4:	c7 04 24 e0 bf 10 00 	movl   $0x10bfe0,(%esp)
  1021cb:	e8 80 1a 00 00       	call   103c50 <release>
  return (char*) r;
}
  1021d0:	89 d8                	mov    %ebx,%eax
  1021d2:	83 c4 04             	add    $0x4,%esp
  1021d5:	5b                   	pop    %ebx
  1021d6:	5d                   	pop    %ebp
  1021d7:	c3                   	ret    
  1021d8:	90                   	nop    
  1021d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

001021e0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
  1021e0:	55                   	push   %ebp
  1021e1:	89 e5                	mov    %esp,%ebp
  1021e3:	53                   	push   %ebx
  1021e4:	83 ec 14             	sub    $0x14,%esp
  1021e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if(((uint) v) % PGSIZE || (uint)v < 1024*1024 || (uint)v >= PHYSTOP) 
  1021ea:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
  1021f0:	75 10                	jne    102202 <kfree+0x22>
  1021f2:	81 fb ff ff 0f 00    	cmp    $0xfffff,%ebx
  1021f8:	76 08                	jbe    102202 <kfree+0x22>
  1021fa:	81 fb ff ff ff 00    	cmp    $0xffffff,%ebx
  102200:	76 0e                	jbe    102210 <kfree+0x30>
    panic("kfree");
  102202:	c7 04 24 36 6e 10 00 	movl   $0x106e36,(%esp)
  102209:	e8 72 e6 ff ff       	call   100880 <panic>
  10220e:	66 90                	xchg   %ax,%ax

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
  102210:	89 1c 24             	mov    %ebx,(%esp)
  102213:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  10221a:	00 
  10221b:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  102222:	00 
  102223:	e8 d8 1a 00 00       	call   103d00 <memset>

  acquire(&kmem.lock);
  102228:	c7 04 24 e0 bf 10 00 	movl   $0x10bfe0,(%esp)
  10222f:	e8 5c 1a 00 00       	call   103c90 <acquire>
  r = (struct run *) v;
  r->next = kmem.freelist;
  102234:	a1 14 c0 10 00       	mov    0x10c014,%eax
  102239:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  10223b:	89 1d 14 c0 10 00    	mov    %ebx,0x10c014
  release(&kmem.lock);
  102241:	c7 45 08 e0 bf 10 00 	movl   $0x10bfe0,0x8(%ebp)
}
  102248:	83 c4 14             	add    $0x14,%esp
  10224b:	5b                   	pop    %ebx
  10224c:	5d                   	pop    %ebp

  acquire(&kmem.lock);
  r = (struct run *) v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  release(&kmem.lock);
  10224d:	e9 fe 19 00 00       	jmp    103c50 <release>
  102252:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  102259:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00102260 <kinit>:
} kmem;

// Initialize free list of physical pages.
void
kinit(void)
{
  102260:	55                   	push   %ebp
  102261:	89 e5                	mov    %esp,%ebp
  102263:	53                   	push   %ebx
  extern char end[];

  initlock(&kmem.lock, "kmem");
  char *p = (char*)PGROUNDUP((uint)end);
  102264:	bb c3 0c 11 00       	mov    $0x110cc3,%ebx
} kmem;

// Initialize free list of physical pages.
void
kinit(void)
{
  102269:	83 ec 14             	sub    $0x14,%esp
  extern char end[];

  initlock(&kmem.lock, "kmem");
  char *p = (char*)PGROUNDUP((uint)end);
  10226c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
void
kinit(void)
{
  extern char end[];

  initlock(&kmem.lock, "kmem");
  102272:	c7 44 24 04 3c 6e 10 	movl   $0x106e3c,0x4(%esp)
  102279:	00 
  10227a:	c7 04 24 e0 bf 10 00 	movl   $0x10bfe0,(%esp)
  102281:	e8 8a 18 00 00       	call   103b10 <initlock>
  char *p = (char*)PGROUNDUP((uint)end);
  for( ; p + PGSIZE - 1 < (char*) PHYSTOP; p += PGSIZE)
  102286:	8d 83 ff 0f 00 00    	lea    0xfff(%ebx),%eax
  10228c:	3d ff ff ff 00       	cmp    $0xffffff,%eax
  102291:	77 1b                	ja     1022ae <kinit+0x4e>
    kfree(p);
  102293:	89 1c 24             	mov    %ebx,(%esp)
{
  extern char end[];

  initlock(&kmem.lock, "kmem");
  char *p = (char*)PGROUNDUP((uint)end);
  for( ; p + PGSIZE - 1 < (char*) PHYSTOP; p += PGSIZE)
  102296:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
  10229c:	e8 3f ff ff ff       	call   1021e0 <kfree>
{
  extern char end[];

  initlock(&kmem.lock, "kmem");
  char *p = (char*)PGROUNDUP((uint)end);
  for( ; p + PGSIZE - 1 < (char*) PHYSTOP; p += PGSIZE)
  1022a1:	8d 83 ff 0f 00 00    	lea    0xfff(%ebx),%eax
  1022a7:	3d ff ff ff 00       	cmp    $0xffffff,%eax
  1022ac:	76 e5                	jbe    102293 <kinit+0x33>
    kfree(p);
}
  1022ae:	83 c4 14             	add    $0x14,%esp
  1022b1:	5b                   	pop    %ebx
  1022b2:	5d                   	pop    %ebp
  1022b3:	c3                   	ret    
  1022b4:	90                   	nop    
  1022b5:	90                   	nop    
  1022b6:	90                   	nop    
  1022b7:	90                   	nop    
  1022b8:	90                   	nop    
  1022b9:	90                   	nop    
  1022ba:	90                   	nop    
  1022bb:	90                   	nop    
  1022bc:	90                   	nop    
  1022bd:	90                   	nop    
  1022be:	90                   	nop    
  1022bf:	90                   	nop    

001022c0 <kbdintr>:
  return c;
}

void
kbdintr(void)
{
  1022c0:	55                   	push   %ebp
  1022c1:	89 e5                	mov    %esp,%ebp
  1022c3:	83 ec 08             	sub    $0x8,%esp
  consoleintr(kbdgetc);
  1022c6:	c7 04 24 e0 22 10 00 	movl   $0x1022e0,(%esp)
  1022cd:	e8 2e e4 ff ff       	call   100700 <consoleintr>
}
  1022d2:	c9                   	leave  
  1022d3:	c3                   	ret    
  1022d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1022da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001022e0 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
  1022e0:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1022e1:	ba 64 00 00 00       	mov    $0x64,%edx
  1022e6:	89 e5                	mov    %esp,%ebp
  1022e8:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
  1022e9:	a8 01                	test   $0x1,%al
  1022eb:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  1022f0:	74 3e                	je     102330 <kbdgetc+0x50>
  1022f2:	ba 60 00 00 00       	mov    $0x60,%edx
  1022f7:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
  1022f8:	3c e0                	cmp    $0xe0,%al
  1022fa:	0f 84 84 00 00 00    	je     102384 <kbdgetc+0xa4>
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);
  102300:	0f b6 c8             	movzbl %al,%ecx

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
  102303:	84 c9                	test   %cl,%cl
  102305:	79 2d                	jns    102334 <kbdgetc+0x54>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
  102307:	8b 15 dc 8d 10 00    	mov    0x108ddc,%edx
  10230d:	f6 c2 40             	test   $0x40,%dl
  102310:	75 03                	jne    102315 <kbdgetc+0x35>
  102312:	83 e1 7f             	and    $0x7f,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
  102315:	0f b6 81 60 6e 10 00 	movzbl 0x106e60(%ecx),%eax
  10231c:	83 c8 40             	or     $0x40,%eax
  10231f:	0f b6 c0             	movzbl %al,%eax
  102322:	f7 d0                	not    %eax
  102324:	21 d0                	and    %edx,%eax
  102326:	31 d2                	xor    %edx,%edx
  102328:	a3 dc 8d 10 00       	mov    %eax,0x108ddc
  10232d:	8d 76 00             	lea    0x0(%esi),%esi
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
  102330:	5d                   	pop    %ebp
  102331:	89 d0                	mov    %edx,%eax
  102333:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
  102334:	a1 dc 8d 10 00       	mov    0x108ddc,%eax
  102339:	a8 40                	test   $0x40,%al
  10233b:	74 0b                	je     102348 <kbdgetc+0x68>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
    shift &= ~E0ESC;
  10233d:	83 e0 bf             	and    $0xffffffbf,%eax
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
  102340:	80 c9 80             	or     $0x80,%cl
    shift &= ~E0ESC;
  102343:	a3 dc 8d 10 00       	mov    %eax,0x108ddc
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  102348:	0f b6 91 60 6f 10 00 	movzbl 0x106f60(%ecx),%edx
  10234f:	0f b6 81 60 6e 10 00 	movzbl 0x106e60(%ecx),%eax
  102356:	0b 05 dc 8d 10 00    	or     0x108ddc,%eax
  10235c:	31 d0                	xor    %edx,%eax
  c = charcode[shift & (CTL | SHIFT)][data];
  10235e:	89 c2                	mov    %eax,%edx
  102360:	83 e2 03             	and    $0x3,%edx
  if(shift & CAPSLOCK){
  102363:	a8 08                	test   $0x8,%al
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  102365:	8b 14 95 60 70 10 00 	mov    0x107060(,%edx,4),%edx
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  10236c:	a3 dc 8d 10 00       	mov    %eax,0x108ddc
  c = charcode[shift & (CTL | SHIFT)][data];
  102371:	0f b6 14 0a          	movzbl (%edx,%ecx,1),%edx
  if(shift & CAPSLOCK){
  102375:	74 b9                	je     102330 <kbdgetc+0x50>
    if('a' <= c && c <= 'z')
  102377:	8d 42 9f             	lea    -0x61(%edx),%eax
  10237a:	83 f8 19             	cmp    $0x19,%eax
  10237d:	77 12                	ja     102391 <kbdgetc+0xb1>
      c += 'A' - 'a';
  10237f:	83 ea 20             	sub    $0x20,%edx
  102382:	eb ac                	jmp    102330 <kbdgetc+0x50>
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
  102384:	83 0d dc 8d 10 00 40 	orl    $0x40,0x108ddc
  10238b:	31 d2                	xor    %edx,%edx
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
  10238d:	5d                   	pop    %ebp
  10238e:	89 d0                	mov    %edx,%eax
  102390:	c3                   	ret    
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
  102391:	8d 42 bf             	lea    -0x41(%edx),%eax
  102394:	83 f8 19             	cmp    $0x19,%eax
  102397:	77 97                	ja     102330 <kbdgetc+0x50>
      c += 'a' - 'A';
  102399:	83 c2 20             	add    $0x20,%edx
  10239c:	eb 92                	jmp    102330 <kbdgetc+0x50>
  10239e:	90                   	nop    
  10239f:	90                   	nop    

001023a0 <lapicw>:
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1023a0:	c1 e0 02             	shl    $0x2,%eax
  1023a3:	03 05 18 c0 10 00    	add    0x10c018,%eax

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  1023a9:	55                   	push   %ebp
  1023aa:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
  1023ac:	89 10                	mov    %edx,(%eax)
  lapic[ID];  // wait for write to finish, by reading
  1023ae:	a1 18 c0 10 00       	mov    0x10c018,%eax
}
  1023b3:	5d                   	pop    %ebp

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  lapic[ID];  // wait for write to finish, by reading
  1023b4:	83 c0 20             	add    $0x20,%eax
  1023b7:	8b 00                	mov    (%eax),%eax
}
  1023b9:	c3                   	ret    
  1023ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001023c0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
  1023c0:	a1 18 c0 10 00       	mov    0x10c018,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
  1023c5:	55                   	push   %ebp
  1023c6:	89 e5                	mov    %esp,%ebp
  if(lapic)
  1023c8:	85 c0                	test   %eax,%eax
  1023ca:	74 0a                	je     1023d6 <lapiceoi+0x16>
    lapicw(EOI, 0);
}
  1023cc:	5d                   	pop    %ebp
// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
  1023cd:	31 d2                	xor    %edx,%edx
  1023cf:	b8 2c 00 00 00       	mov    $0x2c,%eax
  1023d4:	eb ca                	jmp    1023a0 <lapicw>
}
  1023d6:	5d                   	pop    %ebp
  1023d7:	c3                   	ret    
  1023d8:	90                   	nop    
  1023d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

001023e0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
  1023e0:	55                   	push   %ebp
  1023e1:	89 e5                	mov    %esp,%ebp
}
  1023e3:	5d                   	pop    %ebp
  1023e4:	c3                   	ret    
  1023e5:	8d 74 26 00          	lea    0x0(%esi),%esi
  1023e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001023f0 <cpunum>:
  lapicw(TPR, 0);
}

int
cpunum(void)
{
  1023f0:	55                   	push   %ebp
  1023f1:	89 e5                	mov    %esp,%ebp
  1023f3:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  1023f6:	9c                   	pushf  
  1023f7:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
  1023f8:	f6 c4 02             	test   $0x2,%ah
  1023fb:	74 12                	je     10240f <cpunum+0x1f>
    static int n;
    if(n++ == 0)
  1023fd:	a1 e0 8d 10 00       	mov    0x108de0,%eax
  102402:	83 c0 01             	add    $0x1,%eax
  102405:	a3 e0 8d 10 00       	mov    %eax,0x108de0
  10240a:	83 e8 01             	sub    $0x1,%eax
  10240d:	74 14                	je     102423 <cpunum+0x33>
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if(lapic)
  10240f:	8b 15 18 c0 10 00    	mov    0x10c018,%edx
  102415:	31 c0                	xor    %eax,%eax
  102417:	85 d2                	test   %edx,%edx
  102419:	74 06                	je     102421 <cpunum+0x31>
    return lapic[ID]>>24;
  10241b:	8b 42 20             	mov    0x20(%edx),%eax
  10241e:	c1 e8 18             	shr    $0x18,%eax
  return 0;
}
  102421:	c9                   	leave  
  102422:	c3                   	ret    
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
  102423:	8b 45 04             	mov    0x4(%ebp),%eax
  102426:	c7 04 24 70 70 10 00 	movl   $0x107070,(%esp)
  10242d:	89 44 24 04          	mov    %eax,0x4(%esp)
  102431:	e8 8a e0 ff ff       	call   1004c0 <cprintf>
  102436:	eb d7                	jmp    10240f <cpunum+0x1f>
  102438:	90                   	nop    
  102439:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00102440 <lapicinit>:
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(int c)
{
  102440:	55                   	push   %ebp
  102441:	89 e5                	mov    %esp,%ebp
  102443:	83 ec 18             	sub    $0x18,%esp
  cprintf("lapicinit: %d 0x%x\n", c, lapic);
  102446:	a1 18 c0 10 00       	mov    0x10c018,%eax
  10244b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10244f:	8b 45 08             	mov    0x8(%ebp),%eax
  102452:	c7 04 24 9c 70 10 00 	movl   $0x10709c,(%esp)
  102459:	89 44 24 04          	mov    %eax,0x4(%esp)
  10245d:	e8 5e e0 ff ff       	call   1004c0 <cprintf>
  if(!lapic) 
  102462:	8b 15 18 c0 10 00    	mov    0x10c018,%edx
  102468:	85 d2                	test   %edx,%edx
  10246a:	0f 84 ea 00 00 00    	je     10255a <lapicinit+0x11a>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
  102470:	ba 3f 01 00 00       	mov    $0x13f,%edx
  102475:	b8 3c 00 00 00       	mov    $0x3c,%eax
  10247a:	e8 21 ff ff ff       	call   1023a0 <lapicw>

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
  10247f:	ba 0b 00 00 00       	mov    $0xb,%edx
  102484:	b8 f8 00 00 00       	mov    $0xf8,%eax
  102489:	e8 12 ff ff ff       	call   1023a0 <lapicw>
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
  10248e:	ba 20 00 02 00       	mov    $0x20020,%edx
  102493:	b8 c8 00 00 00       	mov    $0xc8,%eax
  102498:	e8 03 ff ff ff       	call   1023a0 <lapicw>
  lapicw(TICR, 10000000); 
  10249d:	ba 80 96 98 00       	mov    $0x989680,%edx
  1024a2:	b8 e0 00 00 00       	mov    $0xe0,%eax
  1024a7:	e8 f4 fe ff ff       	call   1023a0 <lapicw>

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
  1024ac:	ba 00 00 01 00       	mov    $0x10000,%edx
  1024b1:	b8 d4 00 00 00       	mov    $0xd4,%eax
  1024b6:	e8 e5 fe ff ff       	call   1023a0 <lapicw>
  lapicw(LINT1, MASKED);
  1024bb:	b8 d8 00 00 00       	mov    $0xd8,%eax
  1024c0:	ba 00 00 01 00       	mov    $0x10000,%edx
  1024c5:	e8 d6 fe ff ff       	call   1023a0 <lapicw>

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
  1024ca:	a1 18 c0 10 00       	mov    0x10c018,%eax
  1024cf:	83 c0 30             	add    $0x30,%eax
  1024d2:	8b 00                	mov    (%eax),%eax
  1024d4:	c1 e8 10             	shr    $0x10,%eax
  1024d7:	3c 03                	cmp    $0x3,%al
  1024d9:	77 6e                	ja     102549 <lapicinit+0x109>
    lapicw(PCINT, MASKED);

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
  1024db:	ba 33 00 00 00       	mov    $0x33,%edx
  1024e0:	b8 dc 00 00 00       	mov    $0xdc,%eax
  1024e5:	e8 b6 fe ff ff       	call   1023a0 <lapicw>

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
  1024ea:	31 d2                	xor    %edx,%edx
  1024ec:	b8 a0 00 00 00       	mov    $0xa0,%eax
  1024f1:	e8 aa fe ff ff       	call   1023a0 <lapicw>
  lapicw(ESR, 0);
  1024f6:	31 d2                	xor    %edx,%edx
  1024f8:	b8 a0 00 00 00       	mov    $0xa0,%eax
  1024fd:	e8 9e fe ff ff       	call   1023a0 <lapicw>

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
  102502:	31 d2                	xor    %edx,%edx
  102504:	b8 2c 00 00 00       	mov    $0x2c,%eax
  102509:	e8 92 fe ff ff       	call   1023a0 <lapicw>

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  10250e:	31 d2                	xor    %edx,%edx
  102510:	b8 c4 00 00 00       	mov    $0xc4,%eax
  102515:	e8 86 fe ff ff       	call   1023a0 <lapicw>
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  10251a:	ba 00 85 08 00       	mov    $0x88500,%edx
  10251f:	b8 c0 00 00 00       	mov    $0xc0,%eax
  102524:	e8 77 fe ff ff       	call   1023a0 <lapicw>
  while(lapic[ICRLO] & DELIVS)
  102529:	8b 15 18 c0 10 00    	mov    0x10c018,%edx
  10252f:	81 c2 00 03 00 00    	add    $0x300,%edx
  102535:	8b 02                	mov    (%edx),%eax
  102537:	f6 c4 10             	test   $0x10,%ah
  10253a:	75 f9                	jne    102535 <lapicinit+0xf5>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
  10253c:	c9                   	leave  
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
  10253d:	31 d2                	xor    %edx,%edx
  10253f:	b8 20 00 00 00       	mov    $0x20,%eax
  102544:	e9 57 fe ff ff       	jmp    1023a0 <lapicw>
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
    lapicw(PCINT, MASKED);
  102549:	ba 00 00 01 00       	mov    $0x10000,%edx
  10254e:	b8 d0 00 00 00       	mov    $0xd0,%eax
  102553:	e8 48 fe ff ff       	call   1023a0 <lapicw>
  102558:	eb 81                	jmp    1024db <lapicinit+0x9b>
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
  10255a:	c9                   	leave  
  10255b:	c3                   	ret    
  10255c:	8d 74 26 00          	lea    0x0(%esi),%esi

00102560 <lapicstartap>:

// Start additional processor running bootstrap code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
  102560:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102561:	b8 0f 00 00 00       	mov    $0xf,%eax
  102566:	89 e5                	mov    %esp,%ebp
  102568:	ba 70 00 00 00       	mov    $0x70,%edx
  10256d:	56                   	push   %esi
  10256e:	53                   	push   %ebx
  10256f:	8b 75 0c             	mov    0xc(%ebp),%esi
  102572:	0f b6 5d 08          	movzbl 0x8(%ebp),%ebx
  102576:	ee                   	out    %al,(%dx)
  wrv[0] = 0;
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
  102577:	b8 0a 00 00 00       	mov    $0xa,%eax
  10257c:	b2 71                	mov    $0x71,%dl
  10257e:	ee                   	out    %al,(%dx)
  10257f:	c1 e3 18             	shl    $0x18,%ebx
  102582:	b8 c4 00 00 00       	mov    $0xc4,%eax
  102587:	89 da                	mov    %ebx,%edx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  outb(IO_RTC+1, 0x0A);
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
  102589:	c1 ee 04             	shr    $0x4,%esi
  10258c:	66 89 35 69 04 00 00 	mov    %si,0x469
  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
  microdelay(200);
  lapicw(ICRLO, INIT | LEVEL);
  102593:	c1 ee 08             	shr    $0x8,%esi
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  outb(IO_RTC+1, 0x0A);
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  wrv[0] = 0;
  102596:	66 c7 05 67 04 00 00 	movw   $0x0,0x467
  10259d:	00 00 
  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
  microdelay(200);
  lapicw(ICRLO, INIT | LEVEL);
  10259f:	81 ce 00 06 00 00    	or     $0x600,%esi
  wrv[0] = 0;
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
  1025a5:	e8 f6 fd ff ff       	call   1023a0 <lapicw>
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
  1025aa:	ba 00 c5 00 00       	mov    $0xc500,%edx
  1025af:	b8 c0 00 00 00       	mov    $0xc0,%eax
  1025b4:	e8 e7 fd ff ff       	call   1023a0 <lapicw>
  microdelay(200);
  lapicw(ICRLO, INIT | LEVEL);
  1025b9:	ba 00 85 00 00       	mov    $0x8500,%edx
  1025be:	b8 c0 00 00 00       	mov    $0xc0,%eax
  1025c3:	e8 d8 fd ff ff       	call   1023a0 <lapicw>
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
  1025c8:	89 da                	mov    %ebx,%edx
  1025ca:	b8 c4 00 00 00       	mov    $0xc4,%eax
  1025cf:	e8 cc fd ff ff       	call   1023a0 <lapicw>
    lapicw(ICRLO, STARTUP | (addr>>12));
  1025d4:	89 f2                	mov    %esi,%edx
  1025d6:	b8 c0 00 00 00       	mov    $0xc0,%eax
  1025db:	e8 c0 fd ff ff       	call   1023a0 <lapicw>
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
  1025e0:	89 da                	mov    %ebx,%edx
  1025e2:	b8 c4 00 00 00       	mov    $0xc4,%eax
  1025e7:	e8 b4 fd ff ff       	call   1023a0 <lapicw>
    lapicw(ICRLO, STARTUP | (addr>>12));
  1025ec:	89 f2                	mov    %esi,%edx
  1025ee:	b8 c0 00 00 00       	mov    $0xc0,%eax
    microdelay(200);
  }
}
  1025f3:	5b                   	pop    %ebx
  1025f4:	5e                   	pop    %esi
  1025f5:	5d                   	pop    %ebp
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
  1025f6:	e9 a5 fd ff ff       	jmp    1023a0 <lapicw>
  1025fb:	90                   	nop    
  1025fc:	90                   	nop    
  1025fd:	90                   	nop    
  1025fe:	90                   	nop    
  1025ff:	90                   	nop    

00102600 <mpmain>:
// Common CPU setup code.
// Bootstrap CPU comes here from mainc().
// Other CPUs jump here from bootother.S.
static void
mpmain(void)
{
  102600:	55                   	push   %ebp
  102601:	89 e5                	mov    %esp,%ebp
  102603:	53                   	push   %ebx
  102604:	83 ec 14             	sub    $0x14,%esp
  if(cpunum() != mpbcpu()) {
  102607:	e8 e4 fd ff ff       	call   1023f0 <cpunum>
  10260c:	89 c3                	mov    %eax,%ebx
  10260e:	e8 fd 01 00 00       	call   102810 <mpbcpu>
  102613:	39 c3                	cmp    %eax,%ebx
  102615:	74 16                	je     10262d <mpmain+0x2d>
    ksegment();
  102617:	e8 54 44 00 00       	call   106a70 <ksegment>
  10261c:	8d 74 26 00          	lea    0x0(%esi),%esi
    lapicinit(cpunum());
  102620:	e8 cb fd ff ff       	call   1023f0 <cpunum>
  102625:	89 04 24             	mov    %eax,(%esp)
  102628:	e8 13 fe ff ff       	call   102440 <lapicinit>
  }
  vmenable();        // turn on paging
  10262d:	e8 7e 3d 00 00       	call   1063b0 <vmenable>
  cprintf("cpu%d: starting\n", cpu->id);
  102632:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  102638:	0f b6 00             	movzbl (%eax),%eax
  10263b:	c7 04 24 b0 70 10 00 	movl   $0x1070b0,(%esp)
  102642:	89 44 24 04          	mov    %eax,0x4(%esp)
  102646:	e8 75 de ff ff       	call   1004c0 <cprintf>
  idtinit();       // load idt register
  10264b:	e8 70 2e 00 00       	call   1054c0 <idtinit>
  xchg(&cpu->booted, 1);
  102650:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  102657:	b8 01 00 00 00       	mov    $0x1,%eax
  10265c:	f0 87 82 a8 00 00 00 	lock xchg %eax,0xa8(%edx)
  scheduler();     // start running processes
  102663:	e8 38 0c 00 00       	call   1032a0 <scheduler>
  102668:	90                   	nop    
  102669:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00102670 <mainc>:
  panic("jkstack");
}

void
mainc(void)
{
  102670:	55                   	push   %ebp
  102671:	89 e5                	mov    %esp,%ebp
  102673:	53                   	push   %ebx
  102674:	83 ec 14             	sub    $0x14,%esp
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
  102677:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  10267d:	0f b6 00             	movzbl (%eax),%eax
  102680:	c7 04 24 c1 70 10 00 	movl   $0x1070c1,(%esp)
  102687:	89 44 24 04          	mov    %eax,0x4(%esp)
  10268b:	e8 30 de ff ff       	call   1004c0 <cprintf>
  kvmalloc();      // initialize the kernel page table
  102690:	e8 bb 3f 00 00       	call   106650 <kvmalloc>
  pinit();         // process table
  102695:	e8 56 14 00 00       	call   103af0 <pinit>
  tvinit();        // trap vectors
  10269a:	e8 51 2e 00 00       	call   1054f0 <tvinit>
  10269f:	90                   	nop    
  binit();         // buffer cache
  1026a0:	e8 db da ff ff       	call   100180 <binit>
  fileinit();      // file table
  1026a5:	e8 06 e9 ff ff       	call   100fb0 <fileinit>
  iinit();         // inode cache
  1026aa:	e8 f1 f6 ff ff       	call   101da0 <iinit>
  1026af:	90                   	nop    
  ideinit();       // disk
  1026b0:	e8 4b f9 ff ff       	call   102000 <ideinit>
  if(!ismp)
  1026b5:	a1 24 c0 10 00       	mov    0x10c024,%eax
  1026ba:	85 c0                	test   %eax,%eax
  1026bc:	0f 84 ab 00 00 00    	je     10276d <mainc+0xfd>
    timerinit();   // uniprocessor timer
  userinit();      // first user process
  1026c2:	e8 39 12 00 00       	call   103900 <userinit>
  char *stack;

  // Write bootstrap code to unused memory at 0x7000.  The linker has
  // placed the start of bootother.S there.
  code = (uchar *) 0x7000;
  memmove(code, _binary_bootother_start, (uint)_binary_bootother_size);
  1026c7:	c7 44 24 08 6a 00 00 	movl   $0x6a,0x8(%esp)
  1026ce:	00 
  1026cf:	c7 44 24 04 d4 8c 10 	movl   $0x108cd4,0x4(%esp)
  1026d6:	00 
  1026d7:	c7 04 24 00 70 00 00 	movl   $0x7000,(%esp)
  1026de:	e8 bd 16 00 00       	call   103da0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
  1026e3:	69 05 20 c6 10 00 bc 	imul   $0xbc,0x10c620,%eax
  1026ea:	00 00 00 
  1026ed:	05 40 c0 10 00       	add    $0x10c040,%eax
  1026f2:	3d 40 c0 10 00       	cmp    $0x10c040,%eax
  1026f7:	76 6a                	jbe    102763 <mainc+0xf3>
  1026f9:	bb 40 c0 10 00       	mov    $0x10c040,%ebx
  1026fe:	66 90                	xchg   %ax,%ax
    if(c == cpus+cpunum())  // We've started already.
  102700:	e8 eb fc ff ff       	call   1023f0 <cpunum>
  102705:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
  10270b:	05 40 c0 10 00       	add    $0x10c040,%eax
  102710:	39 d8                	cmp    %ebx,%eax
  102712:	74 36                	je     10274a <mainc+0xda>
      continue;

    // Fill in %esp, %eip and start code on cpu.
    stack = kalloc();
  102714:	e8 87 fa ff ff       	call   1021a0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpmain;
  102719:	c7 05 f8 6f 00 00 00 	movl   $0x102600,0x6ff8
  102720:	26 10 00 
    if(c == cpus+cpunum())  // We've started already.
      continue;

    // Fill in %esp, %eip and start code on cpu.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
  102723:	05 00 10 00 00       	add    $0x1000,%eax
  102728:	a3 fc 6f 00 00       	mov    %eax,0x6ffc
    *(void**)(code-8) = mpmain;
    lapicstartap(c->id, (uint)code);
  10272d:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
  102734:	00 
  102735:	0f b6 03             	movzbl (%ebx),%eax
  102738:	89 04 24             	mov    %eax,(%esp)
  10273b:	e8 20 fe ff ff       	call   102560 <lapicstartap>

    // Wait for cpu to finish mpmain()
    while(c->booted == 0)
  102740:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
  102746:	85 c0                	test   %eax,%eax
  102748:	74 f6                	je     102740 <mainc+0xd0>
  // Write bootstrap code to unused memory at 0x7000.  The linker has
  // placed the start of bootother.S there.
  code = (uchar *) 0x7000;
  memmove(code, _binary_bootother_start, (uint)_binary_bootother_size);

  for(c = cpus; c < cpus+ncpu; c++){
  10274a:	69 05 20 c6 10 00 bc 	imul   $0xbc,0x10c620,%eax
  102751:	00 00 00 
  102754:	81 c3 bc 00 00 00    	add    $0xbc,%ebx
  10275a:	05 40 c0 10 00       	add    $0x10c040,%eax
  10275f:	39 d8                	cmp    %ebx,%eax
  102761:	77 9d                	ja     102700 <mainc+0x90>
  userinit();      // first user process
  bootothers();    // start other processors

  // Finish setting up this processor in mpmain.
  mpmain();
}
  102763:	83 c4 14             	add    $0x14,%esp
  102766:	5b                   	pop    %ebx
  102767:	5d                   	pop    %ebp
    timerinit();   // uniprocessor timer
  userinit();      // first user process
  bootothers();    // start other processors

  // Finish setting up this processor in mpmain.
  mpmain();
  102768:	e9 93 fe ff ff       	jmp    102600 <mpmain>
  binit();         // buffer cache
  fileinit();      // file table
  iinit();         // inode cache
  ideinit();       // disk
  if(!ismp)
    timerinit();   // uniprocessor timer
  10276d:	e8 ee 2c 00 00       	call   105460 <timerinit>
  102772:	e9 4b ff ff ff       	jmp    1026c2 <mainc+0x52>
  102777:	89 f6                	mov    %esi,%esi
  102779:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00102780 <jkstack>:
  jkstack();       // call mainc() on a properly-allocated stack 
}

void
jkstack(void)
{
  102780:	55                   	push   %ebp
  102781:	89 e5                	mov    %esp,%ebp
  102783:	83 ec 08             	sub    $0x8,%esp
  char *kstack = kalloc();
  102786:	e8 15 fa ff ff       	call   1021a0 <kalloc>
  if(!kstack)
  10278b:	85 c0                	test   %eax,%eax
  10278d:	75 0c                	jne    10279b <jkstack+0x1b>
    panic("jkstack\n");
  10278f:	c7 04 24 d8 70 10 00 	movl   $0x1070d8,(%esp)
  102796:	e8 e5 e0 ff ff       	call   100880 <panic>
  char *top = kstack + PGSIZE;
  asm volatile("movl %0,%%esp" : : "r" (top));
  10279b:	05 00 10 00 00       	add    $0x1000,%eax
  1027a0:	89 c4                	mov    %eax,%esp
  asm volatile("call mainc");
  1027a2:	e8 c9 fe ff ff       	call   102670 <mainc>
  panic("jkstack");
  1027a7:	c7 04 24 e1 70 10 00 	movl   $0x1070e1,(%esp)
  1027ae:	e8 cd e0 ff ff       	call   100880 <panic>
  1027b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1027b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001027c0 <main>:
void mainc(void);

// Bootstrap processor starts running C code here.
int
main(void)
{
  1027c0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  1027c4:	83 e4 f0             	and    $0xfffffff0,%esp
  1027c7:	ff 71 fc             	pushl  -0x4(%ecx)
  1027ca:	55                   	push   %ebp
  1027cb:	89 e5                	mov    %esp,%ebp
  1027cd:	51                   	push   %ecx
  1027ce:	83 ec 04             	sub    $0x4,%esp
  mpinit();        // collect info about this machine
  1027d1:	e8 0a 01 00 00       	call   1028e0 <mpinit>
  lapicinit(mpbcpu());
  1027d6:	e8 35 00 00 00       	call   102810 <mpbcpu>
  1027db:	89 04 24             	mov    %eax,(%esp)
  1027de:	e8 5d fc ff ff       	call   102440 <lapicinit>
  ksegment();      // set up segments
  1027e3:	e8 88 42 00 00       	call   106a70 <ksegment>
  picinit();       // interrupt controller
  1027e8:	e8 23 03 00 00       	call   102b10 <picinit>
  1027ed:	8d 76 00             	lea    0x0(%esi),%esi
  ioapicinit();    // another interrupt controller
  1027f0:	e8 1b f9 ff ff       	call   102110 <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
  1027f5:	e8 f6 d9 ff ff       	call   1001f0 <consoleinit>
  uartinit();      // serial port
  1027fa:	e8 71 30 00 00       	call   105870 <uartinit>
  1027ff:	90                   	nop    
  kinit();         // initialize memory allocator
  102800:	e8 5b fa ff ff       	call   102260 <kinit>
  jkstack();       // call mainc() on a properly-allocated stack 
  102805:	e8 76 ff ff ff       	call   102780 <jkstack>
  10280a:	90                   	nop    
  10280b:	90                   	nop    
  10280c:	90                   	nop    
  10280d:	90                   	nop    
  10280e:	90                   	nop    
  10280f:	90                   	nop    

00102810 <mpbcpu>:
uchar ioapicid;

int
mpbcpu(void)
{
  return bcpu-cpus;
  102810:	a1 e4 8d 10 00       	mov    0x108de4,%eax
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
  102815:	55                   	push   %ebp
  102816:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
}
  102818:	5d                   	pop    %ebp
uchar ioapicid;

int
mpbcpu(void)
{
  return bcpu-cpus;
  102819:	2d 40 c0 10 00       	sub    $0x10c040,%eax
  10281e:	c1 f8 02             	sar    $0x2,%eax
  102821:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
  102827:	c3                   	ret    
  102828:	90                   	nop    
  102829:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00102830 <sum>:

static uchar
sum(uchar *addr, int len)
{
  102830:	55                   	push   %ebp
  102831:	89 e5                	mov    %esp,%ebp
  102833:	56                   	push   %esi
  102834:	89 c6                	mov    %eax,%esi
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102836:	31 c0                	xor    %eax,%eax
  102838:	85 d2                	test   %edx,%edx
  return bcpu-cpus;
}

static uchar
sum(uchar *addr, int len)
{
  10283a:	53                   	push   %ebx
  10283b:	89 d3                	mov    %edx,%ebx
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  10283d:	7e 14                	jle    102853 <sum+0x23>
  10283f:	31 c9                	xor    %ecx,%ecx
  102841:	31 d2                	xor    %edx,%edx
    sum += addr[i];
  102843:	0f b6 04 31          	movzbl (%ecx,%esi,1),%eax
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102847:	83 c1 01             	add    $0x1,%ecx
    sum += addr[i];
  10284a:	01 c2                	add    %eax,%edx
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  10284c:	39 d9                	cmp    %ebx,%ecx
  10284e:	75 f3                	jne    102843 <sum+0x13>
  102850:	0f b6 c2             	movzbl %dl,%eax
    sum += addr[i];
  return sum;
}
  102853:	5b                   	pop    %ebx
  102854:	5e                   	pop    %esi
  102855:	5d                   	pop    %ebp
  102856:	c3                   	ret    
  102857:	89 f6                	mov    %esi,%esi
  102859:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00102860 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uchar *addr, int len)
{
  102860:	55                   	push   %ebp
  102861:	89 e5                	mov    %esp,%ebp
  102863:	57                   	push   %edi
  102864:	56                   	push   %esi
  102865:	89 c6                	mov    %eax,%esi
  102867:	53                   	push   %ebx
  102868:	89 d3                	mov    %edx,%ebx
  10286a:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p;

  cprintf("mpsearch1 0x%x %d\n", addr, len);
  e = addr+len;
  10286d:	8d 3c 1e             	lea    (%esi,%ebx,1),%edi
static struct mp*
mpsearch1(uchar *addr, int len)
{
  uchar *e, *p;

  cprintf("mpsearch1 0x%x %d\n", addr, len);
  102870:	89 54 24 08          	mov    %edx,0x8(%esp)
  102874:	89 44 24 04          	mov    %eax,0x4(%esp)
  102878:	c7 04 24 e9 70 10 00 	movl   $0x1070e9,(%esp)
  10287f:	e8 3c dc ff ff       	call   1004c0 <cprintf>
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
  102884:	39 fe                	cmp    %edi,%esi
  102886:	73 45                	jae    1028cd <mpsearch1+0x6d>
  102888:	89 f3                	mov    %esi,%ebx
  10288a:	eb 0b                	jmp    102897 <mpsearch1+0x37>
  10288c:	8d 74 26 00          	lea    0x0(%esi),%esi
  102890:	83 c3 10             	add    $0x10,%ebx
  102893:	39 df                	cmp    %ebx,%edi
  102895:	76 36                	jbe    1028cd <mpsearch1+0x6d>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  102897:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  10289e:	00 
  10289f:	c7 44 24 04 fc 70 10 	movl   $0x1070fc,0x4(%esp)
  1028a6:	00 
  1028a7:	89 1c 24             	mov    %ebx,(%esp)
  1028aa:	e8 71 14 00 00       	call   103d20 <memcmp>
  1028af:	85 c0                	test   %eax,%eax
  1028b1:	75 dd                	jne    102890 <mpsearch1+0x30>
  1028b3:	ba 10 00 00 00       	mov    $0x10,%edx
  1028b8:	89 d8                	mov    %ebx,%eax
  1028ba:	e8 71 ff ff ff       	call   102830 <sum>
  1028bf:	84 c0                	test   %al,%al
  1028c1:	75 cd                	jne    102890 <mpsearch1+0x30>
      return (struct mp*)p;
  return 0;
}
  1028c3:	83 c4 0c             	add    $0xc,%esp

  cprintf("mpsearch1 0x%x %d\n", addr, len);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  1028c6:	89 d8                	mov    %ebx,%eax
  return 0;
}
  1028c8:	5b                   	pop    %ebx
  1028c9:	5e                   	pop    %esi
  1028ca:	5f                   	pop    %edi
  1028cb:	5d                   	pop    %ebp
  1028cc:	c3                   	ret    
  1028cd:	83 c4 0c             	add    $0xc,%esp
{
  uchar *e, *p;

  cprintf("mpsearch1 0x%x %d\n", addr, len);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
  1028d0:	31 c0                	xor    %eax,%eax
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
  1028d2:	5b                   	pop    %ebx
  1028d3:	5e                   	pop    %esi
  1028d4:	5f                   	pop    %edi
  1028d5:	5d                   	pop    %ebp
  1028d6:	c3                   	ret    
  1028d7:	89 f6                	mov    %esi,%esi
  1028d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001028e0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
  1028e0:	55                   	push   %ebp
  1028e1:	89 e5                	mov    %esp,%ebp
  1028e3:	83 ec 28             	sub    $0x28,%esp
  1028e6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  1028e9:	89 75 f8             	mov    %esi,-0x8(%ebp)
  1028ec:	89 7d fc             	mov    %edi,-0x4(%ebp)
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar*)0x400;
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
  1028ef:	0f b6 0d 0f 04 00 00 	movzbl 0x40f,%ecx
  1028f6:	0f b6 05 0e 04 00 00 	movzbl 0x40e,%eax
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
  1028fd:	c7 05 e4 8d 10 00 40 	movl   $0x10c040,0x108de4
  102904:	c0 10 00 
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar*)0x400;
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
  102907:	c1 e1 08             	shl    $0x8,%ecx
  10290a:	09 c1                	or     %eax,%ecx
  10290c:	c1 e1 04             	shl    $0x4,%ecx
  10290f:	85 c9                	test   %ecx,%ecx
  102911:	74 4e                	je     102961 <mpinit+0x81>
    if((mp = mpsearch1((uchar*)p, 1024)))
  102913:	ba 00 04 00 00       	mov    $0x400,%edx
  102918:	89 c8                	mov    %ecx,%eax
  10291a:	e8 41 ff ff ff       	call   102860 <mpsearch1>
  10291f:	85 c0                	test   %eax,%eax
  102921:	89 c6                	mov    %eax,%esi
  102923:	74 67                	je     10298c <mpinit+0xac>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  102925:	8b 5e 04             	mov    0x4(%esi),%ebx
  102928:	85 db                	test   %ebx,%ebx
  10292a:	74 28                	je     102954 <mpinit+0x74>
    return 0;
  conf = (struct mpconf*)mp->physaddr;
  if(memcmp(conf, "PCMP", 4) != 0)
  10292c:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  102933:	00 
  102934:	c7 44 24 04 01 71 10 	movl   $0x107101,0x4(%esp)
  10293b:	00 
  10293c:	89 1c 24             	mov    %ebx,(%esp)
  10293f:	e8 dc 13 00 00       	call   103d20 <memcmp>
  102944:	85 c0                	test   %eax,%eax
  102946:	75 0c                	jne    102954 <mpinit+0x74>
    return 0;
  if(conf->version != 1 && conf->version != 4)
  102948:	0f b6 43 06          	movzbl 0x6(%ebx),%eax
  10294c:	3c 01                	cmp    $0x1,%al
  10294e:	74 53                	je     1029a3 <mpinit+0xc3>
  102950:	3c 04                	cmp    $0x4,%al
  102952:	74 4f                	je     1029a3 <mpinit+0xc3>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
  102954:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  102957:	8b 75 f8             	mov    -0x8(%ebp),%esi
  10295a:	8b 7d fc             	mov    -0x4(%ebp),%edi
  10295d:	89 ec                	mov    %ebp,%esp
  10295f:	5d                   	pop    %ebp
  102960:	c3                   	ret    
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
    if((mp = mpsearch1((uchar*)p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1((uchar*)p-1024, 1024)))
  102961:	0f b6 05 14 04 00 00 	movzbl 0x414,%eax
  102968:	0f b6 15 13 04 00 00 	movzbl 0x413,%edx
  10296f:	c1 e0 08             	shl    $0x8,%eax
  102972:	09 d0                	or     %edx,%eax
  102974:	ba 00 04 00 00       	mov    $0x400,%edx
  102979:	c1 e0 0a             	shl    $0xa,%eax
  10297c:	2d 00 04 00 00       	sub    $0x400,%eax
  102981:	e8 da fe ff ff       	call   102860 <mpsearch1>
  102986:	85 c0                	test   %eax,%eax
  102988:	89 c6                	mov    %eax,%esi
  10298a:	75 99                	jne    102925 <mpinit+0x45>
      return mp;
  }
  return mpsearch1((uchar*)0xF0000, 0x10000);
  10298c:	ba 00 00 01 00       	mov    $0x10000,%edx
  102991:	b8 00 00 0f 00       	mov    $0xf0000,%eax
  102996:	e8 c5 fe ff ff       	call   102860 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  10299b:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1((uchar*)p-1024, 1024)))
      return mp;
  }
  return mpsearch1((uchar*)0xF0000, 0x10000);
  10299d:	89 c6                	mov    %eax,%esi
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  10299f:	75 84                	jne    102925 <mpinit+0x45>
  1029a1:	eb b1                	jmp    102954 <mpinit+0x74>
  conf = (struct mpconf*)mp->physaddr;
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
  1029a3:	0f b7 53 04          	movzwl 0x4(%ebx),%edx
  1029a7:	89 d8                	mov    %ebx,%eax
  1029a9:	e8 82 fe ff ff       	call   102830 <sum>
  1029ae:	84 c0                	test   %al,%al
  1029b0:	75 a2                	jne    102954 <mpinit+0x74>
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  1029b2:	c7 05 24 c0 10 00 01 	movl   $0x1,0x10c024
  1029b9:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
  1029bc:	8b 43 24             	mov    0x24(%ebx),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  1029bf:	8d 53 2c             	lea    0x2c(%ebx),%edx

  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  1029c2:	a3 18 c0 10 00       	mov    %eax,0x10c018
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  1029c7:	0f b7 43 04          	movzwl 0x4(%ebx),%eax
  1029cb:	01 c3                	add    %eax,%ebx
  1029cd:	39 da                	cmp    %ebx,%edx
  1029cf:	89 5d ec             	mov    %ebx,-0x14(%ebp)
  1029d2:	73 60                	jae    102a34 <mpinit+0x154>
  1029d4:	a1 e4 8d 10 00       	mov    0x108de4,%eax
  1029d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1029dc:	8d 74 26 00          	lea    0x0(%esi),%esi
    switch(*p){
  1029e0:	0f b6 02             	movzbl (%edx),%eax
  1029e3:	3c 04                	cmp    $0x4,%al
  1029e5:	76 29                	jbe    102a10 <mpinit+0x130>
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
  1029e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1029ea:	a3 e4 8d 10 00       	mov    %eax,0x108de4
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
  1029ef:	0f b6 02             	movzbl (%edx),%eax
  1029f2:	c7 04 24 28 71 10 00 	movl   $0x107128,(%esp)
  1029f9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1029fd:	e8 be da ff ff       	call   1004c0 <cprintf>
      panic("mpinit");
  102a02:	c7 04 24 21 71 10 00 	movl   $0x107121,(%esp)
  102a09:	e8 72 de ff ff       	call   100880 <panic>
  102a0e:	66 90                	xchg   %ax,%ax
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
  102a10:	0f b6 c0             	movzbl %al,%eax
  102a13:	ff 24 85 48 71 10 00 	jmp    *0x107148(,%eax,4)
      ncpu++;
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
  102a1a:	0f b6 42 01          	movzbl 0x1(%edx),%eax
      p += sizeof(struct mpioapic);
  102a1e:	83 c2 08             	add    $0x8,%edx
      ncpu++;
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
  102a21:	a2 20 c0 10 00       	mov    %al,0x10c020
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  102a26:	3b 55 ec             	cmp    -0x14(%ebp),%edx
  102a29:	72 b5                	jb     1029e0 <mpinit+0x100>
  102a2b:	8b 5d f0             	mov    -0x10(%ebp),%ebx
  102a2e:	89 1d e4 8d 10 00    	mov    %ebx,0x108de4
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      panic("mpinit");
    }
  }
  if(mp->imcrp){
  102a34:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
  102a38:	0f 84 16 ff ff ff    	je     102954 <mpinit+0x74>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102a3e:	b8 70 00 00 00       	mov    $0x70,%eax
  102a43:	ba 22 00 00 00       	mov    $0x22,%edx
  102a48:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102a49:	b2 23                	mov    $0x23,%dl
  102a4b:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102a4c:	83 c8 01             	or     $0x1,%eax
  102a4f:	ee                   	out    %al,(%dx)
  102a50:	e9 ff fe ff ff       	jmp    102954 <mpinit+0x74>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
  102a55:	83 c2 08             	add    $0x8,%edx
  102a58:	eb cc                	jmp    102a26 <mpinit+0x146>
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu != proc->apicid) {
  102a5a:	0f b6 7a 01          	movzbl 0x1(%edx),%edi
  102a5e:	89 fb                	mov    %edi,%ebx
  102a60:	0f b6 cb             	movzbl %bl,%ecx
  102a63:	8b 1d 20 c6 10 00    	mov    0x10c620,%ebx
  102a69:	39 d9                	cmp    %ebx,%ecx
  102a6b:	75 2f                	jne    102a9c <mpinit+0x1bc>
        cprintf("mpinit: ncpu=%d apicpid=%d", ncpu, proc->apicid);
        panic("mpinit");
      }
      if(proc->flags & MPBOOT)
  102a6d:	f6 42 03 02          	testb  $0x2,0x3(%edx)
  102a71:	74 0e                	je     102a81 <mpinit+0x1a1>
        bcpu = &cpus[ncpu];
  102a73:	69 c1 bc 00 00 00    	imul   $0xbc,%ecx,%eax
  102a79:	05 40 c0 10 00       	add    $0x10c040,%eax
  102a7e:	89 45 f0             	mov    %eax,-0x10(%ebp)
      cpus[ncpu].id = ncpu;
  102a81:	69 c1 bc 00 00 00    	imul   $0xbc,%ecx,%eax
  102a87:	89 fb                	mov    %edi,%ebx
      ncpu++;
      p += sizeof(struct mpproc);
  102a89:	83 c2 14             	add    $0x14,%edx
        cprintf("mpinit: ncpu=%d apicpid=%d", ncpu, proc->apicid);
        panic("mpinit");
      }
      if(proc->flags & MPBOOT)
        bcpu = &cpus[ncpu];
      cpus[ncpu].id = ncpu;
  102a8c:	88 98 40 c0 10 00    	mov    %bl,0x10c040(%eax)
      ncpu++;
  102a92:	8d 41 01             	lea    0x1(%ecx),%eax
  102a95:	a3 20 c6 10 00       	mov    %eax,0x10c620
  102a9a:	eb 8a                	jmp    102a26 <mpinit+0x146>
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu != proc->apicid) {
  102a9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102a9f:	a3 e4 8d 10 00       	mov    %eax,0x108de4
        cprintf("mpinit: ncpu=%d apicpid=%d", ncpu, proc->apicid);
  102aa4:	0f b6 42 01          	movzbl 0x1(%edx),%eax
  102aa8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  102aac:	c7 04 24 06 71 10 00 	movl   $0x107106,(%esp)
  102ab3:	89 44 24 08          	mov    %eax,0x8(%esp)
  102ab7:	e8 04 da ff ff       	call   1004c0 <cprintf>
        panic("mpinit");
  102abc:	c7 04 24 21 71 10 00 	movl   $0x107121,(%esp)
  102ac3:	e8 b8 dd ff ff       	call   100880 <panic>
  102ac8:	90                   	nop    
  102ac9:	90                   	nop    
  102aca:	90                   	nop    
  102acb:	90                   	nop    
  102acc:	90                   	nop    
  102acd:	90                   	nop    
  102ace:	90                   	nop    
  102acf:	90                   	nop    

00102ad0 <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
  102ad0:	55                   	push   %ebp
  102ad1:	89 c1                	mov    %eax,%ecx
  102ad3:	89 e5                	mov    %esp,%ebp
  102ad5:	ba 21 00 00 00       	mov    $0x21,%edx
  irqmask = mask;
  102ada:	66 a3 a0 88 10 00    	mov    %ax,0x1088a0
  102ae0:	ee                   	out    %al,(%dx)
  outb(IO_PIC1+1, mask);
  outb(IO_PIC2+1, mask >> 8);
}
  102ae1:	66 c1 e9 08          	shr    $0x8,%cx
  102ae5:	b2 a1                	mov    $0xa1,%dl
  102ae7:	89 c8                	mov    %ecx,%eax
  102ae9:	ee                   	out    %al,(%dx)
  102aea:	5d                   	pop    %ebp
  102aeb:	c3                   	ret    
  102aec:	8d 74 26 00          	lea    0x0(%esi),%esi

00102af0 <picenable>:

void
picenable(int irq)
{
  102af0:	55                   	push   %ebp
  picsetmask(irqmask & ~(1<<irq));
  102af1:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
  102af6:	89 e5                	mov    %esp,%ebp
  102af8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  picsetmask(irqmask & ~(1<<irq));
}
  102afb:	5d                   	pop    %ebp
}

void
picenable(int irq)
{
  picsetmask(irqmask & ~(1<<irq));
  102afc:	d3 c0                	rol    %cl,%eax
  102afe:	66 23 05 a0 88 10 00 	and    0x1088a0,%ax
  102b05:	0f b7 c0             	movzwl %ax,%eax
  102b08:	eb c6                	jmp    102ad0 <picsetmask>
  102b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102b10 <picinit>:
}

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
  102b10:	55                   	push   %ebp
  102b11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  102b16:	89 e5                	mov    %esp,%ebp
  102b18:	83 ec 0c             	sub    $0xc,%esp
  102b1b:	89 74 24 04          	mov    %esi,0x4(%esp)
  102b1f:	be 21 00 00 00       	mov    $0x21,%esi
  102b24:	89 1c 24             	mov    %ebx,(%esp)
  102b27:	89 f2                	mov    %esi,%edx
  102b29:	89 7c 24 08          	mov    %edi,0x8(%esp)
  102b2d:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
  102b2e:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  102b33:	89 ca                	mov    %ecx,%edx
  102b35:	ee                   	out    %al,(%dx)
  102b36:	bf 11 00 00 00       	mov    $0x11,%edi
  102b3b:	b2 20                	mov    $0x20,%dl
  102b3d:	89 f8                	mov    %edi,%eax
  102b3f:	ee                   	out    %al,(%dx)
  102b40:	b8 20 00 00 00       	mov    $0x20,%eax
  102b45:	89 f2                	mov    %esi,%edx
  102b47:	ee                   	out    %al,(%dx)
  102b48:	b8 04 00 00 00       	mov    $0x4,%eax
  102b4d:	ee                   	out    %al,(%dx)
  102b4e:	bb 03 00 00 00       	mov    $0x3,%ebx
  102b53:	89 d8                	mov    %ebx,%eax
  102b55:	ee                   	out    %al,(%dx)
  102b56:	be a0 00 00 00       	mov    $0xa0,%esi
  102b5b:	89 f8                	mov    %edi,%eax
  102b5d:	89 f2                	mov    %esi,%edx
  102b5f:	ee                   	out    %al,(%dx)
  102b60:	b8 28 00 00 00       	mov    $0x28,%eax
  102b65:	89 ca                	mov    %ecx,%edx
  102b67:	ee                   	out    %al,(%dx)
  102b68:	b8 02 00 00 00       	mov    $0x2,%eax
  102b6d:	ee                   	out    %al,(%dx)
  102b6e:	89 d8                	mov    %ebx,%eax
  102b70:	ee                   	out    %al,(%dx)
  102b71:	b9 68 00 00 00       	mov    $0x68,%ecx
  102b76:	b2 20                	mov    $0x20,%dl
  102b78:	89 c8                	mov    %ecx,%eax
  102b7a:	ee                   	out    %al,(%dx)
  102b7b:	bb 0a 00 00 00       	mov    $0xa,%ebx
  102b80:	89 d8                	mov    %ebx,%eax
  102b82:	ee                   	out    %al,(%dx)
  102b83:	89 c8                	mov    %ecx,%eax
  102b85:	89 f2                	mov    %esi,%edx
  102b87:	ee                   	out    %al,(%dx)
  102b88:	89 d8                	mov    %ebx,%eax
  102b8a:	ee                   	out    %al,(%dx)
  102b8b:	0f b7 05 a0 88 10 00 	movzwl 0x1088a0,%eax
  102b92:	66 83 f8 ff          	cmp    $0xffffffff,%ax
  102b96:	74 18                	je     102bb0 <picinit+0xa0>
    picsetmask(irqmask);
}
  102b98:	8b 1c 24             	mov    (%esp),%ebx

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
    picsetmask(irqmask);
  102b9b:	0f b7 c0             	movzwl %ax,%eax
}
  102b9e:	8b 74 24 04          	mov    0x4(%esp),%esi
  102ba2:	8b 7c 24 08          	mov    0x8(%esp),%edi
  102ba6:	89 ec                	mov    %ebp,%esp
  102ba8:	5d                   	pop    %ebp

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
    picsetmask(irqmask);
  102ba9:	e9 22 ff ff ff       	jmp    102ad0 <picsetmask>
  102bae:	66 90                	xchg   %ax,%ax
}
  102bb0:	8b 1c 24             	mov    (%esp),%ebx
  102bb3:	8b 74 24 04          	mov    0x4(%esp),%esi
  102bb7:	8b 7c 24 08          	mov    0x8(%esp),%edi
  102bbb:	89 ec                	mov    %ebp,%esp
  102bbd:	5d                   	pop    %ebp
  102bbe:	c3                   	ret    
  102bbf:	90                   	nop    

00102bc0 <piperead>:
  return n;
}

int
piperead(struct pipe *p, char *addr, int n)
{
  102bc0:	55                   	push   %ebp
  102bc1:	89 e5                	mov    %esp,%ebp
  102bc3:	57                   	push   %edi
  102bc4:	56                   	push   %esi
  102bc5:	53                   	push   %ebx
  102bc6:	83 ec 0c             	sub    $0xc,%esp
  102bc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  102bcc:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
  102bcf:	89 1c 24             	mov    %ebx,(%esp)
  102bd2:	e8 b9 10 00 00       	call   103c90 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
  102bd7:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
  102bdd:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
  102be3:	75 62                	jne    102c47 <piperead+0x87>
  102be5:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
  102beb:	85 d2                	test   %edx,%edx
  102bed:	74 58                	je     102c47 <piperead+0x87>
    if(proc->common->killed){
  102bef:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  102bf5:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
  102bfb:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  102c01:	8b 40 4c             	mov    0x4c(%eax),%eax
  102c04:	85 c0                	test   %eax,%eax
  102c06:	74 25                	je     102c2d <piperead+0x6d>
  102c08:	e9 9d 00 00 00       	jmp    102caa <piperead+0xea>
  102c0d:	8d 76 00             	lea    0x0(%esi),%esi
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
  102c10:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
  102c16:	85 d2                	test   %edx,%edx
  102c18:	74 2d                	je     102c47 <piperead+0x87>
    if(proc->common->killed){
  102c1a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  102c20:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  102c26:	8b 48 4c             	mov    0x4c(%eax),%ecx
  102c29:	85 c9                	test   %ecx,%ecx
  102c2b:	75 7d                	jne    102caa <piperead+0xea>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  102c2d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  102c31:	89 34 24             	mov    %esi,(%esp)
  102c34:	e8 47 05 00 00       	call   103180 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
  102c39:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
  102c3f:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
  102c45:	74 c9                	je     102c10 <piperead+0x50>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
  102c47:	85 ff                	test   %edi,%edi
  102c49:	7e 76                	jle    102cc1 <piperead+0x101>
    if(p->nread == p->nwrite)
      break;
  102c4b:	31 f6                	xor    %esi,%esi
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    if(p->nread == p->nwrite)
  102c4d:	89 c2                	mov    %eax,%edx
  102c4f:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
  102c55:	75 11                	jne    102c68 <piperead+0xa8>
  102c57:	eb 68                	jmp    102cc1 <piperead+0x101>
  102c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  102c60:	39 93 38 02 00 00    	cmp    %edx,0x238(%ebx)
  102c66:	74 22                	je     102c8a <piperead+0xca>
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
  102c88:	75 d6                	jne    102c60 <piperead+0xa0>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  102c8a:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
  102c90:	89 04 24             	mov    %eax,(%esp)
  102c93:	e8 88 03 00 00       	call   103020 <wakeup>
  release(&p->lock);
  102c98:	89 1c 24             	mov    %ebx,(%esp)
  102c9b:	e8 b0 0f 00 00       	call   103c50 <release>
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
    if(proc->common->killed){
      release(&p->lock);
  102caa:	89 1c 24             	mov    %ebx,(%esp)
  102cad:	be ff ff ff ff       	mov    $0xffffffff,%esi
  102cb2:	e8 99 0f 00 00       	call   103c50 <release>
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
  102cc3:	eb c5                	jmp    102c8a <piperead+0xca>
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
  102cdf:	e8 ac 0f 00 00       	call   103c90 <acquire>
  for(i = 0; i < n; i++){
  102ce4:	8b 45 10             	mov    0x10(%ebp),%eax
  102ce7:	85 c0                	test   %eax,%eax
  102ce9:	0f 8e 8f 00 00 00    	jle    102d7e <pipewrite+0xae>
  102cef:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
  102cf5:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
  102cfb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  102d02:	eb 35                	jmp    102d39 <pipewrite+0x69>
    while(p->nwrite == p->nread + PIPESIZE) {  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->common->killed){
  102d04:	8b 8b 3c 02 00 00    	mov    0x23c(%ebx),%ecx
  102d0a:	85 c9                	test   %ecx,%ecx
  102d0c:	0f 84 84 00 00 00    	je     102d96 <pipewrite+0xc6>
  102d12:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  102d18:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  102d1e:	8b 40 4c             	mov    0x4c(%eax),%eax
  102d21:	85 c0                	test   %eax,%eax
  102d23:	75 71                	jne    102d96 <pipewrite+0xc6>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
  102d25:	89 3c 24             	mov    %edi,(%esp)
  102d28:	e8 f3 02 00 00       	call   103020 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
  102d2d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  102d31:	89 34 24             	mov    %esi,(%esp)
  102d34:	e8 47 04 00 00       	call   103180 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE) {  //DOC: pipewrite-full
  102d39:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
  102d3f:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
  102d45:	05 00 02 00 00       	add    $0x200,%eax
  102d4a:	39 c1                	cmp    %eax,%ecx
  102d4c:	74 b6                	je     102d04 <pipewrite+0x34>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  102d4e:	89 c8                	mov    %ecx,%eax
  102d50:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102d53:	25 ff 01 00 00       	and    $0x1ff,%eax
  102d58:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102d5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d5e:	0f b6 14 02          	movzbl (%edx,%eax,1),%edx
  102d62:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102d65:	88 54 03 34          	mov    %dl,0x34(%ebx,%eax,1)
  102d69:	8d 41 01             	lea    0x1(%ecx),%eax
  102d6c:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
  102d72:	8b 55 10             	mov    0x10(%ebp),%edx
  102d75:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  102d79:	39 55 f0             	cmp    %edx,-0x10(%ebp)
  102d7c:	75 bb                	jne    102d39 <pipewrite+0x69>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  102d7e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
  102d84:	89 04 24             	mov    %eax,(%esp)
  102d87:	e8 94 02 00 00       	call   103020 <wakeup>
  release(&p->lock);
  102d8c:	89 1c 24             	mov    %ebx,(%esp)
  102d8f:	e8 bc 0e 00 00       	call   103c50 <release>
  102d94:	eb 0f                	jmp    102da5 <pipewrite+0xd5>

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE) {  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->common->killed){
        release(&p->lock);
  102d96:	89 1c 24             	mov    %ebx,(%esp)
  102d99:	e8 b2 0e 00 00       	call   103c50 <release>
  102d9e:	c7 45 10 ff ff ff ff 	movl   $0xffffffff,0x10(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
  102da5:	8b 45 10             	mov    0x10(%ebp),%eax
  102da8:	83 c4 1c             	add    $0x1c,%esp
  102dab:	5b                   	pop    %ebx
  102dac:	5e                   	pop    %esi
  102dad:	5f                   	pop    %edi
  102dae:	5d                   	pop    %ebp
  102daf:	c3                   	ret    

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
  102dc5:	e8 c6 0e 00 00       	call   103c90 <acquire>
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
  102de1:	e8 3a 02 00 00       	call   103020 <wakeup>
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
  102e06:	e9 45 0e 00 00       	jmp    103c50 <release>
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
  102e23:	e8 f8 01 00 00       	call   103020 <wakeup>
  102e28:	eb bc                	jmp    102de6 <pipeclose+0x36>
  102e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  if(p->readopen == 0 && p->writeopen == 0) {
    release(&p->lock);
  102e30:	89 34 24             	mov    %esi,(%esp)
  102e33:	e8 18 0e 00 00       	call   103c50 <release>
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
  102e44:	e9 97 f3 ff ff       	jmp    1021e0 <kfree>
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
  102e71:	e8 fa df ff ff       	call   100e70 <filealloc>
  102e76:	85 c0                	test   %eax,%eax
  102e78:	89 06                	mov    %eax,(%esi)
  102e7a:	0f 84 92 00 00 00    	je     102f12 <pipealloc+0xc2>
  102e80:	e8 eb df ff ff       	call   100e70 <filealloc>
  102e85:	85 c0                	test   %eax,%eax
  102e87:	89 07                	mov    %eax,(%edi)
  102e89:	74 79                	je     102f04 <pipealloc+0xb4>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
  102e8b:	e8 10 f3 ff ff       	call   1021a0 <kalloc>
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
  102ec1:	c7 44 24 04 5c 71 10 	movl   $0x10715c,0x4(%esp)
  102ec8:	00 
  102ec9:	e8 42 0c 00 00       	call   103b10 <initlock>
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
  102f0d:	e8 ce df ff ff       	call   100ee0 <fileclose>
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
  102f2d:	e8 ae df ff ff       	call   100ee0 <fileclose>
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
  102f41:	ba 74 c6 10 00       	mov    $0x10c674,%edx
  102f46:	89 e5                	mov    %esp,%ebp
  102f48:	eb 14                	jmp    102f5e <wakeup1+0x1e>
  102f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  102f50:	81 c2 b8 00 00 00    	add    $0xb8,%edx
  102f56:	81 fa 74 f4 10 00    	cmp    $0x10f474,%edx
  102f5c:	74 29                	je     102f87 <wakeup1+0x47>
    if(p->state == SLEEPING && p->chan == chan)
  102f5e:	83 ba 90 00 00 00 02 	cmpl   $0x2,0x90(%edx)
  102f65:	75 e9                	jne    102f50 <wakeup1+0x10>
  102f67:	39 82 a4 00 00 00    	cmp    %eax,0xa4(%edx)
  102f6d:	75 e1                	jne    102f50 <wakeup1+0x10>
      p->state = RUNNABLE;
  102f6f:	c7 82 90 00 00 00 03 	movl   $0x3,0x90(%edx)
  102f76:	00 00 00 
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  102f79:	81 c2 b8 00 00 00    	add    $0xb8,%edx
  102f7f:	81 fa 74 f4 10 00    	cmp    $0x10f474,%edx
  102f85:	75 d7                	jne    102f5e <wakeup1+0x1e>
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
  102f87:	5d                   	pop    %ebp
  102f88:	c3                   	ret    
  102f89:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00102f90 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  102f90:	55                   	push   %ebp
  102f91:	89 e5                	mov    %esp,%ebp
  102f93:	53                   	push   %ebx
  102f94:	83 ec 04             	sub    $0x4,%esp
  102f97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
  102f9a:	c7 04 24 40 c6 10 00 	movl   $0x10c640,(%esp)
  102fa1:	e8 ea 0c 00 00       	call   103c90 <acquire>
  102fa6:	ba 74 c6 10 00       	mov    $0x10c674,%edx
  102fab:	eb 11                	jmp    102fbe <kill+0x2e>
  102fad:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  102fb0:	81 c2 b8 00 00 00    	add    $0xb8,%edx
  102fb6:	81 fa 74 f4 10 00    	cmp    $0x10f474,%edx
  102fbc:	74 34                	je     102ff2 <kill+0x62>
    if(p->pid == pid){
  102fbe:	8b 82 94 00 00 00    	mov    0x94(%edx),%eax
  102fc4:	39 d8                	cmp    %ebx,%eax
  102fc6:	75 e8                	jne    102fb0 <kill+0x20>
      p->common->killed = 1;
  102fc8:	8b 82 88 00 00 00    	mov    0x88(%edx),%eax
  102fce:	c7 40 4c 01 00 00 00 	movl   $0x1,0x4c(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
  102fd5:	83 ba 90 00 00 00 02 	cmpl   $0x2,0x90(%edx)
  102fdc:	74 2b                	je     103009 <kill+0x79>
        p->state = RUNNABLE;
      release(&ptable.lock);
  102fde:	c7 04 24 40 c6 10 00 	movl   $0x10c640,(%esp)
  102fe5:	e8 66 0c 00 00       	call   103c50 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
  102fea:	83 c4 04             	add    $0x4,%esp
    if(p->pid == pid){
      p->common->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
  102fed:	31 c0                	xor    %eax,%eax
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
  102fef:	5b                   	pop    %ebx
  102ff0:	5d                   	pop    %ebp
  102ff1:	c3                   	ret    
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  102ff2:	c7 04 24 40 c6 10 00 	movl   $0x10c640,(%esp)
  102ff9:	e8 52 0c 00 00       	call   103c50 <release>
  return -1;
}
  102ffe:	83 c4 04             	add    $0x4,%esp
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  103001:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return -1;
}
  103006:	5b                   	pop    %ebx
  103007:	5d                   	pop    %ebp
  103008:	c3                   	ret    
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->common->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
  103009:	c7 82 90 00 00 00 03 	movl   $0x3,0x90(%edx)
  103010:	00 00 00 
  103013:	eb c9                	jmp    102fde <kill+0x4e>
  103015:	8d 74 26 00          	lea    0x0(%esi),%esi
  103019:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103020 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  103020:	55                   	push   %ebp
  103021:	89 e5                	mov    %esp,%ebp
  103023:	53                   	push   %ebx
  103024:	83 ec 04             	sub    $0x4,%esp
  103027:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
  10302a:	c7 04 24 40 c6 10 00 	movl   $0x10c640,(%esp)
  103031:	e8 5a 0c 00 00       	call   103c90 <acquire>
  wakeup1(chan);
  103036:	89 d8                	mov    %ebx,%eax
  103038:	e8 03 ff ff ff       	call   102f40 <wakeup1>
  release(&ptable.lock);
  10303d:	c7 45 08 40 c6 10 00 	movl   $0x10c640,0x8(%ebp)
}
  103044:	83 c4 04             	add    $0x4,%esp
  103047:	5b                   	pop    %ebx
  103048:	5d                   	pop    %ebp
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
  103049:	e9 02 0c 00 00       	jmp    103c50 <release>
  10304e:	66 90                	xchg   %ax,%ax

00103050 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  103050:	55                   	push   %ebp
  103051:	89 e5                	mov    %esp,%ebp
  103053:	83 ec 08             	sub    $0x8,%esp
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
  103056:	c7 04 24 40 c6 10 00 	movl   $0x10c640,(%esp)
  10305d:	e8 ee 0b 00 00       	call   103c50 <release>
  
  // Return to "caller", actually trapret (see allocproc).
}
  103062:	c9                   	leave  
  103063:	c3                   	ret    
  103064:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10306a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00103070 <pschk>:
  }
}

int
pschk()
{
  103070:	55                   	push   %ebp
  103071:	89 e5                	mov    %esp,%ebp
  103073:	53                   	push   %ebx
  struct proc *p;
  int count = 0;

  acquire(&ptable.lock);
  103074:	31 db                	xor    %ebx,%ebx
  }
}

int
pschk()
{
  103076:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  int count = 0;

  acquire(&ptable.lock);
  103079:	c7 04 24 40 c6 10 00 	movl   $0x10c640,(%esp)
  103080:	e8 0b 0c 00 00       	call   103c90 <acquire>
  103085:	ba 74 c6 10 00       	mov    $0x10c674,%edx
  10308a:	eb 15                	jmp    1030a1 <pschk+0x31>
  10308c:	8d 74 26 00          	lea    0x0(%esi),%esi

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
    if (p->state == UNUSED)
      continue;

    count ++;
  103090:	83 c3 01             	add    $0x1,%ebx
  struct proc *p;
  int count = 0;

  acquire(&ptable.lock);

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
  103093:	81 c2 b8 00 00 00    	add    $0xb8,%edx
  103099:	81 fa 74 f4 10 00    	cmp    $0x10f474,%edx
  10309f:	74 2b                	je     1030cc <pschk+0x5c>
    if (p->state == UNUSED)
  1030a1:	8b 82 90 00 00 00    	mov    0x90(%edx),%eax
  1030a7:	85 c0                	test   %eax,%eax
  1030a9:	74 e8                	je     103093 <pschk+0x23>
      continue;

    count ++;

    if (p->state == ZOMBIE || p->state == TZOMBIE) {
  1030ab:	83 e8 05             	sub    $0x5,%eax
  1030ae:	83 f8 01             	cmp    $0x1,%eax
  1030b1:	77 dd                	ja     103090 <pschk+0x20>
      release(&ptable.lock);
  1030b3:	c7 04 24 40 c6 10 00 	movl   $0x10c640,(%esp)
  1030ba:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  1030bf:	e8 8c 0b 00 00       	call   103c50 <release>
    }
  }

  release(&ptable.lock);
  return count;
}
  1030c4:	89 d8                	mov    %ebx,%eax
  1030c6:	83 c4 04             	add    $0x4,%esp
  1030c9:	5b                   	pop    %ebx
  1030ca:	5d                   	pop    %ebp
  1030cb:	c3                   	ret    
      release(&ptable.lock);
      return -1;
    }
  }

  release(&ptable.lock);
  1030cc:	c7 04 24 40 c6 10 00 	movl   $0x10c640,(%esp)
  1030d3:	e8 78 0b 00 00       	call   103c50 <release>
  return count;
}
  1030d8:	89 d8                	mov    %ebx,%eax
  1030da:	83 c4 04             	add    $0x4,%esp
  1030dd:	5b                   	pop    %ebx
  1030de:	5d                   	pop    %ebp
  1030df:	c3                   	ret    

001030e0 <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
  1030e0:	55                   	push   %ebp
  1030e1:	89 e5                	mov    %esp,%ebp
  1030e3:	53                   	push   %ebx
  1030e4:	83 ec 14             	sub    $0x14,%esp
  int intena;

  if(!holding(&ptable.lock))
  1030e7:	c7 04 24 40 c6 10 00 	movl   $0x10c640,(%esp)
  1030ee:	e8 9d 0a 00 00       	call   103b90 <holding>
  1030f3:	85 c0                	test   %eax,%eax
  1030f5:	74 54                	je     10314b <sched+0x6b>
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
  1030f7:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
  1030fe:	83 ba ac 00 00 00 01 	cmpl   $0x1,0xac(%edx)
  103105:	75 50                	jne    103157 <sched+0x77>
    panic("sched locks");
  if(proc->state == RUNNING)
  103107:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
  10310e:	83 b9 90 00 00 00 04 	cmpl   $0x4,0x90(%ecx)
  103115:	74 4c                	je     103163 <sched+0x83>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  103117:	9c                   	pushf  
  103118:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
  103119:	f6 c4 02             	test   $0x2,%ah
  10311c:	75 51                	jne    10316f <sched+0x8f>
    panic("sched interruptible");
  intena = cpu->intena;
  swtch(&proc->context, cpu->scheduler);
  10311e:	8b 42 04             	mov    0x4(%edx),%eax
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = cpu->intena;
  103121:	8b 9a b0 00 00 00    	mov    0xb0(%edx),%ebx
  swtch(&proc->context, cpu->scheduler);
  103127:	89 44 24 04          	mov    %eax,0x4(%esp)
  10312b:	8d 81 a0 00 00 00    	lea    0xa0(%ecx),%eax
  103131:	89 04 24             	mov    %eax,(%esp)
  103134:	e8 e3 0d 00 00       	call   103f1c <swtch>
  cpu->intena = intena;
  103139:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  10313f:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
}
  103145:	83 c4 14             	add    $0x14,%esp
  103148:	5b                   	pop    %ebx
  103149:	5d                   	pop    %ebp
  10314a:	c3                   	ret    
sched(void)
{
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  10314b:	c7 04 24 61 71 10 00 	movl   $0x107161,(%esp)
  103152:	e8 29 d7 ff ff       	call   100880 <panic>
  if(cpu->ncli != 1)
    panic("sched locks");
  103157:	c7 04 24 73 71 10 00 	movl   $0x107173,(%esp)
  10315e:	e8 1d d7 ff ff       	call   100880 <panic>
  if(proc->state == RUNNING)
    panic("sched running");
  103163:	c7 04 24 7f 71 10 00 	movl   $0x10717f,(%esp)
  10316a:	e8 11 d7 ff ff       	call   100880 <panic>
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  10316f:	c7 04 24 8d 71 10 00 	movl   $0x10718d,(%esp)
  103176:	e8 05 d7 ff ff       	call   100880 <panic>
  10317b:	90                   	nop    
  10317c:	8d 74 26 00          	lea    0x0(%esi),%esi

00103180 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  103180:	55                   	push   %ebp
  103181:	89 e5                	mov    %esp,%ebp
  103183:	56                   	push   %esi
  103184:	53                   	push   %ebx
  103185:	83 ec 10             	sub    $0x10,%esp
  if(proc == 0)
  103188:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  10318e:	8b 75 08             	mov    0x8(%ebp),%esi
  103191:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(proc == 0)
  103194:	85 c0                	test   %eax,%eax
  103196:	0f 84 a6 00 00 00    	je     103242 <sleep+0xc2>
    panic("sleep");

  if(lk == 0)
  10319c:	85 db                	test   %ebx,%ebx
  10319e:	0f 84 aa 00 00 00    	je     10324e <sleep+0xce>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
  1031a4:	81 fb 40 c6 10 00    	cmp    $0x10c640,%ebx
  1031aa:	74 64                	je     103210 <sleep+0x90>
    acquire(&ptable.lock);  //DOC: sleeplock1
  1031ac:	c7 04 24 40 c6 10 00 	movl   $0x10c640,(%esp)
  1031b3:	e8 d8 0a 00 00       	call   103c90 <acquire>
    release(lk);
  1031b8:	89 1c 24             	mov    %ebx,(%esp)
  1031bb:	e8 90 0a 00 00       	call   103c50 <release>
  }

  // Go to sleep.
  proc->chan = chan;
  1031c0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1031c6:	89 b0 a4 00 00 00    	mov    %esi,0xa4(%eax)
  proc->state = SLEEPING;
  1031cc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1031d2:	c7 80 90 00 00 00 02 	movl   $0x2,0x90(%eax)
  1031d9:	00 00 00 
  sched();
  1031dc:	e8 ff fe ff ff       	call   1030e0 <sched>

  // Tidy up.
  proc->chan = 0;
  1031e1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1031e7:	c7 80 a4 00 00 00 00 	movl   $0x0,0xa4(%eax)
  1031ee:	00 00 00 

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
  1031f1:	c7 04 24 40 c6 10 00 	movl   $0x10c640,(%esp)
  1031f8:	e8 53 0a 00 00       	call   103c50 <release>
    acquire(lk);
  1031fd:	89 5d 08             	mov    %ebx,0x8(%ebp)
  }
}
  103200:	83 c4 10             	add    $0x10,%esp
  103203:	5b                   	pop    %ebx
  103204:	5e                   	pop    %esi
  103205:	5d                   	pop    %ebp
  proc->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  103206:	e9 85 0a 00 00       	jmp    103c90 <acquire>
  10320b:	90                   	nop    
  10320c:	8d 74 26 00          	lea    0x0(%esi),%esi
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }

  // Go to sleep.
  proc->chan = chan;
  103210:	89 b0 a4 00 00 00    	mov    %esi,0xa4(%eax)
  proc->state = SLEEPING;
  103216:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10321c:	c7 80 90 00 00 00 02 	movl   $0x2,0x90(%eax)
  103223:	00 00 00 
  sched();
  103226:	e8 b5 fe ff ff       	call   1030e0 <sched>

  // Tidy up.
  proc->chan = 0;
  10322b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103231:	c7 80 a4 00 00 00 00 	movl   $0x0,0xa4(%eax)
  103238:	00 00 00 
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
  10323b:	83 c4 10             	add    $0x10,%esp
  10323e:	5b                   	pop    %ebx
  10323f:	5e                   	pop    %esi
  103240:	5d                   	pop    %ebp
  103241:	c3                   	ret    
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(proc == 0)
    panic("sleep");
  103242:	c7 04 24 a1 71 10 00 	movl   $0x1071a1,(%esp)
  103249:	e8 32 d6 ff ff       	call   100880 <panic>

  if(lk == 0)
    panic("sleep without lk");
  10324e:	c7 04 24 a7 71 10 00 	movl   $0x1071a7,(%esp)
  103255:	e8 26 d6 ff ff       	call   100880 <panic>
  10325a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103260 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  103260:	55                   	push   %ebp
  103261:	89 e5                	mov    %esp,%ebp
  103263:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
  103266:	c7 04 24 40 c6 10 00 	movl   $0x10c640,(%esp)
  10326d:	e8 1e 0a 00 00       	call   103c90 <acquire>
  proc->state = RUNNABLE;
  103272:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103278:	c7 80 90 00 00 00 03 	movl   $0x3,0x90(%eax)
  10327f:	00 00 00 
  sched();
  103282:	e8 59 fe ff ff       	call   1030e0 <sched>
  release(&ptable.lock);
  103287:	c7 04 24 40 c6 10 00 	movl   $0x10c640,(%esp)
  10328e:	e8 bd 09 00 00       	call   103c50 <release>
}
  103293:	c9                   	leave  
  103294:	c3                   	ret    
  103295:	8d 74 26 00          	lea    0x0(%esi),%esi
  103299:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001032a0 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  1032a0:	55                   	push   %ebp
  1032a1:	89 e5                	mov    %esp,%ebp
  1032a3:	53                   	push   %ebx
  1032a4:	83 ec 14             	sub    $0x14,%esp
}

static inline void
sti(void)
{
  asm volatile("sti");
  1032a7:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
  1032a8:	c7 04 24 40 c6 10 00 	movl   $0x10c640,(%esp)
  1032af:	bb 74 c6 10 00       	mov    $0x10c674,%ebx
  1032b4:	e8 d7 09 00 00       	call   103c90 <acquire>
  1032b9:	eb 13                	jmp    1032ce <scheduler+0x2e>
  1032bb:	90                   	nop    
  1032bc:	8d 74 26 00          	lea    0x0(%esi),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  1032c0:	81 c3 b8 00 00 00    	add    $0xb8,%ebx
  1032c6:	81 fb 74 f4 10 00    	cmp    $0x10f474,%ebx
  1032cc:	74 61                	je     10332f <scheduler+0x8f>
      if(p->state != RUNNABLE)
  1032ce:	83 bb 90 00 00 00 03 	cmpl   $0x3,0x90(%ebx)
  1032d5:	75 e9                	jne    1032c0 <scheduler+0x20>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
  1032d7:	65 89 1d 04 00 00 00 	mov    %ebx,%gs:0x4
      switchuvm(p);
  1032de:	89 1c 24             	mov    %ebx,(%esp)
  1032e1:	e8 da 36 00 00       	call   1069c0 <switchuvm>
      p->state = RUNNING;
      swtch(&cpu->scheduler, proc->context);
  1032e6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
      p->state = RUNNING;
  1032ec:	c7 83 90 00 00 00 04 	movl   $0x4,0x90(%ebx)
  1032f3:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  1032f6:	81 c3 b8 00 00 00    	add    $0xb8,%ebx
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
      p->state = RUNNING;
      swtch(&cpu->scheduler, proc->context);
  1032fc:	8b 80 a0 00 00 00    	mov    0xa0(%eax),%eax
  103302:	89 44 24 04          	mov    %eax,0x4(%esp)
  103306:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  10330c:	83 c0 04             	add    $0x4,%eax
  10330f:	89 04 24             	mov    %eax,(%esp)
  103312:	e8 05 0c 00 00       	call   103f1c <swtch>
      switchkvm();
  103317:	e8 84 30 00 00       	call   1063a0 <switchkvm>
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  10331c:	81 fb 74 f4 10 00    	cmp    $0x10f474,%ebx
      swtch(&cpu->scheduler, proc->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
  103322:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
  103329:	00 00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  10332d:	75 9f                	jne    1032ce <scheduler+0x2e>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
  10332f:	c7 04 24 40 c6 10 00 	movl   $0x10c640,(%esp)
  103336:	e8 15 09 00 00       	call   103c50 <release>
  10333b:	e9 67 ff ff ff       	jmp    1032a7 <scheduler+0x7>

00103340 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  103340:	55                   	push   %ebp
  103341:	89 e5                	mov    %esp,%ebp
  103343:	56                   	push   %esi
  103344:	53                   	push   %ebx
  103345:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
  103348:	c7 04 24 40 c6 10 00 	movl   $0x10c640,(%esp)
  10334f:	e8 3c 09 00 00       	call   103c90 <acquire>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
  103354:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  10335b:	bb 74 c6 10 00       	mov    $0x10c674,%ebx
  103360:	31 c0                	xor    %eax,%eax
  103362:	eb 0e                	jmp    103372 <wait+0x32>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103364:	81 c3 b8 00 00 00    	add    $0xb8,%ebx
  10336a:	81 fb 74 f4 10 00    	cmp    $0x10f474,%ebx
  103370:	74 24                	je     103396 <wait+0x56>
      if(p->parent != proc)
  103372:	39 93 98 00 00 00    	cmp    %edx,0x98(%ebx)
  103378:	75 ea                	jne    103364 <wait+0x24>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
  10337a:	83 bb 90 00 00 00 05 	cmpl   $0x5,0x90(%ebx)
  103381:	74 3e                	je     1033c1 <wait+0x81>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103383:	81 c3 b8 00 00 00    	add    $0xb8,%ebx
        p->parent = 0;
        p->name[0] = 0;
        p->common->killed = 0;
        p->common = 0;
        release(&ptable.lock);
        return pid;
  103389:	b8 01 00 00 00       	mov    $0x1,%eax

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  10338e:	81 fb 74 f4 10 00    	cmp    $0x10f474,%ebx
  103394:	75 dc                	jne    103372 <wait+0x32>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->common->killed){
  103396:	85 c0                	test   %eax,%eax
  103398:	0f 84 a3 00 00 00    	je     103441 <wait+0x101>
  10339e:	8b 82 88 00 00 00    	mov    0x88(%edx),%eax
  1033a4:	8b 40 4c             	mov    0x4c(%eax),%eax
  1033a7:	85 c0                	test   %eax,%eax
  1033a9:	0f 85 92 00 00 00    	jne    103441 <wait+0x101>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  1033af:	c7 44 24 04 40 c6 10 	movl   $0x10c640,0x4(%esp)
  1033b6:	00 
  1033b7:	89 14 24             	mov    %edx,(%esp)
  1033ba:	e8 c1 fd ff ff       	call   103180 <sleep>
  1033bf:	eb 93                	jmp    103354 <wait+0x14>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
  1033c1:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
  1033c7:	8b b3 94 00 00 00    	mov    0x94(%ebx),%esi
        kfree(p->kstack);
  1033cd:	89 04 24             	mov    %eax,(%esp)
  1033d0:	e8 0b ee ff ff       	call   1021e0 <kfree>
        p->kstack = 0;
        freevm(p->common->pgdir);
  1033d5:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
  1033db:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
  1033e2:	00 00 00 
        freevm(p->common->pgdir);
  1033e5:	8b 40 04             	mov    0x4(%eax),%eax
  1033e8:	89 04 24             	mov    %eax,(%esp)
  1033eb:	e8 10 33 00 00       	call   106700 <freevm>
        p->state = UNUSED;
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->common->killed = 0;
  1033f0:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->common->pgdir);
        p->state = UNUSED;
  1033f6:	c7 83 90 00 00 00 00 	movl   $0x0,0x90(%ebx)
  1033fd:	00 00 00 
        p->pid = 0;
  103400:	c7 83 94 00 00 00 00 	movl   $0x0,0x94(%ebx)
  103407:	00 00 00 
        p->parent = 0;
  10340a:	c7 83 98 00 00 00 00 	movl   $0x0,0x98(%ebx)
  103411:	00 00 00 
        p->name[0] = 0;
  103414:	c6 83 a8 00 00 00 00 	movb   $0x0,0xa8(%ebx)
        p->common->killed = 0;
  10341b:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
        p->common = 0;
  103422:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
  103429:	00 00 00 
        release(&ptable.lock);
  10342c:	c7 04 24 40 c6 10 00 	movl   $0x10c640,(%esp)
  103433:	e8 18 08 00 00       	call   103c50 <release>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
  103438:	83 c4 10             	add    $0x10,%esp
  10343b:	89 f0                	mov    %esi,%eax
  10343d:	5b                   	pop    %ebx
  10343e:	5e                   	pop    %esi
  10343f:	5d                   	pop    %ebp
  103440:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->common->killed){
      release(&ptable.lock);
  103441:	c7 04 24 40 c6 10 00 	movl   $0x10c640,(%esp)
  103448:	be ff ff ff ff       	mov    $0xffffffff,%esi
  10344d:	e8 fe 07 00 00       	call   103c50 <release>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
  103452:	83 c4 10             	add    $0x10,%esp
  103455:	89 f0                	mov    %esi,%eax
  103457:	5b                   	pop    %ebx
  103458:	5e                   	pop    %esi
  103459:	5d                   	pop    %ebp
  10345a:	c3                   	ret    
  10345b:	90                   	nop    
  10345c:	8d 74 26 00          	lea    0x0(%esi),%esi

00103460 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  103460:	55                   	push   %ebp
  103461:	89 e5                	mov    %esp,%ebp
  103463:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
  103466:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  10346d:	3b 15 e8 8d 10 00    	cmp    0x108de8,%edx
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  103473:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  103476:	89 75 fc             	mov    %esi,-0x4(%ebp)
  struct proc *p;
  int fd;

  if(proc == initproc)
  103479:	75 0c                	jne    103487 <exit+0x27>
    panic("init exiting");
  10347b:	c7 04 24 b8 71 10 00 	movl   $0x1071b8,(%esp)
  103482:	e8 f9 d3 ff ff       	call   100880 <panic>
  103487:	31 db                	xor    %ebx,%ebx
  103489:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->common->ofile[fd]){
  103490:	8b 82 88 00 00 00    	mov    0x88(%edx),%eax
  103496:	8b 44 98 08          	mov    0x8(%eax,%ebx,4),%eax
  10349a:	85 c0                	test   %eax,%eax
  10349c:	74 23                	je     1034c1 <exit+0x61>
      fileclose(proc->common->ofile[fd]);
  10349e:	89 04 24             	mov    %eax,(%esp)
  1034a1:	e8 3a da ff ff       	call   100ee0 <fileclose>
      proc->common->ofile[fd] = 0;
  1034a6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1034ac:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  1034b2:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
  1034b9:	00 
  1034ba:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
  1034c1:	83 c3 01             	add    $0x1,%ebx
  1034c4:	83 fb 10             	cmp    $0x10,%ebx
  1034c7:	75 c7                	jne    103490 <exit+0x30>
      fileclose(proc->common->ofile[fd]);
      proc->common->ofile[fd] = 0;
    }
  }

  iput(proc->common->cwd);
  1034c9:	8b 82 88 00 00 00    	mov    0x88(%edx),%eax
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
  1034cf:	bb 74 c6 10 00       	mov    $0x10c674,%ebx
      fileclose(proc->common->ofile[fd]);
      proc->common->ofile[fd] = 0;
    }
  }

  iput(proc->common->cwd);
  1034d4:	8b 40 48             	mov    0x48(%eax),%eax
  1034d7:	89 04 24             	mov    %eax,(%esp)
  1034da:	e8 b1 e3 ff ff       	call   101890 <iput>
  proc->common->cwd = 0;
  1034df:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1034e5:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  1034eb:	c7 40 48 00 00 00 00 	movl   $0x0,0x48(%eax)

  acquire(&ptable.lock);
  1034f2:	c7 04 24 40 c6 10 00 	movl   $0x10c640,(%esp)
  1034f9:	e8 92 07 00 00       	call   103c90 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
  1034fe:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103504:	8b 80 98 00 00 00    	mov    0x98(%eax),%eax
  10350a:	e8 31 fa ff ff       	call   102f40 <wakeup1>

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
  10350f:	8b 35 e8 8d 10 00    	mov    0x108de8,%esi
  103515:	eb 0e                	jmp    103525 <exit+0xc5>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103517:	81 c3 b8 00 00 00    	add    $0xb8,%ebx
  10351d:	81 fb 74 f4 10 00    	cmp    $0x10f474,%ebx
  103523:	74 27                	je     10354c <exit+0xec>
    if(p->parent == proc){
  103525:	8b 83 98 00 00 00    	mov    0x98(%ebx),%eax
  10352b:	65 3b 05 04 00 00 00 	cmp    %gs:0x4,%eax
  103532:	75 e3                	jne    103517 <exit+0xb7>
      p->parent = initproc;
      if(p->state == ZOMBIE)
  103534:	83 bb 90 00 00 00 05 	cmpl   $0x5,0x90(%ebx)
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
  10353b:	89 b3 98 00 00 00    	mov    %esi,0x98(%ebx)
      if(p->state == ZOMBIE)
  103541:	75 d4                	jne    103517 <exit+0xb7>
        wakeup1(initproc);
  103543:	89 f0                	mov    %esi,%eax
  103545:	e8 f6 f9 ff ff       	call   102f40 <wakeup1>
  10354a:	eb cb                	jmp    103517 <exit+0xb7>
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
  10354c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103552:	c7 80 90 00 00 00 05 	movl   $0x5,0x90(%eax)
  103559:	00 00 00 
  sched();
  10355c:	e8 7f fb ff ff       	call   1030e0 <sched>
  panic("zombie exit");
  103561:	c7 04 24 c5 71 10 00 	movl   $0x1071c5,(%esp)
  103568:	e8 13 d3 ff ff       	call   100880 <panic>
  10356d:	8d 76 00             	lea    0x0(%esi),%esi

00103570 <allocproc>:
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and return it.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  103570:	55                   	push   %ebp
  103571:	89 e5                	mov    %esp,%ebp
  103573:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  103574:	bb 74 c6 10 00       	mov    $0x10c674,%ebx
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and return it.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  103579:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  10357c:	c7 04 24 40 c6 10 00 	movl   $0x10c640,(%esp)
  103583:	e8 08 07 00 00       	call   103c90 <acquire>
  103588:	eb 18                	jmp    1035a2 <allocproc+0x32>
  10358a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  103590:	81 c3 b8 00 00 00    	add    $0xb8,%ebx
  103596:	81 fb 74 f4 10 00    	cmp    $0x10f474,%ebx
  10359c:	0f 84 93 00 00 00    	je     103635 <allocproc+0xc5>
    if(p->state == UNUSED)
  1035a2:	8b 93 90 00 00 00    	mov    0x90(%ebx),%edx
  1035a8:	85 d2                	test   %edx,%edx
  1035aa:	75 e4                	jne    103590 <allocproc+0x20>
      goto found;
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  1035ac:	c7 83 90 00 00 00 01 	movl   $0x1,0x90(%ebx)
  1035b3:	00 00 00 
  p->pid = nextpid++;
  1035b6:	a1 a4 88 10 00       	mov    0x1088a4,%eax
  1035bb:	89 83 94 00 00 00    	mov    %eax,0x94(%ebx)
  1035c1:	83 c0 01             	add    $0x1,%eax
  1035c4:	a3 a4 88 10 00       	mov    %eax,0x1088a4
  release(&ptable.lock);
  1035c9:	c7 04 24 40 c6 10 00 	movl   $0x10c640,(%esp)
  1035d0:	e8 7b 06 00 00       	call   103c50 <release>

  // Allocate kernel stack if possible.
  if((p->kstack = kalloc()) == 0){
  1035d5:	e8 c6 eb ff ff       	call   1021a0 <kalloc>
  1035da:	85 c0                	test   %eax,%eax
  1035dc:	89 c2                	mov    %eax,%edx
  1035de:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
  1035e4:	74 65                	je     10364b <allocproc+0xdb>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  1035e6:	8d 80 b4 0f 00 00    	lea    0xfb4(%eax),%eax
  p->tf = (struct trapframe*)sp;
  1035ec:	89 83 9c 00 00 00    	mov    %eax,0x9c(%ebx)
  // which returns to trapret (see below).
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  1035f2:	8d 82 9c 0f 00 00    	lea    0xf9c(%edx),%eax
  p->tf = (struct trapframe*)sp;
  
  // Set up new context to start executing at forkret,
  // which returns to trapret (see below).
  sp -= 4;
  *(uint*)sp = (uint)trapret;
  1035f8:	c7 82 b0 0f 00 00 b0 	movl   $0x1054b0,0xfb0(%edx)
  1035ff:	54 10 00 

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  103602:	89 83 a0 00 00 00    	mov    %eax,0xa0(%ebx)
  memset(p->context, 0, sizeof *p->context);
  103608:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
  10360f:	00 
  103610:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  103617:	00 
  103618:	89 04 24             	mov    %eax,(%esp)
  10361b:	e8 e0 06 00 00       	call   103d00 <memset>
  p->context->eip = (uint)forkret;
  103620:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
  103626:	c7 40 10 50 30 10 00 	movl   $0x103050,0x10(%eax)
  return p;
}
  10362d:	89 d8                	mov    %ebx,%eax
  10362f:	83 c4 14             	add    $0x14,%esp
  103632:	5b                   	pop    %ebx
  103633:	5d                   	pop    %ebp
  103634:	c3                   	ret    

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
  103635:	c7 04 24 40 c6 10 00 	movl   $0x10c640,(%esp)
  10363c:	31 db                	xor    %ebx,%ebx
  10363e:	e8 0d 06 00 00       	call   103c50 <release>
  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
  return p;
}
  103643:	89 d8                	mov    %ebx,%eax
  103645:	83 c4 14             	add    $0x14,%esp
  103648:	5b                   	pop    %ebx
  103649:	5d                   	pop    %ebp
  10364a:	c3                   	ret    
  p->pid = nextpid++;
  release(&ptable.lock);

  // Allocate kernel stack if possible.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
  10364b:	c7 83 90 00 00 00 00 	movl   $0x0,0x90(%ebx)
  103652:	00 00 00 
  103655:	31 db                	xor    %ebx,%ebx
  103657:	eb d4                	jmp    10362d <allocproc+0xbd>
  103659:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00103660 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  103660:	55                   	push   %ebp
  103661:	89 e5                	mov    %esp,%ebp
  103663:	57                   	push   %edi
  103664:	56                   	push   %esi
  103665:	53                   	push   %ebx
  103666:	83 ec 0c             	sub    $0xc,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
  103669:	e8 02 ff ff ff       	call   103570 <allocproc>
  10366e:	89 c7                	mov    %eax,%edi
  103670:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  103675:	85 ff                	test   %edi,%edi
  103677:	0f 84 7d 01 00 00    	je     1037fa <fork+0x19a>
    return -1;

  np->common = &np->threadcommon;
  10367d:	89 bf 88 00 00 00    	mov    %edi,0x88(%edi)

  // Copy process state from p.

  readlock(&proc->common->pglock);
  103683:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103689:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  10368f:	83 c0 08             	add    $0x8,%eax
  103692:	89 04 24             	mov    %eax,(%esp)
  103695:	e8 26 35 00 00       	call   106bc0 <readlock>
  if(!(np->common->pgdir = copyuvm(proc->common->pgdir, proc->common->sz))){
  10369a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1036a0:	8b 9f 88 00 00 00    	mov    0x88(%edi),%ebx
  1036a6:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
  1036ac:	8b 02                	mov    (%edx),%eax
  1036ae:	89 44 24 04          	mov    %eax,0x4(%esp)
  1036b2:	8b 42 04             	mov    0x4(%edx),%eax
  1036b5:	89 04 24             	mov    %eax,(%esp)
  1036b8:	e8 c3 30 00 00       	call   106780 <copyuvm>
  1036bd:	85 c0                	test   %eax,%eax
  1036bf:	89 43 04             	mov    %eax,0x4(%ebx)
  1036c2:	0f 84 3a 01 00 00    	je     103802 <fork+0x1a2>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->common->sz = proc->common->sz;
  1036c8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  readunlock(&proc->common->pglock);

  acquire(&proc->common->lock);
  1036ce:	31 f6                	xor    %esi,%esi
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->common->sz = proc->common->sz;
  1036d0:	8b 97 88 00 00 00    	mov    0x88(%edi),%edx
  1036d6:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  1036dc:	8b 00                	mov    (%eax),%eax
  1036de:	89 02                	mov    %eax,(%edx)
  readunlock(&proc->common->pglock);
  1036e0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1036e6:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  1036ec:	83 c0 08             	add    $0x8,%eax
  1036ef:	89 04 24             	mov    %eax,(%esp)
  1036f2:	e8 d9 34 00 00       	call   106bd0 <readunlock>

  acquire(&proc->common->lock);
  1036f7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1036fd:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  103703:	83 c0 50             	add    $0x50,%eax
  103706:	89 04 24             	mov    %eax,(%esp)
  103709:	e8 82 05 00 00       	call   103c90 <acquire>
  10370e:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  for(i = 0; i < NOFILE; i++)
    if(proc->common->ofile[i])
  103715:	8b 82 88 00 00 00    	mov    0x88(%edx),%eax
  10371b:	8b 44 b0 08          	mov    0x8(%eax,%esi,4),%eax
  10371f:	85 c0                	test   %eax,%eax
  103721:	74 19                	je     10373c <fork+0xdc>
      np->common->ofile[i] = filedup(proc->common->ofile[i]);
  103723:	8b 9f 88 00 00 00    	mov    0x88(%edi),%ebx
  103729:	89 04 24             	mov    %eax,(%esp)
  10372c:	e8 ef d6 ff ff       	call   100e20 <filedup>
  103731:	89 44 b3 08          	mov    %eax,0x8(%ebx,%esi,4)
  103735:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  }
  np->common->sz = proc->common->sz;
  readunlock(&proc->common->pglock);

  acquire(&proc->common->lock);
  for(i = 0; i < NOFILE; i++)
  10373c:	83 c6 01             	add    $0x1,%esi
  10373f:	83 fe 10             	cmp    $0x10,%esi
  103742:	75 d1                	jne    103715 <fork+0xb5>
    if(proc->common->ofile[i])
      np->common->ofile[i] = filedup(proc->common->ofile[i]);
  np->common->cwd = idup(proc->common->cwd);
  103744:	8b 82 88 00 00 00    	mov    0x88(%edx),%eax
  10374a:	8b 9f 88 00 00 00    	mov    0x88(%edi),%ebx
  103750:	8b 40 48             	mov    0x48(%eax),%eax
  103753:	89 04 24             	mov    %eax,(%esp)
  103756:	e8 a5 d8 ff ff       	call   101000 <idup>
  10375b:	89 43 48             	mov    %eax,0x48(%ebx)
  release(&proc->common->lock);
  10375e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103764:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  10376a:	83 c0 50             	add    $0x50,%eax
  10376d:	89 04 24             	mov    %eax,(%esp)
  103770:	e8 db 04 00 00       	call   103c50 <release>

  // Clear %eax so that fork returns 0 in the child.
  *np->tf = *proc->tf;
  103775:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10377b:	8b 97 9c 00 00 00    	mov    0x9c(%edi),%edx
  103781:	8b 80 9c 00 00 00    	mov    0x9c(%eax),%eax
  103787:	89 14 24             	mov    %edx,(%esp)
  10378a:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
  103791:	00 
  103792:	89 44 24 04          	mov    %eax,0x4(%esp)
  103796:	e8 65 06 00 00       	call   103e00 <memcpy>
  np->tf->eax = 0;
  10379b:	8b 87 9c 00 00 00    	mov    0x9c(%edi),%eax
  1037a1:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  // Make sure the page table lock is unlocked.
  initrwlock(&np->common->pglock);
  1037a8:	8b 87 88 00 00 00    	mov    0x88(%edi),%eax
  1037ae:	83 c0 08             	add    $0x8,%eax
  1037b1:	89 04 24             	mov    %eax,(%esp)
  1037b4:	e8 e7 33 00 00       	call   106ba0 <initrwlock>

  np->parent = proc;
  1037b9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1037bf:	89 87 98 00 00 00    	mov    %eax,0x98(%edi)
  safestrcpy(np->name, proc->name, sizeof(proc->name));
  1037c5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1037cb:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  1037d2:	00 
  1037d3:	05 a8 00 00 00       	add    $0xa8,%eax
  1037d8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1037dc:	8d 87 a8 00 00 00    	lea    0xa8(%edi),%eax
  1037e2:	89 04 24             	mov    %eax,(%esp)
  1037e5:	e8 d6 06 00 00       	call   103ec0 <safestrcpy>
  np->state = RUNNABLE;

  pid = np->pid;
  1037ea:	8b 87 94 00 00 00    	mov    0x94(%edi),%eax
  // Make sure the page table lock is unlocked.
  initrwlock(&np->common->pglock);

  np->parent = proc;
  safestrcpy(np->name, proc->name, sizeof(proc->name));
  np->state = RUNNABLE;
  1037f0:	c7 87 90 00 00 00 03 	movl   $0x3,0x90(%edi)
  1037f7:	00 00 00 

  pid = np->pid;

  return pid;
}
  1037fa:	83 c4 0c             	add    $0xc,%esp
  1037fd:	5b                   	pop    %ebx
  1037fe:	5e                   	pop    %esi
  1037ff:	5f                   	pop    %edi
  103800:	5d                   	pop    %ebp
  103801:	c3                   	ret    

  // Copy process state from p.

  readlock(&proc->common->pglock);
  if(!(np->common->pgdir = copyuvm(proc->common->pgdir, proc->common->sz))){
    kfree(np->kstack);
  103802:	8b 87 8c 00 00 00    	mov    0x8c(%edi),%eax
  103808:	89 04 24             	mov    %eax,(%esp)
  10380b:	e8 d0 e9 ff ff       	call   1021e0 <kfree>
    np->kstack = 0;
    np->state = UNUSED;
  103810:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  // Copy process state from p.

  readlock(&proc->common->pglock);
  if(!(np->common->pgdir = copyuvm(proc->common->pgdir, proc->common->sz))){
    kfree(np->kstack);
    np->kstack = 0;
  103815:	c7 87 8c 00 00 00 00 	movl   $0x0,0x8c(%edi)
  10381c:	00 00 00 
    np->state = UNUSED;
  10381f:	c7 87 90 00 00 00 00 	movl   $0x0,0x90(%edi)
  103826:	00 00 00 
  103829:	eb cf                	jmp    1037fa <fork+0x19a>
  10382b:	90                   	nop    
  10382c:	8d 74 26 00          	lea    0x0(%esi),%esi

00103830 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  103830:	55                   	push   %ebp
  103831:	89 e5                	mov    %esp,%ebp
  103833:	53                   	push   %ebx
  103834:	83 ec 14             	sub    $0x14,%esp
  uint sz;

  writelock(&proc->common->pglock);
  103837:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  10383d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint sz;

  writelock(&proc->common->pglock);
  103840:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  103846:	83 c0 08             	add    $0x8,%eax
  103849:	89 04 24             	mov    %eax,(%esp)
  10384c:	e8 8f 33 00 00       	call   106be0 <writelock>

  sz = proc->common->sz;
  103851:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if (n > 0)
  103857:	83 fb 00             	cmp    $0x0,%ebx
{
  uint sz;

  writelock(&proc->common->pglock);

  sz = proc->common->sz;
  10385a:	8b 88 88 00 00 00    	mov    0x88(%eax),%ecx
  103860:	8b 11                	mov    (%ecx),%edx
  if (n > 0)
  103862:	7e 5c                	jle    1038c0 <growproc+0x90>
    sz = allocuvm(proc->common->pgdir, sz, sz + n);
  103864:	8d 04 13             	lea    (%ebx,%edx,1),%eax
  103867:	89 54 24 04          	mov    %edx,0x4(%esp)
  10386b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10386f:	8b 41 04             	mov    0x4(%ecx),%eax
  103872:	89 04 24             	mov    %eax,(%esp)
  103875:	e8 c6 2f 00 00       	call   106840 <allocuvm>
  10387a:	89 c2                	mov    %eax,%edx
  10387c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  else if (n < 0)
    sz = deallocuvm(proc->common->pgdir, sz, sz + n);

  if (sz == 0) {
  103882:	85 d2                	test   %edx,%edx
  103884:	74 5c                	je     1038e2 <growproc+0xb2>
    writeunlock(&proc->common->pglock);
    return -1;
  }

  proc->common->sz = sz;
  103886:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  10388c:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
  10388e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103894:	89 04 24             	mov    %eax,(%esp)
  103897:	e8 24 31 00 00       	call   1069c0 <switchuvm>

  writeunlock(&proc->common->pglock);
  10389c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1038a2:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  1038a8:	83 c0 08             	add    $0x8,%eax
  1038ab:	89 04 24             	mov    %eax,(%esp)
  1038ae:	e8 3d 33 00 00       	call   106bf0 <writeunlock>
  1038b3:	31 c0                	xor    %eax,%eax
  return 0;
}
  1038b5:	83 c4 14             	add    $0x14,%esp
  1038b8:	5b                   	pop    %ebx
  1038b9:	5d                   	pop    %ebp
  1038ba:	c3                   	ret    
  1038bb:	90                   	nop    
  1038bc:	8d 74 26 00          	lea    0x0(%esi),%esi
  writelock(&proc->common->pglock);

  sz = proc->common->sz;
  if (n > 0)
    sz = allocuvm(proc->common->pgdir, sz, sz + n);
  else if (n < 0)
  1038c0:	74 c0                	je     103882 <growproc+0x52>
    sz = deallocuvm(proc->common->pgdir, sz, sz + n);
  1038c2:	8d 04 13             	lea    (%ebx,%edx,1),%eax
  1038c5:	89 54 24 04          	mov    %edx,0x4(%esp)
  1038c9:	89 44 24 08          	mov    %eax,0x8(%esp)
  1038cd:	8b 41 04             	mov    0x4(%ecx),%eax
  1038d0:	89 04 24             	mov    %eax,(%esp)
  1038d3:	e8 98 2d 00 00       	call   106670 <deallocuvm>
  1038d8:	89 c2                	mov    %eax,%edx
  1038da:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1038e0:	eb a0                	jmp    103882 <growproc+0x52>

  if (sz == 0) {
    writeunlock(&proc->common->pglock);
  1038e2:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  1038e8:	83 c0 08             	add    $0x8,%eax
  1038eb:	89 04 24             	mov    %eax,(%esp)
  1038ee:	e8 fd 32 00 00       	call   106bf0 <writeunlock>
  1038f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1038f8:	eb bb                	jmp    1038b5 <growproc+0x85>
  1038fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103900 <userinit>:
}

// Set up first user process.
void
userinit(void)
{
  103900:	55                   	push   %ebp
  103901:	89 e5                	mov    %esp,%ebp
  103903:	56                   	push   %esi
  103904:	53                   	push   %ebx
  103905:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
  103908:	e8 63 fc ff ff       	call   103570 <allocproc>
  10390d:	89 c6                	mov    %eax,%esi
  initproc = p;
  10390f:	a3 e8 8d 10 00       	mov    %eax,0x108de8
  p->common = &p->threadcommon;
  103914:	89 86 88 00 00 00    	mov    %eax,0x88(%esi)
  if(!(p->common->pgdir = setupkvm()))
  10391a:	e8 81 2c 00 00       	call   1065a0 <setupkvm>
  10391f:	85 c0                	test   %eax,%eax
  103921:	89 46 04             	mov    %eax,0x4(%esi)
  103924:	0f 84 ea 00 00 00    	je     103a14 <userinit+0x114>
    panic("userinit: out of memory?");
  inituvm(p->common->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  10392a:	c7 44 24 08 2c 00 00 	movl   $0x2c,0x8(%esp)
  103931:	00 
  103932:	c7 44 24 04 a8 8c 10 	movl   $0x108ca8,0x4(%esp)
  103939:	00 
  10393a:	8b 86 88 00 00 00    	mov    0x88(%esi),%eax
  103940:	8b 40 04             	mov    0x4(%eax),%eax
  103943:	89 04 24             	mov    %eax,(%esp)
  103946:	e8 c5 2b 00 00       	call   106510 <inituvm>
  p->common->sz = PGSIZE;
  10394b:	8b 86 88 00 00 00    	mov    0x88(%esi),%eax
  103951:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
  103957:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
  10395e:	00 
  10395f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  103966:	00 
  103967:	8b 86 9c 00 00 00    	mov    0x9c(%esi),%eax
  10396d:	89 04 24             	mov    %eax,(%esp)
  103970:	e8 8b 03 00 00       	call   103d00 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  103975:	8b 86 9c 00 00 00    	mov    0x9c(%esi),%eax
  10397b:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  103981:	8b 86 9c 00 00 00    	mov    0x9c(%esi),%eax
  103987:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
  10398d:	8b 96 9c 00 00 00    	mov    0x9c(%esi),%edx
  103993:	0f b7 42 2c          	movzwl 0x2c(%edx),%eax
  103997:	66 89 42 28          	mov    %ax,0x28(%edx)
  p->tf->ss = p->tf->ds;
  10399b:	8b 96 9c 00 00 00    	mov    0x9c(%esi),%edx
  1039a1:	0f b7 42 2c          	movzwl 0x2c(%edx),%eax
  1039a5:	66 89 42 48          	mov    %ax,0x48(%edx)
  p->tf->eflags = FL_IF;
  1039a9:	8b 86 9c 00 00 00    	mov    0x9c(%esi),%eax
  1039af:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
  1039b6:	8b 86 9c 00 00 00    	mov    0x9c(%esi),%eax
  1039bc:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
  1039c3:	8b 86 9c 00 00 00    	mov    0x9c(%esi),%eax
  1039c9:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
  1039d0:	8d 86 a8 00 00 00    	lea    0xa8(%esi),%eax
  1039d6:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  1039dd:	00 
  1039de:	c7 44 24 04 ea 71 10 	movl   $0x1071ea,0x4(%esp)
  1039e5:	00 
  1039e6:	89 04 24             	mov    %eax,(%esp)
  1039e9:	e8 d2 04 00 00       	call   103ec0 <safestrcpy>
  p->common->cwd = namei("/");
  1039ee:	8b 9e 88 00 00 00    	mov    0x88(%esi),%ebx
  1039f4:	c7 04 24 f3 71 10 00 	movl   $0x1071f3,(%esp)
  1039fb:	e8 80 e3 ff ff       	call   101d80 <namei>
  103a00:	89 43 48             	mov    %eax,0x48(%ebx)

  p->state = RUNNABLE;
  103a03:	c7 86 90 00 00 00 03 	movl   $0x3,0x90(%esi)
  103a0a:	00 00 00 
}
  103a0d:	83 c4 10             	add    $0x10,%esp
  103a10:	5b                   	pop    %ebx
  103a11:	5e                   	pop    %esi
  103a12:	5d                   	pop    %ebp
  103a13:	c3                   	ret    
  
  p = allocproc();
  initproc = p;
  p->common = &p->threadcommon;
  if(!(p->common->pgdir = setupkvm()))
    panic("userinit: out of memory?");
  103a14:	c7 04 24 d1 71 10 00 	movl   $0x1071d1,(%esp)
  103a1b:	e8 60 ce ff ff       	call   100880 <panic>

00103a20 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  103a20:	55                   	push   %ebp
  103a21:	89 e5                	mov    %esp,%ebp
  103a23:	57                   	push   %edi
  103a24:	56                   	push   %esi
  103a25:	53                   	push   %ebx
  103a26:	bb 74 c6 10 00       	mov    $0x10c674,%ebx
  103a2b:	83 ec 4c             	sub    $0x4c,%esp
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
  103a2e:	8d 7d cc             	lea    -0x34(%ebp),%edi
  103a31:	eb 52                	jmp    103a85 <procdump+0x65>
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
  103a33:	8b 0c 85 3c 72 10 00 	mov    0x10723c(,%eax,4),%ecx
  103a3a:	85 c9                	test   %ecx,%ecx
  103a3c:	74 56                	je     103a94 <procdump+0x74>
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
  103a3e:	8b 93 94 00 00 00    	mov    0x94(%ebx),%edx
  103a44:	8d 83 a8 00 00 00    	lea    0xa8(%ebx),%eax
  103a4a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103a4e:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  103a52:	c7 04 24 f9 71 10 00 	movl   $0x1071f9,(%esp)
  103a59:	89 54 24 04          	mov    %edx,0x4(%esp)
  103a5d:	e8 5e ca ff ff       	call   1004c0 <cprintf>
    if(p->state == SLEEPING){
  103a62:	83 bb 90 00 00 00 02 	cmpl   $0x2,0x90(%ebx)
  103a69:	74 30                	je     103a9b <procdump+0x7b>
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  103a6b:	c7 04 24 d6 70 10 00 	movl   $0x1070d6,(%esp)
  103a72:	e8 49 ca ff ff       	call   1004c0 <cprintf>
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103a77:	81 c3 b8 00 00 00    	add    $0xb8,%ebx
  103a7d:	81 fb 74 f4 10 00    	cmp    $0x10f474,%ebx
  103a83:	74 55                	je     103ada <procdump+0xba>
    if(p->state == UNUSED)
  103a85:	8b 83 90 00 00 00    	mov    0x90(%ebx),%eax
  103a8b:	85 c0                	test   %eax,%eax
  103a8d:	74 e8                	je     103a77 <procdump+0x57>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
  103a8f:	83 f8 06             	cmp    $0x6,%eax
  103a92:	76 9f                	jbe    103a33 <procdump+0x13>
  103a94:	b9 f5 71 10 00       	mov    $0x1071f5,%ecx
  103a99:	eb a3                	jmp    103a3e <procdump+0x1e>
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
  103a9b:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
  103aa1:	be 01 00 00 00       	mov    $0x1,%esi
  103aa6:	89 7c 24 04          	mov    %edi,0x4(%esp)
  103aaa:	8b 40 0c             	mov    0xc(%eax),%eax
  103aad:	83 c0 08             	add    $0x8,%eax
  103ab0:	89 04 24             	mov    %eax,(%esp)
  103ab3:	e8 78 00 00 00       	call   103b30 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
  103ab8:	8b 44 b7 fc          	mov    -0x4(%edi,%esi,4),%eax
  103abc:	85 c0                	test   %eax,%eax
  103abe:	74 ab                	je     103a6b <procdump+0x4b>
        cprintf(" %p", pc[i]);
  103ac0:	83 c6 01             	add    $0x1,%esi
  103ac3:	89 44 24 04          	mov    %eax,0x4(%esp)
  103ac7:	c7 04 24 aa 6c 10 00 	movl   $0x106caa,(%esp)
  103ace:	e8 ed c9 ff ff       	call   1004c0 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
  103ad3:	83 fe 0b             	cmp    $0xb,%esi
  103ad6:	75 e0                	jne    103ab8 <procdump+0x98>
  103ad8:	eb 91                	jmp    103a6b <procdump+0x4b>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
  103ada:	83 c4 4c             	add    $0x4c,%esp
  103add:	5b                   	pop    %ebx
  103ade:	5e                   	pop    %esi
  103adf:	5f                   	pop    %edi
  103ae0:	5d                   	pop    %ebp
  103ae1:	c3                   	ret    
  103ae2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  103ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103af0 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
  103af0:	55                   	push   %ebp
  103af1:	89 e5                	mov    %esp,%ebp
  103af3:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");
  103af6:	c7 44 24 04 02 72 10 	movl   $0x107202,0x4(%esp)
  103afd:	00 
  103afe:	c7 04 24 40 c6 10 00 	movl   $0x10c640,(%esp)
  103b05:	e8 06 00 00 00       	call   103b10 <initlock>
}
  103b0a:	c9                   	leave  
  103b0b:	c3                   	ret    
  103b0c:	90                   	nop    
  103b0d:	90                   	nop    
  103b0e:	90                   	nop    
  103b0f:	90                   	nop    

00103b10 <initlock>:
#include "rwlock.h"
#include "proc.h"

void
initlock(struct spinlock *lk, char *name)
{
  103b10:	55                   	push   %ebp
  103b11:	89 e5                	mov    %esp,%ebp
  103b13:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
  103b16:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
  103b19:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "proc.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
  103b1f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
  103b22:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
  103b29:	5d                   	pop    %ebp
  103b2a:	c3                   	ret    
  103b2b:	90                   	nop    
  103b2c:	8d 74 26 00          	lea    0x0(%esi),%esi

00103b30 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  103b30:	55                   	push   %ebp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  103b31:	31 c9                	xor    %ecx,%ecx
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  103b33:	89 e5                	mov    %esp,%ebp
  103b35:	53                   	push   %ebx
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  103b36:	8b 55 08             	mov    0x8(%ebp),%edx
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  103b39:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  103b3c:	83 ea 08             	sub    $0x8,%edx
  103b3f:	eb 02                	jmp    103b43 <getcallerpcs+0x13>
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint *) 0x100000 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  103b41:	89 c2                	mov    %eax,%edx
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint *) 0x100000 || ebp == (uint*)0xffffffff)
  103b43:	8d 82 00 00 f0 ff    	lea    -0x100000(%edx),%eax
  103b49:	3d fe ff ef ff       	cmp    $0xffeffffe,%eax
  103b4e:	77 13                	ja     103b63 <getcallerpcs+0x33>
      break;
    pcs[i] = ebp[1];     // saved %eip
  103b50:	8b 42 04             	mov    0x4(%edx),%eax
  103b53:	89 04 8b             	mov    %eax,(%ebx,%ecx,4)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
  103b56:	83 c1 01             	add    $0x1,%ecx
    if(ebp == 0 || ebp < (uint *) 0x100000 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  103b59:	8b 02                	mov    (%edx),%eax
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
  103b5b:	83 f9 0a             	cmp    $0xa,%ecx
  103b5e:	75 e1                	jne    103b41 <getcallerpcs+0x11>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
  103b60:	5b                   	pop    %ebx
  103b61:	5d                   	pop    %ebp
  103b62:	c3                   	ret    
    if(ebp == 0 || ebp < (uint *) 0x100000 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
  103b63:	83 f9 09             	cmp    $0x9,%ecx
  103b66:	7f f8                	jg     103b60 <getcallerpcs+0x30>
  103b68:	8d 04 8b             	lea    (%ebx,%ecx,4),%eax
  103b6b:	90                   	nop    
  103b6c:	8d 74 26 00          	lea    0x0(%esi),%esi
  103b70:	83 c1 01             	add    $0x1,%ecx
    pcs[i] = 0;
  103b73:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint *) 0x100000 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
  103b79:	83 c0 04             	add    $0x4,%eax
  103b7c:	83 f9 0a             	cmp    $0xa,%ecx
  103b7f:	75 ef                	jne    103b70 <getcallerpcs+0x40>
    pcs[i] = 0;
}
  103b81:	5b                   	pop    %ebx
  103b82:	5d                   	pop    %ebp
  103b83:	c3                   	ret    
  103b84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103b8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00103b90 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  103b90:	55                   	push   %ebp
  return lock->locked && lock->cpu == cpu;
  103b91:	31 c0                	xor    %eax,%eax
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  103b93:	89 e5                	mov    %esp,%ebp
  103b95:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu;
  103b98:	8b 0a                	mov    (%edx),%ecx
  103b9a:	85 c9                	test   %ecx,%ecx
  103b9c:	74 10                	je     103bae <holding+0x1e>
  103b9e:	8b 42 08             	mov    0x8(%edx),%eax
  103ba1:	65 3b 05 00 00 00 00 	cmp    %gs:0x0,%eax
  103ba8:	0f 94 c0             	sete   %al
  103bab:	0f b6 c0             	movzbl %al,%eax
}
  103bae:	5d                   	pop    %ebp
  103baf:	c3                   	ret    

00103bb0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
  103bb0:	55                   	push   %ebp
  103bb1:	89 e5                	mov    %esp,%ebp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  103bb3:	9c                   	pushf  
  103bb4:	59                   	pop    %ecx
}

static inline void
cli(void)
{
  asm volatile("cli");
  103bb5:	fa                   	cli    
  int eflags;
  
  eflags = readeflags();
  cli();
  if(cpu->ncli++ == 0)
  103bb6:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  103bbc:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
  103bc2:	83 c2 01             	add    $0x1,%edx
  103bc5:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
  103bcb:	83 ea 01             	sub    $0x1,%edx
  103bce:	74 02                	je     103bd2 <pushcli+0x22>
    cpu->intena = eflags & FL_IF;
}
  103bd0:	5d                   	pop    %ebp
  103bd1:	c3                   	ret    
  int eflags;
  
  eflags = readeflags();
  cli();
  if(cpu->ncli++ == 0)
    cpu->intena = eflags & FL_IF;
  103bd2:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  103bd8:	81 e1 00 02 00 00    	and    $0x200,%ecx
  103bde:	89 88 b0 00 00 00    	mov    %ecx,0xb0(%eax)
}
  103be4:	5d                   	pop    %ebp
  103be5:	c3                   	ret    
  103be6:	8d 76 00             	lea    0x0(%esi),%esi
  103be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103bf0 <popcli>:

void
popcli(void)
{
  103bf0:	55                   	push   %ebp
  103bf1:	89 e5                	mov    %esp,%ebp
  103bf3:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  103bf6:	9c                   	pushf  
  103bf7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
  103bf8:	f6 c4 02             	test   $0x2,%ah
  103bfb:	75 36                	jne    103c33 <popcli+0x43>
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
  103bfd:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  103c03:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
  103c09:	83 ea 01             	sub    $0x1,%edx
  103c0c:	85 d2                	test   %edx,%edx
  103c0e:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
  103c14:	78 29                	js     103c3f <popcli+0x4f>
    panic("popcli");
  if(cpu->ncli == 0 && cpu->intena)
  103c16:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  103c1c:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
  103c22:	85 d2                	test   %edx,%edx
  103c24:	75 0b                	jne    103c31 <popcli+0x41>
  103c26:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
  103c2c:	85 c0                	test   %eax,%eax
  103c2e:	74 01                	je     103c31 <popcli+0x41>
}

static inline void
sti(void)
{
  asm volatile("sti");
  103c30:	fb                   	sti    
    sti();
}
  103c31:	c9                   	leave  
  103c32:	c3                   	ret    

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  103c33:	c7 04 24 58 72 10 00 	movl   $0x107258,(%esp)
  103c3a:	e8 41 cc ff ff       	call   100880 <panic>
  if(--cpu->ncli < 0)
    panic("popcli");
  103c3f:	c7 04 24 6f 72 10 00 	movl   $0x10726f,(%esp)
  103c46:	e8 35 cc ff ff       	call   100880 <panic>
  103c4b:	90                   	nop    
  103c4c:	8d 74 26 00          	lea    0x0(%esi),%esi

00103c50 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
  103c50:	55                   	push   %ebp
  103c51:	89 e5                	mov    %esp,%ebp
  103c53:	53                   	push   %ebx
  103c54:	83 ec 04             	sub    $0x4,%esp
  103c57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
  103c5a:	89 1c 24             	mov    %ebx,(%esp)
  103c5d:	e8 2e ff ff ff       	call   103b90 <holding>
  103c62:	85 c0                	test   %eax,%eax
  103c64:	74 1d                	je     103c83 <release+0x33>
    panic("release");

  lk->pcs[0] = 0;
  103c66:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  103c6d:	31 c0                	xor    %eax,%eax
  lk->cpu = 0;
  103c6f:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  103c76:	f0 87 03             	lock xchg %eax,(%ebx)
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);

  popcli();
}
  103c79:	83 c4 04             	add    $0x4,%esp
  103c7c:	5b                   	pop    %ebx
  103c7d:	5d                   	pop    %ebp
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);

  popcli();
  103c7e:	e9 6d ff ff ff       	jmp    103bf0 <popcli>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
  103c83:	c7 04 24 76 72 10 00 	movl   $0x107276,(%esp)
  103c8a:	e8 f1 cb ff ff       	call   100880 <panic>
  103c8f:	90                   	nop    

00103c90 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
  103c90:	55                   	push   %ebp
  103c91:	89 e5                	mov    %esp,%ebp
  103c93:	53                   	push   %ebx
  103c94:	83 ec 14             	sub    $0x14,%esp
  pushcli();
  103c97:	e8 14 ff ff ff       	call   103bb0 <pushcli>
  if(holding(lk))
  103c9c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  103c9f:	89 1c 24             	mov    %ebx,(%esp)
  103ca2:	e8 e9 fe ff ff       	call   103b90 <holding>
  103ca7:	85 c0                	test   %eax,%eax
  103ca9:	74 08                	je     103cb3 <acquire+0x23>
  103cab:	eb 39                	jmp    103ce6 <acquire+0x56>
  103cad:	8d 76 00             	lea    0x0(%esi),%esi
  103cb0:	8b 5d 08             	mov    0x8(%ebp),%ebx
  103cb3:	b8 01 00 00 00       	mov    $0x1,%eax
  103cb8:	f0 87 03             	lock xchg %eax,(%ebx)
    panic("acquire");

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
  103cbb:	85 c0                	test   %eax,%eax
  103cbd:	75 f1                	jne    103cb0 <acquire+0x20>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
  103cbf:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  103cc5:	8b 55 08             	mov    0x8(%ebp),%edx
  103cc8:	89 42 08             	mov    %eax,0x8(%edx)
  getcallerpcs(&lk, lk->pcs);
  103ccb:	8b 45 08             	mov    0x8(%ebp),%eax
  103cce:	83 c0 0c             	add    $0xc,%eax
  103cd1:	89 44 24 04          	mov    %eax,0x4(%esp)
  103cd5:	8d 45 08             	lea    0x8(%ebp),%eax
  103cd8:	89 04 24             	mov    %eax,(%esp)
  103cdb:	e8 50 fe ff ff       	call   103b30 <getcallerpcs>
}
  103ce0:	83 c4 14             	add    $0x14,%esp
  103ce3:	5b                   	pop    %ebx
  103ce4:	5d                   	pop    %ebp
  103ce5:	c3                   	ret    
void
acquire(struct spinlock *lk)
{
  pushcli();
  if(holding(lk))
    panic("acquire");
  103ce6:	c7 04 24 7e 72 10 00 	movl   $0x10727e,(%esp)
  103ced:	e8 8e cb ff ff       	call   100880 <panic>
  103cf2:	90                   	nop    
  103cf3:	90                   	nop    
  103cf4:	90                   	nop    
  103cf5:	90                   	nop    
  103cf6:	90                   	nop    
  103cf7:	90                   	nop    
  103cf8:	90                   	nop    
  103cf9:	90                   	nop    
  103cfa:	90                   	nop    
  103cfb:	90                   	nop    
  103cfc:	90                   	nop    
  103cfd:	90                   	nop    
  103cfe:	90                   	nop    
  103cff:	90                   	nop    

00103d00 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
  103d00:	55                   	push   %ebp
  103d01:	89 e5                	mov    %esp,%ebp
  103d03:	8b 55 08             	mov    0x8(%ebp),%edx
  103d06:	57                   	push   %edi
  103d07:	8b 45 0c             	mov    0xc(%ebp),%eax
  103d0a:	8b 4d 10             	mov    0x10(%ebp),%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  103d0d:	89 d7                	mov    %edx,%edi
  103d0f:	fc                   	cld    
  103d10:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  103d12:	5f                   	pop    %edi
  103d13:	89 d0                	mov    %edx,%eax
  103d15:	5d                   	pop    %ebp
  103d16:	c3                   	ret    
  103d17:	89 f6                	mov    %esi,%esi
  103d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103d20 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
  103d20:	55                   	push   %ebp
  103d21:	89 e5                	mov    %esp,%ebp
  103d23:	57                   	push   %edi
  103d24:	56                   	push   %esi
  103d25:	53                   	push   %ebx
  103d26:	83 ec 04             	sub    $0x4,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  103d29:	8b 45 10             	mov    0x10(%ebp),%eax
  return dst;
}

int
memcmp(const void *v1, const void *v2, uint n)
{
  103d2c:	8b 55 08             	mov    0x8(%ebp),%edx
  103d2f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  103d32:	83 e8 01             	sub    $0x1,%eax
  103d35:	83 f8 ff             	cmp    $0xffffffff,%eax
  103d38:	74 36                	je     103d70 <memcmp+0x50>
    if(*s1 != *s2)
  103d3a:	0f b6 32             	movzbl (%edx),%esi
  103d3d:	0f b6 0f             	movzbl (%edi),%ecx
  103d40:	89 f3                	mov    %esi,%ebx
  103d42:	88 4d f3             	mov    %cl,-0xd(%ebp)
      return *s1 - *s2;
  103d45:	89 d1                	mov    %edx,%ecx
  103d47:	89 fa                	mov    %edi,%edx
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
  103d49:	3a 5d f3             	cmp    -0xd(%ebp),%bl
  103d4c:	74 1a                	je     103d68 <memcmp+0x48>
  103d4e:	eb 2c                	jmp    103d7c <memcmp+0x5c>
  103d50:	0f b6 71 01          	movzbl 0x1(%ecx),%esi
  103d54:	83 c1 01             	add    $0x1,%ecx
  103d57:	0f b6 5a 01          	movzbl 0x1(%edx),%ebx
  103d5b:	83 c2 01             	add    $0x1,%edx
  103d5e:	88 5d f3             	mov    %bl,-0xd(%ebp)
  103d61:	89 f3                	mov    %esi,%ebx
  103d63:	3a 5d f3             	cmp    -0xd(%ebp),%bl
  103d66:	75 14                	jne    103d7c <memcmp+0x5c>
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  103d68:	83 e8 01             	sub    $0x1,%eax
  103d6b:	83 f8 ff             	cmp    $0xffffffff,%eax
  103d6e:	75 e0                	jne    103d50 <memcmp+0x30>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
  103d70:	83 c4 04             	add    $0x4,%esp
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  103d73:	31 d2                	xor    %edx,%edx
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
  103d75:	5b                   	pop    %ebx
  103d76:	89 d0                	mov    %edx,%eax
  103d78:	5e                   	pop    %esi
  103d79:	5f                   	pop    %edi
  103d7a:	5d                   	pop    %ebp
  103d7b:	c3                   	ret    
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
  103d7c:	89 f0                	mov    %esi,%eax
  103d7e:	0f b6 d0             	movzbl %al,%edx
  103d81:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
    s1++, s2++;
  }

  return 0;
}
  103d85:	83 c4 04             	add    $0x4,%esp
  103d88:	5b                   	pop    %ebx
  103d89:	5e                   	pop    %esi
  103d8a:	5f                   	pop    %edi
  103d8b:	5d                   	pop    %ebp
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
  103d8c:	29 c2                	sub    %eax,%edx
    s1++, s2++;
  }

  return 0;
}
  103d8e:	89 d0                	mov    %edx,%eax
  103d90:	c3                   	ret    
  103d91:	eb 0d                	jmp    103da0 <memmove>
  103d93:	90                   	nop    
  103d94:	90                   	nop    
  103d95:	90                   	nop    
  103d96:	90                   	nop    
  103d97:	90                   	nop    
  103d98:	90                   	nop    
  103d99:	90                   	nop    
  103d9a:	90                   	nop    
  103d9b:	90                   	nop    
  103d9c:	90                   	nop    
  103d9d:	90                   	nop    
  103d9e:	90                   	nop    
  103d9f:	90                   	nop    

00103da0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
  103da0:	55                   	push   %ebp
  103da1:	89 e5                	mov    %esp,%ebp
  103da3:	56                   	push   %esi
  103da4:	53                   	push   %ebx
  103da5:	8b 75 08             	mov    0x8(%ebp),%esi
  103da8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  103dab:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
  103dae:	39 f1                	cmp    %esi,%ecx
  103db0:	73 2e                	jae    103de0 <memmove+0x40>
  103db2:	8d 04 19             	lea    (%ecx,%ebx,1),%eax
  103db5:	39 c6                	cmp    %eax,%esi
  103db7:	73 27                	jae    103de0 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
  103db9:	85 db                	test   %ebx,%ebx
  103dbb:	74 1a                	je     103dd7 <memmove+0x37>
  103dbd:	89 c2                	mov    %eax,%edx
  103dbf:	29 d8                	sub    %ebx,%eax
  103dc1:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
  103dc4:	89 c3                	mov    %eax,%ebx
      *--d = *--s;
  103dc6:	0f b6 42 ff          	movzbl -0x1(%edx),%eax
  103dca:	83 ea 01             	sub    $0x1,%edx
  103dcd:	88 41 ff             	mov    %al,-0x1(%ecx)
  103dd0:	83 e9 01             	sub    $0x1,%ecx
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
  103dd3:	39 da                	cmp    %ebx,%edx
  103dd5:	75 ef                	jne    103dc6 <memmove+0x26>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
  103dd7:	89 f0                	mov    %esi,%eax
  103dd9:	5b                   	pop    %ebx
  103dda:	5e                   	pop    %esi
  103ddb:	5d                   	pop    %ebp
  103ddc:	c3                   	ret    
  103ddd:	8d 76 00             	lea    0x0(%esi),%esi
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
  103de0:	31 d2                	xor    %edx,%edx
      *--d = *--s;
  } else
    while(n-- > 0)
  103de2:	85 db                	test   %ebx,%ebx
  103de4:	74 f1                	je     103dd7 <memmove+0x37>
      *d++ = *s++;
  103de6:	0f b6 04 0a          	movzbl (%edx,%ecx,1),%eax
  103dea:	88 04 32             	mov    %al,(%edx,%esi,1)
  103ded:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
  103df0:	39 da                	cmp    %ebx,%edx
  103df2:	75 f2                	jne    103de6 <memmove+0x46>
      *d++ = *s++;

  return dst;
}
  103df4:	89 f0                	mov    %esi,%eax
  103df6:	5b                   	pop    %ebx
  103df7:	5e                   	pop    %esi
  103df8:	5d                   	pop    %ebp
  103df9:	c3                   	ret    
  103dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103e00 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  103e00:	55                   	push   %ebp
  103e01:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
  103e03:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
  103e04:	e9 97 ff ff ff       	jmp    103da0 <memmove>
  103e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00103e10 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
  103e10:	55                   	push   %ebp
  103e11:	89 e5                	mov    %esp,%ebp
  103e13:	56                   	push   %esi
  103e14:	53                   	push   %ebx
  103e15:	8b 5d 10             	mov    0x10(%ebp),%ebx
  103e18:	8b 55 08             	mov    0x8(%ebp),%edx
  103e1b:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
  103e1e:	85 db                	test   %ebx,%ebx
  103e20:	74 2a                	je     103e4c <strncmp+0x3c>
  103e22:	0f b6 02             	movzbl (%edx),%eax
  103e25:	84 c0                	test   %al,%al
  103e27:	74 2b                	je     103e54 <strncmp+0x44>
  103e29:	0f b6 0e             	movzbl (%esi),%ecx
  103e2c:	38 c8                	cmp    %cl,%al
  103e2e:	74 17                	je     103e47 <strncmp+0x37>
  103e30:	eb 25                	jmp    103e57 <strncmp+0x47>
  103e32:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    n--, p++, q++;
  103e36:	83 c6 01             	add    $0x1,%esi
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
  103e39:	84 c0                	test   %al,%al
  103e3b:	74 17                	je     103e54 <strncmp+0x44>
  103e3d:	0f b6 0e             	movzbl (%esi),%ecx
  103e40:	83 c2 01             	add    $0x1,%edx
  103e43:	38 c8                	cmp    %cl,%al
  103e45:	75 10                	jne    103e57 <strncmp+0x47>
  103e47:	83 eb 01             	sub    $0x1,%ebx
  103e4a:	75 e6                	jne    103e32 <strncmp+0x22>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
  103e4c:	5b                   	pop    %ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
  103e4d:	31 d2                	xor    %edx,%edx
}
  103e4f:	5e                   	pop    %esi
  103e50:	89 d0                	mov    %edx,%eax
  103e52:	5d                   	pop    %ebp
  103e53:	c3                   	ret    
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
  103e54:	0f b6 0e             	movzbl (%esi),%ecx
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
  103e57:	0f b6 d0             	movzbl %al,%edx
  103e5a:	0f b6 c1             	movzbl %cl,%eax
}
  103e5d:	5b                   	pop    %ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
  103e5e:	29 c2                	sub    %eax,%edx
}
  103e60:	5e                   	pop    %esi
  103e61:	89 d0                	mov    %edx,%eax
  103e63:	5d                   	pop    %ebp
  103e64:	c3                   	ret    
  103e65:	8d 74 26 00          	lea    0x0(%esi),%esi
  103e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103e70 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
  103e70:	55                   	push   %ebp
  103e71:	89 e5                	mov    %esp,%ebp
  103e73:	56                   	push   %esi
  103e74:	8b 75 08             	mov    0x8(%ebp),%esi
  103e77:	53                   	push   %ebx
  103e78:	8b 4d 10             	mov    0x10(%ebp),%ecx
  103e7b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  103e7e:	89 f2                	mov    %esi,%edx
  103e80:	eb 03                	jmp    103e85 <strncpy+0x15>
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
  103e82:	83 c3 01             	add    $0x1,%ebx
  103e85:	83 e9 01             	sub    $0x1,%ecx
  103e88:	8d 41 01             	lea    0x1(%ecx),%eax
  103e8b:	85 c0                	test   %eax,%eax
  103e8d:	7e 0c                	jle    103e9b <strncpy+0x2b>
  103e8f:	0f b6 03             	movzbl (%ebx),%eax
  103e92:	88 02                	mov    %al,(%edx)
  103e94:	83 c2 01             	add    $0x1,%edx
  103e97:	84 c0                	test   %al,%al
  103e99:	75 e7                	jne    103e82 <strncpy+0x12>
    ;
  while(n-- > 0)
  103e9b:	85 c9                	test   %ecx,%ecx
  103e9d:	7e 0d                	jle    103eac <strncpy+0x3c>
  103e9f:	8d 04 11             	lea    (%ecx,%edx,1),%eax
    *s++ = 0;
  103ea2:	c6 02 00             	movb   $0x0,(%edx)
  103ea5:	83 c2 01             	add    $0x1,%edx
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
  103ea8:	39 c2                	cmp    %eax,%edx
  103eaa:	75 f6                	jne    103ea2 <strncpy+0x32>
    *s++ = 0;
  return os;
}
  103eac:	89 f0                	mov    %esi,%eax
  103eae:	5b                   	pop    %ebx
  103eaf:	5e                   	pop    %esi
  103eb0:	5d                   	pop    %ebp
  103eb1:	c3                   	ret    
  103eb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  103eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103ec0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
  103ec0:	55                   	push   %ebp
  103ec1:	89 e5                	mov    %esp,%ebp
  103ec3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  103ec6:	56                   	push   %esi
  103ec7:	8b 75 08             	mov    0x8(%ebp),%esi
  103eca:	53                   	push   %ebx
  103ecb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;
  
  os = s;
  if(n <= 0)
  103ece:	85 c9                	test   %ecx,%ecx
  103ed0:	7e 1b                	jle    103eed <safestrcpy+0x2d>
  103ed2:	89 f2                	mov    %esi,%edx
  103ed4:	eb 03                	jmp    103ed9 <safestrcpy+0x19>
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
  103ed6:	83 c3 01             	add    $0x1,%ebx
  103ed9:	83 e9 01             	sub    $0x1,%ecx
  103edc:	74 0c                	je     103eea <safestrcpy+0x2a>
  103ede:	0f b6 03             	movzbl (%ebx),%eax
  103ee1:	88 02                	mov    %al,(%edx)
  103ee3:	83 c2 01             	add    $0x1,%edx
  103ee6:	84 c0                	test   %al,%al
  103ee8:	75 ec                	jne    103ed6 <safestrcpy+0x16>
    ;
  *s = 0;
  103eea:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
  103eed:	89 f0                	mov    %esi,%eax
  103eef:	5b                   	pop    %ebx
  103ef0:	5e                   	pop    %esi
  103ef1:	5d                   	pop    %ebp
  103ef2:	c3                   	ret    
  103ef3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00103f00 <strlen>:

int
strlen(const char *s)
{
  103f00:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
  103f01:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
  103f03:	89 e5                	mov    %esp,%ebp
  103f05:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  103f08:	80 3a 00             	cmpb   $0x0,(%edx)
  103f0b:	74 0c                	je     103f19 <strlen+0x19>
  103f0d:	8d 76 00             	lea    0x0(%esi),%esi
  103f10:	83 c0 01             	add    $0x1,%eax
  103f13:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  103f17:	75 f7                	jne    103f10 <strlen+0x10>
    ;
  return n;
}
  103f19:	5d                   	pop    %ebp
  103f1a:	c3                   	ret    
  103f1b:	90                   	nop    

00103f1c <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
  103f1c:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
  103f20:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
  103f24:	55                   	push   %ebp
  pushl %ebx
  103f25:	53                   	push   %ebx
  pushl %esi
  103f26:	56                   	push   %esi
  pushl %edi
  103f27:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
  103f28:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
  103f2a:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
  103f2c:	5f                   	pop    %edi
  popl %esi
  103f2d:	5e                   	pop    %esi
  popl %ebx
  103f2e:	5b                   	pop    %ebx
  popl %ebp
  103f2f:	5d                   	pop    %ebp
  ret
  103f30:	c3                   	ret    
  103f31:	90                   	nop    
  103f32:	90                   	nop    
  103f33:	90                   	nop    
  103f34:	90                   	nop    
  103f35:	90                   	nop    
  103f36:	90                   	nop    
  103f37:	90                   	nop    
  103f38:	90                   	nop    
  103f39:	90                   	nop    
  103f3a:	90                   	nop    
  103f3b:	90                   	nop    
  103f3c:	90                   	nop    
  103f3d:	90                   	nop    
  103f3e:	90                   	nop    
  103f3f:	90                   	nop    

00103f40 <fetchstr_legacy>:
  return 0;
}

int
fetchstr_legacy(struct proc *p, uint addr, char **pp)
{
  103f40:	55                   	push   %ebp
  103f41:	89 e5                	mov    %esp,%ebp
  103f43:	8b 55 08             	mov    0x8(%ebp),%edx
  103f46:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *s, *ep;

  if(addr >= p->common->sz)
  103f49:	8b 82 88 00 00 00    	mov    0x88(%edx),%eax
  103f4f:	39 08                	cmp    %ecx,(%eax)
  103f51:	77 07                	ja     103f5a <fetchstr_legacy+0x1a>
    return -1;
  *pp = (char *) addr;
  ep = (char *) p->common->sz;
  for(s = *pp; s < ep; s++)
  103f53:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    if(*s == 0)
      return s - *pp;
  return -1;
}
  103f58:	5d                   	pop    %ebp
  103f59:	c3                   	ret    
{
  char *s, *ep;

  if(addr >= p->common->sz)
    return -1;
  *pp = (char *) addr;
  103f5a:	8b 45 10             	mov    0x10(%ebp),%eax
  103f5d:	89 08                	mov    %ecx,(%eax)
  ep = (char *) p->common->sz;
  103f5f:	8b 82 88 00 00 00    	mov    0x88(%edx),%eax
  103f65:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++)
  103f67:	39 d1                	cmp    %edx,%ecx
  103f69:	73 e8                	jae    103f53 <fetchstr_legacy+0x13>
    if(*s == 0)
  103f6b:	31 c0                	xor    %eax,%eax
  103f6d:	80 39 00             	cmpb   $0x0,(%ecx)
  103f70:	74 e6                	je     103f58 <fetchstr_legacy+0x18>
  103f72:	89 c8                	mov    %ecx,%eax

  if(addr >= p->common->sz)
    return -1;
  *pp = (char *) addr;
  ep = (char *) p->common->sz;
  for(s = *pp; s < ep; s++)
  103f74:	83 c0 01             	add    $0x1,%eax
  103f77:	39 d0                	cmp    %edx,%eax
  103f79:	74 d8                	je     103f53 <fetchstr_legacy+0x13>
    if(*s == 0)
  103f7b:	80 38 00             	cmpb   $0x0,(%eax)
  103f7e:	75 f4                	jne    103f74 <fetchstr_legacy+0x34>
      return s - *pp;
  return -1;
}
  103f80:	5d                   	pop    %ebp
  if(addr >= p->common->sz)
    return -1;
  *pp = (char *) addr;
  ep = (char *) p->common->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
  103f81:	29 c8                	sub    %ecx,%eax
      return s - *pp;
  return -1;
}
  103f83:	c3                   	ret    
  103f84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103f8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00103f90 <syscall>:
[SYS_twait]   sys_twait,
};

void
syscall(void)
{
  103f90:	55                   	push   %ebp
  103f91:	89 e5                	mov    %esp,%ebp
  103f93:	53                   	push   %ebx
  103f94:	83 ec 14             	sub    $0x14,%esp
  int num;
  
  num = proc->tf->eax;
  103f97:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103f9d:	8b 98 9c 00 00 00    	mov    0x9c(%eax),%ebx
  103fa3:	8b 4b 1c             	mov    0x1c(%ebx),%ecx
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num]) {
  103fa6:	83 f9 1a             	cmp    $0x1a,%ecx
  103fa9:	77 16                	ja     103fc1 <syscall+0x31>
  103fab:	8b 14 8d c0 72 10 00 	mov    0x1072c0(,%ecx,4),%edx
  103fb2:	85 d2                	test   %edx,%edx
  103fb4:	74 0b                	je     103fc1 <syscall+0x31>
    proc->tf->eax = syscalls[num]();
  103fb6:	ff d2                	call   *%edx
  103fb8:	89 43 1c             	mov    %eax,0x1c(%ebx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  }
}
  103fbb:	83 c4 14             	add    $0x14,%esp
  103fbe:	5b                   	pop    %ebx
  103fbf:	5d                   	pop    %ebp
  103fc0:	c3                   	ret    
  
  num = proc->tf->eax;
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
  103fc1:	8b 90 94 00 00 00    	mov    0x94(%eax),%edx
  103fc7:	05 a8 00 00 00       	add    $0xa8,%eax
  103fcc:	89 44 24 08          	mov    %eax,0x8(%esp)
  103fd0:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  103fd4:	c7 04 24 86 72 10 00 	movl   $0x107286,(%esp)
  103fdb:	89 54 24 04          	mov    %edx,0x4(%esp)
  103fdf:	e8 dc c4 ff ff       	call   1004c0 <cprintf>
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  103fe4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103fea:	8b 80 9c 00 00 00    	mov    0x9c(%eax),%eax
  103ff0:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
  103ff7:	83 c4 14             	add    $0x14,%esp
  103ffa:	5b                   	pop    %ebx
  103ffb:	5d                   	pop    %ebp
  103ffc:	c3                   	ret    
  103ffd:	8d 76 00             	lea    0x0(%esi),%esi

00104000 <writebuf>:
  return 0;
}

int
writebuf(struct proc *p, uint addr, void *src, uint sz)
{
  104000:	55                   	push   %ebp
  104001:	89 e5                	mov    %esp,%ebp
  104003:	83 ec 18             	sub    $0x18,%esp
  104006:	89 75 f8             	mov    %esi,-0x8(%ebp)
  104009:	8b 75 08             	mov    0x8(%ebp),%esi
  10400c:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  10400f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  104012:	89 7d fc             	mov    %edi,-0x4(%ebp)
  104015:	8b 7d 14             	mov    0x14(%ebp),%edi
  readlock(&p->common->pglock);
  104018:	8b 86 88 00 00 00    	mov    0x88(%esi),%eax
  10401e:	83 c0 08             	add    $0x8,%eax
  104021:	89 04 24             	mov    %eax,(%esp)
  104024:	e8 97 2b 00 00       	call   106bc0 <readlock>

  if(addr >= p->common->sz || (uint)addr+sz >= proc->common->sz)
  104029:	8b 8e 88 00 00 00    	mov    0x88(%esi),%ecx
  10402f:	39 19                	cmp    %ebx,(%ecx)
  104031:	76 14                	jbe    104047 <writebuf+0x47>
  104033:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  10403a:	8d 04 1f             	lea    (%edi,%ebx,1),%eax
  10403d:	8b 92 88 00 00 00    	mov    0x88(%edx),%edx
  104043:	3b 02                	cmp    (%edx),%eax
  104045:	72 1d                	jb     104064 <writebuf+0x64>

  readunlock(&p->common->pglock);
  return sz;

error:
  readunlock(&p->common->pglock);
  104047:	8d 41 08             	lea    0x8(%ecx),%eax
  10404a:	89 04 24             	mov    %eax,(%esp)
  10404d:	e8 7e 2b 00 00       	call   106bd0 <readunlock>
  104052:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return -1;
}
  104057:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  10405a:	8b 75 f8             	mov    -0x8(%ebp),%esi
  10405d:	8b 7d fc             	mov    -0x4(%ebp),%edi
  104060:	89 ec                	mov    %ebp,%esp
  104062:	5d                   	pop    %ebp
  104063:	c3                   	ret    
  readlock(&p->common->pglock);

  if(addr >= p->common->sz || (uint)addr+sz >= proc->common->sz)
    goto error;

  memmove((char *)addr, src, sz);
  104064:	8b 45 10             	mov    0x10(%ebp),%eax
  104067:	89 7c 24 08          	mov    %edi,0x8(%esp)
  10406b:	89 1c 24             	mov    %ebx,(%esp)
  10406e:	89 44 24 04          	mov    %eax,0x4(%esp)
  104072:	e8 29 fd ff ff       	call   103da0 <memmove>

  readunlock(&p->common->pglock);
  104077:	8b 86 88 00 00 00    	mov    0x88(%esi),%eax
  10407d:	83 c0 08             	add    $0x8,%eax
  104080:	89 04 24             	mov    %eax,(%esp)
  104083:	e8 48 2b 00 00       	call   106bd0 <readunlock>
  return sz;
  104088:	89 f8                	mov    %edi,%eax
  10408a:	eb cb                	jmp    104057 <writebuf+0x57>
  10408c:	8d 74 26 00          	lea    0x0(%esi),%esi

00104090 <writestr>:
  return -1;
}

int
writestr(struct proc *p, uint addr, char *src, uint dsz)
{
  104090:	55                   	push   %ebp
  104091:	89 e5                	mov    %esp,%ebp
  104093:	83 ec 18             	sub    $0x18,%esp
  104096:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  104099:	8b 5d 10             	mov    0x10(%ebp),%ebx
  10409c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  10409f:	8b 75 0c             	mov    0xc(%ebp),%esi
  1040a2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  1040a5:	8b 7d 08             	mov    0x8(%ebp),%edi
  return writebuf(p, addr, src, strlen(src) + 1);
  1040a8:	89 1c 24             	mov    %ebx,(%esp)
  1040ab:	e8 50 fe ff ff       	call   103f00 <strlen>
  1040b0:	89 5d 10             	mov    %ebx,0x10(%ebp)
}
  1040b3:	8b 5d f4             	mov    -0xc(%ebp),%ebx
}

int
writestr(struct proc *p, uint addr, char *src, uint dsz)
{
  return writebuf(p, addr, src, strlen(src) + 1);
  1040b6:	89 75 0c             	mov    %esi,0xc(%ebp)
}
  1040b9:	8b 75 f8             	mov    -0x8(%ebp),%esi
}

int
writestr(struct proc *p, uint addr, char *src, uint dsz)
{
  return writebuf(p, addr, src, strlen(src) + 1);
  1040bc:	89 7d 08             	mov    %edi,0x8(%ebp)
}
  1040bf:	8b 7d fc             	mov    -0x4(%ebp),%edi
}

int
writestr(struct proc *p, uint addr, char *src, uint dsz)
{
  return writebuf(p, addr, src, strlen(src) + 1);
  1040c2:	83 c0 01             	add    $0x1,%eax
  1040c5:	89 45 14             	mov    %eax,0x14(%ebp)
}
  1040c8:	89 ec                	mov    %ebp,%esp
  1040ca:	5d                   	pop    %ebp
}

int
writestr(struct proc *p, uint addr, char *src, uint dsz)
{
  return writebuf(p, addr, src, strlen(src) + 1);
  1040cb:	e9 30 ff ff ff       	jmp    104000 <writebuf>

001040d0 <writeint>:
  return -1;
}

int
writeint(struct proc *p, uint addr, int i)
{
  1040d0:	55                   	push   %ebp
  1040d1:	89 e5                	mov    %esp,%ebp
  1040d3:	83 ec 18             	sub    $0x18,%esp
  1040d6:	89 75 fc             	mov    %esi,-0x4(%ebp)
  1040d9:	8b 75 08             	mov    0x8(%ebp),%esi
  1040dc:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  1040df:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  readlock(&p->common->pglock);
  1040e2:	8b 86 88 00 00 00    	mov    0x88(%esi),%eax
  1040e8:	83 c0 08             	add    $0x8,%eax
  1040eb:	89 04 24             	mov    %eax,(%esp)
  1040ee:	e8 cd 2a 00 00       	call   106bc0 <readlock>

  if (addr >= p->common->sz || addr+4 > p->common->sz) {
  1040f3:	8b 8e 88 00 00 00    	mov    0x88(%esi),%ecx
  1040f9:	8b 11                	mov    (%ecx),%edx
  1040fb:	39 da                	cmp    %ebx,%edx
  1040fd:	76 07                	jbe    104106 <writeint+0x36>
  1040ff:	8d 43 04             	lea    0x4(%ebx),%eax
  104102:	39 c2                	cmp    %eax,%edx
  104104:	73 1a                	jae    104120 <writeint+0x50>
    readunlock(&p->common->pglock);
  104106:	8d 41 08             	lea    0x8(%ecx),%eax
  104109:	89 04 24             	mov    %eax,(%esp)
  10410c:	e8 bf 2a 00 00       	call   106bd0 <readunlock>

  *(int*)(addr) = i;

  readunlock(&p->common->pglock);
  return 0;
}
  104111:	8b 5d f8             	mov    -0x8(%ebp),%ebx
writeint(struct proc *p, uint addr, int i)
{
  readlock(&p->common->pglock);

  if (addr >= p->common->sz || addr+4 > p->common->sz) {
    readunlock(&p->common->pglock);
  104114:	b8 ff ff ff ff       	mov    $0xffffffff,%eax

  *(int*)(addr) = i;

  readunlock(&p->common->pglock);
  return 0;
}
  104119:	8b 75 fc             	mov    -0x4(%ebp),%esi
  10411c:	89 ec                	mov    %ebp,%esp
  10411e:	5d                   	pop    %ebp
  10411f:	c3                   	ret    
  if (addr >= p->common->sz || addr+4 > p->common->sz) {
    readunlock(&p->common->pglock);
    return -1;
  }

  *(int*)(addr) = i;
  104120:	8b 45 10             	mov    0x10(%ebp),%eax
  104123:	89 03                	mov    %eax,(%ebx)

  readunlock(&p->common->pglock);
  104125:	8b 86 88 00 00 00    	mov    0x88(%esi),%eax
  10412b:	83 c0 08             	add    $0x8,%eax
  10412e:	89 04 24             	mov    %eax,(%esp)
  104131:	e8 9a 2a 00 00       	call   106bd0 <readunlock>
  return 0;
}
  104136:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    return -1;
  }

  *(int*)(addr) = i;

  readunlock(&p->common->pglock);
  104139:	31 c0                	xor    %eax,%eax
  return 0;
}
  10413b:	8b 75 fc             	mov    -0x4(%ebp),%esi
  10413e:	89 ec                	mov    %ebp,%esp
  104140:	5d                   	pop    %ebp
  104141:	c3                   	ret    
  104142:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  104149:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00104150 <fetchbuf>:
  return -1;
}

int
fetchbuf(struct proc *p, uint addr, void *dst, uint sz)
{
  104150:	55                   	push   %ebp
  104151:	89 e5                	mov    %esp,%ebp
  104153:	83 ec 18             	sub    $0x18,%esp
  104156:	89 75 f8             	mov    %esi,-0x8(%ebp)
  104159:	8b 75 08             	mov    0x8(%ebp),%esi
  10415c:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  10415f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  104162:	89 7d fc             	mov    %edi,-0x4(%ebp)
  104165:	8b 7d 14             	mov    0x14(%ebp),%edi
  readlock(&p->common->pglock);
  104168:	8b 86 88 00 00 00    	mov    0x88(%esi),%eax
  10416e:	83 c0 08             	add    $0x8,%eax
  104171:	89 04 24             	mov    %eax,(%esp)
  104174:	e8 47 2a 00 00       	call   106bc0 <readlock>

  if(addr >= p->common->sz || (uint)addr+sz >= proc->common->sz)
  104179:	8b 8e 88 00 00 00    	mov    0x88(%esi),%ecx
  10417f:	39 19                	cmp    %ebx,(%ecx)
  104181:	76 14                	jbe    104197 <fetchbuf+0x47>
  104183:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  10418a:	8d 04 1f             	lea    (%edi,%ebx,1),%eax
  10418d:	8b 92 88 00 00 00    	mov    0x88(%edx),%edx
  104193:	3b 02                	cmp    (%edx),%eax
  104195:	72 1d                	jb     1041b4 <fetchbuf+0x64>

  readunlock(&p->common->pglock);
  return sz;

error:
  readunlock(&p->common->pglock);
  104197:	8d 41 08             	lea    0x8(%ecx),%eax
  10419a:	89 04 24             	mov    %eax,(%esp)
  10419d:	e8 2e 2a 00 00       	call   106bd0 <readunlock>
  1041a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return -1;
}
  1041a7:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1041aa:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1041ad:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1041b0:	89 ec                	mov    %ebp,%esp
  1041b2:	5d                   	pop    %ebp
  1041b3:	c3                   	ret    
  readlock(&p->common->pglock);

  if(addr >= p->common->sz || (uint)addr+sz >= proc->common->sz)
    goto error;

  memmove(dst, (char *)addr, sz);
  1041b4:	8b 45 10             	mov    0x10(%ebp),%eax
  1041b7:	89 7c 24 08          	mov    %edi,0x8(%esp)
  1041bb:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1041bf:	89 04 24             	mov    %eax,(%esp)
  1041c2:	e8 d9 fb ff ff       	call   103da0 <memmove>

  readunlock(&p->common->pglock);
  1041c7:	8b 86 88 00 00 00    	mov    0x88(%esi),%eax
  1041cd:	83 c0 08             	add    $0x8,%eax
  1041d0:	89 04 24             	mov    %eax,(%esp)
  1041d3:	e8 f8 29 00 00       	call   106bd0 <readunlock>
  return sz;
  1041d8:	89 f8                	mov    %edi,%eax
  1041da:	eb cb                	jmp    1041a7 <fetchbuf+0x57>
  1041dc:	8d 74 26 00          	lea    0x0(%esi),%esi

001041e0 <fetchstr>:
  return 0;
}

int
fetchstr(struct proc *p, uint addr, char *dst, uint dsz)
{
  1041e0:	55                   	push   %ebp
  1041e1:	89 e5                	mov    %esp,%ebp
  1041e3:	57                   	push   %edi
  1041e4:	56                   	push   %esi
  1041e5:	53                   	push   %ebx
  1041e6:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  uint sz = 0;

  readlock(&p->common->pglock);
  1041e9:	8b 55 08             	mov    0x8(%ebp),%edx
  return 0;
}

int
fetchstr(struct proc *p, uint addr, char *dst, uint dsz)
{
  1041ec:	8b 7d 0c             	mov    0xc(%ebp),%edi
  1041ef:	8b 75 10             	mov    0x10(%ebp),%esi
  char *s;
  uint sz = 0;

  readlock(&p->common->pglock);
  1041f2:	8b 82 88 00 00 00    	mov    0x88(%edx),%eax
  1041f8:	83 c0 08             	add    $0x8,%eax
  1041fb:	89 04 24             	mov    %eax,(%esp)
  1041fe:	e8 bd 29 00 00       	call   106bc0 <readlock>

  if (addr >= p->common->sz)
  104203:	8b 55 08             	mov    0x8(%ebp),%edx
  104206:	8b 82 88 00 00 00    	mov    0x88(%edx),%eax
  10420c:	8b 00                	mov    (%eax),%eax
  10420e:	39 f8                	cmp    %edi,%eax
  104210:	76 58                	jbe    10426a <fetchstr+0x8a>
    goto error;

  for (s = (char *)addr; s < (char *)p->common->sz; s++) {
  104212:	39 c7                	cmp    %eax,%edi
  104214:	73 54                	jae    10426a <fetchstr+0x8a>
  104216:	31 c9                	xor    %ecx,%ecx
  104218:	eb 16                	jmp    104230 <fetchstr+0x50>
  10421a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104220:	8b 45 08             	mov    0x8(%ebp),%eax
  104223:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
  104229:	8d 04 0f             	lea    (%edi,%ecx,1),%eax
  10422c:	39 02                	cmp    %eax,(%edx)
  10422e:	76 3a                	jbe    10426a <fetchstr+0x8a>
    if (sz++ < dsz)
  104230:	83 c1 01             	add    $0x1,%ecx
  104233:	8d 59 ff             	lea    -0x1(%ecx),%ebx
  104236:	39 5d 14             	cmp    %ebx,0x14(%ebp)
  104239:	76 0a                	jbe    104245 <fetchstr+0x65>
      *(dst++) = *s;
  10423b:	0f b6 44 0f ff       	movzbl -0x1(%edi,%ecx,1),%eax
  104240:	88 06                	mov    %al,(%esi)
  104242:	83 c6 01             	add    $0x1,%esi
    if (*s == '\0') {
  104245:	80 7c 0f ff 00       	cmpb   $0x0,-0x1(%edi,%ecx,1)
  10424a:	75 d4                	jne    104220 <fetchstr+0x40>
        readunlock(&p->common->pglock);
  10424c:	8b 55 08             	mov    0x8(%ebp),%edx
  10424f:	8b 82 88 00 00 00    	mov    0x88(%edx),%eax
  104255:	83 c0 08             	add    $0x8,%eax
  104258:	89 04 24             	mov    %eax,(%esp)
  10425b:	e8 70 29 00 00       	call   106bd0 <readunlock>
  }

error:
  readunlock(&p->common->pglock);
  return -1;
}
  104260:	83 c4 0c             	add    $0xc,%esp
  for (s = (char *)addr; s < (char *)p->common->sz; s++) {
    if (sz++ < dsz)
      *(dst++) = *s;
    if (*s == '\0') {
        readunlock(&p->common->pglock);
        return sz - 1;
  104263:	89 d8                	mov    %ebx,%eax
  }

error:
  readunlock(&p->common->pglock);
  return -1;
}
  104265:	5b                   	pop    %ebx
  104266:	5e                   	pop    %esi
  104267:	5f                   	pop    %edi
  104268:	5d                   	pop    %ebp
  104269:	c3                   	ret    
        return sz - 1;
    }
  }

error:
  readunlock(&p->common->pglock);
  10426a:	8b 55 08             	mov    0x8(%ebp),%edx
  10426d:	8b 82 88 00 00 00    	mov    0x88(%edx),%eax
  104273:	83 c0 08             	add    $0x8,%eax
  104276:	89 04 24             	mov    %eax,(%esp)
  104279:	e8 52 29 00 00       	call   106bd0 <readunlock>
  return -1;
}
  10427e:	83 c4 0c             	add    $0xc,%esp
        return sz - 1;
    }
  }

error:
  readunlock(&p->common->pglock);
  104281:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return -1;
}
  104286:	5b                   	pop    %ebx
  104287:	5e                   	pop    %esi
  104288:	5f                   	pop    %edi
  104289:	5d                   	pop    %ebp
  10428a:	c3                   	ret    
  10428b:	90                   	nop    
  10428c:	8d 74 26 00          	lea    0x0(%esi),%esi

00104290 <fetchint>:
// library system call function. The saved user %esp points
// to a saved program counter, and then the first argument.

int
fetchint(struct proc *p, uint addr, int *ip)
{
  104290:	55                   	push   %ebp
  104291:	89 e5                	mov    %esp,%ebp
  104293:	83 ec 18             	sub    $0x18,%esp
  104296:	89 75 fc             	mov    %esi,-0x4(%ebp)
  104299:	8b 75 08             	mov    0x8(%ebp),%esi
  10429c:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  10429f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  readlock(&p->common->pglock);
  1042a2:	8b 86 88 00 00 00    	mov    0x88(%esi),%eax
  1042a8:	83 c0 08             	add    $0x8,%eax
  1042ab:	89 04 24             	mov    %eax,(%esp)
  1042ae:	e8 0d 29 00 00       	call   106bc0 <readlock>

  if (addr >= p->common->sz || addr+4 > p->common->sz) {
  1042b3:	8b 8e 88 00 00 00    	mov    0x88(%esi),%ecx
  1042b9:	8b 11                	mov    (%ecx),%edx
  1042bb:	39 da                	cmp    %ebx,%edx
  1042bd:	76 07                	jbe    1042c6 <fetchint+0x36>
  1042bf:	8d 43 04             	lea    0x4(%ebx),%eax
  1042c2:	39 c2                	cmp    %eax,%edx
  1042c4:	73 1a                	jae    1042e0 <fetchint+0x50>
    readunlock(&p->common->pglock);
  1042c6:	8d 41 08             	lea    0x8(%ecx),%eax
  1042c9:	89 04 24             	mov    %eax,(%esp)
  1042cc:	e8 ff 28 00 00       	call   106bd0 <readunlock>

  *ip = *(int*)(addr);

  readunlock(&p->common->pglock);
  return 0;
}
  1042d1:	8b 5d f8             	mov    -0x8(%ebp),%ebx
fetchint(struct proc *p, uint addr, int *ip)
{
  readlock(&p->common->pglock);

  if (addr >= p->common->sz || addr+4 > p->common->sz) {
    readunlock(&p->common->pglock);
  1042d4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax

  *ip = *(int*)(addr);

  readunlock(&p->common->pglock);
  return 0;
}
  1042d9:	8b 75 fc             	mov    -0x4(%ebp),%esi
  1042dc:	89 ec                	mov    %ebp,%esp
  1042de:	5d                   	pop    %ebp
  1042df:	c3                   	ret    
  if (addr >= p->common->sz || addr+4 > p->common->sz) {
    readunlock(&p->common->pglock);
    return -1;
  }

  *ip = *(int*)(addr);
  1042e0:	8b 03                	mov    (%ebx),%eax
  1042e2:	8b 55 10             	mov    0x10(%ebp),%edx
  1042e5:	89 02                	mov    %eax,(%edx)

  readunlock(&p->common->pglock);
  1042e7:	8b 86 88 00 00 00    	mov    0x88(%esi),%eax
  1042ed:	83 c0 08             	add    $0x8,%eax
  1042f0:	89 04 24             	mov    %eax,(%esp)
  1042f3:	e8 d8 28 00 00       	call   106bd0 <readunlock>
  return 0;
}
  1042f8:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    return -1;
  }

  *ip = *(int*)(addr);

  readunlock(&p->common->pglock);
  1042fb:	31 c0                	xor    %eax,%eax
  return 0;
}
  1042fd:	8b 75 fc             	mov    -0x4(%ebp),%esi
  104300:	89 ec                	mov    %ebp,%esp
  104302:	5d                   	pop    %ebp
  104303:	c3                   	ret    
  104304:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10430a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00104310 <argint>:

// LEGACY XV6 CODE BELOW

int
argint(int n, int *ip)
{
  104310:	55                   	push   %ebp
  104311:	89 e5                	mov    %esp,%ebp
  104313:	83 ec 18             	sub    $0x18,%esp
  return fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
  104316:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
  10431d:	8b 45 0c             	mov    0xc(%ebp),%eax
  104320:	89 44 24 08          	mov    %eax,0x8(%esp)
  104324:	8b 81 9c 00 00 00    	mov    0x9c(%ecx),%eax
  10432a:	8b 50 44             	mov    0x44(%eax),%edx
  10432d:	8b 45 08             	mov    0x8(%ebp),%eax
  104330:	89 0c 24             	mov    %ecx,(%esp)
  104333:	83 c2 04             	add    $0x4,%edx
  104336:	8d 04 82             	lea    (%edx,%eax,4),%eax
  104339:	89 44 24 04          	mov    %eax,0x4(%esp)
  10433d:	e8 4e ff ff ff       	call   104290 <fetchint>
}
  104342:	c9                   	leave  
  104343:	c3                   	ret    
  104344:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10434a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00104350 <argstr>:
  return -1;
}

int
argstr(int n, char **pp)
{
  104350:	55                   	push   %ebp
  104351:	89 e5                	mov    %esp,%ebp
  104353:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
  104356:	8d 45 fc             	lea    -0x4(%ebp),%eax
  104359:	89 44 24 04          	mov    %eax,0x4(%esp)
  10435d:	8b 45 08             	mov    0x8(%ebp),%eax
  104360:	89 04 24             	mov    %eax,(%esp)
  104363:	e8 a8 ff ff ff       	call   104310 <argint>
  104368:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  10436d:	85 c0                	test   %eax,%eax
  10436f:	78 1e                	js     10438f <argstr+0x3f>
    return -1;
  return fetchstr_legacy(proc, addr, pp);
  104371:	8b 45 0c             	mov    0xc(%ebp),%eax
  104374:	89 44 24 08          	mov    %eax,0x8(%esp)
  104378:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10437b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10437f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104385:	89 04 24             	mov    %eax,(%esp)
  104388:	e8 b3 fb ff ff       	call   103f40 <fetchstr_legacy>
  10438d:	89 c2                	mov    %eax,%edx
}
  10438f:	c9                   	leave  
  104390:	89 d0                	mov    %edx,%eax
  104392:	c3                   	ret    
  104393:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104399:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001043a0 <argptr>:
  return fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
}

int
argptr(int n, char **pp, int size)
{
  1043a0:	55                   	push   %ebp
  1043a1:	89 e5                	mov    %esp,%ebp
  1043a3:	83 ec 18             	sub    $0x18,%esp
  int i;
  
  if(argint(n, &i) < 0)
  1043a6:	8d 45 fc             	lea    -0x4(%ebp),%eax
  1043a9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1043ad:	8b 45 08             	mov    0x8(%ebp),%eax
  1043b0:	89 04 24             	mov    %eax,(%esp)
  1043b3:	e8 58 ff ff ff       	call   104310 <argint>
  1043b8:	85 c0                	test   %eax,%eax
  1043ba:	79 07                	jns    1043c3 <argptr+0x23>
    return -1;
  if((uint)i >= proc->common->sz || (uint)i+size >= proc->common->sz)
    return -1;
  *pp = (char *) i;
  return 0;
}
  1043bc:	c9                   	leave  
  if(argint(n, &i) < 0)
    return -1;
  if((uint)i >= proc->common->sz || (uint)i+size >= proc->common->sz)
    return -1;
  *pp = (char *) i;
  return 0;
  1043bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1043c2:	c3                   	ret    
{
  int i;
  
  if(argint(n, &i) < 0)
    return -1;
  if((uint)i >= proc->common->sz || (uint)i+size >= proc->common->sz)
  1043c3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1043c9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1043cc:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  1043d2:	8b 08                	mov    (%eax),%ecx
  1043d4:	39 ca                	cmp    %ecx,%edx
  1043d6:	73 e4                	jae    1043bc <argptr+0x1c>
  1043d8:	8b 45 10             	mov    0x10(%ebp),%eax
  1043db:	01 d0                	add    %edx,%eax
  1043dd:	39 c1                	cmp    %eax,%ecx
  1043df:	76 db                	jbe    1043bc <argptr+0x1c>
    return -1;
  *pp = (char *) i;
  1043e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1043e4:	89 10                	mov    %edx,(%eax)
  1043e6:	31 c0                	xor    %eax,%eax
  return 0;
}
  1043e8:	c9                   	leave  
  1043e9:	c3                   	ret    
  1043ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001043f0 <getuserint>:
  return writebuf(p, addr, src, strlen(src) + 1);
}

int
getuserint(int n, int *ip)
{
  1043f0:	55                   	push   %ebp
  1043f1:	89 e5                	mov    %esp,%ebp
  1043f3:	83 ec 18             	sub    $0x18,%esp
  return fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
  1043f6:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
  1043fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  104400:	89 44 24 08          	mov    %eax,0x8(%esp)
  104404:	8b 81 9c 00 00 00    	mov    0x9c(%ecx),%eax
  10440a:	8b 50 44             	mov    0x44(%eax),%edx
  10440d:	8b 45 08             	mov    0x8(%ebp),%eax
  104410:	89 0c 24             	mov    %ecx,(%esp)
  104413:	83 c2 04             	add    $0x4,%edx
  104416:	8d 04 82             	lea    (%edx,%eax,4),%eax
  104419:	89 44 24 04          	mov    %eax,0x4(%esp)
  10441d:	e8 6e fe ff ff       	call   104290 <fetchint>
}
  104422:	c9                   	leave  
  104423:	c3                   	ret    
  104424:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10442a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00104430 <putuserbuf>:
  return fetchstr(proc, (uint)i, dst, dsz);
}

int
putuserbuf(int n, void *src, int sz)
{
  104430:	55                   	push   %ebp
  104431:	89 e5                	mov    %esp,%ebp
  104433:	83 ec 28             	sub    $0x28,%esp
  int i;

  if (getuserint(n, &i) < 0)
  104436:	8d 45 fc             	lea    -0x4(%ebp),%eax
  104439:	89 44 24 04          	mov    %eax,0x4(%esp)
  10443d:	8b 45 08             	mov    0x8(%ebp),%eax
  104440:	89 04 24             	mov    %eax,(%esp)
  104443:	e8 a8 ff ff ff       	call   1043f0 <getuserint>
  104448:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  10444d:	85 c0                	test   %eax,%eax
  10444f:	78 25                	js     104476 <putuserbuf+0x46>
    return -1;
  return writebuf(proc, (uint)i, src, sz);
  104451:	8b 45 10             	mov    0x10(%ebp),%eax
  104454:	89 44 24 0c          	mov    %eax,0xc(%esp)
  104458:	8b 45 0c             	mov    0xc(%ebp),%eax
  10445b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10445f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  104462:	89 44 24 04          	mov    %eax,0x4(%esp)
  104466:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10446c:	89 04 24             	mov    %eax,(%esp)
  10446f:	e8 8c fb ff ff       	call   104000 <writebuf>
  104474:	89 c2                	mov    %eax,%edx
}
  104476:	c9                   	leave  
  104477:	89 d0                	mov    %edx,%eax
  104479:	c3                   	ret    
  10447a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104480 <getuserstr>:
  return fetchbuf(proc, (uint)i, dst, size);
}

int
getuserstr(int n, char *dst, int dsz)
{
  104480:	55                   	push   %ebp
  104481:	89 e5                	mov    %esp,%ebp
  104483:	83 ec 28             	sub    $0x28,%esp
  int i;

  if (getuserint(n, &i) < 0)
  104486:	8d 45 fc             	lea    -0x4(%ebp),%eax
  104489:	89 44 24 04          	mov    %eax,0x4(%esp)
  10448d:	8b 45 08             	mov    0x8(%ebp),%eax
  104490:	89 04 24             	mov    %eax,(%esp)
  104493:	e8 58 ff ff ff       	call   1043f0 <getuserint>
  104498:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  10449d:	85 c0                	test   %eax,%eax
  10449f:	78 25                	js     1044c6 <getuserstr+0x46>
    return -1;
  return fetchstr(proc, (uint)i, dst, dsz);
  1044a1:	8b 45 10             	mov    0x10(%ebp),%eax
  1044a4:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1044a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1044ab:	89 44 24 08          	mov    %eax,0x8(%esp)
  1044af:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1044b2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1044b6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1044bc:	89 04 24             	mov    %eax,(%esp)
  1044bf:	e8 1c fd ff ff       	call   1041e0 <fetchstr>
  1044c4:	89 c2                	mov    %eax,%edx
}
  1044c6:	c9                   	leave  
  1044c7:	89 d0                	mov    %edx,%eax
  1044c9:	c3                   	ret    
  1044ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001044d0 <getuserbuf>:
  return fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
}

int
getuserbuf(int n, void *dst, int size)
{
  1044d0:	55                   	push   %ebp
  1044d1:	89 e5                	mov    %esp,%ebp
  1044d3:	83 ec 28             	sub    $0x28,%esp
  int i;

  if (getuserint(n, &i) < 0)
  1044d6:	8d 45 fc             	lea    -0x4(%ebp),%eax
  1044d9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1044dd:	8b 45 08             	mov    0x8(%ebp),%eax
  1044e0:	89 04 24             	mov    %eax,(%esp)
  1044e3:	e8 08 ff ff ff       	call   1043f0 <getuserint>
  1044e8:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  1044ed:	85 c0                	test   %eax,%eax
  1044ef:	78 25                	js     104516 <getuserbuf+0x46>
    return -1;
  return fetchbuf(proc, (uint)i, dst, size);
  1044f1:	8b 45 10             	mov    0x10(%ebp),%eax
  1044f4:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1044f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1044fb:	89 44 24 08          	mov    %eax,0x8(%esp)
  1044ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  104502:	89 44 24 04          	mov    %eax,0x4(%esp)
  104506:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10450c:	89 04 24             	mov    %eax,(%esp)
  10450f:	e8 3c fc ff ff       	call   104150 <fetchbuf>
  104514:	89 c2                	mov    %eax,%edx
}
  104516:	c9                   	leave  
  104517:	89 d0                	mov    %edx,%eax
  104519:	c3                   	ret    
  10451a:	90                   	nop    
  10451b:	90                   	nop    
  10451c:	90                   	nop    
  10451d:	90                   	nop    
  10451e:	90                   	nop    
  10451f:	90                   	nop    

00104520 <putfd>:
  return 0;
}

static void
putfd(struct file *f)
{
  104520:	55                   	push   %ebp
  104521:	89 e5                	mov    %esp,%ebp
  104523:	83 ec 08             	sub    $0x8,%esp
  fileclose(f);
  104526:	89 04 24             	mov    %eax,(%esp)
  104529:	e8 b2 c9 ff ff       	call   100ee0 <fileclose>
}
  10452e:	c9                   	leave  
  10452f:	c3                   	ret    

00104530 <fdalloc>:

static int
fdalloc(struct file *f)
{
  104530:	55                   	push   %ebp
  104531:	89 e5                	mov    %esp,%ebp
  104533:	56                   	push   %esi
  104534:	89 c6                	mov    %eax,%esi
  104536:	53                   	push   %ebx
  int fd;

  acquire(&proc->common->lock);
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->common->ofile[fd] == 0){
  104537:	31 db                	xor    %ebx,%ebx
  fileclose(f);
}

static int
fdalloc(struct file *f)
{
  104539:	83 ec 10             	sub    $0x10,%esp
  int fd;

  acquire(&proc->common->lock);
  10453c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104542:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  104548:	83 c0 50             	add    $0x50,%eax
  10454b:	89 04 24             	mov    %eax,(%esp)
  10454e:	e8 3d f7 ff ff       	call   103c90 <acquire>
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->common->ofile[fd] == 0){
  104553:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104559:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  10455f:	90                   	nop    
  104560:	8b 54 98 08          	mov    0x8(%eax,%ebx,4),%edx
  104564:	85 d2                	test   %edx,%edx
  104566:	74 21                	je     104589 <fdalloc+0x59>
fdalloc(struct file *f)
{
  int fd;

  acquire(&proc->common->lock);
  for(fd = 0; fd < NOFILE; fd++){
  104568:	83 c3 01             	add    $0x1,%ebx
  10456b:	83 fb 10             	cmp    $0x10,%ebx
  10456e:	75 f0                	jne    104560 <fdalloc+0x30>
      proc->common->ofile[fd] = f;
      release(&proc->common->lock);
      return fd;
    }
  }
  release(&proc->common->lock);
  104570:	83 c0 50             	add    $0x50,%eax
  104573:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  104578:	89 04 24             	mov    %eax,(%esp)
  10457b:	e8 d0 f6 ff ff       	call   103c50 <release>
  return -1;
}
  104580:	83 c4 10             	add    $0x10,%esp
  104583:	89 d8                	mov    %ebx,%eax
  104585:	5b                   	pop    %ebx
  104586:	5e                   	pop    %esi
  104587:	5d                   	pop    %ebp
  104588:	c3                   	ret    
  int fd;

  acquire(&proc->common->lock);
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->common->ofile[fd] == 0){
      proc->common->ofile[fd] = f;
  104589:	89 74 98 08          	mov    %esi,0x8(%eax,%ebx,4)
      release(&proc->common->lock);
  10458d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104593:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  104599:	83 c0 50             	add    $0x50,%eax
  10459c:	89 04 24             	mov    %eax,(%esp)
  10459f:	e8 ac f6 ff ff       	call   103c50 <release>
      return fd;
    }
  }
  release(&proc->common->lock);
  return -1;
}
  1045a4:	83 c4 10             	add    $0x10,%esp
  1045a7:	89 d8                	mov    %ebx,%eax
  1045a9:	5b                   	pop    %ebx
  1045aa:	5e                   	pop    %esi
  1045ab:	5d                   	pop    %ebp
  1045ac:	c3                   	ret    
  1045ad:	8d 76 00             	lea    0x0(%esi),%esi

001045b0 <sys_pipe>:
  return exec(path, argv);
}

int
sys_pipe(void)
{
  1045b0:	55                   	push   %ebp
  1045b1:	89 e5                	mov    %esp,%ebp
  1045b3:	83 ec 28             	sub    $0x28,%esp
  struct file *rf, *wf;
  int fd[2];

  if (pipealloc(&rf, &wf) < 0)
  1045b6:	8d 45 f8             	lea    -0x8(%ebp),%eax
  1045b9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1045bd:	8d 45 fc             	lea    -0x4(%ebp),%eax
  1045c0:	89 04 24             	mov    %eax,(%esp)
  1045c3:	e8 88 e8 ff ff       	call   102e50 <pipealloc>
  1045c8:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  1045cd:	85 c0                	test   %eax,%eax
  1045cf:	78 3f                	js     104610 <sys_pipe+0x60>
    return -1;
  if ((fd[0] = fdalloc(rf)) < 0)
  1045d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1045d4:	e8 57 ff ff ff       	call   104530 <fdalloc>
  1045d9:	85 c0                	test   %eax,%eax
  1045db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1045de:	78 62                	js     104642 <sys_pipe+0x92>
    goto e_pa;
  if ((fd[1] = fdalloc(wf)) < 0)
  1045e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1045e3:	e8 48 ff ff ff       	call   104530 <fdalloc>
  1045e8:	85 c0                	test   %eax,%eax
  1045ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1045ed:	78 3c                	js     10462b <sys_pipe+0x7b>
    goto e_rf;
  if (putuserbuf(0, fd, sizeof(fd)) < 0)
  1045ef:	8d 45 f0             	lea    -0x10(%ebp),%eax
  1045f2:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
  1045f9:	00 
  1045fa:	89 44 24 04          	mov    %eax,0x4(%esp)
  1045fe:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104605:	e8 26 fe ff ff       	call   104430 <putuserbuf>
    goto e_wf;
  10460a:	31 d2                	xor    %edx,%edx
    return -1;
  if ((fd[0] = fdalloc(rf)) < 0)
    goto e_pa;
  if ((fd[1] = fdalloc(wf)) < 0)
    goto e_rf;
  if (putuserbuf(0, fd, sizeof(fd)) < 0)
  10460c:	85 c0                	test   %eax,%eax
  10460e:	78 04                	js     104614 <sys_pipe+0x64>
  proc->common->ofile[fd[0]] = 0;
e_pa:
  fileclose(rf);
  fileclose(wf);
  return -1;
}
  104610:	c9                   	leave  
  104611:	89 d0                	mov    %edx,%eax
  104613:	c3                   	ret    
    goto e_wf;

  return 0;

e_wf:
  proc->common->ofile[fd[1]] = 0;
  104614:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10461a:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
  104620:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104623:	c7 44 82 08 00 00 00 	movl   $0x0,0x8(%edx,%eax,4)
  10462a:	00 
e_rf:
  proc->common->ofile[fd[0]] = 0;
  10462b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104631:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
  104637:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10463a:	c7 44 82 08 00 00 00 	movl   $0x0,0x8(%edx,%eax,4)
  104641:	00 
e_pa:
  fileclose(rf);
  104642:	8b 45 fc             	mov    -0x4(%ebp),%eax
  104645:	89 04 24             	mov    %eax,(%esp)
  104648:	e8 93 c8 ff ff       	call   100ee0 <fileclose>
  fileclose(wf);
  10464d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  104650:	89 04 24             	mov    %eax,(%esp)
  104653:	e8 88 c8 ff ff       	call   100ee0 <fileclose>
  104658:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  return -1;
}
  10465d:	c9                   	leave  
  10465e:	89 d0                	mov    %edx,%eax
  104660:	c3                   	ret    
  104661:	eb 0d                	jmp    104670 <sys_exec>
  104663:	90                   	nop    
  104664:	90                   	nop    
  104665:	90                   	nop    
  104666:	90                   	nop    
  104667:	90                   	nop    
  104668:	90                   	nop    
  104669:	90                   	nop    
  10466a:	90                   	nop    
  10466b:	90                   	nop    
  10466c:	90                   	nop    
  10466d:	90                   	nop    
  10466e:	90                   	nop    
  10466f:	90                   	nop    

00104670 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
  104670:	55                   	push   %ebp
  104671:	89 e5                	mov    %esp,%ebp
  104673:	81 ec 08 01 00 00    	sub    $0x108,%esp
  104679:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  char path[MAXPATH], *argv[20];
  int i, len;
  uint uargv, uarg;

  if ((len = getuserstr(0, path, MAXPATH)) < 0 || len >= MAXPATH ||
  10467c:	8d 9d 1c ff ff ff    	lea    -0xe4(%ebp),%ebx
  return 0;
}

int
sys_exec(void)
{
  104682:	89 75 f8             	mov    %esi,-0x8(%ebp)
  104685:	89 7d fc             	mov    %edi,-0x4(%ebp)
  char path[MAXPATH], *argv[20];
  int i, len;
  uint uargv, uarg;

  if ((len = getuserstr(0, path, MAXPATH)) < 0 || len >= MAXPATH ||
  104688:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
  10468f:	00 
  104690:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  104694:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10469b:	e8 e0 fd ff ff       	call   104480 <getuserstr>
  1046a0:	85 c0                	test   %eax,%eax
  1046a2:	79 12                	jns    1046b6 <sys_exec+0x46>
      getuserint(1, (int *)&uargv) < 0)
    return -1;

  memset(argv, 0, sizeof(argv));
  for (i=0;; i++) {
    if (i >= NELEM(argv))
  1046a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    // Safe.. exec() prohibited in threaded processes
    if (fetchstr_legacy(proc, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
  1046a9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1046ac:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1046af:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1046b2:	89 ec                	mov    %ebp,%esp
  1046b4:	5d                   	pop    %ebp
  1046b5:	c3                   	ret    
{
  char path[MAXPATH], *argv[20];
  int i, len;
  uint uargv, uarg;

  if ((len = getuserstr(0, path, MAXPATH)) < 0 || len >= MAXPATH ||
  1046b6:	83 f8 7f             	cmp    $0x7f,%eax
  1046b9:	7f e9                	jg     1046a4 <sys_exec+0x34>
  1046bb:	8d 45 f0             	lea    -0x10(%ebp),%eax
  1046be:	89 44 24 04          	mov    %eax,0x4(%esp)
  1046c2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1046c9:	e8 22 fd ff ff       	call   1043f0 <getuserint>
  1046ce:	85 c0                	test   %eax,%eax
  1046d0:	78 d2                	js     1046a4 <sys_exec+0x34>
      getuserint(1, (int *)&uargv) < 0)
    return -1;

  memset(argv, 0, sizeof(argv));
  1046d2:	8d 7d 9c             	lea    -0x64(%ebp),%edi
  1046d5:	31 f6                	xor    %esi,%esi
  1046d7:	c7 44 24 08 50 00 00 	movl   $0x50,0x8(%esp)
  1046de:	00 
  1046df:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1046e6:	00 
  1046e7:	89 3c 24             	mov    %edi,(%esp)
  1046ea:	e8 11 f6 ff ff       	call   103d00 <memset>
  1046ef:	c7 85 10 ff ff ff 00 	movl   $0x0,-0xf0(%ebp)
  1046f6:	00 00 00 
  1046f9:	eb 3a                	jmp    104735 <sys_exec+0xc5>
  1046fb:	90                   	nop    
  1046fc:	8d 74 26 00          	lea    0x0(%esi),%esi
    if (uarg == 0) {
      argv[i] = 0;
      break;
    }
    // Safe.. exec() prohibited in threaded processes
    if (fetchstr_legacy(proc, uarg, &argv[i]) < 0)
  104700:	8b 8d 10 ff ff ff    	mov    -0xf0(%ebp),%ecx
  104706:	89 54 24 04          	mov    %edx,0x4(%esp)
  10470a:	8d 04 8f             	lea    (%edi,%ecx,4),%eax
  10470d:	89 44 24 08          	mov    %eax,0x8(%esp)
  104711:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104717:	89 04 24             	mov    %eax,(%esp)
  10471a:	e8 21 f8 ff ff       	call   103f40 <fetchstr_legacy>
  10471f:	85 c0                	test   %eax,%eax
  104721:	78 81                	js     1046a4 <sys_exec+0x34>
  if ((len = getuserstr(0, path, MAXPATH)) < 0 || len >= MAXPATH ||
      getuserint(1, (int *)&uargv) < 0)
    return -1;

  memset(argv, 0, sizeof(argv));
  for (i=0;; i++) {
  104723:	83 c6 01             	add    $0x1,%esi
    if (i >= NELEM(argv))
  104726:	83 fe 14             	cmp    $0x14,%esi
  if ((len = getuserstr(0, path, MAXPATH)) < 0 || len >= MAXPATH ||
      getuserint(1, (int *)&uargv) < 0)
    return -1;

  memset(argv, 0, sizeof(argv));
  for (i=0;; i++) {
  104729:	89 b5 10 ff ff ff    	mov    %esi,-0xf0(%ebp)
    if (i >= NELEM(argv))
  10472f:	0f 84 6f ff ff ff    	je     1046a4 <sys_exec+0x34>
      return -1;
    if (fetchint(proc, uargv+4*i, (int*)&uarg) < 0)
  104735:	8d 45 ec             	lea    -0x14(%ebp),%eax
  104738:	89 44 24 08          	mov    %eax,0x8(%esp)
  10473c:	8d 04 b5 00 00 00 00 	lea    0x0(,%esi,4),%eax
  104743:	03 45 f0             	add    -0x10(%ebp),%eax
  104746:	89 44 24 04          	mov    %eax,0x4(%esp)
  10474a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104750:	89 04 24             	mov    %eax,(%esp)
  104753:	e8 38 fb ff ff       	call   104290 <fetchint>
  104758:	85 c0                	test   %eax,%eax
  10475a:	0f 88 44 ff ff ff    	js     1046a4 <sys_exec+0x34>
      return -1;
    if (uarg == 0) {
  104760:	8b 55 ec             	mov    -0x14(%ebp),%edx
  104763:	85 d2                	test   %edx,%edx
  104765:	75 99                	jne    104700 <sys_exec+0x90>
      argv[i] = 0;
  104767:	c7 44 b5 9c 00 00 00 	movl   $0x0,-0x64(%ebp,%esi,4)
  10476e:	00 
    }
    // Safe.. exec() prohibited in threaded processes
    if (fetchstr_legacy(proc, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
  10476f:	89 7c 24 04          	mov    %edi,0x4(%esp)
  104773:	89 1c 24             	mov    %ebx,(%esp)
  104776:	e8 a5 c1 ff ff       	call   100920 <exec>
  10477b:	e9 29 ff ff ff       	jmp    1046a9 <sys_exec+0x39>

00104780 <sys_chdir>:
  return 0;
}

int
sys_chdir(void)
{
  104780:	55                   	push   %ebp
  104781:	89 e5                	mov    %esp,%ebp
  104783:	53                   	push   %ebx
  104784:	81 ec 94 00 00 00    	sub    $0x94,%esp
  char path[MAXPATH];
  struct inode *ip;
  int len;

  if ((len = getuserstr(0, path, MAXPATH)) < 0 || len >= MAXPATH ||
  10478a:	8d 9d 7c ff ff ff    	lea    -0x84(%ebp),%ebx
  104790:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
  104797:	00 
  104798:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  10479c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1047a3:	e8 d8 fc ff ff       	call   104480 <getuserstr>
  1047a8:	85 c0                	test   %eax,%eax
  1047aa:	79 14                	jns    1047c0 <sys_chdir+0x40>
  iunlock(ip);
  acquire(&proc->common->lock);
  iput(proc->common->cwd);
  proc->common->cwd = ip;
  release(&proc->common->lock);
  return 0;
  1047ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1047b1:	81 c4 94 00 00 00    	add    $0x94,%esp
  1047b7:	5b                   	pop    %ebx
  1047b8:	5d                   	pop    %ebp
  1047b9:	c3                   	ret    
  1047ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  char path[MAXPATH];
  struct inode *ip;
  int len;

  if ((len = getuserstr(0, path, MAXPATH)) < 0 || len >= MAXPATH ||
  1047c0:	83 f8 7f             	cmp    $0x7f,%eax
  1047c3:	7f e7                	jg     1047ac <sys_chdir+0x2c>
  1047c5:	89 1c 24             	mov    %ebx,(%esp)
  1047c8:	e8 b3 d5 ff ff       	call   101d80 <namei>
  1047cd:	85 c0                	test   %eax,%eax
  1047cf:	89 c3                	mov    %eax,%ebx
  1047d1:	74 d9                	je     1047ac <sys_chdir+0x2c>
      (ip = namei(path)) == 0)
    return -1;

  ilock(ip);
  1047d3:	89 04 24             	mov    %eax,(%esp)
  1047d6:	e8 05 d3 ff ff       	call   101ae0 <ilock>
  if(ip->type != T_DIR){
  1047db:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
  1047e0:	75 63                	jne    104845 <sys_chdir+0xc5>
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  1047e2:	89 1c 24             	mov    %ebx,(%esp)
  1047e5:	e8 d6 ce ff ff       	call   1016c0 <iunlock>
  acquire(&proc->common->lock);
  1047ea:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1047f0:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  1047f6:	83 c0 50             	add    $0x50,%eax
  1047f9:	89 04 24             	mov    %eax,(%esp)
  1047fc:	e8 8f f4 ff ff       	call   103c90 <acquire>
  iput(proc->common->cwd);
  104801:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104807:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  10480d:	8b 40 48             	mov    0x48(%eax),%eax
  104810:	89 04 24             	mov    %eax,(%esp)
  104813:	e8 78 d0 ff ff       	call   101890 <iput>
  proc->common->cwd = ip;
  104818:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10481e:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  104824:	89 58 48             	mov    %ebx,0x48(%eax)
  release(&proc->common->lock);
  104827:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10482d:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  104833:	83 c0 50             	add    $0x50,%eax
  104836:	89 04 24             	mov    %eax,(%esp)
  104839:	e8 12 f4 ff ff       	call   103c50 <release>
  10483e:	31 c0                	xor    %eax,%eax
  104840:	e9 6c ff ff ff       	jmp    1047b1 <sys_chdir+0x31>
      (ip = namei(path)) == 0)
    return -1;

  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
  104845:	89 1c 24             	mov    %ebx,(%esp)
  104848:	e8 73 d2 ff ff       	call   101ac0 <iunlockput>
  10484d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104852:	e9 5a ff ff ff       	jmp    1047b1 <sys_chdir+0x31>
  104857:	89 f6                	mov    %esi,%esi
  104859:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00104860 <create>:
  return 0;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
  104860:	55                   	push   %ebp
  104861:	89 e5                	mov    %esp,%ebp
  104863:	83 ec 48             	sub    $0x48,%esp
  104866:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  104869:	8b 4d 08             	mov    0x8(%ebp),%ecx
  10486c:	89 7d fc             	mov    %edi,-0x4(%ebp)
  10486f:	89 d7                	mov    %edx,%edi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  104871:	8d 55 e2             	lea    -0x1e(%ebp),%edx
  return 0;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
  104874:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  104877:	31 db                	xor    %ebx,%ebx
  return 0;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
  104879:	89 75 f8             	mov    %esi,-0x8(%ebp)
  10487c:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  10487f:	89 54 24 04          	mov    %edx,0x4(%esp)
  104883:	89 04 24             	mov    %eax,(%esp)
  104886:	e8 d5 d4 ff ff       	call   101d60 <nameiparent>
  10488b:	85 c0                	test   %eax,%eax
  10488d:	89 c6                	mov    %eax,%esi
  10488f:	74 4b                	je     1048dc <create+0x7c>
    return 0;
  ilock(dp);
  104891:	89 04 24             	mov    %eax,(%esp)
  104894:	e8 47 d2 ff ff       	call   101ae0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
  104899:	8d 45 f0             	lea    -0x10(%ebp),%eax
  10489c:	8d 4d e2             	lea    -0x1e(%ebp),%ecx
  10489f:	89 44 24 08          	mov    %eax,0x8(%esp)
  1048a3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  1048a7:	89 34 24             	mov    %esi,(%esp)
  1048aa:	e8 11 cd ff ff       	call   1015c0 <dirlookup>
  1048af:	85 c0                	test   %eax,%eax
  1048b1:	89 c3                	mov    %eax,%ebx
  1048b3:	74 3b                	je     1048f0 <create+0x90>
    iunlockput(dp);
  1048b5:	89 34 24             	mov    %esi,(%esp)
  1048b8:	e8 03 d2 ff ff       	call   101ac0 <iunlockput>
    ilock(ip);
  1048bd:	89 1c 24             	mov    %ebx,(%esp)
  1048c0:	e8 1b d2 ff ff       	call   101ae0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
  1048c5:	66 83 ff 02          	cmp    $0x2,%di
  1048c9:	75 07                	jne    1048d2 <create+0x72>
  1048cb:	66 83 7b 10 02       	cmpw   $0x2,0x10(%ebx)
  1048d0:	74 0a                	je     1048dc <create+0x7c>
      return ip;
    iunlockput(ip);
  1048d2:	89 1c 24             	mov    %ebx,(%esp)
  1048d5:	31 db                	xor    %ebx,%ebx
  1048d7:	e8 e4 d1 ff ff       	call   101ac0 <iunlockput>
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);
  return ip;
}
  1048dc:	89 d8                	mov    %ebx,%eax
  1048de:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1048e1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1048e4:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1048e7:	89 ec                	mov    %ebp,%esp
  1048e9:	5d                   	pop    %ebp
  1048ea:	c3                   	ret    
  1048eb:	90                   	nop    
  1048ec:	8d 74 26 00          	lea    0x0(%esi),%esi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
  1048f0:	0f bf c7             	movswl %di,%eax
  1048f3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1048f7:	8b 06                	mov    (%esi),%eax
  1048f9:	89 04 24             	mov    %eax,(%esp)
  1048fc:	e8 0f ce ff ff       	call   101710 <ialloc>
  104901:	85 c0                	test   %eax,%eax
  104903:	89 c3                	mov    %eax,%ebx
  104905:	0f 84 9f 00 00 00    	je     1049aa <create+0x14a>
    panic("create: ialloc");

  ilock(ip);
  10490b:	89 04 24             	mov    %eax,(%esp)
  10490e:	e8 cd d1 ff ff       	call   101ae0 <ilock>
  ip->major = major;
  104913:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
  104917:	66 89 43 12          	mov    %ax,0x12(%ebx)
  ip->minor = minor;
  10491b:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
  ip->nlink = 1;
  10491f:	66 c7 43 16 01 00    	movw   $0x1,0x16(%ebx)
  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");

  ilock(ip);
  ip->major = major;
  ip->minor = minor;
  104925:	66 89 53 14          	mov    %dx,0x14(%ebx)
  ip->nlink = 1;
  iupdate(ip);
  104929:	89 1c 24             	mov    %ebx,(%esp)
  10492c:	e8 ff c7 ff ff       	call   101130 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
  104931:	66 83 ef 01          	sub    $0x1,%di
  104935:	74 24                	je     10495b <create+0xfb>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
  104937:	8b 43 04             	mov    0x4(%ebx),%eax
  10493a:	8d 4d e2             	lea    -0x1e(%ebp),%ecx
  10493d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  104941:	89 34 24             	mov    %esi,(%esp)
  104944:	89 44 24 08          	mov    %eax,0x8(%esp)
  104948:	e8 83 d0 ff ff       	call   1019d0 <dirlink>
  10494d:	85 c0                	test   %eax,%eax
  10494f:	78 65                	js     1049b6 <create+0x156>
    panic("create: dirlink");

  iunlockput(dp);
  104951:	89 34 24             	mov    %esi,(%esp)
  104954:	e8 67 d1 ff ff       	call   101ac0 <iunlockput>
  104959:	eb 81                	jmp    1048dc <create+0x7c>
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
  10495b:	66 83 46 16 01       	addw   $0x1,0x16(%esi)
    iupdate(dp);
  104960:	89 34 24             	mov    %esi,(%esp)
  104963:	e8 c8 c7 ff ff       	call   101130 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
  104968:	8b 43 04             	mov    0x4(%ebx),%eax
  10496b:	c7 44 24 04 3c 73 10 	movl   $0x10733c,0x4(%esp)
  104972:	00 
  104973:	89 1c 24             	mov    %ebx,(%esp)
  104976:	89 44 24 08          	mov    %eax,0x8(%esp)
  10497a:	e8 51 d0 ff ff       	call   1019d0 <dirlink>
  10497f:	85 c0                	test   %eax,%eax
  104981:	78 1b                	js     10499e <create+0x13e>
  104983:	8b 46 04             	mov    0x4(%esi),%eax
  104986:	c7 44 24 04 3b 73 10 	movl   $0x10733b,0x4(%esp)
  10498d:	00 
  10498e:	89 1c 24             	mov    %ebx,(%esp)
  104991:	89 44 24 08          	mov    %eax,0x8(%esp)
  104995:	e8 36 d0 ff ff       	call   1019d0 <dirlink>
  10499a:	85 c0                	test   %eax,%eax
  10499c:	79 99                	jns    104937 <create+0xd7>
      panic("create dots");
  10499e:	c7 04 24 3e 73 10 00 	movl   $0x10733e,(%esp)
  1049a5:	e8 d6 be ff ff       	call   100880 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
  1049aa:	c7 04 24 2c 73 10 00 	movl   $0x10732c,(%esp)
  1049b1:	e8 ca be ff ff       	call   100880 <panic>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
  1049b6:	c7 04 24 4a 73 10 00 	movl   $0x10734a,(%esp)
  1049bd:	e8 be be ff ff       	call   100880 <panic>
  1049c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  1049c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001049d0 <sys_mknod>:
  return 0;
}

int
sys_mknod(void)
{
  1049d0:	55                   	push   %ebp
  1049d1:	89 e5                	mov    %esp,%ebp
  1049d3:	53                   	push   %ebx
  1049d4:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  struct inode *ip;
  char path[MAXPATH];
  int len;
  int major, minor;
  
  if((len=getuserstr(0, path, MAXPATH)) < 0 || len >= MAXPATH ||
  1049da:	8d 9d 74 ff ff ff    	lea    -0x8c(%ebp),%ebx
  1049e0:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
  1049e7:	00 
  1049e8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1049ec:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1049f3:	e8 88 fa ff ff       	call   104480 <getuserstr>
  1049f8:	85 c0                	test   %eax,%eax
  1049fa:	79 14                	jns    104a10 <sys_mknod+0x40>
     getuserint(1, &major) < 0 || getuserint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0)
    return -1;

  iunlockput(ip);
  return 0;
  1049fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104a01:	81 c4 a4 00 00 00    	add    $0xa4,%esp
  104a07:	5b                   	pop    %ebx
  104a08:	5d                   	pop    %ebp
  104a09:	c3                   	ret    
  104a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  struct inode *ip;
  char path[MAXPATH];
  int len;
  int major, minor;
  
  if((len=getuserstr(0, path, MAXPATH)) < 0 || len >= MAXPATH ||
  104a10:	83 f8 7f             	cmp    $0x7f,%eax
  104a13:	7f e7                	jg     1049fc <sys_mknod+0x2c>
  104a15:	8d 45 f8             	lea    -0x8(%ebp),%eax
  104a18:	89 44 24 04          	mov    %eax,0x4(%esp)
  104a1c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104a23:	e8 c8 f9 ff ff       	call   1043f0 <getuserint>
  104a28:	85 c0                	test   %eax,%eax
  104a2a:	78 d0                	js     1049fc <sys_mknod+0x2c>
  104a2c:	8d 45 f4             	lea    -0xc(%ebp),%eax
  104a2f:	89 44 24 04          	mov    %eax,0x4(%esp)
  104a33:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  104a3a:	e8 b1 f9 ff ff       	call   1043f0 <getuserint>
  104a3f:	85 c0                	test   %eax,%eax
  104a41:	78 b9                	js     1049fc <sys_mknod+0x2c>
  104a43:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
  104a47:	ba 03 00 00 00       	mov    $0x3,%edx
  104a4c:	0f bf 4d f8          	movswl -0x8(%ebp),%ecx
  104a50:	89 04 24             	mov    %eax,(%esp)
  104a53:	89 d8                	mov    %ebx,%eax
  104a55:	e8 06 fe ff ff       	call   104860 <create>
  104a5a:	85 c0                	test   %eax,%eax
  104a5c:	74 9e                	je     1049fc <sys_mknod+0x2c>
     getuserint(1, &major) < 0 || getuserint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0)
    return -1;

  iunlockput(ip);
  104a5e:	89 04 24             	mov    %eax,(%esp)
  104a61:	e8 5a d0 ff ff       	call   101ac0 <iunlockput>
  104a66:	31 c0                	xor    %eax,%eax
  104a68:	eb 97                	jmp    104a01 <sys_mknod+0x31>
  104a6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104a70 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
  104a70:	55                   	push   %ebp
  104a71:	89 e5                	mov    %esp,%ebp
  104a73:	53                   	push   %ebx
  104a74:	81 ec 94 00 00 00    	sub    $0x94,%esp
  char path[MAXPATH];
  struct inode *ip;
  int len;

  if((len = getuserstr(0, path, MAXPATH)) < 0 || len >= MAXPATH ||
  104a7a:	8d 9d 7c ff ff ff    	lea    -0x84(%ebp),%ebx
  104a80:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
  104a87:	00 
  104a88:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  104a8c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104a93:	e8 e8 f9 ff ff       	call   104480 <getuserstr>
  104a98:	85 c0                	test   %eax,%eax
  104a9a:	79 14                	jns    104ab0 <sys_mkdir+0x40>
     (ip = create(path, T_DIR, 0, 0)) == 0)
    return -1;

  iunlockput(ip);

  return 0;
  104a9c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104aa1:	81 c4 94 00 00 00    	add    $0x94,%esp
  104aa7:	5b                   	pop    %ebx
  104aa8:	5d                   	pop    %ebp
  104aa9:	c3                   	ret    
  104aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  char path[MAXPATH];
  struct inode *ip;
  int len;

  if((len = getuserstr(0, path, MAXPATH)) < 0 || len >= MAXPATH ||
  104ab0:	83 f8 7f             	cmp    $0x7f,%eax
  104ab3:	7f e7                	jg     104a9c <sys_mkdir+0x2c>
  104ab5:	31 c9                	xor    %ecx,%ecx
  104ab7:	ba 01 00 00 00       	mov    $0x1,%edx
  104abc:	89 d8                	mov    %ebx,%eax
  104abe:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104ac5:	e8 96 fd ff ff       	call   104860 <create>
  104aca:	85 c0                	test   %eax,%eax
  104acc:	74 ce                	je     104a9c <sys_mkdir+0x2c>
     (ip = create(path, T_DIR, 0, 0)) == 0)
    return -1;

  iunlockput(ip);
  104ace:	89 04 24             	mov    %eax,(%esp)
  104ad1:	e8 ea cf ff ff       	call   101ac0 <iunlockput>
  104ad6:	31 c0                	xor    %eax,%eax
  104ad8:	eb c7                	jmp    104aa1 <sys_mkdir+0x31>
  104ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104ae0 <sys_link>:
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  104ae0:	55                   	push   %ebp
  104ae1:	89 e5                	mov    %esp,%ebp
  104ae3:	81 ec 28 01 00 00    	sub    $0x128,%esp
  104ae9:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  char name[DIRSIZ], new[MAXPATH], old[MAXPATH];
  struct inode *dp, *ip;
  int str;

  if ((str = getuserstr(0, old, MAXPATH)) < 0 || str >= MAXPATH ||
  104aec:	8d 9d e6 fe ff ff    	lea    -0x11a(%ebp),%ebx
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  104af2:	89 75 f8             	mov    %esi,-0x8(%ebp)
  104af5:	89 7d fc             	mov    %edi,-0x4(%ebp)
  char name[DIRSIZ], new[MAXPATH], old[MAXPATH];
  struct inode *dp, *ip;
  int str;

  if ((str = getuserstr(0, old, MAXPATH)) < 0 || str >= MAXPATH ||
  104af8:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
  104aff:	00 
  104b00:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  104b04:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104b0b:	e8 70 f9 ff ff       	call   104480 <getuserstr>
  104b10:	85 c0                	test   %eax,%eax
  104b12:	79 12                	jns    104b26 <sys_link+0x46>
bad:
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return -1;
  104b14:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104b19:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  104b1c:	8b 75 f8             	mov    -0x8(%ebp),%esi
  104b1f:	8b 7d fc             	mov    -0x4(%ebp),%edi
  104b22:	89 ec                	mov    %ebp,%esp
  104b24:	5d                   	pop    %ebp
  104b25:	c3                   	ret    
{
  char name[DIRSIZ], new[MAXPATH], old[MAXPATH];
  struct inode *dp, *ip;
  int str;

  if ((str = getuserstr(0, old, MAXPATH)) < 0 || str >= MAXPATH ||
  104b26:	83 f8 7f             	cmp    $0x7f,%eax
  104b29:	7f e9                	jg     104b14 <sys_link+0x34>
  104b2b:	8d b5 66 ff ff ff    	lea    -0x9a(%ebp),%esi
  104b31:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
  104b38:	00 
  104b39:	89 74 24 04          	mov    %esi,0x4(%esp)
  104b3d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104b44:	e8 37 f9 ff ff       	call   104480 <getuserstr>
  104b49:	85 c0                	test   %eax,%eax
  104b4b:	78 c7                	js     104b14 <sys_link+0x34>
  104b4d:	83 f8 7f             	cmp    $0x7f,%eax
  104b50:	7f c2                	jg     104b14 <sys_link+0x34>
  104b52:	89 1c 24             	mov    %ebx,(%esp)
  104b55:	e8 26 d2 ff ff       	call   101d80 <namei>
  104b5a:	85 c0                	test   %eax,%eax
  104b5c:	89 c3                	mov    %eax,%ebx
  104b5e:	74 b4                	je     104b14 <sys_link+0x34>
      (str = getuserstr(1, new, MAXPATH)) < 0 || str >= MAXPATH ||
      (ip = namei(old)) == 0)
    return -1;

  ilock(ip);
  104b60:	89 04 24             	mov    %eax,(%esp)
  104b63:	e8 78 cf ff ff       	call   101ae0 <ilock>
  if(ip->type == T_DIR){
  104b68:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
  104b6d:	74 55                	je     104bc4 <sys_link+0xe4>
    iunlockput(ip);
    return -1;
  }
  ip->nlink++;
  104b6f:	66 83 43 16 01       	addw   $0x1,0x16(%ebx)
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
  104b74:	8d 7d e6             	lea    -0x1a(%ebp),%edi
  if(ip->type == T_DIR){
    iunlockput(ip);
    return -1;
  }
  ip->nlink++;
  iupdate(ip);
  104b77:	89 1c 24             	mov    %ebx,(%esp)
  104b7a:	e8 b1 c5 ff ff       	call   101130 <iupdate>
  iunlock(ip);
  104b7f:	89 1c 24             	mov    %ebx,(%esp)
  104b82:	e8 39 cb ff ff       	call   1016c0 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
  104b87:	89 34 24             	mov    %esi,(%esp)
  104b8a:	89 7c 24 04          	mov    %edi,0x4(%esp)
  104b8e:	e8 cd d1 ff ff       	call   101d60 <nameiparent>
  104b93:	85 c0                	test   %eax,%eax
  104b95:	89 c6                	mov    %eax,%esi
  104b97:	74 16                	je     104baf <sys_link+0xcf>
    goto bad;
  ilock(dp);
  104b99:	89 04 24             	mov    %eax,(%esp)
  104b9c:	e8 3f cf ff ff       	call   101ae0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
  104ba1:	8b 06                	mov    (%esi),%eax
  104ba3:	3b 03                	cmp    (%ebx),%eax
  104ba5:	74 2f                	je     104bd6 <sys_link+0xf6>
    iunlockput(dp);
  104ba7:	89 34 24             	mov    %esi,(%esp)
  104baa:	e8 11 cf ff ff       	call   101ac0 <iunlockput>
  iput(ip);

  return 0;

bad:
  ilock(ip);
  104baf:	89 1c 24             	mov    %ebx,(%esp)
  104bb2:	e8 29 cf ff ff       	call   101ae0 <ilock>
  ip->nlink--;
  104bb7:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  iupdate(ip);
  104bbc:	89 1c 24             	mov    %ebx,(%esp)
  104bbf:	e8 6c c5 ff ff       	call   101130 <iupdate>
  iunlockput(ip);
  104bc4:	89 1c 24             	mov    %ebx,(%esp)
  104bc7:	e8 f4 ce ff ff       	call   101ac0 <iunlockput>
  104bcc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104bd1:	e9 43 ff ff ff       	jmp    104b19 <sys_link+0x39>
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
  104bd6:	8b 43 04             	mov    0x4(%ebx),%eax
  104bd9:	89 7c 24 04          	mov    %edi,0x4(%esp)
  104bdd:	89 34 24             	mov    %esi,(%esp)
  104be0:	89 44 24 08          	mov    %eax,0x8(%esp)
  104be4:	e8 e7 cd ff ff       	call   1019d0 <dirlink>
  104be9:	85 c0                	test   %eax,%eax
  104beb:	78 ba                	js     104ba7 <sys_link+0xc7>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
  104bed:	89 34 24             	mov    %esi,(%esp)
  104bf0:	e8 cb ce ff ff       	call   101ac0 <iunlockput>
  iput(ip);
  104bf5:	89 1c 24             	mov    %ebx,(%esp)
  104bf8:	e8 93 cc ff ff       	call   101890 <iput>
  104bfd:	31 c0                	xor    %eax,%eax
  104bff:	e9 15 ff ff ff       	jmp    104b19 <sys_link+0x39>
  104c04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104c0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00104c10 <sys_open>:
  return ip;
}

int
sys_open(void)
{
  104c10:	55                   	push   %ebp
  104c11:	89 e5                	mov    %esp,%ebp
  104c13:	81 ec a8 00 00 00    	sub    $0xa8,%esp
  104c19:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  char path[MAXPATH];
  int fd, omode, len;
  struct file *f;
  struct inode *ip;

  if ((len = getuserstr(0, path, MAXPATH)) < 0 || len >= MAXPATH ||
  104c1c:	8d 9d 70 ff ff ff    	lea    -0x90(%ebp),%ebx
  return ip;
}

int
sys_open(void)
{
  104c22:	89 75 f8             	mov    %esi,-0x8(%ebp)
  104c25:	89 7d fc             	mov    %edi,-0x4(%ebp)
  char path[MAXPATH];
  int fd, omode, len;
  struct file *f;
  struct inode *ip;

  if ((len = getuserstr(0, path, MAXPATH)) < 0 || len >= MAXPATH ||
  104c28:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
  104c2f:	00 
  104c30:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  104c34:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104c3b:	e8 40 f8 ff ff       	call   104480 <getuserstr>
  104c40:	85 c0                	test   %eax,%eax
  104c42:	79 14                	jns    104c58 <sys_open+0x48>
  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
  104c44:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
  104c49:	89 d8                	mov    %ebx,%eax
  104c4b:	8b 75 f8             	mov    -0x8(%ebp),%esi
  104c4e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  104c51:	8b 7d fc             	mov    -0x4(%ebp),%edi
  104c54:	89 ec                	mov    %ebp,%esp
  104c56:	5d                   	pop    %ebp
  104c57:	c3                   	ret    
  char path[MAXPATH];
  int fd, omode, len;
  struct file *f;
  struct inode *ip;

  if ((len = getuserstr(0, path, MAXPATH)) < 0 || len >= MAXPATH ||
  104c58:	83 f8 7f             	cmp    $0x7f,%eax
  104c5b:	7f e7                	jg     104c44 <sys_open+0x34>
  104c5d:	8d 45 f0             	lea    -0x10(%ebp),%eax
  104c60:	89 44 24 04          	mov    %eax,0x4(%esp)
  104c64:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104c6b:	e8 80 f7 ff ff       	call   1043f0 <getuserint>
  104c70:	85 c0                	test   %eax,%eax
  104c72:	78 d0                	js     104c44 <sys_open+0x34>
      getuserint(1, &omode) < 0)
    return -1;

  if(omode & O_CREATE){
  104c74:	f6 45 f1 02          	testb  $0x2,-0xf(%ebp)
  104c78:	74 62                	je     104cdc <sys_open+0xcc>
    if((ip = create(path, T_FILE, 0, 0)) == 0)
  104c7a:	31 c9                	xor    %ecx,%ecx
  104c7c:	ba 02 00 00 00       	mov    $0x2,%edx
  104c81:	89 d8                	mov    %ebx,%eax
  104c83:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104c8a:	e8 d1 fb ff ff       	call   104860 <create>
  104c8f:	85 c0                	test   %eax,%eax
  104c91:	89 c7                	mov    %eax,%edi
  104c93:	74 af                	je     104c44 <sys_open+0x34>
      iunlockput(ip);
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
  104c95:	e8 d6 c1 ff ff       	call   100e70 <filealloc>
  104c9a:	85 c0                	test   %eax,%eax
  104c9c:	89 c6                	mov    %eax,%esi
  104c9e:	74 64                	je     104d04 <sys_open+0xf4>
  104ca0:	e8 8b f8 ff ff       	call   104530 <fdalloc>
  104ca5:	85 c0                	test   %eax,%eax
  104ca7:	89 c3                	mov    %eax,%ebx
  104ca9:	78 6b                	js     104d16 <sys_open+0x106>
    if(f)
      fileclose(f);
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  104cab:	89 3c 24             	mov    %edi,(%esp)
  104cae:	e8 0d ca ff ff       	call   1016c0 <iunlock>

  f->type = FD_INODE;
  104cb3:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f->ip = ip;
  104cb9:	89 7e 10             	mov    %edi,0x10(%esi)
  f->off = 0;
  104cbc:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
  104cc3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104cc6:	83 f0 01             	xor    $0x1,%eax
  104cc9:	83 e0 01             	and    $0x1,%eax
  104ccc:	88 46 08             	mov    %al,0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  104ccf:	f6 45 f0 03          	testb  $0x3,-0x10(%ebp)
  104cd3:	0f 95 46 09          	setne  0x9(%esi)
  104cd7:	e9 6d ff ff ff       	jmp    104c49 <sys_open+0x39>

  if(omode & O_CREATE){
    if((ip = create(path, T_FILE, 0, 0)) == 0)
      return -1;
  } else {
    if((ip = namei(path)) == 0)
  104cdc:	89 1c 24             	mov    %ebx,(%esp)
  104cdf:	e8 9c d0 ff ff       	call   101d80 <namei>
  104ce4:	85 c0                	test   %eax,%eax
  104ce6:	89 c7                	mov    %eax,%edi
  104ce8:	0f 84 56 ff ff ff    	je     104c44 <sys_open+0x34>
      return -1;
    ilock(ip);
  104cee:	89 04 24             	mov    %eax,(%esp)
  104cf1:	e8 ea cd ff ff       	call   101ae0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
  104cf6:	66 83 7f 10 01       	cmpw   $0x1,0x10(%edi)
  104cfb:	75 98                	jne    104c95 <sys_open+0x85>
  104cfd:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  104d00:	85 c9                	test   %ecx,%ecx
  104d02:	74 91                	je     104c95 <sys_open+0x85>
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
  104d04:	89 3c 24             	mov    %edi,(%esp)
  104d07:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  104d0c:	e8 af cd ff ff       	call   101ac0 <iunlockput>
  104d11:	e9 33 ff ff ff       	jmp    104c49 <sys_open+0x39>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
  104d16:	89 34 24             	mov    %esi,(%esp)
  104d19:	e8 c2 c1 ff ff       	call   100ee0 <fileclose>
  104d1e:	66 90                	xchg   %ax,%ax
  104d20:	eb e2                	jmp    104d04 <sys_open+0xf4>
  104d22:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  104d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00104d30 <sys_unlink>:
  return 1;
}

int
sys_unlink(void)
{
  104d30:	55                   	push   %ebp
  104d31:	89 e5                	mov    %esp,%ebp
  104d33:	81 ec e8 00 00 00    	sub    $0xe8,%esp
  104d39:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  struct dirent de;
  char name[DIRSIZ], path[MAXPATH];
  uint off;
  int str;

  if ((str = getuserstr(0, path, MAXPATH)) < 0 || str >= MAXPATH ||
  104d3c:	8d 9d 42 ff ff ff    	lea    -0xbe(%ebp),%ebx
  return 1;
}

int
sys_unlink(void)
{
  104d42:	89 75 f8             	mov    %esi,-0x8(%ebp)
  104d45:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct dirent de;
  char name[DIRSIZ], path[MAXPATH];
  uint off;
  int str;

  if ((str = getuserstr(0, path, MAXPATH)) < 0 || str >= MAXPATH ||
  104d48:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
  104d4f:	00 
  104d50:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  104d54:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104d5b:	e8 20 f7 ff ff       	call   104480 <getuserstr>
  104d60:	85 c0                	test   %eax,%eax
  104d62:	79 12                	jns    104d76 <sys_unlink+0x46>
  iunlockput(dp);

  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return 0;
  104d64:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104d69:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  104d6c:	8b 75 f8             	mov    -0x8(%ebp),%esi
  104d6f:	8b 7d fc             	mov    -0x4(%ebp),%edi
  104d72:	89 ec                	mov    %ebp,%esp
  104d74:	5d                   	pop    %ebp
  104d75:	c3                   	ret    
  struct dirent de;
  char name[DIRSIZ], path[MAXPATH];
  uint off;
  int str;

  if ((str = getuserstr(0, path, MAXPATH)) < 0 || str >= MAXPATH ||
  104d76:	83 f8 7f             	cmp    $0x7f,%eax
  104d79:	7f e9                	jg     104d64 <sys_unlink+0x34>
  104d7b:	8d 75 e2             	lea    -0x1e(%ebp),%esi
  104d7e:	89 74 24 04          	mov    %esi,0x4(%esp)
  104d82:	89 1c 24             	mov    %ebx,(%esp)
  104d85:	e8 d6 cf ff ff       	call   101d60 <nameiparent>
  104d8a:	85 c0                	test   %eax,%eax
  104d8c:	89 c7                	mov    %eax,%edi
  104d8e:	74 d4                	je     104d64 <sys_unlink+0x34>
      (dp = nameiparent(path, name)) == 0)
    return -1;

  ilock(dp);
  104d90:	89 04 24             	mov    %eax,(%esp)
  104d93:	e8 48 cd ff ff       	call   101ae0 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0){
  104d98:	c7 44 24 04 3c 73 10 	movl   $0x10733c,0x4(%esp)
  104d9f:	00 
  104da0:	89 34 24             	mov    %esi,(%esp)
  104da3:	e8 e8 c7 ff ff       	call   101590 <namecmp>
  104da8:	85 c0                	test   %eax,%eax
  104daa:	74 14                	je     104dc0 <sys_unlink+0x90>
  104dac:	c7 44 24 04 3b 73 10 	movl   $0x10733b,0x4(%esp)
  104db3:	00 
  104db4:	89 34 24             	mov    %esi,(%esp)
  104db7:	e8 d4 c7 ff ff       	call   101590 <namecmp>
  104dbc:	85 c0                	test   %eax,%eax
  104dbe:	75 0f                	jne    104dcf <sys_unlink+0x9f>

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
    iunlockput(dp);
  104dc0:	89 3c 24             	mov    %edi,(%esp)
  104dc3:	e8 f8 cc ff ff       	call   101ac0 <iunlockput>
  104dc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104dcd:	eb 9a                	jmp    104d69 <sys_unlink+0x39>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0){
    iunlockput(dp);
    return -1;
  }

  if((ip = dirlookup(dp, name, &off)) == 0){
  104dcf:	8d 45 f0             	lea    -0x10(%ebp),%eax
  104dd2:	89 74 24 04          	mov    %esi,0x4(%esp)
  104dd6:	89 44 24 08          	mov    %eax,0x8(%esp)
  104dda:	89 3c 24             	mov    %edi,(%esp)
  104ddd:	e8 de c7 ff ff       	call   1015c0 <dirlookup>
  104de2:	85 c0                	test   %eax,%eax
  104de4:	89 c6                	mov    %eax,%esi
  104de6:	74 d8                	je     104dc0 <sys_unlink+0x90>
    iunlockput(dp);
    return -1;
  }
  ilock(ip);
  104de8:	89 04 24             	mov    %eax,(%esp)
  104deb:	e8 f0 cc ff ff       	call   101ae0 <ilock>

  if(ip->nlink < 1)
  104df0:	66 83 7e 16 00       	cmpw   $0x0,0x16(%esi)
  104df5:	0f 8e e7 00 00 00    	jle    104ee2 <sys_unlink+0x1b2>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
  104dfb:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
  104e00:	75 53                	jne    104e55 <sys_unlink+0x125>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
  104e02:	83 7e 18 20          	cmpl   $0x20,0x18(%esi)
  104e06:	76 4d                	jbe    104e55 <sys_unlink+0x125>
  104e08:	bb 20 00 00 00       	mov    $0x20,%ebx
  104e0d:	8d 76 00             	lea    0x0(%esi),%esi
  104e10:	eb 08                	jmp    104e1a <sys_unlink+0xea>
  104e12:	83 c3 10             	add    $0x10,%ebx
  104e15:	39 5e 18             	cmp    %ebx,0x18(%esi)
  104e18:	76 3b                	jbe    104e55 <sys_unlink+0x125>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  104e1a:	8d 45 c2             	lea    -0x3e(%ebp),%eax
  104e1d:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  104e24:	00 
  104e25:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  104e29:	89 44 24 04          	mov    %eax,0x4(%esp)
  104e2d:	89 34 24             	mov    %esi,(%esp)
  104e30:	e8 4b c6 ff ff       	call   101480 <readi>
  104e35:	83 f8 10             	cmp    $0x10,%eax
  104e38:	0f 85 98 00 00 00    	jne    104ed6 <sys_unlink+0x1a6>
      panic("isdirempty: readi");
    if(de.inum != 0)
  104e3e:	66 83 7d c2 00       	cmpw   $0x0,-0x3e(%ebp)
  104e43:	74 cd                	je     104e12 <sys_unlink+0xe2>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
  104e45:	89 34 24             	mov    %esi,(%esp)
  104e48:	e8 73 cc ff ff       	call   101ac0 <iunlockput>
  104e4d:	8d 76 00             	lea    0x0(%esi),%esi
  104e50:	e9 6b ff ff ff       	jmp    104dc0 <sys_unlink+0x90>
    iunlockput(dp);
    return -1;
  }

  memset(&de, 0, sizeof(de));
  104e55:	8d 5d d2             	lea    -0x2e(%ebp),%ebx
  104e58:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  104e5f:	00 
  104e60:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104e67:	00 
  104e68:	89 1c 24             	mov    %ebx,(%esp)
  104e6b:	e8 90 ee ff ff       	call   103d00 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  104e70:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104e73:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  104e7a:	00 
  104e7b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  104e7f:	89 3c 24             	mov    %edi,(%esp)
  104e82:	89 44 24 08          	mov    %eax,0x8(%esp)
  104e86:	e8 c5 c4 ff ff       	call   101350 <writei>
  104e8b:	83 f8 10             	cmp    $0x10,%eax
  104e8e:	75 3a                	jne    104eca <sys_unlink+0x19a>
    panic("unlink: writei");
  if(ip->type == T_DIR){
  104e90:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
  104e95:	74 24                	je     104ebb <sys_unlink+0x18b>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
  104e97:	89 3c 24             	mov    %edi,(%esp)
  104e9a:	e8 21 cc ff ff       	call   101ac0 <iunlockput>

  ip->nlink--;
  104e9f:	66 83 6e 16 01       	subw   $0x1,0x16(%esi)
  iupdate(ip);
  104ea4:	89 34 24             	mov    %esi,(%esp)
  104ea7:	e8 84 c2 ff ff       	call   101130 <iupdate>
  iunlockput(ip);
  104eac:	89 34 24             	mov    %esi,(%esp)
  104eaf:	e8 0c cc ff ff       	call   101ac0 <iunlockput>
  104eb4:	31 c0                	xor    %eax,%eax
  104eb6:	e9 ae fe ff ff       	jmp    104d69 <sys_unlink+0x39>

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
  104ebb:	66 83 6f 16 01       	subw   $0x1,0x16(%edi)
    iupdate(dp);
  104ec0:	89 3c 24             	mov    %edi,(%esp)
  104ec3:	e8 68 c2 ff ff       	call   101130 <iupdate>
  104ec8:	eb cd                	jmp    104e97 <sys_unlink+0x167>
    return -1;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  104eca:	c7 04 24 7e 73 10 00 	movl   $0x10737e,(%esp)
  104ed1:	e8 aa b9 ff ff       	call   100880 <panic>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
  104ed6:	c7 04 24 6c 73 10 00 	movl   $0x10736c,(%esp)
  104edd:	e8 9e b9 ff ff       	call   100880 <panic>
    return -1;
  }
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  104ee2:	c7 04 24 5a 73 10 00 	movl   $0x10735a,(%esp)
  104ee9:	e8 92 b9 ff ff       	call   100880 <panic>
  104eee:	66 90                	xchg   %ax,%ax

00104ef0 <getfd>:
#include "file.h"
#include "fcntl.h"

static int
getfd(int n, int *pfd, struct file **pf)
{
  104ef0:	55                   	push   %ebp
  104ef1:	89 e5                	mov    %esp,%ebp
  104ef3:	83 ec 28             	sub    $0x28,%esp
  104ef6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  104ef9:	89 d3                	mov    %edx,%ebx
  int fd;
  struct file *f;

  if(getuserint(n, &fd) < 0)
  104efb:	8d 55 f0             	lea    -0x10(%ebp),%edx
#include "file.h"
#include "fcntl.h"

static int
getfd(int n, int *pfd, struct file **pf)
{
  104efe:	89 75 f8             	mov    %esi,-0x8(%ebp)
  104f01:	89 ce                	mov    %ecx,%esi
  104f03:	89 7d fc             	mov    %edi,-0x4(%ebp)
  int fd;
  struct file *f;

  if(getuserint(n, &fd) < 0)
  104f06:	89 54 24 04          	mov    %edx,0x4(%esp)
  104f0a:	89 04 24             	mov    %eax,(%esp)
  104f0d:	e8 de f4 ff ff       	call   1043f0 <getuserint>
  104f12:	85 c0                	test   %eax,%eax
  104f14:	79 12                	jns    104f28 <getfd+0x38>
    return -1;

  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  104f16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return 0;
}
  104f1b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  104f1e:	8b 75 f8             	mov    -0x8(%ebp),%esi
  104f21:	8b 7d fc             	mov    -0x4(%ebp),%edi
  104f24:	89 ec                	mov    %ebp,%esp
  104f26:	5d                   	pop    %ebp
  104f27:	c3                   	ret    
  int fd;
  struct file *f;

  if(getuserint(n, &fd) < 0)
    return -1;
  if(fd < 0 || fd >= NOFILE)
  104f28:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
  104f2c:	77 e8                	ja     104f16 <getfd+0x26>
    return -1;

  acquire(&proc->common->lock);
  104f2e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104f34:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  104f3a:	83 c0 50             	add    $0x50,%eax
  104f3d:	89 04 24             	mov    %eax,(%esp)
  104f40:	e8 4b ed ff ff       	call   103c90 <acquire>
  f = proc->common->ofile[fd];
  104f45:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104f4b:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
  104f51:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104f54:	8b 7c 82 08          	mov    0x8(%edx,%eax,4),%edi
  if (f != 0)
  104f58:	85 ff                	test   %edi,%edi
  104f5a:	74 32                	je     104f8e <getfd+0x9e>
    filedup(f);
  104f5c:	89 3c 24             	mov    %edi,(%esp)
  104f5f:	e8 bc be ff ff       	call   100e20 <filedup>
  release(&proc->common->lock);
  104f64:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104f6a:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  104f70:	83 c0 50             	add    $0x50,%eax
  104f73:	89 04 24             	mov    %eax,(%esp)
  104f76:	e8 d5 ec ff ff       	call   103c50 <release>
  if (f == 0)
    return -1;

  if(pfd)
  104f7b:	85 db                	test   %ebx,%ebx
  104f7d:	74 05                	je     104f84 <getfd+0x94>
    *pfd = fd;
  104f7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104f82:	89 03                	mov    %eax,(%ebx)
  if(pf)
  104f84:	31 c0                	xor    %eax,%eax
  104f86:	85 f6                	test   %esi,%esi
  104f88:	74 91                	je     104f1b <getfd+0x2b>
    *pf = f;
  104f8a:	89 3e                	mov    %edi,(%esi)
  104f8c:	eb 8d                	jmp    104f1b <getfd+0x2b>

  acquire(&proc->common->lock);
  f = proc->common->ofile[fd];
  if (f != 0)
    filedup(f);
  release(&proc->common->lock);
  104f8e:	8d 42 50             	lea    0x50(%edx),%eax
  104f91:	89 04 24             	mov    %eax,(%esp)
  104f94:	e8 b7 ec ff ff       	call   103c50 <release>
  104f99:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104f9e:	e9 78 ff ff ff       	jmp    104f1b <getfd+0x2b>
  104fa3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00104fb0 <sys_fstat>:
  return 0;
}

int
sys_fstat(void)
{
  104fb0:	55                   	push   %ebp
  struct file *f;
  struct stat st;
  int ret;

  if (getfd(0, 0, &f) < 0)
  104fb1:	31 d2                	xor    %edx,%edx
  return 0;
}

int
sys_fstat(void)
{
  104fb3:	89 e5                	mov    %esp,%ebp
  struct file *f;
  struct stat st;
  int ret;

  if (getfd(0, 0, &f) < 0)
  104fb5:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
  104fb7:	56                   	push   %esi
  104fb8:	53                   	push   %ebx
  struct file *f;
  struct stat st;
  int ret;

  if (getfd(0, 0, &f) < 0)
  104fb9:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return 0;
}

int
sys_fstat(void)
{
  104fbe:	83 ec 30             	sub    $0x30,%esp
  struct file *f;
  struct stat st;
  int ret;

  if (getfd(0, 0, &f) < 0)
  104fc1:	8d 4d f4             	lea    -0xc(%ebp),%ecx
  104fc4:	e8 27 ff ff ff       	call   104ef0 <getfd>
  104fc9:	85 c0                	test   %eax,%eax
  104fcb:	78 3c                	js     105009 <sys_fstat+0x59>
    return -1;

  if ((ret = filestat(f, &st)) < 0 || putuserbuf(1, &st, sizeof(struct stat)) < 0)
  104fcd:	8d 75 e0             	lea    -0x20(%ebp),%esi
  104fd0:	89 74 24 04          	mov    %esi,0x4(%esp)
  104fd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104fd7:	89 04 24             	mov    %eax,(%esp)
  104fda:	e8 f1 bd ff ff       	call   100dd0 <filestat>
  104fdf:	85 c0                	test   %eax,%eax
  104fe1:	89 c3                	mov    %eax,%ebx
  104fe3:	78 2d                	js     105012 <sys_fstat+0x62>
  104fe5:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
  104fec:	00 
  104fed:	89 74 24 04          	mov    %esi,0x4(%esp)
  104ff1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104ff8:	e8 33 f4 ff ff       	call   104430 <putuserbuf>
  104ffd:	85 c0                	test   %eax,%eax
  104fff:	78 11                	js     105012 <sys_fstat+0x62>
    goto e_fd;

  putfd(f);
  105001:	8b 45 f4             	mov    -0xc(%ebp),%eax
  105004:	e8 17 f5 ff ff       	call   104520 <putfd>
  return ret;

e_fd:
  putfd(f);
  return -1;
}
  105009:	83 c4 30             	add    $0x30,%esp
  10500c:	89 d8                	mov    %ebx,%eax
  10500e:	5b                   	pop    %ebx
  10500f:	5e                   	pop    %esi
  105010:	5d                   	pop    %ebp
  105011:	c3                   	ret    

  putfd(f);
  return ret;

e_fd:
  putfd(f);
  105012:	8b 45 f4             	mov    -0xc(%ebp),%eax
  105015:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  10501a:	e8 01 f5 ff ff       	call   104520 <putfd>
  return -1;
}
  10501f:	83 c4 30             	add    $0x30,%esp
  105022:	89 d8                	mov    %ebx,%eax
  105024:	5b                   	pop    %ebx
  105025:	5e                   	pop    %esi
  105026:	5d                   	pop    %ebp
  105027:	c3                   	ret    
  105028:	90                   	nop    
  105029:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00105030 <sys_close>:
  return -1;
}

int
sys_close(void)
{
  105030:	55                   	push   %ebp
  int fd;
  struct file *f;
  
  if(getfd(0, &fd, &f) < 0)
  105031:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_close(void)
{
  105033:	89 e5                	mov    %esp,%ebp
  105035:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;
  
  if(getfd(0, &fd, &f) < 0)
  105038:	8d 55 fc             	lea    -0x4(%ebp),%edx
  10503b:	8d 4d f8             	lea    -0x8(%ebp),%ecx
  10503e:	e8 ad fe ff ff       	call   104ef0 <getfd>
  105043:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  105048:	85 c0                	test   %eax,%eax
  10504a:	78 2c                	js     105078 <sys_close+0x48>
    return -1;

  proc->common->ofile[fd] = 0;
  10504c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  105052:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
  105058:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10505b:	c7 44 82 08 00 00 00 	movl   $0x0,0x8(%edx,%eax,4)
  105062:	00 
  fileclose(f);
  105063:	8b 45 f8             	mov    -0x8(%ebp),%eax
  105066:	89 04 24             	mov    %eax,(%esp)
  105069:	e8 72 be ff ff       	call   100ee0 <fileclose>

  putfd(f);
  10506e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  105071:	e8 aa f4 ff ff       	call   104520 <putfd>
  105076:	31 d2                	xor    %edx,%edx
  return 0;
}
  105078:	c9                   	leave  
  105079:	89 d0                	mov    %edx,%eax
  10507b:	c3                   	ret    
  10507c:	8d 74 26 00          	lea    0x0(%esi),%esi

00105080 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
  105080:	55                   	push   %ebp
  struct file *f;
  int fd;
  
  if(getfd(0, 0, &f) < 0)
  105081:	31 d2                	xor    %edx,%edx
  return -1;
}

int
sys_dup(void)
{
  105083:	89 e5                	mov    %esp,%ebp
  struct file *f;
  int fd;
  
  if(getfd(0, 0, &f) < 0)
  105085:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
  105087:	53                   	push   %ebx
  struct file *f;
  int fd;
  
  if(getfd(0, 0, &f) < 0)
  105088:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return -1;
}

int
sys_dup(void)
{
  10508d:	83 ec 14             	sub    $0x14,%esp
  struct file *f;
  int fd;
  
  if(getfd(0, 0, &f) < 0)
  105090:	8d 4d f8             	lea    -0x8(%ebp),%ecx
  105093:	e8 58 fe ff ff       	call   104ef0 <getfd>
  105098:	85 c0                	test   %eax,%eax
  10509a:	78 21                	js     1050bd <sys_dup+0x3d>
    return -1;
  if((fd=fdalloc(f)) < 0)
  10509c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10509f:	e8 8c f4 ff ff       	call   104530 <fdalloc>
  1050a4:	85 c0                	test   %eax,%eax
  1050a6:	89 c3                	mov    %eax,%ebx
  1050a8:	78 1b                	js     1050c5 <sys_dup+0x45>
    goto error;
  filedup(f);
  1050aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1050ad:	89 04 24             	mov    %eax,(%esp)
  1050b0:	e8 6b bd ff ff       	call   100e20 <filedup>

  putfd(f);
  1050b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1050b8:	e8 63 f4 ff ff       	call   104520 <putfd>
  return fd;

error:
  putfd(f);
  return -1;
}
  1050bd:	89 d8                	mov    %ebx,%eax
  1050bf:	83 c4 14             	add    $0x14,%esp
  1050c2:	5b                   	pop    %ebx
  1050c3:	5d                   	pop    %ebp
  1050c4:	c3                   	ret    

  putfd(f);
  return fd;

error:
  putfd(f);
  1050c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1050c8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  1050cd:	e8 4e f4 ff ff       	call   104520 <putfd>
  1050d2:	eb e9                	jmp    1050bd <sys_dup+0x3d>
  1050d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1050da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001050e0 <sys_write>:
  return -1;
}

int
sys_write(void)
{
  1050e0:	55                   	push   %ebp
  struct file *f;
  int n, ret;
  char *p;

  if (getfd(0, 0, &f) < 0)
  1050e1:	31 d2                	xor    %edx,%edx
  return -1;
}

int
sys_write(void)
{
  1050e3:	89 e5                	mov    %esp,%ebp
  struct file *f;
  int n, ret;
  char *p;

  if (getfd(0, 0, &f) < 0)
  1050e5:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_write(void)
{
  1050e7:	56                   	push   %esi
  1050e8:	53                   	push   %ebx
  struct file *f;
  int n, ret;
  char *p;

  if (getfd(0, 0, &f) < 0)
  1050e9:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return -1;
}

int
sys_write(void)
{
  1050ee:	83 ec 20             	sub    $0x20,%esp
  struct file *f;
  int n, ret;
  char *p;

  if (getfd(0, 0, &f) < 0)
  1050f1:	8d 4d f4             	lea    -0xc(%ebp),%ecx
  1050f4:	e8 f7 fd ff ff       	call   104ef0 <getfd>
  1050f9:	85 c0                	test   %eax,%eax
  1050fb:	78 2d                	js     10512a <sys_write+0x4a>
    return -1;

  if (getuserint(2, &n) < 0 || n > PGSIZE || (p = kalloc()) == 0)
  1050fd:	8d 45 f0             	lea    -0x10(%ebp),%eax
  105100:	89 44 24 04          	mov    %eax,0x4(%esp)
  105104:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  10510b:	e8 e0 f2 ff ff       	call   1043f0 <getuserint>
  105110:	85 c0                	test   %eax,%eax
  105112:	78 09                	js     10511d <sys_write+0x3d>
  105114:	81 7d f0 00 10 00 00 	cmpl   $0x1000,-0x10(%ebp)
  10511b:	7e 16                	jle    105133 <sys_write+0x53>
  return ret;

e_ka:
  kfree(p);
e_fd:
  putfd(f);
  10511d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  105120:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  105125:	e8 f6 f3 ff ff       	call   104520 <putfd>
  return -1;
}
  10512a:	83 c4 20             	add    $0x20,%esp
  10512d:	89 d8                	mov    %ebx,%eax
  10512f:	5b                   	pop    %ebx
  105130:	5e                   	pop    %esi
  105131:	5d                   	pop    %ebp
  105132:	c3                   	ret    
  char *p;

  if (getfd(0, 0, &f) < 0)
    return -1;

  if (getuserint(2, &n) < 0 || n > PGSIZE || (p = kalloc()) == 0)
  105133:	e8 68 d0 ff ff       	call   1021a0 <kalloc>
  105138:	85 c0                	test   %eax,%eax
  10513a:	89 c6                	mov    %eax,%esi
  10513c:	74 df                	je     10511d <sys_write+0x3d>
    goto e_fd;

  if (getuserbuf(1, p, n) < 0 || (ret = filewrite(f, p, n)) < 0)
  10513e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105141:	89 74 24 04          	mov    %esi,0x4(%esp)
  105145:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  10514c:	89 44 24 08          	mov    %eax,0x8(%esp)
  105150:	e8 7b f3 ff ff       	call   1044d0 <getuserbuf>
  105155:	85 c0                	test   %eax,%eax
  105157:	78 2e                	js     105187 <sys_write+0xa7>
  105159:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10515c:	89 74 24 04          	mov    %esi,0x4(%esp)
  105160:	89 44 24 08          	mov    %eax,0x8(%esp)
  105164:	8b 45 f4             	mov    -0xc(%ebp),%eax
  105167:	89 04 24             	mov    %eax,(%esp)
  10516a:	e8 21 bb ff ff       	call   100c90 <filewrite>
  10516f:	85 c0                	test   %eax,%eax
  105171:	89 c3                	mov    %eax,%ebx
  105173:	78 12                	js     105187 <sys_write+0xa7>
    goto e_ka;

  kfree(p);
  105175:	89 34 24             	mov    %esi,(%esp)
  105178:	e8 63 d0 ff ff       	call   1021e0 <kfree>
  putfd(f);
  10517d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  105180:	e8 9b f3 ff ff       	call   104520 <putfd>
  105185:	eb a3                	jmp    10512a <sys_write+0x4a>
  return ret;

e_ka:
  kfree(p);
  105187:	89 34 24             	mov    %esi,(%esp)
  10518a:	e8 51 d0 ff ff       	call   1021e0 <kfree>
  10518f:	90                   	nop    
  105190:	eb 8b                	jmp    10511d <sys_write+0x3d>
  105192:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  105199:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001051a0 <sys_read>:
  return -1;
}

int
sys_read(void)
{
  1051a0:	55                   	push   %ebp
  struct file *f;
  int n, ret;
  char *p;

  if (getfd(0, 0, &f) < 0)
  1051a1:	31 d2                	xor    %edx,%edx
  return -1;
}

int
sys_read(void)
{
  1051a3:	89 e5                	mov    %esp,%ebp
  struct file *f;
  int n, ret;
  char *p;

  if (getfd(0, 0, &f) < 0)
  1051a5:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_read(void)
{
  1051a7:	56                   	push   %esi
  1051a8:	53                   	push   %ebx
  struct file *f;
  int n, ret;
  char *p;

  if (getfd(0, 0, &f) < 0)
  1051a9:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return -1;
}

int
sys_read(void)
{
  1051ae:	83 ec 20             	sub    $0x20,%esp
  struct file *f;
  int n, ret;
  char *p;

  if (getfd(0, 0, &f) < 0)
  1051b1:	8d 4d f4             	lea    -0xc(%ebp),%ecx
  1051b4:	e8 37 fd ff ff       	call   104ef0 <getfd>
  1051b9:	85 c0                	test   %eax,%eax
  1051bb:	78 2d                	js     1051ea <sys_read+0x4a>
    return -1;

  if (getuserint(2, &n) < 0 || n > PGSIZE || (p = kalloc()) == 0)
  1051bd:	8d 45 f0             	lea    -0x10(%ebp),%eax
  1051c0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1051c4:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1051cb:	e8 20 f2 ff ff       	call   1043f0 <getuserint>
  1051d0:	85 c0                	test   %eax,%eax
  1051d2:	78 09                	js     1051dd <sys_read+0x3d>
  1051d4:	81 7d f0 00 10 00 00 	cmpl   $0x1000,-0x10(%ebp)
  1051db:	7e 16                	jle    1051f3 <sys_read+0x53>
  return ret;

e_ka:
  kfree(p);
e_fd:
  putfd(f);
  1051dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1051e0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  1051e5:	e8 36 f3 ff ff       	call   104520 <putfd>
  return -1;
}
  1051ea:	83 c4 20             	add    $0x20,%esp
  1051ed:	89 d8                	mov    %ebx,%eax
  1051ef:	5b                   	pop    %ebx
  1051f0:	5e                   	pop    %esi
  1051f1:	5d                   	pop    %ebp
  1051f2:	c3                   	ret    
  char *p;

  if (getfd(0, 0, &f) < 0)
    return -1;

  if (getuserint(2, &n) < 0 || n > PGSIZE || (p = kalloc()) == 0)
  1051f3:	e8 a8 cf ff ff       	call   1021a0 <kalloc>
  1051f8:	85 c0                	test   %eax,%eax
  1051fa:	89 c6                	mov    %eax,%esi
  1051fc:	74 df                	je     1051dd <sys_read+0x3d>
    goto e_fd;

  if ((ret = fileread(f, p, n)) < 0 || putuserbuf(1, p, n) < 0)
  1051fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105201:	89 74 24 04          	mov    %esi,0x4(%esp)
  105205:	89 44 24 08          	mov    %eax,0x8(%esp)
  105209:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10520c:	89 04 24             	mov    %eax,(%esp)
  10520f:	e8 1c bb ff ff       	call   100d30 <fileread>
  105214:	85 c0                	test   %eax,%eax
  105216:	89 c3                	mov    %eax,%ebx
  105218:	78 2d                	js     105247 <sys_read+0xa7>
  10521a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10521d:	89 74 24 04          	mov    %esi,0x4(%esp)
  105221:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  105228:	89 44 24 08          	mov    %eax,0x8(%esp)
  10522c:	e8 ff f1 ff ff       	call   104430 <putuserbuf>
  105231:	85 c0                	test   %eax,%eax
  105233:	78 12                	js     105247 <sys_read+0xa7>
    goto e_ka;

  kfree(p);
  105235:	89 34 24             	mov    %esi,(%esp)
  105238:	e8 a3 cf ff ff       	call   1021e0 <kfree>
  putfd(f);
  10523d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  105240:	e8 db f2 ff ff       	call   104520 <putfd>
  105245:	eb a3                	jmp    1051ea <sys_read+0x4a>
  return ret;

e_ka:
  kfree(p);
  105247:	89 34 24             	mov    %esi,(%esp)
  10524a:	e8 91 cf ff ff       	call   1021e0 <kfree>
  10524f:	90                   	nop    
  105250:	eb 8b                	jmp    1051dd <sys_read+0x3d>
  105252:	90                   	nop    
  105253:	90                   	nop    
  105254:	90                   	nop    
  105255:	90                   	nop    
  105256:	90                   	nop    
  105257:	90                   	nop    
  105258:	90                   	nop    
  105259:	90                   	nop    
  10525a:	90                   	nop    
  10525b:	90                   	nop    
  10525c:	90                   	nop    
  10525d:	90                   	nop    
  10525e:	90                   	nop    
  10525f:	90                   	nop    

00105260 <sys_tfork>:
#include "rwlock.h"
#include "proc.h"

int
sys_tfork(void)
{
  105260:	55                   	push   %ebp
  // HW3 TODO
  return 0;
}
  105261:	31 c0                	xor    %eax,%eax
#include "rwlock.h"
#include "proc.h"

int
sys_tfork(void)
{
  105263:	89 e5                	mov    %esp,%ebp
  // HW3 TODO
  return 0;
}
  105265:	5d                   	pop    %ebp
  105266:	c3                   	ret    
  105267:	89 f6                	mov    %esi,%esi
  105269:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00105270 <sys_texit>:

int
sys_texit(void)
{
  105270:	55                   	push   %ebp
  // HW3 TODO
  return 0;
}
  105271:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_texit(void)
{
  105273:	89 e5                	mov    %esp,%ebp
  // HW3 TODO
  return 0;
}
  105275:	5d                   	pop    %ebp
  105276:	c3                   	ret    
  105277:	89 f6                	mov    %esi,%esi
  105279:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00105280 <sys_twait>:

int
sys_twait(void)
{
  105280:	55                   	push   %ebp
  // HW3 TODO
  return 0;
}
  105281:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_twait(void)
{
  105283:	89 e5                	mov    %esp,%ebp
  // HW3 TODO
  return 0;
}
  105285:	5d                   	pop    %ebp
  105286:	c3                   	ret    
  105287:	89 f6                	mov    %esi,%esi
  105289:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00105290 <sys_getpid>:
}

int
sys_getpid(void)
{
  return proc->pid;
  105290:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return kill(pid);
}

int
sys_getpid(void)
{
  105296:	55                   	push   %ebp
  105297:	89 e5                	mov    %esp,%ebp
  return proc->pid;
}
  105299:	5d                   	pop    %ebp
}

int
sys_getpid(void)
{
  return proc->pid;
  10529a:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
}
  1052a0:	c3                   	ret    
  1052a1:	eb 0d                	jmp    1052b0 <sys_pschk>
  1052a3:	90                   	nop    
  1052a4:	90                   	nop    
  1052a5:	90                   	nop    
  1052a6:	90                   	nop    
  1052a7:	90                   	nop    
  1052a8:	90                   	nop    
  1052a9:	90                   	nop    
  1052aa:	90                   	nop    
  1052ab:	90                   	nop    
  1052ac:	90                   	nop    
  1052ad:	90                   	nop    
  1052ae:	90                   	nop    
  1052af:	90                   	nop    

001052b0 <sys_pschk>:

// HW3: This system call is for grading purposes only; you should not
// call it in your code
int
sys_pschk(void)
{
  1052b0:	55                   	push   %ebp
  1052b1:	89 e5                	mov    %esp,%ebp
  return pschk();
}
  1052b3:	5d                   	pop    %ebp
// HW3: This system call is for grading purposes only; you should not
// call it in your code
int
sys_pschk(void)
{
  return pschk();
  1052b4:	e9 b7 dd ff ff       	jmp    103070 <pschk>
  1052b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

001052c0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since boot.
int
sys_uptime(void)
{
  1052c0:	55                   	push   %ebp
  1052c1:	89 e5                	mov    %esp,%ebp
  1052c3:	53                   	push   %ebx
  1052c4:	83 ec 04             	sub    $0x4,%esp
  uint xticks;
  
  acquire(&tickslock);
  1052c7:	c7 04 24 80 f4 10 00 	movl   $0x10f480,(%esp)
  1052ce:	e8 bd e9 ff ff       	call   103c90 <acquire>
  xticks = ticks;
  1052d3:	8b 1d c0 fc 10 00    	mov    0x10fcc0,%ebx
  release(&tickslock);
  1052d9:	c7 04 24 80 f4 10 00 	movl   $0x10f480,(%esp)
  1052e0:	e8 6b e9 ff ff       	call   103c50 <release>
  return xticks;
}
  1052e5:	83 c4 04             	add    $0x4,%esp
  1052e8:	89 d8                	mov    %ebx,%eax
  1052ea:	5b                   	pop    %ebx
  1052eb:	5d                   	pop    %ebp
  1052ec:	c3                   	ret    
  1052ed:	8d 76 00             	lea    0x0(%esi),%esi

001052f0 <sys_sleep>:
    return addr;
}

int
sys_sleep(void)
{
  1052f0:	55                   	push   %ebp
  1052f1:	89 e5                	mov    %esp,%ebp
  1052f3:	53                   	push   %ebx
  1052f4:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;
  
  if(getuserint(0, &n) < 0)
  1052f7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  1052fa:	89 44 24 04          	mov    %eax,0x4(%esp)
  1052fe:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  105305:	e8 e6 f0 ff ff       	call   1043f0 <getuserint>
  10530a:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  10530f:	85 c0                	test   %eax,%eax
  105311:	78 61                	js     105374 <sys_sleep+0x84>
    return -1;
  acquire(&tickslock);
  105313:	c7 04 24 80 f4 10 00 	movl   $0x10f480,(%esp)
  10531a:	e8 71 e9 ff ff       	call   103c90 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
  10531f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  uint ticks0;
  
  if(getuserint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  105322:	8b 1d c0 fc 10 00    	mov    0x10fcc0,%ebx
  while(ticks - ticks0 < n){
  105328:	85 d2                	test   %edx,%edx
  10532a:	75 24                	jne    105350 <sys_sleep+0x60>
  10532c:	eb 4e                	jmp    10537c <sys_sleep+0x8c>
  10532e:	66 90                	xchg   %ax,%ax
    if(proc->common->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  105330:	c7 44 24 04 80 f4 10 	movl   $0x10f480,0x4(%esp)
  105337:	00 
  105338:	c7 04 24 c0 fc 10 00 	movl   $0x10fcc0,(%esp)
  10533f:	e8 3c de ff ff       	call   103180 <sleep>
  
  if(getuserint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
  105344:	a1 c0 fc 10 00       	mov    0x10fcc0,%eax
  105349:	29 d8                	sub    %ebx,%eax
  10534b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  10534e:	73 2c                	jae    10537c <sys_sleep+0x8c>
    if(proc->common->killed){
  105350:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  105356:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  10535c:	8b 40 4c             	mov    0x4c(%eax),%eax
  10535f:	85 c0                	test   %eax,%eax
  105361:	74 cd                	je     105330 <sys_sleep+0x40>
      release(&tickslock);
  105363:	c7 04 24 80 f4 10 00 	movl   $0x10f480,(%esp)
  10536a:	e8 e1 e8 ff ff       	call   103c50 <release>
  10536f:	ba ff ff ff ff       	mov    $0xffffffff,%edx
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
  105374:	83 c4 24             	add    $0x24,%esp
  105377:	89 d0                	mov    %edx,%eax
  105379:	5b                   	pop    %ebx
  10537a:	5d                   	pop    %ebp
  10537b:	c3                   	ret    
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  10537c:	c7 04 24 80 f4 10 00 	movl   $0x10f480,(%esp)
  105383:	e8 c8 e8 ff ff       	call   103c50 <release>
  return 0;
}
  105388:	83 c4 24             	add    $0x24,%esp
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  10538b:	31 d2                	xor    %edx,%edx
  return 0;
}
  10538d:	5b                   	pop    %ebx
  10538e:	89 d0                	mov    %edx,%eax
  105390:	5d                   	pop    %ebp
  105391:	c3                   	ret    
  105392:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  105399:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001053a0 <sys_sbrk>:
  return proc->pid;
}

int
sys_sbrk(void)
{
  1053a0:	55                   	push   %ebp
  1053a1:	89 e5                	mov    %esp,%ebp
  1053a3:	53                   	push   %ebx
  1053a4:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;
  int fault = 0;

  if(getuserint(0, &n) < 0)
  1053a7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  1053aa:	89 44 24 04          	mov    %eax,0x4(%esp)
  1053ae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1053b5:	e8 36 f0 ff ff       	call   1043f0 <getuserint>
  1053ba:	85 c0                	test   %eax,%eax
  1053bc:	79 0d                	jns    1053cb <sys_sbrk+0x2b>
    fault = 1;

  if (fault)
    return -1;
  else
    return addr;
  1053be:	ba ff ff ff ff       	mov    $0xffffffff,%edx
}
  1053c3:	83 c4 24             	add    $0x24,%esp
  1053c6:	89 d0                	mov    %edx,%eax
  1053c8:	5b                   	pop    %ebx
  1053c9:	5d                   	pop    %ebp
  1053ca:	c3                   	ret    
  int fault = 0;

  if(getuserint(0, &n) < 0)
    return -1;

  addr = proc->common->sz;
  1053cb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1053d1:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  1053d7:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
  1053d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1053dc:	89 04 24             	mov    %eax,(%esp)
  1053df:	e8 4c e4 ff ff       	call   103830 <growproc>
  int fault = 0;

  if(getuserint(0, &n) < 0)
    return -1;

  addr = proc->common->sz;
  1053e4:	89 da                	mov    %ebx,%edx
  if(growproc(n) < 0)
  1053e6:	85 c0                	test   %eax,%eax
  1053e8:	79 d9                	jns    1053c3 <sys_sbrk+0x23>
  1053ea:	eb d2                	jmp    1053be <sys_sbrk+0x1e>
  1053ec:	8d 74 26 00          	lea    0x0(%esi),%esi

001053f0 <sys_kill>:
  return wait();
}

int
sys_kill(void)
{
  1053f0:	55                   	push   %ebp
  1053f1:	89 e5                	mov    %esp,%ebp
  1053f3:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(getuserint(0, &pid) < 0)
  1053f6:	8d 45 fc             	lea    -0x4(%ebp),%eax
  1053f9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1053fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  105404:	e8 e7 ef ff ff       	call   1043f0 <getuserint>
  105409:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  10540e:	85 c0                	test   %eax,%eax
  105410:	78 0d                	js     10541f <sys_kill+0x2f>
    return -1;
  return kill(pid);
  105412:	8b 45 fc             	mov    -0x4(%ebp),%eax
  105415:	89 04 24             	mov    %eax,(%esp)
  105418:	e8 73 db ff ff       	call   102f90 <kill>
  10541d:	89 c2                	mov    %eax,%edx
}
  10541f:	c9                   	leave  
  105420:	89 d0                	mov    %edx,%eax
  105422:	c3                   	ret    
  105423:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105429:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00105430 <sys_wait>:
  return 0;  // not reached
}

int
sys_wait(void)
{
  105430:	55                   	push   %ebp
  105431:	89 e5                	mov    %esp,%ebp
  return wait();
}
  105433:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
  105434:	e9 07 df ff ff       	jmp    103340 <wait>
  105439:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00105440 <sys_exit>:
  return fork();
}

int
sys_exit(void)
{
  105440:	55                   	push   %ebp
  105441:	89 e5                	mov    %esp,%ebp
  105443:	83 ec 08             	sub    $0x8,%esp
  exit();
  105446:	e8 15 e0 ff ff       	call   103460 <exit>
  return 0;  // not reached
}
  10544b:	31 c0                	xor    %eax,%eax
  10544d:	c9                   	leave  
  10544e:	c3                   	ret    
  10544f:	90                   	nop    

00105450 <sys_fork>:
  return 0;
}

int
sys_fork(void)
{
  105450:	55                   	push   %ebp
  105451:	89 e5                	mov    %esp,%ebp
  return fork();
}
  105453:	5d                   	pop    %ebp
}

int
sys_fork(void)
{
  return fork();
  105454:	e9 07 e2 ff ff       	jmp    103660 <fork>
  105459:	90                   	nop    
  10545a:	90                   	nop    
  10545b:	90                   	nop    
  10545c:	90                   	nop    
  10545d:	90                   	nop    
  10545e:	90                   	nop    
  10545f:	90                   	nop    

00105460 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
  105460:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  105461:	b8 34 00 00 00       	mov    $0x34,%eax
  105466:	89 e5                	mov    %esp,%ebp
  105468:	ba 43 00 00 00       	mov    $0x43,%edx
  10546d:	83 ec 08             	sub    $0x8,%esp
  105470:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  picenable(IRQ_TIMER);
  105471:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
  105476:	b2 40                	mov    $0x40,%dl
  105478:	ee                   	out    %al,(%dx)
  105479:	b8 2e 00 00 00       	mov    $0x2e,%eax
  10547e:	ee                   	out    %al,(%dx)
  10547f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  105486:	e8 65 d6 ff ff       	call   102af0 <picenable>
}
  10548b:	c9                   	leave  
  10548c:	c3                   	ret    
  10548d:	90                   	nop    
  10548e:	90                   	nop    
  10548f:	90                   	nop    

00105490 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
  105490:	1e                   	push   %ds
  pushl %es
  105491:	06                   	push   %es
  pushl %fs
  105492:	0f a0                	push   %fs
  pushl %gs
  105494:	0f a8                	push   %gs
  pushal
  105496:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
  105497:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
  10549b:	8e d8                	mov    %eax,%ds
  movw %ax, %es
  10549d:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
  10549f:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
  1054a3:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
  1054a5:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
  1054a7:	54                   	push   %esp
  call trap
  1054a8:	e8 d3 00 00 00       	call   105580 <trap>
  addl $4, %esp
  1054ad:	83 c4 04             	add    $0x4,%esp

001054b0 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
  1054b0:	61                   	popa   
  popl %gs
  1054b1:	0f a9                	pop    %gs
  popl %fs
  1054b3:	0f a1                	pop    %fs
  popl %es
  1054b5:	07                   	pop    %es
  popl %ds
  1054b6:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
  1054b7:	83 c4 08             	add    $0x8,%esp
  iret
  1054ba:	cf                   	iret   
  1054bb:	90                   	nop    
  1054bc:	90                   	nop    
  1054bd:	90                   	nop    
  1054be:	90                   	nop    
  1054bf:	90                   	nop    

001054c0 <idtinit>:
  initlock(&tickslock, "time");
}

void
idtinit(void)
{
  1054c0:	55                   	push   %ebp
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
  1054c1:	b8 c0 f4 10 00       	mov    $0x10f4c0,%eax
  1054c6:	89 e5                	mov    %esp,%ebp
  1054c8:	83 ec 10             	sub    $0x10,%esp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  1054cb:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
  1054d1:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
  1054d5:	c1 e8 10             	shr    $0x10,%eax
  1054d8:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
  1054dc:	8d 45 fa             	lea    -0x6(%ebp),%eax
  1054df:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
  1054e2:	c9                   	leave  
  1054e3:	c3                   	ret    
  1054e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1054ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001054f0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
  1054f0:	55                   	push   %ebp
  1054f1:	31 d2                	xor    %edx,%edx
  1054f3:	89 e5                	mov    %esp,%ebp
  1054f5:	83 ec 08             	sub    $0x8,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  1054f8:	8b 04 95 a8 88 10 00 	mov    0x1088a8(,%edx,4),%eax
  1054ff:	66 c7 04 d5 c2 f4 10 	movw   $0x8,0x10f4c2(,%edx,8)
  105506:	00 08 00 
  105509:	c6 04 d5 c4 f4 10 00 	movb   $0x0,0x10f4c4(,%edx,8)
  105510:	00 
  105511:	c6 04 d5 c5 f4 10 00 	movb   $0x8e,0x10f4c5(,%edx,8)
  105518:	8e 
  105519:	66 89 04 d5 c0 f4 10 	mov    %ax,0x10f4c0(,%edx,8)
  105520:	00 
  105521:	c1 e8 10             	shr    $0x10,%eax
  105524:	66 89 04 d5 c6 f4 10 	mov    %ax,0x10f4c6(,%edx,8)
  10552b:	00 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
  10552c:	83 c2 01             	add    $0x1,%edx
  10552f:	81 fa 00 01 00 00    	cmp    $0x100,%edx
  105535:	75 c1                	jne    1054f8 <tvinit+0x8>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  105537:	a1 a8 89 10 00       	mov    0x1089a8,%eax
  
  initlock(&tickslock, "time");
  10553c:	c7 44 24 04 8d 73 10 	movl   $0x10738d,0x4(%esp)
  105543:	00 
  105544:	c7 04 24 80 f4 10 00 	movl   $0x10f480,(%esp)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  10554b:	66 c7 05 c2 f6 10 00 	movw   $0x8,0x10f6c2
  105552:	08 00 
  105554:	66 a3 c0 f6 10 00    	mov    %ax,0x10f6c0
  10555a:	c1 e8 10             	shr    $0x10,%eax
  10555d:	c6 05 c4 f6 10 00 00 	movb   $0x0,0x10f6c4
  105564:	c6 05 c5 f6 10 00 ef 	movb   $0xef,0x10f6c5
  10556b:	66 a3 c6 f6 10 00    	mov    %ax,0x10f6c6
  
  initlock(&tickslock, "time");
  105571:	e8 9a e5 ff ff       	call   103b10 <initlock>
}
  105576:	c9                   	leave  
  105577:	c3                   	ret    
  105578:	90                   	nop    
  105579:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00105580 <trap>:
  lidt(idt, sizeof(idt));
}

void
trap(struct trapframe *tf)
{
  105580:	55                   	push   %ebp
  105581:	89 e5                	mov    %esp,%ebp
  105583:	56                   	push   %esi
  105584:	53                   	push   %ebx
  105585:	83 ec 20             	sub    $0x20,%esp
  105588:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
  10558b:	8b 4b 30             	mov    0x30(%ebx),%ecx
  10558e:	83 f9 40             	cmp    $0x40,%ecx
  105591:	74 5d                	je     1055f0 <trap+0x70>
    if(proc->common->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  105593:	8d 41 e0             	lea    -0x20(%ecx),%eax
  105596:	83 f8 1f             	cmp    $0x1f,%eax
  105599:	76 4c                	jbe    1055e7 <trap+0x67>
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
    break;
   
  default:
    if(proc == 0 || (tf->cs&3) == 0){
  10559b:	65 8b 35 04 00 00 00 	mov    %gs:0x4,%esi
  1055a2:	85 f6                	test   %esi,%esi
  1055a4:	74 0a                	je     1055b0 <trap+0x30>
  1055a6:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
  1055aa:	0f 85 c0 01 00 00    	jne    105770 <trap+0x1f0>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
  1055b0:	0f 20 d0             	mov    %cr2,%eax
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
  1055b3:	89 44 24 10          	mov    %eax,0x10(%esp)
  1055b7:	8b 43 38             	mov    0x38(%ebx),%eax
  1055ba:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1055be:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  1055c4:	0f b6 00             	movzbl (%eax),%eax
  1055c7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  1055cb:	c7 04 24 bc 73 10 00 	movl   $0x1073bc,(%esp)
  1055d2:	89 44 24 08          	mov    %eax,0x8(%esp)
  1055d6:	e8 e5 ae ff ff       	call   1004c0 <cprintf>
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
  1055db:	c7 04 24 92 73 10 00 	movl   $0x107392,(%esp)
  1055e2:	e8 99 b2 ff ff       	call   100880 <panic>
    if(proc->common->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  1055e7:	ff 24 85 34 74 10 00 	jmp    *0x107434(,%eax,4)
  1055ee:	66 90                	xchg   %ax,%ax

void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->common->killed)
  1055f0:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  1055f7:	8b 82 88 00 00 00    	mov    0x88(%edx),%eax
  1055fd:	8b 70 4c             	mov    0x4c(%eax),%esi
  105600:	85 f6                	test   %esi,%esi
  105602:	0f 85 26 01 00 00    	jne    10572e <trap+0x1ae>
      exit();
    proc->tf = tf;
  105608:	89 9a 9c 00 00 00    	mov    %ebx,0x9c(%edx)
    syscall();
  10560e:	e8 7d e9 ff ff       	call   103f90 <syscall>
    if(proc->common->killed)
  105613:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  105619:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  10561f:	8b 58 4c             	mov    0x4c(%eax),%ebx
  105622:	85 db                	test   %ebx,%ebx
  105624:	75 67                	jne    10568d <trap+0x10d>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->common->killed && (tf->cs&3) == DPL_USER)
    exit();
}
  105626:	83 c4 20             	add    $0x20,%esp
  105629:	5b                   	pop    %ebx
  10562a:	5e                   	pop    %esi
  10562b:	5d                   	pop    %ebp
  10562c:	c3                   	ret    
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
  10562d:	e8 2e c9 ff ff       	call   101f60 <ideintr>
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
  105632:	e8 89 cd ff ff       	call   1023c0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->common->killed && (tf->cs&3) == DPL_USER)
  105637:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  10563e:	85 d2                	test   %edx,%edx
  105640:	74 e4                	je     105626 <trap+0xa6>
  105642:	8b 82 88 00 00 00    	mov    0x88(%edx),%eax
  105648:	8b 48 4c             	mov    0x4c(%eax),%ecx
  10564b:	85 c9                	test   %ecx,%ecx
  10564d:	74 10                	je     10565f <trap+0xdf>
  10564f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
  105653:	83 e0 03             	and    $0x3,%eax
  105656:	83 f8 03             	cmp    $0x3,%eax
  105659:	0f 84 f8 00 00 00    	je     105757 <trap+0x1d7>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
  10565f:	83 ba 90 00 00 00 04 	cmpl   $0x4,0x90(%edx)
  105666:	75 0a                	jne    105672 <trap+0xf2>
  105668:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
  10566c:	0f 84 cd 00 00 00    	je     10573f <trap+0x1bf>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->common->killed && (tf->cs&3) == DPL_USER)
  105672:	89 d0                	mov    %edx,%eax
  105674:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  10567a:	8b 40 4c             	mov    0x4c(%eax),%eax
  10567d:	85 c0                	test   %eax,%eax
  10567f:	74 a5                	je     105626 <trap+0xa6>
  105681:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
  105685:	83 e0 03             	and    $0x3,%eax
  105688:	83 f8 03             	cmp    $0x3,%eax
  10568b:	75 99                	jne    105626 <trap+0xa6>
    exit();
}
  10568d:	83 c4 20             	add    $0x20,%esp
  105690:	5b                   	pop    %ebx
  105691:	5e                   	pop    %esi
  105692:	5d                   	pop    %ebp
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->common->killed && (tf->cs&3) == DPL_USER)
    exit();
  105693:	e9 c8 dd ff ff       	jmp    103460 <exit>
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
  105698:	8b 43 38             	mov    0x38(%ebx),%eax
  10569b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10569f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
  1056a3:	89 44 24 08          	mov    %eax,0x8(%esp)
  1056a7:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  1056ad:	0f b6 00             	movzbl (%eax),%eax
  1056b0:	c7 04 24 98 73 10 00 	movl   $0x107398,(%esp)
  1056b7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1056bb:	e8 00 ae ff ff       	call   1004c0 <cprintf>
  1056c0:	e9 6d ff ff ff       	jmp    105632 <trap+0xb2>
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
  1056c5:	e8 06 01 00 00       	call   1057d0 <uartintr>
  1056ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    lapiceoi();
  1056d0:	e8 eb cc ff ff       	call   1023c0 <lapiceoi>
  1056d5:	e9 5d ff ff ff       	jmp    105637 <trap+0xb7>
  1056da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
  1056e0:	e8 db cb ff ff       	call   1022c0 <kbdintr>
    lapiceoi();
  1056e5:	e8 d6 cc ff ff       	call   1023c0 <lapiceoi>
  1056ea:	e9 48 ff ff ff       	jmp    105637 <trap+0xb7>
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
  1056ef:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  1056f5:	80 38 00             	cmpb   $0x0,(%eax)
  1056f8:	0f 85 34 ff ff ff    	jne    105632 <trap+0xb2>
      acquire(&tickslock);
  1056fe:	c7 04 24 80 f4 10 00 	movl   $0x10f480,(%esp)
  105705:	e8 86 e5 ff ff       	call   103c90 <acquire>
      ticks++;
  10570a:	83 05 c0 fc 10 00 01 	addl   $0x1,0x10fcc0
      wakeup(&ticks);
  105711:	c7 04 24 c0 fc 10 00 	movl   $0x10fcc0,(%esp)
  105718:	e8 03 d9 ff ff       	call   103020 <wakeup>
      release(&tickslock);
  10571d:	c7 04 24 80 f4 10 00 	movl   $0x10f480,(%esp)
  105724:	e8 27 e5 ff ff       	call   103c50 <release>
  105729:	e9 04 ff ff ff       	jmp    105632 <trap+0xb2>
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->common->killed)
      exit();
  10572e:	e8 2d dd ff ff       	call   103460 <exit>
  105733:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  10573a:	e9 c9 fe ff ff       	jmp    105608 <trap+0x88>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
  10573f:	e8 1c db ff ff       	call   103260 <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->common->killed && (tf->cs&3) == DPL_USER)
  105744:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10574a:	85 c0                	test   %eax,%eax
  10574c:	0f 85 22 ff ff ff    	jne    105674 <trap+0xf4>
  105752:	e9 cf fe ff ff       	jmp    105626 <trap+0xa6>

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->common->killed && (tf->cs&3) == DPL_USER)
    exit();
  105757:	e8 04 dd ff ff       	call   103460 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
  10575c:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  105763:	85 d2                	test   %edx,%edx
  105765:	0f 85 f4 fe ff ff    	jne    10565f <trap+0xdf>
  10576b:	e9 b6 fe ff ff       	jmp    105626 <trap+0xa6>
  105770:	0f 20 d0             	mov    %cr2,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
  105773:	8b 96 94 00 00 00    	mov    0x94(%esi),%edx
  105779:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  10577d:	8b 43 38             	mov    0x38(%ebx),%eax
  105780:	89 44 24 18          	mov    %eax,0x18(%esp)
  105784:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  10578a:	0f b6 00             	movzbl (%eax),%eax
  10578d:	89 44 24 14          	mov    %eax,0x14(%esp)
  105791:	8b 43 34             	mov    0x34(%ebx),%eax
  105794:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  105798:	89 54 24 04          	mov    %edx,0x4(%esp)
  10579c:	c7 04 24 f0 73 10 00 	movl   $0x1073f0,(%esp)
  1057a3:	89 44 24 10          	mov    %eax,0x10(%esp)
  1057a7:	8d 86 a8 00 00 00    	lea    0xa8(%esi),%eax
  1057ad:	89 44 24 08          	mov    %eax,0x8(%esp)
  1057b1:	e8 0a ad ff ff       	call   1004c0 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->common->killed = 1;
  1057b6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1057bc:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
  1057c2:	c7 40 4c 01 00 00 00 	movl   $0x1,0x4c(%eax)
  1057c9:	e9 69 fe ff ff       	jmp    105637 <trap+0xb7>
  1057ce:	90                   	nop    
  1057cf:	90                   	nop    

001057d0 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
  1057d0:	55                   	push   %ebp
  1057d1:	89 e5                	mov    %esp,%ebp
  1057d3:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
  1057d6:	c7 04 24 40 58 10 00 	movl   $0x105840,(%esp)
  1057dd:	e8 1e af ff ff       	call   100700 <consoleintr>
}
  1057e2:	c9                   	leave  
  1057e3:	c3                   	ret    
  1057e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1057ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001057f0 <uartputc>:
    uartputc(*p);
}

void
uartputc(int c)
{
  1057f0:	55                   	push   %ebp
  1057f1:	89 e5                	mov    %esp,%ebp
  1057f3:	53                   	push   %ebx
  int i;

  if(!uart)
    return;
  1057f4:	31 db                	xor    %ebx,%ebx
    uartputc(*p);
}

void
uartputc(int c)
{
  1057f6:	83 ec 04             	sub    $0x4,%esp
  int i;

  if(!uart)
  1057f9:	a1 ec 8d 10 00       	mov    0x108dec,%eax
  1057fe:	85 c0                	test   %eax,%eax
  105800:	75 19                	jne    10581b <uartputc+0x2b>
  105802:	eb 2b                	jmp    10582f <uartputc+0x3f>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
  105804:	83 c3 01             	add    $0x1,%ebx
    microdelay(10);
  105807:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  10580e:	e8 cd cb ff ff       	call   1023e0 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
  105813:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
  105819:	74 0a                	je     105825 <uartputc+0x35>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  10581b:	ba fd 03 00 00       	mov    $0x3fd,%edx
  105820:	ec                   	in     (%dx),%al
  105821:	a8 20                	test   $0x20,%al
  105823:	74 df                	je     105804 <uartputc+0x14>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  105825:	ba f8 03 00 00       	mov    $0x3f8,%edx
  10582a:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
  10582e:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
  10582f:	83 c4 04             	add    $0x4,%esp
  105832:	5b                   	pop    %ebx
  105833:	5d                   	pop    %ebp
  105834:	c3                   	ret    
  105835:	8d 74 26 00          	lea    0x0(%esi),%esi
  105839:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00105840 <uartgetc>:

static int
uartgetc(void)
{
  if(!uart)
  105840:	8b 15 ec 8d 10 00    	mov    0x108dec,%edx
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
  105846:	55                   	push   %ebp
  105847:	89 e5                	mov    %esp,%ebp
  if(!uart)
  105849:	85 d2                	test   %edx,%edx
  10584b:	75 07                	jne    105854 <uartgetc+0x14>
    return -1;
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
  10584d:	5d                   	pop    %ebp
{
  if(!uart)
    return -1;
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
  10584e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  105853:	c3                   	ret    
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  105854:	ba fd 03 00 00       	mov    $0x3fd,%edx
  105859:	ec                   	in     (%dx),%al
static int
uartgetc(void)
{
  if(!uart)
    return -1;
  if(!(inb(COM1+5) & 0x01))
  10585a:	a8 01                	test   $0x1,%al
  10585c:	74 ef                	je     10584d <uartgetc+0xd>
  10585e:	b2 f8                	mov    $0xf8,%dl
  105860:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
}
  105861:	5d                   	pop    %ebp
  return data;
  105862:	0f b6 c0             	movzbl %al,%eax
  105865:	c3                   	ret    
  105866:	8d 76 00             	lea    0x0(%esi),%esi
  105869:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00105870 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
  105870:	55                   	push   %ebp
  105871:	89 e5                	mov    %esp,%ebp
  105873:	57                   	push   %edi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  105874:	bf fa 03 00 00       	mov    $0x3fa,%edi
  105879:	56                   	push   %esi
  10587a:	89 fa                	mov    %edi,%edx
  10587c:	53                   	push   %ebx
  10587d:	31 db                	xor    %ebx,%ebx
  10587f:	83 ec 0c             	sub    $0xc,%esp
  105882:	89 d8                	mov    %ebx,%eax
  105884:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  105885:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
  10588a:	b2 fb                	mov    $0xfb,%dl
  10588c:	ee                   	out    %al,(%dx)
  10588d:	be f8 03 00 00       	mov    $0x3f8,%esi
  105892:	b8 0c 00 00 00       	mov    $0xc,%eax
  105897:	89 f2                	mov    %esi,%edx
  105899:	ee                   	out    %al,(%dx)
  10589a:	b9 f9 03 00 00       	mov    $0x3f9,%ecx
  10589f:	89 d8                	mov    %ebx,%eax
  1058a1:	89 ca                	mov    %ecx,%edx
  1058a3:	ee                   	out    %al,(%dx)
  1058a4:	b8 03 00 00 00       	mov    $0x3,%eax
  1058a9:	b2 fb                	mov    $0xfb,%dl
  1058ab:	ee                   	out    %al,(%dx)
  1058ac:	b2 fc                	mov    $0xfc,%dl
  1058ae:	89 d8                	mov    %ebx,%eax
  1058b0:	ee                   	out    %al,(%dx)
  1058b1:	b8 01 00 00 00       	mov    $0x1,%eax
  1058b6:	89 ca                	mov    %ecx,%edx
  1058b8:	ee                   	out    %al,(%dx)
  1058b9:	b2 fd                	mov    $0xfd,%dl
  1058bb:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
  1058bc:	04 01                	add    $0x1,%al
  1058be:	74 56                	je     105916 <uartinit+0xa6>
    return;
  uart = 1;
  1058c0:	c7 05 ec 8d 10 00 01 	movl   $0x1,0x108dec
  1058c7:	00 00 00 
  1058ca:	89 fa                	mov    %edi,%edx
  1058cc:	ec                   	in     (%dx),%al
  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  1058cd:	89 f2                	mov    %esi,%edx
  1058cf:	ec                   	in     (%dx),%al
  1058d0:	bb b4 74 10 00       	mov    $0x1074b4,%ebx

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  picenable(IRQ_COM1);
  1058d5:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  1058dc:	e8 0f d2 ff ff       	call   102af0 <picenable>
  ioapicenable(IRQ_COM1, 0);
  1058e1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1058e8:	00 
  1058e9:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  1058f0:	e8 cb c7 ff ff       	call   1020c0 <ioapicenable>
  1058f5:	b8 78 00 00 00       	mov    $0x78,%eax
  1058fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
  105900:	0f be c0             	movsbl %al,%eax
  105903:	89 04 24             	mov    %eax,(%esp)
  105906:	e8 e5 fe ff ff       	call   1057f0 <uartputc>
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
  10590b:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
  10590f:	83 c3 01             	add    $0x1,%ebx
  105912:	84 c0                	test   %al,%al
  105914:	75 ea                	jne    105900 <uartinit+0x90>
    uartputc(*p);
}
  105916:	83 c4 0c             	add    $0xc,%esp
  105919:	5b                   	pop    %ebx
  10591a:	5e                   	pop    %esi
  10591b:	5f                   	pop    %edi
  10591c:	5d                   	pop    %ebp
  10591d:	c3                   	ret    
  10591e:	90                   	nop    
  10591f:	90                   	nop    

00105920 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
  105920:	6a 00                	push   $0x0
  pushl $0
  105922:	6a 00                	push   $0x0
  jmp alltraps
  105924:	e9 67 fb ff ff       	jmp    105490 <alltraps>

00105929 <vector1>:
.globl vector1
vector1:
  pushl $0
  105929:	6a 00                	push   $0x0
  pushl $1
  10592b:	6a 01                	push   $0x1
  jmp alltraps
  10592d:	e9 5e fb ff ff       	jmp    105490 <alltraps>

00105932 <vector2>:
.globl vector2
vector2:
  pushl $0
  105932:	6a 00                	push   $0x0
  pushl $2
  105934:	6a 02                	push   $0x2
  jmp alltraps
  105936:	e9 55 fb ff ff       	jmp    105490 <alltraps>

0010593b <vector3>:
.globl vector3
vector3:
  pushl $0
  10593b:	6a 00                	push   $0x0
  pushl $3
  10593d:	6a 03                	push   $0x3
  jmp alltraps
  10593f:	e9 4c fb ff ff       	jmp    105490 <alltraps>

00105944 <vector4>:
.globl vector4
vector4:
  pushl $0
  105944:	6a 00                	push   $0x0
  pushl $4
  105946:	6a 04                	push   $0x4
  jmp alltraps
  105948:	e9 43 fb ff ff       	jmp    105490 <alltraps>

0010594d <vector5>:
.globl vector5
vector5:
  pushl $0
  10594d:	6a 00                	push   $0x0
  pushl $5
  10594f:	6a 05                	push   $0x5
  jmp alltraps
  105951:	e9 3a fb ff ff       	jmp    105490 <alltraps>

00105956 <vector6>:
.globl vector6
vector6:
  pushl $0
  105956:	6a 00                	push   $0x0
  pushl $6
  105958:	6a 06                	push   $0x6
  jmp alltraps
  10595a:	e9 31 fb ff ff       	jmp    105490 <alltraps>

0010595f <vector7>:
.globl vector7
vector7:
  pushl $0
  10595f:	6a 00                	push   $0x0
  pushl $7
  105961:	6a 07                	push   $0x7
  jmp alltraps
  105963:	e9 28 fb ff ff       	jmp    105490 <alltraps>

00105968 <vector8>:
.globl vector8
vector8:
  pushl $8
  105968:	6a 08                	push   $0x8
  jmp alltraps
  10596a:	e9 21 fb ff ff       	jmp    105490 <alltraps>

0010596f <vector9>:
.globl vector9
vector9:
  pushl $0
  10596f:	6a 00                	push   $0x0
  pushl $9
  105971:	6a 09                	push   $0x9
  jmp alltraps
  105973:	e9 18 fb ff ff       	jmp    105490 <alltraps>

00105978 <vector10>:
.globl vector10
vector10:
  pushl $10
  105978:	6a 0a                	push   $0xa
  jmp alltraps
  10597a:	e9 11 fb ff ff       	jmp    105490 <alltraps>

0010597f <vector11>:
.globl vector11
vector11:
  pushl $11
  10597f:	6a 0b                	push   $0xb
  jmp alltraps
  105981:	e9 0a fb ff ff       	jmp    105490 <alltraps>

00105986 <vector12>:
.globl vector12
vector12:
  pushl $12
  105986:	6a 0c                	push   $0xc
  jmp alltraps
  105988:	e9 03 fb ff ff       	jmp    105490 <alltraps>

0010598d <vector13>:
.globl vector13
vector13:
  pushl $13
  10598d:	6a 0d                	push   $0xd
  jmp alltraps
  10598f:	e9 fc fa ff ff       	jmp    105490 <alltraps>

00105994 <vector14>:
.globl vector14
vector14:
  pushl $14
  105994:	6a 0e                	push   $0xe
  jmp alltraps
  105996:	e9 f5 fa ff ff       	jmp    105490 <alltraps>

0010599b <vector15>:
.globl vector15
vector15:
  pushl $0
  10599b:	6a 00                	push   $0x0
  pushl $15
  10599d:	6a 0f                	push   $0xf
  jmp alltraps
  10599f:	e9 ec fa ff ff       	jmp    105490 <alltraps>

001059a4 <vector16>:
.globl vector16
vector16:
  pushl $0
  1059a4:	6a 00                	push   $0x0
  pushl $16
  1059a6:	6a 10                	push   $0x10
  jmp alltraps
  1059a8:	e9 e3 fa ff ff       	jmp    105490 <alltraps>

001059ad <vector17>:
.globl vector17
vector17:
  pushl $17
  1059ad:	6a 11                	push   $0x11
  jmp alltraps
  1059af:	e9 dc fa ff ff       	jmp    105490 <alltraps>

001059b4 <vector18>:
.globl vector18
vector18:
  pushl $0
  1059b4:	6a 00                	push   $0x0
  pushl $18
  1059b6:	6a 12                	push   $0x12
  jmp alltraps
  1059b8:	e9 d3 fa ff ff       	jmp    105490 <alltraps>

001059bd <vector19>:
.globl vector19
vector19:
  pushl $0
  1059bd:	6a 00                	push   $0x0
  pushl $19
  1059bf:	6a 13                	push   $0x13
  jmp alltraps
  1059c1:	e9 ca fa ff ff       	jmp    105490 <alltraps>

001059c6 <vector20>:
.globl vector20
vector20:
  pushl $0
  1059c6:	6a 00                	push   $0x0
  pushl $20
  1059c8:	6a 14                	push   $0x14
  jmp alltraps
  1059ca:	e9 c1 fa ff ff       	jmp    105490 <alltraps>

001059cf <vector21>:
.globl vector21
vector21:
  pushl $0
  1059cf:	6a 00                	push   $0x0
  pushl $21
  1059d1:	6a 15                	push   $0x15
  jmp alltraps
  1059d3:	e9 b8 fa ff ff       	jmp    105490 <alltraps>

001059d8 <vector22>:
.globl vector22
vector22:
  pushl $0
  1059d8:	6a 00                	push   $0x0
  pushl $22
  1059da:	6a 16                	push   $0x16
  jmp alltraps
  1059dc:	e9 af fa ff ff       	jmp    105490 <alltraps>

001059e1 <vector23>:
.globl vector23
vector23:
  pushl $0
  1059e1:	6a 00                	push   $0x0
  pushl $23
  1059e3:	6a 17                	push   $0x17
  jmp alltraps
  1059e5:	e9 a6 fa ff ff       	jmp    105490 <alltraps>

001059ea <vector24>:
.globl vector24
vector24:
  pushl $0
  1059ea:	6a 00                	push   $0x0
  pushl $24
  1059ec:	6a 18                	push   $0x18
  jmp alltraps
  1059ee:	e9 9d fa ff ff       	jmp    105490 <alltraps>

001059f3 <vector25>:
.globl vector25
vector25:
  pushl $0
  1059f3:	6a 00                	push   $0x0
  pushl $25
  1059f5:	6a 19                	push   $0x19
  jmp alltraps
  1059f7:	e9 94 fa ff ff       	jmp    105490 <alltraps>

001059fc <vector26>:
.globl vector26
vector26:
  pushl $0
  1059fc:	6a 00                	push   $0x0
  pushl $26
  1059fe:	6a 1a                	push   $0x1a
  jmp alltraps
  105a00:	e9 8b fa ff ff       	jmp    105490 <alltraps>

00105a05 <vector27>:
.globl vector27
vector27:
  pushl $0
  105a05:	6a 00                	push   $0x0
  pushl $27
  105a07:	6a 1b                	push   $0x1b
  jmp alltraps
  105a09:	e9 82 fa ff ff       	jmp    105490 <alltraps>

00105a0e <vector28>:
.globl vector28
vector28:
  pushl $0
  105a0e:	6a 00                	push   $0x0
  pushl $28
  105a10:	6a 1c                	push   $0x1c
  jmp alltraps
  105a12:	e9 79 fa ff ff       	jmp    105490 <alltraps>

00105a17 <vector29>:
.globl vector29
vector29:
  pushl $0
  105a17:	6a 00                	push   $0x0
  pushl $29
  105a19:	6a 1d                	push   $0x1d
  jmp alltraps
  105a1b:	e9 70 fa ff ff       	jmp    105490 <alltraps>

00105a20 <vector30>:
.globl vector30
vector30:
  pushl $0
  105a20:	6a 00                	push   $0x0
  pushl $30
  105a22:	6a 1e                	push   $0x1e
  jmp alltraps
  105a24:	e9 67 fa ff ff       	jmp    105490 <alltraps>

00105a29 <vector31>:
.globl vector31
vector31:
  pushl $0
  105a29:	6a 00                	push   $0x0
  pushl $31
  105a2b:	6a 1f                	push   $0x1f
  jmp alltraps
  105a2d:	e9 5e fa ff ff       	jmp    105490 <alltraps>

00105a32 <vector32>:
.globl vector32
vector32:
  pushl $0
  105a32:	6a 00                	push   $0x0
  pushl $32
  105a34:	6a 20                	push   $0x20
  jmp alltraps
  105a36:	e9 55 fa ff ff       	jmp    105490 <alltraps>

00105a3b <vector33>:
.globl vector33
vector33:
  pushl $0
  105a3b:	6a 00                	push   $0x0
  pushl $33
  105a3d:	6a 21                	push   $0x21
  jmp alltraps
  105a3f:	e9 4c fa ff ff       	jmp    105490 <alltraps>

00105a44 <vector34>:
.globl vector34
vector34:
  pushl $0
  105a44:	6a 00                	push   $0x0
  pushl $34
  105a46:	6a 22                	push   $0x22
  jmp alltraps
  105a48:	e9 43 fa ff ff       	jmp    105490 <alltraps>

00105a4d <vector35>:
.globl vector35
vector35:
  pushl $0
  105a4d:	6a 00                	push   $0x0
  pushl $35
  105a4f:	6a 23                	push   $0x23
  jmp alltraps
  105a51:	e9 3a fa ff ff       	jmp    105490 <alltraps>

00105a56 <vector36>:
.globl vector36
vector36:
  pushl $0
  105a56:	6a 00                	push   $0x0
  pushl $36
  105a58:	6a 24                	push   $0x24
  jmp alltraps
  105a5a:	e9 31 fa ff ff       	jmp    105490 <alltraps>

00105a5f <vector37>:
.globl vector37
vector37:
  pushl $0
  105a5f:	6a 00                	push   $0x0
  pushl $37
  105a61:	6a 25                	push   $0x25
  jmp alltraps
  105a63:	e9 28 fa ff ff       	jmp    105490 <alltraps>

00105a68 <vector38>:
.globl vector38
vector38:
  pushl $0
  105a68:	6a 00                	push   $0x0
  pushl $38
  105a6a:	6a 26                	push   $0x26
  jmp alltraps
  105a6c:	e9 1f fa ff ff       	jmp    105490 <alltraps>

00105a71 <vector39>:
.globl vector39
vector39:
  pushl $0
  105a71:	6a 00                	push   $0x0
  pushl $39
  105a73:	6a 27                	push   $0x27
  jmp alltraps
  105a75:	e9 16 fa ff ff       	jmp    105490 <alltraps>

00105a7a <vector40>:
.globl vector40
vector40:
  pushl $0
  105a7a:	6a 00                	push   $0x0
  pushl $40
  105a7c:	6a 28                	push   $0x28
  jmp alltraps
  105a7e:	e9 0d fa ff ff       	jmp    105490 <alltraps>

00105a83 <vector41>:
.globl vector41
vector41:
  pushl $0
  105a83:	6a 00                	push   $0x0
  pushl $41
  105a85:	6a 29                	push   $0x29
  jmp alltraps
  105a87:	e9 04 fa ff ff       	jmp    105490 <alltraps>

00105a8c <vector42>:
.globl vector42
vector42:
  pushl $0
  105a8c:	6a 00                	push   $0x0
  pushl $42
  105a8e:	6a 2a                	push   $0x2a
  jmp alltraps
  105a90:	e9 fb f9 ff ff       	jmp    105490 <alltraps>

00105a95 <vector43>:
.globl vector43
vector43:
  pushl $0
  105a95:	6a 00                	push   $0x0
  pushl $43
  105a97:	6a 2b                	push   $0x2b
  jmp alltraps
  105a99:	e9 f2 f9 ff ff       	jmp    105490 <alltraps>

00105a9e <vector44>:
.globl vector44
vector44:
  pushl $0
  105a9e:	6a 00                	push   $0x0
  pushl $44
  105aa0:	6a 2c                	push   $0x2c
  jmp alltraps
  105aa2:	e9 e9 f9 ff ff       	jmp    105490 <alltraps>

00105aa7 <vector45>:
.globl vector45
vector45:
  pushl $0
  105aa7:	6a 00                	push   $0x0
  pushl $45
  105aa9:	6a 2d                	push   $0x2d
  jmp alltraps
  105aab:	e9 e0 f9 ff ff       	jmp    105490 <alltraps>

00105ab0 <vector46>:
.globl vector46
vector46:
  pushl $0
  105ab0:	6a 00                	push   $0x0
  pushl $46
  105ab2:	6a 2e                	push   $0x2e
  jmp alltraps
  105ab4:	e9 d7 f9 ff ff       	jmp    105490 <alltraps>

00105ab9 <vector47>:
.globl vector47
vector47:
  pushl $0
  105ab9:	6a 00                	push   $0x0
  pushl $47
  105abb:	6a 2f                	push   $0x2f
  jmp alltraps
  105abd:	e9 ce f9 ff ff       	jmp    105490 <alltraps>

00105ac2 <vector48>:
.globl vector48
vector48:
  pushl $0
  105ac2:	6a 00                	push   $0x0
  pushl $48
  105ac4:	6a 30                	push   $0x30
  jmp alltraps
  105ac6:	e9 c5 f9 ff ff       	jmp    105490 <alltraps>

00105acb <vector49>:
.globl vector49
vector49:
  pushl $0
  105acb:	6a 00                	push   $0x0
  pushl $49
  105acd:	6a 31                	push   $0x31
  jmp alltraps
  105acf:	e9 bc f9 ff ff       	jmp    105490 <alltraps>

00105ad4 <vector50>:
.globl vector50
vector50:
  pushl $0
  105ad4:	6a 00                	push   $0x0
  pushl $50
  105ad6:	6a 32                	push   $0x32
  jmp alltraps
  105ad8:	e9 b3 f9 ff ff       	jmp    105490 <alltraps>

00105add <vector51>:
.globl vector51
vector51:
  pushl $0
  105add:	6a 00                	push   $0x0
  pushl $51
  105adf:	6a 33                	push   $0x33
  jmp alltraps
  105ae1:	e9 aa f9 ff ff       	jmp    105490 <alltraps>

00105ae6 <vector52>:
.globl vector52
vector52:
  pushl $0
  105ae6:	6a 00                	push   $0x0
  pushl $52
  105ae8:	6a 34                	push   $0x34
  jmp alltraps
  105aea:	e9 a1 f9 ff ff       	jmp    105490 <alltraps>

00105aef <vector53>:
.globl vector53
vector53:
  pushl $0
  105aef:	6a 00                	push   $0x0
  pushl $53
  105af1:	6a 35                	push   $0x35
  jmp alltraps
  105af3:	e9 98 f9 ff ff       	jmp    105490 <alltraps>

00105af8 <vector54>:
.globl vector54
vector54:
  pushl $0
  105af8:	6a 00                	push   $0x0
  pushl $54
  105afa:	6a 36                	push   $0x36
  jmp alltraps
  105afc:	e9 8f f9 ff ff       	jmp    105490 <alltraps>

00105b01 <vector55>:
.globl vector55
vector55:
  pushl $0
  105b01:	6a 00                	push   $0x0
  pushl $55
  105b03:	6a 37                	push   $0x37
  jmp alltraps
  105b05:	e9 86 f9 ff ff       	jmp    105490 <alltraps>

00105b0a <vector56>:
.globl vector56
vector56:
  pushl $0
  105b0a:	6a 00                	push   $0x0
  pushl $56
  105b0c:	6a 38                	push   $0x38
  jmp alltraps
  105b0e:	e9 7d f9 ff ff       	jmp    105490 <alltraps>

00105b13 <vector57>:
.globl vector57
vector57:
  pushl $0
  105b13:	6a 00                	push   $0x0
  pushl $57
  105b15:	6a 39                	push   $0x39
  jmp alltraps
  105b17:	e9 74 f9 ff ff       	jmp    105490 <alltraps>

00105b1c <vector58>:
.globl vector58
vector58:
  pushl $0
  105b1c:	6a 00                	push   $0x0
  pushl $58
  105b1e:	6a 3a                	push   $0x3a
  jmp alltraps
  105b20:	e9 6b f9 ff ff       	jmp    105490 <alltraps>

00105b25 <vector59>:
.globl vector59
vector59:
  pushl $0
  105b25:	6a 00                	push   $0x0
  pushl $59
  105b27:	6a 3b                	push   $0x3b
  jmp alltraps
  105b29:	e9 62 f9 ff ff       	jmp    105490 <alltraps>

00105b2e <vector60>:
.globl vector60
vector60:
  pushl $0
  105b2e:	6a 00                	push   $0x0
  pushl $60
  105b30:	6a 3c                	push   $0x3c
  jmp alltraps
  105b32:	e9 59 f9 ff ff       	jmp    105490 <alltraps>

00105b37 <vector61>:
.globl vector61
vector61:
  pushl $0
  105b37:	6a 00                	push   $0x0
  pushl $61
  105b39:	6a 3d                	push   $0x3d
  jmp alltraps
  105b3b:	e9 50 f9 ff ff       	jmp    105490 <alltraps>

00105b40 <vector62>:
.globl vector62
vector62:
  pushl $0
  105b40:	6a 00                	push   $0x0
  pushl $62
  105b42:	6a 3e                	push   $0x3e
  jmp alltraps
  105b44:	e9 47 f9 ff ff       	jmp    105490 <alltraps>

00105b49 <vector63>:
.globl vector63
vector63:
  pushl $0
  105b49:	6a 00                	push   $0x0
  pushl $63
  105b4b:	6a 3f                	push   $0x3f
  jmp alltraps
  105b4d:	e9 3e f9 ff ff       	jmp    105490 <alltraps>

00105b52 <vector64>:
.globl vector64
vector64:
  pushl $0
  105b52:	6a 00                	push   $0x0
  pushl $64
  105b54:	6a 40                	push   $0x40
  jmp alltraps
  105b56:	e9 35 f9 ff ff       	jmp    105490 <alltraps>

00105b5b <vector65>:
.globl vector65
vector65:
  pushl $0
  105b5b:	6a 00                	push   $0x0
  pushl $65
  105b5d:	6a 41                	push   $0x41
  jmp alltraps
  105b5f:	e9 2c f9 ff ff       	jmp    105490 <alltraps>

00105b64 <vector66>:
.globl vector66
vector66:
  pushl $0
  105b64:	6a 00                	push   $0x0
  pushl $66
  105b66:	6a 42                	push   $0x42
  jmp alltraps
  105b68:	e9 23 f9 ff ff       	jmp    105490 <alltraps>

00105b6d <vector67>:
.globl vector67
vector67:
  pushl $0
  105b6d:	6a 00                	push   $0x0
  pushl $67
  105b6f:	6a 43                	push   $0x43
  jmp alltraps
  105b71:	e9 1a f9 ff ff       	jmp    105490 <alltraps>

00105b76 <vector68>:
.globl vector68
vector68:
  pushl $0
  105b76:	6a 00                	push   $0x0
  pushl $68
  105b78:	6a 44                	push   $0x44
  jmp alltraps
  105b7a:	e9 11 f9 ff ff       	jmp    105490 <alltraps>

00105b7f <vector69>:
.globl vector69
vector69:
  pushl $0
  105b7f:	6a 00                	push   $0x0
  pushl $69
  105b81:	6a 45                	push   $0x45
  jmp alltraps
  105b83:	e9 08 f9 ff ff       	jmp    105490 <alltraps>

00105b88 <vector70>:
.globl vector70
vector70:
  pushl $0
  105b88:	6a 00                	push   $0x0
  pushl $70
  105b8a:	6a 46                	push   $0x46
  jmp alltraps
  105b8c:	e9 ff f8 ff ff       	jmp    105490 <alltraps>

00105b91 <vector71>:
.globl vector71
vector71:
  pushl $0
  105b91:	6a 00                	push   $0x0
  pushl $71
  105b93:	6a 47                	push   $0x47
  jmp alltraps
  105b95:	e9 f6 f8 ff ff       	jmp    105490 <alltraps>

00105b9a <vector72>:
.globl vector72
vector72:
  pushl $0
  105b9a:	6a 00                	push   $0x0
  pushl $72
  105b9c:	6a 48                	push   $0x48
  jmp alltraps
  105b9e:	e9 ed f8 ff ff       	jmp    105490 <alltraps>

00105ba3 <vector73>:
.globl vector73
vector73:
  pushl $0
  105ba3:	6a 00                	push   $0x0
  pushl $73
  105ba5:	6a 49                	push   $0x49
  jmp alltraps
  105ba7:	e9 e4 f8 ff ff       	jmp    105490 <alltraps>

00105bac <vector74>:
.globl vector74
vector74:
  pushl $0
  105bac:	6a 00                	push   $0x0
  pushl $74
  105bae:	6a 4a                	push   $0x4a
  jmp alltraps
  105bb0:	e9 db f8 ff ff       	jmp    105490 <alltraps>

00105bb5 <vector75>:
.globl vector75
vector75:
  pushl $0
  105bb5:	6a 00                	push   $0x0
  pushl $75
  105bb7:	6a 4b                	push   $0x4b
  jmp alltraps
  105bb9:	e9 d2 f8 ff ff       	jmp    105490 <alltraps>

00105bbe <vector76>:
.globl vector76
vector76:
  pushl $0
  105bbe:	6a 00                	push   $0x0
  pushl $76
  105bc0:	6a 4c                	push   $0x4c
  jmp alltraps
  105bc2:	e9 c9 f8 ff ff       	jmp    105490 <alltraps>

00105bc7 <vector77>:
.globl vector77
vector77:
  pushl $0
  105bc7:	6a 00                	push   $0x0
  pushl $77
  105bc9:	6a 4d                	push   $0x4d
  jmp alltraps
  105bcb:	e9 c0 f8 ff ff       	jmp    105490 <alltraps>

00105bd0 <vector78>:
.globl vector78
vector78:
  pushl $0
  105bd0:	6a 00                	push   $0x0
  pushl $78
  105bd2:	6a 4e                	push   $0x4e
  jmp alltraps
  105bd4:	e9 b7 f8 ff ff       	jmp    105490 <alltraps>

00105bd9 <vector79>:
.globl vector79
vector79:
  pushl $0
  105bd9:	6a 00                	push   $0x0
  pushl $79
  105bdb:	6a 4f                	push   $0x4f
  jmp alltraps
  105bdd:	e9 ae f8 ff ff       	jmp    105490 <alltraps>

00105be2 <vector80>:
.globl vector80
vector80:
  pushl $0
  105be2:	6a 00                	push   $0x0
  pushl $80
  105be4:	6a 50                	push   $0x50
  jmp alltraps
  105be6:	e9 a5 f8 ff ff       	jmp    105490 <alltraps>

00105beb <vector81>:
.globl vector81
vector81:
  pushl $0
  105beb:	6a 00                	push   $0x0
  pushl $81
  105bed:	6a 51                	push   $0x51
  jmp alltraps
  105bef:	e9 9c f8 ff ff       	jmp    105490 <alltraps>

00105bf4 <vector82>:
.globl vector82
vector82:
  pushl $0
  105bf4:	6a 00                	push   $0x0
  pushl $82
  105bf6:	6a 52                	push   $0x52
  jmp alltraps
  105bf8:	e9 93 f8 ff ff       	jmp    105490 <alltraps>

00105bfd <vector83>:
.globl vector83
vector83:
  pushl $0
  105bfd:	6a 00                	push   $0x0
  pushl $83
  105bff:	6a 53                	push   $0x53
  jmp alltraps
  105c01:	e9 8a f8 ff ff       	jmp    105490 <alltraps>

00105c06 <vector84>:
.globl vector84
vector84:
  pushl $0
  105c06:	6a 00                	push   $0x0
  pushl $84
  105c08:	6a 54                	push   $0x54
  jmp alltraps
  105c0a:	e9 81 f8 ff ff       	jmp    105490 <alltraps>

00105c0f <vector85>:
.globl vector85
vector85:
  pushl $0
  105c0f:	6a 00                	push   $0x0
  pushl $85
  105c11:	6a 55                	push   $0x55
  jmp alltraps
  105c13:	e9 78 f8 ff ff       	jmp    105490 <alltraps>

00105c18 <vector86>:
.globl vector86
vector86:
  pushl $0
  105c18:	6a 00                	push   $0x0
  pushl $86
  105c1a:	6a 56                	push   $0x56
  jmp alltraps
  105c1c:	e9 6f f8 ff ff       	jmp    105490 <alltraps>

00105c21 <vector87>:
.globl vector87
vector87:
  pushl $0
  105c21:	6a 00                	push   $0x0
  pushl $87
  105c23:	6a 57                	push   $0x57
  jmp alltraps
  105c25:	e9 66 f8 ff ff       	jmp    105490 <alltraps>

00105c2a <vector88>:
.globl vector88
vector88:
  pushl $0
  105c2a:	6a 00                	push   $0x0
  pushl $88
  105c2c:	6a 58                	push   $0x58
  jmp alltraps
  105c2e:	e9 5d f8 ff ff       	jmp    105490 <alltraps>

00105c33 <vector89>:
.globl vector89
vector89:
  pushl $0
  105c33:	6a 00                	push   $0x0
  pushl $89
  105c35:	6a 59                	push   $0x59
  jmp alltraps
  105c37:	e9 54 f8 ff ff       	jmp    105490 <alltraps>

00105c3c <vector90>:
.globl vector90
vector90:
  pushl $0
  105c3c:	6a 00                	push   $0x0
  pushl $90
  105c3e:	6a 5a                	push   $0x5a
  jmp alltraps
  105c40:	e9 4b f8 ff ff       	jmp    105490 <alltraps>

00105c45 <vector91>:
.globl vector91
vector91:
  pushl $0
  105c45:	6a 00                	push   $0x0
  pushl $91
  105c47:	6a 5b                	push   $0x5b
  jmp alltraps
  105c49:	e9 42 f8 ff ff       	jmp    105490 <alltraps>

00105c4e <vector92>:
.globl vector92
vector92:
  pushl $0
  105c4e:	6a 00                	push   $0x0
  pushl $92
  105c50:	6a 5c                	push   $0x5c
  jmp alltraps
  105c52:	e9 39 f8 ff ff       	jmp    105490 <alltraps>

00105c57 <vector93>:
.globl vector93
vector93:
  pushl $0
  105c57:	6a 00                	push   $0x0
  pushl $93
  105c59:	6a 5d                	push   $0x5d
  jmp alltraps
  105c5b:	e9 30 f8 ff ff       	jmp    105490 <alltraps>

00105c60 <vector94>:
.globl vector94
vector94:
  pushl $0
  105c60:	6a 00                	push   $0x0
  pushl $94
  105c62:	6a 5e                	push   $0x5e
  jmp alltraps
  105c64:	e9 27 f8 ff ff       	jmp    105490 <alltraps>

00105c69 <vector95>:
.globl vector95
vector95:
  pushl $0
  105c69:	6a 00                	push   $0x0
  pushl $95
  105c6b:	6a 5f                	push   $0x5f
  jmp alltraps
  105c6d:	e9 1e f8 ff ff       	jmp    105490 <alltraps>

00105c72 <vector96>:
.globl vector96
vector96:
  pushl $0
  105c72:	6a 00                	push   $0x0
  pushl $96
  105c74:	6a 60                	push   $0x60
  jmp alltraps
  105c76:	e9 15 f8 ff ff       	jmp    105490 <alltraps>

00105c7b <vector97>:
.globl vector97
vector97:
  pushl $0
  105c7b:	6a 00                	push   $0x0
  pushl $97
  105c7d:	6a 61                	push   $0x61
  jmp alltraps
  105c7f:	e9 0c f8 ff ff       	jmp    105490 <alltraps>

00105c84 <vector98>:
.globl vector98
vector98:
  pushl $0
  105c84:	6a 00                	push   $0x0
  pushl $98
  105c86:	6a 62                	push   $0x62
  jmp alltraps
  105c88:	e9 03 f8 ff ff       	jmp    105490 <alltraps>

00105c8d <vector99>:
.globl vector99
vector99:
  pushl $0
  105c8d:	6a 00                	push   $0x0
  pushl $99
  105c8f:	6a 63                	push   $0x63
  jmp alltraps
  105c91:	e9 fa f7 ff ff       	jmp    105490 <alltraps>

00105c96 <vector100>:
.globl vector100
vector100:
  pushl $0
  105c96:	6a 00                	push   $0x0
  pushl $100
  105c98:	6a 64                	push   $0x64
  jmp alltraps
  105c9a:	e9 f1 f7 ff ff       	jmp    105490 <alltraps>

00105c9f <vector101>:
.globl vector101
vector101:
  pushl $0
  105c9f:	6a 00                	push   $0x0
  pushl $101
  105ca1:	6a 65                	push   $0x65
  jmp alltraps
  105ca3:	e9 e8 f7 ff ff       	jmp    105490 <alltraps>

00105ca8 <vector102>:
.globl vector102
vector102:
  pushl $0
  105ca8:	6a 00                	push   $0x0
  pushl $102
  105caa:	6a 66                	push   $0x66
  jmp alltraps
  105cac:	e9 df f7 ff ff       	jmp    105490 <alltraps>

00105cb1 <vector103>:
.globl vector103
vector103:
  pushl $0
  105cb1:	6a 00                	push   $0x0
  pushl $103
  105cb3:	6a 67                	push   $0x67
  jmp alltraps
  105cb5:	e9 d6 f7 ff ff       	jmp    105490 <alltraps>

00105cba <vector104>:
.globl vector104
vector104:
  pushl $0
  105cba:	6a 00                	push   $0x0
  pushl $104
  105cbc:	6a 68                	push   $0x68
  jmp alltraps
  105cbe:	e9 cd f7 ff ff       	jmp    105490 <alltraps>

00105cc3 <vector105>:
.globl vector105
vector105:
  pushl $0
  105cc3:	6a 00                	push   $0x0
  pushl $105
  105cc5:	6a 69                	push   $0x69
  jmp alltraps
  105cc7:	e9 c4 f7 ff ff       	jmp    105490 <alltraps>

00105ccc <vector106>:
.globl vector106
vector106:
  pushl $0
  105ccc:	6a 00                	push   $0x0
  pushl $106
  105cce:	6a 6a                	push   $0x6a
  jmp alltraps
  105cd0:	e9 bb f7 ff ff       	jmp    105490 <alltraps>

00105cd5 <vector107>:
.globl vector107
vector107:
  pushl $0
  105cd5:	6a 00                	push   $0x0
  pushl $107
  105cd7:	6a 6b                	push   $0x6b
  jmp alltraps
  105cd9:	e9 b2 f7 ff ff       	jmp    105490 <alltraps>

00105cde <vector108>:
.globl vector108
vector108:
  pushl $0
  105cde:	6a 00                	push   $0x0
  pushl $108
  105ce0:	6a 6c                	push   $0x6c
  jmp alltraps
  105ce2:	e9 a9 f7 ff ff       	jmp    105490 <alltraps>

00105ce7 <vector109>:
.globl vector109
vector109:
  pushl $0
  105ce7:	6a 00                	push   $0x0
  pushl $109
  105ce9:	6a 6d                	push   $0x6d
  jmp alltraps
  105ceb:	e9 a0 f7 ff ff       	jmp    105490 <alltraps>

00105cf0 <vector110>:
.globl vector110
vector110:
  pushl $0
  105cf0:	6a 00                	push   $0x0
  pushl $110
  105cf2:	6a 6e                	push   $0x6e
  jmp alltraps
  105cf4:	e9 97 f7 ff ff       	jmp    105490 <alltraps>

00105cf9 <vector111>:
.globl vector111
vector111:
  pushl $0
  105cf9:	6a 00                	push   $0x0
  pushl $111
  105cfb:	6a 6f                	push   $0x6f
  jmp alltraps
  105cfd:	e9 8e f7 ff ff       	jmp    105490 <alltraps>

00105d02 <vector112>:
.globl vector112
vector112:
  pushl $0
  105d02:	6a 00                	push   $0x0
  pushl $112
  105d04:	6a 70                	push   $0x70
  jmp alltraps
  105d06:	e9 85 f7 ff ff       	jmp    105490 <alltraps>

00105d0b <vector113>:
.globl vector113
vector113:
  pushl $0
  105d0b:	6a 00                	push   $0x0
  pushl $113
  105d0d:	6a 71                	push   $0x71
  jmp alltraps
  105d0f:	e9 7c f7 ff ff       	jmp    105490 <alltraps>

00105d14 <vector114>:
.globl vector114
vector114:
  pushl $0
  105d14:	6a 00                	push   $0x0
  pushl $114
  105d16:	6a 72                	push   $0x72
  jmp alltraps
  105d18:	e9 73 f7 ff ff       	jmp    105490 <alltraps>

00105d1d <vector115>:
.globl vector115
vector115:
  pushl $0
  105d1d:	6a 00                	push   $0x0
  pushl $115
  105d1f:	6a 73                	push   $0x73
  jmp alltraps
  105d21:	e9 6a f7 ff ff       	jmp    105490 <alltraps>

00105d26 <vector116>:
.globl vector116
vector116:
  pushl $0
  105d26:	6a 00                	push   $0x0
  pushl $116
  105d28:	6a 74                	push   $0x74
  jmp alltraps
  105d2a:	e9 61 f7 ff ff       	jmp    105490 <alltraps>

00105d2f <vector117>:
.globl vector117
vector117:
  pushl $0
  105d2f:	6a 00                	push   $0x0
  pushl $117
  105d31:	6a 75                	push   $0x75
  jmp alltraps
  105d33:	e9 58 f7 ff ff       	jmp    105490 <alltraps>

00105d38 <vector118>:
.globl vector118
vector118:
  pushl $0
  105d38:	6a 00                	push   $0x0
  pushl $118
  105d3a:	6a 76                	push   $0x76
  jmp alltraps
  105d3c:	e9 4f f7 ff ff       	jmp    105490 <alltraps>

00105d41 <vector119>:
.globl vector119
vector119:
  pushl $0
  105d41:	6a 00                	push   $0x0
  pushl $119
  105d43:	6a 77                	push   $0x77
  jmp alltraps
  105d45:	e9 46 f7 ff ff       	jmp    105490 <alltraps>

00105d4a <vector120>:
.globl vector120
vector120:
  pushl $0
  105d4a:	6a 00                	push   $0x0
  pushl $120
  105d4c:	6a 78                	push   $0x78
  jmp alltraps
  105d4e:	e9 3d f7 ff ff       	jmp    105490 <alltraps>

00105d53 <vector121>:
.globl vector121
vector121:
  pushl $0
  105d53:	6a 00                	push   $0x0
  pushl $121
  105d55:	6a 79                	push   $0x79
  jmp alltraps
  105d57:	e9 34 f7 ff ff       	jmp    105490 <alltraps>

00105d5c <vector122>:
.globl vector122
vector122:
  pushl $0
  105d5c:	6a 00                	push   $0x0
  pushl $122
  105d5e:	6a 7a                	push   $0x7a
  jmp alltraps
  105d60:	e9 2b f7 ff ff       	jmp    105490 <alltraps>

00105d65 <vector123>:
.globl vector123
vector123:
  pushl $0
  105d65:	6a 00                	push   $0x0
  pushl $123
  105d67:	6a 7b                	push   $0x7b
  jmp alltraps
  105d69:	e9 22 f7 ff ff       	jmp    105490 <alltraps>

00105d6e <vector124>:
.globl vector124
vector124:
  pushl $0
  105d6e:	6a 00                	push   $0x0
  pushl $124
  105d70:	6a 7c                	push   $0x7c
  jmp alltraps
  105d72:	e9 19 f7 ff ff       	jmp    105490 <alltraps>

00105d77 <vector125>:
.globl vector125
vector125:
  pushl $0
  105d77:	6a 00                	push   $0x0
  pushl $125
  105d79:	6a 7d                	push   $0x7d
  jmp alltraps
  105d7b:	e9 10 f7 ff ff       	jmp    105490 <alltraps>

00105d80 <vector126>:
.globl vector126
vector126:
  pushl $0
  105d80:	6a 00                	push   $0x0
  pushl $126
  105d82:	6a 7e                	push   $0x7e
  jmp alltraps
  105d84:	e9 07 f7 ff ff       	jmp    105490 <alltraps>

00105d89 <vector127>:
.globl vector127
vector127:
  pushl $0
  105d89:	6a 00                	push   $0x0
  pushl $127
  105d8b:	6a 7f                	push   $0x7f
  jmp alltraps
  105d8d:	e9 fe f6 ff ff       	jmp    105490 <alltraps>

00105d92 <vector128>:
.globl vector128
vector128:
  pushl $0
  105d92:	6a 00                	push   $0x0
  pushl $128
  105d94:	68 80 00 00 00       	push   $0x80
  jmp alltraps
  105d99:	e9 f2 f6 ff ff       	jmp    105490 <alltraps>

00105d9e <vector129>:
.globl vector129
vector129:
  pushl $0
  105d9e:	6a 00                	push   $0x0
  pushl $129
  105da0:	68 81 00 00 00       	push   $0x81
  jmp alltraps
  105da5:	e9 e6 f6 ff ff       	jmp    105490 <alltraps>

00105daa <vector130>:
.globl vector130
vector130:
  pushl $0
  105daa:	6a 00                	push   $0x0
  pushl $130
  105dac:	68 82 00 00 00       	push   $0x82
  jmp alltraps
  105db1:	e9 da f6 ff ff       	jmp    105490 <alltraps>

00105db6 <vector131>:
.globl vector131
vector131:
  pushl $0
  105db6:	6a 00                	push   $0x0
  pushl $131
  105db8:	68 83 00 00 00       	push   $0x83
  jmp alltraps
  105dbd:	e9 ce f6 ff ff       	jmp    105490 <alltraps>

00105dc2 <vector132>:
.globl vector132
vector132:
  pushl $0
  105dc2:	6a 00                	push   $0x0
  pushl $132
  105dc4:	68 84 00 00 00       	push   $0x84
  jmp alltraps
  105dc9:	e9 c2 f6 ff ff       	jmp    105490 <alltraps>

00105dce <vector133>:
.globl vector133
vector133:
  pushl $0
  105dce:	6a 00                	push   $0x0
  pushl $133
  105dd0:	68 85 00 00 00       	push   $0x85
  jmp alltraps
  105dd5:	e9 b6 f6 ff ff       	jmp    105490 <alltraps>

00105dda <vector134>:
.globl vector134
vector134:
  pushl $0
  105dda:	6a 00                	push   $0x0
  pushl $134
  105ddc:	68 86 00 00 00       	push   $0x86
  jmp alltraps
  105de1:	e9 aa f6 ff ff       	jmp    105490 <alltraps>

00105de6 <vector135>:
.globl vector135
vector135:
  pushl $0
  105de6:	6a 00                	push   $0x0
  pushl $135
  105de8:	68 87 00 00 00       	push   $0x87
  jmp alltraps
  105ded:	e9 9e f6 ff ff       	jmp    105490 <alltraps>

00105df2 <vector136>:
.globl vector136
vector136:
  pushl $0
  105df2:	6a 00                	push   $0x0
  pushl $136
  105df4:	68 88 00 00 00       	push   $0x88
  jmp alltraps
  105df9:	e9 92 f6 ff ff       	jmp    105490 <alltraps>

00105dfe <vector137>:
.globl vector137
vector137:
  pushl $0
  105dfe:	6a 00                	push   $0x0
  pushl $137
  105e00:	68 89 00 00 00       	push   $0x89
  jmp alltraps
  105e05:	e9 86 f6 ff ff       	jmp    105490 <alltraps>

00105e0a <vector138>:
.globl vector138
vector138:
  pushl $0
  105e0a:	6a 00                	push   $0x0
  pushl $138
  105e0c:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
  105e11:	e9 7a f6 ff ff       	jmp    105490 <alltraps>

00105e16 <vector139>:
.globl vector139
vector139:
  pushl $0
  105e16:	6a 00                	push   $0x0
  pushl $139
  105e18:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
  105e1d:	e9 6e f6 ff ff       	jmp    105490 <alltraps>

00105e22 <vector140>:
.globl vector140
vector140:
  pushl $0
  105e22:	6a 00                	push   $0x0
  pushl $140
  105e24:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
  105e29:	e9 62 f6 ff ff       	jmp    105490 <alltraps>

00105e2e <vector141>:
.globl vector141
vector141:
  pushl $0
  105e2e:	6a 00                	push   $0x0
  pushl $141
  105e30:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
  105e35:	e9 56 f6 ff ff       	jmp    105490 <alltraps>

00105e3a <vector142>:
.globl vector142
vector142:
  pushl $0
  105e3a:	6a 00                	push   $0x0
  pushl $142
  105e3c:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
  105e41:	e9 4a f6 ff ff       	jmp    105490 <alltraps>

00105e46 <vector143>:
.globl vector143
vector143:
  pushl $0
  105e46:	6a 00                	push   $0x0
  pushl $143
  105e48:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
  105e4d:	e9 3e f6 ff ff       	jmp    105490 <alltraps>

00105e52 <vector144>:
.globl vector144
vector144:
  pushl $0
  105e52:	6a 00                	push   $0x0
  pushl $144
  105e54:	68 90 00 00 00       	push   $0x90
  jmp alltraps
  105e59:	e9 32 f6 ff ff       	jmp    105490 <alltraps>

00105e5e <vector145>:
.globl vector145
vector145:
  pushl $0
  105e5e:	6a 00                	push   $0x0
  pushl $145
  105e60:	68 91 00 00 00       	push   $0x91
  jmp alltraps
  105e65:	e9 26 f6 ff ff       	jmp    105490 <alltraps>

00105e6a <vector146>:
.globl vector146
vector146:
  pushl $0
  105e6a:	6a 00                	push   $0x0
  pushl $146
  105e6c:	68 92 00 00 00       	push   $0x92
  jmp alltraps
  105e71:	e9 1a f6 ff ff       	jmp    105490 <alltraps>

00105e76 <vector147>:
.globl vector147
vector147:
  pushl $0
  105e76:	6a 00                	push   $0x0
  pushl $147
  105e78:	68 93 00 00 00       	push   $0x93
  jmp alltraps
  105e7d:	e9 0e f6 ff ff       	jmp    105490 <alltraps>

00105e82 <vector148>:
.globl vector148
vector148:
  pushl $0
  105e82:	6a 00                	push   $0x0
  pushl $148
  105e84:	68 94 00 00 00       	push   $0x94
  jmp alltraps
  105e89:	e9 02 f6 ff ff       	jmp    105490 <alltraps>

00105e8e <vector149>:
.globl vector149
vector149:
  pushl $0
  105e8e:	6a 00                	push   $0x0
  pushl $149
  105e90:	68 95 00 00 00       	push   $0x95
  jmp alltraps
  105e95:	e9 f6 f5 ff ff       	jmp    105490 <alltraps>

00105e9a <vector150>:
.globl vector150
vector150:
  pushl $0
  105e9a:	6a 00                	push   $0x0
  pushl $150
  105e9c:	68 96 00 00 00       	push   $0x96
  jmp alltraps
  105ea1:	e9 ea f5 ff ff       	jmp    105490 <alltraps>

00105ea6 <vector151>:
.globl vector151
vector151:
  pushl $0
  105ea6:	6a 00                	push   $0x0
  pushl $151
  105ea8:	68 97 00 00 00       	push   $0x97
  jmp alltraps
  105ead:	e9 de f5 ff ff       	jmp    105490 <alltraps>

00105eb2 <vector152>:
.globl vector152
vector152:
  pushl $0
  105eb2:	6a 00                	push   $0x0
  pushl $152
  105eb4:	68 98 00 00 00       	push   $0x98
  jmp alltraps
  105eb9:	e9 d2 f5 ff ff       	jmp    105490 <alltraps>

00105ebe <vector153>:
.globl vector153
vector153:
  pushl $0
  105ebe:	6a 00                	push   $0x0
  pushl $153
  105ec0:	68 99 00 00 00       	push   $0x99
  jmp alltraps
  105ec5:	e9 c6 f5 ff ff       	jmp    105490 <alltraps>

00105eca <vector154>:
.globl vector154
vector154:
  pushl $0
  105eca:	6a 00                	push   $0x0
  pushl $154
  105ecc:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
  105ed1:	e9 ba f5 ff ff       	jmp    105490 <alltraps>

00105ed6 <vector155>:
.globl vector155
vector155:
  pushl $0
  105ed6:	6a 00                	push   $0x0
  pushl $155
  105ed8:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
  105edd:	e9 ae f5 ff ff       	jmp    105490 <alltraps>

00105ee2 <vector156>:
.globl vector156
vector156:
  pushl $0
  105ee2:	6a 00                	push   $0x0
  pushl $156
  105ee4:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
  105ee9:	e9 a2 f5 ff ff       	jmp    105490 <alltraps>

00105eee <vector157>:
.globl vector157
vector157:
  pushl $0
  105eee:	6a 00                	push   $0x0
  pushl $157
  105ef0:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
  105ef5:	e9 96 f5 ff ff       	jmp    105490 <alltraps>

00105efa <vector158>:
.globl vector158
vector158:
  pushl $0
  105efa:	6a 00                	push   $0x0
  pushl $158
  105efc:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
  105f01:	e9 8a f5 ff ff       	jmp    105490 <alltraps>

00105f06 <vector159>:
.globl vector159
vector159:
  pushl $0
  105f06:	6a 00                	push   $0x0
  pushl $159
  105f08:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
  105f0d:	e9 7e f5 ff ff       	jmp    105490 <alltraps>

00105f12 <vector160>:
.globl vector160
vector160:
  pushl $0
  105f12:	6a 00                	push   $0x0
  pushl $160
  105f14:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
  105f19:	e9 72 f5 ff ff       	jmp    105490 <alltraps>

00105f1e <vector161>:
.globl vector161
vector161:
  pushl $0
  105f1e:	6a 00                	push   $0x0
  pushl $161
  105f20:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
  105f25:	e9 66 f5 ff ff       	jmp    105490 <alltraps>

00105f2a <vector162>:
.globl vector162
vector162:
  pushl $0
  105f2a:	6a 00                	push   $0x0
  pushl $162
  105f2c:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
  105f31:	e9 5a f5 ff ff       	jmp    105490 <alltraps>

00105f36 <vector163>:
.globl vector163
vector163:
  pushl $0
  105f36:	6a 00                	push   $0x0
  pushl $163
  105f38:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
  105f3d:	e9 4e f5 ff ff       	jmp    105490 <alltraps>

00105f42 <vector164>:
.globl vector164
vector164:
  pushl $0
  105f42:	6a 00                	push   $0x0
  pushl $164
  105f44:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
  105f49:	e9 42 f5 ff ff       	jmp    105490 <alltraps>

00105f4e <vector165>:
.globl vector165
vector165:
  pushl $0
  105f4e:	6a 00                	push   $0x0
  pushl $165
  105f50:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
  105f55:	e9 36 f5 ff ff       	jmp    105490 <alltraps>

00105f5a <vector166>:
.globl vector166
vector166:
  pushl $0
  105f5a:	6a 00                	push   $0x0
  pushl $166
  105f5c:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
  105f61:	e9 2a f5 ff ff       	jmp    105490 <alltraps>

00105f66 <vector167>:
.globl vector167
vector167:
  pushl $0
  105f66:	6a 00                	push   $0x0
  pushl $167
  105f68:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
  105f6d:	e9 1e f5 ff ff       	jmp    105490 <alltraps>

00105f72 <vector168>:
.globl vector168
vector168:
  pushl $0
  105f72:	6a 00                	push   $0x0
  pushl $168
  105f74:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
  105f79:	e9 12 f5 ff ff       	jmp    105490 <alltraps>

00105f7e <vector169>:
.globl vector169
vector169:
  pushl $0
  105f7e:	6a 00                	push   $0x0
  pushl $169
  105f80:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
  105f85:	e9 06 f5 ff ff       	jmp    105490 <alltraps>

00105f8a <vector170>:
.globl vector170
vector170:
  pushl $0
  105f8a:	6a 00                	push   $0x0
  pushl $170
  105f8c:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
  105f91:	e9 fa f4 ff ff       	jmp    105490 <alltraps>

00105f96 <vector171>:
.globl vector171
vector171:
  pushl $0
  105f96:	6a 00                	push   $0x0
  pushl $171
  105f98:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
  105f9d:	e9 ee f4 ff ff       	jmp    105490 <alltraps>

00105fa2 <vector172>:
.globl vector172
vector172:
  pushl $0
  105fa2:	6a 00                	push   $0x0
  pushl $172
  105fa4:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
  105fa9:	e9 e2 f4 ff ff       	jmp    105490 <alltraps>

00105fae <vector173>:
.globl vector173
vector173:
  pushl $0
  105fae:	6a 00                	push   $0x0
  pushl $173
  105fb0:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
  105fb5:	e9 d6 f4 ff ff       	jmp    105490 <alltraps>

00105fba <vector174>:
.globl vector174
vector174:
  pushl $0
  105fba:	6a 00                	push   $0x0
  pushl $174
  105fbc:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
  105fc1:	e9 ca f4 ff ff       	jmp    105490 <alltraps>

00105fc6 <vector175>:
.globl vector175
vector175:
  pushl $0
  105fc6:	6a 00                	push   $0x0
  pushl $175
  105fc8:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
  105fcd:	e9 be f4 ff ff       	jmp    105490 <alltraps>

00105fd2 <vector176>:
.globl vector176
vector176:
  pushl $0
  105fd2:	6a 00                	push   $0x0
  pushl $176
  105fd4:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
  105fd9:	e9 b2 f4 ff ff       	jmp    105490 <alltraps>

00105fde <vector177>:
.globl vector177
vector177:
  pushl $0
  105fde:	6a 00                	push   $0x0
  pushl $177
  105fe0:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
  105fe5:	e9 a6 f4 ff ff       	jmp    105490 <alltraps>

00105fea <vector178>:
.globl vector178
vector178:
  pushl $0
  105fea:	6a 00                	push   $0x0
  pushl $178
  105fec:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
  105ff1:	e9 9a f4 ff ff       	jmp    105490 <alltraps>

00105ff6 <vector179>:
.globl vector179
vector179:
  pushl $0
  105ff6:	6a 00                	push   $0x0
  pushl $179
  105ff8:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
  105ffd:	e9 8e f4 ff ff       	jmp    105490 <alltraps>

00106002 <vector180>:
.globl vector180
vector180:
  pushl $0
  106002:	6a 00                	push   $0x0
  pushl $180
  106004:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
  106009:	e9 82 f4 ff ff       	jmp    105490 <alltraps>

0010600e <vector181>:
.globl vector181
vector181:
  pushl $0
  10600e:	6a 00                	push   $0x0
  pushl $181
  106010:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
  106015:	e9 76 f4 ff ff       	jmp    105490 <alltraps>

0010601a <vector182>:
.globl vector182
vector182:
  pushl $0
  10601a:	6a 00                	push   $0x0
  pushl $182
  10601c:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
  106021:	e9 6a f4 ff ff       	jmp    105490 <alltraps>

00106026 <vector183>:
.globl vector183
vector183:
  pushl $0
  106026:	6a 00                	push   $0x0
  pushl $183
  106028:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
  10602d:	e9 5e f4 ff ff       	jmp    105490 <alltraps>

00106032 <vector184>:
.globl vector184
vector184:
  pushl $0
  106032:	6a 00                	push   $0x0
  pushl $184
  106034:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
  106039:	e9 52 f4 ff ff       	jmp    105490 <alltraps>

0010603e <vector185>:
.globl vector185
vector185:
  pushl $0
  10603e:	6a 00                	push   $0x0
  pushl $185
  106040:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
  106045:	e9 46 f4 ff ff       	jmp    105490 <alltraps>

0010604a <vector186>:
.globl vector186
vector186:
  pushl $0
  10604a:	6a 00                	push   $0x0
  pushl $186
  10604c:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
  106051:	e9 3a f4 ff ff       	jmp    105490 <alltraps>

00106056 <vector187>:
.globl vector187
vector187:
  pushl $0
  106056:	6a 00                	push   $0x0
  pushl $187
  106058:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
  10605d:	e9 2e f4 ff ff       	jmp    105490 <alltraps>

00106062 <vector188>:
.globl vector188
vector188:
  pushl $0
  106062:	6a 00                	push   $0x0
  pushl $188
  106064:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
  106069:	e9 22 f4 ff ff       	jmp    105490 <alltraps>

0010606e <vector189>:
.globl vector189
vector189:
  pushl $0
  10606e:	6a 00                	push   $0x0
  pushl $189
  106070:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
  106075:	e9 16 f4 ff ff       	jmp    105490 <alltraps>

0010607a <vector190>:
.globl vector190
vector190:
  pushl $0
  10607a:	6a 00                	push   $0x0
  pushl $190
  10607c:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
  106081:	e9 0a f4 ff ff       	jmp    105490 <alltraps>

00106086 <vector191>:
.globl vector191
vector191:
  pushl $0
  106086:	6a 00                	push   $0x0
  pushl $191
  106088:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
  10608d:	e9 fe f3 ff ff       	jmp    105490 <alltraps>

00106092 <vector192>:
.globl vector192
vector192:
  pushl $0
  106092:	6a 00                	push   $0x0
  pushl $192
  106094:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
  106099:	e9 f2 f3 ff ff       	jmp    105490 <alltraps>

0010609e <vector193>:
.globl vector193
vector193:
  pushl $0
  10609e:	6a 00                	push   $0x0
  pushl $193
  1060a0:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
  1060a5:	e9 e6 f3 ff ff       	jmp    105490 <alltraps>

001060aa <vector194>:
.globl vector194
vector194:
  pushl $0
  1060aa:	6a 00                	push   $0x0
  pushl $194
  1060ac:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
  1060b1:	e9 da f3 ff ff       	jmp    105490 <alltraps>

001060b6 <vector195>:
.globl vector195
vector195:
  pushl $0
  1060b6:	6a 00                	push   $0x0
  pushl $195
  1060b8:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
  1060bd:	e9 ce f3 ff ff       	jmp    105490 <alltraps>

001060c2 <vector196>:
.globl vector196
vector196:
  pushl $0
  1060c2:	6a 00                	push   $0x0
  pushl $196
  1060c4:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
  1060c9:	e9 c2 f3 ff ff       	jmp    105490 <alltraps>

001060ce <vector197>:
.globl vector197
vector197:
  pushl $0
  1060ce:	6a 00                	push   $0x0
  pushl $197
  1060d0:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
  1060d5:	e9 b6 f3 ff ff       	jmp    105490 <alltraps>

001060da <vector198>:
.globl vector198
vector198:
  pushl $0
  1060da:	6a 00                	push   $0x0
  pushl $198
  1060dc:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
  1060e1:	e9 aa f3 ff ff       	jmp    105490 <alltraps>

001060e6 <vector199>:
.globl vector199
vector199:
  pushl $0
  1060e6:	6a 00                	push   $0x0
  pushl $199
  1060e8:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
  1060ed:	e9 9e f3 ff ff       	jmp    105490 <alltraps>

001060f2 <vector200>:
.globl vector200
vector200:
  pushl $0
  1060f2:	6a 00                	push   $0x0
  pushl $200
  1060f4:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
  1060f9:	e9 92 f3 ff ff       	jmp    105490 <alltraps>

001060fe <vector201>:
.globl vector201
vector201:
  pushl $0
  1060fe:	6a 00                	push   $0x0
  pushl $201
  106100:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
  106105:	e9 86 f3 ff ff       	jmp    105490 <alltraps>

0010610a <vector202>:
.globl vector202
vector202:
  pushl $0
  10610a:	6a 00                	push   $0x0
  pushl $202
  10610c:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
  106111:	e9 7a f3 ff ff       	jmp    105490 <alltraps>

00106116 <vector203>:
.globl vector203
vector203:
  pushl $0
  106116:	6a 00                	push   $0x0
  pushl $203
  106118:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
  10611d:	e9 6e f3 ff ff       	jmp    105490 <alltraps>

00106122 <vector204>:
.globl vector204
vector204:
  pushl $0
  106122:	6a 00                	push   $0x0
  pushl $204
  106124:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
  106129:	e9 62 f3 ff ff       	jmp    105490 <alltraps>

0010612e <vector205>:
.globl vector205
vector205:
  pushl $0
  10612e:	6a 00                	push   $0x0
  pushl $205
  106130:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
  106135:	e9 56 f3 ff ff       	jmp    105490 <alltraps>

0010613a <vector206>:
.globl vector206
vector206:
  pushl $0
  10613a:	6a 00                	push   $0x0
  pushl $206
  10613c:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
  106141:	e9 4a f3 ff ff       	jmp    105490 <alltraps>

00106146 <vector207>:
.globl vector207
vector207:
  pushl $0
  106146:	6a 00                	push   $0x0
  pushl $207
  106148:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
  10614d:	e9 3e f3 ff ff       	jmp    105490 <alltraps>

00106152 <vector208>:
.globl vector208
vector208:
  pushl $0
  106152:	6a 00                	push   $0x0
  pushl $208
  106154:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
  106159:	e9 32 f3 ff ff       	jmp    105490 <alltraps>

0010615e <vector209>:
.globl vector209
vector209:
  pushl $0
  10615e:	6a 00                	push   $0x0
  pushl $209
  106160:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
  106165:	e9 26 f3 ff ff       	jmp    105490 <alltraps>

0010616a <vector210>:
.globl vector210
vector210:
  pushl $0
  10616a:	6a 00                	push   $0x0
  pushl $210
  10616c:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
  106171:	e9 1a f3 ff ff       	jmp    105490 <alltraps>

00106176 <vector211>:
.globl vector211
vector211:
  pushl $0
  106176:	6a 00                	push   $0x0
  pushl $211
  106178:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
  10617d:	e9 0e f3 ff ff       	jmp    105490 <alltraps>

00106182 <vector212>:
.globl vector212
vector212:
  pushl $0
  106182:	6a 00                	push   $0x0
  pushl $212
  106184:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
  106189:	e9 02 f3 ff ff       	jmp    105490 <alltraps>

0010618e <vector213>:
.globl vector213
vector213:
  pushl $0
  10618e:	6a 00                	push   $0x0
  pushl $213
  106190:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
  106195:	e9 f6 f2 ff ff       	jmp    105490 <alltraps>

0010619a <vector214>:
.globl vector214
vector214:
  pushl $0
  10619a:	6a 00                	push   $0x0
  pushl $214
  10619c:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
  1061a1:	e9 ea f2 ff ff       	jmp    105490 <alltraps>

001061a6 <vector215>:
.globl vector215
vector215:
  pushl $0
  1061a6:	6a 00                	push   $0x0
  pushl $215
  1061a8:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
  1061ad:	e9 de f2 ff ff       	jmp    105490 <alltraps>

001061b2 <vector216>:
.globl vector216
vector216:
  pushl $0
  1061b2:	6a 00                	push   $0x0
  pushl $216
  1061b4:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
  1061b9:	e9 d2 f2 ff ff       	jmp    105490 <alltraps>

001061be <vector217>:
.globl vector217
vector217:
  pushl $0
  1061be:	6a 00                	push   $0x0
  pushl $217
  1061c0:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
  1061c5:	e9 c6 f2 ff ff       	jmp    105490 <alltraps>

001061ca <vector218>:
.globl vector218
vector218:
  pushl $0
  1061ca:	6a 00                	push   $0x0
  pushl $218
  1061cc:	68 da 00 00 00       	push   $0xda
  jmp alltraps
  1061d1:	e9 ba f2 ff ff       	jmp    105490 <alltraps>

001061d6 <vector219>:
.globl vector219
vector219:
  pushl $0
  1061d6:	6a 00                	push   $0x0
  pushl $219
  1061d8:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
  1061dd:	e9 ae f2 ff ff       	jmp    105490 <alltraps>

001061e2 <vector220>:
.globl vector220
vector220:
  pushl $0
  1061e2:	6a 00                	push   $0x0
  pushl $220
  1061e4:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
  1061e9:	e9 a2 f2 ff ff       	jmp    105490 <alltraps>

001061ee <vector221>:
.globl vector221
vector221:
  pushl $0
  1061ee:	6a 00                	push   $0x0
  pushl $221
  1061f0:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
  1061f5:	e9 96 f2 ff ff       	jmp    105490 <alltraps>

001061fa <vector222>:
.globl vector222
vector222:
  pushl $0
  1061fa:	6a 00                	push   $0x0
  pushl $222
  1061fc:	68 de 00 00 00       	push   $0xde
  jmp alltraps
  106201:	e9 8a f2 ff ff       	jmp    105490 <alltraps>

00106206 <vector223>:
.globl vector223
vector223:
  pushl $0
  106206:	6a 00                	push   $0x0
  pushl $223
  106208:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
  10620d:	e9 7e f2 ff ff       	jmp    105490 <alltraps>

00106212 <vector224>:
.globl vector224
vector224:
  pushl $0
  106212:	6a 00                	push   $0x0
  pushl $224
  106214:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
  106219:	e9 72 f2 ff ff       	jmp    105490 <alltraps>

0010621e <vector225>:
.globl vector225
vector225:
  pushl $0
  10621e:	6a 00                	push   $0x0
  pushl $225
  106220:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
  106225:	e9 66 f2 ff ff       	jmp    105490 <alltraps>

0010622a <vector226>:
.globl vector226
vector226:
  pushl $0
  10622a:	6a 00                	push   $0x0
  pushl $226
  10622c:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
  106231:	e9 5a f2 ff ff       	jmp    105490 <alltraps>

00106236 <vector227>:
.globl vector227
vector227:
  pushl $0
  106236:	6a 00                	push   $0x0
  pushl $227
  106238:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
  10623d:	e9 4e f2 ff ff       	jmp    105490 <alltraps>

00106242 <vector228>:
.globl vector228
vector228:
  pushl $0
  106242:	6a 00                	push   $0x0
  pushl $228
  106244:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
  106249:	e9 42 f2 ff ff       	jmp    105490 <alltraps>

0010624e <vector229>:
.globl vector229
vector229:
  pushl $0
  10624e:	6a 00                	push   $0x0
  pushl $229
  106250:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
  106255:	e9 36 f2 ff ff       	jmp    105490 <alltraps>

0010625a <vector230>:
.globl vector230
vector230:
  pushl $0
  10625a:	6a 00                	push   $0x0
  pushl $230
  10625c:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
  106261:	e9 2a f2 ff ff       	jmp    105490 <alltraps>

00106266 <vector231>:
.globl vector231
vector231:
  pushl $0
  106266:	6a 00                	push   $0x0
  pushl $231
  106268:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
  10626d:	e9 1e f2 ff ff       	jmp    105490 <alltraps>

00106272 <vector232>:
.globl vector232
vector232:
  pushl $0
  106272:	6a 00                	push   $0x0
  pushl $232
  106274:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
  106279:	e9 12 f2 ff ff       	jmp    105490 <alltraps>

0010627e <vector233>:
.globl vector233
vector233:
  pushl $0
  10627e:	6a 00                	push   $0x0
  pushl $233
  106280:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
  106285:	e9 06 f2 ff ff       	jmp    105490 <alltraps>

0010628a <vector234>:
.globl vector234
vector234:
  pushl $0
  10628a:	6a 00                	push   $0x0
  pushl $234
  10628c:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
  106291:	e9 fa f1 ff ff       	jmp    105490 <alltraps>

00106296 <vector235>:
.globl vector235
vector235:
  pushl $0
  106296:	6a 00                	push   $0x0
  pushl $235
  106298:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
  10629d:	e9 ee f1 ff ff       	jmp    105490 <alltraps>

001062a2 <vector236>:
.globl vector236
vector236:
  pushl $0
  1062a2:	6a 00                	push   $0x0
  pushl $236
  1062a4:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
  1062a9:	e9 e2 f1 ff ff       	jmp    105490 <alltraps>

001062ae <vector237>:
.globl vector237
vector237:
  pushl $0
  1062ae:	6a 00                	push   $0x0
  pushl $237
  1062b0:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
  1062b5:	e9 d6 f1 ff ff       	jmp    105490 <alltraps>

001062ba <vector238>:
.globl vector238
vector238:
  pushl $0
  1062ba:	6a 00                	push   $0x0
  pushl $238
  1062bc:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
  1062c1:	e9 ca f1 ff ff       	jmp    105490 <alltraps>

001062c6 <vector239>:
.globl vector239
vector239:
  pushl $0
  1062c6:	6a 00                	push   $0x0
  pushl $239
  1062c8:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
  1062cd:	e9 be f1 ff ff       	jmp    105490 <alltraps>

001062d2 <vector240>:
.globl vector240
vector240:
  pushl $0
  1062d2:	6a 00                	push   $0x0
  pushl $240
  1062d4:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
  1062d9:	e9 b2 f1 ff ff       	jmp    105490 <alltraps>

001062de <vector241>:
.globl vector241
vector241:
  pushl $0
  1062de:	6a 00                	push   $0x0
  pushl $241
  1062e0:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
  1062e5:	e9 a6 f1 ff ff       	jmp    105490 <alltraps>

001062ea <vector242>:
.globl vector242
vector242:
  pushl $0
  1062ea:	6a 00                	push   $0x0
  pushl $242
  1062ec:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
  1062f1:	e9 9a f1 ff ff       	jmp    105490 <alltraps>

001062f6 <vector243>:
.globl vector243
vector243:
  pushl $0
  1062f6:	6a 00                	push   $0x0
  pushl $243
  1062f8:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
  1062fd:	e9 8e f1 ff ff       	jmp    105490 <alltraps>

00106302 <vector244>:
.globl vector244
vector244:
  pushl $0
  106302:	6a 00                	push   $0x0
  pushl $244
  106304:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
  106309:	e9 82 f1 ff ff       	jmp    105490 <alltraps>

0010630e <vector245>:
.globl vector245
vector245:
  pushl $0
  10630e:	6a 00                	push   $0x0
  pushl $245
  106310:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
  106315:	e9 76 f1 ff ff       	jmp    105490 <alltraps>

0010631a <vector246>:
.globl vector246
vector246:
  pushl $0
  10631a:	6a 00                	push   $0x0
  pushl $246
  10631c:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
  106321:	e9 6a f1 ff ff       	jmp    105490 <alltraps>

00106326 <vector247>:
.globl vector247
vector247:
  pushl $0
  106326:	6a 00                	push   $0x0
  pushl $247
  106328:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
  10632d:	e9 5e f1 ff ff       	jmp    105490 <alltraps>

00106332 <vector248>:
.globl vector248
vector248:
  pushl $0
  106332:	6a 00                	push   $0x0
  pushl $248
  106334:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
  106339:	e9 52 f1 ff ff       	jmp    105490 <alltraps>

0010633e <vector249>:
.globl vector249
vector249:
  pushl $0
  10633e:	6a 00                	push   $0x0
  pushl $249
  106340:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
  106345:	e9 46 f1 ff ff       	jmp    105490 <alltraps>

0010634a <vector250>:
.globl vector250
vector250:
  pushl $0
  10634a:	6a 00                	push   $0x0
  pushl $250
  10634c:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
  106351:	e9 3a f1 ff ff       	jmp    105490 <alltraps>

00106356 <vector251>:
.globl vector251
vector251:
  pushl $0
  106356:	6a 00                	push   $0x0
  pushl $251
  106358:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
  10635d:	e9 2e f1 ff ff       	jmp    105490 <alltraps>

00106362 <vector252>:
.globl vector252
vector252:
  pushl $0
  106362:	6a 00                	push   $0x0
  pushl $252
  106364:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
  106369:	e9 22 f1 ff ff       	jmp    105490 <alltraps>

0010636e <vector253>:
.globl vector253
vector253:
  pushl $0
  10636e:	6a 00                	push   $0x0
  pushl $253
  106370:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
  106375:	e9 16 f1 ff ff       	jmp    105490 <alltraps>

0010637a <vector254>:
.globl vector254
vector254:
  pushl $0
  10637a:	6a 00                	push   $0x0
  pushl $254
  10637c:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
  106381:	e9 0a f1 ff ff       	jmp    105490 <alltraps>

00106386 <vector255>:
.globl vector255
vector255:
  pushl $0
  106386:	6a 00                	push   $0x0
  pushl $255
  106388:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
  10638d:	e9 fe f0 ff ff       	jmp    105490 <alltraps>
  106392:	90                   	nop    
  106393:	90                   	nop    
  106394:	90                   	nop    
  106395:	90                   	nop    
  106396:	90                   	nop    
  106397:	90                   	nop    
  106398:	90                   	nop    
  106399:	90                   	nop    
  10639a:	90                   	nop    
  10639b:	90                   	nop    
  10639c:	90                   	nop    
  10639d:	90                   	nop    
  10639e:	90                   	nop    
  10639f:	90                   	nop    

001063a0 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm()
{
  1063a0:	55                   	push   %ebp
}

static inline void
lcr3(uint val) 
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
  1063a1:	a1 f0 8d 10 00       	mov    0x108df0,%eax
  1063a6:	89 e5                	mov    %esp,%ebp
  1063a8:	0f 22 d8             	mov    %eax,%cr3
  lcr3(PADDR(kpgdir));   // switch to the kernel page table
}
  1063ab:	5d                   	pop    %ebp
  1063ac:	c3                   	ret    
  1063ad:	8d 76 00             	lea    0x0(%esi),%esi

001063b0 <vmenable>:
}

// Turn on paging.
void
vmenable(void)
{
  1063b0:	55                   	push   %ebp
  1063b1:	89 e5                	mov    %esp,%ebp
  uint cr0;

  switchkvm(); // load kpgdir into cr3
  1063b3:	e8 e8 ff ff ff       	call   1063a0 <switchkvm>

static inline uint
rcr0(void)
{
  uint val;
  asm volatile("movl %%cr0,%0" : "=r" (val));
  1063b8:	0f 20 c0             	mov    %cr0,%eax
}

static inline void
lcr0(uint val)
{
  asm volatile("movl %0,%%cr0" : : "r" (val));
  1063bb:	0d 00 00 00 80       	or     $0x80000000,%eax
  1063c0:	0f 22 c0             	mov    %eax,%cr0
  cr0 = rcr0();
  cr0 |= CR0_PG;
  lcr0(cr0);
}
  1063c3:	5d                   	pop    %ebp
  1063c4:	c3                   	ret    
  1063c5:	8d 74 26 00          	lea    0x0(%esi),%esi
  1063c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001063d0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to linear address va.  If create!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int create)
{
  1063d0:	55                   	push   %ebp
  1063d1:	89 e5                	mov    %esp,%ebp
  1063d3:	83 ec 18             	sub    $0x18,%esp
  1063d6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  1063d9:	89 d3                	mov    %edx,%ebx
  uint r;
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  1063db:	c1 ea 16             	shr    $0x16,%edx
// Return the address of the PTE in page table pgdir
// that corresponds to linear address va.  If create!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int create)
{
  1063de:	89 7d fc             	mov    %edi,-0x4(%ebp)
  uint r;
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  1063e1:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to linear address va.  If create!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int create)
{
  1063e4:	89 75 f8             	mov    %esi,-0x8(%ebp)
  uint r;
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
  1063e7:	8b 07                	mov    (%edi),%eax
  1063e9:	a8 01                	test   $0x1,%al
  1063eb:	74 21                	je     10640e <walkpgdir+0x3e>
    pgtab = (pte_t*) PTE_ADDR(*pde);
  1063ed:	89 c6                	mov    %eax,%esi
  1063ef:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = PADDR(r) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
  1063f5:	c1 eb 0a             	shr    $0xa,%ebx
  1063f8:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
  1063fe:	8d 04 33             	lea    (%ebx,%esi,1),%eax
}
  106401:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  106404:	8b 75 f8             	mov    -0x8(%ebp),%esi
  106407:	8b 7d fc             	mov    -0x4(%ebp),%edi
  10640a:	89 ec                	mov    %ebp,%esp
  10640c:	5d                   	pop    %ebp
  10640d:	c3                   	ret    
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*) PTE_ADDR(*pde);
  } else if(!create || !(r = (uint) kalloc()))
  10640e:	85 c9                	test   %ecx,%ecx
  106410:	75 04                	jne    106416 <walkpgdir+0x46>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = PADDR(r) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
  106412:	31 c0                	xor    %eax,%eax
  106414:	eb eb                	jmp    106401 <walkpgdir+0x31>
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*) PTE_ADDR(*pde);
  } else if(!create || !(r = (uint) kalloc()))
  106416:	e8 85 bd ff ff       	call   1021a0 <kalloc>
  10641b:	85 c0                	test   %eax,%eax
  10641d:	8d 76 00             	lea    0x0(%esi),%esi
  106420:	74 f0                	je     106412 <walkpgdir+0x42>
    return 0;
  else {
    pgtab = (pte_t*) r;
  106422:	89 c6                	mov    %eax,%esi
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
  106424:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  10642b:	00 
  10642c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  106433:	00 
  106434:	89 04 24             	mov    %eax,(%esp)
  106437:	e8 c4 d8 ff ff       	call   103d00 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = PADDR(r) | PTE_P | PTE_W | PTE_U;
  10643c:	89 f0                	mov    %esi,%eax
  10643e:	83 c8 07             	or     $0x7,%eax
  106441:	89 07                	mov    %eax,(%edi)
  106443:	eb b0                	jmp    1063f5 <walkpgdir+0x25>
  106445:	8d 74 26 00          	lea    0x0(%esi),%esi
  106449:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00106450 <uva2ka>:
// maps to.  The result is also a kernel logical address,
// since the kernel maps the physical memory allocated to user
// processes directly.
char*
uva2ka(pde_t *pgdir, char *uva)
{    
  106450:	55                   	push   %ebp
  pte_t *pte = walkpgdir(pgdir, uva, 0);
  106451:	31 c9                	xor    %ecx,%ecx
// maps to.  The result is also a kernel logical address,
// since the kernel maps the physical memory allocated to user
// processes directly.
char*
uva2ka(pde_t *pgdir, char *uva)
{    
  106453:	89 e5                	mov    %esp,%ebp
  106455:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte = walkpgdir(pgdir, uva, 0);
  106458:	8b 55 0c             	mov    0xc(%ebp),%edx
  10645b:	8b 45 08             	mov    0x8(%ebp),%eax
  10645e:	e8 6d ff ff ff       	call   1063d0 <walkpgdir>
  if(pte == 0) return 0;
  106463:	31 d2                	xor    %edx,%edx
  106465:	85 c0                	test   %eax,%eax
  106467:	74 08                	je     106471 <uva2ka+0x21>
  uint pa = PTE_ADDR(*pte);
  return (char *)pa;
  106469:	8b 10                	mov    (%eax),%edx
  10646b:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
}
  106471:	c9                   	leave  
  106472:	89 d0                	mov    %edx,%eax
  106474:	c3                   	ret    
  106475:	8d 74 26 00          	lea    0x0(%esi),%esi
  106479:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00106480 <mappages>:
// Create PTEs for linear addresses starting at la that refer to
// physical addresses starting at pa. la and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *la, uint size, uint pa, int perm)
{
  106480:	55                   	push   %ebp
  106481:	89 e5                	mov    %esp,%ebp
  106483:	57                   	push   %edi
  106484:	56                   	push   %esi
  106485:	53                   	push   %ebx
  char *a = PGROUNDDOWN(la);
  106486:	89 d3                	mov    %edx,%ebx
// Create PTEs for linear addresses starting at la that refer to
// physical addresses starting at pa. la and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *la, uint size, uint pa, int perm)
{
  106488:	83 ec 0c             	sub    $0xc,%esp
  10648b:	8b 75 08             	mov    0x8(%ebp),%esi
  char *a = PGROUNDDOWN(la);
  10648e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for linear addresses starting at la that refer to
// physical addresses starting at pa. la and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *la, uint size, uint pa, int perm)
{
  106494:	89 45 f0             	mov    %eax,-0x10(%ebp)
    pte_t *pte = walkpgdir(pgdir, a, 1);
    if(pte == 0)
      return 0;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
  106497:	8b 45 0c             	mov    0xc(%ebp),%eax
// be page-aligned.
static int
mappages(pde_t *pgdir, void *la, uint size, uint pa, int perm)
{
  char *a = PGROUNDDOWN(la);
  char *last = PGROUNDDOWN(la + size - 1);
  10649a:	8d 7c 0a ff          	lea    -0x1(%edx,%ecx,1),%edi
  10649e:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pte_t *pte = walkpgdir(pgdir, a, 1);
    if(pte == 0)
      return 0;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
  1064a4:	83 c8 01             	or     $0x1,%eax
  1064a7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1064aa:	eb 20                	jmp    1064cc <mappages+0x4c>
  1064ac:	8d 74 26 00          	lea    0x0(%esi),%esi

  while(1){
    pte_t *pte = walkpgdir(pgdir, a, 1);
    if(pte == 0)
      return 0;
    if(*pte & PTE_P)
  1064b0:	f6 00 01             	testb  $0x1,(%eax)
  1064b3:	75 43                	jne    1064f8 <mappages+0x78>
      panic("remap");
    *pte = pa | perm | PTE_P;
  1064b5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1064b8:	09 f0                	or     %esi,%eax
    if(a == last)
  1064ba:	39 fb                	cmp    %edi,%ebx
    pte_t *pte = walkpgdir(pgdir, a, 1);
    if(pte == 0)
      return 0;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
  1064bc:	89 02                	mov    %eax,(%edx)
    if(a == last)
  1064be:	74 2b                	je     1064eb <mappages+0x6b>
      break;
    a += PGSIZE;
  1064c0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    pa += PGSIZE;
  1064c6:	81 c6 00 10 00 00    	add    $0x1000,%esi
{
  char *a = PGROUNDDOWN(la);
  char *last = PGROUNDDOWN(la + size - 1);

  while(1){
    pte_t *pte = walkpgdir(pgdir, a, 1);
  1064cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1064cf:	89 da                	mov    %ebx,%edx
  1064d1:	b9 01 00 00 00       	mov    $0x1,%ecx
  1064d6:	e8 f5 fe ff ff       	call   1063d0 <walkpgdir>
    if(pte == 0)
  1064db:	85 c0                	test   %eax,%eax
{
  char *a = PGROUNDDOWN(la);
  char *last = PGROUNDDOWN(la + size - 1);

  while(1){
    pte_t *pte = walkpgdir(pgdir, a, 1);
  1064dd:	89 c2                	mov    %eax,%edx
    if(pte == 0)
  1064df:	75 cf                	jne    1064b0 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 1;
}
  1064e1:	83 c4 0c             	add    $0xc,%esp
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  1064e4:	31 c0                	xor    %eax,%eax
  return 1;
}
  1064e6:	5b                   	pop    %ebx
  1064e7:	5e                   	pop    %esi
  1064e8:	5f                   	pop    %edi
  1064e9:	5d                   	pop    %ebp
  1064ea:	c3                   	ret    
  1064eb:	83 c4 0c             	add    $0xc,%esp
    if(pte == 0)
      return 0;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
  1064ee:	b8 01 00 00 00       	mov    $0x1,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 1;
}
  1064f3:	5b                   	pop    %ebx
  1064f4:	5e                   	pop    %esi
  1064f5:	5f                   	pop    %edi
  1064f6:	5d                   	pop    %ebp
  1064f7:	c3                   	ret    
  while(1){
    pte_t *pte = walkpgdir(pgdir, a, 1);
    if(pte == 0)
      return 0;
    if(*pte & PTE_P)
      panic("remap");
  1064f8:	c7 04 24 bc 74 10 00 	movl   $0x1074bc,(%esp)
  1064ff:	e8 7c a3 ff ff       	call   100880 <panic>
  106504:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10650a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00106510 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
  106510:	55                   	push   %ebp
  106511:	89 e5                	mov    %esp,%ebp
  106513:	83 ec 28             	sub    $0x28,%esp
  106516:	8b 45 0c             	mov    0xc(%ebp),%eax
  106519:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  10651c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  10651f:	8b 75 10             	mov    0x10(%ebp),%esi
  106522:	89 7d fc             	mov    %edi,-0x4(%ebp)
  106525:	8b 7d 08             	mov    0x8(%ebp),%edi
  106528:	89 45 f0             	mov    %eax,-0x10(%ebp)
  char *mem = kalloc();
  10652b:	e8 70 bc ff ff       	call   1021a0 <kalloc>
  if (sz >= PGSIZE)
  106530:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem = kalloc();
  106536:	89 c3                	mov    %eax,%ebx
  if (sz >= PGSIZE)
  106538:	77 4e                	ja     106588 <inituvm+0x78>
    panic("inituvm: more than a page");
  memset(mem, 0, PGSIZE);
  10653a:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  106541:	00 
  106542:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  106549:	00 
  10654a:	89 04 24             	mov    %eax,(%esp)
  10654d:	e8 ae d7 ff ff       	call   103d00 <memset>
  mappages(pgdir, 0, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  106552:	89 f8                	mov    %edi,%eax
  106554:	b9 00 10 00 00       	mov    $0x1000,%ecx
  106559:	89 1c 24             	mov    %ebx,(%esp)
  10655c:	31 d2                	xor    %edx,%edx
  10655e:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
  106565:	00 
  106566:	e8 15 ff ff ff       	call   106480 <mappages>
  memmove(mem, init, sz);
  10656b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10656e:	89 75 10             	mov    %esi,0x10(%ebp)
}
  106571:	8b 7d fc             	mov    -0x4(%ebp),%edi
  char *mem = kalloc();
  if (sz >= PGSIZE)
    panic("inituvm: more than a page");
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
  106574:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
  106577:	8b 75 f8             	mov    -0x8(%ebp),%esi
  10657a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  char *mem = kalloc();
  if (sz >= PGSIZE)
    panic("inituvm: more than a page");
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
  10657d:	89 45 0c             	mov    %eax,0xc(%ebp)
}
  106580:	89 ec                	mov    %ebp,%esp
  106582:	5d                   	pop    %ebp
  char *mem = kalloc();
  if (sz >= PGSIZE)
    panic("inituvm: more than a page");
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
  106583:	e9 18 d8 ff ff       	jmp    103da0 <memmove>
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem = kalloc();
  if (sz >= PGSIZE)
    panic("inituvm: more than a page");
  106588:	c7 04 24 c2 74 10 00 	movl   $0x1074c2,(%esp)
  10658f:	e8 ec a2 ff ff       	call   100880 <panic>
  106594:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10659a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001065a0 <setupkvm>:
}

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
  1065a0:	55                   	push   %ebp
  1065a1:	89 e5                	mov    %esp,%ebp
  1065a3:	53                   	push   %ebx
  1065a4:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;

  // Allocate page directory
  if(!(pgdir = (pde_t *) kalloc()))
  1065a7:	e8 f4 bb ff ff       	call   1021a0 <kalloc>
  1065ac:	85 c0                	test   %eax,%eax
  1065ae:	75 10                	jne    1065c0 <setupkvm+0x20>
    return 0;
  memset(pgdir, 0, PGSIZE);
  if(// Map IO space from 640K to 1Mbyte
  1065b0:	31 db                	xor    %ebx,%ebx
     !mappages(pgdir, (void *)0x100000, PHYSTOP-0x100000, 0x100000, PTE_W) ||
     // Map devices such as ioapic, lapic, ...
     !mappages(pgdir, (void *)0xFE000000, 0x2000000, 0xFE000000, PTE_W))
    return 0;
  return pgdir;
}
  1065b2:	89 d8                	mov    %ebx,%eax
  1065b4:	83 c4 14             	add    $0x14,%esp
  1065b7:	5b                   	pop    %ebx
  1065b8:	5d                   	pop    %ebp
  1065b9:	c3                   	ret    
  1065ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
setupkvm(void)
{
  pde_t *pgdir;

  // Allocate page directory
  if(!(pgdir = (pde_t *) kalloc()))
  1065c0:	89 c3                	mov    %eax,%ebx
    return 0;
  memset(pgdir, 0, PGSIZE);
  1065c2:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  1065c9:	00 
  1065ca:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1065d1:	00 
  1065d2:	89 04 24             	mov    %eax,(%esp)
  1065d5:	e8 26 d7 ff ff       	call   103d00 <memset>
  if(// Map IO space from 640K to 1Mbyte
  1065da:	b9 00 00 06 00       	mov    $0x60000,%ecx
  1065df:	ba 00 00 0a 00       	mov    $0xa0000,%edx
  1065e4:	89 d8                	mov    %ebx,%eax
  1065e6:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  1065ed:	00 
  1065ee:	c7 04 24 00 00 0a 00 	movl   $0xa0000,(%esp)
  1065f5:	e8 86 fe ff ff       	call   106480 <mappages>
  1065fa:	85 c0                	test   %eax,%eax
  1065fc:	74 b2                	je     1065b0 <setupkvm+0x10>
  1065fe:	b9 00 00 f0 00       	mov    $0xf00000,%ecx
  106603:	ba 00 00 10 00       	mov    $0x100000,%edx
  106608:	89 d8                	mov    %ebx,%eax
  10660a:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  106611:	00 
  106612:	c7 04 24 00 00 10 00 	movl   $0x100000,(%esp)
  106619:	e8 62 fe ff ff       	call   106480 <mappages>
  10661e:	85 c0                	test   %eax,%eax
  106620:	74 8e                	je     1065b0 <setupkvm+0x10>
  106622:	b9 00 00 00 02       	mov    $0x2000000,%ecx
  106627:	ba 00 00 00 fe       	mov    $0xfe000000,%edx
  10662c:	89 d8                	mov    %ebx,%eax
  10662e:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  106635:	00 
  106636:	c7 04 24 00 00 00 fe 	movl   $0xfe000000,(%esp)
  10663d:	e8 3e fe ff ff       	call   106480 <mappages>
  106642:	85 c0                	test   %eax,%eax
  106644:	0f 85 68 ff ff ff    	jne    1065b2 <setupkvm+0x12>
  10664a:	e9 61 ff ff ff       	jmp    1065b0 <setupkvm+0x10>
  10664f:	90                   	nop    

00106650 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
  106650:	55                   	push   %ebp
  106651:	89 e5                	mov    %esp,%ebp
  106653:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
  106656:	e8 45 ff ff ff       	call   1065a0 <setupkvm>
  10665b:	a3 f0 8d 10 00       	mov    %eax,0x108df0
}
  106660:	c9                   	leave  
  106661:	c3                   	ret    
  106662:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
  106669:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00106670 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  106670:	55                   	push   %ebp
  106671:	89 e5                	mov    %esp,%ebp
  106673:	57                   	push   %edi
  106674:	56                   	push   %esi
  106675:	53                   	push   %ebx
  106676:	83 ec 0c             	sub    $0xc,%esp
  char *a = (char *)PGROUNDUP(newsz);
  106679:	8b 75 10             	mov    0x10(%ebp),%esi
  char *last = PGROUNDDOWN(oldsz - 1);
  10667c:	8b 7d 0c             	mov    0xc(%ebp),%edi
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  char *a = (char *)PGROUNDUP(newsz);
  10667f:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
  char *last = PGROUNDDOWN(oldsz - 1);
  106685:	83 ef 01             	sub    $0x1,%edi
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  char *a = (char *)PGROUNDUP(newsz);
  106688:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  char *last = PGROUNDDOWN(oldsz - 1);
  10668e:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  for(; a <= last; a += PGSIZE){
  106694:	39 fe                	cmp    %edi,%esi
  106696:	77 37                	ja     1066cf <deallocuvm+0x5f>
    pte_t *pte = walkpgdir(pgdir, a, 0);
  106698:	8b 45 08             	mov    0x8(%ebp),%eax
  10669b:	31 c9                	xor    %ecx,%ecx
  10669d:	89 f2                	mov    %esi,%edx
  10669f:	e8 2c fd ff ff       	call   1063d0 <walkpgdir>
    if(pte && (*pte & PTE_P) != 0){
  1066a4:	85 c0                	test   %eax,%eax
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  char *a = (char *)PGROUNDUP(newsz);
  char *last = PGROUNDDOWN(oldsz - 1);
  for(; a <= last; a += PGSIZE){
    pte_t *pte = walkpgdir(pgdir, a, 0);
  1066a6:	89 c3                	mov    %eax,%ebx
    if(pte && (*pte & PTE_P) != 0){
  1066a8:	74 1b                	je     1066c5 <deallocuvm+0x55>
  1066aa:	8b 00                	mov    (%eax),%eax
  1066ac:	a8 01                	test   $0x1,%al
  1066ae:	74 15                	je     1066c5 <deallocuvm+0x55>
      uint pa = PTE_ADDR(*pte);
      if(pa == 0)
  1066b0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  1066b5:	74 33                	je     1066ea <deallocuvm+0x7a>
        panic("kfree");
      kfree((void *) pa);
  1066b7:	89 04 24             	mov    %eax,(%esp)
  1066ba:	e8 21 bb ff ff       	call   1021e0 <kfree>
      *pte = 0;
  1066bf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  char *a = (char *)PGROUNDUP(newsz);
  char *last = PGROUNDDOWN(oldsz - 1);
  for(; a <= last; a += PGSIZE){
  1066c5:	81 c6 00 10 00 00    	add    $0x1000,%esi
  1066cb:	39 f7                	cmp    %esi,%edi
  1066cd:	73 c9                	jae    106698 <deallocuvm+0x28>
  1066cf:	8b 45 10             	mov    0x10(%ebp),%eax
  1066d2:	3b 45 0c             	cmp    0xc(%ebp),%eax
  1066d5:	77 08                	ja     1066df <deallocuvm+0x6f>
      kfree((void *) pa);
      *pte = 0;
    }
  }
  return newsz < oldsz ? newsz : oldsz;
}
  1066d7:	83 c4 0c             	add    $0xc,%esp
  1066da:	5b                   	pop    %ebx
  1066db:	5e                   	pop    %esi
  1066dc:	5f                   	pop    %edi
  1066dd:	5d                   	pop    %ebp
  1066de:	c3                   	ret    
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  char *a = (char *)PGROUNDUP(newsz);
  char *last = PGROUNDDOWN(oldsz - 1);
  for(; a <= last; a += PGSIZE){
  1066df:	8b 45 0c             	mov    0xc(%ebp),%eax
      kfree((void *) pa);
      *pte = 0;
    }
  }
  return newsz < oldsz ? newsz : oldsz;
}
  1066e2:	83 c4 0c             	add    $0xc,%esp
  1066e5:	5b                   	pop    %ebx
  1066e6:	5e                   	pop    %esi
  1066e7:	5f                   	pop    %edi
  1066e8:	5d                   	pop    %ebp
  1066e9:	c3                   	ret    
  for(; a <= last; a += PGSIZE){
    pte_t *pte = walkpgdir(pgdir, a, 0);
    if(pte && (*pte & PTE_P) != 0){
      uint pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
  1066ea:	c7 04 24 36 6e 10 00 	movl   $0x106e36,(%esp)
  1066f1:	e8 8a a1 ff ff       	call   100880 <panic>
  1066f6:	8d 76 00             	lea    0x0(%esi),%esi
  1066f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00106700 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
  106700:	55                   	push   %ebp
  106701:	89 e5                	mov    %esp,%ebp
  106703:	56                   	push   %esi
  106704:	53                   	push   %ebx
  106705:	83 ec 10             	sub    $0x10,%esp
  106708:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(!pgdir)
  10670b:	85 f6                	test   %esi,%esi
  10670d:	74 59                	je     106768 <freevm+0x68>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, USERTOP, 0);
  10670f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  106716:	00 
  106717:	31 db                	xor    %ebx,%ebx
  106719:	c7 44 24 04 00 00 0a 	movl   $0xa0000,0x4(%esp)
  106720:	00 
  106721:	89 34 24             	mov    %esi,(%esp)
  106724:	e8 47 ff ff ff       	call   106670 <deallocuvm>
  106729:	eb 10                	jmp    10673b <freevm+0x3b>
  10672b:	90                   	nop    
  10672c:	8d 74 26 00          	lea    0x0(%esi),%esi
  for(i = 0; i < NPDENTRIES; i++){
  106730:	83 c3 01             	add    $0x1,%ebx
  106733:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
  106739:	74 1f                	je     10675a <freevm+0x5a>
    if(pgdir[i] & PTE_P)
  10673b:	8b 04 9e             	mov    (%esi,%ebx,4),%eax
  10673e:	a8 01                	test   $0x1,%al
  106740:	74 ee                	je     106730 <freevm+0x30>
      kfree((void *) PTE_ADDR(pgdir[i]));
  106742:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  uint i;

  if(!pgdir)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, USERTOP, 0);
  for(i = 0; i < NPDENTRIES; i++){
  106747:	83 c3 01             	add    $0x1,%ebx
    if(pgdir[i] & PTE_P)
      kfree((void *) PTE_ADDR(pgdir[i]));
  10674a:	89 04 24             	mov    %eax,(%esp)
  10674d:	e8 8e ba ff ff       	call   1021e0 <kfree>
  uint i;

  if(!pgdir)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, USERTOP, 0);
  for(i = 0; i < NPDENTRIES; i++){
  106752:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
  106758:	75 e1                	jne    10673b <freevm+0x3b>
    if(pgdir[i] & PTE_P)
      kfree((void *) PTE_ADDR(pgdir[i]));
  }
  kfree((void *) pgdir);
  10675a:	89 75 08             	mov    %esi,0x8(%ebp)
}
  10675d:	83 c4 10             	add    $0x10,%esp
  106760:	5b                   	pop    %ebx
  106761:	5e                   	pop    %esi
  106762:	5d                   	pop    %ebp
  deallocuvm(pgdir, USERTOP, 0);
  for(i = 0; i < NPDENTRIES; i++){
    if(pgdir[i] & PTE_P)
      kfree((void *) PTE_ADDR(pgdir[i]));
  }
  kfree((void *) pgdir);
  106763:	e9 78 ba ff ff       	jmp    1021e0 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(!pgdir)
    panic("freevm: no pgdir");
  106768:	c7 04 24 dc 74 10 00 	movl   $0x1074dc,(%esp)
  10676f:	e8 0c a1 ff ff       	call   100880 <panic>
  106774:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10677a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00106780 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
  106780:	55                   	push   %ebp
  106781:	89 e5                	mov    %esp,%ebp
  106783:	57                   	push   %edi
  106784:	56                   	push   %esi
  106785:	53                   	push   %ebx
  106786:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d = setupkvm();
  106789:	e8 12 fe ff ff       	call   1065a0 <setupkvm>
  pte_t *pte;
  uint pa, i;
  char *mem;

  if(!d) return 0;
  10678e:	85 c0                	test   %eax,%eax
// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
  pde_t *d = setupkvm();
  106790:	89 45 f0             	mov    %eax,-0x10(%ebp)
  pte_t *pte;
  uint pa, i;
  char *mem;

  if(!d) return 0;
  106793:	0f 84 84 00 00 00    	je     10681d <copyuvm+0x9d>
  for(i = 0; i < sz; i += PGSIZE){
  106799:	8b 45 0c             	mov    0xc(%ebp),%eax
  10679c:	85 c0                	test   %eax,%eax
  10679e:	74 7d                	je     10681d <copyuvm+0x9d>
  1067a0:	31 ff                	xor    %edi,%edi
  1067a2:	eb 43                	jmp    1067e7 <copyuvm+0x67>
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present\n");
    pa = PTE_ADDR(*pte);
    if(!(mem = kalloc()))
      goto bad;
    memmove(mem, (char *)pa, PGSIZE);
  1067a4:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  1067aa:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  1067b1:	00 
  1067b2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1067b6:	89 04 24             	mov    %eax,(%esp)
  1067b9:	e8 e2 d5 ff ff       	call   103da0 <memmove>
    if(!mappages(d, (void *)i, PGSIZE, PADDR(mem), PTE_W|PTE_U))
  1067be:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1067c1:	b9 00 10 00 00       	mov    $0x1000,%ecx
  1067c6:	89 fa                	mov    %edi,%edx
  1067c8:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
  1067cf:	00 
  1067d0:	89 34 24             	mov    %esi,(%esp)
  1067d3:	e8 a8 fc ff ff       	call   106480 <mappages>
  1067d8:	85 c0                	test   %eax,%eax
  1067da:	74 2f                	je     10680b <copyuvm+0x8b>
  pte_t *pte;
  uint pa, i;
  char *mem;

  if(!d) return 0;
  for(i = 0; i < sz; i += PGSIZE){
  1067dc:	81 c7 00 10 00 00    	add    $0x1000,%edi
  1067e2:	39 7d 0c             	cmp    %edi,0xc(%ebp)
  1067e5:	76 36                	jbe    10681d <copyuvm+0x9d>
    if(!(pte = walkpgdir(pgdir, (void *)i, 0)))
  1067e7:	8b 45 08             	mov    0x8(%ebp),%eax
  1067ea:	31 c9                	xor    %ecx,%ecx
  1067ec:	89 fa                	mov    %edi,%edx
  1067ee:	e8 dd fb ff ff       	call   1063d0 <walkpgdir>
  1067f3:	85 c0                	test   %eax,%eax
  1067f5:	74 31                	je     106828 <copyuvm+0xa8>
      panic("copyuvm: pte should exist\n");
    if(!(*pte & PTE_P))
  1067f7:	8b 18                	mov    (%eax),%ebx
  1067f9:	f6 c3 01             	test   $0x1,%bl
  1067fc:	74 36                	je     106834 <copyuvm+0xb4>
  1067fe:	66 90                	xchg   %ax,%ax
      panic("copyuvm: page not present\n");
    pa = PTE_ADDR(*pte);
    if(!(mem = kalloc()))
  106800:	e8 9b b9 ff ff       	call   1021a0 <kalloc>
  106805:	85 c0                	test   %eax,%eax
  106807:	89 c6                	mov    %eax,%esi
  106809:	75 99                	jne    1067a4 <copyuvm+0x24>
      goto bad;
  }
  return d;

bad:
  freevm(d);
  10680b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10680e:	89 04 24             	mov    %eax,(%esp)
  106811:	e8 ea fe ff ff       	call   106700 <freevm>
  106816:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  return 0;
}
  10681d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  106820:	83 c4 1c             	add    $0x1c,%esp
  106823:	5b                   	pop    %ebx
  106824:	5e                   	pop    %esi
  106825:	5f                   	pop    %edi
  106826:	5d                   	pop    %ebp
  106827:	c3                   	ret    
  char *mem;

  if(!d) return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if(!(pte = walkpgdir(pgdir, (void *)i, 0)))
      panic("copyuvm: pte should exist\n");
  106828:	c7 04 24 ed 74 10 00 	movl   $0x1074ed,(%esp)
  10682f:	e8 4c a0 ff ff       	call   100880 <panic>
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present\n");
  106834:	c7 04 24 08 75 10 00 	movl   $0x107508,(%esp)
  10683b:	e8 40 a0 ff ff       	call   100880 <panic>

00106840 <allocuvm>:
// newsz. Allocates physical memory and page table entries. oldsz and
// newsz need not be page-aligned, nor does newsz have to be larger
// than oldsz.  Returns the new process size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  106840:	55                   	push   %ebp
  if(newsz > USERTOP)
  106841:	31 c0                	xor    %eax,%eax
// newsz. Allocates physical memory and page table entries. oldsz and
// newsz need not be page-aligned, nor does newsz have to be larger
// than oldsz.  Returns the new process size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  106843:	89 e5                	mov    %esp,%ebp
  106845:	57                   	push   %edi
  106846:	56                   	push   %esi
  106847:	53                   	push   %ebx
  106848:	83 ec 0c             	sub    $0xc,%esp
  if(newsz > USERTOP)
  10684b:	81 7d 10 00 00 0a 00 	cmpl   $0xa0000,0x10(%ebp)
  106852:	0f 87 96 00 00 00    	ja     1068ee <allocuvm+0xae>
    return 0;
  char *a = (char *)PGROUNDUP(oldsz);
  106858:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *last = PGROUNDDOWN(newsz - 1);
  10685b:	8b 7d 10             	mov    0x10(%ebp),%edi
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  if(newsz > USERTOP)
    return 0;
  char *a = (char *)PGROUNDUP(oldsz);
  10685e:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
  char *last = PGROUNDDOWN(newsz - 1);
  106864:	83 ef 01             	sub    $0x1,%edi
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  if(newsz > USERTOP)
    return 0;
  char *a = (char *)PGROUNDUP(oldsz);
  106867:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  char *last = PGROUNDDOWN(newsz - 1);
  10686d:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  for (; a <= last; a += PGSIZE){
  106873:	39 fe                	cmp    %edi,%esi
  106875:	76 45                	jbe    1068bc <allocuvm+0x7c>
  106877:	eb 7d                	jmp    1068f6 <allocuvm+0xb6>
  106879:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
  106880:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  106887:	00 
  106888:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10688f:	00 
  106890:	89 04 24             	mov    %eax,(%esp)
  106893:	e8 68 d4 ff ff       	call   103d00 <memset>
    mappages(pgdir, a, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  106898:	89 f2                	mov    %esi,%edx
  10689a:	b9 00 10 00 00       	mov    $0x1000,%ecx
  10689f:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
  1068a6:	00 
{
  if(newsz > USERTOP)
    return 0;
  char *a = (char *)PGROUNDUP(oldsz);
  char *last = PGROUNDDOWN(newsz - 1);
  for (; a <= last; a += PGSIZE){
  1068a7:	81 c6 00 10 00 00    	add    $0x1000,%esi
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, a, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  1068ad:	89 1c 24             	mov    %ebx,(%esp)
  1068b0:	8b 45 08             	mov    0x8(%ebp),%eax
  1068b3:	e8 c8 fb ff ff       	call   106480 <mappages>
{
  if(newsz > USERTOP)
    return 0;
  char *a = (char *)PGROUNDUP(oldsz);
  char *last = PGROUNDDOWN(newsz - 1);
  for (; a <= last; a += PGSIZE){
  1068b8:	39 f7                	cmp    %esi,%edi
  1068ba:	72 3a                	jb     1068f6 <allocuvm+0xb6>
    char *mem = kalloc();
  1068bc:	e8 df b8 ff ff       	call   1021a0 <kalloc>
    if(mem == 0){
  1068c1:	85 c0                	test   %eax,%eax
  if(newsz > USERTOP)
    return 0;
  char *a = (char *)PGROUNDUP(oldsz);
  char *last = PGROUNDDOWN(newsz - 1);
  for (; a <= last; a += PGSIZE){
    char *mem = kalloc();
  1068c3:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
  1068c5:	75 b9                	jne    106880 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
  1068c7:	c7 04 24 23 75 10 00 	movl   $0x107523,(%esp)
  1068ce:	e8 ed 9b ff ff       	call   1004c0 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
  1068d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1068d6:	89 44 24 08          	mov    %eax,0x8(%esp)
  1068da:	8b 45 10             	mov    0x10(%ebp),%eax
  1068dd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1068e1:	8b 45 08             	mov    0x8(%ebp),%eax
  1068e4:	89 04 24             	mov    %eax,(%esp)
  1068e7:	e8 84 fd ff ff       	call   106670 <deallocuvm>
  1068ec:	31 c0                	xor    %eax,%eax
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, a, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  }
  return newsz > oldsz ? newsz : oldsz;
}
  1068ee:	83 c4 0c             	add    $0xc,%esp
  1068f1:	5b                   	pop    %ebx
  1068f2:	5e                   	pop    %esi
  1068f3:	5f                   	pop    %edi
  1068f4:	5d                   	pop    %ebp
  1068f5:	c3                   	ret    
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, a, PGSIZE, PADDR(mem), PTE_W|PTE_U);
  }
  return newsz > oldsz ? newsz : oldsz;
  1068f6:	8b 45 10             	mov    0x10(%ebp),%eax
  1068f9:	3b 45 0c             	cmp    0xc(%ebp),%eax
  1068fc:	73 f0                	jae    1068ee <allocuvm+0xae>
  1068fe:	8b 45 0c             	mov    0xc(%ebp),%eax
}
  106901:	83 c4 0c             	add    $0xc,%esp
  106904:	5b                   	pop    %ebx
  106905:	5e                   	pop    %esi
  106906:	5f                   	pop    %edi
  106907:	5d                   	pop    %ebp
  106908:	c3                   	ret    
  106909:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00106910 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
  106910:	55                   	push   %ebp
  106911:	89 e5                	mov    %esp,%ebp
  106913:	57                   	push   %edi
  106914:	56                   	push   %esi
  106915:	53                   	push   %ebx
  106916:	83 ec 1c             	sub    $0x1c,%esp
  106919:	8b 7d 18             	mov    0x18(%ebp),%edi
  uint i, pa, n;
  pte_t *pte;

  if((uint)addr % PGSIZE != 0)
  10691c:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
  106923:	0f 85 82 00 00 00    	jne    1069ab <loaduvm+0x9b>
    panic("loaduvm: addr must be page aligned\n");
  106929:	31 f6                	xor    %esi,%esi
  for(i = 0; i < sz; i += PGSIZE){
  10692b:	85 ff                	test   %edi,%edi
  10692d:	75 0c                	jne    10693b <loaduvm+0x2b>
  10692f:	eb 61                	jmp    106992 <loaduvm+0x82>
  106931:	81 c6 00 10 00 00    	add    $0x1000,%esi
  106937:	39 f7                	cmp    %esi,%edi
  106939:	76 57                	jbe    106992 <loaduvm+0x82>
    if(!(pte = walkpgdir(pgdir, addr+i, 0)))
  10693b:	8b 55 0c             	mov    0xc(%ebp),%edx
  10693e:	31 c9                	xor    %ecx,%ecx
  106940:	8b 45 08             	mov    0x8(%ebp),%eax
  106943:	01 f2                	add    %esi,%edx
  106945:	e8 86 fa ff ff       	call   1063d0 <walkpgdir>
  10694a:	85 c0                	test   %eax,%eax
  10694c:	74 51                	je     10699f <loaduvm+0x8f>
      panic("loaduvm: address should exist\n");
    pa = PTE_ADDR(*pte);
  10694e:	89 fb                	mov    %edi,%ebx
  106950:	8b 10                	mov    (%eax),%edx
  106952:	29 f3                	sub    %esi,%ebx
    if(sz - i < PGSIZE) n = sz - i;
  106954:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
  10695a:	76 05                	jbe    106961 <loaduvm+0x51>
  10695c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    else n = PGSIZE;
    if(readi(ip, (char *)pa, offset+i, n) != n)
  106961:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  106965:	8b 4d 14             	mov    0x14(%ebp),%ecx
  106968:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  10696e:	89 54 24 04          	mov    %edx,0x4(%esp)
  106972:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
  106975:	89 44 24 08          	mov    %eax,0x8(%esp)
  106979:	8b 45 10             	mov    0x10(%ebp),%eax
  10697c:	89 04 24             	mov    %eax,(%esp)
  10697f:	e8 fc aa ff ff       	call   101480 <readi>
  106984:	39 d8                	cmp    %ebx,%eax
  106986:	74 a9                	je     106931 <loaduvm+0x21>
      return 0;
  }
  return 1;
}
  106988:	83 c4 1c             	add    $0x1c,%esp
    if(!(pte = walkpgdir(pgdir, addr+i, 0)))
      panic("loaduvm: address should exist\n");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE) n = sz - i;
    else n = PGSIZE;
    if(readi(ip, (char *)pa, offset+i, n) != n)
  10698b:	31 c0                	xor    %eax,%eax
      return 0;
  }
  return 1;
}
  10698d:	5b                   	pop    %ebx
  10698e:	5e                   	pop    %esi
  10698f:	5f                   	pop    %edi
  106990:	5d                   	pop    %ebp
  106991:	c3                   	ret    
  106992:	83 c4 1c             	add    $0x1c,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint)addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned\n");
  for(i = 0; i < sz; i += PGSIZE){
  106995:	b8 01 00 00 00       	mov    $0x1,%eax
    else n = PGSIZE;
    if(readi(ip, (char *)pa, offset+i, n) != n)
      return 0;
  }
  return 1;
}
  10699a:	5b                   	pop    %ebx
  10699b:	5e                   	pop    %esi
  10699c:	5f                   	pop    %edi
  10699d:	5d                   	pop    %ebp
  10699e:	c3                   	ret    

  if((uint)addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned\n");
  for(i = 0; i < sz; i += PGSIZE){
    if(!(pte = walkpgdir(pgdir, addr+i, 0)))
      panic("loaduvm: address should exist\n");
  10699f:	c7 04 24 74 75 10 00 	movl   $0x107574,(%esp)
  1069a6:	e8 d5 9e ff ff       	call   100880 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint)addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned\n");
  1069ab:	c7 04 24 50 75 10 00 	movl   $0x107550,(%esp)
  1069b2:	e8 c9 9e ff ff       	call   100880 <panic>
  1069b7:	89 f6                	mov    %esi,%esi
  1069b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

001069c0 <switchuvm>:
}

// Switch h/w page table and TSS registers to point to process p.
void
switchuvm(struct proc *p)
{
  1069c0:	55                   	push   %ebp
  1069c1:	89 e5                	mov    %esp,%ebp
  1069c3:	53                   	push   %ebx
  1069c4:	83 ec 04             	sub    $0x4,%esp
  1069c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
  1069ca:	e8 e1 d1 ff ff       	call   103bb0 <pushcli>

  // Setup TSS
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
  1069cf:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  1069d5:	8d 48 08             	lea    0x8(%eax),%ecx
  1069d8:	89 ca                	mov    %ecx,%edx
  1069da:	c1 ea 18             	shr    $0x18,%edx
  1069dd:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
  1069e3:	89 ca                	mov    %ecx,%edx
  1069e5:	c1 ea 10             	shr    $0x10,%edx
  1069e8:	c6 80 a5 00 00 00 99 	movb   $0x99,0xa5(%eax)
  1069ef:	88 90 a4 00 00 00    	mov    %dl,0xa4(%eax)
  1069f5:	c6 80 a6 00 00 00 40 	movb   $0x40,0xa6(%eax)
  1069fc:	66 89 88 a2 00 00 00 	mov    %cx,0xa2(%eax)
  106a03:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
  106a0a:	67 00 
  cpu->gdt[SEG_TSS].s = 0;
  106a0c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  106a12:	80 a0 a5 00 00 00 ef 	andb   $0xef,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
  106a19:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  106a1f:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
  106a25:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  106a2b:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
  106a31:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  106a37:	81 c2 00 10 00 00    	add    $0x1000,%edx
  106a3d:	89 50 0c             	mov    %edx,0xc(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
  106a40:	b8 30 00 00 00       	mov    $0x30,%eax
  106a45:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);

  if(p->common->pgdir == 0)
  106a48:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
  106a4e:	8b 40 04             	mov    0x4(%eax),%eax
  106a51:	85 c0                	test   %eax,%eax
  106a53:	74 0d                	je     106a62 <switchuvm+0xa2>
}

static inline void
lcr3(uint val) 
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
  106a55:	0f 22 d8             	mov    %eax,%cr3
    panic("switchuvm: no pgdir\n");

  lcr3(PADDR(p->common->pgdir));  // switch to new address space
  popcli();
}
  106a58:	83 c4 04             	add    $0x4,%esp
  106a5b:	5b                   	pop    %ebx
  106a5c:	5d                   	pop    %ebp

  if(p->common->pgdir == 0)
    panic("switchuvm: no pgdir\n");

  lcr3(PADDR(p->common->pgdir));  // switch to new address space
  popcli();
  106a5d:	e9 8e d1 ff ff       	jmp    103bf0 <popcli>
  cpu->ts.ss0 = SEG_KDATA << 3;
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
  ltr(SEG_TSS << 3);

  if(p->common->pgdir == 0)
    panic("switchuvm: no pgdir\n");
  106a62:	c7 04 24 3b 75 10 00 	movl   $0x10753b,(%esp)
  106a69:	e8 12 9e ff ff       	call   100880 <panic>
  106a6e:	66 90                	xchg   %ax,%ax

00106a70 <ksegment>:

// Set up CPU's kernel segment descriptors.
// Run once at boot time on each CPU.
void
ksegment(void)
{
  106a70:	55                   	push   %ebp
  106a71:	89 e5                	mov    %esp,%ebp
  106a73:	83 ec 18             	sub    $0x18,%esp

  // Map virtual addresses to linear addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  106a76:	e8 75 b9 ff ff       	call   1023f0 <cpunum>
  106a7b:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
  106a81:	05 40 c0 10 00       	add    $0x10c040,%eax
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
  106a86:	8d 88 b4 00 00 00    	lea    0xb4(%eax),%ecx
  106a8c:	89 ca                	mov    %ecx,%edx
  106a8e:	c1 ea 18             	shr    $0x18,%edx
  106a91:	88 90 8f 00 00 00    	mov    %dl,0x8f(%eax)
  106a97:	89 ca                	mov    %ecx,%edx
  106a99:	c1 ea 10             	shr    $0x10,%edx
  106a9c:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
  106aa2:	8d 50 70             	lea    0x70(%eax),%edx
  // Map virtual addresses to linear addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  106aa5:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  106aa9:	c6 40 7e cf          	movb   $0xcf,0x7e(%eax)
  106aad:	c6 40 7d 9a          	movb   $0x9a,0x7d(%eax)
  106ab1:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
  106ab5:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
  106abb:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  106ac1:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  106ac8:	c6 80 86 00 00 00 cf 	movb   $0xcf,0x86(%eax)
  106acf:	c6 80 85 00 00 00 92 	movb   $0x92,0x85(%eax)
  106ad6:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
  106add:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
  106ae4:	00 00 
  106ae6:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
  106aed:	ff ff 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  106aef:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  106af6:	c6 80 96 00 00 00 cf 	movb   $0xcf,0x96(%eax)
  106afd:	c6 80 95 00 00 00 fa 	movb   $0xfa,0x95(%eax)
  106b04:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
  106b0b:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
  106b12:	00 00 
  106b14:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
  106b1b:	ff ff 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
  106b1d:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)
  106b24:	c6 80 9e 00 00 00 cf 	movb   $0xcf,0x9e(%eax)
  106b2b:	c6 80 9d 00 00 00 f2 	movb   $0xf2,0x9d(%eax)
  106b32:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
  106b39:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
  106b40:	00 00 
  106b42:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
  106b49:	ff ff 

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
  106b4b:	c6 80 8e 00 00 00 c0 	movb   $0xc0,0x8e(%eax)
  106b52:	c6 80 8d 00 00 00 92 	movb   $0x92,0x8d(%eax)
  106b59:	66 89 88 8a 00 00 00 	mov    %cx,0x8a(%eax)
  106b60:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
  106b67:	00 00 
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  106b69:	66 c7 45 fa 37 00    	movw   $0x37,-0x6(%ebp)
  pd[1] = (uint)p;
  106b6f:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
  106b73:	c1 ea 10             	shr    $0x10,%edx
  106b76:	66 89 55 fe          	mov    %dx,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
  106b7a:	8d 55 fa             	lea    -0x6(%ebp),%edx
  106b7d:	0f 01 12             	lgdtl  (%edx)
}

static inline void
loadgs(ushort v)
{
  asm volatile("movw %0, %%gs" : : "r" (v));
  106b80:	ba 18 00 00 00       	mov    $0x18,%edx
  106b85:	8e ea                	mov    %edx,%gs
  lgdt(c->gdt, sizeof(c->gdt));
  loadgs(SEG_KCPU << 3);
  
  // Initialize cpu-local storage.
  cpu = c;
  proc = 0;
  106b87:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
  106b8e:	00 00 00 00 

  lgdt(c->gdt, sizeof(c->gdt));
  loadgs(SEG_KCPU << 3);
  
  // Initialize cpu-local storage.
  cpu = c;
  106b92:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
}
  106b98:	c9                   	leave  
  106b99:	c3                   	ret    
  106b9a:	90                   	nop    
  106b9b:	90                   	nop    
  106b9c:	90                   	nop    
  106b9d:	90                   	nop    
  106b9e:	90                   	nop    
  106b9f:	90                   	nop    

00106ba0 <initrwlock>:
#include "rwlock.h"
#include "proc.h"

void
initrwlock(struct rwlock *m)
{
  106ba0:	55                   	push   %ebp
  106ba1:	89 e5                	mov    %esp,%ebp
// HW3 Todo
}
  106ba3:	5d                   	pop    %ebp
  106ba4:	c3                   	ret    
  106ba5:	8d 74 26 00          	lea    0x0(%esi),%esi
  106ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00106bb0 <destroyrwlock>:

void
destroyrwlock(struct rwlock *m)
{
  106bb0:	55                   	push   %ebp
  106bb1:	89 e5                	mov    %esp,%ebp
// HW3 Todo
}
  106bb3:	5d                   	pop    %ebp
  106bb4:	c3                   	ret    
  106bb5:	8d 74 26 00          	lea    0x0(%esi),%esi
  106bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00106bc0 <readlock>:

void
readlock(struct rwlock *m)
{
  106bc0:	55                   	push   %ebp
  106bc1:	89 e5                	mov    %esp,%ebp
// HW3 Todo
}
  106bc3:	5d                   	pop    %ebp
  106bc4:	c3                   	ret    
  106bc5:	8d 74 26 00          	lea    0x0(%esi),%esi
  106bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00106bd0 <readunlock>:

void
readunlock(struct rwlock *m)
{
  106bd0:	55                   	push   %ebp
  106bd1:	89 e5                	mov    %esp,%ebp
// HW3 Todo
}
  106bd3:	5d                   	pop    %ebp
  106bd4:	c3                   	ret    
  106bd5:	8d 74 26 00          	lea    0x0(%esi),%esi
  106bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00106be0 <writelock>:

void
writelock(struct rwlock *m)
{
  106be0:	55                   	push   %ebp
  106be1:	89 e5                	mov    %esp,%ebp
// HW3 Todo
}
  106be3:	5d                   	pop    %ebp
  106be4:	c3                   	ret    
  106be5:	8d 74 26 00          	lea    0x0(%esi),%esi
  106be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00106bf0 <writeunlock>:

void
writeunlock(struct rwlock *m)
{
  106bf0:	55                   	push   %ebp
  106bf1:	89 e5                	mov    %esp,%ebp
// HW3 Todo
}
  106bf3:	5d                   	pop    %ebp
  106bf4:	c3                   	ret    
  106bf5:	8d 74 26 00          	lea    0x0(%esi),%esi
  106bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00106c00 <sys_rwlock>:

int
sys_rwlock()
{
  106c00:	55                   	push   %ebp
  106c01:	89 e5                	mov    %esp,%ebp
  106c03:	83 ec 28             	sub    $0x28,%esp
  struct rwlock *m;
  int op;

  if (argptr(0, (char **)&m, sizeof(struct rwlock)) < 0 || argint(1, &op) < 0)
  106c06:	8d 45 fc             	lea    -0x4(%ebp),%eax
  106c09:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  106c10:	00 
  106c11:	89 44 24 04          	mov    %eax,0x4(%esp)
  106c15:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  106c1c:	e8 7f d7 ff ff       	call   1043a0 <argptr>
  106c21:	85 c0                	test   %eax,%eax
  106c23:	79 07                	jns    106c2c <sys_rwlock+0x2c>
    case OP_DESTROY: destroyrwlock(m); break;
    default: return -1; // Invalid op. 
  }

  return 0;
}
  106c25:	c9                   	leave  
  int op;

  if (argptr(0, (char **)&m, sizeof(struct rwlock)) < 0 || argint(1, &op) < 0)
    return -1;

  switch (op) {
  106c26:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    case OP_DESTROY: destroyrwlock(m); break;
    default: return -1; // Invalid op. 
  }

  return 0;
}
  106c2b:	c3                   	ret    
sys_rwlock()
{
  struct rwlock *m;
  int op;

  if (argptr(0, (char **)&m, sizeof(struct rwlock)) < 0 || argint(1, &op) < 0)
  106c2c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  106c2f:	89 44 24 04          	mov    %eax,0x4(%esp)
  106c33:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  106c3a:	e8 d1 d6 ff ff       	call   104310 <argint>
  106c3f:	85 c0                	test   %eax,%eax
  106c41:	78 e2                	js     106c25 <sys_rwlock+0x25>
    return -1;

  switch (op) {
  106c43:	31 c0                	xor    %eax,%eax
  106c45:	83 7d f8 05          	cmpl   $0x5,-0x8(%ebp)
  106c49:	77 da                	ja     106c25 <sys_rwlock+0x25>
    case OP_DESTROY: destroyrwlock(m); break;
    default: return -1; // Invalid op. 
  }

  return 0;
}
  106c4b:	c9                   	leave  
  106c4c:	8d 74 26 00          	lea    0x0(%esi),%esi
  106c50:	c3                   	ret    
