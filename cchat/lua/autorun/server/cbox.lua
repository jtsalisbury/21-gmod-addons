util.AddNetworkString("CBOX_PlayerSayCall");
util.AddNetworkString("CBOX_NewMessage");

net.Receive("CBOX_PlayerSayCall", function(len, client)
	local str = net.ReadString();
	hook.Call("PlayerSay", GAMEMODE, client, str);

	net.Start("CBOX_NewMessage");
		net.WriteString(str);
		net.WriteEntity(client);
	net.Broadcast();
end)