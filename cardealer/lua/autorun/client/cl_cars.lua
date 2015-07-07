local colors = {
	head = Color(192, 57, 43, 255),
	back = Color(236, 240, 241, 255),
	text = Color(255, 255, 255, 255),
	btn = Color(52, 73, 94, 255),
	btn_hover = Color(44, 62, 80, 255),
	buy = Color(46, 204, 113, 255),
	buy_hover = Color(39, 174, 96, 255),
	cancel = Color(231, 76, 60, 255),
	cancel_hover = Color(192, 57, 43, 255),
	bar = Color(189, 195, 199, 255),
	barup = Color(127, 140, 141, 255),
	spawn = Color(230, 126, 34, 255),
	spawn_hover = Color(211, 84, 0, 255),
}

surface.CreateFont("carsHead", {font = "coolvetica", size = 60, weight = 500})
surface.CreateFont("carsBtn", {font = "coolvetica", size = 30, weight = 500})
surface.CreateFont("carsBtnSmall", {font = "coolvetica", size = 15, weight = 500})

function CreateCarsMenu()
	local nocar = false;
	local price = 0;

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
		draw.SimpleText("Cars For Sale", "carsHead", f:GetWide() / 2, 25, colors.text, TEXT_ALIGN_CENTER)
	end
	
	local mdl = vgui.Create("DModelPanel", f);
	mdl:SetModel(Model("models/buggy.mdl"));
	mdl:SetSize(650, f:GetTall() - 210);
	mdl:SetPos(520, 110);
	mdl:SetCamPos(Vector(50, 50, 120));
	mdl:SetLookAt(Vector(0, 0, 0));
	mdl:SetVisible(false);
	
	local is_buy = false;
	
	function CreateBuy(car)
		local buy = vgui.Create("DButton", f);
		buy:SetText("");
		buy:SetSize(317, 50);
		buy:SetPos(520, f:GetTall() - 60);
		buy.car = "None";
		is_buy = buy;
		buy.DoClick = function()
			if (LocalPlayer():OwnsCar(car)) then
				f:Close();
				net.Start("sell_car");
					net.WriteString(car);
				net.SendToServer();
			else
				f:Close();
				net.Start("buy_car");
					net.WriteString(car);
				net.SendToServer();
			end
		end
		local ba = false;
		function buy:OnCursorEntered()
			ba = true;
		end
		function buy:OnCursorExited()
			ba = false;
		end
		buy.Paint = function()
			if (ba) then
				draw.RoundedBox(0, 0, 0, buy:GetWide(), buy:GetTall(), colors.buy_hover);
			else
				draw.RoundedBox(0, 0, 0, buy:GetWide(), buy:GetTall(), colors.buy);
			end
		
			local txt = "Buy Car";
			if (LocalPlayer():OwnsCar(car)) then
				txt = "Sell Car";
			end
			draw.SimpleText(txt, "carsBtn", buy:GetWide() / 2, 10, colors.text, TEXT_ALIGN_CENTER);
		end
		if (!LocalPlayer():canAfford(price)) then
			buy:SetDisabled(true);
		end
		if (LocalPlayer():OwnsCar(car)) then
			buy:SetSize(153, 50);
			
			local spawn = vgui.Create("DButton", f);
			spawn:SetText("");
			spawn:SetSize(153, 50);
			spawn:SetPos(684, f:GetTall() - 60);
			spawn.DoClick = function()
				f:Close();
				net.Start("spawn_car");
					net.WriteString(car);
				net.SendToServer();
			end
			local sp = false;
			function spawn:OnCursorEntered()
				sp = true;
			end
			function spawn:OnCursorExited()
				sp = false;
			end
			spawn.Paint = function()
				if (sp) then
					draw.RoundedBox(0, 0, 0, spawn:GetWide(), spawn:GetTall(), colors.spawn_hover);
				else
					draw.RoundedBox(0, 0, 0, spawn:GetWide(), spawn:GetTall(), colors.spawn);
				end
				draw.SimpleText("Spawn Car", "carsBtn", spawn:GetWide() / 2, 10, colors.text, TEXT_ALIGN_CENTER);
			end
		end
	end
	
	local close = vgui.Create("DButton", f);
	close:SetText("");
	close:SetSize(317, 50);
	close:SetPos(849, f:GetTall() - 60);
	close.DoClick = function()
		f:Close();
		net.Start("close_menu");
		net.SendToServer();
	end
	local ca = false;
	function close:OnCursorEntered()
		ca = true;
	end
	function close:OnCursorExited()
		ca = false;
	end
	close.Paint = function()
		if (ca) then
			draw.RoundedBox(0, 0, 0, close:GetWide(), close:GetTall(), colors.cancel_hover);
		else
			draw.RoundedBox(0, 0, 0, close:GetWide(), close:GetTall(), colors.cancel);
		end
		draw.SimpleText("Cancel", "carsBtn", close:GetWide() / 2, 10, colors.text, TEXT_ALIGN_CENTER);
	end
	
	local pr = vgui.Create("DPanel", f);
	pr:SetSize(650, 50);
	pr:SetPos(520, f:GetTall() - 120);
	pr.Paint = function()
		draw.RoundedBox(0, 0, 0, pr:GetWide(), pr:GetTall(), colors.cancel_hover);
		if (!nocar) then
			draw.SimpleText("Select a car to begin!", "carsBtn", pr:GetWide()/2, 12, colors.text, TEXT_ALIGN_CENTER);
		else
			draw.SimpleText("Price: $"..price, "carsBtn", 60, 12, colors.text, TEXT_ALIGN_CENTER);
			draw.SimpleText("Refund: $"..(price * 0.5), "carsBtn", 580, 12, colors.text, TEXT_ALIGN_CENTER);
			draw.SimpleText(nocar, "carsBtn", pr:GetWide() / 2, 12, colors.text, TEXT_ALIGN_CENTER);
		end
	end
	
	local ds = vgui.Create("DScrollPanel", f);
	ds:SetSize(500, f:GetTall() - 110);
	ds:SetPos(10, 105);
	ds:GetVBar().Paint = function() draw.RoundedBox(0, 0, 0, ds:GetVBar():GetWide(), ds:GetVBar():GetTall(), Color(255, 255, 255, 0)) end
	ds:GetVBar().btnUp.Paint = function() draw.RoundedBox(0, 0, 0, ds:GetVBar().btnUp:GetWide(), ds:GetVBar().btnUp:GetTall(), colors.barup) end
	ds:GetVBar().btnDown.Paint = function() draw.RoundedBox(0, 0, 0, ds:GetVBar().btnDown:GetWide(), ds:GetVBar().btnDown:GetTall(), colors.barup) end
	ds:GetVBar().btnGrip.Paint = function(w, h) draw.RoundedBox(0, 0, 0, ds:GetVBar().btnGrip:GetWide(), ds:GetVBar().btnGrip:GetTall(), colors.bar) end
	
	
	local count = 0;
	for k, v in pairs(cars) do
		local b = vgui.Create("DButton", ds);
		b:SetText(" ");
		b:SetPos(0, count * 55);
		b:SetSize(490, 50);
		b.price = v.price;
		b.model = v.model;
		
		count = count + 1;
		
		local e = false;
		function b:OnCursorEntered()
			e = true;
		end
		function b:OnCursorExited()
			e = false;
		end
		b.Paint = function()
			if (e) then
				draw.RoundedBox(0, 0, 0, b:GetWide(), b:GetTall(), colors.btn_hover);
			else
				draw.RoundedBox(0, 0, 0, b:GetWide(), b:GetTall(), colors.btn);
			end
			draw.SimpleText(k, "carsBtn", b:GetWide() / 2, 10, colors.text, TEXT_ALIGN_CENTER);
			draw.SimpleText("Owned", "carsBtnSmall", b:GetWide() - 30, 18, colors.text, TEXT_ALIGN_RIGHT);
			
			local i = vgui.Create("DImage", b);
			i:SetPos(b:GetWide() - 16, 20);
			i:SizeToContents();
			if (LocalPlayer():OwnsCar(k)) then
				i:SetImage("icon16/tick.png");
			else
				i:SetImage("icon16/cross.png");
			end
		end
		b.DoClick = function()
			mdl:SetModel(Model(b.model));
			mdl:SetVisible(true);
			nocar = k;
			price = b.price
			if (is_buy) then
				is_buy:Remove();
				CreateBuy(k);
			else
				CreateBuy(k);
			end
		end
	end
end
concommand.Add("cars", CreateCarsMenu);

concommand.Add("mdl", function()
	local pos = LocalPlayer():GetPos();
	local ang = LocalPlayer():GetAimVector();

	local trd = {
		start = pos,
		endpos = pos + (ang * 80),
	};
	local tr = util.TraceLine(trd);
	
	print(tr.Entity:GetModel())
end)