if (!PW.Enabled) then return; end

local Player = FindMetaTable("Player");

function Player:CanUsePW()
	for k,v in pairs(PW.Groups) do
		if (self:IsUserGroup(v)) then
			return true;
		end
	end
	return false;
end

if (CLIENT) then
	function Player:AddMsg(str)
		chat.AddText(PW.Chat.TagBracketsCol, "[", PW.Chat.TagCol, PW.Chat.Tag, PW.Chat.TagBracketsCol, "] ", PW.Chat.ChatColor, str); 
	end
end

if (SERVER) then 
	function Player:GiveWeapon(wep)
		local weps = self.PWeapons;
		
		for k,v in pairs(weps) do
			if (v == wep) then
				return false;
			end
		end
		self:Give(wep);
		table.insert(weps, wep);
		return true;
	end
	
	function Player:TakeWeapon(wep)
		local weps = self.PWeapons;
		
		for k,v in pairs(weps) do
			if (v == wep) then 
				if (self:HasWeapon(wep)) then
					self:StripWeapon(wep);
				end
				table.remove(weps, k);
				return true;
			end
		end
		return false;
	end
	
	
	
	function Player:CreateWEPProfile()
		local id = self:SteamID();
		local weps = util.TableToJSON({});
		
		Query("INSERT INTO `pw_general` (weps, steamid) VALUES ('"..weps.."', '"..id.."')", function(res)
			self.PWeapons = {};
		end)
	end
	
	function Player:SaveWeapons()
		local id = self:SteamID();
		local weps = util.TableToJSON(self.PWeapons);
		
		Query("UPDATE `pw_general` SET weps = '"..weps.."' WHERE steamid = '"..id.."'");
	end
	
	function Player:LoadWeapons()
		local id = self:SteamID();
		
		Query("SELECT * FROM `pw_general` WHERE steamid = '"..id.."'", function(res)
			if (res[1] == nil) then self:CreateWEPProfile() return; end
			
			local weps = res[1]['weps'];
			local weps = util.JSONToTable(weps);
			
			for k,v in pairs(weps) do
				self:Give(v);
			end
			
			self.PWeapons = weps;
		end)
	end
	
	
end