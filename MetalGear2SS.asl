/*********************************************************/
/* Metal Gear 2: Solid Snake Autosplitter v1             */
/*                                                       */
/* Emulator Compatibility:                               */
/*  * PCXS2                                              */
/*                                                       */
/* Game Compatibility:                                   */
/*  * Metal Gear PS2 PAL                                 */
/*                                                       */
/* Created by Hau5test for Metal Gear Solid Speedrunners */
/*                                                       */
/*********************************************************/

state("pcsx2") {
	// either PAL or NTSC
	string4 region: 0x2C797B9;

	//SLPM, SLES, SLUS
	string4 regCode: 0x2C79798;

	//disc numer
	// 662.21 - NTSC-J Subsistence release
	// 667.95 - NTSC-J 20th anniversary release
	// 212.43 - NTSC-U Subsistence release
	// 820.43 - PAL Subsistence release
	string6 discNumber: 0x2C7979D;

	// separate addresses for each version, with a version prefix
    // EU
	// timers
    uint EU_GameTime: 				0x123E174, 0xB28;
	uint EU_ConsoleTime: 			0x123E174, 0xF08;
    uint EU_GameState: 				0x123E174, 0xCCC;
    uint EU_GameState2: 			0x123E174, 0xCD0;
	uint EU_CheckpointFlag:			0x123E174, 0xA08;
	// variables for state and map location
	uint EU_RadarYCoord: 			0x123E174, 0xDFC;
	uint EU_RadarXCoord: 			0x123E174, 0xE00;
	uint EU_MapVal:					0x1243664, 0xC8C;
	uint EU_ScreenVal:				0x123E174, 0xE04;
	uint EU_FloorNumber:			0x123E174, 0xE50;
	// snake relevant values
	uint EU_HealthUpgrade:			0x1243664, 0xC74;
	uint EU_Health: 				0x1243664, 0xC78;
	uint EU_MaxHealth: 				0x1243664, 0xC7C;
	uint EU_Oxygen: 				0x1243664, 0xC80;
	int EU_SnakeXAxis:				0x1243664, 0xCE0;
	int EU_SnakeYAxis:				0x1243664, 0xCE4;
	int EU_SnakeLookingDirection:	0x1243664, 0xC24;
	// score screen
    uint EU_Saves: 					0x123E174, 0xB3C;
	uint EU_Continues: 				0x123E174, 0xB40;
	uint EU_Alerts: 				0x123E174, 0xB34;
	uint EU_Kills: 					0x123E174, 0xB30;
	uint EU_Rations: 				0x123E174, 0xB2C;
	// inventory values
	uint EU_RationsB1Held: 			0x1243664, 0xC64;
	uint EU_RationsB2Held: 			0x1243664, 0xC68;
	uint EU_RationsB3Held: 			0x1243664, 0xC6C;
	uint EU_PlasticExplosives: 		0x1243664, 0xC50;
	uint EU_Mines: 					0x1243664, 0xC54;
	uint EU_StingerMissiles: 		0x1243664, 0xC48;
	uint EU_RocketLauncherAmmo: 	0x1243664, 0xC60;
	uint EU_RobotMouseAmmo: 		0x1243664, 0xBC;
	uint EU_SMGAmmo: 				0x1243664, 0xC40;
	uint EU_PistolAmmo: 			0x1243664, 0xC3C;
	// menu pointer position
	uint EU_InventoryPointerX:		0x123E174, 0xE1C;
	uint EU_InventoryPointerY:		0x123E174, 0xE20;
	uint EU_ActiveItem:				0x1243664, 0xC2C;
	uint EU_ActiveWeapon:			0x1243664, 0xC28;
	uint EU_WeaponsUpdate:			0x1243664, 0xC30;
	uint EU_ItemsUpdate1:			0x1243664, 0xC34;
	uint EU_ItemsUpdate2:			0x1243664, 0xC38;
	uint EU_RationsFrozenTimer:		0x1243664, 0xC84;
	uint EU_BroochFrozenTimer:		0x1243664, 0xC88;
	uint EU_OwlHatchingTimer:		0x1243664, 0xCA4;
	uint EU_AlertStatus:			0x123E174, 0xDA8;
}

