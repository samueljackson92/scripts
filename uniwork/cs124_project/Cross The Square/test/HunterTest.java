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
public class HunterTest {

    public HunterTest() {
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
     * Test of getNextMove method, of class Hunter.
     */
    @Test
    public void testPeepNextMove() {
	System.out.println("getNextMove");
	Hunter instance = new Hunter();
	Point result = instance.peepNextMove();
	assertTrue(result instanceof Point);
    }

    /**
     * Test of popNextMove method, of class Hunter.
     */
    @Test
    public void testPopNextMove() {
	System.out.println("popNextMove");
	Hunter instance = new Hunter();
	Point result = instance.popNextMove();
	assertTrue(result instanceof Point);
    }

    /**
     * Test of hasNextMove method, of class Hunter.
     */
    @Test
    public void testHasNextMove() {
	System.out.println("hasNextMove");
	Hunter instance = new Hunter();
	boolean expResult = true;
	boolean result = instance.hasNextMove();
	assertEquals(expResult, result);
    }

}