util.AddNetworkString("sug_submit")
util.AddNetworkString("OpenSugMenu")
util.AddNetworkString("SugNotify")

local function notify(ply, ...)
	net.Start("SugNotify")
		net.WriteTable({...})
	net.Send(ply)
end

hook.Add("PlayerSay", "PlayerSay:Suggestions", function(ply, text)
	if (string.sub(text, 1, 4) == sug.ChatCmd) then
		local last = ply:GetPData("last_sug_time", 0)
		local time_since = last + sug.WaitTime
		print(time_since, os.time())
		if (time_since < os.time()) then
			ply.CanSuggest = true

			net.Start("OpenSugMenu")
			net.Send(ply)
		else
			notify(ply, "You must wait "..math.Round((time_since - os.time()) / 60).." more minutes before making another suggestion, feel free to post on the forums though!")
		end
	end

	return ""
end)

net.Receive("sug_submit", function(len, client)
	if (!client.CanSuggest) then notify(client, "You can't suggest right now, sorry!") return end

	local title = net.ReadString()
	local desc = net.ReadString()

	if (!title or !desc or string.len(title) == 0 or string.len(desc) == 0) then
		notify(client, "No title or description!")
		return
	end
	
	client:SetPData("last_sug_time", os.time())
	client.CanSuggest = false
	query("INSERT INTO `suggestions` (`name`, `steamid`, `desc`, `title`, `server`) VALUES ('"..escape(client:Nick()).."', '"..client:SteamID().."', '"..escape(desc).."', '"..escape(title).."', '"..sug.Server.."')")
end)