startup {
	vars.D = new ExpandoObject();
	var D = vars.D;

	D.Equipment = new Dictionary<uint, string>() {
		{ 0,  "cigarettes" },
		{ 1,  "bandana" },
		{ 2,  "scope" },
		{ 3,  "nvg" },
		{ 4,  "irg" },
		{ 5,  "gasmask" },
		{ 6,  "body_armor" },
		{ 7,  "oxygen_tank" },
		{ 8,  "mine_detector" },
		{ 9,  "hang_glider" },
		{ 10,  "cardboard_box" },
		{ 11,  "bucket" },
		{ 12,  "medicine" },
		{ 13,  "cassette" },
		{ 14,  "egg1" },
		{ 15,  "egg2" },
		{ 16,  "brooch" },
		{ 17,  "card1" },
		{ 18,  "card2" },
		{ 19,  "card3" },
		{ 20,  "card4" },
		{ 21,  "card5" },
		{ 22,  "card6" },
		{ 23,  "card7" },
		{ 24,  "card8" },
		{ 25,  "card9" },
		{ 26,  "cardred" },
		{ 27,  "cardblue"},
		{ 28,  "cardgreen" },
		{ 29,  "spray" },
		{ 30,  "oilix" },
		{ 31,  "ration_b1" },
		{ 32,  "ration_b2" },
		{ 33,  "ration_b3" }
	};

	D.Weapons = new Dictionary<uint, string>() {
		{ 0,  "pistol" },
		{ 1,  "smg" },
		{ 2,  "stinger" },
		{ 3,  "rcmissiles" },
		{ 4,  "explosives" },
		{ 5,  "mines" },
		{ 6,  "camouflage" },
		{ 7,  "grenades" },
		{ 8,  "mice" },
		{ 9,  "lighter" },
		{ 10,  "infinite_pistol" },
		{ 11,  "silencer" }
	};

	// define all variables in start up so they can be set before an active run is going on
	vars.Rank = "";
	vars.NGorNGP = "";
	vars.Location = "";
	vars.Floor = "";

	settings.Add("story_splits", true, "Story Flag Splits");
	settings.Add("green_barret", true, "Finished Green Barret Section", "story_splits");
	settings.Add("card4_pickup", true, "Met Holly first time (card 4)", "story_splits");
	settings.Add("card5_pickup", true, "Met Dr. Madnar first time (card 5)", "story_splits");
	settings.Add("brooch_frozen", true, "Froze Brooch", "story_splits");
	settings.Add("card7_pickup", true, "Fought the four horsemen", "story_splits");
	settings.Add("owl_hatched", true, "Owl Hatched", "story_splits");
	settings.Add("reached_underground", true, "Reached Underground After Dr. Madnar", "story_splits");

	settings.Add("final_split", true, "Final Split when fade to black finishes");

	// Weapons Pick Up Splits
	settings.Add("weapons_pickup", false, "Split on Weapon Collection");
	settings.Add("pistol_pickup", false, "Split on Pistol Collection" ,"weapons_pickup");
	settings.Add("smg_pickup", false, "Split on SMG Collection" ,"weapons_pickup");
	settings.Add("grenades_pickup", false, "Split on Grenades Collection" ,"weapons_pickup");
	settings.Add("stinger_pickup", false, "Split on Stinger Collection" ,"weapons_pickup");
	settings.Add("rcm_pickup", false, "Split on RC Missiles Collection" ,"weapons_pickup");
	settings.Add("pexplosives_pickup", false, "Split on Plastic Explosives Collection" ,"weapons_pickup");
	settings.Add("mines_pickup", false, "Split on Mines Collection" ,"weapons_pickup");
	settings.Add("camo_pickup", false, "Split on Camo Mats Collection" ,"weapons_pickup");
	settings.Add("gas_grenade_pickup", false, "Split on Gas Grenades Collection" ,"weapons_pickup");
	settings.Add("mouse_pickup", false, "Split on Mouse Collection" ,"weapons_pickup");
	settings.Add("lighter_pickup", false, "Split on Lighter Collection" ,"weapons_pickup");
	settings.Add("infinitegun_pickup", false, "Split on Infinite Gun Collection" ,"weapons_pickup");
	settings.Add("silencer_pickup", false, "Split on Silencer Collection" ,"weapons_pickup");

	// Items Pick Up Splits
	settings.Add("items_pickup", true, "Split on Items Collection");
	settings.Add("scope_pickup", false, "Split on Binocular Collection","items_pickup");
	settings.Add("nvg_pickup", false, "Split on Night Vision Goggles Collection","items_pickup");
	settings.Add("irg_pickup", false, "Split on Infrared Goggles Collection","items_pickup");
	settings.Add("gasmask_pickup", false, "Split on Gas Mask Collection","items_pickup");
	settings.Add("body_armor_pickup", false, "Split on Body Armor Collection","items_pickup");
	settings.Add("oxygen_tank_pickup", false, "Split on Oxygen Tank Collection","items_pickup");
	settings.Add("mine_detector_pickup", false, "Split on Mine Detector Collection","items_pickup");
	settings.Add("hang_glider_pickup", false, "Split on Hang Glider Collection","items_pickup");
	settings.Add("hang_glider_drop", false, "Split on Post Hang Glider Segment (remove from Inventory)","items_pickup");
	settings.Add("cardboard_box_pickup", false, "Split on Cardboard Box Collection","items_pickup");
	settings.Add("bucket_pickup", false, "Split on Bucket Collection","items_pickup");
	settings.Add("medicine_pickup", false, "Split on Cold Medicine Collection","items_pickup");
	settings.Add("cassette_pickup", false, "Split on Cassette Collection","items_pickup");
	settings.Add("egg1_pickup", false, "Split on Egg 1 Collection","items_pickup");
	settings.Add("egg2_pickup", true, "Split on Owl Egg Collection","items_pickup");
	settings.Add("brooch_pickup", true, "Split on Brooch Collection","items_pickup");
	settings.Add("card1_pickup", false, "Split on Card 1 Collection","items_pickup");
	settings.Add("card2_pickup", false, "Split on Card 2 Collection","items_pickup");
	settings.Add("card3_pickup", false, "Split on Card 3 Collection","items_pickup");
	//settings.Add("card4_pickup", true, "Split on Card 4 Collection","items_pickup"); <- listed as special story split for now
	//settings.Add("card5_pickup", true, "Split on Card 5 Collection","items_pickup"); <- listed as special story split for now
	settings.Add("card6_pickup", false, "Split on Card 6 Collection","items_pickup");
	//settings.Add("card7_pickup", true, "Split on Card 7 Collection","items_pickup"); <- listed as special story split for now
	settings.Add("card8_pickup", false, "Split on Card 8 Collection","items_pickup");
	settings.Add("card9_pickup", true, "Split on Card 9 Collection","items_pickup");
	settings.Add("cardred_pickup", false, "Split on Red Card Collection","items_pickup");
	settings.Add("cardblue_pickup", false, "Split on Blue Card Collection","items_pickup");
	settings.Add("cardgreen_pickup", false, "Split on Green Card Collection","items_pickup");
	settings.Add("spray_pickup", true, "Split on Spray Collection","items_pickup");
	settings.Add("oilix_pickup", false, "Split on Cartridge Collection","items_pickup");
	settings.Add("ration_b1_pickup", false, "Split on Ration B1 Collection","items_pickup");
	settings.Add("ration_b2_pickup", false, "Split on Ration B2 Collection","items_pickup");
	settings.Add("ration_b3_pickup", false, "Split on Ration B3 Collection","items_pickup");


	settings.Add("bosses_splits", true, "Split on Boss Completion");
	settings.Add("black_ninja_split", true, "Split on Black Ninja Completion", "bosses_splits");
	settings.Add("running_man_split", true, "Split on Running Man Completion", "bosses_splits");
	settings.Add("hindd_split", true, "Split on Hind D Completion", "bosses_splits");
	settings.Add("red_blaster_split", true, "Split on Red Blaster Completion", "bosses_splits");
	settings.Add("jungle_evil_split", true, "Split on Jungle Evil Completion", "bosses_splits");
	settings.Add("night_fright_split", true, "Split on Night Fright Completion", "bosses_splits");
	settings.Add("metalgeard_split", true, "Split on Night Fright Completion", "bosses_splits");
	settings.Add("grayfox_split", true, "Split on Night Fright Completion", "bosses_splits");
	settings.Add("bigboss_split", true, "Split on Night Fright Completion", "bosses_splits");
}

