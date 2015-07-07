local chatbox = nil;
local msgbox = nil;
local history = {};

local framecolor = Color(100, 100, 100, 0);
local basecolor  = Color(100, 100, 100, 10);
local bar = Color(255, 255, 255, 0);
local barup = Color(255, 255, 255, 0);

surface.CreateFont("ccbox", {
	font = "TargetID",
	size = 16,
	weight = 0
	})

local font = "ccbox"

local tags = {
	["Superadmin"] = Color(0, 0, 0),
	["Admin"] = Color(255, 25, 25),
	["Moderator"] = Color(255, 255, 25),
	["Server Director"] = Color(0, 0, 255),
	["Developer"] = Color(100, 100, 100),
	["Owner"] = "rainbow",

	["Premium"] = Color(200, 200, 200),
	["Platinum"] = Color(200, 0, 200),
	["Diamond"] = Color(100, 100, 255)
}

local emotpath = "icon16/";
local emots = {};
emots[">:D"] = "emoticon_evilgrin";
emots[":D"] = "emoticon_grin";
emots["8D"] = "emoticon_happy";
emots[":)"] = "emoticon_smile";
emots[":o"] = "emoticon_surprised";
emots[":p"] = "emoticon_tongue";
emots[":("] = "emoticon_unhappy";
emots[":3"] = "emoticon_waii";
emots[";)"] = "emoticon_wink";
emots[";D"] = "emoticon_wink";
emots["<3"] = "heart";
emots[":group:"] = "group";
emots[":add:"] = "add";

emots[":dumb:"] = "box";
emots[":badreading:"] = "book_delete";
emots[":car:"] = "car";
emots[":male:"] = "male";
emots[":female:"] = "female";


