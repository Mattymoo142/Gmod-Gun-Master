local stepinterval = 4
local stepintervaloffset = 0

SWEP.customboboffset = Vector(0,0,0)


function SWEP:DoBobFrame()
	local tsv = GetConVarNumber("host_timescale", 1)
	local ftv = FrameTime()
	local ftvc = tsv*ftv
	
	local owvel, meetswalkgate, meetssprintgate, walkfactorv, runfactorv, sprintfactorv
	
	if !self.bobtimevar then
		self.bobtimevar = 0
	end
	
	owvel = self.Owner:GetVelocity():Length()
	
	meetssprintgate = false
	meetswalkgate = false
	
	if owvel <= self.Owner:GetWalkSpeed() * 0.55 then
		meetswalkgate = true
	end
	
	if owvel > self.Owner:GetWalkSpeed() * 1.2 then
		meetssprintgate = true
	end
	
	walkfactorv = 10.25
	runfactorv = 18
	sprintfactorv = 24
	if !self.bobtimehasbeensprinting then
		self.bobtimehasbeensprinting = 0
	end
	if !self.tprevvel then
		self.tprevvel = owvel
	end
	if !meetssprintgate then
		self.bobtimehasbeensprinting = math.Approach( self.bobtimehasbeensprinting, 0, ftv/(self.IronSightTime/2))
	else
		self.bobtimehasbeensprinting = math.Approach( self.bobtimehasbeensprinting, 3, ftv)
	end
	
	if !self.Owner:IsOnGround() then
		self.bobtimehasbeensprinting = math.Approach( self.bobtimehasbeensprinting, 0, ftv/(5/60))
	end
	
	if owvel>1 and owvel<=self.Owner:GetWalkSpeed()*0.1 and owvel>self.tprevvel then
		if self.Owner:IsOnGround() then
			local val1=math.Round(self.bobtimevar/stepinterval)*stepinterval+stepintervaloffset
			local val2=math.Round(self.bobtimevar/stepinterval)*stepinterval-stepintervaloffset
			if math.abs(self.bobtimevar-val1)<math.abs(self.bobtimevar-val2) then
				self.bobtimevar = math.Approach( self.bobtimevar,val1, ftv/(5/60))
			else
				self.bobtimevar = math.Approach( self.bobtimevar,val2, ftv/(5/60))
			end
		end
	else
		if self.Owner:IsOnGround() then
			self.bobtimevar = self.bobtimevar + ftv * math.max(1, owvel / (runfactorv + (sprintfactorv-runfactorv)*(meetssprintgate and 1 or 0)  - (runfactorv-walkfactorv)*(meetswalkgate and 1 or 0) ) )
		else
			self.bobtimevar = self.bobtimevar + ftv
		end
	end
	
	self.tprevvel = owvel
end
--[[ 
Function Name:  CalculateBob
Syntax: self:CalculateBob(position, angle, scale).
Returns:  Position and Angle, corrected for viewbob.  Scale controls how much they're affected.
Notes:  This is really important and slightly messy.
Purpose:  Feature
]]--

function SWEP:CalculateBob(pos, ang, ci)

	if !self:OwnerIsValid() then return end

	local customboboffsetx,customboboffsety,customboboffsetz,mypi,curtimecompensated, owvel, runspeed, sprintspeed, timehasbeensprinting, tironsightscale
	
	if !ci then
		ci = 1
	end
	
	ci = ci *0.66
	
	tironsightscale = 1 - 0.6 * self:GetIronSightsRatio()
	owvel = self.Owner:GetVelocity():Length()
	runspeed = self.Owner:GetWalkSpeed()
	curtimecompensated = self.bobtimevar or 0
	timehasbeensprinting = self.bobtimehasbeensprinting or 0
	if !self.BobScaleCustom then
		self.BobScaleCustom = 1
	end
	mypi=0.5*3.14159
	customboboffsetx=math.cos(mypi*(curtimecompensated-0.5)*0.5)
	customboboffsetz=math.sin(mypi*(curtimecompensated-0.5))
	customboboffsety=math.sin(mypi*(curtimecompensated-0.5)*3/8)*0.5
	
	customboboffsetx = customboboffsetx - ( math.sin(mypi*(timehasbeensprinting/2))*0.5 + math.sin(mypi*(timehasbeensprinting/6))*2 )*math.max(0, (owvel-runspeed*0.8)/(runspeed))
	
	--[[
	if CLIENT then
		ci = customboboffsetx * (1+ci*self.CLRunSightsProgress)
	else
		ci = customboboffsetx * (1+ci*self:RunSightsRatio())
	end
	]]--
	
	self.customboboffset.x = customboboffsetx*1.3
	self.customboboffset.y = customboboffsety
	self.customboboffset.z = customboboffsetz
	self.customboboffset = self.customboboffset*self.BobScaleCustom*0.45
	
	local sprintbobfac =math.sqrt(math.Clamp(self.BobScaleCustom-1,0,1))
	
	local cboboff2 = customboboffsetx * sprintbobfac * 1.5
	
	self.customboboffset = self.customboboffset*(1+sprintbobfac/3)
	
	pos:Add( self.Owner:EyeAngles():Right() * (cboboff2) )
	
	self.customboboffset = self.customboboffset * ci
	
	ang:RotateAroundAxis(ang:Right(), 		(self.customboboffset.x))
	ang:Normalize()
	ang:RotateAroundAxis(ang:Up(), 		(self.customboboffset.y))
	ang:Normalize()
	ang:RotateAroundAxis(ang:Forward(), 	(self.customboboffset.z))
	ang:Normalize()
	
	local localisedmove,localisedangle = WorldToLocal(self.Owner:GetVelocity(),self.Owner:GetVelocity():Angle(),vector_origin,self.Owner:EyeAngles()) 
	
	ang:RotateAroundAxis(ang:Forward(), 		(math.Approach(localisedmove.y,0,1)/(runspeed/8)*tironsightscale ) * (ci or 1) * (-1 + 2 *(self.ViewModelFlip and 1 or 0) ))	
	ang:Normalize()
	ang:RotateAroundAxis(ang:Right(), 		(math.Approach(localisedmove.x,0,1)/(runspeed) )*tironsightscale * (ci or 1) * (-1 + 2 *(self.ViewModelFlip and 1 or 0) ) )
	ang:Normalize()
	
	pos:Add( ang:Right() * (self.customboboffset.x) )
	pos:Add( ang:Forward() * (self.customboboffset.y) )
	pos:Add( ang:Up() * (self.customboboffset.z) )
	
	return pos, ang 
end

--[[ 
Function Name:  Footstep
Syntax: self:Footstep().  Called for each footstep.
Returns:  Nothing.
Notes:  Corrects the bob time by making it move closer to the downwards position with each footstep.
Purpose:  Feature
]]--

function SWEP:Footstep()
	local ftv = FrameTime()
	if !self.bobtimevar then
		self.bobtimevar = 0 
	end
	local val1=math.Round(self.bobtimevar/stepinterval)*stepinterval+stepintervaloffset
	local val2=math.Round(self.bobtimevar/stepinterval)*stepinterval-stepintervaloffset
	local owvel = self.Owner:GetVelocity():Length()
	if owvel > self.Owner:GetWalkSpeed() * 0.2 then
		if math.abs(self.bobtimevar-val1)<math.abs(self.bobtimevar-val2) then
			self.bobtimevar = math.Approach( self.bobtimevar,val1, 0.15)
		else
			self.bobtimevar = math.Approach( self.bobtimevar,val2, 0.15)
		end
	end
end