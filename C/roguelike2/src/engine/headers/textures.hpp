#include <string>
#include <SFML/Graphics.hpp>
using namespace std;

#ifndef TEXTURES_T
#define TEXTURES_T

class textures_t
{
	struct imageGroup
	{
		sf::Image floor;
		sf::Image wall;
	};
	
	int interator;
	
	public:
		sf::Image* imageArray[5];
		sf::Image darkness;
		imageGroup light, dark;
		
		textures_t()
		{
			interator = 0;
			
			darkness = LoadImage("images/tiles/darkness.png");
			UpdateArray(&darkness);
			
			light.floor = LoadImage("images/tiles/floor.png");
			UpdateArray(&light.floor);
			
			dark.floor = LoadImage("images/tiles/floor-dark.png");
			UpdateArray(&dark.floor);
			
			light.wall = LoadImage("images/tiles/wall.png");
			UpdateArray(&light.wall);
			
			dark.wall = LoadImage ("images/tiles/wall-dark.png");
			UpdateArray(&dark.wall);
		}
	private:
		sf::Image LoadImage(string);
		void UpdateArray(sf::Image*);
};

sf::Image textures_t::LoadImage(string name)
{
	sf::Image img;
	
	if(!img.LoadFromFile(name))
	{
	}
	
	return img;
}

void textures_t::UpdateArray(sf::Image* imgPtr)
{
	imageArray[interator] = imgPtr;
	interator++;
}

#endif
