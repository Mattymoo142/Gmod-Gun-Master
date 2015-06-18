--[[ 
Function Name:  FireAnimationEvent
Syntax: self:FireAnimationEvent( position, angle, event id, options). 
Returns:  Nothing.
Notes:    Used to capture and disable viewmodel animation events, unless you disable that feature.
Purpose:  FX
]]--

function SWEP:FireAnimationEvent(pos, ang, event, options)
	if self.CustomMuzzleFlash or !self.DoMuzzleFlash then
	
		-- Disables animation based muzzle event
		if ( event == 21 ) then return true end	

		-- Disable thirdperson muzzle flash
		if ( event == 5003 ) then return true end
		-- Disable CS-style muzzle flashes, but chance our muzzle flash attachment if one is given.
		if (event == 5001 or event == 5011 or event == 5021 or event == 5031) then 
			if self.AutoDetectMuzzleAttachment then
				self.MuzzleAttachmentRaw = math.Clamp( math.floor( ( event - 4991 ) / 10 ), 1, 4)
				timer.Simple(0, function()
					if IsValid(self) then
						self:ShootEffects()
					end
				end)
			end
			return true 
		end 
	end
end

--[[ 
Function Name:  MakeMuzzleSmoke
Syntax: self:MakeMuzzleSmoke( entity, attachment). 
Returns:  Nothing.
Notes:    Used to make the muzzle smoke effect, clientside.
Purpose:  FX
]]--

function SWEP:MakeMuzzleSmoke(entity,attachment)
	
	self:CleanParticles()
	
	local ht = self.DefaultHoldType and self.DefaultHoldType or self.HoldType
	if ( (CLIENT ) and GetConVarNumber("cl_tfa_fx_muzzlesmoke",1)==1) then
		if IsValid(entity) then
			if attachment and attachment!=0 then
				ParticleEffectAttach(self.SmokeParticles[ht],PATTACH_POINT_FOLLOW,entity,attachment)
			end
		end
	end
	
end

--[[ 
Function Name:  MakeMuzzleFlash
Syntax: self:MakeMuzzleFlash( pos, normal (ang:Up()), entity, attachment, actually use the given position, use the given normal). 
Returns:  Nothing.
Notes:    Used to make the muzzle flash effect, clientside.
Purpose:  FX
]]--
	
local blankvec = Vector(0,0,0)

function SWEP:MakeMuzzleFlash(pos,normal,entity,attachment, usepos, usenormal)
	
	if !IsValid(self.Owner) then return end
	--[[
	print("Making muzzle flash clientside.")
	print("Pos:")
	print(pos)
	print("Normal:")
	print(normal)
	print("Ent:")
	print(entity)
	print("Att:")
	print(attachment)
	print("Use pos?")
	print(usepos)
	print("Use Normal?")
	print(usenormal)
	]]--
	local fp = self:IsFirstPerson()
	
	local ef = EffectData()
	
	if IsValid(entity) then
		ef:SetEntity(entity)
		ef:SetOrigin(blankvec)
	else
		ef:SetOrigin(blankvec)
		ef:SetEntity(self)
	end
	
	ef:SetAttachment( attachment )
	
	if LocalPlayer then
		ef:SetStart( Vector( LocalPlayer():EntIndex(),0,self:EntIndex() ) )
	else
		ef:SetStart( Vector( Entity(1):EntIndex(),0,self:EntIndex() ) )	
	end
	
	local rpos = entity:GetAttachment(attachment)
	
	if fp then
		ef:SetNormal(self.Owner:EyeAngles():Forward())
	else
		local ang = self.Owner:EyeAngles()
		ef:SetNormal(Angle(math.Clamp(ang.p,-55,55),ang.y,ang.r):Forward())
	end
	
	if usepos then
		ef:SetOrigin(pos)
	else
		--[[
		local tpos = self:GetMuzzlePos()
		if tpos and tpos.Pos then
			print(tpos.Pos)
			ef:SetOrigin(tpos.Pos)
		end
		]]--
	end

	if usenormal then
		ef:SetNormal(normal)
	end
	
	if !self.MuzzleFlashEffect then
		if (self:GetSilenced()) then
			util.Effect("tfa_muzzleflash_silenced", ef)
		else
			local a=string.lower(self.Primary.Ammo)
			if a=="buckshot" or a=="slam" or a=="airboatgun" then
				util.Effect("tfa_muzzleflash_shotgun", ef)
			else
				util.Effect("tfa_muzzleflash_rifle", ef)
			end
		end
	else
		util.Effect(self.MuzzleFlashEffect, ef)
	end
	
end

--[[ 
Function Name:  ImpactEffect
Syntax: self:ImpactEffect( position, normal (ang:Up()), materialt ype). 
Returns:  Nothing.
Notes:    Used to make the impact effect.  See utilities code for CanDustEffect.
Purpose:  FX
]]--

function SWEP:ImpactEffect(pos, normal, mattype)
	local fx = EffectData()
	fx:SetOrigin(pos)
	fx:SetNormal(normal)
	if self:CanDustEffect(mattype) then
		if GetConVarNumber("cl_tfa_fx_impact_enabled",1)==1 then
			util.Effect("tfa_bullet_impact",fx)
		end
	end
	if self:CanSparkEffect(mattype) then
		if GetConVarNumber("cl_tfa_fx_impact_enabled",1)==1 then
			util.Effect("tfa_metal_impact",fx)
		end
	end
end