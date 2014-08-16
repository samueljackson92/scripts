#include "headers/textures.hpp"
#include "headers/drawable.hpp"
#include <list>

list <Drawable*> Drawable::Drawables;

Drawable::Drawable()
{
	Drawables.push_back(this);
}

Drawable::~Drawable()
{
	list <Drawable*>::iterator p = find(Drawables.begin(), Drawables.end(), this);
	if (p != Drawables.end())
	{
		Drawables.erase(p);
	}
}

sf::Sprite Drawable::GetSprite()
{
	return sprite;
}

bool Drawable::SetPosition(int ncol, int nrow)
{
	col = ncol;
	row = nrow;
	SetCoordinates(ncol * 32, nrow * 32);
}

bool Drawable::SetCoordinates(int nx, int ny)
{
	x = nx;
	y = ny;
	sprite.SetPosition(x, y);
}

void Drawable::SetImage(sf::Image img)
{
	image = img;
	sprite.SetImage(image);
}

void Drawable::Draw(sf::RenderWindow* rw)
{
	for (list <Drawable*>::iterator i = Drawables.begin(); i != Drawables.end(); ++i)
	{
		rw->Draw((*i)->GetSprite());
	}
}
