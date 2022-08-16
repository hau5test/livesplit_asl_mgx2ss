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
/*
	D.Location = new Dictionary<uint, string>() {
		{ 0,  "Docks" },
		{ 1,  "B1 - Ground Floor" },
		{ 2,  "B1 - First Floor" },
		{ 3,  "B1 - Second Floor" },
		{ 4,  "B1 - Underground" },
		{ 5,  "Desert 1" },
		{ 6,  "B1 - Elevator" },
		{ 7,  "B1 - Roof" },
		{ 8,  "B2 - Ground Floor" },
		{ 9,  "B2 - First Floor" },
		{ 10,  "B2 - Underground" },
		{ 11,  "Desert 2" },
		{ 12,  "B2 - Elevator" },
		{ 13,  "B2 - Hellroof" },
		{ 14,  "B3 - Ground Floor" },
		{ 15,  "B3 - Underground" },
		{ 16,  "B2 - Elevator" },
		{ 17,  "B3 - Escape" }
	};
*/
	// define all variables in start up so they can be set before an active run is going on
	vars.Rank = "";
	vars.NGorNGP = "";
	vars.Location = "";
	vars.Floor = "";

	settings.Add("story_splits", true, "Story Flag Splits");
	settings.Add("green_barret", true, "Finished Green Barret Section", "story_splits");
	settings.Add("meet_holly", true, "Met Holly first time (card 4)", "story_splits");
	settings.Add("meet_dr_madnar", true, "Met Dr. Madnar first time (card 5)", "story_splits");
	settings.Add("brooch_frozen", true, "Froze Brooch", "story_splits");
	settings.Add("fought_four_horsemen", true, "Fought the four horsemen", "story_splits");
	settings.Add("owl_hatched", true, "Owl Hatched", "story_splits");
	settings.Add("reached_underground", true, "Reached Underground After Dr. Madnar", "story_splits");

	settings.Add("final_split", true, "Final Split when fade to black finishes");

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

