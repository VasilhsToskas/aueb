public class Rectangle {
    public int xmin;
    public int xmax;
    public int ymin;
    public int ymax;
    public Rectangle (int x_min,int x_max,int y_min,int y_max){
        xmin=x_min;
        xmax=x_max;
        ymin=y_min;
        ymax=y_max;
    }
    public int xmin() {
        return xmin;
    } // minimum x-coordinate of rectangle

    public int ymin() {
        return ymin;
    }// minimum y-coordinate of rectangle

    public int xmax() {
        return xmax;
    } // maximum x-coordinate of rectangle

    public int ymax() {
        return ymax;
    }// maximum y-coordinate of rectangle

    public boolean contains(Point p) {
        return (p.x()<=xmax && p.x()>=xmin &&p.y()<=ymax &&p.y()>=ymin);
    } //does p belong to the rectangle?

    public boolean intersects(Rectangle that) {
        return !(this.ymax<that.ymin()||this.ymin>that.ymax()||this.xmin>that.xmax()||this.xmax<that.xmin());
    } // do the two rectangles
    // intersect?
    public double distanceTo(Point p) {
        if (this.contains(p)){return 0;}
        double distance = 0;
        if (p.x()<xmin()&&p.y()<ymin())
        {distance= p.distanceTo(new Point(xmin(),ymin()));
        }
        else if (p.x()<xmin&&p.y()>ymax()){
        distance= p.distanceTo(new Point(xmin(),ymax()));
        }
        else if(p.x()>xmax()&&p.y()<ymin())
        {distance= p.distanceTo(new Point(xmax(),ymin()));
        }
        else if (p.x()>xmax()&&p.y()>ymax()) {
            distance = p.distanceTo(new Point(xmax(), ymax()));
        }else if (p.y()>ymax()){
        distance=p.y()-ymax();
        }
        else if (p.x()<xmin()){
        double down=ymin()-p.y();
        }
        else if (p.x()<xmin()){ 
            distance = xmin() - p.x();
        }
        else {
            distance = p.x() - xmax();
        }

        return distance;
    } // Euclidean distance from p

    //to closest point in rectangle
    public int squareDistanceTo(Point p) {
        return ((int)distanceTo(p)^(1/2));
    } // square of Euclidean
    // distance from p to closest point in rectangle
    public String toString() {
        return "[" + xmin + ", " + xmax + "] x [" + ymin + ", " + ymax + "]";
    } // string representation:
// [xmin, xmax] x [ymin, ymax]
}
