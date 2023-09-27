.globl __start

.rodata
    division_by_zero: .string "division by zero"

.text
__start:
    # Read first operand
    li a0, 5
    ecall
    mv s0, a0
    # Read operation
    li a0, 5
    ecall
    mv s1, a0
    # Read second operand
    li a0, 5
    ecall
    mv s2, a0

###################################
#  TODO: Develop your calculator  #
#                                 #
###################################
switch:
    addi t0, s1, 0
    beq t0, x0, addition
    addi t0, t0, -1
    beq t0, x0, subtraction
    addi t0, t0, -1
    beq t0, x0, multiplication
    addi t0, t0, -1
    beq t0, x0, division
    addi t0, t0, -1
    beq t0, x0, minimum
    addi t0, t0, -1
    beq t0, x0, power
    addi t0, t0, -1
    beq t0, x0, factorial
    jal x0, exit

addition:
    add s3, s0, s2
    jal x0, output
    
subtraction:
    sub s3, s0, s2
    jal x0, output
    
multiplication:
    mul s3, s0, s2
    jal x0, output
    
division:
    beq s2, x0, division_by_zero_except
    div s3, s0, s2
    jal x0, output
    
minimum:
    add s3, s0, x0
    blt s0, s2, output
    add s3, s2, x0
    jal x0, output
    
power:
    addi s3, x0, 1
    add s4, x0, x0
powerLoop:
    beq s4, s2, output
    mul s3, s0, s3
    addi s4, s4, 1
    jal x0, powerLoop
    
factorial:
    addi s3, x0, 1
    addi s4, x0, 1
factorialLoop:
    bgt s4, s0, output
    mul s3, s3, s4
    addi s4, s4, 1
    jal x0, factorialLoop

output:
    # Output the result
    li a0, 1
    mv a1, s3
    ecall

exit:
    # Exit program(necessary)
    li a0, 10
    ecall

division_by_zero_except:
    li a0, 4
    la a1, division_by_zero
    ecall
    jal zero, exit
