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
	gray = Color(189, 195, 199, 255),
	gray_hover = Color(127, 140, 141, 255),
}
--[[asdf]]--
surface.CreateFont("shopHead", {font = "OpenSans-Bold", size = 60, weight = 500})
surface.CreateFont("shopBtn", {font = "OpenSans-Regular", size = 30, weight = 500})
surface.CreateFont("shopBtnSmall", {font = "OpenSans-Light", size = 15, weight = 500})

net.Receive("Shop_UpdateClientItems", function()
	local items = net.ReadString() or " "
	local equiped = net.ReadString() or " "

	timer.Create("timers_r_gay", 0.1, 0, function()
		if (LocalPlayer() and IsValid(LocalPlayer())) then
			LocalPlayer().Items = util.JSONToTable(items)
			LocalPlayer().Equiped = util.JSONToTable(equiped)
			timer.Destroy("timers_r_gay")
			MsgN("UPDATED")
		end
	end)
end)

local function createShopGUI()
	if (!LocalPlayer():IsSuperAdmin()) then chat.AddText("This is in beta, only super admins may use it!"); return; end


	local function getItemsForCategory(sCat)
		local tbl = {}

		for k,v in pairs(shop.Items) do
			if (v.category == sCat) then
				tbl[k] = v
			end
		end

		return tbl
	end

	local frame = vgui.Create("DFrame")
	frame:SetSize(837, 545) 
	frame:Center()
	frame:SetTitle(" ")
	frame:MakePopup()
	frame:ShowCloseButton(true)
	function frame:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, colors.back);
		draw.RoundedBox(0, 0, 0, w, 100, colors.head);
		draw.SimpleText("CShop", "shopHead", w / 2, 20, colors.text, TEXT_ALIGN_CENTER);
	end

	local catScroll = vgui.Create("DScrollPanel", frame)
	catScroll:SetSize(200, frame:GetTall() - 5)
	catScroll:SetPos(5, 110)

	local catList = vgui.Create("DIconLayout")
	catScroll:AddItem(catList)
	catList:SetSize(catScroll:GetWide(), catScroll:GetTall())
	catList:SetPos(0, 0)
	catList:SetSpaceY(2)

	local itScroll = vgui.Create("DScrollPanel", frame)
	itScroll:SetSize(frame:GetWide() - 210, frame:GetTall() - 35)
	itScroll:SetPos(210, 110)

	local itList = vgui.Create("DIconLayout")
	itScroll:AddItem(itList)
	itList:SetSize(itScroll:GetWide() - 5, itScroll:GetTall())
	itList:SetPos(0, 0)
	itList:SetSpaceY(1)

	local close = vgui.Create("DButton", frame)
	close:SetSize(150, 25)
	close:SetPos(frame:GetWide() - close:GetWide() - 5, frame:GetTall() - close:GetTall() - 5)
	close:SetText("")
	local ca = false; 
	function close:OnCursorEntered() ca = true; end
	function close:OnCursorExited() ca = false; end
	function close:Paint(w, h)
		if (ca) then
			draw.RoundedBox(0, 0, 0, close:GetWide(), close:GetTall(), colors.cancel_hover);
		else
			draw.RoundedBox(0, 0, 0, close:GetWide(), close:GetTall(), colors.cancel);
		end
		draw.SimpleText("Close", "shopBtnSmall", close:GetWide() / 2, 6, colors.text, TEXT_ALIGN_CENTER);
	end
	function close:DoClick()
		frame:Remove()
	end

	local function populateItemList(items)
		itList:Clear()

		for k,v in pairs(items) do
			local pnl = vgui.Create("DPanel", itList)
			pnl:SetSize(itList:GetWide(), 75)
			function pnl:Paint(w, h)
				draw.RoundedBox(0, 0, 0, w, h, colors.gray_hover);
			end

			local it = vgui.Create("DLabel", pnl)
			it:SetPos(0, 5)
			it:SetText(k)
			it:SetFont("shopBtnSmall")
			it:SetTextColor(colors.text)
			it:SizeToContents()
			it:CenterHorizontal()
			
			local txt = "Cost: "..v.price.." Dollars"
			if (v.canSell and LocalPlayer():ownsItem(k)) then
				txt = "Refund: "..v.sell.." Dollars"
			elseif (!v.canSell and LocalPlayer():ownsItem(k)) then
				txt = "No refund"
			end

			surface.SetFont(it:GetFont())
			local w,h = surface.GetTextSize(txt)

			local costp = vgui.Create("DPanel", pnl)
			costp:SetPos(pnl:GetWide() - 150 - 5, 0)
			costp:SetSize(150, 25)
			function costp:Paint(w, h)
				draw.RoundedBox(0, 0, 0, w, h, colors.gray);
			end


			local cost = vgui.Create("DLabel", costp)
			cost:SetPos(0, 5)
			cost:SetText(txt)
			cost:SetTextColor(colors.text)
			cost:SetFont("shopBtnSmall")
			cost:SizeToContents()
			cost:CenterHorizontal()

			if (v.display.type == "material") then

				local mat = vgui.Create("DPanel", pnl)
				mat:SetSize(65, 65)
				mat:SetPos(5, 5)
				function mat:Paint(width, height)
					surface.SetMaterial(Material(v.display.path, "noclamp"))
					surface.SetDrawColor(Color(255, 255, 255, 255))
					surface.DrawTexturedRect(0, 0, width, height)
				end

			elseif (v.display.type == "model") then

				local mod = vgui.Create("DModelPanel", pnl)
				mod:SetSize(65, 65)
				mod:SetPos(5, 5)
				mod:SetModel(Model(v.display.path))

			end

			local desc = vgui.Create("DLabel", pnl)
			desc:SetPos(75, 30)
			desc:SetSize(pnl:GetWide() - 75 - 155, pnl:GetTall() - 40)
			desc:SetText(v.description or "No description")
			desc:SetWrap(true)
			desc:SetFont("shopBtnSmall");
			desc:SetTextColor(colors.text)


			if (LocalPlayer():ownsItem(k)) then
				local eq = vgui.Create("DButton", pnl)
				eq:SetSize(150, 25)
				eq:SetPos(pnl:GetWide() - eq:GetWide() - 160, pnl:GetTall() - 30)

				local t = "Equip"
				local eqi = LocalPlayer():getEquipedPerCategory(v.category)

				if (eqi[k]) then
					t = "Holster"
				else
					local catMax = shop.Categories[v.category].maxEquiped
					if (#eqi + 1 > catMax) then
						eq:SetDisabled(true)
						eq:SetToolTip("You can't equip any more for this category!")							
					end
				end

				local e = false; 
				function eq:OnCursorEntered() e = true; end
				function eq:OnCursorExited() e = false; end
				function eq:Paint(w, h)
					if (e) then
						draw.RoundedBox(0, 0, 0, w, h, colors.closed_hover);
					else
						draw.RoundedBox(0, 0, 0, w, h, colors.closed);
					end
					
					draw.SimpleText(t, "shopBtnSmall", w / 2, 6, colors.text, TEXT_ALIGN_CENTER);
				end

				function eq:DoClick()
					if (eqi[k]) then
						net.Start("Shop_HolsterItem")
							net.WriteString(k)
						net.SendToServer()
					else
						net.Start("Shop_EquipItem")
							net.WriteString(k)
						net.SendToServer()
					end
				end

				
				eq:SetText(" ")

				local sell = vgui.Create("DButton", pnl)
				sell:SetSize(150, 25)
				sell:SetText(" ")
				sell:SetPos(pnl:GetWide() - sell:GetWide() - 5, pnl:GetTall() - sell:GetTall() - 5)

				if (!v.canSell) then
					sell:SetDisabled(true)
					sell:SetToolTip("This item is un-sellable!")
				end

				function sell:DoClick()
					net.Start("Shop_SellItem")
						net.WriteString(k)
					net.SendToServer()
				end
				local sa = false; 
				function sell:OnCursorEntered() sa = true; end
				function sell:OnCursorExited() sa = false; end
				function sell:Paint(w, h)
					if (sa) then
						draw.RoundedBox(0, 0, 0, w, h, colors.cancel_hover);
					else
						draw.RoundedBox(0, 0, 0, w, h, colors.cancel);
					end
					
					draw.SimpleText("Sell", "shopBtnSmall", w / 2, 6, colors.text, TEXT_ALIGN_CENTER);
				end

			else
			
				local buy = vgui.Create("DButton", pnl)
				buy:SetSize(150, 25)
				buy:SetText(" ")
				buy:SetPos(pnl:GetWide() - buy:GetWide() - 5, pnl:GetTall() - buy:GetTall() - 5)

				if (!LocalPlayer():canAfford(v.price)) then
					buy:SetDisabled(true)
					buy:SetText("You can't afford this!")
				end

				function buy:DoClick()
					net.Start("Shop_BuyItem")
						net.WriteString(k)
					net.SendToServer()
				end
				local ba = false; 
				function buy:OnCursorEntered() ba = true; end
				function buy:OnCursorExited() ba = false; end
				buy.Paint = function()
					if (ba) then
						draw.RoundedBox(0, 0, 0, buy:GetWide(), buy:GetTall(), colors.open_hover);
					else
						draw.RoundedBox(0, 0, 0, buy:GetWide(), buy:GetTall(), colors.open);
					end
					
					draw.SimpleText("Buy", "shopBtnSmall", buy:GetWide() / 2, 6, colors.text, TEXT_ALIGN_CENTER);
				end

			end
		end
	end

	local ct = 0
	local activeCat = "";
	for k,v in pairs(shop.Categories or {}) do
		local catBtn = vgui.Create("DButton", catList)
		catBtn:SetSize(catList:GetWide(), 25)
		catBtn:SetText("")
		if (v.image) then
			catBtn:SetImage(v.image)
		end
		function catBtn:DoClick()
			local items = getItemsForCategory(k)
			
			populateItemList(items)
			activeCat = k;
		end

		if (ct == 0) then
			local items = getItemsForCategory(k)

			populateItemList(items)
		end
		
		local cb = false; 
		function catBtn:OnCursorEntered() cb = true; end
		function catBtn:OnCursorExited() cb = false; end
		catBtn.Paint = function()
			if (k == activeCat) then
				if (cb) then
					draw.RoundedBox(0, 0, 0, catBtn:GetWide(), catBtn:GetTall(), colors.btn_hover);
				else
					draw.RoundedBox(0, 0, 0, catBtn:GetWide(), catBtn:GetTall(), colors.btn);
				end
				
				draw.SimpleText(k, "shopBtnSmall", catBtn:GetWide() / 2, 6, colors.text, TEXT_ALIGN_CENTER);
			else
				if (cb) then
					draw.RoundedBox(0, 0, 0, catBtn:GetWide(), catBtn:GetTall(), colors.gray_hover);
				else
					draw.RoundedBox(0, 0, 0, catBtn:GetWide(), catBtn:GetTall(), colors.gray);
				end
				
				draw.SimpleText(k, "shopBtnSmall", catBtn:GetWide() / 2, 6, colors.text, TEXT_ALIGN_CENTER);
			end
		end

	end
end
concommand.Add("shop", createShopGUI)