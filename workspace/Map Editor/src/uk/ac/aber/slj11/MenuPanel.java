package uk.ac.aber.slj11;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;

public class MenuPanel extends JFrame {
	private Map map;
	private MenuController mc = new MenuController(map);
	
	public MenuPanel(Map map) {
		this.map = map;
		setSize(100, 200);
		JPanel panel = new JPanel();
		
		JButton saveMap = new JButton("Save Map");
		JButton loadMap = new JButton("Load Map");
		
		saveMap.addActionListener(mc);
		loadMap.addActionListener(mc);
		
		panel.add(saveMap);
		panel.add(loadMap);
		
		add(panel);
		
		pack();
	}
}
