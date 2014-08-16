
/*
 * Author: Samuel Jackson
 * Description:
 * The player class is an extension of the entity class. Its purpose is to add
 * strength and score attributes along with getters and setters.
 */
public class Player extends Entity {
    private int strength = 5; //player starts with 5 health
    private int score = 0;
    
    public int getStrength() {
        return strength;
    }
    
    public void setStrength(int s) {
        strength = s;
    }
    public int getScore() {
        return score;
    }
    public void setScore(int s) {
        score = s;
    }
    public boolean isDead() {
        if(strength == 0)
            return true;
        return false;
    }
    public void decrementStrength () {
        strength--;
    }
    public void incrementScore() {
	score++;
    }
    public void reset() {
	strength = 5;
	score = 0;
	setPosition(0,0);
    }
    public void outputStats() {
	System.out.println("STATS -----------------------\n");
        System.out.println("Strength: " + strength);
        System.out.println("Score: " + score);
    }
}
