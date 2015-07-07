local function help(ply)
	am.broadcast(ply, "A list of all available for commands for your rank is being printed in your console!");
	if (ply:hasPerm("Help")) then
		for k,v in pairs(adminCommands) do
			ply:PrintMessage(HUD_PRINTCONSOLE, "-- "..k)
		end
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, "None D:!")
	end
end
AddChatCommand("!help", help);