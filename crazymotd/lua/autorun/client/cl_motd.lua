local colors = {
	head = Color(192, 57, 43, 255),
	back = Color(236, 240, 241, 255),
	text = Color(255, 255, 255, 255),
	text_blue = Color(52, 152, 219, 255),
	btn = Color(52, 73, 94, 255),
	btn_hover = Color(44, 62, 80, 255),
	btn_disabled = Color(52, 73, 94, 150),
	open = Color(46, 204, 113, 255),
	open_hover = Color(39, 174, 96, 255),
	open_disabled = Color(46, 2014, 113, 150),
	cancel = Color(231, 76, 60, 255),
	cancel_hover = Color(192, 57, 43, 255),
	bar = Color(189, 195, 199, 255),
	barup = Color(127, 140, 141, 255),
	closed = Color(230, 126, 34, 255),
	closed_hover = Color(211, 84, 0, 255),
	info_back = Color(189, 195, 199, 255),
	lightgray = Color(189, 195, 199, 255),
}

surface.CreateFont("motdHead", {font = "coolvetica", size = 60, weight = 500})
surface.CreateFont("motdBtn", {font = "coolvetica", size = 30, weight = 500})
surface.CreateFont("motdBtnSmall", {font = "coolvetica", size = 15, weight = 500})

net.Receive("CrazyMotdOpen", function()
	local activePanel = nil;
	local activePanel_Name = "Geek Galaxy";

	local f = vgui.Create("DFrame");
	f:SetSize(ScrW(), ScrH());
	f:SetPos(0, 0);
	f:MakePopup();
	f:ShowCloseButton(false);
	f:SetTitle(" ");
	function f:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, colors.back);
		draw.RoundedBox(0, 0, 0, w, 100, colors.head);
		draw.SimpleText(activePanel_Name, "reportHead", w / 2, 50, colors.text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end

	local sidebar = vgui.Create("DPanel", f);
	sidebar:SetSize(200, ScrH() - 110);
	sidebar:SetPos(0, 110);
	function sidebar:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, colors.lightgray);
	end

	local btnscroll = vgui.Create("DScrollPanel", sidebar);
	btnscroll:SetSize(sidebar:GetWide(), sidebar:GetTall());
	btnscroll:SetPos(0, 0);

	local bar = btnscroll:GetVBar();
	function bar:Paint(w, h) draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 0)); end
	function bar.btnUp:Paint(w, h) draw.RoundedBox(0, 0, 0, w, h, colors.barup); end
	function bar.btnDown:Paint(w, h) draw.RoundedBox(0, 0, 0, w, h, colors.barup); end
	function bar.btnGrip:Paint(w, h) draw.RoundedBox(0, 0, 0, w, h, colors.barup); end

	local btnholder = vgui.Create("DIconLayout", btnscroll);
	btnscroll:AddItem(btnholder);
	btnholder:SetSize(btnscroll:GetWide() - 10, btnscroll:GetTall() - 5);
	btnholder:SetPos(5, 5);
	btnholder:SetSpaceY(5);

	local pbase = vgui.Create("DPanel", f)
	pbase:SetSize(f:GetWide() - 210, f:GetTall() - 110);
	pbase:SetPos(210, 110);
	function pbase:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, colors.lightgray);
	end

	activePanel = motd.tabs[1][2](pbase, pbase:GetWide(), pbase:GetTall(), f, colors);
	activePanel_Name = motd.tabs[1][1];

	for key,tbl in pairs(motd.tabs or {}) do
		local btn = btnholder:Add("DButton");
		btn:SetSize(btnholder:GetWide(), 50);
		btn:SetText(" ");
		function btn:Paint(w, h)
			if (self:IsHovered()) then
				draw.RoundedBox(0, 0, 0, w, h, colors.btn_hover);
			else
				draw.RoundedBox(0, 0, 0, w, h, colors.btn);
			end

			draw.SimpleText(tbl[1], "motdBtn", w / 2, h / 2, colors.text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		end
		function btn:DoClick()
			if (activePanel && IsValid(activePanel)) then activePanel:Remove(); end
			
			activePanel = tbl[2](pbase, pbase:GetWide(), pbase:GetTall(), f, colors);
			activePanel_Name = tbl[1];
		end
	end
end)