util.AddNetworkString("am_syncgroups")
util.AddNetworkString("am_syncperms")
util.AddNetworkString("am_broadcast")
util.AddNetworkString("am_adminchat")
util.AddNetworkString("am_superadminchat")

am.admins = {}
am.permissions = {}

function am.finduser(tosearch)
	for k,v in pairs(player.GetAll()) do 

		local target = string.lower(tosearch);
		local target = string.Trim(target);
		local comp = string.lower(v:Nick());

		if (string.find(comp, target) or target == v:SteamID()) then
			return v;
		end
	end
end

function am.tostring(args)
	local t = ""
	for k,v in pairs(args) do
		t = t .. v .. " "
	end

	return t
end

function am.toseconds(sTT)
	local tab = string.Explode(".", sTT)
	local tim, typ = tab[1], tab[2]
	tim = tonumber(tim)
	if (typ == "s") then
		return tim, " seconds ", tim
	elseif (typ == "m") then
		return tim * 60, " minutes ", tim
	elseif (typ == "h") then
		return (tim * 60) * 60, " hour ", tim
	elseif (typ == "d") then
		return ((tim * 60) * 60) * 60, " days ", tim
	elseif (typ == "y") then
		return (((tim * 60) * 60) * 60) * 60, " years ", tim
	end
end

function am.broadcast(ply, ...)
	net.Start("am_broadcast")
	net.WriteTable({...})

	print(tostring(table.concat({...})))

	if (IsValid(ply) and ply:IsPlayer()) then net.Send(ply) return end
	net.Broadcast()
end

local list = file.Find('am_modules/*.lua', "LUA");
for _, name in pairs(list) do
	include('am_modules/'..name);
	print("Successfully loaded: "..name.."!");
end