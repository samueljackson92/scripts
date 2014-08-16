package uk.ac.aber.slj11;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;

import javax.swing.JOptionPane;

import org.lwjgl.LWJGLException;
import org.lwjgl.input.Keyboard;
import org.lwjgl.input.Mouse;
import org.lwjgl.opengl.Display;
import org.lwjgl.opengl.GL11;
import org.lwjgl.opengl.DisplayMode;

public class Main {
	private Map map;
	private boolean makeTarget = false;
	private boolean targetsMade = false;
	private Coordinate start;
	private Coordinate stop;
	
	private MenuPanel menu = new MenuPanel(map);
	
	public void start() {
		try {
			Display.setDisplayMode(new DisplayMode(512,512));
			Display.create();
		} catch (LWJGLException e) {
			e.printStackTrace();
			System.exit(0);
		}
		
		try {
			Textures.init();
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null, "Failed to load textures.");
			System.exit(-1);
		}

		map = new Map();
		map.init();
		
		initGL();
		while (!Display.isCloseRequested()) {
			GL11.glClear(GL11.GL_COLOR_BUFFER_BIT);
			map.drawMap();
			Display.update();
			
			pollInput();
		}
		
		Display.destroy();
	}
	
	public void initGL(){
		GL11.glEnable(GL11.GL_TEXTURE_2D);               
        
		GL11.glClearColor(0.0f, 0.0f, 0.0f, 0.0f);          
        	// enable alpha blending
        	GL11.glEnable(GL11.GL_BLEND);
        	GL11.glBlendFunc(GL11.GL_SRC_ALPHA, GL11.GL_ONE_MINUS_SRC_ALPHA);
        
        	GL11.glViewport(0,0,512,512);
		GL11.glMatrixMode(GL11.GL_MODELVIEW);

		GL11.glMatrixMode(GL11.GL_PROJECTION);
		GL11.glLoadIdentity();
		GL11.glOrtho(0, 512, 512, 0, 1, -1);
		GL11.glMatrixMode(GL11.GL_MODELVIEW);
	}
	
	public void pollInput(){
		while(Mouse.next()){
			if (Mouse.getEventButtonState()){
				int x = Mouse.getX();
				int y = 512 - Mouse.getY(); //adjust for GL positioning system
				
				x = (x - (x % 32)) /32;
				y = (y - (y % 32)) /32;
				
				if(Mouse.getEventButton() == 0){
					map.setTile(1, x, y);
				} else if (Mouse.getEventButton() == 1){
					if (!makeTarget && !targetsMade){
						map.setTile(2, x, y);
						start = new Coordinate(x, y);
						makeTarget = true;
					} else if (makeTarget && !targetsMade) {
						map.setTile(3, x, y);
						stop = new Coordinate(x, y);
						targetsMade = true;
					}
				}
			}
		}
		
		while (Keyboard.next()){
			if (Keyboard.getEventKeyState()){
				if(Keyboard.getEventKey() == Keyboard.KEY_F1){
					menu.setVisible(!menu.isVisible());
				}
			}
		}
	}
	
	public static void main(String[] argv) {
		Main displayExample = new Main();
		displayExample.start();
	}
}