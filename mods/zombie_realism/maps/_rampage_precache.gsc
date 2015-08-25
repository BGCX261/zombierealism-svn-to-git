#include maps\_utility; 
#include common_scripts\utility;
#include maps\_zombiemode_utility;

init_precache()
{
	thread precache_menus();
	thread precache_weapons();
	thread precache_models();
	thread precache_shaders();
}

precache_menus()
{
	// classes
	game["classmenu"] = "classmenu";
	precacheMenu(game["classmenu"]);

	// kit - support
	game["kit_support"] = "kit_support";
	game["w_support"] = "w_support";
	precacheMenu(game["w_support"]);
	precacheMenu(game["kit_support"]);

	// kit - soldier
	game["kit_soldier"] = "kit_soldier";
	precacheMenu(game["kit_soldier"]);

	// kit - engineer
	game["kit_engineer"] = "kit_engineer";
	precacheMenu(game["kit_engineer"]);
	
	// kit - medic
	game["kit_medic"] = "kit_medic";
	precacheMenu(game["kit_medic"]);
	
	// kit - custom
	game["kit_custom"] = "kit_custom";
	precacheMenu(game["kit_custom"]);
	
	// perk
	game["w_perk1"] = "w_perk1";
	precacheMenu(game["w_perk1"]);
	game["w_perk2"] = "w_perk2";
	precacheMenu(game["w_perk2"]);
	game["w_perk3"] = "w_perk3";
	precacheMenu(game["w_perk3"]);
	
	// sec gren
	game["w_grenade_secondary"] = "w_grenade_secondary";
	precacheMenu(game["w_grenade_secondary"]);

	// weapons
	game["w_bolt"] = "w_bolt";
	game["w_mg"] = "w_mg";
	game["w_rifle"] = "w_rifle";
	game["w_sub"] = "w_sub";
	game["w_shot"] = "w_shot";
	game["w_pistol"] = "w_pistol";
	precacheMenu(game["w_bolt"]);
	precacheMenu(game["w_mg"]);
	precacheMenu(game["w_rifle"]);
	precacheMenu(game["w_sub"]);
	precacheMenu(game["w_shot"]);
	precacheMenu(game["w_pistol"]);
	
	// attachments
	game["w_bolt_attachments"] = "w_bolt_attachments";
	precacheMenu(game["w_bolt_attachments"]);
	game["w_shot_attachments"] = "w_shot_attachments";
	precacheMenu(game["w_shot_attachments"]);
	game["w_rifle_attachments"] = "w_rifle_attachments";
	precacheMenu(game["w_rifle_attachments"]);
	game["w_rifle_attachments2"] = "w_rifle_attachments2";
	precacheMenu(game["w_rifle_attachments2"]);
	game["w_rifle_attachments3"] = "w_rifle_attachments3";
	precacheMenu(game["w_rifle_attachments3"]);
}

precache_weapons()
{
	PrecacheItem("gewehr43_aperture");
	PrecacheItem("gewehr43_telescopic");
	PrecacheItem("kar98k_bayonet");
	PrecacheItem("m1carbine_aperture");
	PrecacheItem("m1carbine_bigammo");
	PrecacheItem("m1garand_bayonet");
	PrecacheItem("m1garand_scoped");
	PrecacheItem("mp40_aperture");
	PrecacheItem("mp40_bigammo");
	PrecacheItem("ppsh");
	PrecacheItem("ppsh_aperture");
	PrecacheItem("ppsh_bigammo");
	PrecacheItem("shotgun_grip");
	PrecacheItem("springfield");
	PrecacheItem("springfield_bayonet");
	PrecacheItem("springfield_scoped_zombie");
	PrecacheItem("stg44_aperture");
	PrecacheItem("stg44_telescopic");
	PrecacheItem("thompson_aperture");
	PrecacheItem("thompson_bigammo");
	PrecacheItem("m1garand_gl");
	PrecacheItem("m1garand_gl_zombie");
	PrecacheItem("m1garand_gl_zombie_upgraded");
	PrecacheItem("panzerschrek");
	PrecacheItem("panzerschrek_zombie");
	PrecacheItem("panzerschrek_zombie_upgraded");
	
	// MW
	PrecacheItem("ak47");
	PrecacheItem("ak74u");
	PrecacheItem("deserteagle");
	PrecacheItem("dragunov");
	PrecacheItem("m4");
	PrecacheItem("m16");
	PrecacheItem("m249");
	PrecacheItem("mp5");
	PrecacheItem("rpd");
	PrecacheItem("winchester");
	PrecacheItem("m7_launcher2");
	PrecacheItem("sticky_grenade");
	//PrecacheItem("brain");
	//PrecacheItem("brain2");
	
	preCacheItem("zombie_perk_bottle_doubletap");
	preCacheItem("zombie_perk_bottle_jugg");
	preCacheItem("zombie_perk_bottle_revive");
	preCacheItem("zombie_perk_bottle_sleight");
}

precache_models()
{
	preCacheModel("zombie_vending_doubletap");
	preCacheModel("zombie_vending_sleight");
	preCacheModel("zombie_vending_jugg");
	preCacheModel("zombie_vending_revive");

	preCacheModel("zombie_vending_doubletap_on");
	preCacheModel("zombie_vending_sleight_on");
	preCacheModel("zombie_vending_jugg_on");
	preCacheModel("zombie_vending_revive_on");

	preCacheModel("collision_geo_64x64x128");

	preCacheModel("zombie_brain");

	precacheModel("char_usa_marine_comoff");
}

precache_shaders()
{
	PrecacheShader( "specialty_armorvest" );
	PrecacheShader( "specialty_bulletdamage" );
	PrecacheShader( "specialty_fastreload" );
	PrecacheShader( "specialty_longersprint" );
	PrecacheShader( "specialty_magic_wrench" );
	PrecacheShader( "specialty_quickrevive_zombies" );
	PrecacheShader( "specialty_specialgrenade" );
	PrecacheShader( "specialty_rof" );
	PrecacheShader( "specialty_twoprimaries" );
}