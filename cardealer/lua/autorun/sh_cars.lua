cars = {};
spawns = {};

function AddCar(name, desc, ent, price, mod, scriptt)
	if (!name or !desc or !price or !mod or !ent or !scriptt) then return; end
	
	if (!cars) then cars = {}; end
	
	cars[name] = {
		description = desc,
		entity = ent,
		price = price,
		model = mod,
		script = scriptt,
	}
end

function AddPoint(vector, angle)
	if (!vector or !angle) then return; end
	table.insert(spawns, {vector, angle});
end

local Player = FindMetaTable("Player");

function Player:OwnsCar(name)
	local mine = self:GetNWString("cars");
	if (!mine) then return; end
	
	local mine = util.JSONToTable(mine) or {};
	
	local ent = cars[name].entity or nil;
	if (!ent) then return; end
	
	return table.HasValue(mine, ent);
end

AddCar("Bugatti EB110", "", "eb110tdm", 150000, "models/tdmcars/bug_eb110.mdl", "scripts/vehicles/tdmcars/eb110.txt");
AddCar("Bugatti Veyron", "", "veyrontdm", 200000, "models/tdmcars/bug_veyron.mdl", "scripts/vehicles/tdmcars/veyron.txt");
AddCar("Bugatti Veyron SS", "", "veyronsstdm", 220000, "models/tdmcars/bug_veyronss.mdl", "scripts/vehicles/tdmcars/veyronss.txt");
AddCar("Delorean DMC-12", "", "deloreantdm", 150000, "models/tdmcars/del_dmc.mdl", "scripts/vehicles/tdmcars/delorean.txt");

AddCar("Ferrari 250GT", "", "ferrari250gttdm", 150000, "models/tdmcars/ferrari250gt.mdl", "scripts/vehicles/tdmcars/ferrari250gt.txt");
AddCar("Ferrari 458 Spider", "", "458spidtdm", 150000, "models/tdmcars/fer_458spid.mdl", "scripts/vehicles/tdmcars/fer458spid.txt");
AddCar("Ferrari 512 TR", "", "ferrari512trtdm", 150000, "models/tdmcars/ferrari512tr.mdl", "scripts/vehicles/tdmcars/ferrari512tr.txt");
AddCar("Ferrari Enzo", "", "enzotdm", 150000, "models/tdmcars/fer_enzo.mdl", "scripts/vehicles/tdmcars/enzo.txt");
AddCar("Ferrari F50", "", "f50tdm", 150000, "models/tdmcars/fer_f50.mdl", "scripts/vehicles/tdmcars/f50.txt");

AddCar("KTM X-BOW", "", "xbowtdm", 100000, "models/tdmcars/ktm_xbow.mdl", "scripts/vehicles/tdmcars/xbow.txt");
AddCar("Lamborghini Diablo", "", "diablotdm", 150000, "models/tdmcars/lambo_diablo.mdl", "scripts/vehicles/tdmcars/diablo.txt");
AddCar("Lamborghini Gallardo", "", "gallardotdm", 200000, "models/tdmcars/gallardo.mdl", "scripts/vehicles/tdmcars/gallardo.txt");
AddCar("Lamborghini Gallardo LP570-4", "gallardospydtdm", "", 250000, "models/tdmcars/lam_gallardospyd.mdl", "scripts/vehicles/tdmcars/gallardospyd.txt");
AddCar("Lamborghini Miura Concept", "", "miuracontdm", 200000, "models/tdmcars/lam_miuracon.mdl", "scripts/vehicles/tdmcars/miuracon.txt");
AddCar("Lamborghini Murcielago", "", "murcielagotdm", 250000, "models/tdmcars/murcielago.mdl", "scripts/vehicles/tdmcars/murcielago.txt");
AddCar("Lamborghini Murcielago LP 670-4 SV", "", "murcielagosvtdm", 250000, "models/tdmcars/lambo_murcielagosv.mdl", "scripts/vehicles/tdmcars/murcielagosv.txt");
AddCar("Lamborghini Reventon Roadster", "", "reventonrtdm", 250000, "models/tdmcars/reventon_roadster.mdl", "scripts/vehicles/tdmcars/reventonr.txt");

