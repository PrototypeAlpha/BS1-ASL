state("bioshock")
{
	bool inGame			:	0x827610, 0x1C, 0x9C, 0x10, 0x4C, 0x2E8, 0x60;
	byte fontainePhase	:	0x8BC810, 0x0, 0x20, 0x4C, 0x1108;
	int	 lvl			:	0x8D1B38;
	bool loading		:	0x8D666C;
}

startup 
{
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
		if(item == "Arcadia (Not skipped)"||item == "Farmers Market") settings.Add(item, false);
		else settings.Add(item, true);
	}
}

init{timer.IsGameTimePaused=false; vars.fromRCC=false; vars.prevLvl=0;}

exit{timer.IsGameTimePaused=true;}

start{vars.fromRCC=false; return current.lvl == 239 && current.inGame && !old.inGame;}

isLoading{return current.loading;}

split
{
	if(current.lvl != old.lvl){
		if(current.lvl == 0 && old.lvl != 0) vars.prevLvl=old.lvl;
		print("[ASL] vars.prevLvl: "+vars.prevLvl+" | current.lvl: "+current.lvl);
		
		if(current.lvl == 0) return;
		else if(vars.prevLvl == 239 	&& current.lvl == 568)	{vars.prevLvl=current.lvl; return settings["The Crash Site"];}
		else if(vars.prevLvl == 814 	&& current.lvl == 779)	{vars.prevLvl=current.lvl; return settings["Welcome to Rapture"];}
		else if(vars.prevLvl == 1104 	&& current.lvl == 919)	{vars.prevLvl=current.lvl; return settings["Medical Pavillion"];}
		else if(vars.prevLvl == 1297 	&& current.lvl == 162)	{vars.prevLvl=current.lvl; return settings["Neptunes Bounty"];}
		else if(vars.prevLvl == 256 	&& current.lvl == 917)	{vars.prevLvl=current.lvl; return settings["Smugglers Hideout"];}
		else if(vars.prevLvl == 1294	&& current.lvl == 520)	{vars.prevLvl=current.lvl; return settings["Arcadia (Not skipped)"];}
		else if(vars.prevLvl == 748		&& current.lvl == 917)	{vars.prevLvl=current.lvl; return settings["Farmers Market"];}
		else if(vars.prevLvl == 1294 	&& current.lvl == 788)	{vars.prevLvl=current.lvl; return settings["Arcadia"];}
		else if(vars.prevLvl == 1116 	&& current.lvl == 598)	{vars.prevLvl=current.lvl; return settings["Fort Frolic"];}
		else if(vars.prevLvl == 855 	&& current.lvl == 174)	{vars.prevLvl=current.lvl; return settings["Hephaestus"] && !vars.fromRCC;}
		else if(vars.prevLvl == 272 	&& current.lvl == 598)	{vars.prevLvl=current.lvl; vars.fromRCC=true;}
		else if(vars.prevLvl == 272 	&& current.lvl == 614)	{vars.prevLvl=current.lvl; return settings["Rapture Central Control"];}
		else if(vars.prevLvl == 877 	&& current.lvl == 533)	{vars.prevLvl=current.lvl; return settings["Olympus Heights"];}
		else if(vars.prevLvl == 766 	&& current.lvl == 747)	{vars.prevLvl=current.lvl; return settings["Apollo Square"];}
		else if(vars.prevLvl == 1060 	&& current.lvl == 324)	{vars.prevLvl=current.lvl; return settings["Point Prometheus"];}
		else if(vars.prevLvl == 478 	&& current.lvl == 119)	{vars.prevLvl=current.lvl; return settings["Proving Grounds"];}
	}
	else if(current.lvl==197 && old.fontainePhase==3 && current.fontainePhase==4)		   return settings["Fontaine"];
}
