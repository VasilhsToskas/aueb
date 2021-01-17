#pragma once
#include "player.h"
#include "enemy.h"
class Game 
{
	typedef enum{ STATUS_START,STATUS_GAME,STATUS_END} status_t;
	Player * player = nullptr;
	bool player_initialized = false;
	Enemy* enemy[5] = { nullptr ,nullptr ,nullptr ,nullptr ,nullptr };
	void spawnEnemy(int x);
	int status=STATUS_START;
	void updateStartScreen();
	void updateGameScreen();
	void updateEndScreen();
	void drawStartScreen();
	void drawGameScreen();
	void drawEndScreen();
	int kills;
	float game_beggining_time;
public:
	void update();
	void draw();
	void init();
	Game();
	~Game();

};