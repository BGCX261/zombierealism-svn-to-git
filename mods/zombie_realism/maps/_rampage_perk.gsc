#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility_new;

init()
{
	thread map_setup();
	thread trigger_setup();

	level thread turn_jugger_on();
	level thread turn_doubletap_on();
	level thread turn_sleight_on();
	level thread turn_revive_on();
	level thread machine_watcher();

	level.speed_jingle = 0;
	level.revive_jingle = 0;
	level.doubletap_jingle = 0;
	level.jugger_jingle = 0;	
}

map_setup()
{
	m = getDvar( "mapname" );

	switch(m)
	{
	//***** Nacht Der Untoten *****
		case "nazi_zombie_prototype":
			level.perk_machine = [];
			level.perk_machine[0] = spawn("script_model",(0,0,0));
			level.perk_machine[0].origin = (-186,49,-1);
			level.perk_machine[0].angles = (0,90,0);
			level.perk_machine[0].targetname = "vending_revive";
			level.perk_machine[0].state = 0;
			level.perk_machine[0].repaired = 5;
			level.perk_machine[0] setModel( "zombie_vending_revive" );
	
			level.perk_machine[1] = spawn("script_model",(0,0,0));
			level.perk_machine[1].origin = (504,644,-1);
			level.perk_machine[1].angles = (0,180,0);
			level.perk_machine[1].targetname = "vending_sleight";
			level.perk_machine[1].state = 0;
			level.perk_machine[1].repaired = 5;
			level.perk_machine[1] setModel( "zombie_vending_sleight" );
	
			level.perk_machine[2] = spawn("script_model",(0,0,0));
			level.perk_machine[2].origin = (169,324,144);
			level.perk_machine[2].angles = (0,0,0);
			level.perk_machine[2].targetname = "vending_jugg";
			level.perk_machine[2].state = 0;
			level.perk_machine[2].repaired = 5;
			level.perk_machine[2] setModel( "zombie_vending_jugg" );
	
			level.perk_machine[3] = spawn("script_model",(0,0,0));
			level.perk_machine[3].origin = (192,658,144);
			level.perk_machine[3].angles = (0,-90,0);
			level.perk_machine[3].targetname = "vending_doubletap";
			level.perk_machine[3].state = 0;
			level.perk_machine[3].repaired = 5;
			level.perk_machine[3] setModel( "zombie_vending_doubletap" );
			level.perk_machineCount = level.perk_machine.size;
		break;
	}
}

trigger_setup()
{
	if( isDefined( level.perk_machine ) )
	{
		for( i = 0; i < level.perk_machineCount; i++ )
		{
			level.perk_trigger[0] = spawn("trigger_radius",(0,0,0),1,35,64);
			level.perk_trigger[0].origin = level.perk_machine[0].origin;
			level.perk_trigger[0].angles = level.perk_machine[0].angles;
			level.perk_trigger[0].targetname = "zombie_vending";
			level.perk_trigger[0].script_noteworthy = "specialty_quickrevive";

			level.perk_trigger[1] = spawn("trigger_radius",(0,0,0),1,35,64);
			level.perk_trigger[1].origin = level.perk_machine[1].origin;
			level.perk_trigger[1].angles = level.perk_machine[1].angles;
			level.perk_trigger[1].targetname = "zombie_vending";
			level.perk_trigger[1].script_noteworthy = "specialty_fastreload";
		
			level.perk_trigger[2] = spawn("trigger_radius",(0,0,0),1,35,64);
			level.perk_trigger[2].origin = level.perk_machine[2].origin;
			level.perk_trigger[2].angles = level.perk_machine[2].angles;
			level.perk_trigger[2].targetname = "zombie_vending";
			level.perk_trigger[2].script_noteworthy = "specialty_armorvest";

			level.perk_trigger[3] = spawn("trigger_radius",(0,0,0),1,34,64);
			level.perk_trigger[3].origin = level.perk_machine[3].origin +(-5,0,0);
			level.perk_trigger[3].angles = level.perk_machine[3].angles;
			level.perk_trigger[3].targetname = "zombie_vending";
			level.perk_trigger[3].script_noteworthy = "specialty_rof";
		
			level.perk_trigger[i] thread repair_think(level.perk_machine[i]);
		
			level.perk_clip[0] = spawnCollision("collision_geo_64x64x128","collider",level.perk_machine[i].origin+(0,0,35),(0,0,0));
			level.perk_clip[0].origin = level.perk_machine[0].origin;
			level.perk_clip[0].angles = level.perk_machine[0].angles;
			
			level.perk_clip[1] = spawnCollision("collision_geo_64x64x128","collider",level.perk_machine[i].origin+(0,0,35),(0,0,0));
			level.perk_clip[1].origin = level.perk_machine[1].origin;
			level.perk_clip[1].angles = level.perk_machine[1].angles;
			
			level.perk_clip[2] = spawnCollision("collision_geo_64x64x128","collider",level.perk_machine[i].origin+(0,0,35),(0,0,0));
			level.perk_clip[2].origin = level.perk_machine[2].origin;
			level.perk_clip[2].angles = level.perk_machine[2].angles;
			
			level.perk_clip[3] = spawnCollision("collision_geo_64x64x128","collider",level.perk_machine[i].origin+(13,0,35),(0,0,0));
			level.perk_clip[3].origin = level.perk_machine[3].origin;
			level.perk_clip[3].angles = level.perk_machine[3].angles;
		}
	}	
}