update {
  	var D = vars.D;
	// get a casted (to dictionary) reference to current
	// so we can manipulate it using dynamic keynames
	var cur = current as IDictionary<string, object>;

	// if we're in the emu...
	if (game.ProcessName.Equals("pcsx2", StringComparison.InvariantCultureIgnoreCase)) {

		// list of pc address names to be recreated when on emu
		var names = new List<string>() { 
			"GameTime",
			"ConsoleTime",
			"GameState",
			"GameState2",
			"CheckpointFlag",
			"RadarYCoord",
			"RadarXCoord",
			"MapVal",
			"ScreenVal",
			"FloorNumber",
			"HealthUpgrade",
			"Health",
			"MaxHealth",
			"Oxygen",
			"SnakeXAxis",
			"SnakeYAxis",
			"SnakeLookingDirection",
			"Saves",
			"Continues",
			"Alerts",
			"Kills",
			"Rations",
			"RationsB1Held",
			"RationsB2Held",
			"RationsB3Held",
			"PlasticExplosives",
			"Mines",
			"StingerMissiles",
			"RocketLauncherAmmo",
			"RobotMouseAmmo",
			"SMGAmmo",
			"PistolAmmo",
			"InventoryPointerX",
			"InventoryPointerY",
			"ActiveItem",
			"ActiveWeapon",
			"WeaponsUpdate",
			"ItemsUpdate1",
			"ItemsUpdate2",
			"RationsFrozenTimer",
			"BroochFrozenTimer",
			"OwlHatchingTimer",
			"AlertStatus"
			};

		// (placeholder) have some logic to work out the version and create the prefix
		string ver = null;

		// check the basics
		//either PAL or another version
		//if (current.region == "PAL") ver = "EU_"; <- not working for some reason
		if (current.regCode == "SLES") ver = "EU_";
		//either NTSC-US or NTSC-JP
		else if (current.regCode == "SLUS") ver = "US_";
		//either NTSC-J Subsistence or 20th Anniversary release
		else if (current.discNumber == "662.21") ver = "JSub_";
		else if (current.discNumber == "667.95") ver = "J20A_";

		// if in a supported version of the game...
		if (ver == null) return false;
		// loop through each desired address...
		foreach(string name in names) {
			// set e.g. current.GameTime to the value at e.g. current.US_GameTime
			cur[name] = cur[ver + name];
		}
	}

	// any more code for update goes here
		//function to display the current rank
	if(current.GameTime>=1296000) {
		vars.Rank = "Chicken";
	} else if ((current.GameTime>971999)&&(current.GameTime<1296000)) {
		vars.Rank = "Turtle";
	} else if ((current.GameTime>809999)&&(current.GameTime<=971999)) {
		vars.Rank = "Hippopotamus";
	} else if ((current.GameTime>647999)&&(current.GameTime<=809999)) {
		vars.Rank = "Elephant";
	} else if ((current.GameTime>431999)&&(current.GameTime<=647999)) {
		vars.Rank = "Deer";
	} else if (current.Kills >= 11) {
		vars.Rank = "Zebra";
	} else if (current.Kills < 11) {
		if ((current.GameTime>215999)&&(current.GameTime<=431999)) {
			vars.Rank = "Zebra";
		} else if ((current.GameTime>135499)&&(current.GameTime<=215999)) {
			vars.Rank = "Jackal";
		} else if ((current.GameTime>94499)&&(current.GameTime<=135499)) {
			vars.Rank = "Panther";
		} else if ((current.Kills > 5) ||(current.Continues > 0) || (current.Alerts > 6) ||(current.Rations > 0)) {
			vars.Rank = "Eagle";
		} else {
			vars.Rank = "Fox";
		}
	}

	// Weapon Update Checker
	D.PistolPickedUp = (current.WeaponsUpdate & (1 << 1-1)) != 0;
	D.SMGPickedUp = (current.WeaponsUpdate & (1 << 2-1)) != 0;
	D.GrenadePickUp = (current.WeaponsUpdate & (1 << 3-1)) != 0;
	D.StingerPickUp = (current.WeaponsUpdate & (1 << 4-1)) != 0;
	D.RCMissilePickedUp = (current.WeaponsUpdate & (1 << 5-1)) != 0;
	D.PExplosivesPickedUp = (current.WeaponsUpdate & (1 << 6-1)) != 0;
	D.MinePickedUp = (current.WeaponsUpdate & (1 << 7-1)) != 0;
	D.CamoPickUp = (current.WeaponsUpdate & (1 << 8-1)) != 0;
	D.GasGrenadePickUp = (current.WeaponsUpdate & (1 << 9-1)) != 0;
	D.MousePickUp = (current.WeaponsUpdate & (1 << 10-1)) != 0;
	D.LighterPickUp = (current.WeaponsUpdate & (1 << 11-1)) != 0;
	D.InfiniteGunPickUp = (current.WeaponsUpdate & (1 << 12-1)) != 0;
	D.SilencerPickUp = (current.WeaponsUpdate & (1 << 13-1)) != 0;


	// count all bools for weapon pick ups
	D.WeaponsPickedUp = (new []{
		D.PistolPickedUp,
		D.SMGPickedUp,
		D.GrenadePickUp,
		D.StingerPickUp,
		D.RCMissilePickedUp,
		D.PExplosivesPickedUp,
		D.MinePickedUp,
		D.CamoPickUp,
		D.GasGrenadePickUp,
		D.MousePickUp,
		D.LighterPickUp,
		D.InfiniteGunPickUp,
		D.SilencerPickUp
	}).Count(x=>x);

	vars.WeaponsPickedUp = D.WeaponsPickedUp + " out of 13";

	// Item Update Checker
	D.CigarettesPickedUp = (current.ItemsUpdate1 & (1 << 1-1)) != 0;
	D.BandanaPickedUp = (current.ItemsUpdate1 & (1 << 2-1)) != 0;
	D.BinocularsPickedUp = (current.ItemsUpdate1 & (1 << 3-1)) != 0;
	D.NVGogglesPickedUp = (current.ItemsUpdate1 & (1 << 4-1)) != 0;
	D.InfraredGogglesPickUp = (current.ItemsUpdate1 & (1 << 5-1)) != 0;
	D.GasMaskPickUp = (current.ItemsUpdate1 & (1 << 6-1)) != 0;
	D.BodyArmorPickedUp = (current.ItemsUpdate1 & (1 << 7-1)) != 0;
	D.OxygenTankPickedUp = (current.ItemsUpdate1 & (1 << 8-1)) != 0;
	D.MineDetectorPickedUp = (current.ItemsUpdate1 & (1 << 9-1)) != 0;
	D.HangGliderPickUp = (current.ItemsUpdate1 & (1 << 10-1)) != 0;
	D.CardboardBoxPickUp = (current.ItemsUpdate1 & (1 << 11-1)) != 0;
	D.BucketPickUp = (current.ItemsUpdate1 & (1 << 12-1)) != 0;
	D.ColdMedicinePickUp = (current.ItemsUpdate1 & (1 << 13-1)) != 0;
	D.CassetteTapePickUp = (current.ItemsUpdate1 & (1 << 14-1)) != 0;
	D.Egg1PickUp = (current.ItemsUpdate1 & (1 << 15-1)) != 0;
	D.Egg2PickUp = (current.ItemsUpdate1 & (1 << 16-1)) != 0;
	D.BroochPickUp = (current.ItemsUpdate1 & (1 << 17-1)) != 0;
	D.Card1PickUp = (current.ItemsUpdate1 & (1 << 18-1)) != 0;
	D.Card2PickUp = (current.ItemsUpdate1 & (1 << 19-1)) != 0;
	D.Card3PickUp = (current.ItemsUpdate1 & (1 << 20-1)) != 0;
	D.Card4PickUp = (current.ItemsUpdate1 & (1 << 21-1)) != 0;
	D.Card5PickUp = (current.ItemsUpdate1 & (1 << 22-1)) != 0;
	D.Card6PickUp = (current.ItemsUpdate1 & (1 << 23-1)) != 0;
	D.Card7PickUp = (current.ItemsUpdate1 & (1 << 24-1)) != 0;
	D.Card8PickUp = (current.ItemsUpdate1 & (1 << 25-1)) != 0;
	D.Card9PickUp = (current.ItemsUpdate1 & (1 << 26-1)) != 0;
	D.CardRedPickUp = (current.ItemsUpdate1 & (1 << 27-1)) != 0;
	D.CardBluePickUp = (current.ItemsUpdate1 & (1 << 28-1)) != 0;
	D.CardGreenPickUp = (current.ItemsUpdate1 & (1 << 29-1)) != 0;
	D.SprayPickUp = (current.ItemsUpdate1 & (1 << 30-1)) != 0;
	D.CartridgePickUp = (current.ItemsUpdate1 & (1 << 31-1)) != 0;
	D.RationB1PickUp = (current.ItemsUpdate1 & (1 << 32-1)) != 0;
	D.RationB2PickUp = (current.ItemsUpdate2 & (1 << 33-1)) != 0;
	D.RationB3PickUp = (current.ItemsUpdate2 & (1 << 34-1)) != 0;

	// count all bools for items pick ups
	D.ItemsPickedUp = (new []{
		D.CigarettesPickedUp,
		D.BandanaPickedUp,
		D.BinocularsPickedUp,
		D.NVGogglesPickedUp,
		D.InfraredGogglesPickUp,
		D.GasMaskPickUp,
		D.BodyArmorPickedUp,
		D.OxygenTankPickedUp,
		D.MineDetectorPickedUp,
		D.HangGliderPickUp,
		D.CardboardBoxPickUp,
		D.BucketPickUp,
		D.ColdMedicinePickUp,
		D.CassetteTapePickUp,
		D.Egg1PickUp,
		D.Egg2PickUp,
		D.BroochPickUp,
		D.Card1PickUp,
		D.Card2PickUp,
		D.Card3PickUp,
		D.Card4PickUp,
		D.Card5PickUp,
		D.Card6PickUp,
		D.Card7PickUp,
		D.Card8PickUp,
		D.Card9PickUp,
		D.CardRedPickUp,
		D.CardBluePickUp,
		D.CardGreenPickUp,
		D.SprayPickUp,
		D.CartridgePickUp,
		D.RationB1PickUp,
		D.RationB2PickUp,
		D.RationB3PickUp,
	}).Count(x=>x);

	vars.ItemsPickedUp = D.ItemsPickedUp + " out of 33";

	vars.SnakeHealth = current.Health + " out of " + current.MaxHealth;

	vars.Floor = current.FloorNumber > 2?current.FloorNumber - 2 + "F":"B" + (3-current.FloorNumber).ToString();

/*
	// define string that can contain the value based on dictionary key
	string loc = null;
	// look up map name based on floor value
	if (D.Location.TryGetValue(current.Floo rVal, out loc)) {
		vars.Location = loc;
	}
	*/

	// if bit for bandana is set to 1, use New Game Plus, if not use New Game data
	vars.NGorNGP = (current.ItemsUpdate1 & (1 << 2-1)) != 0?"New Game":"New Game Plus";
}

