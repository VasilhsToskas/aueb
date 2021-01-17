import java.util.Comparator;

/**
 * Priority Queue implementation based in Heap
 */
public class MaxPQ implements PriorityQueueInterface {
    /**
     * Heap based implementation of PriorityQueue
     * To implement it you need to implement the following helper functions as well
     * swim, sing, swap, grow
     */

    private static Disk[] heap; // the heap to store data in
    private static int size; // current size of the queue

    private final int DEFAULT_CAPACITY = 1; // default capacity
    private final int AUTOGROW_SIZE = 1; // default auto grow

    /**
     * Queue constructor
     *
     */
    MaxPQ() {
        heap = new Disk[DEFAULT_CAPACITY + 1];
        size = 0;
    }

    /**
     * Inserts the specified element into this priority queue.
     *
     */

    public void add(Disk item) {
        // Check available space
        if (size == heap.length - 1)
            grow();

        // Place item at the next available position
        heap[++size] = item;

        // Let the newly added item swim
        swim(size);

    }
    static Disk getDisk(int key){
        for (int i=1;i<=size;i++){
            if (key==heap[i].getId()){
                return heap[i];
            }
        }
        System.out.println("The is no item with this key");
        return null;
    }

    /**
     * Retrieves, but does not remove, the head of this queue, or returns null if this queue is empty.
     *
     * @return the head of the queue
     */
     Disk peek() {
        if (size==0){
            System.out.println("Heap is empty");
            return null;
        }
            return heap[1];


    }

    /**
     * Retrieves and removes the head of this queue, or returns null if this queue is empty.
     *
     * @return the head of the queue
     */
     Disk getMax() {
        if (size==0){
            System.out.println("Heap is empty");
            return null;
        }else {
            Disk temp=heap[1];
            heap[1] = heap[size];
            size--;
            sink(1);

            return temp;
        }

    }

    /**
     * Helper function to swim items to the top
     *
     */
    private void swim(int i) {
        if (i == 1)
            return;

        // find parent
        int parent = i / 2;
        //comparator.compare(heap[i].folders.getFreeSpace(), heap[parent].folders.getFreeSpace()) > 0)
        // compare parent with child i
        while (i != 1 && heap[i].compareTo(heap[parent]) > 0) {
            swap(i, parent);
            i = parent;
            parent = i / 2;
        }

        // recursive function
        // if (heap[i] > heap[parent]) {
        //     swap(i, parent);
        //     swim(parent);
        // }
    }



    //size

    int size(){
        return size;
    }

    /**
     * Helper function to swim items to the bottom
     *
     */
    private void sink(int i) {

        // determine left, right child
        int left = 2 * i;
        int right = left + 1;

        // if 2*i > size, node i is a leaf return
        if (left > size)
            return;

        // while haven't reached the leafs
        while (left <= size) {
            // Determine the largest child of node i
            int max = left;
            if (right <= size) {
                if (heap[left].compareTo(heap[right])< 0)
                    max = right;
            }

            // If the heap condition holds, stop. Else swap and go on.
            // child smaller than parent
            if (heap[i].compareTo(heap[max]) >= 0)
                return;
            else {
                swap(i, max);
                i = max;
                left = i * 2;
                right = left + 1;
            }
        }
    }
    /**
     * Helper function to swap two elements in the heap
     *
     * @param i the first element's index
     * @param j the second element's index
     */
    private void swap(int i, int j) {
        Disk tmp = heap[i];
        heap[i] = heap[j];
        heap[j] = tmp;
    }

    /**
     * Helper function to grow the size of the heap
     */
    private void grow() {
        Disk[] newHeap = new Disk[heap.length + AUTOGROW_SIZE];

        // copy array (notice: in the priority queue, elements are located in the array slots with positions in [1, size])
        for (int i = 0; i <= size; i++) {
            newHeap[i] = heap[i];
        }

        heap = newHeap;
    }
}