repair_think(m)
{
	if(m.state >= m.repaired)
	{
		return;
	}
	
	while(1)
	{
		self waittill("trigger",player);
		if(!player useButtonPressed())
		{
			continue;
		}
		
		if(isDefined(player) && player.class_picked == "engineer_1" && player useButtonPressed())
		{
			wait(1);
			m.state++;
			
			if(m.state >= m.repaired)
			{
				switch(self.script_noteworthy)
				{
					case "specialty_rof":
						level notify("doubletap_on");
						break;
					case "specialty_armorvest":
						level notify("juggernog_on");
						break;
					case "specialty_fastreload":
						level notify("sleight_on");
						break;
					case "specialty_quickrevive":
						level notify("revive_on");
						break;
				}
				self thread vending_trigger_think();
				return;
			}
		}
	}
}
					
turn_sleight_on()
{
	machine = getentarray("vending_sleight", "targetname");
	level waittill("sleight_on");

	for( i = 0; i < machine.size; i++ )
	{
		machine[i] setmodel("zombie_vending_sleight_on");
		machine[i] vibrate((0,-100,0), 0.3, 0.4, 3);
		//machine[i] playsound("perks_power_on");
		machine[i] thread perk_fx( "sleight_light" );
	}

	level notify( "specialty_fastreload_power_on" );
}

turn_revive_on()
{
	machine = getentarray("vending_revive", "targetname");
	level waittill("revive_on");


	for( i = 0; i < machine.size; i++ )
	{
		machine[i] setmodel("zombie_vending_revive_on");
		//machine[i] playsound("perks_power_on");
		machine[i] vibrate((0,-100,0), 0.3, 0.4, 3);
		machine[i] thread perk_fx( "revive_light" );
	}
	
	level notify( "specialty_quickrevive_power_on" );
}

turn_jugger_on()
{
	machine = getentarray("vending_jugg", "targetname");
	level waittill("juggernog_on");

	for( i = 0; i < machine.size; i++ )
	{
		machine[i] setmodel("zombie_vending_jugg_on");
		machine[i] vibrate((0,-100,0), 0.3, 0.4, 3);
		//machine[i] playsound("perks_power_on");
		machine[i] thread perk_fx( "jugger_light" );
		
	}
	level notify( "specialty_armorvest_power_on" );
}

turn_doubletap_on()
{
	machine = getentarray("vending_doubletap", "targetname");
	level waittill("doubletap_on");
	
	for( i = 0; i < machine.size; i++ )
	{
		machine[i] setmodel("zombie_vending_doubletap_on");
		machine[i] vibrate((0,-100,0), 0.3, 0.4, 3);
		//machine[i] playsound("perks_power_on");
		machine[i] thread perk_fx( "doubletap_light" );
	}
	level notify( "specialty_rof_power_on" );
}

perk_fx( fx )
{
	wait(3);
	playfxontag( level._effect[ fx ], self, "tag_origin" );
}
				
