# prog3.s by Shuaib Syed
# I pledge on my honor that I have not given or received any
# unauthorized assitance on this assignment.

# This program determines the number of digits in any number with any 
# positive base. It reads one integer as the number and another as the base. 
# It then passes the numbers into another function which actually computes the
# number of the digits. This program is estientially the same as prog2.s but 
# function computes the number of digits recursively. 

.data
number: .word 0
base:   .word 0
result: .word 0
newline: .asciiz "\n"

.text
.globl main

main:
    # Set up the stack frame
    addiu $sp, $sp, -16
    sw $ra, 12($sp)

    # Read the first integer input (number) using syscall 5
    li $v0, 5
    syscall
    # Store the input value in the memory location labeled 'number'
    sw $v0, number

    # Read the second integer input (base) using syscall 5
    li $v0, 5
    syscall
    # Store the input value in the memory location labeled 'base'
    sw $v0, base

    # Load values of number and base into $a0 and $a1
    lw $a0, number
    lw $a1, base

    # Call num_digits function
    jal num_digits

    # Store the result
    sw $v0, result

    # Print the result as an integer using syscall 1
    lw $a0, result
    li $v0, 1
    syscall

    # Print a newline character
    la $a0, newline
    li $v0, 4
    syscall

    # Clean up the stack and return
    lw $ra, 12($sp)
    addiu $sp, $sp, 16

    # Exit the program using syscall 10
    li $v0, 10
    syscall

num_digits:
    # Set up the stack frame
    addiu $sp, $sp, -16
    sw $ra, 12($sp)
    sw $a0, 8($sp) # Save n
    sw $a1, 4($sp) # Save base

    # Check if base <= 0
    ble $a1, 0, base_negative_or_zero

    # Check if n < 0
    blt $a0, 0, negate_n

skip_negate_n:
    # Check if n == base
    beq $a0, $a1, n_equals_base
    # Check if base == 1
    bne $a1, 1, base_not_one

    # ans = n
    add $v0, $a0, $zero
    b end

n_equals_base:
    li $v0, 2
    b end

base_not_one:
    # Check if n < base
    blt $a0, $a1, n_less_than_base

    # ans = 1 + num_digits(n / base, base)
    div $a0, $a1
    mflo $a0
    sw $a0, 0($sp) # Save n / base on the stack
    jal num_digits
    lw $a0, 0($sp) # Restore n / base from the stack

    addiu $v0, $v0, 1
    b end

n_less_than_base:
    li $v0, 1
    b end

negate_n:
    sub $a0, $zero, $a0
    b skip_negate_n

base_negative_or_zero:
    li $v0, -1

end:
    # Restore the stack and return
    lw $ra, 12($sp)
    addiu $sp, $sp, 16
    jr $ra
