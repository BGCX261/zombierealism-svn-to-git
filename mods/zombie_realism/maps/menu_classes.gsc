#include maps\_utility; 
#include common_scripts\utility;
#include maps\_zombiemode_utility;

#include maps\_rampage_loadout;
#include maps\_rampage_class;

menu_class_response()
{
	while(1)
	{
		self waittill("menuresponse",menu,response);
	
//******************************************************** CLASS SELECTION ********************************************************//
		if(menu == game["classmenu"])
		{
			switch(response)
			{
				case "support":
					if(level.support_size < 1)
					{
						self.class_picked = "support_1";
						self.old_class = "support_1";
					}
					else
					{
						setDvar ("support_locked", "1");
						self openMenu(game["classmenu"]);
						self thread menu_class_response();
					}
					break;
				case "soldier":
					if(level.soldier_size < 1)
					{
						self.class_picked = "soldier_1";
						self.old_class = "soldier_1";
					}
					else
					{
						setDvar ("soldier_locked", "1");
						self openMenu(game["classmenu"]);
						self thread menu_class_response();
					}
					break;
				case "engineer":
					if(level.engineer_size < 1)
					{
						self.class_picked = "engineer_1";
						self.old_class = "engineer_1";
					}
					else
					{
						setDvar ("engineer_locked", "1");
						self openMenu(game["classmenu"]);
						self thread menu_class_response();
					}
					break;
				case "medic":
					if(level.medic_size < 1)
					{
						self.class_picked = "medic_1";
						self.old_class = "medic_1";
					}
					else
					{
						setDvar ("medic_locked", "1");
						self openMenu(game["classmenu"]);
						self thread menu_class_response();
					}
					break;
				case "custom":
					self.class_picked = "custom";
					self.old_class = "custom";
					break;
			}
		}
		
		if(menu == game["kit_support"])
		{
			if(response == "accept")
			{
				if(self.class_picked != "")
				{
					self set_loadout(self.class_picked);
					level notify( "game_is_ready" );
					level.support_size += 1;
					level.ready_players += 1;
				}
			}
					
			if(response == "cancel")
			{
				if(self.old_class == "support_1" || self.old_class == "support_2" || 	self.old_class == "support_3")
				{
					if(level.support_size > 0)
						level.support_size -= 1;
				}
					
				if(self.old_class == "soldier_1" || self.old_class == "soldier_2" || 	self.old_class == "soldier_3")
				{
					if(level.soldier_size > 0)
						level.soldier_size -= 1;
				}
					
				if(self.old_class == "engineer_1" || self.old_class == "engineer_2" || 	self.old_class == "engineer_3")
				{
					if(level.engineer_size > 0)
						level.engineer_size -= 1;
				}
					
				if(self.old_class == "medic_1" || self.old_class == "medic_2" || 	self.old_class == "medic_3")
				{
					if(level.medic_size > 0)
						level.medic_size -= 1;
				}
			}
		}
		
		if(menu == game["kit_soldier"])
		{
			if(response == "accept")
			{
				if(self.class_picked != "")
				{
					set_model(self.class_picked);
					self set_loadout(self.class_picked);
					level notify( "game_is_ready" );
					level.soldier_size += 1;
					level.ready_players += 1;
				}
			}
					
			if(response == "cancel")
			{
				if(self.old_class == "support_1" || self.old_class == "support_2" || 	self.old_class == "support_3")
				{
					if(level.support_size > 0)
						level.support_size -= 1;
				}
					
				if(self.old_class == "soldier_1" || self.old_class == "soldier_2" || 	self.old_class == "soldier_3")
				{
					if(level.soldier_size > 0)
						level.soldier_size -= 1;
				}
					
				if(self.old_class == "engineer_1" || self.old_class == "engineer_2" || 	self.old_class == "engineer_3")
				{
					if(level.engineer_size > 0)
						level.engineer_size -= 1;
				}
					
				if(self.old_class == "medic_1" || self.old_class == "medic_2" || 	self.old_class == "medic_3")
				{
					if(level.medic_size > 0)
						level.medic_size -= 1;
				}
			}
		}
		
		if(menu == game["kit_engineer"])
		{
			if(response == "accept")
			{
				if(self.class_picked != "")
				{
					set_model(self.class_picked);
					self set_loadout(self.class_picked);
					level notify( "game_is_ready" );
					level.medic_size += 1;
					level.ready_players += 1;
				}
			}
					
			if(response == "cancel")
			{
				if(self.old_class == "support_1" || self.old_class == "support_2" || 	self.old_class == "support_3")
				{
					if(level.support_size > 0)
						level.support_size -= 1;
				}
					
				if(self.old_class == "soldier_1" || self.old_class == "soldier_2" || 	self.old_class == "soldier_3")
				{
					if(level.soldier_size > 0)
						level.soldier_size -= 1;
				}
					
				if(self.old_class == "engineer_1" || self.old_class == "engineer_2" || 	self.old_class == "engineer_3")
				{
					if(level.engineer_size > 0)
						level.engineer_size -= 1;
				}
					
				if(self.old_class == "medic_1" || self.old_class == "medic_2" || 	self.old_class == "medic_3")
				{
					if(level.medic_size > 0)
						level.medic_size -= 1;
				}
			}
		}
		
		if(menu == game["kit_medic"])
		{
			if(response == "accept")
			{
				if(self.class_picked != "")
				{
					set_model(self.class_picked);
					self set_loadout(self.class_picked);
					level notify( "game_is_ready" );
					level.medic_size += 1;
					level.ready_players += 1;
				}
			}
					
			if(response == "cancel")
			{
				if(self.old_class == "support_1" || self.old_class == "support_2" || 	self.old_class == "support_3")
				{
					if(level.support_size > 0)
						level.support_size -= 1;
				}
					
				if(self.old_class == "soldier_1" || self.old_class == "soldier_2" || 	self.old_class == "soldier_3")
				{
					if(level.soldier_size > 0)
						level.soldier_size -= 1;
				}
					
				if(self.old_class == "engineer_1" || self.old_class == "engineer_2" || 	self.old_class == "engineer_3")
				{
					if(level.engineer_size > 0)
						level.engineer_size -= 1;
				}
					
				if(self.old_class == "medic_1" || self.old_class == "medic_2" || 	self.old_class == "medic_3")
				{
					if(level.medic_size > 0)
						level.medic_size -= 1;
				}
			}
		}
		
		if(menu == game["kit_custom"])
		{
			if(response == "accept")
			{
				if(self.class_picked != "")
				{
					set_model(self.class_picked);
					self set_loadout(self.class_picked);
					level notify( "game_is_ready" );
					level.ready_players += 1;
				}
			}
					
			if(response == "cancel")
			{
			}
		}
		
//******************************************************** GRENADE SEC ********************************************************//		
		if(menu == game["w_grenade_secondary"])
		{
			if(response != "accept" && response != "cancel" && response != "")
			{
				self.grenade_secondary = response;
			}
		}
		
//******************************************************** PERK 1 ********************************************************//		
		if(menu == game["w_perk1"])
		{
			if(response != "accept" && response != "cancel" && response != "")
			{
				self.perk1 = response;
			}
			
			if(response == "none")
			{
				self.perk1 = "";
			}
		}
//******************************************************** PERK 2 ********************************************************//		
		if(menu == game["w_perk2"])
		{
			if(response != "accept" && response != "cancel" && response != "")
			{
				self.perk2 = response;
			}
			
			if(response == "none")
			{
				self.perk2 = "";
			}
		}
//******************************************************** PERK 3 ********************************************************//		
		if(menu == game["w_perk3"])
		{
			if(response != "accept" && response != "cancel" && response != "")
			{
				self.perk3 = response;
			}

			if(response == "none")
			{
				self.perk3 = "";
			}
		}
		
//******************************************************** BOLT WEAPONS ********************************************************//		
		if(menu == game["w_bolt"])
		{
			if(response != "accept" && response != "cancel" && response != "")
			{
				self.gun_primary = response;
			}
		}
		
//******************************************************** MACHINE GUNS ********************************************************//		
		if(menu == game["w_mg"])
		{
			if(response != "accept" && response != "cancel" && response != "")
			{
				self.gun_primary = response;
			}
		}
		
//******************************************************** RIFLES ********************************************************//		
		if(menu == game["w_rifle"])
		{
			if(response != "accept" && response != "cancel" && response != "")
			{
				self.gun_primary = response;
			}
		}
		
//******************************************************** SUBMACHINE GUNS********************************************************//		
		if(menu == game["w_sub"])
		{
			if(response != "accept" && response != "cancel" && response != "")
			{
				self.gun_primary = response;
			}
		}
		
//******************************************************** SHOTGUNS ********************************************************//		
		if(menu == game["w_shot"])
		{
			if(response != "accept" && response != "cancel" && response != "")
			{
				self.gun_primary = response;
			}
		}
		
//******************************************************** PISTOLS ********************************************************//		
		if(menu == game["w_pistol"])
		{
			if(response != "accept" && response != "cancel" && response != "")
			{
				self.gun_secondary = response;
			}
		}
		
//******************************************************** BOLT ATTACHMENTS ********************************************************//	
		if(menu == game["w_bolt_attachments"])
		{
			if(response != "" && response != "accept" && response != "cancel")
			{
				if(response == "none")
				{
					self.weapon_attachment = "";
				}
				
				if(response == "bayonet")
				{
					self.weapon_attachment = "bayonet";
				}
				
				if(response == "scope")
				{
					self.weapon_attachment = "scoped_zombie";
				}
			}
					
			if(response == "cancel")
			{
				self.weapon_attachment = undefined;
			}
		}

//******************************************************** SHOTGUN ATTACHMENTS ********************************************************//	
		if(menu == game["w_shot_attachments"])
		{
			if(response != "" && response != "accept" && response != "cancel")
			{
				if(response == "none")
				{
					self.weapon_attachment = "";
				}
				
				if(response == "sawed_grip")
				{
					self.weapon_attachment = "sawed_grip";
				}
			}
					
			if(response == "cancel")
			{
				self.weapon_attachment = undefined;
			}
		}
		
//******************************************************** SHOTGUN ATTACHMENTS 2********************************************************//	
		if(menu == game["w_bolt_attachments2"])
		{
			if(response != "" && response != "accept" && response != "cancel")
			{
				if(response == "none")
				{
					self.weapon_attachment = "";
				}
				
				if(response == "grip")
				{
					self.weapon_attachment = "grip";
				}
			}
					
			if(response == "cancel")
			{
				self.weapon_attachment = undefined;
			}
		}
		
//******************************************************** RIFLE ATTACHMENTS ********************************************************//	
		if(menu == game["w_rifle_attachments"])
		{
			if(response != "" && response != "accept" && response != "cancel")
			{
				if(response == "none")
				{
					self.weapon_attachment = "";
				}
				
				if(response == "aperture")
				{
					self.weapon_attachment = "aperture";
				}
				
				if(response == "telescopic")
				{
					self.weapon_attachment = "telescopic";
				}
			}
					
			if(response == "cancel")
			{
				self.weapon_attachment = undefined;
			}
		}
		
//******************************************************** RIFLE ATTACHMENTS 2 ********************************************************//	
		if(menu == game["w_rifle_attachments2"])
		{
			if(response != "" && response != "accept" && response != "cancel")
			{
				if(response == "none")
				{
					self.weapon_attachment = "";
				}
				
				if(response == "aperture")
				{
					self.weapon_attachment = "aperture";
				}
				
				if(response == "bigammo")
				{
					self.weapon_attachment = "bigammo";
				}
			}
					
			if(response == "cancel")
			{
				self.weapon_attachment = undefined;
			}
		}
		
//******************************************************** RIFLE ATTACHMENTS 3 ********************************************************//	
		if(menu == game["w_rifle_attachments3"])
		{
			if(response != "" && response != "accept" && response != "cancel")
			{
				if(response == "none")
				{
					self.weapon_attachment = "";
				}
				
				if(response == "bayonet")
				{
					self.weapon_attachment = "bayonet";
				}
				
				if(response == "gl")
				{
					self.weapon_attachment = "gl";
				}
				
				if(response == "scope")
				{
					self.weapon_attachment = "scoped_zombie";
				}
			}
					
			if(response == "cancel")
			{
				self.weapon_attachment = undefined;
			}
		}
		wait(0.05);
	}
}

set_model(class)
{
	switch(class)
	{
		case "support_1":
			self detachAll();
			character\char_rus_guard_player_hmg::main();
		break;
	
		case "medic_1":
			self detachAll();
			character\char_usa_raider_player_assault::main();
		break;
	
		case "engineer_1":
			self detachAll();
			character\char_zomb_player_1::main();
		break;
	
		case "soldier_1":
			self detachAll();
			character\char_zomb_player_3::main();
		break;
	
		case "custom":
			self detachAll();
			character\char_zomb_player_1::main();
		break;
	}
}