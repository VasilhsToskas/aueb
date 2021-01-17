//package com.company;

import java.io.PrintStream;
import java.util.NoSuchElementException;


public class StringStackImpl implements StringStack{

    private Node top=null;    // last element
    private Node bottom=null;    //first element


    public boolean isEmpty(){
        return(bottom==null);
    }

    public void push(String item){
        Node n = new Node(item);
        if (isEmpty()) {
            top = n;
            bottom = n;
            bottom.setNext(null);
        } else {
            n.setNext(top);
            top=n;
        }
    }


    public String pop() throws NoSuchElementException {
        if (isEmpty()){
            throw new NoSuchElementException("No such element");
        }

        String data = top.getData();
        if (top == bottom){
            top = bottom = null;
        }
        else {
           top=top.getNext();
        }
        return data;
    }

    public String peek() throws NoSuchElementException{
            if (isEmpty()) {
                throw new NoSuchElementException("No such element");
            }
            return top.getData();
        }



    public void printStack(PrintStream stream){
        if (isEmpty()) {
            stream.println( "Stack is empty :(");
        }else if (top==bottom){
            stream.println(top);
        }
        else{

            Node counter=top;
            while (counter!=bottom){
                stream.println(counter);
                counter=counter.getNext();
            }
            stream.println(bottom);
        }

    }


    public int size(){
        if (isEmpty()){
            return (0);
        }else{
            Node counter=top;
            int i=1;
            while (counter != bottom){
                counter=counter.getNext();
                i++;
            }
            return i ;}
    }

}
