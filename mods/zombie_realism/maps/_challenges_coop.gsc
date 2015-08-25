#include maps\_utility;
#include maps\_rampage_util;

//-------------------------------------------------------------------------------------------
// below is from _mission.gsc from MP
//-------------------------------------------------------------------------------------------


init()
{
	if(!level.ranks_on)
		return;
	
	// from _mission.gsc
	cac_init();
	class_init();
	rank_init();
	
	level.onlineGame = true;
	level.xpScale = 1;

	buildChallegeInfo();
	buildMPChallengeInfo();

	level thread onPlayerConnect();
	
	level.missionCallbacks = [];

	precacheString(&"CHALLENGE_COOP_COMPLETED");
	precacheString(&"CHALLENGE_MULTIPLE_COOP_COMPLETED");
	precacheString(&"CHALLENGE_MULTIPLE_COOP_COMPLETED_DETAILS");	

	registerMissionCallback( "actorKilled", ::ch_kills );	
	registerMissionCallback( "playerRevived", ::ch_revives );
	registerMissionCallback( "playerDied", ::ch_dies );
	//registerMissionCallback( "playerGib", ::ch_gib );
	registerMissionCallback( "levelEnd", ::ch_levelEnd );
	registerMissionCallback( "multiplierChanged", ::ch_multiplierChanged );
	registerMissionCallback( "checkpointLoaded", ::ch_checkpointLoaded );
	registerMissionCallback( "playerAssist", ::ch_assists );	

	//registerMissionCallback( "playerKilled", ::ch_vehicle_kills );
	//registerMissionCallback( "playerHardpoint", ::ch_hardpoints );
	//registerMissionCallback( "roundEnd", ::ch_roundwin );
	//registerMissionCallback( "roundEnd", ::ch_roundplayed );
}

mayGenerateAfterActionReport()
{	
	if(!level.ranks_on)
		return false;
	
	return true;
}

mayProcessChallenges()
{
	if(!level.ranks_on)
		return false;
	
	return true;
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill( "connected", player );

		player.rankxp = player statGet( "rankxp" );
		rankId = player getRankForXp( player getRankXP() );
		player.rank = rankId;
	
		prestige = player getPrestigeLevel();
		player setRank( rankId, prestige );
		player.prestige = prestige;

		// Setting Summary Variables to Zero
		player.summary_xp = 0;
		player.summary_challenge = 0;
		
		// resetting game summary dvars
		player setClientDvars( 	"psn", player.playername,
								"psx", "0",
								"pss", "0",
								"psc", "0",
								"psk", "0",
								"psd", "0",
								"psr", "0",
								"psh", "0", 
								"psa", "0",								
								"ui_lobbypopup", "summary");
		
		//"ui_lobbypopup", "summary"						
		// set default popup in lobby after a game finishes to game "summary"
		// if player got promoted during the game, we set it to "promotion"		

		player updateChallenges();
		player updateMPChallenges();

		ch_reset_alive_challenges( player );
		player thread ch_brassCollector();

		//player thread initMissionData();
		//player thread monitorBombUse();
		//player thread monitorSprintDistance();
		//player thread monitorFallDistance();
		//player thread monitorLiveTime();	
		//player thread monitorStreaks();

		/#
			//player thread challengeTest();
		#/
	}
}

onSaveRestored()
{
	if ( !mayProcessChallenges() )
		return;

	players = get_players();
	for( i = 0; i < players.size; i++)
	{
		players[i].rankxp = players[i] statGet( "rankxp" );
		rankId = players[i] getRankForXp( players[i] getRankXP() );
		players[i].rank = rankId;
	

		prestige = players[i] getPrestigeLevel();
		players[i] setRank( rankId, prestige );
		players[i].prestige = prestige;
		
		players[i] updateChallenges();
		players[i] updateMPChallenges();		
	}
}

createCacheSummary()
{
	self.cached_summary_xp = 0;
	self.cached_score = 0;
	self.cached_summary_challenge = 0;
	self.cached_kills =  0;
	self.cached_downs = 0;
	self.cached_assists = 0;
	self.cached_headshots = 0;
	self.cached_revives = 0;
	
	self.summary_cache_created = true;
}

buildSummaryArray()
{
	summaryArray = [];

	if(self.cached_summary_xp != self.summary_xp)
	{
		summaryArray[summaryArray.size] = "psx";
		summaryArray[summaryArray.size] = self.summary_xp;
		self.cached_summary_xp = self.summary_xp;
	}	

	if(self.cached_score != self.score)
	{
		summaryArray[summaryArray.size] = "pss";
		summaryArray[summaryArray.size] = self.score;
		self.cached_score = self.score;
	}
	
	if(self.cached_summary_challenge != self.summary_challenge)
	{
		summaryArray[summaryArray.size] = "psc";
		summaryArray[summaryArray.size] = self.summary_challenge;
		self.cached_summary_challenge = self.summary_challenge;
	}
	
	if(self.cached_downs != self.downs)
	{
		summaryArray[summaryArray.size] = "psd";
		summaryArray[summaryArray.size] = self.downs;
		self.cached_downs = self.downs;
	}

	if(self.cached_headshots != self.headshots)
	{
		summaryArray[summaryArray.size] = "psh";
		summaryArray[summaryArray.size] = self.headshots;
		self.cached_headshots = self.headshots;
	}

	if(self.cached_kills != self.kills - self.headshots)
	{
		summaryArray[summaryArray.size] = "psk";
		summaryArray[summaryArray.size] = self.kills - self.headshots;
		self.cached_kills = self.kills - self.headshots;
	}
	
	if(self.cached_revives != self.revives)
	{
		summaryArray[summaryArray.size] = "psr";
		summaryArray[summaryArray.size] = self.revives;
		self.cached_revives = self.revives;
	}
	
	if(self.cached_assists != self.assists)
	{
		summaryArray[summaryArray.size] = "psa";
		summaryArray[summaryArray.size] = self.assists;
		self.cached_assists = self.assists;
	}	
		
	return summaryArray;
}

updateMatchSummary( callback )
{
	forceUpdate = true;

	if( OkToSpawn() || forceUpdate )
	{
		if( !isdefined(self.summary_cache_created) || callback == "checkpointLoaded" )
		{
			self createCacheSummary();
		}
	
		summary = self buildSummaryArray();
		
		if(summary.size > 0)
		{
			switch(summary.size)	// Vile.
			{
				case 2:
					self setClientDvars(summary[0], summary[1]);
					break;
				case 4:
					self setClientDvars(summary[0], summary[1], summary[2], summary[3]);
					break;
				case 6:
					self setClientDvars(summary[0], summary[1], summary[2], summary[3], summary[4], summary[5]);
					break;
				case 8:
					self setClientDvars(summary[0], summary[1], summary[2], summary[3], summary[4], summary[5], summary[6], summary[7]);
					break;
				case 10:
					self setClientDvars(summary[0], summary[1], summary[2], summary[3], summary[4], summary[5], summary[6], summary[7], summary[8], summary[9]);
					break;
				case 12:
					self setClientDvars(summary[0], summary[1], summary[2], summary[3], summary[4], summary[5], summary[6], summary[7], summary[8], summary[9], summary[10], summary[11]);
					break;
				case 14:
					self setClientDvars(summary[0], summary[1], summary[2], summary[3], summary[4], summary[5], summary[6], summary[7], summary[8], summary[9], summary[10], summary[11], summary[12], summary[13]);
					break;
				case 16:
					self setClientDvars(summary[0], summary[1], summary[2], summary[3], summary[4], summary[5], summary[6], summary[7], summary[8], summary[9], summary[10], summary[11], summary[12], summary[13], summary[14], summary[15]);
					break;
				case 18:
					self setClientDvars(summary[0], summary[1], summary[2], summary[3], summary[4], summary[5], summary[6], summary[7], summary[8], summary[9], summary[10], summary[11], summary[12], summary[13], summary[14], summary[15], summary[16], summary[17]);
					break;
				default:
					assertex("Unexpected number of elements in summary array.");
			}
			
			println("*** Summary sent " + (summary.size / 2) + " elements.");
		}
		
	}
}


