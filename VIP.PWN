/*
|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
|    #Create By: - JoeShk                                 |
|    #Version: - 0.1(Beta)                                |
|    #HQ By: - Nobody                                     |
|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|

*/
#include "a_samp.inc"
#tryinclude "dini.inc"
#tryinclude "cpstream"
#pragma dynamic 14500
#define anatext(%1,%2,%3) %1[%2] == %3 // JoeShk
#define COLOR_WHITE 0xFFFFFFAA
#define red 0xFF0000AA
#define COLOR_ORANGE 0xFF9900AA
#define VIPColor sgba2hex(dini_Int("/VIP/Details.txt", "C1"),dini_Int("/VIP/Details.txt", "C2"),dini_Int("/VIP/Details.txt", "C3"),100)
new VIPBank = -1;
public OnFilterScriptInit()
{
  if(!dini_Exists("/VIP/Details.txt")) dini_Create("/VIP/Details.txt");
  if(!dini_Exists("/VIP/Main.txt"))
  {
      dini_Create("/VIP/Main.txt");
      dini_IntSet("/VIP/Main.txt", "Total", 0);
      dini_FloatSet("/VIP/Main.txt", "B1", 0.0);
      dini_FloatSet("/VIP/Main.txt", "B2", 0.0);
      dini_FloatSet("/VIP/Main.txt", "B3", 0.0);
      dini_FloatSet("/VIP/Main.txt", "x1", 0.0);
      dini_FloatSet("/VIP/Main.txt", "y1", 0.0);
      dini_FloatSet("/VIP/Main.txt", "x2", 0.0);
      dini_FloatSet("/VIP/Main.txt", "y2", 0.0);
  }
  if(!dini_Exists("/VIP/Stats.txt"))
  {
      dini_Create("/VIP/Stats.txt");
      dini_IntSet("/VIP/Stats.txt", "Kills", 0);
      dini_IntSet("/VIP/Stats.txt", "Bank", 0);
  }
  if(dini_Float("/VIP/Main.txt", "B1") != 0.0 && dini_Float("/VIP/Main.txt", "B2") != 0.0 && dini_Float("/VIP/Main.txt", "B3") != 0.0) VIPBank = CPS_AddCheckpoint(dini_Float("/VIP/Main.txt", "B1"),dini_Float("/VIP/Main.txt", "B2"),dini_Float("/VIP/Main.txt", "B3"), 2.5, 20);
  return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
   new cmd[256], idx, string[128];
   cmd = strtok(cmdtext, idx);
   if(!strcmp(cmd, "/vdeposit", true))
   {
	  new tmpvip[256];
	  tmpvip = strtok(cmdtext, idx);
	  #define vcp tmpvip
	  if(!isPlayerVIP(playerid)) return SendClientMessage(playerid, COLOR_WHITE, ".VIP ���� ���");
	  if(!CPS_IsPlayerInCheckpoint(playerid, VIPBank)) return SendClientMessage(playerid, red, " � (VIP) ��� ���� ����� ���� �� ������� ���");
	  if(!strlen(tmpvip)) return SendClientMessage(playerid, COLOR_WHITE,"Usage: /vdeposit [amount]");
	  if(GetPlayerMoney(playerid) < strval(tmpvip)) return SendClientMessage(playerid, COLOR_WHITE, GetPlayerMoney(playerid) < 1? (".��� �� ��� ����") : (".��� �� �� ����� ������"));
	  format(string,sizeof string," � !%d$ - ���� �� � (VIP) ����� ������ ������� %s - �����", strval(tmpvip), GetName(playerid));
	  SendVIPMessageToAll(VIPColor, string);
	  format(string,sizeof string," � !%d$ - ����� ����� ��� ���� �� �", dini_Int(VIPFile(playerid),"Bank")+strval(tmpvip));
	  SendVIPMessageToAll(COLOR_ORANGE, string);
	  GivePlayerMoney(playerid, -strval(tmpvip));
	  dini_IntSet(VIPFile(playerid), "Bank", dini_Int(VIPFile(playerid),"Bank")+strval(tmpvip));
	  dini_IntSet("/VIP/Stats.txt", "Bank", dini_Int("/VIP/Stats.txt", "Bank")+strval(tmpvip));
	  return 1;
   }
   if(!strcmp(cmd, "/vwithdraw", true))
   {
	  new tmpvip[256];
	  tmpvip = strtok(cmdtext, idx);
	  #define vcp tmpvip
	  if(!isPlayerVIP(playerid)) return SendClientMessage(playerid, COLOR_WHITE, ".VIP ���� ���");
	  if(!CPS_IsPlayerInCheckpoint(playerid, VIPBank)) return SendClientMessage(playerid, red, " � (VIP) ��� ���� ����� ���� �� ������� ���");
	  if(!strlen(tmpvip)) return SendClientMessage(playerid, COLOR_WHITE,"Usage: /vwithdraw [amount]");
	  if(dini_Int(VIPFile(playerid),"Bank") < strval(tmpvip)) return SendClientMessage(playerid, COLOR_WHITE, dini_Int(VIPFile(playerid),"Bank") < strval(tmpvip)? (".VIP - ��� �� ���� ����� ����� ���� �� ��� ���� �") : (".VIP - ��� �� ���� ����� ��� ������ �"));
	  format(string,sizeof string," � !%d$ - ���� �� � (VIP) ��� ������ ������ � %s - �����", strval(tmpvip), GetName(playerid));
	  SendVIPMessageToAll(VIPColor, string);
	  format(string,sizeof string," � !%d$ - ����� ����� ��� ���� �� �", dini_Int(VIPFile(playerid),"Bank")-strval(tmpvip));
	  SendVIPMessageToAll(COLOR_ORANGE, string);
	  GivePlayerMoney(playerid, strval(tmpvip));
	  dini_IntSet(VIPFile(playerid), "Bank", dini_Int(VIPFile(playerid),"Bank")-strval(tmpvip));
	  dini_IntSet("/VIP/Stats.txt", "Bank", dini_Int("/VIP/Stats.txt", "Bank")-strval(tmpvip));
	  return 1;
   }
   if(!strcmp(cmd, "/vips", true)) return showVIPMemmbers(playerid);
   if(!strcmp(cmd, "/vip", true))
   {
	  new tmpvip[256], vpfile[128];
	  tmpvip = strtok(cmdtext, idx);
	  #define vcp tmpvip
	  if(!strlen(tmpvip))
	  {
		  SendClientMessage(playerid,COLOR_WHITE,"--- VIP - ���''�� ---");
		  SendClientMessage(playerid,0x16EB43FF,"[01] � /VIP HQ - ����� ������");
		  SendClientMessage(playerid,0x16EB43FF,"[02] � /VIP [Leave/Quit] - �� ��� ����� �� ������");
		  SendClientMessage(playerid,0x16EB43FF,"[03] � /VIP [Tag/Color] - ����� / ������ �� ���� / ���� ������ �� �������");
		  SendClientMessage(playerid,0x16EB43FF,"[04] � /VIP Info [Details/Stats/Online] - ������ ������");
		  SendClientMessage(playerid,0x16EB43FF,"[05] � /VIP CMDS - VIP ������ ������� ������");
		  SendClientMessage(playerid,0x16EB43FF,"[06] � /VIP Memmbers (/VIPS) :�� ��� ����� �� ����� ���''�� �� ����");
		  SendClientMessage(playerid,0x16EB43FF,"[07] � '$' :�'�� VIP�� ��� ���� �");
		  if(IsPlayerAdmin(playerid))
		  {
		      SendClientMessage(playerid,red,"*[A01] � /VIP Remove [player name] - ������ �����");
		      SendClientMessage(playerid,red,"*[A02] � /VIP Create [player name] - VIP ����� ������ �����");
		      SendClientMessage(playerid,red,"*[A03] � /VIP SetColor [red 1-255] [green 1-255] [blue 1-255] - VIP �� ��� ����� �� ���� �� �");
		      SendClientMessage(playerid,red,"*[A04] � /VIP SetBank - �� ��� ����� �� ������ �� ����");
		      SendClientMessage(playerid,red,"*[A05] � /VIP SetArea [1-2] - ����� �� ������ �� ����� �����, �� ���� �� �� ������");
		  }
		  return 1;
	  }
	  if(!strcmp(vcp,"setarea", true) && IsPlayerAdmin(playerid))
	  {
		 new tmpvip2[256], Float:pos[3], i = 0;
		 tmpvip2 = strtok(cmdtext, idx);
		 GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		 if(!strlen(tmpvip2)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /vip setarea [1-2] (1 = x1 + y1 | 2 = x2 + y2)");
		 if(strval(tmpvip2) < 1 && strval(tmpvip2) > 2) return SendClientMessage(playerid, COLOR_WHITE, ".���� ����� ����");
		 while(i < 2)
		 {
			 format(string,sizeof string,!i? ("x%i") : ("y%i"), strval(tmpvip2));
			 dini_FloatSet("/VIP/Main.txt", string, !i? pos[0] : pos[1]);
			 i++;
		 }
		 SendClientMessage(playerid, COLOR_ORANGE,strval(tmpvip2) == 2? ("!������ x2 + y2 ���� �� ��������") : ("!������ x1 + y1 ���� �� ��������"));
		 return 1;
	  }
	  if(!strcmp(vcp, "create", true) && IsPlayerAdmin(playerid))
	  {
		  new tmpvip2[256], id = -1;
		  tmpvip2 = strtok(cmdtext, idx);
		  format(string,sizeof string,"/Mode/Users/%s.ini",tmpvip2);
		  format(vpfile, sizeof vpfile,"/VIP/%s.ini", tmpvip2);
		  if(dini_Exists(vpfile)) return SendClientMessage(playerid, red, ".���� ��� ����� ���");
		  if(!strlen(tmpvip2)) return SendClientMessage(playerid,COLOR_WHITE,"Usage: /VIP Create [name]");
		  id = GetPlayerID(tmpvip2);
		  dini_IntSet("/VIP/Main.txt", "Total", dini_Int("/VIP/Main.txt", "Total")+1);
		  dini_Create(vpfile);
		  dini_IntSet(vpfile, "Level", 1);
		  dini_IntSet(vpfile, "Color", 0);
		  dini_IntSet(vpfile, "Tag", 1);
		  dini_IntSet(vpfile, "Bank", 0);
		  dini_IntSet(vpfile, "ivc", dini_Int("/VIP/Main.txt", "Total"));
		  format(string, sizeof string,"VIP%i", dini_Int("/VIP/Main.txt", "Total"));
		  dini_Set("/VIP/Main.txt", string, tmpvip2);
		  SendClientMessage(playerid, COLOR_ORANGE,id != playerid? ("� !VIP - ���� ����� �� ����� ������� �") : ("� !VIP - ����� �� ���� ������� �"));
		  return (id != -1 && !IsPlayerAdmin(id) && id != playerid)? SendClientMessage(id, COLOR_ORANGE,"/VIP :����� ���� VIP - ������ ���� ���� ������� �") : 1;
	  }
	  if(!strcmp(vcp, "remove", true) && IsPlayerAdmin(playerid))
	  {
		  new tmpvip2[256], id = -1;
		  tmpvip2 = strtok(cmdtext, idx);
		  format(string,sizeof string,"/Mode/Users/%s.ini",tmpvip2);
          format(vpfile, sizeof vpfile,"/VIP/%s.ini", tmpvip2);
		  if(!(dini_Exists(string) || dini_Exists(vpfile))) return SendClientMessage(playerid, red, !dini_Exists(string)? (".�� ���� ����� ��� ���") : (".VIP - ���� �� �� ���"));
		  if(!strlen(tmpvip2)) return SendClientMessage(playerid,COLOR_WHITE,"Usage: /VIP Remove [name]");
		  id = GetPlayerID(tmpvip2);
		  format(string, sizeof string, "VIP%i", dini_Int(vpfile, "ivc"));
		  dini_Set("/VIP/Main.txt", string, "None");
		  dini_Remove(vpfile);
		  dini_IntSet("/VIP/Main.txt", "Total", dini_Int("/VIP/Main.txt", "Total")-1);
		  SendClientMessage(playerid, COLOR_ORANGE,id != playerid? ("� !VIP - ����� ������ �� ���� �� ������� �") : ("� !VIP - ����� �� ���� ������� �"));
		  return (id != -1 && !IsPlayerAdmin(id))? SendClientMessage(id, COLOR_ORANGE,"� Satla-Zone.co.il - �� ��� ������� ������� ��� ����� �� ��� ������ !VIP - ������ ����� ���� ������� �") : 1;
	  }
	  if(!strcmp(vcp,"setbank", true) && IsPlayerAdmin(playerid))
	  {
		  new Float:pos[3];
		  GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		  for(new i = 0; i < 3; i++)
		  {
			   format(string, sizeof string,"B%i", i+1);
			   dini_FloatSet("/VIP/Main.txt", string, pos[i]);
		  }
		  CPS_RemoveCheckpoint(VIPBank);
		  VIPBank = CPS_AddCheckpoint(dini_Float("/VIP/Main.txt", "B1"),dini_Float("/VIP/Main.txt", "B2"),dini_Float("/VIP/Main.txt", "B3"), 2.5, 20);
		  SendClientMessage(playerid, VIPColor, " � !VIP - ���� �� ������ �� ���� �� ����� �");
		  return 1;
	  }
	  if(!strcmp(vcp, "setcolor", true) && IsPlayerAdmin(playerid))
	  {
		  new CC[3][256];
		  for(new d = 0; d < sizeof CC; d++) CC[d] = strtok(cmdtext, idx);
		  if(!strlen(CC[0]) || !strlen(CC[1]) || !strlen(CC[2])) return SendClientMessage(playerid,COLOR_WHITE,"Usage: /VIP SetColor [red-1-255] [green-1-255] [blue-1-255]");
		  if(!strval(CC[0]) || strval(CC[0]) > 255 || !strval(CC[1]) || strval(CC[1]) > 255 || !strval(CC[2]) || strval(CC[2]) > 255) return SendClientMessage(playerid,COLOR_WHITE,".��� ���� ���� �� ��� ���� �������� 1-255");
		  for(new i = 0; i < sizeof CC; i++)
		  {
			   format(string, sizeof string, "C%i", i+1);
               dini_IntSet("/VIP/Details.txt", string, strval(CC[i]));
		  }
		  SendClientMessage(playerid, sgba2hex(strval(CC[0]), strval(CC[1]), strval(CC[2]), 200), " � .������ ���� ���� �� ����� �� VIP - ���� �� �");
		  return 1;
      }
      if(!strcmp(vcp, "color", true))
      {
         if(!isPlayerVIP(playerid)) return SendClientMessage(playerid, COLOR_WHITE, ".VIP ���� ���");
         dini_IntSet(VIPFile(playerid),"Color", !dini_Int(VIPFile(playerid),"Color")? 1 : 0);
         SendClientMessage(playerid,VIPColor, dini_Int(VIPFile(playerid),"Color")? (" � !VIP - ����� �� ���� ������ �� ������ �") : (" � !VIP - ���� �� ���� ������ �� ������ �"));
         SetPlayerColor(playerid, dini_Int(VIPFile(playerid),"Color")? VIPColor : sgba2hex(random(256), random(256), random(256), 100));
		 return 1;
	  }
      if(!strcmp(vcp, "tag", true))
      {
         if(!isPlayerVIP(playerid)) return SendClientMessage(playerid, COLOR_WHITE, ".VIP ���� ���");
         dini_IntSet(VIPFile(playerid),"Tag", !dini_Int(VIPFile(playerid),"Tag")? 1 : 0);
         SendClientMessage(playerid,VIPColor, dini_Int(VIPFile(playerid),"Tag")? (" � !VIP - ����� �� ���� ������ �� ������ �") : (" � !VIP - ���� �� ���� ������ �� ������ �"));
		 return 1;
	  }
	  if(!strcmp(vcp, "info", true))
	  {
		 new vtmp[256];
		 vtmp = strtok(cmdtext, idx);
		 if(!strlen(vtmp))
		 {
		     SendClientMessage(playerid,COLOR_WHITE,"--- VIP - ���''�� ---");
			 SendClientMessage(playerid,0x16EB43FF,"[01] � /VIP Info Details - VIP ���� �� �");
			 SendClientMessage(playerid,0x16EB43FF,"[02] � /VIP Info Stats - VIP ���� �� �");
			 SendClientMessage(playerid,0x16EB43FF,"[03] � /VIP Info Online - ���� ����� ������ �������");
		     return 1;
		 }
		 if(!strcmp(vtmp,"memmbers", true)) return showVIPMemmbers(playerid);
		 if(!strcmp(vtmp, "online", true))
		 {
			 new vicount = 0;
			 if(!getOnlineVIP()) return SendClientMessage(playerid, COLOR_WHITE, !dini_Exists("/VIP/Main.txt") || !dini_Int("/VIP/Main.txt", "Total")? (".������ ���� VIP ��� ����") : (".������� ���� VIP ��� ����"));
			 format(string, sizeof string, "-------- [ %i - ����� ���''�� ������� ] --------", getOnlineVIP());
			 SendClientMessage(playerid, COLOR_WHITE, string);
			 for(new i = 0; i < MAX_PLAYERS; i++)
			 {
			      if(isPlayerVIP(i) && IsPlayerConnected(i))
			      {
					   vicount++;
					   format(string, sizeof string, " � %i. %s [VIP Level %d | ID: %d]", vicount, GetName(i),dini_Int(VIPFile(i),"Level"), i);
					   SendClientMessage(playerid, i == playerid? red : 0x16EB43FF, string);
			      }
			 }
			 SendClientMessage(playerid, COLOR_WHITE, "--------------------------------------");
			 return 1;
		 }
		 if(!strcmp(vtmp, "details", true))
		 {
			 SendClientMessage(playerid, COLOR_WHITE, "-------- [ VIP Details - ���� ���''�� ] --------");
			 format(string, sizeof string, getVIPMemmbers() != 0? (" � .%i ������ VIP ����") : (" � .VIP �� ������ ����"), getVIPMemmbers());
			 SendClientMessage(playerid, getVIPMemmbers() != 0? 0x16EB43FF : red, string);
			 format(string, sizeof string, getOnlineVIP() != 0? (" � .%i ������� ���� VIP ����") : (" � .������� VIP ��� ���� ����"), getOnlineVIP());
			 SendClientMessage(playerid, getOnlineVIP() != 0? 0x16EB43FF : red, string);
   			 format(string, sizeof string, getIntoVIPHQ() != 0? (" � .%i :VIP ���� ������ ��� ������ ������ ����� �") : (" � .VIP - ��� ���� ����� ������ �"), getIntoVIPHQ());
			 SendClientMessage(playerid, getIntoVIPHQ() != 0? 0x16EB43FF : red, string);
			 SendClientMessage(playerid, 0x16EB43FF, " � .10000$ - ������ ���� ��� ������ ���� �� � VIP �� 5 ���� ���� �");
			 SendClientMessage(playerid, !dini_Int("/VIP/Details.txt", "C1") && !dini_Int("/VIP/Details.txt", "C2") && !dini_Int("/VIP/Details.txt", "C3")? red : VIPColor, !dini_Int("/VIP/Details.txt", "C1") && !dini_Int("/VIP/Details.txt", "C2") && !dini_Int("/VIP/Details.txt", "C3")? (" � .VIP - �� ���� ��� ����� ������� �") : (" � .VIP - ��� �� ����� �� ���� ���� �� ������ �"));
			 SendClientMessage(playerid, COLOR_ORANGE, " � /VIP Info Stats - VIP ��� ����� �� ����� �� ���� �");
			 SendClientMessage(playerid, COLOR_WHITE, "--------------------------------------");
			 return 1;
		 }
		 if(!strcmp(vtmp, "stats", true))
		 {
			 SendClientMessage(playerid, COLOR_WHITE, "-------- [ VIP Stats - ����� ���''�� ] --------");
			 format(string, sizeof string," � .%d - ��� �������� VIP ����� �� ������� �� ���� �", dini_Int("/VIP/Stats.txt", "Kills"));
			 SendClientMessage(playerid, 0x16EB43FF, string);
			 format(string, sizeof string," � $%d - VIP - ���� ����� ���� �� �", dini_Int("/VIP/Stats.txt", "Bank"));
			 SendClientMessage(playerid, 0x16EB43FF, string);
   			 format(string, sizeof string,getVIPMemmbers() > dini_Int("/VIP/Stats.txt", "Bank")? (" � ������ �� ����� ���� ���� ���� ����") : (" � $%d - �� �� ���� ������ VIP ��� ���� �������"), dini_Int("/VIP/Stats.txt", "Bank") / getVIPMemmbers());
			 SendClientMessage(playerid, getVIPMemmbers() > dini_Int("/VIP/Stats.txt", "Bank")? red : 0x16EB43FF, string);
			 SendClientMessage(playerid, COLOR_ORANGE, " � /VIP Info Details - VIP ��� ����� �� ���� �");
			 SendClientMessage(playerid, COLOR_WHITE, "--------------------------------------");
			 return 1;
		 }
		 return SendClientMessage(playerid,COLOR_WHITE,".����� VIP �����");
	  }
	  if(!strcmp(vcp, "hq", true))
	  {
		  if(!isPlayerVIP(playerid)) return SendClientMessage(playerid, COLOR_WHITE, ".VIP ���� ���");
		  SendClientMessage(playerid,COLOR_ORANGE,"!VIP - ������ ����� ������ �");
		  return 1;
	  }
	  if(!strcmp(vcp,"leave", true) || !strcmp(vcp,"quit", true))
	  {
 		  format(vpfile, sizeof vpfile,"/VIP/%s.ini", GetName(playerid));
		  if(!isPlayerVIP(playerid)) return SendClientMessage(playerid, COLOR_WHITE, ".VIP ���� ���");
		  format(string, sizeof string, "VIP%i", dini_Int(vpfile, "ivc"));
		  dini_Set("/VIP/Main.txt", string, "None");
		  dini_Remove(vpfile);
   		  dini_IntSet("/VIP/Main.txt", "Total", dini_Int("/VIP/Main.txt", "Total")-1);
   		  SendClientMessage(playerid, red,"� !VIP - ���� ������� �");
		  return 1;
	  }
	  if(!strcmp(vcp, "memmbers", true))
	  {
		 showVIPMemmbers(playerid);
 		 return 1;
	  }
      return SendClientMessage(playerid,COLOR_WHITE,".����� VIP �����");
   }
   return 1;
}
public OnPlayerText(playerid, text[])
{
   new string[128];
   if(text[0] == '$')
   {
        format(string, sizeof string,"$ [VIP Chat]: %s [ID: %i]: %s", GetName(playerid), playerid, text[1]);
	    for(new i = 0; i < MAX_PLAYERS; i++) if(isPlayerVIP(i)) SendClientMessage(playerid, VIPColor, string);
	    return 0;
   }
   return 1;
}
public OnPlayerDeath(playerid, killerid, reason)
{
    if(playerid != INVALID_PLAYER_ID && killerid != playerid && IsPlayerConnected(killerid) && !isPlayerVIP(playerid)) dini_IntSet("/VIP/Stats.txt", "Kills",dini_Int("/VIP/Stats.txt", "Kills")+1);
    return 1;
}
public OnPlayerSpawn(playerid)
{
   if(dini_Int(VIPFile(playerid),"Color")) SetPlayerColor(playerid, VIPColor);
   return 1;
}
public OnPlayerEnterCheckpoint(playerid)
{
   new string[128];
   if(CPS_IsPlayerInCheckpoint(playerid, VIPBank))
   {
	   if(isPlayerVIP(playerid))
	   {
			SendClientMessage(playerid, COLOR_WHITE, "------- [ VIP Bank - ��� ����''�� ] -------");
			format(string, sizeof string, " � !VIP - ������ ����� ���� �� ������ � %s - ���� ��",GetName(playerid));
			SendClientMessage(playerid, 0x00FFFFAA, string);
			format(string, sizeof string, dini_Int("/VIP/Stats.txt", "Bank") != 0? (" � %d$ - ���� �� � VIP - ����� �� ��� �") : (" � .��� ������� VIP - ����� ��� �"),dini_Int("/VIP/Stats.txt", "Bank"));
			SendClientMessage(playerid, dini_Int("/VIP/Stats.txt", "Bank") != 0? 0x16EB43FF : red, string);
			SendClientMessage(playerid,0x16EB43FF, " � /VDeposit - �� ��� ������ ������ ���� �� �������");
			SendClientMessage(playerid,0x16EB43FF, " � /VWithdraw - �� ��� ����� ��� ������ ���� �������");
			SendClientMessage(playerid,COLOR_ORANGE, " � VIP ����: �� ���� �� ���� ����� ����� ����, ���� ���� ����� ���� ��� ������, �� ������ ���� ��� ����� ������ *");
			SendClientMessage(playerid, COLOR_WHITE, "--------------------------------------");
		    return 1;
	   }
	   else SendClientMessage(playerid, red,".���� VIP - �'� ����� �� ���� �� ������ �");
	   return 1;
   }
   return 1;
}
stock VIPFile(playerid)
{
  new string[128];
  format(string,sizeof(string),"/VIP/%s.ini",GetName(playerid));
  return string;
}
stock isPlayerVIP(playerid)
{
  new string[128];
  format(string,sizeof string,"/VIP/%s.ini",GetName(playerid));
  return dini_Exists(string)? 1 : 0;
}
stock getOnlineVIP()
{
  new vicount = 0;
  for(new i = 0; i < MAX_PLAYERS; i++) if(isPlayerVIP(i) && IsPlayerConnected(i)) vicount++;
  return vicount;
}
stock SendVIPMessageToAll(color, const msg[])
{
   for(new i = 0; i < MAX_PLAYERS; i++) if(isPlayerVIP(i) && IsPlayerConnected(i)) SendClientMessage(i, color, msg);
   return 1;
}
stock getIntoVIPHQ()
{
  new vicount = 0;
  for(new i = 0; i < MAX_PLAYERS; i++) if(make_isPlayerInArea(i,dini_Float("/VIP/Main.txt", "x1"),dini_Float("/VIP/Main.txt", "y1"),dini_Float("/VIP/Main.txt", "x2"),dini_Float("/VIP/Main.txt", "y2")) && IsPlayerConnected(i)) vicount++;
  return vicount;
}
stock getVIPMemmbers()
{
   new vc = 0, string[128];
   for(new i = 0; i < dini_Int("/VIP/Main.txt", "Total")+2; i++)
   {
	   format(string, sizeof string, "VIP%i", i);
	   if(strcmp(dini_Get("/VIP/Main.txt", string), "None", false)) vc++;
   }
   return vc;
}
stock showVIPMemmbers(playerid)
{
	new vvip[128], vpfile[128], string[128];
	if(!getVIPMemmbers()) return SendClientMessage(playerid, COLOR_WHITE,".VIP �� ������ �����");
	format(string,sizeof string,"------- [ %d :����� ���''�� ������ ] -------",getVIPMemmbers());
	SendClientMessage(playerid, COLOR_WHITE, string);
	for(new i = 0; i < dini_Int("/VIP/Main.txt", "Total")+2; i++)
	{
		  format(vpfile,sizeof vpfile,"VIP%i", i);
		  if(dini_Isset("/VIP/Main.txt", vpfile) && strcmp(dini_Get("/VIP/Main.txt", vpfile), "None", true))
		  {
		       format(vvip, sizeof vvip,"/VIP/%s.ini", dini_Get("/VIP/Main.txt", vpfile));
		       format(string, sizeof string,GetPlayerID(dini_Get("/VIP/Main.txt", vpfile)) == INVALID_PLAYER_ID? (" � %s [VIP Level: %d]"): (" � %s [VIP Level: %d | ID: %d]"), dini_Get("/VIP/Main.txt", vpfile), dini_Int(vvip,"Level"), GetPlayerID(dini_Get("/VIP/Main.txt", vpfile)));
		       SendClientMessage(playerid,GetPlayerID(dini_Get("/VIP/Main.txt", vpfile)) == INVALID_PLAYER_ID? red : 0x16EB43FF, string);
		  }
		  else continue;
	}
	SendClientMessage(playerid, COLOR_WHITE, "--------------------------------------");
	return 1;
}
stock make_isPlayerInArea(playerid, Float:x1, Float:y1, Float:x2, Float:y2) /// JoeShk
{
   new Float:mx[2], Float:my[2], Float:pos[3];
   mx[0] = x1 > x2? x1 : x2, mx[1] = x1 < x2? x1 : x2;
   my[0] = y1 > y2? y1 : y2, my[1] = y1 < y2? y1 : y2;
   GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
   return pos[0] <= mx[0] && pos[0] >= mx[1] && pos[1] <= my[0] && pos[1] >= my[1]? true : false;
}
stock GetPlayerFile(playerid)
{
  new string[128];
  format(string,sizeof(string),"WDM/Users/%s.ini",GetName(playerid));
  return string;
}
stock GetName(playerid)
{
   new Name[MAX_PLAYER_NAME];
   GetPlayerName(playerid,Name,sizeof(Name));
   return Name;
}
stock GetPlayerID(const Name[])
{
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && !strcmp(Name, GetName(i), true)) return i;
	return INVALID_PLAYER_ID;
}
stock sgba2hex(s,g,b,a) return (s*16777216) + (g*65536) + (b*256) + a;
