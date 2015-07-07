am.admins = {}
am.permissions = {}

net.Receive("am_syncgroups", function()
	local t = net.ReadTable()

	am.admins = t
end)

net.Receive("am_syncperms", function()
	local t = net.ReadTable()

	am.permissions = t
end)

net.Receive("am_broadcast", function()
	local t = net.ReadTable()
	for k,v in pairs(t) do
		if (!isstring(v)) then t[k] = nil end
	end
	str = table.concat(t, " ")

	//chat.AddText(Color(0, 0, 0), "[Ascendance Servers]: ", Color(255, 255, 255), unpack(net.ReadTable()));
	hook.Call("AddMessage", GAMEMODE, "Ascendance Servers", str, Color(0, 0, 0))
end)

net.Receive("am_adminchat", function()
	local nick = net.ReadString();
	local str = net.ReadString();

	hook.Call("AddMessage", GAMEMODE, "Admin Chat", nick.. ": "..str, Color(255, 255, 255))
	//chat.AddText(Color(0, 0, 0), "[Admin Chat] ", Color(255, 255, 255), nick, ": ", str);
end)

net.Receive("am_superadminchat", function()
	local nick = net.ReadString();
	local str = net.ReadString();

	hook.Call("AddMessage", GAMEMODE, "SAdmin Chat", nick.. ": "..str, Color(255, 255, 255))
	//chat.AddText(Color(255, 100, 100), "[SAdmin Chat] ", Color(255, 255, 255), nick, ": ", str);
end)

hook.Add("OnPlayerChat", "ChatTags", function(ply, text)
	/*local group = ply:getGroup()
	local col = am.chat_colors[group]

	chat.AddText(Color(0,0,0), "[", col or Color(255, 255, 255), group, Color(0, 0, 0), "] ", team.GetColor(ply:Team()), ply:Nick(), ": ", Color(255, 255, 255), text)
	return true*/
end)