challengeTest()
{
	/*
	wait 10;
	challengeNotify( "testChallenge" );
	wait 5;

	realLevelScript = level.script;
	level.script = "mak";
	self processTourChallenges();
	level.script = "pel1";
	self processTourChallenges();
	level.script = "pel2";
	self processTourChallenges();
	level.script = "pel1a";
	self processTourChallenges();
	level.script = "pel1b";
	self processTourChallenges();
	level.script = "oki2";
	self processTourChallenges();
	level.script = "oki3";
	self processTourChallenges();

	wait 5;

	level.script = "see2";
	self processTourChallenges();
	level.script = "see1";
	self processTourChallenges();
	level.script = "ber1";
	self processTourChallenges();
	level.script = "ber2";
	self processTourChallenges();
	level.script = "ber3";
	self processTourChallenges();
	level.script = "ber3b";
	self processTourChallenges();

	level.script = realLevelScript;
	*/
}

registerMissionCallback(callback, func)
{
	if (!isdefined(level.missionCallbacks[callback]))
		level.missionCallbacks[callback] = [];
	level.missionCallbacks[callback][level.missionCallbacks[callback].size] = func;
}

getChallengeStatus( name )
{
//	return self getStat( int(tableLookup( statsTable, 7, name, 2 )) ); // too slow, instead we store the challenge status at the beginning of the game
	if ( isDefined( self.challengeData[name] ) )
		return self.challengeData[name];
	else
		return 0;
}

getChallengeLevels( baseName )
{
	if ( isDefined( level.challengeInfo[baseName] ) )
		return level.challengeInfo[baseName]["levels"];
		
	assertex( isDefined( level.challengeInfo[baseName + "1" ] ), "Challenge name " + baseName + " not found!" );
	
	return level.challengeInfo[baseName + "1"]["levels"];
}

challengeNotify( challengeName )
{
	notifyData = spawnStruct();
	notifyData.titleText = &"CHALLENGE_COOP_COMPLETED";
	notifyData.notifyText = challengeName;
	notifyData.sound = "mp_challenge_complete";
	
	self maps\_hud_message::notifyMessage( notifyData );
}

//-------------------------------------------------------------------------------------------
// below is from _rank.gsc from MP
//-------------------------------------------------------------------------------------------

// Initializations related to the ranks
rank_init()
{
	// Set up the lookup tables for fetching rank data
	level.rankTable = [];

	//level.maxRank = int(tableLookup( "mp/rankTable.csv", 0, "maxrank", 1 ));
	level.maxRank = 129;
	level.maxPrestige = int(tableLookup( "mp/rankIconTable.csv", 0, "maxprestige", 1 ));

	pId = 0;
	rId = 0;
	// Precaching the rank icons
	for ( pId = 0; pId <= level.maxPrestige; pId++ )
	{
		for ( rId = 0; rId <= level.maxRank; rId++ )
			precacheShader( tableLookup( "mp/rankIconTable.csv", 0, rId, pId+1 ) );
	}

	rankId = 0;
	rankName = tableLookup( "mp/ranktable.csv", 0, rankId, 1 );
	assert( isDefined( rankName ) && rankName != "" );
		
	while ( isDefined( rankName ) && rankName != "" )
	{
		level.rankTable[rankId][1] = tableLookup( "mp/ranktable.csv", 0, rankId, 1 );
		level.rankTable[rankId][2] = tableLookup( "mp/ranktable.csv", 0, rankId, 2 );
		level.rankTable[rankId][3] = tableLookup( "mp/ranktable.csv", 0, rankId, 3 );
		level.rankTable[rankId][7] = tableLookup( "mp/ranktable.csv", 0, rankId, 7 );

		rankId++;
		rankName = tableLookup( "mp/ranktable.csv", 0, rankId, 1 );		
	}

	level.numChallengeTiers	= 4;
	level.numChallengeTiersMP = 12;

	// Precaching the strings
	precacheString( &"RANK_PLAYER_WAS_PROMOTED_N" );
	precacheString( &"RANK_PLAYER_WAS_PROMOTED" );
	precacheString( &"RANK_PROMOTED" );
	precacheString( &"MP_PLUS" );
	precacheString( &"RANK_ROMANI" );
	precacheString( &"RANK_ROMANII" );
	precacheString( &"RANK_ROMANIII" );
}

// update copy of a challenges to be progressed this game, only at the start of the game
// challenges unlocked during the game will not be progressed on during that game session
updateChallenges()
{
	self.challengeData = [];
	for ( i = 1; i <= level.numChallengeTiers; i++ )
	{
		tableName = "mp/challengetable_tier"+i+".csv";

		idx = 1;
		// unlocks all the challenges in this tier
		for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
		{
			stat_num = tableLookup( tableName, 0, idx, 2 );
			if( isdefined( stat_num ) && stat_num != "" )
			{
				statVal = self getStat( int( stat_num ) );
				if( !statVal )
				{
					statVal = 1;
					self setStat( int( stat_num ), 1 );
				}
				
				refString = tableLookup( tableName, 0, idx, 7 );
				self.challengeData[refString] = statVal;
			}
		}
	}
}

buildChallegeInfo()
{
	level.challengeInfo = [];

	for ( i = 1; i <= level.numChallengeTiers; i++ )
	{
		tableName = "mp/challengetable_tier"+i+".csv";
		//tableName = "mp/challengetable_coop"+i+".csv";

		baseRef = "";

		// unlocks all the challenges in this tier
		for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
		{
			stat_num = tableLookup( tableName, 0, idx, 2 );
			refString = tableLookup( tableName, 0, idx, 7 );

			level.challengeInfo[refString] = [];
			level.challengeInfo[refString]["tier"] = i;
			level.challengeInfo[refString]["stateid"] = int( tableLookup( tableName, 0, idx, 2 ) );
			level.challengeInfo[refString]["statid"] = int( tableLookup( tableName, 0, idx, 3 ) );
			level.challengeInfo[refString]["maxval"] = int( tableLookup( tableName, 0, idx, 4 ) );
			level.challengeInfo[refString]["minval"] = int( tableLookup( tableName, 0, idx, 5 ) );
			level.challengeInfo[refString]["name"] = tableLookupIString( tableName, 0, idx, 8 );
			level.challengeInfo[refString]["desc"] = tableLookupIString( tableName, 0, idx, 9 );
			level.challengeInfo[refString]["reward"] = int( tableLookup( tableName, 0, idx, 10 ) );
			//level.challengeInfo[refString]["camo"] = tableLookup( tableName, 0, idx, 12 );
			//level.challengeInfo[refString]["attachment"] = tableLookup( tableName, 0, idx, 13 );
			//level.challengeInfo[refString]["group"] = tableLookup( tableName, 0, idx, 14 );

			precacheString( level.challengeInfo[refString]["name"] );

			if ( !int( level.challengeInfo[refString]["stateid"] ) )
			{
				level.challengeInfo[baseRef]["levels"]++;
				level.challengeInfo[refString]["stateid"] = level.challengeInfo[baseRef]["stateid"];
				level.challengeInfo[refString]["level"] = level.challengeInfo[baseRef]["levels"];
			}
			else
			{
				level.challengeInfo[refString]["levels"] = 1;
				level.challengeInfo[refString]["level"] = 1;
				baseRef = refString;
			}
		}
	}
}

