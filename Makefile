

floppy.img : mbr.bin
	dd if=/dev/zero of=floppy.img count=2880 bs=512 status=none
	dd if=mbr.bin of=floppy.img count=1 bs=512 status=none


mbr.bin : mbr.o mbr.lds
	ld mbr.o --oformat=binary -o mbr.bin -T mbr.lds -Map=mbr.map

mbr.o : mbr.s
	as mbr.s -o mbr.o

.PHONY: clean
clean:
	rm -f *.o mbr.bin floppy.img *~
#all:
#as mbr.s -o mbr.o
#ld mbr.o --oformat=binary -o mbr.bin -T mbr.lds 
