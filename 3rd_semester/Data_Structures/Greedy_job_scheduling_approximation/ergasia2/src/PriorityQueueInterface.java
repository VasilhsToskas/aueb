public interface PriorityQueueInterface {
    /**
     * Inserts the specified element into this priority queue.
     *
     * @param item
     */
    void add(Disk item);


    /**
     * Retrieves, but does not remove, the head of this queue, or returns null if this queue is empty.
     *
     * @return the head of the queue
     */
    static Disk peek() {
        return null;
    }


    /**
     * Retrieves and removes the head of this queue, or returns null if this queue is empty.
     *
     * @return the head of the queue
     */
    static Disk getMax() {
        return null;
    }
}
