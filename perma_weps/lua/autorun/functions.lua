if (!PW) then PW = {} end
if (!PW.Enabled) then return; end

PW.Notify = function(ply, str)
	if (!ply:IsPlayer()) then
		print(str);
		return;
	end
	net.Start("PW_Notify")
		net.WriteString(str)
	net.Send(ply);
end

PW.Broadcast = function(str)
	for k,v in pairs(player.GetAll()) do
		v:AddMsg(str);
	end
end

PW.FindPlayer = function(id)
	if (string.find(id, "STEAM")) then --steamid
		for k,v in pairs(player.GetAll()) do
			if (string.find(comp, target)) then
				return v;
			end
		end
		return false;
	else
		for k,v in pairs(player.GetAll()) do

			local target = string.lower(id);
			local target = string.Trim(target);
			local comp = string.lower(v:Nick());

			if (string.find(comp, target)) then
				return v;
			end
		end
		return false;
	end
end

PW.FindWeapon = function(class)

	local weps = weapons.GetList();
	local class = string.lower(class);
	local class = string.Trim(class);
	
	for k,v in pairs(weps) do
		if (string.find(string.lower(v.ClassName), class)) then
			return v;
		end
	end
	return false;
end