package uk.ac.aber.slj11;

import java.io.IOException;

import org.newdawn.slick.opengl.Texture;
import org.newdawn.slick.opengl.TextureLoader;
import org.newdawn.slick.util.ResourceLoader;

public class Textures {
	public static Texture FLOOR;
	public static Texture WALL;
	public static Texture START;
	public static Texture STOP;
	public static void init() throws IOException {
		FLOOR = TextureLoader.getTexture("PNG", ResourceLoader.getResourceAsStream("images/floor.png"));
		WALL = TextureLoader.getTexture("PNG", ResourceLoader.getResourceAsStream("images/wall.png"));
		START = TextureLoader.getTexture("PNG", ResourceLoader.getResourceAsStream("images/start.png"));
		STOP = TextureLoader.getTexture("PNG", ResourceLoader.getResourceAsStream("images/stop.png"));
	}
}
