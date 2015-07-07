util.AddNetworkString("f4_control");

hook.Add("ShowSpare2", "f4Menu", function(ply)
	net.Start("f4_control")
	net.Send(ply);
end)