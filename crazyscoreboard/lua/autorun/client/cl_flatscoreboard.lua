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
	verylightgray = Color(220, 220, 220, 255),
	white = Color(255, 255, 255, 255),
}

local tbl = {
	["Superadmin"] = {Color(0, 0, 0)},
	["Admin"] = {Color(255, 25, 25)},
	["Moderator"] = {Color(255, 255, 25)},
	["Server Director"] = {Color(0, 0, 255)},
	["Developer"] = {Color(100, 100, 100)},
	["Owner"] = {"rainbow", "rainbow"},

	["Premium"] = {Color(200, 200, 200)},
	["Platinum"] = {Color(200, 0, 200)},
	["Diamond"] = {Color(100, 100, 255)}
}

surface.CreateFont("sbHead", {font = "coolvetica", size = 50, weight = 500})
surface.CreateFont("sbBtn", {font = "coolvetica", size = 30, weight = 500})
surface.CreateFont("sbBtnSmall", {font = "coolvetica", size = 15, weight = 500})

local scoreboard = nil;

local function createCBoard()
	local function db(x, y, w, h, col)
		draw.RoundedBox(0, x, y, w, h, col);
	end
	local function ds(txt, font, x, y, col)
		draw.SimpleText(txt, font, x, y, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end


	local pnl = vgui.Create("DFrame");
	pnl:SetSize(ScrW() - 200, ScrH() - 100);
	pnl:Center();
	pnl:MakePopup();
	pnl:ShowCloseButton(true);
	pnl:SetTitle(" ");
	function pnl:Paint(w, h)
		db(0, 0, w, h, colors.back);
		db(0, 0, w, 75, colors.head);
		ds("Scoreboard", "sbHead", w / 2, 75 / 2, colors.text);
	end

	local li = vgui.Create("DScrollPanel", pnl);
	li:SetSize(pnl:GetWide() - 20, pnl:GetTall() - 145);
	li:SetPos(10, 125.5);

	local lis = vgui.Create("DIconLayout");
	li:AddItem(lis);
	lis:SetSize(li:GetWide(), li:GetTall());
	lis:SetPos(0, 0);
	lis:SetSpaceY(1);

	local headings = vgui.Create("DPanel", pnl);
	headings:SetSize(pnl:GetWide() - 20, 40);
	headings:SetPos(10, 85);
	surface.SetFont("sbBtn")
	local sw, sh = surface.GetTextSize("W")

	function headings:Paint(w, h)
		db(0, 0, w, h, colors.lightgray);
																							
		ds("Nick", "sbBtn", 100, h / 2, colors.white)
		ds("Kills", "sbBtn", 315, h / 2, colors.white)
		ds("Deaths", "sbBtn", 455, h / 2, colors.white)
		ds("Team", "sbBtn", w - 350, h / 2, colors.white)
		ds("Rank", "sbBtn", w - 40, h / 2, colors.white)

	end

	for k,v in pairs(player.GetAll()) do
		local p_pnl = lis:Add("DPanel");
		p_pnl:SetSize(lis:GetWide(), 50);
		function p_pnl:Paint(w, h)
			db(0, 0, w, h, colors.verylightgray);
		end

		local avatar = vgui.Create("AvatarImage", p_pnl);
		avatar:SetSize(44, 44);
		avatar:SetPos(3, 3);
		avatar:SetPlayer(v, 44);

		local rankt, rankc, namec = hook.Call("Scoreboard_RequestInfo", GAMEMODE, v)
		
		local w,h = surface.GetTextSize(rankt)

		local name = vgui.Create("DLabel", p_pnl);
		name:SetPos(53, 0);
		name:SetFont("sbBtn");
		name:SetText(v:Nick() or "NULL");
		name:SizeToContents();
		name:CenterVertical();

		local rank = vgui.Create("DLabel", p_pnl)
		rank:SetFont("sbBtn")																																																														
		rank:SetText(rankt)
		rank:SizeToContents()
		rank:SetPos(p_pnl:GetWide() - w - 15, 0)
		rank:CenterVertical()

		local j = v:getDarkRPVar("job")
		local w2 = surface.GetTextSize(j)
		local job = vgui.Create("DLabel", p_pnl)
		job:SetFont("sbBtn")
		job:SetPos(p_pnl:GetWide() - 350 - (w2 / 2))
		job:SetText(j)
		job:SetTextColor(team.GetColor(v:Team()))
		job:SizeToContents()
		job:CenterVertical()

		local w3 = surface.GetTextSize(v:Nick())
		local kills = vgui.Create("DLabel", p_pnl)
		kills:SetPos(300)
		kills:SetText(v:Frags())
		kills:SetFont("sbBtn")
		kills:SetTextColor(colors.text_blue)
		kills:SizeToContents()
		kills:CenterVertical()

		local deaths = vgui.Create("DLabel", p_pnl)
		deaths:SetPos(450)
		deaths:SetText(v:Deaths())
		deaths:SetFont("sbBtn")
		deaths:SetTextColor(colors.text_blue)
		deaths:SizeToContents()
		deaths:CenterVertical()

		function p_pnl:Think()
			local t = CurTime()
			local r = math.abs(math.sin(t * 2) * 255);
			local g = math.abs(math.sin(t * 2 + 2) * 255);
			local b = math.abs(math.sin(t * 2 + 4) * 255);

			if (rankc == "rainbow") then rank:SetTextColor(Color(r, g, b))
			else rank:SetTextColor(rankc) end
			if (namec == "rainbow") then name:SetTextColor(Color(r, g, b))
			else name:SetTextColor(namec) end
		end

		function p_pnl:OnMousePressed(btn)
			if (btn == MOUSE_RIGHT /*&& LocalPlayer():IsAdmin()*/) then
				local opts = DermaMenu();
				opts:SetPos(gui.MousePos());
				opts:AddOption("Kick", function()
					net.Start("scoreboard_kick")
						net.WriteEntity(v)
					net.SendToServer()
				end):SetImage("icon16/user_edit.png");
				opts:AddOption("Open Profile Page", function()
					v:ShowProfile()
				end):SetImage("icon16/world.png")
				opts:AddSpacer()
				opts:AddOption("Copy SteamID", function()
					SetClipboardText(v:SteamID());
				end):SetImage("icon16/tag_blue.png");

				opts:Open()
			end
		end
	end

	return pnl;
end

hook.Add("ScoreboardShow", "ShowThiShit", function()
	if (scoreboard) then scoreboard:Remove(); end
	
	scoreboard = createCBoard();
end)

hook.Add("ScoreboardHide", "HideThisShit", function()
	if (scoreboard) then scoreboard:Remove(); end
end)

hook.Add("Scoreboard_RequestInfo", "Shit", function(ply)
	if (tbl[ply:getGroup()]) then 
		local info = tbl[ply:getGroup()]

		local rank = ply:getGroup()
		local rankc = info[1]
		local namec = info[2] or colors.text_blue

		return rank, rankc, namec
	end
	return "User", colors.text_blue, colors.text_blue
end)