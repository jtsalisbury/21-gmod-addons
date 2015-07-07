local function slay(ply, args)
	if (!ply:hasPerm("Slay")) then return am.broadcast(ply, "You aren't staff! You can't do this!"); end
	local user = am.finduser(args[1]);
	if (!user) then return am.broadcast(ply, "User not found!"); end
	if (!user:Alive()) then return am.broadcast(ply, "User is already dead!"); end
	if (!user:IsValid()) then return am.broadcast(ply, "User is invalid?"); end
	if (user.frozen) then return am.broadcast(ply, "User is frozen!"); end

	user:Kill();
	am.broadcast(Color(25, 255, 25), ply:Nick(), Color(255, 255, 255), " has slain ", Color(25, 255, 25), user:Nick());
end
AddChatCommand("!slay", slay);
