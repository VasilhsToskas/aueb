In this assignment we have added delivery and we have changed the behaviour of the cooks. 

The pizza shop has Ncook cooks and Noven ovens and Ndeliverer delivery employees. The first order happens at point 0 in time , and every other order after that happens after a random integer number in [Torderlow,Torderhigh]. Every order has a random integer number of pizza's in [Norderlow,Norderhigh]. Every order waits untill a cook is available. Then  the cook waits untill an oven is available.Then , all the pizza's are being put in the same oven , and they are being cooked for Tbake time.The cook is available once he puts the pizzas in the oven (he doesnt have to wait for them to bake this time). When the pizza's are cooked, the oven becomes available and we wait for an available delivery. When the delivery is available , he takes on a cooked order and he delivers it to the customer. The time needed for the delivery is a random integer in [Tlow,Thiigh]. After the order gets delivered, the delivery needs the same time to go back to the shop and take on the next order.
Every cook is busy with only one order until he puts it in the oven and every delivery can delivery only one order at a time. 

Input and Data: The following constant values will be defined in a decleration file: 
Ncook = 2 cooks 
Noven = 5 ovens 
Ndeliverer = 10
Torderlow = 1 minute 
Torderhigh = 5 minutes 
Norderlow = 1 pizza 
Norderhigh = 5 pizzas 
Tprep = 1 minute
Tbake = 10 minutes
Tlow = 5 minutes
Thigh = 15 minutes

Program will take as input 2 arguments . The first one is the number of customers to service and the second one  will be the seed for the random number generator.


Output: For each order , at the time it is on the delivery bench , a message of the following form will be printed:
-Order number <order's number> was prepared in <X> minutes and was getting cold for <y> minutes.

The order of the lines will be random , but the lines must not interfere with eachother. Time <X> is the time that passed from the time the order was declared until the time the order was on the delivery bench. Time <y> is the time that passed from the time the order was baked until the time the delivery got it.
At the end of the execution, print the average and the maximun order completion time and average and the maximun order "getting" cold time.


Code structure: The first string of your program will create one string per order(total strings: Ncust), to which you will transfer a string number(from 1 to Ncust) in order to defferentiate them. Then , every string will execute the above mentioned step until the order is completed and then it will print the appropriate output.Lastly, the first string will print the ending output.You will need the following:
-An integer and a mutex to count the number of available cooks and a variable to synchronize orders and cooks , in order to block the orders when there are no available cooks.(you will treat ovens and delivery employees in a counterpart way)
-Variables and mutexes for completion times and getting cold times.
-A mutex to lock the screen when the output is being printed.

