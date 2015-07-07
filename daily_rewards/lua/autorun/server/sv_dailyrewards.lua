util.AddNetworkString("redeem_reward");
util.AddNetworkString("send_rewards");
util.AddNetworkString("mail_closed");

local Player = FindMetaTable("Player");

function RandomReward(ply)
	local ran = math.random(1, #rewards);
	local ran = math.Round(ran);
	local reward = rewards[ran];
	
	if (!reward) then return; end
	
	ply:Chat(Color(0, 0, 0, 255), "[", Color(255, 25, 25, 255), "Rewards", Color(0, 0, 0, 255), "] ", Color(255, 255, 255, 255), "You have been given "..reward.name.." as your random reward! Congratulations!");
	reward.func(ply);
end

function Player:Redeem()
	if (!self:CanRedeem()) then return; end
	
	RandomReward(self);
	
	self:SetPData("Rewards", os.time());
end

function Player:CanRedeem()
	if (self:GetPData("Rewards") == nil) then return true; end
	local twentyfour = 60 * 60 * 24
	if ((self:GetPData("Rewards", os.time()) + twentyfour) > os.time()) then
		return false, (self:GetPData("Rewards") + twentyfour) - os.time()
	else
		return true;
	end
end

hook.Add("PlayerIntialSpawn", "SendRewards", function(ply)
	local tbl = {};
	for k,v in pairs(rewards) do
		table.insert(tbl, {name = v[1], desc = v[2], img = v[3]});
	end
	
	net.Start("send_rewards");
		net.WriteTable(tbl);
	net.Send(ply);
end)

net.Receive("redeem_reward", function(len, client)
	client.mailOpen = false;

	local can, timeleft = client:CanRedeem();
	if (!can) then client:Chat(Color(0, 0, 0, 255), "[", Color(255, 25, 25, 255), "Rewards", Color(0, 0, 0, 255), "] ", Color(255, 255, 255, 255), "You must wait 1 day to claim another reward!"); return; end
	
	client:Redeem();
end)

net.Receive("mail_closed", function(l, ply)
	ply.mailOpen = false;
end)

hook.Add("Initialize", "SpawnMailBox", function()
	timer.Simple(5, function()
		print("Spawning Mail entity!");
		local n = ents.Create("mailbox");
		n:SetPos(Vector(652.145264, -633.000183, -131.968750));
		n:SetAngles(Angle(0, 270, 0));
		n:DropToFloor();
		n:Spawn();
		n:Activate();
	end)
end)