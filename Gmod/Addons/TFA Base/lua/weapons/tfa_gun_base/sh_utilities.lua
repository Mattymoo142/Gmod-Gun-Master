
--[[ 
Function Name:  ResetSightsProgress
Syntax: self:ResetSightsProgress( ). 
Returns:   Nothing.
Notes:    Used to reset the progress of some stuff , idk, can you read?
Purpose:  Utility
]]--

function SWEP:ResetSightsProgress()
	self.RunSightsProgress=0
	if CLIENT then
		self.CLNearWallProgress=0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
		self.CLRunSightsProgress=0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
		self.CLIronSightsProgress=0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
		self.CLCrouchProgress=0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
		self.CLJumpProgress=0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
		self.CLSpreadRatio=0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
		self.CLAmmoHUDProgress=0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
		self.ShouldDrawAmmoHUD=false
	end
	
	self:SetIronSightsRatio(0)	
	self:SetRunSightsRatio(0)
end

--[[ 
Function Name:  DoAmmoCheck
Syntax: self:DoAmmoCheck( ). 
Returns:   Nothing.
Notes:    Used to strip the weapon depending on convars set.
Purpose:  Utility
]]--

function SWEP:DoAmmoCheck()
	if IsValid(self) then
		if SERVER and (GetConVar("sv_tfa_weapon_strip"):GetBool()) then 
			if self:Clip1() == 0 && self.Owner:GetAmmoCount( self:GetPrimaryAmmoType() ) == 0 then
				timer.Simple(.1, function()
					if SERVER then
						if IsValid(self) then
							if IsValid(self.Owner) then
								self.Owner:StripWeapon(self.Gun)
							end
						end
					end
				end)
			end
		end
	end
end

--[[ 
Function Name:  GetFireModeName
Syntax: self:GetFireModeName( ). 
Returns:   Firemode name.
Notes:    Returns either the custom name you force or the autodetected one.
Purpose:  Utility
]]--

function SWEP:GetFireModeName()
	
	local fm = self:GetFireMode()
	local fmn = string.lower(self.FireModes[fm])
	
	if string.find(fmn,"safe") or string.find(fmn,"holster") then
		return "Safety"
	end
	
	if self.FireModeName then
		return self.FireModeName
	end
	
	if string.find(fmn,"auto") then
		return "Full-Auto"
	end
	if string.find(fmn,"single") then
		if (self.Revolver or ( (self.DefaultHoldType and self.DefaultHoldType or self.HoldType) == "revolver" ) ) then
			if (self.BoltAction) then
				return "Single-Action"
			else
				return "Double-Action"
			end
		else
			if (self.BoltAction) then
				return "Bolt-Action"
			else
				if (self.Shotgun and self.Primary.RPM<250) then
					return "Pump-Action"
				else
					return "Semi-Auto"
				end
			end
		end
	end
	local bpos = string.find(fmn,"burst")
	if bpos then
		return string.sub(fmn,1,bpos-1) .. " Round Burst"
	end
end

--[[ 
Function Name:  IsSafety
Syntax: self:IsSafety( ). 
Returns:   Are we in safety firemode.
Notes:    Non.
Purpose:  Utility
]]--

function SWEP:IsSafety()
	local fm = self.FireModes[self:GetFireMode()]
	local fmn = string.lower(fm and fm or self.FireModes[1] )
	
	if ( string.find(fmn,"safe") or string.find(fmn,"holster") ) then
		return true
	else
		return false
	end
end

--[[ 
Function Name:  FindEvenBurstNumber
Syntax: self:FindEvenBurstNumber( ). 
Returns:   The ideal burst count.
Notes:    This will result in a two round burst on guns like the glock.  Please check out the autodetect code for how to do things like three round burst in a 20 round clip.
Purpose:  Utility
]]--

function SWEP:FindEvenBurstNumber()
	if (self.Primary.ClipSize % 3 ==0 ) then
		return 3
	elseif (self.Primary.ClipSize % 2 == 0 ) then
		return 2
	else
		local i=4
		while i<=7 do
			if self.Primary.ClipSize % i == 0 then
				return i
			end
			i=i+1
		end
	end
	return nil
end

--[[ 
Function Name:  GetAmmoReserve
Syntax: self:GetAmmoReserve( ). 
Returns:   How much ammo the owner has in reserve.
Notes:    Returns -1 if the owner isn't valid.
Purpose:  Utility
]]--