AddCar("Morgan Aero SS", "", "morgaerosstdm", 300000, "models/tdmcars/morg_aeross.mdl", "scripts/vehicles/tdmcars/morg_aeross.txt");
AddCar("Noble M600", "", "noblem600tdm", 250000, "models/tdmcars/noblem600.mdl", "scripts/vehicles/tdmcars/noblem600.txt");

AddCar("Pagani Carsport America Zonda GR", "", "zondagrtdm", 300000, "models/tdmcars/zondagr.mdl", "scripts/vehicles/tdmcars/zondagr.txt");
AddCar("Pagani Zonda C12", "", "c12tdm", 275000, "models/tdmcars/zondac12.mdl", "scripts/vehicles/tdmcars/c12.txt");

AddCar("Porsche 911 GT3-RSR", "", "porgt3rsrtdm", 250000, "models/tdmcars/por_gt3rsr.mdl", "scripts/vehicles/tdmcars/porgt3rsr.txt");
AddCar("Porsche 918 Spyder", "", "918spydtdm", 250000, "models/tdmcars/por_918.mdl", "scripts/vehicles/tdmcars/918spyd.txt");
//AddCar("Porsche 997 GT3", "", "997gt3tdm", 250000, "models/tdmcars/.mdl", "scripts/vehicles/tdmcars/997gt3.txt");
AddCar("Porsche Carrera GT", "", "carreragttdm", 250000, "models/tdmcars/por_carreragt.mdl", "scripts/vehicles/tdmcars/carreragt.txt");
AddCar("Porsche Cayenne Turbo 12", "", "cayenne12tdm", 250000, "models/tdmcars/por_cayenne12.mdl", "scripts/vehicles/tdmcars/cayenne12.txt");
//AddCar("Porsche Cayenne Turbo S", "", "cayennetdm", 250000, "models/tdmcars/.mdl", "scripts/vehicles/tdmcars/.txt");
AddCar("Porsche Cayenne Tricycle", "", "porcycletdm", 250000, "models/tdmcars/por_tricycle.mdl", "scripts/vehicles/tdmcars/porcycle.txt");

AddCar("Tesla Model S", "", "tesmodelstdm", 100000, "models/tdmcars/tesla_models.mdl", "scripts/vehicles/tdmcars/teslamodels.txt");
AddCar("Toyota FJ Cruiser", "", "toyfjtdm", 50000, "models/tdmcars/toy_fj.mdl", "scripts/vehicles/tdmcars/toyfj.txt");
AddCar("Toyota MR2 GT", "", "mr2gttdm", 50000, "models/tdmcars/toy_mr2gt.mdl", "scripts/vehicles/tdmcars/mr2gt.txt");
AddCar("Toyota Prius", "", "priustdm", 50000, "models/tdmcars/prius.mdl", "scripts/vehicles/tdmcars/prius.txt");
AddCar("Toyota RAV4 Sport", "", "toyrav4tdm", 50000, "models/tdmcars/toy_rav4.mdl", "scripts/vehicles/tdmcars/toyrav4.txt");
AddCar("Toyota Supra", "", "supratdm", 350000, "models/tdmcars/supra.mdl", "scripts/vehicles/tdmcars/supra.txt");
AddCar("Toyota Tundra Crewmax", "", "toytundratdm", 50000, "models/tdmcars/toy_tundra.mdl", "scripts/vehicles/tdmcars/toytundra.txt");

AddCar("Zenvo ST1", "", "st1tdm", 250000, "models/tdmcars/zen_st1.mdl", "scripts/vehicles/tdmcars/st1.txt");

AddPoint(Vector(4691.861328, 2225.437500, 41.031250), Angle(0, 90, 0));
AddPoint(Vector(4881.062012, 2218.409912, 41.031250), Angle(0, 90, 0));
AddPoint(Vector(4691.846191, 1890.415771, 41.031250), Angle(0, 90, 0));
AddPoint(Vector(4881.871094, 1890.108521, 41.031250), Angle(0, 90, 0));
