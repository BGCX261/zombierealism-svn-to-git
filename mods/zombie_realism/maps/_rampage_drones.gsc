#include maps\_utility; 
#include common_scripts\utility;
#include maps\_zombiemode_utility;

setup_drones()
{
	level.drone_spawnFunction["allies"] = character\char_usa_marine_h_comoff::main();
	maps\_drones::init();	
	maps\_drone::init();
}

#using_animtree ("fakeShooters");
do_drones()
{
	players = get_players();

	drone = spawn("script_model",(0,0,0));
	drone.origin = (-186,49,-1);
	drone.team = "allies";
	drone.shootTarget = players[randomInt(players.size)];
	drone.script_moveoverride = true;
	drone character\char_usa_marine_h_comoff::main();
	drone.targetname = "drone";
	drone.script_noteworthy = "run_n_gun_drones";
	drone.weapon = "thompson";
	drone attach("thompson","tag_weapon_right");
	drone makefakeai();
	drone thread maps\_drones::drone_think(drone);
	drone.fakeDeath = true;
	drone.health = 150;

	drone move_drone();
}

move_drone()
{
	players = get_players();
	zombies = getAiArray("zombie","targetname");

	self notify("drone_idle_anim","end");
	self notify("drone_shooting");

	self.drone_run_cycle = %drone_run_forward_1;
		
	while(1)
	{
		player = players[randomInt(players.size)];
		zombie = players[randomInt(zombies.size)];
		dest = player.origin;
	
		self maps\_drones::ShooterRun(dest,undefined);
		self maps\_drones::ShooterShootThread(zombie);
		wait(0.05);
	}
}