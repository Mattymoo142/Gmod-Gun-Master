
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
SWEP.ViewModel				= "models/weapons/v_rif_aek97.mdl"
SWEP.WorldModel				= "models/weapons/w_rif_aek97.mdl"
SWEP.Base 				    = "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("weapons/aek/fire.wav")
SWEP.Primary.Round			= ("gdcwa_5.45x39_ap")
SWEP.Primary.RPM			= 900						// This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 30						// Size of a clip
SWEP.Primary.DefaultClip		= 124
SWEP.Primary.ConeSpray			= 3					// Hip fire accuracy
SWEP.Primary.ConeIncrement		= 0.117					// Rate of innacuracy
SWEP.Primary.ConeMax			= 3.5					// Maximum Innacuracy
SWEP.Primary.ConeDecrement		= 15					// Rate of accuracy
SWEP.Primary.KickUp			= 0.8					// Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0					// Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.3					// Maximum up recoil (stock)
SWEP.Primary.Automatic			= 						true// Automatic/Semi Auto
SWEP.Primary.Ammo			= "smg1"

SWEP.Secondary.ClipSize			= 1						// Size of a clip
SWEP.Secondary.DefaultClip		= 1						// Default number of bullets in a clip
SWEP.Secondary.Automatic		= false						// Automatic/Semi Auto
SWEP.Secondary.Ammo			= ""
SWEP.Secondary.IronFOV			= 75						// How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}						// The starting firemode
SWEP.data.ironsights			= 1

SWEP.IronSightsPos = Vector(-2.721, -8.844, 0.4)
SWEP.IronSightsAng = Vector(0.2, 0.652, 0)
SWEP.SightsPos = Vector(-2.721, -8.844, 0.4)
SWEP.SightsAng = Vector(0.2, 0.652, 0)
SWEP.RunSightsPos = Vector(1.809, -2.211, 0)
SWEP.RunSightsAng = Vector(-12.664, 53.466, -1.407)

SWEP.SelectiveFire = true

SWEP.Primary.SpreadMultiplierMax = 5
SWEP.Primary.SpreadIncrement = 1
SWEP.Primary.SpreadRecovery = 5

SWEP.HoldType 				= "ar2"		-- This is how others view you carrying the weapon.

--Crotch Gun Fix
SWEP.Offset = {
Pos = {
Up = 0.7,
Right = 1,
Forward = 0,
},
Ang = {
Up = 0,
Right = -5,
Forward = 180,
}
}