vending_trigger_think()
{
	perk = self.script_noteworthy;

	self SetCursorHint( "HINT_NOICON" );
	self UseTriggerRequireLookAt();

	notify_name = perk + "_power_on";
	level waittill( notify_name );

	perk_hum = spawn("script_origin", self.origin);
	//perk_hum playloopsound("perks_machine_loop");

	wait(2);

	self thread check_player_has_perk(perk);
	
	self vending_set_hintstring(perk);
	
	for( ;; )
	{
		self waittill( "trigger", player );
	
		if( !player useButtonPressed() )
		{
			continue;
		}
		
		index = maps\_zombiemode_weapons_prototype::get_player_index(player);
		
		cost = level.zombie_vars["zombie_perk_cost"];
		switch( perk )
		{
		case "specialty_armorvest":
			cost = 2500;
			break;

		case "specialty_quickrevive":
			cost = 1500;
			break;

		case "specialty_fastreload":
			cost = 3000;
			break;

		case "specialty_rof":
			cost = 2000;
			break;

		}

		if (player maps\_laststand::player_is_in_laststand() )
		{
			continue;
		}

		if(player in_revive_trigger())
		{
			continue;
		}
		
		if( player isThrowingGrenade() )
		{
			wait( 0.1 );
			continue;
		}
		
		if( player isSwitchingWeapons() )
		{
			wait(0.1);
			continue;
		}

		if ( player HasPerk( perk ) )
		{
			cheat = false;

			/#
			if ( GetDVarInt( "zombie_cheat" ) >= 5 )
			{
				cheat = true;
			}
			#/

			if ( cheat != true )
			{
				//player iprintln( "Already using Perk: " + perk );
				self playsound("deny");
				//player thread play_no_money_perk_dialog();

				
				continue;
			}
		}

		if ( player.score < cost )
		{
			self playsound("deny");
			continue;
		}

		//sound = "bottle_dispense3d";
		//playsoundatposition(sound, self.origin);
		player maps\_zombiemode_score::minus_to_player_score( cost ); 
		///bottle_dispense
		switch( perk )
		{
		case "specialty_armorvest":
			sound = "mx_jugger_sting";
			break;

		case "specialty_quickrevive":
			sound = "mx_revive_sting";
			break;

		case "specialty_fastreload":
			sound = "mx_speed_sting";
			break;

		case "specialty_rof":
			sound = "mx_doubletap_sting";
			break;

		default:
			sound = "mx_jugger_sting";
			break;
		}

		//self thread play_vendor_stings(sound);
	
		//		self waittill("sound_done");


		// do the drink animation
		gun = player perk_give_bottle_begin( perk );
		player.is_drinking = 1;
		player waittill_any( "fake_death", "death", "player_downed", "weapon_change_complete" );

		// restore player controls and movement
		player perk_give_bottle_end( gun, perk );
		player.is_drinking = undefined;
		// TODO: race condition?
		if ( player maps\_laststand::player_is_in_laststand() )
		{
			continue;
		}

		player SetPerk( perk );
		player setblur( 4, 0.1 );
		wait(0.1);
		player setblur(0, 0.1);
		if(perk == "specialty_armorvest")
		{
			player.maxhealth = 160;
			player.health = 160;
		}

		player perk_hud_create( perk );
		player.stats["perks"]++;
		player thread perk_think( perk );

	}
}

check_player_has_perk(perk)
{
	/#
		if ( GetDVarInt( "zombie_cheat" ) >= 5 )
		{
			return;
		}
#/

		dist = 128 * 128;
		while(true)
		{
			players = get_players();
			for( i = 0; i < players.size; i++ )
			{
				if(DistanceSquared( players[i].origin, self.origin ) < dist)
				{
					if(!players[i] hasperk(perk) && !(players[i] in_revive_trigger()))
					{
						//PI CHANGE: this change makes it so that if there are multiple players within the trigger for the perk machine, the hint string is still 
						//                   visible to all of them, rather than the last player this check is done for
						if (IsDefined(level.script) && level.script == "nazi_zombie_theater")
							self setinvisibletoplayer(players[i], false);
						else
							self setvisibletoplayer(players[i]);
						//END PI CHANGE
						//iprintlnbold("turn it off to player");

					}
					else
					{
						self SetInvisibleToPlayer(players[i]);
						//iprintlnbold(players[i].health);
					}
				}


			}

			wait(0.1);

		}

}


