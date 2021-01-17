#include "game.h"
#include "graphics.h"
#include "config.h"
#include "stdlib.h"

//create new enemy
void Game::spawnEnemy(int x)
{
	enemy[x] = new Enemy(*this);
	enemy[x]->pos_x = 200*x+100;
}


void Game::updateStartScreen()
{
	if (graphics::getKeyState(graphics::SCANCODE_SPACE)) 
	{
		status = STATUS_GAME;
	}
}

void Game::updateGameScreen()
{
	if (!player_initialized && graphics::getGlobalTime() > 1000)
	{
		game_beggining_time = graphics::getGlobalTime();
		player = new Player(*this);
		player_initialized = true;
	}


	if (player) {
		//creation of a new enemy (if the random number mod 1000 equals 0 and if the random enemy position is empty )
		if (rand() % 1000 == 0) {
			int x = rand() % 5;
			if (!enemy[x])
			{
				spawnEnemy(x);
			}
		}

		//check if the enemy's bullet hit the player and act acorrdingly (remove one health from his healthbar or end the game if he died)
		player->update();
		for (int i = 0; i < 5; i++) {
			if (enemy[i]) {
				if (enemy[i]->dealtdamage == false && enemy[i]->bpos_x < player->pos_x + 30 && enemy[i]->bpos_x > player->pos_x - 30 && enemy[i]->bpos_y < player->pos_y + 30 && enemy[i]->bpos_y > player->pos_y - 30)
				{
					graphics::playSound(std::string(ASSET_PATH) + "grenade.mp3", 0.5f, false);
					player->hp -= 1;
					enemy[i]->dealtdamage = true;
					if (player->hp == 0) {
						status = STATUS_END;
					}
					
				}
			}
		}

	}
	
	//check if the player's bullet hit one of the enemies and act accordingly (deal damage to the enemy, check if the enemy died)
	for (int i = 0; i < 5; i++) {
		if (enemy[i] && graphics::getGlobalTime() > 1000) {

			enemy[i]->update();
			if (!(enemy[i]->bullet_exists)) {
				enemy[i]->enemy_pos_x = player->pos_x;
				enemy[i]->enemy_pos_y = player->pos_y;
			}
			if (player->dealtdamage == false && player->bpos_x < enemy[i]->pos_x + 30 && player->bpos_x > enemy[i]->pos_x - 30 && player->bpos_y < enemy[i]->pos_y + 30 && player->bpos_y > enemy[i]->pos_y - 30)
			{
				graphics::playSound(std::string(ASSET_PATH) + "grenade.mp3", 0.5f, false);
				enemy[i]->hp -= 1;
				if (enemy[i]->hp == 0) {
					enemy[i] = NULL;
					player->kills++;
					if (player->hp < 4) {
						player->hp++;
					}
				}
				player->dealtdamage = true;
			}

		}
	}


	//delete player and enemies , in order to reset if the user plays again
	if (player && player->hp == 0) {
		player_initialized = false;
		kills = player->kills;
		player = nullptr;
		enemy[0] = nullptr;
		enemy[1] = nullptr;
		enemy[2] = nullptr;
		enemy[3] = nullptr;
		enemy[4] = nullptr;
	}

}

//screen shown when the player dies
void Game::updateEndScreen()
{
	
	if (graphics::getKeyState(graphics::SCANCODE_Y))
	{
		status = STATUS_GAME;
	}
	else if (graphics::getKeyState(graphics::SCANCODE_N)) 
	{
		status = STATUS_START;
	}
}


//screen shown before the game starts (instructions)
void Game::drawStartScreen()
{
	graphics::Brush br;
	br.texture = std::string(ASSET_PATH) + "start.png";
	br.outline_opacity = 0.0f;
	graphics::drawRect(CANVAS_WIDTH / 2, CANVAS_HEIGHT / 2, CANVAS_WIDTH, CANVAS_HEIGHT, br);
	
}

void Game::drawGameScreen()
{
	graphics::Brush br;
	br.texture = std::string(ASSET_PATH) + "space.png";
	br.outline_opacity = 0.0f;

	//draw background
	graphics::drawRect(CANVAS_WIDTH / 2, CANVAS_HEIGHT / 2, CANVAS_WIDTH, CANVAS_HEIGHT , br);

	//draw player
	if (player)
		player->draw();
	for (int i = 0; i < 5; i++) {
		if (enemy[i]) {
			enemy[i]->draw();
		}
	}
	//UI info layer
	if (player)
	{
		char info[40];
		sprintf_s(info, "Time:(%.1f)", player->getTime() / 1000- (game_beggining_time/1000));
		graphics::drawText(30, 30, 20, info, br);
		sprintf_s(info, "Kills:(%d)", player->kills);
		graphics::drawText(30, 50, 20, info, br);
	}
}

void Game::drawEndScreen()
{
	graphics::Brush br;
	char info[40];
	sprintf_s(info, "YOU  DIED");
	graphics::drawText(CANVAS_WIDTH / 2-250, CANVAS_HEIGHT / 2, 100, info, br);
	if (kills == 1) {
		sprintf_s(info, "YOU  DESTROYED %d  ENEMY SPACESHIP", kills);
		graphics::drawText(CANVAS_WIDTH / 2 - 380, CANVAS_HEIGHT / 2 + 150, 40, info, br);
	}
	else {
		sprintf_s(info, "YOU  DESTROYED %d  ENEMY SPACESHIPS", kills);
		graphics::drawText(CANVAS_WIDTH / 2 - 380, CANVAS_HEIGHT / 2 + 150, 40, info, br);
	}

	sprintf_s(info, "DO YOU WANT TO PLAY AGAIN ? (Y/N)");
	graphics::drawText(CANVAS_WIDTH / 2-380, CANVAS_HEIGHT / 2 + 200, 40, info, br);
}

void Game::update()
{
	if (status == STATUS_GAME) {
		updateGameScreen();
	}
	else if (status == STATUS_START){
		updateStartScreen();
	}
	else if(status == STATUS_END){
		updateEndScreen(); 
	}
}

void Game::draw()
{
	if (status == STATUS_GAME) {
		drawGameScreen();
	}
	else if (status == STATUS_START) {
		drawStartScreen();
	}
	else if (status == STATUS_END) {
		drawEndScreen();
	}
	
}

void Game::init()
{
	graphics::setFont(std::string(ASSET_PATH) + "font.ttf");
	graphics::playMusic(std::string(ASSET_PATH) + "undertale_megalovania.mp3",0.3f,true,10000);
	Enemy enemy[5] = { (*this) ,(*this) ,(*this) ,(*this) ,(*this) };

}

Game::Game()
{
}

Game::~Game()
{
	if (player)
	{
		delete player; 
	}
	if (enemy[0] || enemy[1] || enemy[2] || enemy[3] || enemy[4]) 
	{
		delete [] enemy;
	}
}
