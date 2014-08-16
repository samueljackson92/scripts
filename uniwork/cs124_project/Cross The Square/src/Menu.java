

/*
 * Author: Samuel Jackson
 * Description:
 * Menu class contains functions realting to displaying the users options at the
 * start of the game as well as showing the user there postgame. It also makes
 * decisions about whether the player achieved a new highscore or not.
 */

public class Menu {
    //Instatiate essential object members
    private Highscore hs = new Highscore();
    private Game game = new Game();
    
    //Method to show the menu to the player.
    public void showMenu() {
	//variable to store user input
	int option = 0;

	//read in the highscores from file
	hs.read();
	
	do {
	    //output menu to console
	    System.out.println("CROSS THE SQUARE\n");

	    System.out.println("Menu-----------------");
	    System.out.println("Play Level: 1");
	    System.out.println("Play Advanced Level: 2");
	    System.out.println("View Highscores: 3");
	    System.out.println("Exit: 4");
	    System.out.println("---------------------");

	    System.out.println("\nSelect an Option:");

	    //read input from command line
	    option = Keyboard.readInt();

	    int score;
	    switch (option) {
		case 1:
		    //play level
		    score = game.playGame(false);
		    postGame(score);
		    break;
		case 2:
		    //play advanced mode straight away
		    score = game.playGame(true);
		    postGame(score);
		    break;
		case 3:
		    //view highscore
		    hs.printHighscores();
		    break;
	    }

	} while (option != 4); //terminate game execution if user chooses
    }

    
    //Method to output the players final score and write a highscore if applicable
    private void postGame(int score) {
	System.out.println("POST GAME ----------------");
	System.out.println("You are dead!");
	System.out.println("You scored: " + score);
	
	if (hs.checkIfHighscore(score)){
	    System.out.println("Congradulations! You got a new highscore!");
	    System.out.println("Enter your name: ");
	    String name = Keyboard.readString();
	    hs.createHighscore(score, name);
	}

	game.reset();
    }
}
