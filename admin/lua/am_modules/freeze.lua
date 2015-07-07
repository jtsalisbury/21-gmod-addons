local function freeze(ply, args)
	if (!ply:hasPerm("Freeze")) then return am.broadcast(ply, "You aren't staff! You can't do this!"); end

	local user = am.finduser(args[1]);
	if (!user) then return am.broadcast(ply, "User not found!"); end
	
	if (!user:Alive()) then return am.broadcast(ply, "User is not alive!"); end

	if (user.frozen) then return am.broadcast(ply, "User is already frozen!"); end

	user.frozen = true;

	user:Lock();
	am.broadcast(Color(25, 255, 25), ply:Nick(), Color(255, 255, 255), " has frozen ", Color(25, 255, 25), user:Nick());
end
AddChatCommand("!freeze", freeze);

local function unfreeze(ply, args)
	if (!ply:hasPerm("UnFreeze")) then return am.broadcast(ply, "You aren't staff! You can't do this!"); end

	local user = am.finduser(args[1]);
	if (!user) then return am.broadcast(ply, "User not found!"); end

	if (!user.frozen) then return am.broadcast(ply, "User is not currently frozen!"); end

	user.frozen = false;
	user:UnLock();
	am.broadcast(Color(25, 255, 25), ply:Nick(), Color(255, 255, 255), " has unfrozen ", Color(25, 255, 25), user:Nick());
end
AddChatCommand("!unfreeze", unfreeze);
