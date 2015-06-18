--[[Thanks to Clavus.  I'm proud to have your code in my base, and even though you didn't include a liscense anywhere I could find, it's only fit to credit you.]]--

SWEP.vRenderOrder = nil

--[[ 
Function Name:  InitMods
Syntax: self:InitMods().  Should be called only once for best performance.
Returns:  Nothing.
Notes:  Creates the VElements and WElements table, and sets up mods.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]--

function SWEP:InitMods()
	--Create a new table for every weapon instance.
	self.VElements = self:CPTbl( self.VElements )
	self.WElements = self:CPTbl( self.WElements )
	self.ViewModelBoneMods = self:CPTbl( self.ViewModelBoneMods )
	self:CreateModels(self.VElements) -- create viewmodels
	self:CreateModels(self.WElements) -- create worldmodels
	
	--Build the bones and such.
	if IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
			if (self.ShowViewModel == nil or self.ShowViewModel) then
				vm:SetColor(Color(255,255,255,255))
			else
				vm:SetMaterial("Debug/hsv")--This hides the viewmodel, FYI, lol.
			end
		end
	end
end

--[[ 
Function Name:  ViewModelDrawn
Syntax: self:ViewModelDrawn().  Automatically called already.
Returns:  Nothing.
Notes:  This draws the mods.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]--

function SWEP:ViewModelDrawn()
	local vm = self.Owner:GetViewModel()
	if !IsValid(vm) then return end
	if (!self.VElements) then return end
	self:UpdateBonePositions(vm)
	if (!self.vRenderOrder) then
		-- // we build a render order because sprites need to be drawn after models
		self.vRenderOrder = {}
		for k, v in pairs( self.VElements ) do
			if (v.type == "Model") then
				table.insert(self.vRenderOrder, 1, k)
			elseif (v.type == "Sprite" or v.type == "Quad") then
				table.insert(self.vRenderOrder, k)
			end
		end
	end
	for k, name in ipairs( self.vRenderOrder ) do
		local v = self.VElements[name]
		if (!v) then self.vRenderOrder = nil break end
		if (v.hide) then continue end
		
		local model = v.curmodel
		local sprite = v.spritemat
		
		if (!v.bone) then continue end
		
		local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
		
		if (!pos) then continue end
		
		if (v.type == "Model" and IsValid(model)) then
			model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
			model:SetAngles(ang)
			local matrix = Matrix()
			matrix:Scale(v.size)
			model:EnableMatrix( "RenderMultiply", matrix )
			
			if (!v.material) or (v.material == "") then
				model:SetMaterial("")
			elseif (model:GetMaterial() != v.material) then
				model:SetMaterial( v.material )
			end
			
			if (v.skin and v.skin != model:GetSkin()) then
				model:SetSkin(v.skin)
			end
			
			if (v.bodygroup) then
				for k, v in pairs( v.bodygroup ) do
					if (model:GetBodygroup(k) != v) then
						model:SetBodygroup(k, v)
					end
				end
			end
			
			if (v.surpresslightning) then
				render.SuppressEngineLighting(true)
			end
			
			render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
			render.SetBlend(v.color.a/255)
			model:DrawModel()
			render.SetBlend(1)
			render.SetColorModulation(1, 1, 1)
			
			render.SuppressEngineLighting(false)
			
		elseif (v.type == "Sprite" and sprite) then
			
			local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			render.SetMaterial(sprite)
			render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
			
		elseif (v.type == "Quad" and v.draw_func) then
			
			local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
			
			cam.Start3D2D(drawpos, ang, v.size)
				v.draw_func( self )
			cam.End3D2D()
			end
		
	end
	
end

SWEP.wRenderOrder = nil

--[[ 
Function Name:  DrawWorldModel
Syntax: self:DrawWorldModel().  Automatically called already.
Returns:  Nothing.
Notes:  This draws the world model, plus its attachments.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]--

function SWEP:DrawWorldModel()
	if (self.ShowWorldModel == nil or self.ShowWorldModel) then
		local hand, offset, rotate

		local ply = self:GetOwner()

		if IsValid( ply ) and self.Offset and self.Offset.Pos and self.Offset.Ang then
			local handBone = ply:LookupBone( "ValveBiped.Bip01_R_Hand" )
			if handBone then
				local pos, ang = ply:GetBonePosition( handBone )
				pos = pos + ang:Forward() * self.Offset.Pos.Forward + ang:Right() * self.Offset.Pos.Right + ang:Up() * self.Offset.Pos.Up
				ang:RotateAroundAxis( ang:Up(), self.Offset.Ang.Up)
				ang:RotateAroundAxis( ang:Right(), self.Offset.Ang.Right )
				ang:RotateAroundAxis( ang:Forward(),  self.Offset.Ang.Forward )
				self:SetRenderOrigin( pos )
				self:SetRenderAngles( ang )
				self:SetModelScale( self.Offset.Scale or 0, 0 )
				self:DrawModel()
			end
		else
			self:SetRenderOrigin( nil )
			self:SetRenderAngles( nil )
				self:SetModelScale( 1, 0 )
			self:DrawModel()
		end
	end
	
	if (!self.WElements) then return end
	
	if (!self.wRenderOrder) then
		self.wRenderOrder = {}
		for k, v in pairs( self.WElements ) do
			if (v.type == "Model") then
				table.insert(self.wRenderOrder, 1, k)
			elseif (v.type == "Sprite" or v.type == "Quad") then
				table.insert(self.wRenderOrder, k)
			end
		end
	end
	
	bone_ent = self.Owner and self.Owner or self
	
	for k, name in pairs( self.wRenderOrder ) do
		local v = self.WElements[name]
		if (!v) then self.wRenderOrder = nil break end
		if (v.hide) then continue end
		
		local pos, ang
		
		if (v.bone) then
			pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
		else
			pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
		end
		
		if (!pos) then continue end
		
		local model = v.curmodel
		local sprite = v.spritemat
		
		if (v.type == "Model" and IsValid(model)) then
				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				model:SetAngles(ang)
			-- //model:SetModelScale(v.size)
			local matrix = Matrix()
			matrix:Scale(v.size)
			model:EnableMatrix( "RenderMultiply", matrix )
			
			if (v.material == "") then
				model:SetMaterial("")
			elseif (model:GetMaterial() != v.material) then
				model:SetMaterial( v.material )
			end
			
			if (v.skin and v.skin != model:GetSkin()) then
				model:SetSkin(v.skin)
			end
			
			if (v.bodygroup) then
				for k, v in pairs( v.bodygroup ) do
					if (model:GetBodygroup(k) != v) then
						model:SetBodygroup(k, v)
					end
				end
			end
			
			if (v.surpresslightning) then
				render.SuppressEngineLighting(true)
			end
			
			render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
			render.SetBlend(v.color.a/255)
			model:DrawModel()
			render.SetBlend(1)
			render.SetColorModulation(1, 1, 1)
			
			if (v.surpresslightning) then
				render.SuppressEngineLighting(false)
			end
			
		elseif (v.type == "Sprite" and sprite) then
			
			local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			render.SetMaterial(sprite)
			render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
			
		elseif (v.type == "Quad" and v.draw_func) then
			
			local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
			
			cam.Start3D2D(drawpos, ang, v.size)
				v.draw_func( self )
			cam.End3D2D()
		end
	end
end

--[[ 
Function Name:  GetBoneOrientation
Syntax: self:GetBoneOrientation( base bone mod table, bone mod table, entity, bone override ). 
Returns:  Position, Angle.
Notes:  This is a very specific function for a specific purpose, and shouldn't be used generally to get a bone's orientation.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]--

function SWEP:GetBoneOrientation( basetabl, tabl, ent, bone_override )
	
	local bone, pos, ang
	
	if !IsValid(ent) then
		return Vector(0,0,0), Angle(0,0,0)
	end
	
	if (tabl.rel and tabl.rel != "") then
		
		local v = basetabl[tabl.rel]
		
		if (!v) then return end
		
		--As clavus states in his original code, don't make your elements named the same as a bone, because recursion.
		pos, ang = self:GetBoneOrientation( basetabl, v, ent )
		
		if (!pos) then return end
		
		pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
		ang:RotateAroundAxis(ang:Up(), v.angle.y)
		ang:RotateAroundAxis(ang:Right(), v.angle.p)
		ang:RotateAroundAxis(ang:Forward(), v.angle.r)
			
	else
		bone = ent:LookupBone(bone_override or tabl.bone)
		if (!bone) or (bone==-1) then return end
		
		pos, ang = Vector(0,0,0), Angle(0,0,0)
		local m = ent:GetBoneMatrix(bone)
		if (m) then
			pos, ang = m:GetTranslation(), m:GetAngles()
		end
		
		if (IsValid(self.Owner) and self.Owner:IsPlayer() and ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
			ang.r = -ang.r -- For mirrored viewmodels.  You might think to scale negatively on X, but this isn't the case.
		end
	
	end
	
	return pos, ang
end

--[[ 
Function Name:  CreateModels
Syntax: self:CreateModels( elements table ). 
Returns:   Nothing.
Notes:  Creates the elements for whatever you give it.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]--

function SWEP:CreateModels( tabl )
	if (!tabl) then return end
		-- // Create the clientside models here because Garry says we can't do it in the render hook
	for k, v in pairs( tabl ) do
		if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.curmodel) or v.curmodelname != v.model) and 
				string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
			
			v.curmodel = ClientsideModel(v.model, RENDERGROUP_VIEWMODEL)
			if (IsValid(v.curmodel)) then
				v.curmodel:SetPos(self:GetPos())
				v.curmodel:SetAngles(self:GetAngles())
				v.curmodel:SetParent(self)
				v.curmodel:SetNoDraw(true)
				v.curmodelname = v.model
			else
				v.curmodel = nil
			end
			
		elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spritemat or v.cursprite != v.sprite) and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
			
			local name = v.sprite.."-"
			local params = { ["$basetexture"] = v.sprite }
			-- // make sure we create a unique name based on the selected options
			local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
			for i, j in pairs( tocheck ) do
				if (v[j]) then
					params["$"..j] = 1
					name = name.."1"
				else
					name = name.."0"
				end
			end
			v.cursprite = v.sprite
			v.spritemat = CreateMaterial(name,"UnlitGeneric",params)
			
		end
	end
	
end
	
--[[ 
Function Name:  UpdateBonePositions
Syntax: self:UpdateBonePositions( viewmodel ). 
Returns:   Nothing.
Notes:   Updates the bones for a viewmodel.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]--

function SWEP:UpdateBonePositions(vm)
	
	if self.ViewModelBoneMods then
		
		if (!vm:GetBoneCount()) then return end
		
		local loopthrough = self.ViewModelBoneMods
		local vbones = {}
		for i=0, vm:GetBoneCount() do
			local bonename = vm:GetBoneName(i)
			if (self.ViewModelBoneMods[bonename]) then 
				vbones[bonename] = self.ViewModelBoneMods[bonename]
			else
				vbones[bonename] = { 
					scale = Vector(1,1,1),
					pos = Vector(0,0,0),
					angle = Angle(0,0,0)
				}
			end
		end
		
		loopthrough = vbones
		
		for k, v in pairs( loopthrough ) do
		
			local bone = vm:LookupBone(k)
			if (!bone) or (bone==-1) then continue end
			
			local s = Vector(v.scale.x,v.scale.y,v.scale.z)
			local p = Vector(v.pos.x,v.pos.y,v.pos.z)
			local childscale = Vector(1,1,1)
			local cur = vm:GetBoneParent(bone)
			while( cur != -1) do
				local pscale = loopthrough[vm:GetBoneName(cur)].scale
				childscale = childscale * pscale
				cur = vm:GetBoneParent(cur)
			end
			
			s = s * childscale
			
			if vm:GetManipulateBoneScale(bone) != s then
				vm:ManipulateBoneScale( bone, s )
			end
			
			if vm:GetManipulateBoneAngles(bone) != v.angle then
				vm:ManipulateBoneAngles( bone, v.angle )
			end
			
			if vm:GetManipulateBonePosition(bone) != p then
				vm:ManipulateBonePosition( bone, p )
			end
			
		end
	else
		self:ResetBonePositions(vm)
	end
end
	
--[[ 
Function Name:  ResetBonePositions
Syntax: self:ResetBonePositions( viewmodel ). 
Returns:   Nothing.
Notes:   Resets the bones for a viewmodel.
Purpose:  SWEP Construction Kit Compatibility / Basic Attachments.
]]--
 
function SWEP:ResetBonePositions(vm)
	if (!vm:GetBoneCount()) then return end
	for i=0, vm:GetBoneCount() do
		vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
		vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
		vm:ManipulateBonePosition( i, vector_origin )
	end
end