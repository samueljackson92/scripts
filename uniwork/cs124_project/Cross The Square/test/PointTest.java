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
public class PointTest {

    public PointTest() {
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
     * Test of setPoints method, of class Point.
     */
    @Test
    public void testSetPoints() {
	System.out.println("setPoints");
	int x = 0;
	int y = 0;
	Point instance = new Point(1,1);
	instance.setPoints(x, y);
	instance.equals(new Point(0,0));
    }

    /**
     * Test of getX method, of class Point.
     */
    @Test
    public void testGetX() {
	System.out.println("getX");
	Point instance = new Point(0,0);
	int expResult = 0;
	int result = instance.getX();
	assertEquals(expResult, result);
    }

    /**
     * Test of getY method, of class Point.
     */
    @Test
    public void testGetY() {
	System.out.println("getY");
	Point instance = new Point(0,0);
	int expResult = 0;
	int result = instance.getY();
	assertEquals(expResult, result);
    }

    /**
     * Test of clone method, of class Point.
     */
    @Test
    public void testClone() {
	System.out.println("clone");
	Point instance = new Point(0,0);
	Point result = instance.clone();
	assertTrue(new Point(0,0).equals(result));
    }

    /**
     * Test of equals method, of class Point.
     */
    @Test
    public void testEquals() {
	System.out.println("equals");
	Point instance = new Point(0,0);
	assertTrue(instance.equals(new Point(0,0)));
    }

}