vending_set_hintstring( perk )
{
	switch( perk )
	{

	case "specialty_armorvest":
		self SetHintString( "Press & hold &&1 to buy Jugger-Nog [Cost: 2500]" );
		break;

	case "specialty_quickrevive":
		self SetHintString( "Press & hold &&1 to buy Revive [Cost: 1500]" );
		break;

	case "specialty_fastreload":
		self SetHintString( "Press & hold &&1 to buy Speed Cola [Cost: 3000]" );
		break;

	case "specialty_rof":
		self SetHintString( "Press & hold &&1 to buy Double Tap Root Beer [Cost: 2000]" );
		break;

	default:
		self SetHintString( perk + " Cost: " + level.zombie_vars["zombie_perk_cost"] );
		break;

	}
}


perk_think( perk )
{
	/#
		if ( GetDVarInt( "zombie_cheat" ) >= 5 )
		{
			if ( IsDefined( self.perk_hud[ perk ] ) )
			{
				return;
			}
		}
#/

		self waittill_any( "fake_death", "death", "player_downed" );

		self UnsetPerk( perk );
		self.maxhealth = 100;
		self.health = 100;
		self setclientDvar( "g_speed", "190" );
		
		all_weap = self getweaponslistprimaries();
		if( all_weap.size > 2 )
		{
			self takeWeapon( all_weap[2] );
		}
		
		self perk_hud_destroy( perk );
}

perk_hud_create( perk )
{
	if ( !IsDefined( self.perk_hud ) )
	{
		self.perk_hud = [];
	}


		shader = "";

		switch( perk )
		{
		case "specialty_armorvest":
			shader = "specialty_armorvest";
			break;

		case "specialty_quickrevive":
			shader = "specialty_quickrevive_zombies";
			break;

		case "specialty_fastreload":
			shader = "specialty_fastreload";
			break;

		case "specialty_rof":
			shader = "specialty_rof";
			break;
		
		case "specialty_longersprint":
			shader = "specialty_longersprint";
			break;

		case "specialty_bulletdamage":
			shader = "specialty_bulletdamage";
			break;
			
		case "specialty_twoprimaries":
			shader = "specialty_twoprimaries";
			break;

		default:
			shader = "";
			break;
		}

		hud = create_simple_hud( self );
		hud.foreground = true; 
		hud.sort = 1; 
		hud.hidewheninmenu = false; 
		hud.alignX = "center";
		hud.alignY = "middle";
		hud.horzalign = "center";
		hud.vertalign = "middle";
		hud SetShader( shader, 36, 36 );
		wait(0.5);
		hud moveovertime(1);
		hud scaleovertime( 0.5, 24, 24);
		hud.x -= 305; 
		hud.y -= self.perk_hud.size * 30 - 150; 
		hud.alpha = 1;

		self.perk_hud[ perk ] = hud;
}


perk_hud_destroy( perk )
{
	self.perk_hud[ perk ] destroy_hud();
	self.perk_hud[ perk ] = undefined;
}

perk_give_bottle_begin( perk )
{
	self DisableOffhandWeapons();
	self DisableWeaponCycling();

	self AllowLean( false );
	self AllowAds( false );
	self AllowSprint( false );
	self AllowProne( false );		
	self AllowMelee( false );

	wait( 0.05 );

	if ( self GetStance() == "prone" )
	{
		self SetStance( "crouch" );
	}

	gun = self GetCurrentWeapon();
	weapon = "";

	switch( perk )
	{
	case "specialty_armorvest":
		weapon = "zombie_perk_bottle_jugg";
		break;

	case "specialty_quickrevive":
		weapon = "zombie_perk_bottle_revive";
		break;

	case "specialty_fastreload":
		weapon = "zombie_perk_bottle_sleight";
		break;

	case "specialty_rof":
		weapon = "zombie_perk_bottle_doubletap";
		break;
	}

	self GiveWeapon( weapon );
	self SwitchToWeapon( weapon );

	return gun;
}


