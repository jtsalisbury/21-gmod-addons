local function notifyFunc(txt)
	local text = net.ReadString() or txt
	chat.AddText(Color(0, 0, 0), "[", Color(255, 100, 100), "Ascendance Servers", Color(0, 0, 0), "]: ", Color(255, 255, 255), text)
end
net.Receive("sendNotify", notifyFunc)

net.Receive("openDonMenu", function()
	local f = vgui.Create("DFrame")
	f:SetSize(300, 100)
	f:Center()
	f:SetTitle("Donation Redemption")
	f:MakePopup()

	local t = vgui.Create("DTextEntry", f)
	t:SetSize(f:GetWide() - 20, 25)
	t:SetPos(10, 25)
	t:SetValue("Paste Key Here")

	local s = vgui.Create("DButton", f)
	s:SetSize(f:GetWide() - 20, 50)
	s:SetPos(10, 60)
	s:SetText("Redeem!")
	function s:DoClick()
		net.Start("sendRequest")
			net.WriteString(t:GetValue())
		net.SendToServer()

		notifyFunc("We're sending your request to our database now. Please be patient while we retrive our results. This could take up to five minutes!")
		f:Close();
	end
end)