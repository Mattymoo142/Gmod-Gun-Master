-- This HUD was coded by ResidualGrub the HUD textures were done by Lavadeeto.
-- You may not take or use any of these assets unless given permission
-- If there is a glitch with the HUD report it to me (ResidualGrub) by adding me on steam and telling me http://steamcommunity.com/id/ResidualGrub/

local txMag, txPlus, txRes, txNade, txHealth, txSecMag ,txSecplus, txFire, FBMagMax
local defaultwep = {
	"weapon_crowbar", "weapon_357", "weapon_ar2", "weapon_bugbait", "weapon_crossbow", "weapon_frag", "weapon_pistol", "weapon_rpg", "weapon_shotgun", "weapon_smg1", "weapon_slam", "weapon_stunstick", "gmod_camera",  "gmod_tool", "weapon_physcannon", "weapon_physgun"
}
function BF4Fonts()
--Weapon Hud
	surface.CreateFont( "BF4_Ammo_Main",
    {
        font      = "BF4 Numbers",
        size      = 73,
        weight    = 200,
    }

 )

surface.CreateFont( "BF4_Ammo_Secondary",
    {
        font      = "BF4 Numbers",
        size      = 41,
        weight    = 200,
    }

 )

surface.CreateFont( "BF4_Mini",
    {
        font      = "BF4 Numbers",
        size      = 34,
        weight    = 200,
    }

 )
--End Weapon hud
--Map
surface.CreateFont( "BF4_Counters",
    {
        font      = "Purista Semibold",
        size      = 25,
        weight    = 200,
    }

 )
txFire = ""
FBReloadAlpha = 0
Slider1Alpha = 0
Slider2Alpha = 0
Slider3Alpha = 255
Slider4Alpha = 255
Slider5Alpha = 0
Slider6Alpha = 0
FBReloadBaseAlpha = 0
FBReloadIconAlpha = 1
end
hook.Add("Initialize","BF4Fonts",BF4Fonts)
local txFire = Material( "Lavadeeto/Weapon Hud/FR_Single.png", "noclamp" )
local FBMagMax = ""
local angDiff = Angle(0,0,0)
local pointMat = Material( "Lavadeeto/Minimap/Enemy Arrow.png", "noclamp" )
local pointMatDead = Material( "Lavadeeto/Minimap/Dead Player Icon.png", "noclamp" )



