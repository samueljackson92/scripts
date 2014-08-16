/*
 * Author: Samuel Jackson
 * Description:
 * Entity class provides the base for both Player and Hunter objects.
 * This class provides simple getter/setter functions for the position of the
 * entity.
 */
public abstract class Entity {
    //attribute storing the position of the object
    private Point p = new Point(0,0);
    
    //Get and set methods for the position.
    public Point getPosition() {
        return p;
    }
    public void setPosition(int x, int y) {
        p.setPoints(x, y);
    }

    public boolean checkCollide(Entity e) {
	Point ep = e.getPosition();
	if(p.equals(ep)) {
            return true;
        }
        return false;
    }
}