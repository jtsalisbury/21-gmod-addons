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
}
--[[asdf]]--
surface.CreateFont("reportHead", {font = "coolvetica", size = 60, weight = 500})
surface.CreateFont("reportBtn", {font = "coolvetica", size = 30, weight = 500})
surface.CreateFont("reportBtnSmall", {font = "coolvetica", size = 15, weight = 500})

local fr = nil
net.Receive("OpenReportMenu_Admin", function()
	if (fr) then return end

	local reports = table.Reverse(net.ReadTable());
	local info = nil; 
	local key = 0;

	local f = vgui.Create("DFrame");
	f:SetPos(100, 100);
	f:SetSize(ScrW() - 100, ScrH() - 100);
	f:SetTitle(" ");
	f:SetVisible(true);
	f:MakePopup();
	f:Center();
	f:ShowCloseButton(false);
	f.Paint = function()
		draw.RoundedBox(0, 0, 0, f:GetWide(), f:GetTall(), colors.back);
		draw.RoundedBox(0, 0, 0, f:GetWide(), 100, colors.head);
		draw.SimpleText("Report | Admin Menu", "reportHead", f:GetWide() / 2, 25, colors.text, TEXT_ALIGN_CENTER)
	end

	fr = f

	local op_cl = vgui.Create("DButton", f);
	op_cl:SetText("");
	op_cl:SetSize(153, 50);
	op_cl:SetPos(520, f:GetTall() - 60);
	op_cl:SetDisabled(true);
	op_cl.DoClick = function()
		if (info) then
			if (info[7] == "Open") then
				reports[key][7] = "Close"

				net.Start("UpdateReport");
					net.WriteString("Close");
					net.WriteString(info[8])
				net.SendToServer();
			else
				reports[key][7] = "Open"

				net.Start("UpdateReport");
					net.WriteString("Open");
					net.WriteString(info[8])
				net.SendToServer();
			end
		end
	end
	local ba = false; 
	function op_cl:OnCursorEntered() ba = true; end
	function op_cl:OnCursorExited() ba = false; end
	op_cl.Paint = function()
		if (op_cl:GetDisabled()) then
			draw.RoundedBox(0, 0, 0, op_cl:GetWide(), op_cl:GetTall(), colors.open_disabled);
		else
			if (ba) then
				draw.RoundedBox(0, 0, 0, op_cl:GetWide(), op_cl:GetTall(), colors.open_hover);
			else
				draw.RoundedBox(0, 0, 0, op_cl:GetWide(), op_cl:GetTall(), colors.open);
			end
		end
		
			
		local txt = "Select a report!";
		if (info) then
			if (info[7] == "Open") then
				txt = "Close Report";
			else
				txt = "Re-Open Report";
			end
		end
		draw.SimpleText(txt, "reportBtn", op_cl:GetWide() / 2, 10, colors.text, TEXT_ALIGN_CENTER);
	end

	local del = vgui.Create("DButton", f);
	del:SetText("");
	del:SetSize(153, 50);
	del:SetPos(684, f:GetTall() - 60);
	del:SetDisabled(true);
	del.DoClick = function()
		if (info) then
			net.Start("DeleteReport");
				net.WriteString(info[8]);
			net.SendToServer();
			
			reports[key] = nil
		end
	end
	local da = false; 
	function del:OnCursorEntered() da = true; end
	function del:OnCursorExited() da = false; end
	del.Paint = function()
		if (del:GetDisabled()) then
			draw.RoundedBox(0, 0, 0, del:GetWide(), del:GetTall(), colors.open_disabled);
		else
			if (da) then
				draw.RoundedBox(0, 0, 0, del:GetWide(), del:GetTall(), colors.open_hover);
			else
				draw.RoundedBox(0, 0, 0, del:GetWide(), del:GetTall(), colors.open);
			end
		end
		draw.SimpleText("Delete Report", "reportBtn", op_cl:GetWide() / 2, 10, colors.text, TEXT_ALIGN_CENTER);
	end
	
	local close = vgui.Create("DButton", f);
	close:SetText("");
	close:SetSize(317, 50);
	close:SetPos(849, f:GetTall() - 60);
	close.DoClick = function()
		f:Close();
		fr = nil
	end
	local ca = false;
	function close:OnCursorEntered() ca = true; end
	function close:OnCursorExited() 	ca = false; end
	close.Paint = function()
		if (ca) then
			draw.RoundedBox(0, 0, 0, close:GetWide(), close:GetTall(), colors.cancel_hover);
		else
			draw.RoundedBox(0, 0, 0, close:GetWide(), close:GetTall(), colors.cancel);
		end
		draw.SimpleText("Cancel", "reportBtn", close:GetWide() / 2, 10, colors.text, TEXT_ALIGN_CENTER);
	end

	local pr = vgui.Create("DPanel", f);
	pr:SetSize(650, f:GetTall() - 180);
	pr:SetPos(520, 110);
	pr.Paint = function()
		draw.RoundedBox(0, 0, 0, pr:GetWide(), pr:GetTall(), Color(255, 255, 255, 255));
		if (!info) then
			draw.SimpleText("Select a report to begin!", "reportBtn", pr:GetWide()/2, 10, colors.text_blue, TEXT_ALIGN_CENTER);
		else
			draw.SimpleText("Creator: "..info[1], "reportBtn", 10, 10, colors.text_blue, TEXT_ALIGN_LEFT);
			draw.SimpleText("Creator SteamID: "..info[2], "reportBtn", 10, 37, colors.text_blue, TEXT_ALIGN_LEFT);

			draw.SimpleText("Against: "..info[3], "reportBtn", 10, 65, colors.text_blue, TEXT_ALIGN_LEFT);
			draw.SimpleText("Against SteamID: "..info[4], "reportBtn", 10, 95, colors.text_blue, TEXT_ALIGN_LEFT);

			draw.SimpleText("Status: "..info[7], "reportBtn", 10, 124, colors.text_blue, TEXT_ALIGN_LEFT);
			draw.SimpleText("Created: "..os.date("%c", info[9]), "reportBtn", 10, 153, colors.text_blue, TEXT_ALIGN_LEFT);

			draw.SimpleText("Reason: "..info[5], "reportBtn", 10, 182, colors.text_blue, TEXT_ALIGN_LEFT);
			//draw.SimpleText("Details: "..info[6], "reportBtn", 10, 176, colors.text, TEXT_ALIGN_LEFT);
		end
	end

	local pan = vgui.Create("DScrollPanel", pr);
	pan:SetSize(pr:GetWide() - 20, pr:GetTall() - 221);
	pan:SetPos(10, pr:GetTall() - 221);
	pan:GetVBar().Paint = function() draw.RoundedBox(0, 0, 0, pan:GetVBar():GetWide(), pan:GetVBar():GetTall(), Color(255, 255, 255, 0)) end
	pan:GetVBar().btnUp.Paint = function() draw.RoundedBox(0, 0, 0, pan:GetVBar().btnUp:GetWide(), pan:GetVBar().btnUp:GetTall(), colors.barup) end
	pan:GetVBar().btnDown.Paint = function() draw.RoundedBox(0, 0, 0, pan:GetVBar().btnDown:GetWide(), pan:GetVBar().btnDown:GetTall(), colors.barup) end
	pan:GetVBar().btnGrip.Paint = function(w, h) draw.RoundedBox(0, 0, 0, pan:GetVBar().btnGrip:GetWide(), pan:GetVBar().btnGrip:GetTall(), colors.bar) end
	

	local de = vgui.Create("DLabel", pan);
	de:SetWide(pan:GetWide());
	de:SetAutoStretchVertical(true);
	de:SetPos(0, 0);
	de:SetFont("reportBtn");
	de:SetWrap(true);
	de:SetColor(colors.text_blue);
	de:SetText(" ");	

	local li = vgui.Create("DListView", f);
	li:SetPos(10, 110);
	li:SetSize(500, f:GetTall() - 120);

	local cre = li:AddColumn("Creator");
	local aga = li:AddColumn("Against");
	local dat = li:AddColumn("Created");

	for k,v in pairs(reports) do
		local line = li:AddLine(v[1], v[3], os.date("%c", v[8]));
		line.id = k;
		line.reportInfo = v;
	end

	for k,v in pairs(li:GetLines()) do
		v.Paint = function()
			if (v.reportInfo[7] == "Open") then
				draw.RoundedBox(0, 0, 0, v:GetWide(), v:GetTall(), colors.open)
			else
				draw.RoundedBox(0, 0, 0, v:GetWide(), v:GetTall(), colors.closed)
			end
		end
	end

	li.OnClickLine = function(par, line) 
		info = line.reportInfo; 
		key = line.id; 
		if (LocalPlayer():SA()) then
			del:SetDisabled(false);
		end
		
		op_cl:SetDisabled(false);
		de:SetText("Details: "..info[6]);
	end
end)