buildMPChallengeInfo()
{
	level.challengeInfoMP = [];
	
	for ( i = 1; i <= level.numChallengeTiersMP; i++ )
	{
		tableName = "mp/challengetable_tier"+i+".csv";

		baseRef = "";
		// unlocks all the challenges in this tier
		for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
		{
			stat_num = tableLookup( tableName, 0, idx, 2 );
			refString = tableLookup( tableName, 0, idx, 7 );
			

			level.challengeInfoMP[refString] = [];
			level.challengeInfoMP[refString]["tier"] = i;
			level.challengeInfoMP[refString]["stateid"] = int( tableLookup( tableName, 0, idx, 2 ) );
			level.challengeInfoMP[refString]["statid"] = int( tableLookup( tableName, 0, idx, 3 ) );
			level.challengeInfoMP[refString]["maxval"] = int( tableLookup( tableName, 0, idx, 4 ) );
			level.challengeInfoMP[refString]["minval"] = int( tableLookup( tableName, 0, idx, 5 ) );
			level.challengeInfoMP[refString]["fullname"] = tableLookup( tableName, 0, idx, 7 );
			level.challengeInfoMP[refString]["name"] = tableLookupIString( tableName, 0, idx, 8 );
			level.challengeInfoMP[refString]["desc"] = tableLookupIString( tableName, 0, idx, 9 );
			level.challengeInfoMP[refString]["reward"] = int( tableLookup( tableName, 0, idx, 10 ) );
			level.challengeInfoMP[refString]["camo"] = tableLookup( tableName, 0, idx, 12 );
			level.challengeInfoMP[refString]["attachment"] = tableLookup( tableName, 0, idx, 13 );
			level.challengeInfoMP[refString]["group"] = tableLookup( tableName, 0, idx, 14 );

			//precacheString( level.challengeInfo[refString]["name"] );
		}
	}
}

// used for tour challenges to keep track of which levels have been completed
processChallengeBit( baseName, whichbit, levelEnd )
{
	if ( !mayProcessChallenges() )
		return 0;

	if( !isDefined( levelEnd ) )
	{
		levelEnd = false;
	}
		
	refString = baseName;

	missionStatus = self getChallengeStatus( baseName );

	if ( !missionStatus || missionStatus == 255 )
		return 0;

	self setStatBit( level.challengeInfo[refString]["statid"], whichbit, 1 );

	progress = self getStat( level.challengeInfo[refString]["statid"] );

	if ( progress >= level.challengeInfo[refString]["maxval"] )
	{
		missionStatus = 255;

		self thread challengeNotify( level.challengeInfo[refString]["name"], levelEnd );

		self setStat( level.challengeInfo[refString]["stateid"], missionStatus );
		self giveRankXP( "challenge", level.challengeInfo[refString]["reward"] );
		
		return 1;
	}
	
	return 0;
}

processChallenge( baseName, progressInc, levelEnd )
{
	if ( !mayProcessChallenges() )
		return 0; //no challenge processed
		
	if(	!isDefined( levelEnd ) )
	{
		levelEnd = false;
	}
		
	numLevels = getChallengeLevels( baseName );
	
	if ( numLevels > 1 )
		missionStatus = self getChallengeStatus( (baseName + "1") );
	else
		missionStatus = self getChallengeStatus( baseName );

	if ( !isDefined( progressInc ) )
		progressInc = 1;
	
	//iprintln( "CHALLENGE PROGRESS - " + baseName + ": " + progressInc );
	
	if ( !missionStatus || missionStatus == 255 )
		return 0; //no challenge processed
		
	assertex( missionStatus <= numLevels, "Mini challenge levels higher than max: " + missionStatus + " vs. " + numLevels );
	
	if ( numLevels > 1 )
		refString = baseName + missionStatus;
	else
		refString = baseName;

	progress = self getStat( level.challengeInfo[refString]["statid"] );

	progress += progressInc;
	
	self setStat( level.challengeInfo[refString]["statid"], progress );

	if ( progress >= level.challengeInfo[refString]["maxval"] )
	{
		if( false == levelEnd )
		{
			self thread challengeNotify( level.challengeInfo[refString]["name"] );
		}

		//if ( level.challengeInfo[refString]["camo"] != "" )
		//	self maps\mp\gametypes\_rank::unlockCamo( level.challengeInfo[refString]["camo"] );

		//if ( level.challengeInfo[refString]["attachment"] != "" )
		//	self maps\mp\gametypes\_rank::unlockAttachment( level.challengeInfo[refString]["attachment"] );

		if ( missionStatus == numLevels )
			missionStatus = 255;
		else
			missionStatus += 1;

		if ( numLevels > 1 )
			self.challengeData[baseName + "1"] = missionStatus;
		else
			self.challengeData[baseName] = missionStatus;

		// prevent bars from running over
		self setStat( level.challengeInfo[refString]["statid"], level.challengeInfo[refString]["maxval"] );

		self setStat( level.challengeInfo[refString]["stateid"], missionStatus );
		
		self giveRankXP( "challenge", level.challengeInfo[refString]["reward"], levelEnd );
		
		return 1; //challenge processed
	}
	
	return 0; //no challenge processed
}

resetChallengeProgress( baseName, progress )
{
	if ( !mayProcessChallenges() )
		return;
		
	numLevels = getChallengeLevels( baseName );
	
	if ( numLevels > 1 )
		missionStatus = self getChallengeStatus( (baseName + "1") );
	else
		missionStatus = self getChallengeStatus( baseName );

	if ( !isDefined( progress ) )
		progress = 0;
	
	/#
	if ( getDvarInt( "debug_challenges" ) )
		println( "CHALLENGE PROGRESS - " + baseName + ": " + progress );
	#/
	
	if ( !missionStatus || missionStatus == 255 )
		return;
		
	assertex( missionStatus <= numLevels, "Mini challenge levels higher than max: " + missionStatus + " vs. " + numLevels );
	
	if ( numLevels > 1 )
		refString = baseName + missionStatus;
	else
		refString = baseName;

	prevprogress = self getStat( level.challengeInfo[refString]["statid"] );

	// Don't allow reset if challenge has already been completed.
	if ( prevprogress < level.challengeInfo[refString]["maxval"] )
	{
		self setStat( level.challengeInfo[refString]["statid"], progress );
	}
}

giveRankXP( type, value, levelEnd )
{
   self endon("disconnect");

   if ( !mayGenerateAfterActionReport() )
      return;

   if( !isDefined( levelEnd ) )
   {
      levelEnd = false;
   }   
   
   value = int( value * level.xpScale );

   switch( type )
   {
      case "challenge":
         self.summary_challenge += value;
         self.summary_xp += value;
         break;
   
      // Added by Rampage - for kill XP
      case "kill":
         self.summarch_challenge += value;
         self.summary_xp += value;
         break;
   }
      
   self incRankXP( value );

   if ( self updateRank() )
      self thread updateRankAnnounceHUD();

   // Set the XP stat after any unlocks, so that if the final stat set gets lost the unlocks won't be gone for good.
   self syncXPStat();
   self updateRankScoreHUD( value );
}

updateRankScoreHUD( amount )
{
	self endon( "disconnect" );

	if ( amount < 1 )
		return;

	self notify( "update_score" );
	self endon( "update_score" );

	self.rankUpdateTotal += amount;

	if( isDefined( self.hud_rankscroreupdate ) )
	{			
		self.hud_rankscroreupdate.label = "+";
		self.hud_rankscroreupdate.color = (1,1,0.5);
	
		self.hud_rankscroreupdate setValue(amount);
	
		self.hud_rankscroreupdate.alpha = 0.85;
		self.hud_rankscroreupdate thread fontPulse( self );
		self.hud_rankscroreupdate fadeOverTime( 1 );
		self.hud_rankscroreupdate.alpha = 0;
		
		self.rankUpdateTotal = 0;
	}
}

updateRankAnnounceHUD()
{
	self endon("disconnect");

	self notify("update_rank");
	self endon("update_rank");
	
	self notify("reset_outcome");
	newRankName = self getRankInfoFull( self.rank );
	
	notifyData = spawnStruct();

	notifyData.titleText = &"RANK_PROMOTED";
	notifyData.iconName = self getRankInfoIcon( self.rank, self.prestige );
	notifyData.sound = "mp_level_up";
	notifyData.duration = 4.0;
	
	rank_char = level.rankTable[self.rank][1];
	subRank = int(rank_char[rank_char.size-1]);
	
	if ( subRank == 2 )
	{
		notifyData.textLabel = newRankName;
		notifyData.notifyText = &"RANK_ROMANI";
		notifyData.textIsString = true;
	}
	else if ( subRank == 3 )
	{
		notifyData.textLabel = newRankName;
		notifyData.notifyText = &"RANK_ROMANII";
		notifyData.textIsString = true;
	}
	else if ( subRank == 4 )
	{
		notifyData.textLabel = newRankName;
		notifyData.notifyText = &"RANK_ROMANIII";
		notifyData.textIsString = true;
	}
	else
	{
		notifyData.notifyText = newRankName;
	}

	self thread maps\_hud_message::notifyMessage( notifyData );
}