perk_give_bottle_end( gun, perk )
{
	assert( gun != "zombie_perk_bottle_doubletap" );
	assert( gun != "zombie_perk_bottle_revive" );
	assert( gun != "zombie_perk_bottle_jugg" );
	assert( gun != "zombie_perk_bottle_sleight" );
	assert( gun != "zombie_perk_bottle_extreme" );
	assert( gun != "zombie_perk_bottle_stop" );
	assert( gun != "syrette" );

	self EnableOffhandWeapons();
	self EnableWeaponCycling();

	self AllowLean( true );
	self AllowAds( true );
	self AllowSprint( true );
	self AllowProne( true );		
	self AllowMelee( true );
	weapon = "";
	switch( perk )
	{
	case "specialty_armorvest":
		weapon = "zombie_perk_bottle_jugg";
		break;

	case "specialty_quickrevive":
		weapon = "zombie_perk_bottle_revive";
		break;

	case "specialty_fastreload":
		weapon = "zombie_perk_bottle_sleight";
		break;

	case "specialty_rof":
		weapon = "zombie_perk_bottle_doubletap";
		break;
	}

	// TODO: race condition?
	if ( self maps\_laststand::player_is_in_laststand() )
	{
		self TakeWeapon(weapon);
		return;
	}

	if ( gun != "none" && gun != "mine_bouncing_betty" )
	{
		self SwitchToWeapon( gun );
	}
	else 
	{
		// try to switch to first primary weapon
		primaryWeapons = self GetWeaponsListPrimaries();
		if( IsDefined( primaryWeapons ) && primaryWeapons.size > 0 )
		{
			self SwitchToWeapon( primaryWeapons[0] );
		}
	}

	self TakeWeapon(weapon);
}

machine_watcher()
{	
	level waittill("master_switch_activated");	
}

play_vendor_stings(sound)
{	
	if(!IsDefined (level.speed_jingle))
	{
		level.speed_jingle = 0;
	}
	if(!IsDefined (level.revive_jingle))
	{
		level.revive_jingle = 0;
	}
	if(!IsDefined (level.doubletap_jingle))
	{
		level.doubletap_jingle = 0;
	}
	if(!IsDefined (level.jugger_jingle))
	{
		level.jugger_jingle = 0;
	}
	if(!IsDefined (level.packa_jingle))
	{
		level.packa_jingle = 0;
	}
	if(!IsDefined (level.eggs))
	{
		level.eggs = 0;
	}
	if (level.eggs == 0)
	{
		if(sound == "mx_speed_sting" && level.speed_jingle == 0 ) 
		{
//			iprintlnbold("stinger speed:" + level.speed_jingle);
			level.speed_jingle = 1;		
			temp_org_speed_s = spawn("script_origin", self.origin);		
			temp_org_speed_s playsound (sound, "sound_done");
			temp_org_speed_s waittill("sound_done");
			level.speed_jingle = 0;
			temp_org_speed_s delete();
//			iprintlnbold("stinger speed:" + level.speed_jingle);
		}
		else if(sound == "mx_revive_sting" && level.revive_jingle == 0)
		{
			level.revive_jingle = 1;
//			iprintlnbold("stinger revive:" + level.revive_jingle);
			temp_org_revive_s = spawn("script_origin", self.origin);		
			temp_org_revive_s playsound (sound, "sound_done");
			temp_org_revive_s waittill("sound_done");
			level.revive_jingle = 0;
			temp_org_revive_s delete();
//			iprintlnbold("stinger revive:" + level.revive_jingle);
		}
		else if(sound == "mx_doubletap_sting" && level.doubletap_jingle == 0) 
		{
			level.doubletap_jingle = 1;
//			iprintlnbold("stinger double:" + level.doubletap_jingle);
			temp_org_dp_s = spawn("script_origin", self.origin);		
			temp_org_dp_s playsound (sound, "sound_done");
			temp_org_dp_s waittill("sound_done");
			level.doubletap_jingle = 0;
			temp_org_dp_s delete();
//			iprintlnbold("stinger double:" + level.doubletap_jingle);
		}
		else if(sound == "mx_jugger_sting" && level.jugger_jingle == 0) 
		{
			level.jugger_jingle = 1;
//			iprintlnbold("stinger juggernog" + level.jugger_jingle);
			temp_org_jugs_s = spawn("script_origin", self.origin);		
			temp_org_jugs_s playsound (sound, "sound_done");
			temp_org_jugs_s waittill("sound_done");
			level.jugger_jingle = 0;
			temp_org_jugs_s delete();
//			iprintlnbold("stinger juggernog:"  + level.jugger_jingle);
		}
		else if(sound == "mx_packa_sting" && level.packa_jingle == 0) 
		{
			level.packa_jingle = 1;
//			iprintlnbold("stinger packapunch:" + level.packa_jingle);
			temp_org_pack_s = spawn("script_origin", self.origin);		
			temp_org_pack_s playsound (sound, "sound_done");
			temp_org_pack_s waittill("sound_done");
			level.packa_jingle = 0;
			temp_org_pack_s delete();
//			iprintlnbold("stinger packapunch:"  + level.packa_jingle);
		}
	}
}

