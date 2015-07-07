if (CLIENT) then return; end

AddCSLuaFile("cl_bank.lua");
AddCSLuaFile("sh_bank.lua");
include("sh_bank.lua");

SetGlobalFloat("bank_money", bankConfig.initialMoney);
local moneyCur;
local beingRobbed = false;
local weaponsgave = false;
local invault = false;

local function start()

end

local function giveGuardWeapons(ply)
	for k,v in pairs(bankConfig.bankGuardWeapons) do
		if (!ply:isCP()) then
			ply:Give(v);
		end
	end
end

local function stripGuardWeapons(ply)
	for k, v in pairs(bankConfig.bankGuardWeapons) do
		if (ply:HasWeapon(v) && !ply:isCP()) then
			ply:StripWeapon(v);
		end
	end
end

local function bankRobbedNotify(text)
	for k,v in pairs(player.GetAll()) do 
		//if (isGuard(v)) then //as long as the cop doesn't get the guns.
			v:PrintMessage(HUD_PRINTCENTER, text);
		//end
	end
end

local function bankDoneRobbedNotify(text)

	for k,v in pairs(player.GetAll()) do 
		//if (isGuard(v))) then
			v:PrintMessage(HUD_PRINTCENTER, text);
		//end
	end
end

local function Notify(text)
	for k,v in pairs(player.GetAll()) do
		v:PrintMessage(HUD_PRINTTALK, text);
	end
end

hook.Add("InitPostEntity", "StartBankStuff", function()
	
	timer.Create("bank_growthTimer", bankConfig.moneyGrowthTime, 0, function()
		moneyCur = GetGlobalFloat("bank_money") + bankConfig.moneyGrowth //We can continue to update as long as it is still good.
		
		if (moneyCur > bankConfig.maxMoney) then
			SetGlobalFloat("bank_money", bankConfig.maxMoney);			
		else
			SetGlobalFloat("bank_money", moneyCur);
		end
	end)
end)

local function WithinAABB( Start, Stop, Point )

	local x = (Point.x > Stop.x and Point.x < Start.x ) or ( Point.x < Stop.x and Point.x > Start.x);
	local y = (Point.y > Stop.y and Point.y < Start.y ) or ( Point.y < Stop.y and Point.y > Start.y);
	local z = (Point.z > Stop.z and Point.z < Start.z ) or ( Point.z < Stop.z and Point.z > Start.z);

	return (x and y and z);

end

local function isGuard(ply)
	local t = ply:Team();
	
	for k,v in pairs(bankConfig.bankGuards) do
		if (t == v || ply:isCP()) then return true; end
	end
	
	return false
end

local function playersInBank()

	local count = 0;
	
	local pos1 = bankConfig.bankPos[1];
	local pos2 = bankConfig.bankPos[2];
	local pos3 = bankConfig.bankVault[1];
	local pos4 = bankConfig.bankVault[2];
	
	for k,v in pairs(player.GetAll()) do
		if (WithinAABB(pos3, pos4, v:GetPos()) && !isGuard(v)) then
			count = count + 1;
		elseif (WithinAABB(pos1, pos2, v:GetPos()) && !isGuard(v)) then
			count = count + 1;
		end
	end
	return count;
end

local function Breakinto()

	local count = bankConfig.robTime;
	local pos1 = bankConfig.bankPos[1];
	local pos2 = bankConfig.bankPos[2];
	
	if (timer.Exists("BankTimeLeft")) then timer.Destroy("BankTimeLeft"); end
	if (timer.Exists("BankTimeLeftReal")) then timer.Destroy("BankTimeLeftReal"); end
	
	timer.Create("BankTimeLeft", 1, bankConfig.robTime, function()
		
		count = count - 1;
		for k,v in pairs(player.GetAll()) do
			if (WithinAABB(pos1, pos2, v:GetPos())) then
				v:PrintMessage(HUD_PRINTCENTER, "You must hold down the bank for "..count.." more seconds!");
			end
		end
	end)
	
	timer.Create("BankTimeLeftReal",bankConfig.robTime + 1, 1, function()

		local realMoney = GetGlobalFloat("bank_money");
		
		if (playersInBank() > 0) then
			local moneyPerPerson = (realMoney / playersInBank());
			for k,v in pairs(player.GetAll()) do
				if (WithinAABB(pos1, pos2, v:GetPos()) && !isGuard(v)) then
					v:PrintMessage(HUD_PRINTCENTER, "You have raided the bank, and got $"..moneyPerPerson);
					v:addMoney(math.Round(moneyPerPerson));
					SetGlobalFloat("bank_money", bankConfig.initialMoney);
				end
			end
		end
	end)
end

hook.Add("Think", "DetectPlayerInBank", function()

	local pos1 = bankConfig.bankPos[1];
	local pos2 = bankConfig.bankPos[2];
	local pos3 = bankConfig.bankVault[1];
	local pos4 = bankConfig.bankVault[2];

	for k,v in pairs(player.GetAll()) do 
	
		local pos = v:GetPos();
		
		if (WithinAABB(pos1, pos2, pos)) then //the player has entered the vault!
		
			if (GetGlobalFloat("bank_money") < bankConfig.minMoney) then return; end
			
			if (!invault && !isGuard(v) && playersInBank() >= 1) then
				bankRobbedNotify("The robbers have broken into the vault!");
				Breakinto() //the robbers got to the vault, let's start the timer, and if they are still there when it's done, give them the money!
				invault = true;
			end
		elseif (WithinAABB(pos3, pos4, pos)) then		//Someone is in the bank
		
			if (GetGlobalFloat("bank_money") < bankConfig.minMoney) then return; end
			
			if (isGuard(v)) then //We have a guard in the bank, what should we do
				if (!weaponsgave) then
					giveGuardWeapons(v);
					weaponsgave = true;
				end
			else
				if (!beingRobbed && playersInBank() >= 1) then
					bankRobbedNotify("The bank has been broken into!");
					beingRobbed = true;
				end
			end
		else //Not in the bank or the vault
			if (isGuard(v)) then //We have a guard outside the bank, take their guns
				if (weaponsgave) then
					stripGuardWeapons(v);
					weaponsgave = false;
				end
			else
				if (beingRobbed && playersInBank() <= 1 && (!WithinAABB(pos1, pos2, pos))) then
					bankDoneRobbedNotify("The bank is no longer being robbed");
					beingRobbed = false;
					invault = false;
				end
			end
		end
		
	end
end)