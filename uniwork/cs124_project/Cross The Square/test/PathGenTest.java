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
public class PathGenTest {

    public PathGenTest() {
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
     * Test of getPath method, of class PathGen.
     */
    @Test
    public void testGetPath() {
	System.out.println("getPath");
	PathGen instance = new PathGen();
	ArrayList result = instance.getPath();
	assertTrue(result instanceof ArrayList);
    }

    /**
     * Test of generatePath method, of class PathGen.
     */
    @Test
    public void testGeneratePath() {
	System.out.println("generatePath");
	PathGen instance = new PathGen();
	instance.generatePath();
	
	ArrayList<Point> coordinates = instance.getPath();
	Point p = coordinates.get(coordinates.size()-1);
	assertTrue(p.equals(new Point(0,0)));
    }

    /**
     * Test of generateSmartPath method, of class PathGen.
     */
    @Test
    public void testGenerateSmartPath() {
	System.out.println("generateSmartPath");
	int x = 0;
	int y = 0;
	PathGen instance = new PathGen();
	instance.generateSmartPath(x, y);

	ArrayList<Point> coordinates = instance.getPath();
	Point p = coordinates.get(coordinates.size()-1);

	assertTrue(p.equals(new Point(0,0)));
    }

}