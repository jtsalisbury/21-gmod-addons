local function tp(ply, args)
	if (!ply:hasPerm("TP")) then return am.broadcast(ply, "You aren't staff! You can't do this!"); end
	local user = am.finduser(args[1]);
	local loc = args[2];

	if (!user) then return am.broadcast(ply, "User not found!"); end
	if (!ply:IsValid()) then return am.broadcast(ply, "You must be in game tp perform this command!"); end
	if (!ply:Alive()) then return am.broadcast(ply, "You must be alive to perform this command!"); end
	if (!user:Alive()) then return am.broadcast(ply, "The target is dead!"); end
	if (user:InVehicle()) then user:ExitVehicle(); end //force the target out of their car if they're in it.

	if (loc) then //tp target to location
		for k,v in pairs(teleport) do
			if (string.Trim(loc) == k) then
				local randPos = math.random(1, #v);
				local randPos = math.Round(randPos); //round it, since math.random can return a decimal.
				local pos = v[randPos];
			
				user:SetPos(pos);
				user:SetLocalVelocity(Vector(0, 0, 0)); //stop from moving!
				broadcast(Color(25, 255, 25), ply:Nick(), Color(255, 255, 255), " teleported ", Color(25, 255, 25), user:Nick(), Color(255, 255, 255), " to ", Color(25, 255, 25), k);
				return;
			end
		end
		am.broadcast(ply, "Invalid location supplied!");
		return;

	else //tp where player is looking

		local trace = {}; //based off of ulx's trace.
		trace.start = ply:GetPos() * Vector(0, 0, 32);
		trace.endpos = ply:GetPos() + ply:EyeAngles():Forward()* 16384;
		trace.filter = user;
		if (user != ply) then
			trace.filter = {user, ply};
		end

		local tr = util.TraceEntity(trace, user);
		local pos = tr.HitPos;
		print(tostring(pos));
		if (user == ply && pos:Distance(user:GetPos()) < 64) then return; end

		user:SetPos(pos);
		user:SetLocalVelocity(Vector(0, 0, 0));
		am.broadcast(ply:Nick(), " teleported ", user:Nick());

	end
end
AddChatCommand("!tp", tp);

local function getNewPos( from, to, force ) //taked directly from ulx. I didn't make this.

	if not to:IsInWorld() and not force then return false end -- No way we can do this one

	local yawForward = to:EyeAngles().yaw
	local directions = { -- Directions to try
		math.NormalizeAngle( yawForward - 180 ), -- Behind first
		math.NormalizeAngle( yawForward + 90 ), -- Right
		math.NormalizeAngle( yawForward - 90 ), -- Left
		yawForward,
	}

	local t = {}
	t.start = to:GetPos() + Vector( 0, 0, 32 ) -- Move them up a bit so they can travel across the ground
	t.filter = { to, from }

	local i = 1
	t.endpos = to:GetPos() + Angle( 0, directions[ i ], 0 ):Forward() * 47 -- (33 is player width, this is sqrt( 33^2 * 2 ))
	local tr = util.TraceEntity( t, from )
	while tr.Hit do -- While it's hitting something, check other angles
		i = i + 1
		if i > #directions then	 -- No place found
			if force then
				from.ulx_prevpos = from:GetPos()
				from.ulx_prevang = from:EyeAngles()
				return to:GetPos() + Angle( 0, directions[ 1 ], 0 ):Forward() * 47
			else
				return false
			end
		end

		t.endpos = to:GetPos() + Angle( 0, directions[ i ], 0 ):Forward() * 47

		tr = util.TraceEntity( t, from )
	end

	from.ulx_prevpos = from:GetPos()
	from.ulx_prevang = from:EyeAngles()
	return tr.HitPos
end


local function goto(ply, args)
	if (!ply:hasPerm("Goto")) then return am.broadcast(ply, "You aren't staff! You can't do this!"); end
	local user = am.finduser(args[1]);

	if (!user) then return am.broadcast(ply, "No user could be found!"); end
	if (!ply:Alive()) then return am.broadcast(ply, "You must be alive to do this!"); end
	if (!ply:IsValid()) then return am.broadcast(ply, "You must be in game to do this!"); end
	if (ply:InVehicle()) then ply:ExitVehicle(); end
	local newPos = getNewPos(ply, user, ply:GetMoveType() == MOVETYPE_NOCLIP);
	if (!newPos) then
		return am.broadcast(ply, "Can't find a place to put you!! Noclip and try again!");
	end

	local newAng = (user:GetPos() - newPos):Angle();

	ply:SetPos(newPos);
	ply:SetEyeAngles(newAng);
	ply:SetLocalVelocity(Vector(0, 0, 0));
	am.broadcast(ply:Nick(), " teleported to ", user:Nick());
end
AddChatCommand("!goto", goto);