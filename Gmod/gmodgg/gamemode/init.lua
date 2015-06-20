--//Include Files
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include('shared.lua')
--//WEAPON LISTS--\\

--//For valid weapon names go into addons - WEAPON PACK NAME - lua - weapons - Then all of the names for the weapons are there.
--//All that needs editing are the names of the weapons below, you are also welcome to add more lists, they can now be any length you want.
--//If you would like to have a list beneath the newly added one, add a comma at the end bracket and paste the next list below, and at the last weapon, remove the comma at the end of the line.
--//If you require any help with this, please email me at: mattymoo142@gmail.com

--//Please Note: All weapons in the tables below must require ammo, as there is code to give ammo and if it doesnt need ammo it will just return a Nil value error.

WepList = {
    {
        --//LIST 1\\--
        'tfa_luger',
        'tfa_deagle',
        'tfa_ragingbull',
        'tfa_glock',
        'tfa_colt1911',
        'tfa_hk45',
        'tfa_sig_p229r',
        'tfa_mp5',
        'tfa_bizonp19',
        'tfa_kac_pdw',
        'tfa_magpulpdr',
        'tfa_mp5sd',
        'tfa_honeybadger',
        'tfa_mp9',
        'tfa_bf4_ak5c',
        'tfa_bf4_asval',
        'tfa_bf4_aek971',
        'tfa_bf4_ak12',
        'tfa_vector',
        'tfa_bf4_338',
        'tfa_mp7',
        'm9k_dragunov',
        'm9k_intervention',
        'm9k_m24',
        'm9k_m98b',
        'm9k_barret_m82',
        'm9k_aw50',
        'm9k_sl8',
        'm9k_svt40',
        'm9k_svu',
        'm9k_spas12',
        'm9k_usas',
        'm9k_remington870',
        'm9k_remington7615p',
        'm9k_contender',
        'm9k_m249lmg',
        'm9k_pkm',
        'm9k_dbarrel',
        'm9k_1887winchester',
        'm9k_ares_shrike',
        'NAME ANYTHING'
    },
    {
        --//LIST 2\\--
        'tfa_luger',
        'tfa_deagle',
        'tfa_ragingbull',
        'NAME ANYTHING'
    }
}

--// Disable 'Kill' Command

local function BlockSuicide(p1)
    p1:ChatPrint("You Are Not Allowed To Use The Console Command 'Kill' It Causes The Player To No Longer Have A Weapon At Spawn.")
    return false
end

hook.Add("CanPlayerSuicide", "BlockSuicide", BlockSuicide)

--//Set Model

function GM:PlayerSetModel(ply)
    ply:SetModel("models/player/arctic.mdl")
end

--//Picks table
if (SERVER) then
    WeaponList = WepList[math.random(1, #WepList)]
end

--//Player Kill And level Up

function GM:PlayerDeath(victim, inflictor, attacker)

    victim:ShouldDropWeapon(false)
    attacker:ShouldDropWeapon(false)
    if (victim == attacker) then --//If player committed suicide
    PrintMessage(HUD_PRINTTALK, "=================================================")
    PrintMessage(HUD_PRINTTALK, attacker:Name() .. " Committed suicide!")
    PrintMessage(HUD_PRINTTALK, "=================================================")
    attacker:StripWeapon(WeaponList[attacker:GetNWFloat('level', 1)])
    else --//If above returns false, attacker gets kill
    PrintMessage(HUD_PRINTTALK, "=================================================")
    PrintMessage(HUD_PRINTTALK, attacker:Name() .. " Killed " .. victim:Name() .. "!")
    PrintMessage(HUD_PRINTTALK, "=================================================")
    attacker:StripWeapon(WeaponList[attacker:GetNWFloat('level', 1)])
    attacker:Give(WeaponList[attacker:GetNWFloat('level', 1) + 1])
    attacker:GiveAmmo(999, weapons.Get(WeaponList[attacker:GetNWFloat('level', 1)]).Primary.Ammo)
    attacker:SetNWFloat('level', attacker:GetNWFloat('level', 1) + 1)
    --attacker:GivePoints(30, "Nice Kill!") --//If using pointshop, remove the --
    end


    if (attacker:GetNWFloat('level', 1) == #WeaponList) then
        PrintMessage(HUD_PRINTTALK, "=================================================")
        PrintMessage(HUD_PRINTTALK, attacker:Name() .. " Has won! ")
        PrintMessage(HUD_PRINTTALK, "=================================================")
        WeaponList = WepList[math.random(1, #WepList)]
        --attacker:GivePoints(60, "You Won!") --//If using pointshop, remove the --
        for k, v in pairs(player.GetAll()) do
            v:StripWeapons()
            v:RemoveAllAmmo()
            v:SetNWFloat('level', 1)
            v:Spawn()
            victim:ShouldDropWeapon(false)
            attacker:ShouldDropWeapon(false)
        end
    end
end



--//Player spawn - Gives correct weapon on spawn
function GM:PlayerSpawn(p2)
    p2:GiveAmmo(999, "AR2")
    p2:GiveAmmo(999, "Pistol")
    p2:GiveAmmo(999, "SMG1")
    p2:GiveAmmo(999, "357")
    p2:GiveAmmo(999, "Buckshot")
    p2:GiveAmmo(999, "SniperPenetratedRound")
    level = p2:GetNWFloat('level', 1) --//Defines Level
    p2:SetNWFloat('level', level) --//Sets level
    p2:Give(WeaponList[p2:GetNWFloat('level', 1)])
    p2:GiveAmmo(999, weapons.Get(WeaponList[p2:GetNWFloat('level', 1)]).Primary.Ammo)
    self.BaseClass:PlayerSpawn(p2)
    p2:SetGravity(1, 900)
    p2:SetMaxHealth(100, true)
    p2:SetWalkSpeed(165)
    p2:SetRunSpeed(355)
end

--//Anti-NoClip
local function DisableNoclip(ply)
    return ply:IsAdmin()
end

hook.Add("PlayerNoClip", "DisableNoclip", DisableNoclip)
 
