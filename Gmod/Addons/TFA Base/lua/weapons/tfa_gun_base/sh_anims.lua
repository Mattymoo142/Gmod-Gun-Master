--[[ 
Function Name:  ChooseDrawAnim
Syntax: self:ChooseDrawAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.
Purpose:  Animation / Utility
]]--

function SWEP:ChooseDrawAnim()
	if !self:OwnerIsValid() then return end
	local tanim = ACT_VM_DRAW
	local success = true
	if self.SequenceEnabled[ACT_VM_DRAW_SILENCED] and self:GetSilenced() then
		self:SendWeaponAnim(ACT_VM_DRAW_SILENCED)
		tanim=ACT_VM_DRAW_SILENCED
	else
		if self.SequenceEnabled[ACT_VM_DRAW_EMPTY] then
			if (self:Clip1()==0) then
				self:SendWeaponAnim(ACT_VM_DRAW_EMPTY)
				tanim=ACT_VM_DRAW_EMPTY
			else
				if self.SequenceEnabled[ACT_VM_DRAW] then
					self:SendWeaponAnim(ACT_VM_DRAW)
				else
					local _,tanim2 = self:ChooseIdleAnim()
					tanim = tanim2
					success=false
				end
			end
		else
			if self.SequenceEnabled[ACT_VM_DRAW] then
				self:SendWeaponAnim(ACT_VM_DRAW)
			else
				local _,tanim2 = self:ChooseIdleAnim()
				tanim = tanim2
				success=false
			end
		end
	end
	self.lastact = tanim
	return success, tanim
end
--[[ 
Function Name:  ChooseInspectAnim
Syntax: self:ChooseInspectAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.
Purpose:  Animation / Utility
]]--

function SWEP:ChooseInspectAnim()
	if !self:OwnerIsValid() then return end
	local tanim = ACT_VM_FIDGET
	local success = true
	if self.SequenceEnabled[ACT_VM_FIDGET] then
		--[[
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			vm:SetSequence(vm:SelectWeightedSequence(ACT_VM_FIDGET))
			print(vm:SelectWeightedSequence(ACT_VM_FIDGET))
		end
		]]--
		self:SendWeaponAnim(ACT_VM_FIDGET)
		tanim=ACT_VM_FIDGET
	else
		local _,tanim2 = self:ChooseIdleAnim()
		tanim = tanim2
		success=false
	end
	self.lastact = tanim
	
	return success, tanim
end

--[[ 
Function Name:  ChooseHolsterAnim
Syntax: self:ChooseHolsterAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.
Purpose:  Animation / Utility
]]--

function SWEP:ChooseHolsterAnim()
	if !self:OwnerIsValid() then return end
	local tanim = ACT_VM_HOLSTER
	local success = true
	if !self:GetSilenced() then
		if self.SequenceEnabled[ACT_VM_HOLSTER_EMPTY] then
			if ( self:Clip1()==0 ) then
				self:SendWeaponAnim(ACT_VM_HOLSTER_EMPTY)
				tanim = ACT_VM_HOLSTER_EMPTY
			else
				if self.SequenceEnabled[ACT_VM_HOLSTER] then
					self:SendWeaponAnim(ACT_VM_HOLSTER)
				else
					self:SendWeaponAnim(ACT_VM_HOLSTER_EMPTY)
					tanim = ACT_VM_HOLSTER_EMPTY
				end	
			end
		else
			if self.SequenceEnabled[ACT_VM_HOLSTER] then
				self:SendWeaponAnim(ACT_VM_HOLSTER)
			else
				local _,tanim2 = self:ChooseIdleAnim()
				tanim=tanim2
				success=false
			end
		end
	else
		local _,tanim2 = self:ChooseIdleAnim()
		tanim=tanim2
		success=false
	end
	self.lastact = tanim
	
	return success, tanim
end

--[[ 
Function Name:  ChooseReloadAnim
Syntax: self:ChooseReloadAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.
Purpose:  Animation / Utility
]]--

function SWEP:ChooseReloadAnim()
	if !self:OwnerIsValid() then return end
	local tanim = ACT_VM_RELOAD
	local success = true
	if self.SequenceEnabled[ACT_VM_RELOAD_SILENCED] and self:GetSilenced() then
		self:SendWeaponAnim(ACT_VM_RELOAD_SILENCED)
		tanim=ACT_VM_RELOAD_SILENCED
	else
		if self.SequenceEnabled[ACT_VM_RELOAD_EMPTY] then
			if (self:Clip1()==0) then
				self:SendWeaponAnim(ACT_VM_RELOAD_EMPTY)
				tanim=ACT_VM_RELOAD_EMPTY
			else
				if self.SequenceEnabled[ACT_VM_RELOAD] then
					self:SendWeaponAnim(ACT_VM_RELOAD)
				else
					local _,tanim2 = self:ChooseIdleAnim()
					tanim = tanim2
					success=false
				end
			end
		else
			if self.SequenceEnabled[ACT_VM_RELOAD] then
				self:SendWeaponAnim(ACT_VM_RELOAD)
			else
				local _,tanim2 = self:ChooseIdleAnim()
				tanim = tanim2
				success=false
			end
		end
	end
	self.lastact = tanim
	return success, tanim
end

--[[ 
Function Name:  ChooseIdleAnim
Syntax: self:ChooseIdleAnim().
Returns:  True,  Which action?
Notes:  Requires autodetection for full features.
Purpose:  Animation / Utility
]]--

