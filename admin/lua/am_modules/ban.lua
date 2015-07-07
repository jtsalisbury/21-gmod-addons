local function ban(ply, args)
	if (!ply:hasPerm("Ban")) then return am.broadcast(ply, "You aren't staff! You can't do this!"); end

	local user = args[1]
	local time = args[2]

	args[1] = nil
	args[2] = nil

	local reason = am.tostring(args)

	if (!user) then return am.broadcast(ply, "No target user found!"); end
	if (!time) then return am.broadcast(ply, "No time was defined!"); end
	
	local time, prefix, orig = am.toseconds(time)
	if (!time) then return am.broadcast(ply, "Could not convert time to a number!?"); end
	if (!reason) then return am.broadcast(ply, "No reason was defined!"); end

	local user = am.finduser(user);
	if (!user) then return am.broadcast(ply, "No user could be found with that name!"); end

	if (string.len(reason) < 10) then
		return am.broadcast(ply, "The ban reason MUST be more than 10 characters in length!");
	end

	am.broadcast(Color(25, 255, 25), ply:Nick(), Color(255, 255, 255), " has banned ", Color(25, 255, 25),  user:Nick(), Color(255, 255, 255), "for ", Color(25, 255, 25), orig, prefix, Color(255, 255, 255), " for the reason of ", Color(25, 255, 25), reason);

	query("INSERT INTO am_banned (uniqueid, BannedName, BannerID, BannerName, BannedAtDate, BannedAtTime, BannedFor, Reason) VALUES ('"..user:SteamID().."','"..user:Nick().."','"..ply:SteamID().."','"..ply:Nick().."','"..os.date().."','"..os.time().."','"..(os.time() + time).."','"..reason.."')")
	user:Kick("You have been banned! Time: "..orig..prefix.." Reason: "..reason);


end
AddChatCommand("!ban", ban);
