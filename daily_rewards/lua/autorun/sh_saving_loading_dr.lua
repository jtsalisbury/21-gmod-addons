if (CLIENT) then
	concommand.Add("save_mailboxs", function()
		if (!LocalPlayer():IsSuperAdmin()) then return; end
		
		net.Start("mailbox_save");
		net.SendToServer();
	end)
	
else
	util.AddNetworkString("mailbox_save");

	local function Reloadmailboxs()
		local spawns = file.Read("crazy_spawns/"..game.GetMap().."_mailboxspawns.txt", "DATA");
		if (!spawns) then print("No spawns found for this map! How about you add some?"); return; end

		local spawns = util.JSONToTable(spawns);
		for k,v in pairs(spawns) do
			print("Spawning mailbox entity!");
			local n = ents.Create("mailbox");
			n:SetPos(v[1]);
			n:SetAngles(v[2]);
			n:DropToFloor();
			n:Spawn();
			n:Activate();
		end
	end

	hook.Add("Initialize", "SpawnmailboxNPC", function()
		timer.Simple(5, function()
			Reloadmailboxs();
		end)
	end)

	net.Receive("mailbox_save", function(len, client)
		if (!client:IsSuperAdmin()) then return; end
		
		local spawns = {};

		for k,v in pairs(ents.FindByClass("mailbox")) do
			table.insert(spawns, {v:GetPos(), v:GetAngles()});
		end

		local spawns = util.TableToJSON(spawns);
		file.Write("crazy_spawns/"..game.GetMap().."_mailboxspawns.txt", spawns);

		local fil = file.Exists("crazy_spawns/"..game.GetMap().."_mailboxspawns.txt", "DATA");
		if (fil) then
			client:PrintMessage(HUD_PRINTTALK, "mailboxs saved!");
			return;
		end
		client:PrintMessage(HUD_PRINTTALK, "mailbox save failed!");
	end)
end