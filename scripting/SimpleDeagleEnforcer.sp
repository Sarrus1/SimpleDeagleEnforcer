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
    int userid, client;
    userid = event.GetInt("userid");
    client = GetClientOfUserId(userid);
    if (GetPlayerWeaponSlot(client, 1) != -1)
        GivePlayerItem(client, "weapon_deagle");
    if (GetPlayerWeaponSlot(client, 1) != -1)
    {
        if (GetClientTeam(client) == 2)
            GivePlayerItem(client, "weapon_knife_t");
        else
            GivePlayerItem(client, "weapon_knife");
    }
    return Plugin_Handled;
}