updateRank()
{
	newRankId = self getRank();
	if ( newRankId == self.rank )
		return false;

	oldRank = self.rank;
	rankId = self.rank;
	self.rank = newRankId;

	while ( rankId <= newRankId )
	{	
		self statSet( "rank", rankId );
		self statSet( "minxp", int(level.rankTable[rankId][2]) );
		self statSet( "maxxp", int(level.rankTable[rankId][7]) );
	
		// set current new rank index to stat#252
		self setStat( 252, rankId );
			
		// unlock MP challenge =====
		unlockedChallenge = self getRankInfoUnlockChallenge( rankId );
		if ( isDefined( unlockedChallenge ) && unlockedChallenge != "" )
			unlockChallenge( unlockedChallenge );

		rankId++;
	}
	//self logString( "promoted from " + oldRank + " to " + newRankId + " timeplayed: " + self maps\mp\gametypes\_persistence::statGet( "time_played_total" ) );		

	self setRank( newRankId );
	
	return true;
}


getPrestigeLevel()
{
	return self statGet( "plevel" );
}

getRank()
{	
	rankXp = self.rankxp;
	rankId = self.rank;

	if ( rankXp < (getRankInfoMinXP( rankId ) + getRankInfoXPAmt( rankId )) )
		return rankId;
	else
		return self getRankForXp( rankXp );
}

getRankXP()
{
	return self.rankxp;
}

getRankForXp( xpVal )
{
	rankId = 0;
	rankName = level.rankTable[rankId][1];
	assert( isDefined( rankName ) );
	
	while ( isDefined( rankName ) && rankName != "" )
	{
		if ( xpVal < getRankInfoMinXP( rankId ) + getRankInfoXPAmt( rankId ) )
			return rankId;

		rankId++;
		if ( isDefined( level.rankTable[rankId] ) )
			rankName = level.rankTable[rankId][1];
		else
			rankName = undefined;
	}
	
	rankId--;
	return rankId;
}

getRankInfoMinXP( rankId )
{
	return int(level.rankTable[rankId][2]);
}

getRankInfoXPAmt( rankId )
{
	return int(level.rankTable[rankId][3]);
}

getRankInfoMaxXp( rankId )
{
	return int(level.rankTable[rankId][7]);
}

getRankInfoFull( rankId )
{
	return tableLookupIString( "mp/ranktable.csv", 0, rankId, 16 );
}

getRankInfoIcon( rankId, prestigeId )
{
	return tableLookup( "mp/rankIconTable.csv", 0, rankId, prestigeId+1 );
}

//-------------------- Functions Handling MP Unlocks --------------------------------------
getRankInfoUnlockWeapon( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 8 );
}

getRankInfoUnlockPerk( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 9 );
}

getRankInfoUnlockChallenge( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 10 );
}

getRankInfoUnlockFeature( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 15 );
}

getRankInfoUnlockCamo( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 11 );
}

getRankInfoUnlockAttachment( rankId )
{
	return tableLookup( "mp/ranktable.csv", 0, rankId, 12 );
}

// unlocks weapon - multiple
unlockWeapon( refString )
{
	assert( isDefined( refString ) && refString != "" );
	
	// tokenize reference string, accepting multiple weapon unlocks in one call
	Ref_Tok = strTok( refString, " " );
	assertex( Ref_Tok.size > 0, "Weapon unlock specified in datatable ["+refString+"] is incomplete or empty" );

	for( i=0; i<Ref_Tok.size; i++ )
		unlockWeaponSingular( Ref_Tok[i] );
}

// unlocks weapon - singular
unlockWeaponSingular( refString )
{
	stat = int( tableLookup( "mp/statstable.csv", 4, refString, 1 ) );
	
	assertEx( stat > 0, "statsTable refstring " + refString + " has invalid stat number: " + stat );
	
	statVal = self getStat( stat );
	if ( statVal & 1 )
		return;

	self setStat( stat, (statVal | 65537) );

	self setStat( stat, 65537 );	// 65537 is binary mask for newly unlocked weapon
}

// unlocks perk - multiple
unlockPerk( refString )
{
	assert( isDefined( refString ) && refString != "" );

	// tokenize reference string, accepting multiple perk unlocks in one call
	Ref_Tok = strTok( refString, ";" );
	assertex( Ref_Tok.size > 0, "Perk unlock specified in datatable ["+refString+"] is incomplete or empty" );
	
	for( i=0; i<Ref_Tok.size; i++ )
		unlockPerkSingular( Ref_Tok[i] );
}

// unlocks perk
unlockPerkSingular( refString )
{
	assert( isDefined( refString ) && refString != "" );

	stat = int( tableLookup( "mp/statstable.csv", 4, refString, 1 ) );
	
	if( self getStat( stat ) > 0 )
		return;

	self setStat( stat, 2 );	// 2 is binary mask for newly unlocked perk
}

// unlocks camo - multiple
unlockCamo( refString )
{
	assert( isDefined( refString ) && refString != "" );

	// tokenize reference string, accepting multiple camo unlocks in one call
	Ref_Tok = strTok( refString, ";" );
	assertex( Ref_Tok.size > 0, "Camo unlock specified in datatable ["+refString+"] is incomplete or empty" );
	
	for( i=0; i<Ref_Tok.size; i++ )
		unlockCamoSingular( Ref_Tok[i] );
}

// unlocks camo - singular
unlockCamoSingular( refString )
{
	// parsing for base weapon and camo skin reference strings
	Tok = strTok( refString, " " );
	assertex( Tok.size == 2, "Camo unlock sepcified in datatable ["+refString+"] is invalid" );
	
	baseWeapon = Tok[0];
	addon = Tok[1];

	weaponStat = int( tableLookup( "mp/statstable.csv", 4, baseWeapon, 1 ) );
	addonMask = int( tableLookup( "mp/attachmenttable.csv", 4, addon, 10 ) );
	
	if ( self getStat( weaponStat ) & addonMask )
		return;
	
	// ORs the camo/attachment's bitmask with weapon's current bits, thus switching the camo/attachment bit on
	setstatto = ( self getStat( weaponStat ) | addonMask ) | (addonMask<<16) | (1<<16);
	self setStat( weaponStat, setstatto );
}

unlockAttachment( refString )
{
	assert( isDefined( refString ) && refString != "" );

	// tokenize reference string, accepting multiple attachment(?) unlocks in one call
	Ref_Tok = strTok( refString, ";" );
	assertex( Ref_Tok.size > 0, "Attachment unlock specified in datatable ["+refString+"] is incomplete or empty" );
	
	for( i=0; i<Ref_Tok.size; i++ )
		unlockAttachmentSingular( Ref_Tok[i] );
}

// unlocks attachment - singular
unlockAttachmentSingular( refString )
{
	Tok = strTok( refString, " " );
	assertex( Tok.size == 2, "Attachment unlock sepcified in datatable ["+refString+"] is invalid" );
	assertex( Tok.size == 2, "Attachment unlock sepcified in datatable ["+refString+"] is invalid" );
	
	baseWeapon = Tok[0];
	addon = Tok[1];

    addonIndex = getAttachmentSlot( baseWeapon, addon );
    addonMask = 1<<(addonIndex+1);

	weaponStat = int( tableLookup( "mp/statstable.csv", 4, baseWeapon, 1 ) );

	if ( self getStat( weaponStat ) & addonMask )
		return;
	
	// ORs the camo/attachment's bitmask with weapon's current bits, thus switching the camo/attachment bit on
	setstatto = ( self getStat( weaponStat ) | addonMask ) | (addonMask<<16) | (1<<16);
	self setStat( weaponStat, setstatto );
}

