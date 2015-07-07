local Player = FindMetaTable("Player");


function Player:SA()
	if (self:IsSuperAdmin()) then return true; end
	for k,v in pairs(report.SuperAdminGroups) do
		if (self:IsUserGroup(v)) then return true; end
	end
	return false;
end

function Player:Admin()
	if (self:IsAdmin()) then return true; end
	if (self:SA()) then return true; end

	for k,v in pairs(report.AdminGroups) do
		if (self:IsUserGroup(v)) then return true; end
	end
	return false;
end

if (SERVER) then
	util.AddNetworkString("Report_ChatMsg");

	function Player:Chat(...)
		local msg = {...};

		net.Start("Report_ChatMsg");
			net.WriteTable(msg);
		net.Send(self);
	end

else

	net.Receive("Report_ChatMsg", function()
		local text = net.ReadTable();

		chat.AddText(unpack(text));
	end)
end