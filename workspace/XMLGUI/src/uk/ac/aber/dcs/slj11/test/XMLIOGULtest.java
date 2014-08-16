package uk.ac.aber.dcs.slj11.test;

import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.io.IOException;

import org.junit.Test;

import uk.ac.aber.dcs.slj11.gui.XMLIOGUI;


public class XMLIOGULtest {

	@Test
	public void testSavingObjectToFile(){
		XMLIOGUI xml = new XMLIOGUI(null);
		int i = 12;
		try {
			xml.save(i);
			assertTrue("Test Passed", true);
		} catch (IOException e) {
			fail();
		}
	}
	
	@Test
	public void testLoadObjectFromFile(){
		XMLIOGUI xml = new XMLIOGUI(null);
		try {
			Object i = xml.load();
			assertTrue("Test Passed", true);
		} catch (IOException e) {
			fail();
		}
	}
}
