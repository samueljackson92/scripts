
import java.util.ArrayList;

/*
 *  Author: Samuel
 *  Description:
 *  The game class is designed to contain the main application logic. It is used
 *  to control the game at the highest level.
 */
public class Game {
    private Square map = new Square();
    private Player player = new Player();
    private ArrayList<Hunter> hunters = new ArrayList<Hunter>();

    //attribute to control what level the user is current playing at
    private boolean advanced = false;

    //members used to decide how many hunters to spawn
    private int currentHunterMax = 1;
    private int lastScoreIncrease = 0;

    //Game constants
    private final int MAX_HUNTERS = 5;
    private final int LEVEL_2_SCORE = 42;
    private final int DIFF_STEP = 7;
    //Method to start and run a game of cross the square
    public int playGame(boolean adv) {
	//array of chars which are valid user input
        final char[] validChars = {'g', 'h', 'j', 'k'};
        char key;
	advanced = adv;

	player.reset();
	map.addPlayer(player);
	
	//continue to execute the game until the player dies.
        while (!player.isDead()) {

	    //read in the users next move and check it's valid
	    display();
	    System.out.println("Input Move:");
	    key = Keyboard.readChar();
	    if(validChar(key, validChars)){
		//remove any hunters which are at the finish point
		removeHunters();
		
		//move entities around the map
		hunters = map.moveHunters(hunters);
		map.movePlayer(player, key);

		addHunter(); //add hunters to the map if possible

		//check if a hunter has collided with a player
		checkPlayerCollide();

		//change level if applicable
		if (player.getScore() >= LEVEL_2_SCORE && !advanced) {
		    changeLevel();
		}
	    }
	    increaseDifficulty();
        }
	return player.getScore();
    }

        //Method to check if the player has collided with any of the hunters
    //and respond appropriatly.
    private void checkPlayerCollide() {
        for (int i = 0; i < hunters.size(); i++) {
            if(player.checkCollide(hunters.get(i))) {
		player.decrementStrength();
		hunters.remove(i);
            }
        }
    }

    //remove hunters from the map when they have reached the other side.
    private void removeHunters() {
        for (int i = 0; i < hunters.size(); i++) {
	    Point p = hunters.get(i).getPosition();

	    if (p.getX() == 0 && p.getY() == 0) {
		hunters.remove(i);
		map.removeHunter();
		player.incrementScore();
	    }
        }
    }

    //Method to up the difficulty
    private void increaseDifficulty() {
	if (player.getScore() > 0 && player.getScore() != LEVEL_2_SCORE && player.getScore() % DIFF_STEP == 0 && lastScoreIncrease < player.getScore() && currentHunterMax < MAX_HUNTERS) {
	    lastScoreIncrease = player.getScore();
	    currentHunterMax++;
	}
    }

    //Method used to introduce hunters into the game
    private void addHunter() {
	//check if we can add a hunter
	if (hunters.size() < currentHunterMax) {
	    if(map.checkCellEmpty(11,11)) {
		Hunter h;

		//decide which path algorithm to use
		if(!advanced) {
		    h = new Hunter();
		} else {
		    Point p = player.getPosition();
		    h = new Hunter(p.getX(), p.getY());
		}

		hunters.add(h);
		map.addHunter(h);
	    } else if(map.checkForPlayer(11, 11)) {
		player.decrementStrength();
	    }
	}
    }

    private void clearBoard() {
	hunters.clear();
	map.reset();
    }

    //change the level between simple and advanced path generation
    //reset and ready the player
    private void changeLevel() {
	clearBoard();
	advanced = true;
	currentHunterMax = 1;
	lastScoreIncrease = 0;
	player.setStrength(5);
	map.addPlayer(player);
    }

    //clear everything ready for a new game
    public void reset() {
	    clearBoard();
	    advanced = false;
	    currentHunterMax = 0;
	    lastScoreIncrease = 0;
	    player.reset();
    }

    //show the map and player stats
    private void display() {
	map.draw();
	player.outputStats();
    }

    //Method to check if given character matches any of an array of characters.
    private boolean validChar(char c, char chars[]) {
        for (char nc : chars) {
            if (nc == c) {
                return true;
            }
        }
        return false;
    }
}
