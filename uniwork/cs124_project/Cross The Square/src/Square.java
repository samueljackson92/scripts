
import java.util.ArrayList;

/*
 * Author: Samuel Jackson
 * Description:
 * The Square class is designed to track the positions of all the entities on
 * current residing within the game. It is also responsible for moving entities.
 */

public class Square {
    //12x12 grid to store the entities.
    private Entity cells [][] = new Entity[12][12];
    
    //Method to add a hunter to the grid.
    public void addHunter (Hunter h) {
	moveEntity(h,11,11);
    }

    public void addPlayer(Player p) {
	moveEntity(p,0,0);
    }
    
    //Method to move the player round the grid in response to the users input
    public void movePlayer(Player player, char key) {
        Point p = player.getPosition();
	
	int x = p.getX();
	int y = p.getY();
	
        if (key == 'g' && checkValidMove(x-1,y)) {
            moveEntity(player,x-1,y);
        } else if (key == 'h' && checkValidMove(x+1,y)) {
            moveEntity(player,x+1,y);
        } else if (key == 'j' && checkValidMove(x,y-1)) {
            moveEntity(player,x,y-1);
        } else if (key == 'k' && checkValidMove(x,y+1)) {
            moveEntity(player,x,y+1);
        }
    }
    
    //check that move lies within the squares boundries
    public boolean checkValidMove(int x, int y) {
	if (x >= 0 && y >= 0 && x < 12 && y < 12) {
	    return true;
	}
	return false;
    }
    
    //Method to move the all hunters in the game further along there path.
    public ArrayList<Hunter> moveHunters(ArrayList<Hunter> hunters) {
        for (int i=0;i<hunters.size();i++) {
	    Hunter h = hunters.get(i);
	    if(h.hasNextMove()) {
		Point p = h.peepNextMove();

		if(checkCellEmpty(p.getX(), p.getY())) {
		    moveEntity(h, p.getX(), p.getY());
		    h.popNextMove();
		} else if (checkForPlayer(p.getX(), p.getY())) {
		    Player player = (Player) cells[p.getY()][p.getX()];
		    player.decrementStrength();
		    Point hp = h.getPosition();
		    cells[hp.getY()][hp.getX()] = null;
		    hunters.remove(i);
		}
	    }
        }

	return hunters;
    }
    
    //Method to move an entity around the grid
    private void moveEntity(Entity e, int x, int y) {
	Point p = e.getPosition();
	if (!(p.getX() == x && p.getY() == y)) {
	    cells[p.getY()][p.getX()] = null;
	}
	e.setPosition(x, y);
        cells[y][x] = e;
    }
    
    //Method to remove a hunter from the grid if it reaches the oragin
    public void removeHunter() {
	removeHunter(0,0);
    }

    private void removeHunter(int x, int y) {
	if(cells[y][x] instanceof Hunter) {
	    cells[y][x] = null;
	}
    }
    
    //Method to check whether a cell currently has an entity on it.
    public boolean checkCellEmpty(int x, int y) {
	if (cells[y][x] == null)
	    return true;
	return false;
    }

    //Method to check whether a player object is currently occupying a cell
    public boolean checkForPlayer(int x, int y) {
	if(cells[y][x] instanceof Player) {
	    return true;
	}
	return false;
    }
    
    //Method to output the map to the console.
    public void draw() {
        clearMap();
        System.out.println("MAP -------------------\n");
        
        for (int i = 0; i < cells.length; i++) {
            for (int j = 0; j < cells[i].length; j++) {
                if (cells[i][j] == null) {
                    System.out.print(".");
                } else if (cells[i][j] instanceof Hunter) {
                    System.out.print("H");
                } else if (cells[i][j] instanceof Player){
                    System.out.print("P");
                }
            }
            System.out.println();
        }
    }
    
    //Method to clear the console ready for fresh output
    private void clearMap() {
        for (int i = 0; i < 5; i++) System.out.println();
    }
    
    //Method to clear and reset the grid
    public void reset() {
	for (int i=0; i< cells.length; i++) {
	    for (int j=0; j<cells[i].length; j++) {
		cells[j][i] = null;
	    }
	}
    }
}
