#include maps\_utility; 
#include common_scripts\utility;
#include maps\_zombiemode_utility;

// These are not done :)

loadouts()
{
//************************** SUPPORT 1 **************************//
	level.support_1 = spawnStruct();
	level.support_1.gun_primary = "m1garand";
	level.support_1.gun_secondary = "zombie_colt";
	level.support_1.inventory = "";
	level.support_1.inventory_ammo = 0;
	level.support_1.grenade_primary = "stielhandgranate";
	level.support_1.grenade_primary_count = 2;
	level.support_1.grenade_secondary = "";
	level.support_1.grenade_secondary_count = 0;
	
//************************** SOLDIER 1 **************************//
	level.soldier_1 = spawnStruct();
	level.soldier_1.gun_primary = "m1carbine";
	level.soldier_1.gun_secondary = "zombie_colt";
	level.soldier_1.inventory = "";
	level.soldier_1.inventory_ammo = 0;
	level.soldier_1.grenade_primary = "stielhandgranate";
	level.soldier_1.grenade_primary_count = 2;
	level.soldier_1.grenade_secondary = "";
	level.soldier_1.grenade_secondary_count = 0;

//************************** ENGINEER 1 **************************//
	level.engineer_1 = spawnStruct();
	level.engineer_1.gun_primary = "kar98k";
	level.engineer_1.gun_secondary = "zombie_colt";
	level.engineer_1.inventory = "";
	level.engineer_1.inventory_ammo = 0;
	level.engineer_1.grenade_primary = "stielhandgranate";
	level.engineer_1.grenade_primary_count = 2;
	level.engineer_1.grenade_secondary = "";
	level.engineer_1.grenade_secondary_count = 0;
	
//************************** MEDIC 1 **************************//
	level.medic_1 = spawnStruct();
	level.medic_1.gun_primary = "gewehr43";
	level.medic_1.gun_secondary = "zombie_colt";
	level.medic_1.inventory = "";
	level.medic_1.inventory_ammo = 0;
	level.medic_1.grenade_primary = "stielhandgranate";
	level.medic_1.grenade_primary_count = 2;
	level.medic_1.grenade_secondary = "";
	level.medic_1.grenade_secondary_count = 0;
	
//************************** CUSTOM **************************//
	level.custom = spawnStruct();
	level.custom.gun_primary = "gewehr43";
	level.custom.gun_secondary = "zombie_colt";
	level.custom.inventory = "";
	level.custom.inventory_ammo = 0;
	level.custom.grenade_primary = "stielhandgranate";
	level.custom.grenade_primary_count = 2;
	level.custom.grenade_secondary = "";
	level.custom.grenade_secondary_count = 0;
}