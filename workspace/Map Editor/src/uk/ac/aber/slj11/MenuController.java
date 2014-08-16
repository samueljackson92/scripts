package uk.ac.aber.slj11;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;

public class MenuController implements ActionListener {
	Map map;
	public MenuController(Map map){
		this.map = map;
	}
	@Override
	public void actionPerformed(ActionEvent e) {
		String command = e.getActionCommand();
		if(command.equals("Save Map")){
			XMLIO xml = new XMLIO();
			try {
				xml.encodeObject(map, "map.xml");
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} else if (command.equals("Load Map")){
			XMLIO xml = new XMLIO();
			try {
				map = (Map) xml.decodeObject("map.xml");
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
	}

}
