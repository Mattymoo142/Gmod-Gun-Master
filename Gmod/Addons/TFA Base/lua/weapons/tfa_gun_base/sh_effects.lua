--[[ 
Function Name:  CleanParticles
Syntax: self:CleanParticles(). 
Returns:  Nothing.
Notes:    Cleans up particles.
Purpose:  FX
]]--

function SWEP:CleanParticles()
	if !IsValid(self) then return end
	if self.StopParticles then
		self:StopParticles()
	end
	
	if self.StopParticleEmission then
		self:StopParticleEmission()
	end
	
	if !self:OwnerIsValid() then return end
	local vm = self.Owner:GetViewModel()
	if IsValid(vm) then
		if vm.StopParticles then
			vm:StopParticles()
		end
		if vm.StopParticleEmission then
			vm:StopParticleEmission()
		end
	end
end

--[[ 
Function Name:  ShootEffects
Syntax: self:ShootEffects(). 
Returns:  Nothing.
Notes:    Calls the proper muzzleflash, muzzle smoke, muzzle light code.
Purpose:  FX
]]--
	
local blankvec = Vector(0,0,0)



function SWEP:ShootEffects()
	
	if ( ( (CLIENT and !SERVER) and !game.SinglePlayer() ) and !IsFirstTimePredicted() and !self.AutoDetectMuzzleAttachment) then print("canceled") return end
	
	--[[
	if game.SinglePlayer() then
		if !self.Owner.ShouldDrawLocalPlayer then
			self:CallOnClient("ShootEffects","")
			return
		end
	end
	]]--
	
	if !IsValid(self) or !self:OwnerIsValid() then return end
	
	self:MuzzleLight()
	
	local fp =  self:IsFirstPerson()
	local vm = self.Owner:GetViewModel()
	
	self:CleanParticles()
	
	local ht = self.DefaultHoldType and self.DefaultHoldType or self.HoldType
	local tent = self
	local attid = 1
	
	if fp then
		tent = self.Owner:GetViewModel() 
		attid=self:GetFPMuzzleAttachment()--tent:LookupAttachment(self.MuzzleAttachment and self.MuzzleAttachment or "muzzle" )
	else
		attid = self:LookupAttachment("muzzle_flash" )
		if attid == 0 then
			attid = self:LookupAttachment(self.MuzzleAttachment )
		end
		if self.MuzzleAttachmentRaw then
			attid = self.MuzzleAttachmentRaw
		end
		if self.Akimbo then
			attid = 1+self.AnimCycle
		end
	end
	
	if attid == 0 then
		attid = 1
	end
		
	if ( CLIENT or game.SinglePlayer() ) and self.DoMuzzleFlash and self.CustomMuzzleFlash then
		if !self:IsCurrentlyScoped() then
			if fp then
				self:MakeMuzzleSmoke(tent,attid)
				if false then--self.AttachmentCache[attid] then
					local cach = self.AttachmentCache[attid]
					local tmppos2, tmpang2 = LocalToWorld(cach[1],cach[2],self.Owner:GetShootPos(),self.Owner:EyeAngles())
					self:MakeMuzzleFlash(tmppos2,self.Owner:EyeAngles():Forward(),tent,attid,true,true)
				else
					self:MakeMuzzleFlash(blankvec,blankvec,tent,attid,false,false)
				end
			else
				self:MakeMuzzleSmoke(tent,attid)
				self:MakeMuzzleFlash(blankvec,blankvec,tent,attid,false,false)
			end
		else
			if fp then
				local temppos = self.Owner:GetShootPos()
				local tempang = self.Owner:EyeAngles()
				temppos:Add(tempang:Forward()*9)
				temppos:Add(tempang:Up()*-3)
				self:MakeMuzzleFlash(temppos,tempang:Forward(),tent,attid,true,true)
			else
				self:MakeMuzzleSmoke(tent,attid)
				self:MakeMuzzleFlash(blankvec,blankvec,tent,attid,false,false)
			end
		end
	end
	
	tent = self
	attid = self:LookupAttachment("muzzle_flash" )
	if attid == 0 then
		attid = self:LookupAttachment(self.MuzzleAttachment )
	end
	
	if attid == 0 then
		attid = 1
	end
	
	if SERVER and !game.SinglePlayer() then
		self:MakeMuzzleFlashSV(vector_origin,vector_origin,attid,false,false)
		self:MakeMuzzleSmokeSV(attid)
	end
	
