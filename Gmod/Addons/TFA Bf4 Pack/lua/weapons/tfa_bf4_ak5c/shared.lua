
SWEP.Category				= "TFA BF4"
SWEP.Author				    = "TFA"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions			= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment		= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.DrawCrosshair			= true		-- Set false if you want no crosshair from hip

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/bf4weap/v_rif_bak5c.mdl"
SWEP.WorldModel				= "models/bf4weap/w_rif_bak5c.mdl"
SWEP.Base 				    = "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("bf4weap/ak5c/shoot.wav")
SWEP.Primary.Round			= ("gdcwa_5.56x45_tracer")
SWEP.Primary.RPM			= 700						// This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 30						// Size of a clip
SWEP.Primary.DefaultClip		= 124
SWEP.Primary.ConeSpray			= 2					// Hip fire accuracy
SWEP.Primary.ConeIncrement		= 0.091					// Rate of innacuracy
SWEP.Primary.ConeMax			= 2.5					// Maximum Innacuracy
SWEP.Primary.ConeDecrement		= 15					// Rate of accuracy
SWEP.Primary.KickUp			= .4				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= .1			-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal			= .2		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= 						true// Automatic/Semi Auto
SWEP.Primary.Ammo			= "smg1"

SWEP.Secondary.ClipSize			= 1						// Size of a clip
SWEP.Secondary.DefaultClip		= 1						// Default number of bullets in a clip
SWEP.Secondary.Automatic		= false						// Automatic/Semi Auto
SWEP.Secondary.Ammo			= ""
SWEP.Secondary.IronFOV			= 50						// How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}						// The starting firemode
SWEP.data.ironsights			= 1

SWEP.IronSightsPos = Vector(-1.672, -5.2, -0.132)
SWEP.IronSightsAng = Vector(4.25, 0, 0)

SWEP.SightsPos = Vector(-1.672, -5.2, -0.132)
SWEP.SightsAng = Vector(4.25, 0, 0)

SWEP.RunSightsPos = Vector(2.813, -2.01, -2.211)
SWEP.RunSightsAng = Vector(-10.554, 70, -24.623)

SWEP.SelectiveFire = true
SWEP.DisableBurstFire = true

SWEP.Primary.SpreadMultiplierMax = 7
SWEP.Primary.SpreadIncrement = 1
SWEP.Primary.SpreadRecovery = 6

SWEP.HoldType 				= "ar2"		-- This is how others view you carrying the weapon.


--Crotch Gun Fix
SWEP.Offset = {
Pos = {
Up = 0.1,
Right = 1,
Forward = -0.5,
},
Ang = {
Up = 2,
Right = -5,
Forward = 180,
}
}




