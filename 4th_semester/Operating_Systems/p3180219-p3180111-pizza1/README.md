The pizza shop has Ncook cooks and Noven ovens. In this assignment customers can only pick up their order from the pizza shop . The first order happens at point 0 in time , and every other order after that happens after a random integer number in [Torderlow,Torderhigh]. Every order has a random integer number of pizza's in [Norderlow,Norderhigh]. Every order waits untill a cook is available. Then  the cook waits untill an oven is available.Then , all the pizza's are being put in the same oven , and they are being cooked for Tbake time, while the cook watches over the oven. When the pizza's are cooked, the cookereaves the order at the delivery bench and then the cooker is available again.
Every cook can take care of one order at a time .

Input and Data: The following constant values will be defined in a decleration file: 
Ncook=6 cooks 
Noven=5 ovens 
Torderlow=1 minute 
Torderhigh=5 minutes 
Norderlow=1 pizza 
Norderhigh=5 pizzas 
Tprep=1 minute
Tbake=10 minutes

Program will take as input 2 arguments . The first one is the number of customers to service and the second one  will be the seed for the random number generator.


Output: For each order , at the time it is on the delivery bench , a message of the following form will be printed:
-Order number <order's number> was prepared in <X> minutes.

The order of the lines will be random , but the lines must not interfere with eachother. Time <X> is the time that passed from the time the order was declared until the time the order was on the delivery bench. 
At the end of the execution, print the average and the maximun order completion time.


Code structure: The first string of you program will create one string per order(total strings: Ncust), to witch you will transfer a string number(from 1 to Ncust) in order to defferentiate them. Then , every string will execute the above mentioned step until the order is completed and then it will print the appropriate output.Lastly, the first string will print the ending output.You will need the following:
-An integer and a mutex to count the number of available cooks and a variable to synchronize orders and cooks , in order to block the orders when there are no available cooks.
-An integer and a mutex to count the available ovens and a variable to synchronize orders and ovens , in order to block the orders when there are no available ovens.
-Variables and mutexes for completion times.
-A mutex to lock the screen when the output is being printed.

