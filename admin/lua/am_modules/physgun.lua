hook.Add("PhysgunPickup", "AllowPlayerPhysing", function(ply, targ)
	if (targ:IsPlayer() and targ:IsValid()) then
		if (ply:hasPerm("Physgun")) then
			targ:SetMoveType(MOVETYPE_NONE);
			return true
		else
			return
		end
	end
end)

hook.Add("PhysgunDrop", "AllowPlayerDePhysing", function(ply, targ)
	if (targ:IsPlayer()) then
		targ:SetMoveType(MOVETYPE_WALK);
	end
end)
