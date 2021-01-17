//package com.company;

import java.io.PrintStream;
import java.util.NoSuchElementException;


public class StringQueueWithOnePointer {
    /**
     * Defines the methods for a FIFO queue that handles String items
     */
    private Node tail=null;



    /**
     * @return true if the queue is empty
     */
    private boolean isEmpty(){return (tail==null);}

    /**
     * insert new Node n after tail
     */
    public void put(String item){
        Node n = new Node(item);
        if (tail == null) {
            n.setNext(n);
            tail=n;
        }
        else {
            n.setNext(tail.getNext());
            tail.setNext(n);
            tail=n;
        } }

    /**
     * remove the next node of the given node
     */
    void remove()throws NoSuchElementException {
        if (tail==null){
            throw new NoSuchElementException();
        }
        else if (tail.getNext()==tail){
            tail=null;
        }else{
            tail.setNext(tail.getNext().getNext()) ;
        }
    }


    /**
     * return without removing the oldest item of the queue
     * @return oldest item of the queue
     * @throws NoSuchElementException if the queue is empty
     */
    public String peek() throws NoSuchElementException{
        return tail.getData();
    }
    /**
     * print the elements of the queue, starting from the oldest
     * item, to the print stream given as argument. For example, to
     * print the elements to the
     * standard output, pass System.out as parameter. E.g.,
     * printQueue(System.out);
     */
    public void printQueue(PrintStream stream){
        if (isEmpty()){
            stream.println("There are no elements");
        }
        else{
            Node counter= tail.getNext();
            while (counter!=tail){
                stream.println(counter);
                counter=counter.getNext();
            }
            stream.println(tail);
        }
    }

    /**
     * return the size of the queue, 0 if it is empty
     * @return number of elements in the queue
     */
    public int size(){
        int count=0;
        if (tail==null){return count;}
        else {
            count=1;
            Node counter=tail.getNext();
            while (counter!=tail){
                count++;
                counter=counter.getNext();
            }
        }
        return count;
    }


}


