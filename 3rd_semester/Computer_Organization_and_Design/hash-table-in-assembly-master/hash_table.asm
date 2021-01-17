.data
menu:.asciiz"\n Menu \n"
msg1:.asciiz"1.Insert Key \n"
msg2:.asciiz"2.Find Key \n"
msg3:.asciiz"3.Display Hash Table \n"
msg4:.asciiz"4.Exit"
choice:.asciiz"\nChoice?"
choice1msg1:.asciiz"Give new key (greater than zero): "
choice1msg2:.asciiz"key must be greater than zero"
choice2msg1:.asciiz"Give key to search for: "
choice2msg2:.asciiz"Key not in hash table"
choice2msg3:.asciiz"Key value = "
choice2msg4:.asciiz"\n Table position = "
insertkeymsg1:.asciiz"Key is already in hash table."
insertkeymsg2:.asciiz"hash table is full"
poskey:.asciiz"\npos key\n"
space:.asciiz" "
N:.word 10
keys:.word 0
myArray:.space 40
.text
.globl main 
main:


run:
	li $t0,0  #key
	li $t1,0  #pos
	li $t2,0  #choice
	li $t3,0  #telos
	la $t4,myArray
	li $s3,0
	
	#printing menu 
	 li $v0, 4
	 la $a0, menu
	 syscall
	 li $v0, 4
	 la $a0, msg1
	 syscall
	 li $v0, 4
	 la $a0, msg2
	 syscall
	 li $v0, 4
	 la $a0, msg3
	 syscall
	 li $v0, 4
	 la $a0, msg4
	 syscall
	 li $v0, 4
	 la $a0, choice
	 syscall
	 li $v0,5 #diavazei thn epilogh
	 syscall
	 move $t2,$v0
	 
	 beq $t2,1,choiceone
	 beq $t2,2,choicetwo
	 beq $t2,3,choicethree
	 beq $t2,4,choicefour
	 
	 choiceone: #if choice=1
	 li $v0, 4
	 la $a0, choice1msg1
	 syscall
	 
	
	 
	 li $v0, 5
	syscall
	move $t7, $v0
	 
	 ble $t7,0,else1
	 	move $a0,$t4
	 	move $a1,$t7
	 	jal insertkey
	 	j end
	 else1:
	 	li $v0, 4
	 	la $a0, choice1msg2
	 	syscall
	 	j end
	 	
	 	
	 	
	 choicetwo:#if choice=2
	 li $v0, 4
	 la $a0, choice2msg1
	 syscall
	 	 
	 
	 li $v0, 5
	syscall
	move $t7, $v0
	 
	 move $a0,$t4
	 move $a1,$t7
	 jal findkey
	 move $t1,$v0 
	 bne $t1,-1,else2
	 	li $v0, 4
	 	la $a0, choice2msg2
	 	syscall
		j end
	 else2:
	 	mul $t1,$t1,4
	 	add $t4,$t4,$t1

	 	li $v0, 4
	 	la $a0, choice2msg3
	 	syscall
	 	
	 	lw $a0,($t4)
	 	li $v0,1
	 	syscall
	 	
	 	sub $t4,$t4,$t1
	 	div $t1,$t1,4
	 	
	 	li $v0, 4
	 	la $a0, choice2msg4
	 	syscall
	 	move $a0,$t1
	 	li $v0,1
	 	syscall
	 	
	 j end
	 choicethree:#if choice=3
	 	move $a0,$t4
	 	jal displaytable
	 	
	 j end
	 choicefour:#if choice=4
	 	li $t3,1
	 end:
	 beq $t3,0,run
	 li $v0,10
	 syscall

	
	 

       
 insertkey:
sub $sp,$sp,36
sw $s0,0($sp)
sw $s1,4($sp)
sw $s2,8($sp)
sw $s3,12($sp)
sw $s4,16($sp)
sw $s5,20($sp)
sw $s6,24($sp)
sw $s7,28($sp)
sw $ra,32($sp)
move $s0,$a0 #array
move $s1,$a1 #k
jal findkey
move $s2,$v0 #position

la $s3,N
lw $s3,($s3) #t5=N=10
la $s4,keys
lw $s4,($s4)

beq $s2,-1,else3  			#if position !=-1
	 li $v0, 4			#
	 la $a0, insertkeymsg1		#
	 syscall
	 j exitinsertkey		#
