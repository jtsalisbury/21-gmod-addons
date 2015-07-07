net.Receive("OpenSugMenu", function()
	local f = vgui.Create("DFrame")
	f:SetSize(ScrW() / 2, ScrH() / 2)
	f:Center()
	f:MakePopup()
	f:SetTitle(" ")
	f:ShowCloseButton(false)
	function f:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(236, 240, 241, 255));
		draw.RoundedBox(0, 0, 0, w, 20, Color(192, 57, 43, 255));
	
		draw.SimpleText("Suggestions", "ChatFont", f:GetWide() / 2, 2, Color(255, 255, 255), TEXT_ALIGN_CENTER)
	end

	local w, h = f:GetWide(), f:GetTall()

	local t = vgui.Create("DTextEntry", f)
	t:SetSize(w - 20, 20)
	t:SetPos(10, 30)
	t:SetValue("Title")

	local d = vgui.Create("DTextEntry", f)
	d:SetSize(w - 20, h - 105)
	d:SetPos(10, 60)
	d:SetValue("Suggestions")
	d:SetWrap(true)
	d:SetMultiline(true)

	local s = vgui.Create("DButton", f)
	s:SetSize((w / 2) - 15, 25)
	s:SetPos(10, h - 35)
	s:SetText(" ")
	function s:Paint(w, h)
		if (!self:IsHovered()) then
			draw.RoundedBox(0, 0, 0, w, h, Color(46, 204, 113, 255));
		else
			draw.RoundedBox(0, 0, 0, w, h, Color(39, 174, 96, 255));
		end

		draw.SimpleText("Submit", "ChatFont", w / 2, h / 5, Color(255, 255, 255), TEXT_ALIGN_CENTER)
	end
	function s:DoClick()
		net.Start("sug_submit")
			net.WriteString(t:GetValue())
			net.WriteString(d:GetValue())
		net.SendToServer()
		f:Close()
	end

	local c = vgui.Create("DButton", f)
	c:SetSize((w / 2) - 15, 25)
	c:SetPos(w - c:GetWide() - 10, h - 35)
	c:SetText(" ")
	function c:DoClick()
		f:Close()
	end
	function c:Paint(w, h)
		if (!self:IsHovered()) then
			draw.RoundedBox(0, 0, 0, w, h, Color(231, 76, 60, 255));
		else
			draw.RoundedBox(0, 0, 0, w, h, Color(192, 57, 43, 255));
		end
		
		draw.SimpleText("Cancel", "ChatFont", w / 2, h / 5, Color(255, 255, 255), TEXT_ALIGN_CENTER)
	end
end)

net.Receive("SugNotify", function()
	chat.AddText(Color(0, 0, 0), "[", Color(255, 0, 0), "Suggestions", Color(0, 0, 0), "]: ", Color(255, 255, 255), unpack(net.ReadTable()))
end)	