/*
	settings.Add("binocular_pickup", false, "Split on Binocular Collection","items_pickup");
	settings.Add("nvgoggles_pickup", false, "Split on Night Vision Goggles Collection","items_pickup");
	settings.Add("irgoggles_pickup", false, "Split on Infrared Goggles Collection","items_pickup");
	settings.Add("gas_mask_pickup", false, "Split on Gas Mask Collection","items_pickup");
	settings.Add("body_armor_pickup", false, "Split on Body Armor Collection","items_pickup");
	settings.Add("oxygen_tank_pickup", false, "Split on Oxygen Tank Collection","items_pickup");
	settings.Add("mine_detector_pickup", false, "Split on Mine Detector Collection","items_pickup");
	settings.Add("cardboard_box_pickup", false, "Split on Cardboard Box Collection","items_pickup");
	settings.Add("bucket_pickup", false, "Split on Bucket Collection","items_pickup");
	settings.Add("cold_medicine_pickup", false, "Split on Cold Medicine Collection","items_pickup");
	settings.Add("cassette_pickup", false, "Split on Cassette Collection","items_pickup");
	settings.Add("egg1_pickup", true, "Split on Egg 1 Collection","items_pickup");
	settings.Add("card1_pickup", true, "Split on Card 1 Collection","items_pickup");
	settings.Add("card2_pickup", true, "Split on Card 2 Collection","items_pickup");
	settings.Add("card3_pickup", true, "Split on Card 3 Collection","items_pickup");
	settings.Add("card4_pickup", true, "Split on Card 4 Collection","items_pickup");
	settings.Add("card5_pickup", true, "Split on Card 5 Collection","items_pickup");
	settings.Add("card6_pickup", true, "Split on Card 6 Collection","items_pickup");
	settings.Add("cardred_pickup", false, "Split on Red Card Collection","items_pickup");
	settings.Add("cardblue_pickup", false, "Split on Blue Card Collection","items_pickup");
	settings.Add("cardgreen_pickup", false, "Split on Green Card Collection","items_pickup");
	settings.Add("spray_pickup", false, "Split on Spray Collection","items_pickup");
	settings.Add("cartridge_pickup", true, "Split on Cartridge Collection","items_pickup");
	settings.Add("ration_b1_pickup", false, "Split on Ration B1 Collection","items_pickup");
	settings.Add("ration_b2_pickup", false, "Split on Ration B2 Collection","items_pickup");
	settings.Add("ration_b3_pickup", false, "Split on Ration B3 Collection","items_pickup");
	settings.Add("infinitegun2_pickup", true, "Split on Infinite Gun 2 Collection","items_pickup");
	*/
	settings.Add("items_pickup", true, "Split on Items Collection");
	settings.Add("card7_pickup", true, "Split on Card 7 Collection","items_pickup");
	settings.Add("card8_pickup", true, "Split on Card 8 Collection","items_pickup");
	settings.Add("card9_pickup", true, "Split on Card 9 Collection","items_pickup");
	settings.Add("hang_glider_pickup", false, "Split on Hang Glider Collection","items_pickup");
	settings.Add("hang_glider_drop", false, "Split on Post Hang Glider Segment (remove from Inventory)","items_pickup");
	settings.Add("egg2_pickup", true, "Split on Owl Egg Collection","items_pickup");
	settings.Add("brooch_pickup", true, "Split on Brooch Collection","items_pickup");

	settings.Add("bosses_splits", false, "Split on Boss Completion");
	settings.Add("black_ninja_split", false, "Split on Black Ninja Completion", "bosses_splits");
	settings.Add("running_man_split", false, "Split on Running Man Completion", "bosses_splits");
	settings.Add("hindd_split", false, "Split on Hind D Completion", "bosses_splits");
	settings.Add("red_blaster_split", false, "Split on Red Blaster Completion", "bosses_splits");
	settings.Add("jungle_evil_split", false, "Split on Jungle Evil Completion", "bosses_splits");
	settings.Add("night_fright_split", false, "Split on Night Fright Completion", "bosses_splits");
	/*
	settings.Add("four_horsemen_split", false, "Split on Four Horsemen Completion", "bosses_splits");
	settings.Add("dr_madnar_split", false, "Split on Dr. Madnar Completion", "bosses_splits");
	settings.Add("metal_gear_split", false, "Split on Metal Gear Completion", "bosses_splits");
	settings.Add("gray_fox_split", false, "Split on Gray Fox Completion", "bosses_splits");
	settings.Add("big_boss_split", false, "Split on Big Boss Completion", "bosses_splits");
	*/

