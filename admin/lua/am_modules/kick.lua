local function kick(ply, args)
	if (!ply:hasPerm("Kick")) then return am.broadcast(ply, "You aren't staff! You can't do this!"); end
	local user = am.finduser(args[1]);

	args[1] = nil

	local reason = am.tostring(args)

	if (!user) then return am.broadcast(ply, "No user could be found!"); end
	if (!reason) then return am.broadcast(ply, "No reason was defined!"); end

	if (string.len(reason) < am.minkicklength) then
		return am.broadcast(ply, "The kick reason MUST be more than "..am.minkicklength.." characters in length!");
	end

	am.broadcast(Color(25, 255, 25), ply:Nick(), Color(255, 255, 255), " has kicked ", Color(25, 255, 25),  user:Nick(), Color(255, 255, 255), " for the reason of ", Color(25, 255, 25), reason);
	user:Kick("You have been kicked! Reason: "..reason);
end
AddChatCommand("!kick", kick);