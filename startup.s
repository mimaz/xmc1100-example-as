/*
 * Mieszko Mazurek
 * Jul 2018
 */

  .macro irq_entry, handler
    ldr r0, =\handler
    mov pc, r0
  .endm

  .macro irq_hook, handler
    .global \handler
    .type \handler, %function
    .weak \handler
  \handler:
    b \handler
    .size \handler, .-\handler
  .endm
  
  .section .text, "ax", %progbits
  .type _start, %function
  .global _start
  .align 4
_start:
  ldr r0, =__data_begin
  ldr r1, =__data_end
  ldr r2, =__data_load
  b 1f
0:
  ldr r3, [r2]
  str r3, [r0]
  add r0, r0, #4
  add r2, r2, #4
1:
  cmp r0, r1
  bne 0b

  ldr r0, =__bss_begin
  ldr r1, =__bss_end
  mov r2, #0
  b 1f
0:
  str r2, [r0]
  add r0, r0, #4
1:
  cmp r0, r1
  bne 0b

  cpsie i
  bl main
2:
  b 2b
  .size _start, .-_start

  irq_hook irq_reserved
  irq_hook irq_hardfault
  irq_hook irq_svcall
  irq_hook irq_pendsv
  irq_hook irq_systick
  irq_hook irq_0
  irq_hook irq_1
  irq_hook irq_2
  irq_hook irq_3
  irq_hook irq_4
  irq_hook irq_5
  irq_hook irq_6
  irq_hook irq_7
  irq_hook irq_8
  irq_hook irq_9
  irq_hook irq_10
  irq_hook irq_11
  irq_hook irq_12
  irq_hook irq_13
  irq_hook irq_14
  irq_hook irq_15
  irq_hook irq_16
  irq_hook irq_17
  irq_hook irq_18
  irq_hook irq_19
  irq_hook irq_20
  irq_hook irq_21
  irq_hook irq_22
  irq_hook irq_23
  irq_hook irq_24
  irq_hook irq_25
  irq_hook irq_26
  irq_hook irq_27
  irq_hook irq_28
  irq_hook irq_29
  irq_hook irq_30
  irq_hook irq_31

  .section .isr_flash, "ax", %progbits
  .global isr_flash
  .align 4
  .type isr_flash, %object
isr_flash:
  .long 0x20004000    /* 0x00 initial stack pointer */
  .long _start        /* 0x04 reset function address */
  .long 0             /* 0x08 */
  .long 0             /* 0x0C */
  .long 0x00000100    /* 0x10 initialize clock divider to 1 */
  .long 0x80000000    /* 0x14 do not configure peripheral clock at startup */
  .size isr_flash, .-isr_flash

  .section .isr_ram, "ax", %progbits
  .global isr_ram
  .align 4
  .type isr_ram, %object
isr_ram:
  irq_entry irq_reserved
  irq_entry irq_reserved
  irq_entry irq_reserved
  irq_entry irq_hardfault
  irq_entry irq_reserved
  irq_entry irq_reserved
  irq_entry irq_reserved
  irq_entry irq_reserved
  irq_entry irq_reserved
  irq_entry irq_reserved
  irq_entry irq_reserved
  irq_entry irq_svcall
  irq_entry irq_reserved
  irq_entry irq_reserved
  irq_entry irq_pendsv
  irq_entry irq_systick
  irq_entry irq_0
  irq_entry irq_1
  irq_entry irq_2
  irq_entry irq_3
  irq_entry irq_4
  irq_entry irq_5
  irq_entry irq_6
  irq_entry irq_7
  irq_entry irq_8
  irq_entry irq_9
  irq_entry irq_10
  irq_entry irq_11
  irq_entry irq_12
  irq_entry irq_13
  irq_entry irq_14
  irq_entry irq_15
  irq_entry irq_16
  irq_entry irq_17
  irq_entry irq_18
  irq_entry irq_19
  irq_entry irq_20
  irq_entry irq_21
  irq_entry irq_22
  irq_entry irq_23
  irq_entry irq_24
  irq_entry irq_25
  irq_entry irq_26
  irq_entry irq_27
  irq_entry irq_28
  irq_entry irq_29
  irq_entry irq_30
  irq_entry irq_31
  .size isr_ram, .-isr_ram
