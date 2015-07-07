local colors = {
	head = Color(192, 57, 43, 255),
	back = Color(236, 240, 241, 255),
	text = Color(255, 255, 255, 255),
	btn = Color(52, 73, 94, 255),
	btn_hover = Color(44, 62, 80, 255),
	deposit = Color(46, 204, 113, 255),
	deposit_hover = Color(39, 174, 96, 255),
	withdraw = Color(231, 76, 60, 255),
	withdraw_hover = Color(192, 57, 43, 255),
	bar = Color(189, 195, 199, 255),
	barup = Color(127, 140, 141, 255),
	transfer = Color(230, 126, 34, 255),
	transfer_hover = Color(211, 84, 0, 255),
	transfer_disabled = Color(230, 126, 34, 150),
	deposit_disabled = Color(46, 204, 113, 150),
	withdraw_disabled = Color(231, 76, 60, 150),
}

surface.CreateFont("mailHead", {font = "coolvetica", size = 60, weight = 500})
surface.CreateFont("mailBtn", {font = "coolvetica", size = 30, weight = 500})
surface.CreateFont("mailBtnSmall", {font = "coolvetica", size = 20, weight = 500})

function CreateMailMenu()
	
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
		draw.SimpleText("Daily Rewards", "mailHead", f:GetWide() / 2, 25, colors.text, TEXT_ALIGN_CENTER)
	end
	
	local ds = vgui.Create("DScrollPanel", f);
	ds:SetSize(f:GetWide() - 20, 285);
	ds:SetPos(10, 105);
	ds:GetVBar().Paint = function() draw.RoundedBox(0, 0, 0, ds:GetVBar():GetWide(), ds:GetVBar():GetTall(), Color(255, 255, 255, 0)) end
	ds:GetVBar().btnUp.Paint = function() draw.RoundedBox(0, 0, 0, ds:GetVBar().btnUp:GetWide(), ds:GetVBar().btnUp:GetTall(), colors.barup) end
	ds:GetVBar().btnDown.Paint = function() draw.RoundedBox(0, 0, 0, ds:GetVBar().btnDown:GetWide(), ds:GetVBar().btnDown:GetTall(), colors.barup) end
	ds:GetVBar().btnGrip.Paint = function(w, h) draw.RoundedBox(0, 0, 0, ds:GetVBar().btnGrip:GetWide(), ds:GetVBar().btnGrip:GetTall(), colors.bar) end

	local w = vgui.Create("DButton", f);
	w:SetText(" ");
	w:SetPos(10, f:GetTall() - 120);
	w:SetSize(f:GetWide() - 20, 50);
	local wA = false;
	function w:OnCursorEntered()
		wA = true;
	end
	function w:OnCursorExited()
		wA = false;
	end
	w.Paint = function()
		if (w:GetDisabled()) then
			draw.RoundedBox(0, 0, 0, w:GetWide(), w:GetTall(), colors.deposit_disabled);
		else
			if (wA) then
				draw.RoundedBox(0, 0, 0, w:GetWide(), w:GetTall(), colors.deposit_hover);
			else
				draw.RoundedBox(0, 0, 0, w:GetWide(), w:GetTall(), colors.deposit);
			end
		end
		draw.SimpleText("Choose a Random Reward!", "mailBtn", w:GetWide() / 2, 10, colors.text, TEXT_ALIGN_CENTER);
	end
	w.DoClick = function()
		f:Close();
		net.Start("redeem_reward");
		net.SendToServer();
	end

	for k,v in pairs(rewards) do
		
		local acc = vgui.Create("DPanel", ds);
		acc:SetSize(f:GetWide() - 20, 95);
		acc:SetPos(10, (k-1) * 100);
		acc.Paint = function()
			draw.RoundedBox(0, 0, 0, acc:GetWide(), acc:GetTall(), colors.btn);
			draw.SimpleText(v.name, "mailBtn", acc:GetWide() / 2, 12, colors.text, TEXT_ALIGN_CENTER);
			draw.SimpleText(v.desc, "mailBtnSmall", acc:GetWide() / 2, 48, colors.Text, TEXT_ALIGN_CENTER);
		end
		/*
		local im = vgui.Create("HTML", acc);
		im:SetPos(0, 0);
		im:SetSize(75, 94);
		im:SetHTML("<body bgcolor='4f4f4f'><center><img width='50' height='50' src='"..v.img.."' /></center></body>");
		im.PaintOver = function()
			surface.SetDrawColor(55, 55, 55, 255);
			surface.DrawLine(im:GetWide()-1, 1, im:GetWide()-1, im:GetTall());
		end*/
	
	end
		
	local close = vgui.Create("DButton", f);
	close:SetText(" ");
	close:SetPos(10, f:GetTall() - 60);
	close:SetSize(f:GetWide() - 20, 50);
	local ca = false;
	function close:OnCursorEntered()
		ca = true;
	end
	function close:OnCursorExited()
		ca = false;
	end
	close.Paint = function()
		if (close:GetDisabled()) then
			draw.RoundedBox(0, 0, 0, close:GetWide(), close:GetTall(), colors.withdraw_disabled);
		else
			if (ca) then
				draw.RoundedBox(0, 0, 0, close:GetWide(), close:GetTall(), colors.withdraw_hover);
			else
				draw.RoundedBox(0, 0, 0, close:GetWide(), close:GetTall(), colors.withdraw);
			end
		end
		draw.SimpleText("Close", "mailBtn", close:GetWide() / 2, 10, colors.text, TEXT_ALIGN_CENTER);
	end
	close.DoClick = function()
		f:Close();
		net.Start("mail_closed");
		net.SendToServer();
	end
end
concommand.Add("mail", CreateMailMenu);

concommand.Add("pos", function(ply)
	local pos = ply:GetPos();
	local ang = ply:GetAngles();
	print("{Vector("..pos.x..", "..pos.y..", "..pos.z.."), Angle("..ang.p..", "..ang.y..", "..ang.r..")},");
	

end)