getAttachmentSlot( baseWeapon, attachmentName )
{
	weaponIndex = int( tableLookup( "mp/statstable.csv", 4, baseWeapon, 0 ) );
	attachment_array_string = level.tbl_weaponIDs[weaponIndex]["attachment"];

	if( isdefined( attachment_array_string ) && attachment_array_string != "" )
	{           
		attachment_tokens = strtok( attachment_array_string, " " );
		if( isdefined( attachment_tokens ) && attachment_tokens.size != 0 )
		{
			// multiple attachment options
			for( k = 0; k < attachment_tokens.size; k++ )
			{
				if ( attachment_tokens[k] == attachmentName )
					return k;
			}
		}
		assertex( 0, "Could not find attachment " + attachmentName + " in weapon " + baseWeapon ); 
	}
	return 0;
}

unlockChallenge( refString )
{
	assert( isDefined( refString ) && refString != "" );

	// tokenize reference string, accepting multiple camo unlocks in one call
	Ref_Tok = strTok( refString, ";" );
	assertex( Ref_Tok.size > 0, "Camo unlock specified in datatable ["+refString+"] is incomplete or empty" );
	
	for( i=0; i<Ref_Tok.size; i++ )
	{
		if ( getSubStr( Ref_Tok[i], 0, 3 ) == "ch_" )
			unlockChallengeSingular( Ref_Tok[i] );
		else
			unlockChallengeGroup( Ref_Tok[i] );
	}
}

// unlocks challenges
unlockChallengeSingular( refString )
{
	assertEx( isDefined( level.challengeInfoMP[refString] ), "Challenge unlock "+refString+" does not exist." );
	tableName = "mp/challengetable_tier" + level.challengeInfoMP[refString]["tier"] + ".csv";
	
	if ( self getStat( level.challengeInfoMP[refString]["stateid"] ) )
		return;

	self setStat( level.challengeInfoMP[refString]["stateid"], 1 );
	
	// set tier as new
	self setStat( 269 + level.challengeInfoMP[refString]["tier"], 2 );// 2: new, 1: old
}

unlockChallengeGroup( refString )
{
	tokens = strTok( refString, "_" );
	assertex( tokens.size > 0, "Challenge unlock specified in datatable ["+refString+"] is incomplete or empty" );
	
	assert( tokens[0] == "tier" );
	
	tierId = int( tokens[1] );
	assertEx( tierId > 0 && tierId <= level.numChallengeTiersMP, "invalid tier ID " + tierId );

	groupId = "";
	if ( tokens.size > 2 )
		groupId = tokens[2];

	challengeArray = getArrayKeys( level.challengeInfoMP );
	
	unlocked = false;
	for ( index = 0; index < challengeArray.size; index++ )
	{
		challenge = level.challengeInfoMP[challengeArray[index]];
		
		if ( challenge["tier"] != tierId )
			continue;
			
		if ( challenge["group"] != groupId )
			continue;
			
		if ( self getStat( challenge["stateid"] ) )
			continue;

		self setStat( challenge["stateid"], 1 );
		
		// set tier as new
		self setStat( 269 + challenge["tier"], 2 );// 2: new, 1: old
	}
}

unlockFeature( refString )
{
	assert( isDefined( refString ) && refString != "" );

	// tokenize reference string, accepting multiple attachment(?) unlocks in one call
	Ref_Tok = strTok( refString, ";" );
	assertex( Ref_Tok.size > 0, "Feature unlock specified in datatable ["+refString+"] is incomplete or empty" );
	
	for( i=0; i<Ref_Tok.size; i++ )
		unlockFeatureSingular( Ref_Tok[i] );
}

unlockFeatureSingular( refString )
{
	assert( isDefined( refString ) && refString != "" );

	stat = int( tableLookup( "mp/statstable.csv", 4, refString, 1 ) );
	
	if( self getStat( stat ) > 0 )
		return;

	if ( refString == "feature_cac" )
		self setStat( 260, 1 );

	self setStat( stat, 2 ); // 2 is binary mask for newly unlocked
}

// update copy of a challenges to be progressed this game, only at the start of the game
// challenges unlocked during the game will not be progressed on during that game session
updateMPChallenges()
{
	self.challengeMPData = [];
	for ( i = 1; i <= level.numChallengeTiersMP; i++ )
	{
		tableName = "mp/challengetable_tier"+i+".csv";

		idx = 1;
		// unlocks all the challenges in this tier
		for( idx = 1; isdefined( tableLookup( tableName, 0, idx, 0 ) ) && tableLookup( tableName, 0, idx, 0 ) != ""; idx++ )
		{
			stat_num = tableLookup( tableName, 0, idx, 2 );
			if( isdefined( stat_num ) && stat_num != "" )
			{
				statVal = self getStat( int( stat_num ) );
				
				refString = tableLookup( tableName, 0, idx, 7 );
				if ( statVal )
					self.challengeMPData[refString] = statVal;
			}
		}
	}
}

//----------------------------------------------------------


incRankXP( amount )
{
	if ( !mayProcessChallenges() )
		return;
	
	xp = self getRankXP();
	newXp = (xp + amount);

	if ( self.rank == level.maxRank && newXp >= getRankInfoMaxXP( level.maxRank ) )
		newXp = getRankInfoMaxXP( level.maxRank );

	self.rankxp = newXp;
}

syncXPStat()
{
	xp = self getRankXP();
	
	self statSet( "rankxp", xp );
	//self statAdd( "rankxp", xp );
}

ch_goooal()
{
	self processChallenge( "ch_goooal_1" );
	wait( 0.5 );
	self processChallenge( "ch_goooal_1", -1 );
}

ch_bbq()
{
	self processChallenge( "ch_bbq_1" );
	wait( 4.0 );
	self processChallenge( "ch_bbq_1", -1 );
}

ch_hothands( weapon )		// 4 headshots in a row with multiple weapons in 10 seconds
{
	if( !IsDefined(self.hothandscount) )
	{
		self.hothandscount = 0;
		self.hothandsweapon = weapon;
		self.hothandsweaponswitched = false;
	}

	if( self.hothandsweapon != weapon )
	{
		self.hothandsweaponswitched = true;
	}
	self.hothandsweapon = weapon;

	self.hothandscount++;
	if( self.hothandscount > 4 && self.hothandsweaponswitched )
	{
		self processChallenge( "ch_hothands_1" );
	}
	wait( 11.0 );	// give them a second extra ;)
	self.hothandscount--;

	if( self.hothandscount == 0 )
	{
		self.hothandscount = undefined;
	}
}

ch_wagofthefinger()	// get melee kills at the same time as another player
{
	if( !IsDefined(level.lastwagplayer) )
	{
		level.wagofthefinger = 0;
		level.lastwagplayer = self;
	}

	level.wagofthefinger++;
	if( level.wagofthefinger > 1 && level.lastwagplayer != self )
	{
		self processChallenge( "ch_wagofthefinger_1" );
		level.lastwagplayer processChallenge( "ch_wagofthefinger_1" );
	}

	level.lastwagplayer = self;

	wait 0.5;

	level.wagofthefinger--;
	if( level.wagofthefinger == 0 )
	{
		level.lastwagplayer = undefined;
	}
}

ch_doubleheader()	// get headshot kills at the same time as another player
{
	if( !IsDefined(level.lastdhplayer) )
	{
		level.doubleheader = 0;
		level.lastdhplayer = self;
	}

	level.doubleheader++;
	if( level.doubleheader > 1 && level.lastdhplayer != self )
	{
		self processChallenge( "ch_doubleheader_1" );
		level.lastdhplayer processChallenge( "ch_doubleheader_1" );
	}

	level.lastdhplayer = self;

	wait 0.5;

	level.doubleheader--;
	if( level.doubleheader == 0 )
	{
		level.lastdhplayer = undefined;
	}
}

ch_brassCollector()
{
	self waittill( "reload_start" );
	self.ch_brassCollector = 0;
}

ch_assists( player )
{
	if ( !isDefined( player ) || !isPlayer( player ) )
	{
		return;
	}
	player processChallenge( "ch_assist_1" );
}

