# prog1.s by Shuaib Syed
# I pledge on my honor that I have not given or received any
# unauthorized assitance on this assignment.

# This program reads 4 integers from the input and stores them as l1,w1,l2,w2.
#They stand in for the two rectangles' various sides. In the event that any 
# of the dimensions are negative, the program prints out -2. Otherwise, the 
# program calculates the areas of the rectangles and outputs 0 for equal 
# areas, -1 for smaller areas, and 1 for larger areas.
.data
l1: .word 0
w1: .word 0
l2: .word 0
w2: .word 0
rect1: .word 0
rect2: .word 0
result: .word 0

.text
main: 
    # set result to 0
    li $t0, 0     
    sw $t0, result
    # read integer input from user
    li $v0, 5       
    syscall         
    sw $v0, l1 
    li $v0, 5       
    syscall         
    sw $v0, w1
    li $v0, 5       
    syscall         
    sw $v0, l2
    li $v0, 5       
    syscall         
    sw $v0, w2

    # Checks if anything is negative
    lw $t0, l1
    bltz $t0, negative
    lw $t0, w1
    bltz $t0, negative
    lw $t0, l2
    bltz $t0, negative
    lw $t0, w2
    bltz $t0, negative

    # compute rect1 and rect2
    lw $t0, l1
    lw $t1, w1
    mult $t0, $t1
    mflo $t0
    sw $t0, rect1

    lw $t0, l2
    lw $t1, w2
    mult $t0, $t1
    mflo $t0
    sw $t0, rect2

    # compare rect1 and rect2
    lw $t0, rect1
    lw $t1, rect2
    beq $t0, $t1, equal
    blt $t0, $t1, rect1_less_than_rect2
    bgt $t0, $t1, rect1_greater_than_rect2


negative:
    # set result to -2
    li $t0, -2
    sw $t0, result
    j print_result

rect1_less_than_rect2:
    # set result to -1 
    li $t0, -1
    sw $t0, result
    j print_result

rect1_greater_than_rect2:
    # set result to 1 
    li $t0, 1
    sw $t0, result
    j print_result

equal:
    # set result to 0 
    li $t0, 0
    sw $t0, result
    j print_result

print_result: 
    # print the value of result as an integer followed by a newline character
    lw $a0, result     
    li $v0, 1          
    syscall            
    li $v0, 11         
    li $a0, '\n'       
    syscall
    # terminate program
    li $v0, 10     
    syscall   