end

local svflashvec = Vector(1,1,1)

--[[ 
Function Name:  MakeMuzzleFlashSV
Syntax: self:MakeMuzzleFlashSV(position, normal (angle:Up()), attachment id, use the position, use the normal ). 
Returns:  Nothing.
Notes:    Used to make multiplayer muzzleflashes.
Purpose:  FX
]]--

function SWEP:MakeMuzzleFlashSV(pos,normal,attachment, usepos, usenormal)
	
	if !self:OwnerIsValid() then return end
	
	local fp = false
	
	local ef = EffectData()
	
	ef:SetOrigin(pos)
	ef:SetEntity(self)
	
	ef:SetAttachment( attachment )
	
	svflashvec.x = self.Owner:EntIndex()
	svflashvec.y = 1
	svflashvec.z = 1
	ef:SetStart( svflashvec )
	
	local rpos = self:GetAttachment(attachment)
	
	if pos == vector_origin then
		if rpos then
			if rpos.Pos then
				pos = rpos.Pos
			else
				pos = self:GetPos()
			end
		else
			pos = self:GetPos()
		end
	end
	
	
	if fp then
		ef:SetNormal(self.Owner:EyeAngles():Forward())
	else
		local ang = self.Owner:EyeAngles()
		ef:SetNormal(Angle(math.Clamp(ang.p,-55,55),ang.y,ang.r):Forward())
	end
	
	if usepos then
		ef:SetOrigin(pos)
	end

	if usenormal then
		ef:SetNormal(normal)
	end
	
	if !self.MuzzleFlashEffect then
		if (self:GetSilenced()) then
			util.Effect("tfa_muzzleflash_silenced", ef)
		else
			util.Effect("tfa_muzzleflash_rifle", ef)
		end
	else
		util.Effect(self.MuzzleFlashEffect, ef)
	end
	
end

--[[ 
Function Name:  MakeMuzzleSmokeSV
Syntax: self:MakeMuzzleSmokeSV( attachment ). 
Returns:  Nothing.
Notes:    Used to make multiplayer muzzle smoke.  Don't call this unless you verify the attachment exists.
Purpose:  FX
]]--

function SWEP:MakeMuzzleSmokeSV(attachment)
	
	self:CleanParticles()
	
	local ef = EffectData()
	ef:SetEntity(self)
	ef:SetMagnitude(1)
	ef:SetAttachment(attachment)
	util.Effect("tfa_particle_smoketrail", ef)
	
end

--[[ 
Function Name:  MuzzleLight
Syntax: self:MuzzleLight( ). 
Returns:  Nothing.
Notes:    Used to make the muzzle light.
Purpose:  FX
]]--

function SWEP:MuzzleLight()
	if !CLIENT then return end
	
	if !self:GetSilenced() then
		if self:OwnerIsValid() then
			self.Owner:MuzzleFlash()
		end
		--[[
		local att,dylight
		if self:IsFirstPerson() then
			local vm = self.Owner:GetViewModel()
			att = vm:GetAttachment(vm:LookupAttachment(self.MuzzleAttachment and self.MuzzleAttachment or "1" ) )
		else
			att = self:GetAttachment(self:LookupAttachment(self.MuzzleAttachment and self.MuzzleAttachment or "1" ) )
		end
		
		dylight = DynamicLight(self:EntIndex()..","..self:GetClass())
			
		dylight.r = 255 
		dylight.g = 215
		dylight.b = 56
		dylight.brightness = 7
		local tpos =  self.Owner:GetShootPos() + self.Owner:EyeAngles():Forward() * self.WeaponLength
		dylight.Pos = self.Owner:GetShootPos() + self.Owner:EyeAngles():Forward() * self.WeaponLength
		if att and att.Pos then
			tpos=(att.Pos) + self.Owner:GetAimVector() * 1.5
			dylight.pos = tpos
		else
			tpos=self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.WeaponLength
			dylight.pos = tpos
		end
		debugoverlay.Cross(tpos,5,5,Color(255,255,255,255), true)
		dylight.size = 64
		local lifetime = 10/60
		dylight.decay = 1000/(lifetime*3)
		dylight.dieTime = CurTime() + lifetime
		dylight.style = 3
		dylight.key = true
		]]--
	end
	
end
