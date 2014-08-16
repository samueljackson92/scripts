package uk.ac.aber.slj11;

import java.beans.XMLDecoder;
import java.beans.XMLEncoder;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;

/**
 * XML Import/Export Class.
 * Used to encode and decode Java objects to a specified file.
 * 
 * @author Samuel Jackson (slj11@aber.ac.uk)
 */
public class XMLIO {
	
	/**
	 * Encode object to an XML file.
	 *
	 * @param obj The object to be encoded
	 * @param filename The filename to export it to.
	 * @throws IOException Signals that an I/O exception has occurred.
	 */
	public void encodeObject(Object obj, String filename) throws IOException {
		createFileIfNoneExists(filename);
		
		XMLEncoder encoder = new XMLEncoder(new BufferedOutputStream(new FileOutputStream(filename)));
		encoder.setPersistenceDelegate(BigDecimal.class, encoder.getPersistenceDelegate(Integer.class));
		encoder.writeObject(obj);
		encoder.flush();
		encoder.close();
	}
	
	/**
	 * Decode object from an XML file.
	 *
	 * @param filename The filename to load the object from
	 * @return The object which was decoded
	 * @throws FileNotFoundException Signals the the specified file could not be found
	 */
	public Object decodeObject(String filename) throws FileNotFoundException{	
		XMLDecoder decoder = new XMLDecoder(new BufferedInputStream(new FileInputStream(filename)));
		Object obj = decoder.readObject();
		decoder.close();
		return obj;
	}
	
	/**
	 * Creates the specified file if it does not already exist.
	 *
	 * @param filename The filename to be checked/created
	 * @throws IOException Signals that an I/O exception has occurred.
	 */
	private void createFileIfNoneExists(String filename) throws IOException {
		File file = new File(filename);
		
		if (!file.isFile()){
			file.createNewFile();
		}
	}
}
