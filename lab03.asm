# lab03.asm - Recursive palindrome string tester
#   coded in  MIPS assembly using MARS
# for MYΥ-505 - Computer Architecture, Fall 2021
# Department of Computer Science and Engineering, University of Ioannina
# Instructor: Aris Efthymiou

.globl pdrome

###############################################################################
.data
anna:  .asciiz "anna"
bobob: .asciiz "bobob"
input: .asciiz
input_len: .word
###############################################################################
.text
  la    $a0, anna
  addi  $a1, $zero, 4
  jal   pdrome
  add   $s0, $v0, $zero  # keep the return value

  la    $a0, bobob
  addi  $a1, $zero, 5
  jal   pdrome
  add   $s1, $v0, $zero  # keep the return value
  # both s1 and s0 must be 1 here

  addiu   $v0, $zero, 10    # system service 10 is exit
  syscall                   # we are outa here.


pdrome:
la	$a0, input_len	# Load data
	lw	$a0, 0($a0)
	la	$a1, input
	jal 	isPalindrome	# Do the Palindrome check
	add	$a0, $v0, $zero
	jal	pdrome	# Print
	addi	$v0, $zero, 10
	syscall			# Exit


isPalindrome:
	# Check base case
	slti	$t0, $a0, 2
	bne	$t0, $zero, returnTrue

	# Make sure first and last are equal
	lb	$t0, 0($a1)
	addi	$t1, $a0, -1
	add	$t1, $t1, $a1
	lb	$t1, 0($t1)
	bne	$t0, $t1, returnFalse
	
	# Shift pointer, length, recurse
	addi	$a0, $a0, -2
	addi	$a1, $a1, 1
	j	isPalindrome
	
returnFalse:
	addi	$v0, $zero, 0
	jr	$ra


returnTrue:
	addi	$v0, $zero, 1
	jr	$ra
 