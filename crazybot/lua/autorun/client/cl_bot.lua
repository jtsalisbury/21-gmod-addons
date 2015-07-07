net.Receive("CBOT_SendCLAll", function()
	local msg = net.ReadString();

	local r = Color(255, 25, 25, 255);
	local b = Color(0, 0, 0, 255);
	local w = Color(255, 255, 255, 255);

	chat.AddText(b, "[", r, "CBot", b, "] ", w, msg);
end)

net.Receive("CBOT_PrintConsole", function()
	MsgN(net.ReadString());
end)