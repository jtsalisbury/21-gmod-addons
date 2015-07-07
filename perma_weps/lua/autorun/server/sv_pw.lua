if (!PW.Enabled) then return; end

util.AddNetworkString("PW_Notify")

PW.Give = function(ply, args)
	if (ply:IsPlayer() && !ply:CanUsePW()) then PW.Notify(ply, "Sorry, you can't use this command though!"); return; end
	
	local targ = args[1];
	local wep = args[2];
	
	local targ = PW.FindPlayer(targ);
	if (!targ) then PW.Notify(ply, "Could not find a valid player with the name provided!"); return; end
	local wep = PW.FindWeapon(wep);
	if (!wep) then PW.Notify(ply, "Could not find a valid weapon with the name provided!"); return; end
	
	local nick = "Console";
	if (ply:IsPlayer()) then nick = ply:Nick() end
	
	local weps = targ.PWeapons;
		
	for k,v in pairs(weps) do
		if (v == wep.ClassName) then
			return false;
		end
	end
	
	PW.Notify(targ, "You have been given "..(wep.PrintName).." bye "..nick.."!");
	PW.Notify(ply, "Successfully given "..(wep.PrintName).." to "..targ:Nick().."!");
	targ:GiveWeapon(wep.ClassName);
end

PW.Take = function(ply, args)
	if (ply:IsPlayer() && !ply:CanUsePW()) then PW.Notify(ply, "Sorry, you can't use this command though!"); return; end
	
	local targ = args[1];
	local wep = args[2];
	
	local targ = PW.FindPlayer(targ);
	if (!targ) then PW.Notify(ply, "Could not find a valid player with the name provided!"); return; end
	local wep = PW.FindWeapon(wep);
	if (!wep) then PW.Notify(ply, "Could not find a valid weapon with the name provided!"); return; end
	
	local nick = "Console";
	if (ply:IsPlayer()) then nick = ply:Nick() end
	
	for k,v in pairs(targ.PWeapons) do
		if (v == wep.ClassName) then 
			PW.Notify(targ, "You have been stripped of "..(wep.PrintName).." by "..nick.."!");
			PW.Notify(ply, "Successfully taken "..(wep.PrintName).." from "..targ:Nick().."!");
			targ:TakeWeapon(wep.ClassName);
		end
	end
end

//blah blah commands blah blah
concommand.Add("pw_give", function(ply, cmd, args)
	PW.Give(ply, args);
end)

concommand.Add("pw_take", function(ply, cmd, args)
	PW.Take(ply, args);
end)

concommand.Add('weps', function()
	for k,v in pairs(weapons.GetList()) do
		print(v.ClassName);
	end
end)

hook.Add("PlayerSay", "HookPWeapons", function(ply, str)
	if (string.sub(str, 1, 6) == "!pgive") then
		if (ply:IsPlayer() && !ply:CanUsePW()) then PW.Notify(ply, "Sorry, you can't use this command though!"); return ""; end
		
		local pts = string.Explode(" ", str);
		if (#pts < 3) then 
			PW.Notify(ply, "Not enough arguments supplied! Usage: !give <player> <weapon_class>");
			return "";
		end
		local args = {pts[2], pts[3]}; --insert the player, and weapon into a table
		
		PW.Give(ply, args);
		
		return "";
		
	elseif (string.sub(str, 1, 6) == "!ptake") then
		if (ply:IsPlayer() && !ply:CanUsePW()) then PW.Notify(ply, "Sorry, you can't use this command though!"); return ""; end
		
		local pts = string.Explode(" ", str);
		if (#pts < 3) then 
			PW.Notify(ply, "Not enough arguments supplied! Usage: !take <player> <weapon_class>");
			return "";
		end
		local args = {pts[2], pts[3]}; --insert the player, and weapon into a table
		
		PW.Take(ply, args);
		
		return "";
	end
end)

hook.Add("PlayerSpawn", "GiveWeapons", function(ply)
	local weps = ply.PWeapons or {};
	
	for k,v in pairs(weps) do
		ply:Give(v);
	end
end)

hook.Add("PlayerInitialSpawn", "GiveWeapons", function(ply)
	ply:LoadWeapons();
end)

hook.Add("PlayerDisconnected", "SaveWeapons", function(ply)
	ply:SaveWeapons();
end)