/*
	settings.Add("story_flag_1", true, "Story Flag 1 Split","story_splits");
	settings.Add("story_flag_2", true, "Story Flag 2 Split","story_splits");
	settings.Add("story_flag_3", true, "Story Flag 3 Split","story_splits");
	settings.Add("story_flag_4", true, "Story Flag 4 Split","story_splits");
	settings.Add("story_flag_5", true, "Story Flag 5 Split","story_splits");
	settings.Add("story_flag_6", true, "Story Flag 6 Split","story_splits");
	settings.Add("story_flag_7", true, "Story Flag 7 Split","story_splits");
	settings.Add("story_flag_8", true, "Story Flag 8 Split","story_splits");
	settings.Add("story_flag_9", true, "Story Flag 9 Split","story_splits");
	settings.Add("story_flag_10", true, "Story Flag 10 Split","story_splits");
	settings.Add("story_flag_11", true, "Story Flag 11 Split","story_splits");
	settings.Add("story_flag_12", true, "Story Flag 12 Split","story_splits");
	settings.Add("story_flag_13", true, "Story Flag 13 Split","story_splits");
	settings.Add("story_flag_14", true, "Story Flag 14 Split","story_splits");
	settings.Add("story_flag_15", true, "Story Flag 15 Split","story_splits");
	settings.Add("story_flag_16", true, "Story Flag 16 Split","story_splits");
	settings.Add("story_flag_17", true, "Story Flag 17 Split","story_splits");
	settings.Add("story_flag_18", true, "Story Flag 18 Split","story_splits");
	settings.Add("story_flag_19", true, "Story Flag 19 Split","story_splits");
	settings.Add("story_flag_20", true, "Story Flag 20 Split","story_splits");
	settings.Add("story_flag_21", true, "Story Flag 21 Split","story_splits");
	settings.Add("story_flag_22", true, "Story Flag 22 Split","story_splits");
	settings.Add("story_flag_23", true, "Story Flag 23 Split","story_splits");
	settings.Add("story_flag_24", true, "Story Flag 24 Split","story_splits");
	settings.Add("story_flag_25", true, "Story Flag 25 Split","story_splits");
	settings.Add("story_flag_26", true, "Story Flag 26 Split","story_splits");
	settings.Add("story_flag_27", true, "Story Flag 27 Split","story_splits");
	settings.Add("story_flag_28", true, "Story Flag 28 Split","story_splits");
	settings.Add("story_flag_29", true, "Story Flag 29 Split","story_splits");
	settings.Add("story_flag_30", true, "Story Flag 30 Split","story_splits");
	settings.Add("story_flag_31", true, "Story Flag 31 Split","story_splits");
	settings.Add("story_flag_32", true, "Story Flag 32 Split","story_splits");
	settings.Add("story_flag_33", true, "Story Flag 33 Split","story_splits");
	settings.Add("story_flag_34", true, "Story Flag 34 Split","story_splits");
	settings.Add("story_flag_35", true, "Story Flag 35 Split","story_splits");
	settings.Add("story_flag_36", true, "Story Flag 36 Split","story_splits");
	settings.Add("story_flag_37", true, "Story Flag 37 Split","story_splits");
	settings.Add("story_flag_38", true, "Story Flag 38 Split","story_splits");
	settings.Add("story_flag_39", true, "Story Flag 39 Split","story_splits");
	settings.Add("story_flag_40", true, "Story Flag 40 Split","story_splits");
	settings.Add("story_flag_41", true, "Story Flag 41 Split","story_splits");
	settings.Add("story_flag_42", true, "Story Flag 42 Split","story_splits");
	settings.Add("story_flag_43", true, "Story Flag 43 Split","story_splits");
	settings.Add("story_flag_44", true, "Story Flag 44 Split","story_splits");
	settings.Add("story_flag_45", true, "Story Flag 45 Split","story_splits");
	settings.Add("story_flag_46", true, "Story Flag 46 Split","story_splits");
	settings.Add("story_flag_47", true, "Story Flag 47 Split","story_splits");
	*/
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
	// if Item 27 (bandana) is in equipment slot 1 horizontal 2 vertical, use New Game Plus, if not use New Game data
	vars.NGorNGP = current.InventorySlot12 != 27?"New Game":"New Game Plus";
*/
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

	if(current.WeaponsUpdate != old.WeaponsUpdate) {
		if (D.PistolPickedUp && settings["pistol_pickup"]) return true;
		if (D.SMGPickedUp && settings["smg_pickup"]) return true;
		if (D.GrenadePickUp && settings["grenades_pickup"]) return true;
		if (D.StingerPickUp && settings["stinger_pickup"]) return true;
		if (D.RCMissilePickedUp && settings["rcm_pickup"]) return true;
		if (D.PExplosivesPickedUp && settings["pexplosives_pickup"]) return true;
		if (D.MinePickedUp && settings["mines_pickup"]) return true;
		if (D.CamoPickUp && settings["camo_pickup"]) return true;
		if (D.GasGrenadePickUp && settings["gas_grenade_pickup"]) return true;
		if (D.MousePickUp && settings["mouse_pickup"]) return true;
		if (D.LighterPickUp && settings["lighter_pickup"]) return true;
		if (D.InfiniteGunPickUp && settings["infinitegun_pickup"]) return true;
		if (D.SilencerPickUp && settings["silencer_pickup"]) return true;
	}

