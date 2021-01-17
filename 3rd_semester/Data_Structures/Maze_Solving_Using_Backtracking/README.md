# Maze Solving using backtracking


Description 


Athens university of economics and business 
Informatics Department
Autumn Semester 2019 
 
Data  Structures – Project 1 
 
Queues: Implementation and application 
The goal of this project is familiarization with basic data structures like FIFO queues and stacks. 
Part A [30 points]. Interfaces StringStack and StringQueue, declare the basic methods for a stack and a FIFO queue with String elements. Create the implementation of StringStack and StringQueue. 
 
Implementation instructions:  
• Classes must be called StringStackImpl and StringQueueImpl. 
• Your implementation for the 2 interfaces must use single linked list.  
• Every push and pop in the stack and every put and get in the FIFO queue should be completed in O (1). The same applies to size method.
• When the stack is empty, the methods that read from the structures should throw an exception like NoSuchElementException(this exception belongs to java.util package). 
• You can use the single linked list presented to you in the course’s lab or you can write your own or use only Node items inside Queue/Stack class. For better understanding we advice you to write your own classes.
• Optionally: you can do the implementation using generics to be able to use stacks and queues with different types of arguments. There is a 10% bonus if you do the implementation using generic …
• You can’t use premade data structures like list ,stack ,queue , from Java’s library( Vector, ArrayList ..). 
 
 
Part B [30 points]. Using the stack implementation from part A , write a program that will search a maze in order to find an exit . The program will read a user input txt file that will contain the maze in the form of an char array , having n x m dimension .The array can only contain the characters 0,1,E where E should only be in the starting point of the maze(there should be only one E) .When someone gets in the maze , only horizontally and vertically steps are allowed ,towards any direction that has a 0. If you reach the arrays borders and you find 0, then you’ve reached an exit. It is possible to have multiple exits (or zero). Your program should print the coordinates of the exit it found. If there are no exits, it should print the appropriate message (the same goes for errors).
 
Example: The input will be a txt file in this form:
9  7 
0 3 
1 1  1  Å  1  1  1 
1  1  1  0  1  1  1 
1  0  0  0  1  0  1 
1  0  1  0  1  0  0 
1  1  1  0  1  1  1 
1  0  0  0  0  0  1 
1  0  1  1  1  0  1 
1  0  1  1  0  0  1 
0  1  1  1  0  1  1 
 
Array dimensions are declared in the first line (in the example above  n=9, m=7).Coordinates are given in the second line (in the example above (0,3)) .In this example, searching will start moving down . If you turn right, you’ll see that you will soon reach a dead-end and you’ll go back .If you keep searching , a possible exist you can find is (8, 4).   
 
Implementation instructions: 
• Program must be called Thiseas.java. 
• You must use stack implementation from part A. Usage of stack is indicated for finding the exit with backtracking. Think about what you should do when you reach a dead-end and how you can overcome it.
• To check the accuracy of your program, make different mazes with different characteristics and run the program with them as input.   
• Changing array characters is allowed (using a different character to flag the positions you have visited),but you should also use the stack from part A. 
• If there is any wrong parameter in the txt, the program should end print the appropriate message .
• The argument should be the path for the txt file. If you run it from command it should  be like :
 
> java Thiseas path_to_file/filename.txt 
 
Part C [30 points].  The implementation of StringQueue interface with single pointer queue in part A , should use 2 variables pointing head and tail in order to do correctly the imports and the exports. For part C you must make a new implementation for FIFO queue , using only one variable.  Hint: Use circular linked list instead of single linked list .
 
Implementation instructions:  
• The class must be named StringQueueWithOnePointer.java. 
• Imports and exports should be completed in O(1) .The rules for part A also apply for part C.
 
Part D - Report [10 points].Prepare a report in a pdf file that contains:  
a. How you implemented part A and part B interfaces. Especially for part C, explain how you avoided to use 2 pointer for the head and the tail of the queue .
b. For part B , explain how you used the implementation from part A to build you .
