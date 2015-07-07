motd = motd or {};
motd.tabs = motd.tabs or {};

motd.ChatCommand = "!motd";

if (SERVER) then return; end

function motd.DefineTab(text, tabfunc)
	table.insert(motd.tabs, {text, tabfunc});
end

motd.DefineTab("Home", function(base, w, h, _, colors)
	local pnl = vgui.Create("DPanel", base);
	pnl:SetSize(base:GetWide(), base:GetTall());
	pnl:SetPos(0, 0);
	function pnl:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, colors.lightgray);
	end

	local text = vgui.Create("DLabel", pnl);
	text:SetText("Hello. Welcome. \nYou can do almost anything you want, so have fun!");
	text:SetFont("motdBtn");
	text:SetTextColor(colors.text_blue);
	text:SizeToContents();
	text:Center();

	return pnl;
end)

motd.DefineTab("Website", function(base, w, h, _, colors)
	local pnl = vgui.Create("DPanel", base);
	pnl:SetSize(w, h);
	pnl:SetPos(0, 0);
	function pnl:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, colors.lightgray);
	end

	local html = vgui.Create("DHTML", pnl);
	html:SetSize(pnl:GetWide(), pnl:GetTall());
	html:OpenURL("http://wwww.geekgalaxy.tk");

	return pnl;
end)

motd.DefineTab("Rules", function(base, w, h, _, colors)
	local pnl = vgui.Create("DPanel", base);
	pnl:SetSize(w, h);
	pnl:SetPos(0, 0);
	function pnl:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, colors.lightgray);
	end

	local rules = vgui.Create("DLabel", pnl);
	rules:SetText("Have fun. Rules are at the Admin's discretion.");
	rules:SetFont("motdBtn");
	rules:SetTextColor(colors.text_blue);
	rules:SizeToContents();
	rules:Center();

	return pnl;
end)

motd.DefineTab("Close", function(base, _, _, frame)
	frame:Remove();
end)