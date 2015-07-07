AddCSLuaFile("shared.lua");
include("shared.lua");

function ENT:Initialize()
	self:SetModel( "models/odessa.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )     
	self:SetMoveType( MOVETYPE_NONE )  
	self:SetSolid( SOLID_VPHYSICS )         
 
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Use(act, call)
	if (IsValid(act) && !act.menuOpen) then
		act.menuOpen = true;
		act:ConCommand("cars");
	end
end

function ENT:Think()

end

hook.Add("Initialize", "SpawnCARNPC", function()
	timer.Simple(5, function()
		local n = ents.Create("cars");
		n:SetPos(Vector(4075.595459, 2387.017822, 41.031250));
		n:SetAngles(Angle(0, 90, 0));
		n:DropToFloor();
		n:Spawn();
		n:Activate();
	end)
end)