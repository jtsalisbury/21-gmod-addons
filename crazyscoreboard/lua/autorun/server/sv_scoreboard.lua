util.AddNetworkString("scoreboard_kick")
net.Receive("scoreboard_kick", function(l, ply)
	if (!ply:IsAdmin()) then return end
	
	local ent = net.ReadEntity()
	if (!IsValid(ent)) then return end
	
	ent:Kick("Ah shit, Tyrone! You've been kicked!")
end)