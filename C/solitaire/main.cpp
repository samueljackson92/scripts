#include <SFML/Graphics.hpp>

int main (int argc, char** argv)
{
	sf::RenderWindow App(sf::VideoMode(800, 600, 32), "Solitaire");
	
	while (App.IsOpened())
	{
		sf::Event Event;
        while (App.GetEvent(Event))
        {
            if (Event.Type == sf::Event::Closed)
            {
                App.Close();
            }
        }
        App.Clear();
        App.Display();
	}
	
	return EXIT_SUCCESS;
}
