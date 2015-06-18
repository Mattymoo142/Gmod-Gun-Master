--Config GUI
if CLIENT then

	local function tfaOptionServer(panel)
	--Here are whatever default categories you want.
	
	local tfaOptionSV = {Options = {}, CVars = {}, Label = "#Presets", MenuButton = "1", Folder = "TFA SWEP Settings Server"}
	
	tfaOptionSV.Options["#Default"] = { sv_tfa_weapon_strip =	"0",
								sv_tfa_allow_dryfire =	"1",
								sv_tfa_damage_multiplier =	"1",
								sv_tfa_default_clip =	"-1",
								sv_tfa_arrow_lifetime = "30",
								sv_tfa_force_multiplier = "1",
								sv_tfa_dynamicaccuracy = "1",
								sv_tfa_near_wall = "1",
								sv_tfa_gunbob_intensity = "1",
								sv_tfa_viewbob_intensity = "1",
								sv_tfa_range_modifier = "0.5"
							   }				
	panel:AddControl("ComboBox", tfaOptionSV)
	
	--These are the panel controls.  Adding these means that you don't have to go into the console.
	
		panel:AddControl("CheckBox", {
		Label = "Require reload keypress",
		Command = "sv_tfa_allow_dryfire",
	})
	
	panel:AddControl("CheckBox", {
		Label = "Dynamic Accuracy",
		Command = "sv_tfa_dynamicaccuracy",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Pull up weapon when near wall",
		Command = "sv_tfa_near_wall",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Strip Empty Weapons",
		Command = "sv_tfa_weapon_strip",
	})
	
		panel:AddControl("Slider", {
		Label 	= "Damage Multiplier",
		Command 	= "sv_tfa_damage_multiplier",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "5",
	})
	
		panel:AddControl("Slider", {
		Label 	= "Impact Force Multiplier",
		Command 	= "sv_tfa_force_multiplier",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "5",
	})
	
		panel:AddControl("Slider", {
		Label 	= "Default Clip Count (-1 = default)",
		Command 	= "sv_tfa_default_clip",
		Type 		= "Integer",
		Min 		= "-1",
		Max 		= "10",
	})
	
		panel:AddControl("Slider", {
		Label 	= "Gun Bob Intensity",
		Command 	= "sv_tfa_gunbob_intensity",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "2",
	})
	
		panel:AddControl("Slider", {
		Label 	= "View Bob Intensity",
		Command 	= "sv_tfa_viewbob_intensity",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "2",
	})
	
		panel:AddControl("Slider", {
		Label 	= "Bullet Range Damage Degredation",
		Command 	= "sv_tfa_range_modifier",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "1",
	})
	
	panel:AddControl("Label", {Text = "By TheForgottenArchitect"})
	end
	
	local function tfaOptionClient(panel)
	--Here are whatever default categories you want.
	
	local tfaOptionCL = {Options = {}, CVars = {}, Label = "#Presets", MenuButton = "1", Folder = "TFA SWEP Settings Client"}
	
	tfaOptionCL.Options["#Default"] = { cl_tfa_scope_sensitivity_autoscale = "1",
								cl_tfa_scope_sensitivity =	"100",
								cl_tfa_ironsights_toggle = "1",
								cl_tfa_ironsights_resight = "1",
								cl_tfa_viewbob_reloading = "1",
								cl_tfa_viewbob_drawing = "0"
							   }				
	panel:AddControl("ComboBox", tfaOptionCL)
	
	--These are the panel controls.  Adding these means that you don't have to go into the console.
	
		panel:AddControl("CheckBox", {
		Label = "Use Viebob While Drawing",
		Command = "cl_tfa_viewbob_drawing",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Use Viebob While Reloading",
		Command = "cl_tfa_viewbob_reloading",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Toggle Ironsights",
		Command = "cl_tfa_ironsights_toggle",
	})
		panel:AddControl("CheckBox", {
		Label = "Preserve Sights On Reload, Sprint, etc.",
		Command = "cl_tfa_ironsights_resight",
	})
		panel:AddControl("CheckBox", {
		Label = "Compensate sensitivity for FOV",
		Command = "cl_tfa_scope_sensitivity_autoscale",
	})
	
		panel:AddControl("Slider", {
		Label 	= "Scope sensitivity",
		Command 	= "cl_tfa_scope_sensitivity",
		Type 		= "Integer",
		Min 		= "1",
		Max 		= "100",
	})
	
	panel:AddControl("Label", {Text = "By TheForgottenArchitect"})
	end

	local function tfaOptionPerformance(panel)
	--Here are whatever default categories you want.
	
	local tfaOptionPerf = {Options = {}, CVars = {}, Label = "#Presets", MenuButton = "1", Folder = "TFA SWEP Settings Performance"}
	
	tfaOptionPerf.Options["#Default"] = {    cl_tfa_fx_impact_enabled = "1",
								cl_tfa_fx_impact_ricochet_enabled = "1",
								cl_tfa_fx_impact_ricochet_sparks = "20",
								cl_tfa_fx_impact_ricochet_sparklife = "2",
								cl_tfa_fx_gasblur = "1",
								cl_tfa_fx_muzzlesmoke = "1"
							   }				
	panel:AddControl("ComboBox", tfaOptionPerf)
	
		panel:AddControl("CheckBox", {
		Label = "Use Gas Blur",
		Command = "cl_tfa_fx_gasblur",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Use Muzzle Smoke Trails",
		Command = "cl_tfa_fx_muzzlesmoke",
	})	
	
		panel:AddControl("CheckBox", {
		Label = "Use Custom Impact FX",
		Command = "cl_tfa_fx_impact_enabled",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Use Ricochet FX",
		Command = "cl_tfa_fx_impact_ricochet_enabled",
	})
	
		panel:AddControl("Slider", {
		Label 	= "Ricochet Spark Amount",
		Command 	= "cl_tfa_fx_impact_ricochet_sparks",
		Type 		= "Integer",
		Min 		= "0",
		Max 		= "50",
	})
	
		panel:AddControl("Slider", {
		Label 	= "Ricochet Spark Life",
		Command 	= "cl_tfa_fx_impact_ricochet_sparklife",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "5",
	})
	
	panel:AddControl("Label", {Text = "By TheForgottenArchitect"})
	end

	local function tfaOptionHUD(panel)
	
	--Here are whatever default categories you want.
	
	local tfaOptionHUD = {Options = {}, CVars = {}, Label = "#Presets", MenuButton = "1", Folder = "TFA SWEP Settings HUD"}
	
	tfaOptionHUD.Options["#Default"] = {	cl_tfa_hud_crosshair_enable_custom = "1",
								cl_tfa_hud_crosshair_color_r = "225",
								cl_tfa_hud_crosshair_color_g = "225",
								cl_tfa_hud_crosshair_color_b = "225",
								cl_tfa_hud_crosshair_color_a = "225",
								cl_tfa_hud_crosshair_outline_color_r = "5",
								cl_tfa_hud_crosshair_outline_color_g = "5",
								cl_tfa_hud_crosshair_outline_color_b = "5",
								cl_tfa_hud_crosshair_outline_color_a = "225",
								cl_tfa_hud_enabled = "1",
								cl_tfa_hud_ammodata_fadein = "0.2",
								cl_tfa_hud_hangtime = "1",
								cl_tfa_hud_crosshair_length_use_pixels = "0",
								cl_tfa_hud_crosshair_length = "1",
								cl_tfa_hud_crosshair_width = "1",
								cl_tfa_hud_crosshair_gap_scale = "1",
								cl_tfa_hud_crosshair_outline_enabled = "1",
								cl_tfa_hud_crosshair_outline_width = "1",
								cl_tfa_hud_crosshair_dot = "0"
							   }		
	
	tfaOptionHUD.Options["Cross"] = {	cl_tfa_hud_crosshair_enable_custom = "1",
								cl_tfa_hud_crosshair_color_r = "255",
								cl_tfa_hud_crosshair_color_g = "255",
								cl_tfa_hud_crosshair_color_b = "255",
								cl_tfa_hud_crosshair_color_a = "200",
								cl_tfa_hud_crosshair_outline_color_r = "154",
								cl_tfa_hud_crosshair_outline_color_g = "152",
								cl_tfa_hud_crosshair_outline_color_b = "175",
								cl_tfa_hud_crosshair_outline_color_a = "255",
								cl_tfa_hud_enabled = "1",
								cl_tfa_hud_ammodata_fadein = "0.2",
								cl_tfa_hud_hangtime = "1",
								cl_tfa_hud_crosshair_length_use_pixels = "0",
								cl_tfa_hud_crosshair_length = "0.75",
								cl_tfa_hud_crosshair_width = "1",
								cl_tfa_hud_crosshair_gap_scale = "0",
								cl_tfa_hud_crosshair_outline_enabled = "1",
								cl_tfa_hud_crosshair_outline_width = "1",
								cl_tfa_hud_crosshair_dot = "0"
							   }		
	
	tfaOptionHUD.Options["Dot/Minimalist"] = {	cl_tfa_hud_crosshair_enable_custom = "1",
								cl_tfa_hud_crosshair_color_r = "72",
								cl_tfa_hud_crosshair_color_g = "72",
								cl_tfa_hud_crosshair_color_b = "72",
								cl_tfa_hud_crosshair_color_a = "85",
								cl_tfa_hud_crosshair_outline_color_r = "225",
								cl_tfa_hud_crosshair_outline_color_g = "225",
								cl_tfa_hud_crosshair_outline_color_b = "225",
								cl_tfa_hud_crosshair_outline_color_a = "85",
								cl_tfa_hud_enabled = "1",
								cl_tfa_hud_ammodata_fadein = "0.1",
								cl_tfa_hud_hangtime = "0.5",
								cl_tfa_hud_crosshair_length_use_pixels = "0",
								cl_tfa_hud_crosshair_length = "0",
								cl_tfa_hud_crosshair_width = "1",
								cl_tfa_hud_crosshair_gap_scale = "0",
								cl_tfa_hud_crosshair_outline_enabled = "1",
								cl_tfa_hud_crosshair_outline_width = "1",
								cl_tfa_hud_crosshair_dot = "0"
							   }	
	
	tfaOptionHUD.Options["Half Life 2"] = {	cl_tfa_hud_crosshair_enable_custom = "0",
								cl_tfa_hud_crosshair_color_r = "255",
								cl_tfa_hud_crosshair_color_g = "255",
								cl_tfa_hud_crosshair_color_b = "255",
								cl_tfa_hud_crosshair_color_a = "225",
								cl_tfa_hud_crosshair_outline_color_r = "5",
								cl_tfa_hud_crosshair_outline_color_g = "5",
								cl_tfa_hud_crosshair_outline_color_b = "5",
								cl_tfa_hud_crosshair_outline_color_a = "0",
								cl_tfa_hud_enabled = "0",
								cl_tfa_hud_ammodata_fadein = "0.01",
								cl_tfa_hud_hangtime = "0",
								cl_tfa_hud_crosshair_length_use_pixels = "1",
								cl_tfa_hud_crosshair_length = "0.5",
								cl_tfa_hud_crosshair_width = "1",
								cl_tfa_hud_crosshair_gap_scale = "1",
								cl_tfa_hud_crosshair_outline_enabled = "0",
								cl_tfa_hud_crosshair_outline_width = "0",
								cl_tfa_hud_crosshair_dot = "1"
							   }	
	
	tfaOptionHUD.Options["Half Life 2 Enhanced"] = {	cl_tfa_hud_crosshair_enable_custom = "1",
								cl_tfa_hud_crosshair_color_r = "255",
								cl_tfa_hud_crosshair_color_g = "255",
								cl_tfa_hud_crosshair_color_b = "255",
								cl_tfa_hud_crosshair_color_a = "225",
								cl_tfa_hud_crosshair_outline_color_r = "5",
								cl_tfa_hud_crosshair_outline_color_g = "5",
								cl_tfa_hud_crosshair_outline_color_b = "5",
								cl_tfa_hud_crosshair_outline_color_a = "0",
								cl_tfa_hud_enabled = "1",
								cl_tfa_hud_ammodata_fadein = "0.2",
								cl_tfa_hud_hangtime = "1",
								cl_tfa_hud_crosshair_length_use_pixels = "1",
								cl_tfa_hud_crosshair_length = "0.5",
								cl_tfa_hud_crosshair_width = "1",
								cl_tfa_hud_crosshair_gap_scale = "1",
								cl_tfa_hud_crosshair_outline_enabled = "0",
								cl_tfa_hud_crosshair_outline_width = "0",
								cl_tfa_hud_crosshair_dot = "1"
							   }				
	panel:AddControl("ComboBox", tfaOptionHUD)
	
	--These are the panel controls.  Adding these means that you don't have to go into the console.
	
		panel:AddControl("CheckBox", {
		Label = "Use Custom HUD",
		Command = "cl_tfa_hud_enabled",
	})

		panel:AddControl("Slider", {
		Label 	= "Ammo HUD Fadein Time",
		Command 	= "cl_tfa_hud_ammodata_fadein",
		Type 		= "Float",
		Min 		= "0.01",
		Max 		= "1",
	})
	
		panel:AddControl("Slider", {
		Label 	= "HUD Hang Time (after a reload, etc.)",
		Command 	= "cl_tfa_hud_hangtime",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "5",
	})	
	
	panel:AddControl("Label", {Text = "-Crosshair Options-"})
	
		panel:AddControl("CheckBox", {
		Label = "Use Custom Crosshair",
		Command = "cl_tfa_hud_crosshair_enable_custom",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Use Crosshair Dot",
		Command = "cl_tfa_hud_crosshair_dot",
	})
	
		panel:AddControl("CheckBox", {
		Label = "Crosshair Length In Pixels?",
		Command = "cl_tfa_hud_crosshair_length_use_pixels",
	})

		panel:AddControl("Slider", {
		Label 	= "Crosshair Length",
		Command 	= "cl_tfa_hud_crosshair_length",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "10",
	})

		panel:AddControl("Slider", {
		Label 	= "Crosshair Gap Scale",
		Command 	= "cl_tfa_hud_crosshair_gap_scale",
		Type 		= "Float",
		Min 		= "0",
		Max 		= "2",
	})

		panel:AddControl("Slider", {
		Label 	= "Crosshair Width",
		Command 	= "cl_tfa_hud_crosshair_width",
		Type 		= "Integer",
		Min 		= "0",
		Max 		= "3",
	})
	
		panel:AddControl("Color", {
		Label = "Crosshair Color",
		Red = "cl_tfa_hud_crosshair_color_r",
		Green = "cl_tfa_hud_crosshair_color_g",
		Blue = "cl_tfa_hud_crosshair_color_b",
		Alpha = "cl_tfa_hud_crosshair_color_a",
		ShowHSV = 1,
		ShowRGB = 1,
		Multiplier = 255
	})
	
		panel:AddControl("CheckBox", {
		Label = "Enable Crosshair Outline",
		Command = "cl_tfa_hud_crosshair_outline_enabled",
	})

		panel:AddControl("Slider", {
		Label 	= "Crosshair Outline Width",
		Command 	= "cl_tfa_hud_crosshair_outline_width",
		Type 		= "Integer",
		Min 		= "0",
		Max 		= "3",
	})
	
		panel:AddControl("Color", {
		Label = "Crosshair Outline Color",
		Red = "cl_tfa_hud_crosshair_outline_color_r",
		Green = "cl_tfa_hud_crosshair_outline_color_g",
		Blue = "cl_tfa_hud_crosshair_outline_color_b",
		Alpha = "cl_tfa_hud_crosshair_outline_color_a",
		ShowHSV = 1,
		ShowRGB = 1,
		Multiplier = 255
	})
	
	panel:AddControl("Label", {Text = "By TheForgottenArchitect"})
	end
	
	local function tfaOptionRestriction(panel)
	
	--Here are whatever default categories you want.
	
	local tfaOptionRestriction = {Options = {}, CVars = {}, Label = "#Presets", MenuButton = "1", Folder = "TFA SWEP Settings Restriction"}
	
	tfaOptionRestriction.Options["#Default"] = {}				
	panel:AddControl("ComboBox", tfaOptionRestriction)
	local blankar = {}
	local lv = vgui.Create("DListView")
	
	
	lv:AddColumn("Weapon")
	lv:AddColumn("Restricted?")
	
	local myoptionstable = tfaOptionRestriction.Options["#Default"]
	
	for k,v in pairs(TFAWeaponTable) do
		if GetConVarNumber("tfa_blacklist_"..string.Replace(v,"tfa_",""),0) == 0 then
			lv:AddLine(v,"false")
		else
			lv:AddLine(v,"true")
		end
		myoptionstable["tfa_blacklist_"..string.Replace(v,"tfa_","")]=0
	end
	
	lv:SizeToContents()
	lv.DoDoubleClick = function(parent, index, listv)
		local v = TFAWeaponTable[index]
		local v_og = TFAWeaponTable[index]
		v = string.Replace(v,"tfa_","")
		if IsValid(LocalPlayer()) then
			local pl = LocalPlayer()
			local ccm = "tfa_blacklist_"..v
			pl:ConCommand(ccm.." "..(1-GetConVarNumber(ccm,0)))
			local lines = lv:GetLines()
			local line = lines[1]
			lv:Update()
			timer.Simple(0.01, function()
				if IsValid(lv) then
					lv:Update()
				end
			end)
		end
	end
	
	lv.Update = function()
		timer.Simple(0, function()
			if IsValid(lv) then
				lv:Clear()
				for k,v in pairs(TFAWeaponTable) do
					local line
					if GetConVarNumber("tfa_blacklist_"..string.Replace(v,"tfa_",""),0) == 0 then
						lv:AddLine(v,"false")
					else
						lv:AddLine(v,"true")
					end
				end
			end
		end)
	end
	
	local s_x,s_y = panel:GetSize()
	lv:SetHeight(math.max(480,s_y-10))
	
	panel:AddItem(lv)
	
	local b = vgui.Create("DButton")
	b.listv = lv
	b:SizeToContents()
	b.DoClick = function()
		if IsValid(self) then
			if IsValid(self.listv) then
				self.listv:Update()
			end
		end
		if IsValid(lv) then
			lv:Update()
		end
	end
	b:SetText("Refresh")
	
	panel:AddItem(b)
	panel:AddControl("Label", {Text = "By TheForgottenArchitect"})
	
	end
	
	function tfaAddOption()
		spawnmenu.AddToolMenuOption("Options", "TFA SWEP Base Settings", "tfaOptionWeapons", "Weapon Behavior, Clientside", "", "", tfaOptionClient)
		spawnmenu.AddToolMenuOption("Options", "TFA SWEP Base Settings", "tfaOptionPerformance", "Performance", "", "", tfaOptionPerformance)
		spawnmenu.AddToolMenuOption("Options", "TFA SWEP Base Settings", "TFASwepBaseCrosshair", "HUD / Crosshair", "", "", tfaOptionHUD)
		spawnmenu.AddToolMenuOption("Options", "TFA SWEP Base Settings", "TFASwepBaseServer", "Admin / Server", "", "", tfaOptionServer)
		spawnmenu.AddToolMenuOption("Options", "TFA SWEP Base Settings", "TFASwepBaseRestriction", "Restriction", "", "", tfaOptionRestriction)
	end
	
	hook.Add("PopulateToolMenu", "tfaAddOption", tfaAddOption)


