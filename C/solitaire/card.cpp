#include <SFML/Graphics.hpp>

class Card
{
	public:
		int value;
		int suite;
		sf::Sprite sprite;
		
		Card();
		void draw(sf::RenderWindow * app);
}

Card::Card(int val, int suite)
{
	this->value = val;
	this->suite = suite;
}

void Card::draw(sf::RenderWindow *app)
{
	app->Draw(sprite);
}
