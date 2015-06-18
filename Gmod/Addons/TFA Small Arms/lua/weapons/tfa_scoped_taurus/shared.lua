-- Variables that are used on both client and server
SWEP.Gun = ("tfa_scoped_taurus") -- must be the name of your swep but NO CAPITALS!
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "tfa_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Category				= "TFA Pistols"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "Raging Bull - Scoped"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 1				-- Slot in the weapon selection menu
SWEP.SlotPos				= 32			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- Set false if you want no crosshair from hip
SWEP.Weight				= 30			-- Rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.XHair					= true		-- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.BoltAction				= false		-- Is this a bolt action rifle?
SWEP.HoldType 				= "revolver"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 65
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/tfa_v_raging_bull_scoped.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/tfa_w_raging_bull_scoped.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= true
SWEP.Base 				= "tfa_scoped_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("weapon_r_bull.single")		-- script that calls the primary fire sound
SWEP.Primary.RPM				= 115		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 6		-- Size of a clip
SWEP.Primary.DefaultClip			= 30	-- Bullets you start with
SWEP.Primary.KickUp			= 10				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= .5			-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal			= 1		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "357"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.ScopeZoom			= 3
SWEP.Secondary.UseACOG			= false -- Choose one scope type
SWEP.Secondary.UseMilDot		= true	-- I mean it, only one	
SWEP.Secondary.UseSVD			= false	-- If you choose more than one, your scope will not show up at all
SWEP.Secondary.UseParabolic		= false	
SWEP.Secondary.UseElcan			= false
SWEP.Secondary.UseGreenDuplex	= false	
SWEP.Secondary.UseAimpoint		= false

SWEP.data 				= {}
SWEP.data.ironsights			= 1
SWEP.ScopeScale 			= 0.7
SWEP.ReticleScale 				= 0.6

SWEP.Primary.Damage		= 31	--base damage per bullet
SWEP.Primary.Spread		= .02	--define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .0001 -- ironsight accuracy, should be the same for shotguns

-- enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(2.775, -4.02, 0.059)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.SightsPos = Vector(2.775, -4.02, 0.059)
SWEP.SightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(0, 2.95, 0)
SWEP.RunSightsAng = Vector(-13.197, 5.737, 0)

if GetConVar("sv_tfa_default_clip") == nil then
	print("sv_tfa_default_clip is missing!  You might've hit the lua limit.  Contact the SWEP author(s).")
else
	if GetConVar("sv_tfa_default_clip"):GetInt() != -1 then
		SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * GetConVar("sv_tfa_default_clip"):GetInt()
	end
end

if GetConVar("sv_tfa_unique_slots") != nil then
	if not (GetConVar("sv_tfa_unique_slots"):GetBool()) then 
		SWEP.SlotPos = 2
	end
end