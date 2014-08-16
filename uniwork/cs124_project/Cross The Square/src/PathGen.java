
import java.util.ArrayList;
import java.util.Random;

/*
 * Path.java
 * Author: Samuel Jackson
 * Description:
 * The path class provides a way to generate a random path across a grid of cells
 * towards the oragin at (0,0).
 */

public class PathGen {
    //Attribute to store the collection of points.
    private ArrayList<Point> coordinates = new ArrayList<Point>();

    //Method to return the generated coordinates
    public ArrayList<Point> getPath() {
	return coordinates;
    }
    
    //Wrapper function to generate a simple path
    public void generatePath() {
	generatePath(11,11);
    }

    //Method to generate a random path across the grid.
    private void generatePath(int startx, int starty) {
	//create a point to store the current point that we are working with
        Point current = new Point(startx,starty);
	
	//keep generating points while we haven't crossed the square.
	 while (!(current.getX() == 0 && current.getY() == 0)) {
	     //Generate a random direction (x or y)
	    Random rnd = new Random();
	    int direction = rnd.nextInt(2);
	    
	    //check if the direction is valid. If not swap it.
	    if (!checkValidDirection(direction, current)) {
		direction = swapDirection(direction);
	    }

	    switch (direction) {
		//0 for moving in the x
		case 0:
		    //move on the x and add the point to the collection
		    current.setPoints(current.getX()-1, current.getY());
		    coordinates.add(current.clone());
		    break;
		//1 for moving in the y
		case 1:
		    //move on the y and add the point to the collection
		    current.setPoints(current.getX(), current.getY()-1);
		    coordinates.add(current.clone());
		    break;
	    }
            
        }
    }
    
    //Method to generate a path that cross the square via the players given
    //position at time of generation.
    public void generateSmartPath(int x, int y) {
	//set the current point to the hunter oragin
	Point current = new Point(11,11);
	
	int direction;
	
	//calculate the shortest direction to the player
	int diffx = current.getX() - x;
	int diffy = current.getY() - y;
	int shorter = Math.min(diffx, diffy);
	
	if (shorter  == diffx) {
	    direction = 0;
	} else {
	    direction = 1;
	}
	
	//loop until the we have a path to the point the player was at.
	do {
            switch (direction) {
                //0 for moving in the x
                case 0:
		    //generate all points on the x axis require to meet the players
		    //column
		    while (current.getX() != x) {
			current.setPoints(current.getX()-1, current.getY());
			coordinates.add(current.clone());
		    }
		    direction = swapDirection(direction);
                    break;
                //1 for moving in the y
                case 1:
		    //generate all points on the y axis require to meet the players
		    //row
		    while (current.getY() != y) {
			current.setPoints(current.getX(), current.getY()-1);
			coordinates.add(current.clone());
		    } 
		    direction = swapDirection(direction);
                    break;
            }
	} while (!(current.getX() == x && current.getY() == y));
	
	//generate the path from the players point to the oragin. 
	generatePath(x,y);
    }

    //Method to flip the direction of path generation between x and y
    private int swapDirection(int direction) {
	if(direction == 0) {
	    return 1; 
	}else { 
	    return 0;
	}
    }
    
    //Method to check that the current direction is still on the grid.
    private boolean checkValidDirection (int direction, Point p) {
        switch (direction) {
            case 0:
                if (p.getX()-1 >= 0) return true;
                break;
            case 1:
                if (p.getY()-1 >= 0) return true;
                break;
        }
        return false;
    }
}
