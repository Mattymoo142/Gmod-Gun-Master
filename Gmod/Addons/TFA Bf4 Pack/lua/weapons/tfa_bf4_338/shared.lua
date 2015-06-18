
SWEP.Category				= "TFA BF4"
SWEP.Author				= "TFA"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment		= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.DrawCrosshair			= false	

SWEP.ViewModelFOV			= 60
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/bf4weap/v_snip_338.mdl"
SWEP.WorldModel				= "models/bf4weap/w_snip_338.mdl"
SWEP.Base 				= "tfa_scoped_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("bf4weap/338/fire.wav")
SWEP.Primary.Round			= ("gdcwa_338_lapua")
SWEP.Primary.RPM			= 48					// This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 6					// Size of a clip
SWEP.Primary.DefaultClip		= 42					// Default number of bullets in a clip
SWEP.Primary.ConeSpray			= 3.75					// Hip fire accuracy
SWEP.Primary.ConeIncrement		= 0					// Rate of innacuracy
SWEP.Primary.ConeMax			= 5.75					// Maximum Innacuracy
SWEP.Primary.ConeDecrement		= 7.5   				        // Rate of accuracy
SWEP.Primary.KickUp			= 2						// Maximum up recoil (rise)
SWEP.Primary.KickDown			= 1						// Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 1						// Maximum up recoil (stock)
SWEP.Primary.Automatic			= false					// Automatic/Semi Auto
SWEP.Primary.Ammo			= "ar2"

SWEP.Secondary.ClipSize			= 1					// Size of a clip
SWEP.Secondary.DefaultClip		= 1					// Default number of bullets in a clip
SWEP.Secondary.Automatic		= false					// Automatic/Semi Auto
SWEP.Secondary.Ammo			= ""
SWEP.Secondary.ScopeZoom		= 12		
SWEP.Secondary.UseRangefinder		=true
SWEP.Secondary.UseMilDot		=true
SWEP.data 				= {}					-- The starting firemode
SWEP.data.ironsights			= 1
SWEP.ScopeScale 			= 0.75
SWEP.Velocity				= 520

SWEP.IronSightsPos = Vector(-3.201, -7.84, 0.92)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.SightsPos = Vector(-3.201, -7.84, 0.92)
SWEP.SightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(-0.202, -5.226, -0.603)
SWEP.RunSightsAng = Vector(-11.256, 42.21, -28.142)

SWEP.BoltAction = true

SWEP.Primary.SpreadMultiplierMax = 7
SWEP.Primary.SpreadIncrement = 4
SWEP.Primary.SpreadRecovery = 6

SWEP.HoldType 				= "ar2"		-- This is how others view you carrying the weapon.

--Crotch Gun Fix
SWEP.Offset = {
	Pos = {
	Up = 0,
	Right = 1,
	Forward = -3,
	},
	Ang = {
	Up = 0,
	Right = -3,
	Forward = 180,
	}
}

