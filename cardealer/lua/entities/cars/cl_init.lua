include("shared.lua");

function ENT:Draw()
	self:DrawEntityOutline(1.0);
	self:DrawModel();
end
