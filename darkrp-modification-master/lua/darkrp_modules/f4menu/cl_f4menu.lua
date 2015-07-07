include("cl_jobsPanel.lua");
include("cl_miscPanel.lua");
include("cl_shipmentsPanel.lua");

local panel = nil;

local colors = {
	head = Color(192, 57, 43, 255),
	back = Color(236, 240, 241, 255),
	text = Color(255, 255, 255, 255),
	btn = Color(52, 73, 94, 255),
	btn_hover = Color(44, 62, 80, 255),
	accept = Color(46, 204, 113, 255),
	accept_hover = Color(39, 174, 96, 255),
	cancel = Color(231, 76, 60, 255),
	cancel_hover = Color(192, 57, 43, 255),
	bar = Color(189, 195, 199, 255),
	barupdown = Color(127, 140, 141, 255),
	transfer = Color(230, 126, 34, 255),
	transfer_hover = Color(211, 84, 0, 255),
	transfer_disabled = Color(230, 126, 34, 150),
	accept_disabled = Color(46, 204, 113, 150),
	cancel_disabled = Color(231, 76, 60, 150),
}

surface.CreateFont("f4Head", {font = "coolvetica", size = 60, weight = 500});
surface.CreateFont("f4Btn", {font = "coolvetica", size = 30, weight = 500});
surface.CreateFont("f4BtnSmall", {font = "coolvetica", size = 15, weight = 500});

local activeTab = nil;
local activeTabName = "Jobs";

local frame;

local function CreateMenu()
	frame = vgui.Create("DFrame");
	frame:SetPos(100, 100);
	frame:SetSize(ScrW() - 100, ScrH() - 160);
	frame:SetTitle(" ");
	frame:SetVisible(true);
	frame:MakePopup();
	frame:Center();
	frame:ShowCloseButton(false);
	frame.Paint = function()
		draw.RoundedBox(0, 0, 0, frame:GetWide(), frame:GetTall(), colors.back);
		draw.RoundedBox(0, 0, 0, frame:GetWide(), 100, colors.head);
		draw.SimpleText(activeTabName, "f4Head", frame:GetWide() / 2, 25, colors.text, TEXT_ALIGN_CENTER)
	end
	
	panel = frame;
	
	//Create Default Panel fags
	activeTabName = "Jobs";
	activeTab = CreateJobPanel(frame);
	
	local jobs = vgui.Create("DButton", frame);
	jobs:SetText(" ");
	jobs:SetSize(300, 80);
	jobs:SetPos(10, 110);
	jobs.DoClick = function()
		if (activeTab) then activeTab:Remove() activeTab = nil; end
		activeTabName = "Jobs";
		activeTab = CreateJobPanel(frame);
	end
	
	local misc = vgui.Create("DButton", frame);
	misc:SetText(" ");
	misc:SetSize(300, 80);
	misc:SetPos(10, 200);
	misc.DoClick = function()
		if (activeTab) then activeTab:Remove() activeTab = nil; end
		activeTabName = "Misc";
		activeTab = CreateMiscPanel(frame);
		
	end
	
	local ships = vgui.Create("DButton", frame);
	ships:SetText(" ");
	ships:SetSize(300, 80);
	ships:SetPos(10, 290);
	ships.DoClick = function()
		if (activeTab) then activeTab:Remove() activeTab = nil; end
		activeTabName = "Shipments";
		activeTab = CreateShipPanel(frame);
		
	end
	
	local weps = vgui.Create("DButton", frame);
	weps:SetText(" ");
	weps:SetSize(300, 80);
	weps:SetPos(10, 380);
	weps.DoClick = function()
		if (activeTab) then activeTab:Remove() activeTab = nil; end
		activeTabName = "Weapons & Ammo";
		activeTab = CreateGunsAmmoPanel(frame);
		
	end
	
	local close = vgui.Create("DButton", frame);
	close:SetText(" ");
	close:SetSize(300, 80);
	close:SetPos(10, 470);
	close.DoClick = function()
		frame:Close();
	end
	
	/* BUTTON PAINT FUNCTIONS */
	
	local ja = false;
	function jobs:OnCursorEntered() ja = true; end
	function jobs:OnCursorExited() ja = false; end
	jobs.Paint = function()
		if (ja) then
			draw.RoundedBox(0, 0, 0, jobs:GetWide(), jobs:GetTall(), colors.btn_hover);
		else
			draw.RoundedBox(0, 0, 0, jobs:GetWide(), jobs:GetTall(), colors.btn);
		end
		draw.SimpleText("Jobs", "f4Btn", jobs:GetWide() / 2, 25, colors.text, TEXT_ALIGN_CENTER);
	end
	
	local ma = false;
	function misc:OnCursorEntered() ma = true; end
	function misc:OnCursorExited() ma = false; end
	misc.Paint = function()
		if (ma) then
			draw.RoundedBox(0, 0, 0, misc:GetWide(), misc:GetTall(), colors.btn_hover);
		else
			draw.RoundedBox(0, 0, 0, misc:GetWide(), misc:GetTall(), colors.btn);
		end
		draw.SimpleText("Misc", "f4Btn", misc:GetWide() / 2, 25, colors.text, TEXT_ALIGN_CENTER);
	end
	
	local sa = false;
	function ships:OnCursorEntered() sa = true; end
	function ships:OnCursorExited() sa = false; end
	ships.Paint = function()
		if (sa) then
			draw.RoundedBox(0, 0, 0, ships:GetWide(), ships:GetTall(), colors.btn_hover);
		else
			draw.RoundedBox(0, 0, 0, ships:GetWide(), ships:GetTall(), colors.btn);
		end
		draw.SimpleText("Shipments", "f4Btn", ships:GetWide() / 2, 25, colors.text, TEXT_ALIGN_CENTER);
	end
	
	local wa = false;
	function weps:OnCursorEntered() wa = true; end
	function weps:OnCursorExited() wa = false; end
	weps.Paint = function()
		if (wa) then
			draw.RoundedBox(0, 0, 0, weps:GetWide(), weps:GetTall(), colors.btn_hover);
		else
			draw.RoundedBox(0, 0, 0, weps:GetWide(), weps:GetTall(), colors.btn);
		end
		draw.SimpleText("Weapons", "f4Btn", weps:GetWide() / 2, 25, colors.text, TEXT_ALIGN_CENTER);
	end
	
	local ca = false;
	function close:OnCursorEntered() ca = true; end
	function close:OnCursorExited() ca = false; end
	close.Paint = function()
		if (ca) then
			draw.RoundedBox(0, 0, 0, close:GetWide(), close:GetTall(), colors.cancel_hover);
		else
			draw.RoundedBox(0, 0, 0, close:GetWide(), close:GetTall(), colors.cancel);
		end
		draw.SimpleText("Close", "f4Btn", close:GetWide() / 2, 25, colors.text, TEXT_ALIGN_CENTER);
	end
end

local active = false;
net.Receive("f4_control", function()
	CreateMenu();
end)