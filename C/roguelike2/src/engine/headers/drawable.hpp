#include <SFML/Graphics.hpp>
#include <list>
#include <string>

using namespace std;

#ifndef DRAWABLE_C
#define DRAWABLE_C
class Drawable
{
	public:
		Drawable();
		sf::Sprite GetSprite(void);
		bool SetPosition(int, int);
		bool SetCoordinates(int, int);
		void SetImage(sf::Image);
		static void Draw(sf::RenderWindow*);
		
	protected:
		sf::Image image;
		sf::Sprite sprite;
		int col, row;
		int x, y;
		static list<Drawable*> Drawables;
		~Drawable();
};

#include "drawable.cpp"
#endif

