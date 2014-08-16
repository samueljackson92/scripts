/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.ArrayList;
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
public class SquareTest {

    public SquareTest() {
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
     * Test of addHunter method, of class Square.
     */
    @Test
    public void testAddHunter() {
	System.out.println("addHunter");
	Hunter h = new Hunter();
	Square instance = new Square();
	instance.addHunter(h);
    }

    /**
     * Test of addPlayer method, of class Square.
     */
    @Test
    public void testAddPlayer() {
	System.out.println("addPlayer");
	Player p = new Player();
	Square instance = new Square();
	instance.addPlayer(p);
    }

    /**
     * Test of movePlayer method, of class Square.
     */
    @Test
    public void testMovePlayer() {
	System.out.println("movePlayer");
	Player player = new Player();
	char key = 'h';
	Square instance = new Square();
	instance.movePlayer(player, key);
	Point p = player.getPosition();
	assertTrue(p.equals(new Point(1,0)));
    }

    /**
     * Test of checkValidMove method, of class Square.
     */
    @Test
    public void testCheckValidMove() {
	System.out.println("checkValidMove");
	int x = 0;
	int y = 0;
	Square instance = new Square();
	boolean expResult = true;
	boolean result = instance.checkValidMove(x, y);
	assertEquals(expResult, result);
    }

    /**
     * Test of moveHunters method, of class Square.
     */
    @Test
    public void testMoveHunters() {
	System.out.println("moveHunters");
	ArrayList<Hunter> hunters = new ArrayList<Hunter>();
	Square instance = new Square();
	instance.moveHunters(hunters);
    }

    /**
     * Test of removeHunter method, of class Square.
     */
    @Test
    public void testRemoveHunter() {
	System.out.println("removeHunter");
	Square instance = new Square();
	instance.removeHunter();
    }

    /**
     * Test of checkCellEmpty method, of class Square.
     */
    @Test
    public void testCheckCellEmpty() {
	System.out.println("checkCellEmpty");
	int x = 0;
	int y = 0;
	Square instance = new Square();
	boolean expResult = true;
	boolean result = instance.checkCellEmpty(x, y);
	assertEquals(expResult, result);
    }

    /**
     * Test of draw method, of class Square.
     */
    @Test
    public void testDraw() {
	System.out.println("draw");
	Square instance = new Square();
	instance.draw();
    }

    /**
     * Test of reset method, of class Square.
     */
    @Test
    public void testReset() {
	System.out.println("reset");
	Square instance = new Square();
	instance.reset();
    }

}