function SWEP:GetAmmoReserve()

	local wep = self
	if ( !IsValid( wep ) ) then return -1 end
	
	local ply = self.Owner
	if ( !IsValid( ply ) ) then return -1 end
 
	return ply:GetAmmoCount( wep:GetPrimaryAmmoType() )
end

--[[ 
Function Name:  GetRPM
Syntax: self:GetRPM( ). 
Returns:   How many RPM.
Notes:    Returns 600 as default.
Purpose:  Utility
]]--

function SWEP:GetRPM()
	
	if !self.Primary.Automatic then
		if self.Primary.RPM_Semi then
			return self.Primary.RPM_Semi 
		end
	end
	
	if self.Primary.RPM then
		return self.Primary.RPM
	end
	
	return 600
end

--[[ 
Function Name:  IsCurrentlyScoped
Syntax: self:IsCurrentlyScoped( ). 
Returns:   Is the player scoped in enough to display the overlay?  true/false, returns a boolean.
Notes:    Change SWEP.ScopeOverlayThreshold to change when the overlay is displayed.
Purpose:  Utility
]]--

function SWEP:IsCurrentlyScoped()
	if CLIENT then
		return ( (self.CLIronSightsProgress > self.ScopeOverlayThreshold)  and self.Scoped)
	else
		return ( (self:GetIronSightsRatio() > self.ScopeOverlayThreshold)  and self.Scoped)
	end
end

--[[ 
Function Name:  IsFirstPerson
Syntax: self:IsFirstPerson( ). 
Returns:   Is the owner in first person.
Notes:    Broken in singplayer because gary.
Purpose:  Utility
]]--

function SWEP:IsFirstPerson()
	
	if !IsValid(self) or !self:OwnerIsValid() then return false end
	
	local gmsdlp
	
	if LocalPlayer then
		gmsldp = hook.Call("ShouldDrawLocalPlayer", GAMEMODE, self.Owner) 
	else
		gmsldp = false
	end
	
	if gmsdlp then return false end
	
	local vm = self.Owner:GetViewModel()
	
	if IsValid(vm) then
		if vm:GetNoDraw() or vm:IsEffectActive(EF_NODRAW) then
			return false
		end
	end
	
	if !self:IsWeaponVisible() then
		return false
	end
	
	if self.Owner.ShouldDrawLocalPlayer and self.Owner:ShouldDrawLocalPlayer() then
		return false
	end
	
	if !IsValid(self.Owner:GetViewModel()) then return false end
	
	return true
end

--[[ 
Function Name:  GetFPMuzzleAttachment
Syntax: self:GetFPMuzzleAttachment( ). 
Returns:   The firstperson/viewmodel muzzle attachment id.
Notes:    Defaults to the first attachment.
Purpose:  Utility
]]--

function SWEP:GetFPMuzzleAttachment( )
	if !IsValid(self) then return nil end
	if !IsValid(self.Owner) then return nil end
	local ply=self.Owner
	local vm = ply:GetViewModel()
	local obj = vm:LookupAttachment( self.MuzzleAttachment and self.MuzzleAttachment or "1")
	
	if self:GetSilenced() then
		if self.MuzzleAttachmentSilenced then
			obj = vm:LookupAttachment( self.MuzzleAttachmentSilenced and self.MuzzleAttachmentSilenced or "1")
		else
			obj = vm:LookupAttachment( "muzzle_silenced")
		end
		if obj==0 then
			obj = 1
		end
	end
	
	if self.MuzzleAttachmentRaw then
		obj=self.MuzzleAttachmentRaw
	end
	
	return obj 
end

