#include <SFML/Graphics.hpp>
#include <card.cpp>

class Deck
{
	public:
		Card cards[51];
		Deck();
		
		void shuffle();
		
	private:
		sf::Sprite loadImage(std::String filename);
}

Deck::Deck()
{
	int suite;
	//generate the deck of 52
	for (i = 1; i <= 4; i++)
	{
		for (j = 1; j <= 13; j++)
		{

			//pick suite
			if (i == 1) { suite = "d"; }
			else if (i == 2) { suite = "c"; }
			else if (i == 3) { suite = "h"; }
			else if (i == 4) { suite = "s"; }
			
 			Card newcard = Card(j, i);
			newcard.sprite = this->loadImage(suite + j + ".png");
			cards[(i * j) - 1] = Card(j, i);
		}
	}
}

void Deck::shuffle()
{
}

sf::Sprite Deck::loadImage(std::String filename)
{
	sf::Image image;
	sf::Sprite;
	if (!image.LoadFromFile(filename))
	{
	}
	sprite.SetImage(image);
	return sprite
}
