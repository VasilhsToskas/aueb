# Implementation of hash table using assembly 


Description


Athens University of Economics and Business

Department of Informatics

Class: Computer Systems Organization

Implementation of Hash Table using MIPS32

Let’s assume we want to store 100 numerical values in an array. One way to do this is by storing the values-keys randomly or linearly. In this case every procedure (import,search..) has O(n) time complexity (where n the number of numerical values). A more efficient way to store the keys is using a function that transforms every key in an array position. For example: Array position = original key % array size This way, key 253 will be stored in position 253%100=53. Following the same way we can find the position of any key. A function like this one that transforms a large price range is called hashing function and the array that is used to store data using a hashing function is called hash table. The goal of hash tables is to achieve an O(1) access time . If the given key in not of numeric type , we use the ASCII values of its characters -which we then add- to transform it to numeric. Hash collision (open addressing with linear probing)

The problem is that according to the last transformation two different keys can go to the same array position. For example, keys 253 and 453 will be stored in position 53 .This is called a collision. The two keys that claim the same position are called synonyms. A solution for this problem is to search the array, find an open position and store our new key there. This technique is called open addressing. The simplest function to implement open addressing is linear probing. The function searches the array linear from the collision position until it finds an empty position to store our key.

Using MIPS32 assembly language , write a program that implements an array with 10 spaces and functions for importing and searching numeric keys in the array.

Comments • Your solution should implement exactly this Java program. Instructions • Run your program on SPIM .