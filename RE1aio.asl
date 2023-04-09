/*
By deserteagle417
Thanks to Dchaps for the original scripts and for finding the memory values and to Darazanjoll, StevenMayte,
Clix_Gaming, and WitchRain for later versions of the scritps. I've only contributed the characterID value.
Thanks to SHiiDO for the checkpoint splits.
Thanks to WitchRain, Raclesis, and Mercy for helping testing the splits on the absurd number of categories this game has.
Thanks to Mysterion for help with my RE0 autosplitter, which has become the basis for several of my ASLs now.
Thanks to Krayziejaz for finding that the item splitter broke later in the run, which led me to find that Jill's character ID changes in a few spots!
*/

state("Biohazard")
{
    uint time        : 0x6A8E10;
    byte mainMenu    : 0x6A8E57;
    uint gameState   : 0x833090;
    byte gameStart   : 0x833097;
    byte hp          : 0x83523C;
    byte stageID     : 0x8386F0;
    byte roomID      : 0x8386F1;
    byte camID       : 0x8386F2;
    byte oldRoom     : 0x8386F3;
    byte characterID : 0x8386F9;
}

state("Resident Evil")
{
    uint time        : 0x6A8E10;
    byte mainMenu    : 0x6A8E57;
    uint gameState   : 0x833090;
    byte gameStart   : 0x833097;
    byte hp          : 0x83523C;
    byte stageID     : 0x8386F0;
    byte roomID      : 0x8386F1;
    byte camID       : 0x8386F2;
    byte oldRoom     : 0x8386F3;
    byte characterID : 0x8386F9;
}