gameTime {
	if (true) {	
		return TimeSpan.FromMilliseconds(current.GameTime * 1000 / (current.regCode == "SLES"?16.667:15));
	} else {
		return TimeSpan.FromMilliseconds((current.BSGameTimeMinutes * 60 + current.BSGameTimeSeconds) * 1000);
	}
}

isLoading {
	return true;
}

start {
	if (current.GameState != 8 && old.GameState == 8 && old.GameTime == 0) return true;
}
split {	
	var D = vars.D;

	if (current.GameState == 24 && old.GameState != 24 && settings["final_split"]) return true;
	if (current.BroochFrozenTimer > 15 && old.BroochFrozenTimer == 15 && settings["brooch_frozen"]) return true;


	// as long as we're not on the post Metal Gear D / Big Boss Checkpoint
	// where items get dropped and picked up again, leading to double splits
	if(current.EU_CheckpointFlag < 44) {
		// the following block is used to split on weapon pick up or drop (drops usually don't happen)
		var splitname = "_pickup";
		// use temp data
		uint lookUpThisWeapon = 0;
		var weaponName ="";
		// on value change for the weaponsupdate variable
		if(current.WeaponsUpdate != old.WeaponsUpdate) {
			//if the new value is bigger, a weapon got added
			if(current.WeaponsUpdate > old.WeaponsUpdate) {
				// get the log of 2 from this new number, so we know which ID to look up
				lookUpThisWeapon = Convert.ToUInt32(Math.Log(current.WeaponsUpdate - old.WeaponsUpdate));
			// if the new value is smaller, a weapon got removed
			} else {
				splitname = "_drop";
				// get the log of 2 from this new number, so we know which ID to look up
				lookUpThisWeapon = Convert.ToUInt32(Math.Log(old.WeaponsUpdate - current.WeaponsUpdate));
			}

			// define string that can contain the value based on dictionary key
			string loc = null;
			// now that we know the log of 2 from the difference, we know which item ID to look up
			if (D.Weapons.TryGetValue(lookUpThisWeapon, out loc)) {
				weaponName = loc;
			}
			// after everything is done, we can check if a split setting has been set to true for this weapon being picked up OR dropped and split accordingly
			if(settings[(string)weaponName + (string)splitname]) return true;
		}

		// the following block is used to split on weapon pick up or drop (drops usually don't happen)
		// use temp data
		splitname = "_pickup";
		uint lookUpThisEquipment = 0;
		var equipmentName ="";
		// on value change for the weaponsupdate variable
		if(current.ItemsUpdate1 != old.ItemsUpdate1) {
			//if the new value is bigger, a weapon got added
			if(current.ItemsUpdate1 > old.ItemsUpdate1) {
				// get the log of 2 from this new number, so we know which ID to look up
				lookUpThisEquipment = Convert.ToUInt32(Math.Log(current.ItemsUpdate1 - old.ItemsUpdate1, 2));
			// if the new value is smaller, a weapon got removed
			} else {
				splitname = "_drop";
				// get the log of 2 from this new number, so we know which ID to look up
				lookUpThisEquipment = Convert.ToUInt32(Math.Log(old.ItemsUpdate1 - current.ItemsUpdate1, 2));
			}

			// define string that can contain the value based on dictionary key
			string loc = null;
			// now that we know the log of 2 from the difference, we know which item ID to look up
			if (D.Equipment.TryGetValue(lookUpThisEquipment, out loc)) {
				equipmentName = loc;
			}
			// after everything is done, we can check if a split setting has been set to true for this weapon being picked up OR dropped and split accordingly
			if(settings[(string)equipmentName + (string)splitname]) return true;
		}

		// the following block is used to split on equipment pick up or drop (drops usually don't happen)
		// use temp data
		splitname = "_pickup";
		uint lookUpThisEquipment2 = 0;
		var equipmentName2 ="";
		// on value change for the weaponsupdate variable
		if(current.ItemsUpdate2 != old.ItemsUpdate2) {
			//if the new value is bigger, a weapon got added
			if(current.ItemsUpdate2 > old.ItemsUpdate2) {
				// get the log of 2 from this new number, so we know which ID to look up
				lookUpThisEquipment2 = Convert.ToUInt32(Math.Log(current.ItemsUpdate2 - old.ItemsUpdate2, 2)) + 31;
			// if the new value is smaller, a weapon got removed
			} else {
				splitname = "_drop";
				// get the log of 2 from this new number, so we know which ID to look up
				lookUpThisEquipment2 = Convert.ToUInt32(Math.Log(old.ItemsUpdate2 - current.ItemsUpdate2, 2)) + 31;
			}

			// define string that can contain the value based on dictionary key
			string loc = null;
			// now that we know the log of 2 from the difference, we know which item ID to look up
			if (D.Equipment.TryGetValue(lookUpThisEquipment2, out loc)) {
				equipmentName2 = loc;
			}
			// after everything is done, we can check if a split setting has been set to true for this weapon being picked up OR dropped and split accordingly
			if(settings[(string)equipmentName2 + (string)splitname]) return true;
		}
	}

	if (old.HealthUpgrade == 0 && current.HealthUpgrade == 1 && settings["black_ninja_split"]) return true;
	if (old.HealthUpgrade == 1 && current.HealthUpgrade == 2 && settings["running_man_split"]) return true;
	if (old.HealthUpgrade == 2 && current.HealthUpgrade == 3 && settings["hindd_split"]) return true;
	if (old.HealthUpgrade == 3 && current.HealthUpgrade == 4 && settings["red_blaster_split"]) return true;
	if (old.HealthUpgrade == 4 && current.HealthUpgrade == 5 && settings["jungle_evil_split"]) return true;
	if (old.HealthUpgrade == 5 && current.HealthUpgrade == 6 && settings["night_fright_split"]) return true;

	// Story Flag Splits
	// from start to post initial codec call (1 being the official start of gameplay)
	if (old.CheckpointFlag == 0 && current.CheckpointFlag == 1 && settings["story_flag_1"]) return true;
	// Green Barret section over, reached top of the map with the house - happens only once
	if (old.CheckpointFlag == 13 && current.CheckpointFlag == 50 && settings["green_barret"]) return true;
	// post Dr. Madnar fight after the slide going downstairs
	if (old.CheckpointFlag == 43 && current.CheckpointFlag == 44 && settings["reached_underground"]) return true;
	// post Dr. Madnar fight after the slide going downstairs
	if (old.CheckpointFlag == 44 && current.CheckpointFlag == 45 && settings["metalgeard_split"]) return true;
	if (old.CheckpointFlag == 45 && current.CheckpointFlag == 46 && settings["grayfox_split"]) return true;
	if (old.CheckpointFlag == 46 && current.CheckpointFlag == 47 && settings["bigboss_split"]) return true;

}
/*
reset {
	if((current.BSState == 0) && (current.GameTime == 0) && (current.GameTime != old.GameTime))  return true;

    if ( old.BSState == 5 || (current.BSState != 0 && current.BSState == 0)) {
		return true;
    }
}
*/