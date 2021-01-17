public class Point  {
        public int x;
        public int y;
        public Point(int xx,int yy){
            this.x=xx;
            this.y=yy;
        }
        public int x(){return this.x;} // return the x-coordinate
        public int y(){return this.y;} // return the y-coordinate


        public double distanceTo(Point z){
            double dx=x-z.x(),dy=y-z.y();
            return Math.sqrt(dx*dx+dy*dy);
        } // Euclidean distance
        //between two points


        public int squareDistanceTo(Point z) {return ((int)(distanceTo(z))^(1/2));}// square of the Euclidean
        //distance between two points

        public String toString(){return " ("+x+","+y+")";} // string representation: (x, y)
}
