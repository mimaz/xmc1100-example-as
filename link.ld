/*
 * Mieszko Mazurek
 * Jul 2018
 */

MEMORY
{
  FLASH(rx) : ORIGIN = 0x10001000, LENGTH = 64k
  RAM(rwx) : ORIGIN = 0x20000000, LENGTH = 16k
}

SECTIONS
{
  . = ORIGIN(FLASH);

  .text :
  {
    *(.isr_flash)
    *(.text)
  } >FLASH

  . = ORIGIN(RAM);
  . = ALIGN(4);

  .data :
  {
    __data_load = LOADADDR(.data);
    __data_begin = .;
    *(.isr_ram);
    *(.data);
    . = ALIGN(4);
    __data_end = .;
  } >RAM AT>FLASH

  . = ALIGN(4);

  .bss : 
  {
    __bss_begin = .;
    *(.bss);
    . = ALIGN(4);
    __bss_end = .;
  } >RAM
}