perks_a_cola_jingle()
{	
	//self thread play_random_broken_sounds();
	if(!IsDefined(self.perk_jingle_playing))
	{
		self.perk_jingle_playing = 0;
	}
	if (!IsDefined (level.eggs))
	{
		level.eggs = 0;
	}
	while(1)
	{
		//wait(randomfloatrange(60, 120));
		wait(randomfloatrange(31,45));
		if(randomint(100) < 15 && level.eggs == 0)
		{
			level notify ("jingle_playing");
			//playfx (level._effect["electric_short_oneshot"], self.origin);
			//playsoundatposition ("electrical_surge", self.origin);
			
			if(self.script_sound == "mx_speed_jingle" && level.speed_jingle == 0) 
			{
				level.speed_jingle = 1;
				temp_org_speed = spawn("script_origin", self.origin);
				wait(0.05);
				temp_org_speed playsound (self.script_sound, "sound_done");
				temp_org_speed waittill("sound_done");
				level.speed_jingle = 0;
				temp_org_speed delete();
			}
			if(self.script_sound == "mx_revive_jingle" && level.revive_jingle == 0) 
			{
				level.revive_jingle = 1;
				temp_org_revive = spawn("script_origin", self.origin);
				wait(0.05);
				temp_org_revive playsound (self.script_sound, "sound_done");
				temp_org_revive waittill("sound_done");
				level.revive_jingle = 0;
				temp_org_revive delete();
			}
			if(self.script_sound == "mx_doubletap_jingle" && level.doubletap_jingle == 0) 
			{
				level.doubletap_jingle = 1;
				temp_org_doubletap = spawn("script_origin", self.origin);
				wait(0.05);
				temp_org_doubletap playsound (self.script_sound, "sound_done");
				temp_org_doubletap waittill("sound_done");
				level.doubletap_jingle = 0;
				temp_org_doubletap delete();
			}
			if(self.script_sound == "mx_jugger_jingle" && level.jugger_jingle == 0) 
			{
				level.jugger_jingle = 1;
				temp_org_jugger = spawn("script_origin", self.origin);
				wait(0.05);
				temp_org_jugger playsound (self.script_sound, "sound_done");
				temp_org_jugger waittill("sound_done");
				level.jugger_jingle = 0;
				temp_org_jugger delete();
			}
			if(self.script_sound == "mx_packa_jingle" && level.packa_jingle == 0) 
			{
				level.packa_jingle = 1;
				temp_org_packa = spawn("script_origin", self.origin);
				temp_org_packa playsound (self.script_sound, "sound_done");
				temp_org_packa waittill("sound_done");
				level.packa_jingle = 0;
				temp_org_packa delete();
			}

			//self thread play_random_broken_sounds();
		}		
	}	
}
play_random_broken_sounds()
{
	level endon ("jingle_playing");
	if (!isdefined (self.script_sound))
	{
		self.script_sound = "null";
	}
	if (self.script_sound == "mx_revive_jingle")
	{
		while(1)
		{
			wait(randomfloatrange(7, 18));
			playsoundatposition ("broken_random_jingle", self.origin);
		//playfx (level._effect["electric_short_oneshot"], self.origin);
			playsoundatposition ("electrical_surge", self.origin);
	
		}
	}
	else
	{
		while(1)
		{
			wait(randomfloatrange(7, 18));
		// playfx (level._effect["electric_short_oneshot"], self.origin);
			playsoundatposition ("electrical_surge", self.origin);
		}
	}
}

set_perk( perk )
{
	time = RandomIntRange( 30, 60 );

	self SetPerk( perk );
	self setblur( 4, 0.1 );
	wait(0.1);
	self setblur(0, 0.1);

	if(perk == "specialty_armorvest")
	{
		self.maxhealth = 160;
		self.health = 160;
	}
	
	if(perk == "specialty_longersprint")
	{
		self setClientDvar("g_speed",getDvarInt("g_speed")+25);
	}

	self perk_hud_create( perk );
	self thread perk_think( perk );
}