net.Receive("OpenReportMenu", function()
	local targ = nil;
	local greason = nil;

	local f = vgui.Create("DFrame");
	f:SetPos(300, 300);
	f:SetSize(ScrW() - 700, ScrH() - 200);
	f:SetTitle(" ");
	f:SetVisible(true);
	f:MakePopup();
	f:Center();
	f:ShowCloseButton(false);
	f.Paint = function()
		draw.RoundedBox(0, 0, 0, f:GetWide(), f:GetTall(), colors.back);
		draw.RoundedBox(0, 0, 0, f:GetWide(), 100, colors.head);
		draw.SimpleText("Report A Player", "reportHead", f:GetWide() / 2, 25, colors.text, TEXT_ALIGN_CENTER)
	end

	local plist = vgui.Create("DComboBox", f);
	plist:SetPos(10, 110);
	plist:SetSize(f:GetWide() - 20, 25);
	plist:SetValue("Players");
	for k,v in pairs(player.GetAll()) do
		//if (v:Nick() == LocalPlayer():Nick()) then continue; end
		
		local item = plist:AddChoice(v:Nick())
	end
	plist.OnSelect = function(index, value, data)
		targ = data;
	end

	local greasons = vgui.Create("DComboBox", f);
	greasons:SetPos(10, 145);
	greasons:SetSize(f:GetWide() - 20, 25);
	greasons:SetValue("Reasons");
	for k,v in pairs(report.GeneralReasons) do
		local item = greasons:AddChoice(v)
	end
	greasons.OnSelect = function(index, value, data)
		greason = data;
	end

	local te = vgui.Create("DTextEntry", f);
	te:SetSize(f:GetWide() - 20, f:GetTall() - 310);
	te:SetMultiline(true);
	te:SetPos(10, 180);
	te:SetText("More Details");
	
	local d = vgui.Create("DButton", f);
	d:SetText(" ");
	d:SetPos(10, f:GetTall() - 120);
	d:SetSize(f:GetWide() - 20, 50);
	d:SetDisabled(true);
	local dA = false
	function d:OnCursorEntered() dA = true; end
	function d:OnCursorExited() dA = false; end
	d.Paint = function()
		if (d:GetDisabled()) then
			draw.RoundedBox(0, 0, 0, d:GetWide(), d:GetTall(), colors.btn_disabled);
		else
			if (dA) then
				draw.RoundedBox(0, 0, 0, d:GetWide(), d:GetTall(), colors.btn_hover);
			else
				draw.RoundedBox(0, 0, 0, d:GetWide(), d:GetTall(), colors.btn);
			end
		end
		draw.SimpleText("Report", "reportBtn", d:GetWide() / 2, 10, colors.text, TEXT_ALIGN_CENTER);
	end
	d.DoClick = function()
		net.Start("NewReport");
			net.WriteString(targ);
			net.WriteString(greason);
			net.WriteString(te:GetValue())
		net.SendToServer();
		f:Close();
	end
	
	
	local close = vgui.Create("DButton", f);
	close:SetText(" ");
	close:SetPos(10, f:GetTall() - 60);
	close:SetSize(f:GetWide() - 20, 50);
	local ca = false;
	function close:OnCursorEntered() ca = true; end
	function close:OnCursorExited() ca = false; end
	close.Paint = function()
	
		if (ca) then
			draw.RoundedBox(0, 0, 0, close:GetWide(), close:GetTall(), colors.cancel_hover);
		else
			draw.RoundedBox(0, 0, 0, close:GetWide(), close:GetTall(), colors.cancel);
		end
		draw.SimpleText("Cancel", "reportBtn", close:GetWide() / 2, 10, colors.text, TEXT_ALIGN_CENTER);
	end
	close.DoClick = function()
		f:Close();
	end
	
	function te:OnTextChanged()
		if (string.len(te:GetValue()) > 1 && targ && greason) then
			d:SetDisabled(false);
		else
			d:SetDisabled(true);
		end
	end

end)