#include "enemy.h"
#include "graphics.h"
#include "config.h"
#include "game.h"
void Enemy::update()
{

	if (pos_y < 50) {
		pos_y += speed;
	}
	

	//bullet movement
		if (pos_y > 49 && !bullet_exists)
		{
			graphics::playSound(std::string(ASSET_PATH) + "blast.mp3", 0.5f, false);
			bullet_exists = true;
			bpos_x = pos_x;
			bpos_y = pos_y + 30;

			bullet_drawn = true;
		}
		if (bullet_exists)
		{
			bpos_y += 1.5;

			if (enemy_pos_x > pos_x) {
				bpos_x += (enemy_pos_x - pos_x) * (1.5 / (enemy_pos_y - pos_y));
			}
			else {
				bpos_x -= (pos_x - enemy_pos_x) * (1.5 / (enemy_pos_y - pos_y));
			}

		}
		if (bullet_exists && bpos_y > 490)
		{
			bullet_drawn = false;
			bullet_exists = false;
			dealtdamage = false;
		}

}

void Enemy::draw()
{
	//ship
	brush.texture = std::string(ASSET_PATH) + "small_enemy.png";
	brush.outline_opacity = 0.0f;
	graphics::drawRect(pos_x,pos_y,60,60,brush);

	//healthbar
	graphics::Brush br;
	br.outline_opacity = 0.0f;
	if (hp == 4) { br.texture = std::string(ASSET_PATH) + "4_4healthbar.png"; graphics::drawRect(pos_x, pos_y - 20, 100, 100, br); }
	else if (hp == 3) { br.texture = std::string(ASSET_PATH) + "3_4healthbar.png"; graphics::drawRect(pos_x, pos_y - 20, 100, 100, br); }
	else if (hp == 2) { br.texture = std::string(ASSET_PATH) + "2_4healthbar.png"; graphics::drawRect(pos_x, pos_y - 20, 100, 100, br); }
	else if (hp == 1) { br.texture = std::string(ASSET_PATH) + "1_4healthbar.png"; graphics::drawRect(pos_x, pos_y - 20, 100, 100, br); }
	else if (hp == 4) { br.texture = std::string(ASSET_PATH) + "0_4healthbar.png"; graphics::drawRect(pos_x, pos_y - 20, 100, 100, br); }
	//draw bullet
	if (!dealtdamage) {
		float glow = 0.5f + 0.5f * sinf(graphics::getGlobalTime() / 10);
		br.texture = "";
		br.fill_color[0] = 1.0f;
		br.fill_color[1] = 0.5f + glow * 0.7f;
		br.fill_color[2] = 0.0f;
		br.fill_secondary_color[0] = 0.3f;
		br.fill_secondary_color[1] = 0.1f;
		br.fill_secondary_color[2] = 0.0f;
		br.fill_opacity = 1.0f;
		br.fill_secondary_opacity = 0.0f;
		br.gradient = true;

		if (bullet_exists && !(bpos_y < 10)) {
			graphics::drawDisk(bpos_x, bpos_y, 10, br);
		}
	}
}

void Enemy::init()
{
	speed = 1.0f;

	pos_y =- 50;
}

Enemy::Enemy(const Game& mygame)
	:GameObject(mygame)
{
	init();
}


Enemy::~Enemy()
{
}