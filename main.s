/*
 * Mieszko Mazurek
 * Jul 2018
 */

  .text
  .global main
  .type main, %function
  .align 4
main:
  /* init irq_systick */
  ldr r0, =0xe000e010
  ldr r1, =0x00000007
  str r1, [r0]
  add r0, r0, #4
  ldr r1, =16000000
  str r1, [r0]

  /* init leds */
  ldr r0, =0x40040110
  ldr r1, =0x00008080
  str r1, [r0]
  b .
  .size main, .-main

  .type toggle, %function
  .align 4
toggle:
  ldr r0, =0x40040100
  ldr r1, [r0]
  mov r2, #3
  eor r1, r1, r2
  str r1, [r0]
  mov pc, lr
  .size toggle, .-toggle

  .global irq_systick
  .type irq_systick, %function
  .align 4
irq_systick:
  bl toggle
  ldr r0, =0xfffffff1
  bx r0
  .size irq_systick, .-irq_systick
