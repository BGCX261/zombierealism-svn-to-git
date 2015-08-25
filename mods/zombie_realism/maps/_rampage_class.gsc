#include maps\_utility; 
#include common_scripts\utility;
#include maps\_zombiemode_utility;

set_loadout(class)
{
	loadout = self getLoad(class);
	self give_load(loadout);
	self set_health(class);
	self get_class(class);
	self set_perks();
}

get_class()
{
	return self.class_picked;
}

getLoad(picked)
{
	switch(picked)
	{
//******* SUPPORT *******//
		case "support_1":
		loadout = level.support_1;
		return loadout;
	
//******* SOLDIER *******//
		case "soldier_1":
		loadout = level.soldier_1;
		return loadout;
		
//******* ENGINEER *******//
		case "engineer_1":
		loadout = level.engineer_1;
		return loadout;

//******* MEDIC *******//
		case "medic_1":
		loadout = level.medic_1;
		return loadout;
	
//******* CUSTOM *******//
		case "custom":
		loadout = level.custom;
		return loadout;
	}
}

set_health(class)
{
	switch(class)
	{
//******* SUPPORT *******//
		case "support_1":
			self.canbuild = true;
			self.health = 80;
			self.maxhealth = 80;
			break;
	
//******* SOLDIER *******//
		case "soldier_1":
			self.canbuild = false;
			self.health = 120;
			self.maxhealth = 120;
			break;
			
//******* ENGINEER *******//
		case "engineer_1":
			self.canbuild = true;
			self.health = 90;
			self.maxhealth = 90;
			break;

//******* MEDIC *******//
		case "medic_1":
			self.canbuild = false;
			self.health = 100;
			self.maxhealth = 100;
			break;

//******* CUSTOM *******//
		case "custom":
			self.canbuild = false;
			self.health = 100;
			self.maxhealth = 100;
			break;
	}
}

give_load(loadout)
{
	self takeAllWeapons();
	
	weapon = undefined;
	if(loadout.gun_primary != "" && !isDefined(self.gun_primary))
	{
		weapon = loadout.gun_primary;
		self.pers["primaryWeapon"] = strTok(loadout.gun_primary, "_");
	
		if(isDefined(self.weapon_attachment) && self.weapon_attachment != "none" && self.weapon_attachment != "")
		{
			weapon = loadout.gun_primary+"_"+self.weapon_attachment;
		}
		
		if(!isDefined(self.weapon_attachment) || self.weapon_attachment == "none" || self.weapon_attachment == "")
		{
			if(getDvar("mapname") == "nazi_zombie_sumpf" || getDvar("mapname") == "nazi_zombie_factory")
			{
				if(weapon != "ptrs41_zombie" && weapon != "springfield" && weapon != "ak47" && weapon != "ak74u" && weapon != "deserteagle" && weapon != "dragunov" && weapon != "m4" && weapon != "m16" && weapon != "m249" && weapon != "mp5" && weapon != "winchester")
				{
					weapon = "zombie_"+weapon;
				}
			}
		}
		self giveWeapon(weapon);
		self giveStartAmmo(weapon);
		self switchToWeapon(weapon);
	}
	
	if(isDefined(self.gun_primary) && self.gun_primary != "")
	{
		weapon = self.gun_primary;
	
		self.pers["primaryWeapon"] = strTok(self.gun_primary, "_");
	
		if(isDefined(self.weapon_attachment) && self.weapon_attachment != "" && self.weapon_attachment != "none")
		{
			//weapon = self.gun_primary+"_"+self.weapon_attachment;
			weapon = self.gun_primary+"_"+self.weapon_attachment;
		}
		
		if(!isDefined(self.weapon_attachment) || self.weapon_attachment == "none" || self.weapon_attachment == "")
		{
			if(getDvar("mapname") == "nazi_zombie_sumpf" || getDvar("mapname") == "nazi_zombie_factory")
			{
				if(weapon != "ptrs41_zombie" && weapon != "springfield" && weapon != "ak47" && weapon != "ak74u" && weapon != "deserteagle" && weapon != "dragunov" && weapon != "m4" && weapon != "m16" && weapon != "m249" && weapon != "mp5" && weapon != "winchester")
				{
					weapon = "zombie_"+weapon;
				}
			}
		}
		self giveWeapon(weapon);
		self giveStartAmmo(weapon);
		self switchToWeapon(weapon);
	}

	if(loadout.gun_secondary != "" && !isDefined(self.gun_secondary))
	{
		self giveWeapon(loadout.gun_secondary);
		self giveStartAmmo(loadout.gun_secondary);
	
		if(loadout.gun_primary == "")
		{
			self switchToWeapon(loadout.gun_secondary);
		}
	}
	
	if(isDefined(self.gun_secondary))
	{
		self giveWeapon(self.gun_secondary);
		self giveStartAmmo(self.gun_secondary);
	
		if(self.gun_primary == "")
		{
			self switchToWeapon(self.gun_secondary);
		}
	}
	
	if(loadout.inventory != "" && !isDefined(self.inventory))
	{
		self giveWeapon(loadout.inventory);
		self setActionSlot(3,"weapon",loadout.inventory);
		self setActionSlot(4,"", "");
		self setWeaponAmmoClip(loadout.inventory, loadout.inventory_ammo);
	}
	
	if(isDefined(self.inventory))
	{
		self giveWeapon(self.inventory);
		self setWeaponAmmoClip(self.inventory, 2);
	}
	
	if(loadout.grenade_primary != "" && !isDefined(self.grenade_primary))
	{
		self giveWeapon(loadout.grenade_primary);
		self setWeaponAmmoClip(loadout.grenade_primary, loadout.grenade_primary_count);
		self switchToOffhand(loadout.grenade_primary);
	}
	
	if(isDefined(self.grenade_primary))
	{
		self giveWeapon(self.grenade_primary);
		self setWeaponAmmoClip(self.grenade_primary, loadout.grenade_primary_count);
		self switchToOffhand(self.grenade_primary);
	}
	
	if(loadout.grenade_secondary != "" && !isDefined(self.grenade_secondary))
	{
		self giveWeapon(loadout.grenade_secondary);
		self setWeaponAmmoClip(loadout.grenade_secondary, loadout.grenade_secondary_count);
	}
	
	if(isDefined(self.grenade_secondary))
	{
		self giveWeapon(self.grenade_secondary);
		self setWeaponAmmoClip(self.grenade_secondary, 2);
	}
	//wait(0.5);

	self player_flag_set("loadout_given");
	level.loadoutComplete = true;
	level notify("loadout complete");
}

set_perks()
{
	if(isDefined(self.perk1) && self.perk1 != "")
	{
		self maps\_rampage_perk::set_perk( self.perk1 );
	}

	if(isDefined(self.perk2) && self.perk2 != "")
	{
		self maps\_rampage_perk::set_perk( self.perk2 );
	}
	
	if(isDefined(self.perk3) && self.perk3 != "")
	{
		self maps\_rampage_perk::set_perk( self.perk3 );
	}
}

