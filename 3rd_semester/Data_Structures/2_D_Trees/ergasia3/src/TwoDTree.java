import java.io.*;
import java.util.Comparator;
import java.util.Scanner;

public class TwoDTree {
    // the root of the tree
    private TreeNode root;
    private static int size;
    private Comparator<Point> comparator;

    public static void main (String args[]) throws IOException {
         //edw mpainoun arxika ta stoixeia pou diavazontai apo to txt
        try {
            File file = new File(args[0]);

            BufferedReader br = new BufferedReader(new FileReader(file));
            int counter = 0;
            String st;
            int N=Integer.parseInt(st = br.readLine())*2;
            String[] pinakas =new String [N];
            if (N<=0){
                System.out.println("Wrong number of elements");
                System.exit(0);}
            while ((st = br.readLine()) != null) {
                System.out.println(st);
                String[] arrOfStr = st.split(" ");

                for (String a : arrOfStr) {
                    if(Integer.parseInt(a)>100 ||Integer.parseInt(a)<0){
                        System.out.println("Wrong element value");
                        System.exit(0);
                    }
                    if (counter>N){
                        System.out.println("Wrong number of elements");
                        System.exit(0);
                    }
                    pinakas[counter]= a;
                    counter++;
                }

            }
            if (counter!=N){
                System.out.println("Wrong number of elements");
                System.exit(0);
            }

            TwoDTree tree=new TwoDTree(new TreeNode(new Point(Integer.parseInt(pinakas[0]),Integer.parseInt(pinakas[1]))));
            for (int i=2;i<N;i+=2){
                tree.insert(new Point(Integer.parseInt(pinakas[i]),Integer.parseInt(pinakas[i+1])));
            }
            int choice;
            Scanner scanner = new Scanner(System.in);
            while (true){
                System.out.println("1. Compute the size of the tree");
                System.out.println("2. Insert a new point");
                System.out.println("3. Search if a given point exists in the tree");
                System.out.println("4. Provide a query rectangle");
                System.out.println("5. Provide a query point");
                choice = scanner.nextInt();
                if (choice ==1){
                    System.out.println("The size is : "+tree.size());
                    System.out.println();
                }else if (choice == 2){
                    System.out.println("Give the coordinates");
                    tree.insert(new Point(scanner.nextInt(),scanner.nextInt()));
                    System.out.println();
                }else if (choice == 3){
                    System.out.println("Give the coordinates");
                    if (tree.search(new Point (scanner.nextInt(),scanner.nextInt()))){
                        System.out.println("The element is in the tree");
                    }else{
                        System.out.println("The element is not in the tree");
                    }
                    System.out.println();
                }else if (choice==4){
                    System.out.println(tree.rangeSearch(new Rectangle(scanner.nextInt(),scanner.nextInt(),scanner.nextInt(),scanner.nextInt())));
                    System.out.println();
                }else if (choice==5){
                    Point p=new Point(scanner.nextInt(),scanner.nextInt());
                    Point p2=tree.nearestNeighbor(p);
                    System.out.println("The nearest point is : "+p2);
                    System.out.println("The distance is : "+p.distanceTo(p2));
                    System.out.println();
                } else{
                    System.out.println("Wrong input");
                    System.exit(0);
                }
            }


        }catch (FileNotFoundException | EmptyListException e){
            throw new FileNotFoundException();
        }


    }

    public TwoDTree(TreeNode root) {
        this.root = root;
        size++;
    }
 public boolean isEmpty(){
        return root==null;
 }
    /**
     * @return the root of the tree
     */

    public TreeNode getRoot() {
        return root;
    }
public int size(){
return size;
}
    /**
     * @param node The node to get left subtree
     * @return left child as binary tree
     */

    public TwoDTree getLeftSubTree(TreeNode node) {
        if (root == null)
            return null;

        return new TwoDTree(node.getLeft());
    }

    /**
     * @param node The node to get right subtree
     * @return right child as binary tree
     */

    public TwoDTree getRightSubTree(TreeNode node) {
        if (root == null)
            return null;

        return new TwoDTree(node.getRight());
    }

    /**
     * @return The height of the tree
     */

    public int getTreeHeight() {
        if (root == null)
            return 0;

        return getNodeDepth(root);
    }

    /**
     * Recursive function to get nodes depth
     *
     * @param node The node to get depth
     * @return The depth of the node
     */
    private int getNodeDepth(TreeNode node) {
        if (node == null)
            return 0;

        // get left and right depth
        int leftDepth = getNodeDepth(node.getLeft());
        int rightDepth = getNodeDepth(node.getRight());

        // return max depth + 1 for current node
        return Math.max(leftDepth, rightDepth) + 1;
    }

    /**
     * @param node The node to get level
     * @return The level of the node or null if node is not in tree
     */
    public int getNodeLevel(TreeNode node) {
        if (node == null)
            return 0;

        // tree height - node height = node level
        return getTreeHeight() - getNodeDepth(node);
    }

    /**
     * Prints the tree in pre-order form
     * https://en.wikipedia.org/wiki/Tree_traversal#Pre-order_(NLR)
     */
    public void printPreOrder() {
        recursivePreOrder(root);
        System.out.println();
    }

    private void recursivePreOrder(TreeNode node) {
        if (node == null)
            return;

        System.out.print(node.getData() + " ");
        recursivePreOrder(node.getLeft());
        recursivePreOrder(node.getRight());
    }

    /**
     * Prints the tree in in-order form
     * https://en.wikipedia.org/wiki/Tree_traversal#In-order_(LNR)
     */

