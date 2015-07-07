AddCSLuaFile("shared.lua");
include("shared.lua");

function ENT:Initialize()
	self:SetModel( "models/props/CS_militia/mailbox01.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )     
	self:SetMoveType( MOVETYPE_NONE )  
	self:SetSolid( SOLID_VPHYSICS )         
 
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Use(act, call)
	if (IsValid(act) && !act.mailOpen) then
		act.mailOpen = true;
		act:ConCommand("mail");
	end
end

function ENT:Think()

end