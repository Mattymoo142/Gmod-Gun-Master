
SWEP.Category				= "TFA BF4"
SWEP.Author				    = "TFA"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions			= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment		= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.DrawCrosshair			= true		-- Set false if you want no crosshair from hip

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_rif_asval.mdl"
SWEP.WorldModel				= "models/weapons/w_rif_asval.mdl"
SWEP.Base 				    = "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("weapons/asval/fire.wav")
SWEP.Primary.Round			= ("gdcwa_9x39_sp6")
SWEP.Primary.RPM			= 900						// This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 20						// Size of a clip
SWEP.Primary.DefaultClip		= 84
SWEP.Primary.ConeSpray			= 1					// Hip fire accuracy
SWEP.Primary.ConeIncrement		= 0.13					// Rate of innacuracy
SWEP.Primary.ConeMax			= 1.5					// Maximum Innacuracy
SWEP.Primary.ConeDecrement		= 15					// Rate of accuracy
SWEP.Primary.KickUp			= 0.25					// Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.25					// Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.4					// Maximum up recoil (stock)
SWEP.Primary.Automatic			= 						true// Automatic/Semi Auto
SWEP.Primary.Ammo			= "pistol"

SWEP.Secondary.ClipSize			= 1						// Size of a clip
SWEP.Secondary.DefaultClip		= 1						// Default number of bullets in a clip
SWEP.Secondary.Automatic		= false						// Automatic/Semi Auto
SWEP.Secondary.Ammo			= ""
SWEP.Secondary.IronFOV			= 50						// How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}						// The starting firemode
SWEP.data.ironsights			= 1

SWEP.IronSightsPos = Vector(1.787, -6.77, -0.371)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.SightsPos = Vector (1.787, -6.77, -0.371)
SWEP.SightsAng = Vector (0, 0, 0)
SWEP.RunSightsPos = Vector (-4.824, -2.613, -3.12)
SWEP.RunSightsAng = Vector (0, -61.207, 7.738)

SWEP.SelectiveFire = true
SWEP.DisableBurstFire = true
SWEP.MuzzleFlashEffect = "tfa_muzzleflash_silenced" --Change to a string of your muzzle flash effect
SWEP.Silenced = true

SWEP.Primary.SpreadMultiplierMax = 6
SWEP.Primary.SpreadIncrement = 0.8
SWEP.Primary.SpreadRecovery = 4.4

SWEP.HoldType 				= "ar2"		-- This is how others view you carrying the weapon.

--Crotch Gun Fix

SWEP.Offset = {
Pos = {
Up = 1,
Right = 1,
Forward = 0,
},
Ang = {
Up = 2,
Right = -8,
Forward = 180,
}
}