local function CreateListWindow()
	local f = vgui.Create("DFrame");
	f:SetSize(500, 200);
	f:SetPos(10, ScrH() - f:GetTall() - 200);
	f:ShowCloseButton(false);
	f:SetTitle(" ");
	f:SetDraggable(false);
	function f:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, framecolor);
	end

	local ds = vgui.Create("DScrollPanel", f);
	ds:SetSize(f:GetWide() -  10, f:GetTall() - 10);
	ds:SetPos(5, 5);

	local barc = ds:GetVBar();
	function barc:Paint(w, h) draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 0)); end
	function barc.btnUp:Paint(w, h) draw.RoundedBox(0, 0, 0, w, h, barup); end
	function barc.btnDown:Paint(w, h) draw.RoundedBox(0, 0, 0, w, h, barup); end
	function barc.btnGrip:Paint(w, h) draw.RoundedBox(0, 0, 0, w, h, bar); end

	/*local di = vgui.Create("DIconLayout");
	ds:AddItem(di);
	di:SetSize(ds:GetWide(), ds:GetTall());
	di:SetSpaceY(1);
	di:Clear();*/
	local height = 0

	local function add(name, text, id, pre_color, tag, tcol, tid)
		local msg = vgui.Create("DPanel", ds);
		msg:SetSize(ds:GetWide() - 5, 20);
		msg:SetPos(0, height )
		msg.Username = name;
		msg.Text = text;
		msg.UserSteamID = id;
		msg.Tid = tid;

		//local tbl = string.Explode(" ", text);

		surface.SetFont(font);
		local w1,h = surface.GetTextSize(name);
		local gw, gh = surface.GetTextSize(tag);
		//local max_wide = msg:GetWide() - 4 - w1;

		function msg:Paint(pW, pH)
			draw.RoundedBox(0, 0, 0, pW, pH, basecolor);

			/*local text = "";
			local row = 0;
			local w,h = surface.GetTextSize(text);
			for k,v in pairs(tbl) do
				local test = string.ToColor(v);

				if (IsColor(test)) then
					surface.SetDrawColor(test);
				else
					local x,y = msg:GetPos();
					surface.SetTextPos(w + x, h * row + y);
					surface.DrawText()

					text = text.." "..v;
					if (string.len(text..tbl[k + 1] or "") > max_wide) then
						row = row + 1;
					end
				end
			end*/
		end
		local g = vgui.Create("DLabel", msg);
		g:SetFont(font);
		g:SetPos(2, 2);
		g:SetText(tag);
		g:SizeToContents();
		g:CenterVertical();
		function g:Paint()
			if (tcol == "rainbow") then
				local r = math.abs(math.sin(CurTime() * 2) * 255);
				local gc = math.abs(math.sin(CurTime() * 2 + 2) * 255);
				local b = math.abs(math.sin(CurTime() * 2 + 4) * 255);
				
				g:SetTextColor(Color( r, gc, b));
				
				return;
			end
			g:SetTextColor(tcol);
		end

		local n = vgui.Create("DLabel", msg);
		n:SetFont(font);
		n:SetPos(gw + 3, 2);
		n:SetText(name..":");
		n:SizeToContents();
		n:CenterVertical();
		function n:Paint()
			if (pre_color == "rainbow") then
				local r = math.abs(math.sin(CurTime() * 2) * 255);
				local g = math.abs(math.sin(CurTime() * 2 + 2) * 255);
				local b = math.abs(math.sin(CurTime() * 2 + 4) * 255);
				
				n:SetTextColor(Color( r, g, b));
				
				return;
			end
			n:SetTextColor(pre_color);
		end


		
	

		/*for k,v in pairs(emots) do
			local loc = string.find(text, k);
			if (loc) then
				local pts = string.Explode(k, text);
				for key,part in pairs(pts) do
					if (part == k) then table.remove(pts, key); end
						
					local len = string.len(k);
					local inject = "";
					for i=0, len do
						inject = inject.." ";
					end

					table.insert(pts, key, inject);

					local w,h = surface.GetTextSize(part);
					local row = rows / loc;
					
					local lw = surface.GetTextSize("D");

					local emot = vgui.Create("DImage", msg);
					emot:SetImage(emotpath..v..".png");
					emot:SetPos(lw * loc, h);
					emot:SetSize(8, 8);
				end

				text = table.concat(pts);
			end
		end*/

		local _,h = surface.GetTextSize("W")
		local w,_ = surface.GetTextSize(text);
		local rows = w / (msg:GetWide() - (w1 + gw));

		if (rows > 1) then
			msg:SetTall(25 + (rows * h ))//* h));
			n:CenterVertical();
		end

		local x,y = msg:GetTall() / 2;

		local offset = 22
		if (ds:GetVBar():IsVisible()) then
			offset = offset + 10
		end

		local t = vgui.Create("DLabel", msg);
		t:SetFont(font);
		t:SetPos(18 + w1 + gw, 2);
		t:SetWide(msg:GetWide() - offset - w1 - gw);
		t:SetAutoStretchVertical(true);
		t:SetText(text);
		t:SetWrap(true);
		t:SetTextColor(Color(0, 0, 0, 255))
		//t:CenterVertical()

		if (rows > 1) then
			
			t:SetPos(18 + w1 + gw, 2);
			//t:SetPos(10 + w1, 2);
			//t:CenterVertical()
			g:CenterVertical()
		end

		function msg:OnMousePressed(btn)
			if (btn == MOUSE_RIGHT) then
				local opts = DermaMenu();
				opts:SetPos(gui.MousePos());
				opts:AddOption("Copy Sender Name", function()
					SetClipboardText(msg.Username);
				end):SetImage("icon16/user_edit.png");
				
				opts:AddOption("Copy Sender SteamID", function()
					SetClipboardText(msg.UserSteamID);
				end):SetImage("icon16/tag_blue.png");
				
				opts:AddOption("Copy Message String", function()
					SetClipboardText(msg.Username..": "..msg.Text);
				end):SetImage("icon16/page_white_text.png");

				if (LocalPlayer():hasPerm("ChatModeration")) then
					opts:AddOption("Delete Message", function()
						history[tid] = nil
						height = height - msg:GetTall()
						msg:Remove()
					end):SetImage("icon16/cancel.png")
				end
			end
		end

		height = height + msg:GetTall() + 1

		ds:ScrollToChild(msg)
	end

	for k,v in ipairs(history) do
		local name = v[1][1] or "Undefined";
		local col = v[1][3] or Color(0, 0, 0, 255);
		local id = v[1][2] or "Undefined";
		local text = v[2] or "Undefined";
		local tag = v[1][4] or "user";
		local tcol = v[1][5] or Color(0, 0, 0, 255);
		print(k)

		add(name, text, id, col, tag, tcol, k);
	end

	hook.Add("CBOT_MessageAdded", "AddMessage", function(ply, text)
		//hook.Call("OnPlayerChat", GAMEMODE, ply, text);

		local n_color = hook.Call("CBOX_GetNameColor", GAMEMODE, ply);
		local n_tag, t_color   = hook.Call("CBOX_GetChatTag", GAMEMODE, ply);

		local cmd = string.sub(text, 1, 1)
		if (cmd == "!" or cmd == "#" or cmd == "$" or cmd == "@") then return end

		table.insert(history, {
			{
				ply:Nick(),
				ply:SteamID(),
				n_color,
				n_tag,
				t_color,
			},
			text
		});

		add(ply:Nick(), text, ply:SteamID(), n_color, n_tag, t_color, #history);
		
	end)

	hook.Add("AddMessage", "S:KSJDF", function(prefix, text, pre_color)
		prefix = prefix or "Server";

		table.insert(history, {
			{
				prefix,
				prefix,
				pre_color,
				"",
			},
			text
		});
		
		add(prefix, text, "", pre_color, "", Color(0, 0, 0), #history, true);
		
	end)

	return f;
end

function chat.AddText(...)
	local tbl = {...};
	local str = "";
	for k,v in pairs(tbl) do
		if (isstring(v)) then str = str..v end
	end
	
	local tbl2 = string.Explode(" ", str);
	local pre = tbl2[1];
	table.remove(tbl2, 1);
	local str = table.concat(tbl2, " ");


	hook.Call("AddMessage", GAMEMODE, pre, str, tbl[1]);
end

hook.Add("OnPlayerChat", "Return", function()
	return true
end)

hook.Add("HUDPaint", "CreateMSGList", function()
	if (!msgbox) then
		msgbox = CreateListWindow();
	end
end)

local function CreateEditBox()
	local oldframe = framecolor;
	local oldbase  = basecolor;
	local oldbarup = barup;
	local oldbar = bar;

	framecolor = Color(236, 240, 241, 255);
	basecolor  = Color(220, 220, 220, 255);
	bar = Color(189, 195, 199, 255);
	barup = Color(127, 140, 141, 255);

	local f = vgui.Create("DFrame");
	f:SetSize(500, 35);
	f:SetPos(10, ScrH() - f:GetTall() - 165);
	f:MakePopup();
	f:ShowCloseButton(false);
	f:SetTitle(" ");
	function f:Paint(w, h)
		draw.RoundedBox(0, 0, 0, 400, h, Color(192, 57, 43, 255));
	end

	local edit = vgui.Create("DTextEntry", f);
	edit:SetSize(390, 25);
	edit:SetPos(5, 0)
	edit:CenterVertical();
	edit:SetValue("");
	edit:RequestFocus();
	function edit:OnEnter()

		if (string.len(edit:GetValue()) > 0) then
			hook.Call("CBOT_MessageAdded", GAMEMODE, LocalPlayer(), edit:GetValue());
			
			net.Start("CBOX_PlayerSayCall");
				net.WriteString(edit:GetValue());
			net.SendToServer();
		end

		f:Close();

		framecolor = oldframe;
		basecolor  = oldbase;
		bar = oldbar;
		barup = oldbarup;

		chat.Close()
	end

	local sub = vgui.Create("DButton", f)
	sub:SetSize(100, 35)
	sub:SetPos(400, 0)
	sub:SetText(" ")
	function sub:Paint(w, h)
		if (self:IsHovered()) then
			draw.RoundedBox(0, 0, 0, w, h, Color(46, 204, 113, 255));
		else
			draw.RoundedBox(0, 0, 0, w, h, Color(39, 174, 96, 255));
		end

		draw.SimpleText("Enter", font, w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end
	function sub:DoClick()
		edit:OnEnter()
	end

	return f;
end

hook.Add("StartChat", "CBOT:CHATSTART", function()
	chatbox = CreateEditBox();

	return true;
end)

hook.Add("FinishChat", "CBOT:CHATEND", function()
	if (chatbox) then chatbox:Remove(); chatbox = nil; end
end)

hook.Add("CBOX_GetChatTag", "GetChatTag", function(ply)
	local col = tags[ply:getGroup()] or Color(255, 255, 255)
	local tag = "["..ply:getGroup().."] " or "[User] "
	return tag, col
end)

hook.Add("CBOX_GetNameColor", "GetNameColor", function(ply)	
	return Color(0, 0, 0, 255);
end)

net.Receive("CBOX_NewMessage", function()
	local str = net.ReadString();
	local cal = net.ReadEntity();

	if (cal == LocalPlayer()) then return; end

	hook.Call("CBOT_MessageAdded", GAMEMODE, cal, str);
end)