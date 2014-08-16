/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Samuel
 */
public class PlayerTest {

    public PlayerTest() {
    }

    @BeforeClass
    public static void setUpClass() throws Exception {
    }

    @AfterClass
    public static void tearDownClass() throws Exception {
    }

    @Before
    public void setUp() {
    }

    @After
    public void tearDown() {
    }

    /**
     * Test of getStrength method, of class Player.
     */
    @Test
    public void testGetStrength() {
	System.out.println("getStrength");
	Player instance = new Player();
	int expResult = 5; //inital value
	int result = instance.getStrength();
	assertEquals(expResult, result);
    }

    /**
     * Test of setStrength method, of class Player.
     */
    @Test
    public void testSetStrength() {
	System.out.println("setStrength");
	int s = 0;
	Player instance = new Player();
	instance.setStrength(s);
	assertTrue(instance.getStrength() == s);
    }

    /**
     * Test of getScore method, of class Player.
     */
    @Test
    public void testGetScore() {
	System.out.println("getScore");
	Player instance = new Player();
	int expResult = 0;
	int result = instance.getScore();
	assertEquals(expResult, result);
    }

    /**
     * Test of setScore method, of class Player.
     */
    @Test
    public void testSetScore() {
	System.out.println("setScore");
	int s = 0;
	Player instance = new Player();
	instance.setScore(s);
	assertTrue(instance.getScore() == 0);
    }

    /**
     * Test of isDead method, of class Player.
     */
    @Test
    public void testIsDead() {
	System.out.println("isDead");
	Player instance = new Player();
	boolean expResult = false;
	boolean result = instance.isDead();
	assertEquals(expResult, result);
    }

    /**
     * Test of decrementStrength method, of class Player.
     */
    @Test
    public void testDecrementStrength() {
	System.out.println("decrementStrength");
	Player instance = new Player();
	instance.decrementStrength();
	assertTrue(instance.getStrength() == 4);
    }

    /**
     * Test of incrementScore method, of class Player.
     */
    @Test
    public void testIncrementScore() {
	System.out.println("incrementScore");
	Player instance = new Player();
	instance.incrementScore();
	assertTrue(instance.getScore() == 1);
    }

    /**
     * Test of reset method, of class Player.
     */
    @Test
    public void testReset() {
	System.out.println("reset");
	Player instance = new Player();
	instance.reset();
	
	assertTrue(instance.getScore() == 0);
	assertTrue(instance.getStrength() == 5);
	assertTrue(instance.getPosition().equals(new Point(0,0)));
    }

    /**
     * Test of outputStats method, of class Player.
     */
    @Test
    public void testOutputStats() {
	System.out.println("outputStats");
	Player instance = new Player();
	instance.outputStats();
    }

}