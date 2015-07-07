local function loadShit()
	print("Updating groups and permissions..")

	query("SELECT * FROM am_groups", function(tbl)
		for k,v in pairs(tbl) do
			am.admins[ v["uniqueid"] ] = {
				Admin = v["admin"],
				SuperAdmin = v["superadmin"],
				Owner = v["owner"],
				Director = v["server_director"],
				Dev = v["developer"],
				Mod = v["moderator"],
				Premium = v['premium'],
				Platinum = v['platinum'],
				Diamond = v['diamond'],
			}
		end
	end)

	query("SELECT * FROM am_permissions", function(tbl)
		for k,v in pairs(tbl) do
			local perms = v["permissions"]
			local g = v["group"]
			perms = string.Explode(",", perms)
			am.permissions[ g ] = {}

			for k,v2 in pairs(perms) do
				am.permissions[ g ][ v2 ] = 1
			end
		end
	end)

	net.Start("am_syncgroups")
		net.WriteTable(am.admins)
	net.Broadcast()

	net.Start("am_syncperms")
		net.WriteTable(am.permissions)
	net.Broadcast()

end

hook.Add("DBConnected", "DBConnected:AM", function()
	loadShit()
	timer.Create("LoadShitForAdmins", 60, 0, loadShit)
end)

hook.Add("PlayerInitialSpawn", "LoadPlayerInfo", function(ply)
	hook.Add("DBConnected_"..ply:UniqueID(), "DBConnected:Banned", function()
		query("SELECT * FROM am_banned WHERE uniqueid = '"..ply:SteamID().."'", function(data)
			hook.Remove("DBConnected_"..ply:UniqueID(), "DBConnected")

			if (!data) then return end

			for k,v in pairs(data) do
				if (os.time() < tonumber(v["BannedFor"])) then 
					ply:Kick("Oh darn! You're banned! Reason: "..v['Reason']..". Time left: "..(tonumber(v["BannedFor"]) - os.time())); 
					break; 
				end	
			end
		end)
	end)
	
	net.Start("am_syncgroups")
		net.WriteTable(am.admins)
	net.Broadcast()

	net.Start("am_syncperms")
		net.WriteTable(am.permissions)
	net.Broadcast()
end)