    public void printInOrder() {
        recursiveInOrder(root);
        System.out.println();
    }

    private void recursiveInOrder(TreeNode node) {
        if (node == null)
            return;

        recursiveInOrder(node.getLeft());
        System.out.print(node.getData() + " ");
        recursiveInOrder(node.getRight());
    }

    /**
     * Prints the tree in post-order form
     * https://en.wikipedia.org/wiki/Tree_traversal#Post-order_(LRN)
     */

    public void printPostOrder() {
        recursivePostOrder(root);
        System.out.println();
    }

    private void recursivePostOrder(TreeNode node) {
        if (node == null)
            return;

        recursivePostOrder(node.getLeft());
        recursivePostOrder(node.getRight());
        System.out.print(node.getData() + " ");
    }

    /**
     * Prints the tree using Breadth first form
     * https://en.wikipedia.org/wiki/Tree_traversal#Breadth-first_search_/_level_order
     */

    public void printBreadthFirst() {
        ArrayQueue<TreeNode> queue = new ArrayQueue<>();

        if (root == null)
            return;

        queue.enqueue(root);

        try {
            while (!queue.isEmpty()) {
                TreeNode current = queue.dequeue();

                if (current.getLeft() != null)
                    queue.enqueue(current.getLeft());

                if (current.getRight() != null)
                    queue.enqueue(current.getRight());

                System.out.print(current.getData() + " ");
            }
        } catch (EmptyQueueException ex) {
        }
    }
    public boolean search (Point item){

        TreeNode current=root;
        if (current.getData().x()==item.x()&&current.getData().y()==item.y()){return  true;}
        boolean notfound =false;
        int counter=0;
        while (!notfound )
        {
            if (counter%2==0) {
                if (current.getData().x() > item.x()) {
                    if (current.getLeft()==null){
                        notfound=true;

                    }else{
                    current = current.getLeft();}
                } else {
                    if (current.getRight()==null){
                        notfound=true;

                    }else{
                    current = current.getRight();}
                }
            }
            else{
                if (current.getData().y() > item.y()) {
                    if (current.getLeft()==null){
                        notfound=true;

                    }else{
                        current = current.getLeft();}
                } else {
                    if (current.getRight()==null){
                        notfound=true;

                    }else{
                        current = current.getRight();}
                }
            }
            if (current.getData().x()==item.x()&&current.getData().y()==item.y()){return  true;}
            counter++;

        }
        return false;
    }

    public void insert(Point item) {
        if (root == null)
            root = new TreeNode(item);

        if (search(item)){
            System.out.println("Element is already in the tree");
            return ;
        }
        size++;
        TreeNode current=root;
        boolean foundposition=false;
        int counter=0;
        while (!foundposition ) {
            if (counter % 2 == 0) {
                if (current.getData().x() > item.x()) {
                    if (current.getLeft() == null) {
                        foundposition = true;
                        TreeNode temp = new TreeNode(item);
                        current.setLeft(temp);

                    } else {
                        current = current.getLeft();
                    }
                } else {
                    if (current.getRight() == null) {
                        foundposition = true;
                        TreeNode temp = new TreeNode(item);
                        current.setRight(temp);

                    } else {
                        current = current.getRight();
                    }
                }
            } else {
                if (current.getData().y() > item.y()) {
                    if (current.getLeft() == null) {
                        foundposition = true;
                        TreeNode temp = new TreeNode(item);
                        current.setLeft(temp);

                    } else {
                        current = current.getLeft();
                    }
                } else {
                    if (current.getRight() == null) {
                        foundposition = true;
                        TreeNode temp = new TreeNode(item);
                        current.setRight(temp);

                    } else {
                        current = current.getRight();
                    }
                }
            }

            counter++;

        }

    }
    public Point nearestNeighbor(Point p) throws EmptyListException {
        if (root==null){
            return null;
        }
        TreeNode current = root;
        int counter = 0;
        double distance = p.distanceTo(root.getData());
        Point closest = new Point(root.getData().x(), root.getData().y());
        Rectangle rec = new Rectangle(0, 100, 0, 100);
        while (rec.contains(p)) {
            if ((p.distanceTo(current.getData())) < distance) {
                distance = p.distanceTo(current.getData());
                closest = new Point(current.getData().x(), current.getData().y());
            }
            if (counter % 2 == 0) {
                current = current.getLeft();
                rec.xmax=current.getData().x();
            } else {
                current = current.getRight();
                rec.ymax=current.getData().y();
            }

            counter++;

        }

        return closest;
    }

    // point in the tree that is
    //closest to p (null if tree is empty)
    public List rangeSearch(Rectangle rect){
        if (root == null)
            return null;
        List inrange=new List();


        Rectangle rec = new Rectangle(0, 100, 0, 100);


        return implrangesearch(inrange,root,rec,rect);
    }

    public List implrangesearch(List inrange ,TreeNode current,Rectangle rec,Rectangle rect){
       if ((rect.intersects(rec))&&current!=null){
           Rectangle rightrec=rec;
           Rectangle leftrec=rec;
           leftrec.xmax=current.getData().x();
           rightrec.ymax=current.getData().y();
           if (rect.contains(current.getData())) {
               inrange.insertAtFront(current.getData());
           }
           implrangesearch(inrange,current.getLeft(),leftrec,rect);
           implrangesearch(inrange,current.getRight(),rightrec,rect);
       }
        return inrange;
    }
    // Returns a list
    //with the Points that are contained in the rectangle

}
