import java.util.*;
import java.lang.*;


public class Disk implements Comparable<Disk>{
IntQueueImpl folders;
private int id;
Disk(int key){
    this.id=key;
    this.folders=new IntQueueImpl();
}

    public int getId() {
        return id;
    }


    public int compareTo(Disk b)
{
    if(this.folders.getFreeSpace()==b.folders.getFreeSpace())
        return 0;
    else if(this.folders.getFreeSpace()>b.folders.getFreeSpace())
        return 1;
    else
        return -1;
}
}