--[[ 
Function Name:  GetMuzzlePos
Syntax: self:GetMuzzlePos( hacky workaround that doesn't work anyways ). 
Returns:   The AngPos for the muzzle attachment.
Notes:    Defaults to the first attachment, and uses GetFPMuzzleAttachment
Purpose:  Utility
]]--

function SWEP:GetMuzzlePos( ignorepos )
	if !IsValid(self.Owner) then return nil end
	local ply=self.Owner
	local fp = self:IsFirstPerson()
	local vm = ply:GetViewModel()
	local obj = 0--vm:LookupAttachment( self.MuzzleAttachment and self.MuzzleAttachment or "1")
	
	if fp then
		obj=self:GetFPMuzzleAttachment()
	else
		obj = self:LookupAttachment( self.MuzzleAttachment and self.MuzzleAttachment or "1")
		if !obj or obj==0 then
			obj = 1
		end
	end
	
	local muzzlepos
	
	if fp then
		local pos = vm:GetPos()
		local ang = vm:GetAngles()
		local rpos = vm:GetRenderOrigin()
		local rang = vm:GetRenderAngles()
		if ignorepos then
			vm:SetPos(ply:GetShootPos())
			vm:SetAngles(ply:EyeAngles())
			vm:SetRenderOrigin(ply:GetShootPos())
			vm:SetRenderAngles(ply:EyeAngles())
		end
		muzzlepos = vm:GetAttachment( obj )
		vm:SetPos(pos)
		vm:SetAngles(ang)
		vm:SetRenderOrigin(rpos)
		vm:SetRenderAngles(rang)
	else
		muzzlepos = self:GetAttachment(obj)
	end
	
	return muzzlepos 
end

--[[ 
Function Name:  GetAmmoForceMultiplier
Syntax: self:GetAmmoForceMultiplier( ). 
Returns:  The force multiplier for given ammo type.
Notes:    Only compatible with default ammo types, unless you/I mod that.  BMG ammotype is detected based on name and category.
Purpose:  Utility
]]--

function SWEP:GetAmmoForceMultiplier()
	
	if !self.PrintName then
		self.PrintName = ""
	end
	
	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
	--AR2=Rifle ~= Caliber>.308
	--SMG1=SMG ~= Small/Medium Calber ~= 5.56 or 9mm
	--357=Revolver ~= .357 through .50 magnum
	--Pistol = Small or Pistol Bullets ~= 9mm, sometimes .45ACP but rarely.  Generally light.
	--Buckshot = Buckshot = Light, barely-penetrating sniper bullets.
	--Slam = Medium Shotgun Round
	--AirboatGun = Heavy, Penetrating Shotgun Round
	--SniperPenetratedRound = Heavy Large Rifle Caliber ~= .50 Cal blow-yer-head-off
	local am = string.lower(self.Primary.Ammo)
	if ( am=="pistol" ) then
		return 0.4 --M1911 .45 ACP penetrates 2 inches of concrete or so max
	elseif ( am=="357" ) then
		return 0.6--To compensate for the detection algorithm giving revolvers super penetration power because of recoil
	elseif ( am=="smg1" ) then
		return 0.475 --P90 penetrates 3 inches of the ol' crete, and is very capable at penetrating wood or sheet metal.  It can go through about 6 inches of wood or about 2.28 inches of light metal (most in-game is aluminum or light steel.)
	elseif (am=="ar2") then
		if (string.find(string.lower(self.PrintName),"machine") or string.find(string.lower(self.Category),"machine")) then
			return 1.1--50 BMG
		else
			return 0.6--.308
		end
	elseif (am=="buckshot") then
		return 0.2
	elseif (am=="slam") then
		return 0.25
	elseif (am=="airboatgun") then 
		return 0.3
	elseif (am=="sniperpenetratedround") then
		return 0.375--Wow you can shoot through 1.5 feet of concrete with AP M82 nice.
	else
		return 1
	end
	
end

--[[ 
Function Name:  OwnerIsValid
Syntax: self:OwnerIsValid( ). 
Returns:  Is our owner valid and alive?
Notes:    Use this when possible.  Seems to work better than just IsValid(self.Owner).
Purpose:  Utility
]]--

function SWEP:OwnerIsValid()
	if !IsValid(self.Owner) then return false end
	if !self.Owner:IsPlayer() then return false end
	if !self.Owner:Alive() then return false end
	if ! (self.Owner:GetActiveWeapon() == self) then return end
	return true
end

--[[ 
Function Name:  GetAmmoRicochetMultiplier
Syntax: self:GetAmmoRicochetMultiplier( ). 
Returns:  The ricochet multiplier for our ammotype.  More is more chance to ricochet.
Notes:    Only compatible with default ammo types, unless you/I mod that.  BMG ammotype is detected based on name and category.
Purpose:  Utility
]]--

function SWEP:GetAmmoRicochetMultiplier()
	local am = string.lower(self.Primary.Ammo)
	if ( am=="pistol" ) then
		return 1.25
	elseif ( am=="357" ) then
		return 0.75
	elseif ( am=="smg1" ) then
		return 1.1
	elseif (am=="ar2") then
		return 0.9
	elseif (am=="buckshot") then
		return 2
	elseif (am=="slam") then
		return 1.5
	elseif (am=="airboatgun") then 
		return 0.8
	elseif (am=="sniperpenetratedround") then
		return 0.5
	else
		return 1
	end
end

--[[ 
Function Name:  GetMaterialConcise
Syntax: self:GetMaterialConcise( ). 
Returns:  The string material name.
Notes:    Always lowercase.
Purpose:  Utility
]]--

function SWEP:GetMaterialConcise( mat ) 
	local matname
	if (mat==MAT_GLASS) then
		matname = "glass"
	elseif mat==MAT_GRATE or mat==MAT_METAL or mat==MAT_VENT or mat==MAT_COMPUTER or mat==MAT_CLIP then
		matname = "metal"
	elseif mat==MAT_FLESH or mat==MAT_ALIENFLESH or mat==MAT_ANTLION then
		matname = "flesh"
	elseif mat==MAT_FOLIAGE then
		matname = "foliage"
	elseif mat==MAT_DIRT or mat==MAT_GRASS then
		matname = "dirt"
	elseif mat==MAT_EGGSHELL or mat==MAT_PLASTIC then
		matname = "plastic"
	elseif mat==MAT_TILE or mat==MAT_CONCRETE then
		matname = "ceramic"
	elseif mat==MAT_WOOD then
		matname = "wood"
	elseif mat==MAT_SAND then
		matname = "sand"
	elseif mat==MAT_SNOW then
		matname = "snow"
	elseif mat==MAT_SLOSH then
		matname = "slime"
	elseif mat==MAT_WARPSHIELD then
		matname = "energy"
	elseif mat==89 then 
		matname = "glass"
	else
		matname = "default"
	end
	return matname
end

--[[ 
Function Name:  GetPenetrationMultiplier
Syntax: self:GetPenetrationMultiplier( concise material name). 
Returns:  The multilier for how much you can penetrate through a material.
Notes:    Should be used with GetMaterialConcise.
Purpose:  Utility
]]--

function SWEP:GetPenetrationMultiplier( matt )
	local mat = self:GetMaterialConcise( matt )
	local fac = 1
	if mat=="metal" then 
		fac = 1.8 --Since most is aluminum and stuff
	elseif mat=="wood" then
		fac=2.8
	elseif mat=="plastic" then
		fac=5
	elseif mat=="flesh" then
		fac=4
	elseif mat=="ceramic" then
		fac=2.25
	elseif mat=="glass" then
		fac=20
	elseif mat=="energy" then
		fac=0.05
	elseif mat=="slime" or mat=="sand" then
		fac=0.7
	elseif mat=="dirt" then
		fac=5 --This is carboard, not dirt, in most cases.
	elseif mat=="foliage" then
		fac=3
	end
	
	return fac
	
end

--[[ 
Function Name:  CanDustEffect
Syntax: self:CanDustEffect( concise material name ). 
Returns:  True/False
Notes:    Used for the impact effect.  Should be used with GetMaterialConcise.
Purpose:  Utility
]]--

function SWEP:CanDustEffect( mat )
	local n = self:GetMaterialConcise( mat )
	if n=="energy" or n=="dirt" or n=="ceramic" or n=="plastic" or n=="wood" then
		return true
	end
	return false
end


--[[ 
Function Name:  CanSparkEffect
Syntax: self:CanSparkEffect( concise material name ). 
Returns:  True/False
Notes:    Used for the impact effect.  Should be used with GetMaterialConcise.
Purpose:  Utility
]]--

function SWEP:CanSparkEffect( mat )
	local n = self:GetMaterialConcise( mat )
	if n=="default" or n=="metal" then
		return true
	end
	return false
end

--[[ 
Function Name:  CPTbl
Syntax: self:CPTbl( input table). 
Returns:  Unique output table.
Notes:    Always lowercase.
Purpose:  Utility
]]--

function SWEP:CPTbl( tabl )
	if (tabl == nil) then return end
	if (!tabl) then return end 
	
	local result = {}
	
	for k, v in pairs( tabl ) do
		if (type(v) == "table") then
			if v != tabl then
				result[k] = self:CPTbl(v) --Recursion, without the stack overflow.
			end
		elseif (type(v) == "Vector") then
			result[k] = Vector(v.x, v.y, v.z)
		elseif (type(v) == "Angle") then
			result[k] = Angle(v.p, v.y, v.r)
		else
			result[k] = v
		end
	end
	
	return result
end
