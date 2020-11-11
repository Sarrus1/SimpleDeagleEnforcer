#include <sourcemod>
#include <sdkhooks>
#include <sdktools>
#pragma newdecls required

public Plugin myinfo =
{
	name = "",
	author = "Sarrus",
	description = "",
	version = "1.0",
	url = "https://github.com/Sarrus1/"
};

public void OnPluginStart()
{
    HookEvent("player_spawn", OnPlayerSpawn, EventHookMode_Post);
}


public Action OnPlayerSpawn(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	StripAllWeapons(client);
	RequestFrame(SetWeapons, client);
}

public void SetWeapons(int client) 
{ 
    if(IsValidClient(client) && IsPlayerAlive(client)) 
    { 
        if (GetPlayerWeaponSlot(client, 1) != -1)
            GivePlayerItem(client, "weapon_deagle");
        if (GetClientTeam(client) == 2)
            GivePlayerItem(client, "weapon_knife_t");
        else
            GivePlayerItem(client, "weapon_knife");
    }
    return;
} 


stock void StripAllWeapons(int client) 
{
	if (!IsValidClient(client, false))
		return;

	int weapon;
	for (int i; i < 4; i++) {

		if ((weapon = GetPlayerWeaponSlot(client, i)) != -1) {

			if (IsValidEntity(weapon)) {

				RemovePlayerItem(client, weapon);
				AcceptEntityInput(weapon, "Kill");
			}
		}
	}
}

stock bool IsValidClient(int client, bool noBots=true) 
{
	if (client < 1 || client > MaxClients)
		return false;

	if (!IsClientInGame(client))
		return false;

	if (!IsClientConnected(client))
		return false;

	if (noBots)
		if (IsFakeClient(client))
			return false;

	if (IsClientSourceTV(client))
		return false;

	return true;

}