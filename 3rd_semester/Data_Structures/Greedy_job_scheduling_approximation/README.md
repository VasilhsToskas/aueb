# Storing_files
The program is reading a txt with the memory that each file takes. Every disk can store files that need up to 1 TB of memory. 
The project's goal is to compare the efficiency of two algorithms:
-An algorithm that stores each file in a disk by the order that it reads the files from the txt.
- A greedy algorithm that sorts the files before creating any disks.


Description
 
Data Structures
Department of Informatics

Sorting and Priority Queues
The goal of this project is the familiarization with sorting algorithms and the usage of priority queue, one of the most basic data structures in algorithm design. 
 
The project is about memory usage optimization for large volume of data. First, we have to examine the simplest version. We want to store all the data from the total of N files in hard drives with 1TB space each. Every file is between 0 and 1.000.000 MB(1TB). A file should be stored entirely in one hard drive.  The optimized solution would be using the minimum amount of hard drives. This problem is an example of the famous problem <<Bin Packing>>, a problem that even today does not have an algorithm that finds the optimal solution every time. We can still design efficient functions to approach the optimal solution.

Part A [15 points]. Before we move forward to the algorithms you will implement, let’s begin with the Abstract Data Type you will need. 
 
ADT hard drive: To implement the algorithm you have to implement the data type that represents an 1TB hard drive. Name this class Disk.
Disk class items should 
 
• Have unique id’s that are given to them when a new hard drive is created (useful for debugging). 
• Contain a list named folders, that is initialized as empty . The files that the hard drive contains will be added in this list during the storing algorithm.
• Contain the function getFreeSpace() . When getFreeSpace() is called , it return the free space of the hard drive (in MB).
In Disk class you can add anything you find useful. Disk class should implement the Comparable<Disk> interface in order to be able to use it in a priority queue. For the implementation of the interface Comparable<Disk> you can simply compare the free space of each hard drive : if hard drive A has more free space than hard drive B then A>B and A.compareTo(B) should return 1 . If A<B the function return -1 and if A==B it returns 0.

ADT priority queue. 
For this project you will need an efficient data structure for priority queue. You can use the course’s lab priority queue or you can create your own. In every case , your queue will need functions insert and getmax. Name this class MaxPQ. 
 
For folders list of Disk class , you can’t use pre-made list data structures from java library. You can use the course’s lab one or create your own. 
 
Part B [40 points]. Implement the storing algorithm below. Name your program Greedy.java. 
 
Algorithm  1 - Greedy: Process the files in the order that they appear . If a file fits in one of the hard drives we have already use , we store it in the hard drive with the most free space. Otherwise , we use a new hard drive and store it there.  
 
Example: If our algorithm takes in order 5 files with sizes 200.000, 150.000, 700.000, 800.000, 100.000(MB), it will use 3 hard drives that will store the files {200.000, 150.000, 100.000} in the 1st hard drive , the file with 700.000 size in the 2nd hard drive ,and the file with 800.000 size in the 3rd. In this example , the optimal solution would be to use 2 hard drives instead of 3 ({200.000,800.000}and{150.000,700.000,100.000}). 
Input and output 
 
Input. Program Greedy.java will contain a main function that will read the file size’s from a txt file in order to run the algorithm.Every line of the txt will have the size of the file in MB(an int between 0 and 1000000).In the example , the txt will have this form: 
 
200000 
150000 
700000 
800000 
100000 
 
If a file doesn’t have a size between 0 and 1000000 you should print the appropriate message and end the program. 
 
Output. The program should calculate and print the number of disks used from the algorithm and the sum of the sizes of the hard drives in TB. If the number of files to store is not bigger than 100 , print the index of the hard drives in descending order based on the free space of each hard drive. For every hard drive print the id ,free space and then size of each file stored in the hard drive. Here is an example for the output form: 
% java Greedy input.txt 
Sum of all folders = 6.580996 TB Total number of disks used = 8 id 5 325754: 347661 326585 id 0 227744: 420713 351543 id 7 224009: 383972 392019 id 4 190811: 324387 484802 id 6 142051: 340190 263485 254274 id 3 116563: 347560 204065 331812 id 2 109806: 396295 230973 262926 id 1 82266: 311011 286309 320414 
 
Free space: file1size file2size id
This example shows that we used 8 hard drives to store data with total size of 6,580996 TB.
Part C [15 points]: 
In the last example we show that the first algorithm’s solution is not optimal. One of the causes is that the algorithm first got 2 small files and as a result the bigger files needed a new hard drive because they couldn’t fit with them. An idea to improve the algorithm is to look at the files at a descending order. In this example if we did this , we would see that eventually we would put files of 800 gb and 150 fb in the 1st hard drive , and in the 2nd hard drive the rest of them. This way we would reach a much better solution using only 2 hard drives. 
Algorithm 2 (Greedy-decreasing) 
Sort the files with descending order and then use algorithm 1.

For the implementation of Algorithm 2 , the only thing you need is to run first a sorting algorithm for integers in descending order. 
Write a program named Sort.java, that will run one of the functions Mergesort,Quicksort of Heapsort. You are free to choose between the 3 functions and you are also free to choose if you are going to sort an array or a list. There is no need for a main function in Sort.java. 
 
CAUTION: You can’t use pre-made sorting functions from Java library. For this project you have to create your own function. 
Part D [20 points]. In this part you have to do an experimental evaluation to find out which algorithm is better.Use Random class from java.util package and create random data for at least 3 different values of the number of files. For example ,if N is the number of files , you can use N=100, 500, 1000. For each value of N , create 10 different txt files for the algorithms 1 and 2. In these files , every line should be a random number between 0 and 1000000.

 
Then, write a program that will run and compare the two algorithms. For each txt record how many hard disks the algorithms need. Calculate for every N value, how many disks are needed on average for the two algorithms, according to your random data. 
 
Optional: You can use more values for N , and more than 10 txt for each N value , and create a spreadsheet to present the results. Create a diagram that shows the relationship between number of disks and number of files. Each diagram will present 2 curves, one for each algorithm. 
