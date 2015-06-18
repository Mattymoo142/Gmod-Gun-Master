local smokepart = "smoke_trail_tfa"

local function rvec(vec)
	vec.x=math.Round(vec.x)
	vec.y=math.Round(vec.y)
	vec.z=math.Round(vec.z)
	return vec
end

local function PlayerCarryingTFAWeapon( ply )
	if !ply then
		if CLIENT then
			if IsValid(LocalPlayer()) then
				ply = LocalPlayer()
			else
				return false, nil, nil
			end
		else	
			return false, nil, nil
		end
	end
	
	if !ply:IsPlayer() then
		return
	end
	
	local wep = ply:GetActiveWeapon()
	if IsValid(wep) then
		local n=wep:GetClass()
		local nfind=string.find(n,"tfa")
		if (wep.Base and ( string.find(wep.Base,"tfa_gun_base") or string.find(wep.Base,"tfa_shotty_base") or string.find(wep.Base,"tfa_scoped_base") ) )then
			return true, ply, wep
		end
		return false, ply, wep
	end
	return false, ply, nil
end

function EFFECT:Init( data )
	local serverside = false
	local entity = data:GetEntity()
	if IsValid(entity) then
		local ownerent = entity.Owner
		if math.Round(data:GetMagnitude())==1 then
			serverside = true
		end
	else
		return
	end
	
	if serverside then
		if IsValid(ownerent) then
			if LocalPlayer() == ownerent then
				return
			end
		end
	end
	
	local attachment = data:GetAttachment()
	
	if attachment and attachment!=0 then
		if ( GetConVarNumber("cl_tfa_fx_muzzlesmoke",1)==1 ) then
			ParticleEffectAttach(smokepart,PATTACH_POINT_FOLLOW,entity,attachment)
		end
	end
end 

function EFFECT:Think( )
	return false
end

function EFFECT:Render()
end

 