/*
	if(old.ItemsUpdate1 != current.ItemsUpdate1) {
		if (D.BinocularsPickedUp && settings["binocular_pickup"]) return true;
		if (D.NVGogglesPickedUp && settings["nvgoggles_pickup"]) return true;
		if (D.InfraredGogglesPickUp && settings["irgoggles_pickup"]) return true;
		if (D.GasMaskPickUp && settings["gas_mask_pickup"]) return true;
		if (D.BodyArmorPickedUp && settings["body_armor_pickup"]) return true;
		if (D.OxygenTankPickedUp && settings["oxygen_tank_pickup"]) return true;
		if (D.MineDetectorPickedUp && settings["mine_detector_pickup"]) return true;
		if (D.CardboardBoxPickUp && settings["cardboard_box_pickup"]) return true;
		if (D.BucketPickUp && settings["bucket_pickup"]) return true;
		if (D.ColdMedicinePickUp && settings["cold_medicine_pickup"]) return true;
		if (D.CassetteTapePickUp && settings["cassette_pickup"]) return true;
		if (D.Egg1PickUp && settings["egg1_pickup"]) return true;
		if (D.CardRedPickUp && settings["cardred_pickup"]) return true;
		if (D.CardBluePickUp && settings["cardblue_pickup"]) return true;
		if (D.CardGreenPickUp && settings["cardgreen_pickup"]) return true;
		if (D.SprayPickUp && settings["spray_pickup"]) return true;
		if (D.CartridgePickUp && settings["cartridge_pickup"]) return true;
		if (D.RationB1PickUp && settings["ration_b1_pickup"]) return true;
	}
	if(old.ItemsUpdate2 != current.ItemsUpdate2) {
		if (D.RationB2PickUp && settings["ration_b2_pickup"]) return true;
		if (D.RationB3PickUp && settings["ration_b3_pickup"]) return true;
		if (D.InfiniteGun2PickUp && settings["infinitegun2_pickup"]) return true;
	}
	*/
	if(old.ItemsUpdate1 != current.ItemsUpdate1 && current.CheckpointFlag >= 44) {
		if ((current.D.HangGliderPickUp != old.D.HangGliderPickUp) && (current.D.HangGliderPickUp == 1) && settings["hang_glider_pickup"]) return true;
		if ((current.D.HangGliderPickUp != old.D.HangGliderPickUp) && (current.D.HangGliderPickUp == 0) && settings["hang_glider_drop"]) return true;
		if (current.D.Card1PickUp != old.D.Card1PickUp && settings["card1_pickup"]) return true;
		if (current.D.Card2PickUp != old.D.Card2PickUp && settings["card2_pickup"]) return true;
		if (current.D.Card3PickUp != old.D.Card3PickUp && settings["card3_pickup"]) return true;
		if (current.D.Card4PickUp != old.D.Card4PickUp && settings["meet_holly"]) return true;
		if (current.D.Card5PickUp != old.D.Card5PickUp && settings["meet_dr_madnar"]) return true;
		if (current.D.Card6PickUp != old.D.Card6PickUp && settings["card6_pickup"]) return true;
		if ((current.D.Card7PickUp == 1) && (old.D.Card7PickUp == 0) && settings["fought_four_horsemen"]) return true;
		if ((current.D.Card8PickUp == 1) && (old.D.Card8PickUp == 0) && settings["card8_pickup"]) return true;
		if ((current.D.Card9PickUp == 1) && (old.D.Card9PickUp == 0) && settings["card9_pickup"]) return true;
		if ((current.D.Egg2PickUp == 1) && (old.D.Egg2PickUp == 0) && settings["egg2_pickup"]) return true;
		if ((current.D.BroochPickUp == 1) && (old.D.BroochPickUp == 0) && settings["brooch_pickup"]) return true;
	}

	if (old.HealthUpgrade == 0 && current.HealthUpgrade == 1 && settings["black_ninja_split"]) return true;
	if (old.HealthUpgrade == 1 && current.HealthUpgrade == 2 && settings["running_man_split"]) return true;
	if (old.HealthUpgrade == 2 && current.HealthUpgrade == 3 && settings["hindd_split"]) return true;
	if (old.HealthUpgrade == 3 && current.HealthUpgrade == 4 && settings["red_blaster_split"]) return true;
	if (old.HealthUpgrade == 4 && current.HealthUpgrade == 5 && settings["jungle_evil_split"]) return true;
	if (old.HealthUpgrade == 5 && current.HealthUpgrade == 6 && settings["night_fright_split"]) return true;
	/*
	if (old.HealthUpgrade == 8 && current.HealthUpgrade == 9 && settings["four_horsemen_split"]) return true;
	if (old.HealthUpgrade == 9 && current.HealthUpgrade == 10 && settings["metal_gear_split"]) return true;
	if (old.HealthUpgrade == 6 && current.HealthUpgrade == 7 && settings["gray_fox_split"]) return true;
	if (old.HealthUpgrade == 7 && current.HealthUpgrade == 8 && settings["big_boss_split"]) return true;
	*/

	// Story Flag Splits
	// from start to post initial codec call (1 being the official start of gameplay)
	if (old.CheckpointFlag == 0 && current.CheckpointFlag == 1 && settings["story_flag_1"]) return true;
	// Green Barret section over, reached top of the map with the house - happens only once
	if (old.CheckpointFlag == 13 && current.CheckpointFlag == 50 && settings["green_barret"]) return true;
	if (old.CheckpointFlag == 43 && current.CheckpointFlag == 44 && settings["reached_underground"]) return true;
	/*
	if (old.CheckpointFlag == 1 && current.CheckpointFlag == 2 && settings["story_flag_2"]) return true;
	if (old.CheckpointFlag == 2 && current.CheckpointFlag == 3 && settings["story_flag_3"]) return true;
	if (old.CheckpointFlag == 3 && current.CheckpointFlag == 4 && settings["story_flag_4"]) return true;
	if (old.CheckpointFlag == 4 && current.CheckpointFlag == 5 && settings["story_flag_5"]) return true;
	if (old.CheckpointFlag == 5 && current.CheckpointFlag == 6 && settings["story_flag_6"]) return true;
	if (old.CheckpointFlag == 6 && current.CheckpointFlag == 7 && settings["story_flag_7"]) return true;
	if (old.CheckpointFlag == 7 && current.CheckpointFlag == 8 && settings["story_flag_8"]) return true;
	if (old.CheckpointFlag == 8 && current.CheckpointFlag == 9 && settings["story_flag_9"]) return true;
	if (old.CheckpointFlag == 9 && current.CheckpointFlag == 10 && settings["story_flag_10"]) return true;
	if (old.CheckpointFlag == 10 && current.CheckpointFlag == 11 && settings["story_flag_11"]) return true;
	if (old.CheckpointFlag == 11 && current.CheckpointFlag == 12 && settings["story_flag_12"]) return true;
	if (old.CheckpointFlag == 12 && current.CheckpointFlag == 13 && settings["story_flag_13"]) return true;
	if (old.CheckpointFlag == 13 && current.CheckpointFlag == 14 && settings["story_flag_14"]) return true;
	if (old.CheckpointFlag == 14 && current.CheckpointFlag == 15 && settings["story_flag_15"]) return true;
	if (old.CheckpointFlag == 15 && current.CheckpointFlag == 16 && settings["story_flag_16"]) return true;
	if (old.CheckpointFlag == 16 && current.CheckpointFlag == 17 && settings["story_flag_17"]) return true;
	if (old.CheckpointFlag == 17 && current.CheckpointFlag == 18 && settings["story_flag_18"]) return true;
	if (old.CheckpointFlag == 18 && current.CheckpointFlag == 19 && settings["story_flag_19"]) return true;
	if (old.CheckpointFlag == 19 && current.CheckpointFlag == 20 && settings["story_flag_20"]) return true;
	if (old.CheckpointFlag == 20 && current.CheckpointFlag == 21 && settings["story_flag_21"]) return true;
	if (old.CheckpointFlag == 21 && current.CheckpointFlag == 22 && settings["story_flag_22"]) return true;
	if (old.CheckpointFlag == 22 && current.CheckpointFlag == 23 && settings["story_flag_23"]) return true;
	if (old.CheckpointFlag == 23 && current.CheckpointFlag == 24 && settings["story_flag_24"]) return true;
	if (old.CheckpointFlag == 24 && current.CheckpointFlag == 25 && settings["story_flag_25"]) return true;
	if (old.CheckpointFlag == 25 && current.CheckpointFlag == 26 && settings["story_flag_26"]) return true;
	if (old.CheckpointFlag == 26 && current.CheckpointFlag == 27 && settings["story_flag_27"]) return true;
	if (old.CheckpointFlag == 27 && current.CheckpointFlag == 28 && settings["story_flag_28"]) return true;
	if (old.CheckpointFlag == 28 && current.CheckpointFlag == 29 && settings["story_flag_29"]) return true;
	if (old.CheckpointFlag == 29 && current.CheckpointFlag == 30 && settings["story_flag_30"]) return true;
	if (old.CheckpointFlag == 30 && current.CheckpointFlag == 31 && settings["story_flag_31"]) return true;
	if (old.CheckpointFlag == 31 && current.CheckpointFlag == 32 && settings["story_flag_32"]) return true;
	if (old.CheckpointFlag == 32 && current.CheckpointFlag == 33 && settings["story_flag_33"]) return true;
	if (old.CheckpointFlag == 33 && current.CheckpointFlag == 34 && settings["story_flag_34"]) return true;
	if (old.CheckpointFlag == 34 && current.CheckpointFlag == 35 && settings["story_flag_35"]) return true;
	if (old.CheckpointFlag == 35 && current.CheckpointFlag == 36 && settings["story_flag_36"]) return true;
	if (old.CheckpointFlag == 36 && current.CheckpointFlag == 37 && settings["story_flag_37"]) return true;
	if (old.CheckpointFlag == 37 && current.CheckpointFlag == 38 && settings["story_flag_38"]) return true;
	if (old.CheckpointFlag == 38 && current.CheckpointFlag == 39 && settings["story_flag_39"]) return true;
	if (old.CheckpointFlag == 39 && current.CheckpointFlag == 40 && settings["story_flag_40"]) return true;
	if (old.CheckpointFlag == 40 && current.CheckpointFlag == 41 && settings["story_flag_41"]) return true;
	if (old.CheckpointFlag == 41 && current.CheckpointFlag == 42 && settings["story_flag_42"]) return true;
	if (old.CheckpointFlag == 42 && current.CheckpointFlag == 43 && settings["story_flag_43"]) return true;
	if (old.CheckpointFlag == 43 && current.CheckpointFlag == 44 && settings["story_flag_44"]) return true;
	if (old.CheckpointFlag == 44 && current.CheckpointFlag == 45 && settings["story_flag_45"]) return true;
	if (old.CheckpointFlag == 45 && current.CheckpointFlag == 46 && settings["story_flag_46"]) return true;
	if (old.CheckpointFlag == 46 && current.CheckpointFlag == 47 && settings["story_flag_47"]) return true;
	*/


