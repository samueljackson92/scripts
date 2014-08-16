package uk.ac.aber.slj11;

import org.lwjgl.opengl.GL11;
import org.newdawn.slick.Color;
import org.newdawn.slick.opengl.Texture;

public class Map {
	private int[][] map = new int[16][16];

	public void init() {
		for (int i=0;i<16;i++){
			for(int j=0;j<16;j++){
				if (i==0 || i == 15 || j == 0 || j == 15) {
					map[i][j] = 1;
				} else {
					map[i][j] = 0;
				}
			}
		}
	}
	
	public void setMap(int[][] map) {
		this.map = map;
	}

	public int[][] getMap() {
		return map;
	}
	
	public void setTile(int value, int x, int y){
		map[x][y] = value;
	}
	
	public int getTile(int x, int y) {
		return map[x][y];
	}
	
	public boolean isWall(int x, int y) {
		return (map[x][y] == 1);
	}
	
	public void drawMap() {
		for (int i=0;i<map.length;i++){
			for(int j=0;j<map[i].length;j++){
				switch(map[i][j]){
				case 0:
					drawQuad(Textures.FLOOR, i, j);
					break;
				case 1:
					drawQuad(Textures.WALL, i, j);
					break;
				case 2:
					drawQuad(Textures.START, i, j);
					break;
				case 3:
					drawQuad(Textures.STOP, i, j);
					break;
				}
			}
		}
	}
	
	public void drawQuad(Texture tex, int x, int y){
		Color.white.bind();
		tex.bind(); // or GL11.glBind(texture.getTextureID());
		x *= tex.getTextureWidth();
		y *= tex.getTextureHeight();
		
		GL11.glBegin(GL11.GL_QUADS);
			GL11.glTexCoord2f(0,0);
			GL11.glVertex2f(x, y);
			GL11.glTexCoord2f(1,0);
			GL11.glVertex2f(x+tex.getTextureWidth(),y);
			GL11.glTexCoord2f(1,1);
			GL11.glVertex2f(x+tex.getTextureWidth(),y+tex.getTextureHeight());
			GL11.glTexCoord2f(0,1);
			GL11.glVertex2f(x,y+tex.getTextureHeight());
		GL11.glEnd();
	}
}
