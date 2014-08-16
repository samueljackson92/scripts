
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

/*
 * Author: Samuel Jackson
 * Description:
 * Class to handle reading, writing and storing highscores from a text file.
 * Also provides a method for formatting and outputting the read data.
 */

public class Highscore {
    //constant for the filename
    private final String file = "highscore.txt";
    
    //collections for storing the data that is read.
    private ArrayList<String> scores = new ArrayList<String>();
    private ArrayList<String> names = new ArrayList<String>();
    
    //Method for writing the collections back into the file
    private void write() {
	try {
	    BufferedWriter out = new BufferedWriter(new FileWriter(file));
	    for (int i = 0; i < scores.size(); i++) {
		out.write(scores.get(i));
		out.newLine();
		out.write(names.get(i));
		out.newLine();
	    }
	    out.close();
	}catch (IOException e) {
	    System.err.println("IOException: " + e.getMessage());
	} 
    }
    
    //Method for loading the stored data into the collections.
    public void read() {
	String score, name;
	try {
	    BufferedReader in = new BufferedReader(new FileReader(file));
	    while ((score = in.readLine()) != null && (name = in.readLine()) != null){
		scores.add(score);
		names.add(name);
	    }
	    in.close();
	} catch (FileNotFoundException e) {
	    System.err.println("File Not Found: " + e.getMessage());
	} catch (IOException e) {
	    System.err.println("IO Stream: " + e.getMessage());
	}
    }
    
    //Method for formatting and outputting the data to the console
    public void printHighscores() {
	
	System.out.println();
	System.out.println("High Scores: ----------------------------");
	System.out.println();
	
	for (int i = 0; i < scores.size(); i++) {
	    System.out.println(scores.get(i) + " " + names.get(i));
	}

	System.out.println();
    }
    
    //Method to check if the provided score is a highscore
    public boolean checkIfHighscore(int s) {
	for (String hs : scores) {
	    if(s > Integer.parseInt(hs))
		return true;
	}
        return false;
    }
    
    //Method to create a new highscore and write the data back to the file.
    public void createHighscore(int s, String name) {
	for (int i = 0; i < scores.size(); i++) {
	    if(s > Integer.parseInt(scores.get(i))) {
		scores.set(i, Integer.toString(s));
		names.set(i, name);
		break;
	    }
	}
	write ();
    }
}
