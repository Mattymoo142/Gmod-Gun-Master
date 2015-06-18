
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
SWEP.ViewModel				= "models/weapons/v_rif_ak12.mdl"
SWEP.WorldModel				= "models/weapons/w_rif_ak12.mdl"
SWEP.Base 				    = "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("weapons/ak12/fire.wav")
SWEP.Primary.Round			= ("gdcwa_5.45x39_ap")
SWEP.Primary.RPM			= 650						// This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 30						// Size of a clip
SWEP.Primary.DefaultClip		= 217
SWEP.Primary.ConeSpray			= 3					// Hip fire accuracy
SWEP.Primary.ConeIncrement		= 0.085					// Rate of innacuracy
SWEP.Primary.ConeMax			= 3.5					// Maximum Innacuracy
SWEP.Primary.ConeDecrement		= 15					// Rate of accuracy
SWEP.Primary.KickUp			= .55				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= .45			-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal			= .15		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= 						true// Automatic/Semi Auto
SWEP.Primary.Ammo			= "smg1"

SWEP.Secondary.ClipSize			= 1						// Size of a clip
SWEP.Secondary.DefaultClip		= 1						// Default number of bullets in a clip
SWEP.Secondary.Automatic		= false						// Automatic/Semi Auto
SWEP.Secondary.Ammo			= ""
SWEP.Secondary.IronFOV			= 50						// How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}						// The starting firemode
SWEP.data.ironsights			= 1

SWEP.IronSightsPos = Vector(-3.381, -4.422, 0.72)
SWEP.IronSightsAng = Vector(0, 0.05, 0)
SWEP.SightsPos = Vector (-3.381, -4.422, 0.72)
SWEP.SightsAng = Vector (0, 0.05, 0)
SWEP.RunSightsPos = Vector (1.48, -8.04, -5.72)
SWEP.RunSightsAng = Vector (-4.222, 56.28, -32.362)

SWEP.SelectiveFire = true

SWEP.Primary.SpreadMultiplierMax = 6
SWEP.Primary.SpreadIncrement = 0.9
SWEP.Primary.SpreadRecovery = 4

SWEP.HoldType 				= "ar2"		-- This is how others view you carrying the weapon.


--Crotch Gun Fix
SWEP.Offset = {
Pos = {
Up = 0.7,
Right = 1,
Forward = 3,
},
Ang = {
Up = 0,
Right = -5,
Forward = 180,
}
}




