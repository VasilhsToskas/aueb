public class TreeNode {
    // The data it holds
    private Point data;

    // Left subtree (child)
    private TreeNode left;

    // Right subtree (child)
    private TreeNode right;


    /**
     * Default TreeNode constructor
     */


    /**
     * TreeNode constructor accepting data
     * @param
     */
    public TreeNode( Point item){
        this.data = item;
    }



    /**
     * @return The data it holds
     */
    public Point getData() {
        return data;
    }

    /**
     * @param data the data to store
     */
    public void setData(Point data) {
        this.data = data;
    }

    /**
     * @return left subtree
     */
    public TreeNode getLeft() {
        return left;
    }

    /**
     * @param left Set left subtree
     */
    public void setLeft(TreeNode left) {
        this.left = left;
    }

    /**
     * @return right subtree
     */
    public TreeNode getRight() {
        return right;
    }

    /**
     * @param right Set right subtree
     */
    public void setRight(TreeNode right) {
        this.right = right;
    }
}