startup
{   
    settings.Add("route", false, "Routed Splits");
        settings.SetToolTip("route", "Routed door splits will only split when going in the correct direction.");
        settings.CurrentDefaultParent = "route";
        settings.Add("disc", false, "Choose ONE option from each group below to set your category.");

    //Character Choice
	    settings.Add("break1", false, "----------Character------------------------------------------------------------");
		settings.Add("jill", true, "Jill");
		settings.Add("chris", false, "Chris");

    //Ending Choice
	    settings.Add("break2", false, "----------Ending----------------------------------------------------------------");
		settings.Add("bad", true, "Bad Ending");
		settings.Add("good", false, "Good Ending");

    //Glitches Choice
	    settings.Add("break3", false, "----------Glitches--------------------------------------------------------------");
		settings.Add("nmg", true, "No Major Glitches");
		settings.Add("mg", false, "Major Glitches");

    //Restriction Choice
	    settings.Add("break4", false, "----------Restriction-----------------------------------------------------------");
		settings.Add("none", true, "No Restriction");
		settings.Add("knife", false, "Knife Only");
    
    //Split Type Choice
        settings.Add("break5", false, "----------Which type of splits?-------------------------------------------");
		settings.Add("doors", true, "Door Splits");
		settings.Add("set", false, "Segmented splits");
    
    //Route Options
        settings.Add("break6", false, "----------Optional Route Alterations-------------------------------------------");
		settings.Add("egh", false, "Bank when entering Guardhouse");
            settings.SetToolTip("egh", "In applicable categories, switch the guardhouse bank to the beginning, before 001 room.");
        settings.Add("p42", false, "Skip Plant 42 Glitch (Jill Only)");
            settings.SetToolTip("p42", "Skips the splits for entering the Guardhouse bathroom for Flame Rounds and reloading the boss fight.");
        settings.Add("p42rl", false, "Skip Plant 42 Fight Reload");
            settings.SetToolTip("p42", "In applicable categories, skips the splits for reloading the Plant 42 boss fight.");
            settings.CurrentDefaultParent = null;

    settings.Add("other", true, "Other door split options. Useful for Category Extensions.");
        settings.SetToolTip("other", "Disables routed door splits.");
        settings.CurrentDefaultParent = "other";
    
    //Enable Checkpoint Splits
    settings.Add("check", true, "Enable Checkpoint Splits. Works with ALL categories.");
        settings.SetToolTip("check", "Splits on every door transition but will hold up at certain checkpoints based on specific split names.");

    //Basic Door Splits
    settings.Add("basic", false, "Basic Door Splits");
        settings.SetToolTip("basic", "Splits on every door transition.");
        settings.CurrentDefaultParent = null;

    /*Battle Game Room Splits
    settings.Add("battle", false, "Battle Game Splits");
        settings.SetToolTip("battle", "Splits on all door transitions. Not compatible with item splits.");
        settings.CurrentDefaultParent = null;*/

    //Key Items
	vars.KeyItems = new List<int>()
    {
        51, 31,  2, 38,  7, 52, 35, 32, 33, 53,
        41, 66, 44, 46, 45, 29, 62, 59, 57, 58,
        54, 64,         30,  6, 63,         60, 
        55,     42, 10   
    };

	vars.KeyItemSettings = new List<String>()
	{
        "Sword Key (Chris Only)", "Emblem", "Beretta (Chris Only)", "Chemical", "Bazooka", "Armor Key", "Music Notes", "Gold Emblem", "Blue Jewel", "Shield Key",
        "Wind Crest", "Serum", "Moon Crest", "Sun Crest", "Star Crest", "Square Crank", "Red Book", "C. Room Key", "002 Key", "003 Key",
        "Helmet Key", "Doom Book 1 (Red)", "Battery (for Courtyard)", "MO Disk (Library)", "Hex Crank", "Flamethrower (Chris Only)", "Doom Book 2 (Blue)", "MO Disk (Underground)", "MO Disk (Lab)", "Power Room Key", 
        "Master Key", "Battery (for Lab Elevator)", "Flare", "Rocket Launcher"
    };

	settings.Add("item", false, "Key Item Splits");
		settings.CurrentDefaultParent = "item";
		for(int i = 0; i < 22; i++)
        {
        	settings.Add("" + vars.KeyItems[i].ToString(), true, "" + vars.KeyItemSettings[i].ToString());
    	}
        settings.Add("batt1", true, "" + vars.KeyItemSettings[22].ToString());
        settings.Add("MO1", true, "" + vars.KeyItemSettings[23].ToString());
        settings.Add("" + vars.KeyItems[22].ToString(), true, "" + vars.KeyItemSettings[24].ToString());
        settings.Add("" + vars.KeyItems[23].ToString(), true, "" + vars.KeyItemSettings[25].ToString());
        settings.Add("" + vars.KeyItems[24].ToString(), true, "" + vars.KeyItemSettings[26].ToString());
        settings.Add("MO2", true, "" + vars.KeyItemSettings[27].ToString());
        settings.Add("MO3", true, "" + vars.KeyItemSettings[28].ToString());
        settings.Add("" + vars.KeyItems[25].ToString(), true, "" + vars.KeyItemSettings[29].ToString());
        settings.Add("" + vars.KeyItems[26].ToString(), true, "" + vars.KeyItemSettings[30].ToString());
        settings.Add("batt2", true, "" + vars.KeyItemSettings[31].ToString());
        settings.Add("" + vars.KeyItems[27].ToString(), true, "" + vars.KeyItemSettings[32].ToString());
        settings.Add("" + vars.KeyItems[28].ToString(), true, "" + vars.KeyItemSettings[33].ToString());
		settings.CurrentDefaultParent = null;

    //Extra Items to Split On
    vars.ExtraItems = new List<int>()
	{
        28, 3, 48, 27, 34, 5, 37, 36, 43
    };

	vars.ExtraItemsSettings = new List<String>()
	{
        "Broken Shotgun", "Shotgun", "Lighter", "V-Jolt", "Red Jewel", "Colt Python", "Eagle Medal", "Wolf Medal", "Slides", 
        "Small Key (Bathroom)", "Small Key (Terrace Entry)", "Small Key (Store Room)", "Small Key (Room 001)", "Small Key (Meeting Room)", "Small Key (Kitchen)"
    };

	//Additional Item Split Options
	settings.Add("extra", false, "Additional Items to Split On");
		settings.CurrentDefaultParent = "extra";
		for(int i = 0; i < 9; i++)
        {
        	settings.Add("" + vars.ExtraItems[i].ToString(), false, "" + vars.ExtraItemsSettings[i].ToString());
    	}
        settings.Add("small1", false, "" + vars.ExtraItemsSettings[9].ToString());
        settings.Add("small2", false, "" + vars.ExtraItemsSettings[10].ToString());
        settings.Add("small3", false, "" + vars.ExtraItemsSettings[11].ToString());
        settings.Add("small4", false, "" + vars.ExtraItemsSettings[12].ToString());
        settings.Add("small5", false, "" + vars.ExtraItemsSettings[13].ToString());
        settings.Add("small6", false, "" + vars.ExtraItemsSettings[14].ToString());
		settings.CurrentDefaultParent = null;

    //Message to Switch to Game Time
	if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {        
        var timingMessage = MessageBox.Show (
            "This game uses In-Game Time (IGT) as the timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time? This is required for verification.",
            "LiveSplit | Resident Evil",
            MessageBoxButtons.YesNo,MessageBoxIcon.Question);
        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
}

init
{    
    //Initialize Variables
    vars.completedSplits = new List<int>();
	vars.Inventory = new byte[8];
	vars.doorIterator = 0;
    vars.skipValue = 500; //used for skipping from the Mansion 1 group of doors to the post-Mansion 1 group.
    vars.inventorySize = 0;
    vars.disks = 0;
    vars.disksPrevious = 0;
    vars.disk1 = 0;
    vars.disk2 = 0;
    vars.disk3 = 0;
    vars.battery1 = 0;
    vars.battery2 = 0;
    vars.keys = 0;
    vars.keysPrevious = 0;
    vars.key1 = 0;
    vars.key2 = 0;
    vars.key3 = 0;
    vars.key4 = 0;
    vars.key5 = 0;
    vars.key6 = 0;
    vars.helmet = 0; //Used for flags for obtaining specific items
    vars.endSplitFlag = 0; //Used to prevent ending split from triggering multiple times
    vars.category = "";
    vars.splitType = "";
    vars.categoryChosen = false;
    vars.splitsChosen = false; //Used to determine and choose a set of doors and door indexes
    vars.doorIndexList = new List<int>(); //Holds door indexes
    vars.Mansion1Doors = new List<Tuple<int,int,int>>(); //Holds index, roomID, stageID tuples

    //Jill Mansion 1 NMG Doors -- Bazooka: 14, 15, 16, 17
    vars.jillNMG = new List<Tuple<int, int, int>>
    {
        Tuple.Create( 0,  5, 0), Tuple.Create( 1,  4, 0), Tuple.Create( 2,  5, 0), Tuple.Create( 3,  6, 0), Tuple.Create( 4,  7, 0), Tuple.Create( 5,  8, 0), Tuple.Create( 6,  9, 0), Tuple.Create( 7, 10, 0), Tuple.Create( 8, 11, 0), Tuple.Create( 9, 24, 0),
        Tuple.Create(10, 11, 0), Tuple.Create(11,  7, 1), Tuple.Create(12,  4, 1), Tuple.Create(13,  3, 1), Tuple.Create(14, 17, 1), Tuple.Create(15, 18, 1), Tuple.Create(16, 17, 1), Tuple.Create(17,  3, 1), Tuple.Create(18,  2, 1), Tuple.Create(19,  1, 1),
        Tuple.Create(20,  1, 0), Tuple.Create(21,  3, 0), Tuple.Create(22, 12, 0), Tuple.Create(23,  3, 0), Tuple.Create(24,  4, 0), Tuple.Create(25, 15, 0), Tuple.Create(26,  4, 0), Tuple.Create(27,  5, 0), Tuple.Create(28,  6, 0), Tuple.Create(29,  3, 1),
        Tuple.Create(30,  4, 1), Tuple.Create(31, 13, 1), Tuple.Create(32,  4, 1), Tuple.Create(33,  3, 1), Tuple.Create(34,  6, 0), Tuple.Create(35,  5, 0), Tuple.Create(36,  4, 0), Tuple.Create(37,  3, 0), Tuple.Create(38, 13, 0), Tuple.Create(39,  3, 0),
        Tuple.Create(40,  1, 0), Tuple.Create(41,  0, 0), Tuple.Create(42,  1, 0), Tuple.Create(43,  1, 1), Tuple.Create(44,  2, 1), Tuple.Create(45,  3, 1), Tuple.Create(46,  4, 1), Tuple.Create(47, 13, 1), Tuple.Create(48, 14, 1), Tuple.Create(49, 16, 1),
        Tuple.Create(50, 14, 1), Tuple.Create(51, 13, 1), Tuple.Create(52,  4, 1), Tuple.Create(53,  5, 1), Tuple.Create(54,  4, 1), Tuple.Create(55,  7, 1), Tuple.Create(56, 11, 0), Tuple.Create(57, 10, 0), Tuple.Create(58, 23, 0), Tuple.Create(59, 10, 0),
        Tuple.Create(60, 26, 0), Tuple.Create(61, 27, 0), Tuple.Create(62,  0, 2)
    };

    //Jill Mansion 1 MG Doors -- Bazooka: 5, 6, 7, 8
    vars.jillMG = new List<Tuple<int, int, int>>
    {
        Tuple.Create( 0,  5, 0), Tuple.Create( 1,  4, 0), Tuple.Create( 2,  5, 0), Tuple.Create( 3,  6, 0), Tuple.Create( 4,  3, 1), Tuple.Create( 5, 17, 1), Tuple.Create( 6, 18, 1), Tuple.Create( 7, 17, 1), Tuple.Create( 8,  3, 1), Tuple.Create( 9,  2, 1),
        Tuple.Create(10,  1, 1), Tuple.Create(11,  1, 0), Tuple.Create(12,  3, 0), Tuple.Create(13, 12, 0), Tuple.Create(14,  3, 0), Tuple.Create(15,  4, 0), Tuple.Create(16,  5, 0), Tuple.Create(17,  4, 0), Tuple.Create(18,  3, 0), Tuple.Create(19, 13, 0),
        Tuple.Create(20,  3, 0), Tuple.Create(21,  4, 0), Tuple.Create(22, 15, 0), Tuple.Create(23,  4, 0), Tuple.Create(24,  5, 0), Tuple.Create(25,  6, 0), Tuple.Create(26,  7, 0), Tuple.Create(27,  8, 0), Tuple.Create(28,  9, 0), Tuple.Create(29, 10, 0),
        Tuple.Create(30, 11, 0), Tuple.Create(31,  7, 1), Tuple.Create(32,  4, 1), Tuple.Create(33,  5, 1), Tuple.Create(34,  4, 1), Tuple.Create(35, 13, 1), Tuple.Create(36,  4, 1), Tuple.Create(37, 13, 1), Tuple.Create(38, 14, 1), Tuple.Create(39, 16, 1), 
        Tuple.Create(40, 14, 1), Tuple.Create(41, 13, 1), Tuple.Create(42,  4, 1), Tuple.Create(43,  7, 1), Tuple.Create(44, 11, 0), Tuple.Create(45, 10, 0), Tuple.Create(46, 23, 0), Tuple.Create(47, 10, 0), Tuple.Create(48, 26, 0), Tuple.Create(49, 27, 0),
        Tuple.Create(50,  0, 2) 
    };

    //Chris Mansion 1 NMG Doors
    vars.chrisNMG = new List<Tuple<int, int, int>>
    {
        Tuple.Create( 0,  5, 0), Tuple.Create( 1,  4, 0), Tuple.Create( 2,  5, 0), Tuple.Create( 3,  6, 0), Tuple.Create( 4,  3, 1), Tuple.Create( 5,  2, 1), Tuple.Create( 6,  1, 1), Tuple.Create( 7,  1, 0), Tuple.Create( 8,  0, 0), Tuple.Create( 9,  1, 0),
        Tuple.Create(10,  3, 0), Tuple.Create(11,  4, 0), Tuple.Create(12, 15, 0), Tuple.Create(13,  4, 0), Tuple.Create(14,  5, 0), Tuple.Create(15,  6, 0), Tuple.Create(16,  7, 0), Tuple.Create(17,  8, 0), Tuple.Create(18,  9, 0), Tuple.Create(19, 10, 0),
        Tuple.Create(20, 11, 0), Tuple.Create(21, 24, 0), Tuple.Create(22, 11, 0), Tuple.Create(23,  7, 1), Tuple.Create(24,  4, 1), Tuple.Create(25,  3, 1), Tuple.Create(26,  6, 0), Tuple.Create(27,  5, 0), Tuple.Create(28,  4, 0), Tuple.Create(29,  3, 0),
        Tuple.Create(30, 13, 0), Tuple.Create(31,  3, 0), Tuple.Create(32, 12, 0), Tuple.Create(33,  3, 0), Tuple.Create(34,  4, 0), Tuple.Create(35, 15, 0), Tuple.Create(36,  4, 0), Tuple.Create(37,  5, 0), Tuple.Create(38,  6, 0), Tuple.Create(39,  3, 1),
        Tuple.Create(40,  4, 1), Tuple.Create(41, 13, 1), Tuple.Create(42, 14, 1), Tuple.Create(43, 16, 1), Tuple.Create(44, 14, 1), Tuple.Create(45, 13, 1), Tuple.Create(46,  4, 1), Tuple.Create(47,  5, 1), Tuple.Create(48,  4, 1), Tuple.Create(49,  7, 1),
        Tuple.Create(50, 11, 0), Tuple.Create(51, 10, 0), Tuple.Create(52, 23, 0), Tuple.Create(53, 10, 0), Tuple.Create(54, 26, 0), Tuple.Create(55, 27, 0), Tuple.Create(56,  0, 2)  
    };

    //Chris Mansion 1 MG Doors
    vars.chrisMG = new List<Tuple<int, int, int>>
    {
        Tuple.Create( 0,  5, 0), Tuple.Create( 1,  4, 0), Tuple.Create( 2,  5, 0), Tuple.Create( 3,  6, 0), Tuple.Create( 4,  3, 1), Tuple.Create( 5,  2, 1), Tuple.Create( 6,  1, 1), Tuple.Create( 7,  1, 0), Tuple.Create( 8,  0, 0), Tuple.Create( 9,  1, 0),
        Tuple.Create(10,  3, 0), Tuple.Create(11, 12, 0), Tuple.Create(12,  3, 0), Tuple.Create(13,  4, 0), Tuple.Create(14, 15, 0), Tuple.Create(15,  4, 0), Tuple.Create(16,  5, 0), Tuple.Create(17,  6, 0), Tuple.Create(18,  5, 0), Tuple.Create(19,  4, 0),
        Tuple.Create(20,  3, 0), Tuple.Create(21, 13, 0), Tuple.Create(22,  3, 0), Tuple.Create(23,  4, 0), Tuple.Create(24, 15, 0), Tuple.Create(25,  4, 0), Tuple.Create(26,  5, 0), Tuple.Create(27,  6, 0), Tuple.Create(28,  3, 1), Tuple.Create(29,  4, 1),
        Tuple.Create(30,  5, 1), Tuple.Create(31,  4, 1), Tuple.Create(32, 13, 1), Tuple.Create(33, 14, 1), Tuple.Create(34, 16, 1), Tuple.Create(35, 14, 1), Tuple.Create(36, 13, 1), Tuple.Create(37,  4, 1), Tuple.Create(38,  3, 1), Tuple.Create(39,  6, 0),
        Tuple.Create(40,  7, 0), Tuple.Create(41,  8, 0), Tuple.Create(42,  9, 0), Tuple.Create(43, 10, 0), Tuple.Create(44, 23, 0), Tuple.Create(45, 10, 0), Tuple.Create(46, 26, 0), Tuple.Create(47, 27, 0), Tuple.Create(48,  0, 2)
    };

    //Post Mansion 1 Master Door List
    vars.postMansion1 = new List<Tuple<int, int, int>>
    {
        Tuple.Create(100,  1, 2), Tuple.Create(101,  2, 2), Tuple.Create(102,  4, 2), Tuple.Create(103,  0, 3), 
        Tuple.Create(104,  3, 3), Tuple.Create(105,  0, 3), //early guardhouse bank
        Tuple.Create(106,  1, 3), Tuple.Create(107,  2, 3), Tuple.Create(108,  1, 3), Tuple.Create(109,  0, 3), Tuple.Create(110,  5, 3), Tuple.Create(111,  8, 3), Tuple.Create(112,  5, 3), Tuple.Create(113,  6, 3), Tuple.Create(114, 13, 3), Tuple.Create(115, 14, 3),
        Tuple.Create(116, 17, 3), Tuple.Create(117, 14, 3), Tuple.Create(118, 16, 3), Tuple.Create(119, 14, 3), Tuple.Create(120, 13, 3), Tuple.Create(121,  6, 3), Tuple.Create(122,  5, 3), Tuple.Create(123,  8, 3), Tuple.Create(124, 10, 3),
        Tuple.Create(125, 11, 3), Tuple.Create(126, 10, 3), //flame rounds
        Tuple.Create(127, 12, 3), Tuple.Create(128,  8, 3), //P42 reload
        Tuple.Create(129, 12, 3), //require helmet key
        Tuple.Create(130,  8, 3), Tuple.Create(131,  5, 3), Tuple.Create(132,  0, 3),
        Tuple.Create(133,  3, 3), Tuple.Create(134,  0, 3), //late guardhouse bank
        Tuple.Create(135,  4, 2), Tuple.Create(136,  2, 2), Tuple.Create(137,  1, 2), Tuple.Create(138,  0, 2), Tuple.Create(139, 27, 5), Tuple.Create(140, 26, 5), Tuple.Create(141, 10, 5), Tuple.Create(142, 25, 5), Tuple.Create(143, 10, 5), Tuple.Create(144, 11, 5),
        Tuple.Create(145, 24, 5), Tuple.Create(146, 11, 5), //yawn 2 bank
        Tuple.Create(147,  7, 6), Tuple.Create(148, 11, 6), Tuple.Create(149, 12, 6), Tuple.Create(150, 26, 6), Tuple.Create(151, 27, 6), Tuple.Create(152, 28, 6), Tuple.Create(153,  0, 6), Tuple.Create(154, 19, 6),
        Tuple.Create(155, 25, 6), Tuple.Create(156, 19, 6), //battery first
        Tuple.Create(157, 22, 6), Tuple.Create(158, 23, 6), Tuple.Create(159, 22, 6), Tuple.Create(160, 19, 6), //MO disk
        Tuple.Create(161, 25, 6), Tuple.Create(162, 19, 6), //battery second
        Tuple.Create(163,  0, 6), Tuple.Create(164, 28, 6),
        Tuple.Create(165, 16, 5), Tuple.Create(166,  4, 5), //without rope (pt 1)
        Tuple.Create(167,  3, 5), Tuple.Create(168,  1, 5), Tuple.Create(169,  3, 5), Tuple.Create(170,  4, 5), //save rebecca
        Tuple.Create(171,  5, 5), Tuple.Create(172,  6, 5), Tuple.Create(173,  7, 5), Tuple.Create(174,  8, 5), Tuple.Create(175,  9, 5), //without rope (pt 2)
        Tuple.Create(176, 27, 6), Tuple.Create(177, 26, 6), Tuple.Create(178, 12, 6), Tuple.Create(179, 11, 6), Tuple.Create(180,  7, 6), Tuple.Create(181, 11, 5), //with rope
        Tuple.Create(182, 10, 5), Tuple.Create(183, 11, 5), Tuple.Create(184, 24, 5), Tuple.Create(185, 11, 5), //exit Mansion 2 bank
        Tuple.Create(186, 10, 5), Tuple.Create(187, 26, 5), Tuple.Create(188, 27, 5), Tuple.Create(189,  0, 2), Tuple.Create(190,  1, 2), Tuple.Create(191,  2, 2), Tuple.Create(192,  0, 2), Tuple.Create(193,  1, 2), Tuple.Create(194,  0, 2), Tuple.Create(195,  2, 2), 
        Tuple.Create(196,  7, 2), Tuple.Create(197,  8, 2), Tuple.Create(198,  9, 2), Tuple.Create(199, 10, 2), Tuple.Create(200,  9, 2), Tuple.Create(201,  8, 2), Tuple.Create(202,  7, 2), Tuple.Create(203, 11, 2), Tuple.Create(204, 12, 2), Tuple.Create(205, 13, 2), 
        Tuple.Create(206, 15, 2), Tuple.Create(207,  6, 2), Tuple.Create(208, 15, 2), Tuple.Create(209,  5, 2), Tuple.Create(210, 16, 2), Tuple.Create(211,  0, 4), Tuple.Create(212,  2, 4), Tuple.Create(213,  3, 4), Tuple.Create(214,  5, 4), Tuple.Create(215,  6, 4), 
        Tuple.Create(216,  5, 4), Tuple.Create(217,  3, 4), Tuple.Create(218,  4, 4), Tuple.Create(219,  3, 4), Tuple.Create(220,  5, 4), Tuple.Create(221, 12, 4), Tuple.Create(222, 15, 4), Tuple.Create(223, 16, 4), Tuple.Create(224, 17, 4), Tuple.Create(225, 16, 4), 
        Tuple.Create(226, 15, 4), Tuple.Create(227, 12, 4), 
        Tuple.Create(228, 14, 4), Tuple.Create(229, 12, 4), //lab flame rounds 
        Tuple.Create(230, 21, 4), Tuple.Create(231, 20, 4), Tuple.Create(232, 19, 4), Tuple.Create(233, 20, 4), Tuple.Create(234, 21, 4), Tuple.Create(235, 12, 4), 
        Tuple.Create(236,  7, 4), Tuple.Create(237,  5, 4), Tuple.Create(238,  8, 4), Tuple.Create(239,  9, 4), Tuple.Create(240,  8, 4), Tuple.Create(241, 11, 4), Tuple.Create(242, 18, 4), Tuple.Create(243, 11, 4), Tuple.Create(244,  8, 4), //rescue partner
        Tuple.Create(245,  5, 4), Tuple.Create(246,  3, 4), Tuple.Create(247,  2, 4), Tuple.Create(248,  0, 4), Tuple.Create(249,  1, 4), Tuple.Create(250, 13, 4), Tuple.Create(251,  3, 2)
    };

    //Door Black Lists -- Determines which doors to skip from the appropriate Mansion 1 list and the master post-Mansion 1 list. These are the values of doorIterator on which we don't split.
    //Jill NMG skips form 63 to 100
    //Jill any% NMG - 177 total splits
    vars.jillAnyNMG = new List<int>()
    {
        104, 105, 125, 126, 127, 128, 133, 134, 157, 158, 159, 160, 161, 162, 167, 168, 169, 170, 176, 177, 
        178, 179, 180, 181, 182, 183, 184, 185, 228, 229, 236, 237, 238, 239, 240, 241, 242, 243, 244
    };

    //Jill any% NMG Knife - 171 total splits
    vars.jillAnyNMGKnife = new List<int>()
    {
         14,  15,  16,  17, 104, 105, 125, 126, 127, 128, 133, 134, 145, 146, 157, 158, 159, 160, 161, 162,
        167, 168, 169, 170, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 228, 229, 236, 237, 238, 239,
        240, 241, 242, 243, 244
    };

    //Jill 100% NMG - 191 total splits
    vars.jill100NMG = new List<int>()
    {
        104, 105, 125, 126, 127, 128, 133, 134, 155, 156, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174,
        175, 182, 183, 184, 185
    };

    //Jill 100% NMG Knife - 185 total splits
    vars.jill100NMGKnife = new List<int>()
    {
         14,  15,  16,  17, 104, 105, 125, 126, 127, 128, 145, 146, 161, 162, 165, 166, 167, 168, 169, 170,
        171, 172, 173, 174, 175, 182, 183, 184, 185, 228, 229
    };

    //Jill MG skips from 51 to 100
    //Jill any% MG - 169 total splits
    vars.jillAnyMG = new List<int>()
    {
        104, 105, 133, 134, 157, 158, 159, 160, 161, 162, 167, 168, 169, 170, 176, 177, 178, 179, 180, 181, 
        182, 183, 184, 185, 228, 229, 236, 237, 238, 239, 240, 241, 242, 243, 244
    };

    //Jill any% MG Knife - 159 total splits
    vars.jillAnyMGKnife = new List<int>()
    {
          5,   6,   7,   8, 104, 105, 125, 126, 127, 128, 133, 134, 145, 146, 157, 158, 159, 160, 161, 162, 
        167, 168, 169, 170, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 228, 229, 236, 237, 238, 239, 
        240, 241, 242, 243, 244
    };

    //Jill 100% MG - 183 total splits
    vars.jill100MG = new List<int>()
    {
        104, 105, 133, 134, 155, 156, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 182, 183, 184,
        185
    };

    //Jill 100% MG Knife - 173 total splits
    vars.jill100MGKnife = new List<int>()
    {
          5,   6,   7,   8, 104, 105, 125, 126, 127, 128, 145, 146, 161, 162, 165, 166, 167, 168, 169, 170,
        171, 172, 173, 174, 175, 182, 183, 184, 185, 228, 229
    };

    //Chris NMG skips from 57 to 100
    //Chris any% NMG - 173 total splits
    vars.chrisAnyNMG = new List<int>()
    {
        104, 105, 125, 126, 145, 146, 157, 158, 159, 160, 161, 162, 167, 168, 169, 170, 176, 177, 178, 179,
        180, 181, 182, 183, 184, 185, 228, 229, 236, 237, 238, 239, 240, 241, 242, 243, 244
    };

    //Chris 100% NMG - 194 total splits
    vars.chris100NMG = new List<int>()
    {
        104, 105, 125, 126, 145, 146, 161, 162, 176, 177, 178, 179, 180, 181, 228, 229
    };

    //Chris MG skips from 49 to 100
    //Chris any% MG - 165 total splits
    vars.chrisAnyMG = new List<int>()
    {
        104, 105, 125, 126, 145, 146, 157, 158, 159, 160, 161, 162, 167, 168, 169, 170, 176, 177, 178, 179,
        180, 181, 182, 183, 184, 185, 228, 229, 236, 237, 238, 239, 240, 241, 242, 243, 244
    };

    //Chris 100% MG - 186 total splits
    vars.chris100MG = new List<int>()
    {
        104, 105, 125, 126, 145, 146, 161, 162, 176, 177, 178, 179, 180, 181, 228, 229
    };

    //Segment Splits
    vars.segments = new List<Tuple<int, int, int, int>>
    {
        Tuple.Create( 0, 15,  4, 0), Tuple.Create( 1,  4,  3, 1), Tuple.Create( 2, 12,  3, 0), Tuple.Create( 3, 16, 14, 1), Tuple.Create( 4, 31,  0, 2), 
        Tuple.Create( 5, 31,  0, 3), Tuple.Create( 6, 13, 14, 3), Tuple.Create( 7, 31,  4, 2), Tuple.Create( 8, 31, 27, 5), Tuple.Create( 9, 12, 26, 6),
        Tuple.Create(10, 31, 16, 5), Tuple.Create(11, 28, 27, 6), Tuple.Create(12, 31,  0, 2), Tuple.Create(13,  2,  7, 2), Tuple.Create(14, 12, 13, 2), 
        Tuple.Create(15, 31,  0, 4), Tuple.Create(16, 17, 16, 4), Tuple.Create(17, 19, 20, 4), Tuple.Create(18,  9,  8, 4)
    };

    //Segment White Lists -- Determines which segments to split on from the segment door list. These are the values of doorIterator on which we split.
    //Jill any% NMG Segments
    vars.jillSegNMG = new List<int>()
    { 1, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 14, 15, 16, 17};

    //Jill 100% NMG Segments
    vars.jillSegNMG100 = new List<int>()
    { 1, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14, 15, 16, 17, 18};

    //Jill any% MG Segments
    vars.jillSegMG = new List<int>()
    { 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 14, 15, 16, 17};

    //Jill 100% MG Segments
    vars.jillSegMG100 = new List<int>()
    { 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14, 15, 16, 17, 18};

    //Chris any% NMG Segments
    vars.chrisSegNMG = new List<int>()
    { 0, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 14, 15, 16, 17};

    //Chris 100% NMG Segments
    vars.chrisSegNMG100 = new List<int>()
    { 0, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 14, 15, 16, 17, 18};

    //Chris any% MG Segments
    vars.chrisSegMG = new List<int>()
    { 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 14, 15, 16, 17};

    //Chris 100% MG Segments
    vars.chrisSegMG100 = new List<int>()
    { 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 14, 15, 16, 17, 18};
}

update
{    
    //Reset variables when the timer is reset.
	if(timer.CurrentPhase == TimerPhase.NotRunning)
	{
        vars.completedSplits.Clear();
        vars.doorIterator = 0;
        vars.inventorySize = 0;
        vars.disks = 0;
        vars.disksPrevious = 0;
        vars.disk1 = 0;
        vars.disk2 = 0;
        vars.disk3 = 0;
        vars.batteries = 0;
        vars.battery1 = 0;
        vars.battery2 = 0;
        vars.keys = 0;
        vars.keysPrevious = 0;
        vars.key1 = 0;
        vars.key2 = 0;
        vars.key3 = 0;
        vars.key4 = 0;
        vars.key5 = 0;
        vars.key6 = 0;
        vars.helmet = 0;
        vars.endSplitFlag = 0;
        vars.category = "";
        vars.splitType = "";
        vars.categoryChosen = false;
        vars.splitsChosen = false;
        vars.doorIndexList.Clear();
        vars.Mansion1Doors.Clear();
    }

    //Iterate through the inventory slots to return their values
    for(int i = 0; i < 8; i++)
	{
        vars.Inventory[i] = new DeepPointer(0x838814 + i*(0x2)).Deref<byte>(game);
    }

    //Set the inventory size according to the current character
    if(current.characterID == 1 || current.characterID == 5) //Jill has characterID 1 (most places) and 5 (in underground and labs) and has 8 inventory slots
    {
        vars.inventorySize = 8;
    } else { //Chris and Rebecca have characterIDs 0 and 3 (resp.), and 6 inventory slots (Chris probably changes in underground and labs, too, actually)
        vars.inventorySize = 6;
    }

    //Category Chooser -- creates a string that identifies the category and split type to use.
    //After the category string is set, a flag is set to true so this does not continue to evaluate during the run.
    if(!vars.categoryChosen && settings["route"])
    {
        if(settings["jill"])
        {
            vars.category += "jill";
        }
        if(settings["chris"])
        {
            vars.category += "chris";
        }
        if(settings["nmg"])
        {
            vars.category += "-nmg";
        }
        if(settings["mg"])
        {
            vars.category += "-mg";
        }
        if(settings["bad"])
        {
            vars.category += "-bad";
        }
        if(settings["good"])
        {
            vars.category += "-good";
        }
        if(settings["none"])
        {
            vars.category += "-none";
        }
        if(settings["knife"])
        {
            vars.category += "-knife";
        }
        if(settings["doors"])
        {
            vars.category += "-doors";
            vars.splitType += "doors";
        }
        if(settings["set"])
        {
            vars.category += "-set";
            vars.splitType += "set";
        }
        vars.categoryChosen = true;
    }

    /*Once category has been chosen, use the category string to set the doorIterator list for the category and choose the set of Mansion 1 doors
      In the case of segment splits, just the doorIterator list is chosen
      A flag is set once the splits are chosen so this switch does not continue to run.*/
    if(vars.categoryChosen && !vars.splitsChosen)
    {
        string runCategory = vars.category;
        switch(runCategory)
        {
            case ("jill-nmg-bad-none-doors"):
                foreach (int element in vars.jillAnyNMG)
                {vars.doorIndexList.Add(element);}
                foreach (Tuple<int,int,int> element in vars.jillNMG)
                {vars.Mansion1Doors.Add(element);}
                vars.skipValue = 63;
                vars.splitsChosen = true;
                break;
            
            case ("jill-nmg-bad-knife-doors"):
                foreach (int element in vars.jillAnyNMGKnife)
                {vars.doorIndexList.Add(element);}
                foreach (Tuple<int,int,int> element in vars.jillNMG)
                {vars.Mansion1Doors.Add(element);}
                vars.skipValue = 63;
                vars.splitsChosen = true;
                break;
            
            case ("jill-nmg-good-none-doors"):
                foreach (int element in vars.jill100NMG)
                {vars.doorIndexList.Add(element);}
                foreach (Tuple<int,int,int> element in vars.jillNMG)
                {vars.Mansion1Doors.Add(element);}
                vars.skipValue = 63;
                vars.splitsChosen = true;
                break;
            
            case ("jill-nmg-good-knife-doors"):
                foreach (int element in vars.jill100NMGKnife)
                {vars.doorIndexList.Add(element);}
                foreach (Tuple<int,int,int> element in vars.jillNMG)
                {vars.Mansion1Doors.Add(element);}
                vars.skipValue = 63;
                vars.splitsChosen = true;
                break;
            
            case ("jill-mg-bad-none-doors"):
                foreach (int element in vars.jillAnyMG)
                {vars.doorIndexList.Add(element);}
                foreach (Tuple<int,int,int> element in vars.jillMG)
                {vars.Mansion1Doors.Add(element);}
                vars.skipValue = 51;
                vars.splitsChosen = true;
                break;
            
            case ("jill-mg-bad-knife-doors"):
                foreach (int element in vars.jillAnyMGKnife)
                {vars.doorIndexList.Add(element);}
                foreach (Tuple<int,int,int> element in vars.jillMG)
                {vars.Mansion1Doors.Add(element);}
                vars.skipValue = 51;
                vars.splitsChosen = true;
                break;
            
            case ("jill-mg-good-none-doors"):
                foreach (int element in vars.jill100MG)
                {vars.doorIndexList.Add(element);}
                foreach (Tuple<int,int,int> element in vars.jillMG)
                {vars.Mansion1Doors.Add(element);}
                vars.skipValue = 51;
                vars.splitsChosen = true;
                break;
            
            case ("jill-mg-good-knife-doors"):
                foreach (int element in vars.jill100MGKnife)
                {vars.doorIndexList.Add(element);}
                foreach (Tuple<int,int,int> element in vars.jillMG)
                {vars.Mansion1Doors.Add(element);}
                vars.skipValue = 51;
                vars.splitsChosen = true;
                break;
            
            case ("chris-nmg-bad-none-doors"):
            case ("chris-nmg-bad-knife-doors"):
                foreach (int element in vars.chrisAnyNMG)
                {vars.doorIndexList.Add(element);}
                foreach (Tuple<int,int,int> element in vars.chrisNMG)
                {vars.Mansion1Doors.Add(element);}
                vars.skipValue = 57;
                vars.splitsChosen = true;
                break;
            
            case ("chris-nmg-good-none-doors"):
            case ("chris-nmg-good-knife-doors"):
                foreach (int element in vars.chris100NMG)
                {vars.doorIndexList.Add(element);}
                foreach (Tuple<int,int,int> element in vars.chrisNMG)
                {vars.Mansion1Doors.Add(element);}
                vars.skipValue = 57;
                vars.splitsChosen = true;
                break;
            
            case ("chris-mg-bad-none-doors"):
            case ("chris-mg-bad-knife-doors"):
                foreach (int element in vars.chrisAnyMG)
                {vars.doorIndexList.Add(element);}
                foreach (Tuple<int,int,int> element in vars.chrisMG)
                {vars.Mansion1Doors.Add(element);}
                vars.skipValue = 49;
                vars.splitsChosen = true;
                break;
            
            case ("chris-mg-good-none-doors"):
            case ("chris-mg-good-knife-doors"):
                foreach (int element in vars.chris100MG)
                {vars.doorIndexList.Add(element);}
                foreach (Tuple<int,int,int> element in vars.chrisMG)
                {vars.Mansion1Doors.Add(element);}
                vars.skipValue = 49;
                vars.splitsChosen = true;
                break;

            case ("jill-nmg-bad-none-set"):
            case ("jill-nmg-bad-knife-set"):
                foreach (int element in vars.jillSegNMG)
                {vars.doorIndexList.Add(element);}
                vars.splitsChosen = true;
                break;

            case ("jill-nmg-good-none-set"):
            case ("jill-nmg-good-knife-set"):
                foreach (int element in vars.jillSegNMG100)
                {vars.doorIndexList.Add(element);}
                vars.splitsChosen = true;
                break;

            case ("jill-mg-bad-none-set"):
            case ("jill-mg-bad-knife-set"):
                foreach (int element in vars.jillSegMG)
                {vars.doorIndexList.Add(element);}
                vars.splitsChosen = true;
                break;

            case ("jill-mg-good-none-set"):
            case ("jill-mg-good-knife-set"):
                foreach (int element in vars.jillSegMG100)
                {vars.doorIndexList.Add(element);}
                vars.splitsChosen = true;
                break;

            case ("chris-nmg-bad-none-set"):
            case ("chris-nmg-bad-knife-set"):
                foreach (int element in vars.jillchrisSegNMG)
                {vars.doorIndexList.Add(element);}
                vars.splitsChosen = true;
                break;

            case ("chris-nmg-good-none-set"):
            case ("chris-nmg-good-knife-set"):
                foreach (int element in vars.chrisSegNMG100)
                {vars.doorIndexList.Add(element);}
                vars.splitsChosen = true;
                break;

            case ("chris-mg-bad-none-set"):
            case ("chris-mg-bad-knife-set"):
                foreach (int element in vars.chrisSegMG)
                {vars.doorIndexList.Add(element);}
                vars.splitsChosen = true;
                break;

            case ("chris-mg-good-none-set"):
            case ("chris-mg-good-knife-set"):
                foreach (int element in vars.chrisSegMG100)
                {vars.doorIndexList.Add(element);}
                vars.splitsChosen = true;
                break;

            default:
                print("You didn't follow directions!");
                break;
        }
    }
    
	//Uncomment debug information in the event of an update.
	//print(modules.First().ModuleMemorySize.ToString());
}

start
{
    //current.gameStart becomes 0x20 when a new game is started and current.gameState starts with a 9 when the save is loaded. 
    //This is used in conjunction with the cam, stage, and room IDs to further protect the start flag since these IDs can be set after a run is finished.
    return ((current.gameStart == 0x20) || ((current.gameState & 0x90000000) == 0x90000000)) && (current.camID == 0 && current.stageID == 0 && current.roomID == 6);
}

split
{
    //Final Split -- Always Active -- gameState changes to 0x00000000 when the final cutscene begins
    if(current.gameState == 0 && current.stageID == 2 && vars.endSplitFlag == 0)
    {
        vars.endSplitFlag = 1;
        return true;
    }
    
    //Create variables to check for the variables in each item slot
    byte[] currentInventory = (vars.Inventory as byte[]);
    
    //Item Splits
	if((settings["item"] || settings["extra"] || (vars.helmet == 0 && current.stageID == 3 && current.roomID == 12)))
    {
        //Reset the battery, MO disk, and small key total to zero
        vars.batteries = 0;
        vars.disks = 0;
        vars.keys = 0;

        //Cycle through the inventory to look for items
        for(int i = 0; i < vars.inventorySize; i++)
        {
	    	//Check if any inventory slots include the values in our items lists, check if the split was already completed and if the setting for the given item is activated
	    	if((vars.KeyItems.Contains(currentInventory[i]) || vars.ExtraItems.Contains(currentInventory[i])) 
                && !vars.completedSplits.Contains(currentInventory[i]) && settings[currentInventory[i].ToString()])
            {
            	vars.completedSplits.Add(currentInventory[i]);
            	return true;
        	}

            //While cycling through the inventory, count the number of batteries, MO disks, and small keys present. Sets the helmet key flag to 1 if it is detected.
            switch(currentInventory[i])
            {
                case (39):
                    vars.batteries++;
                    break;
                case (40):
                    vars.disks++;
                    break;
                case (54):
                    vars.helmet = 1;
                    break;
                case (61):
                    vars.keys++;
                    break;
            };
        }

        //Special Splits for items which there are more than one of. There are flags for each item that are set to 1 in the room they are in when the item is picked up so it cannot be split on again.
        //Battery Splits
        if((settings["batt1"] && current.roomID == 25 && current.stageID == 6) || 
           (settings["batt2"] && current.roomID == 1 && current.stageID == 4))
        {
            //If the attic battery is active, the battery count is 1 and the attic battery flag is 0, change the flag to 1 and split
            if(settings["batt1"] && vars.battery1 == 0 && vars.batteries == 1 && current.roomID == 25 && current.stageID == 6)
            {
                vars.battery1++;
                return true;
            }

            //If the lab battery is active, the battery count is 1 and the lab battery flag is 0, change the flag to 1 and split
            if(settings["batt2"] && vars.battery2 == 0 && vars.batteries == 1 && current.roomID == 1 && current.stageID == 4)
            {
                vars.battery2++;
                return true;
            }
        }

        //For MO Disks and Small Keys, we are looking for a change in the quantity of them in the inventory since we can have more than one at a time.
        //MO Disk Splits
        if((settings["MO1"] && current.roomID == 23 && current.stageID == 6) || 
           (settings["MO2"] && current.roomID == 15 && current.stageID == 2) || 
           (settings["MO3"] && current.roomID == 3 && current.stageID == 4))
        {
            //If the library MO disk is active, the disk count increases in the Library and the library MO disk flag is 0, change the flag to 1 and split
            if(settings["MO1"] && vars.disk1 == 0 && vars.disks > vars.disksPrevious && current.roomID == 23 && current.stageID == 6)
            {
                vars.disk1++;
                return true;
            }

            //If the caves MO disk is active, the disk count increases in the second boulder room and the caves MO disk flag is 0, change the flag to 1 and split
            if(settings["MO2"] && vars.disk2 == 0 && vars.disks > vars.disksPrevious && current.roomID == 15 && current.stageID == 2)
            {
                vars.disk2++;
                return true;
            }

            //If the lab MO disk is active, the disk count increases in the lab stair room and the lab MO disk flag is 0, change the flag to 1 and split
            if(settings["MO3"] && vars.disk3 == 0 && vars.disks > vars.disksPrevious && current.roomID == 3 && current.stageID == 4)
            {
                vars.disk3++;
                return true;
            }
        }

        //Small Key Splits
        if((settings["small1"] && current.roomID == 19 && (current.stageID == 0 || current.stageID == 5)) || 
           (settings["small2"] && current.roomID == 17 && (current.stageID == 1 || current.stageID == 6)) || 
           (settings["small3"] && current.roomID == 27 && (current.stageID == 0 || current.stageID == 5)) ||
           (settings["small4"] && current.roomID == 1  && current.stageID == 3) || 
           (settings["small5"] && current.roomID == 15 && current.stageID == 3) || 
           (settings["small6"] && current.roomID == 28 && current.stageID == 6))
        {
            //Bathroom small key
            if(settings["small1"] && vars.key1 == 0 && vars.keys > vars.keysPrevious && current.roomID == 19 && (current.stageID == 0 || current.stageID == 5))
            {
                vars.key1++;
                return true;
            }

            //Terrace Entry small key
            if(settings["small2"] && vars.key2 == 0 && vars.keys > vars.keysPrevious && current.roomID == 17 && (current.stageID == 1 || current.stageID == 6))
            {
                vars.key2++;
                return true;
            }

            //Store Room small key
            if(settings["small3"] && vars.key3 == 0 && vars.keys > vars.keysPrevious && current.roomID == 27 && (current.stageID == 0 || current.stageID == 5))
            {
                vars.key3++;
                return true;
            }

            //Room 001 small Key
            if(settings["small4"] && vars.key4 == 0 && vars.keys > vars.keysPrevious && current.roomID == 1 && current.stageID == 3)
            {
                vars.key4++;
                return true;
            }

            //Meeting Room small key (P42 roots)
            if(settings["small5"] && vars.key5 == 0 && vars.keys > vars.keysPrevious && current.roomID == 15 && current.stageID == 3)
            {
                vars.key5++;
                return true;
            }

            //Kitchen small key
            if(settings["small6"] && vars.key6 == 0 && vars.keys > vars.keysPrevious && current.roomID == 28 && current.stageID == 6)
            {
                vars.key6++;
                return true;
            }
        }

        //Set the previous disk and key total to the current total.
        vars.disksPrevious = vars.disks;
        vars.keysPrevious = vars.keys;
	}

    //Routed Door Splits
    if(settings["route"] && !settings["check"] && !settings["basic"])
    {
        //when entering the courtyard, skip the doorIterator to 100 to start using post-Mansion 1 door values
        if(vars.doorIterator == vars.skipValue)
        {
            vars.doorIterator = 100;
        }
        //if using early Guardhouse bank, skip the doors for the late bank
        if(settings["egh"] && vars.doorIterator == 133)
        {
            vars.doorIterator+=2;
        }
        //skipping the extra doors involved in plant 42 glitch
        if(settings["p42"] && settings["jill"] && vars.doorIterator == 125)
        {
            vars.doorIterator+=4;
        }
        //skips the 2 doors for reloading the plant 42 fight between phases
        if(settings["p42rl"] && vars.doorIterator == 127)
        {
            vars.doorIterator+=2;
        }
        //ensures you have to have the helmet key in order for the final plant 42 split to activate
        if(vars.doorIterator == 130 && vars.helmet == 0)
        {
            return false;
        }

        //use the split structure of door splits or segmented splits
        string splits = vars.splitType;
        switch(splits)
        {
            case ("doors"):
                if(settings["egh"] && (vars.doorIterator == 104 || vars.doorIterator == 105) && (settings["chris"] || vars.category == "jill-mg-good-knife-doors") && vars.postMansion1.Contains(Tuple.Create(vars.doorIterator,Convert.ToInt32(current.roomID),Convert.ToInt32(current.stageID)))) //exception for early guardhouse bank
                {
                    vars.doorIterator++;
                    return true;
                } 
                else if(!vars.doorIndexList.Contains(vars.doorIterator) && 
                    (vars.Mansion1Doors.Contains(Tuple.Create(vars.doorIterator, Convert.ToInt32(current.roomID), Convert.ToInt32(current.stageID))) 
                    || vars.postMansion1.Contains(Tuple.Create(vars.doorIterator, Convert.ToInt32(current.roomID), Convert.ToInt32(current.stageID))) )) //checks if the doorIterator value is in the index list, and if the doorIterator, roomID, stageID triple is in the route
                {
                    vars.doorIterator++;
                    return true;
                } 
                else if(vars.doorIndexList.Contains(vars.doorIterator) && vars.doorIterator < 248 && !(settings["egh"] && (vars.doorIterator == 104 || vars.doorIterator == 105))) //skip the doorIterator value when it is not in the route
                {
                    vars.doorIterator++;
                }
                break;

            case ("set"):
                if(vars.doorIndexList.Contains(vars.doorIterator) && 
                    vars.segments.Contains(Tuple.Create(vars.doorIterator, Convert.ToInt32(current.oldRoom), Convert.ToInt32(current.roomID), Convert.ToInt32(current.stageID))) )
                {
                    vars.doorIterator++;
                    return true;
                }
                else if(!vars.doorIndexList.Contains(vars.doorIterator) && vars.doorIterator < 19)
                {
                    vars.doorIterator++;
                }
                break;
        }

    }
    
    //Checkpoint Door Splits -- written by SHiiDO
    if(settings["check"] && !settings["basic"])
    {
	    if(timer.CurrentSplit.Name == "Laboratory - End")
	    {
            return current.gameState== 0;
	    } else if(timer.CurrentSplit.Name == "End")
	    {
	    	return current.gameState == 0;
	    } else if(timer.CurrentSplit.Name == "Underground")
	    {
	    	return current.roomID == 0 && current.stageID == 4;
	    } else if(timer.CurrentSplit.Name == "Courtyard 3")
	    {
	    	return current.roomID == 7 && current.stageID == 2;
	    } else if(timer.CurrentSplit.Name == "Mansion 2")
	    {
	    	return current.roomID == 0 && current.stageID == 2;
	    } else if(timer.CurrentSplit.Name == "Courtyard 2")
	    {
	    	return current.roomID == 27 && current.stageID == 5;
	    } else if(timer.CurrentSplit.Name == "Guardhouse")
	    {
	    	return current.roomID == 4 && current.stageID == 2;
	    } else if(timer.CurrentSplit.Name == "Courtyard 1")
	    {
	    	return current.roomID == 0 && current.stageID == 3;
	    } else if(timer.CurrentSplit.Name == "Mansion 1")
	    {
	    	return current.roomID == 0 && current.stageID == 2;
	    } else if(current.stageID != old.stageID)
	    {
	    	return current.stageID != old.stageID;
	    } else {
	    	return current.roomID != old.roomID;
	    }
    }

    //Basic Door Splits
    if(settings["basic"] && !settings["check"] && (old.roomID != current.roomID || old.stageID != current.stageID))
	{
		return true;
	}
}

gameTime
{
    //game timer is a frame counter based off of 30fps
    return TimeSpan.FromSeconds(current.time / 30.0);
}

isLoading
{
    return true;
}

reset
{
    //current.mainMenu has a value of 1 on the main menu. Resets timer when at the main menu
    return current.mainMenu == 0x1;
}