MEMORY {
  file (RWX) : ORIGIN = 0x00000000, LENGTH = 512
  memory (RWX) : ORIGIN = 0x00007c00, LENGTH = 512
}

SECTIONS
{
  . = 0x00000;
  .text : { *(.text) } > memory AT>file
  .data : { *(.data) } > memory AT>file
  .bss : { *(.bss) } > memory AT>file
  
  .tail :
  {
    . = ORIGIN(memory) + LENGTH(memory) - 2;
    BYTE(0x55);
    BYTE(0xAA);
  } > memory AT>file
}
