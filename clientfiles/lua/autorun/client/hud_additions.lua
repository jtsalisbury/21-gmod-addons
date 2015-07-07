--Begin admin stuff

surface.CreateFont("bankBtn", {font = "coolvetica", size = 30, weight = 500})
surface.CreateFont("bankBtnSmall", {font = "coolvetica", size = 15, weight = 500})

local function prettyTime(time)
	if (!time) then return ""; end
		
	local pretty = os.date("%I:%M:%S %p", time);
	return pretty;
end

local panel = nil;
local function createAdminHud()
	if (IsValid(panel)) then return end
	panel = vgui.Create("DScrollPanel2");	// it's ugly how garry made the scroll bar on the right. this one is on the left
	panel:SetSize(600, 100);
	panel:SetPos(25, 5);
end

local function updateHud()
	if (panel == nil) then createAdminHud() end // make sure the panel is active
		
	panel:Clear(); // clear the panel, we don't want multiples of each added
		
	local notifications = table.Reverse(notifications); //reverse the table, so newest things are shown first
		
	for k,v in ipairs(notifications) do
		local event = v[1];
		local time = prettyTime(v[2]);

		local l = vgui.Create("DLabel");
		l:SetParent(panel);
		l:SetPos(0, 20*k);
		l:SetText("        "..time.." | "..event);
		l:SetColor(Color(255, 255, 255, 255));
		l:SizeToContents();
	end
end

usermessage.Hook("DRPLogMsg", function(um)
	local r, g, b = um:ReadShort(), um:ReadShort(), um:ReadShort() --useless for my purposes; sent by falco for his shit
	local str = um:ReadString();
	local time = os.time();
	
	if (#notifications > 40) then --let's clean old shit out
		table.Empty(notifications);
	end
	
	table.insert(notifications, {str, time});
	
	updateHud();
end)

local lawsBG = Color(150, 150, 150, 150);
local lawsHead = Color(192, 57, 43, 255);
local TextColor = Color(255, 255, 255, 255);

--Laws
local function DrawLaws()
	local laws = DarkRP.getLaws();
	
	local y = ( 20 * #laws ) + 34
	
	draw.RoundedBox(0, ScrW() - 400, 0, 400, y, lawsBG);
	draw.RoundedBox(0, ScrW() - 400, 0, 400, 30, lawsHead);
	draw.SimpleText("City Laws", bankBtn, ScrW() - 240, 2, TextColor, 0, 0);
	
	for k,v in pairs(laws) do
		local offset = ( 20 * (k-1) ) + 34; --subtract one cuz lua tables are gay
		
		local text = k..") "..v
		draw.SimpleText(text, bankBtnSmall, ScrW() - 390, offset, LawTextColor, 0, 0)
	end
end

hook.Add("HUDPaint", "MakeShit", function()
	DrawLaws();
	
	if (LocalPlayer():IsAdmin()) then
		createAdminHud();
	end
end)