function BF4HUD()
local BFply = LocalPlayer()
local BFwep = BFply:GetActiveWeapon()
local FBHudKills = math.Clamp(BFply:GetNWInt("FBKills"),0,999)
local FBHudDeaths = math.Clamp(BFply:GetNWInt("FBDeaths"),0,999)

	if IsValid(BFply) and BFply:Alive() and IsValid(BFwep) then
		--Start Weapon
		-- Draw the main part
		surface.SetDrawColor(255,255,255,255)
		surface.SetMaterial( Material( "Lavadeeto/Weapon Hud/Weapon_Back.png", "noclamp" ) )
		surface.DrawTexturedRect(ScrW()-240,(ScrH()-130),205,101)
		surface.SetTexture(0)

		--Mag Ammo Values
		if !table.HasValue( defaultwep, BFply:GetActiveWeapon():GetClass() ) and BFwep.Primary.Automatic then
			txFire = Material( "Lavadeeto/Weapon Hud/FR_Auto.png", "noclamp" )
		else 
			txFire = Material( "Lavadeeto/Weapon Hud/FR_Single.png", "noclamp" )
		end
			
		local Res=BFply:GetAmmoCount(BFwep:GetPrimaryAmmoType()) 
		-- Primary
		if BFwep:Clip1() < 0 then
			txMag = 0
		elseif BFwep:Clip1() > 999 then
			txMag = 999
		else
			txMag = BFwep:Clip1()
		end
			
		if txMag <= 9 then
			tx = ScrW()-164
			ty = ScrH()-140
		elseif txMag <= 99 then
			tx = ScrW()-200
			ty = ScrH()-140
		elseif txMag <= 999 then
			tx = ScrW()-236
			ty = ScrH()-140
		else
			tx = ScrW()-236
			ty = ScrH()-140
		end
			--Reserve
		if Res < 0 then
			txSecMag = 0
		elseif Res > 999 then
			txSecMag = 999
		else
			txSecMag = Res
		end
			
		if txSecMag <= 9 then
			sectx = ScrW()-64
			secty = ScrH()-131
		elseif txSecMag <= 99 then
			sectx = ScrW()-84
			secty = ScrH()-131
		elseif txSecMag <= 999 then
			sectx = ScrW()-105
			secty = ScrH()-131
		end

		draw.SimpleText(txMag,"BF4_Ammo_Main",tx,ty,Color(158,167,171,330),100,100)--Mag Ammo Counter
		draw.SimpleText(txSecMag,"BF4_Ammo_Secondary",sectx,secty,Color(158,167,171,230),100,100)-- Sec Mag Ammo Counter
		
			
		local Health = BFply:Health( )

		if Health < 39 then 
			HealthR = Color(math.Clamp(255 * math.sin(CurTime() * 7),100,255),0,0,255)
		else
			HealthR = Color(158,167,171,330)
		end

		local Nade = BFply:GetAmmoCount( "Grenade" )
				
		if Nade > 99 then
			txNade = 99
		else
			txNade = Nade
		end

		draw.SimpleText(Health,"BF4_Mini",ScrW()-103,ScrH()-71,HealthR,100,100)
		draw.SimpleText(txNade,"BF4_Mini",ScrW()-202,ScrH()-71,Color(158,167,171,330),100,100)
		surface.SetDrawColor(255,255,255,255)
		surface.SetMaterial(txFire)
		surface.DrawTexturedRect(ScrW()-115,ScrH()-92,60,16)
		surface.SetTexture(0)
		
		if !table.HasValue( defaultwep, BFply:GetActiveWeapon():GetClass() ) then
			FBMagMax = BFply:GetActiveWeapon().Primary.ClipSize

			if BFwep:Clip1() <= FBMagMax / 3 and FBMagMax > 0  then
				FBReloadBaseAlpha = math.Clamp(FBReloadBaseAlpha + 40,0,255)
				FBReloadIconAlpha = 255 * math.sin(CurTime() * 5)
			else
				FBReloadBaseAlpha = math.Clamp(FBReloadBaseAlpha - 40,0,255)
				FBReloadIconAlpha = math.Clamp(FBReloadIconAlpha - 40,0,255)
							
			end
		else
			FBReloadBaseAlpha = 0
			FBReloadIconAlpha = 0
		end
					

		surface.SetDrawColor(255,255,255,FBReloadBaseAlpha)
		surface.SetMaterial(Material( "Lavadeeto/Weapon Hud/Reload_Back.png", "noclamp" ))
		surface.DrawTexturedRect(ScrW()-240,ScrH()-158.1,204,29)
		surface.SetTexture(0)

		surface.SetDrawColor(255,255,255,FBReloadIconAlpha)
		surface.SetMaterial(Material( "Lavadeeto/Weapon Hud/Reload_Icon.png", "noclamp" ))
		surface.DrawTexturedRect(ScrW()-240,ScrH()-159,124,31)
		surface.SetTexture(0)

			
		-- End Weapon
		--Map

	
		surface.SetDrawColor(255,255,255,255)-- Main Map
		surface.SetMaterial( Material( "Lavadeeto/Minimap/Minimap_Back.png", "noclamp" ) )
		surface.DrawTexturedRect(19,(ScrH()-290),207,270)
		surface.SetTexture(0)

		surface.SetDrawColor(255,255,255,255)-- BG
		surface.SetMaterial( Material( "Lavadeeto/Minimap/Minimap_Front.png", "noclamp" ) )
		surface.DrawTexturedRect(20,(ScrH()-211),205,188)
		surface.SetTexture(0)
		surface.SetDrawColor(255,255,255,255)-- BG
		surface.SetMaterial( Material( "Lavadeeto/Minimap/Minimap_Front.png", "noclamp" ) )
		surface.DrawTexturedRect(20,(ScrH()-211),205,188)
		surface.SetTexture(0)

		surface.SetDrawColor(255,255,255,255)-- BG
		surface.SetMaterial( Material( "Lavadeeto/Minimap/Player Arrow.png", "noclamp" ) )
		surface.DrawTexturedRect(105,(ScrH()-136),35,35)
		surface.SetTexture(0)

		surface.SetDrawColor(255,255,255,255)-- BG
		surface.SetMaterial( Material( "Lavadeeto/Minimap/Minimap_FOV.png", "noclamp" ) )
		surface.DrawTexturedRect(22,(ScrH()-210),199,94)
		surface.SetTexture(0)


		-- Start Map functions
		for k,v in pairs(ents.FindInSphere(BFply:GetPos(),2048)) do

			if v:IsNPC() or v:IsPlayer() and v != BFply then
				Mat = ""
				dist = v:GetPos():Distance(BFply:GetPos())/4
				dir = BFply:EyeAngles().y-(v:GetPos()-BFply:GetPos()):Angle().y
				x = 120+math.floor(math.sin(math.rad(dir))*0.2*dist)
				y = ScrH()-120-math.Round(math.cos(math.rad(dir))*0.2*dist)
				local angleLine = BFply:GetAngles().y - v:GetAngles().y
				local angDiff = LerpAngle(FrameTime()*10, angDiff, v:GetAngles())
				if v:IsNPC() then
					Mat = "Lavadeeto/Minimap/Enemy Arrow.png"
				else
					Mat = "Lavadeeto/Minimap/Freindly Arrow.png"
				end
				if dist < 450 then
				    trace = {}
					trace.start = BFply:GetShootPos()
					trace.endpos = v:GetPos()
					trace.filter = {BFply,v}
					tr = util.TraceLine(trace)		   	
				    if !tr.Hit then
				    	surface.SetMaterial( Material( Mat, "noclamp" ) )
						surface.SetDrawColor(255,255,255,255)
						surface.DrawTexturedRectRotated(x, y, 29, 30, -angleLine )
						surface.SetTexture(0)
					end			        				        		
				        	
				end

						
			end

			if v:GetClass() == "npc_grenade_frag" or v:GetClass() == "fas2_thrown_m67" or v:GetClass() == "fas2_40mm_frag" or v:GetClass() == "fas2_m67" or v:GetClass() == "cstm_grenade" then
				surface.SetMaterial( Material( "Lavadeeto/Extras/Frag Icon.png", "noclamp" ) )
				surface.DrawTexturedRectRotated( v:GetPos():ToScreen().x, v:GetPos():ToScreen().y - 15, 38/2, 42/2, 0 )
			end	
			
			if v:GetClass() == "fas2_thrown_ammobox" or v:GetClass() == "activated_ammokit" then
				surface.SetMaterial( Material( "Lavadeeto/Extras/ammopack.png", "noclamp" ) )
				surface.DrawTexturedRectRotated( v:GetPos():ToScreen().x, v:GetPos():ToScreen().y - 15, 50/2, 43/2, 0 )
			end	
			
			if v:GetClass() == "item_healthkit" or v:GetClass() == "item_healthvial" or v:GetClass() == "activated_medkit"  then
				surface.SetMaterial( Material( "Lavadeeto/Extras/medicpack.png", "noclamp" ) )
				surface.DrawTexturedRectRotated( v:GetPos():ToScreen().x, v:GetPos():ToScreen().y - 15, 50/2, 43/2, 0 )
			end	
							
		end
		draw.SimpleText(FBHudKills,"BF4_Counters",27,ScrH()-236,Color(125,211,254,330),100,100)
		draw.SimpleText(FBHudDeaths,"BF4_Counters",185,ScrH()-236,Color(231,139,94,330),100,100)

		if FBHudKills > FBHudDeaths then
			Slider1Alpha = math.Clamp(Slider1Alpha + 30,0,255)
			Slider2Alpha = math.Clamp(Slider2Alpha + 30,0,200)
			Slider3Alpha = math.Clamp(Slider3Alpha + 30,0,155)
			Slider4Alpha = math.Clamp(Slider4Alpha + 30,0,100)
			Slider5Alpha = math.Clamp(Slider5Alpha - 30,0,255)
			Slider6Alpha = math.Clamp(Slider6Alpha - 30,0,255)
		elseif FBHudKills < FBHudDeaths then 
			Slider1Alpha = math.Clamp(Slider1Alpha - 30,0,255)
			Slider2Alpha = math.Clamp(Slider2Alpha - 30,0,200)
			Slider3Alpha = math.Clamp(Slider3Alpha - 30,155,255)
			Slider4Alpha = math.Clamp(Slider4Alpha - 30,100,255)
			Slider5Alpha = math.Clamp(Slider5Alpha + 30,0,255)
			Slider6Alpha = math.Clamp(Slider6Alpha + 30,0,255)
		else
			Slider1Alpha = math.Clamp(Slider1Alpha - 30,0,255)
			Slider2Alpha = math.Clamp(Slider2Alpha - 30,0,200)
			Slider3Alpha = math.Clamp(Slider3Alpha + 30,0,255)
			Slider4Alpha = math.Clamp(Slider4Alpha + 30,0,255)
			Slider5Alpha = math.Clamp(Slider5Alpha - 30,0,255)
			Slider6Alpha = math.Clamp(Slider6Alpha - 30,0,255)
		end

			surface.SetDrawColor(255,255,255,Slider1Alpha)-- Slider 1
			surface.SetMaterial( Material( "Lavadeeto/Minimap/Slider_Win.png", "noclamp" ) )
			surface.DrawTexturedRect(65,(ScrH()-254),20,20)
			surface.SetTexture(0)

			surface.SetDrawColor(255,255,255,Slider2Alpha)-- Slider 2
			surface.SetMaterial( Material( "Lavadeeto/Minimap/Slider_Win.png", "noclamp" ) )
			surface.DrawTexturedRect(85,(ScrH()-254),20,20)
			surface.SetTexture(0)

			surface.SetDrawColor(255,255,255,Slider3Alpha)-- Slider 3
			surface.SetMaterial( Material( "Lavadeeto/Minimap/Slider_Nuetral.png", "noclamp" ) )
			surface.DrawTexturedRect(105,(ScrH()-254),20,20)
			surface.SetTexture(0)

			surface.SetDrawColor(255,255,255,Slider4Alpha)-- Slider 4
			surface.SetMaterial( Material( "Lavadeeto/Minimap/Slider_Nuetral.png", "noclamp" ) )
			surface.DrawTexturedRect(125,(ScrH()-254),20,20)
			surface.SetTexture(0)
			
			surface.SetDrawColor(255,255,255,Slider5Alpha)-- Slider 5
			surface.SetMaterial( Material( "Lavadeeto/Minimap/Slider_Lose.png", "noclamp" ) )
			surface.DrawTexturedRect(145,(ScrH()-254),20,20)
			surface.SetTexture(0)

			surface.SetDrawColor(255,255,255,Slider6Alpha)-- Slider 6
			surface.SetMaterial( Material( "Lavadeeto/Minimap/Slider_Lose.png", "noclamp" ) )
			surface.DrawTexturedRect(165,(ScrH()-254),20,20)
			surface.SetTexture(0)

	end
end
hook.Add("HUDPaint","BF4HUD",BF4HUD )

function BF4Hide(name)
	if name == "CHudHealth" or name == "CHudBattery" or name == "CHudAmmo" or name == "CHudSecondaryAmmo" then 
		return false 
	end	

end
hook.Add("HUDShouldDraw", "BF4Hide", BF4Hide)
