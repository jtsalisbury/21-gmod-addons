util.AddNetworkString("buy_car");
util.AddNetworkString("sell_car");
util.AddNetworkString("spawn_car");
util.AddNetworkString("close_menu");

local function carsMsg(ply, text)
	ply:Chat(Color(0, 0, 0, 255), "[", Color(255, 25, 25, 255), "Car Dealer", Color(0, 0, 0, 255), "] ", Color(255, 255, 255, 255), text)
end

local Player = FindMetaTable("Player");
function Player:BuyCar(name)
	if (!name) then carsMsg(self, "No car name supplied!"); return; end
	
	local car = cars[name].entity;
	if (!car) then carsMsg(self, "No car with this name!"); return; end
	
	local price = cars[name].price;
	if (!price) then carsMsg(self, "No price found for this car name! Contact a dev!"); return; end
	
	local boughtCars = self.boughtCars;
	if (!boughtCars) then self.boughtCars = {}; boughtCars = self.boughtCars; end
	
	if (boughtCars.car) then carsMsg(self, "You already own this car!"); return; end
	
	if (self:canAfford(price)) then 
		self:addMoney(price * -1);
		table.insert(boughtCars, car);
		self:SetNWString("cars", util.TableToJSON(boughtCars));
		return;
	end
	carsMsg(self, "You can't afford to buy this car!");
end

function Player:SellCar(name)
	local mine = self.boughtCars or {};
	if (!mine) then return; end
	
	local ent = cars[name].entity;
	if (!ent) then return; end
	
	if (table.HasValue(mine, ent)) then 
		table.remove(mine, table.KeyFromValue(mine, ent));
		local price = cars[name].price;
		local refund = price * 0.5;
		self:SetNWString("cars", util.TableToJSON(mine));
		self:addMoney(refund);
		return;
	end
	carsMsg(self, "You don't own this car!");
end

function Player:LoadCars()
	local path = "cars/"..self:UniqueID()..".txt";
	local json = file.Read(path, "DATA");
	
	if (!json) then return; end
	
	local tbl = util.JSONToTable(json);
	self:SetNWString("cars", json);
	self.boughtCars = tbl;
	carsMsg(self, "Cars loaded!");
end

function Player:SaveCars()
	local mine = self.boughtCars or {};
	if (!mine) then return; end
	
	local json = util.TableToJSON(mine);
	
	if (!file.Exists("cars", "DATA")) then
		file.CreateDir("cars");
	end
	file.Write("cars/"..self:UniqueID()..".txt", json);
end

function Player:SpawnCar(name)
	if (!name) then return; end
	if (!self:OwnsCar(name)) then return; end
	if (self.active_car) then self.active_car:Remove(); end
	
	local spawnpos = spawns[math.random(#spawns)];
	local pos = spawnpos[1];
	local ang = spawnpos[2];
	
	
	local vehicle = list.Get("Vehicles")[cars[name].entity];
	local v = ents.Create(vehicle.Class);
	
	if (!IsValid(v)) then return; end
	v:SetModel(cars[name].model);
	for k,i in pairs(vehicle.KeyValues) do
		v:SetKeyValue(k, i);
	end
	v:SetPos(pos);
	v:SetAngles(ang);
	v:Spawn();
	v:Activate();
	v:SetCollisionGroup( COLLISION_GROUP_VEHICLE );
	v:CPPISetOwner(self);
	v:keysOwn(self);
	v.Owner = self;
	v.OwnerID = self:SteamID();
	
	
	self.active_car = v;
	
	carsMsg(self, "Your car has been spawned!");
end

net.Receive("buy_car", function(len, client)
	client.menuOpen = false;
	client:BuyCar(net.ReadString());
end)

net.Receive("sell_car", function(len, client)
	client.menuOpen = false;
	client:SellCar(net.ReadString());
end)

net.Receive("spawn_car", function(len, client)
	client.menuOpen = false;
	client:SpawnCar(net.ReadString());
end)

net.Receive("close_menu", function(len, client)
	client.menuOpen = false;
	client:SpawnCar(net.ReadString());
end)

hook.Add("PlayerDisconnected", "SaveCars", function(ply)
	ply:SaveCars();
end)

hook.Add("PlayerInitialSpawn", "LoadCars", function(ply)
	ply:LoadCars();
end)