function SWEP:ChooseIdleAnim()
	if !self:OwnerIsValid() then return end
	local tanim=ACT_VM_IDLE
	if self.SequenceEnabled[ACT_VM_IDLE_SILENCED]  and self:GetSilenced() then
		self:SendWeaponAnim(ACT_VM_IDLE_SILENCED)
		tanim=ACT_VM_IDLE_SILENCED
	else
		if self.SequenceEnabled[ACT_VM_IDLE_EMPTY] then
			if (self:Clip1()==0) then
				self:SendWeaponAnim(ACT_VM_IDLE_EMPTY)
				tanim=ACT_VM_IDLE_EMPTY
			else
				self:SendWeaponAnim(ACT_VM_IDLE)
			end
		else
			self:SendWeaponAnim(ACT_VM_IDLE)
		end
	end
	self.lastact = tanim
	return true, tanim
end

--[[ 
Function Name:  ChooseShootAnim
Syntax: self:ChooseShootAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.
Purpose:  Animation / Utility
]]--

function SWEP:ChooseShootAnim()
	if !self:OwnerIsValid() then return end
	local tanim=ACT_VM_PRIMARYATTACK
	local success = true
	if self.SequenceEnabled[ACT_VM_PRIMARYATTACK_SILENCED]  and self:GetSilenced() then
		if self.SequenceEnabled[ACT_VM_DRYFIRE_SILENCED] and !self.ForceDryFireOff then
			if (self:Clip1()==0) then
				self:SendWeaponAnim(ACT_VM_DRYFIRE_SILENCED)
				tanim=ACT_VM_DRYFIRE_SILENCED
			else
				self:SendWeaponAnim(ACT_VM_PRIMARYATTACK_SILENCED)
				tanim=ACT_VM_PRIMARYATTACK_SILENCED
			end
		else
			if (self:Clip1()==0) then
				success=false
				local _
				_, tanim = self:ChooseIdleAnim()
			else
				self:SendWeaponAnim(ACT_VM_PRIMARYATTACK_SILENCED)
				tanim=ACT_VM_PRIMARYATTACK_SILENCED
			end
		end			
	else
		if ( self.SequenceEnabled[ACT_VM_DRYFIRE] or self.SequenceEnabled[ACT_VM_PRIMARYATTACK_EMPTY] ) then
			if (self:Clip1()==0 and  self.SequenceEnabled[ACT_VM_DRYFIRE] and !self.ForceDryFireOff ) then
				self:SendWeaponAnim(ACT_VM_DRYFIRE)
				tanim=ACT_VM_DRYFIRE
			elseif (self:Clip1()==1 and self.SequenceEnabled[ACT_VM_PRIMARYATTACK_EMPTY]  and !self.ForceEmptyFireOff ) then
				if self.SequenceEnabled[ACT_VM_PRIMARYATTACK_EMPTY] then
					self:SendWeaponAnim(ACT_VM_PRIMARYATTACK_EMPTY)
					success=true
					tanim = ACT_VM_PRIMARYATTACK_EMPTY
				else
					success=true
					tanim = ACT_VM_PRIMARYATTACK
					self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
				end			
			else
				if self.SequenceEnabled[ACT_VM_PRIMARYATTACK] then
					self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
				else
					success=false
					local _
					_, tanim = self:ChooseIdleAnim()
				end
			end
		else
			if self.SequenceEnabled[ACT_VM_PRIMARYATTACK] then
				self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
			else
				success=false
				local _
				_, tanim = self:ChooseIdleAnim()
			end
		end
	end
	
	if self.Akimbo then
		if self.SequenceEnabled[ACT_VM_SECONDARYATTACK] and self.AnimCycle==1 then
			self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
		end
		self.AnimCycle = 1 - self.AnimCycle
	end	
	
	self.lastact = tanim
	return success, tanim
end

--[[ 
Function Name:  ChooseSilenceAnim
Syntax: self:ChooseSilenceAnim( true if we're silencing, false for detaching the silencer).
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.  This is played when you silence or unsilence a gun.  
Purpose:  Animation / Utility
]]--

function SWEP:ChooseSilenceAnim( val )
	if !self:OwnerIsValid() then return end
	local tanim=ACT_VM_PRIMARYATTACK
	local success = false
	if val then
		if self.SequenceEnabled[ACT_VM_ATTACH_SILENCER] then
			self:SendWeaponAnim(ACT_VM_ATTACH_SILENCER)
			tanim=ACT_VM_ATTACH_SILENCER
			success=true
		end
	else
		if self.SequenceEnabled[ACT_VM_DETACH_SILENCER] then
			self:SendWeaponAnim(ACT_VM_DETACH_SILENCER)
			tanim=ACT_VM_DETACH_SILENCER
			success=true
		end
	end
	if !success then
		local _
		_, tanim = self:ChooseIdleAnim()
	end
	self.lastact = tanim
	return success, tanim
	
end

--[[ 
Function Name:  ChooseDryFireAnim
Syntax: self:ChooseDryFireAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.  set SWEP.ForceDryFireOff to false to properly use.
Purpose:  Animation / Utility
]]--

function SWEP:ChooseDryFireAnim()
	if !self:OwnerIsValid() then return end
	local tanim=ACT_VM_DRYFIRE
	local success = true
	if self.SequenceEnabled[ACT_VM_DRYFIRE_SILENCED] and self:GetSilenced() and !self.ForceDryFireOff then
		self:SendWeaponAnim(ACT_VM_DRYFIRE_SILENCED)
		tanim=ACT_VM_DRYFIRE_SILENCED
	else
		if self.SequenceEnabled[ACT_VM_DRYFIRE] and !self.ForceDryFireOff then
			self:SendWeaponAnim(ACT_VM_DRYFIRE)
			tanim=ACT_VM_DRYFIRE
		else
			success=false
			local _
			_, tanim = self:ChooseIdleAnim()
		end
	end
	self.lastact = tanim
	return success, tanim
end
