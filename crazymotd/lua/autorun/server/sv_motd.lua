util.AddNetworkString("CrazyMotdOpen");

hook.Add("PlayerInitialSpawn", "OpenMySexyAssMotd", function(ply)
	net.Start("CrazyMotdOpen");
	net.Send(ply);
end)

hook.Add("PlayerSay", "OpenMySexyAssMotd:Chat", function(ply, text)
	if (text == motd.ChatCommand) then 
		net.Start("CrazyMotdOpen");
		net.Send(ply);
	end
end)