
import java.util.ArrayList;

/*
 * Author: Samuel Jackson
 * Description:
 * Hunter class provides and extension of the entity class to add pathfinding
 * functionality. The Hunter class provides access to its path in the form of a 
 * simplifed queue structure.
 */

public class Hunter extends Entity {
    //Attribute to store the hunters path object
    private PathGen path = new PathGen();
    private ArrayList<Point> coordinates;
    
    //constructor for a simple hunter
    public Hunter () {
	setPosition(11, 11);
	path.generatePath();
	coordinates = path.getPath();
    }
    
    //constructor for more advanced movement
    public Hunter (int x, int y) {
	setPosition(11,11);
	path.generateSmartPath(x, y);
	coordinates = path.getPath();
    }
    
    //Method to get the next point object for the path
    public Point peepNextMove() {
        return coordinates.get(0);
    }
    
    //Method to delete the point object from the queue
    public Point popNextMove() {
	return coordinates.remove(0);
    }
    
    //Method to check if the queue is empty
    public boolean hasNextMove() {
	return !coordinates.isEmpty();
    }
}
