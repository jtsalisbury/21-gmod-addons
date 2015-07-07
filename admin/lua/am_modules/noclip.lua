hook.Add("PlayerNoClip", "EnableAdminNoClip", function(ply)
	return ply:hasPerm("NoClip");
end)