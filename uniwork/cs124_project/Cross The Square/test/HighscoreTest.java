

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

public class HighscoreTest {
    
    @Test
    public void testRead() {
	System.out.println("read");
	Highscore instance = new Highscore();
	instance.read();
    }

    /**
     * Test of printHighscores method, of class Highscore.
     */
    @Test
    public void testPrintHighscores() {
	System.out.println("printHighscores");
	Highscore instance = new Highscore();
	instance.read();
	instance.printHighscores();
    }

    /**
     * Test of checkIfHighscore method, of class Highscore.
     */
    @Test
    public void testCheckIfHighscore() {
	System.out.println("checkIfHighscore");
	int s = 0;
	Highscore instance = new Highscore();
	boolean expResult = false;
	boolean result = instance.checkIfHighscore(s);
	assertEquals(expResult, result);
    }

    /**
     * Test of createHighscore method, of class Highscore.
     */
    @Test
    public void testCreateHighscore() {
	System.out.println("createHighscore");
	int s = 1000;
	String name = "Sam";
	Highscore instance = new Highscore();
	instance.read();
	instance.createHighscore(s, name);
	instance.printHighscores();
    }

}