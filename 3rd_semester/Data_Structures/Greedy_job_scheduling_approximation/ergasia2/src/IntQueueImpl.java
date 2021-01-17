import java.io.PrintStream;
import java.util.NoSuchElementException;

public class IntQueueImpl implements IntQueue{

    private Node tail=null;    // last element
    private Node head=null;    //first element
    private final int capacity= 1000000;
    public boolean isEmpty(){
        return(head==null);
    }

    public void put(int item){
        Node n = new Node(item);

        if (isEmpty()) {
            head = n;
            tail = n;
        } else {
            tail.setNext(n);
            tail = n;
        }
    }

    public int get() throws NoSuchElementException{
        if (isEmpty())
            throw new NoSuchElementException();

        int data = head.getData();

        if (head == tail)
            head = tail = null;
        else
            head = head.getNext();

        return data;
    }

    public int peek() throws NoSuchElementException{
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
                stream.print(current);
                stream.print("   ");
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

    public int getFreeSpace(){
        if (isEmpty()){
            return (capacity);
        }else{
            Node counter=head;
            int i=  counter.getData();
            while (counter.getNext()!=null){
                counter=counter.getNext();
                i+=counter.getData();
            }
            return (capacity-i);
        }
    }
}
