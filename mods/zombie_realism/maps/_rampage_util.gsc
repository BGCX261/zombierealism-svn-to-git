#include maps\_utility; 
#include common_scripts\utility;
#include maps\_zombiemode_utility;

#include maps\_rampage_loadout;
#include maps\_rampage_class;

rampage_variables()
{
	// From _rampage_loadouts
	loadouts();
	maps\_rampage_perk::init();

	level.onlineGame = true;
	level.gameSkill2 = 1;
	level.classes_enabled = true;
	level.ready_players = 0;
	level.engineer_size = 0;
	level.medic_size = 0;
	level.soldier_size = 0;
	level.support_size = 0;
	level.berserk = false;

	players = get_players();
	for(i=0;i<players.size;i++)
	{
		player = players[i];
		player thread fontPulseInit();
	
		// Others
		player.revive_on = false;
		player.ammo_on = false;
		player.build_on = false;
		player.old_class = "";
	
		player.gun_primary = undefined;
		player.gun_secondary = undefined;
		player.inventory = undefined;
		player.grenade_primary = undefined;
		player.grenade_secondary = undefined;
		player.weapon_attachment = undefined;
		player.grenade_count = undefined;
	
		player.perk1 = undefined;
		player.perk2 = undefined;
		player.perk3 = undefined;
	}
}

fontPulseInit()
{
	self.rankUpdateTotal = 0;
	self.baseFontScale = self.fontScale;
	self.maxFontScale = self.fontScale * 2;
	self.inFrames = 3;
	self.outFrames = 5;
}

fontPulse(player)
{
	player endon("disconnect");
	self notify ( "fontPulse" );
	self endon ( "fontPulse" );
	
	scaleRange = self.maxFontScale - self.baseFontScale;
	
	while ( self.fontScale < self.maxFontScale )
	{
		self.fontScale = min( self.maxFontScale, self.fontScale + (scaleRange / self.inFrames) );
		wait 0.05;
	}
		
	while ( self.fontScale > self.baseFontScale )
	{
		self.fontScale = max( self.baseFontScale, self.fontScale - (scaleRange / self.outFrames) );
		wait 0.05;
	}
}