isStrStart( string1, subStr )
{
	return ( getSubStr( string1, 0, subStr.size ) == subStr );
}

getWeaponClass( weapon )
{
	tokens = strTok( weapon, "_" );
	weaponClass = tablelookup( "mp/statstable.csv", 4, tokens[0], 2 );
	return weaponClass;
}

ch_kills( victim )
{
	if ( !isDefined( victim.attacker ) || !isPlayer( victim.attacker ) || victim.team == "allies" )
		return;
	
	player = victim.attacker;
	if(victim.damagemod != "MOD_MELEE" && victim.damagemod != "MOD_BAYONET")
	{
		if ( (victim.damageLocation != "head" && victim.damageLocation != "neck") && victim.damagemod == "MOD_PISTOL_BULLET" || victim.damagemod == "MOD_RIFLE_BULLET" )
		{
			if ( isStrStart( victim.damageweapon, "gewehr43" ) || isStrStart( victim.damageweapon, "zombie_gewehr43" ))
				player processChallenge( "ch_marksman_g43_" );
			else if ( isStrStart( victim.damageweapon, "svt40" ) || isStrStart( victim.damageweapon, "zombie_svt40" ))
				player processChallenge( "ch_marksman_svt40_" );
			else if ( isStrStart( victim.damageweapon, "m1garand" ) || isStrStart( victim.damageweapon, "zombie_m1garand" ))
				player processChallenge( "ch_marksman_m1garand_" );
			else if ( isStrStart( victim.damageweapon, "m1carbine" ) || isStrStart( victim.damageweapon, "zombie_m1carbine" ))
				player processChallenge( "ch_marksman_m1a1_" );
			else if ( isStrStart( victim.damageweapon, "stg44" ) || isStrStart( victim.damageweapon, "zombie_stg44" ))
				player processChallenge( "ch_marksman_stg44_" );		
			else if ( isStrStart( victim.damageweapon, "thompson" ) || isStrStart( victim.damageweapon, "zombie_thompson" ))
				player processChallenge( "ch_marksman_thompson_" );
			else if ( isStrStart( victim.damageweapon, "type100smg" ) || isStrStart( victim.damageweapon, "zombie_type100smg" ))
				player processChallenge( "ch_marksman_type100smg" );
			else if ( isStrStart( victim.damageweapon, "mp40" ) || isStrStart( victim.damageweapon, "zombie_mp40" ))
				player processChallenge( "ch_marksman_mp40_" );
			else if ( isStrStart( victim.damageweapon, "ppsh" ) || isStrStart( victim.damageweapon, "zombie_ppsh" ))
				player processChallenge( "ch_marksman_ppsh_" );		
			else if ( isStrStart( victim.damageweapon, "type99lmg" ) || isStrStart( victim.damageweapon, "type99_lmg" ))
				player processChallenge( "ch_marksman_type99lmg_" );
			else if ( isStrStart( victim.damageweapon, "fg42" ) || isStrStart( victim.damageweapon, "zombie_fg42" ))
				player processChallenge( "ch_marksman_fg42_" );
			else if ( isStrStart( victim.damageweapon, "30cal" ) || isStrStart( victim.damageweapon, "zombie_30cal" ))
				player processChallenge( "ch_marksman_30cal" );
			else if ( isStrStart( victim.damageweapon, "mg42" ) || isStrStart( victim.damageweapon, "zombie_mg42" ))
				player processChallenge( "ch_marksman_mg42" );
			else if ( isStrStart( victim.damageweapon, "dp28" ) || isStrStart( victim.damageweapon, "zombie_dp28" ))
				player processChallenge( "ch_marksman_dp28" );
			else if ( isStrStart( victim.damageweapon, "bar" ) || isStrStart( victim.damageweapon, "zombie_bar" ))
				player processChallenge( "ch_marksman_bar" );
			else if ( isStrStart( victim.damageweapon, "shotgun" ) || isStrStart( victim.damageweapon, "zombie_shotgun" ))
				player processChallenge( "ch_marksman_shotgun_" );
			else if ( isStrStart( victim.damageweapon, "doublebarrel" ) || isStrStart( victim.damageweapon, "zombie_doublebarrel" ))
				player processChallenge( "ch_marksman_dbshotty_" );
			else if ( isStrStart( victim.damageweapon, "mosinrifle" ) || isStrStart( victim.damageweapon, "zombie_mosinrifle" ))
				player processChallenge( "ch_marksman_mosinrifle_" );
			else if ( isStrStart( victim.damageweapon, "springfield" ) || isStrStart( victim.damageweapon, "zombie_springfield" ))
				player processChallenge( "ch_marksman_springfield_" );
			else if ( isStrStart( victim.damageweapon, "kar98k" ) || isStrStart( victim.damageweapon, "zombie_kar98k" ))
				player processChallenge( "ch_marksman_kar98k_" );
			else if ( isStrStart( victim.damageweapon, "type99rifle" ) || isStrStart( victim.damageweapon, "zombie_type99rifle" ))
				player processChallenge( "ch_marksman_type99rifle_" );
			else if ( isStrStart( victim.damageweapon, "ptrs41" ) || isStrStart( victim.damageweapon, "zombie_ptrs41" ))
				player processChallenge( "ch_marksman_type99rifle_" );
		}
		else if ( victim.damagemod == "MOD_HEAD_SHOT" || victim.damageLocation == "head" || victim.damageLocation == "neck" )
		{
			if ( isStrStart( victim.damageWeapon, "gewehr43" ) || isStrStart( victim.damageWeapon, "zombie_gewehr43" ))
			{
				player processChallenge( "ch_expert_g43_" );
				player processChallenge( "ch_marksman_g43_" );
			}
			else if ( isStrStart( victim.damageWeapon, "svt40" ) || isStrStart( victim.damageWeapon, "zombie_svt40" ))
			{
				player processChallenge( "ch_expert_svt40_" );
				player processChallenge( "ch_marksman_svt40_" );
			}
			else if ( isStrStart( victim.damageWeapon, "m1garand" ) || isStrStart( victim.damageWeapon, "zombie_m1garand" ))
			{
				player processChallenge( "ch_expert_m1garand_" );
				player processChallenge( "ch_marksman_m1garand_" );
			}
			else if ( isStrStart( victim.damageWeapon, "stg44" ) || isStrStart( victim.damageWeapon, "zombie_stg44" ))
			{
				player processChallenge( "ch_expert_stg44_" );
				player processChallenge( "ch_marksman_stg44_" );
			}
			else if ( isStrStart( victim.damageWeapon, "m1carbine" ) || isStrStart( victim.damageWeapon, "zombie_m1carbine" ))
			{
				player processChallenge( "ch_expert_m1a1_" );
				player processChallenge( "ch_marksman_m1a1_" );
			}
	/// SMG
			else if ( isStrStart( victim.damageWeapon, "thompson" ) || isStrStart( victim.damageWeapon, "zombie_thompson" ))
			{
				player processChallenge( "ch_expert_thompson_" );
				player processChallenge( "ch_marksman_thompson_" );
			}
			else if ( isStrStart( victim.damageWeapon, "type100smg" ) || isStrStart( victim.damageWeapon, "zombie_type100smg" ))
			{
				player processChallenge( "ch_expert_type100smg_" );
				player processChallenge( "ch_marksman_type100smg_" );
			}
			else if ( isStrStart( victim.damageWeapon, "mp40" ) || isStrStart( victim.damageWeapon, "zombie_mp40" ))
			{
				player processChallenge( "ch_expert_mp40_" );
				player processChallenge( "ch_marksman_mp40_" );
			}
			else if ( isStrStart( victim.damageWeapon, "ppsh" ) || isStrStart( victim.damageWeapon, "zombie_ppsh" ))
			{
				player processChallenge( "ch_expert_ppsh_" );
				player processChallenge( "ch_marksman_ppsh_" );
			}
	//LMGS
			else if ( isStrStart( victim.damageWeapon, "type99lmg" )  || isStrStart( victim.damageWeapon, "type99_lmg" ))
			{
				player processChallenge( "ch_expert_type99lmg_" );
				player processChallenge( "ch_marksman_type99lmg_" );
				player processChallenge( "ch_expert_lmg_" );
			}
			else if ( isStrStart( victim.damageWeapon, "fg42" ) || isStrStart( victim.damageWeapon, "zombie_fg42" ))
			{
				player processChallenge( "ch_expert_fg42_" );
				player processChallenge( "ch_marksman_fg42_" );
				player processChallenge( "ch_expert_lmg_" );
			}
			else if ( isStrStart( victim.damageWeapon, "dp28" ) || isStrStart( victim.damageWeapon, "zombie_dp28" ))
			{
				player processChallenge( "ch_expert_dp28_" );
				player processChallenge( "ch_marksman_dp28" );
				player processChallenge( "ch_expert_lmg_" );
			}
			else if ( isStrStart( victim.damageWeapon, "bar" ) || isStrStart( victim.damageWeapon, "zombie_bar" ))
			{
				player processChallenge( "ch_expert_bar_" );
				player processChallenge( "ch_marksman_bar" );
				player processChallenge( "ch_expert_lmg_" );
			}
	//HMGS
			else if ( isStrStart( victim.damageWeapon, "30cal" ) || isStrStart( victim.damageWeapon, "zombie_30cal" ))
			{
				player processChallenge( "ch_expert_30cal_" );
				player processChallenge( "ch_marksman_30cal" );
				player processChallenge( "ch_expert_hmg_" );
			}
			else if ( isStrStart( victim.damageWeapon, "mg42" ) || isStrStart( victim.damageWeapon, "zombie_mg42" ))
			{
				player processChallenge( "ch_expert_mg42_" );
				player processChallenge( "ch_marksman_mg42" );
				player processChallenge( "ch_expert_hmg_" );
			}
	//SHOTGUNS	
			else if ( isStrStart( victim.damageWeapon, "shotgun" ) || isStrStart( victim.damageWeapon, "zombie_shotgun" ))
			{
				player processChallenge( "ch_expert_shotgun_" );
				player processChallenge( "ch_marksman_shotgun_" );
			}
			else if ( isStrStart( victim.damageWeapon, "doublebarrel" ) || isStrStart( victim.damageWeapon, "zombie_doublebarrel" ))
			{
				player processChallenge( "ch_expert_dbshotty_" );
				player processChallenge( "ch_marksman_dbshotty_" );
			}
	// bolt action rifles		
			else if ( isStrStart( victim.damageWeapon, "kar98k" ) || isStrStart( victim.damageWeapon, "zombie_kar98k" ))
			{
				player processChallenge( "ch_expert_kar98k_" );
				player processChallenge( "ch_marksman_kar98k_" );
			}
			else if ( isStrStart( victim.damageWeapon, "mosinrifle" ) || isStrStart( victim.damageWeapon, "zombie_mosinrifle" ))
			{
				player processChallenge( "ch_expert_mosinrifle_" );
				player processChallenge( "ch_marksman_mosinrifle_" );
			}
			else if ( isStrStart( victim.damageWeapon, "springfield" ) || isStrStart( victim.damageWeapon, "zombie_springfield" ))
			{
				player processChallenge( "ch_expert_springfield_" );
				player processChallenge( "ch_marksman_springfield_" );
			}
			else if ( isStrStart( victim.damageWeapon, "ptrs41" ) || isStrStart( victim.damageWeapon, "zombie_ptrs41" ))
			{
				player processChallenge( "ch_expert_ptrs41_" );
			}
			else if ( isStrStart( victim.damageWeapon, "type99rifle" ) || isStrStart( victim.damageWeapon, "zombie_type99rifle" ))
			{
				player processChallenge( "ch_expert_type99rifle_" );
				player processChallenge( "ch_marksman_type99rifle_" );
			}		
		}
	}
}

