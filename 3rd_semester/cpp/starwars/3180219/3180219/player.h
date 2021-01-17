#pragma once
#include "gameobject.h"
#include "config.h"
class Player : public GameObject 
{
	float time=0;
	float speed = 10.0f; //fps
	
	bool bullet_exists = false; //secures that the spaceship cant shoot before the last bullet it shooted dissapears (hits the player or gets out of the boundaries)
	bool bullet_drawn = false;
public:
	float bpos_x = 0, bpos_y = 0; //bullet position
	float pos_x=CANVAS_WIDTH/2, pos_y=CANVAS_HEIGHT-50;
	int hp=4;	
	int kills=0;
	bool 	dealtdamage = false; //secures that one bullet can cause damage to the enemy only one time 
	Player(const class Game& mygame);
	void update() override;
	void draw() override;
	void init() override;
	float getTime() { return time; }
	void shoot() {}
	
};