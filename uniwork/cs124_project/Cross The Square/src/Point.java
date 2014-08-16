/*
 * Author: Samuel Jackson
 * Description:
 * The Point class is used as a convinient way to store and pass two integers as 
 * a coordinate pair.
 */
public class Point {
    private int x, y; //variables for the x and y position
    
    //constructor initilises the coordinates
    public Point (int x, int y) {
        this.x = x;
        this.y = y;
    }
    
    public void setPoints(int x, int y) {
        this.x = x;
        this.y = y;
    }
    public int getX() {
        return x;
    }
    public int getY() {
        return y;
    }
    
    //Overridden clone method allows this point to the copied easily
    @Override
    public Point clone() {
        return new Point(this.getX(), this.getY());
    }

    public boolean equals(Point p) {
	if(p.getX() == x && p.getY() == y) {
	    return true;
	}
	return false;
    }
}
