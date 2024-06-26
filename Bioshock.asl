state("bioshock", "Steam 1.1")
{
	byte  fontainePhase : 0x8BC810, 0x0, 0x20, 0x4C, 0x1108;
	int   lvl           : 0x8D1B38;
	int   loading       : 0x8D666C;
}
state("bioshock", "GOG 1.1")
{
	byte  fontainePhase : 0x9A4668, 0x0, 0x20, 0x4C, 0x1108;
	int   lvl           : 0x9B9990;
	int   loading       : 0x9BE4D4;
}

startup 
{
	vars.startPos = new Vector3f(502f, 1184f, 73f);
	
	vars.Distance2D = (Func<Vector3f, Vector3f, float>)((vec1, vec2) =>
	{
		float resultX = (float)Math.Sqrt((vec1.X - vec2.X) * (vec1.X - vec2.X));
		float resultY = (float)Math.Sqrt((vec1.Y - vec2.Y) * (vec1.Y - vec2.Y));
		return resultX + resultY;
	});
	/*
	vars.DistanceVec3f = (Func<Vector3f, Vector3f, Vector3f>)((vec1, vec2) =>
	{
		float resultX = (float)Math.Sqrt((vec1.X - vec2.X) * (vec1.X - vec2.X));
		float resultY = (float)Math.Sqrt((vec1.Y - vec2.Y) * (vec1.Y - vec2.Y));
		float resultZ = (float)Math.Sqrt((vec1.Z - vec2.Z) * (vec1.Z - vec2.Z));
		return new Vector3f(resultX, resultY, resultZ);
	});
	*/
	vars.fromRCC=false; //Prevent splitting when loading to RCC from Heph the 2nd time
	vars.lvls=new string[]
	{
		"The Crash Site", "Welcome to Rapture", "Medical Pavillion",
		"Neptunes Bounty", "Smugglers Hideout", "Arcadia (Not skipped)",
		"Farmers Market", "Arcadia", "Fort Frolic", "Hephaestus",
		"Rapture Central Control", "Olympus Heights", "Apollo Square",
		"Point Prometheus", "Proving Grounds", "Fontaine",
	};
	
	foreach(var item in vars.lvls)
	{
		if(item == "The Crash Site") settings.Add(item, (timer.Run.Count > 13)); //Set default state depending on number of splits
		else if(item == "Arcadia (Not skipped)"||item == "Farmers Market") settings.Add(item, false);
		else settings.Add(item, true);
	}
}

init
{
	vars.fromRCC=false;
	vars.prevLvl=0;
	
	var module = modules.First();
	var name = module.ModuleName;
	var size = module.ModuleMemorySize;
	
	print("Size = "+size);
	
	switch(size)
	{
		case 11763712:
			version = "Steam 1.1";
			break;
		case 11747328:
			version = "GOG 1.1";
			break;
		default:
			version = "Unknown";
			var gameMessageText = "Unknown "+name+" "+size;
			var gameMessage = MessageBox.Show(
				"It appears you're running an unknown/newer version of the game.\n"+
				"This ASL script might not work.\n\n"+
				"Please @PrototypeAlpha#7561 on the BioShock Speedrunning discord with "+
				"the following:\n"+gameMessageText+"\n\n"+
				"Press OK to copy the above info to the clipboard and close this message.",
				"BioShock ASL | LiveSplit",
				MessageBoxButtons.OKCancel,MessageBoxIcon.Warning
			);
			if (gameMessage == DialogResult.OK) Clipboard.SetText(gameMessageText);
			break;
	}
	print("Version = "+version);
	
	if(version == "GOG 1.1")
		vars.Position = new MemoryWatcher<Vector3f>(new DeepPointer(0x9A4664, 0x0, 0x10, 0x414, 0x1C0));
	else
		vars.Position = new MemoryWatcher<Vector3f>(new DeepPointer(0x8BC80C, 0x0, 0x10, 0x414, 0x1C0));
	
	if(version == "Unknown")
		vars.Position.Enabled = false; // Disable updating position if game version is unknown
	
	timer.IsGameTimePaused=false;
}

