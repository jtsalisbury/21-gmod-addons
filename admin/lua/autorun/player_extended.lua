local meta = FindMetaTable("Player")

local a = meta.IsAdmin
function meta:IsAdmin()
	local user = am.admins[self:SteamID()]

	if (!user) then return a(self) end

	return user.Admin == 1 or user.SuperAdmin == 1 or user.Owner == 1 or user.Director == 1 or user.Mod == 1 or a(self)
end

local sa = meta.IsSuperAdmin
function meta:IsSuperAdmin()
	
	local user = am.admins[self:SteamID()]

	if (!user) then return sa(self) end

	return user.SuperAdmin == 1 or user.Owner == 1 or user.Director == 1 or sa(self)
end

function meta:hasPerm(sPerm)
	local u = am.admins[self:SteamID()]
	if (!u) then return false end

	local r = ""
	if (u.Admin == 1) then r = "admin" 
		elseif (u.SuperAdmin == 1) then r = "superadmin"
		elseif (u.Owner == 1) then r = "owner"
		elseif (u.Director == 1) then r = "server_director"
		elseif (u.Dev == 1) then r = "developer" 
		elseif (u.Mod == 1) then r = "moderator" 
	end
	
	local perms = am.permissions[r]
	
	return perms[sPerm] and perms[sPerm] == 1
end

function meta:IsStaff()
	local user = am.admins[self:SteamID()]

	return a(self) or user.Dev
end

function meta:getGroup()
	local u = am.admins[self:SteamID()]
	if (!u) then return "User" end

	if (u.Admin == 1) then return "Admin" 
		elseif (u.SuperAdmin == 1) then return "Superadmin"
		elseif (u.Owner == 1) then return "Owner"
		elseif (u.Director == 1) then return "Server Director"
		elseif (u.Dev == 1) then return "Developer" 
		elseif (u.Mod == 1) then return "Moderator" 
		elseif (u.Premium == 1) then return "Premium"
		elseif (u.Platinum == 1) then return "Platinum"
		elseif (u.Diamond == 1) then return "Diamond"
	end
end

function meta:GetUserGroup()
	return self:getGroup()
end

function meta:IsUserGroup(group)
	return (self:getGroup() == group)
end