else
	AddCSLuaFile()
end

--Serverside Convars

if GetConVar("sv_tfa_weapon_strip") == nil then
	CreateConVar("sv_tfa_weapon_strip", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Allow the removal of empty weapons? 1 for true, 0 for false")
	--print("Weapon strip/removal con var created")
end
	
if GetConVar("sv_tfa_range_modifier") == nil then
	CreateConVar("sv_tfa_range_modifier", "0.5", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "This controls how much the range affects damage.  0.5 means the maximum loss of damage is 0.5.")
	--print("Dry fire con var created")
end
	
if GetConVar("sv_tfa_allow_dryfire") == nil then
	CreateClientConVar("sv_tfa_allow_dryfire", 1, true, true)
	--print("Dry fire con var created")
end


if GetConVar("sv_tfa_near_wall") == nil then
	CreateConVar("sv_tfa_near_wall", "1", {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Pull up your weapon and disable shooting when you're too close to a wall?" )
	--print("Near wall con var created")
end

if GetConVar("sv_tfa_damage_multiplier") == nil then
	CreateConVar("sv_tfa_damage_multiplier", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Multiplier for TFA base projectile damage.")
	--print("Damage Multiplier con var created")
end

if GetConVar("sv_tfa_damage_mult_min") == nil then
	CreateConVar("sv_tfa_damage_mult_min", "0.95", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "This is the lower range of a random damage factor.")
	--print("Damage Multiplier con var created")
end

if GetConVar("sv_tfa_damage_mult_max") == nil then
	CreateConVar("sv_tfa_damage_mult_max", "1.05", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "This is the lower range of a random damage factor.")
	--print("Damage Multiplier con var created")
end

if GetConVar("sv_tfa_default_clip") == nil then
	CreateConVar("sv_tfa_default_clip", "-1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "How many clips will a weapon spawn with? Negative reverts to default values.")
	--print("Default clip size con var created")
end

if GetConVar("sv_tfa_viewbob_intensity") == nil then
	CreateConVar("sv_tfa_viewbob_intensity", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "How much the player view itself bobs.")
	--print("Viewbob intensity con var created")
end

if GetConVar("sv_tfa_gunbob_intensity") == nil then
	CreateConVar("sv_tfa_gunbob_intensity", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "How much the gun itself bobs.")
	--print("Viewbob intensity con var created")
end
	
if GetConVar("sv_tfa_unique_slots") == nil then
	CreateConVar("sv_tfa_unique_slots", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Give TFA-based Weapons unique slots? 1 for true, 0 for false. RESTART AFTER CHANGING.")
	--print("Unique slot con var created")
end
	
if GetConVar("sv_tfa_force_multiplier") == nil then
	CreateConVar("sv_tfa_force_multiplier", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Arrow force multiplier (not arrow velocity, but how much force they give on impact).")
	--print("Arrow force con var created")
end
	
if GetConVar("sv_tfa_dynamicaccuracy") == nil then
	CreateConVar("sv_tfa_dynamicaccuracy", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Dynamic acuracy?  (e.g.more accurate on crouch, less accurate on jumping.")
	--print("DynAcc con var created")
end
	
if GetConVar("sv_tfa_ammo_detonation") == nil then
	CreateConVar("sv_tfa_ammo_detonation", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Ammo Detonation?  (e.g. shoot ammo until it explodes) ")
	--print("DynAcc con var created")
end
	
if GetConVar("sv_tfa_ammo_detonation_mode") == nil then
	CreateConVar("sv_tfa_ammo_detonation_mode", "2", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Ammo Detonation Mode?  (0=Bullets,1=Blast,2=Mix) ")
	--print("DynAcc con var created")
end
	
if GetConVar("sv_tfa_ammo_detonation_chain") == nil then
	CreateConVar("sv_tfa_ammo_detonation_chain", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Ammo Detonation Chain?  (0=Ammo boxes don't detonate other ammo boxes, 1 you can chain them together) ")
	--print("DynAcc con var created")
end
	
if GetConVar("sv_tfa_scope_gun_speed_scale") == nil then
	CreateConVar("sv_tfa_scope_gun_speed_scale", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Scale player sensitivity based on player move speed?")
end
	
if GetConVar("sv_tfa_bullet_penetration") == nil then
	CreateConVar("sv_tfa_bullet_penetration", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Allow bullet penetration?")
end
	
if GetConVar("sv_tfa_bullet_ricochet") == nil then
	CreateConVar("sv_tfa_bullet_ricochet", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Allow bullet ricochet?")
end
	
if GetConVar("sv_tfa_holdtype_dynamic") == nil then
	CreateConVar("sv_tfa_holdtype_dynamic", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Allow dynamic holdtype?")
end
	
if GetConVar("sv_tfa_compatibility_movement") == nil then
	CreateConVar("sv_tfa_compatibility_movement", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Disable custom movement speed for increased compatibility?")
end
	
if GetConVar("sv_tfa_compatibility_clientframe") == nil then
	CreateConVar("sv_tfa_compatibility_clientframe", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "This should be used if you have an addon that breaks TFA Base's aiming or other features, but you don't want to remove it.")
end

if GetConVar("sv_tfa_compatibility_footstep") == nil then
	CreateConVar("sv_tfa_compatibility_footstep", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "This should be used if you have an addon that breaks TFA Base's running, sprinting, etc. animations.")
end

--Clientside Convars

if CLIENT then
	if GetConVar("cl_tfa_scope_sensitivity_autoscale") == nil then
		CreateClientConVar("cl_tfa_scope_sensitivity_autoscale", 100, true, true)
		--print("Scope sensitivity autoscale con var created")
	end
		
	if GetConVar("cl_tfa_scope_sensitivity") == nil then
		CreateClientConVar("cl_tfa_scope_sensitivity", 100, true, true)
		--print("Scope sensitivity con var created")
	end
		
	if GetConVar("cl_tfa_ironsights_toggle") == nil then
		CreateClientConVar("cl_tfa_ironsights_toggle", 1, true, true)
		--print("Ironsights toggle con var created")
	end
		
	if GetConVar("cl_tfa_ironsights_resight") == nil then
		CreateClientConVar("cl_tfa_ironsights_resight", 1, true, true)
		--print("Ironsights resight con var created")
	end
		
	--Crosshair Params
	
	if GetConVar("cl_tfa_hud_crosshair_length") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_length", 1, true, true)
	end
		
	if GetConVar("cl_tfa_hud_crosshair_length_use_pixels") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_length_use_pixels", 0, true, true)
	end
		
	if GetConVar("cl_tfa_hud_crosshair_width") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_width", 1, true, true)
	end
		
	if GetConVar("cl_tfa_hud_crosshair_enable_custom") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_enable_custom", 1, true, true)
		--print("Custom crosshair con var created")
	end
		
	if GetConVar("cl_tfa_hud_crosshair_gap_scale") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_gap_scale", 1, true, true)
	end
	
	if GetConVar("cl_tfa_hud_crosshair_dot") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_dot", 0, true, true)
	end
	
	--Crosshair Color
	if GetConVar("cl_tfa_hud_crosshair_color_r") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_color_r", 225, true, true)
		--print("Crosshair tweaking con vars created")
	end
		
	if GetConVar("cl_tfa_hud_crosshair_color_g") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_color_g", 225, true, true)
	end
		
	if GetConVar("cl_tfa_hud_crosshair_color_b") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_color_b", 225, true, true)
	end
		
	if GetConVar("cl_tfa_hud_crosshair_color_a") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_color_a", 200, true, true)
	end
	--Crosshair Outline
	if GetConVar("cl_tfa_hud_crosshair_outline_color_r") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_outline_color_r", 5, true, true)
	end
		
	if GetConVar("cl_tfa_hud_crosshair_outline_color_g") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_outline_color_g", 5, true, true)
	end
		
	if GetConVar("cl_tfa_hud_crosshair_outline_color_b") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_outline_color_b", 5, true, true)
	end
		
	if GetConVar("cl_tfa_hud_crosshair_outline_color_a") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_outline_color_a", 200, true, true)
	end
		
	if GetConVar("cl_tfa_hud_crosshair_outline_width") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_outline_width", 1, true, true)
	end
		
	if GetConVar("cl_tfa_hud_crosshair_outline_enabled") == nil then
		CreateClientConVar("cl_tfa_hud_crosshair_outline_enabled", 1, true, true)
	end
	
	--Other stuff
	
	if GetConVar("cl_tfa_hud_ammodata_fadein") == nil then
		CreateClientConVar("cl_tfa_hud_ammodata_fadein", 0.2, true, true)
	end
		
	if GetConVar("cl_tfa_hud_hangtime") == nil then
		CreateClientConVar("cl_tfa_hud_hangtime", 1, true, true)
	end
		
	if GetConVar("cl_tfa_hud_enabled") == nil then
		CreateClientConVar("cl_tfa_hud_enabled", 1, true, true)
	end
		
	if GetConVar("cl_tfa_fx_gasblur") == nil then
		CreateClientConVar("cl_tfa_fx_gasblur", 1, true, true)
	end
		
	if GetConVar("cl_tfa_fx_muzzlesmoke") == nil then
		CreateClientConVar("cl_tfa_fx_muzzlesmoke", 1, true, true)
	end
		
	if GetConVar("cl_tfa_fx_impact_enabled") == nil then
		CreateClientConVar("cl_tfa_fx_impact_enabled", 1, true, true)
	end
		
	if GetConVar("cl_tfa_fx_impact_ricochet_enabled") == nil then
		CreateClientConVar("cl_tfa_fx_impact_ricochet_enabled", 1, true, true)
	end

	if GetConVar("cl_tfa_fx_impact_ricochet_sparks") == nil then
		CreateClientConVar("cl_tfa_fx_impact_ricochet_sparks", 6, true, true)
	end

	if GetConVar("cl_tfa_fx_impact_ricochet_sparklife") == nil then
		CreateClientConVar("cl_tfa_fx_impact_ricochet_sparklife", 2, true, true)
	end
	
	--viewbob 
	
		
	if GetConVar("cl_tfa_viewbob_drawing") == nil then
		CreateClientConVar("cl_tfa_viewbob_drawing", 0, true, true)
	end
	
	if GetConVar("cl_tfa_viewbob_reloading") == nil then
		CreateClientConVar("cl_tfa_viewbob_reloading", 1, true, true)
	end
	
	
end

--Local function for detecting TFA Base weapons.

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
	
	if not ( IsValid(ply) and ply:IsPlayer() and ply:Alive() )then return end

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

--Blacklist convar creation

TFAWeaponTable = {}

local function UpdateWeaponTable()
	
	local f, d = file.Find("lua/weapons/tfa_*","GAME")
	
	TFAWeaponTable = {}
	
	local i = 1
	
	for k,v in pairs(d) do
		if string.find(v,"base") then
			--continue
		else			
			if GetConVar("tfa_blacklist_"..string.Replace(v,"tfa_","")) == nil then
				CreateConVar("tfa_blacklist_"..string.Replace(v,"tfa_",""), "0", { FCVAR_PROTECTED, FCVAR_ARCHIVE }, "Blacklist the "..v.."?")
			end
			if !TFAWeaponTable[i] or TFAWeaponTable[i]!=v then
				table.insert(TFAWeaponTable,i,v)
				i=i+1
			end
		end
	end

end

UpdateWeaponTable()

hook.Add( "InitPostEntity" , "InitPostEntityTFABlackList", function( )
	UpdateWeaponTable()
end)

--Disable spawning of blacklisted guns

local redcol = Color(255,0,0,255)

hook.Add( "WeaponEquip" , "TFAEquipBlacklist", function( wep )
	local v=wep:GetClass()
	if GetConVarNumber("tfa_blacklist_"..string.Replace(v,"tfa_",""),0)==1 then
		print("SWEP Blocked:")
		print(v)
		if chat and chat.AddText then chat.AddText(redcol,ply,"This gun is blacklisted!") else ply:ChatPrint("This gun is blacklisted!") end
		wep:Remove()
		return false
	end
end)

hook.Add( "PlayerCanPickupWeapon" , "TFAPickUpBlacklist", function( ply, wep )
	local v=wep:GetClass()
	if GetConVarNumber("tfa_blacklist_"..string.Replace(v,"tfa_",""),0)==1 then
		print("This player tried to pick up a blacklisted swep:")
		print(ply)
		print("SWEP:")
		print(v)
		if chat and chat.AddText then chat.AddText(redcol,ply,"This gun is blacklisted!") else ply:ChatPrint("This gun is blacklisted!") end
		wep:Remove()
		return false
	end
end)

hook.Add( "PlayerSwitchWeapon" , "TFAWepSwitchBlacklist", function( ply, oldwep, wep )
	local v=wep:GetClass()
	if GetConVarNumber("tfa_blacklist_"..string.Replace(v,"tfa_",""),0)==1 then
		print("This player tried to switch to a blacklisted swep:")
		print(ply)
		print("SWEP:")
		print(v)
		if chat and chat.AddText then chat.AddText(redcol,ply,"This gun is blacklisted!") else ply:ChatPrint("This gun is blacklisted!") end
		wep:Remove()
		return false
	end
end)

hook.Add( "PlayerGiveSWEP" , "TFAGiveSWEPBlacklist", function( ply, v, swep )
	if GetConVarNumber("sv_tfa_blacklist_"..string.Replace(v,"tfa_",""),0)==1 then
		print("This player tried to give themselves a blacklisted swep:")
		print(ply)
		print("SWEP:")
		print(v)
		if chat and chat.AddText then chat.AddText(redcol,ply,"This gun is blacklisted!") else ply:ChatPrint("This gun is blacklisted!") end
		return false
	end
end)

hook.Add( "PlayerSpawnSWEP" , "TFASpawnSWEPBlacklist", function( ply, v, swep )
	if GetConVarNumber("tfa_blacklist_"..string.Replace(v,"tfa_",""),0)==1 then
		print("This player tried to spawn themselves a blacklisted swep:")
		print(ply)
		print("SWEP:")
		print(v)
		if chat and chat.AddText then chat.AddText(redcol,ply,"This gun is blacklisted!") else ply:ChatPrint("This gun is blacklisted!") end
		return false
	end
end)

--Main weapon think

hook.Add( "PlayerTick" , "PlayerTickTFA", function( ply )
	local isc, ply, wep = PlayerCarryingTFAWeapon(ply)
	if isc then
		if wep.PlayerThink then
			wep:PlayerThink( ply )
		end
	end
end)
	
--You can't pick up props while holding TFA guns.

hook.Add("AllowPlayerPickup","TFAPickupDisable", function(ply, ent)
	local iscarryingtfa, pl, wep = PlayerCarryingTFAWeapon(ply)
	if iscarryingtfa then
		return false
	else
		return
	end
end)

--Client think per-frame

if CLIENT then
	if GetConVarNumber("sv_tfa_compatibility_clientframe",0)!=1 then
		hook.Add("PreRender", "prerender_tfabase", function()

			local iscarryingtfaweapon, pl, wep = PlayerCarryingTFAWeapon()
			
			if iscarryingtfaweapon then
				if wep.PlayerThinkClientFrame then
					wep:PlayerThinkClientFrame(pl)
				end
			end
			
		end)
	else
		hook.Add("Think", "prerender_tfabase", function()
			local iscarryingtfaweapon, pl, wep = PlayerCarryingTFAWeapon()
			
			if iscarryingtfaweapon then
				if wep.PlayerThinkClientFrame then
					wep:PlayerThinkClientFrame(pl)
				end
			end
			
		end)
	end
end

--Post draw opaque renderables.  Not needed really, not used.
--[[
hook.Add("PostDrawOpaqueRenderables", "postdrawopaquerenderables_tfabase", function()

	local iscarryingtfaweapon, pl, wep = PlayerCarryingTFAWeapon()
	
	if iscarryingtfaweapon then
		if wep.PostDrawOpaqueRenderables then
			wep:PostDrawOpaqueRenderables(pl)
		end
	end
	
end)
]]--
--SWEP footstep hook

if GetConVarNumber("sv_tfa_compatibility_footstep",0)!=1 then
	hook.Add("PlayerFootstep","tfa_playerfootstep", function( ply )
		local isc, pl, wep = PlayerCarryingTFAWeapon(ply)
		
		if isc then
			if wep.Footstep and CLIENT then
				wep:Footstep()
			end
		end
		
		return
	end)
end

--Hide default hud for TFA weapons

if CLIENT then

	local TFAHudHide = {
		CHudAmmo = true, 
		CHudSecondaryAmmo = true
	}
	
	hook.Add("HUDShouldDraw", "tfa_hidehud", function( name )
		if ( TFAHudHide[ name ] ) and ( GetConVarNumber("cl_tfa_hud_enabled",1) == 1 ) then
			local ictfa = PlayerCarryingTFAWeapon()
			if ictfa then
				return false
			end
		end
	end)

end

--Movement speed

if GetConVarNumber("sv_tfa_compatibility_movement",0)!=1 then
	hook.Add("SetupMove","tfa_setupmove",function( ply, movedata, commanddata ) 

		local iscarryingtfaweapon, pl, wep = PlayerCarryingTFAWeapon( ply )
		
		if iscarryingtfaweapon then
			if wep.GetIronSightsRatio then
				local speedmult = Lerp(wep:GetIronSightsRatio(), wep.MoveSpeed or 1, wep.IronSightsMoveSpeed or 1)
				movedata:SetMaxClientSpeed(movedata:GetMaxClientSpeed()*speedmult)
				commanddata:SetForwardMove(commanddata:GetForwardMove()*speedmult)
				commanddata:SetSideMove(commanddata:GetSideMove()*speedmult)
			end
		end

	end)
end

--Particle PCF files

if game.AddParticles then
	game.AddParticles("particles/tfa_smoke.pcf")
end

--Fonts

if !TFASleekFontCreated and CLIENT then
	local fontdata = {}
	fontdata.font = "Roboto-Regular"
	fontdata.size = 36
	fontdata.antialias = true
	fontdata.shadow = false 
	surface.CreateFont("TFASleek",fontdata)
	fontdata.size = 30
	surface.CreateFont("TFASleekMedium",fontdata)
	fontdata.size = 24
	surface.CreateFont("TFASleekSmall",fontdata)
	fontdata.size = 18
	surface.CreateFont("TFASleekTiny",fontdata)
	TFASleekFontCreated = true
	TFASleekFontHeight = draw.GetFontHeight("TFASleek")
	TFASleekFontHeightMedium = draw.GetFontHeight("TFASleekMedium")
	TFASleekFontHeightSmall = draw.GetFontHeight("TFASleekSmall")
	TFASleekFontHeightTiny = draw.GetFontHeight("TFASleekTiny")
end

--Scope materials

if CLIENT then
	TFA_SCOPE_ACOG				= {
	scopetex = surface.GetTextureID("scope/gdcw_closedsight"),
	reticletex = surface.GetTextureID("scope/gdcw_acogchevron"),
	dottex = surface.GetTextureID("scope/gdcw_acogcross")
	}
	TFA_SCOPE_MILDOT			= {
	scopetex = surface.GetTextureID("scope/gdcw_scopesight")
	}
	TFA_SCOPE_SVD				= {
	scopetex = surface.GetTextureID("scope/gdcw_svdsight")
	}
	TFA_SCOPE_PARABOLIC			= {
	scopetex = surface.GetTextureID("scope/gdcw_parabolicsight")
	}
	TFA_SCOPE_ELCAN				= {
	scopetex = surface.GetTextureID("scope/gdcw_elcansight"),
	reticletex = surface.GetTextureID("scope/gdcw_elcanreticle")
	}
	TFA_SCOPE_GREENDUPLEX		= {
	scopetex = surface.GetTextureID("scope/gdcw_closedsight"),
	reticletex = surface.GetTextureID("scope/gdcw_nvgilluminatedduplex")
	}
	TFA_SCOPE_AIMPOINT		= {
	scopetex = surface.GetTextureID("scope/gdcw_closedsight"),
	reticletex = surface.GetTextureID("scope/aimpoint")
	}
	TFA_SCOPE_MATADOR		= {
	scopetex = surface.GetTextureID("scope/rocketscope")
	}
	TFA_SCOPE_SCOPESCALE = 4
	TFA_SCOPE_RETICLESCALE = 1
	TFA_SCOPE_DOTSCALE = 1
end

--DarkRP pocketing code.

tfanpw = {}
table.insert(tfanpw, "tfa_davy_crockett_explo")
table.insert(tfanpw, "tfa_gdcwa_matador_90mm")
table.insert(tfanpw, "tfa_gdcwa_rpg_heat")
table.insert(tfanpw, "tfa_improvised_explosive")
table.insert(tfanpw, "tfa_launched_davycrockett")
table.insert(tfanpw, "tfa_launched_ex41")
table.insert(tfanpw, "tfa_launched_m79")
table.insert(tfanpw, "tfa_m202_rocket")
table.insert(tfanpw, "tfa_mad_c4")
table.insert(tfanpw, "tfa_milkor_nade")
table.insert(tfanpw, "tfa_nervegasnade")
table.insert(tfanpw, "tfa_nitro_vapor")
table.insert(tfanpw, "tfa_oribital_cannon")
table.insert(tfanpw, "tfa_poison_parent")
table.insert(tfanpw, "tfa_proxy")
table.insert(tfanpw, "tfa_released_poison")
table.insert(tfanpw, "tfa_sent_nuke_radiation")
table.insert(tfanpw, "tfa_thrown_harpoon")
table.insert(tfanpw, "tfa_thrown_knife")
table.insert(tfanpw, "tfa_thrown_m61")
table.insert(tfanpw, "tfa_thrown_nitrox")
table.insert(tfanpw, "tfa_thrown_spec_knife")
table.insert(tfanpw, "tfa_thrown_sticky_grenade")
table.insert(tfanpw, "bb_dod_bazooka_rocket")
table.insert(tfanpw, "bb_dod_panzershreck_rocket")
table.insert(tfanpw, "bb_garand_riflenade")
table.insert(tfanpw, "bb_k98_riflenade")
table.insert(tfanpw, "bb_planted_dod_tnt")
table.insert(tfanpw, "bb_thrownalliedfrag")
table.insert(tfanpw, "bb_thrownaxisfrag")
table.insert(tfanpw, "bb_thrownsmoke_axis")
table.insert(tfanpw, "bb_thrownaxisfrag")
table.insert(tfanpw, "bb_planted_alt_c4")
table.insert(tfanpw, "bb_planted_css_c4")
table.insert(tfanpw, "bb_throwncssfrag")
table.insert(tfanpw, "bb_throwncsssmoke")
table.insert(tfanpw, "tfa_ammo_40mm")
table.insert(tfanpw, "tfa_ammo_40mm_single")
table.insert(tfanpw, "tfa_ammo_357")
table.insert(tfanpw, "tfa_ammo_ar2")
table.insert(tfanpw, "tfa_ammo_buckshot")
table.insert(tfanpw, "tfa_ammo_c4")
table.insert(tfanpw, "tfa_ammo_frags")
table.insert(tfanpw, "tfa_ammo_ieds")
table.insert(tfanpw, "tfa_ammo_nervegas")
table.insert(tfanpw, "tfa_ammo_nuke")
table.insert(tfanpw, "tfa_ammo_pistol")
table.insert(tfanpw, "tfa_ammo_proxmines")
table.insert(tfanpw, "tfa_ammo_rockets")
table.insert(tfanpw, "tfa_ammo_smg")
table.insert(tfanpw, "tfa_ammo_sniper_rounds")
table.insert(tfanpw, "tfa_ammo_stickynades")
table.insert(tfanpw, "tfa_ammo_winchester")

function TFAPocketFix(ply, wep)

	if not IsValid(wep) then return end
	class = wep:GetClass()
	
	if tfanpw[class] then
		return false
	end
	
end

hook.Add("canPocket", "TFAPocketFix", TFAPocketFix )



--[[ 
Function Name:  VecOrFix
Syntax: self:VecOrFix( ). 
Returns:  Nothing.
Notes:    Guarantees vector_origin = 0.
Purpose:  Utility
]]--

function VecOrFix()
	vector_origin.x=0
	vector_origin.y=0
	vector_origin.z=0
end

hook.Add("Think", "TFAVecOrFix", VecOrFix )
--[[ 
Inspection Stuff
]]--

if SERVER then
	util.AddNetworkString( "tfaInspect" )

	net.Receive("tfaInspect", function( length, client )
		local mybool = net.ReadBool()
		mybool = mybool and 1 or 0
		if IsValid(client) and client:IsPlayer() and client:Alive() then
			local ply = client
			wep = ply:GetActiveWeapon()

			if IsValid(wep) and wep.ToggleInspect then
				wep:ToggleInspect()
			end
		
		end
	end)
end

function TFAPlayerBindPress(ply, b, p)
	if p and IsValid(ply) then
		local wep = ply:GetActiveWeapon()

		if IsValid(wep) and wep.ToggleInspect then
			if b == "+menu_context"  then
				wep:ToggleInspect()
				return true
			end
		end
	end
end

hook.Add("PlayerBindPress", "TFAInspectionMenu", TFAPlayerBindPress)