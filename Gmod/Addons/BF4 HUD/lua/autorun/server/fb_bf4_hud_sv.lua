

function BF4Spawn()
	for k, ply in pairs(player.GetAll()) do
		ply:SetNetworkedNumber("FBKills",-1)
		ply:SetNetworkedNumber("FBDeaths",-1)		
	end
end
hook.Add( "PlayerInitialSpawn", "BF4Spawn", BF4Spawn )

function BF4NPCDie(NPC,attacker)
	NPC:SetNWBool("FB_ISDEAD", true)
	if attacker:IsPlayer() then 
		attacker:SetNetworkedNumber("FBKills",attacker:GetNWInt("FBKills") + 1)
	end
end
hook.Add("OnNPCKilled","BF4NPCDie",BF4NPCDie)

function BF4KillCountPlayer(ply, attacker, dmginfo) -- Kill count stuff for players 
	ply:SetNetworkedNumber("FBDeaths",ply:GetNWInt("FBDeaths") + 1)
	if attacker:IsPlayer() and ply != attacker then
		attacker:SetNetworkedNumber("FBKills",attacker:GetNWInt("FBKills") + 1)

	end
end
hook.Add("DoPlayerDeath","BF4KillCountPlayer",BF4KillCountPlayer)




