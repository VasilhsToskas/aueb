//package com.company;

import java.io.PrintStream;
import java.util.NoSuchElementException;

public class StringQueueImpl implements StringQueue{

    private Node tail=null;    // last element
    private Node head=null;    //first element
    public boolean isEmpty(){
        return(head==null);
    }

    public void put(String item){
        Node n = new Node(item);

        if (isEmpty()) {
            head = n;
            tail = n;
        } else {
            tail.setNext(n);
            tail = n;
        }
    }

    public String get() throws NoSuchElementException{
        if (isEmpty())
            throw new NoSuchElementException();

        String data = head.getData();

        if (head == tail)
            head = tail = null;
        else
            head = head.getNext();

        return data;
    }

    public String peek() throws NoSuchElementException{
        if (isEmpty()){
            throw new NoSuchElementException();
        }else{
            return (tail.getData());
        }
    }

    public void printQueue(PrintStream stream){
        if (isEmpty()){
            stream.println("There are no elements");
        }else{
            Node current = head;
            while (current!=null){
                stream.println(current);
                current=current.getNext();
            }
        }
    }




    public int size(){
        if (isEmpty()){
            return (0);
        }else{
            Node counter=head;
            int i=1;
            while ((counter.getNext()) != null){
                counter=counter.getNext();
                i++;
            }
        return i ;}
    }


}
