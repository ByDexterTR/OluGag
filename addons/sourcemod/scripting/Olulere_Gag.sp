#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = 
{
	name = "Ölü oyuncuları gaglama", 
	author = "ByDexter", 
	description = "", 
	version = "1.0", 
	url = "https://steamcommunity.com/id/ByDexterTR - ByDexter#5494"
};

bool OluGag = false;

public void OnPluginStart()
{
	RegAdminCmd("sm_ogag", Command_Otogag, ADMFLAG_CHAT);
	AddCommandListener(Command_Say);
}

public Action Command_Say(int client, const char[] command, int argc)
{
	if (StrContains(command, "say", false) != -1 && OluGag && IsValidClient(client) && !IsPlayerAlive(client))
	{
		PrintToChat(client, "[SM] \x01Sohbet ölü oyunculara \x07kapalı!");
		return Plugin_Stop;
	}
	return Plugin_Continue;
}

public Action Command_Otogag(int client, int args)
{
	OluGag = !OluGag;
	PrintToChat(client, "[SM] \x10%N \x01%s", client, OluGag ? "tarafından ölülerin sohbeti \x07kapatıldı!":"tarafından ölülerin sohbeti \x04açıldı!");
	return Plugin_Handled;
}

bool IsValidClient(int client, bool nobots = true)
{
	if (client <= 0 || client > MaxClients || !IsClientConnected(client) || (nobots && IsFakeClient(client)))
	{
		return false;
	}
	return IsClientInGame(client);
} 