exit{timer.IsGameTimePaused=true;}

start
{
	vars.fromRCC=false;
	
	// Don't autostart if loading, not on Crash Site level, unknown game version, or currently underwater
	if(current.loading != 0 || current.lvl != 239 || !vars.Position.Enabled || vars.Position.Current.Z < vars.startPos.Z)
		return;
	// Autostart on loading from a save
	if(old.loading != 0 && current.loading == 0)
		return vars.Position.Current.DistanceXY(vars.startPos) < 2f;
	// Autostart on gaining control after opening cutscene
	return (vars.Position.Old.DistanceXY(vars.startPos) < 2f && vars.Position.Current.DistanceXY(vars.startPos) > 2f) || vars.Position.Current.Z < vars.Position.Old.Z;
}

isLoading{return current.loading != 0;}

split
{
	if(current.lvl != old.lvl)
	{
		if(current.lvl == 0 && old.lvl != 0) vars.prevLvl=old.lvl;
		else if(vars.prevLvl == 239  && current.lvl == 568) {vars.prevLvl=current.lvl; return settings["The Crash Site"];}
		else if(vars.prevLvl == 814  && current.lvl == 779) {vars.prevLvl=current.lvl; return settings["Welcome to Rapture"];}
		else if(vars.prevLvl == 1104 && current.lvl == 919) {vars.prevLvl=current.lvl; return settings["Medical Pavillion"];}
		else if(vars.prevLvl == 1297 && current.lvl == 162) {vars.prevLvl=current.lvl; return settings["Neptunes Bounty"];}
		else if(vars.prevLvl == 256  && current.lvl == 917) {vars.prevLvl=current.lvl; return settings["Smugglers Hideout"];}
		else if(vars.prevLvl == 1294 && current.lvl == 520) {vars.prevLvl=current.lvl; return settings["Arcadia (Not skipped)"];}
		else if(vars.prevLvl == 748  && current.lvl == 917) {vars.prevLvl=current.lvl; return settings["Farmers Market"];}
		else if(vars.prevLvl == 1294 && current.lvl == 788) {vars.prevLvl=current.lvl; return settings["Arcadia"];}
		else if(vars.prevLvl == 1116 && current.lvl == 598) {vars.prevLvl=current.lvl; return settings["Fort Frolic"];}
		else if(vars.prevLvl == 855  && current.lvl == 174) {vars.prevLvl=current.lvl; return settings["Hephaestus"] && !vars.fromRCC;}
		else if(vars.prevLvl == 272  && current.lvl == 598) {vars.prevLvl=current.lvl; vars.fromRCC=true;}
		else if(vars.prevLvl == 272  && current.lvl == 614) {vars.prevLvl=current.lvl; return settings["Rapture Central Control"];}
		else if(vars.prevLvl == 877  && current.lvl == 533) {vars.prevLvl=current.lvl; return settings["Olympus Heights"];}
		else if(vars.prevLvl == 766  && current.lvl == 747) {vars.prevLvl=current.lvl; return settings["Apollo Square"];}
		else if(vars.prevLvl == 1060 && current.lvl == 324) {vars.prevLvl=current.lvl; return settings["Point Prometheus"];}
		else if(vars.prevLvl == 478  && current.lvl == 119) {vars.prevLvl=current.lvl; return settings["Proving Grounds"];}
	}
	else if(current.lvl==197 && old.fontainePhase==3 && current.fontainePhase==4)      return settings["Fontaine"];
}

reset{return current.loading != 0 && old.loading != 0 && current.lvl == 239 && vars.Position.Enabled && vars.Position.Current.DistanceXY(vars.startPos) < 2f;}

update{vars.Position.Update(game);}