processKillStreakChallenge()
{
	if( !IsDefined( self.challengeKillStreak ) )
	{
		self.challengeKillStreak = 0;
	}

	self.challengeKillStreak++;
	if( self.challengeKillStreak == 30 )
	{
		self processChallenge( "ch_diehard_1" );
	}
	else if( self.challengeKillStreak == 50 )
	{
		self processChallenge( "ch_bulletproof_1" );
	}
	else if( self.challengeKillStreak == 75 )
	{
		self processChallenge( "ch_goldengod_1" );
	}
}

ch_revives( player )
{
}

ch_checkpointLoaded( player )	// player died
{
	ch_reset_alive_challenges( player );
	if ( !isdefined( level.playerDeaths ) )
	{
		level.playerDeaths = 0;
	}
	level.playerDeaths++;
}

ch_dies( player )	// goes into last stand
{
	ch_reset_alive_challenges( player );
	if ( !isdefined( level.playerDeaths ) )
	{
		level.playerDeaths = 0;
	}
	level.playerDeaths++;
}

ch_reset_alive_challenges( player )	// if the player has died or restarted these must get reset
{
	player.challengeKillStreak = 0;
	player resetChallengeProgress( "ch_goooal_1" );		// kill 10 in 5 sec with nades
	player resetChallengeProgress( "ch_brasscollector_1" );	// no reloading
	player resetChallengeProgress( "ch_bbq_1" );	// kill 8 with flame real quick
}

ch_multiplierChanged( player )
{
	if( player getScoreMultiplier() == 10 )
	{
		player processChallenge( "ch_multiplier_1", player getScoreMultiplier() );
	}
}

ch_gib( victim )
{
	
	if ( !isDefined( victim.attacker ) || !isPlayer( victim.attacker ) )
		return;
	
	player = victim.attacker;

	player processChallenge( "ch_gib_1" );
}

ch_levelEnd( level_index )
{	
	players = get_players();	
	for ( i = 0 ; i < players.size ; i++ )
	{
		players[i] thread playerLevelEndChallengeProcess();
	}
}

