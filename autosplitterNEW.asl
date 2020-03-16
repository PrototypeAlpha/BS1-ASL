//Made by TheShalty
//Fontaine split by Glurmo

state("bioshock")
{
	int level: 0x8D1B38;
	int fontainDrainCount: 0x8BC810, 0x0, 0x20, 0x4C, 0x1108;
	int inGame: 0x827610, 0x1C, 0x9C, 0x10, 0x4C, 0x2E8, 0x60;
}

startup 
{
	settings.Add("crash", true, "The Crash Site");
	settings.Add("welcome", true, "Welcome to Rapture");
	settings.Add("medical", true, "Medical Pavillion");
	settings.Add("neptunes", true, "Neptunes Bounty");
	settings.Add("smugglers", true, "Smugglers Hideout");
	settings.Add("arcadia1", false, "Arcadia1");
	settings.Add("farmers", false, "Farmers Market");
	settings.Add("arcadia", true, "Arcadia");
	settings.Add("frolic", true, "Fort Frolic");
	settings.Add("hephaestus", true, "Hephaestus");
	settings.Add("rcc", true, "Rapture Control Center");
	settings.Add("olympus", true, "Olympus Heights");
	settings.Add("apollo", true, "Apollo Square");
	settings.Add("prometheus", true, "Point Prometheus");
	settings.Add("grounds", true, "Proving grounds");
	settings.Add("fontaine", true, "Fontaine");
}

start
{
	vars.levels = new List<string>();
	vars.lastLevel = 0;
	
	if(settings["crash"])		{vars.levels.Add("crash");}
	if(settings["welcome"])		{vars.levels.Add("welcome");}
	if(settings["medical"])		{vars.levels.Add("medical");}
	if(settings["neptunes"])	{vars.levels.Add("neptunes");}
	if(settings["smugglers"])	{vars.levels.Add("smugglers");}
	if(settings["arcadia1"])	{vars.levels.Add("arcadia1");}
	if(settings["farmers"])		{vars.levels.Add("farmers");}
	if(settings["arcadia"])		{vars.levels.Add("arcadia");}
	if(settings["frolic"])		{vars.levels.Add("frolic");}
	if(settings["hephaestus"])	{vars.levels.Add("hephaestus");}
	if(settings["rcc"])			{vars.levels.Add("rcc");}
	if(settings["olympus"])		{vars.levels.Add("olympus");}
	if(settings["apollo"])		{vars.levels.Add("apollo");}
	if(settings["prometheus"])	{vars.levels.Add("prometheus");}
	if(settings["grounds"])		{vars.levels.Add("grounds");}
	if(settings["fontaine"])	{vars.levels.Add("fontaine");}
	
	
	return(current.level == 239 && current.inGame == 1 && old.inGame != 1);
}

split
{
		if(current.level == 0 && old.level != 0){vars.lastLevel = old.level;}
		
		if(vars.levels.Contains("crash") 		&& vars.lastLevel == 239 	&& current.level == 568)	{vars.levels.Remove("crash"); vars.lastLevel = 0; return true;}
		if(vars.levels.Contains("welcome") 		&& vars.lastLevel == 814 	&& current.level == 779)	{vars.levels.Remove("welcome"); vars.lastLevel = 0; return true;}
		if(vars.levels.Contains("medical") 		&& vars.lastLevel == 1104 	&& current.level == 919)	{vars.levels.Remove("medical"); vars.lastLevel = 0; return true;}
		if(vars.levels.Contains("neptunes") 	&& vars.lastLevel == 1297 	&& current.level == 162)	{vars.levels.Remove("neptunes"); vars.lastLevel = 0; return true;}
		if(vars.levels.Contains("smugglers")	&& vars.lastLevel == 256 	&& current.level == 917)	{vars.levels.Remove("smugglers"); vars.lastLevel = 0; return true;}
		if(vars.levels.Contains("arcadia1")		&& vars.lastLevel == 1294	&& current.level == 520)	{vars.levels.Remove("arcadia1"); vars.lastLevel = 0; return true;}
		if(vars.levels.Contains("farmers")		&& vars.lastLevel == 748	&& current.level == 917)	{vars.levels.Remove("farmers"); vars.lastLevel = 0; return true;}
		if(vars.levels.Contains("arcadia") 		&& vars.lastLevel == 1294 	&& current.level == 788)	{vars.levels.Remove("arcadia"); vars.lastLevel = 0; return true;}
		if(vars.levels.Contains("frolic") 		&& vars.lastLevel == 1116 	&& current.level == 598)	{vars.levels.Remove("frolic"); vars.lastLevel = 0; return true;}
		if(vars.levels.Contains("hephaestus") 	&& vars.lastLevel == 855 	&& current.level == 174)	{vars.levels.Remove("hephaestus"); vars.lastLevel = 0; return true;}
		if(vars.levels.Contains("rcc") 			&& vars.lastLevel == 272 	&& current.level == 614)	{vars.levels.Remove("rcc"); vars.lastLevel = 0; return true;}
		if(vars.levels.Contains("olympus") 		&& vars.lastLevel == 877 	&& current.level == 533)	{vars.levels.Remove("olympus"); vars.lastLevel = 0; return true;}
		if(vars.levels.Contains("apollo") 		&& vars.lastLevel == 766 	&& current.level == 747)	{vars.levels.Remove("apollo"); vars.lastLevel = 0; return true;}
		if(vars.levels.Contains("prometheus") 	&& vars.lastLevel == 1060 	&& current.level == 324)	{vars.levels.Remove("prometheus"); vars.lastLevel = 0; return true;}
		if(vars.levels.Contains("grounds") 		&& vars.lastLevel == 478 	&& current.level == 119)	{vars.levels.Remove("grounds"); vars.lastLevel = 0; return true;}
		if(vars.levels.Contains("fontaine")		&& current.level == 197 	&& old.fontainDrainCount == 3 && current.fontainDrainCount == 4) {vars.levels.Remove("fontaine"); vars.lastLevel = 0; return true;}
}