local function god(ply, args)
	if (!ply:hasPerm("God")) then return am.broadcast(ply, "You aren't staff! You can't do this!"); end
	local user = am.finduser(args[1]);
	if (!user) then return am.broadcast(ply, "User not found!"); end
	if (!user:Alive()) then return am.broadcast(ply, "User is not alive!"); end

	if (!user:IsValid()) then return am.broadcast(ply, "User is invalid?"); end

	user:GodEnable();
	am.broadcast(Color(25, 255, 25), ply:Nick(), Color(255, 255, 255), " has enabled god mode on ", Color(25, 255, 25), user:Nick());
end
AddChatCommand("!god", god);

local function ungod(ply, args)
	if (!ply:hasPerm("UnGod")) then return am.broadcast(ply, "You aren't staff! You can't do this!"); end
	local user = am.finduser(args[1]);
	if (!user) then return am.broadcast(ply, "User not found!"); end
	if (!user:Alive()) then return am.broadcast(ply, "User is not alive!"); end

	if (!user:IsValid()) then return am.broadcast(ply, "User is invalid?"); end

	user:GodDisable();
	am.broadcast(Color(25, 255, 25), ply:Nick(), Color(255, 255, 255), " has disabled god mode on ", Color(25, 255, 25), user:Nick());
end
AddChatCommand("!ungod", ungod);