playerLevelEndChallengeProcess()
{
	self endon("disconnect");
	
	oldRank = self.rank;
	
	totalChallengesUnlock = 0;
		
	players = get_players();	
	if( getdvar( "onlinegame" ) == "1" && arcadeMode() && players.size == 4 )
	{
		highest_score = players[0].score;
		highest = 0;
			
		for ( i = 1 ; i < players.size ; i++ )
		{
			if ( players[i].score > highest_score )
			{
				highest = i;
				highest_score = players[i].score;
			}
		}
		
		if( highest == self GetEntityNumber() )
		{
			totalChallengesUnlock += self processChallenge( "ch_tipeofthehat_1", 1, true );
		}
	}
		
	if ( maps\_collectibles::has_collectible( "collectible_vampire" ) )
	{
		totalChallengesUnlock += self processChallenge( "ch_vampire_1", 1, true );
	}
	if ( maps\_collectibles::has_collectible( "collectible_sticksstones" ) )
	{
		totalChallengesUnlock += self processChallenge( "ch_sticksstones_1", 1, true );
	}
	if ( maps\_collectibles::has_collectible( "collectible_berserker" ) )
	{
		totalChallengesUnlock += self processChallenge( "ch_berserker_1", 1, true );
	}
	if ( maps\_collectibles::has_collectible( "collectible_zombie" ) )
	{
		totalChallengesUnlock += self processChallenge( "ch_zombie_1", 1, true );
	}
	if ( maps\_collectibles::has_collectible( "collectible_paintball" ) )
	{
		totalChallengesUnlock += self processChallenge( "ch_paintball_1", 1, true );
	}
	if ( maps\_collectibles::has_collectible( "collectible_dirtyharry" ) )
	{
		totalChallengesUnlock += self processChallenge( "ch_dirtyharry_1", 1, true );
	}
	if ( maps\_collectibles::has_collectible( "collectible_morphine" ) )
	{
		totalChallengesUnlock += self processChallenge( "ch_morphine_1", 1, true );
	}
	if ( maps\_collectibles::has_collectible( "collectible_thunder" ) )
	{
		totalChallengesUnlock += self processChallenge( "ch_thunder_1", 1, true );
	}
	if ( maps\_collectibles::has_collectible( "collectible_flak_jacket" ) )
	{
		totalChallengesUnlock += self processChallenge( "ch_flak_jacket_1", 1, true );
	}
	if ( maps\_collectibles::has_collectible( "collectible_body_armor" ) )
	{
		totalChallengesUnlock += self processChallenge( "ch_body_armor_1", 1, true );
	}
	if ( maps\_collectibles::has_collectible( "collectible_hard_headed" ) )
	{
		totalChallengesUnlock += self processChallenge( "ch_hard_headed_1", 1, true );
	}
	if ( maps\_collectibles::has_collectible( "collectible_dead_hands" ) )
	{
		totalChallengesUnlock += self processChallenge( "ch_dead_hands_1", 1, true );
	}
	if ( maps\_collectibles::has_collectible( "collectible_hardcore" ) )
	{
		totalChallengesUnlock += self processChallenge( "ch_hardcore_1", 1, true );
	}

	levelChallengeName = "ch_"+level.script+"_1";
	if ( isDefined( level.challengeInfo[levelChallengeName] ) && arcadeMode() && isDefined( self.score ) )
	{
		self resetChallengeProgress( levelChallengeName );
		totalChallengesUnlock += self processChallenge( levelChallengeName, self.score, true );
	}
	if ( !isdefined( level.playerDeaths ) || level.playerDeaths == 0 )
	{
		totalChallengesUnlock += self processChallenge( "ch_purpleheart_1", 1, true );
	}
	if ( level.script != "see2" && (!isdefined( self.ch_brassCollector ) || self.ch_brassCollector != 0) )
	{
		totalChallengesUnlock += self processChallenge( "ch_brasscollector_1", 1, true );
	}
	
	// custom stat tracking for which levels are complete
	totalChallengesUnlock += self processTourChallenges( true );
	
	if( 0 < totalChallengesUnlock )
	{
		notifyData = spawnStruct();
		
		if( 1 == totalChallengesUnlock )
		{
			notifyData.titleText = &"CHALLENGE_COOP_COMPLETED";
		}
		else
		{
			notifyData.titleText = &"CHALLENGE_MULTIPLE_COOP_COMPLETED";
		}
					
		notifyData.notifyText = &"CHALLENGE_MULTIPLE_COOP_COMPLETED_DETAILS";
		notifyData.sound = "mp_challenge_complete";

		self thread maps\_hud_message::notifyMessage( notifyData );
					
		if ( oldRank < self.rank )
		{
			self updateRankAnnounceHUD();
		}		
	}
}

processTourChallenges( levelEnd )
{
	if( !isDefined( levelEnd ) )
	{
		levelEnd = false;
	}

	pacificTour = false;
	europeanTour = false;
	
	whichbit = 0;
	
	switch( level.script )
	{
		// pacifc levels
		case "mak":
			whichbit = 0;
			pacificTour = true;
			break;
		case "pel1":
			whichbit = 1;
			pacificTour = true;
			break;
		case "pel2":
			whichbit = 2;
			pacificTour = true;
			break;
		case "pel1a":
			whichbit = 3;
			pacificTour = true;
			break;
		case "pel1b":
			whichbit = 4;
			pacificTour = true;
			break;
		case "oki2":
			whichbit = 5;
			pacificTour = true;
			break;
		case "oki3":
			whichbit = 6;
			pacificTour = true;
			break;
		// european levels
		case "see2":
			whichbit = 0;
			europeanTour = true;
			break;
		case "see1":
			whichbit = 1;
			europeanTour = true;
			break;
		case "ber1":
			whichbit = 2;
			europeanTour = true;
			break;
		case "ber2":
			whichbit = 3;
			europeanTour = true;
			break;
		case "ber3":
			whichbit = 4;
			europeanTour = true;
			break;
		case "ber3b":
			whichbit = 5;
			europeanTour = true;
			break;
	}

	challengeUnlocked = 0;
	if( pacificTour )
	{
		challengeUnlocked = processChallengeBit( "ch_pacific_tour_1", whichbit, levelEnd );
	}
	else if( europeanTour )
	{
		challengeUnlocked = processChallengeBit( "ch_european_tour_1", whichbit, levelEnd );
	}
	
	return challengeUnlocked; // 1 for yes
}

doMissionCallback( callback, data )
{
	if ( mayProcessChallenges() )
	{	
		if ( getDvarInt( "disable_challenges" ) > 0 )
			return;
		
		if ( !isDefined( level.missionCallbacks[callback] ) )
			return;
	
		if ( isDefined( data ) ) 
		{
			for ( i = 0; i < level.missionCallbacks[callback].size; i++ )
				thread [[level.missionCallbacks[callback][i]]]( data );
		}
		else 
		{
			for ( i = 0; i < level.missionCallbacks[callback].size; i++ )
				thread [[level.missionCallbacks[callback][i]]]();
		}
	}

	if ( mayGenerateAfterActionReport() )
	{			
		// CODER MOD 09/03/08: Bharathwaj
		// Shifted the Update Match Summary to be called after the challenges get unlocked.
		// This will update the correct values to the After Action Report.
		players = get_players();
		for ( i = 0; i < players.size; i++ )
		{
			players[i] updateMatchSummary( callback );
		}
	}	
}

//--------------------------------------------------------------------------
// from _persistence.gsc in MP
//--------------------------------------------------------------------------

/*
=============
statGet

Returns the value of the named stat
=============
*/
statGet( dataName )
{
	if ( !level.onlineGame )
		return 0;
	
	return self getStat( int(tableLookup( "mp/playerStatsTable.csv", 1, dataName, 0 )) );
}

/*
=============
setStat

Sets the value of the named stat
=============
*/
statSet( dataName, value )
{
	if ( !mayProcessChallenges() )
		return;
	
	self setStat( int(tableLookup( "mp/playerStatsTable.csv", 1, dataName, 0 )), value );	
}

/*
=============
statAdd

Adds the passed value to the value of the named stat
=============
*/
statAdd( dataName, value )
{	
	if ( !mayProcessChallenges() )
		return;

	curValue = self getStat( int(tableLookup( "mp/playerStatsTable.csv", 1, dataName, 0 )) );
	self setStat( int(tableLookup( "mp/playerStatsTable.csv", 1, dataName, 0 )), value + curValue );
}


//--------------------------------------------------------------------------
// from _class.gsc in MP
//--------------------------------------------------------------------------

// create a class init
cac_init()
{
	level.tbl_weaponIDs = [];
	for( i=0; i<150; i++ )
	{
		reference_s = tableLookup( "mp/statsTable.csv", 0, i, 4 );
		if( reference_s != "" )
		{ 
			level.tbl_weaponIDs[i]["reference"] = reference_s;
			level.tbl_weaponIDs[i]["group"] = tablelookup( "mp/statstable.csv", 0, i, 2 );
			level.tbl_weaponIDs[i]["count"] = int( tablelookup( "mp/statstable.csv", 0, i, 5 ) );
			level.tbl_weaponIDs[i]["attachment"] = tablelookup( "mp/statstable.csv", 0, i, 8 );	
		}
		else
			continue;
	}
}

class_init()
{
	max_weapon_num = 149;
	for( i = 0; i < max_weapon_num; i++ )
	{
		if( !isdefined( level.tbl_weaponIDs[i] ) || level.tbl_weaponIDs[i]["group"] == "" )
			continue;
		if( !isdefined( level.tbl_weaponIDs[i] ) || level.tbl_weaponIDs[i]["reference"] == "" )
			continue;		
	
		//statstablelookup( get_col, with_col, with_data )
		weapon_type = level.tbl_weaponIDs[i]["group"]; //statstablelookup( level.cac_cgroup, level.cac_cstat, i );
		weapon = level.tbl_weaponIDs[i]["reference"]; //statstablelookup( level.cac_creference, level.cac_cstat, i );
		attachment = level.tbl_weaponIDs[i]["attachment"]; //statstablelookup( level.cac_cstring, level.cac_cstat, i );
	}
}
