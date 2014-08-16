#include <vector>
#include "engine/headers/drawable.hpp"
#include "engine/headers/textures.hpp"

class Roguelike
{
	public:
		void KeyPressed(sf::Event);
		bool Draw();
		void DoEvents();
		static Roguelike* GetInstance();
		
	private:
		static Roguelike* inst;
		sf::RenderWindow* Win;
		textures_t textures;
	
		Roguelike();
};

Roguelike* Roguelike::inst = NULL;

Roguelike::Roguelike()
{
	Win = new sf::RenderWindow (sf::VideoMode(500, 500, 32), "Roguelike 2.0");
}

Roguelike* Roguelike::GetInstance()
{
	if (inst == NULL)
	{
		inst = new Roguelike();
	}
	return inst;
}

void Roguelike::KeyPressed(sf::Event e)
{
	if (e.Key.Code == sf::Key::Escape)
		Win->Close();
}

bool Roguelike::Draw()
{
	Win->Clear();
	Drawable::Draw(Win);
	Win->Display();
	return true;
}

void Roguelike::DoEvents()
{

	while (Win->IsOpened())
	{
		sf::Event e;
	
		while(Win->GetEvent(e))
		{
			if (e.Type == sf::Event::Closed)
				Win->Close();
			
			if (e.Type == sf::Event::KeyPressed)
				KeyPressed(e);
		}
		
		Draw();
	}
}

int main (int argc, char ** argv)
{
	Roguelike* app = Roguelike::GetInstance();
	app->DoEvents();
	return 0;
}

