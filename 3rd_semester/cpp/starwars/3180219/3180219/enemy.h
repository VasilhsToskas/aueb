#pragma once
#include "gameobject.h"
#include "graphics.h"

class Enemy : public GameObject
{
	
	graphics::Brush brush;
	float speed;
	
	bool bullet_drawn = false;

public:

	bool bullet_exists = false;
	float bpos_x = 0, bpos_y = 0;
	float pos_x = 0, pos_y = 0;
	float enemy_pos_x, enemy_pos_y;
	int hp=4;
	bool dealtdamage = false; //secure that one bullet can hit the player only once 
	void update() override;
	void draw() override;
	void init() override;
	Enemy(const class Game & mygame);
	~Enemy();
};