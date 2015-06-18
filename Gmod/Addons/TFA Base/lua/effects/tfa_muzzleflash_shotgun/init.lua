local function rvec(vec)
	vec.x=math.Round(vec.x)
	vec.y=math.Round(vec.y)
	vec.z=math.Round(vec.z)
	return vec
end

local blankvec = Vector(0,0,0)

function EFFECT:Init( data )
	local AddVel = vector_origin
	if CLIENT or game.SinglePlayer() then
		if IsValid(LocalPlayer()) then
			AddVel = LocalPlayer():GetVelocity()
		end
	end
	self.Position = data:GetOrigin()
	self.Forward = data:GetNormal()
	self.Angle = self.Forward:Angle()
	self.Right = self.Angle:Right()
	
	local ownerent = player.GetByID(math.Round(data:GetStart().x))
	local serverside = false
	if math.Round(data:GetStart().y)==1 then
		serverside = true
	end
	
	if serverside then
		if IsValid(ownerent) then
			if LocalPlayer() == ownerent then
				return
			end
			AddVel = ownerent:GetVelocity()
		end
	end
	
	if (!self.Position) or ( rvec(self.Position) == blankvec ) then
		self.WeaponEnt = data:GetEntity()
		self.Attachment = data:GetAttachment()
		if self.WeaponEnt and IsValid(self.WeaponEnt) then
			local rpos = self.WeaponEnt:GetAttachment(self.Attachment)
			if rpos and rpos.Pos then
				self.Position = rpos.Pos
				if data:GetNormal()==vector_origin then
					self.Forward = rpos.Ang:Up()
					self.Angle = self.Forward:Angle()
					self.Right = self.Angle:Right()
				end
			end
		end
	end
	
	self.vOffset = self.Position
	dir = self.Forward
	local emitter = ParticleEmitter( self.vOffset )
		for i=0, 6 do
			local particle = emitter:Add( "particles/flamelet"..math.random(1,5), self.vOffset + (dir * 1.6 * i))
			if (particle) then
				particle:SetVelocity((dir * 15 * i) + 1.05 * AddVel )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( 0.1 )
				particle:SetStartAlpha( math.Rand( 200, 255 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.max(8 - 0.65 * i,1) )
				particle:SetEndSize( 0 )
				particle:SetRoll( math.Rand(0, 360) )
				particle:SetRollDelta( math.Rand(-40, 40) )
				particle:SetColor( 255 , 218 , 97 )
				particle:SetLighting(false)
			end
		end
		
		for i=0, 7 do
		
			local particle = emitter:Add( "particles/smokey", self.vOffset + dir * math.Rand(6, 10 ))
			if (particle) then
				particle:SetVelocity(VectorRand() * 5 + dir * math.Rand(27,33) + 1.05 * AddVel )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( math.Rand( 0.5, 0.5 ) )
				particle:SetStartAlpha( math.Rand( 5, 15 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand(8,10) )
				particle:SetEndSize( math.Rand(2,5) )
				particle:SetRoll( math.Rand(0, 360) )
				particle:SetRollDelta( math.Rand(-0.8, 0.8) )
				
				particle:SetAirResistance( 10 ) 
 				 
 				particle:SetGravity( Vector( 0, 0, 60 ) ) 
				
				particle:SetColor( 255 , 255 , 255 ) 
			end
			
		end
		
		if GetConVarNumber("cl_tfa_fx_gasblur",1)==1 then
			for i=0, 3 do
				local particle = emitter:Add( "sprites/heatwave", self.vOffset + (dir * i) )
				if (particle) then
					particle:SetVelocity((dir * 25 * i) + 1.05 * AddVel )
					particle:SetLifeTime( 0 )
					particle:SetDieTime( math.Rand( 0.05, 0.15 ) )
					particle:SetStartAlpha( math.Rand( 200, 225 ) )
					particle:SetEndAlpha( 0 )
					particle:SetStartSize( math.Rand(3,5) )
					particle:SetEndSize( math.Rand(8,10) )
					particle:SetRoll( math.Rand(0, 360) )
					particle:SetRollDelta( math.Rand(-2, 2) )
					
					particle:SetAirResistance( 5 ) 
					 
					particle:SetGravity( Vector( 0, 0, 40 ) ) 
					
					particle:SetColor( 255 , 255 , 255 ) 
				end
			end
		end
	emitter:Finish() 
end 

function EFFECT:Think( )
	return false
end

function EFFECT:Render()
end

 