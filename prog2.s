# prog2.s by Shuaib Syed
# I pledge on my honor that I have not given or received any
# unauthorized assitance on this assignment.

# This program determines the number of digits in any number with any 
# positive base. It reads one integer as the number and another as the base. 
# It then passes the numbers into another function which actually computes the
# number of the digits. It does this through repeated divison and returns the 
# result. 

.data
number: .word 0
base: .word 0
result: .word 0
newline: .asciiz "\n"

.text
main:
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

    # Load the values from memory locations 'number' and 'base' 
    lw $a0, number
    lw $a1, base

    # Call the num_digits function
    jal num_digits

    # Store the returned result from the num_digits function 
    sw $v0, result

    # Load the value from the memory location 'result' into register $a0
    lw $a0, result

    # Print the result as an integer using syscall 1
    li $v0, 1
    syscall

    # Print a newline character
    la $a0, newline
    li $v0, 4
    syscall

    # Exit the program using syscall 10
    li $v0, 10
    syscall


num_digits:
    # function prologue
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $s0, ($sp)

    # Initialize ans to 0
    li $s0, 0

    # Check if base is less than or equal to 0
    blez $a1, invalid_base
    # If base is less than or equal to 0, jump to invalid_base

    # Check if n is equal to 0
    beq $a0, $zero, n_zero
    # If n is equal to 0, jump to n_zero

    # If n is not equal to 0 and base is greater than 0, execute the while 
    move $t0, $a0  # Copy n to $t0
    while_loop:
    div $t0, $a1  # Divide n by base
    mflo $t1  # Move quotient to $t1

    beq $t0, $zero, done  # If quotient is 0, jump to done

    addi $s0, $s0, 1  # Increment ans
    move $t0, $t1  # Update $t0 with the new quotient for the next iteration
    j while_loop  # Repeat loop


invalid_base:
    li $s0, -1
    # Set ans to -1 if base is less than or equal to 0
    j done

n_zero:
    li $s0, 1
    # Set ans to 1 if n is equal to 0
    j done

# function epilogue
done:
    move $v0, $s0  # Move ans to return register
    lw $ra, 4($sp)
    lw $s0, ($sp)
    addi $sp, $sp, 8
    jr $ra

