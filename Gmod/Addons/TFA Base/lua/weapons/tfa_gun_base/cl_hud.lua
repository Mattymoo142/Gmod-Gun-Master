
local function RoundDecimals(number,decimals)
	local decfactor = math.pow(10,decimals)
	return math.Round(tonumber( number )*decfactor)/decfactor
end

--[[ 
Function Name:  DrawHUD
Syntax: self:DrawHUD( ). 
Returns:  Nothing.
Notes:    Used to draw the HUD.  Can you read?
Purpose:  HUD
]]--

function SWEP:DrawHUD()
	
    cam.Start3D(); cam.End3D() --Workaround for vec:ToScreen()
	--Crosshair
	local drawcrossy
	
	drawcrossy=self.DrawCrosshairDefault
	if !drawcrossy then
		drawcrossy=self.DrawCrosshair
	end
	
	local crossa = GetConVarNumber("cl_tfa_hud_crosshair_color_a", 220) * math.min(1-self.CLIronSightsProgress, 1-self.CLRunSightsProgress, 1-self.CLNearWallProgress)
	local outa = GetConVarNumber("cl_tfa_hud_crosshair_outline_color_a", 255) * math.min(1-self.CLIronSightsProgress, 1-self.CLRunSightsProgress, 1-self.CLNearWallProgress)
	self.DrawCrosshair = false
	if drawcrossy then
		if GetConVarNumber("cl_tfa_hud_crosshair_enable_custom") == 1 then
			if IsValid(LocalPlayer()) and self.Owner == LocalPlayer() then
				local x, y -- local, always
				local s_cone,recoil
				if !game.SinglePlayer() then
					s_cone,recoil = self:ClientCalculateConeRecoil()
				else
					s_cone,recoil = self:CalculateConeRecoil()
				end
				-- If we're drawing the local player, draw the crosshair where they're aiming
				-- instead of in the center of the screen.
				if ( self.Owner:ShouldDrawLocalPlayer() ) then
					local tr = util.GetPlayerTrace( self.Owner )
					tr.mask = ( CONTENTS_SOLID+CONTENTS_MOVEABLE+CONTENTS_MONSTER+CONTENTS_WINDOW+CONTENTS_DEBRIS+CONTENTS_GRATE+CONTENTS_AUX ) -- This controls what the crosshair will be projected onto.
					local trace = util.TraceLine( tr )
					
					local coords = trace.HitPos:ToScreen()
					x, y = coords.x, coords.y

				else
					x, y = ScrW() / 2.0, ScrH() / 2.0 -- Center of screen
				end
				local crossr,crossg,crossb, crosslen, crosshairwidth, drawdot
				crossr = GetConVarNumber("cl_tfa_hud_crosshair_color_r", 225)
				crossg = GetConVarNumber("cl_tfa_hud_crosshair_color_g", 225)
				crossb = GetConVarNumber("cl_tfa_hud_crosshair_color_b", 225)
				crosslen = GetConVarNumber("cl_tfa_hud_crosshair_length", 1) * 0.01
				crosshairwidth = GetConVarNumber("cl_tfa_hud_crosshair_width", 1) 
				drawdot = GetConVarNumber("cl_tfa_hud_crosshair_dot",0)
				local scale = (s_cone *  90 ) / self.Owner:GetFOV() * 680 * GetConVarNumber("cl_tfa_hud_crosshair_gap_scale",1)
				
				local gap = scale
				local length = 1
				if GetConVarNumber("cl_tfa_hud_crosshair_length_use_pixels",1)!=1 then
					length = gap + ScrH()*1.777*crosslen
				else
					length = gap + crosslen*100
				end
				--Outline
				
				if GetConVarNumber("cl_tfa_hud_crosshair_outline_enabled",1) == 1 then
					local outr,outg,outb,outlinewidth
					outr = GetConVarNumber("cl_tfa_hud_crosshair_outline_color_r", 5)
					outg = GetConVarNumber("cl_tfa_hud_crosshair_outline_color_g", 5)
					outb = GetConVarNumber("cl_tfa_hud_crosshair_outline_color_b", 5)
					outlinewidth = GetConVarNumber("cl_tfa_hud_crosshair_outline_width", 1) 
					surface.SetDrawColor( outr, outg, outb, outa)
					surface.DrawRect( math.Round(x - length - outlinewidth ) - crosshairwidth/2 , math.Round(y - outlinewidth) - crosshairwidth/2 , math.Round(length-gap + outlinewidth*2) + crosshairwidth, math.Round(outlinewidth*2)  + crosshairwidth)	-- Left
					surface.DrawRect( math.Round(x + gap - outlinewidth) - crosshairwidth/2 , math.Round(y - outlinewidth) - crosshairwidth/2 , math.Round(length-gap + outlinewidth*2) + crosshairwidth, math.Round(outlinewidth*2)  + crosshairwidth)	-- Right
					surface.DrawRect( math.Round(x  - outlinewidth) - crosshairwidth/2  , math.Round(y - length - outlinewidth) - crosshairwidth/2 , math.Round(outlinewidth*2 ) + crosshairwidth, math.Round(length-gap + outlinewidth*2 )  + crosshairwidth)	-- Top
					surface.DrawRect( math.Round(x  - outlinewidth) - crosshairwidth/2  , math.Round(y + gap - outlinewidth) - crosshairwidth/2 , math.Round(outlinewidth*2) + crosshairwidth, math.Round(length-gap + outlinewidth*2 )  + crosshairwidth)	-- Bottom
					if drawdot==1 then
						surface.DrawRect( math.Round(x-outlinewidth)-crosshairwidth/2,math.Round(y-outlinewidth)-crosshairwidth/2,math.Round(outlinewidth*2)+crosshairwidth,math.Round(outlinewidth*2)+crosshairwidth)--Dot
					end
				end
				
				--Main Crosshair
				
				surface.SetDrawColor( crossr, crossg, crossb, crossa)
				surface.DrawRect( math.Round(x - length)  - crosshairwidth/2, math.Round(y)  - crosshairwidth/2, math.Round(length-gap) + crosshairwidth, crosshairwidth)	-- Left
				surface.DrawRect( math.Round(x + gap)  - crosshairwidth/2, math.Round(y)  - crosshairwidth/2, math.Round(length-gap ) + crosshairwidth, crosshairwidth)	-- Right
				surface.DrawRect( math.Round(x)  - crosshairwidth/2, math.Round(y - length) - crosshairwidth/2, crosshairwidth, math.Round(length-gap)+crosshairwidth)	-- Top
				surface.DrawRect( math.Round(x)  - crosshairwidth/2, math.Round(y + gap) - crosshairwidth/2, crosshairwidth, math.Round(length-gap)+crosshairwidth)	-- Bottom
				if drawdot==1 then
					surface.DrawRect( math.Round(x)-crosshairwidth/2,math.Round(y)-crosshairwidth/2,crosshairwidth,crosshairwidth)--dot
				end
			end
		else
			if math.min(1-self.CLIronSightsProgress, 1-self.CLRunSightsProgress, 1-self.CLNearWallProgress)>0.5 then
				self.DrawCrosshair = true
			end
		end
	end
	--HUD
	local angpos = self:GetMuzzlePos()
	if angpos and ( GetConVarNumber("cl_tfa_hud_enabled",1) == 1 ) then
		local pos = angpos.Pos
		local textsize = self.textsize and self.textsize or 1
		local pl = LocalPlayer() and LocalPlayer() or self.Owner
		local ang = pl:EyeAngles()--(angpos.Ang):Up():Angle()
		local myalpha = 225 * self.CLAmmoHUDProgress
		ang:RotateAroundAxis(ang:Right(), 90)
		ang:RotateAroundAxis(ang:Up(), -90)
		ang:RotateAroundAxis(ang:Forward(), 0)
		pos = pos + ang:Right()*( self.textupoffset and self.textupoffset or -2 * (textsize/1) )
		pos = pos + ang:Up()*( self.textfwdoffset and self.textfwdoffset or 0 * (textsize/1)  )
		pos = pos + ang:Forward()*( self.textrightoffset and self.textrightoffset or -1 * (textsize/1) )
		local postoscreen = pos:ToScreen()
		xx = postoscreen.x
		yy = postoscreen.y
		if self:GetInspectingRatio()<0.01 then
			local str =  string.upper( "MAG: "..self:Clip1() )
			if (self:Clip1() > self.Primary.ClipSize) then
				str =  string.upper( "MAG: "..self.Primary.ClipSize.." + "..( self:Clip1()-self.Primary.ClipSize ) )
			end
			draw.DrawText( str, "TFASleek", xx+1, yy+1, ColorAlpha(self.TextColContrast, myalpha), TEXT_ALIGN_RIGHT )
			draw.DrawText( str, "TFASleek", xx, yy, ColorAlpha(self.TextCol, myalpha), TEXT_ALIGN_RIGHT )
			str =  string.upper( "RESERVE: "..self:GetAmmoReserve() )
			yy = yy + TFASleekFontHeight
			xx = xx - TFASleekFontHeight / 3
			draw.DrawText( str, "TFASleekMedium", xx+1, yy+1, ColorAlpha(self.TextColContrast, myalpha), TEXT_ALIGN_RIGHT )
			draw.DrawText( str, "TFASleekMedium", xx, yy, ColorAlpha(self.TextCol, myalpha), TEXT_ALIGN_RIGHT )
			yy = yy + TFASleekFontHeightMedium
			xx = xx - TFASleekFontHeightMedium / 3
			str = string.upper( self:GetFireModeName() )
			draw.DrawText( str, "TFASleekSmall", xx+1, yy+1, ColorAlpha(self.TextColContrast, myalpha), TEXT_ALIGN_RIGHT )
			draw.DrawText( str, "TFASleekSmall", xx, yy, ColorAlpha(self.TextCol, myalpha), TEXT_ALIGN_RIGHT )
		else
			local str =  string.upper( "DAMAGE: "..RoundDecimals(self.Primary.Damage,1) )
			if self.Primary.NumShots and self.Primary.NumShots > 1 then
				str = str .. "x" .. math.Round(self.Primary.NumShots)
			end
			yy=yy-100
			yy=math.Clamp(yy,0,ScrH())
			xx=math.Clamp(xx,250,ScrW())
			draw.DrawText( str, "TFASleek", xx+1, yy+1, ColorAlpha(self.TextColContrast, myalpha), TEXT_ALIGN_RIGHT )
			draw.DrawText( str, "TFASleek", xx, yy, ColorAlpha(self.TextCol, myalpha), TEXT_ALIGN_RIGHT )
			yy = yy + TFASleekFontHeight
			str =  string.upper( "RPM: "..RoundDecimals(self.Primary.RPM,1) )
			draw.DrawText( str, "TFASleek", xx+1, yy+1, ColorAlpha(self.TextColContrast, myalpha), TEXT_ALIGN_RIGHT )
			draw.DrawText( str, "TFASleek", xx, yy, ColorAlpha(self.TextCol, myalpha), TEXT_ALIGN_RIGHT )
			yy = yy + TFASleekFontHeight
			str =  string.upper( "Range: " .. RoundDecimals(self.Primary.Range/16000*0.305,3) .. "KM")
			draw.DrawText( str, "TFASleek", xx+1, yy+1, ColorAlpha(self.TextColContrast, myalpha), TEXT_ALIGN_RIGHT )
			draw.DrawText( str, "TFASleek", xx, yy, ColorAlpha(self.TextCol, myalpha), TEXT_ALIGN_RIGHT )
			yy = yy + TFASleekFontHeight
			str =  string.upper( "Spread: " .. RoundDecimals(self.Primary.Spread and self.Primary.Spread or self.Primary.Accuracy, 2) )
			draw.DrawText( str, "TFASleek", xx+1, yy+1, ColorAlpha(self.TextColContrast, myalpha), TEXT_ALIGN_RIGHT )
			draw.DrawText( str, "TFASleek", xx, yy, ColorAlpha(self.TextCol, myalpha), TEXT_ALIGN_RIGHT )
			yy = yy + TFASleekFontHeight
			str =  string.upper( "Spread Max: ".. RoundDecimals( ( self.Primary.SpreadMultiplierMax ) , 2) )
			draw.DrawText( str, "TFASleek", xx+1, yy+1, ColorAlpha(self.TextColContrast, myalpha), TEXT_ALIGN_RIGHT )
			draw.DrawText( str, "TFASleek", xx, yy, ColorAlpha(self.TextCol, myalpha), TEXT_ALIGN_RIGHT )
			yy = yy + TFASleekFontHeight
		end
	end
	--Scope Overlay
	if self.CLIronSightsProgress > self.ScopeOverlayThreshold and self.Scoped then
		local tbl = nil
		if self.Secondary.UseACOG then
			tbl=TFA_SCOPE_ACOG
		end
		if self.Secondary.UseMilDot then
			tbl=TFA_SCOPE_MILDOT
		end
		if self.Secondary.UseSVD then
			tbl=TFA_SCOPE_SVD
		end
		if self.Secondary.UseParabolic then
			tbl=TFA_SCOPE_PARABOLIC
		end
		if self.Secondary.UseElcan then
			tbl=TFA_SCOPE_ELCAN
		end
		if self.Secondary.UseGreenDuplex then
			tbl=TFA_SCOPE_GREENDUPLEX
		end
		if self.Secondary.UseAimpoint then
			tbl=TFA_SCOPE_AIMPOINT
		end
		if self.Secondary.UseMatador then
			tbl=TFA_SCOPE_MATADOR
		end
		local w,h = ScrW(), ScrH()
		for k,v in pairs(tbl) do
			local dimension = h
			
			if k=="scopetex" then
				dimension = dimension * self.ScopeScale^2 * TFA_SCOPE_SCOPESCALE
			elseif k=="reticletex" then
				dimension = dimension * (self.ReticleScale and self.ReticleScale or 1 )^2 * ( TFA_SCOPE_RETICLESCALE and TFA_SCOPE_RETICLESCALE or 1)
			else
				dimension = dimension * self.ReticleScale^2 * TFA_SCOPE_DOTSCALE
			end
			
			local quad = {
				texture = v, 
				color = Color( 255, 255, 255, 255 ), 
				x 	= w/2-dimension/2, 
				y 	= (h-dimension)/2, 
				w 	= dimension, 
				h 	= dimension
			}
			draw.TexturedQuad(quad)
		end
	end
	
end
