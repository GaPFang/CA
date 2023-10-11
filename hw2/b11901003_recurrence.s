.globl __start

.rodata

.text
__start:
    li a0, 5
    ecall
    mv s2, a0
    jal x1, T
    jal x0, output

T:
    addi sp, sp, -8
    sw s2, 4(sp)
    sw x1, 0(sp)
    addi t0, s2, -1
    ble t0, x0, leave_T
    addi a1, x0, 0
    addi s2, s2, -1
    jal x1, T
    addi sp, sp, -4
    sw a1, 0(sp)
    addi a1, x0, 0
    addi s2, s2, -1
    jal x1, T
    addi t0, a1, 0
    lw a1, 0(sp)
    addi sp, sp, 4
    addi t1, x0, 2
    mul a1, a1, t1
    add a1, a1, t0
    lw x1, 0(sp)
    lw s2 4(sp)
    addi sp, sp, 8
    jalr x0, 0(x1)
leave_T:
    lw x1, 0(sp)
    lw s2 4(sp)
    addi sp, sp, 8
    beq s2, x0, s2_is_0
    li a1, 1
    jalr x0, 0(x1)
s2_is_0:
    li a1, 0
    jalr x0, 0(x1)

output:
    li a0, 1
    ecall

exit:
    li a0 10
    ecall