/*
    if (current.GameTime > 0) {
        //on entering the elevator on building 1
        if (current.FloorVal == 6) {
            if (old.FloorVal == 1) {
            //if previous map was Building 1 - Ground Floor
                return true;
            } else if (old.FloorVal == 3) {
            //if previous map was Building 1 - First Floor
                return true;
            } else if (old.FloorVal == 4) {
            //if previous map was Building 1 - Underground
                return true;
            } else if (old.FloorVal == 2) {
            //if previous map was Building 1 - MGK Floor
                return true;
            }
        }
        //on capture on B1 Ground Floor to being put in the underground
        if ((current.FloorVal == 4) && (old.FloorVal == 1)) return true;

        //on switching from Building 1 - Roof to Building 1 - Ground Floor via parachute drop
        if ((current.FloorVal == 1) && (old.FloorVal == 7)) return true;

        //on entering Desert between Building 1 to Building 2 with B1 - GF as previous map
        if ((current.FloorVal == 5) && (old.FloorVal == 1)) return true;

        //on entering Building 2 with connecting desert as previous map
        if ((current.FloorVal == 8) && (old.FloorVal == 5)) return true;

        //on entering the elevator on building 2
        if (current.FloorVal == 12) {
            if (old.FloorVal == 8) {
            //if previous map was Building 2 - Ground Floor
                return true;
            } else if (old.FloorVal == 13) {
            //if previous map was Building 2 - Hell Roof
                return true;
            } else if (old.FloorVal == 10) {
            //if previous map was Building 2 - Underground
                return true;
            }
        }

        //on ranking up from Rank 3 to Rank 4
        // if ((current.ClassValue == 3) && (old.ClassValue == 2)) return true;

        //on entering the B2 elevator, but only if the amount of continues for a single checkpoint 5 (reaching death abuse)
        //and on transitioning between B2 Elevator and going back into Building 2 - First Floor again
        // marking the end of the death abuse segment
        if ((current.ClassValue == 3) && (current.ContPerCheckpoint == 5) && (current.FloorVal == 9) && (old.FloorVal == 12)) return true;

        //on entering the B2 elevator, but only if the amount of continues for a single checkpoint is higher than 4
        //and on transitioning between Building 2 - First Floor going into the B2 Elevator
        if ((current.ClassValue == 3) && (current.ContPerCheckpoint > 4) && (current.FloorVal == 12) && (old.FloorVal == 9)) return true;

        // for big boss, the above check will be accepted if the continues per checkpoint are exactly 0
        // for an intended Big Boss rank run
        if ((current.ClassValue == 3) && (current.ContPerCheckpoint == 0) && (current.FloorVal == 12) && (old.FloorVal == 9)) return true;

        // on reaching Building 3
        if (current.FloorVal == 14) {
            if (old.FloorVal == 8) {
            // if previous map was B2 Ground Floor
                return true;
            } else if (old.FloorVal == 11) {
            // if previous map was Connecting Desert between Building 2 and Building 3
                return true;
            }
        }

        // on returning back to Building 2 Ground Floor after having visited Building 3 (post Dirty Duck)
        if ((current.FloorVal == 8) && (old.FloorVal == 14)) return true;

        // going from Buildin 2 Ground Floor into the connecting desert between Building 2 and Building 3
        if ((current.FloorVal == 11) && (old.FloorVal == 8)) return true;
        
        // going from Desert between B2 and B3 into Building 2 Ground Floor
        if ((current.FloorVal == 8) && (old.FloorVal == 11)) return true;
        
        // on entering Building 3 elevator after having visited Building 3 Ground Floor
        if ((current.FloorVal == 16) && (old.FloorVal == 14)) return true;

        // on entering Building 3 Underground
        if (current.FloorVal == 15) {
            // after map has switched from underground to TX-55 boss room
            if ((old.SubFloorVal == 16) && (current.SubFloorVal == 57)) return true;
            // after map has switched from TX-55 boss room to Big Boss Boss fight room
            if ((old.SubFloorVal == 57) && (current.SubFloorVal == 56)) return true;
        }
        // on entering the final map
        if ((current.FloorVal == 17) && (old.FloorVal == 15)) return true;
        
    }

    // during Boss Survival
    if ((old.BSState == 4) && (current.BSState == 6)) return true;

	// NTSC-U main menu state to define end of run
	if ((current.MainMenuState == 22288560) && (current.MainMenuState != old.MainMenuState)) return true;

	// NTSC-J (both) main menu state to define end of run
	if ((current.MainMenuState == 19351936) && (current.MainMenuState != old.MainMenuState)) return true;

	// PAL main menu state to define end of run
	if ((current.MainMenuState == 22295024) && (current.MainMenuState != old.MainMenuState)) return true;

	// PC main menu state to define end of run
	if ((current.MainMenuState == 192594032) && (current.MainMenuState != old.MainMenuState)) return true;

	// PC main menu state to define end of run
	if ((current.MainMenuState == 2214592509) && (current.MainMenuState != old.MainMenuState)) return true;
*/
}
/*
reset {
	if((current.BSState == 0) && (current.GameTime == 0) && (current.GameTime != old.GameTime))  return true;

    if ( old.BSState == 5 || (current.BSState != 0 && current.BSState == 0)) {
		return true;
    }
}
*/