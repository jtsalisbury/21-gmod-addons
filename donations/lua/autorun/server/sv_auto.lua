util.AddNetworkString("openDonMenu")
util.AddNetworkString("sendRequest")
util.AddNetworkString("sendNotify")

local function donNotify(ply, txt)
	net.Start("sendNotify")
		net.WriteString(txt)
	net.Send(ply)
end

local cmd = "!donate"
local packages = {
	["Premium Lifetime"] = function(ply) 
		query("INSERT INTO donations (uniqueid, name, premium) VALUES ('"..ply:SteamID().."', '"..ply:Nick().."', '1')", function(res)
			if (res) then
				return true
			end
		end)
	end,
	["Platinum Lifetime"] = function(ply) 
		query("INSERT INTO donations (uniqueid, name, platinum) VALUES ('"..ply:SteamID().."', '"..ply:Nick().."', '1')", function(res)
			if (res) then
				return true
			end
		end) 
	end,
	["Diamond Lifetime"] = function(ply) 
		query("INSERT INTO donations (uniqueid, name, diamond) VALUES ('"..ply:SteamID().."', '"..ply:Nick().."', '1')", function(res)
			if (res) then
				return true
			end
		end)
	end
}

hook.Add("PlayerSay", "OpenOurDonateMenu", function(ply, text)
	if (string.sub(text, 1, (string.len(cmd))) == cmd) then
		net.Start("openDonMenu")
		net.Send(ply)
	end
end)

net.Receive("sendRequest", function(len, ply)
	local key = net.ReadString()

	if (!key) then donNotify(ply, "No key supplied!") return end
	
	key = escape(key)

	query("SELECT * FROM donations WHERE steamid = '"..ply:SteamID().."' AND redeemed = '0' AND unique_key = '"..key.."'", function(res)
		if (#res != 0) then
			local p = res[1]['package']
			local rp = packages[p]
			
			if (!rp) then donNotify(ply, "Package not found, contact a Server Director or Owner!") return end
			
			local s = rp(ply)
			if (s) then
				
				query("UPDATE donations SET redeemed = '1' WHERE steamid ='"..ply:SteamID().."' AND unique_key = '"..key.."'", function(res)
					if (res) then
						donNotify(ply, "Successfully redeemed, thanks for donating!")
					end
				end)

			end
		else
			donNotify(ply, "No key found for that SteamID, or it is already redeemed!")
		end
	end)
end)