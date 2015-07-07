local Player = FindMetaTable("Player");

if (SERVER) then 
	util.AddNetworkString("sv_chat_color");
		
	
	function Player:Chat(...)
		net.Start("sv_chat_color");
			net.WriteTable({...});
		net.Send(self);
	end
	
else

	net.Receive("sv_chat_color", function(len, client)
		local tbl = net.ReadTable();
		
		chat.AddText(unpack(tbl));
	end)
	
end

local vip_groups = {"superadmin"};
function Player:IsVIP()
	for k,v in pairs(vip_groups) do
		if (self:IsUserGroup(v)) then
			return true;
		end
	end
	return false;
end