else3:					#else
	bge $s4,$s3,else4		#if keys<N
		move $a0,$s0
		move $a1,$s1
		jal hashfunction
		move $s2,$v0            #position=hashfunction(hash,k)
		
		mul $s2,$s2,4
		add $s0,$s0,$s2
		sw $s1,($s0)		#hash[position]=k
		add $s4,$s4,1         #keys++
		la $s5,keys
		sw $s4,($s5)
		j exitinsertkey
	
	else4:
		li $v0, 4
		la $a0, insertkeymsg2
		syscall
exitinsertkey:	
lw $s0,0($sp)
lw $s1,4($sp)
lw $s2,8($sp)
lw $s3,12($sp)
lw $s4,16($sp)
lw $s5,20($sp)
lw $s6,24($sp)
lw $s7,28($sp)
lw $ra,32($sp)
add $sp,$sp,36
jr $ra



hashfunction:
sub $sp,$sp,32
sw $s0,0($sp)
sw $s1,4($sp)
sw $s2,8($sp)
sw $s3,12($sp)
sw $s4,16($sp)
sw $s5,20($sp)
sw $s6,24($sp)
sw $s7,28($sp)

move $s0,$a0
move $s1,$a1
la $s2,N
lw $s2,($s2) #s2=N=10
la $s3,keys #s3=keys
lw $s3,($s3)

rem $s4,$s1,$s2	#position
mul $s4,$s4,4
add $s5,$s4,$s0 #dieuthynsh stoixeiou
lw $s6,($s5)
div $s4,$s4,4
while:
	beq $s6,0,exithashfunction
		add $s4,$s4,1
		rem $s4,$s4,$s2	#position
		
		mul $s4,$s4,4
		add $s5,$s4,$s0 #dieuthynsh stoixeiou
		lw $s6,($s5)
		div $s4,$s4,4	
		j while
exithashfunction:
move $v0,$s4
lw $s0,0($sp)
lw $s1,4($sp)
lw $s2,8($sp)
lw $s3,12($sp)
lw $s4,16($sp)
lw $s5,20($sp)
lw $s6,24($sp)
lw $s7,28($sp)
add $sp,$sp,32
jr $ra



findkey:
sub $sp,$sp,32
sw $s0,0($sp)
sw $s1,4($sp)
sw $s2,8($sp)
sw $s3,12($sp)
sw $s4,16($sp)
sw $s5,20($sp)
sw $s6,24($sp)
sw $s7,28($sp)
move $s0,$a0
move $s1,$a1
la $s2,N
lw $s2,($s2) #s2=N=10
rem $s3,$s1,$s2 #position
li $s4,1 #i=0
li $s5,0 #found=0



while2:
	bge $s4,$s2,endwhile2
	bne $s5,0,endwhile2
	add $s4,$s4,1
	mul $s3,$s3,4
	add $s6,$s0,$s3 #s6=hash[position]
	lw $s6,($s6)
	div $s3,$s3,4
		bne $s6,$s1,else5
			li $s5,1
			j while2
		else5:
			add $s3,$s3,1
			rem $s3,$s3,$s2
			j while2
endwhile2:
bne $s5,1,else6
	
	move $v0,$s3
	j exitfindkey
else6:
	li $v0,-1
exitfindkey:
lw $s0,0($sp)
lw $s1,4($sp)
lw $s2,8($sp)
lw $s3,12($sp)
lw $s4,16($sp)
lw $s5,20($sp)
lw $s6,24($sp)
lw $s7,28($sp)
add $sp,$sp,32
jr $ra




displaytable:
sub $sp,$sp,32
sw $s0,0($sp)
sw $s1,4($sp)
sw $s2,8($sp)
sw $s3,12($sp)
sw $s4,16($sp)
sw $s5,20($sp)
sw $s6,24($sp)
sw $s7,28($sp)
move $s0,$a0
move $s1,$a1
li $v0, 4
la $a0, poskey
syscall
la $s2,N
lw $s2,($s2) #s2=N=10

li $s3,-1 #s2=i
for:
	add $s3,$s3,1
	bge $s3,$s2,exitfor
		li $v0, 4
		la $a0, space
		syscall
		move $a0,$s3
		li $v0,1
		syscall
		li $v0, 4
		la $a0, space
		syscall
		mul $s3,$s3,4
		add $s4,$s0,$s3
		lw $s4,($s4)
		div $s3,$s3,4
		move $a0,$s4
		li $v0,1
		syscall
		j for
exitfor:
lw $s0,0($sp)
lw $s1,4($sp)
lw $s2,8($sp)
lw $s3,12($sp)
lw $s4,16($sp)
lw $s5,20($sp)
lw $s6,24($sp)
lw $s7,28($sp)
add $sp,$sp,32
jr $ra
