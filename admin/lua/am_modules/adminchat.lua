local function adminChat(ply, args)
	local str = "";
	for k,v in pairs(args) do
		str = str..v.." ";
	end
	for k,v in pairs(player.GetAll()) do
		if (v:hasPerm("AdminChat")) then
			net.Start("am_adminchat");
				net.WriteString(ply:Nick());
				net.WriteString(str);
			net.Send(v);
		end
	end
end
AddChatCommand("@", adminChat);

local function adminChat(ply, args)
	local str = "";
	for k,v in pairs(args) do
		str = str..v.." ";
	end
	for k,v in pairs(player.GetAll()) do
		if (v:hasPerm("SuperAdminChat")) then
			net.Start("am_superadminchat");
				net.WriteString(ply:Nick());
				net.WriteString(str);
			net.Send(v);
		end
	end
end
AddChatCommand("$", adminChat);