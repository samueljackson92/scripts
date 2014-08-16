package uk.ac.aber.dcs.slj11.gui;

import java.awt.Component;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;

import javax.swing.JFileChooser;
import javax.swing.JFrame;

import uk.ac.aber.dcs.slj11.data.XMLIO;

public class XMLIOGUI {
	private Component parent;
	private XMLIO xml;
	private final JFileChooser fc;
	
	public XMLIOGUI(Component parent) {
		setParent(parent);
		xml = new XMLIO();
		fc = new JFileChooser();
		fc.setFileSelectionMode(JFileChooser.FILES_ONLY);
	}
	
	public void save(Object obj) throws IOException{
		fc.setFileSelectionMode(JFileChooser.FILES_ONLY);
		int val = fc.showSaveDialog(parent);
		if(val == JFileChooser.APPROVE_OPTION){
			File file = fc.getSelectedFile();
			xml.encodeObject(obj, file.getAbsolutePath());
		}
	}
	
	public Object load () throws IOException{
		int val = fc.showOpenDialog(parent);
		if (val ==JFileChooser.APPROVE_OPTION){
			File file = fc.getSelectedFile();
			return xml.decodeObject(file.getAbsolutePath());
		} else {
			throw new IOException("File could not be loaded");
		}
	}

	public void setParent(Component parent2) {
		this.parent = parent2;
	}

	public Component getParent() {
		return parent;
	}
}
