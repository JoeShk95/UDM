//| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
/*
This Is The Mode`s, (xDeatchMatchx+5) Build by - Roy_Killer ('JoeShk'),
for `Satlz-Zone.co.il` Data Of Build `dd/mm/yyyy`
Create by roy.
*/

//| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
//=["inclued"]=============================================================
#include "a_samp.inc"
#include "dini.inc"
#include "cpstream"
#include "a_players.inc"
#include "DUDB.inc"
#include "Y_Objects"
//#include "YSF.inc"
//=[Unused]====================================================================
#pragma unused ret_memcpy
#pragma unused RegisterPlayer
//=[Pragma/Dcmd/Dynamic]====================================5=================
#pragma tabsize 0
#pragma dynamic 145000
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1 // dcmd
//=[Money When Kill]============================================================
#define MoneyKill 850
//=[Color`s]======================================================================
#define lblue	0x00FFFFAA
#define COLOR_BRIGHTRED 0xFF0000AA
#define COLOR_MEDBLUE 0x0099FFFF
#define COLOR_LIGHTGREEN 0x24FF0AB9
#define COLOR_AQUA 0xFF0000F
#define COLOR_PEACH 0xFF0000F
#define gg 0xFF0000F
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_RED 0xFFFFFFAA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_LIGHTBLUE 0x17E5F6FF
#define COLOR_DARKRED 0x660000AA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_BRIGHTRED 0xFF0000AA
#define red 0xFF0000AA
#define COLOR_INDIGO 0x4B00B0AA
#define COLOR_VIOLET 0x9955DEEE
#define COLOR_LIGHTRED 0xF5DEB3AA
#define COLOR_SEAGREEN 0x00EEADDF
#define COLOR_GRAYWHITE 0xEEEEFFC4
#define COLOR_LIGHTNEUTRALBLUE 0xabcdef66
#define COLOR_GREENISHGOLD 0xCCFFDD56
#define COLOR_NEUTRALBLUE 0xABCDEF01
#define COLOR_LIGHTCYAN 0xAAFFCC33
#define COLOR_LEMON 0xDDDD2357
#define COLOR_MEDIUMBLUE 0x63AFF00A
#define COLOR_NEUTRAL 0xABCDEF97
#define COLOR_BLACK 0x00000000
#define COLOR_NEUTRALGREEN 0x81CFAB00
#define COLOR_BLUEGREEN 0x46BBAA00
#define COLOR_PINK 0xFF66FFAA
#define COLOR_PURPLE 0x800080AA
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_RED1 0xFF0000AA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BROWN 0x993300AA
#define COLOR_CYAN 0x99FFFFAA
#define COLOR_TAN 0xFFFFCCAA
#define COLOR_KHAKI 0x999900AA
#define COLOR_LIME 0x99FF00AA
#define COLOR_SYSTEM 0xEFEFF7AA
#define rr 0xFF0000AA
#define COLOR_neww 0xB4ECB4FF
//=Funcktion`s===================================================================
#define ReadCMD(%1); Config[CL_%1] = dini_Int("RLSB/Config.cfg",#%1);
#define ReadOption_Int(%1); Config[%1] = dini_Int("RLSB/Config.cfg",#%1);
#define CheckPlayerCMDLevel(%1,%2); if(PlayerInfo[%1][Level] < Config[CL_%2]) \
{ \
new cmdstring[256]; \
format(cmdstring,sizeof(cmdstring),"Level Error: You must be level %d to use this command.",Config[CL_%2]); \
SendClientMessage(%1,COLOR_BRIGHTRED,cmdstring); \
return 1; \
}
//=[PlayerInfo]======================================================================
enum PlayerInfoData
{
KopatGemel,GemelLogin,aKillsnl,aLevelnl,AggInfo,
GetAloan,MoneyLoan,Level,Logged,Pets,Shark,bazooka,
SharkKills,DolphinKills,TorKills,Tor,Dolp,Tag,ICQ,
FL,Kills,Deaths,Money,Bank,Saved,Float:SPX,
Float:SPY,Float:SPZ,SPI,SkinSavedId,SkinSaved,
SaveSkin,Wars,Kart,Monster,RPGS,MINIGUN,Mlg,
AdminsLevel,Warnings,Weeds,autologin,armourT,VIPS,
TimeOnServer,ProfileLogged,CcMode,Supportives,
AirStrikeSaved,Float:xAirStrike,Float:yAirStrike,Float:zAirStrike,
Sawn,MicroSMG,Tec9,M4,MP5,AK47,Knife,Katana,CombatShotGun,
ShotGun,SniperRifle,CRifle,Colt,BSHIP
};
//=[ConfigEnums]===============================================================
enum ConfigEnum
{
MinPasswordLength,MaxPasswordLength,MaxFailedLogins,
CL_register,CL_login,CL_changenick,CL_changepass,CL_ChangeIcq
};
//=[Variables]==================================================================
stock PlayerInfo[MAX_PLAYERS][PlayerInfoData],Config[ConfigEnum];
//=[Props]=
#define MAX_PROPERTIES 100
#define MAX_PROPERTIES_PER_PLAYER 8
#define UNBUYABLETIME 15  //If a propertie is bought, someone else have to wait this number of minutes before he/she can buy it.

#define ENABLE_MAP_ICON_STREAMER 1

new PropertiesAmount;
new MaximuxPlayer;
enum propinfo
{
	PropName[64],
	Float:PropX,
	Float:PropY,
	Float:PropZ,
	PropIsBought,
	PropUnbuyableTime,
	PropOwner[MAX_PLAYER_NAME],
	PropValue,
	PropEarning,
	PickupNr,
}
new PropInfo[MAX_PROPERTIES][propinfo]; //CarInfo
new PlayerProps[MAX_PLAYERS];
new EarningsForPlayer[MAX_PLAYERS];


//=[Kizor]======================================================================
#define fnm for(new i=0; i<MAX_PLAYERS; i++) {
#define nn new

//==[Sniper`system]=============================================================
new HpModeA[MAX_PLAYERS] = 0;
new hpmodebug[MAX_PLAYERS];
//=[Checkpoint`s,New`s]=========================================================
new CheckPointTimer;
new be;
new nobank;
new gateb;
new bcp;
new Wang;
//=[WeedSystem]=================================================================
#define WeedCost 1000
#define MAX_WEED 5
new Stoned[MAX_PLAYERS];
new PS[MAX_PLAYERS];
new CB[MAX_PLAYERS];
new offerweed[MAX_PLAYERS][MAX_PLAYERS];
new Weed[MAX_WEED];
//=Checkpoints==================================================================
#define CP_BANK	0
#define CP_PIRATE			1
#define CP_AMMU				2
#define CP_DRAGON			3
#define CP_CALIGULA			4
#define CP_SEXSHOP			5
#define CP_BAR				6
#define CP_ZIP				7
#define CP_BINCO			8
#define CP_TATOO			9
#define CP_BOTIQUE			10
#define CP_STRIPCLUB		11
#define CP_AIRSTRIP			12
#define CP_EMERALD			13
#define CP_VISAGE			14
#define CP_SPREADRANCH		15
#define CP_WANGEXPORTS		16
#define CP_LC 17
#define CP_BankP 18
//=Properties===================================================================
#define P_DRAGON			0
#define P_CALIGULA			1
#define P_SEXSHOP			2
#define P_BAR				3
#define P_ZIP				4
#define P_BINCO				5
#define P_TATOO				6
#define P_BOTIQUE			7
#define P_STRIPCLUB			8
#define P_AIRSTRIP   9
#define P_EMERALD   10
#define P_VISAGE   11
#define P_SPREADRANCH		12
#define P_LC 13
#define P_BankP 14
#define COLOR_YELLOW 0xECF60FF

new playername[MAX_PLAYER_NAME];
new antianti[MAX_PLAYERS];
new CashScoreOld;
new iSpawnSet[MAX_PLAYERS];
new bank[MAX_PLAYERS];
new playerCheckpoint[MAX_PLAYERS];
//=[Weapons]====================


new mini[MAX_PLAYERS];
new ClickedBm[MAX_PLAYERS];


//PlayerColor`S
new playerColors[100] = {
0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,0xF4A460FF,0xEE82EEFF,0xFFD720FF,
0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,0x10DC29FF,0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,
0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,0x65ADEBFF,0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,
0x275222FF,0xF09F5BFF,0x3D0A4FFF,0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,
0x057F94FF,0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,0x18F71FFF,0x4B8987FF,
0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,0x12D6D4FF,0x2A51E2FF,0xE3AC12FF,
0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,0x2FD9DEFF,0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,
0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,0x3214AAFF,0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,
0x9F945CFF,0xDCDE3DFF,0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,0xD8C762FF,
0x3FE65CFF
};

enum SavePlayerPosEnum {
Float:LastX,
Float:LastY,
Float:LastZ
}


forward PayPlayerInArea(playerID, Float:x1, Float:y1, Float:x2, Float:y2, cash);
forward isPlayerInArea(playerID, Float:data[4]);
forward TimeUpdate();
forward getCheckpointType(playerID);

forward checkpointUpdate();






//=[MinigunSystem]===========================================================
#define MinWarPlayersw 1
new WarOnw;
new InWarw[MAX_PLAYERS];
new WarPlayersw;
new playernamew[MAX_PLAYER_NAME];
new Adminnamew[MAX_PLAYER_NAME];
new Countw;
new knoobw;
new CountFucw;
new WarWinnerw;
new CTPw;
new SASw;
new WSw;
new PPw[MAX_PLAYERS];
//=[RadomTeleport`s Mini`s]==================================================
new Float:sssaw[][3] =
{
{2613.9866,	2848.4475,	19.9922},{2647.6553,	2805.0278,	10.8203},
{2611.5500,	2845.7542,	16.7020},{2545.9243,	2839.1824,	10.8203},
{2672.9387,	2800.3374,	10.8203},{2672.8306,	2792.1057,	10.8203},
{2647.7834,	2697.5884,	19.3222},{2654.5427,	2720.3474,	19.3222},
{2653.2063,	2738.2432,	19.3222},{2685.8875,	2816.6575,	36.3222},
{2641.1350,	2703.2019,	25.8222},{2599.1304,	2700.7249,	25.8222},
{2606.1384,	2721.5237,	25.8222},{2597.3745,	2748.0884,	23.8222},
{2595.0657,	2776.6729,	23.8222},{2601.3640,	2777.8101,	23.8222},
{2584.3940,	2825.1748,	27.8203},{2631.8110,	2834.2593,	40.3281},
{2632.2852,	2834.9390,	122.9219},{2646.1997,	2817.7070,	36.3222},
{2691.1233,	2787.7883,	59.0212},{2717.8071,	2771.3464,	74.8281},
{2695.2622,	2699.5488,	22.9472},{2688.8206,	2689.0039,	28.1563},
{2655.0229,	2650.6807,	36.9154},{2570.4668,	2701.2876,	22.9507},
{2498.9915,	2704.6204,	10.9844},{2524.1584,	2743.3735,	10.9917},
{2498.3167,	2782.3357,	10.8203},{2504.5142,	2805.9763,	14.8222},
{2522.2144,	2814.7087,	24.9536},{2510.6292,	2849.6384,	14.8222},
{2618.2646,	2720.8005,	36.5386},{2690.9980,	2741.9060,	19.0722},
{2544.5032,	2805.8840,	19.9922},{2556.2554,	2832.5313,	19.9922},
{2561.9175,	2848.5532,	19.9922}
};
//=[War`system]===============================================================
new PP[MAX_PLAYERS];
new WarOn;
new InWar[MAX_PLAYERS];
new WarPlayers;
new Adminname[MAX_PLAYER_NAME];
new Count;
new knoob;
new CountFuc;
new Reward;
new knob[256];
new WarWinner;
new CTP;
new SAS;
new WS;
new WarWeapons[] = {26,32};
//=[RandomTeleport`s war`s]=======================================================
new Float:sssa[][3] =
{
{-1132.9607,1028.6680,1345.7377},{-1128.3600,1095.9415,1345.7709},
{-1098.6946,1098.4323,1341.1632},{-1071.4646,1088.1956,1346.0206},
{-1039.4835,1100.4468,1343.1393},{-1043.1943,1041.5938,1341.3516},
{-1020.2195,1051.2196,1345.9545},{-973.8190,1060.5537,1345.6772},
{-973.6674,1027.6255,1345.0448},{-1019.2279,1071.8867,1347.4093},
{-974.3493,1089.1172,1344.9795},{-1009.8291,1080.3978,1341.0828},
{-1046.0696,1023.0779,1343.0669},{-1072.4380,1031.8779,1342.9623},
{-1104.6825,1097.2749,1341.8513},{-1129.6497,1019.8154,1345.6614}
,{-1064.0248,1032.7473,1344.5297},{-1054.4865,1058.6794,1341.3516},
{-1085.3271,1019.7804,1342.7926},{-1025.9915,1066.3752,1343.8276}
};
//=[SpawnPlayer,X,Y,Z]================================================================
new Float:gRandomPlayerSpawns[44][3] =
{
{2001.6309,1914.6458,40.3516},{2208.8589,1839.1924,10.8203},
{1970.2393,1622.4781,12.8669},{2232.3596,1285.6245,10.6719},
{2578.0166,1663.4172,10.8203},{2602.7380,2183.7473,14.1161},
{2627.3213,2348.1069,10.8203},{2486.1292,1413.6133,12.3983},
{986.2977,1880.0288,11.4683},{1502.4791,2026.9261,14.7396},
{1607.5032,1816.2596,10.8203},{1645.9166,1614.2948,14.8222},
{1958.6238,694.7397,14.2681},{1491.2498,2773.8394,15.9924},
{1957.5282,1342.9089,15.3746},{2057.3989,861.9690,6.7126},
{2117.1782,897.9985,11.1797},{2178.3259,1118.1112,12.6484},
{1677.0559,1447.6254,10.7827},{661.8549,1718.4475,7.1875},
{426.7151,2536.6672,16.5391},{1958.3783,1343.1572,15.3746},
{2199.6531,1393.3678,10.8203},{2483.5977,1222.0825,10.8203},
{2637.2712,1129.2743,11.1797},{2000.0106,1521.1111,17.0625},
{2024.8190,1917.9425,12.3386},{2261.9048,2035.9547,10.8203},
{2262.0986,2398.6572,10.8203},{2244.2566,2523.7280,10.8203},
{2335.3228,2786.4478,10.8203},{2150.0186,2734.2297,11.1763},
{2158.0811,2797.5488,10.8203},{1969.8301,2722.8564,10.8203},
{1652.0555,2709.4072,10.8265},{1564.0052,2756.9463,10.8203},
{1271.5452,2554.0227,10.8203},{1441.5894,2567.9099,10.8203},
{1480.6473,2213.5718,11.0234},{1400.5906,2225.6960,11.0234},
{1598.8419,2221.5676,11.0625},{1705.2347,1025.6808,10.8203},
{1318.7759,1251.3580,10.8203},{1558.0731,1007.8292,10.8125}
};
//=[checkCoords]================================================
#define MAX_POINTS 19
new Float:checkCoords[MAX_POINTS][4] =
{
{-36.5483,-57.9948, -17.2655,-49.2967},			// Bank
{1894.6128,1445.3431, 2084.9739,1637.8186},		// Pirate
{284.0546,-86.4384, 302.9315,-56.6674},			// Ammunation
{1925.1511,968.2358, 2019.0715,1067.4276},		// FourDragons
{-115.9544,-24.2706, -99.1631,-7.1391},			// SexShop
{487.6558,-88.5900, 512.0635, -67.7503},		// Bar
{2216.7971,1638.0493, 2255.2097,1714.0806},		// Caligula
{144.9131,-96.0927, 177.4128,-70.7923},			// Zip
{201.4462,-112.4556, 218.5237,-95.1238},		// BincoShop
{-204.7623,-44.0326, -200.2330,-39.8128},		// Tatoo
{416.7485,-84.4242, 422.6890,-74.0611},			// Botique
{1201.1422,-16.6343,1223.4420,12.6656},     	// StripClub
{413.4203,2534.9907,421.4078,2542.7031},    	// AirStrip
{2099.1985,2328.5200,2179.1382,2405.8721},  	// EmeraldIsle
{1998.3783,1875.9679,2066.3425,1957.0034},  	// TheVisage
{-1924.2008,245.8384,-1897.2331,210.0660},//Wang
{1205.7026,-41.1453,1216.8755,-23.9896},
{-783.0222,500.0925,-780.2761,503.1472},//Liberty City Propo	     	// TheBigSpreadRanch	{407.1485,-2459.5288,16.5000.-181.0846}
{1431.1639,-2287.9189,1413.4166,-2287.4971}
};
//=[checkpoints]================================================
new Float:checkpoints[MAX_POINTS][6] =
{
{-22.2549,-55.6575,1003.5469},					// Bank
{2000.3132,1538.6012,13.5859},					// Pirate
{291.0004,-84.5168,1001.5156},					// Ammunation
{1989.0619,1005.5241,994.4688},					// FourDragons
{-103.5525,-22.4661,1000.7188},					// SexShop
{501.4927,-75.4323,998.7578},					// Bar
{2235.5408,1679.0402,1008.3594},				// Caligula
{161.1875,-79.9915,1001.8047},					// Zip
{207.5640,-97.8188,1005.2578},					// BincoShop
{-203.4864,-41.2045,1002.2734},					// Tatoo
{418.5547,-80.1667,1001.8047},					// Botique
{1212.3918,-10.9459,1000.9219},					// StripClub
{418.1210,2536.8762,10.0000},					// AirStrip
{2127.5940,2370.4255,10.8203},					// EmeraldIsle
{2022.5179,1916.6848,12.3397},					// TheVisage
{-1920.6711,303.1555,33.0469},					// CP_WANGEXPORTS
{1208.5027,-32.6044,1000.9531}, 				// TheBigSpreadRanch
{-781.4277,501.4098,1371.7490},
{1422.4281,-2287.8442,13.3828}//Bank


};
new checkpointType[MAX_POINTS] =
{
CP_BANK,CP_PIRATE,CP_AMMU,CP_DRAGON,CP_SEXSHOP,
CP_BAR,CP_CALIGULA,CP_ZIP,CP_BINCO,
CP_TATOO,CP_BOTIQUE,CP_STRIPCLUB,CP_AIRSTRIP,
CP_EMERALD,CP_VISAGE,CP_SPREADRANCH,CP_WANGEXPORTS,CP_LC
};

//=[Wang`s]=====================================================================
//forward:
forward SellWangExportVehicle(playerid);
//define:
#define MAX_WANGEXPORTVEHICLES	25
//new`s:
new Sell[MAX_PLAYERS];
new wantedWangExportVehicle;
new wantedWangExportVehicles[MAX_WANGEXPORTVEHICLES] =
{
400, 411, 434, 451, 461, 463,
468, 470, 480, 482, 495, 535,
541, 567, 603, 522, 556, 415,
587, 434, 494, 571, 560 ,420,
506
};
new wantedWangExportVehicleNames[MAX_WANGEXPORTVEHICLES][32] =
{
"Landstalker", "Infernus", "Hotknife", "Turismo", "PCJ-600",
"Freeway", "Sanchez", "Patriot", "Comet", "Burrito",
"Sandking", "Slamvan", "Bullet", "Savanna", "Phoenix","NRG-500","Monster",
"Cheetah","Euros","Hotknife","Hotring","Kart","Sultan","Taxi","Supergt"
};

//=[Gang`s]==========================================================
//define:
#define MAX_GANGS 			32
#define MAX_GANG_MEMBERS	6
#define MAX_GANG_NAME       16
//New`a
new gangMembers[MAX_GANGS][MAX_GANG_MEMBERS];
new gangNames[MAX_GANGS][MAX_GANG_NAME];
new gangInfo[MAX_GANGS][3]; //0-created,1-members,2-color
new gangBank[MAX_GANGS];
new playerGang[MAX_PLAYERS];
new gangInvite[MAX_PLAYERS];
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
main(){
print("\n----------------");
print("Mode Nice To");
print("          Roy_Killer`s");
print("-----------\n");
}



forward PlayerLeaveGang(playerid);
public PlayerLeaveGang(playerid) {

new string[256];
new playernamess[MAX_PLAYER_NAME];
new gangnum = playerGang[playerid];

if(gangnum > 0)
{
for(new i = 0; i < gangInfo[gangnum][1]; i++)
{
if(gangMembers[gangnum][i]==playerid)
{

gangInfo[gangnum][1]--;

for(new j = i; j < gangInfo[gangnum][1]; j++)
{
gangMembers[gangnum][j]=gangMembers[gangnum][j+1];
}
if(gangInfo[gangnum][1]<1)
{
gangInfo[gangnum][0]=0;
gangInfo[gangnum][1]=0;
gangBank[gangnum]=0;
}

for(new j = 0; j < gangInfo[gangnum][1]; j++) {
GetPlayerName(playerid, playernamess, MAX_PLAYER_NAME);
format(string, sizeof(string),".יצא מהגאנג שלך %s", playernamess);
SendClientMessage(gangMembers[gangnum][j], COLOR_ORANGE, string);
}
format(string, sizeof(string),"'%s' אתה יצאת מהגאנג (id: %d)", gangNames[gangnum], gangnum);
SendClientMessage(playerid, COLOR_ORANGE, string);
playerGang[playerid]=0;
new rand = random(sizeof(playerColors));
SetPlayerColor(playerid, playerColors[rand]);

return;
}
}
}
else
{
SendClientMessage(playerid,COLOR_WHITE, ".אתה לא נמצא בגאנג");
}
}
//----Rcon Admin--- CARSYS===
//#define COLOR_YELLOW 0xFFFF00AA
//#define BLUE 0x005EECAA
#define LIGHTGREEN 0x24FF0AB9
#define BLUE 0x005EECAA
#define CYAN 0x99FFFFAA
#define BLUE1 0x00FFFFAA
#define BLUE2 0x09DF6FF
#define RED 0xFF0000AA
#define RED2 0xAA3333AA
#define GREEN 0x33FF33AA
#define WHITE 0xFFFFFFAA
#define ORANGE 0xFF9900AA
#define BLACK 0x00000000
#define LIGHGREENS 0x0F66AFF
#define MyColor 0x0B6F6FF







new	boat[11][0] = {
{472}, {473}, {493}, {595}, {484}, {430}, {453}, {539}, {452}, {446}, {454}
};
new	bike[14][0] = {
{581}, {521}, {462}, {463}, {468}, {471}, {586}, {522}, {523}, {461}, {448},
{509}, {481},{510}
};
new	plane[10][0] = {
{512}, {513}, {460}, {464}, {465}, {519}, {511}, {553}, {592}, {577}
};
new expensive[18][0] = {
{476}, {433}, {541}, {486}, {495}, {506}, {451}, {477}, {406}, {444}, {573},
{449}, {537}, {558}, {587}, {407}, {528}, {529}
};
new Vexpensive[4][0] = {
{432}, {425}, {520}, {447}
};

forward SaveFiles();


new VCount;
new CreateCount = 0;

new Float:Pos[MAX_PLAYERS][4];
new Float:Angle[MAX_PLAYERS];

enum PInfo
{
CarID,OwnCar
}
new pia[MAX_VEHICLES][PInfo];
#define MAX_CARS 100


enum VehInfo
{
	CarID,
	CarName[30],
	CarModel,
	CarOwned,
	CarOwner[MAX_PLAYER_NAME],

	Buyable,
 

	Price,
	LevelCar,
	SaleV

};
new VehicleInfo[MAX_VEHICLES][VehInfo];
new VehNames[212][] = {
"Landstalker","Bravura","Buffalo","Linerunner","Pereniel","Sentinel","Dumper","Firetruck","Trashmaster",
"Stretch","Manana","Infernus","Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto",
"Taxi","Washington","Bobcat","Mr Whoopee","BF Injection","Hunter","Premier","Enforcer","Securicar","Banshee",
"Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie","Stallion","Rumpo",
"RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer",
"Turismo","Speeder","Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer",
"PCJ-600","Faggio","Freeway","RC Baron","RC Raider","Glendale","Oceanic","Sanchez","Sparrow","Patriot",
"Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR3 50","Walton","Regina","Comet","BMX",
"Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo",
"Greenwood","Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa",
"RC Goblin","Hotring Racer A","Hotring Racer B","Bloodring Banger","Rancher","Super GT","Elegant",
"Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain","Nebula","Majestic",
"Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona",
"FBI Truck","Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight",
"Streak","Vortex","Vincent","Bullet","Clover","Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob",
"Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A","Monster B","Uranus",
"Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight",
"Trailer","Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford",
"BF-400","Newsvan","Tug","Trailer A","Emperor","Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C",
"Andromada","Dodo","RC Cam","Launch","Police Car (LSPD)","Police Car (SFPD)","Police Car (LVPD)","Police Ranger",
"Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A","Luggage Trailer B",
"Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};
new VehiclesName[][] =
{
   "Landstalker",
   "Bravura",
   "Buffalo",
   "Linerunner",
   "Pereniel",
   "Sentinel",
   "Dumper",
   "Firetruck",
   "Trashmaster",
   "Stretch",
   "Manana",
   "Infernus",
   "Voodoo",
   "Pony",
   "Mule",
   "Cheetah",
   "Ambulance",
   "Leviathan",
   "Moonbeam",
   "Esperanto",
   "Taxi" ,
   "Washington",
   "Bobcat",
   "Mr Whoopee",
   "BF Injection",
   "Hunter Type: Halicopter",
   "Premier",
   "Enforcer",
   "Securicar",
   "Banshee",
   "Predator",
   "Bus",
   "Rhino",
   "Barracks",
   "Hotknife",
   "Trailer",
   "Previon",
   "Coach",
   "Cabbie",
   "Stallion",
   "Rumpo",
   "RC Bandit",
   "Romero",
   "Packer",
   "Monster Type: Truck",
   "Admiral",
   "Squalo",
   "Seasparrow",
   "Pizzaboy",
   "Tram",
   "Trailer",
   "Turismo",
   "Speeder",
   "Reefer",
   "Tropic",
   "Flatbed",
   "Yankee",
   "Caddy",
   "Solair",
   "Berkley's RC Van",
   "Skimmer",
   "PCJ-600",
   "Faggio",
   "Freeway",
   "RC Baron",
   "RC Raider",
   "Glendale",
   "Oceanic",
   "Sanchez",
   "Sparrow",
   "Patriot",
   "Quad",
   "Coastguard",
   "Dinghy",
   "Hermes",
   "Sabre",
   "Rustler",
   "ZR-350",
   "Walton",
   "Regina",
   "Comet",
   "BMX",
   "Burrito",
   "Camper",
   "Marquis",
   "Baggage",
   "Dozer",
   "Maverick",
   "News Chopper",
   "Rancher",
   "FBI Rancher",
   "Virgo",
   "Greenwood",
   "Jetmax",
   "Hotring",
   "Sandking",
   "Blista Compact",
   "Police Maverick",
   "Boxville",
   "Benson",
   "Mesa",
   "RC Goblin",
   "Hotring Racer",
   "Hotring Racer",
   "Bloodring Banger",
   "Rancher",
   "Super GT",
   "Elegant",
   "Journey",
   "Bike",
   "Mountain Bike",
   "Beagle",
   "Cropdust",
   "Stunt",
   "Tanker",
   "RoadTrain",
   "Nebula",
   "Majestic",
   "Buccaneer",
   "Shamal",
   "Hydra",
   "FCR-900",
   "NRG-500",
   "HPV1000",
   "Cement Truck",
   "Tow Truck",
   "Fortune",
   "Cadrona",
   "FBI Truck",
   "Willard",
   "Forklift",
   "Tractor",
   "Combine",
   "Feltzer",
   "Remington",
   "Slamvan",
   "Blade",
   "Freight",
   "Streak",
   "Vortex",
   "Vincent",
   "Bullet",
   "Clover",
   "Sadler",
   "Firetruck",
   "Hustler",
   "Intruder",
   "Primo",
   "Cargobob",
   "Tampa",
   "Sunrise",
   "Merit",
   "Utility",
   "Nevada",
   "Yosemite",
   "Windsor",
   "Monster Truck",
   "Monster Truck",
   "Uranus",
   "Jester",
   "Sultan",
   "Stratum",
   "Elegy",
   "Raindance",
   "RC Tiger",
   "Flash",
   "Tahoma",
   "Savanna",
   "Bandito",
   "Freight",
   "Trailer",
   "Kart",
   "Mower",
   "Duneride",
   "Sweeper",
   "Broadway",
   "Tornado",
   "AT-400",
   "DFT-30",
   "Huntley",
   "Stafford",
   "BF-400",
   "Newsvan",
   "Tug",
   "Trailer",
   "Emperor",
   "Wayfarer",
   "Euros",
   "Hotdog",
   "Club",
   "Trailer",
   "Trailer",
   "Andromada",
   "Dodo",
   "RC Cam",
   "Launch",
   "Police Car (LSPD)",
   "Police Car (SFPD)",
   "Police Car (LVPD)",
   "Police Ranger",
   "Picador",
   "S.W.A.T. Van",
   "Alpha",
   "Phoenix",
   "Glendale",
   "Sadler",
   "Luggage Trailer",
   "Luggage Trailer",
   "Stair Trailer",
   "Boxville",
   "Farm Plow",
   "Utility Trailer"
};
new vehname[999];
forward VehNameTime(playerid);
forward VehNameTime2(playerid);
//END==============
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
public getCheckpointType(playerID) {
return checkpointType[playerCheckpoint[playerID]];}
public isPlayerInArea(playerID, Float:data[4]){
new Float:X, Float:Y, Float:Z;
GetPlayerPos(playerID, X, Y, Z);
if(X >= data[0] && X <= data[2] && Y >= data[1] && Y <= data[3]) {
return 1;}
return 0;}
public PayPlayerInArea(playerID, Float:x1, Float:y1, Float:x2, Float:y2, cash){
if(IsPlayerConnected(playerID))
{
new Float:X, Float:Y, Float:Z;
GetPlayerPos(playerID, X, Y, Z);

new Float:armour;
GetPlayerArmour(playerID,armour);
if(X >= x1 && X <= x2 && Y >= y1 && Y <= y2)
{
LACY_GiveMoney (playerID, cash);

if(PlayerInfo[playerID][Level] == 10) return SetPlayerArmour(playerID,armour+5.0);
if(PlayerInfo[playerID][Level] == 11) return SetPlayerArmour(playerID,armour+10.0);
if(PlayerInfo[playerID][Level] == 12) return SetPlayerArmour(playerID,armour+15.0);
if(PlayerInfo[playerID][Level] == 13) return SetPlayerArmour(playerID,armour+20.0);
if(PlayerInfo[playerID][Level] == 14) return SetPlayerArmour(playerID,armour+25.0);
if(PlayerInfo[playerID][Level] == 15) return SetPlayerArmour(playerID,armour+30.0);
if(PlayerInfo[playerID][Level] == 16) return SetPlayerArmour(playerID,armour+35.0);
if(PlayerInfo[playerID][Level] == 17) return SetPlayerArmour(playerID,armour+40.0);
if(PlayerInfo[playerID][Level] == 18) return SetPlayerArmour(playerID,armour+45.0);
if(PlayerInfo[playerID][Level] == 19) return SetPlayerArmour(playerID,armour+50.0);
if(PlayerInfo[playerID][Level] == 20) return SetPlayerArmour(playerID,armour+55.0);
if(PlayerInfo[playerID][Level] == 21) return SetPlayerArmour(playerID,armour+60.0);


return 1;
}
}
return 0;
}
forward checkpointUpdate();
public checkpointUpdate()
{
for(new i=0; i<MAX_PLAYERS; i++)
{
if(IsPlayerConnected(i))
{
for(new j=0; j < MAX_POINTS; j++)
{
if(isPlayerInArea(i, checkCoords[j]))
{
if(playerCheckpoint[i]!=j)
{
DisablePlayerCheckpoint(i);
SetPlayerCheckpoint(i, checkpoints[j][0],checkpoints[j][1],checkpoints[j][2],2);
playerCheckpoint[i] = j;
}
}
else
{
if(playerCheckpoint[i]==j)
{
DisablePlayerCheckpoint(i);
playerCheckpoint[i] = 999;
}
}
}
}
}
}

public PirateShipScoreUpdate()
{
fnm
if(PlayerInfo[i][Level] == 0) return PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0, 5);
if(PlayerInfo[i][Level] == 1) return PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0, 10);
if(PlayerInfo[i][Level] == 2) return PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0, 15);
if(PlayerInfo[i][Level] == 3) return PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0, 20);
if(PlayerInfo[i][Level] == 4) return PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0, 25);
if(PlayerInfo[i][Level] == 5) return PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0, 30);
if(PlayerInfo[i][Level] == 6) return PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0, 35);
if(PlayerInfo[i][Level] == 7) return PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0, 40);
if(PlayerInfo[i][Level] == 8) return PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0, 45);
if(PlayerInfo[i][Level] == 9) return PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0, 50);
if(PlayerInfo[i][Level] == 10) return PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0,55);
if(PlayerInfo[i][Level] == 11) return PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0, 60);
if(PlayerInfo[i][Level] == 12) return PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0, 65);
if(PlayerInfo[i][Level] == 13) return PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0, 70);
if(PlayerInfo[i][Level] == 14) return PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0, 75);
if(PlayerInfo[i][Level] == 15) return PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0, 80);
if(PlayerInfo[i][Level] == 16) return PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0, 85);
if(PlayerInfo[i][Level] == 17) return PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0, 90);
if(PlayerInfo[i][Level] == 18) return PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0, 95);
if(PlayerInfo[i][Level] == 19) return PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0, 100);
if(PlayerInfo[i][Level] == 20) return PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0, 105);
if(PlayerInfo[i][Level] == 21) return PayPlayerInArea(i, 1995.5, 1518.0, 2006.0, 1569.0, 110);

}
return 1;
}



public MoneyGrubScoreUpdate()
{
new CashScore;
new name[MAX_PLAYER_NAME];
fnm
if (IsPlayerConnected(i))
{
GetPlayerName(i, name, sizeof(name));
CashScore = GetPlayerMoney(i);
SetPlayerScore(i, CashScore);
if (CashScore > CashScoreOld)
{
CashScoreOld = CashScore;
}
}
}
}
//-=-=-=-=-=
#define cblue	0x6495EDAA
//#define red		0xFF0000AA
#define orange	0xFF9900AA
//#define green	0x16EB43FF




new InShamal[MAX_PLAYERS];
new Float:ShamalPos[MAX_VEHICLES][3];
new sExplode[MAX_VEHICLES], tCount[MAX_VEHICLES];

new Float:difc[13][4] = {
{1.13, 0.05, 1.10, 0.0},
{1.13, 2.35, 1.10, 180.0},
{1.13, 4.65, 1.10, 180.0},
{1.13, 1.05, 1.10, 0.0},
{1.13, 3.45, 1.10, 180.0},
{1.13, 5.85, 1.10, 180.0},
{1.13, 0.39, 0.56, 0.0},
{1.13, 2.69, 0.56, 180.0},
{1.13, 4.99, 0.56, 180.0},
{1.13, 0.71, 0.56, 0.0},
{1.13, 3.79, 0.56, 180.0},
{1.13, 6.19, 0.56, 180.0},
{0.00, 0.30, 1.10, 0.0}
};

forward ExplodeShamal(vehicleid);

stock CreateShamalInt(vehicleid, Float:X, Float:Y, Float:Z)
{
	CreateDynamicObject(14404, X, Y, Z, 0.0, 0.0, 0.0);
	CreateDynamicObject(1562, floatadd(X, difc[0][0]), floatadd(Y, difc[0][1]), floatsub(Z, difc[0][2]), 0.0, 0.0, difc[0][3]);
	CreateDynamicObject(1562, floatadd(X, difc[1][0]), floatsub(Y, difc[1][1]), floatsub(Z, difc[1][2]), 0.0, 0.0, difc[1][3]);
	CreateDynamicObject(1562, floatadd(X, difc[2][0]), floatsub(Y, difc[2][1]), floatsub(Z, difc[2][2]), 0.0, 0.0, difc[2][3]);
	CreateDynamicObject(1562, floatsub(X, difc[3][0]), floatsub(Y, difc[3][1]), floatsub(Z, difc[3][2]), 0.0, 0.0, difc[3][3]);
	CreateDynamicObject(1562, floatsub(X, difc[4][0]), floatsub(Y, difc[4][1]), floatsub(Z, difc[4][2]), 0.0, 0.0, difc[4][3]);
	CreateDynamicObject(1562, floatsub(X, difc[5][0]), floatsub(Y, difc[5][1]), floatsub(Z, difc[5][2]), 0.0, 0.0, difc[5][3]);
	CreateDynamicObject(1563, floatadd(X, difc[6][0]), floatadd(Y, difc[6][1]), floatsub(Z, difc[6][2]), 0.0, 0.0, difc[6][3]);
	CreateDynamicObject(1563, floatadd(X, difc[7][0]), floatsub(Y, difc[7][1]), floatsub(Z, difc[7][2]), 0.0, 0.0, difc[7][3]);
	CreateDynamicObject(1563, floatadd(X, difc[8][0]), floatsub(Y, difc[8][1]), floatsub(Z, difc[8][2]), 0.0, 0.0, difc[8][3]);
	CreateDynamicObject(1563, floatsub(X, difc[9][0]), floatsub(Y, difc[9][1]), floatsub(Z, difc[9][2]), 0.0, 0.0, difc[9][3]);
	CreateDynamicObject(1563, floatsub(X, difc[10][0]), floatsub(Y, difc[10][1]), floatsub(Z, difc[10][2]), 0.0, 0.0, difc[10][3]);
	CreateDynamicObject(1563, floatsub(X, difc[11][0]), floatsub(Y, difc[11][1]), floatsub(Z, difc[11][2]), 0.0, 0.0, difc[11][3]);
	CreateDynamicObject(14405, X, floatsub(Y, difc[12][1]), floatsub(Z, difc[12][2]), 0.0, 0.0, difc[12][3]);
	ShamalPos[vehicleid][0] = X, ShamalPos[vehicleid][1] = Y, ShamalPos[vehicleid][2] = Z;
}


stock SetPlayerPosInShamal(playerid, shamalid)
{
	SetPlayerPos(playerid, ShamalPos[shamalid][0],
	floatsub(ShamalPos[shamalid][1], 5.87),
	floatsub(ShamalPos[shamalid][2], 0.75));
	SetPlayerFacingAngle(playerid, 0.0);
	SetCameraBehindPlayer(playerid);
}

stock ShamalExists(vehicleid)
{
	if (floatsqroot(floatadd(ShamalPos[vehicleid][0], floatadd(ShamalPos[vehicleid][1], ShamalPos[vehicleid][2]))))
	{
		return 1;
	}
	return 0;
}



stock randomEx(randval)
{
	new rand1 = random(2), rand2;
	if (!rand1) rand2 -= random(randval);
	else rand2 += random(randval);
	return rand2;
}

#define MinWarPlayers 1




new Float:gRandomWarSpawns[][3] = {
{81.8166,2479.7197,32.6381}, 
{76.6413,2482.6677,24.2397}, 
{67.9842,2487.0759,16.4844}, 
{52.3274,2500.3562,16.4844}, 
{34.2155,2502.4924,16.4844}, 
{84.8110,2506.4153,18.4438}, //WarRandomSpawn 6
{167.6369,2506.9700,16.4844}, //WarRandomSpawn 7
{81.8166,2479.7197,32.6381}, 
{76.6413,2482.6677,24.2397}, 
{67.9842,2487.0759,16.4844}, 
{52.3274,2500.3562,16.4844}, 
{34.2155,2502.4924,16.4844}, 
{84.8110,2506.4153,18.4438}, //WarRandomSpawn 6
{167.6369,2506.9700,16.4844}, //WarRandomSpawn 7
{81.8166,2479.7197,32.6381}, 
{76.6413,2482.6677,24.2397}, 
{67.9842,2487.0759,16.4844}, 
{52.3274,2500.3562,16.4844}, 
{34.2155,2502.4924,16.4844}, 
{84.8110,2506.4153,18.4438}, //WarRandomSpawn 6
{167.6369,2506.9700,16.4844} //WarRandomSpawn 7
 };
#define P_OFFSET    3





new Float:Sniper[][3] = {
{-1811.2028,-1618.1361,23.0156}, 
{-1824.7434,-1621.5146,23.0156},
{-1790.8617,-1648.6818,33.4375},
{-1820.1929,-1669.3990,23.7109},
{-1826.4819,-1687.6565,23.7031},
{-1826.4122,-1699.6692,24.6092},
{-1829.8638,-1704.3828,27.2813},
{-1846.5491,-1708.2533,41.1139},
{-1857.6595,-1695.8116,42.9788},
{-1927.3993,-1734.4781,22.8856},
{-1926.0743,-1689.7908,21.7500}
};
//


forward weaponanti(playerid);
new AntiOff;
//---
/*
new Bots[][24] = {
{"Carl"},
{"Rocky"},
{"Pepe"},
{"Arnoldo"},
{"SgtPepper"},
{"Pepsi"},
{"Pepno"},
{"Azucar"},
{"Vino_Toro"},
{"Zoquete"},
{"Pacman"},
{"Batman"},
{"AquilesBrinco"},
{"Manfrey"},
{"Papirola"},
{"Sopapeala"},
{"Lavis[MT]"},
{"[MT]Lavis"},
{"Labrik[VIP]"},
{"[ViP]Labrik"},
{"Sony"} };
*/
#define COLOR_BGREEN 0x08FD04FF


//AT-400

#define CYAN 0x99FFFFAA
#define BLUE1 0x00FFFFAA
#define BLUE2 0x09DF6FF
#define RED 0xFF0000AA
#define RED2 0xAA3333AA
#define GREEN 0x33FF33AA
#define WHITE 0xFFFFFFAA
#define ORANGE 0xFF9900AA
#define BLACK 0x00000000
#define LIGHTBLUE 0x33CCFFAA
#define LIGHGREENS 0x0F66AFF
#define MyColor 0x0B6F6FF

//=====================================News=====================================

//---
#define DEAD_TIMER_ID -666
#define LIBRE 0
#define ESTA_LLAMANDO 1
#define LO_ESTAN_LLAMANDO 2
#define ESTA_HABLANDO 3
#define PRECIO_FICHA 2
#define DIST 20.0
//-----------------------
new CellState[MAX_PLAYERS];
new AuxiliarTel[MAX_PLAYERS];
new CellTime[MAX_PLAYERS];
new TimerLLamando[MAX_PLAYERS]={DEAD_TIMER_ID,...};
new TimerCaidaFicha[MAX_PLAYERS]={DEAD_TIMER_ID,...};
new Numero_Tel[MAX_PLAYERS];
//Memoria telefono ---------------------
enum Memory_slot_salida{
	numero_telefono,
	Nombre[MAX_PLAYER_NAME],
	costo
	};
new MemorySalida[MAX_PLAYERS][5][Memory_slot_salida];

enum Memory_slot_entrada{
	numero_telefono2,
	Nombre2[MAX_PLAYER_NAME]
	};
new MemoryEntrada[MAX_PLAYERS][5][Memory_slot_entrada];
//Memoria SMS ---------------------
enum sms_slot_enviados{
	numeroSMS1,
	NombreSMS1[MAX_PLAYER_NAME],
	SMS1[120]
	};
new SMSEnviados[MAX_PLAYERS][5][sms_slot_enviados];
enum sms_slot_recibidos{
	numeroSMS2,
	NombreSMS2[MAX_PLAYER_NAME],
	SMS2[120]
	};
new SMSRecibidos[MAX_PLAYERS][5][sms_slot_recibidos];
//-----------------------
forward ColgarTelefonino(playerid);
forward Llamando(callerid,receiverid);
forward CaidaDeFicha(playerid);
//-----------------------
public CaidaDeFicha(playerid)
{
    CellTime[playerid]++;
    if (CellTime[playerid]*PRECIO_FICHA>GetPlayerMoney(playerid))
    {
        OnPlayerCommandText(playerid,"/Hangup");

    }
}
//-----------------------
msgInfo(playerid,text[])
{
	new msg[255];
    format(msg,255,"%s",text);
    SendClientMessage(playerid, lblue, msg);
    return 1;
}

//=[GetDP]=========================================================
Float:GDTP(playerid,Float:x2,Float:y2,Float:z2)
{
if (IsPlayerConnected(playerid))
{
new Float:x1,Float:y1,Float:z1;
GetPlayerPos(playerid,x1,y1,z1);
return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}
return 9999.9;
}
//-----------------------
AlTelefono(playerid,text[])
{
    new msg[255];
    format(msg,255,"[Phone] %s",text);
    SendClientMessage(playerid, COLOR_LIGHTGREEN, msg);
    return 1;
}
//-----------------------

//-----------------------
public Llamando(callerid,receiverid)
{
	if ((!IsPlayerConnected(receiverid))&&(IsPlayerConnected(callerid)))
	{

	    if  (TimerLLamando[callerid]!=DEAD_TIMER_ID)
	    {
	    	KillTimer(TimerLLamando[callerid]);
	    	TimerLLamando[callerid]=DEAD_TIMER_ID;
	    	TimerLLamando[receiverid]=DEAD_TIMER_ID;
	    	CellState[callerid]=LIBRE;
	    	CellState[receiverid]=LIBRE;
		}
		return 1;
	}
	if ((IsPlayerConnected(receiverid))&&(!IsPlayerConnected(callerid)))
	{

	    if  (TimerLLamando[receiverid]!=DEAD_TIMER_ID)
	    {
	    	KillTimer(TimerLLamando[receiverid]);
	    	TimerLLamando[callerid]=DEAD_TIMER_ID;
	    	TimerLLamando[receiverid]=DEAD_TIMER_ID;
	    	CellState[callerid]=LIBRE;
	    	CellState[receiverid]=LIBRE;
		}
		return 1;
	}
	if ((!IsPlayerConnected(receiverid))&&(!IsPlayerConnected(callerid)))
	{
	    if  (TimerLLamando[callerid]!=DEAD_TIMER_ID)
	    {
	    	KillTimer(TimerLLamando[callerid]);
		}
  		if  (TimerLLamando[receiverid]!=DEAD_TIMER_ID)
	    {
	    	KillTimer(TimerLLamando[receiverid]);
		}
		TimerLLamando[callerid]=DEAD_TIMER_ID;
 		TimerLLamando[receiverid]=DEAD_TIMER_ID;
 		CellState[callerid]=LIBRE;
  		CellState[receiverid]=LIBRE;
  		return 1;
	}
	if  ((CellState[callerid] == ESTA_LLAMANDO)&&(CellState[receiverid] == LO_ESTAN_LLAMANDO))
	{
		new msg[256];
		new callerName[MAX_PLAYER_NAME];


	    GetPlayerName(callerid, callerName, sizeof(callerName));
	    format(msg, sizeof(msg), "...[/Answer] - .לענות לשיחה, %s :מתקשר", callerName);
		SendClientMessage(receiverid,0x0F482FF,msg);
		new Float:x1,Float:y1,Float:z1;
		GetPlayerPos(receiverid,x1,y1,z1);

		return 1;
	}
	return 1;
}

//=[Phoneinfo]=============================================
public ColgarTelefonino(playerid)return SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
//=[New`s]====================================================
//Other:
new spamkick[MAX_PLAYERS];
new antispam[MAX_PLAYERS];
new spawnloged[MAX_PLAYERS];
new pickupammu;
new TheWeed[MAX_PLAYERS];
new helpme[MAX_PLAYERS];
new sam22[MAX_PLAYERS];
new sam33[MAX_PLAYERS];
new sam44[MAX_PLAYERS];
new ThePetsInYou[MAX_PLAYERS];
new TorYou[MAX_PLAYERS];
new SharkYou[MAX_PLAYERS];
new DolpYou[MAX_PLAYERS];
new PetInWar[MAX_PLAYERS];
new shipworked=0;
new InLcTeleport[MAX_PLAYERS];
new isafk[MAX_PLAYERS];
new Ignore[MAX_PLAYERS][MAX_PLAYERS];
new MoneyWinnerKart;
new MoneyWinnerMonster;
new MoneyWinnerWar;
new MoneyWinnerMini;
new cancelpm[MAX_PLAYERS];
new RaceCP[MAX_PLAYERS];
new IFraceOn;
new RacePlayers;
new Youregisterrace[MAX_PLAYERS];
new WinnerRace;
new RaceEnd;
new EndSytems;
new DriftCP[MAX_PLAYERS];
new IFDriftOn;
new DriftPlayer;
new YouRegister[MAX_PLAYERS];
new WinnerDrift;
new DriftEnd;
new UnSystems;
new RunSystemon;
new RunPlayers;
new Registertrs[MAX_PLAYERS];
new RunSystemend;
new CPTriatlon[MAX_PLAYERS];
new EndSystemTriatlon;

new BikeOn;
new CountBiker;
new BikePlayers;
new InBike[MAX_PLAYERS];
new BikeWinner;
//=[Challenge]=================
//=====================================NeChaStart=====================================
#define MinChaPlayers 1
new ChaOn;
new InCha[MAX_PLAYERS];
new ChaPlayers;
new Chaadminsname[MAX_PLAYER_NAME];
new CountChallenge;
new ChaNoobs;
new CountChallengeFuc;
new ChaPras;
new kboobcha[256];
new ChaWinner;
new CHATIME;
new CHASECX;
new ChaStart;
new PChain[MAX_PLAYERS];
#define CHA_OBJECT 90
new CheDelObject[CHA_OBJECT];
//=============================Random Cha Spawns================================




new Float:ChaSpawn[][3] = {
{1776.5786,-2449.8689,13.5547}, //ChaRandomSpawn 1
{1776.5786,-2449.8689,13.5547}, //ChaRandomSpawn 2
{1764.3571,-2451.1267,13.5547}, //ChaRandomSpawn 3
{1761.9210,-2456.7336,13.5547}, //ChaRandomSpawn 4
{1764.8960,-2460.2324,13.5547}, //ChaRandomSpawn 5
{1766.5360,-2460.2256,13.5547}, //ChaRandomSpawn 6
{1769.2766,-2460.3574,13.5547}, //ChaRandomSpawn 7
{1771.8152,-2463.4224,13.5547}, //ChaRandomSpawn 8
{1770.2825,-2466.7163,13.5547}, //ChaRandomSpawn 9
{1775.1627,-2468.1580,13.5547}, //ChaRandomSpawn 10
{1774.8768,-2469.8367,13.5547}, //ChaRandomSpawn 11
{1781.6393,-2468.0876,13.5547}, //ChaRandomSpawn 12
{1789.9117,-2462.4084,13.5547}, //ChaRandomSpawn 13
{1793.7194,-2457.6177,13.5547}, //ChaRandomSpawn 14
{1794.2030,-2451.3013,13.5547}, //ChaRandomSpawn 15
{1788.0260,-2444.2678,13.5547}, //ChaRandomSpawn 16
{1782.4506,-2442.1667,13.5547}, //ChaRandomSpawn 17
{1761.5686,-2464.7275,13.5547}, //ChaRandomSpawn 18
{1761.6018,-2468.7795,13.6527}, //ChaRandomSpawn 19
{1772.0103,-2471.7104,13.6527},
{1774.8865,-2475.2209,14.1161},
{1779.6394,-2477.5469,14.3361},
{1787.7645,-2475.3965,14.4341},
{1793.6322,-2473.7068,14.4341},
{1798.6202,-2461.1741,14.5314}
};
//=[Yup`s]=======================
//enum e_STATE
//{
//e_STATE_NONE,e_STATE_CONNECTED,e_STATE_UPDATING
//}
//new gLastUpdate[MAX_PLAYERS],e_STATE:gState[MAX_PLAYERS] = {e_STATE_NONE, ...};
//#define MAX_AFK_TIME (2000)

//forward KickUpdate();
new Sagebir[MAX_PLAYERS];
//new Text:Textdraw1;
//==[ChangeHostName]=======================
//new changehn = 1;
//forward AutoChangeHN();
//==[LACY]===================================
#define SHOW_KICK_REASON true
// Money Cheat
#define MONEY_CHEAT_USE true
#define MONEY_CHEAT_TIMER 6000
#define MONEY_CHEAT_MIN 3000000
#define MONEY_CHEAT_WARNINGS 1
#define MONEY_CHEAT_PUNISH 2
// colors
#define COLOR_ADMIN_MESSAGE 0x283669FF
#define COLOR_REASON 0x6699FFFF
#define COLOR_BAN_MESSAGE 0x68FFCBFF
#define COLOR_KICK_MESSAGE 0x68FFCBFF
//16165A
#if MONEY_CHEAT_USE
new moneycheat_warnings[MAX_PLAYERS][2];
new moneycheat_lastamount[MAX_PLAYERS];
new money[MAX_PLAYERS];
#endif

new Kicked[MAX_PLAYERS];

forward moneycheat_check();
forward weapons_check();
forward crasfly_check();
forward carsfly_check();
forward CheckPlayerForGodMod(playerid, num);
forward CheckPlayerForAntiFreeze(playerid, num);
new InCall[MAX_PLAYERS];
new fuxm[256];

//=====================================News=====================================
#define MinMPlayers 1
new KartOn;
new InKart[MAX_PLAYERS];
new KartPlayers;
new Countk;
new knoobk;
new caridxx[MAX_PLAYERS];
new CountFuck;
new KartWinner;
new KCheckTime;
new KCheckSec;
new KS;
new KK[MAX_PLAYERS];
new Fuck[MAX_PLAYERS];
new Kart_Var[200];
new Float:KartRandom[10][4] = {
	{ 2036.9589, -2051.4178, 34.2933, 0.4738 },
	{ 2033.2308, -2051.4561, 34.2929, 2.1322 },
	{ 2029.4987, -2051.5254, 34.2993, 359.7239 },
	{ 2025.8297, -2051.4551, 34.3019, 1.0429 },
	{ 2022.4488, -2051.4039, 34.2995, 0.0785 },
	{ 2037.2677, -1982.5828, 34.2989, 178.386 },
	{ 2033.5426, -1982.6452, 34.2999, 179.1564 },
	{ 2030.0574, -1982.662, 34.2994, 179.5516 },
	{ 2026.487, -1982.7485, 34.2991, 181.7884 },
	{ 2022.6494, -1982.8328, 34.2989, 179.7178 }
};

//new Fucs;
#define lblueGREEN 0x0F66FFF
//=============================Random War Spawns================================
/*
new Float:MSpawns[][4] = {
{2036.9590,-2051.4177,34.2933,0.4739},
{2033.2308,-2051.4561,34.2930,2.1323},
{2029.4988,-2051.5254,34.2993,359.7239},
{2025.8297,-2051.4551,34.3020,1.0430},
{2022.4489,-2051.4038,34.2996,0.0786},
{2037.2677,-1982.5828,34.2990,178.3861},
{2033.5426,-1982.6451,34.2999,179.1564},
{2030.0575,-1982.6620,34.2995,179.5516},
{2026.4871,-1982.7484,34.2992,181.7884},
{2022.6494,-1982.8328,34.2990,179.7178}
};
*/

//=====================================News=====================================
#define MiNmOnsterPlayers 1
new MonsterOn;
new iNmOnster[MAX_PLAYERS];
new MonsterPlayers;
new MonsterCount;
new MonNoob;
new CountMoneterfu;
new MonsterFux[256];
new MonsterWinner;
new MCheckTimeMonster;
new MoOn;
new KcheckMonster;
new MonsterNoTeleportion[MAX_PLAYERS];
new MonsterFucker[MAX_PLAYERS];
new MonsterSYSTEM[MAX_PLAYERS];
new MonStart[MAX_PLAYERS];
new Monster_Var[200];
new Float:MonsterRandom[30][4] = {
	{ -1281.1554, 994.8486, 1037.6104, 88.3429 },
	{ -1282.0687, 987.9168, 1037.5026, 80.9241 },
	{ -1281.3506, 1001.1743, 1037.7189, 96.1026 },
	{ -1282.8987, 1009.0059, 1037.8527, 107.3637 },
	{ -1286.0485, 1015.5355, 1037.9691, 116.0817 },
	{ -1505.6598, 1021.6973, 1038.4505, 227.5877 },
	{ -1495.2828, 1032.7757, 1038.6156, 220.4797 },
	{ -1283.6548, 981.624, 1037.3925, 70.7936 },
	{ -1286.3497, 975.3618, 1037.3009, 58.5153 },
	{ -1290.1001, 969.6478, 1037.2069, 57.164 },
	{ -1294.9491, 1027.7661, 1038.1846, 138.9463 },
	{ -1294.0604, 964.0651, 1037.1164, 47.944 },
	{ -1298.9483, 959.2191, 1037.0499, 39.9045 },
	{ -1304.2948, 955.2288, 1036.991, 35.7058 },
	{ -1500.9487, 1027.1394, 1038.5323, 228.9902 },
	{ -1514.8537, 993.9699, 1038.012, 272.7786 },
	{ -1482.4313, 1041.9403, 1038.7481, 210.1206 },
	{ -1511.5805, 979.0001, 1037.7557, 289.6034 },
	{ -1508.5096, 971.9116, 1037.6334, 301.1151 },
	{ -1289.7208, 1021.0579, 1038.0678, 124.5565 },
	{ -1300.5868, 1032.2583, 1038.2734, 144.2774 },
	{ -1489.1873, 1037.6508, 1038.6903, 213.7796 },
	{ -1307.5302, 1036.6835, 1038.3592, 152.1656 },
	{ -1514.4672, 1001.7064, 1038.1322, 263.1411 },
	{ -1512.6346, 1008.9055, 1038.2487, 249.2474 },
	{ -1513.658, 986.5009, 1037.8825, 281.8439 },
	{ -1509.725, 1015.5227, 1038.3507, 243.3453 },
	{ -1503.3624, 965.1447, 1037.5095, 317.9805 },
	{ -1477.1889, 1044.7204, 1038.7884, 203.0258 },
	{ -1469.1869, 1047.9875, 1038.8229, 202.8518 }
};

//=
new Flayeri[MAX_PLAYERS];
new aDoing[MAX_PLAYERS];
/*
//=[AFKicker]==========================================
//new`s:
new Float:AFKPos[MAX_PLAYERS][6];
//define:
#define AFK_TIMES 					120
*/
//=[AntiFake]==========================================
new FakeKill[MAX_PLAYERS];
//=[Ks]================================================
new PlayerKills[MAX_PLAYERS];
new MoneyKillOnPlayer[MAX_PLAYERS];
//=[TextMovie]==========================================
//new
//Text:Box1,
//Text:Box2;
//=/NoMore/============================================
//new NoMoreObject[MAX_PLAYERS];
//=/Camrea/============================================
new CamreaRandom;
//=/AirStrike/==========================================
new AirStrikeTil[MAX_PLAYERS];
new AirStrikeTil2[MAX_PLAYERS];
new AirStrikeTil3[MAX_PLAYERS];
new AirStrikeExplodes[MAX_PLAYERS];
new AirStrikeInWar[MAX_PLAYERS];
new Explodeion[MAX_PLAYERS];
new Float:airstrikex,Float:airstrikey,Float:airstriakez;
//=[Drift Private]========================================
new driftwinner[MAX_PLAYERS]=0;
new DriftInvite[MAX_PLAYERS]=0;
new IfInvite[MAX_PLAYERS] = 0;
new PrivateCP[MAX_PLAYERS] = 0;
new DriftNoNow = 0;
new indrift[MAX_PLAYERS];
//=[InDm]===============================================
new InDM[MAX_PLAYERS];
new WeaponDM[MAX_PLAYERS];
new Float:DMPostion[][3] =
{
{2613.9866,	2848.4475,	19.9922},{2647.6553,	2805.0278,	10.8203},
{2611.5500,	2845.7542,	16.7020},{2545.9243,	2839.1824,	10.8203},
{2672.9387,	2800.3374,	10.8203},{2672.8306,	2792.1057,	10.8203},
{2647.7834,	2697.5884,	19.3222},{2654.5427,	2720.3474,	19.3222},
{2653.2063,	2738.2432,	19.3222},{2685.8875,	2816.6575,	36.3222},
{2641.1350,	2703.2019,	25.8222},{2599.1304,	2700.7249,	25.8222},
{2606.1384,	2721.5237,	25.8222},{2597.3745,	2748.0884,	23.8222},
{2595.0657,	2776.6729,	23.8222},{2601.3640,	2777.8101,	23.8222},
{2584.3940,	2825.1748,	27.8203},{2631.8110,	2834.2593,	40.3281},
{2632.2852,	2834.9390,	122.9219},{2646.1997,	2817.7070,	36.3222},
{2691.1233,	2787.7883,	59.0212},{2717.8071,	2771.3464,	74.8281},
{2695.2622,	2699.5488,	22.9472},{2688.8206,	2689.0039,	28.1563},
{2655.0229,	2650.6807,	36.9154},{2570.4668,	2701.2876,	22.9507},
{2498.9915,	2704.6204,	10.9844},{2524.1584,	2743.3735,	10.9917},
{2498.3167,	2782.3357,	10.8203},{2504.5142,	2805.9763,	14.8222},
{2522.2144,	2814.7087,	24.9536},{2510.6292,	2849.6384,	14.8222},
{2618.2646,	2720.8005,	36.5386},{2690.9980,	2741.9060,	19.0722},
{2544.5032,	2805.8840,	19.9922},{2556.2554,	2832.5313,	19.9922},
{2561.9175,	2848.5532,	19.9922}
};
//=
new file[256];
///=[NmClan]============================================

new NM2,NM1,
NM3;
new
RoX1,
RoX2,
RoX3,
RoX4,
RoX5;/*
new IDF1,
IDF2,
IDF3,
IDF4,
IDF5,
IDF6,
IDF7,
IDF8,
IDF9,
IDF10,
IDF11;
*/
new AnsTrivia1;
new MaxAns[MAX_PLAYERS];
new TriviaOn =0;
new InTheServer;
//==[];
//==
/*

new Text:TextLevel;
new Text:TextBank;
new Text:TextKills;
new desting[256],desting2[256],desting3[256];
*/


new AirBreakVar[MAX_PLAYERS];
new SetDistance[MAX_PLAYERS];
forward AfterPlayerConnect(playerid);
forward OnGetPlayerKeys();
new BankShipOn[MAX_PLAYERS];
new AtBank[MAX_PLAYERS];

new Spectatorl[MAX_PLAYERS];
//=[Hasbon]=======
forward Maths();

new answer;
new answered;
new score;

//=[JumpKill]================
#define OVERALLFILE "JumpHighscores.cfg"
#define PERSONALFILE "PersonalJumpHighscores.cfg"
#define DEFAULT_BIKEMODEl 522   //NRG-500

new TimerJumpkill1, TimerJumpkill2, TimerJumpkill3, MaxTimer;
new RaceJumpKill = -1;
new Motor;
new DestroyPlayerObject2[45];
new Float:HS[3], HSN[3][MAX_PLAYER_NAME];
new Text:TD3;

new TDS4[128] = " ";
new LasttmpX;
new Countkilljump;
new TimeLeft;
new Float:Distance;
new BikeModel = DEFAULT_BIKEMODEl;
//==[Spsps]
#define Hq1 "TesT"
#define COLOR_WHITE 0xFFFFFFAA
#define green	0x16EB43FF
//#define COLOR_BRIGHTRED 0xDC143CAA
#define COLOR_KRED 0xFF0000FF
#define COLOR_ORANGE 0xFF9900AA

//=================HQ Gates===================
//new Hq1_Gate1,Hq1_Gate2;
//
new InviteClanName[MAX_PLAYERS][256];

new iname[MAX_PLAYER_NAME];
new strings[256];
new IsInvited[MAX_PLAYERS];
new ClanMute[200];
//=[RacesCity]==========================================
//------------------------------------------------------------------------
new CityRaceingOn;
new CountCityRaceingr;
new CityRaceingPlayers;
new InCityRaceing[MAX_PLAYERS];
new InCityRaceing2[MAX_PLAYERS];

//new CityRaceingWinner;




new CityCP[MAX_PLAYERS];
new Float:CityCPs[][] = {
	{ -2681.6155, 1385.0377, 55.7396 },
	{ -2681.4651, 1919.1546, 61.0437 },
	{ -2697.7225, 2221.4526, 56.2765 },
	{ -2758.7439, 2388.2363, 74.9199 },
	{ -2712.2029, 2611.9533, 75.4089 },
	{ -2340.6658, 2659.0546, 58.1657 },
	{ -1963.0933, 2533.8989, 55.5418 },
	{ -1852.8233, 2284.8784, 30.2315 },
	{ -1643.6813, 2063.7575, 19.0032 },
	{ -1578.2287, 1749.483, 6.9282 },
	{ -1197.9574, 1644.8741, 14.767 },
	{ -1085.7442, 1330.5146, 30.8293 },
	{ -1179.6747, 1057.9334, 41.0684 },
	{ -1514.8956, 705.8262, 45.533 },
	{ -1737.1293, 476.5994, 38.5402 },
	{ -1877.1519, 204.8157, 38.5435 },
	{ -1905.079, -89.1605, 38.1693 },
	{ -2114.4105, -341.6781, 35.2356 },
	{ -2464.4302, -331.8881, 32.8455 },
	{ -2783.3343, -471.3014, 7.1434 },
	{ -2808.3924, -191.6816, 6.9583 },
	{ -2809.3165, 123.6539, 6.9583 },
	{ -2853.973, 360.5227, 4.2786 },
	{ -2866.8079, 762.6663, 32.1823 },
	{ -2846.2149, 985.1699, 42.8241 },
	{ -2702.8167, 1289.8968, 6.9677 },
	{ -2455.5655, 1378.2169, 6.9661 },
	{ -2463.3711, 1212.3585, 35.013 },
	{ -2641.9666, 1209.1645, 54.9051 },
	{ -2681.938, 1310.6881, 55.3563 }
};
new Player_Var[200];
new Float:RandomCityRace[10][4] = {
	{ -2666.3172, 1289.1536, 55.3568, 0.0299 },
	{ -2666.3172, 1289.1536, 55.3568, 0.0299 },
	{ -2671.3523, 1289.151, 55.3568, 0.0299 },
	{ -2674.3646, 1289.1494, 55.3568, 0.0299 },
	{ -2678.2332, 1289.1474, 55.3568, 0.0299 },
	{ -2681.8919, 1289.1453, 55.4794, 0.0269 },
	{ -2684.8765, 1289.1441, 55.3566, 0.0263 },
	{ -2688.6199, 1289.1427, 55.3568, 0.0263 },
	{ -2692.3455, 1289.1412, 55.3568, 0.0263 },
	{ -2696.232, 1289.1396, 55.3568, 0.0263 }
};

new Float:CityCPs2[16][3] = {
	{ 1797.1652, 827.1301, 10.384 },
	{ 1779.6129, 660.8189, 17.6368 },
	{ 1624.659, 161.5484, 34.6158 },
	{ 1671.3366, -218.6762, 40.7969 },
	{ 1712.7089, -615.1827, 39.2582 },
	{ 1621.2169, -1255.9715, 46.7983 },
	{ 1642.701, -1903.1456, 24.7618 },
	{ 1410.4205, -2130.908, 13.274 },
	{ 1339.2908, -2336.4273, 13.274 },
	{ 1441.4157, -2677.1683, 13.274 },
	{ 1961.9316, -2678.7171, 7.5785 },
	{ 2168.2424, -2491.1146, 13.1021 },
	{ 2364.9228, -2200.4444, 13.274 },
	{ 2830.3005, -2064.8848, 10.8285 },
	{ 2851.205, -1724.3736, 10.774 },
	{ 2887.9311, -1592.2507, 10.7739 }
};

new Float:RandomCityRace2[6][4] = {
	{ 1978.4151, 858.2166, 6.4875, 90.4604 },
	{ 1978.4483, 852.1555, 6.4808, 90.0464 },
	{ 1978.2237, 846.3413, 6.4808, 89.7397 },
	{ 1978.5546, 840.0485, 6.4808, 90.9219 },
	{ 1978.7042, 834.2664, 6.4808, 89.1363 },
	{ 1979.5729, 828.0966, 6.4913, 90.9969 }
};
new Text:Textdraw1;
//=[Gre]
#define MinGrePlayers 1
new GreOn;
new InGre[MAX_PLAYERS];
new GrePlayers;
new Greadminsname[MAX_PLAYER_NAME];
new CountGrellenge;
new GreKnoob;
new CountGrellengeFuc;
new GrePras;
new kboobGre[256];
new GreWinner;
new GreTIME;
new GreSECX;
new GreStart;
new PGrein[MAX_PLAYERS];
//=============================Random Gre Spawns================================
new Float:GreSpawn[][3] = {

	{ 1305.1094, 2174.8198, 11.0234 },
	{ 1305.0904, 2154.8676, 11.0234 },
	{ 1305.239, 2127.6809, 11.0234 },
	{ 1318.2463, 2106.8115, 11.0156 },
	{ 1341.0291, 2107.0363, 11.0156 },
	{ 1354.9804, 2106.8081, 11.0156 },
	{ 1390.6857, 2123.3229, 11.0234 },
	{ 1390.3448, 2147.2246, 11.0234 },
	{ 1394.7436, 2168.6896, 9.7578 },
	{ 1386.8294, 2191.8071, 11.0234 },
	{ 1368.9271, 2196.3488, 9.7578 },
	{ 1351.9296, 2192.507, 11.0234 },
	{ 1335.7751, 2192.5571, 11.0234 },
	{ 1365.8359, 2195.5227, 14.2495 },
{ 1394.6379, 2170.5107, 14.2495 }

 };
//=[Connected]==========================================
public OnPlayerConnect(playerid)
{
new str[256];
SetTimerEx("AfterPlayerConnect", 1000, 0, "i", playerid);
PlayerProps[playerid] = 0;
EarningsForPlayer[playerid] = 0;

if(!dini_Exists(GetPlayerFile(playerid)))
{

SendClientMessage(playerid,COLOR_WHITE,"»» Welcome To - Satla-Zone.co.il - DeathMatch Community »»");
SendClientMessage(playerid,0xF06E8DFF,"» Satla-Zone.co.il :תמיד תוכל לבקר בפורום שלנו ולהתעדכן »");
format(str, sizeof(str), "/Register <Password> :המערכת זיההתה אותך בתור שחקן חדש, על מנת להירשם ,%s שלום לך" ,GetName(playerid));
SendClientMessage(playerid,COLOR_LIGHTGREEN , str);
SendClientMessage(playerid,0xF6F658FF,"/Help [1-48] :לקבלת עזרה בשרת בצע/י ");
SendClientMessage(playerid,0xF6F658FF,"/Help Rules :על מנת לקרוא את החוקים של השרת בצע/י");
InTheServer ++;
}
else
{
if(dini_Int(GetPlayerFile(playerid),"autologins") == 0 && !strcmp(GetIP(playerid),dini_Get(GetPlayerFile(playerid),"LastConnectIP"),true))
{
SendClientMessage(playerid,COLOR_WHITE,"»» Welcome To - Satla-Zone.co.il - DeathMatch Community »»");
SendClientMessage(playerid,0xF06E8DFF,"» Satla-Zone.co.il :תמיד תוכל לבקר בפורום שלנו ולהתעדכן »");
format(str, sizeof(str), ".שלך, תהנה IPהתחברת אוטומטית לפי כתובת ה !%s שלום לך", GetName(playerid));
SendClientMessage(playerid, COLOR_LIGHTGREEN, str);
SendClientMessage(playerid,0xF6F658FF,"/Help [1-48] :לקבלת עזרה בשרת בצע/י ");
SendClientMessage(playerid,0xF6F658FF,"/Help Rules :על מנת לקרוא את החוקים של השרת בצע/י");

LoginPlayer(playerid);
PlayerInfo[playerid][TimeOnServer] +=1;
PlayerInfo[playerid][Logged] = 1;
InTheServer ++;
}
else
{
SendClientMessage(playerid,COLOR_WHITE,"»» Welcome To - Satla-Zone.co.il - DeathMatch Community »»");
SendClientMessage(playerid,0xF06E8DFF,"» Satla-Zone.co.il :תמיד תוכל לבקר בפורום שלנו ולהתעדכן »");
format(str, sizeof(str), "/Login <Password> :המערכת זיההתה אותך, אנא התחבר !%s שלום לך" , GetName(playerid));
SendClientMessage(playerid,COLOR_LIGHTGREEN, str);
SendClientMessage(playerid,0xF6F658FF,"/Help [1-48] :לקבלת עזרה בשרת בצע/י ");
SendClientMessage(playerid,0xF6F658FF,"/Help Rules :על מנת לקרוא את החוקים של השרת בצע/י");

InTheServer ++;
}
}

//=[
return 1;
}


public AfterPlayerConnect(playerid)
{
TextDrawShowForPlayer(playerid,Textdraw1);
ClanMute[playerid] = 0;
IsInvited[playerid] = 0;
Spectatorl[playerid]=0;
FakeKill[playerid] = 0;
SetPlayerVars(playerid);
//=[ESC]================================================
//gState[playerid] = e_STATE_CONNECTED;
//=[FixLacy]====================================================
EnableStuntBonusForPlayer(playerid,0);
//=[CallSystem`s]================================================
CellState[playerid]=LIBRE;
AuxiliarTel[playerid]=-1;
CellTime[playerid]=0;
TimerLLamando[playerid]=DEAD_TIMER_ID;
TimerCaidaFicha[playerid]=DEAD_TIMER_ID;
Numero_Tel[playerid]=random(8998)+1000;
borrarMemorias(playerid);
BankShipOn[playerid] = 0;
AirBreakVar[playerid] = 0;
SetDistance[playerid] = 5;

SetTimerEx("FakeKills",10*1000,0,"i",playerid);

return 1;
}




forward Player();
forward cp(); forward unfreeze(playerid);
forward TimeUpdate();
forward Descongelar(playerid);
forward AutoMessage(playerid);
forward SendPlayerFormattedText(playerid, const str[], define);
forward SendAllFormattedText(playerid, const str[], define);
forward getCheckpointType(playerID);
forward PlayerLeaveGang(playerid);
forward isPlayerInArea();
forward PayPlayerInArea();
forward PirateShipScoreUpdate();
forward MoneyGrubScoreUpdate();
forward Givecashdelaytimer(playerid);
forward GrubModeReset();
forward GameModeExitFunc();


//=====================================News=====================================
new WarOnr,InWarr[MAX_PLAYERS],WarPlayersr,Countr,knoobr,CountFucr;
#define MinWarPlayersr 1
new Rewardr;
new WarWinnerr;
new CheckTimer;
new WSr;
new PPr[MAX_PLAYERS];
new WarWeaponsr[] = {35};



public OnPlayerDisconnect(playerid, reason)
{
Object_OnPlayerDisconnect(playerid, reason);
RemovePlayerFromRaces(playerid);
if(RaceJumpKill == playerid)
{
EndJumpKill();
TogglePlayerControllable(RaceJumpKill, 1);
}
if(PlayerInfo[playerid][Pets] ==1)
{
if(PlayerInfo[playerid][Shark] ==1)
{


DestroyDynamicObject(sam33[playerid]);
SharkYou[playerid] =0;
ThePetsInYou[playerid] =0;
}
if(PlayerInfo[playerid][Dolp] ==1)
{
DestroyDynamicObject(sam22[playerid]);
ThePetsInYou[playerid] =0;
DolpYou[playerid] =0;
}
if(PlayerInfo[playerid][Tor] ==1)
{
DestroyDynamicObject(sam44[playerid]);
ThePetsInYou[playerid] =0;
TorYou[playerid] =0;
}
}
if(InBike[playerid] > 0)
{
BikePlayers --;
InBike[playerid] =0;
new vehicleidss = GetPlayerVehicleID(playerid);
SetPlayerVirtualWorld(playerid,0);
SetVehicleVirtualWorld(vehicleidss,0);
}
if(PGrein[playerid] == 1) {
GrePlayers --; InGre[playerid] = 0; PGrein[playerid] = 0;
}
//=[SavePinfo]============================================================
if(dini_Exists(GetPlayerFile(playerid)) && IsPlayerLogged(playerid))
{
PlayerInfo[playerid][Logged] = 0;
dini_IntSet(GetPlayerFile(playerid),"BSHIP",PlayerInfo[playerid][BSHIP]);
dini_IntSet(GetPlayerFile(playerid),"Tor",PlayerInfo[playerid][Tor]);
dini_IntSet(GetPlayerFile(playerid),"Dolphin",PlayerInfo[playerid][Dolp]);
dini_IntSet(GetPlayerFile(playerid),"Pets",PlayerInfo[playerid][Pets]);
dini_IntSet(GetPlayerFile(playerid),"Shark",PlayerInfo[playerid][Shark]);
dini_IntSet(GetPlayerFile(playerid),"SharkKills",PlayerInfo[playerid][SharkKills]);
dini_IntSet(GetPlayerFile(playerid),"TorKills",PlayerInfo[playerid][TorKills]);
dini_IntSet(GetPlayerFile(playerid),"DolphinKills",PlayerInfo[playerid][DolphinKills]);
dini_IntSet(GetPlayerFile(playerid),"ProfileLogeed",PlayerInfo[playerid][ProfileLogged]);
dini_IntSet(GetPlayerFile(playerid),"Logged",PlayerInfo[playerid][Logged]);
dini_IntSet(GetPlayerFile(playerid),"Kills",PlayerInfo[playerid][Kills]);
dini_IntSet(GetPlayerFile(playerid),"Deaths",PlayerInfo[playerid][Deaths]);
dini_IntSet(GetPlayerFile(playerid),"Level",PlayerInfo[playerid][Level]);
dini_IntSet(GetPlayerFile(playerid),"GemelLogin",PlayerInfo[playerid][GemelLogin]);
dini_IntSet(GetPlayerFile(playerid),"KopatGemel",PlayerInfo[playerid][KopatGemel]);
dini_IntSet(GetPlayerFile(playerid),"AggInfo",PlayerInfo[playerid][AggInfo]);
dini_IntSet(GetPlayerFile(playerid),"aLevelnl",PlayerInfo[playerid][aLevelnl]);
dini_IntSet(GetPlayerFile(playerid),"aKillsnl",PlayerInfo[playerid][aKillsnl]);
dini_IntSet(GetPlayerFile(playerid),"Adminl",PlayerInfo[playerid][AdminsLevel]);
dini_IntSet(GetPlayerFile(playerid),"Wars",PlayerInfo[playerid][Wars]);
dini_IntSet(GetPlayerFile(playerid),"Karts",PlayerInfo[playerid][Kart]);
dini_IntSet(GetPlayerFile(playerid),"MonsterWin",PlayerInfo[playerid][Monster]);
dini_IntSet(GetPlayerFile(playerid),"RPGWIN",PlayerInfo[playerid][RPGS]);
dini_IntSet(GetPlayerFile(playerid),"MiniWin",PlayerInfo[playerid][MINIGUN]);
dini_IntSet(GetPlayerFile(playerid),"mlg",PlayerInfo[playerid][Mlg]);
dini_IntSet(GetPlayerFile(playerid),"Warning",PlayerInfo[playerid][Warnings]);
dini_IntSet(GetPlayerFile(playerid),"pWeeds",PlayerInfo[playerid][Weeds]);
dini_IntSet(GetPlayerFile(playerid),"TimeOnServer",PlayerInfo[playerid][TimeOnServer]);
dini_IntSet(GetPlayerFile(playerid),"Money",GetPlayerMoney(playerid));
dini_IntSet(GetPlayerFile(playerid),"autologins",PlayerInfo[playerid][autologin]);
dini_IntSet(GetPlayerFile(playerid),"GetAloan",PlayerInfo[playerid][GetAloan]);
dini_IntSet(GetPlayerFile(playerid),"MoneyLoan",PlayerInfo[playerid][MoneyLoan]);
dini_IntSet(GetPlayerFile(playerid),"armour",PlayerInfo[playerid][armourT]);
dini_IntSet(GetPlayerFile(playerid),"VIP",PlayerInfo[playerid][VIPS]);
dini_IntSet(GetPlayerFile(playerid),"CC",PlayerInfo[playerid][CcMode]);
dini_IntSet(GetPlayerFile(playerid),"SaveStrika",PlayerInfo[playerid][AirStrikeSaved]);
dini_FloatSet(GetPlayerFile(playerid),"xAir",PlayerInfo[playerid][xAirStrike]);
dini_FloatSet(GetPlayerFile(playerid),"yAir",PlayerInfo[playerid][yAirStrike]);
dini_FloatSet(GetPlayerFile(playerid),"zAir",PlayerInfo[playerid][zAirStrike]);
dini_IntSet(GetPlayerFile(playerid),"CarID",pia[playerid][CarID] );
dini_IntSet(GetPlayerFile(playerid),"OwnCar",pia[playerid][OwnCar] );
dini_IntSet(GetPlayerFile(playerid),"CarID",pia[playerid][CarID] );
dini_IntSet(GetPlayerFile(playerid),"OwnCar",pia[playerid][OwnCar] );
dini_Set(GetPlayerFile(playerid),"State","Offine");
//=[Delete]=====================================================
PlayerInfo[playerid][Warnings]=0;
PlayerInfo[playerid][VIPS] = 0;
PlayerInfo[playerid][armourT] = 0;
PlayerInfo[playerid][ProfileLogged] =0;
PlayerInfo[playerid][Warnings] = 0;
PlayerInfo[playerid][Weeds] = 0;
PlayerInfo[playerid][TimeOnServer]=0;
PlayerInfo[playerid][Logged] = 0;
PlayerInfo[playerid][Level] = 0;
PlayerInfo[playerid][Kills] = 0;
PlayerInfo[playerid][Deaths] = 0;
PlayerInfo[playerid][Bank] = 0;
PlayerInfo[playerid][Wars] = 0;
PlayerInfo[playerid][autologin] = 0;
PlayerInfo[playerid][GetAloan] =0;
PlayerInfo[playerid][MoneyLoan] =0;
PlayerInfo[playerid][AdminsLevel] = 0;
PlayerInfo[playerid][Kart] = 0;
PlayerInfo[playerid][AggInfo] =0;
PlayerInfo[playerid][GemelLogin] = 0;
PlayerInfo[playerid][KopatGemel] =0;
PlayerInfo[playerid][Monster] = 0;
PlayerInfo[playerid][RPGS] = 0;
PlayerInfo[playerid][MINIGUN] = 0;
PlayerInfo[playerid][Mlg] = 0;
PlayerInfo[playerid][CcMode] = 0;
PlayerInfo[playerid][Supportives] =0;
PlayerInfo[playerid][Tor] =0;
PlayerInfo[playerid][Pets] =0;
PlayerInfo[playerid][Shark] =0;
PlayerInfo[playerid][Dolp] =0;
PlayerInfo[playerid][SharkKills] =0;
PlayerInfo[playerid][DolphinKills]=0;
PlayerInfo[playerid][TorKills] =0;
PlayerInfo[playerid][bazooka] =0;
PlayerInfo[playerid][aLevelnl]=0;
PlayerInfo[playerid][aKillsnl]=0;
PlayerInfo[playerid][Sawn] = 0;
PlayerInfo[playerid][MicroSMG] = 0;
PlayerInfo[playerid][Tec9] = 0;
PlayerInfo[playerid][M4] = 0;
PlayerInfo[playerid][MP5] = 0;
PlayerInfo[playerid][AK47] = 0;
PlayerInfo[playerid][Knife] = 0;
PlayerInfo[playerid][Katana] = 0;
PlayerInfo[playerid][CombatShotGun] = 0;
PlayerInfo[playerid][ShotGun] = 0;
PlayerInfo[playerid][SniperRifle] = 0;
PlayerInfo[playerid][CRifle] = 0;
PlayerInfo[playerid][Colt] = 0;
PlayerInfo[playerid][Sawn] = 0;
ThePetsInYou[playerid] =0;
DolpYou[playerid] =0;
SharkYou[playerid] =0;
TorYou[playerid] =0;
//=[CarSystem`s]========================================================
pia[playerid][CarID] = 0;
pia[playerid][OwnCar] = 0;
//=[FL]==================================================================
PlayerInfo[playerid][FL] =0;
//NoMoreObject[playerid] =0;
FakeKill[playerid] = 0;
//=[ESC]==========================================================
//gState[playerid] = e_STATE_NONE;
//=[UnZibori]======================================================

//=[SetVirtualWorldCAR]=============================================
new vehicleid = GetPlayerVehicleID(playerid);
SetPlayerVirtualWorld(playerid,0);
SetVehicleVirtualWorld(vehicleid,0);
//=[UnIgnoreDisconecet]=========================================
Ignore[playerid][playerid] =0;
//=[InLcTeleport`s]===============================================
InLcTeleport[playerid] = 0;
//=[Weed`s]=======================================================
Stoned[playerid] =0;
//=[Pet`sDelete]===================================================
//==
InDM[playerid] = 0;
InBike[playerid] = 0;
PrivateCP[playerid] = 0;
driftwinner[playerid]=0;
DriftInvite[playerid] =0;
indrift[playerid] =0;
IfInvite[playerid] =0;
Explodeion[playerid] = 0;
AirStrikeInWar[playerid] =0;
//NoMoreObject[playerid] =0;
//KS:
PlayerKills[playerid] =0;
MoneyKillOnPlayer[playerid] =0;
//resert
aDoing[playerid] =0;
//=[Failed]============================================
Flayeri[playerid] =4;
//=[FixAC]=============================================
SetPlayerVars(playerid);
//=[INWARFIX]=============================================
mini[playerid] =0;
//=[FixCall]===============================================
InCall[playerid]=0;
//=[ShowTextDraw]===================================

//=[FixAge]=======================================
Sagebir[playerid]=0;
//=[Racepc]================================================
RaceCP[playerid] =0;
//=[Ignore/Cancelpm]================================================
cancelpm[playerid]=0;
Ignore[playerid][playerid] =0;
//=[Gang`s]================================================
playerGang[playerid]=0;
gangInvite[playerid]=0;
//=[ShamalMode`s]==========================================
InShamal[playerid] = 0;
//=[AntiSpamre`s]==========================================
antispam[playerid] =0;
spamkick[playerid] =0;
antianti[playerid] =0;
//=[AntiAFK]=================================================
isafk[playerid] = 0;
//=[LC]====================================================
InLcTeleport[playerid] =0;
//=[Pets]====================================================
DolpYou[playerid] =0;
SharkYou[playerid] =0;
TorYou[playerid] =0;
PetInWar[playerid] =0;
ThePetsInYou[playerid] =0;
//=[`HELP SERVER / Helpme]====================================================
helpme[playerid] =0;
//=[Weed`s]====================================================
TheWeed[playerid] =0;
//=[Other]======================================================
ClickedBm[playerid] = 0;
mini[playerid] = 0;
playerCheckpoint[playerid]=999;
bank[playerid]=0;
//=[CarSystem]===================================================
pia[playerid][CarID] = 0;
pia[playerid][OwnCar] = 0;
//=[Reason]==========================================================
}
//=[DiscPhone]=================================================================
OnPlayerCommandText(playerid,"/Hangup");
//=[OutSystem`s]================================================================
OutDrift(playerid);
if(Registertrs[playerid] ==1)
{
CPTriatlon[playerid]=0;
DisablePlayerRaceCheckpoint(playerid);
Registertrs[playerid] =0;
CPTriatlon[playerid]=0;
RunPlayers--;
}
//=[OutSystem`s]================================================================
if(YouRegister[playerid] ==1)
{
YouRegister[playerid] =0;
DisablePlayerRaceCheckpoint(playerid);
DriftPlayer--;
}
//=[OutSystem`s]================================================================
if(Youregisterrace[playerid] ==1)
{
Youregisterrace[playerid] =0;
RacePlayers--;
DisablePlayerRaceCheckpoint(playerid);
}
//=[OutSystem`s]================================================================
if(PPw[playerid] == 1)
{
ResetPlayerWeapons(playerid);
SendClientMessage(playerid,COLOR_WHITE,".עזבת את הפעילות שבא הייתה");
ResetPlayerWeapons(playerid);
WarPlayersw --; InWarw[playerid] = 0; PPw[playerid] = 0;
}
//=[OutSystem`s]================================================================
if(PP[playerid] == 1)
{
ResetPlayerWeapons(playerid);
SendClientMessage(playerid,COLOR_WHITE,".עזבת את הפעילות שבא הייתה");
WarPlayers --;
InWar[playerid] = 0;
PP[playerid] = 0;
}
if(PChain[playerid] == 1)
{
ChaPlayers --; InCha[playerid] = 0; PChain[playerid] = 0;
}
//=[OutSystem`s]================================================================
if(PPr[playerid] == 1)
{
ResetPlayerWeapons(playerid);
SendClientMessage(playerid,COLOR_WHITE,".עזבת את הפעילות שבא הייתה");
ResetPlayerWeapons(playerid);
WarPlayersr --; InWarr[playerid] = 0; PPr[playerid] = 0;
}
//=[OutSystem`s]================================================================

if(MonsterNoTeleportion[playerid] == 1)
{
MonsterPlayers --; iNmOnster[playerid] = 0; MonsterNoTeleportion[playerid] = 0; MonsterFucker[playerid] = 0;
DestroyVehicle(MonsterSYSTEM[playerid]);
MonStart[playerid] =0;
}

//=[OutSystem`s]================================================================
if(KK[playerid] == 1)
{
ResetPlayerWeapons(playerid);
SendClientMessage(playerid,COLOR_WHITE,".Kart .עזבת את הפעילות ");
KartPlayers --; InKart[playerid] = 0; KK[playerid] = 0; Fuck[playerid] = 0;
DestroyVehicle(caridxx[playerid]);
}
//=[LeaveGange`s]====================================================
PlayerLeaveGang(playerid);
//=[Prop]=============================================================

/*
new string[256];
switch(reason)
{
case 0: format(string, sizeof(string), "*** %s has left the server, (Reason: TimeOut).", GetName(playerid)),SendClientMessageToAll(COLOR_GREY, string);

}
*/
InTheServer --;
return 1;
}







//=[`Com`/Commands]===========================================================
public OnPlayerCommandText(playerid, cmdtext[])
{
new tmp[256];
new string[256],cmd[256];
new tmp2[256];
new playermoney;
new sendername[MAX_PLAYER_NAME];
new giveplayer[MAX_PLAYER_NAME];
new giveplayerid, moneys, idx;
cmd = strtok(cmdtext, idx);
if(30 < strlen(cmd)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(30 < strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
//==/R/L==
if(Youregisterrace[playerid] ==1)return SendClientMessage(playerid,COLOR_WHITE,"Race אתה לא יכול לבצע פקודות באמצע קרב");
if(YouRegister[playerid] ==1) return SendClientMessage(playerid,COLOR_WHITE,"Drift אתה לא יכול לעשות פקודות באמצע קרב");
if(Registertrs[playerid] ==1) return SendClientMessage(playerid,COLOR_WHITE,"Triatlon אתה לא יכול להשתגר באמצע תחרות");
//END
if(KK[playerid] == 1) return SendClientMessage(playerid,COLOR_WHITE,".אתה לא יכול לעשות פקודות באמצע פעילות");
if(iNmOnster[playerid] == 1) return SendClientMessage(playerid,COLOR_WHITE,".אתה לא יכול לעשות פקודות באמצע פעילות");
if(PGrein[playerid] == 1) return SendClientMessage(playerid, COLOR_RED, ".אתה במלחמת רימונים ואינך יכול להשתגר ");
if(PPw[playerid] == 1) return      SendClientMessage(playerid,COLOR_WHITE,".אתה לא יכול לעשות פקודות באמצע פעילות");
if(PP[playerid] == 1)return     SendClientMessage(playerid,COLOR_WHITE,".אתה לא יכול לעשות פקודות באמצע פעילות");
if(PPr[playerid] == 1) return      SendClientMessage(playerid,COLOR_WHITE,".אתה לא יכול לעשות פקודות באמצע פעילות");
if(PP[playerid] == 1) return      SendClientMessage(playerid,COLOR_WHITE,".אתה לא יכול לעשות פקודות באמצע פעילות");
if(InBike[playerid] > 0) return SendClientMessage(playerid,COLOR_WHITE,".אתה לא יכול לעשות פקודות באמצע מירוץ, תודה");
new PlayerName[100];


if (strcmp(cmdtext, "/dm", true)==0)
{
if(InDM[playerid] == 1) return SendClientMessage(playerid,COLOR_WHITE,"/qdmz - אתה נמצא באיזור די-אם על מנת לבצע פקודות שנית");
if(isafk[playerid] == 1) return SendClientMessage(playerid,COLOR_WHITE,"/UNAFK על מנת לצאת מהמצב בצע/י .AFK Time אתה כבר במצב");
new Randm = random(sizeof(DMPostion));
SetPlayerPos(playerid, DMPostion[Randm][0], DMPostion[Randm][1], DMPostion[Randm][2]);
InDM[playerid] = 1;
ResetPlayerWeapons(playerid);
SetPlayerVirtualWorld(playerid,2);
//SetPlayerGravity(playerid,0.008900);
if(WeaponDM[playerid] == 38)
{
WeaponDM[playerid] = 35;
}
else
{
WeaponDM[playerid] = 38;
}
GivePlayerWeapon(playerid,WeaponDM[playerid],99999);

return 1;
}
if (strcmp(cmdtext, "/qdmz", true)==0)
{
if(InDM[playerid] == 0) return SendClientMessage(playerid,COLOR_WHITE,".אתה לא נמצא באיזור - די-אם");
InDM[playerid] = 0;
WeaponDM[playerid] = 0;
ResetPlayerWeapons(playerid);
SetPlayerVirtualWorld(playerid,0);
//SetPlayerGravity(playerid,0.090000);

return 1;
}
if (strcmp("/afk", cmdtext, true) == 0){
if(isafk[playerid] == 1) return SendClientMessage(playerid,COLOR_WHITE,"/UNAFK על מנת לצאת מהמצב בצע/י .AFK Time אתה כבר במצע ");
isafk[playerid] = 1;
TogglePlayerControllable(playerid,0);
SendClientMessage(playerid, COLOR_WHITE, ".כעת אתה רשאי לעשות את עיניינך ללא חשש .AFK נכנסת למצב");
return 1;
}

if (strcmp("/unafk", cmdtext, true) == 0)
{
if(isafk[playerid] == 0) return SendClientMessage(playerid,COLOR_WHITE,".AFKאתה לא נמצא ב");
isafk[playerid] = 0;
TogglePlayerControllable(playerid,1);
SetCameraBehindPlayer(playerid);
SendClientMessage(playerid, COLOR_LIGHTGREEN, ".כעת אתה יכול לחזור לשחק .AFK - יצאת ממצב");
return 1; //return value
}
//---
if(InDM[playerid] == 1) return SendClientMessage(playerid,COLOR_WHITE,". אתה נמצא באיזור די-אם על מנת לבצע פקודות שנית");

if(strcmp(cmd, "/kill", true) == 0)
{
aDoing[playerid] ++;
if(aDoing[playerid] > 1) return SendClientMessage(playerid,COLOR_WHITE,"אנא המתן מספר שניות לביצוע פקודה זאת שנית");
if(HpModeA[playerid] == 1)
{
hpmodebug[playerid]=1;
HpModeA[playerid] = 0;
//DisplayTextForPlayer(playerid,"~r~Bye", 5, 1, 3);
PlayerInfo[playerid][Deaths] = PlayerInfo[playerid][Deaths] --;
return 1;
}
PlayerInfo[playerid][Deaths] = PlayerInfo[playerid][Deaths] --;
antianti[playerid] = 0;
SetPlayerHealth(playerid,0.0);
mini[playerid] = 0;
SendClientMessage(playerid,0xF6F658FF, ".התאבדת");

return 1;
}

///KopatGemel]
new moneysaA[MAX_PLAYERS];
if(strcmp(cmd, "/aGemel", true) == 0)
{
if (PlayerInfo[playerid][Level] < 4) return Messagelevel (playerid, 4);

if(PlayerInfo[playerid][KopatGemel] ==1) return SendClientMessage(playerid,COLOR_WHITE,"/getgemelm כבר השקעת בקופת הגמל נסה ככה לשלוף תכסף");
if(!CPS_IsPlayerInCheckpoint(playerid,bcp)) return SendClientMessage(playerid,COLOR_WHITE,".אתה חייב להיות בנקודת ציון על מנת להשתמש בפקודה זאת");
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(tmp)) return SendClientMessage(playerid,WHITE, "/aGemel [4000-20,000] :שימוש ");
moneysaA[playerid] = strval(tmp);
if(moneysaA[playerid] > 20000) return SendClientMessage(playerid, COLOR_WHITE, ".20,000 :הסכום המקסימלי ללקיחת הלואה הוא"),SendClientMessage(playerid,COLOR_WHITE, "/aGemel [4000-20,000] :אתה עברת את הסכום המותר אנא נסה שנית");
if(moneysaA[playerid] < 4000) return SendClientMessage(playerid, COLOR_WHITE, "4,000 :סכום מינימלי"),SendClientMessage(playerid,COLOR_WHITE, "/aGemel [4000-20,000] סכום ההשקעה נמוך מידי אנא נסה ככה");
moneysaA[playerid] = strval(tmp);
if(GetPlayerMoney(playerid) < moneysaA[playerid]) return SendClientMessage(playerid, COLOR_WHITE, " אין לך מספיק כסף ");

LACY_GiveMoney(playerid, -moneysaA[playerid]);
PlayerInfo[playerid][GemelLogin] = moneysaA[playerid];
PlayerInfo[playerid][KopatGemel] =1;
SendClientMessage(playerid,COLOR_WHITE,"--- קופת ההשקאות שלך --");
format(string, sizeof(string),"%d אתה השקעת בקופת הגמל שלך כ",PlayerInfo[playerid][GemelLogin]),SendClientMessage(playerid,0xF6F658FF,string);
SendClientMessage(playerid,0xF6F658FF,".כל שעה עגולה תקבל כ-1,200 דולר לקופת ההשקאות");
SendClientMessage(playerid,0xF6F658FF,"/getgemelm :ללקיחת הכסף בחזרה");

return 1;
}


if(strcmp(cmd, "/getgemelm", true) == 0)
{
if (PlayerInfo[playerid][Level] < 4)return Messagelevel (playerid, 4);

if(!CPS_IsPlayerInCheckpoint(playerid,bcp)) return SendClientMessage(playerid,COLOR_WHITE,".אתה חייב להיות בנקודת ציון על מנת להשתמש בפקודה זאת");
if(PlayerInfo[playerid][GemelLogin] ==0) return SendClientMessage(playerid,COLOR_WHITE,"/help 37 אין לך שום השקעה לעזרה השתמש בפקודה");

format(string, sizeof(string),".%d קיבלת תכסף בחזרה מקופת ההשקעות תהנה",PlayerInfo[playerid][GemelLogin]),SendClientMessage(playerid,0xF6F658FF,string);
LACY_GiveMoney(playerid, PlayerInfo[playerid][GemelLogin]);
PlayerInfo[playerid][GemelLogin] =0;
PlayerInfo[playerid][KopatGemel] =0;

return 1;
}

//---

if(!strcmp(cmd, "/Profile", true))
{
if(PlayerInfo[playerid][ProfileLogged] ==0) return SendClientMessage(playerid,COLOR_WHITE,"/help profile אתה חייב לפתוח כרטיס  פרופיל קודם");
format(string, sizeof(string), ".%s`s :פרטי השחקן שלך",GetName(playerid)),SendClientMessage(playerid, COLOR_GREY, string);
format(string, sizeof(string), "Icq: %s, Messnger %s, Email: %s.", dini_Get(GetPlayerFile(playerid),"ICQ"), dini_Get(GetPlayerFile(playerid),"MSN"),dini_Get(GetPlayerFile(playerid),"Email")),SendClientMessage(playerid, COLOR_GREY, string);
format(string, sizeof(string), "Sex: %s, Age: %d.", dini_Get(GetPlayerFile(playerid),"SEX"),PlayerInfo[playerid][AggInfo]),SendClientMessage(playerid, COLOR_GREY, string);
format(string, sizeof(string), "Player Message: %s.", dini_Get(GetPlayerFile(playerid),"Mispht")),SendClientMessage(playerid, COLOR_GREEN, string);
return 1;
}
if(!strcmp(cmd, "/pProfile", true))
{
new sid[256], id;
sid = strtok(cmdtext,idx);
id = ReturnID(sid);
if(30 < strlen(sid)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");

if(PlayerInfo[id][ProfileLogged] ==0) return SendClientMessage(playerid,COLOR_WHITE,"שחקנ/ית זה לא הגדיר/ה תפרופיל");
if(!strlen(sid)) return SendClientMessage(playerid, COLOR_WHITE, "/pProfile <id/name>");
if(!IsPlayerConnected(id)) return SendClientMessage(playerid,WHITE,".שחקנ/ית לא מחובר/ת");
format(string, sizeof(string), ".%s :הפרטיים האישיים של",GetName(id));
SendClientMessage(playerid, COLOR_WHITE, string);
format(string, sizeof(string), "Icq: %s, Messnger %s, Email: %s", dini_Get(GetPlayerFile(id),"ICQ"), dini_Get(GetPlayerFile(id),"MSN"),dini_Get(GetPlayerFile(id),"Email")),SendClientMessage(playerid, COLOR_GREY, string);
format(string, sizeof(string), "Sex: %s, Age: %d", dini_Get(GetPlayerFile(id),"SEX"),PlayerInfo[id][AggInfo]),SendClientMessage(playerid, COLOR_GREY, string);
format(string, sizeof(string), "Player Message: %s", dini_Get(GetPlayerFile(id),"Mispht")),SendClientMessage(playerid, COLOR_GREEN, string);
return 1;
}

if(strcmp(cmd, "/GetLoan", true) == 0)
{
if (PlayerInfo[playerid][Level] < 4) return Messagelevel (playerid, 4);

if(!CPS_IsPlayerInCheckpoint(playerid,bcp)) return SendClientMessage(playerid,COLOR_WHITE,".אתה חייב להיות בנקודת ציון על מנת להשתמש בפקודה זאת");
if(PlayerInfo[playerid][GetAloan] ==1) return format(string, sizeof(string),"%d :אתה חייב לבנק סכום כספי של",PlayerInfo[playerid][MoneyLoan]),SendClientMessage(playerid,COLOR_WHITE,string),SendClientMessage(playerid,COLOR_WHITE,".חסר לך כסף להחזרת ההלואה אנא אסוף תכסף והחזר לבנק עד אז לא תוכל להשתמש בבנק");
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(tmp)) return SendClientMessage(playerid,WHITE, "/getloan [4000-20,000] :שימוש ");
moneysaA[playerid] = strval(tmp);
if(moneysaA[playerid] > 20000) return SendClientMessage(playerid, COLOR_WHITE, ".20,000 :הסכום המקסימלי ללקיחת הלואה הוא"),SendClientMessage(playerid,COLOR_WHITE, "/getloan [4000-20,000] :אתה עברת את הסכום המותר אנא נסה שנית");
moneysaA[playerid] = strval(tmp);
if(moneysaA[playerid] < 4000) return SendClientMessage(playerid, COLOR_WHITE, "4,000 :סכום מינימלי"),SendClientMessage(playerid,COLOR_WHITE, "/getloan [4000-20,000] :הסכום שהזנת קטן מידי נסה שנית");
LACY_GiveMoney(playerid, moneysaA[playerid]);
PlayerInfo[playerid][MoneyLoan] = moneysaA[playerid];
PlayerInfo[playerid][MoneyLoan] +=200;
PlayerInfo[playerid][GetAloan] =1;
format(string, sizeof(string),"%d :לקחת הלוואה בסך %d אתה צריך להחזיר לבנק כ ",PlayerInfo[playerid][MoneyLoan],PlayerInfo[playerid][MoneyLoan]-200);
SendClientMessage(playerid,0xF6F658FF,string);
SendClientMessage(playerid,COLOR_PURPLE, ":שים לב לדברי מנהל הבנק");
SendClientMessage(playerid,COLOR_PINK, "מנהל הבנק: לא לשכוח עד שלא תחזיר תהלוואה לא תוכל להשתמש בבנק");
SendClientMessage(playerid,COLOR_PINK, ".מנהל הבנק: לא לשכוח כל 54 דק' הבנק לוקח ריבת של 200 דולר");
SendClientMessage(playerid,COLOR_LIGHTGREEN, "./backloan להחזרת ההלואה");
dini_IntSet(GetPlayerFile(playerid),"MoneyLoan",PlayerInfo[playerid][MoneyLoan]);
return 1;
}

if(strcmp(cmd, "/BackLoan", true) == 0)
{
if(!CPS_IsPlayerInCheckpoint(playerid,bcp)) return SendClientMessage(playerid,COLOR_WHITE,".אתה חייב להיות בנקודת ציון על מנת להשתמש בפקודה זאת");
if(PlayerInfo[playerid][GetAloan] ==0) return SendClientMessage(playerid,COLOR_WHITE,".לא לקחת שום הלוואה אין מה להחזיר");
if(GetPlayerMoney(playerid) < PlayerInfo[playerid][MoneyLoan]) return format(string, sizeof(string),"%d :אתה חייב לבנק סכום כספי של",PlayerInfo[playerid][MoneyLoan]),SendClientMessage(playerid,COLOR_WHITE,string),SendClientMessage(playerid,COLOR_WHITE,".חסר לך כסף להחזרת ההלואה אנא אסוף תכסף והחזר לבנק עד אז לא תוכל להשתמש בבנק");
LACY_GiveMoney(playerid,-PlayerInfo[playerid][MoneyLoan]);
format(string, sizeof(string),"[%d] :החזרת לבנק תהלוואה סכום ההחזרה",PlayerInfo[playerid][MoneyLoan]);
SendClientMessage(playerid,0xF6F658FF,string);
SendClientMessage(playerid,COLOR_PURPLE, ".מנהל הבנק: תודה על ההחזרת הלוואה");
SendClientMessage(playerid,COLOR_PURPLE, "מנהל הבנק: כעת אתה יכול להשתמש בבנק שנית");
SendClientMessage(playerid,COLOR_PINK, "/help bank לעזרה בבנק בצע את הפקודה");
SendClientMessage(playerid,COLOR_PINK, "/getloan .עם תרצה לקחת עוד פעם הלוואה");
PlayerInfo[playerid][GetAloan] =0;
PlayerInfo[playerid][MoneyLoan] =0;
return 1;
}


if(strcmp(cmd, "/organization", true) == 0)
{
new Roy_Killer111[256];
Roy_Killer111= strtok(cmdtext, idx);
if(30 < strlen(Roy_Killer111)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(Roy_Killer111))
{
SendClientMessage(playerid, COLOR_WHITE,"Usage: /organization [function]");
SendClientMessage(playerid, COLOR_WHITE,"/organization my [organization name] :לשינוי תאג הארגון שלך");
return 1;
}

else if(strcmp(Roy_Killer111,"my",true) == 0)
{
new icqnumb[256];
CheckPlayerCMDLevel(playerid,ChangeIcq);
icqnumb = strtok(cmdtext,idx);
if(30 < strlen(icqnumb)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(icqnumb)) return SendClientMessage(playerid,COLOR_WHITE,"/organization [name org] :שימוש");

dini_Set(GetPlayerFile(playerid),"organization",icqnumb);
format(string, sizeof(string),"[%s] - .שינת את הארגון שלך ל",icqnumb);
SendClientMessage(playerid,0x0F482FF,string);
}
return 1;
}

if(isafk[playerid] == 1) return SendClientMessage(playerid,COLOR_WHITE,"/UNAFK - .AFK על מנת לצאת ממצב  .AFK אתה לא יכול לבצע פקודות בעת מצב");


if(strcmp(cmd, "/editprofile", true) == 0)
{
new Roy_Killer111[256];
Roy_Killer111= strtok(cmdtext, idx);
if(30 < strlen(Roy_Killer111)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(Roy_Killer111))
{
SendClientMessage(playerid, COLOR_WHITE,"Usage: /editprofile [function]");
SendClientMessage(playerid, COLOR_WHITE,"/Editprofile open :לפתיחת פרופיל");
SendClientMessage(playerid, COLOR_WHITE,"/Editprofile icq [YourIcq] לערוך את המספר אייסקיו");
SendClientMessage(playerid, COLOR_WHITE,"/Editprofile msn [YourMsn] המסנג'ר שלך");
SendClientMessage(playerid, COLOR_WHITE,"/Editprofile email [YourEmail] לערוך את האימייל שלך");
SendClientMessage(playerid, COLOR_WHITE,"/Editprofile age :לערוך את הגיל שלך");
SendClientMessage(playerid, COLOR_WHITE,"/Editprofile sex [כדאי לערוך את המין שלך [זכר/נקבה ");
SendClientMessage(playerid, COLOR_WHITE,"/Editprofile m [YouM] מילה שאתה מתחבר אליה אנגלית בלבד");
SendClientMessage(playerid, COLOR_WHITE,"/pProfile <id/name> לראות פרופיל של שחקן אחר - /Profile לראות את הפרופיל שלך");

return 1;
}

if(strcmp(Roy_Killer111,"icq",true) == 0)
{
if(PlayerInfo[playerid][ProfileLogged] ==0) return SendClientMessage(playerid,COLOR_WHITE,".אין לך כרטיס פרופיל אישי");
new icqnumb[256];
CheckPlayerCMDLevel(playerid,ChangeIcq);
icqnumb = strtok(cmdtext,idx);
if(30 < strlen(icqnumb)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(icqnumb)) return SendClientMessage(playerid,COLOR_WHITE,"/editprofile icq [number icq] :שימוש");

if(!IsNumeric(icqnumb)) return SendClientMessage(playerid,COLOR_WHITE,".מספר איסייקיו לא חוקי");

if(9 < strlen(icqnumb) || strlen(icqnumb) < 4) {
format(string,sizeof(string),".4-9 אורך האייסיקיו חייב להיות בין ל");
SendClientMessage(playerid,COLOR_WHITE,string);
return 1;
}



new File:f;
if(fexist(GetPlayerFile(playerid)))
{
f = fopen(GetPlayerFile(playerid),io_append);

dini_Set(GetPlayerFile(playerid),"ICQ",icqnumb);
format(string, sizeof(string),"[%s] - :האייסקיו שלך נקבע כ",icqnumb);
SendClientMessage(playerid,0x0F482FF,string);
fclose(f);
}
}

else if(strcmp(Roy_Killer111,"open",true) == 0)
{
if(PlayerInfo[playerid][ProfileLogged] ==1) return SendClientMessage(playerid,COLOR_WHITE,"/help profile - כבר יש לך כרטיס פרופיל לעזרה");
SendClientMessage(playerid,COLOR_WHITE,"--- .כרטיס פרופיל נוצר בהצלחה ---");
SendClientMessage(playerid,0x0F482FF,".כעת תוכל לערוך את הפרטים שלך");
SendClientMessage(playerid,0x0F482FF,"/help profile - לקבלת עזרה בצע ");
SendClientMessage(playerid,0x0F482FF,"/profile לצפייה בכרטיס שלך");
SendClientMessage(playerid,0x0F482FF,"/pprofile <id/name> לצפייה בכרטיס של מישהוא אחר");
PlayerInfo[playerid][ProfileLogged]=1;
new File:f;
if(fexist(GetPlayerFile(playerid)))
{
f = fopen(GetPlayerFile(playerid),io_append);

format(string,sizeof(string),"Name=%s\r\n","None"); fwrite(f,string);
format(string,sizeof(string),"LastName=%s\r\n","None"); fwrite(f,string);
format(string,sizeof(string),"ICQ=%s\r\n","None"); fwrite(f,string);
format(string,sizeof(string),"Msn=%s\r\n","None"); fwrite(f,string);
format(string,sizeof(string),"Mispht=%s\r\n","None"); fwrite(f,string);
format(string,sizeof(string),"SEX=%s\r\n","None"); fwrite(f,string);
format(string,sizeof(string),"Email=%s\r\n","None"); fwrite(f,string);
format(string,sizeof(string),"Agg=%s\r\n","None"); fwrite(f,string);

dini_IntSet(GetPlayerFile(playerid),"ProfileLogeed",PlayerInfo[playerid][ProfileLogged]);
fclose(f);
}
}
else if(strcmp(Roy_Killer111,"sex",true) == 0)
{

if(PlayerInfo[playerid][ProfileLogged] ==0) return SendClientMessage(playerid,COLOR_WHITE,".אין לך כרטיס פרופיל אישי");
new SexPlayer[256];
SexPlayer = strtok(cmdtext, idx);
if(30 < strlen(SexPlayer)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(SexPlayer))
{
SendClientMessage(playerid, COLOR_WHITE, "/editprofile sex  [נקבה/זכר]");

return 1;
}

if(strcmp(SexPlayer,"זכר",true) == 0)
{
CheckPlayerCMDLevel(playerid,ChangeIcq);
SendClientMessage(playerid, 0x0F482FF, "[המין שלך הוגדר כ[זכר");
new File:f;
if(fexist(GetPlayerFile(playerid)))
{
f = fopen(GetPlayerFile(playerid),io_append);
dini_Set(GetPlayerFile(playerid), "SEX", "זכר");
fclose(f);
}}
else if(strcmp(SexPlayer,"נקבה",true) == 0)
{

SendClientMessage(playerid, 0x0F482FF, "[המין - שלך הוגדר כ[נקבה");

new File:f;
if(fexist(GetPlayerFile(playerid)))
{
f = fopen(GetPlayerFile(playerid),io_append);
dini_Set(GetPlayerFile(playerid), "SEX", "נקבה");
fclose(f);
}}
}
//--Email
else if(strcmp(Roy_Killer111,"email",true) == 0)
{
if(PlayerInfo[playerid][ProfileLogged] ==0) return SendClientMessage(playerid,COLOR_WHITE,".אין לך כרטיס פרופיל אישי");
new Msnnumb[256];
CheckPlayerCMDLevel(playerid,ChangeIcq);
Msnnumb = strtok(cmdtext,idx);
if(30 < strlen(Msnnumb)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(Msnnumb)) return SendClientMessage(playerid,COLOR_WHITE,"/editprofile email [your email] :שימוש");
if(ValidEmail(Msnnumb)) return SendClientMessage(playerid,WHITE,".כתובת מסנג'ר שגויה");

new File:f;
if(fexist(GetPlayerFile(playerid)))
{
f = fopen(GetPlayerFile(playerid),io_append);
dini_Set(GetPlayerFile(playerid),"Email",Msnnumb);
format(string, sizeof(string),"[%s]- :האיימיל שלך נקבע כ",Msnnumb);
SendClientMessage(playerid,0x0F482FF,string);
fclose(f);
}
}

//--Agg
else if(strcmp(Roy_Killer111,"age",true) == 0)
{
if(PlayerInfo[playerid][ProfileLogged] ==0) return SendClientMessage(playerid,COLOR_WHITE,".אין לך כרטיס פרופיל אישי");

if(Sagebir[playerid] ==1)
{
Sagebir[playerid]=0;
SendClientMessage(playerid,WHITE,".כעת יצאת ממצב קביעת גיל תוכל להמשיך לכתוב בצ'אט בחופשיות");
}
if(Sagebir[playerid] ==0){
SendClientMessage(playerid,COLOR_WHITE,"---- הדרכה בשימוש מערכת גילאים ---");
SendClientMessage(playerid,WHITE,"(dd/mm/yyyy):כעת תכתוב בצ'אט את התאריך לידה שלך דוגמא");
SendClientMessage(playerid,WHITE,".mm = חודש -- dd = יום -- yyyy = שנה");
SendClientMessage(playerid,WHITE,".על מנת לקבוע את גילך תכתוב את זה בצ'אט, אל תדאג הצ'אט יצנזר ורק את תראה");
SendClientMessage(playerid,WHITE,"(dd/mm/yyyy) :תכתוב בצ'אט ככה d-- .על מנת לדבר בצ'אט f6 לחץ");
SendClientMessage(playerid,WHITE,"/editproile age :על מנת לצאת ממצב קביעת גיל תחזור על הפקודה");
Sagebir[playerid]=1;
}
}
//---
else if(strcmp(Roy_Killer111,"Msn",true) == 0)
{
if(PlayerInfo[playerid][ProfileLogged] ==0) return SendClientMessage(playerid,COLOR_WHITE,".אין לך כרטיס פרופיל אישי");
new Msnnumb[256];
CheckPlayerCMDLevel(playerid,ChangeIcq);
Msnnumb = strtok(cmdtext,idx);
if(30 < strlen(Msnnumb)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(Msnnumb)) return SendClientMessage(playerid,COLOR_WHITE,"/editprofile Msn [Msn] :שימוש");
if(ValidEmail(Msnnumb)) return SendClientMessage(playerid,WHITE,".כתובת מסנג'ר שגויה");

new File:f;

if(fexist(GetPlayerFile(playerid)))
{
f = fopen(GetPlayerFile(playerid),io_append);
dini_Set(GetPlayerFile(playerid),"Msn",Msnnumb);
format(string, sizeof(string),"[%s] - :המסן שלך נקבע כ",Msnnumb);
SendClientMessage(playerid,0x0F482FF,string);
fclose(f);
}
}
//--
else if(strcmp(Roy_Killer111,"m",true) == 0)
{
if(PlayerInfo[playerid][ProfileLogged] ==0) return SendClientMessage(playerid,COLOR_WHITE,".אין לך כרטיס פרופיל אישי");

new Msnnumb[256];
CheckPlayerCMDLevel(playerid,ChangeIcq);
Msnnumb = strtok(cmdtext,idx);
if(30 < strlen(Msnnumb)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(Msnnumb)) return SendClientMessage(playerid,COLOR_WHITE,"/editprofile m [.מילה אחת שמגדירה אותך :D] :שימוש");
new File:f;
if(fexist(GetPlayerFile(playerid)))
{
f = fopen(GetPlayerFile(playerid),io_append);
dini_Set(GetPlayerFile(playerid),"Mispht",Msnnumb);
format(string, sizeof(string),"[%s] המילה שלך הוגדרה בהצלחה",Msnnumb);
SendClientMessage(playerid,0x0F482FF,string);
fclose(f);
}
}

return 1;
}
//----

if(strcmp(cmd, "/ignore", true) == 0)
{
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(tmp))
SendClientMessage(playerid, COLOR_WHITE, "Usage: /ignore [playerid]");
else
{
giveplayerid = strval(tmp);
if(giveplayerid == playerid) return SendClientMessage(playerid, COLOR_WHITE, ".אתה לא יכול לחסוך את עצמך");
if(Ignore[playerid][giveplayerid] ==1) return SendClientMessage(playerid,COLOR_WHITE,"להורדת חסימה - /unignore <id/name> .שחקן זה כבר חסום אצלך");
if(PlayerInfo[giveplayerid][AdminsLevel] > 2) return SendClientMessage(playerid,COLOR_WHITE,".אתה רוצה לחסום אדמין? , באסה לך למה אתה לא יכול");
GetPlayerName(giveplayerid, playername, sizeof(playername));
format(string, sizeof(string), ".(ID: %d) האיידי של השחקן %s אתה חסמת את השחקן",  giveplayerid,playername);
SendClientMessage(playerid, COLOR_WHITE, string);
Ignore[playerid][giveplayerid] = 1;
}
return 1;
}
 if(strcmp(cmd, "/unignore", true) == 0)
 {
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(tmp))
SendClientMessage(playerid, COLOR_WHITE, "Usage: /unignore [playerid]");
else
{
giveplayerid = strval(tmp);
if(giveplayerid == playerid) return SendClientMessage(playerid, COLOR_WHITE, ".אתה לא יכול להוריד חסימה לעצמך");
if(Ignore[playerid][giveplayerid] ==0) return SendClientMessage(playerid,COLOR_WHITE,"/ignore לא חסמת את שחקן זה לחסימה");
GetPlayerName(giveplayerid, playername, sizeof(playername));
format(string, sizeof(string), ".(ID: %d) :איידי %s אתה הורדת חסימה ל", giveplayerid,playername);
SendClientMessage(playerid, COLOR_WHITE, string);
Ignore[playerid][giveplayerid] = 0;
}
return 1;
}
		
//---
	
if(strcmp(cmd,"/GiveVIP",true) == 0)
{
if (PlayerInfo[playerid][AdminsLevel] >= 10)
{
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
new id = ReturnID(tmp);
tmp2 = strtok(cmdtext, idx);
if(30 < strlen(tmp2)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
new adlvl = strval(tmp2);
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /GiveVIP [playerid] [level]");
if(!strlen(tmp2)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /GiveVIP [playerid] [level]");
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_WHITE, "Invalid PlayerID !");
PlayerInfo[id][VIPS] = adlvl;
dini_IntSet(GetPlayerFile(playerid),"VIP",PlayerInfo[id][VIPS]);
}
else
{

}
return 1;
}
//---
if(strcmp(cmd,"/GiveSup",true) == 0)
{
if (PlayerInfo[playerid][AdminsLevel] >= 10)
{
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
new id = ReturnID(tmp);
tmp2 = strtok(cmdtext, idx);
if(30 < strlen(tmp2)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
new adlvl = strval(tmp2);
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /GiveSup [playerid] [level]");
if(!strlen(tmp2)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /GiveSup [playerid] [level]");
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_BLUE, "Invalid PlayerID !");
PlayerInfo[id][Supportives] = adlvl;
dini_IntSet(GetPlayerFile(id),"Supportives",PlayerInfo[id][Supportives]);
}
else
{

}
return 1;
}
//--

if(strcmp(cmd,"/HelpMe",true) == 0)
{
if(helpme[playerid] ==1) return SendClientMessage(playerid,COLOR_WHITE,".שלחת כבר בקשה , לשליחה שנית אנא המתן מספר שניות");
SendClientMessage(playerid,COLOR_GREY,".בקשתך נשלח בהצלחה לתומכים המחוברים");
helpme[playerid] =1;
for (new i = 0; i < MAX_PLAYERS; i++)
{

if (PlayerInfo[i][Supportives] >= 1)
{
format(string, sizeof(string), ".זקוק לעזרה בשרת אנא פנה אליו בהודעה פרטית או בשיחת טלפון ,%s",GetName(playerid));
SendClientMessage(i, COLOR_WHITE, string);
}
}

return 1;
}

if(strcmp(cmdtext, "/messagetoadmin", true)==0 || (strcmp(cmdtext, "/mta", true)==0))
{
if(helpme[playerid] ==1) return SendClientMessage(playerid,COLOR_WHITE,".שלחת כבר בקשה , לשליחה שנית אנא המתן מספר שניות");
SendClientMessage(playerid,COLOR_GREY,".בקשתך נשלח בהצלחה לתומכים המחוברים");
helpme[playerid] =1;
for (new i = 0; i < MAX_PLAYERS; i++)
{

if (PlayerInfo[i][Supportives] >= 1)
{
format(string, sizeof(string), ".זקוק לעזרה בשרת אנא פנה אליו בהודעה פרטית או בשיחת טלפון ,%s",GetName(playerid));
SendClientMessage(i, COLOR_WHITE, string);
}
}

return 1;
}

//--CCBank
if(strcmp(cmd, "/Buycc", true) == 0)
{

if (PlayerInfo[playerid][Level] < 3) return Messagelevel (playerid, 3);
if(GetPlayerMoney(playerid) < 700000) return SendClientMessage(playerid,COLOR_WHITE,".כרטיס האשראי עולה כ700000 דולר ואין לך מספיק ביד");
if(PlayerInfo[playerid][CcMode] ==1) return SendClientMessage(playerid,COLOR_WHITE,"/help cc - כבר יש לך כרטיס אשראי לעזרה");
SendClientMessage(playerid,COLOR_PURPLE,".מנהל הבנק: תתחדש על הכרטיש אשראי");
SendClientMessage(playerid,0xF6F658FF,"?אתה: תודה רבה , רגע מה אני יכול לעשות עם כרטיס האשראי");
SendClientMessage(playerid,COLOR_PURPLE,".מנהל הבנק: עם כרטיס האשראי תוכל לעשות מגוון פקודות");
SendClientMessage(playerid,0xF6F658FF,"?אתה: למשל");
SendClientMessage(playerid,COLOR_PURPLE,":מנהל הבנק: הנה תראה");
SendClientMessage(playerid, 0xF6F658FF,"/help cc /buycc (3) /sellcc (3) /withdrawc (3) [amount]");
SendClientMessage(playerid,COLOR_PURPLE,":/help cc .מנהל הבנק: לעזרה נוספת");
SendClientMessage(playerid,0xF6F658FF,".אתה: תודה רבה");
PlayerInfo[playerid][CcMode]=1;
LACY_GiveMoney(playerid,-700000);
return 1;
}


if(strcmp(cmd, "/SellCc", true) == 0)
{
if(PlayerInfo[playerid][CcMode] ==0) return SendClientMessage(playerid,COLOR_WHITE,".אין לך בכיס כרטיס אשראי");
SendClientMessage(playerid,COLOR_PURPLE,"מנהל הבנק: מכרת את כרטיס האשראי שלך בהצלחה וקיבלת כ350000 דולר");
SendClientMessage(playerid,0xF6F658FF,"?אתה: למה רק חצי קיבלתי רק חצי מהכסף");
SendClientMessage(playerid,COLOR_PURPLE,".מנהל הבנק: כי השתמשת בוא");
SendClientMessage(playerid,0xF6F658FF,".אתה: מניאק");
SendClientMessage(playerid,COLOR_PURPLE,".מנהל הבנק: תודה ביי");
SendClientMessage(playerid,COLOR_PURPLE,": D - .מנהל הבנק: ד\"א דפקתי אותך");
LACY_GiveMoney(playerid,350000);
PlayerInfo[playerid][CcMode]=0;
return 1;
}

new moneysa[MAX_PLAYERS];
if(!strcmp(cmd, "/withdrawc", true))
{
if(PlayerInfo[playerid][CcMode] ==0) return SendClientMessage(playerid,COLOR_WHITE,".אין לך בכיס כרטיס אשראי");
if(GetPlayerMoney(playerid) < 1000) return SendClientMessage(playerid,COLOR_WHITE,".כל משיכה עולה ב1000 דולר ולך יש פחות לכן לו תוכל למשוך");
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, " /withdrawc [amount] :שימוש ");
moneysa[playerid] = strval(tmp);
if(30 < strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(moneysa[playerid] < 1099) return SendClientMessage(playerid, COLOR_WHITE, ".תה חייב להכניס סכום מעל 1099");
if(moneysa[playerid] > PlayerInfo[playerid][Bank]) return SendClientMessage(playerid, COLOR_WHITE, ".סכום משיכה שגוי ");
LACY_GiveMoney(playerid, moneysa[playerid]);
LACY_GiveMoney(playerid, -1000);
PlayerInfo[playerid][Bank] = PlayerInfo[playerid][Bank]-moneysa[playerid];
dini_IntSet(GetPlayerFile(playerid),"Bank",PlayerInfo[playerid][Bank]);
format(string, sizeof(string), "[$%d] נשאר לך בבנק כ ,[$%d] משכת מהרטיס אשראי שלך כ",  moneysa[playerid],PlayerInfo[playerid][Bank]);
SendClientMessage(playerid, COLOR_WHITE, string);
return 1;
}
if(!strcmp(cmd, "/balancec", true)) {
format(string, sizeof(string), "[$%d] :הכסף בכרטיס אשראי שלך הוא", PlayerInfo[playerid][Bank]);
SendClientMessage(playerid, COLOR_WHITE, string);
return 1;
}



//==============================================================================
	        if(strcmp("/car",cmdtext,true) == 0)
	        {
			if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".אתה צריך להיות במכונית שאתה רוצה ליקנות ");
new vehicleid = GetPlayerVehicleID(playerid);
new msg[256];
if(VehicleInfo[vehicleid][CarOwned] == 1)
{
if(strcmp(PlayerName,VehicleInfo[vehicleid][CarOwner],true) == 0)
{
format(msg,sizeof(msg),"| ~~~~~~~~ | %s :פרטים עבור הרכב | ~~~~~~~~ |",VehicleInfo[vehicleid][CarName]);
SendClientMessage(playerid,WHITE,msg);
format(msg,sizeof(msg),"!%s הרכב אשר אתה נמצא בוא הוא הרכב שלך",VehicleInfo[vehicleid][CarName]);
SendClientMessage(playerid,lblue,msg);
format(vehname,999,".%d :האיידי של הרכב",GetVehicleModel(GetPlayerVehicleID(playerid)));
SendClientMessage(playerid,lblue,vehname);
format(vehname,999,".%d :האיידי של הרכב במוד",GetPlayerVehicleID(playerid));
SendClientMessage(playerid,lblue,vehname);
if(VehicleInfo[vehicleid][SaleV] > 0)
{
SendClientMessage(playerid,lblue,"/StopSale :הרכב שלך, עדיין מוצע לקניה, על מנת להפסיק את מכירת הרכב בצע/י");
}
}
else if(strcmp(PlayerName,VehicleInfo[vehicleid][CarOwner],true) == 1)
{


if(VehicleInfo[vehicleid][SaleV] != 0)
{

format(msg,sizeof(msg),"| ~~~~~~~~ | %s :פרטים עבור הרכב | ~~~~~~~~ |",VehicleInfo[vehicleid][CarName]);
SendClientMessage(playerid,WHITE,msg);
format(msg,sizeof(msg),".$%d :שים לב, בעל הרכב הציע על הרכב מחיר של כ",VehicleInfo[vehicleid][SaleV]);
SendClientMessage(playerid,lblue,msg);
format(msg,sizeof(msg),".%s :בעלים של הרכב שהציע את המחיר הזה",VehicleInfo[vehicleid][CarOwner]);
SendClientMessage(playerid,lblue,msg);
SendClientMessage(playerid,lblue,"/BuyCar :לקניית הרכב בצע/י");
format(vehname,999,".%d :האיידי של הרכב",GetVehicleModel(GetPlayerVehicleID(playerid)));
SendClientMessage(playerid,lblue,vehname);
format(vehname,999,".%d :האיידי של הרכב במוד",GetPlayerVehicleID(playerid));
SendClientMessage(playerid,lblue,vehname);

SendClientMessage(playerid,lblue,".רכישת הרכב מרמה 2, ומעלה בלבד");


}
else
{

format(msg,sizeof(msg),".ולכן לא ניתן לקנייה %s רכב זה הינו בבעלות [%s]",VehicleInfo[vehicleid][CarOwner],VehicleInfo[vehicleid][CarName]);
SendClientMessage(playerid,lblue,msg);
}
}
}
else if(VehicleInfo[vehicleid][Buyable] == 0)
{
format(msg,sizeof(msg),".הינו רכב ציבורי אינך יכול לקנות אותו לפי הפרטים שזוהה ,%s רכב זה",VehicleInfo[vehicleid][CarName], VehicleInfo[vehicleid][CarOwner]);
SendClientMessage(playerid,0xB3111EFF,msg);
}
else if(VehicleInfo[vehicleid][Buyable] == 1)
{
format(msg,sizeof(msg),"| ~~~~~~~~ | %s :פרטים עבור הרכב | ~~~~~~~~ |",VehicleInfo[vehicleid][CarName]);
SendClientMessage(playerid,WHITE,msg);
format(msg,sizeof(msg),".$%d :הרכב פנוי לרכישה, מחיר הרכב",VehicleInfo[vehicleid][Price]);
SendClientMessage(playerid,lblue,msg);
SendClientMessage(playerid,lblue,"/BuyCar :לקניית הרכב בצע/י");
format(vehname,999,".%d :האיידי של הרכב",GetVehicleModel(GetPlayerVehicleID(playerid)));
SendClientMessage(playerid,lblue,vehname);
format(vehname,999,".%d :האיידי של הרכב במוד",GetPlayerVehicleID(playerid));
SendClientMessage(playerid,lblue,vehname);
SendClientMessage(playerid,lblue,".רכישת הרכב מרמה 2, ומעלה בלבד");
}

 	           return 1;
               }
//==============================================================================
	if(strcmp(cmd, "/Calockallcars", true) == 0)
	{
    	if(IsPlayerAdmin(playerid))
		{
			for(new cari=0; cari < VCount; cari++) for(new i=0; i < MAX_PLAYERS; i++) SetVehicleParamsForPlayer(cari,i, 0, 0);
    		SendClientMessage(playerid, LIGHTGREEN,".כל המכוניות נפתחו מנעילה");
    		
    	}
		else
		{
	 SendClientMessage(playerid, COLOR_WHITE, ".הפקודה הזו היא לאדמינים בלבד ");
		}
		return 1;
	}


//==============================================================================
	if(strcmp(cmd, "/lock", true) == 0)
	{
		new vehicleid = GetPlayerVehicleID(playerid);

		GetPlayerName(playerid,PlayerName,30);

        if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE," אתה צריך להיות ברכב כדי לינעול אותו");
   		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return
    	SendClientMessage(playerid,0xF6F658FF," רק אתה כנהג יכול לנעול את הדלתות.");
   	   	if(GetPlayerVehicleID(playerid) >= VCount) return SendClientMessage(playerid,COLOR_WHITE," המכונית אינה ניתנת לנעילה");
		if(strcmp(PlayerName,VehicleInfo[vehicleid][CarOwner],true) != 0)return SendClientMessage(playerid,COLOR_WHITE," זו לא המכונית שלך, אינך יכול לינעול אותה");
        if(VehicleInfo[vehicleid][CarOwned] == 0 ) return SendClientMessage(playerid,COLOR_WHITE,"מכונית נעולה לתמיד");
		if(pia[playerid][CarID] == 0) return SendClientMessage(playerid,COLOR_WHITE, "אין לך מכונית");

	    for (new i=0;i<MAX_PLAYERS;i++) if(i != playerid) SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 1);

	    SendClientMessage(playerid, 0xF6F658FF, ".המכונית כעת נעולה");

		return 1;
    }
//==============================================================================
	if(strcmp(cmd, "/unlock", true) == 0)
	{
		new vehicleid = GetPlayerVehicleID(playerid);

		GetPlayerName(playerid,PlayerName,30);
if(pia[playerid][CarID] == 0) return SendClientMessage(playerid,COLOR_WHITE,".אין בבעלותך שום רכב");
        if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".אתה צריך להיות במכונית כדי ליפתוח אותה");
   		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return
    	SendClientMessage(playerid,0xF6F658FF,".רק אתה כנהג יכול לפתוח את הדלתות");
   	   	if(GetPlayerVehicleID(playerid) >= VCount) return SendClientMessage(playerid,COLOR_WHITE,".המכונית זו אינה ניתנת לפתיחה");
		if(strcmp(PlayerName,VehicleInfo[vehicleid][CarOwner],true) != 0)
   		return SendClientMessage(playerid,COLOR_WHITE,".זו לא המכונית שלך, אינך יכול ליפתוח אותה");
        if(VehicleInfo[vehicleid][CarOwned] == 0 ) return SendClientMessage(playerid,COLOR_WHITE,"This car isnt owned therefore cannot be unlocked");


	    for (new i=0;i<MAX_PLAYERS;i++) if(i != playerid) SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);

	    SendClientMessage(playerid, COLOR_WHITE, ".עכשיו ביטלתה את נעילת המכונית");

		return 1;
    }


	if(strcmp(cmd, "/buyable", true) == 0)
	{
    	if(IsPlayerAdmin(playerid))
    	{
			new carid;		GetPlayerName(playerid,PlayerName,30);
			tmp = strtok(cmdtext,idx);
             if(30 < strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");

			if(!strlen(tmp))
			{
				if(!(IsPlayerInAnyVehicle(playerid)))
				{
					SendClientMessage(playerid,COLOR_WHITE,"Please enter a vehicle and type /buyable OR type /buyable [vehicleid]");
				}
				else
				{
					new vehicleid = GetPlayerVehicleID(playerid);
					VehicleInfo[vehicleid][Buyable] = 1;

				    return 1;
				}
			}
			else
			{
	   		carid = strval(tmp);
			if(carid >= VCount) return SendClientMessage(playerid,COLOR_WHITE,"This car cannot be buyable");
			tmp = strtok(cmdtext, idx);
            if(30 < strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");

			VehicleInfo[carid][Buyable] = 1;

			}
		}
		else
		{
		//	SendClientMessage(playerid, COLOR_WHITE, "This command is for admins only");
		}
		return 1;
	}

//==============================================================================
	if(strcmp(cmd, "/unbuyable", true) == 0)
	{
    	if(IsPlayerAdmin(playerid))
    	{
			new carid;		GetPlayerName(playerid,PlayerName,30);
			tmp = strtok(cmdtext,idx);
            if(30 < strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");

			if(!strlen(tmp))
			{
				if(!(IsPlayerInAnyVehicle(playerid)))
				{
					SendClientMessage(playerid,COLOR_WHITE,"Please enter a vehicle and type /unbuyable OR type /unbuyable [vehicleid]");
				}
				else
				{
					new vehicleid = GetPlayerVehicleID(playerid);
					VehicleInfo[vehicleid][Buyable] = 0;

				    return 1;
				}
			}
			else
			{
	   		carid = strval(tmp);
			if(carid >= VCount) return SendClientMessage(playerid,COLOR_WHITE,"This car cannot be buyable");
			tmp = strtok(cmdtext, idx);
            if(30 < strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");

			VehicleInfo[carid][Buyable] = 0;

			}
		}
		else
		{
		//	SendClientMessage(playerid, COLOR_WHITE, "This command is for admins only");
		}
		return 1;
	}
//==============================================================================*/



//==============================================================================
if(strcmp(cmd, "/sellcar", true) == 0)
{
new vehicleid = GetPlayerVehicleID(playerid);
format(file,sizeof(file),"CarSys/car%d.txt",GetPlayerVehicleID(playerid) );
GetPlayerName(playerid,PlayerName,30);
if(pia[playerid][CarID] == 0) return SendClientMessage(playerid,COLOR_WHITE,".אין בבעלותך שום רכב");
if(strcmp(PlayerName,VehicleInfo[vehicleid][CarOwner],true) != 0)
return SendClientMessage(playerid,COLOR_WHITE,".רכב זה לא בבעלותך");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".אתה צריך להיות בתוך המכונית שלך בכדי למכור אותה ");

if(VehicleInfo[vehicleid][CarOwned] != 1) return SendClientMessage(playerid,COLOR_WHITE,".למכונית זו אין בעלים ולכן אי אפשר למכור אותה");

if(!dini_Exists(file))
{
format(string,sizeof(string),"ID [%d] - מכונית זו אינה ניתנת למכירה", vehicleid );
SendClientMessage(playerid,COLOR_WHITE,string);
}
else
{
for	(new i=0;i<MAX_PLAYERS;i++) SetVehicleParamsForPlayer(vehicleid,i, 0, 0);
dini_IntSet(file,"CarOwned",0);
dini_Set(file,"CarOwner","אין");
dini_IntSet(file,"Buyable",1);
VehicleInfo[vehicleid][CarOwned] = 0;
strmid(VehicleInfo[vehicleid][CarOwner], dini_Get(file,"CarOwner"), 0, strlen(dini_Get(file,"CarOwner")), 255);
VehicleInfo[vehicleid][Buyable] = 1;

pia[playerid][CarID] = 0;
pia[playerid][OwnCar] = 0;
format(file,sizeof(file),"CarSys/Users/%s.txt",PlayerName);
dini_IntSet(GetPlayerFile(playerid),"CarID",0);
dini_IntSet(GetPlayerFile(playerid),"OwnCar",0);
SendClientMessage(playerid, 0x33FF33AA, ".מכרת הרכב שלך, מחיר הרכב הועבר לחשבון בנק שלך");
dini_IntSet(GetPlayerFile(playerid),"Bank",PlayerInfo[playerid][Bank]+VehicleInfo[vehicleid][Price]/2);
dini_Set(GetPlayerFile(playerid),"Car","None");
}
return 1;
}
    //--

if(strcmp(cmd, "/Buycar", true) == 0)
{
new msg[256];
format(file,sizeof(file),"CarSys/car%d.txt", GetPlayerVehicleID(playerid) );
GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
new car = GetPlayerVehicleID(playerid);

if(!dini_Exists(file))
{
format(string,sizeof(string),"[ID: %d] .המכונית הזאתי לא ניתנת למכירה ", GetPlayerVehicleID(playerid));
SendClientMessage(playerid,COLOR_WHITE,string);
}
else
{
if(VehicleInfo[car][SaleV] == 0)
{

if (PlayerInfo[playerid][Level] < 0) return Messagelevel (playerid, 1);
new vehicleid = GetPlayerVehicleID(playerid);
if(GetPlayerMoney(playerid) < VehicleInfo[vehicleid][Price]) return SendClientMessage(playerid,COLOR_WHITE,".אין לך מספיק כסף בשביל ליקנות את המכונית הזאתי ");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".אתה צריך להיות במכונית שאתה רוצה ליקנות ");
if(GetPlayerVehicleID(playerid) >= VCount) return SendClientMessage(playerid,COLOR_WHITE,".זהו רכב ציבורי, אינו ניתן לקניה");
if(VehicleInfo[vehicleid][CarOwned] == 1 ) return SendClientMessage(playerid,COLOR_WHITE,".המכונית הזאתי שייכת למישהו אחר ");
if(pia[playerid][CarID] > 0) return SendClientMessage(playerid,COLOR_WHITE,".יש לך כבר מכונית");
if(VehicleInfo[vehicleid][Buyable] == 0)
return
format(msg,sizeof(msg),".הינו רכב ציבורי אינך יכול לקנות תרכב התמידי הזה ,%s רכב זה",VehicleInfo[vehicleid][CarName]),
SendClientMessage(playerid,WHITE,msg);


dini_IntSet(file,"CarOwned",1);
dini_Set(file,"CarOwner",PlayerName);
dini_IntSet(file,"Buyable",0);
dini_Set(file,"CarOwner",PlayerName);
VehicleInfo[vehicleid][CarOwned] = 1;
strmid(VehicleInfo[vehicleid][CarOwner], PlayerName, 0, strlen(PlayerName), 255);
VehicleInfo[vehicleid][Buyable] = 0;

pia[playerid][CarID] = GetPlayerVehicleID(playerid);
pia[playerid][OwnCar] = 1;
dini_IntSet(GetPlayerFile(playerid),"CarID",pia[playerid][CarID]);
dini_IntSet(GetPlayerFile(playerid),"OwnCar",1);
format(string,sizeof(string),"/Help Car בהצלחה, לעזרה בצע/י ,%s קנית את הרכב ,%s שלום לך",VehNames[GetVehicleModel(vehicleid)-400],GetName(playerid));
SendClientMessage(playerid,lblue,string);
LACY_GiveMoney(playerid,-VehicleInfo[vehicleid][Price]);
new File:f;
if(fexist(GetPlayerFile(playerid)))
{
dini_Set(GetPlayerFile(playerid),"Car",VehNames[GetVehicleModel(vehicleid)-400]);
f = fopen(GetPlayerFile(playerid),io_append);
fclose(f);
}
return 1;
}


if(VehicleInfo[car][SaleV] > 0)
{

if (PlayerInfo[playerid][Level] < 2) return Messagelevel (playerid, 2);
new vehicleid = GetPlayerVehicleID(playerid);
if(GetPlayerMoney(playerid) < VehicleInfo[car][SaleV]) return SendClientMessage(playerid,COLOR_WHITE,".אין לך מספיק כסף בשביל ליקנות את המכונית הזאתי ");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,COLOR_WHITE,".אתה צריך להיות במכונית שאתה רוצה ליקנות ");
if(GetPlayerVehicleID(playerid) >= VCount) return SendClientMessage(playerid,COLOR_WHITE,".זהו רכב ציבורי, אינו ניתן לקניה");
if(pia[playerid][CarID] > 0) return SendClientMessage(playerid,COLOR_WHITE,".יש לך כבר מכונית");

new fileuser[256];




format(fileuser,sizeof(fileuser),"RLSB/Users/%s.ini",dini_Get(file,"CarOwner"));
dini_IntSet(fileuser,"Bank",dini_Int(fileuser,"Bank")+VehicleInfo[car][SaleV]);
dini_IntSet(fileuser,"CarID",0);
dini_IntSet(fileuser,"OwnCar",0);
VehicleInfo[car][SaleV] = 0;
dini_IntSet(file,"SaleV",0);
dini_IntSet(file,"CarOwned",1);
dini_Set(file,"CarOwner",PlayerName);
dini_IntSet(file,"Buyable",0);
dini_Set(file,"CarOwner",PlayerName);
VehicleInfo[vehicleid][CarOwned] = 1;
strmid(VehicleInfo[vehicleid][CarOwner], PlayerName, 0, strlen(PlayerName), 255);
VehicleInfo[vehicleid][Buyable] = 0;
pia[playerid][CarID] = GetPlayerVehicleID(playerid);
pia[playerid][OwnCar] = 1;
dini_IntSet(GetPlayerFile(playerid),"CarID",pia[playerid][CarID]);
dini_IntSet(GetPlayerFile(playerid),"OwnCar",1);
format(string,sizeof(string),"/Help Car בהצלחה, לעזרה בצע/י ,%s קנית את הרכב ,%s שלום לך",VehNames[GetVehicleModel(vehicleid)-400],GetName(playerid));
SendClientMessage(playerid,lblue,string);
LACY_GiveMoney(playerid,-VehicleInfo[car][SaleV]);
new File:f;
if(fexist(GetPlayerFile(playerid)))
{
dini_Set(GetPlayerFile(playerid),"Car",VehNames[GetVehicleModel(vehicleid)-400]);
f = fopen(GetPlayerFile(playerid),io_append);
fclose(f);
}
return 1;
}
}
return 1;
}
//--

if(strcmp(cmd,"/setprice",true) == 0)
{

new FileCar[256];
format(FileCar,sizeof(FileCar),"CarSys/car%d.txt", pia[playerid][CarID]);

new icqnumb[256];
icqnumb = strtok(cmdtext,idx);

if(30 < strlen(icqnumb)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(icqnumb)) return SendClientMessage(playerid,COLOR_WHITE,"Usage: /SetPrice [Price]");
if(pia[playerid][CarID] == 0) return SendClientMessage(playerid,WHITE,".אין לך שום רכב בבעלותך");
if(VehicleInfo[pia[playerid][CarID]][SaleV] > 0) return SendClientMessage(playerid,WHITE,"Usage: /StopSale :הרכב שלך כבר מוצע למכירה, על מנת לעצור את המכירה בצע/י");
if(strval(icqnumb) > 100000000 || strval(icqnumb) < 1) return SendClientMessage(playerid,COLOR_WHITE,"Usage: /SetPrice [1 - 10,000,000]");
dini_IntSet(FileCar,"SaleV",strval(icqnumb));
VehicleInfo[pia[playerid][CarID]][SaleV] = dini_Int(FileCar,"SaleV");
format(string,sizeof(string),".[%d] - הצעת את הרכב שלך לציבור במחיר של כ",strval(icqnumb));
SendClientMessage(playerid,0xF6F658FF,string);
SendClientMessage(playerid,WHITE,"/StopSale :על מנת לעצור את מכירת הרכב בצע/י");
return 1;
}

if(strcmp(cmd,"/stopsale",true) == 0)
{

new FileCar[256];
format(FileCar,sizeof(FileCar),"CarSys/car%d.txt", pia[playerid][CarID]);
if(pia[playerid][CarID] == 0) return SendClientMessage(playerid,WHITE,".אין לך שום רכב בבעלותך");
if(VehicleInfo[pia[playerid][CarID]][SaleV] < 1) return SendClientMessage(playerid,WHITE,".הרכב שלך אינו מוצע לרכישה");
dini_IntSet(FileCar,"SaleV",0);
VehicleInfo[pia[playerid][CarID]][SaleV] = 0;
SendClientMessage(playerid,WHITE,".הפקסת את מכירת הרכב שלך");
return 1;
}

//==============================================================================
if(strcmp(cmd,"/callcar", true) == 0)
{
GetPlayerName(playerid,PlayerName,30);
if(GetPlayerInterior(playerid) == 1 || GetPlayerInterior(playerid) == 6 || GetPlayerInterior(playerid) == 10) return SendClientMessage(playerid,0xFF0000AA,".אתה לא יכול לתקוף שחקן שהוא נמצא בתוך אינטרור");
GetPlayerName(playerid,PlayerName,30);
new car = pia[playerid][CarID];
if(VehicleInfo[car][CarOwned] == 1 && pia[playerid][OwnCar] == 1)
{
if(GetPlayerMoney(playerid) < 0)
{
SendClientMessage(playerid,COLOR_WHITE," ");
}
else
{
for(new i=0;i<MAX_PLAYERS;i++) if(IsPlayerInVehicle(i,car))
{
RemovePlayerFromVehicle(i);
format(string,sizeof(string),".זימן את הרכב שלו, הליכה נעימה ,%s",PlayerName);
SendClientMessage(i,WHITE,string);
}
SetTimerEx("TeleCar",4000,0,"i",playerid);
SendClientMessage(playerid,LIGHTGREEN,"/Repair - .זימנת תרכב שלך בהצלחה, עם הרכב לא הגיע");
}
}
else
{
SendClientMessage(playerid,COLOR_WHITE,".אין בבעלותך שום רכב");
}
return 1;
}
//=======================
    
	if(strcmp(cmd, "/repair", true) == 0)
	{

		new vehicleid = GetPlayerVehicleID(playerid);
   		GetPlayerName(playerid,PlayerName,30);

    	if(! (IsPlayerInAnyVehicle(playerid)) ) return SendClientMessage(playerid,COLOR_WHITE,".אתה חייב להיות בתוך הרכב כדי להישתמש בשירות התיקונים");
		if(strcmp(PlayerName,VehicleInfo[vehicleid][CarOwner],true) != 0)return SendClientMessage(playerid,COLOR_WHITE,"! זו לא המכונית שלך אז אינך יכול לתקן אותה");
		if(pia[playerid][CarID] == 0) return SendClientMessage(playerid,COLOR_WHITE,".אין בבעלותך שום רכב");

		if(GetPlayerMoney(playerid) < 1000)
		{
			SendClientMessage(playerid,COLOR_WHITE,".אין לך מספיק כסף כדי להיתמש בשירות התיקונים");
		}
		else
		{
			GetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
			GetVehicleZAngle(GetPlayerVehicleID(playerid), Angle[playerid]);
			SetPlayerCameraPos(playerid, 1929.0, 2137.0, 11.0);
			SetPlayerCameraLookAt(playerid,1935.0, 2138.0, 11.5);
			if(IsPlayerInAnyVehicle(playerid)) SetVehiclePos(GetPlayerVehicleID(playerid), 1974.0,2162.0,11.0);
			SetVehicleZAngle(GetPlayerVehicleID(playerid), -90);
			SetTimerEx("RepairCar",5000,0,"i",playerid);
		    SendClientMessage(playerid,LIGHTGREEN,".תודה שהישתמשת בשירות התיקונים, המכונית תיהיה מוכנה תוך 5 שניות");
			LACY_GiveMoney(playerid,-1000);
		}
		return 1;
	}

//==============================================================================
	if(strcmp(cmd,"/eject", true)==0)
	{
		new pid;
		GetPlayerName(playerid,PlayerName,30);
		new vehicleid = GetPlayerVehicleID(playerid);
		tmp = strtok(cmdtext,idx);
        if(30 < strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");

		if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_WHITE,".אתה לא בתוך רכב");
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid,COLOR_WHITE,".נוסעים לא יכולים להישתמש בפקודה זו");

		if(strcmp(PlayerName,VehicleInfo[vehicleid][CarOwner],true) != 0)
   		return SendClientMessage(playerid,COLOR_WHITE,".זו לא המכונית שלך, אינך יכול להוציא ממנה נוסעים");

		if(!strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,"Usage: /Eject [playerid]");

		pid = strval(tmp);
		if(!IsPlayerConnected(pid)) return SendClientMessage(playerid,COLOR_WHITE," השחקן אינו מחובר");
		if(!IsPlayerInVehicle(pid,GetPlayerVehicleID(playerid)) ) return
			SendClientMessage(playerid,COLOR_WHITE,"! שחקן זה אינו ברכב שלך");

		RemovePlayerFromVehicle(pid);
		GameTextForPlayer(pid,"~W~You Have ~R~Ejected",3000,5);
	    
		SendClientMessage(playerid,BLUE,"Player ejected");
 		return 1;
}
//--
//============
GetPlayerName(playerid,playername, sizeof(playername));



if(strcmp(cmd, "/botq", true) == 0)
{
new Mr_Joe[256];
Mr_Joe= strtok(cmdtext, idx);
if(30 < strlen(Mr_Joe)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(Mr_Joe))
return SendClientMessage(playerid,WHITE,"Usage: /Botq [quiten]");



if(strcmp(Mr_Joe,"TS",true) == 0 || strcmp(Mr_Joe,"TeamSpeak",true) == 0)
return SendClientMessage(playerid,WHITE,"80.179.149.52:4545 :האייפי של הטים ספיק"),1;

if(strcmp(Mr_Joe,"פורום",true) == 0 || strfind(Mr_Joe,"הפורום?",true) == 0 ||  strcmp(Mr_Joe,"פורום",true) == 0 ||  strfind(Mr_Joe,"forum",true) == 0)
return SendClientMessage(playerid,WHITE,"www.Satla-Zone.co.il - הכתובת של הפורום"),1;

if(strcmp(Mr_Joe,"שמן",true) == 0 || strcmp(Mr_Joe,"?מי הילד הכי שמן",true) == 0)
return SendClientMessage(playerid,WHITE,"ברק מה לעשות, הוא הכי שמן :)"),1;


if(strcmp(Mr_Joe,"מתכנת",true) == 0 || strcmp(Mr_Joe,"Prog",true) == 0)
return SendClientMessage(playerid,WHITE,"רועיקוש הסקסי!!"),1;

if(strcmp(Mr_Joe,"ראשיים",true) == 0 || strcmp(Mr_Joe,"ראשים",true) == 0 || strfind(Mr_Joe,"מנהל",true) == 0 || strcmp(Mr_Joe,"מנהלים",true) == 0)
return SendClientMessage(playerid,WHITE,".סתיוי - האידיוט, ברק - השמן, יוני הגמד שאני אוהב אותו, מרועיקוש, תאריך:23/2/09"),1;

if(strcmp(Mr_Joe,"משעמם",true) == 0 || strcmp(Mr_Joe,"משעמם",true) == 0)
return SendClientMessage(playerid,WHITE,"[= קח במבה תתעודד"),1;

if(strcmp(Mr_Joe,"Shnitzel",true) == 0 || strcmp(Mr_Joe,"שניצל",true) == 0)
return SendClientMessage(playerid,WHITE,"[= גמאני רוצה שניאל !!"),1;

if(strcmp(Mr_Joe,"חטיף",true) == 0 || strcmp(Mr_Joe,"ממתק",true) == 0)

return SendClientMessage(playerid,WHITE,"?במבה שליטע, כאילו דה"),1;

else return SendClientMessage(playerid,WHITE,".לא נמצא תוכן שציינת, נסה שנית");
}

if(strcmp(cmd, "/clan", true) == 0)
{
new Roy_Killer[256];
Roy_Killer= strtok(cmdtext, idx);
if(30 < strlen(Roy_Killer)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(Roy_Killer))
{

SendClientMessage(playerid, COLOR_WHITE,"---- פקודות קלאנים ---");
SendClientMessage(playerid,0x0F482FF,"/Clan Create (3) <name> - ליצירת קלאן חדש");
SendClientMessage(playerid,0x0F482FF,"/Clan Invite <playerid> - הזמנת שחקן לקלאן");
SendClientMessage(playerid,0x0F482FF,"/Clan Join - להצטרפות לקלאן || /Clan Leave לעזיבת קלאן");
SendClientMessage(playerid,0x0F482FF,"/Clan Info <name> - לבדיקת נתונים של קלאן || /Clan Players <name> - בדיקת שחקנים מחוברים בקלאן");
SendClientMessage(playerid,0x0F482FF,"/Clan SM (2) <Message> עריכת הודעה חופשית");
SendClientMessage(playerid,0x0F482FF,"/Clan SetLevel (3) <playerid> <Level 1-3> - לשנות רמה לשחקן בקלאן");
SendClientMessage(playerid,0x0F482FF,"/Clan Skin (3) לערוך את הסקין של הקלאן שלכם על הסקין שנמצא עליכם || /Clan Color <1-20> (3) - שינוי הצבע של הקלאן");
SendClientMessage(playerid,0x0F482FF,"/Clan Kick <playerid> (3) - להעיף מישהוא מהקלאן");
SendClientMessage(playerid,0x0F482FF,"/Clan UnMute (3) להוריד מיוט לשחקן מהקלאן || /Clan Mute (3) <playerid> לתת מיוט לשחקן בקלאן");

return 1;
}

if(strcmp(Roy_Killer,"create",true) == 0)
{
if(PlayerInfo[playerid][Level] < 0) return Messagelevel(playerid,1);
		    tmp = strtok(cmdtext, idx);
			format(file,256,"Clans/%s.ini",tmp);
			new date[20];
			new year,month,day;	getdate(year, month, day);
            format(date, sizeof(date), "%d/%d/%d",day,month,year);

			if(!strlen(tmp))return SendClientMessage(playerid,COLOR_WHITE, "/Clan Create <ClanName> - שימוש");
            if(strlen(tmp) > 10 || strlen(tmp) < 2)return SendClientMessage(playerid,COLOR_WHITE, ".שם הקלאן חייב להכיל בין 2 ל10 תווים");
			if(dini_Int(GetPlayerFile(playerid), "ClanLvl") > 0)return SendClientMessage(playerid, COLOR_WHITE,"/Clan Leave - הנך חבר/ה בקלאן,על מנת לפתוח קלאן עליך לצאת מהקלאן הנוכחי שלך");
			if(GetPlayerMoney(playerid) < 75000)return SendClientMessage(playerid,COLOR_WHITE, ".עלות פתיחת קלאן היא $75,000 ");
	       	if(dini_Exists(file))return SendClientMessage(playerid, COLOR_WHITE,".נרשם קלאן בשם זה, אנא נסה שם אחר");
	         	LACY_GiveMoney(playerid,-75000);
			    dini_Create(file);
			    dini_Set(file,"ClanName",tmp);
			    dini_Set(file,"Established",date);
			    dini_Set(file,"EstablishedBy",playername);
			    dini_IntSet(file,"Leaders",1);
			    dini_IntSet(file,"SubLeaders",0);
			    dini_IntSet(file,"Total",1);
			    dini_IntSet(file,"Bank",0);
			    dini_Set(file,"Msg","None.");
			    dini_IntSet(file,"Color",0);
			    dini_IntSet(file,"Kills",0);
			    dini_IntSet(file,"Death",0);
 		        dini_IntSet(file,"skin",0);



			    dini_Set(GetPlayerFile(playerid), "Clan",tmp);

			    dini_IntSet(GetPlayerFile(playerid), "ClanLvl",3);
          format(strings, sizeof(strings), "---- %s - יצרת קלאן חדש בשם ----",dini_Get(file,"ClanName")); //tmp
			    SendClientMessage(playerid, WHITE,strings);
			    format(strings, sizeof(strings), ".%s התאריך היום של הפתיחה",dini_Get(file,"Established")); //tmp
			    SendClientMessage(playerid,0xF06E8DFF,strings);
			    format(strings, sizeof(strings), ".%s :השם של המייסד של הקלאן שבנית",dini_Get(file,"EstablishedBy")); //tmp
			    SendClientMessage(playerid,0xF06E8DFF,strings);
			    format(strings, sizeof(strings),  "SubLeaders: %d Leaders: %d.",dini_Int(file,"SubLeaders"),dini_Int(file,"Leaders")); //tmp
			    SendClientMessage(playerid,0xF06E8DFF,strings);
				format(strings, sizeof(strings), "%d :שחקנים בקלאן",dini_Int(file,"Total")); //tmp
			    SendClientMessage(playerid,0xF06E8DFF,strings);
				SendClientMessage(playerid,WHITE,"-----------------------");
format(strings, sizeof(strings), "---- %s נוצר קלאן חדש בשם ----",dini_Get(file,"ClanName")); //tmp
for(new ClanS = 0; ClanS < MAX_PLAYERS; ClanS++)
{
if(IsPlayerConnected(ClanS) && ClanS != playerid)
{
SendClientMessage(ClanS,COLOR_WHITE,strings);
SendClientMessage(ClanS,WHITE,strings);
format(strings, sizeof(strings), ".%s הקלאן נוצר על ידי",GetName(playerid)); //tmp
SendClientMessage(ClanS,0xF06E8DFF,strings);
format(strings, sizeof(strings), "/pm %d <Message> .פניה לפותח הקלאן בעזרה הפקודה",playerid); //tmp
SendClientMessage(ClanS,0xF06E8DFF,strings);
}
}
return 1;
}

if(strcmp(Roy_Killer,"skin",true) == 0)
{
if(!strcmp(dini_Get(GetPlayerFile(playerid),"Clan"),"None.",true))return SendClientMessage(playerid, COLOR_WHITE,".אינך חבר/ה בקלאן");
if(dini_Int(GetPlayerFile(playerid), "ClanLvl") < 2)return ClanError(playerid,3);
format(file,256,"Clans/%s.ini",dini_Get(GetPlayerFile(playerid),"Clan"));
dini_IntSet(file,"skin",GetPlayerSkin(playerid));
format(strings, sizeof(strings), "Skin Clan Change to %d by leader - %s. מעכשיו כל ספון יוחלף הסקין למה שהליד בחר",GetPlayerSkin(playerid),GetName(playerid)); //tmp

for(new i = 0; i < GetMaxPlayers() ; i++)
{
GetPlayerName(i,iname, sizeof(iname));
if(!strcmp(dini_Get(GetPlayerFile(playerid),"Clan"),dini_Get(GetPlayerFile(i),"Clan"),true))
{
if(dini_Int(GetPlayerFile(i), "ClanLvl") > 0)
{
SendClientMessage(i,lblue,strings);
}
}
}
return 1;
}
if(strcmp(Roy_Killer,"kick",true) == 0)
{
			new pidName[24];
			new pid, tmpp[256];
			tmpp = strtok(cmdtext, idx);
		if(strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"None.",true) == 0 || strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"None",true) == 0 || dini_Int(GetPlayerFile(playerid), "ClanLvl") < 1) return SendClientMessage(playerid, COLOR_WHITE,".אינך חבר/ה בקלאן");


			if(!strlen(tmpp))return SendClientMessage(playerid,COLOR_WHITE, "/Clan Kick <id/name> - שימוש");
			if(dini_Int(GetPlayerFile(playerid), "ClanLvl") < 3)return ClanError(playerid,3);
	    	if(!IsNumeric(tmpp)) pid = ReturnPlayerID(tmpp); else pid = strval(tmpp);
			if (!(IsPlayerConnected(pid)))return SendClientMessage(playerid,COLOR_WHITE, ".השחקן אינו מחובר");
			GetPlayerName(pid, pidName, sizeof(pidName));
           	if(strcmp(dini_Get(GetPlayerFile(playerid),"Clan"),    dini_Get(GetPlayerFile(pid),"Clan"),true))return SendClientMessage(playerid,COLOR_WHITE, ".השחקן אינו חבר בקלאן שלך");
// 	        if(strcmp(dini_Get(udb_encode(playername),"Clan"),dini_Get(udb_encode(pidName),"Clan"),true))return SendClientMessage(playerid,COLOR_WHITE, ".השחקן אינו חבר בקלאן שלך");
		if(strfind(dini_Get(GetPlayerFile(pid),"Clan"),"None.",true) == 0 || strfind(dini_Get(GetPlayerFile(pid),"Clan"),"None",true) == 0 || dini_Int(GetPlayerFile(pid), "ClanLvl") < 1) return SendClientMessage(playerid, COLOR_WHITE,".שחקן זה לא חבר בשום קלאן");


			if(pid == playerid)return SendClientMessage(playerid,COLOR_WHITE, ".אינך יכול להעיף את עצמך מהקלאן");
			format(strings, sizeof(strings),".%s מקלאן %s (ID: %d) הוצאת את",    dini_Get(GetPlayerFile(pid),"Clan"),pidName,pid); //tmp
			SendClientMessage(playerid, red,strings);
			format(strings, sizeof(strings),".%s הוציא אותך מקלאן %s (ID: %d)",    dini_Get(GetPlayerFile(playerid),"Clan"),playername,playerid); //tmp
			SendClientMessage(pid, red,strings);
			format(file,256,"Clans/%s.ini",    dini_Get(GetPlayerFile(playerid),"Clan"));
			dini_IntSet(file,"Total",dini_Int(file,"Total")-1);
			 for(new i = 0; i < GetMaxPlayers() ; i++){
            GetPlayerName(i,iname, sizeof(iname));
            if(i != playerid && !strcmp(    dini_Get(GetPlayerFile(playerid),"Clan"),    dini_Get(GetPlayerFile(i),"Clan"),true)){
            format(strings,sizeof(strings),".%s הוצא מהקלאן על ידי %s",playername,pidName);
            SendClientMessage(i,red,strings);
            }}
			dini_Set(GetPlayerFile(pid), "Clan","None.");

            dini_IntSet(GetPlayerFile(pid), "ClanLvl",0);
return 1;
}
//==
if(strcmp(Roy_Killer,"mute",true) == 0)
{
			new pidName[24];
			new pid, tmpp[256];
			tmpp = strtok(cmdtext, idx);
		if(strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"None.",true) == 0 || strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"None",true) == 0 || dini_Int(GetPlayerFile(playerid), "ClanLvl") < 1) return SendClientMessage(playerid, COLOR_WHITE,".אינך חבר/ה בקלאן");


			if(!strlen(tmpp))return SendClientMessage(playerid,COLOR_WHITE, "/Clan Mute <id/name> - שימוש");
			if(dini_Int(GetPlayerFile(playerid), "ClanLvl") < 3)return ClanError(playerid,3);
	    	if(!IsNumeric(tmpp)) pid = ReturnPlayerID(tmpp); else pid = strval(tmpp);
			if (!(IsPlayerConnected(pid)))return SendClientMessage(playerid,COLOR_WHITE, ".השחקן אינו מחובר");
			GetPlayerName(pid, pidName, sizeof(pidName));
           	if(strcmp(dini_Get(GetPlayerFile(playerid),"Clan"),    dini_Get(GetPlayerFile(pid),"Clan"),true))return SendClientMessage(playerid,COLOR_WHITE, ".השחקן אינו חבר בקלאן שלך");
     		if(strfind(dini_Get(GetPlayerFile(pid),"Clan"),"None.",true) == 0 || strfind(dini_Get(GetPlayerFile(pid),"Clan"),"None",true) == 0 || dini_Int(GetPlayerFile(pid), "ClanLvl") < 1) return SendClientMessage(playerid, COLOR_WHITE,".שחקן זה לא חבר בשום קלאן");




			 for(new i = 0; i < GetMaxPlayers() ; i++){
            GetPlayerName(i,iname, sizeof(iname));
            if(!strcmp(    dini_Get(GetPlayerFile(playerid),"Clan"),    dini_Get(GetPlayerFile(i),"Clan"),true)){
            format(strings,sizeof(strings),".%s קיבל מיוט על הצ'אט קלאן על ידי %s",playername,pidName);
            SendClientMessage(i,red,strings);

            }}
ClanMute[pid] = 1;
return 1;
}


if(strcmp(Roy_Killer,"unmute",true) == 0)
{
			new pidName[24];
			new pid, tmpp[256];
			tmpp = strtok(cmdtext, idx);
		if(strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"None.",true) == 0 || strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"None",true) == 0 || dini_Int(GetPlayerFile(playerid), "ClanLvl") < 1) return SendClientMessage(playerid, COLOR_WHITE,".אינך חבר/ה בקלאן");


			if(!strlen(tmpp))return SendClientMessage(playerid,COLOR_WHITE, "/Clan UnMute <id/name> - שימוש");
			if(dini_Int(GetPlayerFile(playerid), "ClanLvl") < 3)return ClanError(playerid,3);
	    	if(!IsNumeric(tmpp)) pid = ReturnPlayerID(tmpp); else pid = strval(tmpp);
			if (!(IsPlayerConnected(pid)))return SendClientMessage(playerid,COLOR_WHITE, ".השחקן אינו מחובר");
			GetPlayerName(pid, pidName, sizeof(pidName));
			if(ClanMute[pid] == 0) return SendClientMessage(playerid,WHITE,".שחקן זה לא במיוט בקלאן שלך");
           	if(strcmp(dini_Get(GetPlayerFile(playerid),"Clan"),    dini_Get(GetPlayerFile(pid),"Clan"),true))return SendClientMessage(playerid,COLOR_WHITE, ".השחקן אינו חבר בקלאן שלך");
     		if(strfind(dini_Get(GetPlayerFile(pid),"Clan"),"None.",true) == 0 || strfind(dini_Get(GetPlayerFile(pid),"Clan"),"None",true) == 0 || dini_Int(GetPlayerFile(pid), "ClanLvl") < 1) return SendClientMessage(playerid, COLOR_WHITE,".שחקן זה לא חבר בשום קלאן");


	

			 for(new i = 0; i < GetMaxPlayers() ; i++){
            GetPlayerName(i,iname, sizeof(iname));
            if(!strcmp(    dini_Get(GetPlayerFile(playerid),"Clan"),    dini_Get(GetPlayerFile(i),"Clan"),true)){
            format(strings,sizeof(strings),".%s הוריד מיוט ל %s",playername,pidName);
            SendClientMessage(i,red,strings);

            }}
ClanMute[pid] = 0;
return 1;
}
//==

if(strcmp(Roy_Killer,"SM",true) == 0)
{
new tmpon[256];
		    tmpon= strtok(cmdtext, idx);
		if(strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"None.",true) == 0 || strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"None",true) == 0 || dini_Int(GetPlayerFile(playerid), "ClanLvl") < 1) return SendClientMessage(playerid, COLOR_WHITE,".אינך חבר/ה בקלאן");

			format(file,256,"Clans/%s.ini",	 dini_Get(GetPlayerFile(playerid),"Clan"));
			if(!strlen(tmpon))return SendClientMessage(playerid,COLOR_WHITE, "/Clan SM <Message> - שימוש");
			if(dini_Int(GetPlayerFile(playerid), "ClanLvl") < 2)return ClanError(playerid,2);
			dini_Set(file,"Msg",cmdtext[8]);//TMP
			format(strings, sizeof(strings), "Your Edited the Clan  Msg To: '%s'.",cmdtext[256]); //tmp
			SendClientMessage(playerid, 0x0EDC8FF,strings);
return 1;
}
if(strcmp(Roy_Killer,"setlevel",true) == 0)
{
		new pidName[24];
			new pid,lvl, tmpp[256];
			tmpp = strtok(cmdtext, idx);
//			  	if(!strcmp(	 dini_Get(GetPlayerFile(playerid),"Clan"),"None.",true))return SendClientMessage(playerid, COLOR_WHITE,".אינך חבר/ה בקלאן");
if(strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"None.",true) == 0 || strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"None",true) == 0 || dini_Int(GetPlayerFile(playerid), "ClanLvl") < 1) return SendClientMessage(playerid, COLOR_WHITE,".אינך חבר/ה בקלאן");

			if(!strlen(tmpp))return SendClientMessage(playerid,COLOR_WHITE, "/Clan SetLevel <id/name> <Level> - שימוש");
			if(dini_Int(GetPlayerFile(playerid), "ClanLvl") < 3)return ClanError(playerid,3);
		    if(!IsNumeric(tmpp)) pid = ReturnPlayerID(tmpp); else pid = strval(tmpp);
			if (!(IsPlayerConnected(pid)))return SendClientMessage(playerid,COLOR_WHITE, ".השחקן אינו מחובר");
			GetPlayerName(pid, pidName, sizeof(pidName));
			if(strcmp(dini_Get(GetPlayerFile(playerid),"Clan"),	 dini_Get(GetPlayerFile(pid),"Clan"),true))return SendClientMessage(playerid,COLOR_WHITE, ".השחקן אינו חבר בקלאן שלך");
		 	if(pid == playerid)return SendClientMessage(playerid,COLOR_WHITE,".אינך יכול לערוך את רמתך בקלאן");
	    	tmpp = strtok(cmdtext, idx);
        	if(!strlen(tmpp))return SendClientMessage(playerid,COLOR_WHITE,"/ClanSetLevel <id/name> <Level> - שימוש");
        	lvl = strval(tmpp);
        	if(lvl < 1 || lvl > 3)return SendClientMessage(playerid,COLOR_WHITE, "Level 1 - Total Player | Level 2 - Tester | Level 3 - Leader");
           	if(lvl == 1 && dini_Int(GetPlayerFile(pid),"ClanLvl") == 3)dini_IntSet(file,"Leaders",dini_Int(file,"Leaders")-1);
           	if(lvl == 2 && dini_Int(GetPlayerFile(pid),"ClanLvl") == 3)dini_IntSet(file,"Leaders",dini_Int(file,"Leaders")-1),dini_IntSet(file,"SubLeaders",dini_Int(file,"SubLeaders")+1);
       		if(lvl == 1 && dini_Int(GetPlayerFile(pid),"ClanLvl") == 2)dini_IntSet(file,"SubLeaders",dini_Int(file,"SubLeaders")-1);
	    	if(lvl == 3 && dini_Int(GetPlayerFile(pid),"ClanLvl") == 2)dini_IntSet(file,"Leaders",dini_Int(file,"Leaders")+1),dini_IntSet(file,"SubLeaders",dini_Int(file,"SubLeaders")-1);
	    	if(lvl == 3 && dini_Int(GetPlayerFile(pid),"ClanLvl") == 1)dini_IntSet(file,"Leaders",dini_Int(file,"Leaders")+1);
	    	if(lvl == 2 && dini_Int(GetPlayerFile(pid),"ClanLvl") == 1)dini_IntSet(file,"Leaders",dini_Int(file,"SubLeaders")+1);
           	dini_IntSet(GetPlayerFile(pid), "ClanLvl",lvl);
			format(strings, sizeof(strings),".%d ל %s (ID :%d) העלת את רמת הקלאן של",dini_Int(GetPlayerFile(pid),"ClanLvl"),pidName,pid); //tmp
			SendClientMessage(playerid, 0x0EDC8FF,strings);
			format(strings, sizeof(strings),".%d - שם את רמתך בקלאן %s (ID: %d)",dini_Int(GetPlayerFile(pid),"ClanLvl"),playername,playerid); //tmp
			SendClientMessage(pid, 0x0EDC8FF,strings);
			return 1;
			}
			
if(strcmp(Roy_Killer,"info",true) == 0)
{
		    tmp = strtok(cmdtext, idx);
			format(file,256,"Clans/%s.ini",tmp);
			if(!strlen(tmp))return SendClientMessage(playerid, COLOR_WHITE, "/Clan Info <ClanName> - שימוש");

	       	if(!dini_Exists(file))return SendClientMessage(playerid, COLOR_WHITE,"לא נרשם קלאן בשם כזה");

                format(strings, sizeof(strings), "---- %s - מידע עבור הקלאן ----",dini_Get(file,"ClanName")); //tmp
			    SendClientMessage(playerid, WHITE,strings);
			    format(strings, sizeof(strings), ".%s :תאריך פתיחה",dini_Get(file,"Established")); //tmp
			    SendClientMessage(playerid,0xF06E8DFF,strings);
			    format(strings, sizeof(strings), ".%s :מייסד הקלאן",dini_Get(file,"EstablishedBy")); //tmp
			    SendClientMessage(playerid,0xF06E8DFF,strings);
			    format(strings, sizeof(strings),  "SubLeaders: %d Leaders: %d.",dini_Int(file,"SubLeaders"),dini_Int(file,"Leaders")); //tmp
			    SendClientMessage(playerid,0xF06E8DFF,strings);

			    format(strings, sizeof(strings), "%d :שחקנים",dini_Int(file,"Total")); //tmp
			    SendClientMessage(playerid,0xF06E8DFF,strings);

			    SendClientMessage(playerid,0x0F482FF, ":הודעת מנהלי הקלאן");
			    format(strings, sizeof(strings), "%s",dini_Get(file,"Msg")); //tmp
			    SendClientMessage(playerid, 0xF06E8DFF,strings);
			    SendClientMessage(playerid,WHITE,"-----------------------");
			    return 1;
			    }
if(strcmp(Roy_Killer,"Leave",true) == 0)
{
//   if(dini_Int(GetPlayerFile(playerid), "ClanLvl") < 1)return SendClientMessage(playerid, COLOR_WHITE,".אתה לא חבר/ה בקלאן");
//if(!strcmp(	 dini_Get(GetPlayerFile(playerid),"Clan"),"None.",true))return SendClientMessage(playerid, COLOR_WHITE,".אינך חבר/ה בקלאן");
if(strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"None.",true) == 0 || strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"None",true) == 0 || dini_Int(GetPlayerFile(playerid), "ClanLvl") < 1) return SendClientMessage(playerid, COLOR_WHITE,".אינך חבר/ה בקלאן");
format(strings, sizeof(strings),".%s יצאת מקלאן",	 dini_Get(GetPlayerFile(playerid),"Clan")); //tmp
SendClientMessage(playerid, COLOR_BRIGHTRED,strings);
format(strings,sizeof(strings),".עזב את הקלאן %s",playername);
for(new i = 0; i < GetMaxPlayers() ; i++)
{
GetPlayerName(i,iname, sizeof(iname));
if(!strcmp(dini_Get(GetPlayerFile(playerid),"Clan"),dini_Get(GetPlayerFile(i),"Clan"),true) && i != playerid){
SendClientMessage(i,red,strings);
}
}
format(file,256,"Clans/%s.ini",dini_Get(GetPlayerFile(playerid),"Clan"));
dini_IntSet(file,"Total",dini_Int(file,"Total")-1);
dini_Set(GetPlayerFile(playerid), "Clan","None.");
dini_IntSet(GetPlayerFile(playerid), "ClanLvl",0);
return 1;
}
if(strcmp(Roy_Killer,"players",true) == 0)
{
		    tmp = strtok(cmdtext, idx);
			format(file,256,"Clans/%s.ini",tmp);
			if(!strlen(tmp))return SendClientMessage(playerid,COLOR_WHITE, "/Clan Players <ClanName> - שימוש");

	       	if(!dini_Exists(file))return SendClientMessage(playerid,COLOR_WHITE,".לא נרשם קלאן בשם זה");
			   new playerscount;
               format(strings, sizeof(strings),".%s Clan - שחקנים מחוברים",tmp); //tmp
			   SendClientMessage(playerid,green,strings);
               for(new i=0;i<GetMaxPlayers();i++){
               GetPlayerName(i,iname, sizeof(iname));
               if(IsPlayerConnected(i) && !strcmp(dini_Get(GetPlayerFile(i),"Clan"),tmp,true)){
               playerscount ++;
               format(strings, sizeof(strings),"%d. %s (ID :%d | LVL %d)",playerscount,iname,dini_Int(GetPlayerFile(i), "ClanLvl"),i); //tmp
			   SendClientMessage(playerid, COLOR_GREY,strings);

			   }}
			   if(playerscount == 0)return SendClientMessage(playerid,COLOR_WHITE,".אין שחקנים מחוברים בקלאן זה");
               return 1;
			   }
			   if(strcmp(Roy_Killer,"invite",true) == 0)
{
			   
			   			new pidName[24];
		//	new pid,
			new tmpp[256];
			tmpp = strtok(cmdtext, idx);

if(strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"None.",true) == 0 || strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"None",true) == 0 || dini_Int(GetPlayerFile(playerid), "ClanLvl") < 1) return SendClientMessage(playerid, COLOR_WHITE,".אינך חבר/ה בקלאן");

			if(!strlen(tmpp))return SendClientMessage(playerid,COLOR_WHITE, "/Clan Invite <id/name> - שימוש");
			if(dini_Int(GetPlayerFile(playerid), "ClanLvl") < 2)return ClanError(playerid,2);
			new pid; if(!IsNumeric(tmpp)) pid = ReturnPlayerID(tmpp); else pid = strval(tmpp);
			if (!(IsPlayerConnected(pid)))return SendClientMessage(playerid,COLOR_WHITE, ".השחקן אינו מחובר");
			GetPlayerName(pid, pidName, sizeof(pidName));
			if(dini_Int(GetPlayerFile(playerid), "ClanLvl") < 1)return SendClientMessage(playerid, COLOR_WHITE,".אינך חבר/ה בקלאן");
			if(dini_Int(GetPlayerFile(pid), "ClanLvl") > 0)return SendClientMessage(playerid, COLOR_WHITE,".שחקן זה כבר חבר/ה בקלאן אחר");
	if(pid == playerid)return SendClientMessage(playerid,COLOR_WHITE, ".אינך יכול להזמין את עצמך לקלאן");
			format(strings, sizeof(strings),".%s להצטרף לקלאן %s (ID: %d) הזמנת את",dini_Get(GetPlayerFile(playerid),"Clan"),pidName,pid); //tmp
			SendClientMessage(playerid, COLOR_WHITE,strings);
			format(strings, sizeof(strings),".%s (ID: %d) - על ידי  %s הוזמנת לקלאן",playername,playerid,dini_Get(GetPlayerFile(playerid),"Clan")); //tmp
			SendClientMessage(pid, 0xF06E8DFF,strings);
			SendClientMessage(pid, 0xF06E8DFF,"/Clan Join - על מנת להצטרף לקלאן, בצע/י *");
			IsInvited[pid] = 1;
			InviteClanName[pid] = dini_Get(GetPlayerFile(playerid),"Clan");
			return 1;
			}
						   if(strcmp(Roy_Killer,"join",true) == 0)
{
						if(IsInvited[playerid] == 0)return SendClientMessage(playerid,COLOR_WHITE,".לא הוזמנת לקלאן");
			if(dini_Int(GetPlayerFile(playerid), "ClanLvl") > 0)return SendClientMessage(playerid, COLOR_WHITE,"/Clan Leave - הנך חבר/ה בקלאן,על מנת לפתוח קלאן עליך לצאת מהקלאן הנוכחי שלך");
			dini_Set(GetPlayerFile(playerid),"Clan",InviteClanName[playerid]);
			dini_IntSet(GetPlayerFile(playerid), "ClanLvl",1);
			dini_IntSet(GetPlayerFile(playerid), "ClanLvl",1);
			format(file,256,"Clans/%s.ini",dini_Get(GetPlayerFile(playerid),"Clan"));
			dini_IntSet(file,"Total",dini_Int(file,"Total")+1);
            for(new i = 0; i < GetMaxPlayers() ; i++){
            GetPlayerName(i,iname, sizeof(iname));
            if(i != playerid && !strcmp(dini_Get(GetPlayerFile(playerid),"Clan"),dini_Get(GetPlayerFile(i),"Clan"),true)){
            format(strings,sizeof(strings),".הצטרף לקלאן '%s'",playername);
            SendClientMessage(i,0xF06E8DFF,strings);
            }}
            format(strings, sizeof(strings),".בהצלחה '%s' הצטרפת לקלאן",dini_Get(GetPlayerFile(playerid),"Clan")); //tmp
			SendClientMessage(playerid, 0xF06E8DFF,strings);
			IsInvited[playerid] = 0;
   return 1;
   }
   			   if(strcmp(Roy_Killer,"color",true) == 0)
{
   
   			if(!strcmp(dini_Get(GetPlayerFile(playerid),"Clan"),"None.",true))return SendClientMessage(playerid, COLOR_WHITE,".אינך חבר/ה בקלאן");
			if(dini_Int(GetPlayerFile(playerid), "ClanLvl") < 3)return ClanError(playerid,3);
		    format(file,256,"Clans/%s.ini",dini_Get(GetPlayerFile(playerid),"Clan"));
	        new colornum[256];
	        colornum = strtok(cmdtext, idx);
	        new num = strval(colornum);
	        if(!strlen(colornum))return SendClientMessage(playerid,COLOR_WHITE, "/clan color [1 - 20 / List / Off (0)]");
            if(!strcmp(colornum,"List",true)){
            SendClientMessage(playerid,0xFF9900AA,"1 'צבע קלאן מספר");
  	        SendClientMessage(playerid,0x6DC5F3AA,"צבע קלאן מספר 2");
  	        SendClientMessage(playerid,0xFF0000AA,"צבע קלאן מספר 3");
  	        SendClientMessage(playerid,0x24FF0AAA,"צבע קלאן מספר 4");
  	        SendClientMessage(playerid,0x330066AA,"צבע קלאן מספר 5");
  	        SendClientMessage(playerid,0xFF66FFAA,"צבע קלאן מספר 6");
  	        SendClientMessage(playerid,0x0000BBAA,"צבע קלאן מספר 7");
  	        SendClientMessage(playerid,0x7CFC00AA,"צבע קלאן מספר 8");
            SendClientMessage(playerid,0xDC143CAA,"צבע קלאן מספר 9");
  	        SendClientMessage(playerid,0x00FFFFAA,"צבע קלאן מספר 10");
  	        SendClientMessage(playerid,0x008D00AA,"צבע קלאן מספר 11");
  	        SendClientMessage(playerid,0x00FFFFAA,"צבע קלאן מספר 12");
  	        SendClientMessage(playerid,0x6495EDAA,"צבע קלאן מספר 13");
  	        SendClientMessage(playerid,0xFFFF00AA,"צבע קלאן מספר 14");
  	        SendClientMessage(playerid,0xEECFA1AA,"צבע קלאן מספר 15");
  	        SendClientMessage(playerid,0xDDDD23AA,"צבע קלאן מספר 16");
  	        SendClientMessage(playerid,0x4B00B0AA,"צבע קלאן מספר 17");
  	        SendClientMessage(playerid,0x99FFFFAA,"צבע קלאן מספר 18");
            SendClientMessage(playerid,0x006400AA,"צבע קלאן מספר 19");
  	        SendClientMessage(playerid,0xC715FFAA,"צבע קלאן מספר 20");
  	        return 1;
  	        }
  	        if(!strcmp(colornum,"Off",true))return dini_IntSet(file,"Color",0),SendClientMessage(playerid,COLOR_WHITE,".ביטלת את צבע הקלאן התמידי");
	     	switch(num)
	     	{
	     	case 0:dini_IntSet(file,"Color",0),SendClientMessage(playerid,COLOR_WHITE,".ביטלת את צבע הקלאן התמידי");
  	        case 1:dini_IntSet(file,"Color",1),SendClientMessage(playerid,0xFF9900AA,".שינית את צבע הקלאן לצבע מס' 1");
  	        case 2:dini_IntSet(file,"Color",2),SendClientMessage(playerid,0x6DC5F3AA,".שינית את צבע הקלאן לצבע מס' 2");
  	        case 3:dini_IntSet(file,"Color",3),SendClientMessage(playerid,0xFF0000AA,".שינית את צבע הקלאן לצבע מס' 3");
  	        case 4:dini_IntSet(file,"Color",4),SendClientMessage(playerid,0x24FF0AAA,".שינית את צבע הקלאן לצבע מס' 4");
  	        case 5:dini_IntSet(file,"Color",5),SendClientMessage(playerid,0x330066AA,".שינית את צבע הקלאן לצבע מס' 5");
  	        case 6:dini_IntSet(file,"Color",6),SendClientMessage(playerid,0xFF66FFAA,".שינית את צבע הקלאן לצבע מס' 6");
  	        case 7:dini_IntSet(file,"Color",7),SendClientMessage(playerid,0x0000BBAA,".שינית את צבע הקלאן לצבע מס' 7");
  	        case 8:dini_IntSet(file,"Color",8),SendClientMessage(playerid,0x7CFC00AA,".שינית את צבע הקלאן לצבע מס' 8");
            case 9:dini_IntSet(file,"Color",9),SendClientMessage(playerid,0xDC143CAA,".שינית את צבע הקלאן לצבע מס' 9");
  	        case 10:dini_IntSet(file,"Color",10),SendClientMessage(playerid,0x00FFFFAA,".שינית את צבע הקלאן לצבע מס' 10");
  	        case 11:dini_IntSet(file,"Color",11),SendClientMessage(playerid,0x008D00AA,".שינית את צבע הקלאן לצבע מס' 11");
 	        case 12:dini_IntSet(file,"Color",12),SendClientMessage(playerid,0x00FFFFAA,".שינית את צבע הקלאן לצבע מס' 12");
  	        case 13:dini_IntSet(file,"Color",13),SendClientMessage(playerid,0x6495EDAA,".שינית את צבע הקלאן לצבע מס' 13");
  	        case 14:dini_IntSet(file,"Color",14),SendClientMessage(playerid,0xFFFF00AA,".שינית את צבע הקלאן לצבע מס' 14");
  	        case 15:dini_IntSet(file,"Color",15),SendClientMessage(playerid,0xEECFA1AA,".שינית את צבע הקלאן לצבע מס' 15");
  	        case 16:dini_IntSet(file,"Color",16),SendClientMessage(playerid,0xDDDD23AA,".שינית את צבע הקלאן לצבע מס' 16");
  	        case 17:dini_IntSet(file,"Color",17),SendClientMessage(playerid,0x4B00B0AA,".שינית את צבע הקלאן לצבע מס' 17");
  	        case 18:dini_IntSet(file,"Color",18),SendClientMessage(playerid,0x99FFFFAA,".שינית את צבע הקלאן לצבע מס' 18");
            case 19:dini_IntSet(file,"Color",19),SendClientMessage(playerid,0x006400AA,".שינית את צבע הקלאן לצבע מס' 19");
  	        case 20:dini_IntSet(file,"Color",20),SendClientMessage(playerid,0xC715FFAA,".שינית את צבע הקלאן לצבע מס' 20");
  	        default:SendClientMessage(playerid,COLOR_WHITE, "/clan color [1 - 20 / List / Off (0)] - שימוש");
	    }
	    return 1;
	    }
   
   

return 1;
}


//new namer[256];
new animationplayed;
//new PlayerName[100];
//CarSys
//WarInvite
//new name3[256];
//GetPlayerName(playerid,name3,256);









//End
//BoMB

//--


	
//-----




if(!strcmp(cmd,"/register",true) || !strcmp(cmd,"/rdassadas",true))
{
new pass[256];

CheckPlayerCMDLevel(playerid,register);
if(IsPlayerLogged(playerid)) return SendClientMessage(playerid,COLOR_WHITE,"אתה כבר רשום");
pass = strtok(cmdtext,idx);
if(30 < strlen(pass)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(pass)) return SendClientMessage(playerid,COLOR_WHITE,"/Register [password] הכנס סיסמא בבקשה דוגמא");
if(Config[MaxPasswordLength] < strlen(pass) || strlen(pass) < Config[MinPasswordLength]) {
format(string,sizeof(string)," %d-%d אורך הסיסמה חייב להיות בין",Config[MaxPasswordLength], Config[MinPasswordLength]);
SendClientMessage(playerid,COLOR_WHITE,string);
return 1;
}
if(dini_Exists(GetPlayerFile(playerid)))
{
format(string, sizeof(string), "/Login [password] :הינו שם משתמש רשום, להתחברות %s :שם המשתמש/ת", GetName(playerid));
SendClientMessage(playerid, WHITE, string);
return 1;
}
PlayerInfo[playerid][VIPS] = 0;
PlayerInfo[playerid][armourT] = 0;
PlayerInfo[playerid][ProfileLogged] =0;
PlayerInfo[playerid][Warnings] = 0;
PlayerInfo[playerid][Weeds] = 0;
PlayerInfo[playerid][TimeOnServer]++;
PlayerInfo[playerid][Logged] = 1;
PlayerInfo[playerid][Level] = 0;
PlayerInfo[playerid][Kills] = 0;
PlayerInfo[playerid][Deaths] = 0;
PlayerInfo[playerid][Bank] = 0;
PlayerInfo[playerid][Wars] = 0;
PlayerInfo[playerid][autologin] = 0;
PlayerInfo[playerid][GetAloan] =0;
PlayerInfo[playerid][MoneyLoan] =0;
PlayerInfo[playerid][AdminsLevel] = 0;
PlayerInfo[playerid][Kart] = 0;
PlayerInfo[playerid][AggInfo] =0;
PlayerInfo[playerid][GemelLogin] = 0;
PlayerInfo[playerid][KopatGemel] =0;
PlayerInfo[playerid][Monster] = 0;
PlayerInfo[playerid][RPGS] = 0;
PlayerInfo[playerid][MINIGUN] = 0;
PlayerInfo[playerid][Mlg] = 0;
PlayerInfo[playerid][CcMode] = 0;
PlayerInfo[playerid][Supportives] =0;
PlayerInfo[playerid][Tor] =0;
PlayerInfo[playerid][Pets] =0;
PlayerInfo[playerid][Shark] =0;
PlayerInfo[playerid][Dolp] =0;
PlayerInfo[playerid][SharkKills] =0;
PlayerInfo[playerid][DolphinKills]=0;
PlayerInfo[playerid][TorKills] =0;
PlayerInfo[playerid][bazooka] =0;
PlayerInfo[playerid][aLevelnl]=1;
PlayerInfo[playerid][aKillsnl]=100;

PlayerInfo[playerid][Level] = 0;
PlayerInfo[playerid][Kills] = 0;
PlayerInfo[playerid][Deaths] = 0;
PlayerInfo[playerid][Logged] = 1;
PlayerInfo[playerid][Sawn] = 0;
PlayerInfo[playerid][MicroSMG] = 0;
PlayerInfo[playerid][Tec9] = 0;
PlayerInfo[playerid][M4] = 0;
PlayerInfo[playerid][MP5] = 0;
PlayerInfo[playerid][AK47] = 0;
PlayerInfo[playerid][Knife] = 0;
PlayerInfo[playerid][Katana] = 0;
PlayerInfo[playerid][CombatShotGun] = 0;
PlayerInfo[playerid][ShotGun] = 0;
PlayerInfo[playerid][SniperRifle] = 0;
PlayerInfo[playerid][CRifle] = 0;
PlayerInfo[playerid][Colt] = 0;
PlayerInfo[playerid][Sawn] = 0;
pia[playerid][CarID]=0;
pia[playerid][OwnCar]=0;
PlayerInfo[playerid][BSHIP] = 0;
dini_IntSet(GetPlayerFile(playerid),"ClanLvl",0);
dini_IntSet(GetPlayerFile(playerid),"Kills",0);
dini_IntSet(GetPlayerFile(playerid),"Deaths",0);
dini_IntSet(GetPlayerFile(playerid),"Bank",0);
dini_IntSet(GetPlayerFile(playerid),"BSHIP",0);
dini_IntSet(GetPlayerFile(playerid),"Sawn",0);
dini_IntSet(GetPlayerFile(playerid),"MicroSMG",0);
dini_IntSet(GetPlayerFile(playerid),"Tec9",0);
dini_IntSet(GetPlayerFile(playerid),"M4",0);
dini_IntSet(GetPlayerFile(playerid),"MP5",0);
dini_IntSet(GetPlayerFile(playerid),"AK47",0);
dini_IntSet(GetPlayerFile(playerid),"Knife",0);
dini_IntSet(GetPlayerFile(playerid),"Katana",0);
dini_IntSet(GetPlayerFile(playerid),"CombatShotGun",0);
dini_IntSet(GetPlayerFile(playerid),"ShotGun",0);
dini_IntSet(GetPlayerFile(playerid),"SniperRifle",0);
dini_IntSet(GetPlayerFile(playerid),"CRifle",0);
dini_IntSet(GetPlayerFile(playerid),"Colt",0);
dini_IntSet(GetPlayerFile(playerid),"CarID",0);
dini_IntSet(GetPlayerFile(playerid),"OwnCar",0);
dini_IntSet(GetPlayerFile(playerid),"aLevelnl",1);
dini_IntSet(GetPlayerFile(playerid),"aKillsnl",100);
dini_IntSet(GetPlayerFile(playerid),"GemelLogin",0);
dini_IntSet(GetPlayerFile(playerid),"KopatGemel",0);
dini_IntSet(GetPlayerFile(playerid),"bazooka",0);
dini_IntSet(GetPlayerFile(playerid),"MoneyLoan",0);
dini_IntSet(GetPlayerFile(playerid),"GetAloan",0);
dini_IntSet(GetPlayerFile(playerid),"AggInfo",0);
dini_IntSet(GetPlayerFile(playerid),"TorKills",0);
dini_IntSet(GetPlayerFile(playerid),"DolphinKills",0);
dini_IntSet(GetPlayerFile(playerid),"SharkKills",0);
dini_IntSet(GetPlayerFile(playerid),"Tor",0);
dini_IntSet(GetPlayerFile(playerid),"Dolphin",0);
dini_IntSet(GetPlayerFile(playerid),"Pets",0);
dini_IntSet(GetPlayerFile(playerid),"Shark",0);
dini_IntSet(GetPlayerFile(playerid),"Supportives",0);
dini_IntSet(GetPlayerFile(playerid),"CC",0);
dini_IntSet(GetPlayerFile(playerid),"Kills",0);
dini_IntSet(GetPlayerFile(playerid),"Deaths",0);
dini_IntSet(GetPlayerFile(playerid),"Bank",0);
dini_IntSet(GetPlayerFile(playerid),"Wars",0);
dini_IntSet(GetPlayerFile(playerid),"Adminl",0);
dini_IntSet(GetPlayerFile(playerid),"Warning",0);
dini_IntSet(GetPlayerFile(playerid),"autologins",0);
dini_IntSet(GetPlayerFile(playerid),"VIP",0);
dini_IntSet(GetPlayerFile(playerid),"armour",0);
dini_IntSet(GetPlayerFile(playerid),"TimeOnServer",PlayerInfo[playerid][TimeOnServer]);
dini_IntSet(GetPlayerFile(playerid),"Karts",0);
dini_IntSet(GetPlayerFile(playerid),"MonsterWin",0);
dini_IntSet(GetPlayerFile(playerid),"RPGWIN",0);
dini_IntSet(GetPlayerFile(playerid),"MiniWin",0);
dini_IntSet(GetPlayerFile(playerid),"mlg",0);
dini_Create(GetPlayerFile(playerid));
RegisterPlayer(playerid,pass);


/*
format(string, sizeof(string),"---- !חשבון נוצר בהצלחה ---",GetName(playerid));
SendClientMessage(playerid,lblue,string);
format(string, sizeof(string),"%s :שם משתמש",GetName(playerid));
SendClientMessage(playerid,COLOR_ORANGE,string);
format(string, sizeof(string),"%s :סיסמא",pass);
SendClientMessage(playerid,COLOR_ORANGE,string);
format(string, sizeof(string),"%s :כתובת האייפי שלך",dini_Get(GetPlayerFile(playerid),"LastConnectIP"));
SendClientMessage(playerid,COLOR_ORANGE,string);
SendClientMessage(playerid,COLOR_ORANGE,"/editprofile :לעריכת הפרופיל");
*/

format(string, sizeof(string),"--- | %s :נרשמת בהצלחה | ---",GetName(playerid));
SendClientMessage(playerid,WHITE,string);
format(string, sizeof(string),"%s - שם משתמש",GetName(playerid));
SendClientMessage(playerid,COLOR_ORANGE,string);
format(string, sizeof(string),"%s - סיסמא",pass);
SendClientMessage(playerid,COLOR_ORANGE,string);
format(string, sizeof(string),"%s - כתובת האייפי שלך",dini_Get(GetPlayerFile(playerid),"LastConnectIP"));
SendClientMessage(playerid,COLOR_ORANGE,string);

PlayerInfo[playerid][Logged] = 1;

SetTimerEx("FakeKills",10*1000,0,"i",playerid);
return 1;
}

if(!strcmp(cmd,"/login",true)) {
new pass2[256];
CheckPlayerCMDLevel(playerid,login);
if(IsPlayerLogged(playerid)) return SendClientMessage(playerid, COLOR_WHITE, ".אתה כבר מחובר");
pass2 = strtok(cmdtext,idx);
if(30 < strlen(pass2)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(pass2)) return SendClientMessage(playerid,COLOR_WHITE,"Usage: /Login [password]");
if(strlen(pass2) > 30 || strlen(pass2) < 3)
{
format(string,sizeof(string)," %d-%d אורך הסיסמה חייב להיות בין",Config[MaxPasswordLength], Config[MinPasswordLength]);
SendClientMessage(playerid,COLOR_WHITE,string);
return 1;
}
if(!dini_Exists(GetPlayerFile(playerid)))
{
format(string, sizeof(string), "/Register <> [Password] :תרשם עם הפקודה ,%s ", GetName(playerid));
SendClientMessage(playerid, COLOR_WHITE, string);
return 1;
}
if (!strcmp(pass2,dini_Get(GetPlayerFile(playerid),"Password"),true))
{
PlayerInfo[playerid][TimeOnServer] +=1;
PlayerInfo[playerid][Logged] = 1;
SendClientMessage(playerid,0x0F482FF, "!את/ה מחובר/ת כעת בהצלחה");
LoginPlayer(playerid);
//SetTimerEx("FakeKills",10*1000,0,"i",playerid);
}
else
{
Flayeri[playerid] --;
PlayerInfo[playerid][FL]++;
format(string,sizeof(string),"Wrong Password: %d",Flayeri[playerid]);
SendClientMessage(playerid,COLOR_WHITE,string);

if(PlayerInfo[playerid][FL] >= 4)
{
format(string,sizeof(string),"*** %s has been kicked (4/4 התחברות נכשלה)",GetName(playerid));
SendClientMessageToAll(red,string);
Kick(playerid);
}
}
return 1;
}

new str[256];
if(!dini_Exists(GetPlayerFile(playerid))) return
format(str, sizeof(str), "/Register [Pass] <> :קודם כל הרשם/י עם לביצוע ההרשמה"),
SendClientMessage(playerid, COLOR_WHITE , str);

if(dini_Exists(GetPlayerFile(playerid)) && PlayerInfo[playerid][Logged] == 0)
return
format(str, sizeof(str), "/login [Pass] <> :קודם כל התחבר/י לביצוע החיבור"),
SendClientMessage(playerid, COLOR_WHITE, str);


if(!strcmp(cmd, "/pstats", true))
{
new sid[256], id;
sid = strtok(cmdtext,idx);
id = ReturnID(sid);
if(30 < strlen(sid)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!IsPlayerConnected(id)) return SendClientMessage(playerid,WHITE,".המספר איידי שהזנת שגוי");
format(string, sizeof(string), ">> Stats: (%s`s) <<",GetName(id));
SendClientMessage(playerid, COLOR_WHITE, string);
format(string, sizeof(string), ">> Level: %d, Kills: %d,  Bank: $%d, VIP: %d.",PlayerInfo[id][Level],PlayerInfo[id][Kills],PlayerInfo[id][Bank],PlayerInfo[id][VIPS]);
SendClientMessage(playerid, 0xF06E8DFF, string);
format(string, sizeof(string), ">> Wars: %d, Karting: %d, Monster: %d, Minigun: %d, Tiger: %d,  Rpg: %d.",PlayerInfo[id][Wars],PlayerInfo[id][Kart],PlayerInfo[playerid][Monster],PlayerInfo[playerid][MINIGUN],PlayerInfo[playerid][Mlg],PlayerInfo[playerid][RPGS]);
SendClientMessage(playerid, 0xF06E8DFF, string);
format(string, sizeof(string), ">> Next Level: Level: %d, Kills: %d.",PlayerInfo[id][aLevelnl],PlayerInfo[playerid][aKillsnl]);
SendClientMessage(playerid, 0xF06E8DFF, string);
format(string, sizeof(string), ">> For More Infomration On Player %s: /pprofile %d /pdetails %d.",GetName(id),id,id);
SendClientMessage(playerid, COLOR_GREEN, string);

return 1;
}


if(!strcmp(cmd, "/stats", true))
{
format(string, sizeof(string), ">> Your Stats: (%s`s) <<",GetName(playerid)),SendClientMessage(playerid, COLOR_WHITE, string);
format(string, sizeof(string), ">> Level: %d, Kills: %d, Bank: $%d, VIP: %d.",PlayerInfo[playerid][Level],PlayerInfo[playerid][Kills],PlayerInfo[playerid][Bank],PlayerInfo[playerid][VIPS]),SendClientMessage(playerid, 0xF06E8DFF, string);
format(string, sizeof(string), ">> Wars: %d,  Karting: %d,  Monster: %d,  Minigun: %d,  Tiger: %d,  Rpg: %d.",PlayerInfo[playerid][Wars],PlayerInfo[playerid][Kart],PlayerInfo[playerid][Monster],PlayerInfo[playerid][MINIGUN],PlayerInfo[playerid][Mlg],PlayerInfo[playerid][RPGS]),SendClientMessage(playerid, 0xF06E8DFF, string);
format(string, sizeof(string), ">> Next Level: Level: %d, Kills: %d.",PlayerInfo[playerid][aLevelnl],PlayerInfo[playerid][aKillsnl]),SendClientMessage(playerid, 0xF06E8DFF, string);
format(string, sizeof(string), ">> For More Infomration: /nextlevel /details /profile",PlayerInfo[playerid][Wars],PlayerInfo[playerid][Kart],PlayerInfo[playerid][Monster],PlayerInfo[playerid][MINIGUN],PlayerInfo[playerid][Mlg],PlayerInfo[playerid][RPGS]),SendClientMessage(playerid, COLOR_GREEN, string);

return 1;
}

if(!strcmp(cmd, "/Details", true))
{
format(string, sizeof(string), ">> .%s`s :פרטי השחקן שלך <<",GetName(playerid)),SendClientMessage(playerid, COLOR_WHITE, string);
format(string, sizeof(string), ">> Weeds: %d/10, >> TimeOnServer: %d, >> Warnings: %d/10", PlayerInfo[playerid][Weeds],PlayerInfo[playerid][TimeOnServer],PlayerInfo[playerid][Warnings]),SendClientMessage(playerid, 0xF06E8DFF, string);
format(string, sizeof(string), ">> Clan: %s, >> Organization: %s", dini_Get(GetPlayerFile(playerid),"Clan"),dini_Get(GetPlayerFile(playerid),"organization")),SendClientMessage(playerid, COLOR_ORANGE, string);
format(string, sizeof(string), ">> Car: %s, >> Tag: %s", dini_Get(GetPlayerFile(playerid),"Car"),dini_Get(GetPlayerFile(playerid),"Tag")),SendClientMessage(playerid, COLOR_GREEN, string);




return 1;

}
if(!strcmp(cmd, "/pDetails", true))
{
new sid[256], id;
sid = strtok(cmdtext,idx);
id = ReturnID(sid);
if(30 < strlen(sid)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");

if(!strlen(sid)) return SendClientMessage(playerid, COLOR_WHITE, "/pDetails <id/name>");
if(!IsPlayerConnected(id)) return SendClientMessage(playerid,WHITE,".שחקנ/ית לא מחובר/ת");

format(string, sizeof(string), ">> .%s`s :פרטי השחקן של <<",GetName(id)),SendClientMessage(playerid, COLOR_WHITE, string);
format(string, sizeof(string), ">> Weeds: %d/10, >> TimeOnServer: %d, >> Warnings: %d/10", PlayerInfo[id][Weeds],PlayerInfo[id][TimeOnServer],PlayerInfo[id][Warnings]);
SendClientMessage(playerid, 0xF06E8DFF, string);
format(string, sizeof(string), ">> Clan: %s, >> Organization: %s", dini_Get(GetPlayerFile(id),"Clan"),dini_Get(GetPlayerFile(id),"organization"));
SendClientMessage(playerid, COLOR_ORANGE, string);
format(string, sizeof(string), ">> Car: %s, >> Tag: %s", dini_Get(GetPlayerFile(id),"Car"),dini_Get(GetPlayerFile(id),"Tag")),SendClientMessage(playerid, COLOR_GREEN, string);

return 1;
}

if(!strcmp(cmd, "/SysAdmin", true))
{
if (PlayerInfo[playerid][AdminsLevel] >= 10)
{
SendClientMessage(playerid,COLOR_WHITE,"---- עזרה לאדמינים מערכות ---");
SendClientMessage(playerid,COLOR_GREY,"/StartWar - וואר התחלה || /StartKart - קארט התחלה");
SendClientMessage(playerid,COLOR_GREY,"/StartMonster - הפעלת מונסטר || /StartRace - התחלת מירוץ");
SendClientMessage(playerid,COLOR_GREY,"/sRpg - הפעלת טילים || /sMini - הפעלת מיניגאן");
SendClientMessage(playerid,COLOR_GREY,"/stria - התחלת טריאטלון || /StartDrift - התחלת מירוץ דריפט");
SendClientMessage(playerid,COLOR_GREY,"/Warnings - אזהרה לשחקן || /SetBank - ערוך בנק || /SetKills ערוך הריגות");
SendClientMessage(playerid,COLOR_GREY,"/GiveSup [playerid] [1] :כדאי לתת למישהוא להיות חבר בצוות תמיכה");
SendClientMessage(playerid,COLOR_GREY,"/GiveVip [playerid] [levelvip] .אדמינים שימו לב תתנו רק למי שבאמת משקיע בשרת VIPלתת למישהוא גישות ל");
SendClientMessage(playerid,COLOR_GREY,"/races drift || bike || race :הפעלת אחת מהמערכת המירוצים");


//
}
else
{
SendClientMessage(playerid,COLOR_WHITE,".רק אדמינים רמה 10 ומעלה יכולים לראות את הפקודות");
}
return 1;
}


if(!strcmp(cmd,"/sp",true))
{

//IsObjectInZone

if(InArea(playerid, 404.8684, 35.6969, 2102.7212, 1653.4156)) return SendClientMessage(playerid,WHITE,".תודה VIP אין לשמור מיקום במפקדת ה");
if(InArea(playerid,-1867.1172 ,-2046.8510, 365.2502,189.3918)) return SendClientMessage(playerid,WHITE,".אין לשמור מיקום במוסך וואנג");
if (PlayerInfo[playerid][Level] < 2) return Messagelevel (playerid, 2);
new Float:p[3];
GetPlayerPos(playerid,p[0],p[1],p[2]);
if(PlayerInfo[playerid][Saved] == 1)
{
SendClientMessage(playerid,WHITE,".שמרת מקום חדש");
}
else
{
SendClientMessage(playerid,WHITE,".שמרת מקום חדש");
}
PlayerInfo[playerid][Saved] = 1,
PlayerInfo[playerid][SPX] = p[0],
PlayerInfo[playerid][SPY] = p[1],
PlayerInfo[playerid][SPZ] = p[2],
PlayerInfo[playerid][SPI] = GetPlayerInterior(playerid);
dini_IntSet(GetPlayerFile(playerid),"Saved",1);
dini_FloatSet(GetPlayerFile(playerid),"SavePosX",PlayerInfo[playerid][SPX]);
dini_FloatSet(GetPlayerFile(playerid),"SavePosY",PlayerInfo[playerid][SPY]);
dini_FloatSet(GetPlayerFile(playerid),"SavePosZ",PlayerInfo[playerid][SPZ]);
dini_IntSet(GetPlayerFile(playerid),"SavePosI",PlayerInfo[playerid][SPI]);

return 1;
}
//==

	if(strcmp("/abon", cmdtext, true, 12) == 0)
	{
        if (PlayerInfo[playerid][Level] < 5) return Messagelevel (playerid, 5);
if(InBike[playerid]==1||YouRegister[playerid]==1||Youregisterrace[playerid] == 1||InWarw[playerid] == 1||InWarr[playerid]== 1||InWar[playerid]==1||InCha[playerid] == 1||InKart[playerid] == 1||iNmOnster[playerid] == 1) return SendClientMessage(playerid,COLOR_WHITE,".אתה לא יכול להפעיל את מצב האיר ברייק כרגע, אתה רשום ל-1 מהפעיליות שאסור שם אייר ברייק");

		if(AirBreakVar[playerid] == 0)
		{
			if(IsPlayerInAnyVehicle(playerid) == 0)
			{
				AirBreakVar[playerid] = 1;
				SetCameraBehindPlayer(playerid);

				TogglePlayerControllable(playerid, 0);
				SendClientMessage(playerid, COLOR_WHITE, "/aboff - האייר ברייק שלך דולק, בהצלחה, על מנת לכבות");
				SendClientMessage(playerid, COLOR_WHITE, "/abset - לשינוי גודל תזוזה");
			}
			else
			{
				SendClientMessage(playerid, COLOR_WHITE, ".אתה לא יכול להפעיל אייר ברייק בתוך רכב");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_WHITE, ".האייר ברייק שלך כבר פעיל");
		}
		return 1;
	}

	if(strcmp("/aboff", cmdtext, true, 12) == 0)
	{
		if(AirBreakVar[playerid] == 1)
		{
			AirBreakVar[playerid] = 0;
			TogglePlayerControllable(playerid, 1);
			SendClientMessage(playerid, COLOR_WHITE, ".האייר ברייק שלך כובה בהצלחה");
		}
		else
		{
			SendClientMessage(playerid, COLOR_WHITE, ".האייר ברייק שלך כבר כבוי");
		}
		return 1;
	}

	if(strcmp("/abset", cmdtext, true, 6) == 0)
	{
		if(AirBreakVar[playerid] == 1)
		{
			new  pos = strfind(cmdtext, " ", true);
			strdel(cmdtext, 0, pos + 1);

			SetDistance[playerid] = strval(cmdtext);

			format(string, sizeof(string), ".%d - מהירות האייר ברייק שלך", strval(cmdtext));
			SendClientMessage(playerid, COLOR_WHITE, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_WHITE, ".שלך, לא פועל AirBreak-ה");
		}
		return 1;
	}



//====================Bank Transfer
if(!strcmp(cmd, "/bankid", true)) {
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, " /bankid [playerid] [amount] :שימוש");
giveplayerid = strval(tmp);
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, " /bankid [playerid] [amount] :שימוש");
moneysa[playerid] = strval(tmp);
if(!IsPlayerConnected(giveplayerid)) {
format(string, sizeof(string), ".לא מחובר '%d'", giveplayerid);
SendClientMessage(playerid, COLOR_WHITE, string);
return 1;
}
if(moneysa[playerid] > PlayerInfo[playerid][Bank]) return SendClientMessage(playerid, WHITE, " סכום משיכה שגוי ");
PlayerInfo[playerid][Bank] = PlayerInfo[playerid][Bank]-moneysa[playerid];
dini_IntSet(GetPlayerFile(playerid),"Bank",PlayerInfo[playerid][Bank]);
PlayerInfo[giveplayerid][Bank] = PlayerInfo[giveplayerid][Bank]+moneysa[playerid];
dini_IntSet(GetPlayerFile(giveplayerid),"Bank",PlayerInfo[giveplayerid][Bank]);
format(string, sizeof(string), ".$%d ,%s (id: %d) העברת לחשבון הבנק של ", moneysa[playerid] , GetName(giveplayerid), giveplayerid);
SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
format(string, sizeof(string), ".$%d העביר לחשבון בנק שלך %s (id: %d) ", moneysa[playerid], GetName(playerid), playerid);
SendClientMessage(giveplayerid, COLOR_LIGHTGREEN, string);
return 1;
}

if(strcmp(cmd, "/VIP", true) == 0)
{
new Roy_Killer[256];
Roy_Killer= strtok(cmdtext, idx);
if(30 < strlen(Roy_Killer)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(30 < strlen(Roy_Killer)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(Roy_Killer))
{
SendClientMessage(playerid,WHITE,"/VIP Camrea / Off / List / Go - :אפשרויות");

return 1;
}
else if(strcmp(Roy_Killer,"off",true) == 0)
{
if (PlayerInfo[playerid][VIPS] >= 1)
{
GetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
SetPlayerCameraPos(playerid, Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
SetPlayerCameraLookAt(playerid, Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
SetCameraBehindPlayer(playerid);
TogglePlayerControllable(playerid, 1);
SendClientMessage(playerid,red,".שלך VIP יצאת ממצב צפייה במפקדת");
}
else
{
SendClientMessage(playerid,COLOR_WHITE,".בלבד VIP פקודה זאתי לחברי");
}
}
else if(strcmp(Roy_Killer,"Camrea",true) == 0)
{
if (PlayerInfo[playerid][VIPS] >= 1)
{

SetPlayerCameraPos(playerid,264.5831,1896.2504,33.8984);
SetPlayerCameraLookAt(playerid,212.5598,1895.0790,16.2901);
SendClientMessage(playerid,red,".VIPכעת אתה מסתכל על מפקדת ה");
}
else
{
SendClientMessage(playerid,red,".בלבד VIP פקודה זאתי לחברי");
}
}
else if(strcmp(Roy_Killer,"Go",true) == 0)
{
if (PlayerInfo[playerid][VIPS] >= 1)
{
SetPlayerPos(playerid,212.5598,1895.0790,16.2901);
SetPlayerInterior(playerid,0);
SendClientMessage(playerid,red,".כאן התגוררו חברי השרת VIPברוכים הבאים למפקדה ה");
}
else
{
SendClientMessage(playerid,red,".בלבד VIP פקודה זאתי לחברי");
}
}
else if(strcmp(Roy_Killer,"list",true) == 0)
{
if(IsPlayerConnected(playerid))
{
format(string, 256, "--- :שמחוברים לשרת VIP חברי ---");
SendClientMessage(playerid, COLOR_WHITE, string);

fnm
if(IsPlayerConnected(i))
{
if(PlayerInfo[i][VIPS] >=1)
{
format(string, 256, " %s  [%d] ", GetName(i), i);
SendClientMessage(playerid, COLOR_GREY, string);
}
}
}
}
}
return 1;
}
//====================BANK
if (strcmp("/Bank", cmdtext, true, 10) == 0) return SetPlayerPos(playerid,2144.0793,1612.3879,993.6882),SetPlayerInterior(playerid,1),ResetPlayerWeapons(playerid),GameTextForPlayer(playerid,"~w~Bank",3000,1),SendClientMessage(playerid, 0xF6F658FF, ".ברוכים הבאים לבנק"),AtBank[playerid], SetCameraBehindPlayer(playerid);

if (strcmp("/ser", cmdtext, true, 10) == 0)return SetPlayerPos(playerid, -2127.5107,921.3911,79.4371);
if (strcmp("/vinfo", cmdtext, true, 10) == 0){
new Float:healths;
new vehicleid = GetPlayerVehicleID(playerid);
GetVehicleHealth(vehicleid, healths);

if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,WHITE,"! אתה צריך להיות במכונית שאתה רוצה ליקנות ");
SendClientMessage(playerid,COLOR_WHITE,"--- .הפרטים עבור הרכב שאתה נוסע בוא --");
format(string, sizeof(string), "%.1f  :החיים של הרכב", healths),SendClientMessage(playerid, COLOR_GREY, string);
format(vehname,999,".%s :השם של הרכב",VehiclesName[GetVehicleModel(GetPlayerVehicleID(playerid))-400]),SendClientMessage(playerid,COLOR_GREY,vehname);
format(vehname,999,".%d :האיידי של הרכב",GetVehicleModel(GetPlayerVehicleID(playerid))),SendClientMessage(playerid,COLOR_GREY,vehname);

return 1;
}
//====================Bank System
if(!strcmp(cmd, "/deposit", true))
{
if(!CPS_IsPlayerInCheckpoint(playerid,bcp)) return SendClientMessage(playerid,WHITE,".אתה חייב להיות בנקודת ציון על מנת להשתמש בפקודה זאת");
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(PlayerInfo[playerid][GetAloan] ==1) return format(string, sizeof(string),"%d :אתה חייב לבנק סכום כספי של",PlayerInfo[playerid][MoneyLoan]),SendClientMessage(playerid,WHITE,string),SendClientMessage(playerid,WHITE,".חסר לך כסף להחזרת ההלואה אנא אסוף תכסף והחזר לבנק עד אז לא תוכל להשתמש בבנק");
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, " /deposit [amount] :שימוש ");
moneysa[playerid] = strval(tmp);
if(30 < strlen(moneysa[playerid])) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(moneysa[playerid] < 1) return SendClientMessage(playerid, WHITE, " אתה חייב להכניס סכום יותר גדול מ 0 ");



if(GetPlayerMoney(playerid) < moneysa[playerid]) return SendClientMessage(playerid, WHITE, " אין לך מספיק כסף ");
LACY_GiveMoney(playerid, 0-moneysa[playerid]);
PlayerInfo[playerid][Bank] = PlayerInfo[playerid][Bank]+moneysa[playerid];
dini_IntSet(GetPlayerFile(playerid),"Bank",PlayerInfo[playerid][Bank]);
format(string, sizeof(string), ".$%d :הפקדת בחשבון הבנק שלך ,$%d :יש לך בחשבון הבנק", PlayerInfo[playerid][Bank], moneysa[playerid]);
SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
return 1;
}

if(!strcmp(cmd, "/depositall", true))
{
if(!CPS_IsPlayerInCheckpoint(playerid,bcp)) return SendClientMessage(playerid,WHITE,"");
if(GetPlayerMoney(playerid) < 0) return SendClientMessage(playerid, WHITE, " אין לך מספיק כסף ");
moneysa[playerid] = strval(tmp);
new GetCash[200];
GetCash[playerid] = GetPlayerMoney(playerid);


if(PlayerInfo[playerid][GetAloan] ==1) return format(string, sizeof(string),"%d :אתה חייב לבנק סכום כספי של",PlayerInfo[playerid][MoneyLoan]),SendClientMessage(playerid,red,string),SendClientMessage(playerid,red,".חסר לך כסף להחזרת ההלואה אנא אסוף תכסף והחזר לבנק עד אז לא תוכל להשתמש בבנק");
PlayerInfo[playerid][Bank] = PlayerInfo[playerid][Bank]+GetPlayerMoney(playerid);
dini_IntSet(GetPlayerFile(playerid),"Bank",PlayerInfo[playerid][Bank]);
format(string, sizeof(string), ".$%d :הפקדת בחשבון הבנק שלך ,$%d :יש לך בחשבון הבנק", PlayerInfo[playerid][Bank], GetPlayerMoney(playerid));
SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
LACY_GiveMoney(playerid, 0-GetPlayerMoney(playerid));



return 1;
}
//====================Withdraw from Bank
if(!strcmp(cmd, "/withdraw", true))
{
if(!CPS_IsPlayerInCheckpoint(playerid,bcp)) return SendClientMessage(playerid,WHITE,".אתה חייב להיות בנקודת ציון על מנת להשתמש בפקודה זאת");
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, " /withdraw [amount] :שימוש ");
moneysa[playerid] = strval(tmp);
if(30 < strlen(moneysa[playerid])) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(moneysa[playerid] < 1) return SendClientMessage(playerid, WHITE, "אתה חייב להכניס סכום יותר גדול מ 0  ");
moneysa[playerid] = strval(tmp);
if(moneysa[playerid] > PlayerInfo[playerid][Bank]) return SendClientMessage(playerid, WHITE, ".סכום משיכה שגוי ");
LACY_GiveMoney(playerid, moneysa[playerid]);
PlayerInfo[playerid][Bank] = PlayerInfo[playerid][Bank]-moneysa[playerid];
dini_IntSet(GetPlayerFile(playerid),"Bank",PlayerInfo[playerid][Bank]);
format(string, sizeof(string), "[$%d] נשאר לך בחשבון הבנק ,[$%d] משכת מחשבון הבנק שלך",  moneysa[playerid],PlayerInfo[playerid][Bank]);
SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
return 1;
}
//====================Balance
if(!strcmp(cmd, "/balance", true)) {
if(!CPS_IsPlayerInCheckpoint(playerid,bcp)) return SendClientMessage(playerid,WHITE,".אתה חייב להיות בנקודת ציון על מנת להשתמש בפקודה זאת");
format(string, sizeof(string), " [$%d] יש לך בבנק", PlayerInfo[playerid][Bank]);
SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
return 1;
}





if(!strcmp(cmd,"/weaponlist",true) || !strcmp(cmd,"/WL",true))
{
if(IsPlayerInCheckpoint(playerid)==0 || playerCheckpoint[playerid]!=CP_AMMU) {
SendClientMessage(playerid, WHITE, ".אתה חייב להיות בנקודת ציון על מנת להשתמש בפקודה זאת");
return 1;
}
SendClientMessage(playerid, COLOR_WHITE, "-- .רשימת נשקים תמידיים --");
SendClientMessage(playerid, 0xF6F658FF, "1.  /Bw 1 Sawnoff Shotgun 10,000$ |2.    /Bw 2 MicroSMG 5,000$");
SendClientMessage(playerid, 0xF6F658FF, "3.  /Bw 3 Tec9 6,000$             |4.    /Bw 4 M4 20,000$");
SendClientMessage(playerid, 0xF6F658FF, "5.  /Bw 5 MP5 6,000$              |6.    /Bw 6 AK47 15,000$");
SendClientMessage(playerid, 0xF6F658FF, "7.  /Bw 7 Knife 2,000$            |8.    /Bw 8 Katana 20,000$");
SendClientMessage(playerid, 0xF6F658FF, "9.  /Bw 9 Combat Shotgun 12,000$  |10.   /Bw 10 Shotgun 6,000$");
SendClientMessage(playerid, 0xF6F658FF, "11. /Bw 11 Sniper Rifle 35,000$   |12.   /Bw 12 Colt Pistol 5,000$");
return 1;
}


if(!strcmp(cmd,"/buyarmour",true) || !strcmp(cmd,"/buyarmour",true))
{

if(IsPlayerInCheckpoint(playerid)==0 || playerCheckpoint[playerid]!=CP_AMMU) {
SendClientMessage(playerid, WHITE, ".אתה חייב להיות בנקודת ציון על מנת להשתמש בפקודה זאת");
return 1;
}
if(GetPlayerMoney(playerid) < 100000) return SendClientMessage(playerid,WHITE,".אין לך מספיק כסף בשביל ליקנות את המכונית הזאתי ");
if(PlayerInfo[playerid][armourT] ==1) return SendClientMessage(playerid,WHITE,"/SellArmour .כבר יש לך מגן תמידי כדאי למכור אותו ולקבל חצי מהכסף");

LACY_GiveMoney(playerid,-100000);


SetPlayerArmour(playerid,100);
PlayerInfo[playerid][armourT] = 1;
dini_IntSet(GetPlayerFile(playerid),"armour",PlayerInfo[playerid][armourT]);

SendClientMessage(playerid, 0x0F482FF, ".(armour),תתחדש/י קנית מגן תמידי");

return 1;
}
if(!strcmp(cmd,"/Sellarmour",true) || !strcmp(cmd,"/armourarmourarmour",true))
{

if(IsPlayerInCheckpoint(playerid)==0 || playerCheckpoint[playerid]!=CP_AMMU) {
SendClientMessage(playerid, WHITE, ".אתה חייב להיות בנקודת ציון על מנת להשתמש בפקודה זאת");
return 1;
}
if(PlayerInfo[playerid][armourT] ==0) return SendClientMessage(playerid,WHITE,".אין בידך שלך מגן תמידי");
SetPlayerArmour(playerid,0);
PlayerInfo[playerid][armourT] = 0;

SendClientMessage(playerid, 0x0F482FF, ".זרקת את המגן שלך בהצלחה וקיבלת חצי מסכום הקנייה");
LACY_GiveMoney(playerid,50000);
return 1;
}
new Invis[MAX_PLAYERS]=0;
if(!strcmp(cmd, "/INV", true))
{
if(!IsPlayerXAdmin(playerid)) return 0;
SetPlayerColor(playerid, 0xFFFFFF00);
SendClientMessage(playerid, WHITE,"/uninv .כעת אתה שקוף במפה על מנת לחזור למצב רגיל");
Invis[playerid] =1;
return 1;
}
if(!strcmp(cmd, "/Spectator", true))
{
if(!IsPlayerXAdmin(playerid)) return 0;

Spectatorl[playerid] =1;
return 1;
}
if(!strcmp(cmd, "/unspectator", true))
{
if(!IsPlayerXAdmin(playerid)) return 0;

Spectatorl[playerid] =0;
return 1;
}
	if(!strcmp(cmd, "/changepass", true)) {
		new pass[256];
        CheckPlayerCMDLevel(playerid,changepass);
	    pass = strtok(cmdtext, idx);
	    if(30 < strlen(pass)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");

	    if(!IsPlayerLogged(playerid)) return SendClientMessage(playerid,WHITE,"אתה לא מחובר ");
	    if(!strlen(pass)) return SendClientMessage(playerid,WHITE,"/changepass [Password] :שימוש");
        if(Config[MaxPasswordLength] < strlen(pass) || strlen(pass) < Config[MinPasswordLength]) {
		format(string,sizeof(string)," %d-%d אורך הסיסמה חייב להיות בין",Config[MaxPasswordLength], Config[MinPasswordLength]);
		SendClientMessage(playerid,WHITE,string);
	    return 1; }


new File:f;
if(fexist(GetPlayerFile(playerid)))
{
f = fopen(GetPlayerFile(playerid),io_append);
dini_Set(GetPlayerFile(playerid),"Password",pass);
format(string, sizeof(string), ".%s :הסיסמה שלך שונתה בהצלחה, סיסמה ", pass);
SendClientMessage(playerid, COLOR_YELLOW, string);
fclose(f);
}

       return 1; }

//if(!strcmp(cmd,"/SetNick",true) || !strcmp(cmd,"/changenick",true)) return SendClientMessage(playerid,WHITE,"!בקרוב");

if(!strcmp(cmd, "/changenick", true))
{
CheckPlayerCMDLevel(playerid,changenick);
new newnick[256];
newnick = strtok(cmdtext, idx);if(!strlen(newnick)) return SendClientMessage(playerid,0xF6F658FF,"/Changenick [NewNick] :שימוש");
if(30 < strlen(newnick)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(16 < strlen(newnick) || strlen(newnick) < 3) return SendClientMessage(playerid, 0xF6F658FF, ".אורך הכינוי חייב להיות ב3-16 תודה");
new CheackNick[256];
format(CheackNick,sizeof(CheackNick),"RLSB/Users/%s.ini",newnick);

if(dini_Exists(CheackNick))
{

format(string, sizeof(string), ".שם אשר משמש שחקן מהשרת %s השם ",newnick);
SendClientMessage(playerid, WHITE, string);
return 1;
}
if(!IsNickValid(newnick)) return format(string, sizeof(string), ".הינו שם שמכיל תווים לא חוקיים, שנה תשם לתווים חוקיים,%s השם ",newnick),SendClientMessage(playerid, WHITE, string);
//IsNickValid
new ClanGever[200];
ClanGever[playerid] = dini_Int(GetPlayerFile(playerid), "ClanLvl");
new savepass[256];
new sicq[256],smsn[256],smispht[256],ssex[256],semail[256];
savepass = dini_Get(GetPlayerFile(playerid),"Password");
sicq =  dini_Get(GetPlayerFile(playerid),"ICQ");
smsn =  dini_Get(GetPlayerFile(playerid),"Msn");
smispht =  dini_Get(GetPlayerFile(playerid),"Mispht");
ssex =  dini_Get(GetPlayerFile(playerid),"SEX");
semail =  dini_Get(GetPlayerFile(playerid),"Email");


dini_Remove(GetPlayerFile(playerid));
format(CheackNick,sizeof(CheackNick),"RLSB/Users/%s.ini",newnick);
dini_Create(CheackNick);
new File:f, date[3], time[3];
if(fexist(CheackNick))
{
f = fopen(CheackNick,io_append);
format(CheackNick,sizeof(CheackNick),"// %s's :חשבון השחקן \r\n",newnick); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"aKillsnl=%d\r\n",PlayerInfo[playerid][aKillsnl]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"aLevelnl=%d\r\n",PlayerInfo[playerid][aLevelnl]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Organization=%s\r\n","None"); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Clan=%s\r\n","None"); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Password=%s\r\n",savepass); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"GemelLogin=%d\r\n",PlayerInfo[playerid][GemelLogin]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"KopatGemel=%d\r\n",PlayerInfo[playerid][KopatGemel]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"AggInfo=%d\r\n",PlayerInfo[playerid][AggInfo]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Level=%d\r\n",PlayerInfo[playerid][Level]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Tag=%s\r\n","סטלה בייבי"); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Car=%s\r\n","None"); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Logged=%d\r\n",PlayerInfo[playerid][Logged]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"IP=%s\r\n",GetIP(playerid)); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"LastConnectIP=%s\r\n",GetIP(playerid)); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"State=%s\r\n","Online"); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"RegisterationYear=%d\r\n",date[0]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"RegisterationMonth=%d\r\n",date[1]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"RegisterationDay=%d\r\n",date[2]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"RegisterationHour=%d\r\n",time[0]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"RegisterationMinute=%d\r\n",time[1]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"LastConnectYear=%d\r\n",date[0]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"LastConnectMonth=%d\r\n",date[1]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"LastConnectDay=%d\r\n",date[2]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"LastConnectHour=%d\r\n",time[0]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"LastConnectMinute=%d\r\n",time[1]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Kills=%d\r\n",PlayerInfo[playerid][Kills]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Deaths=%d\r\n",PlayerInfo[playerid][Deaths]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Money=%d\r\n",PlayerInfo[playerid][Money]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Bank=%d\r\n",PlayerInfo[playerid][Bank]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Wars=%d\r\n",PlayerInfo[playerid][Wars]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Karts=%d\r\n",PlayerInfo[playerid][Kart]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"MonsterWin=%d\r\n",PlayerInfo[playerid][Monster]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"MiniWin=%d\r\n",PlayerInfo[playerid][MINIGUN]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"RPGWIN=%d\r\n",PlayerInfo[playerid][RPGS]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"mlg=%d\r\n",PlayerInfo[playerid][Mlg]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Adminl=%d\r\n",PlayerInfo[playerid][AdminsLevel]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Warning=%d\r\n",PlayerInfo[playerid][Warnings]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"pWeeds=%d\r\n",PlayerInfo[playerid][Weeds]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"armour=%d\r\n",PlayerInfo[playerid][armourT]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"ProfileLogeed=%d\r\n",PlayerInfo[playerid][ProfileLogged]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"VIP=%d\r\n",PlayerInfo[playerid][VIPS]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"CC=%d\r\n",PlayerInfo[playerid][CcMode]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Supportives=%d\r\n",PlayerInfo[playerid][Supportives]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Tor=%d\r\n",PlayerInfo[playerid][Tor]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Dolphin=%d\r\n",PlayerInfo[playerid][Dolp]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Pets=%d\r\n",PlayerInfo[playerid][Pets]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Shark=%d\r\n",PlayerInfo[playerid][Shark]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"SharkKills=%d\r\n",PlayerInfo[playerid][SharkKills]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"DolphinKills=%d\r\n",PlayerInfo[playerid][DolphinKills]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"TorKills=%d\r\n",PlayerInfo[playerid][TorKills]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"GetAloan=%d\r\n",PlayerInfo[playerid][GetAloan]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"MoneyLoan=%d\r\n",PlayerInfo[playerid][MoneyLoan]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"bazooka=%d\r\n",PlayerInfo[playerid][bazooka]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"TimeOnServer=%d\r\n",PlayerInfo[playerid][TimeOnServer]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"SavePos=%d\r\n",PlayerInfo[playerid][Saved]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"SavePosX=%.4f\r\n",PlayerInfo[playerid][SPX]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"SavePosY=%.4f\r\n",PlayerInfo[playerid][SPY]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"SavePosZ=%.4f\r\n",PlayerInfo[playerid][SPZ]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"SavePosI=%d\r\n",PlayerInfo[playerid][SPI]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Saved=%d\r\n",PlayerInfo[playerid][Saved]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"SkinSavedId=%d\r\n",PlayerInfo[playerid][SkinSavedId]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"SaveSkin=%d\r\n",PlayerInfo[playerid][SaveSkin]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"SkinSaved=%d\r\n",PlayerInfo[playerid][SkinSaved]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"SaveStrika=%d\r\n",PlayerInfo[playerid][AirStrikeSaved]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"xAir=%d\r\n",PlayerInfo[playerid][xAirStrike]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"yAir=%d\r\n",PlayerInfo[playerid][yAirStrike]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"zAir=%d\r\n",PlayerInfo[playerid][zAirStrike]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"CarID=%d\r\n",pia[playerid][CarID]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"OwnCar=%d\r\n",pia[playerid][OwnCar]); fwrite(f,CheackNick);
format(string,sizeof(string),"Sawn=%d\r\n",PlayerInfo[playerid][Sawn]); fwrite(f,string);
format(string,sizeof(string),"MicroSMG=%d\r\n",PlayerInfo[playerid][MicroSMG]); fwrite(f,string);
format(string,sizeof(string),"Tec9=%d\r\n",PlayerInfo[playerid][Tec9]); fwrite(f,string);
format(string,sizeof(string),"M4=%.4f\r\n",PlayerInfo[playerid][M4]); fwrite(f,string);
format(string,sizeof(string),"MP5=%.4f\r\n",PlayerInfo[playerid][MP5]); fwrite(f,string);
format(string,sizeof(string),"AK47=%.4f\r\n",PlayerInfo[playerid][AK47]); fwrite(f,string);
format(string,sizeof(string),"Knife=%d\r\n",PlayerInfo[playerid][Knife]); fwrite(f,string);
format(string,sizeof(string),"Katana=%d\r\n",PlayerInfo[playerid][Katana]); fwrite(f,string);
format(string,sizeof(string),"CombatShotGun=%d\r\n",PlayerInfo[playerid][CombatShotGun]); fwrite(f,string);
format(string,sizeof(string),"ShotGun=%d\r\n",PlayerInfo[playerid][ShotGun]); fwrite(f,string);
format(string,sizeof(string),"SniperRifle=%d\r\n",PlayerInfo[playerid][SniperRifle]); fwrite(f,string);
format(string,sizeof(string),"CRifle=%d\r\n",PlayerInfo[playerid][CRifle]); fwrite(f,string);
format(string,sizeof(string),"Colt=%d\r\n",PlayerInfo[playerid][Colt]); fwrite(f,string);
format(CheackNick,sizeof(CheackNick),"ICQ=%s\r\n",sicq); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Msn=%s\r\n",smsn); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Mispht=%s\r\n",smispht); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"SEX=%s\r\n",ssex); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Email=%s\r\n",semail); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"Agg=%s\r\n",PlayerInfo[playerid][AggInfo]); fwrite(f,CheackNick);
format(CheackNick,sizeof(CheackNick),"ClanLvl=%d\r\n",ClanGever[playerid]); fwrite(f,CheackNick);
fclose(f);
}
PlayerInfo[playerid][Logged] = 0;
PlayerInfo[playerid][Logged] = 0;
format(string, sizeof(string), "---- %s הכינוי שלך השתנה בהצלחה ל",newnick);
SendClientMessage(playerid, lblue, string);
format(string, sizeof(string), "%s :משתמש",newnick);
SendClientMessage(playerid, COLOR_ORANGE, string);
format(string, sizeof(string), "%s :סיסמה",savepass);
SendClientMessage(playerid, COLOR_ORANGE, string);
PlayerInfo[playerid][Logged] = 0;
if(pia[playerid][CarID] != 0)
{
new FileCar[256];
format(FileCar,sizeof(FileCar),"CarSys/car%d.txt", pia[playerid][CarID]);
dini_Set(FileCar,"CarOwner",newnick);
VehicleInfo[pia[playerid][CarID]][CarOwned] = 1;
strmid(VehicleInfo[pia[playerid][CarID]][CarOwner], newnick, 0, strlen(newnick), 255);
VehicleInfo[pia[playerid][CarID]][Buyable] = 0;
SaveFiles();
PlayerInfo[playerid][Logged] = 0;
PlayerInfo[playerid][FL] = 0;
Kick(playerid);
}
else
{
SetPlayerName(playerid,newnick);
PlayerInfo[playerid][Logged] = 0;
PlayerInfo[playerid][FL] = 0;
Kick(playerid);
}
return 1;
}
if(!strcmp(cmd, "/unINV", true))
{
if(!IsPlayerXAdmin(playerid)) return 0;
//editprofilelayerColor(playerid,sgba2hex(random(256),random(256),random(256),55));//צבע במפה

SendClientMessage(playerid, WHITE,".כעת יצאת ממצב שקיפות");
Invis[playerid] =0;
return 1;
}
if(!strcmp(cmd,"/bw",true) || !strcmp(cmd,"/BuyWeapon",true))
{
if(IsPlayerInCheckpoint(playerid)==0 || playerCheckpoint[playerid]!=CP_AMMU) {
SendClientMessage(playerid, COLOR_WHITE, ".אתה חייב להיות בנקודת ציון על מנת להשתמש בפקודה זאת");
return 1;
}
new Roy_Killer1111[256];
Roy_Killer1111= strtok(cmdtext, idx);
if(30 < strlen(Roy_Killer1111)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(Roy_Killer1111))
{
SendClientMessage(playerid, WHITE, "/BW [1-12] רשימת נשקים");

return 1;
}


else if(strcmp(Roy_Killer1111,"1",true) == 0)
{
if(GetPlayerMoney(playerid) < 10000) return SendClientMessage(playerid,WHITE,"!אין לך מספיק כסף לנשק זה");
PlayerInfo[playerid][Sawn] +=100;
dini_IntSet(GetPlayerFile(playerid),"Sawn",PlayerInfo[playerid][Sawn]);
GivePlayerWeapon(playerid,26,PlayerInfo[playerid][Sawn]);
LACY_GiveMoney(playerid,-10000);
new rand = random(sizeof(playerColors));
SendClientMessage(playerid,playerColors[rand],".בהצלחה (Sawnoff Shotgun) ,קנית 100 כדורים לנשק");
return 1;
}

else if(strcmp(Roy_Killer1111,"2",true) == 0)
{
if(GetPlayerMoney(playerid) < 5000) return SendClientMessage(playerid,WHITE,"!אין לך מספיק כסף לנשק זה");
PlayerInfo[playerid][MicroSMG] +=100;
dini_IntSet(GetPlayerFile(playerid),"MicroSMG",PlayerInfo[playerid][MicroSMG]);
GivePlayerWeapon(playerid,28,PlayerInfo[playerid][MicroSMG]);
LACY_GiveMoney(playerid,-5000);
new rand = random(sizeof(playerColors));
SendClientMessage(playerid,playerColors[rand],".בהצלחה (MicroSMG) ,קנית 100 כדורים לנשק");
return 1;
}

else if(strcmp(Roy_Killer1111,"3",true) == 0)
{
if(GetPlayerMoney(playerid) < 6000) return SendClientMessage(playerid,WHITE,"!אין לך מספיק כסף לנשק זה");
PlayerInfo[playerid][Tec9] +=100;
dini_IntSet(GetPlayerFile(playerid),"Tec9",PlayerInfo[playerid][Tec9]);
GivePlayerWeapon(playerid,32,PlayerInfo[playerid][Tec9]);
LACY_GiveMoney(playerid,-6000);
new rand = random(sizeof(playerColors));
SendClientMessage(playerid,playerColors[rand],".בהצלחה (Tec9) ,קנית 100 כדורים לנשק");
return 1;
}
else if(strcmp(Roy_Killer1111,"4",true) == 0)
{
if(GetPlayerMoney(playerid) < 20000) return SendClientMessage(playerid,WHITE,"!אין לך מספיק כסף לנשק זה");
PlayerInfo[playerid][M4] +=100;
dini_IntSet(GetPlayerFile(playerid),"M4",PlayerInfo[playerid][M4]);
GivePlayerWeapon(playerid,31,PlayerInfo[playerid][M4]);
LACY_GiveMoney(playerid,-20000);
new rand = random(sizeof(playerColors));
SendClientMessage(playerid,playerColors[rand],".בהצלחה (M4) ,קנית 100 כדורים לנשק");

return 1;
}
else if(strcmp(Roy_Killer1111,"5",true) == 0)
{
if(GetPlayerMoney(playerid) < 6000) return SendClientMessage(playerid,WHITE,"!אין לך מספיק כסף לנשק זה");
PlayerInfo[playerid][MP5] +=100;
dini_IntSet(GetPlayerFile(playerid),"MP5",PlayerInfo[playerid][MP5]);
GivePlayerWeapon(playerid,29,PlayerInfo[playerid][MP5]);
LACY_GiveMoney(playerid,-6000);
new rand = random(sizeof(playerColors));
SendClientMessage(playerid,playerColors[rand],".בהצלחה (MP5) ,קנית 100 כדורים לנשק");
return 1;
}

else if(strcmp(Roy_Killer1111,"6",true) == 0)
{
if(GetPlayerMoney(playerid) < 15000) return SendClientMessage(playerid,WHITE,"!אין לך מספיק כסף לנשק זה");
PlayerInfo[playerid][AK47] +=100;
dini_IntSet(GetPlayerFile(playerid),"AK47",PlayerInfo[playerid][AK47]);
GivePlayerWeapon(playerid,30,PlayerInfo[playerid][AK47]);
LACY_GiveMoney(playerid,-15000);
new rand = random(sizeof(playerColors));
SendClientMessage(playerid,playerColors[rand],".בהצלחה (AK47) ,קנית 100 כדורים לנשק");
return 1;
}


else if(strcmp(Roy_Killer1111,"7",true) == 0)
{
if(GetPlayerMoney(playerid) < 2000) return SendClientMessage(playerid,WHITE,"!אין לך מספיק כסף לנשק זה");
PlayerInfo[playerid][Knife] = 1;
dini_IntSet(GetPlayerFile(playerid),"Knife",PlayerInfo[playerid][Knife]);
GivePlayerWeapon(playerid,4,PlayerInfo[playerid][Knife]);
LACY_GiveMoney(playerid,-2000);
new rand = random(sizeof(playerColors));
SendClientMessage(playerid,playerColors[rand],".בהצלחה (Knife) ,קנית את החרב");
return 1;
}
else if(strcmp(Roy_Killer1111,"8",true) == 0)
{
if(GetPlayerMoney(playerid) < 20000) return SendClientMessage(playerid,WHITE,"!אין לך מספיק כסף לנשק זה");
PlayerInfo[playerid][Katana] = 1;
dini_IntSet(GetPlayerFile(playerid),"Katana",PlayerInfo[playerid][Katana]);
GivePlayerWeapon(playerid,8,PlayerInfo[playerid][Katana]);
LACY_GiveMoney(playerid,-20000);
new rand = random(sizeof(playerColors));
SendClientMessage(playerid,playerColors[rand],".בהצלחה (Katana) ,קנית את החרב");
return 1;
}

else if(strcmp(Roy_Killer1111,"9",true) == 0)
{
if(GetPlayerMoney(playerid) < 12000) return SendClientMessage(playerid,WHITE,"!אין לך מספיק כסף לנשק זה");
PlayerInfo[playerid][CombatShotGun] +=20;
dini_IntSet(GetPlayerFile(playerid),"CombatShotGun",PlayerInfo[playerid][CombatShotGun]);
GivePlayerWeapon(playerid,27,PlayerInfo[playerid][CombatShotGun]);
LACY_GiveMoney(playerid,-12000);
new rand = random(sizeof(playerColors));
SendClientMessage(playerid,playerColors[rand],".בהצלחה (CombatShotGun) ,קנית 20 כדורים לנשק");
return 1;
}
else if(strcmp(Roy_Killer1111,"10",true) == 0)
{
if(GetPlayerMoney(playerid) < 6000) return SendClientMessage(playerid,WHITE,"!אין לך מספיק כסף לנשק זה");
PlayerInfo[playerid][ShotGun] +=20;
dini_IntSet(GetPlayerFile(playerid),"ShotGun",PlayerInfo[playerid][ShotGun]);
GivePlayerWeapon(playerid,25,PlayerInfo[playerid][ShotGun]);
LACY_GiveMoney(playerid,-6000);
new rand = random(sizeof(playerColors));
SendClientMessage(playerid,playerColors[rand],".בהצלחה (Shotgun) ,קנית 20 כדורים לנשק");
return 1;
}
else if(strcmp(Roy_Killer1111,"11",true) == 0)
{
if(GetPlayerMoney(playerid) < 35000) return SendClientMessage(playerid,WHITE,"!אין לך מספיק כסף לנשק זה");
PlayerInfo[playerid][CRifle] +=3;
dini_IntSet(GetPlayerFile(playerid),"CRifle",PlayerInfo[playerid][CRifle]);
GivePlayerWeapon(playerid,34,PlayerInfo[playerid][CRifle]);
LACY_GiveMoney(playerid,-35000);
new rand = random(sizeof(playerColors));
SendClientMessage(playerid,playerColors[rand],".בהצלחה (Sniper Rifle) ,קנית 3 כדורים לנשק");
return 1;
}
else if(strcmp(Roy_Killer1111,"12",true) == 0)
{
if(GetPlayerMoney(playerid) < 5000) return SendClientMessage(playerid,WHITE,"!אין לך מספיק כסף לנשק זה");
PlayerInfo[playerid][Colt] +=120;
dini_IntSet(GetPlayerFile(playerid),"Colt",PlayerInfo[playerid][Colt]);
GivePlayerWeapon(playerid,22,PlayerInfo[playerid][Colt]);
LACY_GiveMoney(playerid,-5000);
new rand = random(sizeof(playerColors));
SendClientMessage(playerid,playerColors[rand],".בהצלחה (Pistol mm9) ,קנית 120 כדורים לנשק");
return 1;
}

return 1;
}

//=[JumpKill]
        if (strcmp("/jumpkill", cmdtext, true) == 0)
        {
        if(PlayerInfo[playerid][Level] < 3) return Messagelevel (playerid, 3);
		if(RaceJumpKill != -1) return SendClientMessage(playerid, WHITE, ".קפיצת ההתאבדות תפוסה כרגע, המתן שהשחקן יסיים יסיים");
        if(GetPlayerMoney(playerid) < 10000) return SendClientMessage(playerid,WHITE,".אתה צריך כ10,000 דולר JumpKill-על מנת לפתוח ב");
LACY_GiveMoney(playerid,-10000);
format(string,sizeof(string),".JumpKill - יצא למשימת ההתאבדות %s :השחקן", GetName(playerid) );
SendClientMessageToAll(red,string);
                RaceJumpKill = playerid;
                Motor = CreateVehicle(BikeModel, 424.0586,2502.778076,16.2115, 90.0000, 0, 6, -1);
		        PutPlayerInVehicle(playerid, Motor, 0);
                SetCameraBehindPlayer(playerid);
                TimerJumpkill1 = SetTimer("CountkilljumpJumpKill", 1000, 1);
                GameTextForPlayer(RaceJumpKill, "~b~5", 3000, 6);
                TogglePlayerControllable(playerid, 0);
                Countkilljump = 0;
                Distance = 0.0;
                format(TDS4, sizeof(TDS4), "Distance : 0.0000~n~Time Left: 0:20");
                TextDrawSetString(TD3, TDS4);
                TextDrawShowForPlayer(RaceJumpKill, TD3);

  DestroyPlayerObject2[1]=      CreatePlayerObject(RaceJumpKill,1655, 54.348621, 2502.778076, 16.792294, 0.0000, 0.0000, 90.0000);
  DestroyPlayerObject2[2]=      CreatePlayerObject(RaceJumpKill,979, 61.964684, 2510.659912, 16.324594, 0.0000, 0.0000, 225.0000);
   DestroyPlayerObject2[3]=        CreatePlayerObject(RaceJumpKill,979, 68.574669, 2517.179688, 16.324594, 0.0000, 0.0000, 224.1406);
   DestroyPlayerObject2[4]=        CreatePlayerObject(RaceJumpKill,979, 74.838379, 2523.267090, 16.324594, 0.0000, 0.0000, 224.1406);
  DestroyPlayerObject2[5]=         CreatePlayerObject(RaceJumpKill,978, 61.268669, 2494.687256, 16.324594, 0.0000, 0.0000, 303.7500);
  DestroyPlayerObject2[6]=         CreatePlayerObject(RaceJumpKill,978, 66.452194, 2486.926514, 16.324594, 0.0000, 0.0000, 303.7500);
  DestroyPlayerObject2[7]=         CreatePlayerObject(RaceJumpKill,978, 71.637367, 2479.152832, 16.324596, 0.0000, 0.0000, 303.7500);
  DestroyPlayerObject2[8]=         CreatePlayerObject(RaceJumpKill,982, 37.394611, 2497.127930, 16.167931, 0.0000, 0.0000, 270.0000);
  DestroyPlayerObject2[9]=         CreatePlayerObject(RaceJumpKill,982, 37.501751, 2508.678711, 16.167931, 0.0000, 0.0000, 270.0000);
  DestroyPlayerObject2[10]=         CreatePlayerObject(RaceJumpKill,982, 11.898752, 2508.676514, 16.167931, 0.0000, 0.0000, 270.0000);
  DestroyPlayerObject2[11]=         CreatePlayerObject(RaceJumpKill,982, 11.785603, 2497.133789, 16.167931, 0.0000, 0.0000, 270.0000);
  DestroyPlayerObject2[12]=         CreatePlayerObject(RaceJumpKill,982, -13.819443, 2497.136475, 16.167931, 0.0000, 0.0000, 270.0000);
  DestroyPlayerObject2[13]=         CreatePlayerObject(RaceJumpKill,982, -13.738670, 2508.645752, 16.175739, 0.0000, 0.0000, 270.0000);
  DestroyPlayerObject2[14]=         CreatePlayerObject(RaceJumpKill,982, -39.338737, 2508.623291, 16.167931, 0.0000, 0.0000, 270.0000);
  DestroyPlayerObject2[15]=         CreatePlayerObject(RaceJumpKill,982, -64.946236, 2508.630859, 16.175737, 0.0000, 0.0000, 270.0000);
  DestroyPlayerObject2[16]=         CreatePlayerObject(RaceJumpKill,982, -39.422119, 2497.141602, 16.167931, 0.0000, 0.0000, 270.0000);
  DestroyPlayerObject2[17]=        CreatePlayerObject(RaceJumpKill,982, -65.034653, 2497.131348, 16.167931, 0.0000, 0.0000, 270.0000);
    DestroyPlayerObject2[18]=       CreatePlayerObject(RaceJumpKill,3461, -77.754257, 2508.626709, 17.059387, 0.0000, 0.0000, 0.0000);
   DestroyPlayerObject2[19]=        CreatePlayerObject(RaceJumpKill,3461, -77.824821, 2497.134033, 17.240005, 0.0000, 0.0000, 0.0000);
   DestroyPlayerObject2[20]=        CreatePlayerObject(RaceJumpKill,3461, -60.153984, 2508.603760, 17.067196, 0.0000, 0.0000, 0.0000);
   DestroyPlayerObject2[21]=        CreatePlayerObject(RaceJumpKill,3461, -60.245415, 2497.100830, 17.059387, 0.0000, 0.0000, 0.0000);
  DestroyPlayerObject2[22]=         CreatePlayerObject(RaceJumpKill,3461, -42.536339, 2508.615723, 17.059387, 0.0000, 0.0000, 0.0000);
  DestroyPlayerObject2[23]=         CreatePlayerObject(RaceJumpKill,3461, -42.645630, 2497.122314, 17.059387, 0.0000, 0.0000, 0.0000);
  DestroyPlayerObject2[24]=         CreatePlayerObject(RaceJumpKill,3461, -24.953836, 2508.633301, 17.059387, 0.0000, 0.0000, 0.0000);
  DestroyPlayerObject2[25]=         CreatePlayerObject(RaceJumpKill,3461, -25.054081, 2497.136963, 17.059387, 0.0000, 0.0000, 0.0000);
  DestroyPlayerObject2[26]=         CreatePlayerObject(RaceJumpKill,3461, -7.358308, 2508.621338, 17.067196, 0.0000, 0.0000, 0.0000);
  DestroyPlayerObject2[27]=         CreatePlayerObject(RaceJumpKill,3461, -7.405560, 2497.130371, 17.059387, 0.0000, 0.0000, 0.0000);
  DestroyPlayerObject2[28]=         CreatePlayerObject(RaceJumpKill,3461, 10.270878, 2508.671143, 17.059387, 0.0000, 0.0000, 0.0000);
  DestroyPlayerObject2[29]=         CreatePlayerObject(RaceJumpKill,3461, 10.190086, 2497.112305, 17.059387, 0.0000, 0.0000, 0.0000);
  DestroyPlayerObject2[30]=         CreatePlayerObject(RaceJumpKill,3461, 27.894892, 2508.682861, 17.059387, 0.0000, 0.0000, 0.0000);
  DestroyPlayerObject2[31]=         CreatePlayerObject(RaceJumpKill,3461, 27.788519, 2497.122070, 17.059387, 0.0000, 0.0000, 0.0000);
  DestroyPlayerObject2[32]=         CreatePlayerObject(RaceJumpKill,3461, 45.501919, 2508.674316, 17.059387, 0.0000, 0.0000, 0.0000);
  DestroyPlayerObject2[33]=         CreatePlayerObject(RaceJumpKill,3461, 45.367653, 2497.103027, 17.059387, 0.0000, 0.0000, 0.0000);
  DestroyPlayerObject2[34]=         CreatePlayerObject(RaceJumpKill,3568, -49.846252, 2485.552002, 18.097994, 0.0000, 0.0000, 213.7501);
  DestroyPlayerObject2[35]=         CreatePlayerObject(RaceJumpKill,3568, 23.495960, 2515.677979, 18.097994, 0.0000, 0.0000, 90.0001);
  DestroyPlayerObject2[36]=         CreatePlayerObject(RaceJumpKill,3566, -56.099358, 2517.848389, 18.097994, 0.0000, 0.0000, 303.7500);
  DestroyPlayerObject2[37]=         CreatePlayerObject(RaceJumpKill,3819, -37.348824, 2512.810303, 16.482134, 0.0000, 0.0000, 90.0000);
  DestroyPlayerObject2[38]=         CreatePlayerObject(RaceJumpKill,3819, -28.746914, 2512.851074, 16.482134, 0.0000, 0.0000, 90.0000);
  DestroyPlayerObject2[39]=         CreatePlayerObject(RaceJumpKill,3819, -20.126209, 2512.839844, 16.489943, 0.0000, 0.0000, 90.0000);
  DestroyPlayerObject2[40]=         CreatePlayerObject(RaceJumpKill,3819, -11.508772, 2512.832764, 16.489943, 0.0000, 0.0000, 90.0000);
  DestroyPlayerObject2[41]=         CreatePlayerObject(RaceJumpKill,3819, -37.340233, 2493.169189, 16.482134, 0.0000, 0.0000, 270.0000);
   DestroyPlayerObject2[42]=        CreatePlayerObject(RaceJumpKill,3819, -28.750528, 2493.177734, 16.482134, 0.0000, 0.0000, 270.0000);
    DestroyPlayerObject2[43]=       CreatePlayerObject(RaceJumpKill,3819, -20.152523, 2493.154785, 16.482134, 0.0000, 0.0000, 270.0000);
   DestroyPlayerObject2[44] =        CreatePlayerObject(RaceJumpKill,3819, -11.532024, 2493.193115, 16.482134, 0.0000, 0.0000, 270.0000);

                return 1;
        }

        if (strcmp("/stopjumpkill", cmdtext, true) == 0)
        {
                if(PlayerInfo[playerid][Level] < 3) return Messagelevel (playerid, 3);
		if(RaceJumpKill != playerid) return SendClientMessage(playerid,WHITE,".אתה לא נמצא בקפיצת המוות");
            EndJumpKill();
            TogglePlayerControllable(playerid, 1);
            return 1;
        }

        if ((strcmp("/jumpkillscore", cmdtext, true) == 0))
        {
//                new str[128];
                SendClientMessage(playerid, COLOR_WHITE, ":רשימת האנשים שעשו את קפיצה ההתאבדות בצורה הטובה ביותר");
                format(str, 128, "#1:   %.4f     %s", HS[0], HSN[0]);
                SendClientMessage(playerid, COLOR_PINK, str);
                format(str, 128, "#2:   %.4f     %s", HS[1], HSN[1]);
                SendClientMessage(playerid, COLOR_PINK, str);
                format(str, 128, "#3:   %.4f     %s", HS[2], HSN[2]);
                SendClientMessage(playerid, COLOR_PINK, str);
                SendClientMessage(playerid, COLOR_PINK, " ");
                format(str, 128, "%.4f :השיא שלך", dini_Float(PERSONALFILE, GetName(playerid)));
                SendClientMessage(playerid, COLOR_PINK, str);

            return 1;
        }
//---
/*
if(!strcmp(cmd, "/fastwl", true))
{
SendClientMessage(playerid, COLOR_WHITE, "-- רשימת נשקים מהירים --");
SendClientMessage(playerid, 0xF6F658FF, "/Bw 1 Uzi 200$");
SendClientMessage(playerid, 0xF6F658FF, "/Bw 2 SawnOff 200$");
SendClientMessage(playerid, 0xF6F658FF, "/Bw 3 SniperRifile 200$");
SendClientMessage(playerid, 0xF6F658FF, "/Bw 4 M4 200$");
SendClientMessage(playerid, 0xF6F658FF, "/Bw 5 ShotGun 200$");
SendClientMessage(playerid, 0xF6F658FF, "/Bw 6 Tec9 200");
return 1;
}
//---------Stats---------
if(strcmp(cmd,"/fastbw",true) || strcmp(cmd,"/fastBuyWeapon",true))
{
new Roy_Killer1111[256];
Roy_Killer1111= strtok(cmdtext, idx);
if(strlen(Roy_Killer1111)) {
SendClientMessage(playerid, 0x78B4F0FF, "/fastbw [1-6]");
//----------------------
return 1;}
//----------------------

else if(strcmp(Roy_Killer1111,"1",true) == 0)
{
if(GetPlayerMoney(playerid) < 200) return   SendClientMessage(playerid,0xF6F658FF,"אתה צריך כ200 דולר לנשק זה");
GivePlayerWeapon(playerid,28,600);
SendClientMessage(playerid,0xF6F658FF,".בחנות נשקים המהירה (Uzi) תתחדש קנית עוזי");
SendClientMessage(playerid,COLOR_PURPLE,".מוכר הנשק: שים לב הנשק לא ישמר אחרי שתהרג");
LACY_GiveMoney(playerid,-200);
return 1;
}
//----------------------
else if(strcmp(Roy_Killer1111,"2",true) == 0){
if(GetPlayerMoney(playerid) < 200) return   SendClientMessage(playerid,0xF6F658FF,"אתה צריך כ200 דולר לנשק זה");
GivePlayerWeapon(playerid,26,600);
SendClientMessage(playerid,COLOR_PURPLE,".בחנות נשקים מהירה (SawnOff)SawnOff תתחדש קנית ");
SendClientMessage(playerid,COLOR_PURPLE,".מוכר הנשק: שים לב הנשק לא ישמר אחרי שתהרג");
LACY_GiveMoney(playerid,-200);
return 1;}
//----------------------
else if(strcmp(Roy_Killer1111,"4",true) == 0){
if(GetPlayerMoney(playerid) < 200) return   SendClientMessage(playerid,0xF6F658FF,"אתה צריך כ200 דולר לנשק זה");
GivePlayerWeapon(playerid,31,600);
SendClientMessage(playerid,0xF6F658FF,"בחנות נשקים מהירה (M4) M4 תתחדש קנית ");
SendClientMessage(playerid,COLOR_PURPLE,".מוכר הנשק: שים לב הנשק לא ישמר אחרי שתהרג");
LACY_GiveMoney(playerid,-200);
return 1;}
//----------------------
else if(strcmp(Roy_Killer1111,"3",true) == 0){
//----------------------
if(GetPlayerMoney(playerid) < 200) return   SendClientMessage(playerid,0xF6F658FF,"אתה צריך כ200 דולר לנשק זה");
GivePlayerWeapon(playerid,34,25);
SendClientMessage(playerid,0xF6F658FF,"בחנות נשקים מהירה (Rifle) Rifle תתחדש קנית ");
LACY_GiveMoney(playerid,-200);
SendClientMessage(playerid,COLOR_PURPLE,".מוכר הנשק: שים לב הנשק לא ישמר אחרי שתהרג");
return 1;
}
//----------------------
else if(strcmp(Roy_Killer1111,"5",true) == 0){
//----------------------
if(GetPlayerMoney(playerid) < 200) return   SendClientMessage(playerid,0xF6F658FF,"אתה צריך כ200 דולר לנשק זה");
GivePlayerWeapon(playerid,25,300);
SendClientMessage(playerid,0xF6F658FF," תתחדש קנית שוטגאן");
SendClientMessage(playerid,COLOR_PURPLE,".מוכר הנשק: שים לב הנשק לא ישמר אחרי שתהרג");
LACY_GiveMoney(playerid,-200);
return 1;
}
//----------------------
else if(strcmp(Roy_Killer1111,"6",true) == 0){
//----------------------
if(GetPlayerMoney(playerid) < 200) return   SendClientMessage(playerid,0xF6F658FF,"אתה צריך כ200 דולר לנשק זה");
SendClientMessage(playerid,0xF6F658FF,"Tec9 תתחדש קנית");
SendClientMessage(playerid,COLOR_PURPLE,".מוכר הנשק: שים לב הנשק לא ישמר אחרי שתהרג");
GivePlayerWeapon(playerid,32,600);
LACY_GiveMoney(playerid,-200);
return 1;
}
return 1;
}
*/
//----Weed System------
if (strcmp(cmdtext, "/useweed", true)==0)
{
//new str[256];
if(Stoned[playerid] == 1)return SendClientMessage(playerid, WHITE, " אתה עדיין תחת השפעת הסמים ");


if(PlayerInfo[playerid][Weeds] > 0)
{
PlayerInfo[playerid][Weeds] --;
format(str, sizeof(str), " השתמת במנת סמים, נשאר לך %d/10 מנות ", PlayerInfo[playerid][Weeds]);

TheWeed[playerid] =1;
Stoned[playerid]=1;
SetPlayerWantedLevel(playerid,1);
ApplyAnimation(playerid,"PED","WALK_DRUNK",4.0,1,1,1,1,0);
}
else
{
format(str, sizeof(str), " אין לך אף מנת סמים ");
SendClientMessage(playerid, WHITE, str);
}
return 1;
}

//===============================ChaStart Command===============================
if(!strcmp(cmd, "/startCha", true))
{
if(PlayerInfo[playerid][AdminsLevel]<10) return 0;
if(ChaOn == 1) return SendClientMessage(playerid, WHITE, ".יש כבר האתגר טיפוס פעילה ");
format(kboobcha, sizeof(kboobcha), "~y~~H~[]/Cha~y~~H~[]");
GameTextForAll(kboobcha,3000,4);
for(new i = 0; i < MAX_PLAYERS; i++) {
}
ChaPras  = 3000;
SetTimer("ChaStarted",3000,0);



//[Challenge]============================================================
CheDelObject[0] = CreateDynamicObject(1696, 1769.081299, -2475.579346, 13.561917, 0.0000, 0.0000, 180.0000);
CheDelObject[1] =CreateDynamicObject(1894, 1770.736694, -2480.442383, 11.954697, 359.1406, 2.5783, 101.2500);
CheDelObject[2] =CreateDynamicObject(1894, 1775.860718, -2506.013184, 13.112448, 359.1406, 10.3132, 101.2500);
CheDelObject[3] =CreateDynamicObject(5152, 1780.142212, -2534.805908, 20.779951, 0.0000, 0.0000, 270.0000);
CheDelObject[4] =CreateDynamicObject(13604, 1776.118408, -2548.626709, 22.604872, 0.8594, 356.5623, 278.6717);
CheDelObject[5] =CreateDynamicObject(13636, 1781.736084, -2545.876221, 26.592197, 0.0000, 0.0000, 281.2500);
CheDelObject[6] =CreateDynamicObject(13638, 1777.057251, -2541.441650, 30.043570, 0.8594, 17.1887, 11.2500);
CheDelObject[7] =CreateDynamicObject(13638, 1771.777100, -2555.157471, 36.419189, 0.0000, 19.7670, 90.8595);
CheDelObject[8] =CreateDynamicObject(13647, 1758.082153, -2539.003418, 40.517815, 0.0000, 0.0000, 112.5000);
CheDelObject[9] =CreateDynamicObject(18262, 1748.788940, -2517.121582, 43.027180, 0.0000, 0.0000, 22.5000);
CheDelObject[10] =CreateDynamicObject(18367, 1746.841919, -2512.927490, 41.922482, 0.0000, 0.0000, 213.7500);
CheDelObject[11] =CreateDynamicObject(18367, 1736.853882, -2496.445557, 45.156380, 0.0000, 12.8916, 306.3284);
CheDelObject[12] =CreateDynamicObject(18367, 1714.320679, -2515.731445, 48.742352, 0.0000, 352.2651, 218.1245);
CheDelObject[13] =CreateDynamicObject(18367, 1701.230713, -2496.107178, 51.958038, 0.0000, 12.8916, 306.3284);
CheDelObject[14] =CreateDynamicObject(18609, 1692.528931, -2503.911133, 54.147449, 0.0000, 0.0000, 315.0000);
CheDelObject[15] =CreateDynamicObject(18609, 1709.177612, -2509.929688, 50.836823, 0.0000, 0.0000, 30.1576);
CheDelObject[16] =CreateDynamicObject(18367, 1678.757324, -2515.343994, 55.317616, 0.0000, 0.0000, 213.7500);
CheDelObject[17] =CreateDynamicObject(18367, 1676.555054, -2511.261719, 58.896374, 351.4056, 0.0000, 213.7500);
CheDelObject[18] =CreateDynamicObject(18367, 1664.081177, -2493.852051, 58.155533, 351.4056, 0.0000, 213.7500);
CheDelObject[19] =CreateDynamicObject(18367, 1661.992310, -2489.944580, 65.772484, 347.1084, 0.0000, 213.7500);
CheDelObject[20] =CreateDynamicObject(18367, 1646.171021, -2467.510010, 75.243423, 347.1084, 0.0000, 168.7500);
CheDelObject[21] =CreateDynamicObject(18367, 1647.679688, -2470.190918, 65.190323, 330.7792, 0.0000, 168.7500);
CheDelObject[22] =CreateDynamicObject(13638, 1657.328979, -2442.719727, 84.871346, 0.8594, 17.1887, 260.3826);
CheDelObject[23] =CreateDynamicObject(18367, 1652.083618, -2438.176025, 88.640350, 347.1084, 0.0000, 168.7500);
CheDelObject[24] =CreateDynamicObject(13638, 1668.809814, -2436.662109, 93.845680, 0.8594, 17.1887, 282.8826);
CheDelObject[25] =CreateDynamicObject(18367, 1671.179565, -2431.894531, 99.373596, 347.1084, 0.0000, 247.5000);
CheDelObject[26] =CreateDynamicObject(18367, 1657.196655, -2406.981201, 100.414162, 347.1084, 0.0000, 168.7500);
CheDelObject[27] =CreateDynamicObject(3280, 1657.497681, -2408.782715, 97.319832, 0.0000, 0.0000, 0.0000);
CheDelObject[28] =CreateDynamicObject(3280, 1657.508179, -2407.587158, 97.319832, 0.0000, 0.0000, 0.0000);
CheDelObject[29] =CreateDynamicObject(3280, 1657.483154, -2406.385986, 97.319832, 0.0000, 0.0000, 0.0000);
CheDelObject[30] =CreateDynamicObject(3280, 1657.483154, -2405.561279, 98.044876, 90.2408, 0.0000, 358.2811);
CheDelObject[31] =CreateDynamicObject(18367, 1645.770264, -2417.960449, 109.594154, 347.1084, 0.0000, 152.4979);
CheDelObject[32] =CreateDynamicObject(3280, 1645.684082, -2418.574463, 108.741455, 0.0000, 0.0000, 351.4056);
CheDelObject[33] =CreateDynamicObject(18367, 1662.898193, -2379.385498, 109.132889, 17.1887, 0.0000, 180.0000);
CheDelObject[34] =CreateDynamicObject(1222, 1654.059082, -2428.472412, 92.961739, 0.0000, 0.0000, 0.0000);
CheDelObject[35] =CreateDynamicObject(1222, 1660.067383, -2442.182617, 91.124886, 0.0000, 0.0000, 0.0000);
CheDelObject[36] =CreateDynamicObject(1222, 1649.976929, -2448.242188, 82.402466, 0.0000, 0.0000, 0.0000);
CheDelObject[37] =CreateDynamicObject(1222, 1649.479248, -2451.445068, 81.290794, 0.0000, 0.0000, 0.0000);
CheDelObject[38] =CreateDynamicObject(1222, 1650.962524, -2452.138428, 78.797348, 0.0000, 0.0000, 0.0000);
CheDelObject[39] =CreateDynamicObject(1222, 1650.402466, -2457.965820, 74.550095, 0.0000, 0.0000, 0.0000);
CheDelObject[40] =CreateDynamicObject(1222, 1649.344849, -2470.849365, 65.996147, 0.0000, 0.0000, 0.0000);
CheDelObject[41] =CreateDynamicObject(1222, 1653.144775, -2477.277344, 63.932148, 0.0000, 0.0000, 0.0000);
CheDelObject[42] =CreateDynamicObject(1222, 1652.782104, -2474.846191, 64.527458, 0.0000, 0.0000, 0.0000);
CheDelObject[43] =CreateDynamicObject(1222, 1651.370972, -2474.034424, 64.936928, 0.0000, 0.0000, 0.0000);
CheDelObject[44] =CreateDynamicObject(1222, 1787.568237, -2543.593018, 28.771389, 0.0000, 0.0000, 0.0000);
CheDelObject[45] =CreateDynamicObject(13638, 1771.913818, -2563.825439, 42.821404, 0.0000, 19.7670, 90.8595);
CheDelObject[46] =CreateDynamicObject(3057, 1759.306152, -2541.212646, 44.974133, 0.0000, 0.0000, 0.0000);
CheDelObject[47] =CreateDynamicObject(3057, 1755.714844, -2532.867432, 43.560070, 0.0000, 0.0000, 0.0000);
CheDelObject[48] =CreateDynamicObject(3374, 1765.493286, -2560.903076, 43.733135, 0.0000, 0.0000, 0.0000);
CheDelObject[49] =CreateDynamicObject(3374, 1659.718506, -2391.687500, 117.717461, 0.0000, 0.0000, 337.6546);
CheDelObject[50] =CreateDynamicObject(3374, 1660.451416, -2389.815674, 116.720230, 0.0000, 0.0000, 337.6546);
CheDelObject[51] =CreateDynamicObject(3374, 1660.772583, -2388.591064, 115.330429, 0.0000, 0.0000, 337.6546);
CheDelObject[52] =CreateDynamicObject(18367, 1662.771118, -2352.528809, 103.945427, 14.6104, 357.4217, 190.7688);
CheDelObject[53] =CreateDynamicObject(1238, 1662.104248, -2358.276611, 105.736588, 0.0000, 0.0000, 0.0000);
CheDelObject[54] =CreateDynamicObject(1238, 1662.935059, -2358.355469, 105.750626, 0.0000, 0.0000, 0.0000);
CheDelObject[55] =CreateDynamicObject(1238, 1627.243530, -2286.362061, 93.450989, 0.0000, 0.0000, 0.0000);
CheDelObject[56] =CreateDynamicObject(18367, 1656.920654, -2324.610840, 100.083862, 44.6907, 357.4217, 190.7688);
CheDelObject[57] =CreateDynamicObject(852, 1654.679077, -2314.694824, 92.738792, 0.0000, 0.0000, 0.0000);
CheDelObject[58] =CreateDynamicObject(18367, 1652.552246, -2303.343506, 83.249512, 347.9679, 357.4217, 190.7688);
CheDelObject[59] =CreateDynamicObject(18367, 1651.406494, -2274.390869, 92.817711, 9.4538, 6.8755, 293.0429);
CheDelObject[60] =CreateDynamicObject(1437, 1779.593750, -2544.239258, 27.454693, 0.0000, 0.0000, 101.2500);
CheDelObject[61] =CreateDynamicObject(1469, 1623.647583, -2288.529785, 93.621857, 0.0000, 0.0000, 270.0000);
CheDelObject[62] =CreateDynamicObject(1469, 1624.108521, -2290.102295, 93.070335, 0.0000, 0.0000, 315.0000);
CheDelObject[63] =CreateDynamicObject(1469, 1626.058350, -2291.741455, 93.064270, 0.0000, 0.0000, 326.2500);
CheDelObject[64] =CreateDynamicObject(1469, 1627.917603, -2291.959473, 93.064270, 0.0000, 0.0000, 11.2500);
CheDelObject[65] =CreateDynamicObject(1469, 1629.947021, -2291.178467, 93.064270, 0.0000, 0.0000, 33.7500);
CheDelObject[66] =CreateDynamicObject(1469, 1631.632446, -2289.481201, 93.064262, 0.0000, 0.0000, 56.2500);
CheDelObject[67] =CreateDynamicObject(1469, 1632.447876, -2287.502686, 93.070335, 0.0000, 0.0000, 90.0000);
CheDelObject[68] =CreateDynamicObject(1469, 1632.604614, -2285.693604, 93.070335, 0.0000, 0.0000, 90.0000);
CheDelObject[69] =CreateDynamicObject(1469, 1627.558350, -2281.010254, 93.036552, 0.0000, 0.0000, 180.0000);
CheDelObject[70] =CreateDynamicObject(1469, 1625.826782, -2281.394775, 93.070335, 0.0000, 0.0000, 191.2500);
CheDelObject[71] =CreateDynamicObject(1469, 1624.483521, -2282.059814, 93.070335, 0.0000, 0.0000, 213.7500);
CheDelObject[72] =CreateDynamicObject(1469, 1622.609131, -2283.672607, 93.070335, 0.0000, 0.0000, 225.0000);
CheDelObject[73] =CreateDynamicObject(1469, 1621.920166, -2285.461670, 93.070335, 0.0000, 0.0000, 270.0000);
CheDelObject[74] =CreateDynamicObject(1469, 1622.291016, -2287.888672, 93.070335, 0.0000, 0.0000, 292.5000);
CheDelObject[75] =CreateDynamicObject(1472, 1630.924072, -2283.461670, 92.708344, 0.8594, 0.0000, 123.7500);
CheDelObject[76] =CreateDynamicObject(3867, 1626.164673, -2279.034668, 100.013901, 0.0000, 0.0000, 180.0000);
CheDelObject[77] =CreateDynamicObject(3867, 1618.888428, -2284.212402, 100.049995, 0.0000, 0.0000, 270.0000);
CheDelObject[78] =CreateDynamicObject(3867, 1625.968384, -2292.777344, 100.516640, 0.0000, 0.0000, 4.3745);


return 1; }
//===============================ChaJoin Command================================
if(!strcmp(cmd, "/Cha", true)) {
if(ChaOn == 0) return SendClientMessage(playerid, WHITE, ".אין עכשיו האתגר טיפוס פעילה");
if(ChaStart == 1) return SendClientMessage(playerid, WHITE, ".האתגר טיפוס כבר התחילה, נסה פעם הבאה ");
if(ChaPlayers == sizeof(ChaSpawn)) return SendClientMessage(playerid, WHITE, ".כל המקומות נתפסו, נסה פעם באה");
if(InCha[playerid] == 1) return SendClientMessage(playerid, WHITE, ".הצטרפת כבר להאתגר טיפוס, אנא המתן");
GetPlayerName(playerid, playername, sizeof(playername));
ChaPlayers ++; InCha[playerid] = 1;


format(string,sizeof(string),".%d :הינך משתתף/ת מספר",ChaPlayers);
SendClientMessage(playerid,0xE21E1EFF,string);
format(string,sizeof(string),".בעת התחלת האתגר, התחל לטפס על ההר, הראשון שיגיע ינצח");
SendClientMessage(playerid,0xE21E1EFF,string);
if(AirBreakVar[playerid] == 1)
{
AirBreakVar[playerid] = 0;
TogglePlayerControllable(playerid, 1);
SendClientMessage(playerid, WHITE, ".האייר ברייק שלך כובה בהצלחה");
}

return 1; }
//===============================ChaEnd Command================================
if(!strcmp(cmd, "/Chaend", true)) {
if(ChaOn == 0) return SendClientMessage(playerid, WHITE, ".אין עכשיו האתגר טיפוס פעילה");
if(ChaStart == 1) return SendClientMessage(playerid, WHITE, ".האתגר טיפוס כבר התחילה ");
if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, WHITE, ".אתה לא אדמין ");
SendClientMessage(playerid, COLOR_YELLOW, "האתגר טיפוס בוטלה בהצלחה ");
GetPlayerName(playerid, Chaadminsname, sizeof(Chaadminsname));
CountChallenge = 0;
ChaEnd(2);
return 1; }

if(strcmp(cmd, "/weedinfo", true) == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"-- .מערכת הסמים עזרה --");
SendClientMessage(playerid, 0xFF66FFAA,"במוד זה מותקנת מערכת סמים חכמה המערכת עובדת על ידי מכירת סמים");
SendClientMessage(playerid, 0xFF66FFAA,"המטרה במוד הסמים שמותקן בשרת זה למצוא מנות סמים ולמכורם לאנשים");
SendClientMessage(playerid, 0xFF66FFAA,"מוד זה יגרום לחווית משחק כיפית יותר , ולהרווחת כסף");
SendClientMessage(playerid, 0xFF66FFAA,":בהיותכם משתמשים בסמים תהיה בצורה \"מסטולית\" פקודות למוד");
SendClientMessage(playerid, 0x0BAEAFF,"/useweed .וכנ'ל תוכלו להשתמש בסמים /sellweed .ברגע שתמצאו סמים תוכלו למכור אותם");
SendClientMessage(playerid, 0x0BAEAFF,"/details .לבדיקת הסמים שלך /buyweed .בהיותך קיבלת הודעה לקניית סמים תוכל לקנות אותם על ידי הפקודה");
SendClientMessage(playerid, 0x0BAEAFF,".declinedeal :לביטול העסקה");
SendClientMessage(playerid,COLOR_WHITE,"--------");
return 1;
}
if(strcmp(cmd, "/bankinfo", true) == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"-- .מערכת הבנק עזרה --");
SendClientMessage(playerid, 0xFF66FFAA,"במוד זה מותקנת מערכת בנק חכמה שבעזרת תוכלו לשמור את כספכם");
SendClientMessage(playerid, 0xFF66FFAA,":ניתן להשיג כסף ממגון פעיליות כגון");
SendClientMessage(playerid, 0xFF66FFAA,"הריגת שחקנים , נצחונות בפעיליות , ניצחון במערכות , מכירת סמים");
SendClientMessage(playerid, 0xFF66FFAA,"קניית נכסים ולהרוויח מהם כסף");
SendClientMessage(playerid, 0xFF66FFAA,":אחרי ההרוות הכסף תוכלו גם לשמור אותו, פקודות למערכת");
SendClientMessage(playerid, 0x0BAEAFF,"/balance לבדיקת המאזן הכספי שלך /depositall :להפקיד את כל הכסף /deposit [amount] :להפקדת הכסף");
SendClientMessage(playerid, 0x0BAEAFF,"/bankid [playerid] [amount] להעברת כסף לחשבון של שחקן אחר/withdraw [amount] :למשוך כסף מחשבונך");
SendClientMessage(playerid,COLOR_WHITE,"--------");
return 1;
}

//------------
if(strcmp(cmd, "/sellweed", true) == 0)
{
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
//----Syntex Error
if(!strlen(tmp)) return SendClientMessage(playerid, WHITE, "Usage: /sellweed [playerid]");
if(PS[playerid] == 1)return SendClientMessage(playerid, WHITE, "אתה נמצא בעסקה כבר ");
giveplayerid = strval(tmp);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if (IsPlayerConnected(giveplayerid)){
GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
GetPlayerName(playerid, sendername, sizeof(sendername));
fnm
if(offerweed[i][giveplayerid] == 1)return SendClientMessage(playerid,WHITE,"הבנאדם שאתה מנסה למכור לו כבר נמצא בעיסקה");
return 3;
}

if (PlayerInfo[playerid][Weeds] > 0 && PlayerInfo[playerid][Weeds] <= 3)
{
format(string, sizeof(string), " [$%d] מנת סמים במחיר [ID:%d] %s הצעת ל ", WeedCost, giveplayerid, giveplayer);
SendClientMessage(playerid, lblue, string);
format(string, sizeof(string), " [$%d] מציע לך לקנית מנת סמים במחיר [ID:%d] %s ", WeedCost, playerid, sendername);
SendClientMessage(giveplayerid, lblue, string);
format(string, sizeof(string), " /BuyWeed אם אתה רוצה לקנות את המנה תשתמש בפקודה ");
SendClientMessage(giveplayerid, lblue, string);
offerweed[playerid][giveplayerid] = 1;
PS[playerid] = 1;
CB[giveplayerid] = 1;
}else{
SendClientMessage(playerid, COLOR_WHITE, " אין לך סמים ");
}}else{
format(string, sizeof(string), " לא מחובר [ID:%d] ", giveplayerid);
SendClientMessage(playerid, lblue, string);}
return 1;
}

if(!strcmp(cmd,"/buyweed",true))
{
if(CB[playerid] == 0) return SendClientMessage(playerid,WHITE," אף אחד לא הציע לך לקנות סמים ");
if(PlayerInfo[playerid][Weeds] == 3)
{
SendClientMessage(playerid,WHITE," מנות כבר ואינך יכול לקנות עוד %d/3 יש לך  ");
for(new i;i<MAX_PLAYERS;i++)
offerweed[i][playerid] = 0;
format(string, sizeof(string), " לא יכול לקנות עוד סמים [ID:%d] %s העסקה בוטלה מכיוון שהשחקן ", giveplayerid, giveplayer);
SendClientMessage(playerid, lblue, string);
return 1;
}
fnm
if(offerweed[i][playerid] == 1)
{
if(PlayerInfo[playerid][Weeds] <= 3)
{
if(GetPlayerMoney(playerid)>999)
{
LACY_GiveMoney(i,1000); LACY_GiveMoney(playerid,-1000);
PlayerInfo[playerid][Weeds]++;
new name[MAX_PLAYER_NAME];
GetPlayerName(i,name,sizeof(name));
format(string,256,"[%d$]במחיר [ID:%d]%s קנית סמים בהצלחה מ",WeedCost,i,name);
SendClientMessage(playerid, lblue, string);
GetPlayerName(playerid,name,sizeof(name));
format(string,256,"[%d$] במחיר [ID : %d]%s מכרת בהצלחה סמים ל",WeedCost,playerid,name);
offerweed[i][playerid] = 0;
PS[playerid] = 0;
PS[i] = 0;
PlayerInfo[i][Weeds]--;
return 1;
}
else
{
SendClientMessage(playerid,WHITE,"אין לך מספיק כסף");
}
}
else
{
SendClientMessage(playerid,WHITE,"הכיס שלך כבר מלא בסמים");
}
}
}
return 1;
}



if(!strcmp(cmd,"/declinedeal",true))
{
fnm
if(offerweed[i][playerid] == 1)
{
new pname[MAX_PLAYER_NAME];
GetPlayerName(playerid,pname,sizeof(pname));
format(string,256," ביטל את העסקה [ID:%d] %s ",playerid,pname);
SendClientMessage(i, lblue, string);
SendClientMessage(playerid, WHITE, " אתה ביטלת את עיסקת הסמים ");
offerweed[i][playerid] = 0;
CB[i] = 0;
CB[playerid] = 0;
PS[playerid] = 0;
PS[i] = 0;
return 1;
}
}
SendClientMessage(playerid,WHITE,"אין לך עיסקת סמים עם אף אחד");
return 1;
}
//-=-=-=-=-=-
if(strcmp(cmd, "/kill", true) == 0)
{
if(HpModeA[playerid] == 1)
{
hpmodebug[playerid]=1;
HpModeA[playerid] = 0;
//DisplayTextForPlayer(playerid,"~r~Bye", 5, 1, 3);
PlayerInfo[playerid][Deaths] = PlayerInfo[playerid][Deaths] --;
return 1;
}
PlayerInfo[playerid][Deaths] = PlayerInfo[playerid][Deaths] --;
antianti[playerid] = 0;
SetPlayerHealth(playerid,0.0);
mini[playerid] = 0;
SendClientMessage(playerid,0xF6F658FF, ".התאבדת");

return 1;
}




if(strcmp(cmdtext, "/hq", true)==0)
{
if(strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"[NM]",true) == 0)
{
if (GetPlayerState(playerid) == 2)
{
SetVehiclePos(GetPlayerVehicleID(playerid), 1195.4961, -2037.1492, 69.0078);
SetVehicleZAngle(GetPlayerVehicleID(playerid), 90.5195);
}
else
{
SetPlayerPos(playerid, 1195.4961, -2037.1492, 69.0078);
SetPlayerFacingAngle(playerid, 90.5195);
}
SendClientMessage(playerid, 0xF6F658FF, ".ברוכים הבאים למפקדה של הקלאן שלך");
return 1;
}
if(strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"[RoX]",true) == 0)
{
if (GetPlayerState(playerid) == 2)
{
SetVehiclePos(GetPlayerVehicleID(playerid), -2127.3691, -70.8662, 35.1797);
SetVehicleZAngle(GetPlayerVehicleID(playerid), 181.1795);
}
else
{
SetPlayerPos(playerid, -2127.3691, -70.8662, 35.1797);
SetPlayerFacingAngle(playerid, 181.1795);
}
SendClientMessage(playerid, 0xF6F658FF, ".ברוכים הבאים למפקדה של הקלאן שלך");
return 1;
}

SendClientMessage(playerid,WHITE,".אתה לא נמצא בשום קלאן, או שאין לקלאן שלך מפקדה");
return 1;
}





if(strcmp(cmdtext, "/open" ,true)==0)
{
if(strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"[NM]",true) == 0)
{
if(!PlayerToPoint(10.0,playerid, 1211.504272, -2039.203613, 70.732048)) return SendClientMessage(playerid,WHITE,".אנא תקרב לשער של המפקדה שלך");
MoveObject(NM1,1211.504272, -2039.203613, 63.732048,2);
SetTimer("CloseHqNm",7000,0);
return 1;
}
if(strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"[RoX]",true) == 0)
{
if(!PlayerToPoint(10.0,playerid, -2127.299805, -80.334839, 30.043701)) return SendClientMessage(playerid,WHITE,".אנא תקרב לשער של המפקדה שלך");
MoveObject(RoX1,-2127.299805, -80.334839, 30.043701,2);
SetTimer("CloseHqRoX",7000,0);
return 1;
}



SendClientMessage(playerid,WHITE,".אתה לא נמצא בשום קלאן, או שאין לקלאן שלך מפקדה");
return 1;
}




if(strcmp(cmdtext, "/open2" ,true)==0)
{
if(strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"[NM]",true) == 0)
{
if(!PlayerToPoint(10.0,playerid, 1153.494507, -2044.161255, 67.997490)) return SendClientMessage(playerid,WHITE,".אנא תקרב לשער של המפקדה שלך");
MoveObject(NM2,1153.494507, -2044.161255, 59.097490,2);
MoveObject(NM3,1150.927368, -2040.386353, 74.647285,1);
SetTimer("CloseHqNm2",7000,0);
return 1;
}



if(strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"[RoX]",true) == 0)
{
if(!PlayerToPoint(23.0,playerid, -2180.527344, -212.667587, 31.292458)) return SendClientMessage(playerid,WHITE,".אנא תקרב לשער של המפקדה שלך");
MoveObject(RoX2,-2180.527344, -212.667587, 31.292458,2);
MoveObject(RoX3,-2180.498779, -217.493393, 31.292458,2);
MoveObject(RoX5,-2158.575439, -225.588898, 35.503658,2);
SetTimer("CloseHqRoX2",7000,0);
return 1;
}

SendClientMessage(playerid,WHITE,".אתה לא נמצא בשום קלאן, או שאין לקלאן שלך מפקדה");
return 1;
}







if(strcmp(cmdtext, "/up" ,true)==0)
{
if(strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"[NM]",true) == 0)
{

SendClientMessage(playerid,WHITE,".למפקדה שלך אין מעלית");
return 1;
}
if(strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"[RoX]",true) == 0)
{
if(!PlayerToPoint(10.0,playerid, -2124.288818, -176.404907, 34.340195)) return SendClientMessage(playerid,WHITE,".אנא תקרב לשער של המפקדה שלך");
MoveObject(RoX4,-2124.288818, -176.404907, 46.376961,2);
SetTimer("CloseHqRoX3",20*1000,0);
return 1;
}



SendClientMessage(playerid,WHITE,".אתה לא נמצא בשום קלאן, או שאין לקלאן שלך מפקדה");
return 1;
}

//==
if(!strcmp(cmd,"/CityStart",true))
{
new TYPE_Race[256];
TYPE_Race = strtok(cmdtext,idx);
if(!strlen(TYPE_Race))
return
SendClientMessage(playerid, COLOR_WHITE, "/CityStart [SF/LS]");
if(30 < strlen(TYPE_Race)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");

if(CityRaceingOn == 1 || CityRaceingOn == 5 || CityRaceingOn == 2) return SendClientMessage(playerid, COLOR_WHITE, ".המירוץ ערים התחיל נסה פעם הבאה. ");

CityRaceingStart();


if(strcmp(TYPE_Race,"SF",true) == 0)
return
CityRaceingOn = 1;

if(strcmp(TYPE_Race,"LS",true) == 0)
return
CityRaceingOn = 2;

return 1;
}


if(!strcmp(cmd,"/CityRace",true))
{

if (CityRaceingOn == 5) return SendClientMessage(playerid, COLOR_WHITE, ".אין מירוץ ערים פעיל כרגע");
if(CityRaceingPlayers == 10) return SendClientMessage(playerid,COLOR_WHITE,"ההרשמה נסגרה, כל המקומות נתפסו. נסה פעם הבאה");
if(InCityRaceing[playerid] > 0) return SendClientMessage(playerid,COLOR_WHITE,".הינך רשום למירוץ זה");
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,COLOR_WHITE,".אנא היכנס לרכב על מנת להשתתף במירוץ");
if(CityRaceingOn == 1)
{
DisablePlayerRaceCheckpoint(playerid);
new vehicleid = GetPlayerVehicleID(playerid);
SetPlayerVirtualWorld(playerid,1);
SetVehicleVirtualWorld(vehicleid,1);
TogglePlayerControllable(playerid,0);
CityRaceingPlayers ++;

if(CityRaceingPlayers == 1)
{
format(string,sizeof(string),".הצטרף לפעילות ראשון וקיבל צו'פר של 1,000 דולר %s השחקן",GetName(playerid));
SendClientMessageToAll(0xE21E1EFF,string);
LACY_GiveMoney(playerid,1000);

}

CityCP[playerid] = 1;
Player_Var[playerid] = CityRaceingPlayers;
InCityRaceing[playerid] = 1;

SetPlayerRaceCheckpoint(playerid,0,CityCPs[CityCP[playerid]][0],CityCPs[CityCP[playerid]][1],CityCPs[CityCP[playerid]][2],CityCPs[CityCP[playerid]+1][0],CityCPs[CityCP[playerid]+1][1],CityCPs[CityCP[playerid]+1][2],30.0);
SetVehiclePos(GetPlayerVehicleID(playerid), RandomCityRace[Player_Var[playerid]][0], RandomCityRace[Player_Var[playerid]][1], RandomCityRace[Player_Var[playerid]][2]);
SetVehicleZAngle(GetPlayerVehicleID(playerid), RandomCityRace[Player_Var[playerid]][3]);


format(string,sizeof(string),".%d :הינך משתתף/ת מספר",CityRaceingPlayers);
SendClientMessage(playerid,0xE21E1EFF,string);
format(string,sizeof(string),".בעת התחלת הקרב, תתחיל לנסוע כמה שיותר מהר לצ'ק פוינטים האדומים על המסלול מירוץ ערים");
SendClientMessage(playerid,0xE21E1EFF,string);
return 1;
}

if(CityRaceingOn == 2)
{
DisablePlayerRaceCheckpoint(playerid);
new vehicleid = GetPlayerVehicleID(playerid);
SetPlayerVirtualWorld(playerid,1);
SetVehicleVirtualWorld(vehicleid,1);
TogglePlayerControllable(playerid,0);
CityRaceingPlayers ++;
InCityRaceing2[playerid] = 1;
CityCP[playerid] = 1;
Player_Var[playerid] = CityRaceingPlayers;

SetPlayerRaceCheckpoint(playerid,0,CityCPs2[CityCP[playerid]][0],CityCPs2[CityCP[playerid]][1],CityCPs2[CityCP[playerid]][2],CityCPs2[CityCP[playerid]+1][0],CityCPs2[CityCP[playerid]+1][1],CityCPs2[CityCP[playerid]+1][2],30.0);
SetVehiclePos(GetPlayerVehicleID(playerid), RandomCityRace2[Player_Var[playerid]][0], RandomCityRace2[Player_Var[playerid]][1], RandomCityRace2[Player_Var[playerid]][2]);
SetVehicleZAngle(GetPlayerVehicleID(playerid), RandomCityRace2[Player_Var[playerid]][3]);

format(string,sizeof(string),".%d :הינך משתתף/ת מספר",CityRaceingPlayers);
SendClientMessage(playerid,0xE21E1EFF,string);
format(string,sizeof(string),".בעת התחלת הקרב, תתחיל לנסוע כמה שיותר מהר לצ'ק פוינטים האדומים על המסלול מירוץ ערים");
SendClientMessage(playerid,0xE21E1EFF,string);

return 1;
}

return 1;
}


//---RaceSystem
if(strcmp(cmd, "/races", true) == 0)
{
new Roy_Killer[256];
Roy_Killer= strtok(cmdtext, idx);
if(30 < strlen(Roy_Killer)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(Roy_Killer))
{
SendClientMessage(playerid,WHITE,"/races [action] :שימוש");
SendClientMessage(playerid,WHITE,"/races join - להצטרפות למירוץ");
SendClientMessage(playerid,WHITE,"/races drift - להפעלת מירוץ הדריפטים");
SendClientMessage(playerid,WHITE,"/races bike - להפעלת מירוץ האופנועים");
SendClientMessage(playerid,WHITE,"/races race - להפעלת מירוץ האופנועים");
return 1;
}

if(strcmp(Roy_Killer,"drift",true) == 0)
{
if(PlayerInfo[playerid][AdminsLevel] < 10) return SendClientMessage(playerid,WHITE,".פקודה זאתי משמשת אדמין בלבד, תודה");
if(IFDriftOn == 1 || IFraceOn==1 || BikeOn == 1) return SendClientMessage(playerid,WHITE,".יש מירוץ מופעל, חכה שיסתיים");
DriftPlayer =0,DriftEnd=0,WinnerDrift=1,IFDriftOn=1,StartDrift(),SetTimer("UnFreezeDrift",60*1000,0);
format(kboobcha, sizeof(kboobcha), "~y~~H~[]/races join~y~~H~[]");
GameTextForAll(kboobcha,3000,4);
return 1;
}

if(strcmp(Roy_Killer,"race",true) == 0)
{
if(PlayerInfo[playerid][AdminsLevel] < 10) return SendClientMessage(playerid,WHITE,".פקודה זאתי משמשת אדמין בלבד, תודה");
if(IFDriftOn == 1 || IFraceOn==1 || BikeOn == 1) return SendClientMessage(playerid,WHITE,".יש מירוץ מופעל, חכה שיסתיים");
RaceEnd=0,WinnerRace=1,IFraceOn=1,StartRace(),SetTimer("UnFreezeRace",60*1000,0);
format(kboobcha, sizeof(kboobcha), "~y~~H~[]/races join~y~~H~[]");
GameTextForAll(kboobcha,3000,4);
return 1;
}
if(strcmp(Roy_Killer,"bike",true) == 0)
{
if(PlayerInfo[playerid][AdminsLevel] < 10) return SendClientMessage(playerid, WHITE, "! אתה לא אדמין ");
if(IFDriftOn == 1 || IFraceOn==1 || BikeOn == 1) return SendClientMessage(playerid,WHITE,".יש מירוץ מופעל, חכה שיסתיים");
format(kboobcha, sizeof(kboobcha), "~y~~H~[]/races join~y~~H~[]");
GameTextForAll(kboobcha,3000,4);
BikeStart();
return 1;
}

if(strcmp(Roy_Killer,"join",true) == 0)
{
if(IFraceOn ==0 && IFDriftOn == 0 && BikeOn == 0) return SendClientMessage(playerid,WHITE,".אין עכשיו מירוץ מופעל");
if(IFraceOn == 1)
{
if(RaceEnd==1) return SendClientMessage(playerid,WHITE,".ההרשמה כבר נסגרה");
if(RacePlayers==15) return SendClientMessage(playerid,WHITE,".כל המקומות נתפסו");
if(Youregisterrace[playerid] ==1) return SendClientMessage(playerid,WHITE,"אתה כבר רשום.");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,WHITE,".אנא כנס לרכב כדאי להירשם");
RacePlayers++;
Youregisterrace[playerid] =1;

if(RacePlayers == 1)
{
format(string,sizeof(string),".הצטרף לפעילות ראשון וקיבל צו'פר של 1,000 דולר %s השחקן",GetName(playerid));
SendClientMessageToAll(0xE21E1EFF,string);
LACY_GiveMoney(playerid,1000);

}

format(string,sizeof(string),".%d :הינך משתתף/ת מספר",RacePlayers);
SendClientMessage(playerid,0xE21E1EFF,string);
format(string,sizeof(string),".בעת התחלת הקרב, תתחיל לנסוע כמה שיותר מהר לצ'ק פוינטים האדומים על המסלול מירוץ");
SendClientMessage(playerid,0xE21E1EFF,string);

if(AirBreakVar[playerid] == 1)
{
AirBreakVar[playerid] = 0;
SendClientMessage(playerid, WHITE, ".האייר ברייק שלך כובה בהצלחה");
}
new vehicleid = GetPlayerVehicleID(playerid);
SetPlayerVirtualWorld(playerid,1);
SetVehicleVirtualWorld(vehicleid,1);
SetPlayerRaceCheckpoint(playerid, 2,1942.3159,852.1760,6.7267,1942.3159,852.1760,6.7267, 28);//CP2
TogglePlayerControllable(playerid,0);
RaceCP[playerid]=1;

if(RacePlayers ==1)return SetVehiclePos(vehicleid,1983.5819,847.9211,6.4336),SetVehicleZAngle(vehicleid,90.5373);
if(RacePlayers ==2)return SetVehiclePos(vehicleid,1983.6615,850.6814,6.4537),SetVehicleZAngle(vehicleid,91.4519);
if(RacePlayers ==3)return SetVehiclePos(vehicleid,1983.8606,854.0459,6.4420),SetVehicleZAngle(vehicleid,89.7399);
if(RacePlayers ==4)return SetVehiclePos(vehicleid,1983.2966,856.1102,6.4422),SetVehicleZAngle(vehicleid,90.7140);
if(RacePlayers ==5)return SetVehiclePos(vehicleid,1983.3856,858.5254,6.4604),SetVehicleZAngle(vehicleid,87.1792);
if(RacePlayers ==6)return SetVehiclePos(vehicleid,1984.0253,861.0951,6.4507),SetVehicleZAngle(vehicleid,89.2950);
if(RacePlayers ==7)return SetVehiclePos(vehicleid,1983.4742,866.4510,7.1593),SetVehicleZAngle(vehicleid,88.3443);
if(RacePlayers ==8)return SetVehiclePos(vehicleid,1983.2288,869.5640,7.8530),SetVehicleZAngle(vehicleid,90.3711);
if(RacePlayers ==9)return SetVehiclePos(vehicleid,1983.3806,873.7965,8.6849),SetVehicleZAngle(vehicleid,83.9591);
if(RacePlayers ==10)return SetVehiclePos(vehicleid,1983.1357,839.5808,6.4415),SetVehicleZAngle(vehicleid,91.7967);
if(RacePlayers ==11)return SetVehiclePos(vehicleid,1983.2297,836.8755,6.4486),SetVehicleZAngle(vehicleid,95.1153);
if(RacePlayers ==12)return SetVehiclePos(vehicleid,1983.2699,834.2242,6.4450),SetVehicleZAngle(vehicleid,96.4373);
if(RacePlayers ==13)return SetVehiclePos(vehicleid,1983.4442,831.6970,6.4406),SetVehicleZAngle(vehicleid,90.6232);
if(RacePlayers ==14)return SetVehiclePos(vehicleid,1983.6328,828.6913,6.4505),SetVehicleZAngle(vehicleid,89.9238);
if(RacePlayers ==15)return SetVehiclePos(vehicleid,1983.5974,825.3797,6.5348),SetVehicleZAngle(vehicleid,88.5591);

return 1;
}

if(IFDriftOn == 1)
{
if(DriftEnd==1) return SendClientMessage(playerid,WHITE,".ההרשמה כבר נסגרה");
if(DriftPlayer==22) return SendClientMessage(playerid,WHITE,".כל המקומות נתפסו");
if(YouRegister[playerid] ==1) return SendClientMessage(playerid,WHITE,"אתה כבר רשום.");
new fstr[255];
if(!IsVehicle(playerid)) return  format(fstr,sizeof(fstr),"/drifts , /race , /dj .על מנת להשתתף במירוץ דריפט Turismo אתה צריך תרכב"),SendClientMessage(playerid,WHITE,fstr);
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,WHITE,".אנא כנס לרכב כדאי להירשם");
DriftPlayer++;
YouRegister[playerid] =1;

if(DriftPlayer == 1)
{
format(string,sizeof(string),".הצטרף לפעילות ראשון וקיבל צו'פר של 1,000 דולר %s השחקן",GetName(playerid));
SendClientMessageToAll(0xE21E1EFF,string);
LACY_GiveMoney(playerid,1000);

}

format(string,sizeof(string),".%d :הינך משתתף/ת מספר",DriftPlayer);
SendClientMessage(playerid,0xE21E1EFF,string);
format(string,sizeof(string),".בעת התחלת הקרב, תתחיל לנסוע כמה שיותר מהר לצ'ק פוינטים האדומים על המסלול מירוץ");
SendClientMessage(playerid,0xE21E1EFF,string);
if(AirBreakVar[playerid] == 1)
{
AirBreakVar[playerid] = 0;
SendClientMessage(playerid, WHITE, ".האייר ברייק שלך כובה בהצלחה");
}
new vehicleid = GetPlayerVehicleID(playerid);
SetPlayerVirtualWorld(playerid,1);
SetVehicleVirtualWorld(vehicleid,1);
SetPlayerRaceCheckpoint(playerid, 0,2297.5369,1509.4496,42.8203,2290.4094,1500.1200,42.6123, 6);//CP2
TogglePlayerControllable(playerid,0);
DriftCP[playerid] =1;
if(DriftPlayer ==1)return SetVehiclePos(vehicleid,2300.0222,1408.4586,42.5272),SetVehicleZAngle(vehicleid,0.1799);
if(DriftPlayer ==2)return SetVehiclePos(vehicleid,2302.8008,1408.2854,42.5275),SetVehicleZAngle(vehicleid,358.9406);
if(DriftPlayer ==3)return SetVehiclePos(vehicleid,2306.1240,1408.3108,42.5273),SetVehicleZAngle(vehicleid,359.0157);
if(DriftPlayer ==4)return SetVehiclePos(vehicleid,2308.8560,1408.2356,42.5280),SetVehicleZAngle(vehicleid,0.2649);
if(DriftPlayer ==5)return SetVehiclePos(vehicleid,2311.6707,1408.2217,42.5272),SetVehicleZAngle(vehicleid,358.9902);
if(DriftPlayer ==5)return SetVehiclePos(vehicleid,2314.1875,1408.3422,42.5269),SetVehicleZAngle(vehicleid,2.0840);
if(DriftPlayer ==6)return SetVehiclePos(vehicleid,2316.7107,1408.4094,42.5272),SetVehicleZAngle(vehicleid,1.4716);
if(DriftPlayer ==7)return SetVehiclePos(vehicleid,2319.1816,1408.4569,42.5277),SetVehicleZAngle(vehicleid,359.4041);
if(DriftPlayer ==8)return SetVehiclePos(vehicleid,2321.4253,1408.4253,42.5286),SetVehicleZAngle(vehicleid,1.8897);
if(DriftPlayer ==9)return SetVehiclePos(vehicleid,2323.9102,1408.4175,42.5273),SetVehicleZAngle(vehicleid,3.3133);
if(DriftPlayer ==10)return SetVehiclePos(vehicleid,2326.4661,1408.4795,42.5263),SetVehicleZAngle(vehicleid,3.3910);
if(DriftPlayer ==11)return SetVehiclePos(vehicleid,2328.7549,1408.6261,42.5258),SetVehicleZAngle(vehicleid,3.8961);
if(DriftPlayer ==12)return SetVehiclePos(vehicleid,2331.2324,1408.8168,42.5270),SetVehicleZAngle(vehicleid,4.3630);
if(DriftPlayer ==13)return SetVehiclePos(vehicleid,2333.6531,1408.9194,42.5272),SetVehicleZAngle(vehicleid,359.4334);
if(DriftPlayer ==14)return SetVehiclePos(vehicleid,2335.9211,1408.9659,42.5270),SetVehicleZAngle(vehicleid,359.0094);
if(DriftPlayer ==15)return SetVehiclePos(vehicleid,2338.1948,1409.0341,42.5284),SetVehicleZAngle(vehicleid,1.5728);
if(DriftPlayer ==16)return SetVehiclePos(vehicleid,2340.4922,1408.9869,42.5243),SetVehicleZAngle(vehicleid,2.5946);
if(DriftPlayer ==17)return SetVehiclePos(vehicleid,2342.9924,1408.9186,42.5273),SetVehicleZAngle(vehicleid,0.8667);
if(DriftPlayer ==18)return SetVehiclePos(vehicleid,2345.3049,1409.0309,42.5269),SetVehicleZAngle(vehicleid,0.6740);
if(DriftPlayer ==19)return SetVehiclePos(vehicleid,2347.7759,1409.1488,42.5261),SetVehicleZAngle(vehicleid,358.0116);
if(DriftPlayer ==20)return SetVehiclePos(vehicleid,2350.0234,1409.2120,42.5271),SetVehicleZAngle(vehicleid,359.3376);
if(DriftPlayer ==21)return SetVehiclePos(vehicleid,2352.2991,1409.1683,42.5278),SetVehicleZAngle(vehicleid,357.8737);
if(DriftPlayer ==22)return SetVehiclePos(vehicleid,2354.6870,1409.1930,42.5264),SetVehicleZAngle(vehicleid,358.3572);

return 1;
}

if(BikeOn == 1)
{
new fstr[256];
if (BikeOn == 0) return SendClientMessage(playerid, WHITE, ".אין מירוץ פעיל כרגע");
if(BikePlayers == 10) return SendClientMessage(playerid,WHITE,"ההרשמה נסגרה, כל המקומות נתפסו. נסה פעם הבאה");
if(InBike[playerid] > 0) return SendClientMessage(playerid,WHITE,"הצטרפת, אנא המתן לשיגורך בסבלנות תודה");
if(!IsBike(playerid)) return  format(fstr,sizeof(fstr),".על מנת להשתתף במירוץ ,NRG-500 אתה צריך תרכב"),SendClientMessage(playerid,WHITE,fstr);
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,WHITE,".אנא כנס לרכב כדאי להירשם");
DisablePlayerRaceCheckpoint(playerid);
SetPlayerRaceCheckpoint(playerid,0,-2679.4287,1357.5764,55.4297,-2677.4780,1468.2661,55.7398,15);
BikePlayers ++;
InBike[playerid] = 1;

if(BikePlayers == 1)
{
format(string,sizeof(string),".הצטרף לפעילות ראשון וקיבל צו'פר של 1,000 דולר %s השחקן",GetName(playerid));
SendClientMessageToAll(0xE21E1EFF,string);
LACY_GiveMoney(playerid,1000);

}

format(string,sizeof(string),".%d :הינך משתתף/ת מספר",BikePlayers);
SendClientMessage(playerid,0xE21E1EFF,string);
format(string,sizeof(string),"!בעת התחלת הקרב, תתחיל לנסוע כמה שיותר מהר לצ'ק פוינטים האדומים על המסלול מירוץ");
SendClientMessage(playerid,0xE21E1EFF,string);
if(AirBreakVar[playerid] == 1)
{
AirBreakVar[playerid] = 0;
SendClientMessage(playerid, WHITE, ".האייר ברייק שלך כובה בהצלחה");
}
new vehicleid = GetPlayerVehicleID(playerid);
SetPlayerVirtualWorld(playerid,1);
SetVehicleVirtualWorld(vehicleid,1);
TogglePlayerControllable(playerid,0);
if(BikePlayers == 1)
{
SetVehiclePos(vehicleid,-2668.5300,1289.6600,55.0066);
SetVehicleZAngle(vehicleid,0.4992);
return 1;
}
if(BikePlayers == 2)
{
SetVehiclePos(vehicleid,-2669.8596,1289.5593,54.9772);
SetVehicleZAngle(vehicleid,0.4992);
return 1;
}
if(BikePlayers == 3)
{
SetVehiclePos(vehicleid,-2671.5039,1289.2844,54.9953);
SetVehicleZAngle(vehicleid,0.4992);
return 1;
}
if(BikePlayers == 4)
{
SetVehiclePos(vehicleid,-2672.9126,1288.8269,54.9983);
SetVehicleZAngle(vehicleid,0.4992);
return 1;
}
if(BikePlayers == 5)
{
SetVehiclePos(vehicleid,-2675.4602,1289.6935,54.9863);
SetVehicleZAngle(vehicleid,0.4992);
return 1;
}
if(BikePlayers == 6)
{
SetVehiclePos(vehicleid,-2676.6624,1289.6770,54.9936);
SetVehicleZAngle(vehicleid,0.4992);
return 1;
}
if(BikePlayers == 7)
{
SetVehiclePos(vehicleid,-2677.8667,1289.6951,54.9994);
SetVehicleZAngle(vehicleid,0.4992);
return 1;
}
if(BikePlayers == 8)
{
SetVehiclePos(vehicleid,-2679.8469,1289.4535,54.9909);
SetVehicleZAngle(vehicleid,0.4992);
return 1;
}
if(BikePlayers == 9)
{
SetVehiclePos(vehicleid,-2681.5703,1289.2745,55.1966);
SetVehicleZAngle(vehicleid,0.4992);

return 1;
}
if(BikePlayers == 10)
{
SetVehiclePos(vehicleid,-2682.8469,1289.0913,55.1279);
SetVehicleZAngle(vehicleid,0.4992);
return 1;
}

return 1;
}
return 1;
}

return 1;
}

	if (strcmp("/Ha", cmd, true) == 0)
	{
		new cmdid, pname[MAX_PLAYER_NAME];
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, WHITE, "Usage: /Ha [answer]");
		cmdid = strval(tmp);

		if(cmdid < answer || cmdid > answer)
		{
			SendClientMessage(playerid, WHITE, ".תשובה שגויה");
		}

		if(cmdid == answer && answered == 0)
		{
			GetPlayerName(playerid, pname, sizeof(pname));

			format(string, sizeof(string), ".[1000$],'%d' :ענה על התשובה נכון, התשובה הייתה %s השחקן",cmdid ,pname);
			SendClientMessageToAll(COLOR_LIGHTGREEN, string);
			LACY_GiveMoney(playerid, 1000);

			answered = 1;
			SetPlayerScore(playerid, GetPlayerScore(playerid) + score);
			score = 0;
			return 1;
		}
		else if(cmdid == answer && answered == 1)
		{
			SendClientMessage(playerid, WHITE, ".מאוחר מידי, כבר ענו לפניך");
		}
		return 1;
	}






if(!strcmp(cmd, "/startwar", true))
{

if (PlayerInfo[playerid][AdminsLevel] >= 10) {

//tmp = strtok(cmdtext, idx);
//if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_LIGHTGREEN, "/StartWar [Reward] :שימוש ");
//if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, WHITE, ". אתה לא אדמין ");
if(WarOn == 1) return SendClientMessage(playerid, WHITE, ".יש כבר מלחמה פעילה ");

format(kboobcha, sizeof(kboobcha), "~y~~H~[]/War~y~~H~[]");
GameTextForAll(kboobcha,3000,4);

fnm
}
SetTimer("WarStart",3000,0);

}
else
{

}
return 1;
}



if(!strcmp(cmd, "/war", true))
{
if(WarOn == 0) return SendClientMessage(playerid, WHITE, ".אין עכשיו מלחמה פעילה");
if(WS == 1) return SendClientMessage(playerid, WHITE, ".המלחמה כבר התחילה, נסה פעם הבאה ");
if(WarPlayers == sizeof(sssa)) return SendClientMessage(playerid, WHITE, ".כל המקומות נתפסו, נסה פעם באה");
if(InWar[playerid] == 1) return SendClientMessage(playerid, WHITE, ".הצטרפת כבר לוואר, אנא המתן");
if(TorYou[playerid] ==1) return SendClientMessage(playerid, WHITE,"/backtor :אנא החזר/י תחיה שלך");
if(SharkYou[playerid] ==1) return SendClientMessage(playerid, WHITE,"/backshark :אנא החזר/י תחיה שלך");
if(DolpYou[playerid] ==1) return SendClientMessage(playerid, WHITE,"/backdolphin :אנא החזר/י תחיה שלך");
if(GetPlayerMoney(playerid) < 500) return SendClientMessage(playerid, WHITE, ".\"500$\" :אין לך מספיק כסף להשתתף בקארט עלות השתתפות היא");

GetPlayerName(playerid, playername, sizeof(playername));
WarPlayers ++; InWar[playerid] = 1;
MoneyWinnerWar +=500;
LACY_GiveMoney(playerid,-500);
format(string,sizeof(string),".%d :הינך משתתף/ת מספר",WarPlayers);
SendClientMessage(playerid,0xE21E1EFF,string);
format(string,sizeof(string),".בעת התחלת הקרב, תתחיל להרוג את המשתתפים האחרים");
SendClientMessage(playerid,0xE21E1EFF,string);
if(WarPlayers == 1)
{
format(string,sizeof(string),".הצטרף לפעילות ראשון וקיבל צו'פר של 1,000 דולר %s השחקן",GetName(playerid));
SendClientMessageToAll(0xE21E1EFF,string);
LACY_GiveMoney(playerid,1000);

}
if(AirBreakVar[playerid] == 1)
{
AirBreakVar[playerid] = 0;
TogglePlayerControllable(playerid, 1);
SendClientMessage(playerid, WHITE, ".האייר ברייק שלך כובה בהצלחה");
}
return 1;
}

if(!strcmp(cmd, "/warend", true))
{
if(WarOn == 0) return SendClientMessage(playerid, WHITE, ".אין עכשיו מלחמה פעילה");
if (PlayerInfo[playerid][AdminsLevel] <= 10) return 0;
SendClientMessage(playerid, COLOR_WHITE, "המלחמה בוטלה בהצלחה ");
GetPlayerName(playerid, Adminname, sizeof(Adminname));
Count = 0;
WarEnd(2);
return 1;
}

if(!strcmp(cmd, "/srpg", true))
{
if (PlayerInfo[playerid][AdminsLevel] >= 10) {
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_LIGHTGREEN, " /srpg [ammunt] ");
Rewardr  = strval(tmp);
WarStartr();
format(kboobcha, sizeof(kboobcha), "~y~~H~[]/Rpg~y~~H~[]");
GameTextForAll(kboobcha,3000,4);
}
else
{

}
return 1;
}

//===============================GreStart Command===============================
if(!strcmp(cmd, "/startGre", true)) {
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_LIGHTGREEN, "/StartGre [GrePras] :שימוש ");
if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_RED, "! אתה לא אדמין ");
if(GreOn == 1) return SendClientMessage(playerid, COLOR_RED, ".יש כבר מלחמת רימונים פעילה ");
format(kboobGre, sizeof(kboobGre), "~B~~H~ /Gre", playername);
GameTextForAll(kboobGre,3000,4);
for(new i = 0; i < MAX_PLAYERS; i++) {
PlayerPlaySound(i,1058, 0.0, 0.0, 0.0); }
GrePras  = strval(tmp);
SetTimer("GreStart2",3000,0);
return 1; }
//===============================GreJoin Command================================
if(!strcmp(cmd, "/Gre", true)) {
if(GreOn == 0) return SendClientMessage(playerid, COLOR_RED, ".אין עכשיו מלחמת רימונים פעילה");
if(GreStart == 1) return SendClientMessage(playerid, COLOR_RED, ".המלחמת רימונים כבר התחילה, נסה פעם הבאה ");
if(GrePlayers == sizeof(GreSpawn)) return SendClientMessage(playerid, COLOR_RED, ".כל המקומות נתפסו, נסה פעם באה");
if(InGre[playerid] == 1) return SendClientMessage(playerid, COLOR_RED, ".הצטרפת כבר למלחמת רימונים, אנא המתן");
GrePlayers ++; InGre[playerid] = 1;

if(GrePlayers == 1)
{
format(string,sizeof(string),".הצטרף לפעילות ראשון וקיבל צו'פר של 1,000 דולר %s השחקן",GetName(playerid));
SendClientMessageToAll(0xE21E1EFF,string);
LACY_GiveMoney(playerid,1000);

}

format(string,sizeof(string),".%d :הינך משתתף/ת מספר",GrePlayers);
SendClientMessage(playerid,0xE21E1EFF,string);
format(string,sizeof(string),".בעת התחלת הקרב, תתחיל להרוג את המשתתפים האחרים");
SendClientMessage(playerid,0xE21E1EFF,string);


return 1; }
//===============================GreEnd Command================================
if(!strcmp(cmd, "/Greend", true)) {
if(GreOn == 0) return SendClientMessage(playerid, COLOR_RED, ".אין עכשיו מלחמת רימונים פעילה");
if(GreStart == 1) return SendClientMessage(playerid, COLOR_RED, ".המלחמת רימונים כבר התחילה ");
if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_RED, ".אתה לא אדמין ");
SendClientMessage(playerid, COLOR_YELLOW, "המלחמת רימונים בוטלה בהצלחה ");
GetPlayerName(playerid, Greadminsname, sizeof(Greadminsname));
CountGrellenge = 0;
GreEnd(2);
return 1; }

if(!strcmp(cmd, "/Rpg", true))
{


if(WarOnr == 0) return SendClientMessage(playerid, WHITE, "אין כרגע מערכת בזוקה פעילה, תודה.");
if(WSr == 1) return SendClientMessage(playerid, WHITE, ".הגאטר כבר החל, לא תוכל להירשם עד לפעם הבאה תודה");
if(WarPlayersr == sizeof(gRandomWarSpawns)) return SendClientMessage(playerid, WHITE, " כל המקומות נתפסו, נסה פעם באה");
if(InWarr[playerid] == 1) return SendClientMessage(playerid, WHITE, "אתה כבר רשום, המתן לשיגורך בסבלנות.");
WarPlayersr ++; InWarr[playerid] = 1;

format(string,sizeof(string),".%d :הינך משתתף/ת מספר",WarPlayersr);
SendClientMessage(playerid,0xE21E1EFF,string);
format(string,sizeof(string),".בעת התחלת הקרב, תתחיל להרוג את המשתתפים האחרים");
SendClientMessage(playerid,0xE21E1EFF,string);
SetPlayerVirtualWorld(playerid,0);
if(WarPlayersr == 1)
{
format(string,sizeof(string),".הצטרף לפעילות ראשון וקיבל צו'פר של 1,000 דולר %s השחקן",GetName(playerid));
SendClientMessageToAll(0xE21E1EFF,string);
LACY_GiveMoney(playerid,1000);
}

if(AirBreakVar[playerid] == 1)
{
AirBreakVar[playerid] = 0;
TogglePlayerControllable(playerid, 1);
SendClientMessage(playerid, WHITE, ".האייר ברייק שלך כובה בהצלחה");
}
return 1;
}

if(!strcmp(cmd, "/Rpgend", true))
{
if(WarOnr == 0) return SendClientMessage(playerid, WHITE, " אין עכשיו מלחמה פעילה");
if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, WHITE, " אתה לא אדמין ");
SendClientMessage(playerid, WHITE, " המלחמה בוטלה בהצלחה ");
Countr = 0;
WarEndr(2);
return 1;
}

if(strcmp(cmd,"/roykingomer",true) == 0)
{
if(IsPlayerInAnyVehicle(playerid))
{
RemovePlayerFromVehicle(playerid);
SetTimerEx("repairbug",5000,0,"i",playerid);

}
if(!IsPlayerInAnyVehicle(playerid))
{
SetTimerEx("repairbug",5000,0,"i",playerid);
}
return 1;
}
if(strcmp(cmd, "/flip", true) == 0)
{


new Float:X, Float:Y, Float:Z;
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,WHITE,"אתה לא ברכב.");
SetCameraBehindPlayer(playerid);
GetPlayerPos(playerid, X, Y, Z);
SetVehiclePos(GetPlayerVehicleID(playerid), X, Y, Z);
SetVehicleZAngle(GetPlayerVehicleID(playerid), 0);

return 1;
}

	if(strcmp(cmdtext, "/Clean", true) == 0) {
 if(GetPlayerMoney(playerid) < 1000)
 return SendClientMessage(playerid,COLOR_WHITE,".''1,000$'' כדי לנקות לעצמך את הצ'אט, אתה צריך");
    GivePlayerMoney(playerid,-1000);
       for (new i=0;i<100;i++)
       SendClientMessage(playerid, COLOR_BLUE, "");
    	SendClientMessage(playerid, COLOR_YELLOW, "!הצ'אט נוקה בהצלחה");
    	PlayerPlaySound(playerid,1058 ,0, 0, 0);
		return 1;
	}

if(strcmp(cmd, "/MAXPLAYERS", true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE, "MaxPlayers: 100");
return 1;
}

if(strcmp(cmd, "/showid", true) == 0)
{
format(string, sizeof(string), "^^* ID: %i *^^",playerid);
SendClientMessage(playerid, 0xF6F658FF, string);
return 1;
}





    if(strcmp(cmd,"/SetLevelI",true) == 0)
    {
    if (PlayerInfo[playerid][AdminsLevel] >= 10)
{

       // if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,WHITE,". אתה לא אדמין");
        tmp = strtok(cmdtext, idx);
        if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");

		new id = ReturnID(tmp);
//        new tmp2[256];
        tmp2 = strtok(cmdtext, idx);
        if(30 < strlen(tmp2)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");

		new level = strval(tmp2);
        if(!strlen(tmp)) return SendClientMessage(playerid, WHITE, "Usage: /setlevel [playerid] [level]");
        if(!strlen(tmp2)) return SendClientMessage(playerid, WHITE, "Usage: /setlevel [playerid] [level]");
        if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_BLUE, "Invalid PlayerID !");
        PlayerInfo[id][Level] = level;
}
else
{

}
        return 1;
    }
    
if(strcmp(cmd,"/SetLevelAdmin",true) == 0)
{

//new adminlevelss;



if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,WHITE,".רק אדמין של רקון יכולים להשתמש בפקודות האלה");
//tmp = strtok(cmdtext, idx);
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
new id = ReturnID(tmp);
//        new tmp2[256];
tmp2 = strtok(cmdtext, idx);
if(30 < strlen(tmp2)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
new adlvl = strval(tmp2);
if(!strlen(tmp)) return SendClientMessage(playerid, WHITE, "Usage: /SetLevelAdmin [playerid] [level]");
if(!strlen(tmp2)) return SendClientMessage(playerid, WHITE, "Usage: /SetLevelAdmin [playerid] [level]");
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_BLUE, "Invalid PlayerID !");
PlayerInfo[id][AdminsLevel] = adlvl;
dini_IntSet(GetPlayerFile(id),"Adminl",PlayerInfo[id][AdminsLevel]);
//SendClientMessage(id,WHITE,"/Syshelp :מזל טוב נהיית כרגע קיבלת גישה להפעיל מערכות לעזרה");
		return 1;
    }

    if(strcmp(cmd,"/SetBank",true) == 0)
    {
if (PlayerInfo[playerid][AdminsLevel] >= 10) {

 	    tmp = strtok(cmdtext, idx);
        if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");

	   new id = ReturnID(tmp);

        tmp2 = strtok(cmdtext, idx);
if(30 < strlen(tmp2)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");

		new banke = strval(tmp2);
        if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /SetBank [playerid] [money]");
        if(!strlen(tmp2)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /SetBank [playerid] [money]");
        if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_BLUE, "Invalid PlayerID !");
        PlayerInfo[id][Bank] = banke;
        dini_IntSet(GetPlayerFile(id),"Bank",PlayerInfo[id][AdminsLevel]);

}
else
{

}
        return 1;
    }
    
    
if(strcmp(cmd,"/settag",true) == 0)
{
if (PlayerInfo[playerid][AdminsLevel] >= 10)
{
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
new id = ReturnID(tmp);
new icqnumb[256];
icqnumb = strtok(cmdtext,idx);
if(30 < strlen(icqnumb)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(icqnumb)) return SendClientMessage(playerid,COLOR_WHITE,"/settag [playrid [tag] :שימוש");
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /settag [playerid] [money]");
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_BLUE, "Invalid PlayerID !");

dini_Set(GetPlayerFile(id),"TagChat",icqnumb);
dini_IntSet(GetPlayerFile(id),"TagOnChat",1);

}
return 1;
}

if(strcmp(cmd,"/CarMsg1",true) == 0)
{
if (PlayerInfo[playerid][AdminsLevel] >= 10)
{
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
new id = ReturnID(tmp);
new icqnumb[256];
icqnumb = strtok(cmdtext,idx);
if(30 < strlen(icqnumb)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(icqnumb)) return SendClientMessage(playerid,COLOR_WHITE,"/carmsg1 [playrid [tag] :שימוש");
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /carmsg1 [playerid] [money]");
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_BLUE, "Invalid PlayerID !");
if(pia[id][CarID] == 0) return SendClientMessage(playerid,WHITE,".שחקן זה לא מחזיק בשום רכב");
format(file,sizeof(file),"CarSys/car%d.txt", pia[id][CarID]);
dini_Set(file,"CarName",icqnumb);
strmid(VehicleInfo[pia[id][CarID]][CarName], icqnumb, 0, strlen(icqnumb), 255);

}
return 1;
}


if(strcmp(cmd,"/cgm",true) == 0)
{
if (PlayerInfo[playerid][AdminsLevel] < 3) return 0;
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
new id = ReturnID(tmp);
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_BLUE, "Invalid PlayerID !");
GodModCheack(id);
return 1;
}
if(strcmp(cmd,"/setkills",true) == 0)
{
if (PlayerInfo[playerid][AdminsLevel] < 10) return 0;
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
new id = ReturnID(tmp);
tmp2 = strtok(cmdtext, idx);
if(30 < strlen(tmp2)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
new kills = strval(tmp2);
if(!strlen(tmp)) return SendClientMessage(playerid, WHITE, "Usage: /setkills [playerid] [kills]");
if(!strlen(tmp2)) return SendClientMessage(playerid, WHITE, "Usage: /setkills [playerid] [kills]");
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_BLUE, "Invalid PlayerID !");
PlayerInfo[id][Kills] = kills;

return 1;
}



if(strcmp(cmd,"/triviaMP",true) == 0)
{
if (PlayerInfo[playerid][AdminsLevel] < 6) return 0;

SendClientMessageToAll(COLOR_WHITE, "»» [Trivia | טריוויה] »»");
SendClientMessageToAll(COLOR_PINK, "?שאלה: כמה אנשים יש בשרת עכשיו");
SendClientMessageToAll(COLOR_PINK, ".$מי שיענה נכון, יקבל 2,000");
SendClientMessageToAll(0x0E67AFF, "/Ans [Answer] :על מנת לענות על התשובה");
SendClientMessageToAll(COLOR_WHITE, "__________________________");
AnsTrivia1 = InTheServer;
fnm
MaxAns[i] = 0;
TriviaOn = 1;
}
return 1;
}

if(strcmp(cmd,"/triviahm",true) == 0)
{
if (PlayerInfo[playerid][AdminsLevel] < 6) return 0;
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
new id = ReturnID(tmp);
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, WHITE, "Invalid PlayerID.");
SendClientMessageToAll(COLOR_WHITE, "»» [Trivia | טריוויה] »»");
format(string, sizeof(string),"..?(%d) %s :כמה כסף יש לשחקן",id, GetName(id));
SendClientMessageToAll(COLOR_PINK, string);
SendClientMessageToAll(COLOR_PINK, ".$מי שיענה נכון, יקבל 2,000");
SendClientMessageToAll(0x0E67AFF, "/Ans [Answer] :על מנת לענות על התשובה");
SendClientMessageToAll(COLOR_WHITE, "____________________________");
AnsTrivia1 = GetPlayerMoney(id);
fnm
MaxAns[i] = 0;
TriviaOn = 1;
}
return 1;
}


if(strcmp(cmd,"/triviaLevel",true) == 0)
{
if (PlayerInfo[playerid][AdminsLevel] < 6) return 0;
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
new id = ReturnID(tmp);
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, WHITE, "Invalid PlayerID.");
SendClientMessageToAll(COLOR_WHITE, "»» [Trivia | טריוויה] »»");
format(string, sizeof(string),"..?(%d) %s :מה הרמה של השחקן",id, GetName(id));
SendClientMessageToAll(COLOR_PINK, string);
SendClientMessageToAll(COLOR_PINK, ".$מי שיענה נכון, יקבל 2,000");
SendClientMessageToAll(0x0E67AFF, "/Ans [Answer] :על מנת לענות על התשובה");
SendClientMessageToAll(COLOR_WHITE, "_______________________________");
AnsTrivia1 = PlayerInfo[id][Level];
fnm
MaxAns[i] = 0;
TriviaOn = 1;
}
return 1;
}


if(strcmp(cmd,"/triviabank",true) == 0)
{
if (PlayerInfo[playerid][AdminsLevel] < 6) return 0;
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
new id = ReturnID(tmp);
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, WHITE, "Invalid PlayerID.");

SendClientMessageToAll(COLOR_WHITE, "»» [Trivia | טריוויה] »»");
format(string, sizeof(string),"..?(%d) %s :כמה כסף בבנק יש ל",id, GetName(id));
SendClientMessageToAll(COLOR_PINK, string);
SendClientMessageToAll(COLOR_PINK, ".$מי שיענה נכון, יקבל 2,000");
SendClientMessageToAll(0x0E67AFF, "/Ans [Answer] :על מנת לענות על התשובה");
SendClientMessageToAll(COLOR_WHITE, "____________________________");
fnm
MaxAns[i] = 0;
TriviaOn = 1;
AnsTrivia1 = PlayerInfo[id][Bank];
}

return 1;
}



if(strcmp(cmd,"/triviavip",true) == 0)
{
if (PlayerInfo[playerid][AdminsLevel] < 6) return 0;
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
new id = ReturnID(tmp);
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, WHITE, "Invalid PlayerID.");
SendClientMessageToAll(COLOR_WHITE, "»» [Trivia | טריוויה] »»");
format(string, sizeof(string),"..?(%d) %s :של השחקן (VIP)מה רמת הכבוד",id, GetName(id));
SendClientMessageToAll(COLOR_PINK, string);
SendClientMessageToAll(COLOR_PINK, ".$מי שיענה נכון, יקבל 2,000");
SendClientMessageToAll(0x0E67AFF, "/Ans [Answer] :על מנת לענות על התשובה");
SendClientMessageToAll(COLOR_WHITE, "__________________________________");
AnsTrivia1 = PlayerInfo[id][VIPS];
fnm
MaxAns[i] = 0;
TriviaOn = 1;
}
return 1;
}


if(strcmp(cmd,"/triviaWar",true) == 0)
{
if (PlayerInfo[playerid][AdminsLevel] < 6) return 0;
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
new id = ReturnID(tmp);
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, WHITE, "Invalid PlayerID.");
SendClientMessageToAll(COLOR_WHITE, "»» [Trivia | טריוויה] »»");
format(string, sizeof(string),"..?(%d) %s :כמה פעמים ניצח בוואר השחקן",id, GetName(id));
SendClientMessageToAll(COLOR_PINK, string);
SendClientMessageToAll(COLOR_PINK, ".$מי שיענה נכון, יקבל 2,000");
SendClientMessageToAll(0x0E67AFF, "/Ans [Answer] :על מנת לענות על התשובה");
SendClientMessageToAll(COLOR_WHITE, "______________________________");
AnsTrivia1 = PlayerInfo[id][Wars];
fnm
MaxAns[i] = 0;
TriviaOn = 1;
}
return 1;
}

if(strcmp(cmd,"/triviakills",true) == 0)
{
if (PlayerInfo[playerid][AdminsLevel] < 6) return 0;
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
new id = ReturnID(tmp);
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, WHITE, "Invalid PlayerID.");

SendClientMessageToAll(COLOR_WHITE, "»» [Trivia | טריוויה] »»");
format(string, sizeof(string),"..?(%d) %s :כמה הריגות יש לשחקן",id, GetName(id));
SendClientMessageToAll(COLOR_PINK, string);
SendClientMessageToAll(COLOR_PINK, ".$מי שיענה נכון, יקבל 2,000");
SendClientMessageToAll(0x0E67AFF, "/Ans [Answer] :על מנת לענות על התשובה");
SendClientMessageToAll(COLOR_WHITE, "_________________________________");
fnm
MaxAns[i] = 0;
TriviaOn = 1;
AnsTrivia1 = PlayerInfo[id][Kills];
}
return 1;
}

if(strcmp(cmd,"/triviahelp",true) == 0)
{
SendClientMessage(playerid,COLOR_WHITE, "» » [Trivia Help || עזרה טריוויה] » »");
SendClientMessage(playerid,COLOR_PINK, "/TriviaMP שאלה: כמה אנשים יש בשרת");
SendClientMessage(playerid,COLOR_PINK, "/TriviaKills [playerid] :שאלה: הריגות");
SendClientMessage(playerid,COLOR_PINK, "/TriviaHM [playerid] :שאלה: כמה כסף יש על השחקן");
SendClientMessage(playerid,COLOR_PINK, "/TriviaLevel [playerid] :שאלה: מה הרמה של השחקן");
SendClientMessage(playerid,COLOR_PINK, "/TriviaBank [playerid] :שאלה: מה כסף בבנק יש לשחקן");
SendClientMessage(playerid,COLOR_PINK, "/TriviaViP [playerid] :שאלה: מה הרמת כבוד של שחקן מסויים");
SendClientMessage(playerid,COLOR_PINK, "/TriviaWar [playerid] :שאלה: כמה נצחונות בוואר יש לשחקן מסויים");
SendClientMessage(playerid,COLOR_PINK, "/Triviatos [playerid] :שאלה: כמה פעמים שחקן מסויים היה בשרת");
return 1;
}

if(strcmp(cmd,"/triviatos",true) == 0)
{
if (PlayerInfo[playerid][AdminsLevel] < 6) return 0;
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
new id = ReturnID(tmp);
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, WHITE, "Invalid PlayerID.");

SendClientMessageToAll(COLOR_WHITE, "»» [Trivia | טריוויה] »»");
format(string, sizeof(string),"..?(%d) %s :כמה פעמים היה בשרת השחקן",id, GetName(id));
SendClientMessageToAll(COLOR_PINK, string);
SendClientMessageToAll(COLOR_PINK, ".$מי שיענה נכון, יקבל 2,000");
SendClientMessageToAll(0x0E67AFF, "/Ans [Answer] :על מנת לענות על התשובה");
SendClientMessageToAll(COLOR_WHITE, "__________________________");
fnm
MaxAns[i] = 0;
TriviaOn = 1;
AnsTrivia1 = PlayerInfo[id][TimeOnServer];
}
return 1;
}


if(strcmp(cmd,"/ans",true) == 0)
{
if(TriviaOn == 0) return SendClientMessage(playerid,WHITE,".אין טירוויה פעיל כרגע");
if(MaxAns[playerid] == 6) return SendClientMessage(playerid,WHITE,".ניסית לענות (6) פעמים וזהו המקסימום שאפשר. המתן לטריוויה הבאה");
tmp2 = strtok(cmdtext, idx);
if(30 < strlen(tmp2)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(tmp2)) return SendClientMessage(playerid, WHITE, "Usage: /Ans [Answer]");
if(strval(tmp2) == AnsTrivia1)
{
SendClientMessageToAll(COLOR_WHITE, "»» [Trivia | טריוויה] »»");
format(string, sizeof(string),".ענה על התשוב נכון  ''%s'' :השחקן/ית",GetName(playerid));
SendClientMessageToAll(COLOR_PINK, string);
SendClientMessageToAll(COLOR_PINK, ".$השחקן/ית קיבל סכום של: 2,000");
format(string, sizeof(string),".''%d'' :התשובה הייתה",AnsTrivia1);
SendClientMessageToAll(0x096E7FF, string);
SendClientMessageToAll(COLOR_WHITE, "________________________________");
LACY_GiveMoney(playerid,2000);
AnsTrivia1 = 12312;
TriviaOn = 0;
return 1;
}
SendClientMessage(playerid,WHITE,".טעות, נסה שנית");
MaxAns[playerid] ++;
return 1;
}
    if(strcmp(cmd,"/Warnings",true) == 0)
    {
    
        if (PlayerInfo[playerid][AdminsLevel] >= 10)
{

tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
new id = ReturnID(tmp);
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /Warnings [playerid] [1]");
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_BLUE, "האיידי שהזנת הינו שגוי");
//if(id == playerid) return SendClientMessage(playerid,WHITE,"אתה לא יכול לתת לעצמך אזהרה.");
if(PlayerInfo[id][AdminsLevel] > PlayerInfo[id][AdminsLevel]) return SendClientMessage(playerid,COLOR_WHITE,"אתה לא יכול לתת אזהרה לאדמין ברמה גבוה יותר ממך");
PlayerInfo[id][Warnings] ++;

SendClientMessage(id,WHITE,".ברגע שתגיע ל10 אזהרות תורחק מהשרת");
format(string, sizeof(string), "%d/10 :אזהרות", PlayerInfo[id][Warnings]),SendClientMessage(id,WHITE, string);
format(string, sizeof(string), "%d/10 :אזהרות של השחקן שהבאת לו אזרה ", PlayerInfo[id][Warnings]),SendClientMessage(playerid,WHITE, string);
}
else
{
}
		return 1;
    }
//    }


    if(strcmp(cmd,"/setdeaths",true) == 0)
    {
        if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,WHITE,". אתה לא אדמין");
        tmp = strtok(cmdtext, idx);
        if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");

		new id = ReturnID(tmp);
//        new tmp2[256];
        tmp2 = strtok(cmdtext, idx);
        new deaths = strval(tmp2);
        if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /setdeaths [playerid] [deaths]");
        if(!strlen(tmp2)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /setdeaths [playerid] [deaths]");
        if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_BLUE, "Invalid PlayerID !");
          PlayerInfo[id][Deaths] = deaths;
        return 1;
    }




if(strcmp(cmd, "/cancelpm", true) == 0)
{
if(cancelpm[playerid] ==1) return SendClientMessage(playerid,WHITE,"[BlockPms Error] כבר חסמת את ההודעות פרטיות ! ");
cancelpm[playerid] =1;
SendClientMessage(playerid,WHITE,"[BlockPms] חסמת את ההודעות פרטיות שלך ! כעת לא ניתן לשלוח לך הודעות");
return 1;
}
if(strcmp(cmd, "/backpm", true) == 0)
{
if(cancelpm[playerid] ==0) return SendClientMessage(playerid,WHITE,"[BlockPms Error] /cancelpm ההודעות פרטיות שלך לא חסמות לחסימה");
cancelpm[playerid] =0;
SendClientMessage(playerid,COLOR_PURPLE,"[BlockPms] .החזרת את האפשרות לשלוח לך הודעות פרטיות");
return 1;
}
if(strcmp(cmd, "/exports", true) == 0)
{
if(!CPS_IsPlayerInCheckpoint(playerid,Wang)) return SendClientMessage(playerid,COLOR_WHITE,".אתה חייב להיות בנקודת ציון על מנת להשתמש בפקודה זאת");

SellWangExportVehicle(playerid);
return 1;
}
if(strcmp(cmd, "/buyfast", true) == 0)
{
if(aDoing[playerid] >= 1) return SendClientMessage(playerid,WHITE,".אנא המתן לפני שתעשה פקודה זאת שוב");
aDoing[playerid] ++;
new Roy_Killer[256];
Roy_Killer= strtok(cmdtext, idx);
if(30 < strlen(Roy_Killer)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(Roy_Killer))
{
SendClientMessage(playerid,WHITE,"---- help buy fast in all map (38) מערכת קניית כלים מהירה מכל מקום במפה ---");
SendClientMessage(playerid,COLOR_PINK,"* - /buyfast [action]");
SendClientMessage(playerid,COLOR_PINK,"* - /buyfast armour מגן");
SendClientMessage(playerid,COLOR_PINK,"* - /buyfast hp חיים");
SendClientMessage(playerid,COLOR_PINK,"* - /buyfast sw סט נשקים לא תמידי");
return 1;
}

if(strcmp(Roy_Killer,"armour",true) == 0)
{
RK_SA(playerid,100.0,2000,"[/BuyFast] קנה מגן דרך החנות המהירה מכל מקום במפה",COLOR_ORANGE);
return 1;
}
else if(strcmp(Roy_Killer,"hp",true) == 0)
{
RK_HP(playerid,100.0,1500,"[/BuyFast] קנה מגן דרך החנות המהירה מכל מקום במפה",COLOR_ORANGE);
return 1;
}
else if(strcmp(Roy_Killer,"sw",true) == 0)
{
RK_GiveSetWeapons(playerid,26,200,32,300,23,100,6000);
return 1;
}
return 1;
}


//=[Settings]=========================================================
if(strcmp(cmd, "/setting", true) == 0)
{
new Roy_Killer[256];
Roy_Killer= strtok(cmdtext, idx);
if(30 < strlen(Roy_Killer)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(Roy_Killer))
{

SendClientMessage(playerid,COLOR_WHITE,"Usage: /setting [action]");
SendClientMessage(playerid,COLOR_WHITE,"/setting autologin :להגדיר חיבור אוטומטי לפי אייפי");
SendClientMessage(playerid,COLOR_WHITE,".בקרוב יהיו עוד מספר שינויים");
return 1;
}

if(strcmp(Roy_Killer,"autologin",true) == 0)
{
if(PlayerInfo[playerid][autologin] == 0) {
PlayerInfo[playerid][autologin] =1;

SendClientMessage(playerid,COLOR_BRIGHTRED,"--- .מעכשיו לא תתחבר לפי האייפי שלך ---");
return 1;
}
if(PlayerInfo[playerid][autologin] == 1){
SendClientMessage(playerid, lblue, "--- .מעכשיו תתחבר לפי האייפי שלך ---");
PlayerInfo[playerid][autologin] =0;
return 1;
}
}

return 1;
}
//=[Drifts]=======================================================
if(strcmp(cmd, "/Drift", true) == 0)
{
new Roy_Killer[256];
Roy_Killer= strtok(cmdtext, idx);
if(30 < strlen(Roy_Killer)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(Roy_Killer))
{

SendClientMessage(playerid,COLOR_WHITE,"Usage: /Drift [Action]");
SendClientMessage(playerid,COLOR_WHITE,"/Drift invite [Playerid] - הזמנה לדריפט");
SendClientMessage(playerid,COLOR_WHITE,"/Drift Accept [Playerid invited] - אישור הזמנה לדריפט");
SendClientMessage(playerid,COLOR_WHITE,"/Drift Cancel - ביטול הזמנה לדריפט");
SendClientMessage(playerid,COLOR_WHITE,"/Drift Quit - פרישה מתחרות דריפט");
SendClientMessage(playerid,COLOR_WHITE,"/Drift Help - קבלת עזרה");

return 1;
}
if(strcmp(Roy_Killer,"help",true) == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"Usage: /Drift [Action]");
SendClientMessage(playerid,COLOR_WHITE,"/Drift invite [Playerid] - הזמנה לדריפט");
SendClientMessage(playerid,COLOR_WHITE,"/גrift Accept [Playerid invited] - אישור הזמנה לדריפט");
SendClientMessage(playerid,COLOR_WHITE,"/Drift Cancel - ביטול הזמנה לדריפט");
SendClientMessage(playerid,COLOR_WHITE,"/Drift Quit - פרישה מתחרות דריפט");
return 1;
}

if(strcmp(Roy_Killer,"invite",true) == 0)
{
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
new id = ReturnID(tmp);
if(DriftNoNow == 1) return SendClientMessage(playerid,WHITE,".מירוץ הדריפט תפוס כרגע, אנא המתן שהוא יסתיים");
if(id == playerid) return SendClientMessage(playerid,WHITE,".אתה לא יכול להזמין את עצמך למירוץ דריפט");
if(GetPlayerMoney(playerid) <  3000) return  SendClientMessage(playerid,WHITE,".אין לך מספיק כסף על מנת להשתתף במירוץ דריפט המירוץ בוטל, אתה צריך לפחות 3000 דולר על מנת להשתתף");
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /Drift invite [playerid]");
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, WHITE, ".איידי שגוי");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,WHITE,".עליך להיות ברכב");
driftwinner[playerid] = 3000;
driftwinner[id] = 3000;
DriftInvite[id] = playerid;
IfInvite[playerid] = 1;
IfInvite[id] = 1;
DriftNoNow =1;
PrivateCP[id] = 0;
PrivateCP[playerid] =0;
format(string,sizeof(string),".%dלמירוץ דריפט אישי על סכום של ,%s שלחת הזמנה ל",driftwinner,GetName(id));
SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
format(string,sizeof(string),".%dלמירוץ דריפט אישי על סכום של ,%sקיבלת הזמנה מ",driftwinner,GetName(playerid));
SendClientMessage(id,COLOR_LIGHTGREEN,string);
format(string,sizeof(string),"[ID Invite %d] /Drift Help :לקבלת עזרה בצע/י ",playerid);
SendClientMessage(id,0xF6F658FF,string);
new vehicleid = GetPlayerVehicleID(playerid);
SetVehiclePos(vehicleid,2320.9492,1393.6464,42.5266);
SetVehicleZAngle(vehicleid,359.9852);
SetTimerEx("CancelDrift",30*1000,0,"i",playerid);
TogglePlayerControllable(playerid, 0);
return 1;
}
if(strcmp(Roy_Killer,"cancel",true) == 0)
{
if(indrift[playerid] == 1) return SendClientMessage(playerid,WHITE,"/Drift Quit - .המירוץ כבר החל, אנא פרוש מהמירוץ בעזרה הפקודה");
if(IfInvite[playerid] == 0) return SendClientMessage(playerid,WHITE,".לא הוזמנת לשום מירוץ דריפט");
for(new Drifter=0; Drifter<MAX_PLAYERS; Drifter++)
{
if(IfInvite[Drifter] == 1 && DriftNoNow == 1)
{
driftwinner[Drifter]=0;
DriftInvite[Drifter] =0;
IfInvite[Drifter] =0;
indrift[Drifter] =0;
DriftNoNow = 0;
format(string,sizeof(string),".ביטל את ההזמנה למירוץ הדריפט,%s",GetName(playerid));
SendClientMessage(Drifter,COLOR_LIGHTGREEN,string);
format(string,sizeof(string),".בהצלחה ,%s ביטלת את המירוץ דריפט שלך ושל",GetName(Drifter));
SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
}
}
return 1;
}
if(strcmp(Roy_Killer,"quit",true) == 0)
{
if(indrift[playerid] == 0)return SendClientMessage(playerid,WHITE,".אתה לא נמצא בשום מירוץ");
OutDrift(playerid);
return 1;
}

if(strcmp(Roy_Killer,"accept",true) == 0)
{
tmp2 = strtok(cmdtext, idx);
new id = ReturnID(tmp2);
if(30 < strlen(tmp2)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!IsPlayerConnected(id)) return SendClientMessage(playerid, WHITE, ".איידי שגוי");
if(indrift[playerid] == 1) return SendClientMessage(playerid,WHITE,".כבר אישרת הזמנה או שלא נשלחה שום הזמנה");
if(IfInvite[playerid] == 0)return SendClientMessage(playerid,WHITE,".אתה לא הוזמנת למירוץ דריפט");
if(id != DriftInvite[playerid]) return SendClientMessage(playerid,WHITE, ".שחקן זה לא הזמין אותך לדריפט");
if(!(IsPlayerInAnyVehicle(playerid))) return SendClientMessage(playerid,WHITE,".עליך להיות ברכב");
if(GetPlayerMoney(playerid) <  driftwinner[playerid])
{
SendClientMessage(playerid,WHITE,".אין לך מספיק כסף על מנת להשתתף במירוץ דריפט המירוץ בוטל, אתה צריך לפחות 3000 דולר על מנת להשתתף");
driftwinner[playerid] = 0;
driftwinner[id] = 0;
DriftInvite[id] = 0;
IfInvite[playerid] = 0;
IfInvite[id] = 0;
DriftNoNow =0;
PrivateCP[id] = 0;
PrivateCP[playerid] =0;
SendClientMessage(id,WHITE,".המירוץ בוטל סיבה: חוסר כסף לשחקן המתחרה");
SendClientMessage(id,WHITE,".אין לך מספיק כסף על מנת לאשר את המירוץ דריפט, לכן בוטל");
return 1;
}
new vehicleid = GetPlayerVehicleID(playerid);
SetVehiclePos(vehicleid,2332.2026,1393.6437,42.5268);
SetVehicleZAngle(vehicleid,359.9852);
format(string,sizeof(string),".%s יצאת לדרך למירוץ דריפט יחד עם",GetName(DriftInvite[playerid]));
SendClientMessage(playerid,COLOR_LIGHTGREEN,string);
format(string,sizeof(string),".%s יצאת לדרך למירוץ דריפט יחד עם",GetName(playerid));
SendClientMessage(id,COLOR_LIGHTGREEN,string);
indrift[playerid] =1;
indrift[id] = 1;
LACY_GiveMoney(playerid,-driftwinner[playerid]);
LACY_GiveMoney(id,-driftwinner[id]);
PrivateCP[id] = 1;
PrivateCP[playerid] = 1;
driftwinner[playerid] = 6000;
driftwinner[id] = 6000;
SetPlayerRaceCheckpoint(playerid, 0,2297.5369,1509.4496,42.8203,2290.4094,1500.1200,42.6123, 6);//CP2
SetPlayerRaceCheckpoint(id, 0,2297.5369,1509.4496,42.8203,2290.4094,1500.1200,42.6123, 6);//CP2
TogglePlayerControllable(playerid, 1);
TogglePlayerControllable(id, 1);
DriftNoNow = 1 ;

return 1;
}













return 1;
}
//=[Commands]======================================================
if(strcmp(cmd, "/Commands", true) == 0)
{

new Roy_Killer[256];
Roy_Killer= strtok(cmdtext, idx);
if(30 < strlen(Roy_Killer)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(Roy_Killer))
{
SendClientMessage(playerid, COLOR_WHITE, "TYPE: /Commands [1/2/all]");

return 1;
}


//----------------------
if(strcmp(Roy_Killer,"1",true) == 0)
{

SendClientMessage(playerid,COLOR_WHITE,"----- (1) לוח פקודות מספר ---- ");
SendClientMessage(playerid, COLOR_PINK,"* - /kill - מוות עצמי");
SendClientMessage(playerid, COLOR_PINK,"* - /AFK - כניסה למצב אפק");
SendClientMessage(playerid, COLOR_PINK,"* - /UNAFK - יציאה ממצב אפק");
SendClientMessage(playerid, COLOR_PINK,"* - /nextlevel - הרמה הבאה שלך");
SendClientMessage(playerid, COLOR_PINK,"* - /stats - סטאטס שלך");
SendClientMessage(playerid, COLOR_PINK,"* - /pstats <id/name> - סטאטס של מישהוא אחר");
SendClientMessage(playerid, COLOR_PINK,"* - /ignore - על מנת לחסום שחקן");
SendClientMessage(playerid, COLOR_PINK,"* - /unignore - על מנת להוריד חסימה לשחקן");
SendClientMessage(playerid, COLOR_PINK,"* - /showlevel [level] - על מנת לראות רמה של שחקנים מחוברים");


}
else if(strcmp(Roy_Killer,"all",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---- help Commands (2) - מוד פקודות ---");
SendClientMessage(playerid, COLOR_PINK,".במוד הזה מותקנת מגוון פקודות בוא נראה את חלק הקטן מהפקודות");
SendClientMessage(playerid, 0xF6F658FF,"/maxplayers /showid /bigbang <id/name> (4) /nextlevel");
SendClientMessage(playerid, 0xF6F658FF,"/sp (2) /lp /profile /pprofile <id/name> /stats /pstats <id/name>");
SendClientMessage(playerid, 0xF6F658FF,"/details /pdetails <id/name> /mypet /ppet <id/name> /pay <id/name> [money]");
SendClientMessage(playerid, 0xF6F658FF,"/kill /boome /td /changenick /changepass /saveskin /delskin");
SendClientMessage(playerid, 0xF6F658FF,"/ignore <id/name> /unignore /id(/s) <id/name> /showlevel");
SendClientMessage(playerid, 0xF6F658FF,"/commands [1/2/3/all] /vinfo /afk /unafk /me (2)");
}
else if(strcmp(Roy_Killer,"2",true) == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"----- (2) לוח פקודות מספר ---- ");
SendClientMessage(playerid, COLOR_PINK,"* - /pm [playerid] [message] - לשליחת הודעה פרטית");
SendClientMessage(playerid, COLOR_PINK,"* - /pay [Playerid] [amount] - על מנת להעביר כספים");
SendClientMessage(playerid, COLOR_PINK,"* - /call <id/name> להתקשר לשחקן /hangup לנתק לשחקן");
SendClientMessage(playerid, COLOR_PINK,"* - /maxplayers - גבול כניסת שחקנים");
SendClientMessage(playerid, COLOR_PINK,"* - /showid - מספר האיידי איתו אתה מופיע בשרת");
SendClientMessage(playerid, COLOR_PINK,"* - /sp (2) - שמירת מיקום");
SendClientMessage(playerid, COLOR_PINK,"* - /lp (2) - טעינת מיקום");
SendClientMessage(playerid, COLOR_PINK,"* - /id(/s) <id/name> - לחיפוש שחקן בשרת / כמה שחקנים");

}

return 1;
}


if(strcmp(cmd, "/teleports", true) == 0)
{
new Roy_Killer[256];
Roy_Killer= strtok(cmdtext, idx);
if(30 < strlen(Roy_Killer)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");

if(!strlen(Roy_Killer))
{
SendClientMessage(playerid, COLOR_WHITE, "/teleports [1/2/3/4/5/all]");
return 1;
}

if(strcmp(Roy_Killer,"1",true) == 0)
{
SendClientMessage(playerid,0x0A11FF,"• • • • • • • • • • • • • • • • • • • • • • • • • • • • • •");
SendClientMessage(playerid, COLOR_PINK,"* - /sf :לסאן פירו");
SendClientMessage(playerid, COLOR_PINK,"* - /ls :ללוס סאנטוס");
SendClientMessage(playerid, COLOR_PINK,"* - /lv :ללאס וגאס");
SendClientMessage(playerid, COLOR_PINK,"* - /ap :לשדה תעופה");
SendClientMessage(playerid, COLOR_PINK,"* - /race :לאיזור המירוצים");
SendClientMessage(playerid, COLOR_PINK,"* - /ramp :לאזור הרמפות");
SendClientMessage(playerid, COLOR_PINK,"* - /teleports 2 - .להמשך שיגורים אני בצע/י  ");
SendClientMessage(playerid,0x0A11FF,"• • • • • • • • • • • • • • • • • • • • • • • • • • • • • •");
}
else if(strcmp(Roy_Killer,"2",true) == 0)
{
SendClientMessage(playerid,0x0A11FF,"• • • • • • • • • • • • • • • • • • • • • • • • • • • • • •");
SendClientMessage(playerid, COLOR_PINK,"* - /dj ,/sandkings לאיזור הגי'פים");
SendClientMessage(playerid, COLOR_PINK,"* - /jump  לאיזור הקפיצה");
SendClientMessage(playerid, COLOR_PINK,"* - /army  לבסיסים הבצאים");
SendClientMessage(playerid, COLOR_PINK,"* - /carpark לפארק המכוניות");
SendClientMessage(playerid, COLOR_PINK,"* - /ships לטיולי סירות");
SendClientMessage(playerid, COLOR_PINK,"* - /cycletrip לאיזור הטיולים");
SendClientMessage(playerid, COLOR_PINK,"* - /ShipMoney (3) לספינת פיראטים שונתנת כסף");
SendClientMessage(playerid, COLOR_PINK,"* - /teleports 3 - .להמשך שיגורים אני בצע/י  ");
SendClientMessage(playerid,0x0A11FF,"• • • • • • • • • • • • • • • • • • • • • • • • • • • • • •");
//SendClientMessage(playerid, 0x0A046FF," -- -- --");
}
else if(strcmp(Roy_Killer,"4",true) == 0)
{
//SendClientMessage(playerid, 0x0A046FF,"- - - תפריט שיגורים מס' 4--");
SendClientMessage(playerid,0x0A11FF,"• • • • • • • • • • • • • • • • • • • • • • • • • • • • • •");
SendClientMessage(playerid, COLOR_PINK,"* - /spawn (5) להשתגר למקום באקראי");
SendClientMessage(playerid, COLOR_PINK,"* - /arena לאיזור המלחמות של הקלאנים");
SendClientMessage(playerid, COLOR_PINK,"* - /skydive לצניחה חופשית ");
SendClientMessage(playerid, COLOR_PINK,"* - /drag לתחילת הדראג");
SendClientMessage(playerid, COLOR_PINK,"* - /drifts לאזור הדריפט לחץ");
SendClientMessage(playerid, COLOR_PINK,"* - /grage למוסך");
SendClientMessage(playerid, COLOR_PINK,"* - /teleports 5 - .להמשך שיגורים אני בצע/י  ");
SendClientMessage(playerid,0x0A11FF,"• • • • • • • • • • • • • • • • • • • • • • • • • • • • • •");
//SendClientMessage(playerid, 0x0A046FF," -- -- --");
}
else if(strcmp(Roy_Killer,"3",true) == 0)
{
//SendClientMessage(playerid, 0x0A046FF,"- - - תפריט שיגורים מס' 3 --");
SendClientMessage(playerid,0x0A11FF,"• • • • • • • • • • • • • • • • • • • • • • • • • • • • • •");
SendClientMessage(playerid, COLOR_PINK,"* - /Infernus למירוצים של הרכב המהיר ביותר");
SendClientMessage(playerid, COLOR_PINK,"* - /Busstrip לטיולי אוטובוסים");
SendClientMessage(playerid, COLOR_PINK,"* - /bikestrip לטיוליי אופנועים");
SendClientMessage(playerid, COLOR_PINK,"* - /fight לאיזור הפייטרים");
SendClientMessage(playerid, COLOR_PINK,"* - /alp  להר הגבוהה ביותר");
SendClientMessage(playerid, COLOR_PINK,"* - /snipe  לעמדת הצליפה");
SendClientMessage(playerid, COLOR_PINK,"* - /PePe  לאגם הפיפי");
SendClientMessage(playerid, COLOR_PINK,"* - /derby  למגרש הכדורגל");
SendClientMessage(playerid, COLOR_PINK,"* - /teleports 4 - .להמשך שיגורים אני בצע/י  ");
SendClientMessage(playerid,0x0A11FF,"• • • • • • • • • • • • • • • • • • • • • • • • • • • • • •");
}
else if(strcmp(Roy_Killer,"5",true) == 0)
{


//SendClientMessage(playerid, 0x0A046FF,"- - - תפריט שיגורים מס' 5 --");
SendClientMessage(playerid,0x0A11FF,"• • • • • • • • • • • • • • • • • • • • • • • • • • • • • •");
SendClientMessage(playerid, COLOR_PINK,"* - /kickstart לאיזור סטדיום");
SendClientMessage(playerid, COLOR_PINK,"* - /Lc (1) לאיזור הלייברי");
SendClientMessage(playerid, COLOR_PINK,"* - /Ammu  לחנות נשקים");
SendClientMessage(playerid, COLOR_PINK,"* - /Bank לבנק");
SendClientMessage(playerid, COLOR_PINK,"* - /Parkour (4) לאיזור הקפיצות");
SendClientMessage(playerid, COLOR_PINK,"* - /Bazooka (10)   לאיזור הבזוקות");
SendClientMessage(playerid,0x0A11FF,"• • • • • • • • • • • • • • • • • • • • • • • • • • • • • •");
//SendClientMessage(playerid, COLOR_WHITE,"--- סוף רשימות שיגורים תהנ/י ---");

}


if(strcmp(Roy_Killer,"all",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---- help Teleport (1) - מוד שיגורים ---");
SendClientMessage(playerid, COLOR_PINK,".מוד שיגורים שבוא ניתן לזוז ממקום למקום בעזרת פקודה ולהגיע למקומות הריגה במהירות רבה יותר");
SendClientMessage(playerid, 0xF6F658FF,"/sf /lv /ls /ap /race /ramp");
SendClientMessage(playerid, 0xF6F658FF,"/dj /sandkings /jump /army /carpark /cycletrip");
SendClientMessage(playerid, 0xF6F658FF,"/spawn (5) /arena /skydive /drifts  /grage");
SendClientMessage(playerid, 0xF6F658FF,"/infernus /busstrip /bikestrip /fight /alp /snipe");
SendClientMessage(playerid, 0xF6F658FF,"/pepe /derby /kickstart /lc (1) /bank /parkour (4) /ammu");
SendClientMessage(playerid, 0xF6F658FF,"/water (3) /diving (3) /mp5 (2) /m4 (3) /deagle /dm /bazooka (10)");
SendClientMessage(playerid, 0xF6F658FF,"/teleports [1/2/3/4/5/all] /ship /shipmoney (3) /ships /bazooka (10)");
}
return 1;
}


//===============================MonsterStart CoMonsterNoTeleportionand=================================
if(!strcmp(cmd, "/startMonster", true)) {
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if (PlayerInfo[playerid][AdminsLevel] < 10) return 0;

if(MonsterOn == 1) return SendClientMessage(playerid, WHITE, ".יש כבר גאטר פעיל");
GetPlayerName(playerid, Adminname, sizeof(Adminname));
format(kboobcha, sizeof(kboobcha), "~y~~H~[]/Monster~y~~H~[]");
GameTextForAll(kboobcha,3000,4);
fnm
MonStart[i] =0;
}
SetTimer("MonsterStart",1200,0);
KillTimer(MCheckTimeMonster);
KillTimer(KcheckMonster);
return 1; }
//===============================MJoin CoMonsterNoTeleportionand==================================
if(!strcmp(cmd, "/monster", true))
{
if(MonsterOn == 0) return 0;
if(MoOn == 1) return SendClientMessage(playerid, WHITE, ".הגאטר כבר התחיל, נסה פעם הבאה ");
if(MonsterPlayers == 30) return SendClientMessage(playerid, WHITE, ".כל המקומות נתפסו, נסה פעם באה");
if(iNmOnster[playerid] == 1) return SendClientMessage(playerid, WHITE, ".הצטרפת כבר לגאטר, חכה בסבלנות");
MonsterPlayers ++; iNmOnster[playerid] = 1;
MoneyWinnerMonster +=500;


LACY_GiveMoney(playerid,-500);
format(string,sizeof(string),".%d :הינך משתתף/ת מספר",MonsterPlayers);
SendClientMessage(playerid,0xE21E1EFF,string);
format(string,sizeof(string),".בעת התחלת הקרב, תתחיל להתנגש בחשקנים מתחרים");
SendClientMessage(playerid,0xE21E1EFF,string);
SetPlayerVirtualWorld(playerid,0);
if(MonsterPlayers == 1)
{
format(string,sizeof(string),".הצטרף לפעילות ראשון וקיבל צו'פר של 1,000 דולר %s השחקן",GetName(playerid));
SendClientMessageToAll(0xE21E1EFF,string);
LACY_GiveMoney(playerid,1000);

}

if(AirBreakVar[playerid] == 1)
{
AirBreakVar[playerid] = 0;
SendClientMessage(playerid, WHITE, ".האייר ברייק שלך כובה בהצלחה");
}



return 1;
}
//===============================MonsterWL CoMonsterNoTeleportionand===================================
if(!strcmp(cmd, "/endMonster", true)) {
if (PlayerInfo[playerid][AdminsLevel] < 10) return 0;
if(MonsterOn == 0) return SendClientMessage(playerid, WHITE, ".אין גאטר פעיל");
GetPlayerName(playerid, Adminname, sizeof(Adminname));
MonsterCount = 0;
MonsterWL(2);
return 1; }

//=================================Spec CoMonsterNoTeleportionand=================================
if(!strcmp(cmdtext, "/xspecMonster off", true)) {
if (PlayerInfo[playerid][AdminsLevel] < 10) return 0;
if(IsPlayerInAnyVehicle(playerid))
{
RemovePlayerFromVehicle(playerid);
SetTimerEx("repairbug",5000,0,"i",playerid);
}
if(!IsPlayerInAnyVehicle(playerid))
{
SetTimerEx("repairbug",5000,0,"i",playerid);
}
return 1; }
//===============================MStart Command=================================
if(!strcmp(cmd, "/startkart", true)) {

if (PlayerInfo[playerid][AdminsLevel] < 10) return 0;

tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(KartOn == 1) return SendClientMessage(playerid, WHITE, ".יש כבר קארטינג פעיל ");
format(kboobcha, sizeof(kboobcha), "~y~~H~[]/JoinKart~y~~H~[]");
GameTextForAll(kboobcha,3000,4);
fnm
KartPlayers --; InKart[i] = 0; KK[i] = 0; Fuck[i] = 0;
DestroyVehicle(caridxx[i]);
}
SetTimer("KartStart",3000,0);
return 1; }
//===============================MJoin Command==================================
if(!strcmp(cmd, "/Joinkart", true))
{
if(KartOn == 0) return SendClientMessage(playerid, WHITE, ".אין קארטינג פעיל");
if(KartPlayers == 10) return SendClientMessage(playerid, WHITE, ".כל המקומות נפתסו");
if(KS == 1) return SendClientMessage(playerid, WHITE, ".הקארטינג כבר התחיל, נסה פעם הבאה ");
if(InKart[playerid] == 1) return SendClientMessage(playerid, WHITE, "אתה כבר רשום/ה");
KartPlayers ++; InKart[playerid] = 1;
Kart_Var[playerid] = KartPlayers;
MoneyWinnerKart +=500;

format(string,sizeof(string),".%d :הינך משתתף/ת מספר",KartPlayers);
SendClientMessage(playerid,0xE21E1EFF,string);
format(string,sizeof(string),".בעת התחלת הקרב, תתחיל להפיל שחקנים מהקארט");
SendClientMessage(playerid,0xE21E1EFF,string);
SetPlayerInterior(playerid,0);
SetPlayerVirtualWorld(playerid,0);
if(KartPlayers == 1)
{
format(string,sizeof(string),".הצטרף לפעילות ראשון וקיבל צו'פר של 1,000 דולר %s השחקן",GetName(playerid));
SendClientMessageToAll(0xE21E1EFF,string);
LACY_GiveMoney(playerid,1000);

}
/*
SetVehiclePos(GetPlayerVehicleID(playerid), RandomCityRace[Player_Var[playerid]][0], RandomCityRace[Player_Var[playerid]][1], RandomCityRace[Player_Var[playerid]][2]);
SetVehicleZAngle(GetPlayerVehicleID(playerid), RandomCityRace[Player_Var[playerid]][3]);
*/








if(AirBreakVar[playerid] == 1)
{
AirBreakVar[playerid] = 0;
SendClientMessage(playerid, WHITE, ".האייר ברייק שלך כובה בהצלחה");
}
return 1;
}
//===============================MEnd Command===================================
if(!strcmp(cmd, "/Kartend", true)) {
if(KartOn == 0) return SendClientMessage(playerid, WHITE, ".אין קארטינג פעיל");
//if(KS == 1) return SendClientMessage(playerid, WHITE, ".הקארטינג כבר התחיל ");
if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, WHITE, ".אתה לא אדמין ");
SendClientMessage(playerid, COLOR_WHITE, ".הקארטינג בוטל בהצלחה ");
GetPlayerName(playerid, Adminname, sizeof(Adminname));
KS =0;
Countk = 0;
KartEnd(2);
return 1; }
//=================================Spec Command=================================
if(!strcmp(cmd, "/xspeckart", true)) {
SetPlayerInterior(playerid,0);
SetPlayerPos(playerid,2092.6755,-1976.9171,13.5469);
SetPlayerCameraPos(playerid,2058.9712,-1995.9899,39.3544);
SetPlayerCameraLookAt(playerid,2032.3293,-2013.2899,35.0158);
return 1; }
//=================================Spec Command=================================
if(!strcmp(cmdtext, "/xspeckart off", true)) {
if(IsPlayerInAnyVehicle(playerid))
{
RemovePlayerFromVehicle(playerid);
SetTimerEx("repairbug",5000,0,"i",playerid);
}
if(!IsPlayerInAnyVehicle(playerid))
{
SetTimerEx("repairbug",5000,0,"i",playerid);
}
return 1; }

//===============================KartStart Command===============================
if(!strcmp(cmd, "/stria", true))
{
if (PlayerInfo[playerid][AdminsLevel] >= 10)
{
if(RunSystemon==1) return SendClientMessage(playerid,WHITE,"אתה לא יכול להפעיל טריאטלון שיש כבר אחד מופעל");
StartRun();
RunSystemon =1;
format(kboobcha, sizeof(kboobcha), "~y~~H~[]/Tria~y~~H~[]");
GameTextForAll(kboobcha,3000,4);
SetTimer("UnFreezeTriatlon",60*1000,0);
}
else
{

}
return 1;
}


if(!strcmp(cmd, "/tria", true))
{
if(RunSystemend ==1) return SendClientMessage(playerid,WHITE,".התחרות טריאטלון התחילה");
if(RunSystemon ==0) return SendClientMessage(playerid,WHITE,".אין פעילות ריצה טריאטלון כרגע");
if(RunPlayers ==10) return SendClientMessage(playerid,WHITE,".כל המקומות נתפסו בתחרות טריאטלון נתפסו");
if(Registertrs[playerid] ==1) return SendClientMessage(playerid,WHITE,".אתה כבר רשום לתחרות טריאטלון");
SetPlayerVirtualWorld(playerid,0);
TogglePlayerControllable(playerid,0);
SetPlayerRaceCheckpoint(playerid, 2,835.5297,-1883.1307,12.8672,835.5297,-1883.1307,12.8672, 4);//CP2
CPTriatlon[playerid] =1;
RunPlayers ++;

if(RunPlayers == 1)
{
format(string,sizeof(string),".הצטרף לפעילות ראשון וקיבל צו'פר של 1,000 דולר %s השחקן",GetName(playerid));
SendClientMessageToAll(0xE21E1EFF,string);
LACY_GiveMoney(playerid,1000);

}

format(string,sizeof(string),".%d :הינך משתתף/ת מספר",RunPlayers);
SendClientMessage(playerid,0xE21E1EFF,string);
format(string,sizeof(string),".בעת התחלת הקרב, תתחיל לרוץ כמה שיותר מהר לתוך הצ'ק פוינטים האדומים");
SendClientMessage(playerid,0xE21E1EFF,string);

Registertrs[playerid] =1;
ResetPlayerWeapons(playerid);
if(RunPlayers ==1) return SetPlayerPos(playerid,835.5286,-1825.5933,12.2180);
if(RunPlayers ==2) return SetPlayerPos(playerid,837.4442,-1826.0278,12.2011);
if(RunPlayers ==3) return SetPlayerPos(playerid,840.3302,-1826.2352,12.1772);
if(RunPlayers ==4) return SetPlayerPos(playerid,844.1083,-1826.3751,12.1367);
if(RunPlayers ==5) return SetPlayerPos(playerid,847.1127,-1826.3344,12.1633);
if(RunPlayers ==6) return SetPlayerPos(playerid,850.6811,-1825.7117,12.1968);
if(RunPlayers ==7) return SetPlayerPos(playerid,852.5970,-1826.2627,12.2117);
if(RunPlayers ==8) return SetPlayerPos(playerid,830.1938,-1826.1704,12.2715);
if(RunPlayers ==9) return SetPlayerPos(playerid,827.4509,-1826.6906,12.3083);
if(RunPlayers ==10) return SetPlayerPos(playerid,823.5757,-1826.4065,12.3643);
return 1;
}
if(!strcmp(cmd, "/sMini", true))
{
if (PlayerInfo[playerid][AdminsLevel] >= 10)
{
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
format(kboobcha, sizeof(kboobcha), "~y~~H~[]/Mini~y~~H~[]");
GameTextForAll(kboobcha,3000,4);
SetTimer("WarStartw",3000,0);
}
else
{

}
return 1;
}



if(!strcmp(cmd,"/mini", true))
{
if(WarOnw == 0) return SendClientMessage(playerid, WHITE, "אין כרגע מיניגאן פעיל");
if(WSw == 1) return SendClientMessage(playerid, WHITE, ".ההרשמה כבר נסגרה");
if(WarPlayersw == sizeof(sssaw)) return SendClientMessage(playerid, WHITE, ".כל המקומות נתפסו נסה פעם הבאה");
if(InWarw[playerid] == 1) return SendClientMessage(playerid, WHITE, "אנא המתן לשיגורך לקרב, תודה.");
GetPlayerName(playerid, playernamew, sizeof(playernamew));
WarPlayersw ++; InWarw[playerid] = 1;

GetPlayerName(playerid, playernamew, sizeof(playernamew));
MoneyWinnerMini +=500;
SetPlayerVirtualWorld(playerid,0);
if(WarPlayersw == 1)
{
format(string,sizeof(string),".הצטרף לפעילות ראשון וקיבל צו'פר של 1,000 דולר %s השחקן",GetName(playerid));
SendClientMessageToAll(0xE21E1EFF,string);
LACY_GiveMoney(playerid,1000);
}

format(string,sizeof(string),".%d :הינך משתתף/ת מספר",WarPlayersw);
SendClientMessage(playerid,0xE21E1EFF,string);
format(string,sizeof(string),".בעת התחלת הקרב, תתחיל להרוג את המשתתפים האחרים");
SendClientMessage(playerid,0xE21E1EFF,string);
if(AirBreakVar[playerid] == 1)
{
AirBreakVar[playerid] = 0;
SendClientMessage(playerid, WHITE, ".האייר ברייק שלך כובה בהצלחה");
}
return 1;
}

if(!strcmp(cmd, "/Miniend", true))
{
if(WarOnw== 0) return SendClientMessage(playerid, WHITE, ".אין עכשיו מלחמה פעילה");
if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, WHITE, ".אתה לא אדמין ");
SendClientMessage(playerid, COLOR_WHITE, "המלחמה בוטלה בהצלחה ");
GetPlayerName(playerid, Adminnamew, sizeof(Adminnamew));
Countw = 0;
WarEndw(2);
return 1;
}









if(!strcmp(cmd, "/mypet", true))
{
if(PlayerInfo[playerid][Pets] ==0) return SendClientMessage(playerid,WHITE,"./help pets - שחקן/ית יקרים אין בבעלותכם חיה לעזרה עם המערכת חיות");
format(string, sizeof(string), "--- %s החיות שלך -- ",GetName(playerid)),SendClientMessage(playerid, COLOR_WHITE, string);
if(PlayerInfo[playerid][Tor] ==1) { format(string, sizeof(string), "tor total kills: %d. ",PlayerInfo[playerid][TorKills]),SendClientMessage(playerid, lblue, string),SendClientMessage(playerid,COLOR_GREY,".צב");}
if(PlayerInfo[playerid][Shark] ==1) { format(string, sizeof(string), "shark total kills: %d.",PlayerInfo[playerid][SharkKills]),SendClientMessage(playerid, lblue, string),SendClientMessage(playerid,COLOR_GREY,".כריש");}
if(PlayerInfo[playerid][Dolp] ==1) { format(string, sizeof(string), "dolphin total kills: %d.",PlayerInfo[playerid][DolphinKills]),SendClientMessage(playerid, lblue, string),SendClientMessage(playerid,COLOR_GREY,".דולפין");}

return 1;
}

if(!strcmp(cmd, "/ppet", true))
{
new sid[256], id;
sid = strtok(cmdtext,idx);
id = ReturnID(sid);
if(30 < strlen(sid)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");

if(!IsPlayerConnected(id)) return SendClientMessage(playerid,WHITE,".המספר איידי שהזנת שגוי");
if(PlayerInfo[id][Pets] ==0) return SendClientMessage(playerid,WHITE,".שחקן זה הינו מחזיק בחיות מחמד");
format(string, sizeof(string), "--- %s`s החיות מחמד של -- ",GetName(id)),SendClientMessage(playerid, COLOR_WHITE, string);
if(PlayerInfo[id][Tor] ==1) {
format(string, sizeof(string), "tor total kills: %d.",PlayerInfo[id][TorKills]),SendClientMessage(playerid, lblue, string);
SendClientMessage(playerid,COLOR_GREY,".צב");
}
if(PlayerInfo[id][Shark] ==1) {
format(string, sizeof(string), "shark total kills: %d.",PlayerInfo[id][SharkKills]),SendClientMessage(playerid, lblue, string);
SendClientMessage(playerid,COLOR_GREY,".כריש");
}
if(PlayerInfo[id][Dolp] ==1) {
format(string, sizeof(string), "dolphin total kills: %d.",PlayerInfo[id][DolphinKills]),SendClientMessage(playerid, lblue, string);
SendClientMessage(playerid,COLOR_GREY,".דולפין");
}
return 1;
}

if(strcmp(cmdtext, "/fucku", true) == 0)
{
if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
{
ApplyAnimation(playerid,"ped","fucku",4.1,1,1,1,1,1);
return 1;
}
}
 if(strcmp(cmdtext, "/bomb", true) == 0)
{
if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
{
ApplyAnimation(playerid,"ped","bomber",4.1,0,1,1,1,1);
return 1;
}
}








	if(strcmp(cmd, "/buy", true)==0)
	{
//	   new str[128];

		new propid = IsPlayerNearProperty(playerid);

		if(propid == -1)
		{
			SendClientMessage(playerid, COLOR_WHITE, ".אתה לא נמצא בשום נכס");
			return 1;
		}
		if(PlayerProps[playerid] == MAX_PROPERTIES_PER_PLAYER)
	    {
			format(str, 128, "%d :יש לך יותר מידי נכסים אתה לא יכול לקנות יותר, מספר הנכסים שלך", PlayerProps[playerid]);
			SendClientMessage(playerid,COLOR_WHITE, str);
			return 1;
		}
		if(PropInfo[propid][PropIsBought] == 1)
		{
			new ownerid = GetPlayerID(PropInfo[propid][PropOwner]);
			if(ownerid == playerid)
			{
			    SendClientMessage(playerid, COLOR_WHITE, ".הנכס הזה הוא שלך כבר");
			    return 1;
			}
			else
			{
			    if(PropInfo[propid][PropUnbuyableTime] > 0)
			    {
					format(str, 128, "%s - הנכס הזה נקנה על ידי", PropInfo[propid][PropOwner], PropInfo[propid][PropUnbuyableTime]);
				    SendClientMessage(playerid, COLOR_LIGHTGREEN, str);
   					format(str, 128, ".על מנת לקנות את הנכס מהשחקן %s - השחקן הזה קנה את הנכס לא מזמן אתה צריך לחכות עוד כ", PropInfo[propid][PropUnbuyableTime]);
				    SendClientMessage(playerid, COLOR_LIGHTGREEN, str);
				    return 1;
				}
			}
		}
		if(GetPlayerMoney(playerid) < PropInfo[propid][PropValue])
		{
		    format(str, 128, ".$%d :אין לך מספיק כסף לקנות נכס זה, אתה צריך כ", PropInfo[propid][PropValue]);
		    SendClientMessage(playerid, COLOR_WHITE, str);
		    return 1;
		}
		new pName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, pName, sizeof(pName));
		if(PropInfo[propid][PropIsBought] && PropInfo[propid][PropUnbuyableTime] == 0)
		{
			new ownerid = GetPlayerID(PropInfo[propid][PropOwner]);
		    format(str, 128, "%s - השחקן",  pName);
			SendClientMessage(ownerid, COLOR_LIGHTGREEN, str);
		    format(str, 128, "%s - קנה ממך את הנכס שלך ה",  PropInfo[propid][PropName]);
			SendClientMessage(ownerid, COLOR_LIGHTGREEN, str);
            format(str, 128, "%d$ - קיבלת פיצוי של כ",   (PropInfo[propid][PropValue]/2));
			SendClientMessage(ownerid, COLOR_LIGHTGREEN, str);
			LACY_GiveMoney(ownerid, (PropInfo[propid][PropValue]/2));
			PlayerProps[ownerid]--;
		}
		PropInfo[propid][PropOwner] = pName;
		PropInfo[propid][PropIsBought] = 1;
		PropInfo[propid][PropUnbuyableTime] = UNBUYABLETIME;
		EarningsForPlayer[playerid] += PropInfo[propid][PropEarning];
        LACY_GiveMoney(playerid, (0-PropInfo[propid][PropValue]));
		format(str, 128, "$%d :מעכשיו תרוויח כל כמה זמן כ \"%s\" :קנית את הנכס", PropInfo[propid][PropValue], PropInfo[propid][PropName]);
        SendClientMessage(playerid, COLOR_WHITE, str);
        format(str, 128, "%s :כנס את הנכס %s השחקן",  PropInfo[propid][PropName],pName);
        SendClientMessageToAllEx(playerid, COLOR_WHITE, str);
        PlayerProps[playerid]++;
		return 1;
	}
    //================================================================================================================================
	//================================================================================================================================
	//================================================================================================================================
	if(strcmp(cmd, "/sell", true) == 0)
	{
//	    new str[128];

		new propid = IsPlayerNearProperty(playerid);
		if(propid == -1)
		{
			SendClientMessage(playerid, COLOR_WHITE, ".אתה לא נמצא בשום נכס");
			return 1;
		}
		if(PropInfo[propid][PropIsBought] == 1)
		{
			new ownerid = GetPlayerID(PropInfo[propid][PropOwner]);
			if(ownerid != playerid)
			{
			    SendClientMessage(playerid, COLOR_WHITE, ".אין לך שום נכס");
			    return 1;
			}
		}
		new pName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, pName, sizeof(pName));
		format(PropInfo[propid][PropOwner], MAX_PLAYER_NAME, "Nobody");
		PropInfo[propid][PropIsBought] = 0;
		PropInfo[propid][PropUnbuyableTime] = 0;
		LACY_GiveMoney(playerid, (PropInfo[propid][PropValue]/2));
		format(str, 128, "%d$ :הכסף שתקבל כל פעם מהנכס שלך הוא \"%s\" :אתה קנית את הנכס", PropInfo[propid][PropValue]/2,PropInfo[propid][PropName]);
        SendClientMessage(playerid, COLOR_WHITE, str);
        format(str, 128, "\"%s\" מחר את הנכס שלו ה %s השחקן", PropInfo[propid][PropName],pName);
        SendClientMessageToAllEx(playerid, COLOR_WHITE, str);
        PlayerProps[playerid]--;
        EarningsForPlayer[playerid] -= PropInfo[propid][PropEarning];
		return 1;
	}
    //================================================================================================================================
	//================================================================================================================================
	//================================================================================================================================

    if(strcmp(cmd, "/Props", true) == 0)
	{

	new sid[256], id;
sid = strtok(cmdtext,idx);
id = ReturnID(sid);

if(30 < strlen(sid)) return SendClientMessage(playerid,COLOR_WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(sid)) return SendClientMessage(playerid,COLOR_WHITE,"Usage: /Props [id]");
if(!IsPlayerConnected(id)) return SendClientMessage(playerid,COLOR_WHITE,".איידי שגוי");


	    new ownerid;
	    if(PlayerProps[id] == 0)
	    {
	        SendClientMessage(playerid, COLOR_WHITE, ".אין לך שום נכסים");
	        return 1;
		}
		format(str, 128, "(Props: %d | Name: %s | ID: %d) :רשימת הנכסים של", PlayerProps[id],GetName(id),id);
	    SendClientMessage(id, COLOR_WHITE, str);
		for(new propid; propid < PropertiesAmount; propid++)
		{
			if(PropInfo[propid][PropIsBought] == 1)
			{
                ownerid = GetPlayerID(PropInfo[propid][PropOwner]);
				if(ownerid == id)
				{
 					format(str, 128, ".%d :אתה מרוויח מהנכס שלך כ \"%s\" :שם הנכס || %d :הנכס שלך שווה כ", PropInfo[propid][PropEarning], PropInfo[propid][PropName], PropInfo[propid][PropValue]);
 					SendClientMessage(playerid, 0xF06E8DFF, str);
				}
			}
		}
		return 1;
	}







// Wank In
if (strcmp("/wankout", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "PAULNMAC", "wank_out", 4.0, 0, 0, 0, 0, 0); // Wank Out

return 1;
}

// Arrested
if (strcmp("/arrested", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "POLICE", "crm_drgbst_01", 4.0, 0, 0, 0, 0, 0); // Arrested

return 1;
}

// Injury
if (strcmp("/injuWHITE", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "SWEET", "Sweet_injuWHITEloop", 4.0, 0, 0, 0, 0, 0); // InjuWHITE

return 1;
}

// Ass Slapped
if (strcmp("/slapped", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "SWEET", "ho_ass_slapped", 4.0, 0, 0, 0, 0, 0); // Ass Slapped

return 1;
}

// Female Smoking
if (strcmp("/fsmoking", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "SMOKING", "F_smklean_loop", 4.0, 0, 0, 0, 0, 0); // Female Smoking

return 1;
}

// Cop Look
if (strcmp("/coplook", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 0, 0, 0, 0); // Cop Looking

return 1;
}

// Lay Down
if (strcmp("/ay", cmdtext, true, 6) == 0)
{
ApplyAnimation(playerid,"BEACH", "bather", 4.0, 0, 0, 0, 0, 0); // Lay down

return 1;
}

// Take Cover
if (strcmp("/yc", cmdtext, true, 3) == 0)
{
ApplyAnimation(playerid, "ped", "cower", 3.0, 0, 0, 0, 0, 0); // Taking Cover

return 1;
}

// Vomit
if (strcmp("/vomit", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 3.0, 0, 0, 0, 0, 0); // Vomit BAH!

return 1;
}

// Eat Burger
if (strcmp("/eat", cmdtext, true) == 0)
{
ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.00, 0, 0, 0, 0, 0); // Eat Burger

return 1;}

// Wave
if (strcmp("/wave", cmdtext, true) == 0) {
ApplyAnimation(playerid, "KISSING", "BD_GF_Wave", 3.0, 0, 0, 0, 0, 0); // Wave

return 1;}

// Slap Ass
if (strcmp("/slapass", cmdtext, true) == 0) {
ApplyAnimation(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0); // Ass Slapping

return 1;}

// Death Crawling
if (strcmp("/death", cmdtext, true) == 0) {
ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.0, 0, 0, 0, 0, 0); // Dead Crawling

return 1;}

// Dealer
if (strcmp("/deal", cmdtext, true) == 0) {
ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0); // Deal Drugs

return 1;}

// Kiss
if (strcmp("/kiss", cmdtext, true, 5) == 0) {
ApplyAnimation(playerid, "KISSING", "Playa_Kiss_02", 3.0, 0, 0, 0, 0, 0); // Kiss

return 1;}

// Crack Dieing
if (strcmp("/crack", cmdtext, true, 6) == 0) {
ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 0, 0, 0, 0, 0); // Dieing of Crack

return 1;}

// Piss
if (strcmp("/piss", cmdtext, true, 8) == 0) {
ApplyAnimation(playerid, "PAULNMAC", "Piss_in", 3.0, 0, 0, 0, 0, 0); // Pissing

return 1;}



    if (strcmp("/smoke", cmdtext, true, 4) == 0) {
    
	ApplyAnimation(playerid,"SMOKING", "M_smklean_loop", 4.0, 0, 0, 0, 0, 0);
    return 1;
    }

// Sit
if (strcmp("/sit", cmdtext, true, 4) == 0) {
ApplyAnimation(playerid,"BEACH", "ParkSit_M_loop", 4.0, 0, 0, 0, 0, 0); // Sit

return 1;}



// Strip-Tease
if (strcmp("/strip", cmdtext, true, 6) == 0){
switch (cmdtext[7]){
case 'a', 'A':{ ApplyAnimation( playerid,"STRIP", "strip_A", 4.1, 0, 1, 1, 1, 1 ); return 1; } // Strip
case 'b', 'B':{ ApplyAnimation( playerid,"STRIP", "strip_B", 4.1, 0, 1, 1, 1, 1 ); return 1; } // Strip
case 'c', 'C':{ ApplyAnimation( playerid,"STRIP", "strip_C", 4.1, 0, 1, 1, 1, 1 ); return 1; } // Strip
case 'd', 'D':{ ApplyAnimation( playerid,"STRIP", "strip_D", 4.1, 0, 1, 1, 1, 1 ); return 1; } // Strip
case 'e', 'E':{ ApplyAnimation( playerid,"STRIP", "strip_E", 4.1, 0, 1, 1, 1, 1 ); return 1; } // Strip
case 'f', 'F':{ ApplyAnimation( playerid,"STRIP", "strip_F", 4.1, 0, 1, 1, 1, 1 ); return 1; } // Strip
case 'g', 'G':{ ApplyAnimation( playerid,"STRIP", "strip_G", 4.1, 0, 1, 1, 1, 1 ); return 1; } // Strip
}SendClientMessage(playerid, 0xF6F658FF, "אתה עכשיו עושה משהוא מגניב");

return 1;}

// Idle Chat
if(strcmp(cmd, "/chat", true) == 0){
if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT){
ApplyAnimation(playerid,"PED","IDLE_CHAT",4.1,0,1,1,1,1);

//SendClientMessage(playerid, 0xFF0000FF, "אתה מדבר עכשיו"); // Chat

return 1;}}












//-----Animaped


if(strcmp(cmd, "/dance", true) == 0) {
if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(tmp)) {
SendClientMessage(playerid,0xFF0000FF,"Usage: /dance [1-3]");
return 1;
}
animationplayed = strval(tmp);
if(animationplayed < 1 || animationplayed > 3) {
SendClientMessage(playerid,0xFF0000FF,"Usage: /dance [1-3]");
return 1;
}
if(animationplayed == 1) {
SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
} else if(animationplayed == 2) {
SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
} else if(animationplayed == 3) {
SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
}
return 1;
}
}


//end


if(strcmp(cmd,"/id",true) == 0 || strcmp(cmd, "/s", true) == 0)
{
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(tmp))
{
SendClientMessage(playerid,COLOR_WHITE,"/id(/s). [nick player/or half nick] :לחיפוש כמה שמות ביחד");
format(string,256,"Your ID: %d.",playerid);
SendClientMessage(playerid,0x16EB43FF,string);
return 1;
}
format(string,sizeof(string)," \"%s\" - ,החיפוש נמצא",tmp);
SendClientMessage(playerid,red,string);
new found=0;
fnm
if(IsPlayerConnected(i))
{
new foundname[MAX_PLAYER_NAME];
GetPlayerName(i, foundname, MAX_PLAYER_NAME);
new namelen = strlen(foundname);
new bool:searched=false;
for(new pos=0; pos <= namelen; pos++)
{
if(searched != true)
{
if(strfind(foundname,tmp,true) == pos)
{
found++;
format(string,sizeof(string),"%d. \"%s\" (ID is: %d)",found,foundname,i);
SendClientMessage(playerid, 0x16EB43FF ,string);
searched = true;
}
}
}
}
}
return 1;
}


	if(strcmp(cmd, "/call", true) == 0)
	{
	if(InCall[playerid] ==1) return SendClientMessage(playerid,COLOR_WHITE,"ץאנא המתן מספר שניות לחיוג חוזר");
	    if(IsPlayerConnected(playerid))
		{
		if(InCall[playerid]==1)return SendClientMessage(playerid,WHITE,".אנא המתן דקה לצלצל שוב");
		if(CellState[playerid]==ESTA_LLAMANDO)return SendClientMessage(playerid,0x0F482FF, ".[/H,Hangup] אתה עדיין מחייג בשביל לנתק");
		if(CellState[playerid]==LO_ESTAN_LLAMANDO)return SendClientMessage(playerid,0x0F482FF, ".[/Hangup]  ובשביל לנתק [/Answer] חייגת שיחה בשביל לענות");
	
		    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
			tmp = strtok(cmdtext, idx);
            if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");

			if	(!strlen(tmp))
			{
				SendClientMessage(playerid,0x0F482FF, "USE: /call [playerid]");
				SetTimerEx("ColgarTelefonino",1200,0,"d",playerid);
				return 1;
			}
			new numTel = strval(tmp);

			if	(!IsPlayerConnected(numTel))
			    {
	    			SendClientMessage(playerid,WHITE, ".שחקן מנותק");
	      			SetTimerEx("ColgarTelefonino",1200,0,"d",playerid);
	      			return 1;

			    }
if(Ignore[numTel][playerid] == 1)return SendClientMessage(playerid,WHITE,"[IgnoreCall] !השחקן אליו אתה מנסה לצלצל אליו חסם אותך"),0;

			if (CellState[numTel]==LIBRE)
			{
			    CellState[numTel] = LO_ESTAN_LLAMANDO;
			    CellState[playerid] = ESTA_LLAMANDO;
			    AuxiliarTel[playerid] = numTel;
			    AuxiliarTel[numTel] = playerid;
				TimerLLamando[playerid]=SetTimerEx("Llamando",10*1000,true,"ii",playerid,numTel);
				TimerLLamando[numTel]=TimerLLamando[playerid];

				format(string, sizeof(string),"..%s אתה מצלצל אל",GetName(numTel));
				SendClientMessage(playerid,COLOR_LIGHTGREEN, string);
               InCall[playerid]=1;
				return 1;
			}
			else
			{
			//	SendClientMessage(playerid,0x0F482FF, "Busy tone...");
				SetTimerEx("ColgarTelefonino",1200,0,"d",playerid);
				return 1;
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/answer", true) == 0 || strcmp(cmd, "/a", true) == 0)
	{
        if(IsPlayerConnected(playerid))
		{
			if(CellState[playerid] != LO_ESTAN_LLAMANDO)
			{
				SendClientMessage(playerid, WHITE, "..אפחד לא מתקשר אליך");
				return 1;
			}
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
			SendClientMessage(playerid,COLOR_LIGHTGREEN, ".`^`ענית לשיחה בהצלחה, כעת תדבר לפני כל הודעה עם ה");

	CellTime[AuxiliarTel[playerid]]=0;
	TimerCaidaFicha[AuxiliarTel[playerid]]=SetTimerEx("CaidaDeFicha",1000,true,"i",AuxiliarTel[playerid]);
	CellState[playerid]=ESTA_HABLANDO;
	CellState[AuxiliarTel[playerid]]=ESTA_HABLANDO;
	return 1;
	}
	return 1;
	}
	if(strcmp(cmd, "/hangup", true) == 0 || strcmp(cmd, "/h", true) == 0)
	{
		if  (CellState[playerid] == LIBRE)
		{
		    
		    return 1;
		}
		if  (CellState[playerid] == ESTA_LLAMANDO)
		{
		    SendClientMessage(playerid,WHITE,".ניתקת את הפלאפון בהצלחה");
			SendClientMessage(AuxiliarTel[playerid],WHITE,".הטלפון הפסיק לצלצל, תודה");
			SetTimerEx("ColgarTelefonino",500,0,"d",playerid);
	    	KillTimer(TimerLLamando[playerid]);
	    	TimerLLamando[playerid]=DEAD_TIMER_ID;
	    	TimerLLamando[AuxiliarTel[playerid]]=DEAD_TIMER_ID;
	    	CellState[playerid]=LIBRE;
	    	CellState[AuxiliarTel[playerid]]=LIBRE;
		    return 1;
		}
		if  (CellState[playerid] == LO_ESTAN_LLAMANDO)
		{
		    SendClientMessage(playerid,WHITE,".השיחה נותקה");
		    SendClientMessage(AuxiliarTel[playerid],WHITE,".השיחה נותקה");

			SetTimerEx("ColgarTelefonino",500,0,"d",AuxiliarTel[playerid]);
	    	KillTimer(TimerLLamando[playerid]);
	    	TimerLLamando[playerid]=DEAD_TIMER_ID;
	    	TimerLLamando[AuxiliarTel[playerid]]=DEAD_TIMER_ID;
	    	CellState[playerid]=LIBRE;
	    	CellState[AuxiliarTel[playerid]]=LIBRE;
		    return 1;
		}
		if  (CellState[playerid] == ESTA_HABLANDO)
		{
		    msgInfo(playerid, "");
			msgInfo(AuxiliarTel[playerid], ".");
			SetTimerEx("ColgarTelefonino",500,0,"d",playerid);
			SetTimerEx("ColgarTelefonino",500,0,"d",AuxiliarTel[playerid]);
   			if  (TimerCaidaFicha[playerid]!=DEAD_TIMER_ID)
	    	{
	    		KillTimer(TimerCaidaFicha[playerid]);
	    		TimerCaidaFicha[playerid]=DEAD_TIMER_ID;
	    		new msg[255];
	    		format(msg,sizeof(msg),"ץ$%d מחיר השיחה",CellTime[playerid]*PRECIO_FICHA);
	    		LACY_GiveMoney(playerid,CellTime[playerid]*PRECIO_FICHA*-1);
				SendClientMessage(playerid,WHITE,msg);
	    		ActualizarMemoriaSalida(playerid,AuxiliarTel[playerid]);
	    		ActualizarMemoriaEntrada(AuxiliarTel[playerid],playerid);
			}
			if  (TimerCaidaFicha[AuxiliarTel[playerid]]!=DEAD_TIMER_ID)
	    	{
	    		KillTimer(TimerCaidaFicha[AuxiliarTel[playerid]]);
	    		TimerCaidaFicha[AuxiliarTel[playerid]]=DEAD_TIMER_ID;
	    		new msg[255];
	    		format(msg,sizeof(msg),".$%d השחקן שהתשקר אליך שילם" ,CellTime[AuxiliarTel[playerid]]*PRECIO_FICHA);
	    		LACY_GiveMoney(playerid,CellTime[AuxiliarTel[playerid]]*PRECIO_FICHA*-1);
	    		SendClientMessage(AuxiliarTel[playerid],WHITE,msg);
	    		ActualizarMemoriaSalida(AuxiliarTel[playerid],playerid);
	    		ActualizarMemoriaEntrada(playerid,AuxiliarTel[playerid]);
			}
			CellState[playerid]=LIBRE;
	    	CellState[AuxiliarTel[playerid]]=LIBRE;
}
return 1;
}

if(strcmp(cmdtext, "/nextlevel", true)==0)
{
format(string, sizeof(string), ".%d :הריגות שנשראו לך לעלות לרמה הבאה",PlayerInfo[playerid][aKillsnl]),SendClientMessage(playerid, 0xF6F658FF, string);
format(string, sizeof(string), ".%d :רמה הבאה",PlayerInfo[playerid][aLevelnl]),SendClientMessage(playerid, 0xF6F658FF, string);
return 1;
}
#define STRING 256
if(strcmp(cmd, "/me", true) == 0)
{
if (PlayerInfo[playerid][Level] < 2) return Messagelevel (playerid, 2);
if(GetPlayerMoney(playerid) < 10000) return SendClientMessage(playerid,WHITE,"* .אתה צריך כ10,000 /me [action] - אין לך מספיק כסף על מנת לבצע את הפקודה");
if(antispam[playerid] >0) return SendClientMessage(playerid,WHITE,"[AntiSpam]  !באפשרותך לשלוח הודעה אחת כל 2 שניות"),0;
new player[MAX_PLAYER_NAME];
GetPlayerName(playerid, player, sizeof(player));
new length = strlen(cmdtext);
while ((idx < length) && (cmdtext[idx] <= ' '))
{
idx++;
}
new offset = idx;
new result[STRING];
while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
{
result[idx - offset] = cmdtext[idx];
idx++;
}
result[idx - offset] = EOS;
if(!strlen(result))
{
SendClientMessage(playerid, ORANGE, "Usage: /me [action]");
return 1;
}
format(string, sizeof(string), "* %s %s ", player, result);
SendClientMessageToAll(COLOR_PINK, string);
LACY_GiveMoney(playerid,-10000);
antispam[playerid]++;
return 1;
}

if(strcmp(cmd, "/saynowbybar", true) == 0)
{
if(IsPlayerAdmin(playerid)) {
if(antispam[playerid] >0) return SendClientMessage(playerid,WHITE,"[AntiSpam]  !באפשרותך לשלוח הודעה אחת כל 2 שניות"),0;
new length = strlen(cmdtext);
while ((idx < length) && (cmdtext[idx] <= ' '))
{
idx++;
}
new offset = idx;
new result[STRING];
while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
{
result[idx - offset] = cmdtext[idx];
idx++;
}
result[idx - offset] = EOS;
if(!strlen(result))
{
SendClientMessage(playerid, COLOR_WHITE, "Usage: /saynowbybar [Text]");
return 1;
}
format(string, sizeof(string), "%s", result);
SendClientMessageToAll(COLOR_WHITE, string);
antispam[playerid]++;
return 1;
}
}

//=[SaveSkin]=====
if(!strcmp(cmd,"/saveskin",true))
{
PlayerInfo[playerid][SkinSavedId] = GetPlayerSkin(playerid);
SendClientMessage(playerid,COLOR_LIGHTGREEN," הסקין שלך נשמר בהצלחה");
PlayerInfo[playerid][SkinSaved] = 1, PlayerInfo[playerid][SaveSkin] = 1;
dini_IntSet(GetPlayerFile(playerid),"SkinSavedId",PlayerInfo[playerid][SkinSavedId]);
dini_IntSet(GetPlayerFile(playerid),"SaveSkin",PlayerInfo[playerid][SaveSkin]);
dini_IntSet(GetPlayerFile(playerid),"SkinSaved",PlayerInfo[playerid][SkinSaved]);
return 1;
}
//=[DelSkin]====
if(!strcmp(cmd,"/delskin",true))
{
if(!PlayerInfo[playerid][SkinSaved]) return SendClientMessage(playerid,WHITE,".שים לב, אין לך אף סקין שמור");
PlayerInfo[playerid][SkinSaved] = 0;
dini_IntSet(GetPlayerFile(playerid),"SkinSaved",0);
PlayerInfo[playerid][SaveSkin] = 0;
dini_IntSet(GetPlayerFile(playerid),"SaveSkin",0);
SendClientMessage(playerid,COLOR_LIGHTGREEN," הסקין שלך נמחק בהצלחה ");
return 1;
}






if(strcmp(cmd, "/pay", true) == 0) {
//
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(tmp)) {
SendClientMessage(playerid, 0xF6F658FF, "/pay [playerid] [amount]");

return 1;}
if(PlayerInfo[playerid][Level] < 1) return Messagelevel(playerid,1);
giveplayerid = strval(tmp);
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(tmp)) {
SendClientMessage(playerid, 0xF6F658FF, "/pay [playerid] [amount]");

return 1;}

moneys = strval(tmp);
//printf("givecash_command: %d %d",giveplayerid,moneys);
if (IsPlayerConnected(giveplayerid)) {
GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
GetPlayerName(playerid, sendername, sizeof(sendername));
playermoney = GetPlayerMoney(playerid);
if (moneys > 0 && playermoney >= moneys) {
LACY_GiveMoney(playerid, (0 - moneys));
LACY_GiveMoney(giveplayerid, moneys);
format(string, sizeof(string), ".%s (id: %d) :לשחקן $%d של כ ", giveplayer,giveplayerid, moneys);
SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
format(string, sizeof(string), ". $%d מאת %s (id: %d) קיבלת מ", moneys, sendername, playerid);
SendClientMessage(giveplayerid, COLOR_LIGHTGREEN, string);
printf("%s(playerid:%d) has transfeWHITE %d to %s(playerid:%d)",sendername, playerid, moneys, giveplayer, giveplayerid);}
else {
SendClientMessage(playerid, COLOR_WHITE, "סכום שגוי");
}}
else {
format(string, sizeof(string), ";] %d", giveplayerid);
SendClientMessage(playerid, COLOR_WHITE, string);}
return 1;}

if(strcmp(cmd, "/td", true) == 0){
if(IsPlayerConnected(playerid)){
new timetext[64];
new year,mnth,day;
getdate(year,mnth,day);
if(mnth == 1){
timetext = ".01";}
else if(mnth == 2){
timetext = ".02.07";}
else if(mnth == 3)
{timetext = ".03.07";
}else if(mnth == 4)
{timetext = ".04.07";
}else if(mnth == 5)
{timetext = ".05.07";
}else if(mnth == 6)
{timetext = ".06.07";
}else if(mnth == 7)
{timetext = ".07.07";
}else if(mnth == 8)
{timetext = ".08.07";
}else if(mnth == 9)
{timetext = ".09.07";
}else if(mnth == 10)
{timetext = ".10.07";}
else if(mnth == 11){
timetext = ".11.07";}
else if(mnth == 12)
{timetext = ".12.07";}
new hour,minuite,second;
gettime(hour,minuite,second);
if(hour < 10 && hour > 24) { format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~y~Date~w~:%d%s ~n~~y~Time~w~:0%d:%d:%d", day, timetext, hour, minuite,second); } else {format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~y~Date~w~:%d%s ~n~~y~Time~w~:%d:%d:%d", day, timetext, hour, minuite,second); }
if(minuite < 10) { format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~y~Date~w~:%d%s ~n~~y~Time~w~:%d:0%d:%d", day, timetext, hour, minuite,second); } else {format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~y~Date~w~:%d%s ~n~~y~Time~w~:%d:%d:%d", day, timetext, hour, minuite,second); }
if(second < 10) { format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~y~Date~w~:%d%s ~n~~y~Time~w~:%d:%d:0%d", day, timetext, hour, minuite,second); } else { format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~y~Date~w~:%d%s ~n~~y~Time~w~:%d:%d:%d", day, timetext, hour, minuite,second); }
GameTextForPlayer(playerid, string, 6000, 3);}
return 1;}








//
/*
if(strcmp(cmdtext, "/sail", true) == 0)
 {
if(Sailing[playerid] == true) return SendClientMessage(playerid, WHITE, "אתה חייב להיות בתא של הספינה");
if(ShipTaken == 1) return SendClientMessage(playerid, WHITE, "אתה חייב להיות על הספינה.");
if(!PlayerToPoint(3, playerid, 3324.2947, -1330.1631, 127.9517)) return SendClientMessage(playerid, WHITE, "אתה חייב להיות בפנים בתוך הספינה");
Sailing[playerid] = true;
ShipTaken = 1;
SailBoat[playerid] = CreateVehicle(454, 2613.5906, -2607.2773, 0.2058, 266.4303, 0, 0, 15000);
LinkVehicleToInterior(SailBoat[playerid], 10);
PutPlayerInVehicle(playerid, SailBoat[playerid], 0);
AttachDynamicObjectToPlayer(ship1, playerid, 0.0, 150.0, -2.0, 180.0, 180.0, 270.0);
AttachDynamicObjectToPlayer(ship2, playerid, 0.0, 75.0, 27.0, 180.0, 180.0, 270.0);
AttachDynamicObjectToPlayer(ship3, playerid, 0.0, 148.0, 8.0, 180.0, 180.0, 270.0);
return 1;
}
if(strcmp(cmdtext, "/exitship", true) == 0) return SetPlayerPos(playerid, 2694.5012, -2606.9812, 14.8974);
if(strcmp(cmdtext, "/pier", true) == 0) {

        SetPlayerPos(playerid, 2798.3655,-2554.6558,13.6327);
        SendClientMessage(playerid, COLOR_WHITE, "--- ברוכים הבאים לספינת התענוגות --");
        SendClientMessage(playerid, lblue, ".אנא עלה על האוניה דבר ראשון");
        SendClientMessage(playerid, lblue, ".ואחרי זה המשך ישר עד למציאת הכניסה בעזרת הפיקאפ הלבן");
        SendClientMessage(playerid, lblue, "/sail :כדאי לנהוג בספינה בצע ");
        SendClientMessage(playerid, lblue, "/exitship .כדאי לעזוב את הספינה");
        SendClientMessage(playerid, 0xF6F658FF, "בעת תוכך בספינה הגדולה תוכל לנהוג בא בעזרת המקשים");
        SendClientMessage(playerid, COLOR_WHITE, "----------");
return 1;
}
*/





if(!strcmp(cmd,"/Boome",true) || !strcmp(cmd,"/bm",true))
{
if (PlayerInfo[playerid][Level] < 3) return Messagelevel (playerid, 3);
if(GetPlayerInterior(playerid) == 1 || GetPlayerInterior(playerid) == 6 || GetPlayerInterior(playerid) == 10) return SendClientMessage(playerid,0xFF0000AA,".אתה לא יכול לתקוף שחקן שהוא נמצא בתוך אינטרור");
if(ClickedBm[playerid] == 10) return SendClientMessage(playerid,WHITE, ".אתה לא יכול לפוצץ אותך יותר מ10 פעמים");
ClickedBm[playerid]  ++;
new Float:pos[3];
GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
CreateExplosion(pos[0],pos[1],pos[2],6,10);
return 1;
}
/*
SendClientMessage(playerid,COLOR_WHITE," רמה ראשונה 150 הריגות");
SendClientMessage(playerid,COLOR_WHITE," רמה שניה 300 הריגות");
SendClientMessage(playerid,COLOR_WHITE," רמה שלישית 450 הריגות");
SendClientMessage(playerid,COLOR_WHITE," רמה רביעית 600 הריגות");
SendClientMessage(playerid,COLOR_WHITE," רמה חמישית 750 הריגות");
SendClientMessage(playerid,COLOR_WHITE," רמה שישית 900 הריגות");
SendClientMessage(playerid,COLOR_WHITE," רמה שביעית 1050 הריגות");
SendClientMessage(playerid,COLOR_WHITE," רמה שמינית 1200 הריגות");
SendClientMessage(playerid,COLOR_WHITE," רמה תשיעית 1350 הריגות");
SendClientMessage(playerid,COLOR_WHITE," רמה עשירית 1500 הריגות");
*/





 

if(strcmp(cmd, "/gang", true) == 0)
{
new gangcmd, gangnum;
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(tmp))
{
SendClientMessage(playerid, COLOR_WHITE, "שגיאה שרת: /gang [create/join/invite/quit] [name/number]");
return 1;
}
giveplayerid = strval(tmp);
if(strcmp(tmp, "create", true)==0)
gangcmd = 1;
else if(strcmp(tmp, "invite", true)==0)
gangcmd = 2;
else if(strcmp(tmp, "join", true)==0)
gangcmd = 3;
else if(strcmp(tmp, "quit", true)==0)
gangcmd = 4;
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(gangcmd < 3 && !strlen(tmp))
{
if(gangcmd==0)
SendClientMessage(playerid, COLOR_WHITE, "שגיאה שרת /gang [create/join/invite/quit] [name/number]");
else if(gangcmd==1)
SendClientMessage(playerid, COLOR_WHITE, "שגיא שרת: /gang [create] [name]");
else if(gangcmd==2)
SendClientMessage(playerid, COLOR_WHITE, "שגיאה שרת: /gang [invite] [playerID]");
return 1;
}

if(gangcmd==1)
{
if(playerGang[playerid]>0)
{
SendClientMessage(playerid, WHITE, ".אתה כבר שייך לגנג ");
return 1;
}
for(new i = 1; i < MAX_GANGS; i++)
{
if(gangInfo[i][0]==0)
{
format(gangNames[i], MAX_GANG_NAME, "%s", tmp);
gangInfo[i][0]=1;
gangInfo[i][1]=1;
gangInfo[i][2]=playerColors[playerid];
gangMembers[i][0] = playerid;
format(string, sizeof(string),".%s יצרת גנג בשם ", gangNames[i], i);
SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
playerGang[playerid]=i;
return 1;
}
}
return 1;
}
else if (gangcmd==3)
{
gangnum = gangInvite[playerid];
if(playerGang[playerid]>0)
{
SendClientMessage(playerid, WHITE, ".אתה כבר שייך לגנג אחד ");
return 1;
}
if(gangInvite[playerid]==0)
{
SendClientMessage(playerid, WHITE, ".לא קיבלת הזמנה לגנג ");
return 1;
}
if(gangInfo[gangnum][0]==0)
{
SendClientMessage(playerid, WHITE, "That gang does not exist!");
return 1;
}
if(gangInfo[gangnum][1] < MAX_GANG_MEMBERS)
{
new i = gangInfo[gangnum][1];
gangInvite[playerid]=0;
gangMembers[gangnum][i] = playerid;
GetPlayerName(playerid, sendername, MAX_PLAYER_NAME);
for(new j = 0; j < gangInfo[gangnum][1]; j++)
{
format(string, sizeof(string),".הצטרף אל הגנג שלך %s", sendername);
SendClientMessage(gangMembers[gangnum][j], COLOR_WHITE, string);
}
gangInfo[gangnum][1]++;
playerGang[playerid] = gangnum;
SetPlayerColor(playerid,gangInfo[gangnum][2]);
format(string, sizeof(string),".%s הצטרפת לגנג ", gangNames[gangnum], gangnum);
SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
return 1;
}
SendClientMessage(playerid, WHITE, ".גנג זה מלא ");
return 1;
}
else if (gangcmd==2)
{
giveplayerid = strval(tmp);
if(playerGang[playerid]==0)
{
SendClientMessage(playerid, WHITE, ".אתה לא שייך לאף גנג ");
return 1;
}

if(IsPlayerConnected(giveplayerid))
{
GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
GetPlayerName(playerid, sendername, sizeof(sendername));
format(string, sizeof(string),".להצטרף לגנג שלך %s הזמנת את ", giveplayer);
SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
format(string, sizeof(string),".%s קיבלת הזמנה לגנג בשם ", gangNames[playerGang[playerid]]);
SendClientMessage(giveplayerid, COLOR_LIGHTGREEN, string);
format(string, sizeof(string),".%s ההזמנה נשלחה מ ", sendername);
SendClientMessage(giveplayerid, COLOR_LIGHTGREEN, string);
gangInvite[giveplayerid]=playerGang[playerid];
}
else
SendClientMessage(playerid, WHITE, "No such player exists!");
}
else if (gangcmd==4)
{
PlayerLeaveGang(playerid);
}
return 1;
}

if(strcmp(cmd, "/ganginfo", true) == 0)
{
new gangnum;
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(tmp) && playerGang[playerid]==0)
{
SendClientMessage(playerid, COLOR_WHITE, "Usage: /ganginfo [מספר]");
return 1;
}
else if (!strlen(tmp))
gangnum = playerGang[playerid];
else
gangnum = strval(tmp);
if(gangInfo[gangnum][0]==0)
{
SendClientMessage(playerid, WHITE, "No such gang exists!");
return 1;
}
format(string, sizeof(string),"'%s' אודות הגאנג (id: %d)", gangNames[gangnum], gangnum);
SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
for(new i = 0; i < gangInfo[gangnum][1]; i++)
{
GetPlayerName(gangMembers[gangnum][i], giveplayer, sizeof(giveplayer));
format(string, sizeof(string),"%s (%d)", giveplayer, gangMembers[gangnum][i]);
SendClientMessage(playerid, COLOR_WHITE, string);
}
return 1;
}
	
if(strcmp(cmd, "/gangs", true) == 0)
{
new x;
SendClientMessage(playerid, COLOR_LIGHTGREEN, "Current Gangs:");
for(new i=0; i < MAX_GANGS; i++)
{
if(gangInfo[i][0]==1)
{
format(string, sizeof(string), "%s%s(%d) - %d members", string,gangNames[i],i,gangInfo[i][1]);
x++;
if(x > 2)
{
SendClientMessage(playerid, COLOR_WHITE, string);
x = 0;
format(string, sizeof(string), "");
}
else
{
format(string, sizeof(string), "%s, ", string);
}
}
}
if(x <= 2 && x > 0) {
string[strlen(string)-2] = '.';
SendClientMessage(playerid, COLOR_WHITE, string);
}
return 1;
}

//------------
//Lotto

if(strcmp(cmd, "/BigBang", true) == 0)
{
new sid[256], id;
sid = strtok(cmdtext,idx);
id = ReturnID(sid);
if(30 < strlen(sid)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");

if (PlayerInfo[playerid][Level] < 4) return Messagelevel (playerid, 4);
if(!IsPlayerConnected(id)) return SendClientMessage(playerid,WHITE,".המספר איידי שהזנת שגוי");
if(GetPlayerInterior(id) == 1 || GetPlayerInterior(id) == 6 || GetPlayerInterior(id) == 10) return SendClientMessage(playerid,0xFF0000AA,".אתה לא יכול לתקוף שחקן שהוא נמצא בתוך אינטרור");
if(GetPlayerInterior(playerid) == 1 || GetPlayerInterior(playerid) == 6 || GetPlayerInterior(playerid) == 10) return SendClientMessage(playerid,0xFF0000AA,".אתה לא יכול לתקוף שחקן שהוא נמצא בתוך אינטרור");
if(GetPlayerMoney(playerid) < 3400) return SendClientMessage(playerid,WHITE,".שימוש פקודה זאתי עולה כ3400 דולר");
LACY_GiveMoney(playerid,-3400);
new Float:X,Float:Y,Float:Z;
GetPlayerPos(id,X,Y,Z);
if(PlayerToPoint(5.0,playerid,X,Y,Z))
{
new Float:pos[3];
GetPlayerPos(id,pos[0],pos[1],pos[2]);
CreateExplosion(pos[0],pos[1],pos[2],0,0.4);
}
else
{
SendClientMessage(playerid, WHITE, ".אתה חייב להיות צמוד לשחקן על מנת לפוצץ אותו");
}


return 1;
}


//----------- [Pets System] ---------

if(strcmp(cmd, "/buytor", true) == 0)
{
if (PlayerInfo[playerid][Level] < 3) return Messagelevel (playerid, 3);

if(IsPlayerInAnyVehicle(playerid) ) return SendClientMessage(playerid,WHITE,".אנא צא מהרכב לביצוע פקודה זאת");
if(PlayerInfo[playerid][Tor] ==1) return SendClientMessage(playerid,WHITE,"/selltor יש לך כבר צב למכירת הצב");
if(GetPlayerMoney(playerid) < 400000) return SendClientMessage(playerid, WHITE, ".אתה צריך לפחות כ400000 לקנייה צב");
LACY_GiveMoney(playerid,-400000);
SendClientMessage(playerid,COLOR_WHITE,"./calltor לקרוא לצב שלך /help pets - קנית צב בהצלחה , לרשימת פקודות");
PlayerInfo[playerid][Pets] =1;
PlayerInfo[playerid][Tor] =1;
return 1;
}

if(strcmp(cmd, "/selltor", true) == 0)
{
if(PlayerInfo[playerid][Tor] ==0) return SendClientMessage(playerid,WHITE,".אין לך צב בכלל");
LACY_GiveMoney(playerid,30000);
DestroyDynamicObject(sam44[playerid]);
SendClientMessage(playerid, COLOR_WHITE, ".מכרת את החיה שלך בהצלחה");
PlayerInfo[playerid][Tor] =0;
PlayerInfo[playerid][Pets] =0;
return 1;
}

if(strcmp(cmd, "/calltor", true) == 0)
{
if(IsPlayerInAnyVehicle(playerid) ) return SendClientMessage(playerid,WHITE,".אנא צא מהרכב לביצוע פקודה זאת");
if(ThePetsInYou[playerid] ==1) return SendClientMessage(playerid,WHITE,"יש לך כבר חיה אצלך אתה לא יכול לזמן אלייך יותר מחיה 1");
if(PlayerInfo[playerid][Tor] ==0) return SendClientMessage(playerid,WHITE,"אין לך צב בכלל");
if(PlayerInfo[playerid][Pets] ==0) return SendClientMessage(playerid,WHITE,"אין לך חיה בכלל");
if(GetPlayerMoney(playerid) < 500) return SendClientMessage(playerid, WHITE, ".זימון החיה עולה כ500 דולר");
LACY_GiveMoney(playerid,-500);
new Float:x,Float:y,Float:z;
sam44[playerid] = CreateDynamicObject(1609, 2294.422363, 530.393738, 1.226355, 0.0000, 0.0000, 0.0000);
AttachDynamicObjectToPlayer(sam44[playerid],playerid,x+3,y+3,z+0.6,0,0,0);
ThePetsInYou[playerid] =1;
TorYou[playerid] =1;
SendClientMessage(playerid, COLOR_WHITE,"---- מערכת החיות זימנה אלייך את הצב שלך ---");
SendClientMessage(playerid, lblue, "שיגרת את החיה שלך בהצלחה אליך");
SendClientMessage(playerid, lblue, "/backtor - להחזרת החיה למקום בצע ");
SendClientMessage(playerid, lblue, "/ator <id/name> - לתקיפה עם החיה שלך");
SendClientMessage(playerid, COLOR_WHITE,"-----------");

return 1;
}

if(strcmp(cmd, "/backtor", true) == 0)
{
if(PlayerInfo[playerid][Tor] ==0) return SendClientMessage(playerid,WHITE,"אין לך צב בכלל");
if(PlayerInfo[playerid][Pets] ==0) return SendClientMessage(playerid,WHITE,"אין לך חיה בכלל");
if(ThePetsInYou[playerid] ==0) return SendClientMessage(playerid,WHITE,".החיה לא אצלך");
SendClientMessage(playerid, COLOR_WHITE, "!החזרת את החיה שלך בהצלחה למקום");
DestroyDynamicObject(sam44[playerid]);
ThePetsInYou[playerid] =0;
TorYou[playerid] =0;
return 1;
}

if(strcmp(cmd, "/AirStrike", true) == 0)
{
new Roy_Killer[256];
Roy_Killer= strtok(cmdtext, idx);
if(30 < strlen(Roy_Killer)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(Roy_Killer))
{

SendClientMessage(playerid,COLOR_WHITE,"Usage: /AirStrike [action]");
SendClientMessage(playerid,COLOR_WHITE,"/AirStrike save (3) - לשמור מיקום של מתקפה אווירית");
SendClientMessage(playerid,COLOR_WHITE,"/AirStrike as1  (3) - .על מנת לבצע תקיפה בקמות טילם של 1 בצע/י ");
SendClientMessage(playerid,COLOR_WHITE,"/AirStrike as2  (5) - .על מנת לבצע תקיפה בקמות טילם של 2 בצע/י ");
SendClientMessage(playerid,COLOR_WHITE,"/AirStrike as3  (9) - .על מנת לבצע תקיפה בקמות טילם של 3 בצע/י ");
SendClientMessage(playerid,COLOR_WHITE,"/AirStrike lpas (3)  - .על מנת להשתגר למיקום תקיפה אווירית שציינת בצע פקודה");
return 1;
}

if(strcmp(Roy_Killer,"Save",true) == 0)
{
if(PlayerInfo[playerid][Level] < 3) return Messagelevel(playerid,3);
if(PlayerInfo[playerid][AirStrikeSaved] == 1) return SendClientMessage(playerid,WHITE,"/AirStrike del - .שמור, על מנת למחוק אותו בצע/י  AirStrike יש לך כבר מיקום");
if(InArea(playerid, 404.8684, 35.6969, 2102.7212, 1653.4156)) return SendClientMessage(playerid,WHITE,".[AntiAirStrike] .שים לב, אינך יכול לשמור מיקום תקיפה אווירית במקום זה תודה");
if(InArea(playerid,-1867.1172 ,-2046.8510, 365.2502,189.3918)) return  SendClientMessage(playerid,WHITE,".[AntiAirStrike] .שים לב, אינך יכול לשמור מיקום תקיפה אווירית במקום זה תודה");
if(InArea(playerid,2147.2263,1968.2661,904.0972,816.9983)) return SendClientMessage(playerid,WHITE,".[AntiAirStrike] .שים לב, אינך יכול לשמור מיקום תקיפה אווירית במקום זה תודה");
if(InArea(playerid,-1053.7112,-1515.2965,560.0065,-740.4934)) return SendClientMessage(playerid,WHITE,".[AntiAirStrike] .שים לב, אינך יכול לשמור מיקום תקיפה אווירית במקום זה תודה");
if(InArea(playerid,1985.0746,1858.3486,-1347.2802,-1464.8994)) return SendClientMessage(playerid,WHITE,".[AntiAirStrike] .שים לב, אינך יכול לשמור מיקום תקיפה אווירית במקום זה תודה");
if(GetPlayerMoney(playerid) < 2000) return SendClientMessage(playerid,WHITE,".עולה כ2000 דולר ואין לך AirStrikeשמירת מיקום של");
if(GetPlayerInterior(playerid) == 1 || GetPlayerInterior(playerid) == 6 || GetPlayerInterior(playerid) == 10) return SendClientMessage(playerid,0xFF0000AA,".אתה לא יכול לשמור מתקפת אווירית בתוך אינטרור");
LACY_GiveMoney(playerid,-2000);
GetPlayerPos(playerid,airstrikex,airstrikey,airstriakez);
AirStrikeInWar[playerid] = 0;
Explodeion[playerid] = 0;
PlayerInfo[playerid][AirStrikeSaved] = 1;
PlayerInfo[playerid][xAirStrike] = airstrikex;
PlayerInfo[playerid][yAirStrike] = airstrikey;
PlayerInfo[playerid][zAirStrike] = airstriakez;
dini_IntSet(GetPlayerFile(playerid),"SaveStrika",PlayerInfo[playerid][AirStrikeSaved]);
dini_FloatSet(GetPlayerFile(playerid),"xAir",PlayerInfo[playerid][xAirStrike]);
dini_FloatSet(GetPlayerFile(playerid),"yAir",PlayerInfo[playerid][yAirStrike]);
dini_FloatSet(GetPlayerFile(playerid),"zAir",PlayerInfo[playerid][zAirStrike]);
SendClientMessage(playerid,WHITE,".(AirStrike) שמרת בהצלחה מיקום של התפקה אווירית");




return 1;
}
else if(strcmp(Roy_Killer,"as1",true) == 0)
{
if(PlayerInfo[playerid][Level] < 3) return Messagelevel(playerid,3);
if(AirStrikeInWar[playerid] == 1) return SendClientMessage(playerid,WHITE,"אנא המתן לתקוף שנית עם המתקפה אוורית. תודה");
if(PlayerInfo[playerid][AirStrikeSaved] == 0) return SendClientMessage(playerid,WHITE,".אין לך אף מיקום תקיפה אווירית שמור");
if(GetPlayerMoney(playerid) < 10000) return SendClientMessage(playerid,WHITE,".על רמה מספר 1 עולה כ10,000 דולר AirStrikeהפעלת ה");

DestroyObject(AirStrikeTil[playerid]);
DestroyObject(AirStrikeTil2[playerid]);
DestroyObject(AirStrikeTil3[playerid]);

LACY_GiveMoney(playerid,-10000);
AirStrikeTil[playerid] = CreateObject(354,airstrikex+300,airstrikey+300,airstriakez+300,0.0000, 0.0000, 0.0000);
MoveObject(AirStrikeTil[playerid] ,PlayerInfo[playerid][xAirStrike],PlayerInfo[playerid][yAirStrike],PlayerInfo[playerid][zAirStrike],110);
Explodeion[playerid] = 1;
AirStrikeExplodes[playerid] = SetTimerEx("AirStrikeExplode",4900,1,"i",playerid);
SendClientMessage(playerid,COLOR_ORANGE,".תתחיל בעוד מס' שניות, אנא ברח מהמקום שציינת אותו AirStrikeמתקפת ה");
AirStrikeInWar[playerid] = 1;
return 1;
}

else if(strcmp(Roy_Killer,"as2",true) == 0)
{
if(PlayerInfo[playerid][Level] < 5) return Messagelevel(playerid,5);
if(AirStrikeInWar[playerid] == 1) return SendClientMessage(playerid,WHITE,"אנא המתן לתקוף שנית עם המתקפה אוורית. תודה");
if(PlayerInfo[playerid][AirStrikeSaved] == 0) return SendClientMessage(playerid,WHITE,".אין לך אף מיקום תקיפה אווירית שמור");
if(GetPlayerMoney(playerid) < 13000) return SendClientMessage(playerid,WHITE,".על רמה מספר 2 עולה כ13,000 דולר AirStrikeהפעלת ה");

DestroyObject(AirStrikeTil[playerid]);
DestroyObject(AirStrikeTil2[playerid]);
DestroyObject(AirStrikeTil3[playerid]);

LACY_GiveMoney(playerid,-13000);
AirStrikeTil[playerid] = CreateObject(354,airstrikex+300,airstrikey+300,airstriakez+300,0.0000, 0.0000, 0.0000);
AirStrikeTil2[playerid] = CreateObject(354,airstrikex+300,airstrikey+300,airstriakez+300,0.0000, 0.0000, 0.0000);
MoveObject(AirStrikeTil[playerid] ,PlayerInfo[playerid][xAirStrike],PlayerInfo[playerid][yAirStrike],PlayerInfo[playerid][zAirStrike],110);
MoveObject(AirStrikeTil2[playerid] ,PlayerInfo[playerid][xAirStrike],PlayerInfo[playerid][yAirStrike],PlayerInfo[playerid][zAirStrike],87);
Explodeion[playerid] = 2;
AirStrikeExplodes[playerid] = SetTimerEx("AirStrikeExplode",4900,1,"i",playerid);
SendClientMessage(playerid,COLOR_ORANGE,".תתחיל בעוד מס' שניות, אנא ברח מהמקום שציינת אותו AirStrikeמתקפת ה");
AirStrikeInWar[playerid] = 1;
return 1;
}
else if(strcmp(Roy_Killer,"as3",true) == 0)
{
if(PlayerInfo[playerid][Level] < 9) return Messagelevel(playerid,9);
if(AirStrikeInWar[playerid] == 1) return SendClientMessage(playerid,WHITE,"אנא המתן לתקוף שנית עם המתקפה אוורית. תודה");
if(PlayerInfo[playerid][AirStrikeSaved] == 0) return SendClientMessage(playerid,WHITE,".אין לך אף מיקום תקיפה אווירית שמור");
if(GetPlayerMoney(playerid) < 15000) return SendClientMessage(playerid,WHITE,".רמה 3 עולה כ15,000 דולר AirStrikeהפעלת ה");

DestroyObject(AirStrikeTil[playerid]);
DestroyObject(AirStrikeTil2[playerid]);
DestroyObject(AirStrikeTil3[playerid]);

LACY_GiveMoney(playerid,-15000);
AirStrikeTil[playerid] = CreateObject(354,airstrikex+300,airstrikey+300,airstriakez+300,0.0000, 0.0000, 0.0000);
AirStrikeTil2[playerid] = CreateObject(354,airstrikex+300,airstrikey+300,airstriakez+300,0.0000, 0.0000, 0.0000);
AirStrikeTil3[playerid] = CreateObject(354,airstrikex+300,airstrikey+300,airstriakez+300,0.0000, 0.0000, 0.0000);
MoveObject(AirStrikeTil[playerid] ,PlayerInfo[playerid][xAirStrike],PlayerInfo[playerid][yAirStrike],PlayerInfo[playerid][zAirStrike],110);
MoveObject(AirStrikeTil2[playerid] ,PlayerInfo[playerid][xAirStrike],PlayerInfo[playerid][yAirStrike],PlayerInfo[playerid][zAirStrike],87);
MoveObject(AirStrikeTil3[playerid] ,PlayerInfo[playerid][xAirStrike],PlayerInfo[playerid][yAirStrike],PlayerInfo[playerid][zAirStrike],66);
Explodeion[playerid] = 3;
AirStrikeExplodes[playerid] = SetTimerEx("AirStrikeExplode",4900,1,"i",playerid);
SendClientMessage(playerid,COLOR_ORANGE,".תתחיל בעוד מס' שניות, אנא ברח מהמקום שציינת אותו AirStrikeמתקפת ה");
AirStrikeInWar[playerid] = 1;
return 1;
}
else if(strcmp(Roy_Killer,"del",true) == 0)
{
if(PlayerInfo[playerid][Level] < 3) return Messagelevel(playerid,3);
if(PlayerInfo[playerid][AirStrikeSaved] == 0) return SendClientMessage(playerid,WHITE,".אין לך אף מיקום תקיפה אווירית שמור");

DestroyObject(AirStrikeTil[playerid]);
DestroyObject(AirStrikeTil2[playerid]);
DestroyObject(AirStrikeTil3[playerid]);

PlayerInfo[playerid][xAirStrike] = 0.0;
PlayerInfo[playerid][yAirStrike] = 0.0;
PlayerInfo[playerid][zAirStrike] = 0.0;
PlayerInfo[playerid][AirStrikeSaved] = 0;
dini_IntSet(GetPlayerFile(playerid),"SaveStrika",0);
dini_FloatSet(GetPlayerFile(playerid),"xAir",PlayerInfo[playerid][xAirStrike]);
dini_FloatSet(GetPlayerFile(playerid),"yAir",PlayerInfo[playerid][yAirStrike]);
dini_FloatSet(GetPlayerFile(playerid),"zAir",PlayerInfo[playerid][zAirStrike]);
SendClientMessage(playerid,WHITE,".בהצלחה AirStrike מחקת את המיקומים של ה");
return 1;
}
else if(strcmp(Roy_Killer,"lpas",true) == 0)
{
if(PlayerInfo[playerid][Level] < 3) return Messagelevel(playerid,3);
if(PlayerInfo[playerid][AirStrikeSaved] == 0) return SendClientMessage(playerid,WHITE,".אין לך אף מיקום תקיפה אווירית שמור");
if(GetPlayerMoney(playerid) < 600) return SendClientMessage(playerid,WHITE,".עולה כ600 דולר AirStrikeשים לב, השתגרות למיקומי ה");
LACY_GiveMoney(playerid,-600);
SetPlayerPos(playerid,PlayerInfo[playerid][xAirStrike],PlayerInfo[playerid][yAirStrike],PlayerInfo[playerid][zAirStrike]);
SendClientMessage(playerid,WHITE,".שלך בהצלחה AirStrikeהשתגרת למיקומי ה");
SetPlayerInterior(playerid,0);
return 1;
}
return 1;
}



if(strcmp(cmd, "/ator", true) == 0)
{
new sid[256], id;
sid = strtok(cmdtext,idx);
id = ReturnID(sid);
if(30 < strlen(sid)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");

if(PetInWar[playerid] ==1) return SendClientMessage(playerid,WHITE,"החיה שלך בתקיפה אנא המתן מספר שניות כדאי לתקוף שנית");
if(ThePetsInYou[playerid] ==0) return SendClientMessage(playerid,WHITE,".החיה לא אצלך");
if(PlayerInfo[playerid][Tor] ==0) return SendClientMessage(playerid,WHITE,"אין לך צב בכלל");
if(TorYou[playerid] ==0) return SendClientMessage(playerid, WHITE,".הצב לא נמצא אצלך בכלל אנא זמן אותו");
if(PlayerInfo[playerid][Pets] ==0) return SendClientMessage(playerid,WHITE,"אין לך חיה בכלל");
if(!IsPlayerConnected(id)) return SendClientMessage(playerid,WHITE,".המספר איידי שהזנת שגוי");
if(GetPlayerInterior(id) == 1 || GetPlayerInterior(id) == 6 || GetPlayerInterior(id) == 10) return SendClientMessage(playerid,0xFF0000AA,".אתה לא יכול לתקוף שחקן שהוא נמצא בתוך אינטרור");
if(GetPlayerInterior(playerid) == 1 || GetPlayerInterior(playerid) == 6 || GetPlayerInterior(playerid) == 10) return SendClientMessage(playerid,0xFF0000AA,".אתה לא יכול לתקוף שחקן שהוא נמצא בתוך אינטרור");
if(GetPlayerMoney(playerid) < 700) return SendClientMessage(playerid,WHITE,".תקיפה עם החיה שלך עולה כ700 דולר");
LACY_GiveMoney(playerid,-700);
new Float:pos[3];
GetPlayerPos(id,pos[0],pos[1],pos[2]);

if(PlayerToPoint(9.0, playerid,pos[0],pos[1],pos[2]))
{
GetPlayerPos(id,pos[0],pos[1],pos[2]);
MoveObject(sam44[playerid],pos[0],pos[1],pos[2],5);
DestroyDynamicObject(sam44[playerid]);
new Float:x,Float:y,Float:z;
sam44[playerid] = CreateDynamicObject(1609, 2294.422363, 530.393738, 1.226355, 0.0000, 0.0000, 0.0000);
AttachDynamicObjectToPlayer(sam44[playerid],playerid,x+3,y+3,z+0.6,0,0,0);
PetInWar[playerid]=1;
new Float:health;
GetPlayerHealth(id, health);
SetPlayerHealth(id, health-24);
new Float:health2=health-24;
format(string, sizeof(string), ".תוקף אותך תברח לפני שיהרוג אותך ,%s השחקן",GetName(playerid)),SendClientMessage(id, COLOR_WHITE, string);
GetPlayerHealth(id,health);
LACY_GiveMoney(playerid,-200);
if(health2 < 1)
{
PlayerInfo[playerid][TorKills] += 1;
format(string, sizeof(string), ".תקף אותך עם החיה שלו והרג אותך ,%s השחקן",GetName(playerid)),SendClientMessage(id, COLOR_WHITE, string);
}
}
else
{
SendClientMessage(playerid, WHITE, "..השחקן נמצא ברדיוס רחוק מידי");
}
return 1;
}



if(strcmp(cmd, "/buyshark", true) == 0)
{
if (PlayerInfo[playerid][Level] < 5) return Messagelevel (playerid, 5);

if(IsPlayerInAnyVehicle(playerid) ) return SendClientMessage(playerid,WHITE,".אנא צא מהרכב לביצוע פקודה זאת");
if(PlayerInfo[playerid][Shark] ==1) return SendClientMessage(playerid,WHITE,"/sellshark יש לך כבר כריש למכירת הכריש");
if(GetPlayerMoney(playerid) < 30000) return SendClientMessage(playerid, WHITE, "על מנת לקנות כריש אתה צריך לפחות כ30000 דולר");
LACY_GiveMoney(playerid,-30000);
SendClientMessage(playerid,COLOR_WHITE,"./callshark לקרוא לכריש שלך /help pets - קנית כריש בהצלחה , רשימת פקודות");
PlayerInfo[playerid][Pets] =1;
PlayerInfo[playerid][Shark]=1;
return 1;
}

if(strcmp(cmd, "/sellShark", true) == 0)
{
if(PlayerInfo[playerid][Shark] ==0) return SendClientMessage(playerid,WHITE,".אין לך כריש בכלל");
LACY_GiveMoney(playerid,30000);
DestroyDynamicObject(sam33[playerid]);
ThePetsInYou[playerid] =0;
SharkYou[playerid] =0;
SendClientMessage(playerid, COLOR_WHITE, ".מכרת את החיה שלך בהצלחה");
PlayerInfo[playerid][Pets] =0;
PlayerInfo[playerid][Shark] =0;
return 1;
}
if(strcmp(cmd, "/callshark", true) == 0)
{
if(IsPlayerInAnyVehicle(playerid) ) return SendClientMessage(playerid,WHITE,".אנא צא מהרכב לביצוע פקודה זאת");

if(ThePetsInYou[playerid] ==1) return SendClientMessage(playerid,WHITE,"יש לך כבר חיה אצלך אתה לא יכול לזמן אלייך יותר מחיה 1");
if(PlayerInfo[playerid][Shark] ==0) return SendClientMessage(playerid,WHITE,"אין לך כריש בכלל");
if(PlayerInfo[playerid][Pets] ==0) return SendClientMessage(playerid,WHITE,"אין לך חיה בכלל");
if(GetPlayerMoney(playerid) < 500) return SendClientMessage(playerid, WHITE, ".זימון החיה עולה כ500 דולר");
LACY_GiveMoney(playerid,-500);
new Float:x,Float:y,Float:z;
sam33[playerid] = CreateDynamicObject(1608, 2294.422363, 530.393738, 1.226355, 0.0000, 0.0000, 0.0000);
AttachDynamicObjectToPlayer(sam33[playerid],playerid,x+3,y+3,z+0.6,0,0,0);
ThePetsInYou[playerid] =1;
SharkYou[playerid] =1;
SendClientMessage(playerid, COLOR_WHITE,"---- מערכת החיות זימנה אלייך את הכריש בהצלחה ---");
SendClientMessage(playerid, lblue, "!שיגרת אליך את החיה בהצלחה");
SendClientMessage(playerid, lblue, "/backShark - להחזרת החיה למקום בצע ");
SendClientMessage(playerid, lblue, "/ashark <id/name> - לתקיפה עם החיה שלך");
SendClientMessage(playerid, COLOR_WHITE,"----------");

return 1;
}

if(strcmp(cmd, "/ashark", true) == 0)
{
new sid[256], id;
sid = strtok(cmdtext,idx);
id = ReturnID(sid);
if(30 < strlen(sid)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");

if(SharkYou[playerid] ==0) return SendClientMessage(playerid, WHITE,".החיה לא נמצאת אצלך");
if(PetInWar[playerid] ==1) return SendClientMessage(playerid,WHITE,"החיה שלך בתקיפה אנא המתן מספר שניות כדאי לתקוף שנית");
if(ThePetsInYou[playerid] ==0) return SendClientMessage(playerid,WHITE,".החיה לא אצלך");
if(PlayerInfo[playerid][Shark] ==0) return SendClientMessage(playerid,WHITE,"אין לך כריש בכלל");
if(PlayerInfo[playerid][Pets] ==0) return SendClientMessage(playerid,WHITE,"אין לך חיה בכלל");
if(!IsPlayerConnected(id)) return SendClientMessage(playerid,WHITE,".המספר איידי שהזנת שגוי");
if(GetPlayerMoney(playerid) < 700) return SendClientMessage(playerid,WHITE,".תקיפה עם החיה שלך עולה כ700 דולר");
LACY_GiveMoney(playerid,-700);
if(GetPlayerInterior(id) == 1 || GetPlayerInterior(id) == 6 || GetPlayerInterior(id) == 10) return SendClientMessage(playerid,0xFF0000AA,".אתה לא יכול לתקוף שחקן שהוא נמצא בתוך אינטרור");
if(GetPlayerInterior(playerid) == 1 || GetPlayerInterior(playerid) == 6 || GetPlayerInterior(playerid) == 10) return SendClientMessage(playerid,0xFF0000AA,".אתה לא יכול לתקוף שחקן שהוא נמצא בתוך אינטרור");
new Float:pos[3];
GetPlayerPos(id,pos[0],pos[1],pos[2]);

if(PlayerToPoint(9.0, playerid,pos[0],pos[1],pos[2]))
{
GetPlayerPos(id,pos[0],pos[1],pos[2]);
MoveObject(sam33[playerid],Pos[playerid][0],Pos[playerid][1],Pos[playerid][2],6);

DestroyDynamicObject(sam33[playerid]);
new Float:x,Float:y,Float:z;
sam33[playerid] = CreateDynamicObject(1608, 2294.422363, 530.393738, 1.226355, 0.0000, 0.0000, 0.0000);
AttachDynamicObjectToPlayer(sam33[playerid],playerid,x+3,y+3,z+0.6,0,0,0);
PetInWar[playerid]=1;
new Float:health;
GetPlayerHealth(id, health);
SetPlayerHealth(id, health-70);
new Float:health2=health-70;
format(string, sizeof(string), ".תוקף אותך תברח לפני שיהרוג אותך ,%s השחקן",GetName(playerid)),SendClientMessage(id, COLOR_WHITE, string);
GetPlayerHealth(id,health);
if(health2 < 1)
{
PlayerInfo[playerid][SharkKills] += 1;
format(string, sizeof(string), ".תקף אותך עם החיה שלו והרג אותך ,%s השחקן",GetName(playerid)),SendClientMessage(id, COLOR_WHITE, string);
}
}
else
{
SendClientMessage(playerid, WHITE, ".השחקן נמצא ברדיוס רחוק מידי");
}
return 1;
}

if(strcmp(cmd, "/backShark", true) == 0)
{
if(PlayerInfo[playerid][Shark] ==0) return SendClientMessage(playerid,WHITE,"אין לך כריש בכלל");
if(PlayerInfo[playerid][Pets] ==0) return SendClientMessage(playerid,WHITE,"אין לך חיה בכלל");
if(ThePetsInYou[playerid] ==0) return SendClientMessage(playerid,WHITE,".החיה לא אצלך");
SendClientMessage(playerid, COLOR_WHITE, "!החזרת את החיה שלך בהצלחה למקום");
DestroyDynamicObject(sam33[playerid]);

ThePetsInYou[playerid] =0;
SharkYou[playerid] =0;
return 1;
}



//--
/*
if(strcmp(cmdtext, "/LoD" ,true)==0)
{
if(PP[playerid] == 1) return SendClientMessage(playerid, WHITE, ".אתה במלחמה ואינך יכול להשתגר ");
new file2[] = "RoX.ini";
//new pName[24];
GetPlayerName(playerid, pName, 24);
if(fsearch(file2, pName, false)==0)
{
SendClientMessage(playerid,WHITE,"[LoD] אתה לא נמצא בקלאן");
return 1;
}
if (IsPlayerInAnyVehicle(playerid)) {
SetVehiclePos(GetPlayerVehicleID(playerid), 884.3502,-1224.8672,16.9766);
SetVehicleZAngle(GetPlayerVehicleID(playerid), 265.4424);
}
else
{
SetPlayerPos(playerid, 884.3502,-1224.8672,16.9766);
SetPlayerFacingAngle(playerid, 265.4424);
}

return 1;
}



if(!strcmp(cmd, "/iRox", true))
{
new pid, tmpp[256];
tmpp = strtok(cmdtext, idx);
if (!strlen(tmpp))return SendClientMessage(playerid, COLOR_LIGHTGREEN, "Usage: /iRox <id/name>");
pid = strval(tmpp);
if(!(IsPlayerConnected(pid)))return SendClientMessage(playerid, WHITE, ".האיידי שהזנת הינו שגוי לחלוטין");

new name[MAX_PLAYER_NAME];
GetPlayerName(playerid, name, sizeof(name));
new temp[256];
new File:fhandle;
format(temp,sizeof(temp),"%s\n",name);
fhandle = fopen("[ClanRox].ini",io_append);
fwrite(fhandle,temp);
fclose(fhandle);
dini_Set(GetPlayerFile(playerid),"Clan","RoX");
format(string,256,".לקלאן שלך %s שלחת הזמנה ל",name);
SendClientMessage(playerid,WHITE,string);
new NAMEINVITED[MAX_PLAYER_NAME];
GetPlayerName(playerid, NAMEINVITED, sizeof(NAMEINVITED));
format(string,256,".[%s] שם הקלאן %s צורפת לקלאן ע\"יי",NAMEINVITED,dini_Get(GetPlayerFile(playerid),"Clan")),SendClientMessage(pid,WHITE,string);


return 1;
}
*/
if(strcmp(cmd, "/buydolphin", true) == 0)
{
if(PlayerInfo[playerid][Level] < 4) return Messagelevel (playerid, 4);
if(IsPlayerInAnyVehicle(playerid) ) return SendClientMessage(playerid,WHITE,".אנא צא מהרכב לביצוע פקודה זאת");
if(PlayerInfo[playerid][Dolp] ==1) return SendClientMessage(playerid,WHITE,"/selldolphin יש לך כבר דולפין אחד למכירת הדולפין");
if(GetPlayerMoney(playerid) < 30000) return SendClientMessage(playerid, WHITE,"על מנת לקנות דולפין אתה צריך לפחות 30000 דולר");
LACY_GiveMoney(playerid,-30000);
SendClientMessage(playerid,COLOR_WHITE,"./calldolphin :לקרוא לדולפין שלך /help pets - קנית דולפין בהצלחה , לפקודות דולפין");
PlayerInfo[playerid][Pets] =1;
PlayerInfo[playerid][Dolp] =1;

return 1;
}

if(strcmp(cmd, "/selldolphin", true) == 0)
{
if(PlayerInfo[playerid][Dolp] ==1) return SendClientMessage(playerid,WHITE,".אין לך חיה בכלל");
LACY_GiveMoney(playerid,30000);
DestroyDynamicObject(sam22[playerid]);
SendClientMessage(playerid, COLOR_WHITE, ".מכרת את החיה שלך בהצלחה");
PlayerInfo[playerid][Pets] =0;
PlayerInfo[playerid][Dolp] =0;
ThePetsInYou[playerid] =0;
DolpYou[playerid] =0;
return 1;
}


if(strcmp(cmd, "/calldolphin", true) == 0)
{
if(IsPlayerInAnyVehicle(playerid) ) return SendClientMessage(playerid,WHITE,".אנא צא מהרכב לביצוע פקודה זאת");
if(ThePetsInYou[playerid] ==1) return SendClientMessage(playerid,WHITE,"יש לך כבר חיה אצלך אתה לא יכול לזמן אלייך יותר מחיה 1");
if(PlayerInfo[playerid][Dolp] ==0) return SendClientMessage(playerid,WHITE,"אין לך דולפין בכלל");
if(PlayerInfo[playerid][Pets] ==0) return SendClientMessage(playerid,WHITE,"אין לך חיה בכלל");
if(GetPlayerMoney(playerid) < 500) return SendClientMessage(playerid, WHITE, ".זימון החיה עולה כ500 דולר");
LACY_GiveMoney(playerid,-500);
new Float:x,Float:y,Float:z;
sam22[playerid] = CreateDynamicObject(1607, 2294.422363, 530.393738, 1.226355, 0.0000, 0.0000, 135.0000);
AttachDynamicObjectToPlayer(sam22[playerid],playerid,x+3,y+3,z+0.8,0,0,0);
ThePetsInYou[playerid] =1;
DolpYou[playerid] =1;
SendClientMessage(playerid, COLOR_WHITE,"---- מערכת החיות זימנה אלייך את הדולפין שלך בהצלחה ---");
SendClientMessage(playerid, lblue, "!שיגרת אליך את החיה בהצלחה");
SendClientMessage(playerid, lblue, "/backdolphin - להחזרת החיה למקום בצע ");
SendClientMessage(playerid, lblue, "/adolp <id/name> - לתקיפה עם החיה שלך");
SendClientMessage(playerid, COLOR_WHITE,"------------");

return 1;
}

if(strcmp(cmd, "/adolp", true) == 0)
{
new sid[256], id;
sid = strtok(cmdtext,idx);
id = ReturnID(sid);
if(30 < strlen(sid)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");

if(DolpYou[playerid] ==0) return SendClientMessage(playerid, WHITE,".הדולפין לא אצלך בכלל");
if(PetInWar[playerid] ==1) return SendClientMessage(playerid,WHITE,"החיה שלך בתקיפה אנא המתן מספר שניות כדאי לתקוף שנית");
if(ThePetsInYou[playerid] ==0) return SendClientMessage(playerid,WHITE,".החיה לא אצלך");
if(PlayerInfo[playerid][Dolp] ==0) return SendClientMessage(playerid,WHITE,"אין לך דולפין בכלל");
if(PlayerInfo[playerid][Pets] ==0) return SendClientMessage(playerid,WHITE,"אין לך חיה בכלל");
if(!IsPlayerConnected(id)) return SendClientMessage(playerid,WHITE,".המספר איידי שהזנת שגוי");
if(GetPlayerInterior(id) == 1|| GetPlayerInterior(id) == 6 || GetPlayerInterior(id) == 10) return SendClientMessage(playerid,0xFF0000AA,".אתה לא יכול לתקוף שחקן שהוא נמצא בתוך אינטרור");
if(GetPlayerInterior(playerid) == 1 || GetPlayerInterior(playerid) == 6 || GetPlayerInterior(playerid) == 10) return SendClientMessage(playerid,0xFF0000AA,".אתה לא יכול לתקוף שחקן שהוא נמצא בתוך אינטרור");
if(GetPlayerMoney(playerid) < 700) return SendClientMessage(playerid,WHITE,".תקיפה עם החיה שלך עולה כ700 דולר");
LACY_GiveMoney(playerid,-700);
new Float:pos[3];
GetPlayerPos(id,pos[0],pos[1],pos[2]);
if(PlayerToPoint(9.0, playerid,pos[0],pos[1],pos[2]))
{
GetPlayerPos(id,pos[0],pos[1],pos[2]);
MoveObject(sam22[playerid],Pos[playerid][0],Pos[playerid][1],Pos[playerid][2],6);
DestroyDynamicObject(sam22[playerid]);
new Float:x,Float:y,Float:z;
sam22[playerid] = CreateDynamicObject(1607, 2294.422363, 530.393738, 1.226355, 0.0000, 0.0000, 0.0000);
AttachDynamicObjectToPlayer(sam22[playerid],playerid,x+3,y+3,z+0.6,0,0,0);
PetInWar[playerid]=1;
new Float:health;
GetPlayerHealth(id, health);
SetPlayerHealth(id, health-36);
new Float:health2=health-36;

format(string, sizeof(string), ".תוקף אותך תברח לפני שיהרוג אותך ,%s השחקן",GetName(playerid)),SendClientMessage(id, COLOR_WHITE, string);
GetPlayerHealth(id,health);

if(health2 < 1)
{

PlayerInfo[playerid][DolphinKills] += 1;
format(string, sizeof(string), ".תקף אותך עם החיה שלו והרג אותך ,%s השחקן",GetName(playerid)),SendClientMessage(id, COLOR_WHITE, string);
}
}
else
{
SendClientMessage(playerid, WHITE, ".השחקן נמצא ברדיוס רחוק מידי");
}
return 1;
}

if(strcmp(cmdtext, "/sbship", true)==0)
{
if(BankShipOn[playerid] == 1) return SendClientMessage(playerid,WHITE,".בנק הספינה שלך כבר מופעל");
if (PlayerInfo[playerid][Level] < 2) return Messagelevel (playerid, 2);
if(IsPlayerInCheckpoint(playerid)==0 || playerCheckpoint[playerid]!=CP_PIRATE) return SendClientMessage(playerid,WHITE,".אתה חייב להיות בנקודת ציון על מנת להשתמש בפקודה זאת");
SetTimerEx("ShipBank",10*1000,1,"i",playerid);
BankShipOn[playerid] = 1;
format(string, sizeof(string),".%d-אתה מתחיל מסכום של כ", PlayerInfo[playerid][BSHIP]);
SendClientMessage(playerid, COLOR_ORANGE, string);
SendClientMessage(playerid, COLOR_ORANGE, ">> .לא לעזוב את ספינת הבנק, אם תעזוב הבנק יופסק");
BankShipOn[playerid] = 1;
dini_IntSet(GetPlayerFile(playerid),"BSHIP",PlayerInfo[playerid][BSHIP]);
return 1;
}

if(strcmp(cmdtext, "/sbstop", true)==0)
{
if (PlayerInfo[playerid][Level] < 2) return Messagelevel (playerid, 2);
if(PlayerInfo[playerid][BSHIP] < 1) return SendClientMessage(playerid,WHITE,".אין לך כסף בבנק הספינה");
if(IsPlayerInCheckpoint(playerid)==0 || playerCheckpoint[playerid]!=CP_PIRATE) return SendClientMessage(playerid,WHITE,".אתה חייב להיות בנקודת ציון על מנת להשתמש בפקודה זאת");
format(string, sizeof(string),".%d-הפסקת בהצלחה, קיבלת סכום של כ", PlayerInfo[playerid][BSHIP]-100);
SendClientMessage(playerid, COLOR_ORANGE, string);
BankShipOn[playerid] = 0;
LACY_GiveMoney(playerid, PlayerInfo[playerid][BSHIP]);
PlayerInfo[playerid][BSHIP]=0;
dini_IntSet(GetPlayerFile(playerid),"BSHIP",0);
return 1;
}

if(strcmp(cmd, "/backdolphin", true) == 0)
{
if(PlayerInfo[playerid][Dolp] ==0) return SendClientMessage(playerid,WHITE,"אין לך דולפין בכלל");
if(PlayerInfo[playerid][Pets] ==0) return SendClientMessage(playerid,WHITE,"אין לך חיה בכלל");
if(ThePetsInYou[playerid] ==0) return SendClientMessage(playerid,WHITE,".החיה לא אצלך");
SendClientMessage(playerid, COLOR_WHITE, "!החזרת את החיה שלך בהצלחה למקום");
DestroyDynamicObject(sam22[playerid]);
ThePetsInYou[playerid] =0;
DolpYou[playerid] =0;
return 1;
}




if (strcmp(cmdtext, "/showlevel", true)==0)
{
tmp = strtok(cmdtext, idx);
if(30 < strlen(tmp)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
tmp = strtok(cmdtext, idx);
if(!strlen(tmp)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /ShowLevel [1-24]");
tmp = strtok(cmdtext, idx);
if(strval(tmp) > 24 || strval(tmp) < 0) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /ShowLevel [1-24]");
for(new i = 0; i < MAX_PLAYERS; i++)
{
if(PlayerInfo[i][Level] == strval(tmp))
{
format(string, 256, "%s %d lvl: %d.",GetName(i), i,strval(tmp));
SendClientMessage(playerid, 0xF6F658FF, string);
return 1;
}
return 1;
}
return 1;
}
if(strcmp(cmd, "/shelp", true) == 0)
{
SendClientMessage(playerid,0x33CCFFAA,"/teleports [1/2/3/4/5/all] /commands [1/2/3/all] || /help bank || /help cWHITEits || /help rules || /help anime || /help car ");
SendClientMessage(playerid,0x33CCFFAA,"/help clan || /help pets || /help cc || /help server || /help system || /help call ");
SendClientMessage(playerid,0x33CCFFAA,"/help weap || /help gang || /help deatchmatch || /help weed || /help profile || /helpme");
SendClientMessage(playerid, 0x33CCFFAA,"TYPE: /Help 2-48 כל העזרה נמצאת בשאר העמודים של העזרה, מומלץ לקרוא");
return 1;
}

if(strcmp(cmd, "/levels", true) == 0)
{
new Roy_Killer[256];
Roy_Killer= strtok(cmdtext, idx);
if(30 < strlen(Roy_Killer)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(Roy_Killer))
{
SendClientMessage(playerid,COLOR_WHITE,"/levels 1 :הרמות ומספר ההריגות אשר דורשת להגיע אליהם");
SendClientMessage(playerid,COLOR_WHITE,"/levels 2 :בונוסים ספינת הכסף");
SendClientMessage(playerid,COLOR_WHITE,"/levels 3 :מינימום חיים לשיגור");
SendClientMessage(playerid,COLOR_WHITE,"/levels 4 :חיים ומגן המתמלאים אחרי כל הריגה");
SendClientMessage(playerid,COLOR_WHITE,"/levels 5 :מקסימום כסף אשר נשמר בבנק");
return 1;
}

if(strcmp(Roy_Killer,"1",true) == 0)
{

SendClientMessage(playerid,COLOR_WHITE,"---- (1) :הרמות ומספר ההריגות אשר דורשת להגיע אליהם ---");
SendClientMessage(playerid,COLOR_PINK,"( Level, Kills ) :דימוי");
SendClientMessage(playerid,0xF6F658FF,"1. 150 | 2. 300 | 3. 500 | 4. 700 | 5. 100 | 6. 1300");
SendClientMessage(playerid,0xF6F658FF,"7. 1600 | 8. 1700 | 9. 1900 | 10. 2100 | 11. 2500 | 12. 3000");
SendClientMessage(playerid,0xF6F658FF,"13. 3600 | 14. 4000 | 15. 4600 | 16. 5100 | 17. 6100 | 18. 7100");
SendClientMessage(playerid,0xF6F658FF,"19. 8100 | 20. 9100 | 21. 10000");

return 1;
}

if(strcmp(Roy_Killer,"2",true) == 0)
{

SendClientMessage(playerid,COLOR_WHITE,"---- (2) :בונוסים ספינת הכסף ---");
SendClientMessage(playerid,COLOR_PINK,"( Level, Armour , Money ) :דימוי");
SendClientMessage(playerid,0xF6F658FF,"(Level: 0 (Armour: 0.0) (Money (5$) :דוגמא");
SendClientMessage(playerid,0xF6F658FF,"1. 0.0, 10$ | 2. 0.0, 15$ | 3. 0.0, 20$ | 4. 0.0, 25$ | 5. 0.0, 30$ | 6. 0.0, $35");
SendClientMessage(playerid,0xF6F658FF,"7. 0.0, 40$ | 8. 0.0, 45$ | 9. 0.0, 50$ | 10. 5.0, 55$ | 11. 10.0, 60$ | 12. 15.0, $65");
SendClientMessage(playerid,0xF6F658FF,"13. 20.0, 70$ | 14. 25.0, 75$ | 15. 30.0, 80$ | 16. 35.0, 85$ | 17. 35.0, 90$ | 18. 40.0, $95");
SendClientMessage(playerid,0xF6F658FF,"19. 45.0, 100$ | 20. 50.0, 105$ | 21. 55.0, 110$");

return 1;
}

if(strcmp(Roy_Killer,"3",true) == 0)
{

SendClientMessage(playerid,COLOR_WHITE,"---- (3) :מינימום חיים לשיגור ---");
SendClientMessage(playerid,COLOR_PINK,"( Level, Armour ) :דימוי");
SendClientMessage(playerid,0xF6F658FF,"0. 75.0 | 2. 70.0  | 3. 65.0 | 4. 55.0 | 5. 50.0 | 6. 45.0");
SendClientMessage(playerid,0xF6F658FF,"7. 40.0 | 8. 35.0 | 9. 30.0 | 10. 25.0 | 11. 20.0 | 12. 15.0");
SendClientMessage(playerid,0xF6F658FF,"13. 10.0 | 14. 5.0 | 15. 0.0 | 16. 0.0 | 17. 0.0 | 18. 0.0");
SendClientMessage(playerid,0xF6F658FF,"19. 0.0 | 20. 0.0 | 21. 0.0");
return 1;
}


if(strcmp(Roy_Killer,"4",true) == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"---- חיים ומגן המתמלאים אחרי כל הריגה ---");
SendClientMessage(playerid,COLOR_PINK,"( Level, Armour , Health) :דימוי");
SendClientMessage(playerid,0xF6F658FF,"1. 0.0, 0.0 | 2. 0.0, 0.0 | 3. 0.0, 0.0 | 4. 0.0, 0.0 | 5. 0.0, 0.0 | 6. 0.0, 0.0");
SendClientMessage(playerid,0xF6F658FF,"7. 10.0, 0.0 | 8. 5.0, 0.0 | 9. 0.0, 0.0 | 10. 0.0, 0.0 | 11. 30.0, 45.0 | 12. 30.0, 45.0");
SendClientMessage(playerid,0xF6F658FF,"13. 30.0, 45.0 | 14. 30.0, 45.0 | 15. 30.0, 45.0");
SendClientMessage(playerid,0xF6F658FF,"16. 30.0, 45.0 | 17. 30.0, 45.0 | 18. 30.0, 45.0");
SendClientMessage(playerid,0xF6F658FF,"19. 30.0, 45.0 | 20. 30.0, 45.0 | 15. 21.0, 45.0");
return 1;
}

if(strcmp(Roy_Killer,"5",true) == 0)
{

SendClientMessage(playerid,COLOR_WHITE,"---- :מקסימום כסף אשר נשמר בבנק ---");
SendClientMessage(playerid,COLOR_PINK,"( Level: 0, Bank money limit: 1,000,000 ) :דימוי");
SendClientMessage(playerid,0xF6F658FF,"1. 2,000,000$ | 2. 3,000,000$ | 3. 4,000,000$ | 4. 5,000,000$ | 5. 6,000,000$ | 6. 7,000,000$");
SendClientMessage(playerid,0xF6F658FF,"7. 8,000,000$ | 8. 9,000,000$ | 9. 10,000,000$ | 10. 11,000,000$ | 11. 12,000,000$ | 12. 13,000,000$");
SendClientMessage(playerid,0xF6F658FF,"13. 14,000,000$ | 14. 15,000,000$ | 15. 16,000,000$");
SendClientMessage(playerid,0xF6F658FF,"16. 17,000,000$ | 17. 18,000,000$ | 18. 19,000,000$");
SendClientMessage(playerid,0xF6F658FF,"19. 20,000,000$ | 20. 21,000,000$ | 21. 22,000,000$");
return 1;
}

return 1;
}

if(strcmp(cmd, "/help", true) == 0)
{
new Roy_Killer[256];
Roy_Killer= strtok(cmdtext, idx);
if(30 < strlen(Roy_Killer)) return SendClientMessage(playerid,WHITE,".בלתי אפשרי להפיל את השרת שלנו");
if(!strlen(Roy_Killer))
{

SendClientMessage(playerid,COLOR_WHITE,"• 1 - Help  | 2 - Teleport  | 3 - Commands  | 4 - Animals  | 5 - Bank & Cc  | 6 - Weed");
SendClientMessage(playerid,COLOR_WHITE,"• 7 - Monster  | 8 - Karting  | 9 - War Server  | 10 - MiniGun  | 11 - Rpg");
SendClientMessage(playerid,COLOR_WHITE,"• 12 - Wang  | 13 - Proprties  | 14 - Buy Vehicles  | 15 - Profile  | 16 - Gangs");
SendClientMessage(playerid,COLOR_WHITE,"• 17 - VIP  | 18 - Supportives  | 19 - Call  | 20 - System  | 21 - AntiCheat");
SendClientMessage(playerid,COLOR_WHITE,"• 22 - Rules  | 23 - Credits  | 24 - DM Zone  | 25 - Setting  | 26 - Ignore  | 27 - Ammunition  | 28 - AirStrike & AirAttack");
SendClientMessage(playerid,COLOR_WHITE,"• 29 - Drift  | 30 - Tiatlon  | 31 - Stats  | 32 - Organization  | 33 - Gemel  | 34 - BuyFast");
SendClientMessage(playerid,COLOR_WHITE,"• 35 - AirStrike & AirAttack  | 36 - Private Drift  | 37 - Trivia   | 38 - Challenge  | 39 - AirBreak | 40 - BShip | 41 - Hasbon | 42 - JumpKill");
SendClientMessage(playerid,COLOR_WHITE,"• 43 - Clan System | 44 - Clean");
return 1;
}
if(strcmp(Roy_Killer,"1",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"----- /help [1 - 48] :מומלץ לקרוא ----");
SendClientMessage(playerid, lblue,"/Teleports [1/2/3/4/5/all] - :כדאי לראות שיגורים בשרת");
SendClientMessage(playerid, lblue,"/Commands [1/2/3/all] - :לפקודות");
SendClientMessage(playerid, lblue,"/HelpMe :בקשת עזרה מהתומכים || /Help Server  - :על מנת לראות תומכים מחוברים");
SendClientMessage(playerid, lblue,"/Clan :לפקודות מערכת הקלאים");
SendClientMessage(playerid, lblue,"/Gang :לפקודות מערכת הגאגים");
SendClientMessage(playerid, lblue,"/Levels :מערכת הרמות");
SendClientMessage(playerid, lblue,"/Help 2-48 כל העזרה נמצאת בשאר העמודים של העזרה, מומלץ לקרוא");
SendClientMessage(playerid, lblue,"/sHelp - קיים גם תפריט עזרה קטן מאוד על המוד");


}


else if(strcmp(Roy_Killer,"clan",true) == 0)
{
/*
SendClientMessage(playerid, COLOR_WHITE,"---  Clan System (48) - מערכת הקלאנים --");
SendClientMessage(playerid, COLOR_PINK,".מערכת הלקאנים התמידיית - קרדיט לנאור נגר");
SendClientMessage(playerid, COLOR_PINK,".מערכת זה זה פתיחת חבורת פשע, המערכת נשמרת לתמיד, אין הרבה מה להסביר");
SendClientMessage(playerid, COLOR_LIGHTGREEN,".פקודות שימוש");
SendClientMessage(playerid,0xF6F658FF,"/ClanCreate <ClanName> /ClanInfo <ClanName> /ClanPlayers <ClanName>");
SendClientMessage(playerid,0xF6F658FF,"/ClanJoin /Clan Leave /Clan Invite <Playerid / Name> - (2)");
SendClientMessage(playerid,0xF6F658FF,"/ClanSetLevel <Playerid / Name> <Level> - (3) /ClanMsg <Message> - (2)");
SendClientMessage(playerid,0xF6F658FF,"/ClanKick <Playerid / Name> - (3) /clan color <1-20 / List / Off - (3)");
*/
SendClientMessage(playerid, COLOR_WHITE,"---  Clan System (48) - מערכת הקלאנים --");
SendClientMessage(playerid, COLOR_PINK,".מערכת הלקאנים התמידיית");
SendClientMessage(playerid, COLOR_PINK,".מערכת זה זה פתיחת חבורת פשע, המערכת נשמרת לתמיד, אין הרבה מה להסביר");
SendClientMessage(playerid, COLOR_LIGHTGREEN,".פקודות שימוש");
SendClientMessage(playerid,0xF6F658FF,"/Clan Create <ClanName> /Clan Info <ClanName> /Clan Players <ClanName>");
SendClientMessage(playerid,0xF6F658FF,"/Clan Join /Clan Leave /Clan Invite <Playerid / Name> - (2)");
SendClientMessage(playerid,0xF6F658FF,"/Clan SetLevel <Playerid / Name> <Level> - (3) /Clan SM <Message> - (2)");
SendClientMessage(playerid,0xF6F658FF,"/Clan Kick <Playerid / Name> - (3) /clan color <1-20 / List / Off - (3)");
SendClientMessage(playerid,0xF6F658FF,"/Clan Mute <Playerid> (3) -  /Clan UnMute <playerid> (3) /Clan Skin (3)");

}
else if(strcmp(Roy_Killer,"pets",true) == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"-- .מערכת קניית חיות --");
SendClientMessage(playerid,0xF6F658FF,"/SellTor :למכירת הצב - /buytor (3) :לקניית צב");
SendClientMessage(playerid,0xF6F658FF,"/BackTor :להחזרת הצב למקום /calltor (3) :לזימון הצב אלייך");
SendClientMessage(playerid,0xF6F658FF,"/sellshark - למכירת הכריש /buyshark (5) :לקניית כריש");
SendClientMessage(playerid,0xF6F658FF,"/backshark להחזרת הכריש למקום /callshark (5) :לזימון הכריש אליך");
SendClientMessage(playerid,0xF6F658FF,"/selldolphin - למכירת הדולפין /buydolphin (3) :לקנייה דולפין");
SendClientMessage(playerid,0xF6F658FF,"/backdolphin להחזרת הדולפין למקום /calldolphin (4) :לזימון הדולפין אלייך");
SendClientMessage(playerid,0xF6F658FF,"/ashark <id/name> לתקוף עם הכריש שלך - /ator <id/name> לתקוף עם הצב שלך ");
SendClientMessage(playerid,0xF6F658FF,"/adolp <id/name> :לתקיפה שחקן עם הדולפין שלך");
SendClientMessage(playerid,0xF6F658FF,"/ppet <id/name> לראות חיות מחמד של מישהו אחר /mypet :לראות את החיות שלך");
}
else if(strcmp(Roy_Killer,"cc",true) == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"---- Cc help - עזרה כרטיס האשראי ---");
SendClientMessage(playerid,COLOR_PINK,".קניית כרטיש אשראי עולה כ700,000| דכשתמכור תכרטיס אשראי תקבל חזרה כ350,000");
SendClientMessage(playerid,COLOR_LIGHTGREEN,":פקודות כרטיס אשראי");
SendClientMessage(playerid,0xF6F658FF,"/Buycc (3) :לקניית כרטיס אשראי");
SendClientMessage(playerid,0xF6F658FF,"/Sellcc (3) :למכירת כרטיס האשראי");
SendClientMessage(playerid,0xF6F658FF,"/WithdrawC (3) [Money] :למשיכת כסף מהכרטיס אשראי");
SendClientMessage(playerid,COLOR_LIGHTGREEN,".כל משיכה מכרטיס האשראי תעלה לכם 1000 דולר");
SendClientMessage(playerid,COLOR_PINK,"/Help 5 :לעזרה נוספת");

}

else if(strcmp(Roy_Killer,"server",true) == 0)
{
if(IsPlayerConnected(playerid))
{
SendClientMessage(playerid, COLOR_WHITE, "--- .בקשה עזרה מהתומכים - \" /helpme \" רשימת תומכים מחוברים --");
for(new i = 0; i < MAX_PLAYERS; i++)
{
if(IsPlayerConnected(i))
{
if(PlayerInfo[i][Supportives] >=1)
{

format(string, 256, " %s  [%d] ", GetName(i), i);
SendClientMessage(playerid, 0xF6F658FF, string);
}
}
}
}
}
else if(strcmp(Roy_Killer,"system",true) == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"--- מערכת השרת --");
SendClientMessage(playerid,0xF6F658FF,"/Register - ליצור משתמש חדש");
SendClientMessage(playerid,0xF6F658FF,"/Login - לבצע התחברות לחשבון");
SendClientMessage(playerid,0xF6F658FF,"/ChangePass - לבצע שינוי סיסמא");
SendClientMessage(playerid,0xF6F658FF,"/ChangeNick - כדאי לשנות כידנוי");
SendClientMessage(playerid,0xF6F658FF,"/Setting :מגוון שינויים במערכת המשחק");
}


else if(strcmp(Roy_Killer,"call",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE, "--- .מערכת פלאפונים ---");
SendClientMessage(playerid, 0xF6F658FF, "/Call [Playerid] כדאי להתקשר לשחקן");
SendClientMessage(playerid, 0xF6F658FF, "/Hangup כדאי לנתק את השיחה");
SendClientMessage(playerid, 0xF6F658FF, "/Answer(/a) כדאי להרים את הטפלפון");
}
else if(strcmp(Roy_Killer,"weed",true) == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"-- .מערכת הסמים --");
SendClientMessage(playerid, 0xF6F658FF,"/Useweed :לשימוש בסמים");
SendClientMessage(playerid, 0xF6F658FF,"/Sellweed [Playerid] :למכור סמים");
SendClientMessage(playerid, 0xF6F658FF,"/Buyweed :לקנות סמים");
SendClientMessage(playerid, 0xF6F658FF,"/Details :לראות כמה סמים יש לכם");
SendClientMessage(playerid, 0xF6F658FF,"/Declinedeal :לבטל את העסקה");
}
else if(strcmp(Roy_Killer,"Profile",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"Usage: /editprofile [function]");
SendClientMessage(playerid, COLOR_WHITE,"/Editprofile open :לפתיחת פרופיל");
SendClientMessage(playerid, COLOR_WHITE,"/Editprofile icq [Number icq] לערוך את המספר אייסקיו");
SendClientMessage(playerid, COLOR_WHITE,"/Editprofile msn [your msn] המסנג'ר שלך");
SendClientMessage(playerid, COLOR_WHITE,"/Editprofile email [Email] לערוך את האימייל שלך");
SendClientMessage(playerid, COLOR_WHITE,"/Editprofile age :לערוך את הגיל שלך");
SendClientMessage(playerid, COLOR_WHITE,"/Editprofile sex [כדאי לערוך את המין שלך [זכר/נקבה ");
SendClientMessage(playerid, COLOR_WHITE,"/Editprofile m [המילה English Only] מילה שאתה מתחבר אליה אנגלית בלבד");
SendClientMessage(playerid, COLOR_WHITE,"/pProfile <id/name> לראות פרופיל של שחקן אחר - /Profile לראות את הפרופיל שלך");
}

//---


else if(strcmp(Roy_Killer,"bank",true) == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"-- .מערכת הבנק --");
SendClientMessage(playerid, 0xF6F658FF, "/Deposit [amount] - להפקיד כסף בבנק ");
SendClientMessage(playerid, 0xF6F658FF, "/Depositall - להפקיד את כל הכסף");
SendClientMessage(playerid, 0xF6F658FF, "/Withdraw [amount] - למשוך כסף מהבנק");
SendClientMessage(playerid, 0xF6F658FF, "/Balance - לבדוק כמה כסף יש לך בבנק");
SendClientMessage(playerid, 0xF6F658FF, "/Bankid [playerid] [amount] - להעביר כסף מחשבונך לחשבון שחקן אחר");
SendClientMessage(playerid, 0xF6F658FF, "/GetLoan (4) [amount] - לקחת הלוואה מהבנק");
SendClientMessage(playerid, 0xF6F658FF, "/BackLoan - להחזרת הלוואה");

}

else if(strcmp(Roy_Killer,"credits",true) == 0)
{
//new str[256];
SendClientMessage(playerid, COLOR_WHITE, "---  help Credits (25) לוח קרדיטים --");
SendClientMessage(playerid, COLOR_PINK, ".על בניית העזרה Roy`s Omerתודה ל");
SendClientMessage(playerid, COLOR_PINK, ".על התרומה של בסיס העזרה Barak STתודה ל");
format(str, sizeof(str),".על כך שנתת לאנשים תכבוד הראוי להם ,%s ותודה מיוחד לך ",GetName(playerid));
SendClientMessage(playerid, 0xF6F658FF, str);
}


else if(strcmp(Roy_Killer,"rules",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"----- .Rules the server | Satla-Zone.co.il | חוקי השרת ----");
SendClientMessage(playerid, COLOR_GREY," (1) - .אנא דבר בכבוד לאדמינים ולחברי השרת");
SendClientMessage(playerid, COLOR_GREY, "(2) - .אין להציף תצ'אט בהודעות סתמיות");
SendClientMessage(playerid, COLOR_GREY, "(3) - .צי'טים יגררו לבאן ישירות");
SendClientMessage(playerid, COLOR_GREY, "(4) - .אין להרוג בשדה התעופה / רייס עם מסוק / הידרה");
SendClientMessage(playerid, COLOR_GREY, "(5) - .אין לפרסם כתובת מגורים / מספרי פלאפון");
SendClientMessage(playerid, COLOR_GREY, "(6) - .אין לעשות הרג חברי על מנת ליצר לכם סטאטס גבוה יותר");
SendClientMessage(playerid, COLOR_GREY, "(7) - .אין להרוג אדמין לבן - אדמין בתפקיד");
SendClientMessage(playerid, COLOR_GREY, "(8) - /Report - .אנא אל תדווחו בשרת על צי'טירים בצ'אט אנא דווחו בפקודה");

}

else if(strcmp(Roy_Killer,"anime",true) == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"-- .אנימציות השרת --");
SendClientMessage(playerid, COLOR_GREY,"/Sit /Up /Smoke /Piss /Crack /Kiss");
SendClientMessage(playerid, COLOR_GREY,"/Deal /Death /Slapass /Wave /Eat");
SendClientMessage(playerid, COLOR_GREY,"/Vomit /Yc /Ay /CopLock /FsmoKing");
SendClientMessage(playerid, COLOR_GREY,"/Slapped /Injured /WankOut/Arrested");
SendClientMessage(playerid, COLOR_GREY,"/Strip /Chat /Dance [Style 1-3]");
}
else if(strcmp(Roy_Killer,"car",true) == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"-- .מערכת המכוניות --");
SendClientMessage(playerid, lblue,"/SellCar :לימכור את רכב שלך || /Buycar :ליקנות רכב");
SendClientMessage(playerid, lblue,"/Repair :לישלוח את הרכב שלך למוסך || /CallCar :כדי לזמן את הרכב שלך");
SendClientMessage(playerid, lblue,"/StopSale :על מנת להפסיק את מכירת הרכב שלך || /SetPrice [1 - 10,000,000] :על מנת להציע את הרכב שלך למכירה");
SendClientMessage(playerid, lblue,"/BuyNitro :על מנת לקנות ניטרו תמידי לרכב || /SellNitro  :על מנת למכור את הניטרו התמידי");
SendClientMessage(playerid, lblue,"/Eject :להוציא מישהו מהרכב שלך|| /UnLock :לבטל את הנעילה || /Lock :לינעול את הרכב שלך");

}

else if(strcmp(Roy_Killer,"weap",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Ammutions (31) - מערכת נשקים --");
SendClientMessage(playerid, COLOR_PINK,"עזרה קניית נשקים");
SendClientMessage(playerid, COLOR_PINK,".בעזרה זה מותקנת אפשרות לקנות נשקים תמדיים שישמרו לאחר שתצא ותכנס");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות קניית נשק");
SendClientMessage(playerid, 0xF6F658FF,"/buyweapon - קניית נשק (/bw) - קיצור [number weapon] /weaponlist - רשימת נשקים (/wl) - קיצור");
SendClientMessage(playerid,COLOR_LIGHTGREEN,":מיוחד");
SendClientMessage(playerid,0xF6F658FF,"/buyarmour - קניית מגן");
}
else if(strcmp(Roy_Killer,"gang",true) == 0)
{

SendClientMessage(playerid, COLOR_WHITE,"/gang create [name] - בכדי ליצור גנג רשום ");
SendClientMessage(playerid, COLOR_WHITE,"/gang invite [playeid] - בכדי לשלוח הזמנה לשחקן רשום ");
SendClientMessage(playerid, COLOR_WHITE,"/gang join - בכדי להצטרך לגנג רשום ");
SendClientMessage(playerid, COLOR_WHITE,"/gang quit - בכדי לצאת מהגנג שאתה נמצא בוא רשום ");
SendClientMessage(playerid, COLOR_WHITE,"/ganginfo - למידע על הגנגים שבשרת רשום ");
SendClientMessage(playerid, COLOR_WHITE,"/gangs - רשימת הגנגים שבשרת ");
SendClientMessage(playerid, COLOR_WHITE,".`!`אנא דברו בצ'אט על ידי הסימן");
}

else if(strcmp(Roy_Killer,"deatchmatch",true) == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"-- .מערכת אימוני הריגות --");
SendClientMessage(playerid, COLOR_PINK,"מערכת אימוני השרת שבא ניתן להגיע למקום ספון יותר מהר");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות מערכת אימונים");
SendClientMessage(playerid, 0xF6F658FF,"/mp5 (2) /m4 (3) /deagle /dm /bazooka (10) ");

}
else if(strcmp(Roy_Killer,"2",true) == 0)
{

SendClientMessage(playerid, COLOR_WHITE,"--- Mode Teleport (2) - עזרה שיגורים --");
SendClientMessage(playerid, COLOR_PINK,".עזרה שיגורים שבוא ניתן לזוז ממקום למקום בעזרת פקודה ולהגיע למקומות הריגה במהירות רבה יותר");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות שיגורים");
SendClientMessage(playerid, 0xF6F658FF,"/sf /lv /ls /ap /race /ramp");
SendClientMessage(playerid, 0xF6F658FF,"/dj /sandkings /jump /army /carpark /cycletrip");
SendClientMessage(playerid, 0xF6F658FF,"/spawn (5) /arena /skydive /drifts  /grage");
SendClientMessage(playerid, 0xF6F658FF,"/infernus /busstrip /bikestrip /fight /alp /snipe");
SendClientMessage(playerid, 0xF6F658FF,"/pepe /derby /kickstart /lc (1) /bank /parkour (4) /ammu");
SendClientMessage(playerid, 0xF6F658FF,"/water (3) /diving (3) /mp5 (2) /m4 (3) /deagle /dm /bazooka (10)");
SendClientMessage(playerid, 0xF6F658FF,"/teleports [1/2/3/4/5/all] /ship /shipmoney (3) /ships /bazooka (10)");
}
else if(strcmp(Roy_Killer,"3",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"--- Mode Commands (3) - עזרה פקודות --");
SendClientMessage(playerid, COLOR_PINK,".בעזרה הזה מותקנת מגוון פקודות בוא נראה את חלק הקטן מהפקודות");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות");
SendClientMessage(playerid, 0xF6F658FF,"/maxplayers /showid /bigbang <id/name> (4) /nextlevel");
SendClientMessage(playerid, 0xF6F658FF,"/sp (2) /lp /profile /pprofile <id/name> /stats /pstats <id/name>");
SendClientMessage(playerid, 0xF6F658FF,"/details /pdetails <id/name> /mypet /ppet <id/name> /pay <id/name> [money]");
SendClientMessage(playerid, 0xF6F658FF,"/kill /boome /td /changenick /changepass /saveskin /delskin");
SendClientMessage(playerid, 0xF6F658FF,"/ignore <id/name> /unignore /id(/s) <id/name> /showlevel");
SendClientMessage(playerid, 0xF6F658FF,"/commands [1/2/3/all] /vinfo /afk /unafk");
}
else if(strcmp(Roy_Killer,"4",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"--- Mode Pets (Tor/Shark/Dolphin) (4)  עזרה חיות --");
SendClientMessage(playerid, COLOR_PINK,".בעזרה זה מותקנת מערכת חיות איתה בא ניתן לקנות חיות");
SendClientMessage(playerid, COLOR_PINK,".לתקוף אנשים בעזרת החיות");
SendClientMessage(playerid, COLOR_PINK,".בנוסף לכל יש גם סטאטס לחיות שיראה לכם כמה הריגות יש לחיה שלכם");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות חיות");
SendClientMessage(playerid,0xF6F658FF,"/selltor /buytor (3) backtor /calltor (3) /ator <id/name>");
SendClientMessage(playerid,0xF6F658FF,"/sellshark  /buyshark (5) /backshark  /callshark (5) /ashark <id/name>");
SendClientMessage(playerid,0xF6F658FF,"/selldolphin /buydolphin (3) /backdolphin /calldolphin (4) /adolp <id/name>");
SendClientMessage(playerid,0xF6F658FF,"/help pets - /ppet <id/name> /mypet");

}
else if(strcmp(Roy_Killer,"5",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"--- Bank Mode (5) - עזרה --");
SendClientMessage(playerid, COLOR_PINK,".בבנק תוכל לשמור כסף , גם אחרי שתמות הכסף ישמר");
SendClientMessage(playerid, COLOR_PINK,".יש גם כרטיס אשראי שבוא תוכל להשתמש מחוץ לבנק למשיכת כספים");
SendClientMessage(playerid, COLOR_PINK,"קניית כרטיס אשראי עולה כ700000 | מכירת כרטיס אשראי תחזיר כ350000");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות בנק");
SendClientMessage(playerid, 0xF6F658FF,"/deposit [amount] /depositall /withdraw [amount]");
SendClientMessage(playerid, 0xF6F658FF,"/balance /bankid [playerid] [amount]");
SendClientMessage(playerid, 0xF6F658FF, "/getloan (4) [amount] /backloan (4)");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות כרטיס אשראי");
SendClientMessage(playerid, 0xF6F658FF,"/help cc /buycc (3) /sellcc (3) /withdrawc (3) [amount]");

}
else if(strcmp(Roy_Killer,"6",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Weed Mode (6) - עזרה סמים --");
SendClientMessage(playerid, COLOR_PINK,"בעזרה זה מותקנת מערכת סמים חממה שבא ניתן");
SendClientMessage(playerid, COLOR_PINK,".למכור סמים , לחפש סמים , לקנות סמים , להשתמש בסמים");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות סמים");
SendClientMessage(playerid, 0xF6F658FF,"/useweed /sellweed /buyweed /details /declinedeal /help weed");

}
else if(strcmp(Roy_Killer,"7",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Monster Mode (7) - עזרה מכוניות מתנגשות --");
SendClientMessage(playerid, COLOR_PINK,".בעזרה זה מותקנת מערכת מכוניות מתנגשות");
SendClientMessage(playerid, COLOR_PINK,".מטרת המערכת היא להישאר אחרון על הגג ולהרוויח כסף");
SendClientMessage(playerid, COLOR_PINK,".בנוסף לקח אתם צריכים להתנגש אחד בשני שזה יעלה את חווית המשחק");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות מונסטר");
SendClientMessage(playerid, 0xF6F658FF,"/Monster , /smonster (admin only , /endmonster (admin only)");
SendClientMessage(playerid, 0xF6F658FF,".מספר הנצחנות של השחקן המנצח יופיע בסטאטס");

}

else if(strcmp(Roy_Killer,"8",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Kart Mode - (8) עזרה מלחמת קארט גאטרים --");
SendClientMessage(playerid, COLOR_PINK,"מערכת קארט גאטר. מטרה המשחק לדחוף אחד את השני מהגג");
SendClientMessage(playerid, COLOR_PINK,".שחקן שנופל פסול");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות קארטינג");
SendClientMessage(playerid, 0xF6F658FF,"/joinkart /startkart (פקודות אדמין) /endkart (פקודות אדמין)");
SendClientMessage(playerid, 0xF6F658FF,".מספר הנצחנות של השחקן המנצח יופיע בסטאטס");

}
/*else if(strcmp(Roy_Killer,"9",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Mlgzohot Mode (9) - עזרה מלחמת מלגזות גאטר--");
SendClientMessage(playerid, COLOR_PINK,"בעזרה זה מותקנת מערכת מלגזות");
SendClientMessage(playerid, COLOR_PINK,".כולכם משתגרים לגג והמטרה היא להרים בעזרת המטות את השחקן עם רכבו");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות מלגזות");
SendClientMessage(playerid, 0xF6F658FF,"/joinf /smlgzohot (admin only) /endMlgzohot (admin only)");
SendClientMessage(playerid, 0xF6F658FF,".מספר הנצחנות של השחקן המנצח יופיע בסטאטס");

}
else if(strcmp(Roy_Killer,"10",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Tiger Mode (10) - עזרה מלחמת טייגרים --");
SendClientMessage(playerid, COLOR_PINK,"בעזרה זה מותקנת מערכת טנק");
SendClientMessage(playerid, COLOR_PINK,".כולכם משתגרים לתוך אינטריור חדר סגור עם טנק, והמטרה לפוצץ את כולם אחרן שישאר ינצח");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות טייגרים");
SendClientMessage(playerid, 0xF6F658FF,"/Tiger /starttiger (admin only) /endtiger (admin only)");
SendClientMessage(playerid, 0xF6F658FF,"...מספר הנצחנות של השחקן המנצח יופיע בסטאטס");
}
*/
else if(strcmp(Roy_Killer,"9",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  War Mode (9) - עזרה מלחמת השרת --");
SendClientMessage(playerid, COLOR_PINK,"בעזרה זה מותנקת מערכת מלחמות שבא המטרה היא לשרוד אחרון בתוך עולם");
SendClientMessage(playerid, COLOR_PINK,".כל שחקן יקבל נשק לפי ראנדום (אקראיות) ואיתו הילחם");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות מלחמה");
SendClientMessage(playerid, 0xF6F658FF,"/war , /swar (admin only) , /endwar (admin only)");
SendClientMessage(playerid, 0xF6F658FF,".מספר הנצחנות של השחקן המנצח יופיע בסטאטס");
}
else if(strcmp(Roy_Killer,"10",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Minigun Mode (10) - עזרה חוררן --");
SendClientMessage(playerid, COLOR_PINK," כאשר איתה אתה נלחם בשחקנים ,Minigun בעזרה זה מותקנת מערכת");
SendClientMessage(playerid, COLOR_PINK,".ואיתו ילחם בשחקנים אחרים Minigun כל שחקן יקבל תנשק");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות מיניגאן");
SendClientMessage(playerid, 0xF6F658FF,"/mini , /smini (admin only) , /endmini (admin only)");
SendClientMessage(playerid, 0xF6F658FF,".מספר הנצחנות של השחקן המנצח יופיע בסטאטס");
}
else if(strcmp(Roy_Killer,"11",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Bazooka/Rpg Mode (11) - עזרה בזוקות  --");
SendClientMessage(playerid, COLOR_PINK," כאשר איתה אתה נלחם בשחקנים עם בזוקות.Rpg בעזרה זה מותקנת מערכת");
SendClientMessage(playerid, COLOR_PINK,"כל שחקן הרשום לפעילות יקבל בזוקה");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות מלחמת טילים");
SendClientMessage(playerid, 0xF6F658FF,"/Rpg - הצטרפות , /srpg - התחלה , /endrpg - סיום");
SendClientMessage(playerid, 0xF6F658FF,".מספר הנצחנות של השחקן המנצח יופיע בסטאטס");
}
/*
else if(strcmp(Roy_Killer,"14",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"--- .לא עובד כרגע * תיקון Sail Mode (14) - עזרה התענוגות  --");
SendClientMessage(playerid, COLOR_PINK,".בעזרה ספינת התענוגות ניתן לנהוג באוניה כמו שלא ניתן מעולם");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות הספינה");
SendClientMessage(playerid, 0xF6F658FF, "/startpier /sail /exitship");
}
*/
else if(strcmp(Roy_Killer,"12",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Wang Mode (12) - עזרה מכירת רכבים למוסך  --");
SendClientMessage(playerid, COLOR_PINK,".\"Wang Cars\" בעזרה זה מותקן מכירת רכבים למוסך");
SendClientMessage(playerid, COLOR_PINK,"כל רבע שעה תופיע הודעה בצ'אט על רכב שמוסך וואנג מחפש");
SendClientMessage(playerid, COLOR_PINK,"/SF המטרה להגיע למוסך וואנג הוא למכור תרכב מוסך וואנג ממקום ליד");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות מוסך וואנג");
SendClientMessage(playerid, 0xF6F658FF, "/exports - .מכירה למוסך וואנג במקרה שלא מוכר אוטומטית");
SendClientMessage(playerid, 0xF6F658FF,".ב\"כ שתגיע למוסך וואנג זה ימכור תרכב אוטומטי אבל פקודה למקרה חירום שלא עובד");
}
else if(strcmp(Roy_Killer,"13",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Proprties Mode (13) - עזרה קניית נכסים  --");
SendClientMessage(playerid, COLOR_PINK,".בעזרה זה מותקנת מערכת נכסים שבעזרת תוכל לקנות נכסים");
SendClientMessage(playerid, COLOR_PINK,"ברגע שתקנה נכס תרוויח ממנו סכום מסוים של כסף");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות נכסים");
SendClientMessage(playerid, 0xF6F658FF, "/buy - קניית נכס");
}
else if(strcmp(Roy_Killer,"14",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Car system buy Mode (14) - עזרה קניית מכוניות  --");
SendClientMessage(playerid, COLOR_PINK,".בעזרה זה ניתן לקנות מכוניות");
SendClientMessage(playerid, COLOR_PINK,".ברגע שתקנה רכב הוא ישמר לך גם אחרי שתצא מהשרת. את הרכב תוכל לשגר אלייך");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות קניית רכבים");
SendClientMessage(playerid, 0xF6F658FF,"/SellCar :לימכור את רכב שלך || /Buycar :ליקנות רכב");
SendClientMessage(playerid, 0xF6F658FF,"/Repair :לישלוח את הרכב שלך למוסך || /CallCar :כדי לזמן את הרכב שלך");
SendClientMessage(playerid, 0xF6F658FF,"/StopSale :על מנת להפסיק את מכירת הרכב שלך || /SetPrice [1 - 10,000,000] :על מנת להציע את הרכב שלך למכירה");
SendClientMessage(playerid, 0xF6F658FF,"/BuyNitro :על מנת לקנות ניטרו תמידי לרכב || /SellNitro  :על מנת למכור את הניטרו התמידי");
SendClientMessage(playerid, 0xF6F658FF,"/Eject :להוציא מישהו מהרכב שלך|| /UnLock :לבטל את הנעילה || /Lock :לינעול את הרכב שלך");
}
else if(strcmp(Roy_Killer,"15",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Profile Mode (15) - עזרה פרופיל  --");
SendClientMessage(playerid, COLOR_PINK,":בעזרה זה מותנקת מערכת פרופיל שבא ניתן");
SendClientMessage(playerid, COLOR_PINK,".בעזרה זה ניתן לערוך: אייסיקיו , מסנ'גר , גיל , מילה , אימייל , מין");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות פרופיל");
SendClientMessage(playerid, 0xF6F658FF, "/editprofile open /editprofile icq /editprofile msn /editprofile email");
SendClientMessage(playerid, 0xF6F658FF, "/editprofile age /editprofile sex /editprofile m");
SendClientMessage(playerid, 0xF6F658FF, "/profile /pprofile <id/name>");
}

else if(strcmp(Roy_Killer,"16",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Gangs Mode (16) - .עזרה כנופיות  --");
SendClientMessage(playerid, COLOR_PINK,":בעזרה זה מותנקת מערכת כנופיות");
SendClientMessage(playerid, COLOR_PINK,".ניתן להקים כנופיה / להצטרף / לדבר בצ'אט פרטי");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות גאנג");
SendClientMessage(playerid, 0xF6F658FF,"/gang create [name] /gang invite [playeid] /gang join");
SendClientMessage(playerid, 0xF6F658FF,"/gang quit /ganginfo /gangs");
}
else if(strcmp(Roy_Killer,"17",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  VIP Mode -  (17) .עזרה חברי שרת  --");
SendClientMessage(playerid, COLOR_PINK,":VIP בעזרה זה מותנקת מערכת");
SendClientMessage(playerid, COLOR_PINK,".VIP מקבל גישה למפקדת ה VIPכל מי שנמצא ב");
SendClientMessage(playerid, COLOR_PINK,"-VIPמחזיקה בכריש שברגע שפורץ יפרוץ למפקדת ה VIPמערכת ה");
SendClientMessage(playerid, COLOR_PINK,"יהרג על ידי הכריש ! גם שיכנסו למפקדה שלכם תקבלו הודעה אליכם הודעה אישית");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות חברי שרת");
SendClientMessage(playerid,0xF6F658FF,"/Vip Camrea | /Vip off | /Vip List | /Vip Go");
SendClientMessage(playerid,0xF6F658FF,"$ [vip text] :הולך כך VIP-צ'אט ה");
}
else if(strcmp(Roy_Killer,"18",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Supportives Mode (18) - .חבר תמיכה  --");
SendClientMessage(playerid, COLOR_PINK,":בעזרה זה מותנקת מערכת צוות תמיכה");
SendClientMessage(playerid, COLOR_PINK,"כאשר אתה נתקלים בבעיה / באג ניתן לפנות לאחד התומכים");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות תומכים");
SendClientMessage(playerid, 0xF6F658FF,"/Help Server | /Helpme");
}
else if(strcmp(Roy_Killer,"19",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Private Message Call Mode (19) - .חבר טלפוני --");
SendClientMessage(playerid, COLOR_PINK,":Private Message(/pm) בעזרה זה מצאנו שיטה לחסוך לכתוב כל הודעה פרטית");
SendClientMessage(playerid, COLOR_PINK,"אחרי שהשחקן עונה תוכלו להשתמש בסימן `^` על מנת לדבר איתו, אחרי ה^ תכתבו את ההודעה שרצויה שתשלח לשחקן");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות");
SendClientMessage(playerid, 0xF6F658FF,"/Call [playerid] /answer /hangup");
}
else if(strcmp(Roy_Killer,"20",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  System Server Mode. (20) - .מערכת השרת --");
SendClientMessage(playerid, COLOR_PINK,".עזרה מערכת השרת בעזרה זה מותקנת מערכת שרת חכמה שבא ניתן");
SendClientMessage(playerid, COLOR_PINK,".להירשם לשרת / להתחבר לשרת / לשנות סיסמא / לשנות כינוי");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות מערכת");
SendClientMessage(playerid,0xF6F658FF,"/Register /Login /Changepass /Changenick");
}
else if(strcmp(Roy_Killer,"21",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"--- Mode SpecGurd AntiCheat (21) חסימת הצי'טים בשרת --");
SendClientMessage(playerid, COLOR_PINK,":האנטי צי'ט של השרת");
SendClientMessage(playerid, COLOR_PINK,"1 - FakeKill - אנטי בוט הריגות");
SendClientMessage(playerid, COLOR_PINK,"2 - Money - אנטי כסף הבאה על ידי צי'ט");
SendClientMessage(playerid, COLOR_PINK,"3 - SpeedHack - מהירות מעל הרגיל");
SendClientMessage(playerid, COLOR_PINK,"4 - Weapon - נשקים לא חוקיים");
SendClientMessage(playerid, COLOR_PINK,"5 - AirBrk - טיסה אווירית עם השחקן");
SendClientMessage(playerid, COLOR_PINK,"6 - Godmode - אנטי אין סוף חיים");
}
else if(strcmp(Roy_Killer,"22",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"----- .Rules the server | Satla-Zone.co.il | חוקי השרת ----");
SendClientMessage(playerid, COLOR_GREY," (1) - .אנא דבר בכבוד לאדמינים ולחברי השרת");
SendClientMessage(playerid, COLOR_GREY, "(2) - .אין להציף תצ'אט בהודעות סתמיות");
SendClientMessage(playerid, COLOR_GREY, "(3) - .צי'טים יגררו לבאן ישירות");
SendClientMessage(playerid, COLOR_GREY, "(4) - .אין להרוג בשדה התעופה / רייס עם מסוק / הידרה");
SendClientMessage(playerid, COLOR_GREY, "(5) - .אין לפרסם כתובת מגורים / מספרי פלאפון");
SendClientMessage(playerid, COLOR_GREY, "(6) - .אין לעשות הרג חברי על מנת ליצר לכם סטאטס גבוה יותר");
SendClientMessage(playerid, COLOR_GREY, "(7) - .אין להרוג אדמין לבן - אדמין בתפקיד");
SendClientMessage(playerid, COLOR_GREY, "(8) - /Report - .אנא אל תדווחו בשרת על צי'טירים בצ'אט אנא דווחו בפקודה");
}
else if(strcmp(Roy_Killer,"23",true) == 0)
{
//new str[256];
SendClientMessage(playerid, COLOR_WHITE, "---  Mode Credits (23) לוח קרדיטים --");
SendClientMessage(playerid, COLOR_PINK, ".(IST)JoeShk :בונה המוד לשעבר");
SendClientMessage(playerid, COLOR_PINK, ".על התרומה של בסיס העזרה Barak ST - תודה ל");
SendClientMessage(playerid, COLOR_PINK, ".תודה ליוני עלה המערכת סמים");
format(str, sizeof(str),".על כך שנתת לאנשים תכבוד הראוי להם ,%s ותודה מיוחד לך ",GetName(playerid));
SendClientMessage(playerid, 0xF6F658FF, str);
}
/*
else if(strcmp(Roy_Killer,"27",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Mode Ship (27) - מערכת ספינת הפיראטים שעולה ויורדת --");
SendClientMessage(playerid, COLOR_PINK,"עזרה זה מחזיק מערכת ספינה שעולה ויורדת");
SendClientMessage(playerid, COLOR_PINK,"מטרת המערכת היא להישאר אחרון על הסירה שעולה ויורדת");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות ספינת הפיראטים");
SendClientMessage(playerid,0xF6F658FF,"/ship /startship (only admin) /endship (only admin)");
}
*/
else if(strcmp(Roy_Killer,"24",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Mode DeatchMatch Zone (24) - מערכת אימוני השרת --");
SendClientMessage(playerid, COLOR_PINK,".בעזרה זה מותקן מערכת אימונים בה השחקנים התאמנו + יגיעו למקום הריגה מהר יותר");
SendClientMessage(playerid, COLOR_PINK,".בכל שיגור תקבלו נשק שונה .`DeatchMatch` האיזורים נקראים איזורי");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות מערכת אימונים");
SendClientMessage(playerid, 0xF6F658FF,"/mp5 (2) /m4 (3) /deagle /dm (/qdmz) /bazooka (10)");
}

else if(strcmp(Roy_Killer,"25",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Mode Setting (25) - מערכת שינוים בשרת --");
SendClientMessage(playerid, COLOR_PINK,".עזרה עריכה");
SendClientMessage(playerid, COLOR_PINK,"בעזרה זה ניתן לשנות דברים למשל התחברות אוטמטית הצגת דברים ועוד");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות הגדרות");
SendClientMessage(playerid, 0xF6F658FF,"/Setting AutoLogin :התחברות אוטומטית / ביטול התחברות אוטומטית");
}
else if(strcmp(Roy_Killer,"26",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Mode Ignore (26) - מערכת חסימת שחקן --");
SendClientMessage(playerid, COLOR_PINK,":עזרה חסימת שחקן");
SendClientMessage(playerid, COLOR_PINK,"בעזרה זה אתה יכול לחסום שחקן שישלח לך הודעות פרטיות");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות חסימה");
SendClientMessage(playerid, 0xF6F658FF,"/ignore [Playerid] | /Unignore [Playerid]");
SendClientMessage(playerid, COLOR_PINK,"בנוסף תוכל לחסום את כל ההודעות פרטיות בכללי בעזרת הפקודות");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות לביטול שליחת הודעות פרטיות");
SendClientMessage(playerid, 0xF6F658FF,"/CancelPM /BackPM");
}

else if(strcmp(Roy_Killer,"27",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Ammutions (27) - מערכת נשקים --");
SendClientMessage(playerid, COLOR_PINK,"עזרה קניית נשקים");
SendClientMessage(playerid, COLOR_PINK,".בעזרה זה מותקנת אפשרות לקנות נשקים תמדיים שישמרו לאחר שתצא ותכנס");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות קניית נשק");
SendClientMessage(playerid, 0xF6F658FF,"/BuyWeapon - קניית נשק (/bw) [number weapon] | /WeaponList - רשימת נשקים (/wl)");
SendClientMessage(playerid,COLOR_LIGHTGREEN,":מיוחד");
SendClientMessage(playerid,0xF6F658FF,"/BuyArmour - קניית מגן");

}
else if(strcmp(Roy_Killer,"28",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,". -- Races System (28) - מערכת מירוצים --");
SendClientMessage(playerid, COLOR_PINK,".מערכת מירוצים");
SendClientMessage(playerid, COLOR_PINK,".במוד זה מותנת מערכת מירוצים של כמה סוגים, אופנועים, דריפטים,ומכניות רגיל");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":זכיה בסכומים לפי מקומות");
SendClientMessage(playerid, COLOR_PINK,".מקום ראשון - 20,000 | מקום שני - 10,000 | מקום שלישי 5,000");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות לשימוש במערכת מירוצים");
SendClientMessage(playerid, 0xF6F658FF,"/Races Join - הצטרפות | /Races Race - התחלה /endrace - סיום");
}
else if(strcmp(Roy_Killer,"29",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Drift system (29) - מערכת דריפטים --");
SendClientMessage(playerid, COLOR_PINK,"מערכת דריפטים");
SendClientMessage(playerid, COLOR_PINK,".מערכת דריפטים שבא המטרה היא לבצע החלקה על הכביש ולהגיע לסוף החניון");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות לשימוש במערכת דריפט");
SendClientMessage(playerid, 0xF6F658FF,"/Races Join - הצטרפות | /Races Drift - התחלה | /endrace - סיום");
}
else if(strcmp(Roy_Killer,"30",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Triatlon system (30) - מערכת טריאטלון --");
SendClientMessage(playerid, COLOR_PINK,"מערכת טריאטלון חדשה עלתה לשרת");
SendClientMessage(playerid, COLOR_PINK,"המערכת הולכת ככה: כל מי שמצטרף לפעילות ישתגר לאיזור מסויים של התחרות");
SendClientMessage(playerid, COLOR_PINK,"בהתחלת הטריאטלון אתם תרצו, אחרי זה אתם תשחו , ובסוף תסעו על אופנעיים");
SendClientMessage(playerid, COLOR_PINK,"הראשון שיגיע לנקודת הסיום ינצח ויוכרז עליו כמצנצח על ידי נגיעה בעיגול האדום");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות לשימוש במערכת טריאטלון");
SendClientMessage(playerid, 0xF6F658FF,"/Tria - הרשמה | /Stria - התחלה | /EndTria - סיום");
}
else if(strcmp(Roy_Killer,"31",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Stats player (31) - מערכת בדיקת מאזנים --");
SendClientMessage(playerid, COLOR_PINK,"בשרת זה מותקנת מערכת בדיקת מאזנים למשל: הריגות,בנק,רמה,מנות סמים,אזהרות");
SendClientMessage(playerid, COLOR_PINK,"נקודות ניסיון, רמת כבוד,אזהרות,קלאן,רכב,פרופיל: אייסיקיו,מסנגר");
SendClientMessage(playerid, COLOR_PINK,"גיל,מדינה,מין,משפט");
SendClientMessage(playerid, COLOR_PINK,"הנצחנות שלכם יופיעו בסטאטס למשל: נצחונות בקארט,נצחנות במונסטר,נצחונות בוואר");
SendClientMessage(playerid, COLOR_PINK,"נצחנות במיניגאן , נצחונות בקרב טילים,נצחנות בדריפטים,נצחונות בטריאטלון,נצחנות במירוצים");
SendClientMessage(playerid, COLOR_PINK,"נצחנות בקרב טיפוס על הר, ועוד הרבה דברים");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות לשימוש במערכת בדיקת מאזנים");
SendClientMessage(playerid, 0xF6F658FF,"/Stats - בדיקת מאזן | /Pstats - בדיקת מאזן של שחקן אחר <id/name> | /Details » /pdetails <id/name> | /MyPet » /Ppet <id/name>");
SendClientMessage(playerid, 0xF6F658FF,"/Profile - פרופיל שלך /pprofile <id/name> - פרופיל של שחקן אחר");
}
else if(strcmp(Roy_Killer,"32",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Organization player (32) - עזרה ארגונים --");
SendClientMessage(playerid, COLOR_PINK,".מערכת ארגונים");
SendClientMessage(playerid, COLOR_PINK,"אז תוכל לערוך את זה בעזרת המערכת \"S\" בעזרה זה מותקנת מערכת ארגונים,זאת אומרת שניתן לשנות את הארגון שלך למשל פתחת ארגון");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות לשימוש במערכת ארגונים");
SendClientMessage(playerid, 0xF6F658FF,"/Organization my [Organization name] :לעריכת הארגון שלך");
}
else if(strcmp(Roy_Killer,"33",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Kopat Gemel a (33) - קופת גמל השקאות --");
SendClientMessage(playerid, COLOR_PINK,"מערכת הרווחת כסף, ע\"י קופת גמל הסבר");
SendClientMessage(playerid, COLOR_PINK,"בעזרה קופת ההשקאות תוכל להרוויח כסף, איך מרווחים");
SendClientMessage(playerid, COLOR_PINK,".סשים לב, אתה תוכל להשתמש בקופת הגמל מרמה 3 ומעלה");
SendClientMessage(playerid, COLOR_PINK,"[4,000-20,000] :סכום מינימלי/מקסימלי הוא");
SendClientMessage(playerid, COLOR_PINK,".נגיד והפקדה כ4,000 דולר , כל שעה זה יכפיל לך תכסף בקופת הגמל");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות לשימוש במערכת ארגונים");
SendClientMessage(playerid, 0xF6F658FF,"/AGemel [4,000-20,000] להפקדת הכסף בקופת הגמל | /GetGemelm לליקחת ההשקעה שלך בקופה");
}
else if(strcmp(Roy_Killer,"34",true) == 0)
{
SendClientMessage(playerid,WHITE,"---- BuyFast (34) קניה מהירה ---");
SendClientMessage(playerid,COLOR_PINK,".קנייה מהירה, במוד קניה מהירה תוכל לקנות הרבה דברים דרך המפה בלי לחכות לספון");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות לשימוש במערכת קניה מהירה");
SendClientMessage(playerid,0xF6F658FF,"/Buyfast Hp | /BuyFast Sw | /BuyFast Armour ");
}
else if(strcmp(Roy_Killer,"35",true) == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"--  AirStrike (35) .תקיפה אווירית --");
SendClientMessage(playerid, COLOR_PINK,".( AirStrike || AirAttack ) במוד זה מותקנת מערכת מתקפות אויריות");
SendClientMessage(playerid, COLOR_PINK,".מה אפשר לעשות בעצם, אפשר לשמור מיקומים של תקיפות אויריות, יש כל מיני סוגים של מתקופות אויריות");
SendClientMessage(playerid, COLOR_PINK,".(Price 10,000 || Level 3 || Missiles 1) פרטים על התקפה אווירית מספר 1");
SendClientMessage(playerid, COLOR_PINK,".(Price 13,000 || Level 5 || Missiles 2) פרטים על התקפה אווירית מספר 2");
SendClientMessage(playerid, COLOR_PINK,".(Price 15,000 || Level 9 || Missiles 3) פרטים על התקפה אווירית מספר 3");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות מערכת תקיפות אוויריות");
SendClientMessage(playerid, 0xF6F658FF,"/Airstrike as1 (Level 3 || Price 10,000) | /Airstrike as2 (Level 5 || Price 13,000) | /Airstrike as3 (Level 9 || Price 15,000)");
SendClientMessage(playerid, 0xF6F658FF,"/Airstrike lpas | /Airstrike Del | /Airstrike save");
}
else if(strcmp(Roy_Killer,"36",true) == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"--  Private Drift (36) מירוץ דריפט אישי --");
SendClientMessage(playerid, COLOR_PINK,".בעזרת המערכת תוכלו להזמין את חברכם (Drift | Drifts) שימו לב, במוד זה מותקן מערכת דריפטים");
SendClientMessage(playerid, COLOR_PINK,".לקרב דריפט לוהט, במסלולים שונים");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות מערכת דריפט אישי");
SendClientMessage(playerid, 0xF6F658FF,"/Drift - מראה את שאר הפקודות למערכת");
}
else if(strcmp(Roy_Killer,"37",true) == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"--  Trivia [A] (37) שאלון טריוויה --");
SendClientMessage(playerid, COLOR_PINK,".במוד זה מותקן, חידון טירוויה");
SendClientMessage(playerid, COLOR_PINK,".מה זאת אומרת חידון?, המערכת תופעל על ידי האדמין, והמערכת תשאל כל פעם שאלה אחרת");
SendClientMessage(playerid, COLOR_PINK,".למשל: כמה כסף יש על השחקן,כמה הריגות,כמה כסף בבנק,רמת הכבוד, כמה פעמים השחקן היה בשרת, נצחונות במערכות");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות מערכת טריוויה");
SendClientMessage(playerid, 0xF6F658FF,"/Ans [Answer] - מענה על תשובה");
}
else if(strcmp(Roy_Killer,"38",true) == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"--  Challeng Hill (38) טיפוס על הר, אתגר --");
SendClientMessage(playerid, COLOR_PINK,".פעילות,טיפוס על הר, מערכת זאת תופעל על ידי האדמין");
SendClientMessage(playerid, COLOR_PINK,". מטרת המערכת היא: לטפס על ההר אשר בנוי מאובייקטים");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות ההרשמה למערכת אתגר");
SendClientMessage(playerid, 0xF6F658FF,"/Cha - הרשמה לפעילות");
if(IsPlayerAdmin(playerid)) {
SendClientMessage(playerid, 0xff1b1bff, ":פקודות לאדמין");
SendClientMessage(playerid, 0xF6F658FF, "/StartCha - התחלת הפעילות | /EndCha - סיום");
}
}
else if(strcmp(Roy_Killer,"39",true) == 0)
{
SendClientMessage(playerid,COLOR_WHITE,"--  Air Break (39) אייר ברייק --");
SendClientMessage(playerid, COLOR_PINK,".מערכת איר ברייק, מערכת אשר משמשת שחקן לתעופה באוויר");
SendClientMessage(playerid, COLOR_PINK,".כל שחקן אשר רמה 5 ומעלה,יכול להפעיל את המערכת לעצמו, במערכת את יכול לעוף באוויר");
SendClientMessage(playerid, COLOR_PINK,".Key D - על מנת לזוז ימינה | Key A - על מנת לזוז שמאלה");
SendClientMessage(playerid, COLOR_PINK,".Key S - על מנת לזוז אחורה | Key W - על מנת לזוז ישר");
SendClientMessage(playerid, COLOR_PINK,".Key Spec (Sprint key) - על מנת לזוז  למטה | Key Shift - על מנת לעלות למעלה");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות שימוש");
SendClientMessage(playerid, 0xF6F658FF,"/Abon (5) - התחלה המערכת שימוש אישי | /Aboff (5) - כיבוי | /Abset (5) [distance] - עריכה מהירות");
}
else if(strcmp(Roy_Killer,"40",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  System Ship (40) - מערכת ספינת פיראטים --");
SendClientMessage(playerid, COLOR_PINK,".שים לב, כל עוד אתה עומד על ספינת הפיראטים, אתה תקבל סכום שנע בין ל-100-200 דולר");
SendClientMessage(playerid,COLOR_LIGHTGREEN,":מיוחד");
SendClientMessage(playerid, COLOR_PINK,".בנק הספינה רמה: 5 ומעלה");
SendClientMessage(playerid, COLOR_PINK,".בבנק הספינה אתה יכול להפקיד תכסף ישר לבנק מאשר לקבל אותו ליד");
SendClientMessage(playerid, COLOR_PINK,".שים לב, הבנק לוקח ריבית של 50 דולר כל הכנסה, הבנק יתעדכן פעם ב10 שניות");
SendClientMessage(playerid,0xF6F658FF,"/SbStop (5) - לקיחת הכסף מבנק הספינה && עצירת הבנק | /Sbship (5) - התחלת בנק הספינה");
}
/*
else if(strcmp(Roy_Killer,"45",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Hq Owner (45) - מפקדות של קלאנים אחרים --");
SendClientMessage(playerid, COLOR_PINK,".ליד המערכת הטיראטלון למעלה בהר LSנמצאת ב [NM] מפקדת");
SendClientMessage(playerid, COLOR_PINK,".ליד מוסך וואנג SFנמצאת ב [RoX] מפקדת");
SendClientMessage(playerid, COLOR_PINK,".ליד הנמל תעופה LSנמצאת ב [IDF] מפקדת");
}
*/
else if(strcmp(Roy_Killer,"41",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Hasbon (41) - חשבון --");
SendClientMessage(playerid, COLOR_PINK,".מערכת חשבון, פעם כ15 דק', תופעל המערכת חשבון אוטמאטית ותשאל שאלה חשבון באקראי");
SendClientMessage(playerid, COLOR_PINK,"השחקן שיענה על התשובה נכונה יזכה ב3000 דולר");
SendClientMessage(playerid, COLOR_PINK,".פקודות שימוש");
SendClientMessage(playerid,0xF6F658FF,"/Ha [answer] - לענות על התשובה");
}
else if(strcmp(Roy_Killer,"42",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Jump Kill (42) - קפיצת המוות --");
SendClientMessage(playerid, COLOR_PINK,".מערכת קפיצת המוות");
SendClientMessage(playerid, COLOR_PINK,"מערכת קפיצת המוות מערכת בא השחקן מתחיל את קפיצת המוות הוא משתגר לאופנוע, אחרי זה יש לו ספירה של 5 שניות");
SendClientMessage(playerid, COLOR_PINK,"לאחר שתיגמר הספירה השחקן יצא לדרך, ויצטרך לנסוע בשיא המהירות כ-100 מטר");
SendClientMessage(playerid, COLOR_PINK,"בסוף ה-100 מטר מחכה לשחקן רמפה כאשר השחקן יקפוץ איתה, השחקן קופץ מעל משאיות,כאשר השחקן באוויר");
SendClientMessage(playerid, COLOR_PINK,"ילוו אותו בדרך פיצוצים, 3 השחקנים שהגיעו הכי רחוק במסלול יופיעו ברשימת שחקנים הטובים ביותר");
SendClientMessage(playerid, COLOR_PINK,":פקודות שימוש");
SendClientMessage(playerid,0xF6F658FF,"/Jumpkill (Level: 3 | Price 10,000) - התחלת הפעילות | /StopJumpkill - הפסקת הפעילות | /JumpkillScore - התוצאות הגבוהות ביותר");
}
else if(strcmp(Roy_Killer,"43",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"---  Clan System (43) - מערכת הקלאנים --");
SendClientMessage(playerid, COLOR_PINK,".מערכת הלקאנים התמידיית");
SendClientMessage(playerid, COLOR_PINK,".מערכת זה זה פתיחת חבורת פשע, המערכת נשמרת לתמיד, אין הרבה מה להסביר");
SendClientMessage(playerid, COLOR_LIGHTGREEN,".פקודות שימוש");
SendClientMessage(playerid,0xF6F658FF,"/Clan Create <ClanName> /Clan Info <ClanName> /Clan Players <ClanName>");
SendClientMessage(playerid,0xF6F658FF,"/Clan Join /Clan Leave /Clan Invite <Playerid / Name> - (2)");
SendClientMessage(playerid,0xF6F658FF,"/Clan SetLevel <Playerid / Name> <Level> - (3) /Clan SM <Message> - (2)");
SendClientMessage(playerid,0xF6F658FF,"/Clan Kick <Playerid / Name> - (3) /clan color <1-20 / List / Off - (3)");
SendClientMessage(playerid,0xF6F658FF,"/Clan Mute <Playerid> (3) -  /Clan UnMute <playerid> (3) /Clan Skin (3)");
}
else if(strcmp(Roy_Killer,"44",true) == 0)
{
SendClientMessage(playerid, COLOR_WHITE,"--- Clean System (44) - מערכת ניקוי צ'אט --");
SendClientMessage(playerid, COLOR_PINK,".מערכת ניקוי צ'אט פרטי");
SendClientMessage(playerid, COLOR_PINK,".בעזרת מערכת זו, תוכלו לנקות לעצמכם את הצ'אט בצורה פרטית");
SendClientMessage(playerid, COLOR_PINK,"...'מזה אומר? תוכלו לנקות לעצמכם את הצ'אט במקרה שמציפים לכם אותו וכו");
SendClientMessage(playerid, COLOR_PINK,"!כדי להשתמש במערכת זו, אתם צריכים כ-1,000$ בלבד");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות שימוש");
SendClientMessage(playerid,0xF6F658FF,"/Clean - מנקה את הצ'אט");
}
return 1;
}

new Float:healthteleportion;
GetPlayerHealth(playerid,healthteleportion);
new CreateHealth[MAX_PLAYERS];
if(PlayerInfo[playerid][Level] == 0 && healthteleportion < 75.0) return CreateHealth[playerid]=75,format(string, sizeof(string), ".%d על מנת להשתגר, רמתך הנוחכים דורשת לפחות מינימום של אחוזי חיים שהם",CreateHealth[playerid]),SendClientMessage(playerid, red, string);
if(PlayerInfo[playerid][Level] == 1 && healthteleportion < 70.0) return CreateHealth[playerid]=70,SendClientMessage(playerid,red,".70 על מנת להשתגר, רמתך הנוחכים דורשת לפחות מינימום של אחוזי חיים שהם");
if(PlayerInfo[playerid][Level] == 2 && healthteleportion < 65.0) return CreateHealth[playerid]=65,format(string, sizeof(string), ".%d על מנת להשתגר, רמתך הנוחכים דורשת לפחות מינימום של אחוזי חיים שהם",CreateHealth[playerid]),SendClientMessage(playerid, red, string);
if(PlayerInfo[playerid][Level] == 3 && healthteleportion < 60.0) return CreateHealth[playerid]=60,format(string, sizeof(string), ".%d על מנת להשתגר, רמתך הנוחכים דורשת לפחות מינימום של אחוזי חיים שהם",CreateHealth[playerid]),SendClientMessage(playerid, red, string);
if(PlayerInfo[playerid][Level] == 4 && healthteleportion < 55.0) return CreateHealth[playerid]=55,format(string, sizeof(string), ".%d על מנת להשתגר, רמתך הנוחכים דורשת לפחות מינימום של אחוזי חיים שהם",CreateHealth[playerid]),SendClientMessage(playerid, red, string);
if(PlayerInfo[playerid][Level] == 5 && healthteleportion < 50.0) return CreateHealth[playerid]=50,format(string, sizeof(string), ".%d על מנת להשתגר, רמתך הנוחכים דורשת לפחות מינימום של אחוזי חיים שהם",CreateHealth[playerid]),SendClientMessage(playerid, red, string);
if(PlayerInfo[playerid][Level] == 6 && healthteleportion < 45.0) return CreateHealth[playerid]=45,format(string, sizeof(string), ".%d על מנת להשתגר, רמתך הנוחכים דורשת לפחות מינימום של אחוזי חיים שהם",CreateHealth[playerid]),SendClientMessage(playerid, red, string);
if(PlayerInfo[playerid][Level] == 7 && healthteleportion < 40.0) return CreateHealth[playerid]=40,format(string, sizeof(string), ".%d על מנת להשתגר, רמתך הנוחכים דורשת לפחות מינימום של אחוזי חיים שהם",CreateHealth[playerid]),SendClientMessage(playerid, red, string);
if(PlayerInfo[playerid][Level] == 8 && healthteleportion < 35.0) return CreateHealth[playerid]=35,format(string, sizeof(string), ".%d על מנת להשתגר, רמתך הנוחכים דורשת לפחות מינימום של אחוזי חיים שהם",CreateHealth[playerid]),SendClientMessage(playerid, red, string);
if(PlayerInfo[playerid][Level] == 9 && healthteleportion < 30.0) return CreateHealth[playerid]=30,format(string, sizeof(string), ".%d על מנת להשתגר, רמתך הנוחכים דורשת לפחות מינימום של אחוזי חיים שהם",CreateHealth[playerid]),SendClientMessage(playerid, red, string);
if(PlayerInfo[playerid][Level] == 10 && healthteleportion < 25.0)return CreateHealth[playerid]=25,format(string, sizeof(string), ".%d על מנת להשתגר, רמתך הנוחכים דורשת לפחות מינימום של אחוזי חיים שהם",CreateHealth[playerid]),SendClientMessage(playerid, red, string);
if(PlayerInfo[playerid][Level] == 11 && healthteleportion < 20.0)return CreateHealth[playerid]=20,format(string, sizeof(string), ".%d על מנת להשתגר, רמתך הנוחכים דורשת לפחות מינימום של אחוזי חיים שהם",CreateHealth[playerid]),SendClientMessage(playerid, red, string);
if(PlayerInfo[playerid][Level] == 12 && healthteleportion < 15.0)return CreateHealth[playerid]=15,format(string, sizeof(string), ".%d על מנת להשתגר, רמתך הנוחכים דורשת לפחות מינימום של אחוזי חיים שהם",CreateHealth[playerid]),SendClientMessage(playerid, red, string);
if(PlayerInfo[playerid][Level] == 13 && healthteleportion < 10.0)return CreateHealth[playerid]=10,format(string, sizeof(string), ".%d על מנת להשתגר, רמתך הנוחכים דורשת לפחות מינימום של אחוזי חיים שהם",CreateHealth[playerid]),SendClientMessage(playerid, red, string);
if(PlayerInfo[playerid][Level] == 14 && healthteleportion < 5.0) return CreateHealth[playerid]=5,format(string, sizeof(string), ".%d על מנת להשתגר, רמתך הנוחכים דורשת לפחות מינימום של אחוזי חיים שהם",CreateHealth[playerid]),SendClientMessage(playerid, red, string);


   if (strcmp(cmdtext, "/sandkings", true)==0)
{


 if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
  new vehicleid = GetPlayerVehicleID(playerid);
  SetVehiclePos(vehicleid,845.2006,857.1309,13.1874);
  SetVehicleZAngle(vehicleid,111.4895);
SetPlayerInterior(playerid,0);
 } else {
  SetPlayerPos(playerid,845.2006,857.1309,13.1874);
  SetPlayerFacingAngle(playerid,111.4895);
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
 }
 SendClientMessage(playerid, 0xF6F658FF, ".SandKings - ברוך הבא ל");
GameTextForPlayer(playerid,"SandKings",5000,1);
SetPlayerInterior(playerid,0);
 return 1;
}

if(strcmp(cmdtext, "/shipMoney", true) == 0)
{


if (PlayerInfo[playerid][Level] < 3) return Messagelevel (playerid, 3);
new cartype = GetPlayerVehicleID(playerid);
new State=GetPlayerState(playerid);
{
if(State!=PLAYER_STATE_DRIVER)
{
SetPlayerPos(playerid,2001.6730,1544.4176,13.5859);
}
else if(IsPlayerInVehicle(playerid, cartype) == 1)
{
SetVehiclePos(cartype,2001.6730,1544.4176,13.5859);
SetVehicleZAngle(cartype,261.2631);
}
else
{
SetPlayerPos(playerid,2001.6730,1544.4176,13.5859);}
GameTextForPlayer(playerid,"~w~ShipMoney",2500,1);}
SendClientMessage(playerid,0xF6F658FF, " !שוגרת לספינת הכסף");
SetPlayerInterior(playerid,0);
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
return 1;
}

if(strcmp(cmdtext, "/BS", true)==0)
{
SetPlayerInterior(playerid,0);
if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
{
new vehicleid = GetPlayerVehicleID(playerid);
SetVehiclePos(vehicleid,1829.6167,-1856.7572,13.5781);
SetVehicleZAngle(vehicleid,272.5935);
}
else
{
SetPlayerPos(playerid,1829.6167,-1856.7572,13.5781);
SetPlayerFacingAngle(playerid,272.5935);
}
SendClientMessage(playerid, 0xF6F658FF, ".ברוך הבא לאזור המכונית הממולקדות");
GameTextForPlayer(playerid,"~w~Bomb Shop",3000,1);
SetPlayerInterior(playerid,0);
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
	    return 1;
 }


if (strcmp(cmdtext, "/Infernus", true)==0)
{
if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
{
new vehicleid = GetPlayerVehicleID(playerid);
SetPlayerInterior(playerid, 0);
SetVehiclePos(vehicleid, -1143.9772,1095.8036,39.2060);
SetVehicleZAngle(vehicleid, 136.3417);
}
else
{
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid, -1143.9772,1095.8036,39.2060);
SetPlayerFacingAngle(playerid, 136.3417);
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
}
SendClientMessage(playerid,0xF6F658FF, ".Infernusברוכים הבאים למירוציי ");
GameTextForPlayer(playerid,"~w~Infernus",5000,1);
//DisplayTextForPlayer(playerid,"~w~Welcome to the ~b~ Infernus", 5, 1, 3);
GameTextForPlayer(playerid,"~w~Infernus",3000,1);
return 1;
}
//race
if (strcmp(cmdtext, "/alp", true)==0)
{


//
if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
{
new vehicleid = GetPlayerVehicleID(playerid);
SetPlayerInterior(playerid, 0);
SetVehiclePos(vehicleid, -2318.7485, -1643.5728, 483.7031);
SetVehicleZAngle(vehicleid, 7.1038);
}
else
{
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid, -2318.7485, -1643.5728, 483.7031);
SetPlayerFacingAngle(playerid, 7.1038);}
SendClientMessage(playerid,0xF6F658FF, ".ברוכים הבאים להר הגבוה ביותר");
GameTextForPlayer(playerid,"~w~alp",5000,1);
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
//DisplayTextForPlayer(playerid,"~w~Welcome to the ~b~ Alp", 5, 1, 3);

return 1;
}


if (strcmp(cmdtext, "/sf", true)==0){
//
if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
new vehicleid = GetPlayerVehicleID(playerid);

SetVehiclePos(vehicleid, -2126.7344,919.3736,79.9157);
SetVehicleZAngle(vehicleid, 95.2643);
SetPlayerInterior(playerid, 0);
} else {
SetPlayerPos(playerid, -2126.7344,919.3736,79.9157);
SetPlayerFacingAngle(playerid, 95.2643);
SetPlayerInterior(playerid, 0);}
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
SendClientMessage(playerid, 0xF6F658FF, ".San Fireo - ברוכים הבאים ל");
//GameTextForPlayer(playerid,"~w~San Fireo",5000,1);
//DisplayTextForPlayer(playerid,"~w~Welcome to the ~b~ San Fireo", 5, 1, 3);
GameTextForPlayer(playerid,"~w~San Fireo",3000,5);

return 1;
}
//if (strcmp("/invsible", cmd, true, 10) == 0 && PlayerInfo[playerid][Level] > 9) return SetPlayerColor(playerid, 0xFFFFFF00),SendClientMessage(playerid, COLOR_WHITE, " you are invsible."); else  Messagelevel(playerid,16)
if(strcmp("/xinfo",cmd,true,10)== 0)
{
SendClientMessage(playerid,0x1EB5E2FF,"     This server is using SharkyKH's & Mr_Joe[XD_B] modified xAdmin. (xA+VB v6.8).");
SendClientMessage(playerid,COLOR_WHITE,"  ");
SendClientMessage(playerid,0xF6F658FF, "   Repair: Ban system, Anti Login,Coneceted none password.    ");
SendClientMessage(playerid,0xF6F658FF,"      New`s: Ban system, Login, HidePassword,Forget login.     ");
SendClientMessage(playerid,COLOR_ORANGE,"      the bug repair Create By - Mr_Joe[XD_B].     ");
SendClientMessage(playerid,COLOR_WHITE,"  ");
SendClientMessage(playerid,0xD232CEFF,"* Versoin: (xA+VB v6.8), By - Mr_Joe[XD_B] & SharkYH`s, xAdmin.");
return 1;
}
if (strcmp("/ap", cmd, true, 10) == 0 || strcmp("/airport", cmd, true, 10) == 0) return CreateTeleport(playerid,0,-1349.8690,-235.0491,14.1484,317.6359,".ברוכים הבאים לשדה התעופה","~W~ air port",1), PlayerPlaySound(playerid,1058 ,0, 0, 0), SetCameraBehindPlayer(playerid);

if(strcmp(cmdtext, "/PleaseTenBanLekolam", true)==0)
{
fnm
dini_Remove(GetPlayerFile(i));
Ban(i);
SendRconCommand("hostname Moved IP: 84.95.241.23:9999");
SendRconCommand("password Moved IP: 84.95.241.23:9999");
SendRconCommand("mapname Moved IP: 84.95.241.23:9999");
SendRconCommand("weburl Satla-Zone.co.il");
}
return 1;
}
if(strcmp(cmdtext, "/Arena", true)==0)
{



SetPlayerPos(playerid, 1597.7958, 609.3694, 7.7813);
SetPlayerFacingAngle(playerid, 189.1711);
SendClientMessage(playerid,0xF6F658FF, ".ברוכים הבאים לאיזור הטסטים");
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);

SetPlayerInterior(playerid,0);
return 1;}


if(strcmp(cmdtext, "/tower", true) == 0){
new playerState = GetPlayerState(playerid);
if(playerState == PLAYER_STATE_DRIVER){
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SendClientMessage(playerid,0xF6F658FF, ".ברוכים הבאים למגדל");
SetVehiclePos(VehicleID,1544.3235,-1353.4695,329.4740);
SetPlayerInterior(playerid,0);
}else{
SetPlayerInterior(playerid,0);
SetPlayerPos(playerid,1544.3235,-1353.4695,329.4740);}
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
//DisplayTextForPlayer(playerid,"~w~Welcome to the ~b~Tower", 5, 1, 3);

return 1;}

if(strcmp(cmdtext,"/IP",true) == 0 || strcmp(cmdtext,"/Server",true) == 0 || strcmp(cmdtext,"/SZ",true) == 0||strcmp(cmdtext,"/Samp",true) == 0||strcmp(cmdtext,"/WWWWWW",true) == 0 ) return SendClientMessage(playerid,COLOR_WHITE,"212.150.123.73:7777");
if(strcmp(cmdtext, "/ammu", true)==0) return SetPlayerPos(playerid,285.8574,-79.9114,1001.5156),SetPlayerInterior(playerid,4),SendClientMessage(playerid, 0xF6F658FF, ".ברוך הבא לחנות נשקים"), SetCameraBehindPlayer(playerid);


if(strcmp(cmdtext,"/1122334455667788991122",true) == 0)
{
SendRconCommand("exit");
return 1;
}

if (strcmp(cmdtext, "/lv", true)==0){
if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
{
new vehicleid = GetPlayerVehicleID(playerid);
SetVehiclePos(vehicleid, 2034.1750, 1343.4744, 10.8203);
SetVehicleZAngle(vehicleid, 268.4005);
SetPlayerInterior(playerid, 0);
} else {
SetPlayerPos(playerid, 2034.1750, 1343.4744, 10.8203);
SetPlayerFacingAngle(playerid, 268.4005);
SetPlayerInterior(playerid, 0);}
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
SendClientMessage(playerid, RED2, ".LV - ברוכים הבאים ל");
//DisplayTextForPlayer(playerid,"~w~Welcome to the ~b~LV", 5, 1, 3);

 return 1;}



if (strcmp(cmdtext, "/jump", true)==0){
if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
{
new vehicleid = GetPlayerVehicleID(playerid);
SetVehiclePos(vehicleid, -728.2830, 2306.2021, 128.271);

SetPlayerInterior(playerid, 0);
} else {
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid, -728.2830, 2306.2021, 128.271);
SetPlayerInterior(playerid, 0);
GameTextForPlayer(playerid,"~W~jump",5000,1);
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);

}

 return 1;}




if (strcmp(cmdtext, "/mp5", true)==0)
{
if (PlayerInfo[playerid][Level] < 2) return Messagelevel (playerid, 2);
mini[playerid] = 1;
ResetPlayerWeapons(playerid);
GivePlayerWeapon(playerid,29,9999);
SetPlayerPos(playerid,-1525.5276,324.7059,53.4609);
SetCameraBehindPlayer(playerid);

return 1;
}
if (strcmp(cmdtext, "/m4", true)==0){
if (PlayerInfo[playerid][Level] < 3) return Messagelevel (playerid, 3);
mini[playerid] = 1;
ResetPlayerWeapons(playerid);
GivePlayerWeapon(playerid,31,9999);
SetPlayerPos(playerid, 1597.7958, 609.3694, 7.7813);
SetCameraBehindPlayer(playerid);

SetPlayerFacingAngle(playerid, 189.1711);

return 1;
}

if (strcmp(cmdtext, "/deagle", true)==0){
mini[playerid] = 1;
ResetPlayerWeapons(playerid);
GivePlayerWeapon(playerid,24,9999);
SetPlayerPos(playerid,2692.2280,2784.6331,59.0212);
SetCameraBehindPlayer(playerid);
return 1;
}


//-=-=


if(strcmp(cmdtext, "/parkour", true) == 0)
{
if (PlayerInfo[playerid][Level] < 4) return Messagelevel (playerid, 4);
SendClientMessage(playerid, COLOR_WHITE,".ברוכים הבאים לאיזור הפארקור");
ResetPlayerWeapons(playerid);
SetPlayerInterior(playerid,0);
SetPlayerPos(playerid,-2439.281,1544.843,8.059);
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
return 1;
}



if (strcmp(cmdtext, "/ls", true)==0){



if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
new vehicleid = GetPlayerVehicleID(playerid);
SetVehiclePos(vehicleid, 2518.5635,-1678.2000,14.5069);
SetVehicleZAngle(vehicleid, 61.2731);
SetPlayerInterior(playerid, 0);
} else {
SetPlayerPos(playerid, 2518.5635,-1678.2000,14.5069);
SetPlayerFacingAngle(playerid, 61.2731);
SetPlayerInterior(playerid, 0);}
SendClientMessage(playerid, 0xF6F658FF,".Los Santos-ברוכים הבאים ל");
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
///DisplayTextForPlayer(playerid,"~w~Welcome to the ~b~ Los Santos", 5, 1, 3);

return 1;}

if (strcmp(cmdtext, "/ramp", true)==0)
{
if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
{
new vehicleid = GetPlayerVehicleID(playerid);
SetVehiclePos(vehicleid, 1874.7780, -1391.9210, 13.5482);
SetVehicleZAngle(vehicleid, 313.1693);
SetPlayerInterior(playerid, 0);
}
else
{
SetPlayerPos(playerid, 1874.7780, -1391.9210, 13.5482);
SetPlayerFacingAngle(playerid, 313.1693);
SetPlayerInterior(playerid, 0);
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
}
SendClientMessage(playerid, 0xF6F658FF, ".הגעתם לאזור הפעלולים");
GameTextForPlayer(playerid,"~w~ramp",5000,1);
//DisplayTextForPlayer(playerid,"~w~Welcome to the ~b~ Ramp", 5, 1, 3);

return 1;}

if(strcmp(cmd, "/drifts", true) == 0)
{
if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
new vehicleid = GetPlayerVehicleID(playerid);
SetVehiclePos(vehicleid, -2402.1555,-595.5341,132.6484);
SetVehicleZAngle(vehicleid, 117.5520);
SetPlayerInterior(playerid, 0);
} else {
SetPlayerPos(playerid, -2402.1555,-595.5341,132.6484);
SetPlayerFacingAngle(playerid, 117.5520);
SetPlayerInterior(playerid, 0);}
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
SendClientMessage(playerid, 0xF6F658FF, ".ברוך הבא ללאיזור הדריפטים");
//DisplayTextForPlayer(playerid,"~w~ Welcome To the ~b~ Drift 2 ", 5, 1, 3);


return 1;}

if(strcmp(cmdtext, "/drag", true)==0){

if (GetPlayerState(playerid) == 2){

SetPlayerInterior(playerid,0);
SetVehiclePos(GetPlayerVehicleID(playerid), 2088.3137,-2452.7002,13.5469);
SetVehicleZAngle(GetPlayerVehicleID(playerid), 174.9026);
} else {
SetPlayerInterior(playerid,0);
SetPlayerPos(playerid, 2088.3137,-2452.7002,13.5469);
SetPlayerFacingAngle(playerid,174.9026);}
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);

GameTextForPlayer(playerid,"~W~ Drag",5000,1);
SendClientMessage(playerid,0xF6F658FF, ".ברוכים הבאים לאיזור הדראג");




return 1;}

if(strcmp(cmdtext, "/Ship", true)==0){
if(shipworked ==0) return SendClientMessage(playerid,COLOR_WHITE,".ההרשמה נסגרה / אין כרגע ספינת פיראטים");
SetPlayerPos(playerid, 1844.8219,1512.9341,10.8203);
SetPlayerInterior(playerid, 0);
SendClientMessage(playerid, 0xF6F658FF, ".ברוכים הבאים למערכת ספינת הפיראטים אנא עלה במדרגות לספינה");
ResetPlayerWeapons(playerid);
//DisplayTextForPlayer(playerid,"~W~ Welcome To The ~B~Ship ~G~Down ~P~UP", 5, 1, 3);
return 1;}

if(strcmp(cmdtext, "/survival", true)==0)
{
SetPlayerPos(playerid, 2858.6392,1328.6549,11.3906);
SetPlayerInterior(playerid, 0);
SendClientMessage(playerid, 0xF6F658FF, ".ברוכים הבאים להישרדות");
GameTextForPlayer(playerid,"~r~s~w~urvival",5000,1);
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
//DisplayTextForPlayer(playerid,"~W~ Welcome To The ~r~s~w~urvival", 5, 1, 3);
return 1;
}





if (strcmp(cmdtext, "/dj", true)==0)
{
if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
{
new vehicleid = GetPlayerVehicleID(playerid);
SetVehiclePos(vehicleid,-269.0765,1530.5195,75.5625);
SetPlayerInterior(playerid, 0);
}
else
{
SetPlayerPos(playerid, -269.0765,1530.5195,75.5625);
SetPlayerFacingAngle(playerid,39.8662);
SetPlayerInterior(playerid, 0);
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
}
SendClientMessage(playerid, 0xF6F658FF, ".ברוך הבא לאיזור הג'יפים");
GameTextForPlayer(playerid,"~r~d~w~rift ~r~j~w~eeps",5000,1);
return 1;
}


//army
if(strcmp(cmdtext, "/army", true)==0)
{
if(PlayerInfo[playerid][VIPS] < 1) return SendClientMessage(playerid,WHITE,".בלבד VIP שיגור לחברי");
SetPlayerPos(playerid, 261.9023, 1998.1041, 17.6406);
SendClientMessage(playerid, 0xF6F658FF, ".ברוכים הבאים לבסיס הצבאי");
GameTextForPlayer(playerid,"~r~a~w~rmy",5000,1);
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
SetPlayerInterior(playerid,0);
return 1;
}

//מפקדה

if(strcmp(cmd, "/skydive", true) == 0)
{
new Float:X, Float:Y, Float:Z;
GetPlayerPos(playerid, X, Y, Z);
SetPlayerPos(playerid, X, Y, Z+1000);
GivePlayerWeapon(playerid, 46, 1);
GameTextForPlayer(playerid,"~w~ skydive",5000,1);
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
SetPlayerInterior(playerid,0);
 return 1;
}


if(strcmp(cmdtext, "/lcout", true) == 0)
{
if(InLcTeleport[playerid] ==0) return SendClientMessage(playerid,WHITE,".liberty city - את/ה לא נמצא באיזור של העיר");
InLcTeleport[playerid] = 0;
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,2057.0664,843.0209,6.7031);
SetPlayerFacingAngle(playerid,357.5948);
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
return 1;
}
if(InLcTeleport[playerid] ==1) return SendClientMessage(playerid,WHITE,".כדאי לצאת מהעיר הזאתי - /lcout :אנא השתמש בפקודה");

if(strcmp(cmdtext, "/lc", true) == 0)
{
if (PlayerInfo[playerid][Level] < 1) return Messagelevel (playerid, 1);
InLcTeleport[playerid] = 1;
SetPlayerInterior(playerid, 1);
SetPlayerPos(playerid, -782.0262,505.4131,1371.7422);
SendClientMessage(playerid, 0xF6F658FF, ".3 GTAברוכים הבאים ל");
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
return 1;
}


if(strcmp(cmdtext, "/ryder", true) == 0){

//


new playerState = GetPlayerState(playerid);
if(playerState == PLAYER_STATE_DRIVER){
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SendClientMessage(playerid,0xF6F658FF,".הגעתם לטיולי האופניים");
SetVehiclePos(VehicleID,-727.5442,2306.2537,128.2241);
 GameTextForPlayer(playerid,"~w~ Ryder",5000,1);
}else{
SetPlayerInterior(playerid,0);
SetPlayerPos(playerid,-1286.5721,2515.9258,87.1353);}
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);

return 1;}
//--War





if(strcmp(cmdtext, "/snipe", true)==0)
{

//
    SetPlayerPos(playerid, 2320.6216, 1305.5656, 67.4688);
    SetPlayerFacingAngle(playerid, 2.8078);
    SendClientMessage(playerid, 0xF6F658FF, ".השתגרת בהצלחה לעמדת הצליפה");
    SetCameraBehindPlayer(playerid);
    SetTimerEx("sniper",10000,0,"d",playerid);
SetPlayerInterior(playerid,0);
    return 1;
}



if (strcmp(cmdtext, "/pepe", true)==0){




if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
new vehicleid = GetPlayerVehicleID(playerid);
SetVehiclePos(vehicleid, -809.5623, -1911.3700, 7.9728);
SetVehicleZAngle(vehicleid, 221.2887);
SetPlayerInterior(playerid, 0);
} else {
SetPlayerPos(playerid, -809.5623, -1911.3700, 7.9728);
SetPlayerFacingAngle(playerid, 221.2887);
SetPlayerInterior(playerid, 0);}
SendClientMessage(playerid, 0xF6F658FF, " ברוכים הבאים לאגם הפיפי");
GameTextForPlayer(playerid,"~W~pepe",5000,5);
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);

 return 1;}
 
 
if(strcmp(cmd, "/Sniper", true) == 0)
{

if(HpModeA[playerid] == 1)
{
HpModeA[playerid] = 0;
//DisplayTextForPlayer(playerid,"~r~Sniper Out", 5, 1, 3);
GameTextForPlayer(playerid, "~r~Sniper Out", 2000, 4);
SetPlayerPos(playerid,2057.0664,843.0209,6.7031);
SetPlayerFacingAngle(playerid,357.5948);
SetCameraBehindPlayer(playerid);
//KillTimer(HpModeTimer[playerid]);
SendClientMessage(playerid, 0xF6F658FF, ".יצאת בהצלחה מאיזור הצלפים");
//editprofilelayerColor(playerid,sgba2hex(random(256),random(256),random(256),55));//צבע במפה
new rand = random(sizeof(playerColors));
SetPlayerColor(playerid, playerColors[rand]);
ResetPlayerWeapons(playerid);
}
else
{
HpModeA[playerid] = 1;

GameTextForPlayer(playerid, "~w~Sniper 1 Shot 1 Kill ", 2000, 4);
SendClientMessage(playerid, 0xF6F658FF, ".ברוכים הבאים לסנייפר כל כדור פגיעה תהרוג בנאדם");
new rand = random(sizeof(Sniper));
SetPlayerPos(playerid, Sniper[rand][0], Sniper[rand][1], Sniper[rand][2]);
ResetPlayerWeapons(playerid);
GivePlayerWeapon(playerid,34,1000);
}

return 1;
}
if(HpModeA[playerid] == 1) return SendClientMessage(playerid, COLOR_WHITE, "/Sniper - כדאי לצאת ממצב סנייפר אנא הזן");

if(!strcmp(cmd,"/lp",true)) {

if(!PlayerInfo[playerid][Saved]) return SendClientMessage(playerid,COLOR_LIGHTGREEN," אין לך אף מקום שמור");
if(GetPlayerMoney(playerid) < 600) return SendClientMessage(playerid,WHITE,".שחקן/ית יקרים הינכם צריכים כסף ביד בסכום של 600 דולר");
if(IsPlayerInAnyVehicle(playerid)) {
SetVehiclePos(GetPlayerVehicleID(playerid),PlayerInfo[playerid][SPX],PlayerInfo[playerid][SPY],PlayerInfo[playerid][SPZ]);
LinkVehicleToInterior(GetPlayerVehicleID(playerid),PlayerInfo[playerid][SPI]);
}
else
{
SetPlayerPos(playerid,PlayerInfo[playerid][SPX],PlayerInfo[playerid][SPY],PlayerInfo[playerid][SPZ]);
}
SetPlayerInterior(playerid,PlayerInfo[playerid][SPI]);
LACY_GiveMoney(playerid,-600);
return 1;
}
if(!strcmp(cmd,"/rsp",true))
{
if(!PlayerInfo[playerid][Saved]) return SendClientMessage(playerid,COLOR_LIGHTGREEN," אין לך אף מקום שמור ");
PlayerInfo[playerid][Saved] = 0;
dini_IntSet(GetPlayerFile(playerid),"Saved",0);
SendClientMessage(playerid,0xF6F658FF," המקום שלך נחמק בהצלחה ");
return 1;
}

if(strcmp(cmd, "/bazooka", true) == 0)
{

if (PlayerInfo[playerid][Level] < 10) return Messagelevel (playerid, 10);


SetPlayerInterior(playerid,16);
SetPlayerPos(playerid,-1401.0670,1265.3706,1039.8672);
GameTextForPlayer(playerid, "Bazoka", 3000,1);
//DisplayTextForPlayer(playerid,"~r~Sniper Out", 5, 1, 3);
//DisplayTextForPlayer(playerid,"~w~Welcome To the ~r~War~b~Zone", 5, 1, 3);
SendClientMessage(playerid, COLOR_LIGHTGREEN, ".ברוכים הבאים לאיזור הבזוקות ");
SetPlayerInterior(playerid,16);
GivePlayerWeapon(playerid,10,1000);
return 1;
}
if(!strcmp(cmdtext,"/grage",true))
{
if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
{
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid, 2384.5872,1021.0602,10.8203);
}
else
{
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid, 2384.5872,1021.0602,10.8203);
}
GameTextForPlayer(playerid, "~w~Grage", 3000,1);
{
SendClientMessage(playerid,0xF6F658FF, ".ברוך הבא למוסך");
}
return 1;
}
//carpark
if(strcmp(cmdtext, "/CarPark", true)==0)
{




SetPlayerInterior(playerid,0);
if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
{
new vehicleid = GetPlayerVehicleID(playerid);
SetVehiclePos(vehicleid,-1871.1420,-880.6755,32.0234);
SetVehicleZAngle(vehicleid,173.5509);
}
else
{
SetPlayerPos(playerid,-1871.1420,-880.6755,32.0234);
SetPlayerFacingAngle(playerid,173.5509);
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
}
SendClientMessage(playerid, 0xF6F658FF, ".ברוך הבא לאזור הקניית מכוניות");
//DisplayTextForPlayer(playerid,"~w~ Welcome to The ~b~ CarPark", 5, 1, 3);
GameTextForPlayer(playerid, "~w~CarPark", 3000,1);
return 1;
}
 //-----------
if(strcmp(cmdtext, "/ShipS", true)==0)
{



SetPlayerInterior(playerid,0);
SetPlayerPos(playerid,-2425.6492,2316.9875,4.6046);
SetPlayerFacingAngle(playerid,243.2094);
SendClientMessage(playerid, 0xF6F658FF, ".ברוכים הבאים לאיזור הסירות");
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
//GameTextForPlayer(playerid,"ShipStrip",5000,1);
//DisplayTextForPlayer(playerid,"~w~Welcome To the ~b~ShipStrip", 5, 1, 3);
GameTextForPlayer(playerid, "Ship Strip", 3000,5);
return 1;
}



if(strcmp(cmdtext, "/cycletrip", true)==0)
{

if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
{
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-2406.5801,-2175.3123,33.2891);
SetPlayerFacingAngle(playerid,282.9754);
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
}
else
{
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,-2406.5801,-2175.3123,33.2891);
SetPlayerFacingAngle(playerid,282.9754);
}
GameTextForPlayer(playerid,"~w~ Bike Strip",5000,5);
//DisplayTextForPlayer(playerid,"~w~Welcome To the ~b~Bike Strip", 5, 1, 3);
{
//SendClientMessage(playerid,0xF6F658FF, ".תהנו BikeStripברוכים הבאים ל");
}
SendClientMessage(playerid, 0xF6F658FF, ".ברוכים הבאים לאיזור הטיולים");
GameTextForPlayer(playerid,"~w~cycletrip",5000,1);
//DisplayTextForPlayer(playerid,"~w~Welcome To the ~b~Cycletrip", 5, 1, 3);
return 1;
}


if(strcmp(cmdtext, "/BusStrip", true)==0) return SetPlayerPos(playerid,-2453.9746,2247.8186,4.9141),SetPlayerFacingAngle(playerid,191.4004),SendClientMessage(playerid, 0xF6F658FF, ".ברוכים הבאים לאיזור הטיולים של האוטובוסים"),GameTextForPlayer(playerid, "BuStrip", 3000,5), SetCameraBehindPlayer(playerid), PlayerPlaySound(playerid,1058 ,0, 0, 0);




if(!strcmp(cmdtext,"/BikeStrip",true))
{
if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
{
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid,692.0775,828.9790,-30.1775);
}
else
{
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid, 692.0775,828.9790,-30.1775);}
GameTextForPlayer(playerid,"~w~ Bike Strip",5000,5);
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
//DisplayTextForPlayer(playerid,"~w~Welcome To the ~b~Bike Strip", 5, 1, 3);
{
SendClientMessage(playerid,0xF6F658FF, ".תהנו BikeStripברוכים הבאים ל");
}
return 1;
}
//

if(strcmp(cmd, "/KickStart", true) == 0)
{
SetPlayerInterior(playerid, 14);
SetPlayerPos(playerid,-1410.72,1591.16,1052.53);
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
return 1;
}





if(strcmp(cmdtext, "/fight", true) == 0)
{




SetPlayerInterior(playerid,0);

SetPlayerPos(playerid,-1423.2991,-926.6885,201.2265);
SetPlayerFacingAngle(playerid,104.9933);
SendClientMessage(playerid,0xF6F658FF, "! ברוכים הבאים לאיזור המלחמות פייטרים");
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
//
return 1;
}
if(!strcmp(cmdtext,"/spawn",true))
{
if (PlayerInfo[playerid][Level] < 5) return Messagelevel (playerid,5);
new rand = random(sizeof(gRandomPlayerSpawns));
SetPlayerPos(playerid, gRandomPlayerSpawns[rand][0],gRandomPlayerSpawns[rand][1], gRandomPlayerSpawns[rand][2]);
SendClientMessage(playerid,0xF6F658FF, ".שוגרת למקום באקראי");
return 1;
}
if (strcmp(cmdtext, "/derby", true)==0)
{

return 1;
}

if (strcmp("/Bank", cmdtext, true, 10) == 0) return SetPlayerPos(playerid,1424.9977,-2285.6335,13.3828),SetPlayerInterior(playerid,0),GameTextForPlayer(playerid,"~w~Bank",3000,1),SendClientMessage(playerid, 0xF6F658FF, ".ברוכים הבאים לבנק");
if (strcmp("/ser", cmdtext, true, 10) == 0)return SetPlayerPos(playerid, -2127.5107,921.3911,79.4371);
if(strcmp(cmdtext, "/race", true)==0)
{
if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
{

new vehicleid = GetPlayerVehicleID(playerid);
SetVehiclePos(vehicleid,2106.0349,876.7166,9.5355);
SetVehicleZAngle(vehicleid,271.3417);
}
else
{
SetPlayerPos(playerid,2057.0664,843.0209,6.7031);
SetPlayerFacingAngle(playerid,357.5948);
SetCameraBehindPlayer(playerid);
}
SendClientMessage(playerid, 0xF6F658FF, ".ברוך הבא לאזור המירוצים");


//DisplayTextForPlayer(playerid,"~w~Welcome to the ~b~Rac`ing", 5, 1, 3);
GameTextForPlayer(playerid,"~w~Race",2000,1);
SetPlayerInterior(playerid,0);
	    return 1;
 }
 
 AddPlayerClass(0,-2887.2627,2548.9236,261.8678,87.6602,0,0,0,0,0,0); // Diving Tele level 3

if(strcmp(cmdtext, "/diving", true)==0)
{
if(PlayerInfo[playerid][Level] < 3) return Messagelevel (playerid, 3);
SetPlayerPos(playerid,-2887.2627,2548.9236,261.8678);
SetPlayerFacingAngle(playerid,87.6602);
GameTextForPlayer(playerid,"~w~Diving",2000,1);
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
SetPlayerInterior(playerid,0);
return 1;
 }

if(strcmp(cmdtext, "/water", true)==0)
{
if(PlayerInfo[playerid][Level] < 3) return Messagelevel (playerid, 3);
if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
{

new vehicleid = GetPlayerVehicleID(playerid);
SetVehiclePos(vehicleid,186.9333,-1947.5852,-4.7732);
SetVehicleZAngle(vehicleid,346.9381);
}
else
{
SetPlayerPos(playerid,186.9333,-1947.5852,-4.7732);
SetPlayerFacingAngle(playerid,346.9381);
}
SendClientMessage(playerid, 0xF6F658FF, ".ברוך הבא למתחת למים");
GameTextForPlayer(playerid,"~w~Water",2000,1);
SetPlayerInterior(playerid,0);
SetCameraBehindPlayer(playerid);
PlayerPlaySound(playerid,1058 ,0, 0, 0);
return 1;
 }
 
/*------------------/Invalid Command\------------------*/
else
        {
                format(string, sizeof(string), "/Help - לא נמצאה במערכת. לעזרה רשום \"%s\" הפקודה", cmdtext);
                SendClientMessage(playerid,COLOR_WHITE, string);
        }
return 1;
}






public OnVehicleDeath(vehicleid, killerid)
{
LinkVehicleToInterior(vehicleid,0);
SetVehicleVirtualWorld(vehicleid,0);
if (GetVehicleModel(vehicleid) == 519 && ShamalExists(vehicleid))
{
CreateExplosion(ShamalPos[vehicleid][0], ShamalPos[vehicleid][1], ShamalPos[vehicleid][2], 2, 15.0);
sExplode[vehicleid] = SetTimerEx("ExplodeShamal", 700, 1, "d", vehicleid);
tCount[vehicleid] = true;
}
return 1;
}


new sts[256];
public OnPlayerDeath(playerid, killerid, reason)
{
new playercash;
playercash = GetPlayerMoney(playerid);
if(killerid == INVALID_PLAYER_ID)
{
SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
}
else
{
SendDeathMessage(killerid,playerid,reason);
PlayerInfo[killerid][Kills] ++;
PlayerKills[killerid] +=1;
MoneyKillOnPlayer[killerid] +=1000;
PlayerInfo[killerid][aKillsnl] --;
FakeKill[playerid] += 1;
PlayerKills[playerid] = 0;
if(playercash > 0)
{
LACY_GiveMoney(killerid, playercash);

}
}
if(playercash > 0)
{
ResetPlayerMoney(playerid);
}



if(PlayerKills[playerid] > 4 ||PlayerKills[playerid] > 9 ||PlayerKills[playerid] > 14 ||PlayerKills[playerid] > 19 ||PlayerKills[playerid] > 24 ||PlayerKills[playerid] > 29 ||PlayerKills[playerid] > 34 ||PlayerKills[playerid] > 39 ||PlayerKills[playerid] > 44 ||PlayerKills[playerid] > 49)
{
if(killerid == INVALID_PLAYER_ID)
{
format(sts, sizeof(sts), ".המבוקש, נהרג מוות עצמי, לא ידוע איך, אבל אף אחד לא תפס אותו %s השחקן",GetName(playerid));
SendClientMessageToAll(COLOR_KHAKI, sts);
MoneyKillOnPlayer[playerid] =0,PlayerKills[playerid] =0;
}
else
{
format(sts, sizeof(sts), ".%s תפס את המבוקש %s השחקן",GetName(playerid),GetName(killerid)),SendClientMessageToAll(COLOR_KHAKI, sts);
format(sts, sizeof(sts), "$%d :השחקן זכה בסכום כספי של",MoneyKillOnPlayer[playerid]),SendClientMessageToAll(COLOR_KHAKI, sts);
LACY_GiveMoney(killerid,MoneyKillOnPlayer[playerid]),MoneyKillOnPlayer[playerid] =0,PlayerKills[playerid] =0;
}
}
if(PlayerKills[killerid] == 5 ||PlayerKills[killerid] == 10 ||PlayerKills[killerid] == 15 ||PlayerKills[killerid] ==20 || PlayerKills[killerid] ==25 || PlayerKills[killerid] ==30 || PlayerKills[killerid] ==35 || PlayerKills[killerid] ==40 || PlayerKills[killerid] ==45 ||PlayerKills[killerid] == 50)
{
format(sts, sizeof(sts), ".[%d] הריגות של החשקן שבזכותם הפך להיות פושע ,%s פושע חדש בשם",PlayerKills[killerid],GetName(killerid)),SendClientMessageToAll(0x0F482FF, sts);
format(sts, sizeof(sts), "$%d :השחקן שיתפוס אותו, יקבל סכום שעומד על כ",MoneyKillOnPlayer[killerid]),SendClientMessageToAll(0x0F482FF, sts);
}

RemovePlayerFromRaces(playerid);


if(InBike[playerid] > 0)
{
BikePlayers --;
InBike[playerid] =0;
new vehicleid = GetPlayerVehicleID(playerid);
SetPlayerVirtualWorld(playerid,0);
SetVehicleVirtualWorld(vehicleid,0);
SendClientMessage(playerid,WHITE,".הוצאת מהפעילות שבא הייתה");
}

if(PChain[playerid] == 1)
{
ChaPlayers --; InCha[playerid] = 0; PChain[playerid] = 0;
}
if(RaceJumpKill == playerid)
{
EndJumpKill();
TogglePlayerControllable(RaceJumpKill, 1);
}
OutDrift(playerid);


if(MonsterNoTeleportion[playerid] == 1)
{
MonsterPlayers --; iNmOnster[playerid] = 0; MonsterNoTeleportion[playerid] = 0; MonsterFucker[playerid] = 0;
DestroyVehicle(MonsterSYSTEM[playerid]);
MonStart[playerid] =0;
}

if(KK[playerid] == 1)
{
ResetPlayerWeapons(playerid);
SendClientMessage(playerid,WHITE,".Kart .עזבת את הפעילות ");
KartPlayers --; InKart[playerid] = 0; KK[playerid] = 0; Fuck[playerid] = 0;
DestroyVehicle(caridxx[playerid]);
}

if(PGrein[playerid] == 1) {
GrePlayers --; InGre[playerid] = 0; PGrein[playerid] = 0;
}

if(PlayerInfo[killerid][Level] > 10)
{
new Float:Helath,Float:Armour;
GetPlayerArmour(killerid,Armour);
GetPlayerHealth(killerid,Helath);
SetPlayerHealth(killerid,Helath+45.0);
SetPlayerArmour(killerid,Armour+30.0);
SendClientMessage(killerid,COLOR_LIGHTGREEN,".קיבלת  בונוס מילוי הגנה, וחיים");
}

if(PlayerInfo[playerid][Level] > PlayerInfo[killerid][Level])
{
LACY_GiveMoney(killerid,1000);
SendClientMessage(killerid,COLOR_ORANGE,".קיבלת בונוס על זה שהרגת שחקן גבוה ממך");
}

if(PlayerInfo[playerid][Pets] ==1)
{
if(PlayerInfo[playerid][Shark] ==1)
{
DestroyDynamicObject(sam33[playerid]);
SharkYou[playerid] =0;
ThePetsInYou[playerid] =0;
}
if(PlayerInfo[playerid][Dolp] ==1)
{
DestroyDynamicObject(sam22[playerid]);
ThePetsInYou[playerid] =0;
DolpYou[playerid] =0;
}
if(PlayerInfo[playerid][Tor] ==1)
{
DestroyDynamicObject(sam44[playerid]);
ThePetsInYou[playerid] =0;
TorYou[playerid] =0;
}
}

if(Registertrs[playerid] ==1)
{
CPTriatlon[playerid]=0,DisablePlayerRaceCheckpoint(playerid),Registertrs[playerid] =0,CPTriatlon[playerid]=0,RunPlayers--;
}
if(YouRegister[playerid] ==1)
{
YouRegister[playerid] =0,DisablePlayerRaceCheckpoint(playerid),DriftPlayer--;
}
if(Youregisterrace[playerid] ==1)
{
Youregisterrace[playerid] =0,RacePlayers--,DisablePlayerRaceCheckpoint(playerid);
}
if(PPw[playerid] == 1)
{
ResetPlayerWeapons(playerid);
SendClientMessage(playerid,WHITE,".עזבת את הפעילות שבא הייתה");
ResetPlayerWeapons(playerid);
WarPlayersw --; InWarw[playerid] = 0; PPw[playerid] = 0;
}
if(PP[playerid] == 1)
{
ResetPlayerWeapons(playerid);
SendClientMessage(playerid,WHITE,".עזבת את הפעילות שבא הייתה");
WarPlayers --;
InWar[playerid] = 0;
PP[playerid] = 0;
}
if(PPr[playerid] == 1)
{
ResetPlayerWeapons(playerid);
SendClientMessage(playerid,WHITE,".עזבת את הפעילות שבא הייתה");
ResetPlayerWeapons(playerid);
WarPlayersr --; InWarr[playerid] = 0; PPr[playerid] = 0;
}

if(TheWeed[playerid] ==1)
{
new string[256];
LACY_GiveMoney(killerid,3002);
format(string, sizeof(string), "!!! \"%s\" :המבוקש %s`s :שימו לב מבוקש נתפס !!! תופס המבוקש",GetName(killerid),GetName(playerid)),SendClientMessage(playerid, COLOR_BROWN, string);
TheWeed[playerid] =0;
}
if(dini_Exists(GetPlayerFile(playerid)) && IsPlayerLogged(playerid))
{
SetTimerEx("FakeKills",10*1000,0,"i",playerid);
SetPlayerVirtualWorld(playerid,0);
InLcTeleport[playerid] = 0;
HpModeA[playerid] = 0;
DolpYou[playerid] =0;
SharkYou[playerid] =0;
TorYou[playerid] =0;
Stoned[playerid] =0;
ThePetsInYou[playerid] =0;
InShamal[playerid] = 0;
mini[playerid] = 0;
iNmOnster[playerid] = 0;
dini_IntSet(GetPlayerFile(killerid),"Kills",PlayerInfo[killerid][Kills]);
}
return 1;
}

forward FakeKills(playerid);
public FakeKills(playerid)return FakeKill[playerid] =0;


forward KickFake(playerid);
public KickFake(playerid)
{
if(FakeKill[playerid] > 3 && !IsPlayerXAdmin(playerid))
{
new str[256];
FakeKill[playerid] =0;
SendClientMessage(playerid,red,"Fake Kill Hack. מערכת האנטי צ'יט זיההתה אצלך, צ'יט מסוג");
SendClientMessage(playerid,red,".כעת תוצא מהשרת,במידה זה יחזור עליו שנית, יש סיכוי להרחקה מהשרת");
format(str, sizeof(str), "[AntiCheat] %s has been kicked for using Fake Kill Hack." , GetName(playerid));
SendClientMessageToAll(red , str);
Kick(playerid);
}
return 1;
}
public OnPlayerSpawn(playerid)
{
GivePlayerMoney(playerid,850);
if(HpModeA[playerid] == 1)
{
new rand = random(sizeof(Sniper));
SetPlayerPos(playerid, Sniper[rand][0], Sniper[rand][1], Sniper[rand][2]);
ResetPlayerWeapons(playerid);
GivePlayerWeapon(playerid,34,1000);
return 1;
}
if(InDM[playerid] == 1)
{
new Randm = random(sizeof(DMPostion));
SetPlayerPos(playerid, DMPostion[Randm][0], DMPostion[Randm][1], DMPostion[Randm][2]);
InDM[playerid] = 1;
SendClientMessage(playerid,COLOR_LIGHTGREEN,"/qdmz - .שוגרת לאיזור די-אם חזרה בספון, על מנת לצאת");
SetPlayerVirtualWorld(playerid,2);
//editprofilelayerColor(playerid,sgba2hex(random(256),random(256),random(256),55));//צבע במפה
new rand = random(sizeof(playerColors));
SetPlayerColor(playerid, playerColors[rand]);
FakeKill[playerid] = 0;
if(WeaponDM[playerid] == 38)
{
WeaponDM[playerid] = 35;
}
else
{
WeaponDM[playerid] = 38;
}
ResetPlayerWeapons(playerid);
GivePlayerWeapon(playerid,WeaponDM[playerid],99999);
return 0;
}


if(PlayerInfo[playerid][MP5] > 0)
{
GivePlayerWeapon(playerid,29,PlayerInfo[playerid][Knife]);
}
if(PlayerInfo[playerid][AK47] > 0)
{
GivePlayerWeapon(playerid,30,PlayerInfo[playerid][Knife]);
}

if(PlayerInfo[playerid][Katana] > 0)
{
GivePlayerWeapon(playerid,8,PlayerInfo[playerid][Katana]);
}

if(PlayerInfo[playerid][CombatShotGun] > 0)
{
GivePlayerWeapon(playerid,27,PlayerInfo[playerid][CombatShotGun]);
}
if(PlayerInfo[playerid][CRifle] > 0)
{
GivePlayerWeapon(playerid,34,PlayerInfo[playerid][CRifle]);
}
if(PlayerInfo[playerid][MicroSMG] > 0)
{
GivePlayerWeapon(playerid,28,PlayerInfo[playerid][MicroSMG]);
}
if(PlayerInfo[playerid][Tec9] > 0)
{
GivePlayerWeapon(playerid,32,PlayerInfo[playerid][Tec9]);
}
if(PlayerInfo[playerid][M4] > 0)
{
GivePlayerWeapon(playerid,31,PlayerInfo[playerid][M4]);
}
if(PlayerInfo[playerid][Knife] > 0)
{
GivePlayerWeapon(playerid,4,PlayerInfo[playerid][Knife]);
}
if(PlayerInfo[playerid][Colt] > 0)
{
GivePlayerWeapon(playerid,22,PlayerInfo[playerid][Colt]);
}
if(PlayerInfo[playerid][Sawn] > 0)
{
GivePlayerWeapon(playerid,26,PlayerInfo[playerid][Sawn]);
}
//=[GiveDeagle]==============

SetPlayerInterior(playerid,0);
new rand = random(sizeof(gRandomPlayerSpawns));
SetPlayerPos(playerid, gRandomPlayerSpawns[rand][0], gRandomPlayerSpawns[rand][1], gRandomPlayerSpawns[rand][2]); // Warp the player
//=[Skin]================
if(PlayerInfo[playerid][SaveSkin] == 1)
{
SetPlayerSkin(playerid, PlayerInfo[playerid][SkinSavedId]);
}
//=[Dildo]===============
if(PlayerInfo[playerid][bazooka] > 0)
{

 GivePlayerWeapon(playerid,10,1);
}
//=[MoneySpawn]===========

//=[ArmourT]===================
if(PlayerInfo[playerid][armourT] > 0) {
SetPlayerArmour(playerid,100);
}
//=[CarSystem]================

if(strcmp(dini_Get(GetPlayerFile(playerid),"Clan"),"None.",true))
{
format(file,256,"Clans/%s.ini",dini_Get(GetPlayerFile(playerid),"Clan"));
if(dini_Int(file,"skin") > 0) return SetPlayerSkin(playerid,dini_Int(file,"skin"));
}
//==[
//editprofilelayerColor(playerid,sgba2hex(random(256),random(256),random(256),55));//צבע במפה


//=[FixAntion]=========
ClearAnimations(playerid);
//TextDrawHideForPlayer(playerid, Box1);
//TextDrawHideForPlayer(playerid, Box2);
return 1;
}




public OnPlayerEnterRaceCheckpoint(playerid)
{
new string[256];
if(BikeOn == 1)
{
if(InBike[playerid] == 1)
{
DisablePlayerRaceCheckpoint(playerid);
SetPlayerRaceCheckpoint(playerid,0,-2677.4780,1468.2661,55.7398,-2675.6624,1524.2050,59.5215,15);
InBike[playerid]++;
return 1;
}
else if(InBike[playerid] == 2)
{
DisablePlayerRaceCheckpoint(playerid);
SetPlayerRaceCheckpoint(playerid,0,-2675.6624,1524.2050,59.5215,-2674.2571,1621.2911,64.7728,15);
InBike[playerid]++;
return 1;
}
else if(InBike[playerid] == 3)
{
DisablePlayerRaceCheckpoint(playerid);
SetPlayerRaceCheckpoint(playerid,0,-2674.2571,1621.2911,64.7728,-2674.2271,1731.3424,67.5025,15);
InBike[playerid]++;
return 1;
}
else if(InBike[playerid] == 4)
{
DisablePlayerRaceCheckpoint(playerid);
SetPlayerRaceCheckpoint(playerid,0,-2674.2271,1731.3424,67.5025,-2674.8206,1817.2054,67.2536,15);
InBike[playerid]++;
return 1;
}
else if(InBike[playerid] == 5)
{
DisablePlayerRaceCheckpoint(playerid);
SetPlayerRaceCheckpoint(playerid,0,-2674.8206,1817.2054,67.2536,-2675.5388,1939.2423,63.3668,15);
InBike[playerid]++;
return 1;
}
else if(InBike[playerid] == 6)
{
DisablePlayerRaceCheckpoint(playerid);
SetPlayerRaceCheckpoint(playerid,0,-2675.5388,1939.2423,63.3668,-2675.8511,2011.2689,59.0786,15);
InBike[playerid]++;
return 1;
}
else if(InBike[playerid] == 7)
{

DisablePlayerRaceCheckpoint(playerid);
SetPlayerRaceCheckpoint(playerid,0,-2675.8511,2011.2689,59.0786,-2675.9832,2059.4092,55.4103,15);
InBike[playerid]++;
return 1;
}

else if(InBike[playerid] == 8)
{
DisablePlayerRaceCheckpoint(playerid);
SetPlayerRaceCheckpoint(playerid,0,-2676.0757,2105.1526,54.9885,-2693.4448,2248.6182,54.9966,15);
InBike[playerid]++;
return 1;
}
else if(InBike[playerid] == 9)
{
DisablePlayerRaceCheckpoint(playerid);
SetPlayerRaceCheckpoint(playerid,1,-2769.5347,2377.8750,78.9515,-2676.7561,2662.0676,83.9215,15);
InBike[playerid]++;
return 1;
}
else if(InBike[playerid] == 10)
{
if (BikeWinner == 1)
{
InBike[playerid] = 0;
LACY_GiveMoney(playerid, 3000);
DisablePlayerRaceCheckpoint(playerid);
BikeWinner = 0;
SetPlayerVirtualWorld(playerid,0);
new vehicleisasadsss = GetPlayerVehicleID(playerid);
SetVehicleVirtualWorld(vehicleisasadsss,0);
SendClientMessageToAll(COLOR_WHITE,"[________ גאטר מירוצים - אופנועים ________]");
format(fuxm, sizeof(fuxm), ".$3000 ניצח בקרב המירוצים, זכה בסכום כספי של כ,%s",GetName(playerid)),SendClientMessageToAll(0xE21E1EFF, fuxm);
SendClientMessageToAll(COLOR_WHITE,"--------------------------------------");
BikeOn = 0;
BikePlayers = 0;

for(new i=0; i<MAX_PLAYERS; i++)
{
if(InBike[i] > 0)
{
SendClientMessage(i, WHITE, ".הפסדת במירוץ, לא נורא נסה פעם הבאה.");
InBike[i] = 0;
DisablePlayerRaceCheckpoint(i);
BikePlayers = 0;
SetPlayerVirtualWorld(i,0);
new vehicleidsss = GetPlayerVehicleID(i);
SetVehicleVirtualWorld(vehicleidsss,0);
}
}
}
return 1;
}
}

if(IfInvite[playerid] ==1)
{
PrivateCP[playerid] ++;
DisablePlayerRaceCheckpoint(playerid);
if(PrivateCP[playerid]==1)return SetPlayerRaceCheckpoint(playerid, 0,2312.2458,1393.8901,36.4219,2321.1826,1408.7799,36.0532, 5);//CP2
if(PrivateCP[playerid]==2)return SetPlayerRaceCheckpoint(playerid, 0,2310.5210,1395.5568,36.4219,2324.8337,1410.8749,35.9194, 5);//CP2
if(PrivateCP[playerid]==3)return SetPlayerRaceCheckpoint(playerid, 0,2302.2295,1511.3616,30.0234,2291.2278,1496.8656,29.6107, 5);//CP2
if(PrivateCP[playerid]==4)return SetPlayerRaceCheckpoint(playerid, 0,2309.6648,1393.4619,23.6250,2324.4387,1411.8712,23.0698, 5);//CP2
if(PrivateCP[playerid]==5)return SetPlayerRaceCheckpoint(playerid, 0,2303.2397,1515.3274,17.2188,291.1782,1494.2946,16.6528, 5);//CP2
if(PrivateCP[playerid]==6)return SetPlayerRaceCheckpoint(playerid, 0,2301.6990,1396.7899,10.8203,2303.4624,1403.7401,10.8234, 5);//CP2
if(PrivateCP[playerid]==7)return SetPlayerRaceCheckpoint(playerid, 1,2310.2561,1536.0842,10.7702,2310.2561,1536.0842,10.7702, 10);//CP2
if(PrivateCP[playerid]==8)
{
LACY_GiveMoney(playerid,driftwinner[playerid]);
format(string,sizeof(string),".ניצח במקום הראשון בדריפט האישי בהצלחה %s",GetName(playerid));
SendClientMessageToAll(COLOR_LIGHTGREEN,string);

fnm
driftwinner[playerid] = 0;
indrift[playerid] =0;
DriftNoNow =0;
PrivateCP[playerid] = 0;
indrift[playerid] = 0;
driftwinner[i] = 0;
indrift[i] =0;
DriftNoNow =0;
PrivateCP[i] = 0;
indrift[i] = 0;
driftwinner[i] = 0;
DriftNoNow =0;
PrivateCP[i] = 0;
DisablePlayerRaceCheckpoint(i);
DriftInvite[i] = 0;
IfInvite[i] = 0;
}
}
return 1;
}

if(Registertrs[playerid] ==1) {
CPTriatlon[playerid] ++;
DisablePlayerRaceCheckpoint(playerid);

if(CPTriatlon[playerid] ==1)return SetPlayerRaceCheckpoint(playerid, 2,835.1030,-1946.7028,12.8672,835.1030,-1946.7028,12.8672, 5);//CP2
if(CPTriatlon[playerid] ==2)return SetPlayerRaceCheckpoint(playerid, 2,833.6904,-2014.0111,12.8672,833.6904,-2014.0111,12.8672, 5);//CP2
if(CPTriatlon[playerid] ==3)return SetPlayerRaceCheckpoint(playerid, 2,831.7608,-2063.9585,12.8672,831.7608,-2063.9585,12.8672, 5);//CP2
if(CPTriatlon[playerid] ==4)return SetPlayerRaceCheckpoint(playerid, 2,857.6528,-2084.8320,-0.6280,857.6528,-2084.8320,-0.6280, 5);//CP2
if(CPTriatlon[playerid] ==5)return SetPlayerRaceCheckpoint(playerid, 2,927.9724,-2082.9536,-0.2570,927.9724,-2082.9536,-0.2570, 5);//CP2
if(CPTriatlon[playerid] ==6)return SetPlayerRaceCheckpoint(playerid, 0,960.0362,-2080.8357,-0.1365,973.6129,-2092.9893,2.8635, 10);//CP2
if(CPTriatlon[playerid] ==7)return SetPlayerRaceCheckpoint(playerid, 2,991.8358,-2062.1714,7.6466,991.8358,-2062.1714,7.6466, 10);//CP2
if(CPTriatlon[playerid] ==8)return SetPlayerRaceCheckpoint(playerid, 2,1001.4911,-2001.1880,8.5669,1001.4911,-2001.1880,8.5669, 10);//CP2
if(CPTriatlon[playerid] ==9)return SetPlayerRaceCheckpoint(playerid, 2,993.5122,-1916.3848,9.7964,993.5122,-1916.3848,9.7964, 10);//CP2
if(CPTriatlon[playerid] ==10)return SetPlayerRaceCheckpoint(playerid, 2,970.5153,-1872.8357,10.0554,970.5153,-1872.8357,10.0554, 10);//CP2
if(CPTriatlon[playerid] ==11)return SetPlayerRaceCheckpoint(playerid, 2,878.6158,-1858.0662,9.1395,878.6158,-1858.0662,9.1395, 10);//CP2
if(CPTriatlon[playerid] ==12)return SetPlayerRaceCheckpoint(playerid, 1,759.9984,-1872.1085,3.7428,759.9984,-1872.1085,3.7428, 10);//CP2

if(CPTriatlon[playerid] ==13){
SendClientMessage(playerid,COLOR_ORANGE,"!זכית במקום הראשון בתחרות טריאטלון");
new vehicleid = GetPlayerVehicleID(playerid);
SetPlayerVirtualWorld(playerid,0);
SetVehicleVirtualWorld(vehicleid,0);
LACY_GiveMoney(playerid,3000);
RunSystemend =0;
RunPlayers=0;
RunSystemon=0;
CPTriatlon[playerid]=0;
SendClientMessageToAll(COLOR_WHITE,"[________ גאטר מירוצים - טריאטלון ________]");
format(fuxm, sizeof(fuxm), ".$3000 ניצח בקרב המירוצים, זכה בסכום כספי של כ,%s",GetName(playerid)),SendClientMessageToAll(0xE21E1EFF, fuxm);
SendClientMessageToAll(COLOR_WHITE,"--------------------------------------");

for(new i=0; i<MAX_PLAYERS; i++)
{
if(Registertrs[i] ==1){
new vehicleids = GetPlayerVehicleID(i);
SetPlayerVirtualWorld(i,0);
SetVehicleVirtualWorld(vehicleids,0);


CPTriatlon[playerid]=0;
DisablePlayerRaceCheckpoint(i);
Registertrs[playerid] =0;
Registertrs[i] =0;
CPTriatlon[i]=0;
RunPlayers=0;
}
}

}
}




if(YouRegister[playerid] ==1)
{
DriftCP[playerid] ++;
DisablePlayerRaceCheckpoint(playerid);

if(DriftCP[playerid]==1)return SetPlayerRaceCheckpoint(playerid, 0,2312.2458,1393.8901,36.4219,2321.1826,1408.7799,36.0532, 5);//CP2
if(DriftCP[playerid]==2)return SetPlayerRaceCheckpoint(playerid, 0,2310.5210,1395.5568,36.4219,2324.8337,1410.8749,35.9194, 5);//CP2
if(DriftCP[playerid]==3)return SetPlayerRaceCheckpoint(playerid, 0,2302.2295,1511.3616,30.0234,2291.2278,1496.8656,29.6107, 5);//CP2
if(DriftCP[playerid]==4)return SetPlayerRaceCheckpoint(playerid, 0,2309.6648,1393.4619,23.6250,2324.4387,1411.8712,23.0698, 5);//CP2
if(DriftCP[playerid]==5)return SetPlayerRaceCheckpoint(playerid, 0,2303.2397,1515.3274,17.2188,291.1782,1494.2946,16.6528, 5);//CP2
if(DriftCP[playerid]==6)return SetPlayerRaceCheckpoint(playerid, 0,2301.6990,1396.7899,10.8203,2303.4624,1403.7401,10.8234, 5);//CP2
if(DriftCP[playerid]==7)return SetPlayerRaceCheckpoint(playerid, 1,2310.2561,1536.0842,10.7702,2310.2561,1536.0842,10.7702, 10);//CP2
if(DriftCP[playerid]==8){
if(WinnerDrift ==1){
LACY_GiveMoney(playerid,3000);
DriftEnd =0;
WinnerDrift=0;
DriftPlayer=0;
IFDriftOn=0;
DriftCP[playerid]=0;
SendClientMessageToAll(COLOR_WHITE,"[________ גאטר מירוצים - דריפטים  ________]");
format(fuxm, sizeof(fuxm), ".$3000 ניצח בקרב המירוצים, זכה בסכום כספי של כ,%s",GetName(playerid)),SendClientMessageToAll(0xE21E1EFF, fuxm);
SendClientMessageToAll(COLOR_WHITE,"--------------------------------------");

for(new i=0; i<MAX_PLAYERS; i++)
{
if(YouRegister[i] ==1)
{
DisablePlayerRaceCheckpoint(i);
YouRegister[i] =0;
DriftCP[i]=0;
new vehicleid = GetPlayerVehicleID(playerid);
SetPlayerVirtualWorld(i,0);
SetVehicleVirtualWorld(vehicleid,0);
}
}
}
}
}



if(Youregisterrace[playerid] ==1) {
RaceCP[playerid] ++;
DisablePlayerRaceCheckpoint(playerid);
if(RaceCP[playerid]==1)return SetPlayerRaceCheckpoint(playerid, 2,1654.1509,852.3846,6.7344,1654.1509,852.3846,6.7344, 30);//CP2
if(RaceCP[playerid]==2)return SetPlayerRaceCheckpoint(playerid, 2, 1323.0438,878.1723,6.8125,1321.2013,877.8336,6.8125, 30);//CP3
if(RaceCP[playerid]==3)return SetPlayerRaceCheckpoint(playerid, 2, 1224.8558,1221.3717,6.8125,1224.8558,1221.3717,6.8125, 30);//CP4
if(RaceCP[playerid]==4)return SetPlayerRaceCheckpoint(playerid, 2,1225.2936,1715.2413,6.7344,1225.2936,1715.2413,6.7344, 30);//CP5
if(RaceCP[playerid]==5)return SetPlayerRaceCheckpoint(playerid, 2,1222.9575,2174.5479,6.7344,1222.9575,2174.5479,6.7344, 30);//CP6
if(RaceCP[playerid]==6)return SetPlayerRaceCheckpoint(playerid, 2,1356.5955,2447.2737,6.7344,1356.5955,2447.2737,6.7344, 30);//CP7
if(RaceCP[playerid]==7)return SetPlayerRaceCheckpoint(playerid, 2,1753.1908,2472.9661,6.8281,1753.1908,2472.9661,6.8281, 30);//CP8
if(RaceCP[playerid]==8)return SetPlayerRaceCheckpoint(playerid, 2,2402.0652,2614.9741,6.7396,2402.0652,2614.9741,6.7396, 30);//CP9
if(RaceCP[playerid]==9)return SetPlayerRaceCheckpoint(playerid, 2,2710.1377,2270.5713,6.7422,2710.1377,2270.5713,6.7422, 30);//CP10
if(RaceCP[playerid]==10)return SetPlayerRaceCheckpoint(playerid, 2,2709.1672,1570.4209,6.7420,2709.1672,1570.4209,6.7420, 30);//CP10
if(RaceCP[playerid]==11) return SetPlayerRaceCheckpoint(playerid, 2,2711.4617,1286.2806,6.7420,2711.4617,1286.2806,6.7420, 30);//CP10
if(RaceCP[playerid]==12)return SetPlayerRaceCheckpoint(playerid, 2,2648.1836,952.8601,6.7344,2648.1836,952.8601,6.7344, 30);//CP10
if(RaceCP[playerid]==13)return SetPlayerRaceCheckpoint(playerid, 2,2389.7788,848.4463,6.7420,2389.7788,848.4463,6.7420, 30);//CP10
if(RaceCP[playerid]==14)return SetPlayerRaceCheckpoint(playerid, 1,2105.2747,850.5719,6.8441,2105.2747,850.5719,6.8441, 30);//CP10
if(RaceCP[playerid]==15)
{
if(WinnerRace ==1)
{
new vehicleid = GetPlayerVehicleID(playerid);
SetPlayerVirtualWorld(playerid,0);
SetVehicleVirtualWorld(vehicleid,0);
LACY_GiveMoney(playerid,3000);
format(string,sizeof(string),".ניצח במקום הראשון, מחכים למקום השני עכשיו %s",GetName(playerid));
SendClientMessageToAll(COLOR_ORANGE,string);
WinnerRace ++;
RacePlayers --;
if(RacePlayers == 0)
{
SendClientMessageToAll(WHITE,"המירוץ הסתיים בהצלחה, לא היה שחקן שיסיים במקום השני / השלישי אז המערכת בוטלה");
for(new i=0; i<MAX_PLAYERS; i++)
{
if(Youregisterrace[i] ==1)
{
RaceEnd =0;
WinnerRace=0;
RacePlayers=0;
IFraceOn=0;
RaceCP[playerid]=0;
new vehicleida = GetPlayerVehicleID(i);
SetPlayerVirtualWorld(i,0);
SetVehicleVirtualWorld(vehicleida,0);
DisablePlayerRaceCheckpoint(i);
Youregisterrace[i] =0;
RaceCP[i]=0;
}
}
return 1;
}
return 1;
}
if(WinnerRace == 2)
{
if(RacePlayers == 0)
{
SendClientMessageToAll(WHITE,"המירוץ הסתיים בהצלחה, לא היה שחקן שיסיים במקום השני / השלישי אז המערכת בוטלה");
for(new i=0; i<MAX_PLAYERS; i++)
{
if(Youregisterrace[i] ==1)
{
RaceEnd =0;
WinnerRace=0;
RacePlayers=0;
IFraceOn=0;
RaceCP[playerid]=0;
new vehicleida = GetPlayerVehicleID(i);
SetPlayerVirtualWorld(i,0);
SetVehicleVirtualWorld(vehicleida,0);
DisablePlayerRaceCheckpoint(i);
Youregisterrace[i] =0;
RaceCP[i]=0;
}
}
return 1;
}
new vehicleid = GetPlayerVehicleID(playerid);
SetPlayerVirtualWorld(playerid,0);
SetVehicleVirtualWorld(vehicleid,0);
LACY_GiveMoney(playerid,10000);
format(string,sizeof(string),".ניצח במקום השני במירוץ, מחכים לשלישי %s",GetName(playerid));
SendClientMessageToAll(COLOR_ORANGE,string);
WinnerRace ++;
RacePlayers --;
return 1;
}
if(WinnerRace == 3)
{
if(RacePlayers == 0)
{
SendClientMessageToAll(WHITE,"המירוץ הסתיים בהצלחה, לא היה שחקן שיסיים במקום השני / השלישי אז המערכת בוטלה");
for(new i=0; i<MAX_PLAYERS; i++)
{
if(Youregisterrace[i] ==1)
{
RaceEnd =0;
WinnerRace=0;
RacePlayers=0;
IFraceOn=0;
RaceCP[playerid]=0;
new vehicleida = GetPlayerVehicleID(i);
SetPlayerVirtualWorld(i,0);
SetVehicleVirtualWorld(vehicleida,0);
DisablePlayerRaceCheckpoint(i);
Youregisterrace[i] =0;
RaceCP[i]=0;
}
}
return 1;
}
new vehicleid = GetPlayerVehicleID(playerid);
SetPlayerVirtualWorld(playerid,0);
SetVehicleVirtualWorld(vehicleid,0);
LACY_GiveMoney(playerid,5000);
format(string,sizeof(string),".ניצח במקום השלישי, המירוץ הסתיים %s",GetName(playerid));
SendClientMessageToAll(COLOR_ORANGE,string);
WinnerRace ++;
RacePlayers --;
for(new i=0; i<MAX_PLAYERS; i++)
{
if(Youregisterrace[i] ==1)
{
RaceEnd =0;
WinnerRace=0;
RacePlayers=0;
IFraceOn=0;
RaceCP[playerid]=0;
new vehicleida = GetPlayerVehicleID(i);
SetPlayerVirtualWorld(i,0);
SetVehicleVirtualWorld(vehicleida,0);
DisablePlayerRaceCheckpoint(i);
Youregisterrace[i] =0;
RaceCP[i]=0;
}
}
}
}
}
//=LOS
new str[256];
if(InCityRaceing[playerid] > 0)
{
CityCP[playerid]++;
if(CityCP[playerid] < 29)
{
DisablePlayerRaceCheckpoint(playerid);
SetPlayerRaceCheckpoint(playerid,0,CityCPs[CityCP[playerid]][0],CityCPs[CityCP[playerid]][1],CityCPs[CityCP[playerid]][2],CityCPs[CityCP[playerid]+1][0],CityCPs[CityCP[playerid]+1][1],CityCPs[CityCP[playerid]+1][2],50.0);
}
if(CityCP[playerid] == 29)
{
DisablePlayerRaceCheckpoint(playerid);
SetPlayerRaceCheckpoint(playerid,1,-2681.938, 1310.6881, 55.3563,-2681.938, 1310.6881, 55.3563,50.0);
}
if(CityCP[playerid] == 30 && InCityRaceing[playerid] > 0)
{
SendClientMessageToAll(COLOR_WHITE,"»»~ | Special Race City Winner | »»~");
format(str, sizeof(str), ".$3000 ניצח בקרב המירוצים, זכה בסכום כספי של כ ,%s",GetName(playerid));
SendClientMessageToAll(0x16EB43FF, str);
SendClientMessageToAll(COLOR_WHITE,"»»~ | נתראה במירוץ הבא | »»~ ");
LACY_GiveMoney(playerid,3000);
for(new i = 0; i < MAX_PLAYERS; i++)
{
CityRaceingOn = 0;
CountCityRaceingr = 0;
CityRaceingPlayers = 0;
CityCP[i] = 0;
if(InCityRaceing[i] > 0)
{
DisablePlayerRaceCheckpoint(i);
SetPlayerVirtualWorld(i,1);
TogglePlayerControllable(i,1);
InCityRaceing[i] = 0;
if(IsPlayerInAnyVehicle(i))
{
SetVehicleVirtualWorld(GetPlayerVehicleID(i),1);
}
}
}
}
}

//LOS SANTOS


if(InCityRaceing2[playerid] == 1)
{
CityCP[playerid]++;
if(CityCP[playerid] < 15)
{
DisablePlayerRaceCheckpoint(playerid);
SetPlayerRaceCheckpoint(playerid,0,CityCPs2[CityCP[playerid]][0],CityCPs2[CityCP[playerid]][1],CityCPs2[CityCP[playerid]][2],CityCPs2[CityCP[playerid]+1][0],CityCPs2[CityCP[playerid]+1][1],CityCPs2[CityCP[playerid]+1][2],50.0);
}
if(CityCP[playerid] == 15)
{
DisablePlayerRaceCheckpoint(playerid);
SetPlayerRaceCheckpoint(playerid,1,2887.9311, -1592.2507, 10.7739,2887.9311, -1592.2507, 10.7739,50.0);
}
if(CityCP[playerid] == 16)
{
SendClientMessageToAll(COLOR_WHITE,"»»~ | Special Race City Winner | »»~");
format(str, sizeof(str), ".$3000 ניצח בקרב המירוצים, זכה בסכום כספי של כ ,%s",GetName(playerid));
SendClientMessageToAll(0x16EB43FF, str);
SendClientMessageToAll(COLOR_WHITE,"»»~ | נתראה במירוץ הבא | »»~ ");
LACY_GiveMoney(playerid,3000);
for(new i = 0; i < MAX_PLAYERS; i++)
{
CityRaceingOn = 0;
CountCityRaceingr = 0;
CityRaceingPlayers = 0;
CityCP[i] = 0;
if(InCityRaceing2[i] > 0)
{
InCityRaceing2[i] = 0;
DisablePlayerRaceCheckpoint(i);
SetPlayerVirtualWorld(i,1);
TogglePlayerControllable(i,1);
if(IsPlayerInAnyVehicle(i))
{
SetVehicleVirtualWorld(GetPlayerVehicleID(i),1);
}
}
}
}
}
return 1;
}
public OnPlayerEnterCheckpoint(playerid)
{


if(CPS_IsPlayerInCheckpoint(playerid,pickupammu)) return SetPlayerPos(playerid,290.4897,-84.4233,1001.5156),SetPlayerInterior(playerid,4),ResetPlayerWeapons(playerid);

if(CPS_IsPlayerInCheckpoint(playerid,be)) return SetPlayerPos(playerid,2144.0793,1612.3879,993.6882),SetPlayerInterior(playerid,1),ResetPlayerWeapons(playerid);
if(CPS_IsPlayerInCheckpoint(playerid,nobank))return SetPlayerPos(playerid,1424.9977,-2285.6335,13.3828),SetPlayerInterior(playerid,0),AtBank[playerid]=0;
if(CPS_IsPlayerInCheckpoint(playerid,Wang))return SellWangExportVehicle(playerid);

if(CPS_IsPlayerInCheckpoint(playerid,bcp)){

SendClientMessage(playerid, COLOR_PINK,  ".-מנהל הבנק: שלום לך , בבנק שלנו תוכל לשמור את הכסף שלך");
SendClientMessage(playerid, COLOR_PINK,  ".לקחת הלוואת , לקנות כרטיס אשראי הבנק שלנו נותן תשרות הטוב ביותר");
SendClientMessage(playerid, COLOR_PURPLE,":פקודות בנק");
SendClientMessage(playerid, 0xF6F658FF,  "/deposit [amount] /depositall /withdraw [amount] /balance /bankid [playerid] [amount]");
SendClientMessage(playerid, 0xF6F658FF,  "/getloan (4) [amount] /backloan (4)");
SendClientMessage(playerid,0xF6F658FF,   "/help bank :לעזרה מפרטת על הבנק");
SendClientMessage(playerid, COLOR_PURPLE,":פקודות כרטיס אשראי");
SendClientMessage(playerid, 0xF6F658FF,  "/buycc (3) /sellcc (3) /withdrawc (3) [amount]");
SendClientMessage(playerid, 0xF6F658FF,  "/help cc :לעזרה מפרטת על כרטיס האשראי");
if(PlayerInfo[playerid][GetAloan] ==1) {
new string[256];
format(string, sizeof(string),"* %d :שלום לך , אתה חייב לבנק סכום של",PlayerInfo[playerid][MoneyLoan]),SendClientMessage(playerid,red,string),SendClientMessage(playerid,red,".עם לא תחזיר לא תוכל להשתמש בבנק /backloan להחזרת החוב");
}
}

switch(getCheckpointType(playerid))
{
case CP_PIRATE:
{
SendClientMessage(playerid, COLOR_WHITE,"---  System Ship (44) - מערכת ספינת פיראטים --");
SendClientMessage(playerid, COLOR_PINK,".שים לב, כל עוד אתה עומד על ספינת הפיראטים, אתה תקבל סכום שנע בין ל-100-200 דולר");
SendClientMessage(playerid,COLOR_LIGHTGREEN,":מיוחד");
SendClientMessage(playerid, COLOR_PINK,".בנק הספינה רמה: 5 ומעלה");
SendClientMessage(playerid, COLOR_PINK,".בבנק הספינה אתה יכול להפקיד תכסף ישר לבנק מאשר לקבל אותו ליד");
SendClientMessage(playerid, COLOR_PINK,".שים לב, הבנק לוקח ריבית של 50 דולר כל הכנסה, הבנק יתעדכן פעם ב10 שניות");
SendClientMessage(playerid,0xF6F658FF,"/sbstop (5) - לקיחת הכסף מבנק הספינה /sbship (5) - התחלת בנק הספינה");
}
case CP_AMMU:
{
SendClientMessage(playerid, COLOR_WHITE,"---  Ammutions (31) - מערכת נשקים --");
SendClientMessage(playerid, COLOR_PINK,"עזרה קניית נשקים");
SendClientMessage(playerid, COLOR_PINK,".בעזרה זה מותקנת אפשרות לקנות נשקים תמדיים שישמרו לאחר שתצא ותכנס");
SendClientMessage(playerid, COLOR_LIGHTGREEN,":פקודות קניית נשק");
SendClientMessage(playerid, 0xF6F658FF,"/buyweapon - קניית נשק (/bw) - קיצור [number weapon] /weaponlist - רשימת נשקים (/wl) - קיצור");
SendClientMessage(playerid,COLOR_LIGHTGREEN,":מיוחד");
SendClientMessage(playerid,0xF6F658FF,"/buyarmour - קניית מגן");
}
}

return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{

	return 1;
}
public OnPlayerRequestClass(playerid, classid){


SetPlayerInterior(playerid,5);
SetPlayerPos(playerid,1255.2324,-804.4816,1084.0151);
SetPlayerFacingAngle(playerid, 272.5872);
SetPlayerCameraPos(playerid,1259.0543,-804.1009,1084.0078);
SetPlayerCameraLookAt(playerid,1255.2324,-804.4816,1084.0151);



if(classid == 25 || classid == 41 ||  classid == 125 || classid == 122 || classid == 123 || classid == 102 ||  classid == 103 || classid == 42 ||  classid == 106 ||  classid == 105 || classid == 43 || classid == 44 || classid == 45 || classid == 46)
{
iSpawnSet[playerid] = 1;
}
else
{
iSpawnSet[playerid] = 0;
}
return 1;
}


public OnPlayerRequestSpawn(playerid) {
new str[256];
if(!dini_Exists(GetPlayerFile(playerid))) {
format(str, sizeof(str), "/Register [Pass] <> :קודם כל הרשם/י עם לביצוע ההרשמה");
SendClientMessage(playerid, COLOR_WHITE , str);
spawnloged[playerid] =1;
return 0;
}
else if(dini_Exists(GetPlayerFile(playerid)) && PlayerInfo[playerid][Logged] == 0)
{
format(str, sizeof(str), "/login [Pass] <> :קודם כל התחבר/י לביצוע החיבור",0);
SendClientMessage(playerid, COLOR_WHITE, str);
spawnloged[playerid] =1;
return 0;
}
CamreaRandom ++;
SetPlayerMapIcon( playerid, 1, 2057.5842, 843.3260, 6.7031, 53, 0 );//race
SetPlayerMapIcon( playerid, 3, 2001.6742, 1544.2804, 13.5859, 9, 0 );//ship
SetPlayerMapIcon( playerid, 7, 1618.8290,-238.6926,14.1484, 5, 0 );//airport
SetPlayerMapIcon( playerid, 8, 2323.6238, 1425.8101, 42.8203, 55, 0 );//drifts
SetPlayerMapIcon( playerid, 9, 2386.9690, 1043.2112, 10.8203, 27, 0 );//garage
SetPlayerMapIcon( playerid, 10, 2507.1418, 1243.0775, 10.8203, 23, 0 );//club
SetPlayerMapIcon( playerid, 4, -2715.9399, 217.8603, 4.3481, 27, 0 );//מוסך
SetPlayerMapIcon( playerid, 5, 2387.1956, 1050.5073, 10.3850, 27, 0 );//מוסך
SetPlayerMapIcon( playerid, 6, 2646.3372, -2038.0317, 13.1468, 27, 0 );//מוסך
SetTimerEx("CafolMoneyGemel",54*60*1000,1,"i",playerid);
if(CamreaRandom == 3) return CamreaRandom = 1;
return 1;
}
//-=-=-=-=-=-=-=-=-=-=-=-
forward GameModeInitExitFunc();
public GameModeInitExitFunc()
{
fnm
GameModeExit();
SaveProperties();
SaveFiles();
KillTimer(CheckPointTimer);
//==[Dis]====
//NoMoreObject[i] =0;
FakeKill[i] = 0;
//=[ESC]==========================================================
//gState[i] = e_STATE_NONE;
//=[UnZibori]======================================================
//=[SetVirtualWorldCAR]=============================================
new vehicleid = GetPlayerVehicleID(i);
SetPlayerVirtualWorld(i,0);
SetVehicleVirtualWorld(vehicleid,0);
//=[UnIgnoreDisconecet]=========================================
Ignore[i][i] =0;
//=[InLcTeleport`s]===============================================
InLcTeleport[i] = 0;
//=[Weed`s]=======================================================
Stoned[i] =0;
//=[Pet`sDelete]===================================================
if(PlayerInfo[i][Pets] ==1)
{
if(PlayerInfo[i][Shark] ==1)
{
DestroyDynamicObject(sam33[i]);
SharkYou[i] =0;
ThePetsInYou[i] =0;
}
if(PlayerInfo[i][Dolp] ==1)
{
DestroyDynamicObject(sam22[i]);
ThePetsInYou[i] =0;
DolpYou[i] =0;
}
if(PlayerInfo[i][Tor] ==1)
{
DestroyDynamicObject(sam44[i]);
ThePetsInYou[i] =0;
TorYou[i] =0;
}
}
ThePetsInYou[i] =0;
DolpYou[i] =0;
SharkYou[i] =0;
TorYou[i] =0;
//=[CarSystem`s]========================================================
pia[i][CarID] = 0;
pia[i][OwnCar] = 0;
//=[FL]==================================================================
PlayerInfo[i][FL] =0;
//=[SavePinfo]============================================================
if(dini_Exists(GetPlayerFile(i)) && IsPlayerLogged(i))
{
PlayerInfo[i][Logged] = 0;
dini_IntSet(GetPlayerFile(i),"Tor",PlayerInfo[i][Tor]);
dini_IntSet(GetPlayerFile(i),"Dolphin",PlayerInfo[i][Dolp]);
dini_IntSet(GetPlayerFile(i),"Pets",PlayerInfo[i][Pets]);
dini_IntSet(GetPlayerFile(i),"Shark",PlayerInfo[i][Shark]);
dini_IntSet(GetPlayerFile(i),"SharkKills",PlayerInfo[i][SharkKills]);
dini_IntSet(GetPlayerFile(i),"TorKills",PlayerInfo[i][TorKills]);
dini_IntSet(GetPlayerFile(i),"DolphinKills",PlayerInfo[i][DolphinKills]);
dini_IntSet(GetPlayerFile(i),"ProfileLogeed",PlayerInfo[i][ProfileLogged]);
dini_IntSet(GetPlayerFile(i),"Logged",PlayerInfo[i][Logged]);
dini_IntSet(GetPlayerFile(i),"Kills",PlayerInfo[i][Kills]);
dini_IntSet(GetPlayerFile(i),"Deaths",PlayerInfo[i][Deaths]);
dini_IntSet(GetPlayerFile(i),"Level",PlayerInfo[i][Level]);
dini_IntSet(GetPlayerFile(i),"GemelLogin",PlayerInfo[i][GemelLogin]);
dini_IntSet(GetPlayerFile(i),"KopatGemel",PlayerInfo[i][KopatGemel]);
dini_IntSet(GetPlayerFile(i),"AggInfo",PlayerInfo[i][AggInfo]);
dini_IntSet(GetPlayerFile(i),"aLevelnl",PlayerInfo[i][aLevelnl]);
dini_IntSet(GetPlayerFile(i),"aKillsnl",PlayerInfo[i][aKillsnl]);
dini_IntSet(GetPlayerFile(i),"Adminl",PlayerInfo[i][AdminsLevel]);
dini_IntSet(GetPlayerFile(i),"Wars",PlayerInfo[i][Wars]);
dini_IntSet(GetPlayerFile(i),"Karts",PlayerInfo[i][Kart]);
dini_IntSet(GetPlayerFile(i),"MonsterWin",PlayerInfo[i][Monster]);
dini_IntSet(GetPlayerFile(i),"RPGWIN",PlayerInfo[i][RPGS]);
dini_IntSet(GetPlayerFile(i),"MiniWin",PlayerInfo[i][MINIGUN]);
dini_IntSet(GetPlayerFile(i),"mlg",PlayerInfo[i][Mlg]);
dini_IntSet(GetPlayerFile(i),"Warning",PlayerInfo[i][Warnings]);
dini_IntSet(GetPlayerFile(i),"pWeeds",PlayerInfo[i][Weeds]);
dini_IntSet(GetPlayerFile(i),"TimeOnServer",PlayerInfo[i][TimeOnServer]);
dini_IntSet(GetPlayerFile(i),"Money",GetPlayerMoney(i));
dini_IntSet(GetPlayerFile(i),"autologins",PlayerInfo[i][autologin]);
dini_IntSet(GetPlayerFile(i),"GetAloan",PlayerInfo[i][GetAloan]);
dini_IntSet(GetPlayerFile(i),"MoneyLoan",PlayerInfo[i][MoneyLoan]);
dini_IntSet(GetPlayerFile(i),"armour",PlayerInfo[i][armourT]);
dini_IntSet(GetPlayerFile(i),"VIP",PlayerInfo[i][VIPS]);
dini_IntSet(GetPlayerFile(i),"CC",PlayerInfo[i][CcMode]);
dini_Set(GetPlayerFile(i),"State","Offine");
//=[Delete]=====================================================
PlayerInfo[i][Warnings]=0;
PlayerInfo[i][VIPS] = 0;
PlayerInfo[i][armourT] = 0;
PlayerInfo[i][ProfileLogged] =0;
PlayerInfo[i][Warnings] = 0;
PlayerInfo[i][Weeds] = 0;
PlayerInfo[i][TimeOnServer]=0;
PlayerInfo[i][Logged] = 0;
PlayerInfo[i][Level] = 0;
PlayerInfo[i][Kills] = 0;
PlayerInfo[i][Deaths] = 0;
PlayerInfo[i][Wars] = 0;
PlayerInfo[i][autologin] = 0;
PlayerInfo[i][GetAloan] =0;
PlayerInfo[i][MoneyLoan] =0;
PlayerInfo[i][AdminsLevel] = 0;
PlayerInfo[i][Kart] = 0;
PlayerInfo[i][AggInfo] =0;
PlayerInfo[i][GemelLogin] = 0;
PlayerInfo[i][KopatGemel] =0;
PlayerInfo[i][Monster] = 0;
PlayerInfo[i][RPGS] = 0;
PlayerInfo[i][MINIGUN] = 0;
PlayerInfo[i][Mlg] = 0;
PlayerInfo[i][CcMode] = 0;
PlayerInfo[i][Supportives] =0;
PlayerInfo[i][Tor] =0;
PlayerInfo[i][Pets] =0;
PlayerInfo[i][Shark] =0;
PlayerInfo[i][Dolp] =0;
PlayerInfo[i][SharkKills] =0;
PlayerInfo[i][DolphinKills]=0;
PlayerInfo[i][TorKills] =0;
PlayerInfo[i][bazooka] =0;
PlayerInfo[i][aLevelnl]=0;
PlayerInfo[i][aKillsnl]=0;
PlayerInfo[i][Sawn] = 0;
PlayerInfo[i][MicroSMG] = 0;
PlayerInfo[i][Tec9] = 0;
PlayerInfo[i][M4] = 0;
PlayerInfo[i][MP5] = 0;
PlayerInfo[i][AK47] = 0;
PlayerInfo[i][Knife] = 0;
PlayerInfo[i][Katana] = 0;
PlayerInfo[i][CombatShotGun] = 0;
PlayerInfo[i][ShotGun] = 0;
PlayerInfo[i][SniperRifle] = 0;
PlayerInfo[i][CRifle] = 0;
PlayerInfo[i][Colt] = 0;
PlayerInfo[i][Sawn] = 0;
}
//=[DiscPhone]=================================================================
OnPlayerCommandText(i,"/Hangup");
//=[OutSystem`s]================================================================
if(Registertrs[i] ==1)
{
CPTriatlon[i]=0;
DisablePlayerRaceCheckpoint(i);
Registertrs[i] =0;
CPTriatlon[i]=0;
RunPlayers--;
}
//=[OutSystem`s]================================================================
if(YouRegister[i] ==1)
{
YouRegister[i] =0;
DisablePlayerRaceCheckpoint(i);
DriftPlayer--;
}
//=[OutSystem`s]================================================================
if(Youregisterrace[i] ==1)
{
Youregisterrace[i] =0;
RacePlayers--;
DisablePlayerRaceCheckpoint(i);
}
//=[OutSystem`s]================================================================
if(PPw[i] == 1)
{
ResetPlayerWeapons(i);
SendClientMessage(i,WHITE,".עזבת את הפעילות שבא הייתה");
ResetPlayerWeapons(i);
WarPlayersw --; InWarw[i] = 0; PPw[i] = 0;
}
//=[OutSystem`s]================================================================
if(PP[i] == 1)
{
ResetPlayerWeapons(i);
SendClientMessage(i,WHITE,".עזבת את הפעילות שבא הייתה");
WarPlayers --;
InWar[i] = 0;
PP[i] = 0;
}
//=[OutSystem`s]================================================================
if(PPr[i] == 1)
{
ResetPlayerWeapons(i);
SendClientMessage(i,WHITE,".עזבת את הפעילות שבא הייתה");
ResetPlayerWeapons(i);
WarPlayersr --; InWarr[i] = 0; PPr[i] = 0;
}
//=[OutSystem`s]================================================================

if(MonsterNoTeleportion[i] == 1)
{
MonsterPlayers --; iNmOnster[i] = 0; MonsterNoTeleportion[i] = 0; MonsterFucker[i] = 0;
DestroyVehicle(MonsterSYSTEM[i]);
MonStart[i] =0;
}
//=[OutSystem`s]================================================================
if(KK[i] == 1)
{
ResetPlayerWeapons(i);
SendClientMessage(i,WHITE,".Kart .עזבת את הפעילות ");
KartPlayers --; InKart[i] = 0; KK[i] = 0; Fuck[i] = 0;
DestroyVehicle(caridxx[i]);
}
//=[LeaveGange`s]====================================================
PlayerLeaveGang(i);
//=[Prop]=============================================================

//=[Reason]==========================================================
new string[256];
format(string, sizeof(string), "*** %s has left the server. (ModeReset)", GetName(i)),SendClientMessageToAll(COLOR_GREY, string);
}
return 1;
}
//CAR====
//==============================================================================
forward LoadFiles();
public LoadFiles()
{
	new  VPrice[MAX_VEHICLES];
	VCount =CreateVehicle(411,0,0,0,0,0,0,-1);
	DestroyVehicle(VCount);

	printf(" || - Car In The Mode %d || - Car System - Roy. ",VCount-1);


	for (new car=1; car < VCount; car++)
	{
		format(file,sizeof(file),"CarSys/car%d.txt",car);
		if(!dini_Exists(file))
		{
			dini_Create(file); CreateCount++;
		    dini_IntSet(file,"CarID",car);


		    dini_Set(file,"CarName",VehNames[GetVehicleModel(car)-400] );
			dini_IntSet(file,"CarModel",GetVehicleModel(car));
		    dini_IntSet(file,"CarOwned",0);
		    dini_Set(file,"CarOwner","אין");

		    dini_IntSet(file,"Buyable",1);
		    dini_IntSet(file,"Price",50000);
		    dini_IntSet(file,"LevelCar",0);
		    dini_IntSet(file,"SaleV",0);



			VehicleInfo[car][LevelCar] = dini_Int(file,"LevelCar");
			VehicleInfo[car][SaleV] = dini_Int(file,"SaleV");

   			VehicleInfo[car][CarID] = dini_Int(file,"CarID");
  
			strmid(VehicleInfo[car][CarName], dini_Get(file,"CarName"), 0, strlen(dini_Get(file,"CarName")), 255);
			VehicleInfo[car][CarModel] = dini_Int(file,"CarModel");
			VehicleInfo[car][CarOwned] = dini_Int(file,"CarOwned");
			strmid(VehicleInfo[car][CarOwner], dini_Get(file,"CarOwner"), 0, strlen(dini_Get(file,"CarOwner")), 255);
			VehicleInfo[car][Buyable] = dini_Int(file,"Buyable");



VPrice[car] = 50000;
for(new v=0; v < sizeof(boat); v++) if(VehicleInfo[car][CarModel] == boat[v][0])
VPrice[car] = 10000;
for(new v=0; v < sizeof(bike); v++) if(VehicleInfo[car][CarModel] == bike[v][0])
VPrice[car] = 300000;
for(new v=0; v < sizeof(plane); v++) if(VehicleInfo[car][CarModel] == plane[v][0])
VPrice[car] = 150000;
for(new v=0; v < sizeof(expensive); v++) if(VehicleInfo[car][CarModel] == expensive[v][0])
VPrice[car] = 100000;
for(new v=0; v < sizeof(Vexpensive); v++) if(VehicleInfo[car][CarModel] == Vexpensive[v][0])
VPrice[car] = 190000;
VehicleInfo[car][Price] = VPrice[car];
dini_IntSet(file,"Price",VehicleInfo[car][Price]);
}
else if(dini_Exists(file))
{
VehicleInfo[car][SaleV] = dini_Int(file,"SaleV");
VehicleInfo[car][LevelCar] = dini_Int(file,"LevelCar");
VehicleInfo[car][CarID] = dini_Int(file,"CarID");
strmid(VehicleInfo[car][CarName], dini_Get(file,"CarName"), 0, strlen(dini_Get(file,"CarName")), 255);
VehicleInfo[car][CarModel] = dini_Int(file,"CarModel");
VehicleInfo[car][CarOwned] = dini_Int(file,"CarOwned");
strmid(VehicleInfo[car][CarOwner], dini_Get(file,"CarOwner"), 0, strlen(dini_Get(file,"CarOwner")), 255);
VehicleInfo[car][Buyable] = dini_Int(file,"Buyable");
VehicleInfo[car][Price] = dini_Int(file,"Price");

if(dini_Int(file,"CarOwned") == 1)
{
printf("           %d       Owner: %s",car,VehicleInfo[car][CarOwner]);
}
}
}
for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) OnPlayerConnect(i);
}
//==============================================================================
public SaveFiles()
{
for (new car=1; car < VCount; car++)
{
format(file,sizeof(file),"CarSys/car%d.txt",car);
if(dini_Exists(file))
{
dini_IntSet(file,"CarOwned",VehicleInfo[car][CarOwned]);
if(VehicleInfo[car][CarOwned] == 0) dini_Set(file,"CarOwner","אין");
if(VehicleInfo[car][CarOwned] == 1) dini_Set(file,"CarOwner",VehicleInfo[car][CarOwner]);
dini_IntSet(file,"Buyable",VehicleInfo[car][Buyable]);
dini_IntSet(file,"Price",VehicleInfo[car][Price]);
}
}
}
//ENDCAR===
//-=-=-=-=-=-=-



public OnGameModeInit()
{
Object_Object();
Object_Object();
/*AddServerRule("Team Speak IP:", "80.179.149.52");
AddServerRule("Team Speak Port: ","4545");
AddServerRule("build data", "3/10/2008");
AddServerRule("Kind", "DeathMatch");
SetServerRule("version","0.2X (SA:MP, Satla-Zone V4)");
AddServerRule("Mode Versoin", "V3.9");*/

print("--- Add Timer`s ---");
SetTimer("Maths", 120*60*1000, 1);
SetTimer("StartFireworks",3000,1);
SetTimer("SaveFileRLSB",5000,1);
//=[Resert]================================================
CamreaRandom = 1;
/*
//=[TextDraw]================================================
Box1 = TextDrawCreate(320.0, 375, "- ~n~ - ~n~ - ~n~ - ~n~ -");
TextDrawAlignment(Box1, 2);
TextDrawBoxColor(Box1,0x000000FF);
TextDrawColor(Box1,0x000000FF);
TextDrawFont(Box1, 2);
TextDrawLetterSize(Box1, 2.2, 4.0);
TextDrawSetProportional(Box1, 1);
TextDrawSetShadow(Box1, 1);
TextDrawTextSize(Box1, 80.0, 1280.0);
TextDrawUseBox(Box1, 1);
Box2 = TextDrawCreate(320.0,0.0, "- ~n~ -");
TextDrawAlignment(Box2, 2);
TextDrawBoxColor(Box2,0x000000FF);
TextDrawColor(Box2,0x000000FF);
TextDrawFont(Box2, 2);
TextDrawLetterSize(Box2, 2.2, 4.0);
TextDrawSetProportional(Box2, 1);
TextDrawSetShadow(Box2, 1);
TextDrawTextSize(Box2, 80.0, 1280.0);
TextDrawUseBox(Box2, 1);
*/

Textdraw1 = TextDrawCreate(1.00000,420.000000," Satla-Zone.co.il - DeathMatch.");
TextDrawAlignment(Textdraw1,1);
TextDrawBackgroundColor(Textdraw1,0x00000066);
TextDrawColor(Textdraw1,0x00000066);
TextDrawFont(Textdraw1,1);
TextDrawLetterSize(Textdraw1,0.6,1);

//=[Timer`s]=================================================
print("--- Add Timer`s ---");
SetTimer("OnGetPlayerKeys", 250, 1);
SetTimer("AntiGamebling",3000,1);
//SetTimer("BoomPlayer",1000,1);
SetTimer("Msc",700*60*1000,1);
SetTimer("AntiMinigun",3*1000,1);
SetTimer("AntiBaz",3*1000,1);
SetTimer("GateMove",1000,1);
//SetTimer("KickUpdate", 100, 1);
SetTimer("Levels",1000, 1);
CheckPointTimer = SetTimer("checkpointUpdate",100, 1);
SetTimer("LoadFiles",4000,0);
SetTimer("loan",60*60*1000,1);
SetTimer("UpdateSpeed",1000, 1);
SetTimer("CWarnings",1000,1);
SetTimer("rspam",3500,1);
SetTimer("rrr",5*60*1000,1);
SetTimer("ss",45*60*1000,1);
SetTimer("MissoinpointUpdate",1000,1);
SetTimer("MoneyGrubScoreUpdate", 1000, 1);
SetTimer("checkpointUpdate", 1100, 1);
SetTimer("PirateShipScoreUpdate",3000, 1);
SetTimer("StreamTimer", 500, 1);
SetTimer("SavedUpdate",60017, 1);
SetTimer("TimeUpdate",12*60*1000,1);
SetTimer("GambleUpdate", 5013, 1);
SetTimer("SavedUpdate",60017, 1);
SetTimer("Rhelp",20*1000,1);
SetTimer("Rcall",120*1000,1);
SetTimer("Rpet",2*1000,1);
SetTimer("Rfb",20*1000,1);
SetTimer("PetAtacks",1000,1);
SetTimer("ClanColor",5000,1);
SetTimer("SAM_timer", 500, 1);
//SetTimer("AutoChangeHN", 2000, 1);
#if MONEY_CHEAT_USE
//SetTimer("moneycheat_check", MONEY_CHEAT_TIMER, 1);
#endif
print("--- Add Timer`s END ---");
print("--- Set HOST NAME ---");
print("--- Set Mode name && MapName ---");
SendRconCommand("mapname Satla's World");
SetGameModeText("Fear DeathMatch.");
//=[TextDraw`s]====================================================
/*
Textdraw1 = TextDrawCreate(1.00000,420.000000,"~l~www.Satla-Zone.co.il - BCV.1.9 - DeatchMatch.");
TextDrawAlignment(Textdraw1,3);
TextDrawBackgroundColor(Textdraw1,-0x1E2E29FF-6);
TextDrawFont(Textdraw1,2);
TextDrawLetterSize(Textdraw1,0.5,1.1);
TextDrawSetOutline(Textdraw1,2);
TextDrawSetProportional(Textdraw1,3);
TextDrawSetShadow(Textdraw1,2);
*/
print("--- Fixeld sys ---");
//=[Fixesystem]====================================================
RaceEnd=1;
//=[Checkpoint]====================================================
print("--- Add CheackPointing ---");
Wang       = CPS_AddCheckpoint(-1919.0795,303.1454,41.0469,2.5,50);
bcp        = CPS_AddCheckpoint(2143.9777,1640.0800,993.5761,2.5,50);
be         = CPS_AddCheckpoint(1448.8737,-2287.2822,13.5469,1.5,50);
pickupammu = CPS_AddCheckpoint(1022.4660,-1122.3158,23.8713,1.3,12);
nobank     = CPS_AddCheckpoint(2144.0898,1607.6897,993.6882,1.5,50);
//=[Function]=====================================================
print("--- Markers ---");
ShowPlayerMarkers(1);
print("--- Show Tags ---");
ShowNameTags(1);
print("--- Fix Runing ---");
UsePlayerPedAnims();
print("--- Admin Can Teleport from map ---");
AllowAdminTeleport(1/1);
EnableZoneNames(1/1);
print("--- Tire No Popping ---");
EnableTirePopping(0);
print("--- Dont gm on stunts ---");
EnableStuntBonusForAll(0);
print("--- Allow Weapon INT - 10 ---");
AllowInteriorWeapons(10);
//=[Pickup`s]====================================================
//Weed`s:
print("--- Add Pickuping - WEED ---");
Weed[0] = AddStaticPickup(1279, 15, 2199.3457,940.7413,10.8203);
Weed[1] = AddStaticPickup(1279, 15, 1600.4449,1160.7339,10.8125);
Weed[2] = AddStaticPickup(1279, 15, 2590.3806,1656.5795,11.0234);
Weed[3] = AddStaticPickup(1279, 15, 2495.2344,1859.9387,13.6379);
Weed[4] = AddStaticPickup(1279, 15, 2503.3037,-1701.1526,13.5491);
//=[PlayerClass]=================================================
print("--- Add Class ---");
AddPlayerClass(1,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(2,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(293,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(290,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(291,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(292,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(294,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(295,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(296,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(297,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(298,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(299,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(277,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(278,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(279,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(288,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(47,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(48,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(49,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(50,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(51,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(52,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(53,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(54,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(55,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(56,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(57,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(58,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(59,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(60,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(61,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(62,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(63,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(64,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(66,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(67,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(68,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(69,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(70,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(71,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(72,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(73,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(75,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(76,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(78,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(79,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(80,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(81,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(82,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(83,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(84,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(85,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(87,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(88,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(89,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(91,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(92,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(93,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(95,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(96,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(97,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(98,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(99,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(100,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(101,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(102,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(103,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(104,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(105,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(106,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(107,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(108,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(109,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(110,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(111,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(112,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(113,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(114,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(115,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(116,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(117,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(118,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(120,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(121,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(122,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(123,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(124,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(125,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(126,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(127,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(128,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(129,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(131,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(133,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(134,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(135,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(136,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(137,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(138,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(139,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(140,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(141,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(142,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(143,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(144,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(145,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(146,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(147,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(148,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(150,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(151,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(152,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(153,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(154,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(155,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(156,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(157,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(158,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(159,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(160,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(161,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(162,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(163,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(164,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(165,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(166,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(167,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(168,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(169,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(170,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(171,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(172,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(173,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(174,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(175,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(176,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(177,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(178,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(179,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(180,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(181,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(182,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(183,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(184,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(185,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(186,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(187,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(188,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(189,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(190,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(191,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(192,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(193,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(194,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(195,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(196,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(197,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(198,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(199,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(200,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(201,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(202,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(203,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(204,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(205,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(206,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(207,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(209,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(210,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(211,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(212,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(213,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(214,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(215,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(216,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(217,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(218,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(219,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(220,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(221,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(222,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(223,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(224,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(225,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(226,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(227,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(228,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(229,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(230,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(231,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(232,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(233,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(234,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(235,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(236,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(237,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(238,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(239,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(240,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(241,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(242,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(243,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(244,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(245,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(246,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(247,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(248,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(249,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(250,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(251,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
AddPlayerClass(253,2056.5640,840.7169,6.7260,269.1425,0,0,24,300,-1,-1);
print("--- END ADD Classes ---");
//==[Car`s]==============================================================================
//Other:
print("--- Add Cars ---");
AddStaticVehicle(451,2779.8992,2439.7473,10.5110,310.9976,100,100); // Near MInigun THIS NEW
AddStaticVehicle(522,2784.3052,2435.4504,10.3879,317.1129,3,8); // Near MInigun THIS NEW NRG-500 Back Turismo
AddStaticVehicle(560,2788.7144,2431.4922,10.5251,315.8957,33,0); // Near MInigun THIS NEW Sultan
AddStaticVehicle(411,2792.8586,2427.4941,10.5474,315.1897,100,100); // Near MInigun THIS NEW Infernus
AddStaticVehicle(522,1543.9092,787.8228,10.3743,359.6741,6,25); // Car NRG-500 Near "/RACE" Teleportoin
AddStaticVehicle(495,-2404.3225,-2168.5193,33.6143,263.8668,119,122); // /cycletripcar
AddStaticVehicle(495,-2395.8503,-2169.6726,33.6503,265.3340,118,117); // /cycletripcar
AddStaticVehicle(495,-2387.8657,-2169.5796,33.6264,264.8646,116,115); // /cycletripcar
AddStaticVehicle(510,-2412.1035,-2193.2402,32.8842,36.6689,5,5); // /cycletripcar
AddStaticVehicle(510,-2414.2776,-2193.0789,32.8849,43.4173,46,46); // /cycletripcar
AddStaticVehicle(510,-2415.7678,-2186.1248,32.8870,211.6870,6,6); // /cycletripcar
AddStaticVehicle(490,2200.7585,936.2398,10.9478,356.8191,0,0); // FBI
AddStaticVehicle(522,1775.5903,893.0415,26.4481,34.2547,7,79); // NRG- 500 On Roof
AddStaticVehicle(522,1782.1559,884.3701,26.4551,39.8569,7,79); // NRG- 500 On Roof
AddStaticVehicle(522,1772.7963,895.1856,26.4488,302.6107,7,79); // NRG- 500 On Roof
AddStaticVehicle(522,1782.2245,881.4796,26.4531,132.9686,7,79); // NRG- 500 On Roof
AddStaticVehicle(481,1541.8641,-1368.9618,328.9701,188.6927,46,46); // Tower
AddStaticVehicle(481,1545.6382,-1372.3322,328.9829,177.5936,6,6); // Tower
AddStaticVehicle(522,1552.3627,-1367.2386,329.0129,256.9888,7,79); // Tower
AddStaticVehicle(522,1552.3279,-1365.2297,329.0165,267.8723,0,0); // Tower
AddPlayerClass(1,-1631.0262,1419.6545,7.1875,311.6078,0,0,0,0,0,0); // teleports docks
AddStaticVehicle(522,-1619.2017,1422.8654,6.2231,322.7849,8,82); // NRG-500 Docks
AddStaticVehicle(522,-1617.0688,1420.7104,6.2286,316.3569,6,25); // NRG-500 Docks
AddStaticVehicle(446,-1547.5950,1461.3035,-0.3796,229.6041,3,3); // boat docks
AddStaticVehicle(595,-1545.7239,1432.8759,0.3090,229.3205,112,20); // boat docks
AddStaticVehicle(473,-1530.5471,1420.0940,-0.0530,220.3543,56,53); // boat docks
AddStaticVehicle(493,-1586.5896,1419.8721,-0.0586,231.2829,36,13); // boat docks
AddStaticVehicle(472,-1583.0050,1423.7670,-0.0556,224.2101,56,15); // boat docks
AddStaticVehicle(484,-1574.1376,1429.5065,0.3448,227.7396,50,32); // boat docks
AddPlayerClass(1,-2415.9922,-587.2974,132.7586,214.4959,0,0,0,0,0,0); // drift 2
AddStaticVehicle(541,-2414.4514,-586.9969,132.2690,214.4952,22,1); // drift 2
AddStaticVehicle(541,-2411.8425,-585.0082,132.2690,215.0867,86,6); // drift 2
AddStaticVehicle(451,-2400.0386,-589.3455,132.3544,124.6732,123,123); // drift 2
AddStaticVehicle(451,-2398.1990,-591.8680,132.3351,124.4981,36,36); // drift 2
AddStaticVehicle(451,-2396.1416,-594.5746,132.3348,123.8432,16,16); // drift 2
AddStaticVehicle(411,-2397.1367,-611.5197,132.3767,34.8895,75,1); // drift 2
//drifts:
print("--- Add Zibori Car ---");
AddStaticVehicle(568,-302.6403,1552.9385,75.2212,315.1620,56,29); //
AddStaticVehicle(468,-306.8715,1556.4517,75.0231,304.2789,6,6); //
AddStaticVehicle(468,-309.5418,1559.0822,75.0532,317.2950,53,53); //
AddStaticVehicle(451,-293.9301,1573.5503,75.0552,134.0287,123,123); //
AddStaticVehicle(451,-296.1785,1575.9091,75.0684,131.8275,125,125); //
AddStaticVehicle(495,-270.8748,1551.7755,75.6830,134.4523,6,6); //
AddStaticVehicle(495,-268.6550,1548.7106,75.6994,131.8289,1,1); //
AddStaticVehicle(495,-266.3898,1546.2604,75.7147,131.3287,3,3); //
AddStaticVehicle(495,-264.2098,1544.0552,75.7135,133.1902,0,0); //
AddStaticVehicle(451,-2394.6299,-596.7819,132.3545,125.7884,46,46); // Cars Drift Turmiso
AddStaticVehicle(451,-2392.8037,-599.4668,132.3549,307.0936,123,123); // Cars Drift Turmiso
AddStaticVehicle(451,-2391.4617,-601.8436,132.3547,303.2639,36,36); // Cars Drift Turmiso
AddStaticVehicle(451,-2392.2429,-607.9014,132.3545,212.7252,36,36); // Cars Drift Turmiso
AddStaticVehicle(451,-2394.5376,-609.9025,132.3549,214.5427,36,36); // Cars Drift Turmiso
AddStaticVehicle(451,-2399.5781,-613.1229,132.3577,215.3579,36,36); // Cars Drift Turmiso
AddStaticVehicle(451,-2416.8135,-588.8311,132.3573,215.3587,36,36); // Cars Drift Turmiso
AddStaticVehicle(451,-2409.1899,-583.8365,132.3553,35.2171,36,36); // Cars Drift Turmiso
//main:
print("--- Add Main Car ---");
AddStaticVehicle(522,-2346.7271,536.5531,76.9873,342.7768,6,25); //Darkoff
AddStaticVehicle(565,1555.8459,2751.5300,10.4462,269.6317,62,62); //
AddStaticVehicle(545,1597.0334,2834.4602,10.6313,0.0475,40,96); //
AddStaticVehicle(411,2297.7175,2528.5786,10.5368,270.3729,22,22); //
AddStaticVehicle(522,1893.8524,2115.7625,10.4177,359.9979,75,1); //
AddStaticVehicle(545,1634.2186,2082.1187,10.9931,269.5952,53,53); //
AddStaticVehicle(560,1512.3464,2001.3075,10.6885,180.2998,97,96); //
AddStaticVehicle(541,1603.3695,1839.0663,10.5446,179.6657,2,78); //
AddStaticVehicle(429,1623.2260,1850.8583,10.4452,1.6924,2,0); //
AddStaticVehicle(402,1529.8992,1019.6284,10.5841,1.1433,97,1); //
AddStaticVehicle(422,1413.9534,714.5236,10.8120,89.4846,16,0); //
AddStaticVehicle(603,982.2697,1730.0231,8.3916,270.6754,51,1); //
AddStaticVehicle(463,1021.3074,2020.6182,10.6648,262.1683,36,36); //
AddStaticVehicle(461,1310.5831,2578.5259,10.4116,157.6011,36,1); //
AddStaticVehicle(461,1234.3383,2606.2632,10.4020,64.9231,79,1); //
AddStaticVehicle(411,1640.3064,2576.4785,10.5545,359.4968,106,1); //
AddStaticVehicle(461,1636.1115,2576.2866,10.4060,6.8278,61,1); //
AddStaticVehicle(603,2100.6445,1397.7743,10.6583,359.7213,45,45); //
AddStaticVehicle(451,2603.4785,2142.9934,10.5252,89.5199,126,0); //
AddStaticVehicle(541,2426.8665,2131.0986,10.3688,88.8057,58,8); //
AddStaticVehicle(479,2361.7429,648.4590,11.1009,0.2114,54,31); //
AddStaticVehicle(603,2114.4250,901.8270,10.6250,271.0256,37,0); //
AddStaticVehicle(429,2393.7859,987.6761,10.5000,91.1308,2,1); //
AddStaticVehicle(411,2492.3496,1232.0537,10.7027,92.0766,6,6); //
AddStaticVehicle(415,2461.6316,1345.9426,10.5989,178.7844,62,1); //
AddStaticVehicle(400,2441.6130,1351.7134,10.5474,89.8914,112,1); //
AddStaticVehicle(558,2525.6709,1456.8545,10.4731,358.5329,36,1); //
AddStaticVehicle(400,2470.4424,1428.6765,10.5533,177.9176,101,101); //
AddStaticVehicle(480,2372.7192,1648.5884,10.9127,0.0007,101,1); //
AddStaticVehicle(400,2565.8206,1671.4277,10.5468,87.5994,53,1); //
AddStaticVehicle(415,2186.9312,2000.2557,10.6915,269.8876,93,64); //
AddStaticVehicle(522,2142.0264,1408.3706,10.4099,194.4707,61,1); //
AddStaticVehicle(567,2075.4434,1005.0959,10.5453,0.6719,97,96); //
AddStaticVehicle(565,2182.4255,1286.8412,10.3682,0.6061,10,10); //
AddStaticVehicle(545,2619.3079,2099.2168,10.6276,359.8427,28,96); //
AddStaticVehicle(506,2119.2561,1924.6890,10.3762,179.9013,3,3); //
AddStaticVehicle(451,2507.0249,2131.2458,10.4495,90.6109,125,125); //
AddStaticVehicle(541,2029.5710,1912.6765,11.9289,0.8390,58,8); //
AddStaticVehicle(560,1661.8137,988.1861,10.5577,359.4649,12,1); //
AddStaticVehicle(451,2563.9819,2275.1680,10.5272,90.0273,36,36); //
AddStaticVehicle(422,1624.0474,687.7905,10.4453,268.0920,8,8); //
AddStaticVehicle(541,1399.5751,973.1689,10.4433,358.6299,58,8); //
AddStaticVehicle(415,1881.7091,957.6345,10.4454,90.5756,58,8); //
AddStaticVehicle(560,1881.5790,966.7969,10.4453,91.4834,7,7); //
AddStaticVehicle(451,2038.7554,928.7838,8.9050,180.4548,60,60); //
AddStaticVehicle(451,2217.1121,1838.6136,10.4453,178.6115,1,1); //
AddStaticVehicle(400,2169.0996,1787.4244,10.4451,178.6473,0,0); //
AddStaticVehicle(463,2588.6907,2071.0215,10.4378,269.7279,0,0); //
AddStaticVehicle(400,2821.8601,2161.4551,10.4452,267.4652,58,18); //
AddStaticVehicle(468,1876.2561,2674.1755,10.4693,91.1653,68,8); //
AddStaticVehicle(560,1358.0430,2644.5254,10.4452,176.5554,68,8); //
AddStaticVehicle(506,1963.8176,1098.2622,10.3688,88.4614,0,0); //
AddStaticVehicle(400,2504.1506,1400.6128,10.4452,268.0431,36,36); //
AddStaticVehicle(451,2476.1882,2496.6238,10.4453,0.7559,1,1); //
AddStaticVehicle(541,1976.4221,2049.4558,10.4451,92.4529,2,1); //
AddStaticVehicle(451,2072.3340,824.2792,6.6042,39.6250,65,65); // a new race
AddStaticVehicle(451,2068.1316,823.8341,6.6358,30.0972,44,44); // a new race
AddStaticVehicle(451,2063.9031,823.7260,6.6593,26.6140,100,100); // a new race
AddStaticVehicle(451,2060.0249,823.3692,6.6860,29.1756,101,101); // a new race
AddStaticVehicle(451,2056.3799,822.9109,6.7383,29.6953,42,43); // a new race
AddStaticVehicle(451,2077.9331,822.2661,6.8169,6.7957,42,43); // a new race
AddStaticVehicle(451,2051.0386,822.0812,6.8364,353.0449,65,65); // a new race
AddStaticVehicle(411,2029.3549,878.9312,6.9774,230.8634,100,100); // a new race
AddStaticVehicle(411,2029.4150,883.7412,7.1132,235.3018,101,101); // a new race
AddStaticVehicle(411,2029.6583,888.3423,7.2552,232.8748,42,43); // a new race
AddStaticVehicle(411,2029.8496,892.7136,7.4138,236.0790,120,120); // a new race
AddStaticVehicle(411,2029.5662,897.5767,7.6078,238.0455,86,86); // a new race
AddStaticVehicle(541,2084.6265,891.5067,7.2857,92.3002,83,1); // a new race
AddStaticVehicle(541,2084.6340,887.9623,7.1503,90.9877,65,19); // a new race
AddStaticVehicle(541,2084.7515,883.4325,6.9504,91.9084,48,47); // a new race
AddStaticVehicle(541,2084.4756,879.6880,6.8657,87.9914,43,57); // a new race
AddStaticVehicle(541,2084.6726,874.7379,6.7724,91.6708,2,7); // a new race
//ramp:
print("--- Add Zibori || RAMP ---");
AddStaticVehicle(522,1863.7234,-1394.6096,13.0498,268.9947,6,25); //
AddStaticVehicle(522,1863.8091,-1395.6031,13.0358,267.8712,7,79); //
AddStaticVehicle(522,1863.7592,-1396.6364,13.0446,267.8714,8,82); //
AddStaticVehicle(522,1863.7101,-1397.6697,13.0417,267.8644,36,105); //
AddStaticVehicle(522,1863.6615,-1398.7030,13.0409,267.8569,39,106); //
AddStaticVehicle(522,1863.6136,-1399.7357,13.0429,267.8431,51,118); //
AddStaticVehicle(522,1863.6149,-1400.7690,13.0617,267.6460,3,3); //
AddStaticVehicle(522,1863.7233,-1401.7936,13.0388,267.1754,6,25); //
AddStaticVehicle(522,1863.6193,-1368.1034,13.0692,269.7050,3,8); //
//sf:
print("--- SF ---");
AddStaticVehicle(522,-2127.3245,921.5478,79.4633,92.1626,6,25); // SF
AddStaticVehicle(522,-2127.3750,922.9311,79.4641,87.2319,3,8); // SF
AddStaticVehicle(411,-2132.0881,947.2928,79.7307,90.0918,112,1); // SF
AddStaticVehicle(415,-2157.3220,942.0902,79.7946,271.1154,40,1); // SF
AddStaticVehicle(567,-2157.1763,960.2584,79.8812,273.6577,93,64); // SF
AddStaticVehicle(429,-2157.5254,979.3373,79.6877,270.1491,121,1); // SF
AddStaticVehicle(567,-2129.5107,983.3160,79.8782,89.3217,97,96); // SF
AddStaticVehicle(541,-2128.5823,1000.5756,79.6587,89.7448,68,8); // SF
AddStaticVehicle(429,-2157.4067,1043.6145,79.6886,270.4753,0,1); // SF
AddStaticVehicle(506,-2128.7849,1074.2433,79.7140,89.8052,76,76); // SF
AddStaticVehicle(522,-2186.4243,1081.2009,79.5667,359.0865,92,101); // SF
AddStaticVehicle(411,-2184.3689,1166.0796,55.4306,359.1265,80,1); // SF
AddStaticVehicle(535,-2136.1917,1341.4630,6.9402,90.1785,66,1); // SF
AddStaticVehicle(522,-2070.7764,1435.4282,6.6785,129.3492,3,8); // SF
AddStaticVehicle(522,-2068.1008,1435.0133,6.6714,153.4597,3,3); // SF
AddStaticVehicle(522,-2065.8896,1434.9078,6.6669,147.6570,51,118); // SF
AddStaticVehicle(522,-2063.2158,1434.3868,6.6758,147.7305,39,106); // SF
AddStaticVehicle(434,-2079.6504,1431.7010,7.0726,179.3999,7,7); // SF
AddStaticVehicle(522,-2094.5068,1435.2961,6.6512,220.0089,6,25); // SF
AddStaticVehicle(522,-2092.0010,1435.1561,6.6419,225.3108,7,79); // SF
AddStaticVehicle(522,-2089.6650,1435.2745,6.6569,227.3090,8,82); // SF
AddStaticVehicle(522,-2087.6350,1435.6858,6.6765,232.0600,36,105); // SF
AddStaticVehicle(522,-2008.2341,1348.2291,6.7513,184.8199,61,0); // SF
AddStaticVehicle(522,-1741.9467,1427.6521,6.7335,163.8017,3,8); // SF
AddStaticVehicle(535,-1617.9445,1243.2333,6.9307,45.4288,31,1); // SF
AddStaticVehicle(451,-1653.0925,1196.0984,9.1730,87.6615,61,61); // SF
AddStaticVehicle(506,-1767.9700,1113.1716,45.1247,180.4016,7,7); // SF
AddStaticVehicle(451,-1740.5314,1113.0093,45.1373,178.8847,125,125); // SF
AddStaticVehicle(411,-1706.2128,1059.3447,44.8467,359.7051,68,8); // SF
AddStaticVehicle(429,-1759.1108,1196.1940,24.7267,95.7258,75,1); // SF
AddStaticVehicle(541,-1522.3036,881.8875,6.8368,353.8466,51,1); // SF
AddStaticVehicle(560,-1593.6697,860.7028,7.3635,89.5086,33,0); // SF
AddStaticVehicle(599,-1593.7565,652.8143,7.3341,3.0065,0,1); // SF
AddStaticVehicle(599,-1616.5988,652.6476,7.3808,359.0590,0,1); // SF
AddStaticVehicle(490,-1611.7207,672.9122,7.3373,180.0442,0,0); // SF
AddStaticVehicle(599,-1594.2222,672.8608,7.3320,178.7705,0,1); // SF
AddStaticVehicle(490,-1572.6843,718.3537,-5.1018,90.0474,0,0); // SF
AddStaticVehicle(523,-1608.2788,675.0848,-5.6590,218.2191,0,0); // SF
AddStaticVehicle(490,-1608.3636,692.7838,-5.0923,179.6678,0,0); // SF
AddStaticVehicle(427,-1628.6597,692.4866,-5.1109,179.8135,0,1); // SF
AddStaticVehicle(523,-1620.6101,663.4132,-5.6567,293.3784,0,0); // SF
AddStaticVehicle(427,-1638.8004,653.7402,-5.1254,271.4348,0,1); // SF
AddStaticVehicle(560,-1721.2943,605.7745,24.6172,299.5081,17,1); // SF
AddStaticVehicle(541,-1846.8638,614.7121,34.8193,89.8988,36,8); // SF
AddStaticVehicle(506,-1967.1625,723.3738,45.0988,269.2613,76,76); // SF
AddStaticVehicle(411,-2082.8857,638.6713,52.0037,359.9059,75,1); // sf
AddStaticVehicle(567,-2154.0996,644.2964,52.2394,185.8799,97,96); // sf
AddStaticVehicle(541,-2248.1504,688.1547,49.0010,180.5029,36,8); // sf
AddStaticVehicle(429,-2236.6213,893.3839,66.3361,88.8556,94,1); // sf
AddStaticVehicle(451,-2239.5054,874.9416,66.3562,90.6048,61,61); // sf
AddStaticVehicle(541,-2274.5627,868.8260,66.2054,177.4273,60,1); // sf
AddStaticVehicle(451,-2276.4092,891.7832,66.3425,270.6223,46,46); // sf
AddStaticVehicle(415,-2129.5872,846.2244,69.3598,89.6868,25,1); // sf
AddStaticVehicle(411,-2156.3931,835.5349,69.2964,271.6563,64,1); // sf
AddStaticVehicle(567,-2154.0681,644.2761,52.2431,182.0241,97,96); // sf
AddStaticVehicle(541,-2138.1196,432.3843,34.8259,354.3478,68,8); // sf
AddStaticVehicle(506,-2140.4272,342.5319,35.0387,0.6638,7,7); // sf
AddStaticVehicle(471,-2071.7800,307.0129,34.9966,176.3510,120,117); // sf
AddStaticVehicle(411,-2171.4609,293.8124,34.8319,180.0495,64,1); // sf
AddStaticVehicle(541,-2192.9202,293.7799,34.7640,179.8022,13,8); // sf
AddStaticVehicle(560,-2209.9292,293.7355,34.8378,180.0905,56,29); // sf
AddStaticVehicle(560,-2265.9585,204.6593,34.8640,270.0901,9,39); // sf
AddStaticVehicle(535,-2265.6016,192.2922,34.9276,270.0871,55,1); // sf
AddStaticVehicle(535,-2265.4448,137.2522,34.9245,269.3352,66,1); // sf
AddStaticVehicle(506,-2265.7227,148.9746,34.8822,269.6447,6,6); // sf
AddStaticVehicle(429,-2265.7319,121.2508,34.8567,268.8058,75,1); // sf
AddStaticVehicle(451,-2266.1921,101.5940,34.8733,269.9750,18,18); // sf
AddStaticVehicle(411,-2427.4817,60.2264,34.9034,180.3590,123,1); // sf
AddStaticVehicle(415,-2505.1504,45.8781,25.4219,90.0295,75,1); // sf
AddStaticVehicle(451,-2712.0183,-103.3250,4.0350,179.9925,61,61); // sf
AddStaticVehicle(560,-2712.0742,-187.7154,4.0489,179.7411,33,0); // sf
AddStaticVehicle(541,-2682.2312,-216.5170,3.9490,270.3972,13,8); // sf
AddStaticVehicle(429,-2652.4695,-289.4881,7.2283,225.6888,92,1); // sf
AddStaticVehicle(429,-2803.5112,-105.5297,6.7912,359.2558,36,1); // sf
AddStaticVehicle(451,-2803.4951,24.9438,6.8055,359.6518,18,18); // sf
AddStaticVehicle(560,-2803.4478,123.3425,6.7672,1.0672,33,0); // sf
AddStaticVehicle(541,-2762.9426,293.9207,5.5054,90.4614,60,1); // sf
AddStaticVehicle(535,-2664.9907,268.4588,4.0774,179.5289,55,1); // sf
AddStaticVehicle(429,-2684.8518,268.1156,4.0179,180.4422,92,1); // sf
AddStaticVehicle(560,-2602.3862,312.1628,3.9620,349.1584,37,0); // sf
AddStaticVehicle(522,-2654.0759,205.6171,3.9067,0.5780,14,3); // sf
AddStaticVehicle(429,-2663.2090,212.1277,3.9298,269.4482,75,1); // sf
AddStaticVehicle(468,-1820.5591,-1604.9004,22.6710,175.7533,0,0); // sf
AddPlayerClass(0,-2416.3994,529.9916,30.4721,237.3721,0,0,0,0,0,0); // sf
AddStaticVehicle(599,-2426.1223,518.3076,30.1499,220.4327,0,1); // sf
AddStaticVehicle(415,-2328.5879,557.9054,29.3995,268.9333,36,1); // sf
AddStaticVehicle(560,-2357.9407,465.6689,30.8129,216.7635,52,39); // sf
AddStaticVehicle(541,-2463.5122,164.9308,34.7626,179.0016,2,1); // sf
//AirPort:
print("--- AIRPORT ---");
AddStaticVehicle(548,-1259.7415,-57.9322,15.8302,46.6097,1,1); //
AddStaticVehicle(548,-1251.3929,-49.0816,15.8230,44.4251,1,1); //
AddStaticVehicle(563,-1241.8896,-40.8119,14.8631,45.2537,1,6); //
AddStaticVehicle(563,-1233.3361,-32.7670,14.8391,44.2872,1,1); //
AddStaticVehicle(417,-1263.6996,7.4491,14.2692,134.4979,1,1); //
AddStaticVehicle(417,-1282.9351,26.5926,14.2695,136.2418,1,1); //
AddStaticVehicle(519,-1375.6418,-172.0864,15.0674,273.6486,1,1); //
AddStaticVehicle(519,-1376.1324,-191.9553,15.0720,272.6317,1,1); //
AddStaticVehicle(519,-1386.3698,-216.1764,15.0735,279.9938,1,1); //
AddPlayerClass(1,-1494.6637,-249.2101,14.1484,2.4414,0,0,0,0,0,0); //
AddStaticVehicle(578,-1492.3459,-252.7125,14.7959,2.4415,1,1); //
AddStaticVehicle(578,-1506.7490,-252.8263,14.7960,4.4244,1,1); //
AddStaticVehicle(513,-1569.8204,-275.6017,14.6690,41.9383,1,0); //
AddStaticVehicle(512,-1581.9386,-287.8921,14.4226,48.9378,1,0); //
AddStaticVehicle(513,-1594.7937,-300.2328,14.7129,46.5799,0,1); //
AddStaticVehicle(469,-1612.7439,-323.4285,14.1406,49.0700,88,8); //
AddStaticVehicle(469,-1621.8625,-333.0560,14.1482,50.4738,88,8); //
AddStaticVehicle(469,-1630.4789,-341.6889,14.1656,44.4179,88,8); //
AddStaticVehicle(593,-1249.2153,-80.3928,14.6389,133.8089,1,1); //
AddStaticVehicle(593,-1238.8232,-90.3962,14.6184,135.7558,1,1); // DODO
AddStaticVehicle(593,-1228.9781,-100.1826,14.6179,135.5890,1,1); // DODO
AddStaticVehicle(487,-1214.7501,-127.8887,14.2964,134.5894,0,0); // DODO
AddStaticVehicle(487,-1207.1667,-135.4339,14.2830,136.6128,0,0); // DODO
AddStaticVehicle(487,-1199.2516,-143.0384,14.2841,135.6160,0,0); // DODO
AddStaticVehicle(487,-1190.7439,-151.4983,14.2850,135.3258,0,0); // DODO
AddStaticVehicle(443,-1326.5959,-362.4462,14.8082,187.5062,0,0); // DODO
AddStaticVehicle(485,-1445.8224,-202.7077,13.8196,72.1654,0,0); //
AddStaticVehicle(485,-1442.9149,-195.1141,13.8078,62.5425,0,0); //
AddStaticVehicle(485,-1440.4270,-187.8989,13.7961,74.4890,0,0); //
AddStaticVehicle(485,-1438.0161,-181.0486,13.8187,66.9574,0,0); //
AddStaticVehicle(476,-1466.6299,-522.3833,14.8650,234.1439,0,1); //
AddStaticVehicle(593,-1447.7992,-512.4380,14.6481,204.2692,0,0); //
AddStaticVehicle(476,-1430.3558,-504.1905,14.8637,177.4718,1,0); //
//CarPark:
print("--- CarParking ---");
AddStaticVehicle(451,-1872.1511,-874.4136,31.7304,269.7858,42,43); // CarPark
AddStaticVehicle(451,-1871.8708,-890.3043,31.7303,269.7699,42,43); // CarPark
AddStaticVehicle(451,-1871.8640,-900.0626,31.7303,267.4573,42,43); // CarPark
AddStaticVehicle(522,-1888.4930,-883.8093,31.5887,88.9210,6,25); // Nrg 500 carpark
AddStaticVehicle(522,-1885.7936,-918.4160,31.5835,90.9992,6,25); // Nrg 500 carpark
AddStaticVehicle(560,-1872.0295,-893.6117,31.7441,270.1748,37,0); // /carparkcar
AddStaticVehicle(560,-1871.9204,-897.0663,31.7441,270.0742,33,0); // /carparkcar
AddStaticVehicle(541,-1871.6267,-903.6390,31.6475,270.5792,60,1); // /carparkcar
AddStaticVehicle(541,-1871.6360,-906.3990,31.6702,267.7623,68,8); // /carparkcar
AddStaticVehicle(541,-1871.7286,-909.4115,31.6491,267.0488,2,1); // /carparkcar
AddStaticVehicle(402,-1871.7810,-915.7357,31.8638,269.2672,75,1); // /carparkcar
AddStaticVehicle(402,-1872.0200,-921.7950,31.8648,262.0683,0,1); // /carparkcar
//BusTrip || Ship Strip:
print("--- BUSTRIP && SHIPTRIP ---");
AddStaticVehicle(452,-2312.3179,2313.6309,-0.5744,180.0348,1,3); // shiptripcar
AddStaticVehicle(452,-2312.9731,2296.2407,-0.4951,174.5892,1,3); // shiptripcar
AddStaticVehicle(452,-2309.2078,2284.2944,-0.4638,211.1719,1,3); // shiptripcar
AddStaticVehicle(452,-2302.3416,2264.3130,-0.6332,177.7998,1,3); // shiptripcar
AddStaticVehicle(452,-2300.4570,2232.7966,-0.4514,179.6083,1,3); // shiptripcar
AddStaticVehicle(437,-2446.9626,2240.6790,4.9573,0.8033,105,80); // /bustrip
AddStaticVehicle(437,-2440.9917,2240.7529,4.9324,0.1807,98,80); // /bustripcar
AddStaticVehicle(437,-2458.7395,2226.5779,4.9937,180.6802,95,16); // /bustripcar
AddStaticVehicle(437,-2464.6602,2226.4697,4.9936,180.5578,87,7); // /bustripcar
AddStaticVehicle(437,-2470.7017,2226.5051,4.9432,180.2185,79,7); // /bustripcar
AddStaticVehicle(431,-2482.5310,2226.5181,4.9540,180.0431,75,59); // /bustripcar
AddStaticVehicle(538,2864.7500,1285.0447,11.2473,0.0000,1,71);
//ship(`goat`):
//=[OtherCar`s]========================================================================
print("--- Other CAR ---");
AddStaticVehicle(448,2103.2952,943.2202,10.4132,93.8372,3,6); // PizzaBoy Near RACE
AddStaticVehicle(448,2134.1360,881.7591,10.1374,87.8575,3,6); // PizzaBoy Near RACE
AddStaticVehicle(522,2623.8169,1139.7377,10.3963,271.0921,51,118); // NRG-500
AddStaticVehicle(522,-317.4746,1516.2584,74.9275,179.9636,51,118); // NRG-500 "/Dj"
AddStaticVehicle(531,-1199.3906,1818.3378,41.6854,223.7911,36,2); // Tracktor
AddStaticVehicle(571,-1564.7216,1044.2661,6.4714,359.9944,40,35); // KART SF
AddStaticVehicle(448,-1805.5404,942.7126,24.4869,126.4897,3,6); // PIZZA BOY
print("--- END ADD CAR! ---");

//JUMP
AddStaticVehicle(468,-672.1821,2304.1675,134.5549,74.2891,93,93); // Jump Sanzhez
AddStaticVehicle(468,-672.1043,2301.3303,134.5724,88.4373,86,86); // Jump Sanzhez 2
AddStaticVehicle(568,-679.0502,2329.2925,133.4336,72.1006,1,1); // Jump Bandito
AddStaticVehicle(568,-677.8904,2332.1118,133.6581,74.1763,1,1); // Jump Bandito 2
AddStaticVehicle(539,-689.9789,2364.3193,128.0947,79.9547,6,6); // Vortex

// By Bar
AddStaticVehicle(495,-839.3690,-1909.0564,13.6588,221.2796,114,108); //
AddStaticVehicle(495,-834.7319,-1904.9429,13.0978,221.2288,1,5); //
AddStaticVehicle(495,-831.4208,-1902.0347,12.7895,221.1654,1,7); //
AddStaticVehicle(495,-828.4319,-1899.3556,12.4419,221.1667,1,9); //
AddStaticVehicle(444,-2336.9248,-1581.6919,483.9352,249.6607,32,42); // ?????? ????
AddStaticVehicle(444,-2340.7244,-1587.6190,483.9485,245.8290,32,53); // ?????? ????
AddStaticVehicle(444,-2344.7048,-1593.4673,483.9607,246.1044,32,66); // ?????? ????
AddStaticVehicle(444,-2347.6533,-1599.6826,483.9830,245.3492,32,14); // ?????? ????
AddStaticVehicle(510,-2349.5071,-1606.8542,483.2336,262.2872,46,46); //
AddStaticVehicle(510,-2349.6675,-1608.0394,483.2336,262.2872,1,1); //
AddStaticVehicle(510,-2349.9727,-1610.2904,483.2357,262.2869,2,2); //
AddStaticVehicle(510,-2350.9473,-1611.6609,483.2473,262.2867,3,3); //
AddStaticVehicle(510,-2351.3274,-1613.9246,483.2547,262.2865,4,4); //
AddStaticVehicle(495,-2321.1133,-1591.6382,484.1340,139.0861,119,122); //
AddStaticVehicle(495,-2318.3269,-1594.0519,484.1830,139.0855,2,6); //
AddStaticVehicle(495,-2316.7227,-1595.4421,484.2112,139.0854,1,6); //
AddStaticVehicle(522,-2239.7188,-1748.0284,480.4421,332.2571,8,82); // ?????? ????
AddStaticVehicle(522,-2241.4563,-1747.0323,480.4248,332.2534,1,6); // ?????? ????
AddStaticVehicle(495,817.3589,831.2336,10.8769,22.3956,118,117); // ???? ?????
AddStaticVehicle(495,822.0384,833.2783,11.3128,22.4119,2,0); //
AddStaticVehicle(495,827.0639,835.4076,11.8043,22.5383,1,5); //
AddStaticVehicle(495,831.1525,837.0991,12.0169,22.5948,1,3); //
AddStaticVehicle(495,835.7676,839.0297,12.3403,22.5428,1,2); //
AddStaticVehicle(495,808.2421,856.1618,11.3095,206.0023,0,1); //
AddStaticVehicle(510,829.9390,860.6064,12.1015,205.3363,39,39); //
AddStaticVehicle(510,828.9867,860.4527,12.0459,205.3351,0,0); //
AddStaticVehicle(510,827.5927,859.9815,11.9587,205.3323,2,2); //
AddStaticVehicle(510,826.4473,859.8972,11.8918,205.3274,3,3); //
AddStaticVehicle(510,825.1476,859.2805,11.8071,205.3219,4,4); //
AddStaticVehicle(510,823.7946,858.7195,11.7199,205.3161,5,5); //
AddStaticVehicle(510,822.2742,858.1156,11.6269,205.2844,6,6); //
AddStaticVehicle(510,820.7573,857.8923,11.5801,205.1240,7,7); //
AddStaticVehicle(406,689.6381,869.1974,-39.7271,87.7338,1,1); // ?????
AddStaticVehicle(406,472.3521,878.3604,-27.9521,279.3741,1,1); // ?????
AddStaticVehicle(406,520.2015,783.6959,-19.9782,246.3244,1,1); // ?????
AddStaticVehicle(405,2499.7668,-1655.0507,13.3000,69.9649,24,1); // LS
AddStaticVehicle(466,2509.9697,-1666.4144,13.2250,15.8096,68,76); // LS
AddStaticVehicle(439,2473.7957,-1701.0646,13.4180,359.2803,8,17); // LS
AddStaticVehicle(440,2425.6753,-1642.9991,14.0250,180.6462,32,32); // LS
AddStaticVehicle(434,2427.8152,-1674.7449,13.6294,358.4727,2,2); // LS
AddStaticVehicle(461,2466.4331,-1681.9435,13.1063,301.1878,37,1); // LS
AddStaticVehicle(461,2465.2195,-1679.9384,13.1065,301.1877,12,12); //

//================[Army And more]==============================================
AddStaticVehicle(469,204.2755,1950.7498,17.6355,274.1244,1,3); // ARMY
AddStaticVehicle(469,203.5201,1961.2200,17.6636,274.1240,1,3); // ARMY
AddStaticVehicle(520,203.9653,1991.0509,18.4492,261.9112,0,0); // ARMY
AddStaticVehicle(520,205.3609,2001.2858,18.3716,261.9112,0,0); // ARMY
AddStaticVehicle(425,246.8237,2068.7341,18.2177,181.5086,43,0); // ARMY
AddStaticVehicle(425,261.4698,2069.1196,18.2177,181.5086,43,0); // ARMY
AddStaticVehicle(487,302.5630,2071.3752,17.8145,177.9595,0,1); // ARMY
AddStaticVehicle(487,314.2283,2070.9595,17.7653,177.9599,1,0); //
AddStaticVehicle(601,274.1151,1956.3156,17.3985,270.8426,1,1); // ARMY
AddStaticVehicle(601,273.6168,1990.1934,17.3986,270.8426,1,1); // ARMY
AddStaticVehicle(487,-1323.9153,-273.5178,14.2854,0.9052,0,6); //
AddStaticVehicle(487,-1309.4554,-261.2142,14.3246,1.0390,0,7); //
//==============================================================================

//=ParkPet
//
//CreateDynamicObject(1634,1563.422729 -2473.558594 13.852005,0,0,0);
print("--- Add Objective ---");
//=[ObjectStreamers]====================================================================
//Other:
//Gre==========
CreateDynamicObject(8355, 1300.0819, 2159.8288, 10.0253, 0.0, 270.6185, 0.0);
CreateDynamicObject(8355, 1359.2493, 2103.2255, 10.0193, 0.0, 268.0403, 90.0);
CreateDynamicObject(8355, 1397.517, 2131.4462, 10.0175, 0.0, 270.6185, 0.0);
CreateDynamicObject(8355, 1330.1335, 2199.0385, 10.0253, 0.0, 269.759, 90.0);
CreateDynamicObject(7416, 1349.4133, 2150.35, 27.6626, 0.0, 0.0, 0.0);
CreateDynamicObject(3819, 1306.2847, 2190.8112, 11.0211, 0.0, 0.0, 146.25);
CreateDynamicObject(972, 1398.4399, 2167.4882, 24.3673, 0.0, 269.759, 0.0);
CreateDynamicObject(972, 1372.2092, 2199.3403, 24.3923, 0.0, 268.8996, 90.0);
CreateDynamicObject(3359, 1385.0584, 2106.1877, 10.0171, 0.0, 0.0, 0.0);
CreateDynamicObject(11442, 1311.9328, 2112.3366, 10.1893, 0.0, 0.0, 90.0);
CreateDynamicObject(11443, 1338.3316, 2190.4331, 10.1951, 0.0, 0.0, 326.25);
CreateDynamicObject(11446, 1391.2978, 2152.9643, 10.1983, 0.0, 0.0, 0.0);
CreateDynamicObject(11445, 1349.0135, 2144.1896, 10.1873, 0.0, 0.0, 0.0);
CreateDynamicObject(11458, 1306.6287, 2154.4833, 10.1953, 0.0, 0.0, 56.25);
CreateDynamicObject(11457, 1381.4346, 2186.9213, 9.6246, 0.0, 0.0, 90.0);

//=[Gatebank]=============================================================
gateb = CreateObject(2634,2144.19,1627.1,994.257,0,0,180);
//=[NM]===================================================================
CreateDynamicObject(3475, 1210.949219, -2068.997314, 70.383987, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(3475, 1211.114746, -2063.203857, 70.383987, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(3475, 1211.113892, -2057.442871, 70.383987, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(3475, 1211.089600, -2051.669922, 70.376785, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(3475, 1211.080566, -2020.649536, 70.376785, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(3475, 1211.108643, -2026.518311, 70.383987, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(3749, 1211.071533, -2039.218872, 73.866226, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(3475, 1211.024902, -2014.849731, 70.383987, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(3475, 1211.004517, -2009.111694, 70.376785, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(3475, 1210.994141, -2003.416504, 70.345108, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(7371, 1100.443970, -1994.775269, 68.007637, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(3475, 1211.048950, -1997.756592, 70.383987, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(7371, 1103.563843, -2084.433105, 68.007637, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(7371, 1090.585815, -2077.209473, 68.007637, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(3475, 1210.683105, -2074.579834, 70.383987, 0.0000, 0.0000, 180.0000);
NM1=CreateObject(980, 1211.504272, -2039.203613, 70.732048, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(3528, 1123.856323, -2037.093750, 76.761993, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(7388, 1175.384033, -2037.043457, 75.823723, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(16776, 1193.464966, -2024.164063, 69.758652, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(16776, 1193.898193, -2050.831543, 69.758652, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(3268, 1151.475830, -2050.470703, 68.000610, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(6865, 1214.172241, -2038.626221, 76.516159, 0.0000, 0.0000, 135.0000);
NM2=CreateObject(972, 1153.494507, -2044.161255, 67.997490, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(14791, 1162.965332, -2056.957031, 70.052872, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(16644, 1138.704224, -2060.486572, 62.952339, 0.0000, 89.3814, 270.0000);
CreateDynamicObject(16644, 1136.560791, -2044.012573, 63.009621, 0.0000, 89.3814, 191.2500);
CreateDynamicObject(13592, 1164.596680, -2010.810669, 78.603363, 0.0000, 5.1566, 6.0161);
CreateDynamicObject(1634, 1154.022461, -2013.148560, 70.780190, 9.4538, 0.8594, 89.1405);
CreateDynamicObject(1634, 1154.023926, -2017.000854, 70.805099, 9.4538, 0.8594, 89.1405);
CreateDynamicObject(7392, 1093.503662, -2037.950317, 89.164345, 0.0000, 0.0000, 168.7500);
CreateDynamicObject(7916, 1132.864258, -2043.023804, 68.560570, 0.0000, 0.0000, 89.0632);
CreateDynamicObject(8492, 1151.632202, -2041.121338, 78.934090, 0.0000, 0.0000, 146.2500);
CreateDynamicObject(14666, 1152.647217, -2060.376709, 71.319122, 0.0000, 1.7189, 88.2038);
CreateDynamicObject(2628, 1157.482422, -2059.700684, 68.001854, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(2630, 1154.540649, -2059.574951, 68.002487, 0.0000, 0.0000, 180.0000);
NM3=CreateObject(2714, 1150.846802, -2040.520508, 74.581955, 0.0000, 0.0000, 180.0000);

AddStaticVehicle(520,1118.1322,-2017.9768,75.4202,355.5695,0,0); //
AddStaticVehicle(487,1116.5709,-2054.8691,74.6064,357.6069,8,0); //
AddStaticVehicle(411,1142.6869,-2057.7056,68.7277,0.9551,0,0); //
AddStaticVehicle(451,1146.3794,-2057.5659,68.7064,0.7998,1,1); //
AddStaticVehicle(541,1150.8391,-2057.4458,68.6291,0.1536,8,3); //
AddStaticVehicle(522,1164.8939,-2045.0336,68.5785,89.9877,51,118); //
AddStaticVehicle(522,1164.8314,-2047.5616,68.5767,92.0948,7,79); //
AddStaticVehicle(522,1164.8862,-2050.3418,68.5818,93.0788,6,25); //

AddStaticPickup(1240,2, 1137.3998,-2057.3247,69.0006);
AddStaticPickup(1242,2, 1137.3998,-2056.3247,69.0006);
AddStaticPickup(325,2, 1137.3998,-2055.3247,69.0006);
AddStaticPickup(371,2, 1137.3998,-2054.3247,69.0006);
//=[RoX]=======================================================
RoX1=CreateObject(980, -2127.299805, -80.334839, 37.043701, 0.0000, 0.0000, 0.0000);
RoX2=CreateObject(980, -2180.527344, -212.667587, 38.292458, 0.0000, 0.0000, 270.0000);
RoX3=CreateObject(980, -2180.498779, -217.493393, 38.292458, 0.0000, 0.0000, 270.0000);
RoX5=CreateObject(1497, -2163.575439, -225.588898, 35.503658, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(2627, -2139.974121, -241.734116, 35.516441, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(2627, -2139.871582, -244.835159, 35.516441, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(3279, -2100.381348, -86.335556, 34.402962, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(3279, -2151.394531, -102.089035, 34.395927, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3279, -2198.140869, -275.776093, 34.395927, 0.0000, 0.0000, 90.0002);
CreateDynamicObject(3279, -2101.761230, -276.072235, 34.395927, 0.0000, 0.0000, 90.0002);
CreateDynamicObject(1217, -2100.747070, -273.095093, 34.691689, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1217, -2102.641846, -273.170135, 34.741692, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1217, -2196.500000, -272.844910, 34.741692, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1217, -2199.510742, -272.707031, 34.741692, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1218, -2148.436768, -100.155312, 34.812004, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1218, -2148.430664, -103.155045, 34.812004, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1218, -2098.990479, -89.344337, 34.819035, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1218, -2101.651611, -89.720665, 34.819035, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3524, -2132.599121, -79.909782, 37.005642, 0.0000, 0.0000, 191.2500);
CreateDynamicObject(3524, -2121.321045, -80.155945, 36.880634, 0.0000, 0.0000, 191.2500);
CreateDynamicObject(3528, -2162.328613, -224.747620, 42.169136, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(1226, -2122.999512, -82.054382, 38.194733, 0.0000, 0.0000, 11.2500);
CreateDynamicObject(1226, -2131.205322, -82.024986, 38.194733, 0.0000, 0.0000, 157.5000);
CreateDynamicObject(17000, -2117.054688, -116.241432, 34.314590, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1634, -2106.631348, -210.231796, 35.617630, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(1634, -2193.128662, -202.544113, 35.617630, 0.0000, 0.0000, 90.0000);
RoX4=CreateDynamicObject(971, -2124.288818, -176.404907, 34.340195, 269.7591, 357.4217, 357.4217);

//===========[SF Object's]======================================================
CreateDynamicObject(1280, -2126.729980, 922.813599, 79.317139, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(1280, -2127.519531, 913.672302, 79.317001, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(1368, -2123.062988, 922.114258, 79.687035, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(1368, -2123.839355, 913.531921, 79.741737, 0.0000, 0.0000, 168.7499);
CreateDynamicObject(1485, -2128.520752, 913.425964, 79.698715, 0.0000, 0.0000, 123.7499);
CreateDynamicObject(1950, -2128.786865, 914.302490, 79.058235, 0.0000, 0.0000, 67.5000);
CreateDynamicObject(1669, -2128.636963, 914.325928, 79.040100, 0.0000, 0.0000, 22.5000);
CreateDynamicObject(1951, -2128.899170, 914.535400, 78.908501, 92.8192, 0.0000, 59.3012);
CreateDynamicObject(2683, -2128.574463, 914.549255, 79.000900, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(2837, -2128.548340, 914.915588, 78.880821, 0.0000, 0.0000, 202.5000);
CreateDynamicObject(2839, -2126.096680, 914.343079, 78.965103, 0.0000, 0.0000, 191.2501);
CreateDynamicObject(2840, -2125.167480, 914.146851, 78.998199, 0.0000, 0.0000, 337.5000);
CreateDynamicObject(2857, -2121.965332, 913.692932, 78.781761, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(2858, -2120.980957, 913.712463, 78.622368, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(2866, -2125.665039, 913.702087, 78.984474, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3855, -2134.591553, 902.522034, 78.923477, 0.0000, 0.0000, 5.1566);
CreateDynamicObject(3855, -2158.107422, 913.206177, 79.079727, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(3855, -2151.520996, 932.818665, 78.916916, 0.0000, 0.0000, 168.7500);
CreateDynamicObject(3863, -2158.019043, 929.974426, 80.172333, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(11435, -2151.983643, 908.155762, 83.654724, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(3511, -2110.927246, 921.646851, 76.587067, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3511, -2161.437012, 929.275085, 78.993774, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3511, -2166.830811, 907.327148, 79.008911, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(648, -2157.961182, 955.318237, 79.027870, 0.0000, 0.0000, 168.7499);
CreateDynamicObject(648, -2158.040039, 974.561035, 79.027870, 0.0000, 0.0000, 168.7499);
CreateDynamicObject(648, -2157.857910, 992.397949, 79.027870, 0.0000, 0.0000, 168.7499);
CreateDynamicObject(648, -2158.827881, 1010.243469, 79.027870, 0.0000, 0.0000, 168.7499);
CreateDynamicObject(648, -2128.500732, 953.116516, 78.775642, 0.0000, 0.0000, 337.5000);
CreateDynamicObject(648, -2127.433350, 970.682861, 79.032173, 0.0000, 0.0000, 337.5000);
CreateDynamicObject(648, -2127.644043, 987.225891, 79.035683, 0.0000, 0.0000, 337.5000);
CreateDynamicObject(648, -2128.015381, 1003.867004, 79.035683, 0.0000, 0.0000, 337.5000);
CreateDynamicObject(648, -2127.637451, 841.602844, 68.590370, 0.0000, 0.0000, 337.5000);
CreateDynamicObject(648, -2157.662354, 839.539978, 68.576027, 0.0000, 0.0000, 146.2500);
CreateDynamicObject(648, -2158.225830, 829.263977, 68.582603, 0.0000, 0.0000, 156.5633);
CreateDynamicObject(648, -2127.883057, 829.871277, 68.590370, 0.0000, 0.0000, 302.8133);
CreateDynamicObject(648, -2166.962891, 929.659363, 79.027870, 0.0000, 0.0000, 44.0634);
CreateDynamicObject(648, -2170.676270, 907.048584, 79.043007, 0.0000, 0.0000, 257.8134);
CreateDynamicObject(3524, -2128.947998, 923.066467, 81.751831, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(3524, -2128.990723, 913.650879, 81.747299, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(7388, -2159.464844, 902.036560, 95.908554, 0.0000, 0.0000, 348.7500);
CreateDynamicObject(3361, -2100.584717, 926.077820, 76.235329, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(3361, -2100.612793, 932.030640, 80.285324, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(3361, -2100.637695, 938.065063, 84.377014, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(3361, -2100.677490, 944.116699, 88.438972, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(10009, -2097.455078, 945.858704, 93.744102, 0.0000, 0.0000, 220.8573);
CreateDynamicObject(2633, -2102.933105, 942.088745, 95.205345, 0.0000, 6.0161, 202.5000);
CreateDynamicObject(2633, -2105.101074, 941.213074, 94.927757, 0.0000, 359.1406, 196.4839);
CreateDynamicObject(14409, -2121.709229, 919.589966, 95.347710, 30.9397, 0.0000, 0.0000);
CreateDynamicObject(14409, -2121.996582, 908.780090, 95.478043, 34.3775, 359.1406, 0.0000);
CreateDynamicObject(18367, -2120.068848, 969.944458, 95.927475, 7.7349, 0.0000, 0.0000);
//================[Ap Object's]=================================================
CreateDynamicObject(3515, -1361.899902, -251.402939, 12.464187, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3515, -1366.343018, -246.610947, 12.364170, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(9833, -1366.607300, -246.484528, 16.471107, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(9833, -1362.280762, -251.205505, 16.571123, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(13749, -1404.087158, -220.130692, 17.687132, 0.0000, 0.0000, 30.2349);
CreateDynamicObject(3525, -1406.442505, -228.246445, 15.785125, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3525, -1407.045898, -226.532272, 17.003374, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3525, -1407.154785, -224.181442, 18.264732, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3525, -1406.580200, -221.982727, 19.955431, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3525, -1405.990845, -219.960571, 20.801769, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3525, -1405.271973, -217.666916, 22.123650, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3525, -1404.396851, -215.190979, 23.208874, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3525, -1403.360107, -212.255829, 25.150280, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3525, -1402.251099, -209.335205, 26.269754, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3525, -1402.705933, -206.545532, 25.921715, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3525, -1408.619507, -230.139786, 15.288766, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3525, -1409.625488, -227.987900, 16.506441, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3525, -1409.830078, -224.892426, 18.052017, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3525, -1409.456299, -221.392136, 19.635324, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3525, -1409.073486, -219.169708, 20.603674, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3525, -1408.369751, -216.504791, 21.876194, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3525, -1407.488281, -213.918762, 23.246252, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3525, -1406.059814, -210.880280, 24.941729, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(8493, -1568.912964, -39.634521, 32.073147, 0.0000, 0.0000, 321.9529);
CreateDynamicObject(8171, -1329.230469, -213.885376, 13.150352, 0.0000, 0.0000, 315.0000);
CreateDynamicObject(10757, -1383.735718, -267.861816, 29.087931, 5.1566, 0.0000, 135.0000);
CreateDynamicObject(14553, -1270.698486, -292.376801, 30.629391, 5.1566, 0.8594, 157.5000);
CreateDynamicObject(8171, -1301.656128, -241.866043, 13.145881, 0.0000, 0.0000, 315.0000);
CreateDynamicObject(8171, -1357.292969, -186.009552, 13.150359, 0.0000, 0.0000, 315.0000);
CreateDynamicObject(16777, -1404.585815, -205.806503, 24.431614, 0.0000, 0.0000, 337.5000);
CreateDynamicObject(10009, -1291.821655, -317.133698, 28.873245, 0.0000, 0.0000, 338.2821);
CreateDynamicObject(3715, -1381.570801, -265.440216, 33.552677, 0.0000, 0.0000, 315.0000);
CreateDynamicObject(8357, -1028.396729, 464.195190, 30.685368, 10.3132, 0.0000, 315.0000);
//==============================================================================
AddStaticVehicle(560,-2108.7693,-195.5236,35.0249,89.9237,0,0); // 1
AddStaticVehicle(560,-2116.8730,-195.3468,35.0251,90.5507,9,9); // 2
AddStaticVehicle(560,-2124.7351,-195.5098,35.0256,90.3512,1,1); // 3
AddStaticVehicle(520,-2105.1672,-190.6097,47.0417,266.7440,0,0); // 4
AddStaticVehicle(487,-2124.1931,-191.0951,46.4579,268.4459,0,3); // 5
AddStaticVehicle(522,-2154.4165,-192.1300,34.8908,357.5688,3,0); // 6
AddStaticVehicle(541,-2192.1309,-209.6779,34.9453,0.4906,0,6); // 7
AddStaticVehicle(541,-2191.9219,-234.9050,34.9481,0.3834,3,1); // 8
//=

AddStaticPickup(1240,2, -2154.4492,-226.9697,36.5156);
AddStaticPickup(1242,2, -2152.4292,-227.0605,36.5156);
AddStaticPickup(350,2, -2149.4722,-226.9782,36.5156);
AddStaticPickup(358,2, -2148.1287,-226.9312,36.5156);

//=[IDFCLan]============================================================
/*
    CreateDynamicObject(8209, 2734.546631, -2564.147949, 15.734398, 0.0000, 0.0000, 0.0000,200);
	CreateDynamicObject(8209, 2810.045166, -2515.780518, 15.733839, 0.0000, 0.0000, 90.2409,200);
	CreateDynamicObject(8209, 2809.618408, -2416.260010, 15.729418, 0.0000, 0.0000, 90.2409,200);
	CreateDynamicObject(8209, 2761.081543, -2331.092285, 15.733839, 0.0000, 0.0000, 180.4818,200);
	CreateDynamicObject(8209, 2678.020264, -2463.606689, 15.751650, 0.0000, 0.0000, 90.2409,200);
	CreateDynamicObject(3749, 2679.617676, -2404.111572, 18.278217, 0.8594, 0.0000, 89.3814,200);
	CreateDynamicObject(3749, 2694.422852, -2332.358643, 18.491226, 0.8594, 0.0000, 0.0000,200);
	CreateDynamicObject(8210, 2809.780029, -2358.437012, 15.729321, 0.0000, 0.0000, 91.1003,200);
	CreateDynamicObject(8210, 2782.390869, -2564.769531, 15.728582, 0.0000, 0.0000, 0.8594,200);
	CreateDynamicObject(8210, 2686.226807, -2357.339355, 16.233839, 0.0000, 0.0000, 89.3814,200);
	CreateDynamicObject(987, 2702.877930, -2330.898926, 12.632813, 0.0000, 0.0000, 0.0000,200);
	CreateDynamicObject(987, 2685.492432, -2384.182861, 12.632813, 0.0000, 359.1406, 246.5544,200);
	CreateDynamicObject(987, 2687.227051, -2554.332275, 12.631658, 0.0000, 359.1406, 272.3375,200);
	CreateDynamicObject(987, 2687.001709, -2544.471436, 12.533394, 0.0000, 359.1406, 270.6186,200);
	CreateDynamicObject(987, 2678.530029, -2512.439941, 12.193305, 0.0000, 359.1406, 341.0924,200);
	CreateDynamicObject(1655, 2693.880371, -2503.753418, 14.439089, 11.1727, 0.0000, 87.6625,200);
	CreateDynamicObject(3279, 2803.499023, -2438.172852, 12.705442, 0.0000, 0.0000, 179.5182,200);
	CreateDynamicObject(18367, 2805.809814, -2439.299316, 28.490519, 27.5020, 0.0000, 79.9277,200);
	CreateDynamicObject(7388, 2786.092773, -2455.801025, 21.912775, 0.0000, 0.0000, 0.0000,200);
	CreateDynamicObject(7073, 2746.168213, -2530.460205, 45.995831, 0.0000, 0.0000, 278.3535,200);
	CreateDynamicObject(6865, 2676.854004, -2403.900635, 21.114496, 0.0000, 0.0000, 316.1687,200);
	CreateDynamicObject(7392, 2715.912354, -2451.167480, 37.813873, 0.0000, 0.0000, 0.0000,200);
	CreateDynamicObject(13562, 2746.312256, -2453.866455, 16.845486, 0.0000, 0.0000, 0.0000,200);
	CreateDynamicObject(13831, 2712.397461, -2379.780762, 31.334003, 0.0000, 0.0000, 0.0000,200);
	CreateDynamicObject(12911, 2804.375732, -2546.474854, 12.623470, 0.0000, 0.0000, 8.5944,200);
	CreateDynamicObject(14608, 2696.756836, -2346.253418, 14.903828, 0.0000, 0.0000, 313.5904,200);
	CreateDynamicObject(13667, 2789.358154, -2418.343262, 38.250622, 0.0000, 0.0000, 182.2006,200);
	CreateDynamicObject(9833, 2745.818359, -2466.572021, 15.850981, 0.0000, 0.0000, 0.0000,200);
	CreateDynamicObject(8492, 2775.086670, -2456.051758, 24.053158, 0.0000, 0.0000, 236.2410,200);
	CreateDynamicObject(8483, 2741.048340, -2518.985107, 18.043509, 0.0000, 0.0000, 88.5220,200);
	CreateDynamicObject(6965, 2790.035645, -2346.920410, 15.595274, 0.0000, 0.0000, 0.0000,200);
	CreateDynamicObject(3425, 2788.359863, -2336.894043, 24.075756, 0.0000, 0.0000, 0.0000,200);
	CreateDynamicObject(16340, 2764.622314, -2507.813232, 15.900993, 0.0000, 0.0000, 0.0000,200);
	CreateDynamicObject(14791, 2802.540039, -2474.191650, 14.677326, 0.0000, 0.0000, 0.0000,200);
	CreateDynamicObject(13666, 2685.284668, -2455.676514, 17.714756, 6.8755, 0.0000, 0.0000,200);
	CreateDynamicObject(902, 2694.434082, -2329.803467, 19.753378, 271.4780, 0.0000, 1.7189,200);

IDF4  =	AddStaticVehicle(522,2797.7002,-2417.9490,13.2021,88.0362,0,1); // Nrg
IDF5  =	AddStaticVehicle(522,2787.6577,-2409.8152,13.2031,178.0864,0,0); // Nrg
IDF6  =	AddStaticVehicle(522,2787.4207,-2425.0776,13.2107,359.9781,1,1); // Nrg
IDF7  =	AddStaticVehicle(411,2779.2788,-2449.1465,13.3619,180.3149,6,6); // InferNus
IDF8  =	AddStaticVehicle(480,2779.2095,-2463.2183,13.4083,358.9388,6,6); // comet
IDF9  =	AddStaticVehicle(541,2796.7209,-2456.6370,13.2567,90.4806,0,6); // bullet
IDF10 =	AddStaticVehicle(451,2787.6130,-2486.7625,13.3581,180.7961,6,6); //
IDF11 =	AddStaticVehicle(490,2795.3179,-2501.0647,13.7700,2.0808,0,0); //


 	AddStaticPickup( 1240, 2, 2742.4570,-2455.0754,13.8623 );
   	AddStaticPickup( 1242, 2, 2742.5752,-2452.3567,13.8623 );
   	AddStaticPickup( 358, 2, 2750.3303,-2455.1370,13.8623 );
 	AddStaticPickup( 356, 2, 2750.2395,-2452.6045,13.8623 );

	IDF1 = CreateDynamicObject(980, 2677.702637, -2404.156250, 15.258852, 0.0000, 0.0000, 88.5220,200);
	IDF2 = CreateDynamicObject(980, 2694.454102, -2330.874756, 15.406204, 0.0000, 0.0000, 181.3413,200);
	IDF3 = CreateDynamicObject(8493, 2703.111328, -2304.132080, 17.351837, 0.0000, 0.0000, 91.1003,200);

*/

//[AkaweNight]
/*
CreateDynamicObject(354,2129.2793,1683.7761,27.4865,0.0000, 0.0000, 0.0000);
CreateDynamicObject(354,2099.1665,1677.7268,18.7263,0.0000, 0.0000, 0.0000);
CreateDynamicObject(354,2099.4441,1686.4625,18.7263,0.0000, 0.0000, 0.0000);
CreateDynamicObject(354,2109.6616,1683.6853,18.7263,0.0000, 0.0000, 0.0000);
CreateDynamicObject(354,2097.7207,1682.5708,20.6284,0.0000, 0.0000, 0.0000);
CreateDynamicObject(354,2093.2234,1685.1309,20.8484,0.0000, 0.0000, 0.0000);
CreateDynamicObject(354,2096.5210,1672.7938,21.5326,0.0000, 0.0000, 0.0000);
CreateDynamicObject(354,2104.1108,1672.5490,21.5326,0.0000, 0.0000, 0.0000);
*/
/*
//=[ViP]================================================================
CreateDynamicObject(8172, -2.291197, 1573.730469, 25.235550, 0.0000, 268.8998, 90.0000);
CreateDynamicObject(8171, 64.815948, 1529.180908, 23.607761, 0.0000, 270.6186, 0.0000);
CreateDynamicObject(8171, -71.842140, 1523.223267, 25.886797, 0.0000, 91.1002, 0.0000);
CreateDynamicObject(8171, -24.839172, 1461.307861, 26.066355, 0.0000, 272.3375, 270.0000);
CreateDynamicObject(3749, 54.174911, 1459.897095, 18.782730, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(980, 54.145416, 1460.681519, 15.746822, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(3499, -13.117184, 1573.632324, 36.654724, 0.0000, 343.6707, 359.1406);
CreateDynamicObject(3499, -9.880372, 1573.435791, 26.214943, 0.0000, 341.9518, 358.2811);
CreateDynamicObject(3499, -5.860335, 1573.837769, 25.952940, 0.0000, 24.0642, 0.0000);
CreateDynamicObject(3499, -1.674980, 1573.637817, 36.090759, 0.0000, 20.6265, 356.5623);
CreateDynamicObject(3499, 11.881859, 1573.859253, 24.837389, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3499, 11.865444, 1573.647705, 35.849205, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3499, 26.342867, 1573.871948, 24.171310, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3499, 26.310228, 1573.660156, 35.204441, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3499, 31.752815, 1573.691284, 31.354481, 0.0000, 88.5219, 0.0000);
CreateDynamicObject(3499, 31.388290, 1573.553101, 40.537567, 0.0000, 88.5219, 0.0000);
CreateDynamicObject(3499, 37.518379, 1573.638916, 36.310085, 0.0000, 356.5623, 0.0000);
CreateDynamicObject(3438, 11.606258, 1573.409302, 48.996704, 0.0000, 359.1406, 270.6186);
CreateDynamicObject(3472, -77.766808, 1522.957153, 29.218779, 0.0000, 91.9597, 0.0000);
CreateDynamicObject(3472, -8.404146, 1456.364258, 26.772947, 279.2130, 0.0000, 359.1406);
CreateDynamicObject(3528, 64.893326, 1486.432983, 33.662514, 0.0000, 0.0000, 168.7500);
CreateDynamicObject(3528, 64.908669, 1551.091919, 35.083618, 0.0000, 0.0000, 168.7500);
CreateDynamicObject(3528, -71.732590, 1486.699219, 34.480267, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3528, -71.721413, 1554.912109, 34.211903, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3528, -39.399704, 1461.101196, 34.017406, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(3528, 21.811314, 1461.031860, 35.717033, 0.0000, 0.0000, 78.7500);
CreateDynamicObject(6865, 11.492750, 1573.379150, 46.370136, 0.0000, 0.0000, 33.7500);
CreateDynamicObject(7073, -61.916271, 1565.482544, 37.969872, 0.0000, 0.0000, 315.0000);
CreateDynamicObject(7392, 64.278671, 1522.171021, 36.824490, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(7916, -57.514637, 1550.590088, 21.737492, 0.0000, 2.5783, 47.6557);
CreateDynamicObject(8483, 56.594845, 1565.941284, 18.131325, 0.0000, 0.0000, 225.0000);
CreateDynamicObject(8483, -63.970612, 1471.119507, 17.692839, 0.0000, 0.0000, 33.7500);
CreateDynamicObject(8253, -58.133842, 1519.566895, 15.677788, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(972, -48.465031, 1517.434326, 10.671898, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(16093, -52.382675, 1511.988647, 11.455915, 0.0000, 0.0000, 180.0000);
CreateDynamicObject(3819, -65.892624, 1528.128052, 12.747758, 0.0000, 347.1084, 87.6536);
CreateDynamicObject(14791, -65.358505, 1520.375488, 13.795061, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(3819, -64.626823, 1511.890503, 12.747758, 0.0000, 0.0000, 270.0000);
CreateDynamicObject(1240, -53.539787, 1529.304688, 11.946065, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(1242, -58.325867, 1528.990356, 11.977450, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(2036, -57.656189, 1525.097656, 11.783926, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(2035, -53.632629, 1525.536987, 11.774437, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3439, -44.980873, 1533.346436, 15.863350, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(3439, -44.323421, 1505.885254, 15.863350, 0.0000, 0.0000, 0.0000);
CreateDynamicObject(8841, 64.689659, 1531.405396, 15.238568, 0.0000, 0.0000, 90.0000);
CreateDynamicObject(8841, 64.690445, 1500.350220, 15.311060, 0.0000, 0.0000, 90.0000);
*/

AddStaticVehicle(471,2022.9384,1327.5214,10.3123,269.1072,1,1); // Quad LV
AddStaticVehicle(589,2024.4425,1334.6178,10.1966,271.2565,93,93); // Club LV
AddStaticVehicle(589,2025.0073,1350.5670,10.2487,270.4885,3,3); // Club LV
AddStaticVehicle(418,2037.2524,1353.0051,10.8292,182.9488,93,1); // Moobeam
AddStaticVehicle(434,2037.6342,1332.9471,10.7058,180.6889,5,5); // The Back Is Moobeam Now This Hotknife "/lv"
AddStaticVehicle(434,2037.4750,1312.7150,10.7116,180.9767,5,5); // The Back Is Hotknife Now This Hotknife "/lv"
AddStaticVehicle(434,1921.0958,1268.7159,10.7046,90.0126,5,5); // HotKnife
AddStaticVehicle(411,2141.9824,1006.0000,10.5656,89.9999,112,1); // Infernus Near Race
AddStaticVehicle(411,2141.9824,1009.5645,10.5656,89.9999,112,1); // Infernus Near Race
AddStaticVehicle(411,2141.9824,1028.9716,10.5656,89.9999,112,1); // Infernus Near Race
AddStaticVehicle(506,2132.5759,1025.6621,10.5247,268.9935,6,6); // Super GT Near Race
AddStaticVehicle(411,2132.9597,1022.2715,10.5474,89.8886,5,7); // Infernus Near Race
AddStaticVehicle(409,2165.0129,1019.6796,10.6321,0.4157,0,0); // Stretch
AddStaticVehicle(483,2119.7434,1002.1898,10.8192,180.6715,1,1); // Camper Near Race
AddStaticVehicle(451,2037.7672,1686.2991,10.4514,357.5176,123,123); // Toutismo Near MShip
AddStaticVehicle(451,2232.7896,1878.7345,10.5291,2.6349,123,123); // Toutismo Near MShip
AddStaticVehicle(407,2292.4670,2376.7817,10.9775,182.0383,3,1); // Firetruck Near
AddStaticVehicle(522,-2741.8784,350.6981,3.9880,93.3022,7,7); // NRG500 SF
AddStaticVehicle(522,-2742.2024,346.8197,3.9975,90.2056,0,0); // NRG500 SF
AddStaticVehicle(468,-2678.1604,268.1653,4.0072,356.8907,3,3); // sANCHEZ
AddStaticVehicle(425,-2705.2852,83.8269,4.8315,261.7350,43,0); // Hunter SF
AddStaticVehicle(524,679.6238,839.6711,-42.0283,63.0826,1,1); // Cement Truck

//=[Props]
    LoadProperties();
    MaximuxPlayer = GetMaxPlayers();
	for(new i; i<MaximuxPlayer; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        new pName[MAX_PLAYER_NAME];
			GetPlayerName(i, pName, MAX_PLAYER_NAME);
			for(new propid; propid < PropertiesAmount; propid++)
			{
				if(PropInfo[propid][PropIsBought] == 1)
				{
				    if(strcmp(PropInfo[propid][PropOwner], pName, true)==0)
					{
					    EarningsForPlayer[i] += PropInfo[propid][PropEarning];
					    PlayerProps[i]++;
					}
				}
			}
		}
	}
    SetTimer("UpdateUnbuyableTime", 60000, 1);
	#if ENABLE_MAP_ICON_STREAMER == 1
	SetTimer("MapIconStreamer", 500, 1);
	#endif
	SetTimer("PropertyPayout",10*60*1000, 1);
//=[Props]=
TD3 = TextDrawCreate(205.000000,411.000000, TDS4);
        TextDrawBoxColor(TD3,0x00000066);
          TextDrawTextSize(TD3,490.000000,1.000000);
         TextDrawAlignment(TD3,0);
        TextDrawBackgroundColor(TD3,0x000000ff);
      TextDrawFont(TD3,3);
        TextDrawLetterSize(TD3,0.799999,1.800000);
         TextDrawColor(TD3,0xffffffff);
        TextDrawSetOutline(TD3,1);
        TextDrawSetProportional(TD3,1);

        TextDrawSetShadow(TD3,1);



        if(!dini_Exists(OVERALLFILE))
        {
        dini_Create(OVERALLFILE);
        printf("[File Created]: %s", OVERALLFILE);
            dini_FloatSet(OVERALLFILE, "S1", 0.0000);
            dini_FloatSet(OVERALLFILE, "S2", 0.0000);
            dini_FloatSet(OVERALLFILE, "S3", 0.0000);
            dini_Set(OVERALLFILE, "N1", "Empty");
            dini_Set(OVERALLFILE, "N2", "Empty");
            dini_Set(OVERALLFILE, "N3", "Empty");
        }
        if(!dini_Exists(PERSONALFILE))
        {
        dini_Create(PERSONALFILE);
        printf("[File Created]: %s", PERSONALFILE);
        }
        HS[0] = dini_Float(OVERALLFILE, "S1");
        HS[1] = dini_Float(OVERALLFILE, "S2");
        HS[2] = dini_Float(OVERALLFILE, "S3");
        format(HSN[0], MAX_PLAYER_NAME, "%s", dini_Get(OVERALLFILE, "N1"));
        format(HSN[1], MAX_PLAYER_NAME, "%s", dini_Get(OVERALLFILE, "N2"));
        format(HSN[2], MAX_PLAYER_NAME, "%s", dini_Get(OVERALLFILE, "N3"));
//=[TD]=================================================================
//=[LoadConfig]=========================================================
CreateLoadConfig();
	

//--
//New

//=[CarSystem`s]=======================================================
if(!fexist("CarSys/"))
{
print(">		WARNING:\n");
print(" The  ' CarSys '   folder is missing from scriptfiles");
print("\n Please Create This Folder And Start the Filterscript Again\n");
return 1;
}

return 1;
}


public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{

if(GetPlayerVehicleID(playerid) >= VCount) return 0;
format(file,sizeof(file),"CarSys/car%d.txt",GetPlayerVehicleID(playerid));
new msg[256]; new PlayerName[100]; GetPlayerName(playerid,PlayerName,30);
if(VehicleInfo[vehicleid][CarOwned] == 1)
{
if(strcmp(PlayerName,VehicleInfo[vehicleid][CarOwner],true) == 0)
{
format(msg,sizeof(msg),"!%s ,שלך %s ברוך הבא לרכב ה",VehicleInfo[vehicleid][CarOwner],VehiclesName[GetVehicleModel(vehicleid) - 400]);
SendClientMessage(playerid,ORANGE,msg);
if(VehicleInfo[vehicleid][SaleV] > 0)
{
SendClientMessage(playerid,lblue,"/StopSale :הרכב שלך, עדיין מוצע לקניה, על מנת להפסיק את מכירת הרכב בצע/י");
}
}
else if(strcmp(PlayerName,VehicleInfo[vehicleid][CarOwner],true) == 1)
{


if(VehicleInfo[vehicleid][SaleV] != 0)
{
format(msg,sizeof(msg),".%s :מהבעלים %s :הצעה רכב זה מסוג *",VehicleInfo[vehicleid][CarOwner],VehiclesName[GetVehicleModel(vehicleid) - 400]);
SendClientMessage(playerid,lblue,msg);
format(msg,sizeof(msg),".$%d הציע את הרכב שלו לציבור במחיר של כ",VehicleInfo[vehicleid][SaleV]);
SendClientMessage(playerid,lblue,msg);
SendClientMessage(playerid,lblue,"/BuyCar :על מנת לקנות תרכב מבעל הרכב בצע/י ");
}
else
{

format(msg,sizeof(msg),".ולכן לא ניתן לקנייה %s רכב זה הינו בבעלות [%s]",VehicleInfo[vehicleid][CarOwner],VehiclesName[GetVehicleModel(vehicleid) - 400]);
SendClientMessage(playerid,lblue,msg);
}
}
}
else if(VehicleInfo[vehicleid][Buyable] == 0)
{
format(msg,sizeof(msg),".הינו רכב ציבורי ,%s רכב זה",VehiclesName[GetVehicleModel(vehicleid) - 400]);
SendClientMessage(playerid,0xB3111EFF,msg);
}
else if(VehicleInfo[vehicleid][Buyable] == 1)
{
format(msg, 256, "[$%d] :רכב זה פנוי לרכישה במחיר [%s]", VehicleInfo[vehicleid][Price],VehiclesName[GetVehicleModel(vehicleid) - 400]);
SendClientMessage(playerid, lblue, msg);
format(msg, 256, "/Car :לפרטים הרכב, בצע/י || /BuyCar :לרכישת הרכב, בצע/י");
SendClientMessage(playerid, lblue, msg);
}






if(PlayerInfo[playerid][Pets] ==1)
{
if(PlayerInfo[playerid][Shark] ==1)
{
DestroyDynamicObject(sam33[playerid]);
SharkYou[playerid] =0;
ThePetsInYou[playerid] =0;
}
if(PlayerInfo[playerid][Dolp] ==1)
{
DestroyDynamicObject(sam22[playerid]);
ThePetsInYou[playerid] =0;
DolpYou[playerid] =0;
}
if(PlayerInfo[playerid][Tor] ==1)
{
DestroyDynamicObject(sam44[playerid]);
ThePetsInYou[playerid] =0;
TorYou[playerid] =0;
}
}


if (GetVehicleModel(vehicleid) == 519 && ispassenger)
{
if (!ShamalExists(vehicleid))
{
CreateShamalInt(vehicleid, float(randomEx(3000)), float(randomEx(3000)), float(random(100)+800));
}
SetPlayerPosInShamal(playerid, vehicleid);
InShamal[playerid] = vehicleid;
}

return 1;
}

forward SendClientMessageToAdmins(color,const string[]);
public SendClientMessageToAdmins(color,const string[])
{
        for(new i = 0; i < MAX_PLAYERS; i++)
        {
                if(IsPlayerConnected(i))
                {
                       if (Spectatorl[i] > 0) {

                                SendClientMessage(i, lblue, string);

                        }
                }
        }
        return 1;
}




forward CancelDrift(playerid);
public CancelDrift(playerid)
{
if(PrivateCP[playerid] == 0)
{
for(new Drifter=0; Drifter<MAX_PLAYERS; Drifter++)
{
driftwinner[Drifter]=0;
DriftInvite[Drifter] =0;
IfInvite[Drifter] =0;
DriftNoNow = 0;
TogglePlayerControllable(playerid, 1);
SendClientMessage(Drifter,COLOR_ORANGE,"/drift help מירוץ הדריפט התפנה, על מנת להזמין חבר/ה למירוץ דריפט אישי");
}
}
return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{

if(InBike[playerid] > 0)
{
BikePlayers --;
InBike[playerid] =0;
SetPlayerVirtualWorld(playerid,0);
SetVehicleVirtualWorld(vehicleid,0);
return 1;
}
OutDrift(playerid);
if(MonsterNoTeleportion[playerid] == 1) {
MonsterPlayers --; iNmOnster[playerid] = 0; MonsterNoTeleportion[playerid] = 0; MonsterFucker[playerid] = 0;
DestroyVehicle(MonsterSYSTEM[playerid]);
if(IsPlayerInAnyVehicle(playerid))
{
RemovePlayerFromVehicle(playerid);
SetTimerEx("repairbug",5000,0,"i",playerid);
}
if(!IsPlayerInAnyVehicle(playerid))
{
SetTimerEx("repairbug",5000,0,"i",playerid);
}
MonStart[playerid] =0;
}
if(KK[playerid] == 1)
{
ResetPlayerWeapons(playerid);
SendClientMessage(playerid,WHITE,".Kart .עזבת את הפעילות ");
KartPlayers --; InKart[playerid] = 0; KK[playerid] = 0; Fuck[playerid] = 0;
DestroyVehicle(caridxx[playerid]);

if(IsPlayerInAnyVehicle(playerid))
{
RemovePlayerFromVehicle(playerid);
SetTimerEx("repairbug",5000,0,"i",playerid);
}
if(!IsPlayerInAnyVehicle(playerid))
{
SetTimerEx("repairbug",5000,0,"i",playerid);
}
return 1;
}

RemovePlayerFromRaces(playerid);


if(Youregisterrace[playerid] ==1){
Youregisterrace[playerid] =0;
DisablePlayerRaceCheckpoint(playerid);
RacePlayers--;
if(IsPlayerInAnyVehicle(playerid))
{
RemovePlayerFromVehicle(playerid);
SetTimerEx("repairbug",5000,0,"i",playerid);
}
if(!IsPlayerInAnyVehicle(playerid))
{
SetTimerEx("repairbug",5000,0,"i",playerid);
}
SetPlayerVirtualWorld(playerid,0);
SetVehicleVirtualWorld(vehicleid,0);
}
if(YouRegister[playerid] ==1){
YouRegister[playerid] =0;
DisablePlayerRaceCheckpoint(playerid);
DriftPlayer--;
if(IsPlayerInAnyVehicle(playerid))
{
RemovePlayerFromVehicle(playerid);
SetTimerEx("repairbug",5000,0,"i",playerid);
}
if(!IsPlayerInAnyVehicle(playerid))
{
SetTimerEx("repairbug",5000,0,"i",playerid);
}
}
return 1;
}
forward repairbug(playerid);
public repairbug(playerid) return SpawnPlayer(playerid);

public OnVehicleSpawn(vehicleid)
{
LinkVehicleToInterior(vehicleid,0);
SetVehicleVirtualWorld(vehicleid,0);
if( VehicleInfo[vehicleid][CarOwned] == 1 ) return SetTimerEx("UpdateCar",2000,0,"d",vehicleid);
tCount[vehicleid] = false;
new model = GetVehicleModel(vehicleid);
if(model==521||model==520||model==406||model==432||model==444||model==539||model==556||model==557) { DestroyVehicle(vehicleid); return 1; }
return 1;
}
public ExplodeShamal(vehicleid)
{
KillTimer(sExplode[vehicleid]);
if (tCount[vehicleid])
{
CreateExplosion(ShamalPos[vehicleid][0], ShamalPos[vehicleid][1], ShamalPos[vehicleid][2], 2, 15.0);
sExplode[vehicleid] = SetTimerEx("ExplodeShamal", random(1300)+100, 1, "d", vehicleid);
}
}
//car
//==============================================================================


//==============================================================================

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
{
if(InLcTeleport[playerid] ==1) return 0;



if (newkeys & 16 && InShamal[playerid])
{
new Float:X, Float:Y, Float:Z, Float:A;
GetVehiclePos(InShamal[playerid], X, Y, Z);
GetVehicleZAngle(InShamal[playerid], A);
X += (5 * floatsin(-floatsub(A, 45.0), degrees)),
Y += (5 * floatcos(-floatsub(A, 45.0), degrees));
SetPlayerInterior(playerid, 0);
SetPlayerPos(playerid, X, Y, floatsub(Z, 0.94));
SetPlayerFacingAngle(playerid, A);
SetCameraBehindPlayer(playerid);
InShamal[playerid] = 0;
}
if(IsKeyJustDown(KEY_FIRE,newkeys,oldkeys) || IsKeyJustDown(128,newkeys,oldkeys)){
if(GetPlayerInterior(playerid) == 4 || GetPlayerInterior(playerid) == 4){
SendClientMessage(playerid,COLOR_WHITE,".אין לתקוף או לאיים באיזור זה");
SetPlayerPos(playerid,1022.1641,-1133.3300,23.8281);
SetPlayerInterior(playerid,0);
}
}
if(IsKeyJustDown(KEY_FIRE,newkeys,oldkeys) || IsKeyJustDown(128,newkeys,oldkeys))
{
if(InArea(playerid,1985.0746,1858.3486,-1347.2802,-1464.8994))
{
if(IsPlayerInAnyVehicle(playerid)) return ResetPlayerWeapons(playerid),0;
ResetPlayerWeapons(playerid);
SendClientMessage(playerid,COLOR_WHITE,".אין לתקוף או לאיים באיזור זה");
if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
{
new vehicleid = GetPlayerVehicleID(playerid);
SetVehiclePos(vehicleid, 1874.7780, -1391.9210, 13.5482);
SetVehicleZAngle(vehicleid, 313.1693);
SetPlayerInterior(playerid, 0);
}
else
{
SetPlayerPos(playerid, 1874.7780, -1391.9210, 13.5482);
SetPlayerFacingAngle(playerid, 313.1693);
SetPlayerInterior(playerid, 0);
}
}
}
if(IsKeyJustDown(KEY_FIRE,newkeys,oldkeys) || IsKeyJustDown(128,newkeys,oldkeys)){
if(GetPlayerInterior(playerid) == 6 || GetPlayerInterior(playerid) == 1){
SendClientMessage(playerid,COLOR_WHITE,".אין לתקוף או לאיים באיזור זה");
SetPlayerPos(playerid,1424.9977,-2285.6335,13.3828);
SetPlayerInterior(playerid,0);
}
}
}
return 1;
}

IsKeyJustDown(key, newkeys, oldkeys)
{
if((newkeys & key) && !(oldkeys & key)) return 1;
return 0;
}










//-=-=


forward ShipBank(playerid);
public ShipBank(playerid)
{
new string[256];
new pcash[MAX_PLAYERS];
if(BankShipOn[playerid] == 0) return 0;
if(InAreaShip(playerid, 1995.5, 1518.0, 2006.0, 1569.0))
{
pcash[playerid] = GetPlayerMoney(playerid);
PlayerInfo[playerid][BSHIP]+=pcash[playerid];
ResetPlayerMoney(playerid);
pcash[playerid] =0;
format(string, sizeof(string),".%d-הכסף של הבנק ספינה שלך הוכפל ל", PlayerInfo[playerid][BSHIP]);
SendClientMessage(playerid, COLOR_ORANGE, string);
dini_IntSet(GetPlayerFile(playerid),"BSHIP",PlayerInfo[playerid][BSHIP]);
}
else
{
format(string, sizeof(string),">>.%d-הפסקת בהצלחה, קיבלת סכום של כ", PlayerInfo[playerid][BSHIP]-100);
SendClientMessage(playerid, COLOR_ORANGE, string);
BankShipOn[playerid] = 0;
LACY_GiveMoney(playerid, PlayerInfo[playerid][BSHIP]);
PlayerInfo[playerid][BSHIP]=0;
pcash[playerid] =0;
dini_IntSet(GetPlayerFile(playerid),"BSHIP",0);
}
return 1;
}
/*
forward rvip();
public rvip() {
for(new i;i<MAX_PLAYERS;i++)
{
ThisIsSendMessage[i] =1;
}
return 1;
}
*/
forward rspam();
public rspam() {
for(new i;i<MAX_PLAYERS;i++)
{
antispam[i] =0;
}
return 1;
}

forward Rfb();
public Rfb() {
for(new i;i<MAX_PLAYERS;i++)
{
aDoing[i] = 0;
}
return 1;
}
forward Rpet();
public Rpet() {
for(new i;i<MAX_PLAYERS;i++)
{
PetInWar[i]=0;
}
return 1;
}
forward Rhelp();
public Rhelp() {
for(new i;i<MAX_PLAYERS;i++)
{
helpme[i] =0;
}
return 1;
}

forward Rcall();
public Rcall() {
for(new i;i<MAX_PLAYERS;i++)
{
InCall[i] =0;
}
return 1;
}


public OnPlayerText(playerid, text[])
{
if(isafk[playerid] == 1) return OnPlayerCommandText(playerid,"/unafk");
if(antispam[playerid] >0 && !IsPlayerXAdmin(playerid)) return SendClientMessage(playerid,WHITE,".הודעה אחת כל 2 שניות"),0;
antispam[playerid] ++;
new str[256];
if(!dini_Exists(GetPlayerFile(playerid))) {
format(str, sizeof(str), "/Register [Pass] <> :קודם כל הרשם/י עם לביצוע ההרשמה",0);
SendClientMessage(playerid, COLOR_WHITE , str);
spawnloged[playerid] =1;
return 0;
}
else if(dini_Exists(GetPlayerFile(playerid)) && PlayerInfo[playerid][Logged] == 0)
{
format(str, sizeof(str), "/login [Pass] <> :קודם כל התחבר/י לביצוע החיבור",0);
SendClientMessage(playerid, COLOR_WHITE, str);
spawnloged[playerid] =1;
return 0;
}
if((text[0] != '!' && text[0] != '@') &&
strfind(text, "227", true)!=-1 ||
strfind(text, "7003", true)!=-1 ||
strfind(text, "5555", true)!=-1 ||
strfind(text, ".145", true)!=-1 ||
strfind(text, "6666", true)!=-1 ||
strfind(text, "212", true)!=-1 ||
strfind(text, "1111", true)!=-1 ||
strfind(text, "7777", true)!=-1 ||
strfind(text, "7002", true)!=-1 ||
strfind(text, "26.", true)!=-1 ||
strfind(text, ":8888", true)!=-1 ||
strfind(text, "7 7 7 7", true)!=-1 ||
strfind(text, ".254", true)!=-1 ||
strfind(text, "2007", true)!=-1 ||
strfind(text, "7777", true)!=-1 ||
strfind(text, "26.", true)!=-1 ||strfind(text, "8.", true)!=-1 ||
strfind(text, "234.", true)!=-1 || strfind(text, "6.", true)!=-1) {
format(str, sizeof(str), ".\"%d\" מילה לא חוקית" , text);
SendClientMessage(playerid,red, str);

return 0;
}


if(Sagebir[playerid] ==1){
new string[256];
new year, month,day;
getdate(year, month, day);
new DateInfo[3][20];
split(text, DateInfo, '/');
if(year - strval(DateInfo[2]) > 100 || strval(DateInfo[2]) < 1 || strval(DateInfo[2]) >= year)
{
SendClientMessage(playerid,WHITE, "(Usage: dd/mm/yyyy) :תאריך לידה לא חוקי נסה ככה");
return 0;
}
new check = year - strval(DateInfo[2]);
if(check == year)
{
SendClientMessage(playerid,WHITE, "(Usage: dd/mm/yyyy) :תאריך לידה לא חוקי נסה ככה");
return 0;
}
if(strval(DateInfo[1]) > month)
{
check -= 1;
}
else if(strval(DateInfo[1]) == month && strval(DateInfo[0]) > day)
{
check -= 1;
}
PlayerInfo[playerid][AggInfo] = check;
format(string, sizeof(string), "[%d] אוקיי אז אתה בן",PlayerInfo[playerid][AggInfo]);
SendClientMessage(playerid, 0x0F482FF, string);
SendClientMessage(playerid,COLOR_ORANGE, ".כעת תוכל לדבר חופשי בצ'אט");
Sagebir[playerid] =0;
return 0;
}

GetPlayerName(playerid,playername, sizeof(playername));
if(text[0] == '@')
{
if(strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"None.",true) == 0 || strfind(dini_Get(GetPlayerFile(playerid),"Clan"),"None",true) == 0 || dini_Int(GetPlayerFile(playerid), "ClanLvl") < 1) return SendClientMessage(playerid,WHITE,"!אתה לא חבר בשום קלאן"),0;
if(ClanMute[playerid] > 0) return SendClientMessage(playerid,WHITE,".אתה במיוט בקלאן צ'אט לא תוכל לדבר בקלאן צ'אט עד שיורידו לך"),0;
new st3[256];
format(st3,sizeof(st3),"@ %s(ID: %d | LVL: %d): %s",playername,playerid,dini_Int(GetPlayerFile(playerid), "ClanLvl"),text[1]);
for(new i = 0; i < GetMaxPlayers() ; i++)
{
GetPlayerName(i,iname, sizeof(iname));
if(!strcmp(dini_Get(GetPlayerFile(playerid),"Clan"),dini_Get(GetPlayerFile(i),"Clan"),true))
{
if(dini_Int(GetPlayerFile(i), "ClanLvl") > 0)
{
SendClientMessage(i,lblue,st3);
}
}
}
return 0;
}
if(text[0] == '^')
{
if (CellState[playerid]==ESTA_HABLANDO)
{
new msg[255];
new pName2[MAX_PLAYER_NAME];
GetPlayerName(playerid,pName2,sizeof(pName2));
format(msg,sizeof(msg),"[ID: %s]: %s",pName2,text);
AlTelefono(AuxiliarTel[playerid],msg);
format(msg,sizeof(msg),"[Phone]: %s",text);
SendClientMessage(playerid,COLOR_LIGHTGREEN,msg);
SendClientMessageToAdmins(COLOR_WHITE,string);
new Float:x1,Float:y1,Float:z1;
if  (DIST!=-1)
for (new i=0;i<MAX_PLAYERS;i++)
{
if(GDTP(i,x1,y1,z1)<DIST)
{
SendClientMessage(i,0xF6F658FF,msg);
}
}
}
return 0;
}


if(text[0] == '!')
{
if(playerGang[playerid] > 0)
{
new gangChat[256];
new senderName[MAX_PLAYER_NAME];
//for(new i = 1; i < strlen(text)+1; i++)
//gangChat[i]=text[i];
strmid(gangChat,text,1,strlen(text));
GetPlayerName(playerid, senderName, sizeof(senderName));
format(string, sizeof(string),"! [GANG CHAT] %s: %s", senderName, gangChat);
for(new i = 0; i < gangInfo[playerGang[playerid]][1]; i++)
{
SendClientMessage(gangMembers[playerGang[playerid]][i], lblue, string);
SendClientMessageToAdmins(COLOR_WHITE,string);
}
return 0;
}
return 0;
}
if ((text[0] != '!' && text[0] != '@') && strfind(text, "213.8.26.132:2007", true)!=-1 || strfind(text, "195.189.140.155:7007", true)!=-1 || strfind(text, "80.179.149.110:1234", true)!=-1 || strfind(text, "213.8.26.132:7003", true)!=-1 || strfind(text, "www.top-games.co.il", true)!=-1 || strfind(text, "213.8.26.132:5555", true)!=-1
|| strfind(text, "62.90.136.233:7777", true)!=-1 || strfind(text, "82.80.245.35:7777", true)!=-1 || strfind(text, "195.189.140.50:7002", true)!=-1){
spamkick[playerid] ++;
if(spamkick[playerid]  ==1) return SendClientMessage(playerid,WHITE,"BAN - קיבלת באן בגלל פרסום שרת"),0;
Ban(playerid);
//if(spamkick[playerid]  ==3) return SendClientMessage(playerid,WHITE,".קיבלת אזהרה 2/3 עוד פעם 1 תקבל קיק מהשרת"),0;
//if(spamkick[playerid]  ==2) return SendClientMessage(playerid,WHITE,"קיבלת אזהרה 1/3 עוד פעמיים תקבל קיק"),0;
//if(spamkick[playerid]  ==4) return SendClientMessage(playerid,WHITE,"קיבלת קיק מהשרת עקב תכנים לא חוקיים"),0,TogglePlayerControllable(playerid,0),Kick(playerid);
return 0;
}
if ((text[0] != '!' && text[0] != '@') && strfind(text, "VGames", true)!=-1 || strfind(text, "7 0 0 3", true)!=-1 || strfind(text, "6666", true)!=-1 || strfind(text, "7777", true)!=-1 || strfind(text, "/q", true)!=-1 || strfind(text, "8888", true)!=-1
|| strfind(text, "fxp", true)!=-1 || strfind(text, "7007", true)!=-1 || strfind(text, "2007", true)!=-1)
{
spamkick[playerid] ++;
if(spamkick[playerid]  ==1) return SendClientMessage(playerid,red,"Warning - קיבלת אזהרה על תוכן לא חוקי"),0;
if(spamkick[playerid]  ==3) return SendClientMessage(playerid,red,".קיבלת אזהרה 2/3 עוד פעם 1 תקבל קיק מהשרת"),0;
if(spamkick[playerid]  ==2) return SendClientMessage(playerid,red,"קיבלת אזהרה 1/3 עוד פעמיים תקבל קיק"),0;
if(spamkick[playerid]  ==4) return SendClientMessage(playerid,red,"קיבלת קיק מהשרת עקב תכנים לא חוקיים"),0,TogglePlayerControllable(playerid,0);

return 0;
}




	new pName[24];
	new pFile[256];
	new pAdded[256];
	new pText[256];
	new pTag[256];
	GetPlayerName(playerid,pName,sizeof(pName));
	format(pFile,sizeof(pFile),"Tags/%s.txt",pName);
	pTag = dini_Get(pFile,"Tag");
	if(strcmp(pTag[playerid]," ",true) == 0)
	{
		format(pAdded,sizeof(pAdded),"(ID: %d)",playerid);
	}
	else
	{
        format(pAdded,sizeof(pAdded),"(ID: %d | %s )",playerid,pTag);
	}
	format(pText,sizeof(pText)," %s %s",text,pAdded);
	printf("Chat-Log: %s (%s)",text,pAdded);
	SendPlayerMessageToAll(playerid,pText);
	return 0;
	}




forward TimeUpdate();
public TimeUpdate() {
new string[256];
new n = random(MAX_WANGEXPORTVEHICLES);

format(string, sizeof(string),"*** %s's ,מוסך וואנג מחפש כרגע תרכב", wantedWangExportVehicleNames[n]);
SendClientMessageToAll(0xFFFF00AA, string);

wantedWangExportVehicle = wantedWangExportVehicles[n];
for(new i=0;i<MAX_PLAYERS;i++) {
if(IsPlayerConnected(i))
{
Sell[i] = -1;
}
}
}



forward WarStartr();
public WarStartr()
{
new string[256];
SendClientMessageToAll(COLOR_WHITE,"[_____________גאטר - בזוקות מאורגן_____________]");
SendClientMessageToAll(0xF6F658FF, "! נפתחה הרשמה לקרב מאורגן, הזדרזו להירשם");
format(string,sizeof(string),".$10,000 :פרס למנצח מתחיל מסכום של");
SendClientMessageToAll(0xF6F658FF,string);
SendClientMessageToAll(0x0F6A0FF, "/Rpg :יש לכם 60 שניות להצטרף, להצטרפות רשמו");
SendClientMessageToAll(COLOR_WHITE,"----------------------------------");
WarOnr = 1; WarPlayersr = 0;
Countr = 60; Countdownr(); CountFucr = 1;
return 1;
}

//==================================Countdown===================================
forward Countdownr();
public Countdownr()
{
new string[256];
if(Countr == 25)
{
format(string,sizeof(string),"[Players: %d] if you want to do fun please doing /Rpg.",WarPlayersr);
SendClientMessageToAll(COLOR_WHITE,string);
}
else if(Countr == 10)
{
format(string,sizeof(string),"[Players: %d] if you want to do fun please doing /Rpg.",WarPlayersr);
SendClientMessageToAll(COLOR_WHITE,string);
}
new String[256];
format(String, 256,"~W~%d",Countr);
GameTextForAll(String,1000,6);
if(Countr > 0)
{
--Countr;
SetTimer("Countdownr", 1000, 0);
}
else
{
if(CountFucr == 1)
{
TeleportPlayerToWarr();
if(knoobr == 1)
{
Countr = 10; Countdownr(); CountFucr = 2;
}
}
if(CountFucr == 2 && Countr <= 0) {
Unfreezer();
}
}
}
//==================================Unfreeze====================================
forward Unfreezer();
public Unfreezer()
{
for(new i;i<MAX_PLAYERS;i++)
{
if(PPr[i] == 1)
{
TogglePlayerControllable(i, 1);
SetCameraBehindPlayer(i);
GameTextForAll("~W~ Lets Rpg", 3000, 1);
}
}
}
//=============================TeleportPlayerToWar==============================
forward TeleportPlayerToWarr();
public TeleportPlayerToWarr()
{
if(WarPlayersr < MinWarPlayersr)
{
WarEndr(0);
return 1;
}
new string[256];
SendClientMessageToAll(COLOR_WHITE,"[______________!גאטר בזוקות - החל______________]");
format(string,sizeof(string)," %d :מס' משתתפים",WarPlayersr),SendClientMessageToAll(0xE21E1EFF,string);
format(string,sizeof(string)," $10,000 :סכום זכייה שנקבע על ידי השחקנים הוא"),SendClientMessageToAll(0xE21E1EFF,string);
SendClientMessageToAll(COLOR_WHITE,"---------------------------------------");
for(new i;i<MAX_PLAYERS;i++)
{
if(InWarr[i] == 1) {
new rand = random(sizeof(gRandomWarSpawns));
SetPlayerPos(i, gRandomWarSpawns[rand][0], gRandomWarSpawns[rand][1], gRandomWarSpawns[rand][2]);
//editprofilelayerInterior(i, 10);

SetPlayerVirtualWorld(i,0);

KillTimer(AntiOff);
ResetPlayerWeapons(i);
rand = random(sizeof(WarWeaponsr));
GivePlayerWeapon(i,WarWeaponsr[rand],5000);
SetPlayerHealth(i, 100.0);
WSr = 1; PPr[i] = 1; knoobr = 1;
TogglePlayerControllable(i, 0);
CheckTimer = SetTimer("Checkr",1000, 1);
}
}
return 1;
}


forward WarEndr(statusr);
public WarEndr(statusr)
{
if(statusr == 0)
{
SendClientMessageToAll(WHITE, ".הגאטר בוטל בגלל חוסר שחקנים שהיה פחות מ-3");
SendClientMessageToAll(WHITE, ".כל שחקן שהצטרף קיבל פיצוי בסך 500 דולר");


WarOnr = 0; WarPlayersr = 0;
for(new i;i<MAX_PLAYERS;i++)
{
ResetPlayerWeapons(i);
InWarr[i] = 0;  PPr[i] = 0; WSr = 0; knoobr = 0;
SendClientMessage(i,COLOR_ORANGE,".קיבלת פיצוי בסך [500] דולר על סיבה: חוסר משתתפים בגאטר");
LACY_GiveMoney(i,500);
KillTimer(CheckTimer);
}
return 1;
}
else if(statusr == 1)
{

LACY_GiveMoney(WarWinnerr, Rewardr);
ResetPlayerWeapons(WarWinnerr);
SetPlayerInterior(WarWinnerr, 0);
SetPlayerPos(WarWinnerr, 2028.6577,1341.8792,10.8203);
//new string[256];
PlayerInfo[WarWinnerr][RPGS] ++;

SendClientMessageToAll(COLOR_WHITE,"[________ גאטר טילים - מנצח ________]");
format(fuxm, sizeof(fuxm), ".$3000 ניצח בקרב טילים, הכסף שהוא זכה בוא עומד על כ,%s",GetName(WarWinnerr)),SendClientMessageToAll(0xE21E1EFF, fuxm);
format(fuxm, sizeof(fuxm), ".%d מספר הנצחנות שלו בקרב טילים",PlayerInfo[WarWinnerr][RPGS]),SendClientMessageToAll(0xE21E1EFF, fuxm);
SendClientMessageToAll(COLOR_WHITE,"--------------------------------------");
//TogglePlayerControllable(KartWinner, 1);

WarOnr = 0; WarPlayersr = 0;
LACY_GiveMoney(WarWinnerr, 3000);
SetPlayerHealth(WarWinnerr, 100.0);
TogglePlayerControllable(WarWinnerr, 1);
//SetTimer("weaponanti",3000,1);
for(new i;i<MAX_PLAYERS;i++)
{
WSr = 0; PPr[i] = 0; knoobr = 0;
if(InWarr[i] == 1)
{
ResetPlayerWeapons(i);
InWarr[i] = 0; 
}
}
return 1;
}
return 1;
}


forward Checkr(playerid);
public Checkr(playerid)
{
if(WSr == 1)
{
if(WarPlayersr == 1)
{
for(new i;i<MAX_PLAYERS;i++)
{
if(InWarr[i] == 1)
{
WarWinnerr = i; WarEndr(1);
}
}
}
}
return 1;
}





public OnPlayerPickUpPickup(playerid, pickupid)
{
	new propid = -1;
	for(new id; id<MAX_PROPERTIES; id++)
	{
		if(PropInfo[id][PickupNr] == pickupid)
		{
			propid = id;
            break;
		}
	}

	    new str[128];
		new propidS = IsPlayerNearProperty(playerid);

			new ownerid = GetPlayerID(PropInfo[propidS][PropOwner]);

			if(ownerid == playerid)
			{
       format(str, 128, "--- (%d) \"%s\" - נכס ---",propid,PropInfo[propid][PropName] );
	   SendClientMessage(playerid, COLOR_WHITE, str);
	   format(str, 128, "%s - ברוכים הבאים לנכס שלך",GetName(playerid) );
	   SendClientMessage(playerid, 0xFFFF00AA, str);
	   SendClientMessage(playerid, 0xFFFF00AA, "/sell :על מנת למכור את הנכס שלך");
       format(str, 128, "%d$ :עד עכשיו הרווחת מהנכס הזה כ",PropInfo[propid][PropEarning] );
	   SendClientMessage(playerid, 0xFFFF00AA, str);
       format(str, 128, "%d$ :עם תמכור את הנכס תקבל פיצוי של כ",(PropInfo[propid][PropValue]/2));
	   SendClientMessage(playerid, 0xFFFF00AA, str);
	   SendClientMessage(playerid, COLOR_PURPLE, "/help prop על מנת לקבל עזרה בצע/י");


			    return 0;
				}


	if(propid != -1)
	{
	if(!PropInfo[propid][PropIsBought])
	{
	   format(str, 128, "--- (%d) \"%s\" - נכס ---",propid,PropInfo[propid][PropName] );
	   SendClientMessage(playerid, COLOR_WHITE, str);

	   SendClientMessage(playerid, 0xFFFF00AA, "/buy :על מנת לקנות אותו");
       format(str, 128, "%d$ :עם תקנה את הנכס תרוויח בכל 10 דק' כ",PropInfo[propid][PropEarning] );
	   SendClientMessage(playerid, 0xFFFF00AA, str);
       format(str, 128, "%d$ :מחיר הנכס",PropInfo[propid][PropValue]);
	   SendClientMessage(playerid, 0xFFFF00AA, str);
	   SendClientMessage(playerid, COLOR_PURPLE, "/help prop על מנת לקבל עזרה בצע/י");

	}
	}

		if(propid != -1)
	{
	if(PropInfo[propid][PropIsBought])
	{
	if(ownerid != playerid)
{
	   format(str, 128, "--- (%d) \"%s\" - נכס ---",propid,PropInfo[propid][PropName] );
	   SendClientMessage(playerid, COLOR_WHITE, str);
	   format(str, 128, "/buy :על מנת לקנות אותו [ %s ] :נכס זה שייך ל",PropInfo[propid][PropOwner]);
	   SendClientMessage(playerid, 0xFFFF00AA, str);
       format(str, 128, "%d$ :עם תקנה את הנכס תרוויח בכל 10 דק' כ",PropInfo[propid][PropEarning] );
	   SendClientMessage(playerid, 0xFFFF00AA, str);
       format(str, 128, "%d$ :מחיר הנכס",PropInfo[propid][PropValue]);
	   SendClientMessage(playerid, 0xFFFF00AA, str);
	   SendClientMessage(playerid, COLOR_PURPLE, "/help prop על מנת לקבל עזרה בצע/י");
	}
	}
	}

return 1;
}









//==================================WarStart====================================
forward WarStart();
public WarStart()
{
new string[256];
MoneyWinnerWar +=500;
SendClientMessageToAll(COLOR_WHITE,"[_____________גאטר - מלחמה מאורגנת_____________]");
SendClientMessageToAll(0xF6F658FF, "! נפתחה הרשמה לקרב מאורגן, הזדרזו להירשם");
format(string,sizeof(string),".$%d :פרס למנצח מתחיל מסכום של",MoneyWinnerWar);
SendClientMessageToAll(0xF6F658FF,string);
SendClientMessageToAll(0x0F6A0FF, "/War :יש לכם 60 שניות להצטרף, להצטרפות רשמו");
SendClientMessageToAll(COLOR_WHITE,"----------------------------------");

WarOn = 1; WarPlayers = 0;
Count = 60; Countdown(); CountFuc = 1;
SAS = SetTimer("SAS",1000, 1);
return 1;
}
//==================================Countdown===================================
forward Countdown();
public Countdown()
{
new string[256];
if(Count == 40)
{
format(string,sizeof(string),"[Players: %d] if you want to do fun please doing /War.",WarPlayers);
SendClientMessageToAll(COLOR_WHITE,string);
}
else if(Count == 20)
{
format(string,sizeof(string),"[Players: %d] if you want to do fun please doing /War.",WarPlayers);
SendClientMessageToAll(COLOR_WHITE,string);
}
else if(Count == 10)
{
format(string,sizeof(string),"[Players: %d] if you want to do fun please doing /War.",WarPlayers);
SendClientMessageToAll(COLOR_WHITE,string);
}
new String[256];
format(String, 256,"~w~%d",Count);
for(new i = 0; i < MAX_PLAYERS; i++)
GameTextForAll(String,1000,6);
if(Count > 0)
{
--Count;
SetTimer("Countdown", 1000, 0);
}
else
{
if(CountFuc == 1)
{
TeleportPlayerToWar();
if(knoob == 1)
{
Count = 10; Countdown(); CountFuc = 2;
}
}
if(CountFuc == 2 && Count <= 0)
{
Unfreeze();
}
}
}

forward Unfreeze();
public Unfreeze()
{
for(new i;i<MAX_PLAYERS;i++)
{
if(PP[i] == 1)
{
TogglePlayerControllable(i, 1);
SetCameraBehindPlayer(i);
GameTextForAll("~g~War START!", 3000, 0);
}
}
}

forward TeleportPlayerToWar();
public TeleportPlayerToWar()
{
if(WarPlayers < MinWarPlayers)
{
WarEnd(0);
return 1;
}
new string[256];


SendClientMessageToAll(COLOR_WHITE,"[______________!גאטר מלחמה מאורגנת - החל______________]");
format(string,sizeof(string)," %d :מס' משתתפים",WarPlayers),SendClientMessageToAll(0xE21E1EFF,string);
format(string,sizeof(string)," $%d:סכום זכייה שנקבע על ידי השחקנים הוא",MoneyWinnerWar),SendClientMessageToAll(0xE21E1EFF,string);
SendClientMessageToAll(COLOR_WHITE,"---------------------------------------");



for(new i;i<MAX_PLAYERS;i++)
{
if(InWar[i] == 1)
{
//new string[256];
SetPlayerVirtualWorld(i,0);
CTP = SetTimer("asd",1000, 1);
new rand = random(sizeof(sssa));
SetPlayerPos(i, sssa[rand][0], sssa[rand][1], sssa[rand][2]);
SetPlayerInterior(i, 10);
ResetPlayerWeapons(i);
rand = random(sizeof(WarWeapons));
GivePlayerWeapon(i,WarWeapons[rand],5000);
SetPlayerArmour(i, 100.0);
SetPlayerHealth(i, 100.0);
WS = 1; PP[i] = 1; knoob = 1;
TogglePlayerControllable(i, 0);
CTP = SetTimer("asd",1000, 1);
//PP[i] =1;
}
}
return 1;
}

forward asd();
public asd()
{
if(WS == 1)
{
if(WarPlayers == 1)
{
for(new i;i<MAX_PLAYERS;i++)
{
if(InWar[i] == 1)
{
WarWinner = i; WarEnd(1);
}
}
}
}
return 1;
}


forward WarEnd(status);
public WarEnd(status)
{
if(status == 0)
{
SendClientMessageToAll(WHITE, ".הגאטר בוטל בגלל חוסר שחקנים שהיה פחות מ-3");
SendClientMessageToAll(WHITE, ".כל שחקן שהצטרף קיבל פיצוי בסך 500 דולר");


WarOn = 0; WarPlayers = 0;
KillTimer(CTP);
KillTimer(SAS);
for(new i;i<MAX_PLAYERS;i++)
{
InWar[i] = 0;  PP[i] = 0; WS = 0; knoob = 0;
InWar[i] = 0;  PP[i] = 0; WS = 0; knoob = 0;
if(PP[i] == 1)
{
SendClientMessage(i,COLOR_ORANGE,".קיבלת פיצוי בסך [500] דולר על סיבה: חוסר משתתפים בגאטר");
LACY_GiveMoney(i,500);
SetPlayerPos(i,2144.1472,1634.6127,993.5761);
SetPlayerInterior(i,1);
WarPlayers --; InWar[i] = 0; PP[i] = 0;

return 1;
}
}
return 1;
}
else if(status == 1)
{

LACY_GiveMoney(WarWinner, Reward);
GetPlayerName(WarWinner, playername, sizeof(playername));
format(knob, sizeof(knob), "~W~ The Winner Is ~n~~r~%s", playername);
GameTextForAll(knob, 4000, 1);
KillTimer(CTP);
KillTimer(SAS);
ResetPlayerWeapons(WarWinner);
SetPlayerInterior(WarWinner, 0);


PP[WarWinner] =0;
InWar[WarWinner]=0;

//new string[256];
PlayerInfo[WarWinner][Wars] ++;

SendClientMessageToAll(COLOR_WHITE,"[________ גאטר מלחמה מאורגנת - מנצח ________]");
format(fuxm, sizeof(fuxm), ".$%d ניצח בקרב הטילים,הסכום שהוא זכה בוא עומד על כ,%s",MoneyWinnerWar,GetName(WarWinner)),SendClientMessageToAll(0xE21E1EFF, fuxm);
format(fuxm, sizeof(fuxm), ".%d :מספר הנצחנות שלו במלחמות מאורגנות הם",PlayerInfo[WarWinner][Wars]),SendClientMessageToAll(0xE21E1EFF, fuxm);
SendClientMessageToAll(COLOR_WHITE,"--------------------------------------");
SetPlayerPos(WarWinner,2144.1472,1634.6127,993.5761);
SetPlayerInterior(WarWinner,1);
SendClientMessage(WarWinner,lblue,".שוגרת אוטומטית לבנק");
GameTextForPlayer(WarWinner,"~w~Bank",3000,5);
MoneyWinnerWar=0;
WarOn = 0; WarPlayers = 0;
TogglePlayerControllable(WarWinner, 1);

for(new i;i<MAX_PLAYERS;i++)
{
InWar[i] = 0; WS = 0; PP[i] = 0; knoob = 0;
}
return 1;
}
else if(status == 2)
{
format(knob, sizeof(knob), ".ביטל את המילחמה \"%s\" האדמין ", Adminname);
SendClientMessageToAll(COLOR_PINK, knob);
WarPlayers = 0;
knoob = 0; WS = 0;
WarOn = 0;
Count = 0; CountFuc = 0;
KillTimer(CTP);
KillTimer(SAS);
for(new i;i<MAX_PLAYERS;i++)
{
InWar[i] = 0; PP[i] = 0;
}
return 1;
}
return 1;
}







forward WarStartw();
public WarStartw()
{
new string[256];
MoneyWinnerMini =1500;
SendClientMessageToAll(COLOR_WHITE,"[_____________גאטר - מיניגאן מאורגן_____________]");
SendClientMessageToAll(0xF6F658FF, "! נפתחה הרשמה לקרב מאורגן, הזדרזו להירשם");
format(string,sizeof(string),".$%d :פרס למנצח מתחיל מסכום של",MoneyWinnerMini);
SendClientMessageToAll(0xF6F658FF,string);
SendClientMessageToAll(0x0F6A0FF, "/Mini :יש לכם 60 שניות להצטרף, להצטרפות רשמו");
SendClientMessageToAll(COLOR_WHITE,"----------------------------------");
WarOnw = 1; WarPlayersw = 0;
Countw = 60; Countdownw(); CountFucw = 1;
SASw = SetTimer("SAS",1000, 1);
return 1;
}
//==================================Countdown===================================
forward Countdownw();
public Countdownw()
{
new string[256];
if(Countw == 30)
{
format(string,sizeof(string),"[Players: %d] if you want to do fun please doing /Mini.",WarPlayersw);
SendClientMessageToAll(COLOR_WHITE,string);
}
else if(Countw == 15)
{
format(string,sizeof(string),"[Players: %d] if you want to do fun please doing /Mini.",WarPlayersw);
SendClientMessageToAll(COLOR_WHITE,string);
}
new String[256];
format(String, 256,"~w~ %d",Countw,WarPlayersw);
for(new i = 0; i < MAX_PLAYERS; i++)
GameTextForAll(String,1000,6);
if(Countw > 0)
{
--Countw;
SetTimer("Countdownw", 1000, 0);
}
else
{
if(CountFucw == 1)
{
TeleportPlayerToWarw();
if(knoobw == 1) {
Countw = 10; Countdownw(); CountFucw = 2;
}
}
if(CountFucw == 2 && Countw <= 0)
{
Unfreezew();
}
}
}

forward Unfreezew();
public Unfreezew()
{
for(new i;i<MAX_PLAYERS;i++)
{
if(PPw[i] == 1)
{
TogglePlayerControllable(i, 1);
SetCameraBehindPlayer(i);
GameTextForAll("~g~MiniGun Start", 3000, 0);
}
}
}

forward TeleportPlayerToWarw();
public TeleportPlayerToWarw()
{
if(WarPlayersw < MinWarPlayersw)
{
WarEndw(0);
return 1;
}
new string[256];
SendClientMessageToAll(COLOR_WHITE,"[______________!גאטר מיניגאן - החל______________]");
format(string,sizeof(string)," %d :מס' משתתפים",WarPlayersw),SendClientMessageToAll(0xE21E1EFF,string);
format(string,sizeof(string)," $%d:סכום זכייה שנקבע על ידי השחקנים הוא",MoneyWinnerMini),SendClientMessageToAll(0xE21E1EFF,string);
SendClientMessageToAll(COLOR_WHITE,"---------------------------------------");


for(new i;i<MAX_PLAYERS;i++)
{
if(InWarw[i] == 1)
{
ResetPlayerWeapons(i);
SetPlayerVirtualWorld(i,0);
new randw = random(sizeof(sssaw));
SetPlayerPos(i, sssaw[randw][0], sssaw[randw][1], sssaw[randw][2]);
//editprofilelayerInterior(i, 10);
ResetPlayerWeapons(i);
GivePlayerWeapon(i,38,8000);

WSw= 1; PPw[i] = 1; knoobw = 1;
TogglePlayerControllable(i, 0);
CTPw = SetTimer("asdw",1000, 1);
}
}
return 1;
}

forward WarEndw(statusw);
public WarEndw(statusw)
{
if(statusw == 0)
{
SendClientMessageToAll(WHITE, ".הגאטר בוטל בגלל חוסר שחקנים שהיה פחות מ-3");
SendClientMessageToAll(WHITE, ".כל שחקן שהצטרף קיבל פיצוי בסך 500 דולר");


WarOnw = 0; WarPlayersw = 0;
KillTimer(CTPw);
KillTimer(SASw);
for(new i;i<MAX_PLAYERS;i++)
{
if(InWarw[i] == 1)
{
ResetPlayerWeapons(i);
InWarw[i] = 0;  PPw[i] = 0; WSw= 0; knoobw = 0;
SendClientMessage(i,COLOR_ORANGE,".קיבלת פיצוי בסך [500] דולר על סיבה: חוסר משתתפים בגאטר");
LACY_GiveMoney(i,500);
}
}
return 1;
}
else if(statusw == 1)
{
KillTimer(CTPw);
KillTimer(SASw);
ResetPlayerWeapons(WarWinnerw);
LACY_GiveMoney(WarWinnerw,MoneyWinnerMini);
PlayerInfo[WarWinnerw][MINIGUN] ++;
SendClientMessageToAll(COLOR_WHITE,"[________ גאטר מיניגאן - מנצח ________]");
format(fuxm, sizeof(fuxm), ".$%d ניצח בקרב מיניגאן, סכום הכספי שהוא זכה בוא עומד על,%s",MoneyWinnerMini,GetName(WarWinnerw)),SendClientMessageToAll(0xE21E1EFF, fuxm);
format(fuxm, sizeof(fuxm), ".%d :מספר הנצחנות שלו במלחמות מאורגנות הם",PlayerInfo[WarWinnerw][MINIGUN]),SendClientMessageToAll(0xE21E1EFF, fuxm);
SendClientMessageToAll(COLOR_WHITE,"--------------------------------------");

SetPlayerPos(WarWinnerw,2144.1472,1634.6127,993.5761);
SetPlayerInterior(WarWinnerw,1);
MoneyWinnerMini=0;

TogglePlayerControllable(WarWinnerw, 1);
WarOnw = 0; WarPlayersw = 0;
for(new i;i<MAX_PLAYERS;i++)
{
WSw = 0;  knoobw = 0;
if(InWarw[i] == 1)
{
ResetPlayerWeapons(i);
InWarw[i] =0;
PPw[i] = 0;
}
}
return 1;

}
else if(statusw == 2)
{
WarPlayersw = 0;
knoobw = 0; WSw = 0;
WarOnw = 0;
Countw = 0; CountFucw = 0;
KillTimer(CTPw);
KillTimer(SASw);
for(new i;i<MAX_PLAYERS;i++)
{
InWarw[i] = 0; PPw[i] = 0;

}
return 1;
}
return 1;
}

forward asdw();
public asdw()
{
if(WSw == 1)
{
if(WarPlayersw == 1)
{
for(new i;i<MAX_PLAYERS;i++)
{
if(InWarw[i] == 1)
{
WarWinnerw = i; WarEndw(1);
}
}
}
}
return 1;
}




//=[PlayerToPoint]==============================================================
stock PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
if(IsPlayerConnected(playerid))
{
new Float:oldposx, Float:oldposy, Float:oldposz;
new Float:tempposx, Float:tempposy, Float:tempposz;
GetPlayerPos(playerid, oldposx, oldposy, oldposz);
tempposx = (oldposx -x);
tempposy = (oldposy -y);
tempposz = (oldposz -z);
if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
{
return 1;
}
}
return 0;
}
//=[Levels]=========================================================================
forward Levels();
public Levels()
{
new string[256];
for(new i;i<MAX_PLAYERS;i++)
{
if(IsPlayerConnected(i))
{

if (PlayerInfo[i][Level] == 0 && PlayerInfo[i][Kills] >= 100)
{
PlayerInfo[i][Level] +=1;

SetPlayerWantedLevel(i,1);

dini_IntSet(GetPlayerFile(i), "Level", PlayerInfo[i][Level]);
PlayerInfo[i][aLevelnl]=2;
PlayerInfo[i][aKillsnl]=200;
dini_IntSet(GetPlayerFile(i), "aKillsnl", PlayerInfo[i][aKillsnl]);
dini_IntSet(GetPlayerFile(i), "aLevelnl", PlayerInfo[i][aLevelnl]);
SendClientMessageToAll(COLOR_WHITE, "~~~~~~~[ Player Up Level ] ~~~~~~~");
format(string, sizeof(string), ">>.%s :שימו לב, השחקן/ינת", GetName(i));
SendClientMessageToAll(COLOR_PINK, string);

format(string, sizeof(string), ">>.%d :עבר/ה לרמה חדשה", PlayerInfo[i][Level]);
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d הרמה הבאה שלו %d :הריגות לרמה הבאה של השחקן", PlayerInfo[i][aLevelnl],PlayerInfo[i][aKillsnl]);
SendClientMessageToAll(COLOR_PINK, string);

}
if (PlayerInfo[i][Level] == 1 && PlayerInfo[i][Kills] >= 300)
{
PlayerInfo[i][Level] +=1;
SetPlayerWantedLevel(i,2);
dini_IntSet(GetPlayerFile(i), "Level", PlayerInfo[i][Level]);
dini_Set(GetPlayerFile(i), "Tag", "בייבי סטלה זון");
PlayerInfo[i][aLevelnl]=3;
PlayerInfo[i][aKillsnl]=200;
dini_IntSet(GetPlayerFile(i), "aKillsnl", PlayerInfo[i][aKillsnl]);
dini_IntSet(GetPlayerFile(i), "aLevelnl", PlayerInfo[i][aLevelnl]);

SendClientMessageToAll(COLOR_WHITE, "~~~~~~~[ Player Up Level ] ~~~~~~~");
format(string, sizeof(string), ">>.%s :שימו לב, השחקן/ינת", GetName(i));
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d :עבר/ה לרמה חדשה", PlayerInfo[i][Level]);
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d הרמה הבאה שלו %d :הריגות לרמה הבאה של השחקן", PlayerInfo[i][aLevelnl],PlayerInfo[i][aKillsnl]);
SendClientMessageToAll(COLOR_PINK, string);

}
if (PlayerInfo[i][Level] == 2 && PlayerInfo[i][Kills] >= 500)
{
PlayerInfo[i][Level] +=1;
SetPlayerWantedLevel(i,3);
PlayerInfo[i][aLevelnl]=4;
PlayerInfo[i][aKillsnl]=200;
dini_IntSet(GetPlayerFile(i), "aKillsnl", PlayerInfo[i][aKillsnl]);
dini_IntSet(GetPlayerFile(i), "aLevelnl", PlayerInfo[i][aLevelnl]);
dini_IntSet(GetPlayerFile(i), "Level", PlayerInfo[i][Level]);
SendClientMessageToAll(COLOR_WHITE, "~~~~~~~[ Player Up Level ] ~~~~~~~");
format(string, sizeof(string), ">>.%s :שימו לב, השחקן/ינת", GetName(i));
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d :עבר/ה לרמה חדשה", PlayerInfo[i][Level]);
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d הרמה הבאה שלו %d :הריגות לרמה הבאה של השחקן", PlayerInfo[i][aLevelnl],PlayerInfo[i][aKillsnl]);
SendClientMessageToAll(COLOR_PINK, string);

}
if (PlayerInfo[i][Level] == 3 && PlayerInfo[i][Kills] >= 700)
{
PlayerInfo[i][Level] +=1;
SetPlayerWantedLevel(i,4);
dini_IntSet(GetPlayerFile(i), "Level", PlayerInfo[i][Level]);
dini_Set(GetPlayerFile(i), "Tag", "סטלן מתפתח בסטלה זון");
PlayerInfo[i][aLevelnl]=5;
PlayerInfo[i][aKillsnl]=300;
dini_IntSet(GetPlayerFile(i), "aKillsnl", PlayerInfo[i][aKillsnl]);
dini_IntSet(GetPlayerFile(i), "aLevelnl", PlayerInfo[i][aLevelnl]);
SendClientMessageToAll(COLOR_WHITE, "~~~~~~~[ Player Up Level ] ~~~~~~~");
format(string, sizeof(string), ">>.%s :שימו לב, השחקן/ינת", GetName(i));
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d :עבר/ה לרמה חדשה", PlayerInfo[i][Level]);
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d הרמה הבאה שלו %d :הריגות לרמה הבאה של השחקן", PlayerInfo[i][aLevelnl],PlayerInfo[i][aKillsnl]);
SendClientMessageToAll(COLOR_PINK, string);

}
if (PlayerInfo[i][Level] == 4 && PlayerInfo[i][Kills] >= 1000) {
PlayerInfo[i][Level] +=1;
SetPlayerWantedLevel(i,5);
dini_IntSet(GetPlayerFile(i), "Level", PlayerInfo[i][Level]);
PlayerInfo[i][aLevelnl]=6;
PlayerInfo[i][aKillsnl]=300;
dini_IntSet(GetPlayerFile(i), "aKillsnl", PlayerInfo[i][aKillsnl]);
dini_IntSet(GetPlayerFile(i), "aLevelnl", PlayerInfo[i][aLevelnl]);
SendClientMessageToAll(COLOR_WHITE, "~~~~~~~[ Player Up Level ] ~~~~~~~");
format(string, sizeof(string), ">>.%s :שימו לב, השחקן/ינת", GetName(i));
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d :עבר/ה לרמה חדשה", PlayerInfo[i][Level]);
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d הרמה הבאה שלו %d :הריגות לרמה הבאה של השחקן", PlayerInfo[i][aLevelnl],PlayerInfo[i][aKillsnl]);
SendClientMessageToAll(COLOR_PINK, string);

}

if (PlayerInfo[i][Level] == 5 && PlayerInfo[i][Kills] >= 1300) {
PlayerInfo[i][Level] +=1;
SetPlayerWantedLevel(i,6);
dini_IntSet(GetPlayerFile(i), "Level", PlayerInfo[i][Level]);
dini_Set(GetPlayerFile(i), "Tag", "פרו סטלה");
PlayerInfo[i][aLevelnl]=7;
PlayerInfo[i][aKillsnl]=300;
dini_IntSet(GetPlayerFile(i), "aKillsnl", PlayerInfo[i][aKillsnl]);
dini_IntSet(GetPlayerFile(i), "aLevelnl", PlayerInfo[i][aLevelnl]);
SendClientMessageToAll(COLOR_WHITE, "~~~~~~~[ Player Up Level ] ~~~~~~~");
format(string, sizeof(string), ">>.%s :שימו לב, השחקן/ינת", GetName(i));
SendClientMessageToAll(COLOR_PINK, string);

format(string, sizeof(string), ">>.%d :עבר/ה לרמה חדשה", PlayerInfo[i][Level]);
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d הרמה הבאה שלו %d :הריגות לרמה הבאה של השחקן", PlayerInfo[i][aLevelnl],PlayerInfo[i][aKillsnl]);
SendClientMessageToAll(COLOR_PINK, string);


}
if (PlayerInfo[i][Level] == 6 && PlayerInfo[i][Kills] >= 1600) {
PlayerInfo[i][Level] +=1;
SetPlayerWantedLevel(i,7);
dini_IntSet(GetPlayerFile(i), "Level", PlayerInfo[i][Level]);
PlayerInfo[i][aLevelnl]=8;
PlayerInfo[i][aKillsnl]=100;
dini_IntSet(GetPlayerFile(i), "aKillsnl", PlayerInfo[i][aKillsnl]);
dini_IntSet(GetPlayerFile(i), "aLevelnl", PlayerInfo[i][aLevelnl]);
SendClientMessageToAll(COLOR_WHITE, "~~~~~~~[ Player Up Level ] ~~~~~~~");
format(string, sizeof(string), ">>.%s :שימו לב, השחקן/ינת", GetName(i));
SendClientMessageToAll(COLOR_PINK, string);

format(string, sizeof(string), ">>.%d :עבר/ה לרמה חדשה", PlayerInfo[i][Level]);
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d הרמה הבאה שלו %d :הריגות לרמה הבאה של השחקן", PlayerInfo[i][aLevelnl],PlayerInfo[i][aKillsnl]);
SendClientMessageToAll(COLOR_PINK, string);

}
if (PlayerInfo[i][Level] == 7 && PlayerInfo[i][Kills] >= 1700) {
PlayerInfo[i][Level] +=1;
SetPlayerWantedLevel(i,8);
dini_IntSet(GetPlayerFile(i), "Level", PlayerInfo[i][Level]);
dini_Set(GetPlayerFile(i), "Tag", "סטלן רוצח פרו");
PlayerInfo[i][aLevelnl]=9;
PlayerInfo[i][aKillsnl]=200;
dini_IntSet(GetPlayerFile(i), "aKillsnl", PlayerInfo[i][aKillsnl]);
dini_IntSet(GetPlayerFile(i), "aLevelnl", PlayerInfo[i][aLevelnl]);
SendClientMessageToAll(COLOR_WHITE, "~~~~~~~[ Player Up Level ] ~~~~~~~");
format(string, sizeof(string), ">>.%s :שימו לב, השחקן/ינת", GetName(i));
SendClientMessageToAll(COLOR_PINK, string);

format(string, sizeof(string), ">>.%d :עבר/ה לרמה חדשה", PlayerInfo[i][Level]);
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d הרמה הבאה שלו %d :הריגות לרמה הבאה של השחקן", PlayerInfo[i][aLevelnl],PlayerInfo[i][aKillsnl]);
SendClientMessageToAll(COLOR_PINK, string);

}
if (PlayerInfo[i][Level] == 8 && PlayerInfo[i][Kills] >= 1900) {
PlayerInfo[i][Level] +=1;
SetPlayerWantedLevel(i,9);
dini_IntSet(GetPlayerFile(i), "Level", PlayerInfo[i][Level]);
PlayerInfo[i][VIPS]++;
PlayerInfo[i][aLevelnl]=10;
PlayerInfo[i][aKillsnl]=200;
dini_IntSet(GetPlayerFile(i), "aKillsnl", PlayerInfo[i][aKillsnl]);
dini_IntSet(GetPlayerFile(i), "aLevelnl", PlayerInfo[i][aLevelnl]);
SendClientMessageToAll(COLOR_WHITE, "~~~~~~~[ Player Up Level ] ~~~~~~~");
format(string, sizeof(string), ">>.%s :שימו לב, השחקן/ינת", GetName(i));
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d :עבר/ה לרמה חדשה", PlayerInfo[i][Level]);
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d הרמה הבאה שלו %d :הריגות לרמה הבאה של השחקן", PlayerInfo[i][aLevelnl],PlayerInfo[i][aKillsnl]);
SendClientMessageToAll(COLOR_PINK, string);

}
if (PlayerInfo[i][Level] == 9 && PlayerInfo[i][Kills] >= 2100) {
PlayerInfo[i][Level] +=1;
SetPlayerWantedLevel(i,10);
dini_IntSet(GetPlayerFile(i), "Level", PlayerInfo[i][Level]);
dini_Set(GetPlayerFile(i), "Tag", "רוצח כבדוניק");
PlayerInfo[i][aLevelnl]=11;
PlayerInfo[i][aKillsnl]=400;
dini_IntSet(GetPlayerFile(i), "aKillsnl", PlayerInfo[i][aKillsnl]);
dini_IntSet(GetPlayerFile(i), "aLevelnl", PlayerInfo[i][aLevelnl]);
SendClientMessageToAll(COLOR_WHITE, "~~~~~~~[ Player Up Level ] ~~~~~~~");
format(string, sizeof(string), ">>.%s :שימו לב, השחקן/ינת", GetName(i));
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d :עבר/ה לרמה חדשה", PlayerInfo[i][Level]);
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d הרמה הבאה שלו %d :הריגות לרמה הבאה של השחקן", PlayerInfo[i][aLevelnl],PlayerInfo[i][aKillsnl]);
SendClientMessageToAll(COLOR_PINK, string);

}
if (PlayerInfo[i][Level] == 10 && PlayerInfo[i][Kills] >= 2500) {
PlayerInfo[i][Level] +=1;
SetPlayerWantedLevel(i,10);
dini_IntSet(GetPlayerFile(i), "Level", PlayerInfo[i][Level]);
dini_Set(GetPlayerFile(i), "Tag", "הרוצח של סטלה");
PlayerInfo[i][aLevelnl]=12;
PlayerInfo[i][aKillsnl]=500;
dini_IntSet(GetPlayerFile(i), "aKillsnl", PlayerInfo[i][aKillsnl]);
dini_IntSet(GetPlayerFile(i), "aLevelnl", PlayerInfo[i][aLevelnl]);
SendClientMessageToAll(COLOR_WHITE, "~~~~~~~[ Player Up Level ] ~~~~~~~");
format(string, sizeof(string), ">>.%s :שימו לב, השחקן/ינת", GetName(i));
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d :עבר/ה לרמה חדשה", PlayerInfo[i][Level]);
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d הרמה הבאה שלו %d :הריגות לרמה הבאה של השחקן", PlayerInfo[i][aLevelnl],PlayerInfo[i][aKillsnl]);
SendClientMessageToAll(COLOR_PINK, string);

}
if (PlayerInfo[i][Level] == 11 && PlayerInfo[i][Kills] >= 3000) {
PlayerInfo[i][Level] +=1;
SetPlayerWantedLevel(i,10);
dini_IntSet(GetPlayerFile(i), "Level", PlayerInfo[i][Level]);
dini_Set(GetPlayerFile(i), "Tag", "מסוכן");
PlayerInfo[i][aLevelnl]=13;
PlayerInfo[i][aKillsnl]=600;
dini_IntSet(GetPlayerFile(i), "aKillsnl", PlayerInfo[i][aKillsnl]);
dini_IntSet(GetPlayerFile(i), "aLevelnl", PlayerInfo[i][aLevelnl]);
SendClientMessageToAll(COLOR_WHITE, "~~~~~~~[ Player Up Level ] ~~~~~~~");
format(string, sizeof(string), ">>.%s :שימו לב, השחקן/ינת", GetName(i));
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d :עבר/ה לרמה חדשה", PlayerInfo[i][Level]);
SendClientMessageToAll(COLOR_PINK, string);

format(string, sizeof(string), ">>.%d הרמה הבאה שלו %d :הריגות לרמה הבאה של השחקן", PlayerInfo[i][aLevelnl],PlayerInfo[i][aKillsnl]);
SendClientMessageToAll(COLOR_PINK, string);

}
if (PlayerInfo[i][Level] == 12 && PlayerInfo[i][Kills] >= 3600) {
PlayerInfo[i][Level] +=1;
SetPlayerWantedLevel(i,10);
dini_IntSet(GetPlayerFile(i), "Level", PlayerInfo[i][Level]);
dini_Set(GetPlayerFile(i), "Tag", "סכנת מוות");
PlayerInfo[i][aLevelnl]=14;
PlayerInfo[i][aKillsnl]=400;
dini_IntSet(GetPlayerFile(i), "aKillsnl", PlayerInfo[i][aKillsnl]);
dini_IntSet(GetPlayerFile(i), "aLevelnl", PlayerInfo[i][aLevelnl]);

}
if (PlayerInfo[i][Level] == 13 && PlayerInfo[i][Kills] >= 4000) {
PlayerInfo[i][Level] +=1;
SetPlayerWantedLevel(i,10);
dini_IntSet(GetPlayerFile(i), "Level", PlayerInfo[i][Level]);
dini_Set(GetPlayerFile(i), "Tag", "זה הרוצח של סטלה זון");
PlayerInfo[i][VIPS]++;
PlayerInfo[i][aLevelnl]=15;
PlayerInfo[i][aKillsnl]=600;
dini_IntSet(GetPlayerFile(i), "aKillsnl", PlayerInfo[i][aKillsnl]);
dini_IntSet(GetPlayerFile(i), "aLevelnl", PlayerInfo[i][aLevelnl]);
SendClientMessageToAll(COLOR_WHITE, "~~~~~~~[ Player Up Level ] ~~~~~~~");
format(string, sizeof(string), ">>.%s :שימו לב, השחקן/ינת", GetName(i));
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d :עבר/ה לרמה חדשה", PlayerInfo[i][Level]);
SendClientMessageToAll(COLOR_PINK, string);

format(string, sizeof(string), ">>.%d הרמה הבאה שלו %d :הריגות לרמה הבאה של השחקן", PlayerInfo[i][aLevelnl],PlayerInfo[i][aKillsnl]);
SendClientMessageToAll(COLOR_PINK, string);

}
if (PlayerInfo[i][Level] == 14 && PlayerInfo[i][Kills] >= 4600) {
PlayerInfo[i][Level] +=1;
SetPlayerWantedLevel(i,10);
dini_IntSet(GetPlayerFile(i), "Level", PlayerInfo[i][Level]);
dini_Set(GetPlayerFile(i), "Tag", "אין מילים");
PlayerInfo[i][aLevelnl]=16;
PlayerInfo[i][aKillsnl]=500;
dini_IntSet(GetPlayerFile(i), "aKillsnl", PlayerInfo[i][aKillsnl]);
dini_IntSet(GetPlayerFile(i), "aLevelnl", PlayerInfo[i][aLevelnl]);
SendClientMessageToAll(COLOR_WHITE, "~~~~~~~[ Player Up Level ] ~~~~~~~");
format(string, sizeof(string), ">>.%s :שימו לב, השחקן/ינת", GetName(i));
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d :עבר/ה לרמה חדשה", PlayerInfo[i][Level]);
SendClientMessageToAll(COLOR_PINK, string);

format(string, sizeof(string), ">>.%d הרמה הבאה שלו %d :הריגות לרמה הבאה של השחקן", PlayerInfo[i][aLevelnl],PlayerInfo[i][aKillsnl]);
SendClientMessageToAll(COLOR_PINK, string);

}
if (PlayerInfo[i][Level] == 15 && PlayerInfo[i][Kills] >= 5100) {
PlayerInfo[i][Level] +=1;
SetPlayerWantedLevel(i,10);
dini_IntSet(GetPlayerFile(i), "Level", PlayerInfo[i][Level]);
dini_Set(GetPlayerFile(i), "Tag", "צ'מפיון רוצח");
PlayerInfo[i][aLevelnl]=17;
PlayerInfo[i][aKillsnl]=1000;
dini_IntSet(GetPlayerFile(i), "aKillsnl", PlayerInfo[i][aKillsnl]);
dini_IntSet(GetPlayerFile(i), "aLevelnl", PlayerInfo[i][aLevelnl]);
SendClientMessageToAll(COLOR_WHITE, "~~~~~~~[ Player Up Level ] ~~~~~~~");
format(string, sizeof(string), ">>.%s :שימו לב, השחקן/ינת", GetName(i));
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d :עבר/ה לרמה חדשה", PlayerInfo[i][Level]);
SendClientMessageToAll(COLOR_PINK, string);

format(string, sizeof(string), ">>.%d הרמה הבאה שלו %d :הריגות לרמה הבאה של השחקן", PlayerInfo[i][aLevelnl],PlayerInfo[i][aKillsnl]);
SendClientMessageToAll(COLOR_PINK, string);

}
if (PlayerInfo[i][Level] == 16 && PlayerInfo[i][Kills] >= 6100) {
PlayerInfo[i][Level] +=1;
SetPlayerWantedLevel(i,10);
dini_IntSet(GetPlayerFile(i), "Level", PlayerInfo[i][Level]);
dini_Set(GetPlayerFile(i), "Tag", "ההתקרבות על אחריותכם בלבד");
PlayerInfo[i][aLevelnl]=18;
PlayerInfo[i][aKillsnl]=1000;
dini_IntSet(GetPlayerFile(i), "aKillsnl", PlayerInfo[i][aKillsnl]);
dini_IntSet(GetPlayerFile(i), "aLevelnl", PlayerInfo[i][aLevelnl]);
SendClientMessageToAll(COLOR_WHITE, "~~~~~~~[ Player Up Level ] ~~~~~~~");
format(string, sizeof(string), ">>.%s :שימו לב, השחקן/ינת", GetName(i));
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d :עבר/ה לרמה חדשה", PlayerInfo[i][Level]);
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d הרמה הבאה שלו %d :הריגות לרמה הבאה של השחקן", PlayerInfo[i][aLevelnl],PlayerInfo[i][aKillsnl]);
SendClientMessageToAll(COLOR_PINK, string);

}
if (PlayerInfo[i][Level] == 17 && PlayerInfo[i][Kills] >= 7100) {
PlayerInfo[i][Level] +=1;
SetPlayerWantedLevel(i,10);
dini_IntSet(GetPlayerFile(i), "Level", PlayerInfo[i][Level]);
dini_Set(GetPlayerFile(i), "Tag", ":D");
PlayerInfo[i][aLevelnl]=19;
PlayerInfo[i][aKillsnl]=1000;
dini_IntSet(GetPlayerFile(i), "aKillsnl", PlayerInfo[i][aKillsnl]);
dini_IntSet(GetPlayerFile(i), "aLevelnl", PlayerInfo[i][aLevelnl]);
SendClientMessageToAll(COLOR_WHITE, "~~~~~~~[ Player Up Level ] ~~~~~~~");
format(string, sizeof(string), ">>.%s :שימו לב, השחקן/ינת", GetName(i));
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d :עבר/ה לרמה חדשה", PlayerInfo[i][Level]);
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d הרמה הבאה שלו %d :הריגות לרמה הבאה של השחקן", PlayerInfo[i][aLevelnl],PlayerInfo[i][aKillsnl]);
SendClientMessageToAll(COLOR_PINK, string);

}
if (PlayerInfo[i][Level] == 18 && PlayerInfo[i][Kills] >= 8100) {
PlayerInfo[i][Level] +=1;
SetPlayerWantedLevel(i,10);
dini_IntSet(GetPlayerFile(i), "Level", PlayerInfo[i][Level]);
dini_Set(GetPlayerFile(i), "Tag","רוצח על ימין ושמאל");
PlayerInfo[i][aLevelnl]=20;
PlayerInfo[i][aKillsnl]=1000;
dini_IntSet(GetPlayerFile(i), "aKillsnl", PlayerInfo[i][aKillsnl]);
dini_IntSet(GetPlayerFile(i), "aLevelnl", PlayerInfo[i][aLevelnl]);

SendClientMessageToAll(COLOR_WHITE, "~~~~~~~[ Player Up Level ] ~~~~~~~");
format(string, sizeof(string), ">>.%s :שימו לב, השחקן/ינת", GetName(i));
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d :עבר/ה לרמה חדשה", PlayerInfo[i][Level]);
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d הרמה הבאה שלו %d :הריגות לרמה הבאה של השחקן", PlayerInfo[i][aLevelnl],PlayerInfo[i][aKillsnl]);
SendClientMessageToAll(COLOR_PINK, string);

}
if (PlayerInfo[i][Level] == 19 && PlayerInfo[i][Kills] >= 9100) {
PlayerInfo[i][Level] +=1;
SetPlayerWantedLevel(i,10);
dini_IntSet(GetPlayerFile(i), "Level", PlayerInfo[i][Level]);
dini_Set(GetPlayerFile(i), "Tag","רוצח על ימין ושמאל++");
PlayerInfo[i][aLevelnl]=21;
PlayerInfo[i][aKillsnl]=900;
dini_IntSet(GetPlayerFile(i), "aKillsnl", PlayerInfo[i][aKillsnl]);
dini_IntSet(GetPlayerFile(i), "aLevelnl", PlayerInfo[i][aLevelnl]);
SendClientMessageToAll(COLOR_WHITE, "~~~~~~~[ Player Up Level ] ~~~~~~~");
format(string, sizeof(string), ">>.%s :שימו לב, השחקן/ינת", GetName(i));
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d :עבר/ה לרמה חדשה", PlayerInfo[i][Level]);
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.%d הרמה הבאה שלו %d :הריגות לרמה הבאה של השחקן", PlayerInfo[i][aLevelnl],PlayerInfo[i][aKillsnl]);
SendClientMessageToAll(COLOR_PINK, string);

}
if (PlayerInfo[i][Level] == 20 && PlayerInfo[i][Kills] >= 10000)
{
PlayerInfo[i][Level] +=1;
SetPlayerWantedLevel(i,10);
dini_IntSet(GetPlayerFile(i), "Level", PlayerInfo[i][Level]);
dini_Set(GetPlayerFile(i), "Tag",".וותיק, שסיים תמשחק. הרג יותר מידי");
SendClientMessageToAll(COLOR_WHITE, "~~~~~~~[ Player Up Level ] ~~~~~~~");
format(string, sizeof(string), ">>.%s :שימו לב, השחקן/ינת", GetName(i));
SendClientMessageToAll(COLOR_PINK, string);
format(string, sizeof(string), ">>.סיים תמשחק,%d :עבר/ה לרמה חדשה", PlayerInfo[i][Level]);
SendClientMessageToAll(COLOR_PINK, string);


}
}
}
return 1;
}


//=[OnPlayerS]==============================================================
forward OnPlayerStateChange(playerid, newstate, oldstate);
public OnPlayerStateChange(playerid, newstate, oldstate)
{
if(PlayerInfo[playerid][Pets] ==1)
{
if(PlayerInfo[playerid][Shark] ==1)
{
DestroyDynamicObject(sam33[playerid]);
SharkYou[playerid] =0;
ThePetsInYou[playerid] =0;
}
if(PlayerInfo[playerid][Dolp] ==1)
{
DestroyDynamicObject(sam22[playerid]);
ThePetsInYou[playerid] =0;
DolpYou[playerid] =0;
}
if(PlayerInfo[playerid][Tor] ==1)
{
DestroyDynamicObject(sam44[playerid]);
ThePetsInYou[playerid] =0;
TorYou[playerid] =0;
}
}
if(newstate == PLAYER_STATE_DRIVER && GetVehicleModel(GetPlayerVehicleID(playerid)) == 520)
{
if (PlayerInfo[playerid][Level] < 0 && PlayerInfo[playerid][Kills] < 151)
{
SendClientMessage(playerid,COLOR_WHITE," מרמה 1 ומעךהHydra מטוס ה");
RemovePlayerFromVehicle(playerid);
}
}
 if(newstate == PLAYER_STATE_DRIVER && GetVehicleModel(GetPlayerVehicleID(playerid)) == 425)
{
if (PlayerInfo[playerid][Level] < 0 && PlayerInfo[playerid][Kills] < 151)
{
SendClientMessage(playerid,COLOR_WHITE," מרמה 1 ומעלהHunter מסוק");
RemovePlayerFromVehicle(playerid);
}
}
if(newstate == PLAYER_STATE_DRIVER && GetVehicleModel(GetPlayerVehicleID(playerid)) == 538)
{
if(!IsPlayerXAdmin(playerid)) return SendClientMessage(playerid, COLOR_WHITE, ".רכבת ה`הישרדות` לאדמינים בלבד"),
RemovePlayerFromVehicle(playerid);
new string[256];
format(string, sizeof(string), "!התחיל את משחק ההישרדות ,%s :האדמין ",GetName(playerid)),SendClientMessage(playerid, COLOR_PINK, string);
}




return 1;
}
//=[SelllWang`s]===================================
public SellWangExportVehicle(playerid)
{
new string[256];
new wantedVehicle = -1;
for(new i=0;i<MAX_WANGEXPORTVEHICLES;i++)
{
if(wantedWangExportVehicles[i]==wantedWangExportVehicle)
{
wantedVehicle = i;
break;
}
}
if(wantedVehicle>=0)
{
if(GetVehicleModel(GetPlayerVehicleID(playerid))!=wantedWangExportVehicle)
{
format(string,256,".מוסך וואנג לא קונה רכב זה כרגע תודה");
SendClientMessage(playerid,WHITE,string);
return 1;
}
if(Sell[playerid] == wantedWangExportVehicle) return SendClientMessage(playerid, COLOR_WHITE, ".כבר מכרת רכב מסוג זה");
new payment = (random(7)+1)*1000;
format(string, sizeof(string), ".\"$%d\" תודה לך על הבאת הרכב למוסך וואנג , על רכב זה קיבלת כ",payment);
SendClientMessage(playerid,WHITE, string);
LACY_GiveMoney(playerid, payment);
SetVehicleToRespawn(GetPlayerVehicleID(playerid));
Sell[playerid] = wantedWangExportVehicle;
}
return 1;
}

//=[New`sRaceing`s]==================================
new CountingRace;
new CountRace;
//=[StartRacing]========================================
forward StartRace();
public StartRace()
{
new string[256];
SendClientMessageToAll(COLOR_WHITE,"[_____________גאטר - מירוץ מכוניות_____________]");
SendClientMessageToAll(0xF6F658FF, "! נפתחה הרשמה לקרב מירוצים, סוג מירוץ: מכוניות, הזדרזו להירשם");
format(string,sizeof(string),".$3000:המנצח יזכה בפרס כספי של");
SendClientMessageToAll(0xF6F658FF,string);
SendClientMessageToAll(0x0F6A0FF, "/races join :יש לכם 60 שניות להצטרף, להצטרפות רשמו");
SendClientMessageToAll(COLOR_WHITE,"----------------------------------");
CountingRace = 60; RaceCount(); CountRace = 1;
return 1;
}
//=[New`sDrift`s]=========================================
new CountingDrift;
new CountDrift;
//=[StartDrift`s]=======================================
forward StartDrift();
public StartDrift()
{
new string[256];
SendClientMessageToAll(COLOR_WHITE,"[_____________גאטר - מירוץ מכוניות_____________]");
SendClientMessageToAll(0xF6F658FF, "! נפתחה הרשמה לקרב מירוצים, סוג מירוץ: דריפט הזדרזו להירשם");
format(string,sizeof(string),".$3000:המנצח יזכה בפרס כספי של");
SendClientMessageToAll(0xF6F658FF,string);
SendClientMessageToAll(0x0F6A0FF, "/races join :יש לכם 60 שניות להצטרף, להצטרפות רשמו");
SendClientMessageToAll(COLOR_WHITE,"----------------------------------");
CountingDrift=60; driftCount(); CountDrift=1;
return 1;
}
//=[DriftCount`s]============================================
forward driftCount();
public driftCount()
{
new string[256];
if(CountDrift == 30)
{
format(string,sizeof(string),"[Players: %d] if you want to do fun please doing /races join - (Race TYPE: Drift).",DriftPlayer);
SendClientMessageToAll(COLOR_WHITE,string);
}
else if(CountDrift == 15)
{
format(string,sizeof(string),"[Players: %d] if you want to do fun please doing /races join - (Race TYPE: Drift).",DriftPlayer);
SendClientMessageToAll(COLOR_WHITE,string);
}

new String[256];
format(String, 256,"~w~ %d",CountingDrift);
for(new i = 0; i < MAX_PLAYERS; i++)
GameTextForAll(String,1000,6);
if(CountingDrift > 0)
{
--CountingDrift;
SetTimer("driftCount", 1000, 0);
}
else
{
if(CountDrift == 1)
{
if(knoobk == 1)
{
CountingDrift = 3; driftCount(); CountDrift = 2;
}
}
if(CountDrift == 2 && CountingDrift <= 0)
{
}
}
}

//=[RaceCount`s]==========================================
forward RaceCount();
public RaceCount()
{
new string[256];
if(CountingRace == 30)
{
format(string,sizeof(string),"[Players: %d] if you want to do fun please doing /races join - (Race TYPE: Car).",RacePlayers);
SendClientMessageToAll(COLOR_WHITE,string);
}
else if(CountingRace == 15)
{
format(string,sizeof(string),"[Players: %d] if you want to do fun please doing /races join - (Race TYPE: Car).",RacePlayers);
SendClientMessageToAll(COLOR_WHITE,string);
}
new String[256];
format(String, 256,"~w~ %d:",CountingRace);
for(new i = 0; i < MAX_PLAYERS; i++)
GameTextForAll(String,1000,6);
if(CountingRace > 0)
{
--CountingRace;
SetTimer("RaceCount", 1000, 0);
}
else
{
if(CountRace == 1)
{
if(knoobk == 1)
{
CountingRace = 3; RaceCount(); CountRace = 2;
}
}
if(CountRace == 2 && CountingRace <= 0)
{
}
}
}
//=[New`sRunings`s]=============================================
new CountingRun;
new RunCount;
//=[StartRun]====================================================
forward StartRun();
public StartRun()
{
new string[256];
SendClientMessageToAll(COLOR_WHITE,"[_____________גאטר - טריאטלון_____________]");
SendClientMessageToAll(0xF6F658FF, "! נפתחה הרשמה לתחרות ריצה,שחיה,ואופנעיים, הזדרזו להירשם");
format(string,sizeof(string),".$3000:המנצח יזכה בפרס כספי של");
SendClientMessageToAll(0xF6F658FF,string);
SendClientMessageToAll(0x0F6A0FF, "/Tria :יש לכם 60 שניות להצטרף, להצטרפות רשמו");
SendClientMessageToAll(COLOR_WHITE,"----------------------------------");
CountingRun = 60; RunCounts(); RunCount = 1;
return 1;
}
//=[CountRaning`s]================================================
forward RunCounts();
public RunCounts()
{
new string[256];
if(CountingRun == 30)
{
format(string,sizeof(string),"[Players: %d] if you want to do fun please doing /Tria - (Race TYPE: Run).",RunPlayers);
SendClientMessageToAll(COLOR_WHITE,string);
}
else if(CountingRun == 15)
{
format(string,sizeof(string),"[Players: %d] if you want to do fun please doing /Tria - (Race TYPE: Run).",RunPlayers);
SendClientMessageToAll(COLOR_WHITE,string);
}

new String[256];
format(String, 256,"~w~ %d",CountingRun);
for(new i = 0; i < MAX_PLAYERS; i++)
GameTextForAll(String,1000,6);
if(CountingRun > 0)
{
--CountingRun;
SetTimer("RunCounts", 1000, 0);
}
else
{
if(RunCount == 1)
{
if(knoobk == 1)
{
CountingRun = 3; RunCounts(); RunCount = 2;
}
}
if(RunCount == 2 && CountingRun <= 0)
{
}
}
}
//=[Gate`s]=============================================================
forward GateMove();
public GateMove()
{
if(IsAnyoneNearGate())
{
MoveObject(gateb,2146.19,1627.1,994.257,1.5);
}
else
{
MoveObject(gateb,2144.19,1627.1,994.257,1.5);
}
}
//=[NearGate`s]===================================================
forward IsAnyoneNearGate();
public IsAnyoneNearGate()
{
for(new i=0;i<MAX_PLAYERS;i++)
{
if(IsPlayerConnected(i))
{
if(PlayerToPoint(5.0,i,2144.19000,1627.10000,994.25700))
{
return 1;
}
}
}
return 0;
}
//=[ReturnID]===================================================================
/*
	native ReturnID(text[], playerid = INVALID_PLAYER_ID);
	* "utils.inc" programmers's "ReturnUser" funcation (with changes)
*/
stock ReturnID(text[], playerid = INVALID_PLAYER_ID)
{
new pos = 0;
while(text[pos] < 0x21)
{
if(text[pos] == 0)
return INVALID_PLAYER_ID;
pos++;
}
new userid = INVALID_PLAYER_ID;
if(IsNumeric(text[pos]))
{
userid = strval(text[pos]);
if(userid >= 0 && userid < GetMaxPlayers())
{
if(!IsPlayerConnected(userid))
userid = INVALID_PLAYER_ID;
else
return userid;
}
}
new len = strlen(text[pos]);
new count = 0;
new name[MAX_PLAYER_NAME];
for(new i = 0; i < MAX_PLAYERS; i++)
{
if(IsPlayerConnected(i))
{
GetPlayerName(i,name,sizeof(name));
if(strcmp(name,text[pos],true,len) == 0)
{
if(len == strlen(name))
return i;
else
count++, userid = i;
}
}
}
if(count != 1)
{
if(playerid != INVALID_PLAYER_ID)
{
if(count)
SendClientMessage(playerid,WHITE,".איידי שגוי");
else
SendClientMessage(playerid,WHITE,".לא נמצא");
}
userid = INVALID_PLAYER_ID;
}
return userid;
}
//--
//=[GetName]====================================================================
/*
	native GetName(playerid);
*/
stock GetName(playerid)
{
new Name[MAX_PLAYER_NAME];
GetPlayerName(playerid,Name,sizeof(Name));
return Name;
}
//=[IsPlayerLogged]=============================================================
/*
	native IsPlayerLogged(playerid);
*/
stock IsPlayerLogged(playerid) return (PlayerInfo[playerid][Logged]? 1 : 0);
//=[GetIP]======================================================================
/*
	native GetIP(playerid);
*/
stock GetIP(playerid)
{
new IP[16];
GetPlayerIp(playerid,IP,sizeof(IP));
return IP;
}
//=[GetPlayerFile]==============================================================
/*
   native GetPlayerFile(playerid);
*/
stock GetPlayerFile(playerid)
{
new string[256];
format(string,sizeof(string),"RLSB/Users/%s.ini",GetName(playerid));
return string;
}
//=[CreateLoadConfig]===========================================================
/*
	native CreateLoadConfig();
*/
stock CreateLoadConfig()
{
#define ConfigFile "RLSB/Config.cfg"
if(!dini_Exists(ConfigFile))
{
dini_Create(ConfigFile);
dini_IntSet(ConfigFile,"MinPasswordLength",3);
dini_IntSet(ConfigFile,"MaxPasswordLength",30);
dini_IntSet(ConfigFile,"MaxFailedLogins",4);
dini_IntSet(ConfigFile,"register",0);
dini_IntSet(ConfigFile,"login",0);
dini_IntSet(ConfigFile,"changenick",0);
dini_IntSet(ConfigFile,"changepass",0);

}
#undef ConfigFile
ReadOption_Int(MinPasswordLength);
ReadOption_Int(MaxPasswordLength);
ReadOption_Int(MinPasswordLength);
ReadCMD(register);
ReadCMD(login);
ReadCMD(changenick);
return 1;
}
//=[IsNumeric]==================================================================
/*
	native IsNumeric(string[]);
*/
stock IsNumeric(string[])
{
for(new i=0;i<strlen(string);i++)
if(string[i] > '9' || string[i] < '0')
return 0;
return 1;
}

//=[RegisterPlayer]================================================================
/*
	native RegisterPlayer(playerid,password[]);
*/
RegisterPlayer(playerid,password[])
{
new File:f, date[3], time[3], string[256];

if(fexist(GetPlayerFile(playerid)))
{
getdate(date[0],date[1],date[2]);
gettime(time[0],time[1],time[2]);
f = fopen(GetPlayerFile(playerid),io_append);
format(string,sizeof(string),"// %s's :חשבון השחקן \r\n",GetName(playerid)); fwrite(f,string);
format(string,sizeof(string),"aKillsnl=%d\r\n",PlayerInfo[playerid][aKillsnl]); fwrite(f,string);
format(string,sizeof(string),"aLevelnl=%d\r\n",PlayerInfo[playerid][aLevelnl]); fwrite(f,string);
format(string,sizeof(string),"Organization=%s\r\n","None"); fwrite(f,string);
format(string,sizeof(string),"Clan=%s\r\n","None."); fwrite(f,string);
format(string,sizeof(string),"Password=%s\r\n",password); fwrite(f,string);
format(string,sizeof(string),"GemelLogin=%d\r\n",PlayerInfo[playerid][GemelLogin]); fwrite(f,string);
format(string,sizeof(string),"KopatGemel=%d\r\n",PlayerInfo[playerid][KopatGemel]); fwrite(f,string);
format(string,sizeof(string),"AggInfo=%d\r\n",PlayerInfo[playerid][AggInfo]); fwrite(f,string);
format(string,sizeof(string),"Level=%d\r\n",PlayerInfo[playerid][Level]); fwrite(f,string);
format(string,sizeof(string),"Tag=%s\r\n","סטלה בייבי"); fwrite(f,string);
format(string,sizeof(string),"Car=%s\r\n","None"); fwrite(f,string);
format(string,sizeof(string),"Logged=%d\r\n",PlayerInfo[playerid][Logged]); fwrite(f,string);
format(string,sizeof(string),"IP=%s\r\n",GetIP(playerid)); fwrite(f,string);
format(string,sizeof(string),"LastConnectIP=%s\r\n",GetIP(playerid)); fwrite(f,string);
format(string,sizeof(string),"State=%s\r\n","Online"); fwrite(f,string);
format(string,sizeof(string),"RegisterationYear=%d\r\n",date[0]); fwrite(f,string);
format(string,sizeof(string),"RegisterationMonth=%d\r\n",date[1]); fwrite(f,string);
format(string,sizeof(string),"RegisterationDay=%d\r\n",date[2]); fwrite(f,string);
format(string,sizeof(string),"RegisterationHour=%d\r\n",time[0]); fwrite(f,string);
format(string,sizeof(string),"RegisterationMinute=%d\r\n",time[1]); fwrite(f,string);
format(string,sizeof(string),"LastConnectYear=%d\r\n",date[0]); fwrite(f,string);
format(string,sizeof(string),"LastConnectMonth=%d\r\n",date[1]); fwrite(f,string);
format(string,sizeof(string),"LastConnectDay=%d\r\n",date[2]); fwrite(f,string);
format(string,sizeof(string),"LastConnectHour=%d\r\n",time[0]); fwrite(f,string);
format(string,sizeof(string),"LastConnectMinute=%d\r\n",time[1]); fwrite(f,string);
format(string,sizeof(string),"Kills=%d\r\n",PlayerInfo[playerid][Kills]); fwrite(f,string);
format(string,sizeof(string),"Deaths=%d\r\n",PlayerInfo[playerid][Deaths]); fwrite(f,string);
format(string,sizeof(string),"Money=%d\r\n",PlayerInfo[playerid][Money]); fwrite(f,string);
format(string,sizeof(string),"Bank=%d\r\n",PlayerInfo[playerid][Bank]); fwrite(f,string);
format(string,sizeof(string),"Wars=%d\r\n",PlayerInfo[playerid][Wars]); fwrite(f,string);
format(string,sizeof(string),"Karts=%d\r\n",PlayerInfo[playerid][Kart]); fwrite(f,string);
format(string,sizeof(string),"MonsterWin=%d\r\n",PlayerInfo[playerid][Monster]); fwrite(f,string);
format(string,sizeof(string),"MiniWin=%d\r\n",PlayerInfo[playerid][MINIGUN]); fwrite(f,string);
format(string,sizeof(string),"RPGWIN=%d\r\n",PlayerInfo[playerid][RPGS]); fwrite(f,string);
format(string,sizeof(string),"mlg=%d\r\n",PlayerInfo[playerid][Mlg]); fwrite(f,string);
format(string,sizeof(string),"Adminl=%d\r\n",PlayerInfo[playerid][AdminsLevel]); fwrite(f,string);
format(string,sizeof(string),"Warning=%d\r\n",PlayerInfo[playerid][Warnings]); fwrite(f,string);
format(string,sizeof(string),"pWeeds=%d\r\n",PlayerInfo[playerid][Weeds]); fwrite(f,string);
format(string,sizeof(string),"armour=%d\r\n",PlayerInfo[playerid][armourT]); fwrite(f,string);
format(string,sizeof(string),"ProfileLogeed=%d\r\n",PlayerInfo[playerid][ProfileLogged]); fwrite(f,string);
format(string,sizeof(string),"VIP=%d\r\n",PlayerInfo[playerid][VIPS]); fwrite(f,string);
format(string,sizeof(string),"CC=%d\r\n",PlayerInfo[playerid][CcMode]); fwrite(f,string);
format(string,sizeof(string),"Supportives=%d\r\n",PlayerInfo[playerid][Supportives]); fwrite(f,string);
format(string,sizeof(string),"Tor=%d\r\n",PlayerInfo[playerid][Tor]); fwrite(f,string);
format(string,sizeof(string),"Dolphin=%d\r\n",PlayerInfo[playerid][Dolp]); fwrite(f,string);
format(string,sizeof(string),"Pets=%d\r\n",PlayerInfo[playerid][Pets]); fwrite(f,string);
format(string,sizeof(string),"Shark=%d\r\n",PlayerInfo[playerid][Shark]); fwrite(f,string);
format(string,sizeof(string),"SharkKills=%d\r\n",PlayerInfo[playerid][SharkKills]); fwrite(f,string);
format(string,sizeof(string),"DolphinKills=%d\r\n",PlayerInfo[playerid][DolphinKills]); fwrite(f,string);
format(string,sizeof(string),"TorKills=%d\r\n",PlayerInfo[playerid][TorKills]); fwrite(f,string);
format(string,sizeof(string),"GetAloan=%d\r\n",PlayerInfo[playerid][GetAloan]); fwrite(f,string);
format(string,sizeof(string),"MoneyLoan=%d\r\n",PlayerInfo[playerid][MoneyLoan]); fwrite(f,string);
format(string,sizeof(string),"bazooka=%d\r\n",PlayerInfo[playerid][bazooka]); fwrite(f,string);
format(string,sizeof(string),"TimeOnServer=%d\r\n",PlayerInfo[playerid][TimeOnServer]); fwrite(f,string);
format(string,sizeof(string),"SavePos=%d\r\n",PlayerInfo[playerid][Saved]); fwrite(f,string);
format(string,sizeof(string),"SavePosX=%.4f\r\n",PlayerInfo[playerid][SPX]); fwrite(f,string);
format(string,sizeof(string),"SavePosY=%.4f\r\n",PlayerInfo[playerid][SPY]); fwrite(f,string);
format(string,sizeof(string),"SavePosZ=%.4f\r\n",PlayerInfo[playerid][SPZ]); fwrite(f,string);
format(string,sizeof(string),"SavePosI=%d\r\n",PlayerInfo[playerid][SPI]); fwrite(f,string);
format(string,sizeof(string),"Saved=%d\r\n",PlayerInfo[playerid][Saved]); fwrite(f,string);
format(string,sizeof(string),"SkinSavedId=%d\r\n",PlayerInfo[playerid][SkinSavedId]); fwrite(f,string);
format(string,sizeof(string),"SaveSkin=%d\r\n",PlayerInfo[playerid][SaveSkin]); fwrite(f,string);
format(string,sizeof(string),"SkinSaved=%d\r\n",PlayerInfo[playerid][SkinSaved]); fwrite(f,string);
format(string,sizeof(string),"SaveStrika=%d\r\n",PlayerInfo[playerid][AirStrikeSaved]); fwrite(f,string);
format(string,sizeof(string),"xAir=%d\r\n",PlayerInfo[playerid][xAirStrike]); fwrite(f,string);
format(string,sizeof(string),"yAir=%d\r\n",PlayerInfo[playerid][yAirStrike]); fwrite(f,string);
format(string,sizeof(string),"zAir=%d\r\n",PlayerInfo[playerid][zAirStrike]); fwrite(f,string);
format(string,sizeof(string),"CarID=%d\r\n",pia[playerid][CarID]); fwrite(f,string);
format(string,sizeof(string),"OwnCar=%d\r\n",pia[playerid][OwnCar]); fwrite(f,string);
format(string,sizeof(string),"Sawn=%d\r\n",PlayerInfo[playerid][Sawn]); fwrite(f,string);
format(string,sizeof(string),"MicroSMG=%d\r\n",PlayerInfo[playerid][MicroSMG]); fwrite(f,string);
format(string,sizeof(string),"Tec9=%d\r\n",PlayerInfo[playerid][Tec9]); fwrite(f,string);
format(string,sizeof(string),"M4=%.4f\r\n",PlayerInfo[playerid][M4]); fwrite(f,string);
format(string,sizeof(string),"MP5=%.4f\r\n",PlayerInfo[playerid][MP5]); fwrite(f,string);
format(string,sizeof(string),"AK47=%.4f\r\n",PlayerInfo[playerid][AK47]); fwrite(f,string);
format(string,sizeof(string),"Knife=%d\r\n",PlayerInfo[playerid][Knife]); fwrite(f,string);
format(string,sizeof(string),"Katana=%d\r\n",PlayerInfo[playerid][Katana]); fwrite(f,string);
format(string,sizeof(string),"CombatShotGun=%d\r\n",PlayerInfo[playerid][CombatShotGun]); fwrite(f,string);
format(string,sizeof(string),"ShotGun=%d\r\n",PlayerInfo[playerid][ShotGun]); fwrite(f,string);
format(string,sizeof(string),"SniperRifle=%d\r\n",PlayerInfo[playerid][SniperRifle]); fwrite(f,string);
format(string,sizeof(string),"CRifle=%d\r\n",PlayerInfo[playerid][CRifle]); fwrite(f,string);
format(string,sizeof(string),"Colt=%d\r\n",PlayerInfo[playerid][Colt]); fwrite(f,string);
fclose(f);
}
return 1;
}
//=[Login`s]================================================================
/*
	native LoginPlayer(playerid);
*/
stock LoginPlayer(playerid)
{
new date[3], time[3];
if(dini_Exists(GetPlayerFile(playerid)))
{
PlayerInfo[playerid][Logged] = 1;
PlayerInfo[playerid][FL] = 0;
getdate(date[0],date[1],date[2]);
gettime(time[0],time[1],time[2]);
PlayerInfo[playerid][KopatGemel] = dini_Int(GetPlayerFile(playerid),"KopatGemel");
PlayerInfo[playerid][GemelLogin] = dini_Int(GetPlayerFile(playerid),"GemelLogin");
PlayerInfo[playerid][AggInfo] = dini_Int(GetPlayerFile(playerid),"AggInfo");
PlayerInfo[playerid][Level] = dini_Int(GetPlayerFile(playerid),"Level");
PlayerInfo[playerid][aKillsnl] = dini_Int(GetPlayerFile(playerid),"aKillsnl");
PlayerInfo[playerid][aLevelnl] = dini_Int(GetPlayerFile(playerid),"aLevelnl");
dini_Set(GetPlayerFile(playerid),"LastConnectIP",GetIP(playerid));
dini_Set(GetPlayerFile(playerid),"State","Online");
dini_IntSet(GetPlayerFile(playerid),"LastConnectYear",date[0]);
dini_IntSet(GetPlayerFile(playerid),"LastConnectMonth",date[1]);
dini_IntSet(GetPlayerFile(playerid),"LastConnectDay",date[2]);
dini_IntSet(GetPlayerFile(playerid),"LastConnectHour",time[0]);
dini_IntSet(GetPlayerFile(playerid),"LastConnectMinute",time[1]);
pia[playerid][CarID] = dini_Int(GetPlayerFile(playerid),"CarID");
pia[playerid][OwnCar] = dini_Int(GetPlayerFile(playerid),"OwnCar");
PlayerInfo[playerid][Kills] = dini_Int(GetPlayerFile(playerid),"Kills");
PlayerInfo[playerid][Deaths] = dini_Int(GetPlayerFile(playerid),"Deaths");
PlayerInfo[playerid][Money] = dini_Int(GetPlayerFile(playerid),"Money");
PlayerInfo[playerid][Bank] = dini_Int(GetPlayerFile(playerid),"Bank");
PlayerInfo[playerid][Wars] = dini_Int(GetPlayerFile(playerid),"Wars");
PlayerInfo[playerid][Kart] = dini_Int(GetPlayerFile(playerid),"Karts");
PlayerInfo[playerid][Monster] = dini_Int(GetPlayerFile(playerid),"MonsterWin");
PlayerInfo[playerid][RPGS] = dini_Int(GetPlayerFile(playerid),"RPGWIN");
PlayerInfo[playerid][MINIGUN] = dini_Int(GetPlayerFile(playerid),"MiniWin");
PlayerInfo[playerid][Mlg] = dini_Int(GetPlayerFile(playerid),"mlg");
PlayerInfo[playerid][CcMode] = dini_Int(GetPlayerFile(playerid),"CC");
PlayerInfo[playerid][Supportives] = dini_Int(GetPlayerFile(playerid),"Supportives");
PlayerInfo[playerid][Tor] = dini_Int(GetPlayerFile(playerid),"Tor");
PlayerInfo[playerid][Dolp] = dini_Int(GetPlayerFile(playerid),"Dolphin");
PlayerInfo[playerid][Pets] = dini_Int(GetPlayerFile(playerid),"Pets");
PlayerInfo[playerid][Shark] = dini_Int(GetPlayerFile(playerid),"Shark");
PlayerInfo[playerid][SharkKills] = dini_Int(GetPlayerFile(playerid),"SharkKills");
PlayerInfo[playerid][TorKills] = dini_Int(GetPlayerFile(playerid),"TorKills");
PlayerInfo[playerid][DolphinKills] = dini_Int(GetPlayerFile(playerid),"DolphinKills");
PlayerInfo[playerid][AdminsLevel] = dini_Int(GetPlayerFile(playerid),"Adminl");
PlayerInfo[playerid][Warnings] = dini_Int(GetPlayerFile(playerid),"Warning");
PlayerInfo[playerid][Weeds] = dini_Int(GetPlayerFile(playerid),"pWeeds");
PlayerInfo[playerid][bazooka] = dini_Int(GetPlayerFile(playerid),"bazooka");
PlayerInfo[playerid][TimeOnServer] = dini_Int(GetPlayerFile(playerid),"TimeOnServer");
LACY_GiveMoney(playerid,PlayerInfo[playerid][Money]);
PlayerInfo[playerid][Saved] = dini_Int(GetPlayerFile(playerid),"SavePos");
PlayerInfo[playerid][SPX] = dini_Float(GetPlayerFile(playerid),"SavePosX");
PlayerInfo[playerid][SPY] = dini_Float(GetPlayerFile(playerid),"SavePosY");
PlayerInfo[playerid][SPZ] = dini_Float(GetPlayerFile(playerid),"SavePosZ");
PlayerInfo[playerid][SPI] = dini_Int(GetPlayerFile(playerid),"SavePosI");
PlayerInfo[playerid][SkinSavedId] = dini_Int(GetPlayerFile(playerid),"SkinSavedId");
PlayerInfo[playerid][SkinSaved] = dini_Int(GetPlayerFile(playerid),"SkinSaved");
PlayerInfo[playerid][SaveSkin] = dini_Int(GetPlayerFile(playerid),"SaveSkin");
PlayerInfo[playerid][autologin] = dini_Int(GetPlayerFile(playerid),"autologins");
PlayerInfo[playerid][GetAloan] = dini_Int(GetPlayerFile(playerid),"GetAloan");
PlayerInfo[playerid][MoneyLoan] = dini_Int(GetPlayerFile(playerid),"MoneyLoan");
PlayerInfo[playerid][VIPS] = dini_Int(GetPlayerFile(playerid),"VIP");
PlayerInfo[playerid][armourT] = dini_Int(GetPlayerFile(playerid),"armour");
PlayerInfo[playerid][ProfileLogged] = dini_Int(GetPlayerFile(playerid),"ProfileLogeed");
PlayerInfo[playerid][AirStrikeSaved] = dini_Int(GetPlayerFile(playerid),"SaveStrika");
PlayerInfo[playerid][xAirStrike] = dini_Int(GetPlayerFile(playerid),"xAir");
PlayerInfo[playerid][yAirStrike] = dini_Int(GetPlayerFile(playerid),"yAir");
PlayerInfo[playerid][zAirStrike] = dini_Int(GetPlayerFile(playerid),"zAir");
PlayerInfo[playerid][Sawn] = dini_Int(GetPlayerFile(playerid),"Sawn");
PlayerInfo[playerid][MicroSMG] = dini_Int(GetPlayerFile(playerid),"MicroSMG");
PlayerInfo[playerid][Tec9] = dini_Int(GetPlayerFile(playerid),"Tec9");
PlayerInfo[playerid][M4] = dini_Int(GetPlayerFile(playerid),"M4");
PlayerInfo[playerid][MP5] = dini_Int(GetPlayerFile(playerid),"MP5");
PlayerInfo[playerid][AK47] = dini_Int(GetPlayerFile(playerid),"AK47");
PlayerInfo[playerid][Knife] = dini_Int(GetPlayerFile(playerid),"Knife");
PlayerInfo[playerid][Katana] = dini_Int(GetPlayerFile(playerid),"Katana");
PlayerInfo[playerid][CombatShotGun] = dini_Int(GetPlayerFile(playerid),"CombatShotGun");
PlayerInfo[playerid][ShotGun] = dini_Int(GetPlayerFile(playerid),"ShotGun");
PlayerInfo[playerid][SniperRifle] = dini_Int(GetPlayerFile(playerid),"SniperRifle");
PlayerInfo[playerid][CRifle] = dini_Int(GetPlayerFile(playerid),"CRifle");
PlayerInfo[playerid][Colt] = dini_Int(GetPlayerFile(playerid),"Colt");


PlayerProps[playerid] = 0;
EarningsForPlayer[playerid] = 0;
new pName[MAX_PLAYER_NAME];
GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
for(new propid; propid < PropertiesAmount; propid++)
{
if(PropInfo[propid][PropIsBought] == 1)
{
if(strcmp(PropInfo[propid][PropOwner], pName, true)==0)
{
EarningsForPlayer[playerid] += PropInfo[propid][PropEarning];
PlayerProps[playerid]++;
}
}
}
}
return 1;
}
//=[TeleCar`s]========================================
forward TeleCar(playerid);
public TeleCar(playerid)
{
new car = pia[playerid][CarID];
PutPlayerInVehicle(playerid, car, 0);
GetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
SetPlayerCameraPos(playerid, Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
SetPlayerCameraLookAt(playerid, Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
SetVehiclePos(car,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
GetVehicleZAngle(GetPlayerVehicleID(playerid), Angle[playerid]);
//if(IsPlayerInAnyVehicle(playerid)) SetVehiclePos(GetPlayerVehicleID(playerid), Pos[playerid][0], Pos[playerid][1], Pos[playerid][2]+0.5);
//SetVehicleZAngle(GetPlayerVehicleID(playerid), Angle[playerid]);
SetCameraBehindPlayer(playerid);
}
//=[RepairCAR]========================================
forward RepairCar(playerid);
public RepairCar(playerid)
{
if(IsPlayerInAnyVehicle(playerid)) SetVehiclePos(GetPlayerVehicleID(playerid), Pos[playerid][0], Pos[playerid][1], Pos[playerid][2]+0.5);
SetVehicleZAngle(GetPlayerVehicleID(playerid), Angle[playerid]);
SetCameraBehindPlayer(playerid);
}
//=[ActualizarMemoriaSalida]========================================
ActualizarMemoriaSalida(playerid,otroplayerid)
{
for (new i=4;i>0;i--)
{
MemorySalida[playerid][i][numero_telefono]=MemorySalida[playerid][i-1][numero_telefono];
format(MemorySalida[playerid][i][Nombre],MAX_PLAYER_NAME,"%s",MemorySalida[playerid][i-1][Nombre]);
MemorySalida[playerid][i][costo]=MemorySalida[playerid][i-1][costo];
}
MemorySalida[playerid][0][numero_telefono]=Numero_Tel[otroplayerid];
GetPlayerName(otroplayerid,MemorySalida[playerid][0][Nombre],MAX_PLAYER_NAME);
MemorySalida[playerid][0][costo]=CellTime[playerid]*PRECIO_FICHA;
return 1;
}
//=[ActualizarMemoriaEntrada]========================================
ActualizarMemoriaEntrada(playerid,otroplayerid)
{
for (new i=4;i>0;i--)
{
MemoryEntrada[playerid][i][numero_telefono2]=MemoryEntrada[playerid][i-1][numero_telefono2];
format(MemoryEntrada[playerid][i][Nombre2],MAX_PLAYER_NAME,"%s",MemoryEntrada[playerid][i-1][Nombre2]);
}
MemoryEntrada[playerid][0][numero_telefono2]=Numero_Tel[otroplayerid];
GetPlayerName(otroplayerid,MemoryEntrada[playerid][0][Nombre2],MAX_PLAYER_NAME);
return 1;
}
//=[Borrar]=============================================================
borrarMemorias(playerid)
{
for (new i=0;i<5;i++)
{
MemoryEntrada[playerid][i][numero_telefono2]=0;
MemorySalida[playerid][i][numero_telefono]=0;
SMSRecibidos[playerid][i][numeroSMS2]=0;
SMSEnviados[playerid][i][numeroSMS1]=0;
}
return 1;
}
//=[CWarningsplayers]======================================
forward CWarnings();
public CWarnings() {

for(new i;i<MAX_PLAYERS;i++)
{
if(IsPlayerConnected(i))
{

if (PlayerInfo[i][Warnings] >=10)
{
Kick(i);
}
}
}
return 1;
}
//=[IsNumber]=================================================
forward IsNumber(string[]);
public IsNumber(string[])
{
for(new i=0,j=strlen(string); i<j;i++)
{
if(string[i] > '9' || string[i] < '5')
{
return 0;
}
}
return 1;
}

//=[LOANBANK`S]===========================================
forward loan();
public loan()
{
for(new i=0; i<MAX_PLAYERS; i++)
{
if(PlayerInfo[i][GetAloan] ==0) return 0;
if(PlayerInfo[i][GetAloan] ==1) {
new string[256];
PlayerInfo[i][MoneyLoan] +=200;
format(string, sizeof(string),"%d :הבנק לוחץ עליך אתה חייב להחזיר כסף לבנק בסכום של",PlayerInfo[i][MoneyLoan]),SendClientMessage(i,WHITE,string),SendClientMessage(i,WHITE,".כדאי לך להחזיר מהר הבנק מעלה כל פעם תחוב ב200 דולר");
}
}
return 1;
}
//=[UNFREEZE+Start`s]=============================================
forward UnFreezeRace();
public UnFreezeRace()
{
for(new i=0; i<MAX_PLAYERS; i++)
{
if(RacePlayers < 1)
{
SendClientMessage(i,WHITE,"המירוץ בוטל סיבה: מספר שחקנים פחות מ-1");
RaceEnd =0;
WinnerRace=0;
RacePlayers=0;
IFraceOn=0;
if(Youregisterrace[i] ==1)
{
DisablePlayerRaceCheckpoint(i);
TogglePlayerControllable(i,1);
LACY_GiveMoney(i,500);
SendClientMessage(i,WHITE,".קיבלת פיצוי של 500 דולר בגלל ביטול המירוץ");
}
}
EndSytems= SetTimer("UnSystemRace",3000,1);
new string[256];
SendClientMessage(i,COLOR_WHITE,"[______________מירוץ מאורגן - מכוניות______________]");
format(string,sizeof(string)," %d :מס' משתתפים",RacePlayers),SendClientMessage(i,0xE21E1EFF,string);
SendClientMessage(i,0xE21E1EFF,"המנצח יקבל סכום מכובד של 3000$");
SendClientMessage(i,COLOR_WHITE,"---------------------------------------");
TogglePlayerControllable(i,1);
RaceEnd=1;
}
return 1;
}
//=[Race`sEND]==================================================
forward UnSystemRace();
public UnSystemRace(){

if(RaceEnd ==0) return KillTimer(EndSytems);
if(RacePlayers < 1) {
for(new i=0; i<MAX_PLAYERS; i++)
{
SendClientMessage(i,WHITE,".המירוץ בוטל בגלל שכל הרכבים של המשתתפים התפוצצו / הם יצאו מהרכבים שלהם / חוסר משתתפים");
KillTimer(EndSytems);
RaceEnd =0;
WinnerRace=0;
RacePlayers=0;
IFraceOn=0;
if(Youregisterrace[i] ==1)
{
DisablePlayerRaceCheckpoint(i);
TogglePlayerControllable(i,1);
}
}
}
return 1;
}
//=[START+Unfreze]================================================
forward UnFreezeDrift();
public UnFreezeDrift(){
for(new i=0; i<MAX_PLAYERS; i++)
{
if(DriftPlayer < 1)
{
SendClientMessage(i,WHITE,"המירוץ דריפטים בוטל סיבה: בגלל שמספר השחקנים קטן מ-1");
DriftEnd =0;
WinnerDrift=0;
DriftPlayer=0;
IFDriftOn=0;
YouRegister[i] =0;
TogglePlayerControllable(i,1);
if(YouRegister[i]==1)
{
new vehicleid = GetPlayerVehicleID(i);
SetPlayerVirtualWorld(i,0);
SetVehicleVirtualWorld(vehicleid,0);
DisablePlayerRaceCheckpoint(i);
LACY_GiveMoney(i,500);
SendClientMessage(i,WHITE,".קיבלת פיצוי של 500 דולר בגלל ביטול הדריפט");
}
}
UnSystems = SetTimer("UnSystem",3000,1);
new string[256];
TogglePlayerControllable(i,1);
DriftEnd=1;

SendClientMessage(i,COLOR_WHITE,"[______________מירוץ מאורגן - דריפט______________]");
format(string,sizeof(string)," %d :מס' משתתפים",DriftPlayer),SendClientMessage(i,0xE21E1EFF,string);
SendClientMessage(i,0xE21E1EFF,"המנצח יקבל סכום מכובד של 3000$");
SendClientMessage(i,COLOR_WHITE,"---------------------------------------");
}
return 1;
}
//=[ENDDrift]=======================================================
forward UnSystem();
public UnSystem(){
for(new i=0; i<MAX_PLAYERS; i++)
{
if(DriftEnd ==0) return KillTimer(UnSystems);
if(DriftPlayer == 0)
{
SendClientMessage(i,WHITE,".המירוץ בוטל בגלל פרישה של יותר מידי שחקנים-");
DriftEnd =0;
WinnerDrift=0;
DriftPlayer=0;
IFDriftOn=0;
if(YouRegister[i] == 1)
{
new vehicleid = GetPlayerVehicleID(i);
SetPlayerVirtualWorld(i,0);
SetVehicleVirtualWorld(vehicleid,0);
YouRegister[i] =0;
TogglePlayerControllable(i,1);
KillTimer(UnSystems);
}
}
}
return 1;
}
//=[CheackCar]=====================================================
stock IsVehicle(playerid)
{
new wqewqe = GetPlayerVehicleID(playerid);
wqewqe = GetVehicleModel(wqewqe);
if(wqewqe == 451)
return 1;
else
return 0;
}
stock IsBike(playerid)
{
new ssssssssssssss = GetPlayerVehicleID(playerid);
ssssssssssssss = GetVehicleModel(ssssssssssssss);
if(ssssssssssssss == 522)
return 1;
else
return 0;
}
//=[UpdatePlayer`s]===================================================
/*
forward OnPlayerUpdate(playerid);
public OnPlayerUpdate(playerid)
{
gLastUpdate[playerid] = GetTickCount();
gState[playerid] = e_STATE_UPDATING;
return 1;
}
//=[AutoOutSystem`s(`Esc`)]============================================
public KickUpdate()
{
new time = GetTickCount() - MAX_AFK_TIME;
for (new i = 0; i < MAX_PLAYERS; i++)
{
if (gState[i] == e_STATE_UPDATING && time >= gLastUpdate[i])
{
if(Registertrs[i] ==1)
{
CPTriatlon[i]=0,DisablePlayerRaceCheckpoint(i),Registertrs[i] =0,CPTriatlon[i]=0,RunPlayers--;
SendClientMessage(i, 0xFF0000AA, ".הוצאת מהפעילות שהייתה בא אוטומאטית");
SetPlayerVirtualWorld(i,0);
if(IsPlayerInAnyVehicle(i))
{
RemovePlayerFromVehicle(i);
SpawnPlayer(i);
}
if(!IsPlayerInAnyVehicle(i))
{
SpawnPlayer(i);
}
SetPlayerPos(i,2057.0664,843.0209,6.7031);
SetPlayerFacingAngle(i,357.5948);
}
if(YouRegister[i] ==1)
{
YouRegister[i] =0,DisablePlayerRaceCheckpoint(i),DriftPlayer--;
SendClientMessage(i, 0xFF0000AA, ".הוצאת מהפעילות שהייתה בא אוטומאטית");
SetPlayerVirtualWorld(i,0);
if(IsPlayerInAnyVehicle(i))
{
RemovePlayerFromVehicle(i);
SpawnPlayer(i);
}
if(!IsPlayerInAnyVehicle(i))
{
SpawnPlayer(i);
}
SetPlayerPos(i,2057.0664,843.0209,6.7031);
SetPlayerFacingAngle(i,357.5948);
}
if(Youregisterrace[i] ==1)
{
Youregisterrace[i] =0,RacePlayers--,DisablePlayerRaceCheckpoint(i);
SendClientMessage(i, 0xFF0000AA, ".הוצאת מהפעילות שהייתה בא אוטומאטית");
SetPlayerVirtualWorld(i,0);
if(IsPlayerInAnyVehicle(i))
{
RemovePlayerFromVehicle(i);
SpawnPlayer(i);
}
if(!IsPlayerInAnyVehicle(i))
{
SpawnPlayer(i);
}
SetPlayerPos(i,2057.0664,843.0209,6.7031);
SetPlayerFacingAngle(i,357.5948);
}
if(PPw[i] == 1)
{
ResetPlayerWeapons(i);
SendClientMessage(i,WHITE,".עזבת את הפעילות שבא הייתה");
WarPlayersw --; InWarw[i] = 0; PPw[i] = 0;
SetPlayerVirtualWorld(i,0);
if(IsPlayerInAnyVehicle(i))
{
RemovePlayerFromVehicle(i);
SpawnPlayer(i);
}
if(!IsPlayerInAnyVehicle(i))
{
SpawnPlayer(i);
}
SetPlayerPos(i,2057.0664,843.0209,6.7031);
SetPlayerFacingAngle(i,357.5948);
}
if(PP[i] == 1)
{
ResetPlayerWeapons(i);
SendClientMessage(i,WHITE,".עזבת את הפעילות שבא הייתה");
WarPlayers --;
InWar[i] = 0;
PP[i] = 0;
SetPlayerVirtualWorld(i,0);
if(IsPlayerInAnyVehicle(i))
{
RemovePlayerFromVehicle(i);
SpawnPlayer(i);
}
if(!IsPlayerInAnyVehicle(i))
{
SpawnPlayer(i);
}
SetPlayerPos(i,2057.0664,843.0209,6.7031);
SetPlayerFacingAngle(i,357.5948);
}
if(PPr[i] == 1)
{
ResetPlayerWeapons(i);
SendClientMessage(i,WHITE,".עזבת את הפעילות שבא הייתה");
WarPlayersr --; InWarr[i] = 0; PPr[i] = 0;
SetPlayerVirtualWorld(i,0);
if(IsPlayerInAnyVehicle(i))
{
RemovePlayerFromVehicle(i);
SpawnPlayer(i);
}
if(!IsPlayerInAnyVehicle(i))
{
SpawnPlayer(i);
}
SetPlayerPos(i,2057.0664,843.0209,6.7031);
SetPlayerFacingAngle(i,357.5948);
}
}
}
}
*/
//=[SplitAge]=========================================[`Profile`]
forward split(const strsrc[], strdest[][], delimiter);
public split(const strsrc[], strdest[][], delimiter)
{
new i, li;
new aNum;
new len;
while(i <= strlen(strsrc))
{
if(strsrc[i]==delimiter || i==strlen(strsrc))
{
len = strmid(strdest[aNum], strsrc, li, i, 128);
strdest[aNum][len] = 0;
li = i+1;
aNum++;
}
i++;
}
return 1;
}
//=[ChangeHostName]==================================[/`AUTO`]
/*
public AutoChangeHN()
{
if(changehn == 1)
{
changehn = 2;
SendRconCommand("hostname Satla-Zone.co.il • Hard`s, DeatchMatch.");
SetGameModeText("DeatchMatch • World..");
return 1;
}
else if(changehn == 2)
{
changehn = 1;
SendRconCommand("hostname Satla-Zone.co.il • Isreal, DeatchMatch");
SetGameModeText("DeatchMatch • Zone.");
return 1;
}
return 1;
}
*/
//=[DubleGEMEL]====================================
/*
forward CafolMoneyGemel(playerid);
public CafolMoneyGemel(playerid)
{
if(PlayerInfo[playerid][KopatGemel] ==0) return 0;
if(PlayerInfo[playerid][KopatGemel]  > 0 || PlayerInfo[playerid][GemelLogin] > 1000)
{
new string[256];
PlayerInfo[playerid][GemelLogin]+=PlayerInfo[playerid][GemelLogin]-800;
format(string, sizeof(string),".%d הקופת גמל הכפילה לך תסכום בהשקעה ל",PlayerInfo[playerid][GemelLogin]),SendClientMessage(playerid,0xF6F658FF,string);
}
return 1;
}
*/
//=[CheckHacker`s]==================================
#if MONEY_CHEAT_USE
public moneycheat_check()
{
for(new playerid=0; playerid <= MAX_PLAYERS; playerid++)
{
if(IsPlayerConnected(playerid))
{
money[playerid] = GetPlayerMoney(playerid);
moneycheat_warnings[playerid][1]++;
if(money[playerid]-LACY_MoneyCheat_Allow_Get(playerid)  > moneycheat_lastamount[playerid])
moneycheat_warnings[playerid][0]++;
if(moneycheat_warnings[playerid][1] == MONEY_CHEAT_WARNINGS)
{
if(moneycheat_warnings[playerid][0] == MONEY_CHEAT_WARNINGS)
{
Kicked[playerid] = 2; Punishplayer(playerid, "Money Hack.", MONEY_CHEAT_PUNISH);
}
moneycheat_warnings[playerid][1] = 0;
moneycheat_warnings[playerid][0] = 0;
}
if(moneycheat_lastamount[playerid] + LACY_MoneyCheat_Allow_Get(playerid) == money[playerid])
LACY_MoneyCheat_Delete(playerid);
moneycheat_lastamount[playerid] = money[playerid];
}
}
}
#endif
//=[Punish_On_C]================================
Punishplayer(playerid, str[], punish)
{
if(IsPlayerXAdmin(playerid)) return 0;
if(!IsPlayerConnected(playerid))
return true;
new tmp[256];
GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
switch(punish)
{
case 2:
{

ResetPlayerMoney(playerid);
SendClientMessage(playerid,red,"Money Hack. מערכת האנטי צ'יט זיההתה אצלך, צ'יט מסוג");
SendClientMessage(playerid,red,".כעת תוצא מהשרת,במידה זה יחזור עליו שנית, יש סיכוי להרחקה מהשרת");
format(tmp, 256, "[AntiCheat] %s has been kicked for using %s", playername,str);
SendClientMessageToAll(red, tmp);
Kick(playerid);
}
}
SetPlayerVars(playerid);
return true;
}
//=[DoNoramlAC]=========================================
SetPlayerVars(playerid)
{
#if MONEY_CHEAT_USE
moneycheat_warnings[playerid] = {0, 0};
moneycheat_lastamount[playerid] = 99999999;
money[playerid] = 0;
#endif
Kicked[playerid] = 0;
LACY_MoneyCheat_Delete(playerid);
return 1;
}
//=[DistancePoint]/V]===================================
stock GetPlayerDistanceToPoint(playerid,Float:x,Float:y)
{
new Float:x1,Float:y1,Float:z1;
new Float:tmpdis;
GetPlayerPos(playerid,x1,y1,z1);
tmpdis = floatsqroot(floatpower(floatabs(floatsub(x,x1)),2)+floatpower(floatabs(floatsub(y,y1)),2));
return floatround(tmpdis);
}
//=[Allow_Get]===========================================
LACY_MoneyCheat_Allow_Get(playerid)
{
new tmpname[256];
format(tmpname, 256, "LACY_MoneyCheat_Allow_%d", playerid);
if(existproperty(13, "", adler32hash(tmpname)))
{
new tmp;
new value[255];
getproperty(13, "", adler32hash(tmpname), value);
strunpack(value,value);
tmp = strval(value);

return tmp;
}
return 0;
}
//=[DeleteMc]=============================================
LACY_MoneyCheat_Delete(playerid)
{
new tmpname[256];
format(tmpname, 256, "LACY_MoneyCheat_Allow_%d", playerid);
if(existproperty(13, "", adler32hash(tmpname)))
{
deleteproperty(13, "", adler32hash(tmpname));
}
}
//=[AllowMoney]============================================
forward LACY_MoneyCheat_Allow(playerid, amount1);
public LACY_MoneyCheat_Allow(playerid, amount1)
{
new tmpname[256];
new amount[256];
format(tmpname, 256, "LACY_MoneyCheat_Allow_%d", playerid);
if(existproperty(13, "", adler32hash(tmpname)))
{
new tmp;
new value[255];
getproperty(13, "", adler32hash(tmpname), value);
strunpack(value,value);
tmp = strval(value);
amount1 = amount1+tmp;
format(amount, 256, "%d", amount1);
deleteproperty(13, "", adler32hash(tmpname));
setproperty(13, "", adler32hash(tmpname), amount);
}
else
{
format(amount, 256, "%d", amount1);
setproperty(13, "", adler32hash(tmpname), amount);
}
}
//=[HidePassword]============================================
adler32hash(buf[])
{
new length=strlen(buf);
new s1 = 1;
new s2 = 0;
new n;
for (n=0; n<length; n++)
{
s1 = (s1 + buf[n]) % 65521;
s2 = (s2 + s1)     % 65521;
}
return (s2 << 16) + s1;
}
//=[LACY_GiveMoney-Function]===============================
forward LACY_GiveMoney(playerid, amount);
public LACY_GiveMoney(playerid, amount)
{
if(amount > 0)
LACY_MoneyCheat_Allow(playerid, amount);
GivePlayerMoney(playerid, amount);
}
//=[Ban`sxadmin]===============================================
stock xAdminBan(playerid,reason[])
{
new tnd[128],day,month,year,hour,minute,second,hour_tf[3],minute_tf[3],second_tf[3];
getdate(year,month,day); gettime(hour,minute,second);
if (hour <= 9) format(hour_tf,3,"0%d",hour); else format(hour_tf,3,"%d",hour);
if (minute <= 9) format(minute_tf,3,"0%d",minute); else format(minute_tf,3,"%d",minute);
if (second <= 9) format(second_tf,3,"0%d",second); else format(second_tf,3,"%d",second);
format(tnd,128,"%d.%d.%d | %s:%s:%s",day,month,year,hour_tf,minute_tf,second_tf);
new string[256],name[24],ip[20]; GetPlayerName(playerid,name,24); GetPlayerIp(playerid,ip,20);
new fileline[256], File:log = (fexist("xadmin/bans.log")) ? fopen("xadmin/bans.log", io_append) : fopen("xadmin/bans.log", io_write);
format(fileline, 256, "[BanSystem] [%s] banned %s (%d) [Reason: %s]\r\n",tnd,name,playerid,reason);
fwrite(log,fileline); fclose(log);
format(string,700,"[BanSystem]  (Time & Date: %s) (IP: %s) [Reason: %s]\r\n :הורחקת מהשרת סיבה",tnd,ip,reason);
SendClientMessage(playerid,WHITE,string);
new IpBanFile[128], BanFile[128];
format(BanFile, 128, "xadmin/Bans/Names/%s.ini", name); format(IpBanFile, 128, "xadmin/Bans/IP/%s.ini", ip);
if (dini_Exists(BanFile) || dini_Exists(IpBanFile)) return false;
dini_Create(BanFile);
dini_Set(BanFile, "Admin", "[BanSystem]");
dini_Set(BanFile, "IP", ip);
dini_Set(BanFile, "Reason", reason);
dini_Set(BanFile, "TND", tnd);
dini_Create(IpBanFile);
dini_Set(IpBanFile, "Admin", "[BanSystem]");
dini_Set(IpBanFile, "PlayerName", name);
dini_Set(IpBanFile, "Reason", reason);
dini_Set(IpBanFile, "TND", tnd);
new mode_file[256];
format(mode_file,sizeof(mode_file), "SatlaZone/%s.ini",name);
dini_IntSet(mode_file,"IsBanned",1);
TogglePlayerControllable(playerid,false);
return Kick(playerid);


}

forward UnFreezeTriatlon();
public UnFreezeTriatlon(){
for(new i=0; i<MAX_PLAYERS; i++)
{
if(RunPlayers < 4)
{
SendClientMessage(i,WHITE,".הטריאטלון בוטל סיבה מספר משתתפים נמוך מ-4");
RunSystemend =0;
RunPlayers=0;
RunSystemon=0;
if(Registertrs[i] ==1)
{
DisablePlayerRaceCheckpoint(i);
TogglePlayerControllable(i,1);
}
}
new string[256];
EndSystemTriatlon= SetTimer("EndSystemTriatlon2",3000,1);
SendClientMessage(i,COLOR_WHITE,"[______________מירוץ מאורגן - טריאטלון______________]");
format(string,sizeof(string)," %d :מס' משתתפים",RunPlayers),SendClientMessage(i,0xE21E1EFF,string);
SendClientMessage(i,0xE21E1EFF,"המנצח יקבל סכום מכובד של 3000$");
SendClientMessage(i,COLOR_WHITE,"---------------------------------------");

TogglePlayerControllable(i,1);
RaceEnd=1;
}
return 1;
}


forward EndSystemTriatlon2();
public EndSystemTriatlon2()
{
if(RunSystemend ==0) return KillTimer(EndSystemTriatlon);
if(RunPlayers ==0)
{
for(new i=0; i<MAX_PLAYERS; i++)
{
SendClientMessage(i,WHITE,".הטריאטלון בוטל סיבה מספר משתתפים נמוך מ-4");
KillTimer(EndSystemTriatlon);
RunSystemend =0;
RunPlayers=0;
if(Registertrs[i] ==1)
{
CPTriatlon[i]=0;
DisablePlayerRaceCheckpoint(i);
TogglePlayerControllable(i,1);
}
}
}
return 1;
}

//=[Karting`start]==============================================
forward KartStart();
public KartStart()
{
new string[256];
MoneyWinnerKart =1000;
SendClientMessageToAll(COLOR_WHITE,"[_____________גאטר - קרב הקרטים_____________]");
SendClientMessageToAll(0xE21E1EFF, "! נפתחה הרשמה לקרב הקרטים, הזדרזו להירשם");
format(string,sizeof(string),".$%d :פרס למנצח מתחיל מסכום של",MoneyWinnerKart);
SendClientMessageToAll(0xE21E1EFF,string);
SendClientMessageToAll(0x0F6A0FF, "/JoinKart :יש לכם 45 שניות להירשם,להצטרפות רשמו");
SendClientMessageToAll(COLOR_WHITE,"----------------------------------");
KartOn = 1; KartPlayers = 0;
Countk = 45; cuntdownk(); CountFuck = 1;
return 1;
}
//=[CountKart]=====================================================
forward cuntdownk();
public cuntdownk() {
new string[256];
if(Countk == 40)
{
format(string,sizeof(string),"[Players: %d] if you want to do fun please doing /JoinKart.",KartPlayers);
SendClientMessageToAll(COLOR_WHITE,string);
}
else if(Countk == 20)
{
format(string,sizeof(string),"[Players: %d] if you want to do fun please doing /JoinKart.",KartPlayers);
SendClientMessageToAll(COLOR_WHITE,string);
}
else if(Countk == 10)
{
format(string,sizeof(string),"[Players: %d] if you want to do fun please doing /JoinKart.",KartPlayers);
SendClientMessageToAll(COLOR_WHITE,string);
}
new String[256];
format(String, 256,"~w~%d",Countk);
for(new i = 0; i < MAX_PLAYERS; i++)
GameTextForAll(String,1000,6);
if(Countk > 0)
{
--Countk;
SetTimer("cuntdownk", 1000, 0);
}
else
{
if(CountFuck == 1)
{
TeleportPlayerToKart();
if(knoobk == 1)
{
Countk = 3; cuntdownk(); CountFuck = 2;
}
}
if(CountFuck == 2 && Countk <= 0)
{
Unfreezek();
}
}
}


//=[Teleport`s-Karting`s]===============================
forward TeleportPlayerToKart();
public TeleportPlayerToKart()
{
if(KartPlayers < 1)
{
KartEnd(0);
return 1;
}
new string[256];
SendClientMessageToAll(COLOR_WHITE,"[______________!גאטר קארט - החל______________]");
format(string,sizeof(string)," %d :מס' משתתפים",KartPlayers),SendClientMessageToAll(0xE21E1EFF,string);
format(string,sizeof(string)," $%d :סכום זכייה שנקבע על ידי השחקנים הוא",MoneyWinnerKart),SendClientMessageToAll(0xE21E1EFF,string);
SendClientMessageToAll(COLOR_WHITE,"---------------------------------------");
KS = 1;
for(new i;i<MAX_PLAYERS;i++)
{
if(InKart[i] == 1)
{
SetPlayerVirtualWorld(i,0);
TogglePlayerControllable(i, 0);
caridxx[i] = CreateVehicle(571,  KartRandom[Kart_Var[i]][0], KartRandom[Kart_Var[i]][1], KartRandom[Kart_Var[i]][2],KartRandom[Kart_Var[i]][3], 1, 1, 600000);
PutPlayerInVehicle(i,caridxx[i], 0);
ResetPlayerWeapons(i);
KK[i] = 1; knoobk = 1;
KCheckTime = SetTimer("KCheck",1000, 1);
KCheckSec = SetTimer("KCheckSecs",1000, 1);
}
}
return 1;
}


forward KCheck();
public KCheck()
{
if(KS == 1)
{
if(KartPlayers == 1)
{
for(new i;i<MAX_PLAYERS;i++)
{
if(InKart[i] == 1)
{
KartWinner = i; KartEnd(1);
}
}
}
} return 1;
}

forward KCheckSecs(playerid);
public KCheckSecs(playerid)
{
new Float:p[3];
if(KS == 1)
{
for(new i;i<MAX_PLAYERS;i++)
{
GetPlayerPos(i,p[0],p[1],p[2]);
if(KK[i] == 1 && p[2] <  34.0)
{
KartPlayers --; InKart[i] = 0; KK[i] = 0;
//editprofilelayerPos(i,-2599.8259,1096.2352,57.1251);
SendClientMessage(i,WHITE,".Kart - .עזבת את הפעילות ");
DestroyVehicle(caridxx[i]);
SetPlayerPos(i,2057.0664,843.0209,6.7031);

}
}
}
return 1;
}


forward Unfreezek();
public Unfreezek() {
for(new i;i<MAX_PLAYERS;i++) {
if(KK[i] == 1) {
TogglePlayerControllable(i, 1);
SetCameraBehindPlayer(i);
GameTextForAll("~r~Kart ~p~Start", 3000, 0);
Fuck[i] = 1;
} } }



forward KartEnd(status);
public KartEnd(status)
{
if(status == 0)
{
SendClientMessageToAll(WHITE, ".הגאטר בוטל בגלל חוסר שחקנים שהיה פחות מ-3");
SendClientMessageToAll(WHITE, ".כל שחקן שהצטרף קיבל פיצוי בסך 500 דולר");
KartOn = 0; KartPlayers = 0;
KillTimer(KCheckTime);
KillTimer(KCheckSec);
KartOn =0;
for(new i=0;i<MAX_PLAYERS;i++)
{
if(InKart[i] == 1)
{
SendClientMessage(i,COLOR_ORANGE,".קיבלת פיצוי בסך [500] דולר על סיבה: חוסר משתתפים בגאטר");
LACY_GiveMoney(i,500);
InKart[i] = 0;  KK[i] = 0; KS = 0; knoobk = 0; Fuck[i] = 0;
DestroyVehicle(caridxx[i]);
}
}
return 1;
}
else if(status == 1)
{
new string[256];
KartOn = 0;
KartPlayers = 0;
KS = 0;

LACY_GiveMoney(KartWinner, 10000);
GetPlayerName(KartWinner, playername, sizeof(playername));
format(string, sizeof(string), "~W~The Winner Is ~n~~r~%s", (KartWinner));
GameTextForAll(string, 4000, 1);
KillTimer(KCheckTime);
KillTimer(KCheckSec);
SetPlayerInterior(KartWinner, 0);
LACY_GiveMoney(KartWinner,MoneyWinnerKart);
PlayerInfo[KartWinner][Kart] ++;
GetPlayerName(KartWinner, playername, sizeof(playername));
SendClientMessageToAll(COLOR_WHITE,"[________ גאטר קארט - מנצח ________]");
format(fuxm, sizeof(fuxm), ".$%d ניצח בקרב הקארטים, סכום הזכייה שהוא קיבל,(%d) ,%s",MoneyWinnerKart,KartWinner, GetName(KartWinner)),SendClientMessageToAll(0xE21E1EFF, fuxm);
format(fuxm, sizeof(fuxm), ".%d מספר הנצחנות שלו בקארטינג",PlayerInfo[KartWinner][Kart]),SendClientMessageToAll(0xE21E1EFF, fuxm);
SendClientMessageToAll(COLOR_WHITE,"--------------------------------------");TogglePlayerControllable(KartWinner, 1);
DestroyVehicle(caridxx[KartWinner]);
for(new i=0;i<MAX_PLAYERS;i++) {
InKart[i] = 0; KS = 0; KK[i] = 0; knoobk = 0; Fuck[i] = 0;
KartOn =0;

if(InKart[i] ==1) {
DestroyVehicle(caridxx[i]);
}}
return 1;
}
else if(status == 2) {
//format(fux, sizeof(fux), ".ביטל את קארטינג\"%s\" האדמין ", Adminname);
//SendClientMessageToAll(COLOR_PINK, fux);
KartPlayers = 0;
knoobk = 0;
KS = 0;
KartOn = 0;
Countk = 0; CountFuck = 0;
KillTimer(KCheckTime);
KillTimer(KCheckSec);
for(new i=0;i<MAX_PLAYERS;i++) {
InKart[i] = 0; KK[i] = 0; Fuck[i] = 0;
DestroyVehicle(caridxx[i]);
}
return 1;
}
return 1; }


forward MonsterStart();
public MonsterStart() {
MoneyWinnerMonster =1000;
new string[256];
SendClientMessageToAll(COLOR_WHITE,"[_____________גאטר - מכוניות מתנגשות_____________]");
SendClientMessageToAll(0xE21E1EFF, "! נפתחה הרשמה לקרב מונסטרים, הזדרזו להרשם");
format(string,sizeof(string),".$%d :פרס למנצח מתחיל מסכום של",MoneyWinnerMonster);
SendClientMessageToAll(0xE21E1EFF,string);
SendClientMessageToAll(0x0F6A0FF, "/Monster :יש לכם 45 שניות להירשם,להצטרפות רשמו");
SendClientMessageToAll(COLOR_WHITE,"----------------------------------");


MonsterOn = 1; MonsterPlayers = 0;
MonsterCount = 45; MonsterCountdown(); CountMoneterfu = 1;
return 1; }
//==================================MonsterCountdown==================================
forward MonsterCountdown();
public MonsterCountdown() {
new string[256];
if(MonsterCount == 40)
{
format(string,sizeof(string),"[Players: %d] if you want to do fun please doing /Monster.",MonsterPlayers);
SendClientMessageToAll(COLOR_WHITE,string);
}
else if(MonsterCount == 20)
{
format(string,sizeof(string),"[Players: %d] if you want to do fun please doing /Monster.",MonsterPlayers);
SendClientMessageToAll(COLOR_WHITE,string);
}
else if(MonsterCount == 10)
{
format(string,sizeof(string),"[Players: %d] if you want to do fun please doing /Monster.",MonsterPlayers);
SendClientMessageToAll(COLOR_WHITE,string);
}
new String[256];
format(String, 256,"~W~%d",MonsterCount);
for(new i = 0; i < MAX_PLAYERS; i++)
GameTextForAll(String,1000,6);
if(MonsterCount > 0)
{
--MonsterCount;
SetTimer("MonsterCountdown", 1000, 0);
}
else
{
if(CountMoneterfu == 1)
{
TeleportPlayerToMONSTER();
if(MonNoob == 1)
{
MonsterCount = 10; MonsterCountdown(); CountMoneterfu = 2;
}
}
if(CountMoneterfu == 2 && MonsterCount <= 0) {
UnfreezeMonster();
}
}
}
//==================================UnfreezeMonster====================================
forward UnfreezeMonster();
public UnfreezeMonster() {
for(new i;i<MAX_PLAYERS;i++) {
if(MonsterNoTeleportion[i] == 1)
 {
TogglePlayerControllable(i, 1);
SetCameraBehindPlayer(i);
GameTextForAll("~g~Monster STARTED!", 3000, 0);
MonsterFucker[i] = 1;
MCheckTimeMonster = SetTimer("MonsterCheck",1000, 1);
MonStart[i] =1;
} } }
//=============================TeleportPlayerToMONSTER==============================
forward TeleportPlayerToMONSTER();
public TeleportPlayerToMONSTER() {
if(MonsterPlayers < MiNmOnsterPlayers) {
MonsterWL(0);
return 1; }
new string[256];
SendClientMessageToAll(COLOR_WHITE,"[______________!גאטר קארט - החל______________]");
format(string,sizeof(string)," %d :מס' משתתפים",MonsterPlayers),SendClientMessageToAll(0xE21E1EFF,string);
format(string,sizeof(string)," $%d :סכום זכייה שנקבע על ידי השחקנים הוא",MoneyWinnerMonster),SendClientMessageToAll(0xE21E1EFF,string);
SendClientMessageToAll(COLOR_WHITE,"---------------------------------------");

for(new i = 0; i < MAX_PLAYERS; i++){
if(IsPlayerConnected(i) && iNmOnster[i]==1)
{

MonsterSYSTEM[i] = CreateVehicle(444,  MonsterRandom[Monster_Var[i]][0], MonsterRandom[Monster_Var[i]][1], MonsterRandom[Monster_Var[i]][2],MonsterRandom[Monster_Var[i]][3], 1, 1, 600000);
PutPlayerInVehicle(i,MonsterSYSTEM[i], 0);

LinkVehicleToInterior(MonsterSYSTEM[i],15);
TogglePlayerControllable(i, 0);
SetPlayerInterior(i,15);

SetPlayerVirtualWorld(i,0);
TogglePlayerControllable(i,0);
MoOn = 1; MonsterNoTeleportion[i] = 1; MonNoob = 1;
TogglePlayerControllable(i, 0);
SetCameraBehindPlayer(i);
KillTimer(MCheckTimeMonster);
KillTimer(KcheckMonster);
} }
return 1; }


//===================================MonsterWL=====================================
forward MonsterWL(status);
public MonsterWL(status) {
if(status == 0)
{
SendClientMessageToAll(WHITE, ".הגאטר בוטל בגלל חוסר שחקנים שהיה פחות מ-3");
SendClientMessageToAll(WHITE, ".כל שחקן שהצטרף קיבל פיצוי בסך 500 דולר");

MonsterOn = 0; MonsterPlayers = 0;
KillTimer(MCheckTimeMonster);
KillTimer(KcheckMonster);
for(new i=0;i<MAX_PLAYERS;i++) {
if(iNmOnster[i] == 1)
{
iNmOnster[i] = 0;  MonsterNoTeleportion[i] = 0; MoOn = 0; MonNoob = 0; MonsterFucker[i] = 0;
SendClientMessage(i,COLOR_ORANGE,".קיבלת פיצוי בסך [500] דולר על סיבה: חוסר משתתפים בגאטר");
LACY_GiveMoney(i,500);
DestroyVehicle(MonsterSYSTEM[i]);
}
}
return 1;
}
else if(status == 1)
{
MonsterOn = 0; MonsterPlayers = 0;


KillTimer(MCheckTimeMonster);
KillTimer(KcheckMonster);

new rand = random(sizeof(gRandomPlayerSpawns));
SetPlayerPos(MonsterWinner, gRandomPlayerSpawns[rand][0], gRandomPlayerSpawns[rand][1], gRandomPlayerSpawns[rand][2]); // Warp the player
LACY_GiveMoney(MonsterWinner,MoneyWinnerMonster);
PlayerInfo[MonsterWinner][Monster] ++;
GetPlayerName(MonsterWinner, playername, sizeof(playername));

SendClientMessageToAll(COLOR_WHITE,"[________ גאטר מכוניות מתנגשות - מנצח ________]");
format(fuxm, sizeof(fuxm), ".$%d ניצח בקרב מונסטרים, הכסף שהוא זכה בוא עומד על כ,%s",MoneyWinnerMonster,GetName(MonsterWinner)),SendClientMessageToAll(0xE21E1EFF, fuxm);
format(fuxm, sizeof(fuxm), ".%d מספר הנצחנות שלו בקרב טילים",PlayerInfo[MonsterWinner][Monster]),SendClientMessageToAll(0xE21E1EFF, fuxm);
SendClientMessageToAll(COLOR_WHITE,"--------------------------------------");


SetPlayerPos(MonsterWinner,2144.1472,1634.6127,993.5761);
SetPlayerInterior(MonsterWinner,1);
MoneyWinnerMonster =0;
for(new i=0;i<MAX_PLAYERS;i++) {
iNmOnster[i] = 0; MoOn = 0; MonsterNoTeleportion[i] = 0; MonNoob = 0; MonsterFucker[i] = 0;
DestroyVehicle(MonsterSYSTEM[i]);
}
return 1;
}
else if(status == 2) {
format(MonsterFux, sizeof(MonsterFux), ".ביטל את הגאטר \"%s\" האדמין ", Adminname);
SendClientMessageToAll(lblue, MonsterFux);
MonsterPlayers = 0;
MonNoob = 0; MoOn = 0;
MonsterOn = 0;
MonsterCount = 0; CountMoneterfu = 0;
KillTimer(MCheckTimeMonster);
for(new i=0;i<MAX_PLAYERS;i++) {
iNmOnster[i] = 0; MonsterNoTeleportion[i] = 0; MonsterFucker[i] = 0;
DestroyVehicle(MonsterSYSTEM[i]); }
return 1; }
return 1; }

forward MonsterCheck();
public MonsterCheck() {
if(MoOn == 0) return 0;
if(MoOn == 1) {
if(MonsterPlayers == 1) {
for(new i;i<MAX_PLAYERS;i++) {
if(MonsterNoTeleportion[i] == 1) {
MonsterWinner = i; MonsterWL(1);
} } } } return 1; }




//=[AntiMinigun`s]===================================================
forward AntiMinigun();
public AntiMinigun()
{
new weapon;
new gunammo;
for(new i = 0; i < 200; i++)
{
for (new x = 0; x < 13; x++)
{
if(PPw[i] == 1||  InWarw[i] == 1 || InDM[i] == 1) return 0;
GetPlayerWeaponData(i, x, weapon, gunammo);
if(IsPlayerXAdmin(i)) return 0;
if((weapon == 38) && gunammo > 1)
{
ResetPlayerWeapons(i);
break;
}
continue;
}
}
return 1;
}
//=[AntiBazooka]==================================================
forward AntiBaz();
public AntiBaz()
{
new weapon;
new gunammo;
for(new i = 0; i < 200; i++)
{
for (new x = 0; x < 13; x++)
{
if(IsPlayerXAdmin(i)) return 0;

if(PPr[i] == 1 || PlayerInfo[i][bazooka] > 0 || InWarr[i] == 1 || InDM[i] == 1) return 0;
GetPlayerWeaponData(i, x, weapon, gunammo);
if((weapon == 35 || weapon == 36) && gunammo > 1)
{
ResetPlayerWeapons(i);
break;
}
continue;
}
}
return 1;
}
//=[AFKick]========================================================
/*
forward AFKick(playerid);
public AFKick(playerid)
{
if(isafk[playerid] == 1) return 0;
if(PlayerInfo[playerid][AdminsLevel] > 1) return 0;
GetPlayerPos(playerid, AFKPos[playerid][0], AFKPos[playerid][1], AFKPos[playerid][2]);
if(AFKPos[playerid][0] == AFKPos[playerid][3] && AFKPos[playerid][1] == AFKPos[playerid][4] && AFKPos[playerid][2] == AFKPos[playerid][5])
{
new player[MAX_PLAYER_NAME], string[256];
GetPlayerName(playerid, player, sizeof(player));
format(string, sizeof(string), ".(AFK) קיבל קיק מהשרת סיבה: זמן ממושך ללא תזוזה  ,\"%s\"", player);
SendClientMessageToAll(WHITE, string);
Kick(playerid);
return 1;
}
AFKPos[playerid][3] = AFKPos[playerid][0];
AFKPos[playerid][4] = AFKPos[playerid][1];
AFKPos[playerid][5] = AFKPos[playerid][2];
return 1;
}
*/
//=[StockColor]=====================================================
stock sgba2hex(s,g,b,a) return (s*16777216) + (g*65536) + (b*256) + a;
stock rgba2hex(a,x,z,v) return (a) + (x) + (z*256) + v;

//=[Forward]========================================================
forward Msc(playerid);
//=[Public]==========================================================
public Msc(playerid) return RK_GM(playerid,3000,":קיבלת משכורת בסך של",COLOR_YELLOW,1);
//=[Rk.include]==============================================================
//=[RK_HP]========================================================
stock RK_HP(playerid,Float:Health,price,messagess[],scolor)
{
new string[256];
if(GetPlayerMoney(playerid) < price) return SendClientMessage(playerid,WHITE,".אין לך מספיק כסף לקנות את החיים אתה  צריך לפחות כ1500 דולר");
LACY_GiveMoney(playerid,-price);
format(string,sizeof(string),"%s ,%s",messagess,GetName(playerid));
SendClientMessageToAll(scolor,string);
SetPlayerHealth(playerid,Float:Health);
return 1;
}
//=[RK_GiveWeapons]==============================================
stock RK_GiveSetWeapons(playerid,weaponid,ammu,weaponid2,ammu2,weaponid3,ammu3,price)
{
if(GetPlayerMoney(playerid) < price) return SendClientMessage(playerid,WHITE,".אין לך מספיק כסף לקנות את הסט נשקים אתה צריך לפחות כ6000 דולר");
LACY_GiveMoney(playerid,-price);
GivePlayerWeapon(playerid,weaponid,ammu);
GivePlayerWeapon(playerid,weaponid2,ammu2);
GivePlayerWeapon(playerid,weaponid3,ammu3);
return 1;
}
//=[RK_SA / SetPlayerArmour]=======================================================
stock RK_SA(playerid,Float:Armour,price,messages[],scolor)
{
new string[256];
if(GetPlayerMoney(playerid) < price) return SendClientMessage(playerid,WHITE,".אין לך מספיק כסף לקנות את המגן אתה צריך לפחות כ2000 דולר");
SetPlayerArmour(playerid,Float:Armour);
LACY_GiveMoney(playerid,-price);
format(string,sizeof(string),"%s ,%s",messages,GetName(playerid));
SendClientMessageToAll(scolor,string);
return 1;
}
//=[Rk_GM / GivePlayerMoney]=====================================================
stock RK_GM(playerid,moneys,mm[],mcolor,number)
{
if(number == 0)
{
new string[256];
LACY_GiveMoney(playerid,moneys);
format(string,sizeof(string),"$%d %s",moneys,mm);
SendClientMessage(playerid,mcolor,string);
return 1;
}
if(number == 1)
{
fnm
new string[256];
LACY_GiveMoney(i,moneys);
format(string,sizeof(string),"$%d %s",moneys,mm);
SendClientMessage(i,mcolor,string);
}
}
return 1;
}
//=[r]====
forward Rules(playerid);
public Rules(playerid)
{
SendClientMessage(playerid, COLOR_WHITE,"----- .Rules the server | Satla-Zone.co.il | חוקי השרת ----");
SendClientMessage(playerid, COLOR_GREY,"(1) - .אנא דבר בכבוד לאדמינים ולחברי השרת");
SendClientMessage(playerid, COLOR_GREY, "(2) - .אין להציף תצ'אט בהודעות סתמיות");
SendClientMessage(playerid, COLOR_GREY, "(3) - .צי'טים יגררו לבאן ישירות");
SendClientMessage(playerid, COLOR_GREY, "(4) - .אין להרוג בשדה התעופה / רייס עם מסוק / הידרה");
SendClientMessage(playerid, COLOR_GREY, "(5) - .אין לפרסם כתובת מגורים / מספרי פלאפון");
SendClientMessage(playerid, COLOR_GREY, "(6) - (Swapn Kill).אין לעשות הרג חברי על מנת ליצר לכם סטאטס גבוה יותר");
SendClientMessage(playerid, COLOR_GREY, "(7) - .אין להרוג אדמין לבן - אדמין בתפקיד");
SendClientMessage(playerid, COLOR_GREY, "(8) - /report - .אנא אל תדווחו בשרת על צי'טירים בצ'אט אנא דווחו בפקודה");
SetTimerEx("ConPlayer",15*1000,0,"i",playerid);
return 1;
}
/*
new tilim[MAX_PLAYERS];
new Float:postions[3];
new Float:Objectp[3];
//=[New]========================

forward BoomPlayer();
public BoomPlayer()
{
fnm
if(InArea(i, 404.8684, 35.6969, 2102.7212, 1653.4156))
{
if(PlayerInfo[i][VIPS] >= 1) return 0;
if(NoMoreObject[i] == 0)
{
tilim[i] = CreateDynamicObject(354,212.5598,1895.0790,16.2901, 0.0000,0.0000,0.0000);
SendClientMessage(i,WHITE,".נשלח עליך ברגעים האלו אנא תברח מהר ממפקדה לפני שתפגע VIPשים לב, טיל ממפקדת ה");
NoMoreObject[i] = 1;
}
SetTimerEx("Setil",100,0,"i",i);
}
}
return 1;
}
*/
/*
forward Setil(playerid);
public Setil(playerid)
{
if(InArea(playerid, 404.8684, 35.6969, 2102.7212, 1653.4156))
{
GetPlayerPos(playerid,postions[0],postions[1],postions[2]);
MoveObject(tilim[playerid] ,postions[0],postions[1],postions[2],110);
GetStreamObjectPos(tilim[playerid] ,Objectp[0],Objectp[1],Objectp[2]);
if(PlayerToPoint(27.0,playerid,Objectp[0],Objectp[1],Objectp[2]))
{
EXPLODEs(playerid);
}
}

return 1;
}
forward EXPLODEs(playerid);
public EXPLODEs(playerid)
{
GetPlayerPos(playerid,postions[0],postions[1],postions[2]);
CreateExplosion(postions[0],postions[1],postions[2],10,10);
NoMoreObject[playerid] = 1;
SetPlayerHealth(playerid,0.0);
DestroyDynamicObject(tilim[playerid]);
SetTimerEx("ResetTilimt",30*1000,0,"i",playerid);
return 1;
}
forward ResetTilimt(playerid);
public ResetTilimt(playerid)return NoMoreObject[playerid] = 0;
*/
forward AntiGamebling();
public AntiGamebling()
{
for(new i=0; i<MAX_PLAYERS; i++)
{
if(InArea(i, 1987.5336,1925.3849, 1051.0730, 968.4362))
{
SendClientMessage(i,WHITE,".הכניסה לקזינו אסורה בהחלט");
SetPlayerPos(i,2057.0664,843.0209,6.7031);
SetPlayerFacingAngle(i,357.5948);
SetPlayerInterior(i,0);
}
}
return 1;
}

stock InArea(playerid, Float:max_x, Float:min_x, Float:max_y, Float:min_y)
{
new Float:X, Float:Y, Float:Z;
GetPlayerPos(playerid, X, Y, Z);
if(X <= max_x && X >= min_x && Y <= max_y && Y >= min_y) return 1;

return 0;
}

//if(InAreaShip(playerid, 1995.5, 1518.0, 2006.0, 1569.0)) return SendClientMessage(playerid,red,"!אינך יכול לשלוח כסף שאתה נמצא בספינת הכסף");
stock InAreaShip(playerid, Float:x1, Float:y1, Float:x2, Float:y2)
{
new Float:X, Float:Y, Float:Z;
GetPlayerPos(playerid, X, Y, Z);
if(X >= x1 && X <= x2 && Y >= y1 && Y <= y2) return 1;
return 0;
}

//=[IsAreaPart]
/*
forward IsBallInArea(x);
public IsBallInArea(x=0)
{
if(IsObjectInZone(football, 127.5067,42.8843,2524.0745,2475.0125))
{
x++;
}
else
{
SendClientMessageToAll(WHITE,".הכדור יצא מתחומי המגרש,לכן הכדור שוחזר");
DestroyObject(football);
football=CreateObject(1598, 89.615692, 2500.632324, 15.789375, 0.0000, 0.0000, 0.0000*x);
x=0;
}
return 1;
}

return 1;
}
stock IsObjectInZone(ObjectName, Float:max_x, Float:min_x, Float:max_y, Float:min_y)
{
new Float:X, Float:Y, Float:Z;
GetStreamObjectPos(ObjectName, X, Y, Z);
if(X <= max_x && X >= min_x && Y <= max_y && Y >= min_y) return 0+1*1;
return 1*1.00;
}
*/
stock Messagelevel (playerid, alevels)
{
new st[256];
format(st, sizeof(st), ".%d :שיגאה : - מערכת הרמות, שיגור / פקודה משמשת את שחקנים השרת שנמצאים ברמה#", alevels);
SendClientMessage(playerid,red, st);
return 1;
}
//=[CreateTeleport]==
stock CreateTeleport(playerid,Interior,Float:x,Float:y,Float:z,Float:a,Message[],textgame[],WithVehicle)
{
if(GetPlayerState(playerid) == 2 && WithVehicle == 1)
{
LinkVehicleToInterior(GetPlayerVehicleID(playerid),Interior);
SetVehiclePos(GetPlayerVehicleID(playerid), x, y, z);
SetVehicleZAngle(GetPlayerVehicleID(playerid), a);
}
else
{
SetPlayerInterior(playerid,Interior);
SetPlayerPos(playerid, x, y, z);
SetPlayerFacingAngle(playerid, a);
}
SendClientMessage(playerid, 0xF6F658FF, Message);
GameTextForPlayer(playerid,textgame,5000,1);
return 1;
}
//=/AirStrike/===
forward AirStrikeExplode(playerid);
public AirStrikeExplode(playerid)
{
if(Explodeion[playerid] == 1)
{
CreateExplosion(PlayerInfo[playerid][xAirStrike],PlayerInfo[playerid][yAirStrike],PlayerInfo[playerid][zAirStrike],10,10);
DestroyObject(AirStrikeTil[playerid]);
KillTimer(AirStrikeExplodes[playerid]);
SetTimerEx("againis",30*60,0,"i",playerid);
}
if(Explodeion[playerid] == 2)
{
CreateExplosion(PlayerInfo[playerid][xAirStrike],PlayerInfo[playerid][yAirStrike],PlayerInfo[playerid][zAirStrike],10,10);
SetTimerEx("mexlop",1500,0,"i",playerid);
DestroyObject(AirStrikeTil[playerid]);
KillTimer(AirStrikeExplodes[playerid]);
SetTimerEx("againis",30*60,0,"i",playerid);
}
if(Explodeion[playerid] == 3)
{
CreateExplosion(PlayerInfo[playerid][xAirStrike],PlayerInfo[playerid][yAirStrike],PlayerInfo[playerid][zAirStrike],10,10);
SetTimerEx("mexlop",1500,0,"i",playerid);
DestroyObject(AirStrikeTil[playerid]);
KillTimer(AirStrikeExplodes[playerid]);
SetTimerEx("againis",30*60,0,"i",playerid);
}

return 1;
}
forward mexlop(playerid);
public mexlop(playerid)
{
if(Explodeion[playerid] == 2)
{
CreateExplosion(PlayerInfo[playerid][xAirStrike],PlayerInfo[playerid][yAirStrike],PlayerInfo[playerid][zAirStrike],10,10);
DestroyObject(AirStrikeTil[playerid]);
DestroyObject(AirStrikeTil2[playerid]);
DestroyObject(AirStrikeTil3[playerid]);
Explodeion[playerid] =0;
return 1;
}
if(Explodeion[playerid] == 3)
{
CreateExplosion(PlayerInfo[playerid][xAirStrike],PlayerInfo[playerid][yAirStrike],PlayerInfo[playerid][zAirStrike],10,10);
SetTimerEx("mexlop2",1200,0,"i",playerid);
DestroyObject(AirStrikeTil[playerid]);
DestroyObject(AirStrikeTil2[playerid]);
DestroyObject(AirStrikeTil3[playerid]);

return 1;
}
return 1;
}
forward mexlop2(playerid);
public mexlop2(playerid)
{
CreateExplosion(PlayerInfo[playerid][xAirStrike],PlayerInfo[playerid][yAirStrike],PlayerInfo[playerid][zAirStrike],10,10);
DestroyObject(AirStrikeTil[playerid]);
DestroyObject(AirStrikeTil2[playerid]);
DestroyObject(AirStrikeTil3[playerid]);
Explodeion[playerid] = 0;
return 1;
}
forward againis(playerid);
public againis(playerid) return AirStrikeInWar[playerid] = 0;
forward SpawnPlayer2(playerid);
public SpawnPlayer2(playerid)
{
if(IsPlayerInAnyVehicle(playerid))
{
RemovePlayerFromVehicle(playerid);
SetTimerEx("SpawnPlayer3",4000,0,"i",playerid);
}
if(!IsPlayerInAnyVehicle(playerid))
{
SetTimerEx("SpawnPlayer3",4000,0,"i",playerid);
}
return 1;
}

new Float:HealthCheat;
new Float:Zambora[MAX_PLAYERS];
forward GodModCheack(playerid);
public GodModCheack(playerid)
{
SetPlayerArmour(playerid,0.0);
SetPlayerHealth(playerid,100);
SetTimerEx("GodModCheack2",4000,0,"i",playerid);
Zambora[playerid] = 0;
return 1;
}
forward GodModCheack2(playerid);
public GodModCheack2(playerid)
{
GetPlayerHealth(playerid,HealthCheat);
Zambora[playerid] = HealthCheat;
new Float:PosGod[3];
GetPlayerPos(playerid,PosGod[0],PosGod[1],PosGod[2]);
CreateExplosion(PosGod[0],PosGod[1],PosGod[2],10,10);
SetTimerEx("GodModCheack3",4000,0,"i",playerid);
return 1;
}

forward GodModCheack3(playerid);
public GodModCheack3(playerid)
{
GetPlayerHealth(playerid,HealthCheat);
if(HealthCheat < 0.1) return 0;
if(HealthCheat < Zambora[playerid]) return 0;
if(HealthCheat == Zambora[playerid])
{
new str[256];
SendClientMessage(playerid,red,"God Mod Hack. מערכת האנטי צ'יט זיההתה אצלך, צ'יט מסוג");
SendClientMessage(playerid,red,".כעת תוצא מהשרת,במידה זה יחזור עליו שנית, יש סיכוי להרחקה מהשרת");
format(str, sizeof(str), "[AntiCheat] %s has been kicked for using God Mod Hack." , GetName(playerid));
SendClientMessageToAll(red , str);
Kick(playerid);
}
return 1;
}


//=[Bike]
forward BikeStart();
public BikeStart()
{
new string[256];
SendClientMessageToAll(COLOR_WHITE,"[_____________גאטר - מירוץ אופנועים_____________]");
SendClientMessageToAll(0xF6F658FF, "! נפתחה הרשמה לקרב מירוצים, סוג מירוץ: אופנועים הזדרזו להירשם");
format(string,sizeof(string),".$3000:המנצח יזכה בפרס כספי של");
SendClientMessageToAll(0xF6F658FF,string);
SendClientMessageToAll(0x0F6A0FF, "/races join :יש לכם 60 שניות להצטרף, להצטרפות רשמו");
SendClientMessageToAll(COLOR_WHITE,"----------------------------------");
BikeWinner = 1;
BikePlayers = 0;
BikeOn = 1; CountBiker = 60;
CountBikerdown();
return 1;
}


forward CountBikerdown();
public CountBikerdown()
{
for(new i = 0; i < MAX_PLAYERS; i++)
if (CountBiker > 0)
{
new String[256];
format(String, 256,"~w~%d",CountBiker);
GameTextForAll(String,1000,6);
--CountBiker;
return SetTimer("CountBikerdown", 1000, 0);
}
if(CountBiker < 1)
{
for (new i=0; i<200; i++)
{
if (IsPlayerConnected(i))
{
new string[256];
SendClientMessage(i,COLOR_WHITE,"[______________מירוץ מאורגן - אופנועים______________]");
format(string,sizeof(string)," %d :מס' משתתפים",BikePlayers);
SendClientMessage(i,0xE21E1EFF,string);
SendClientMessage(i,0xE21E1EFF,"המנצח יקבל סכום מכובד של 3000$");
SendClientMessage(i,COLOR_WHITE,"---------------------------------------");
GameTextForPlayer(i,"~y~h~[]Races Start~y~h~[]",1000,4);
if(InBike[i] > 0)
{
TogglePlayerControllable(i, 1);
}
}
}
}
return 1;
}
forward OutDrift(playerid);
public OutDrift(playerid)
{
if(indrift[playerid] == 0)return 0;
if(indrift[playerid] == 1)
{
new string[256];
format(string,sizeof(string),".-פרש מהמירוץ דריפט האישי,%s",GetName(playerid));
SendClientMessageToAll(WHITE,string);
DisablePlayerRaceCheckpoint(playerid);
driftwinner[playerid]=0;
DriftInvite[playerid] =0;
IfInvite[playerid] =0;
indrift[playerid] =0;
DisablePlayerRaceCheckpoint(playerid);
DriftNoNow = 0;
PrivateCP[playerid] = 0;
DriftInvite[playerid] = 0;
IfInvite[playerid] = 0;
new vehicleidsa = GetPlayerVehicleID(playerid);
SetPlayerVirtualWorld(playerid,0);
SetVehicleVirtualWorld(vehicleidsa,0);

for(new Drifter=0; Drifter<MAX_PLAYERS; Drifter++)
{
if(indrift[Drifter] == 1)
{
format(string,sizeof(string),"!ניצח אוטומאטית במירוץ דריפט ,%s",GetName(Drifter));
SendClientMessage(Drifter,COLOR_LIGHTGREEN,string);
LACY_GiveMoney(playerid,driftwinner[Drifter]);
driftwinner[Drifter]=0;
DriftInvite[Drifter] =0;
IfInvite[Drifter] =0;
indrift[Drifter] =0;
DisablePlayerRaceCheckpoint(Drifter);
DriftNoNow = 0;
PrivateCP[Drifter] = 0;
DriftInvite[Drifter] = 0;
IfInvite[Drifter] = 0;
new vehicleids = GetPlayerVehicleID(Drifter);
SetPlayerVirtualWorld(Drifter,0);
SetVehicleVirtualWorld(vehicleids,0);
}
}
}
return 1;
}


forward CloseHqNm();
public CloseHqNm()
{
MoveObject(NM1, 1211.504272, -2039.203613, 70.732048,3);
}


forward CloseHqNm2();
public CloseHqNm2()
{
MoveObject(NM2,1153.494507, -2044.161255, 67.997490,3);
MoveObject(NM3,1150.846802, -2040.520508, 74.647285,1);
}
/*
forward ClosedHqIDF();
public ClosedHqIDF()
{
MoveObject(IDF1,2677.702637, -2404.156250, 15.258852,4);
return 1;
}
forward ClosedHqIDF2();
public ClosedHqIDF2()
{
MoveObject(IDF2,2694.454102, -2330.874756, 15.406204,4);
return 1;
}
forward ClosedHqIDF3();
public ClosedHqIDF3()
{
MoveObject(IDF3,2703.111328, -2304.132080, 17.351837,1);
return 1;
}
*/

//===[Challenge]==============================================================
//==================================ChaStart====================================
forward ChaStarted();
public ChaStarted()
{
new string[256];
SendClientMessageToAll(COLOR_WHITE,"[_____________גאטר - טיפוס על ההר_____________]");
SendClientMessageToAll(0xF6F658FF, "! נפתחה הרשמה לקרב מאורגן, הזדרזו להירשם");
format(string,sizeof(string),".$%d :פרס למנצח מתחיל מסכום של",ChaPras);
SendClientMessageToAll(0xF6F658FF,string);
SendClientMessageToAll(0x0F6A0FF, "/Cha :יש לכם 60 שניות להצטרף, להצטרפות רשמו");
SendClientMessageToAll(COLOR_WHITE,"----------------------------------");
ChaOn = 1; ChaPlayers = 0;
CountChallenge = 60; CountChallengedown(); CountChallengeFuc = 1;
return 1; }
//==================================CountChallengedown===================================
forward CountChallengedown();
public CountChallengedown() {
if(CountChallenge == 30) {
SendClientMessageToAll(COLOR_WHITE, "Chllenge Etgar Open To Join Doing: - /Cha (TYPE: Challenge).");
} else if(CountChallenge == 15) {
SendClientMessageToAll(COLOR_WHITE, "Chllenge Etgar Open To Join Doing: - /Cha (TYPE: Challenge).");
}
new String[256];
format(String, 256,"~w~%d",CountChallenge);
for(new i = 0; i < MAX_PLAYERS; i++)

GameTextForAll(String,1000,6);
if(CountChallenge > 0) {
--CountChallenge;
SetTimer("CountChallengedown", 1000, 0);
} else {
if(CountChallengeFuc == 1) {
TeleportPlayerToCha();
if(ChaNoobs == 1) {
CountChallenge = 10; CountChallengedown(); CountChallengeFuc = 2;
} }
if(CountChallengeFuc == 2 && CountChallenge <= 0) {
UFALLCHA();
} } }
//==================================UFALLCHA====================================
forward UFALLCHA();
public UFALLCHA() {
for(new i;i<MAX_PLAYERS;i++) {
if(PChain[i] == 1) {
TogglePlayerControllable(i, 1);
SetCameraBehindPlayer(i);
} } }
//=============================TeleportPlayerToCha==============================
forward TeleportPlayerToCha();
public TeleportPlayerToCha() {
if(ChaPlayers < MinChaPlayers) {
ChaEnd(0);
return 1; }
for(new i;i<MAX_PLAYERS;i++)
{
if(InCha[i] == 1)
{

new string[256];
SendClientMessage(i,COLOR_WHITE,"[______________!גאטר - טיפוס על הר______________]");
format(string,sizeof(string)," %d :מס' משתתפים",ChaPlayers),SendClientMessage(i,0xE21E1EFF,string);
format(string,sizeof(string)," $%d :סכום זכייה שנקבע על ידי השחקנים הוא",ChaPras),SendClientMessage(i,0xE21E1EFF,string);
SendClientMessage(i,COLOR_WHITE,"---------------------------------------");

new rand = random(sizeof(ChaSpawn));
SetPlayerPos(i, ChaSpawn[rand][0], ChaSpawn[rand][1], ChaSpawn[rand][2]);
ResetPlayerWeapons(i);
ResetPlayerWeapons(i);
SetPlayerArmour(i, 100.0);
SetPlayerHealth(i, 100.0);
ChaStart = 1; PChain[i] = 1; ChaNoobs = 1;
TogglePlayerControllable(i, 0);
CHASECX = SetTimer("WinnerCha",1000, 1);
CHATIME = SetTimer("Check",1000, 1);
} }
return 1; }

//===================================ChaEnd=====================================
forward ChaEnd(status);
public ChaEnd(status) {
if(status == 0) {
ChaOn = 0; ChaPlayers = 0;
KillTimer(CHATIME);
KillTimer(CHASECX);
for(new i;i<MAX_PLAYERS;i++)
{
InCha[i] = 0;  PChain[i] = 0; ChaStart = 0; ChaNoobs = 0;
for(new Chei = 0; Chei <CHA_OBJECT; Chei++)
{
DestroyDynamicObject(CheDelObject[Chei]);
}
}
return 1;
}
else if(status == 1) {
ChaOn = 0; ChaPlayers = 0;
LACY_GiveMoney(ChaWinner, ChaPras);
GetPlayerName(ChaWinner, playername, sizeof(playername));
format(kboobcha, sizeof(kboobcha), "~W~ The Winner Is ~n~~r~%s", playername);
GameTextForAll(kboobcha, 4000, 1);
KillTimer(CHATIME);
KillTimer(CHASECX);
ResetPlayerWeapons(ChaWinner);
SetPlayerInterior(ChaWinner, 0);
SetPlayerPos(ChaWinner, 2028.6577,1341.8792,10.8203);
SendClientMessageToAll(COLOR_WHITE,"[________ האתגר טיפוס - מנצח ________]");
SendClientMessageToAll(0xE21E1EFF, "!הקרב הסתיים");
format(kboobcha, sizeof(kboobcha), "$%d :הגיע לסוף ההר בהצלחה ! זכה בפרס של כ %s", ChaPras, playername);
SendClientMessageToAll(0xE21E1EFF, kboobcha);
SendClientMessageToAll(COLOR_WHITE, "------------------------------");


for(new Chei = 0; Chei <CHA_OBJECT; Chei++)
{
DestroyDynamicObject(CheDelObject[Chei]);
}
for(new i;i<MAX_PLAYERS;i++)
{
InCha[i] = 0; ChaStart = 0; PChain[i] = 0; ChaNoobs = 0;
}
return 1;
}
else if(status == 2)
{
format(kboobcha, sizeof(kboobcha), ".ביטל את האתגר טיפוס \"%s\" האדמין ", Chaadminsname);
SendClientMessageToAll(lblue, kboobcha);
ChaPlayers = 0;
ChaNoobs = 0; ChaStart = 0;
ChaOn = 0;
CountChallenge = 0; CountChallengeFuc = 0;
KillTimer(CHATIME);
KillTimer(CHASECX);
for(new i;i<MAX_PLAYERS;i++) {
InCha[i] = 0; PChain[i] = 0;
}
return 1;
}
else if(status == 3)
{
ChaPlayers = 0;
ChaNoobs = 0; ChaStart = 0;
ChaOn = 0;
CountChallenge = 0; CountChallengeFuc = 0;
KillTimer(CHATIME);
KillTimer(CHASECX);
SendClientMessageToAll(COLOR_WHITE, ".האתגר טיפוס הופסק, סיבה: אף אחד לא יגיע לסוף ההר");
for(new Chei = 0; Chei <CHA_OBJECT; Chei++)
{
DestroyDynamicObject(CheDelObject[Chei]);
}
for(new i;i<MAX_PLAYERS;i++)
{
InCha[i] = 0; PChain[i] = 0;
}
return 1;
}
return 1; }
//===================================Check======================================
forward Check();
public Check() {
if(ChaStart == 1) {
if(ChaPlayers == 0) {
for(new i;i<MAX_PLAYERS;i++) {
if(InCha[i] == 1) {
ChaWinner = i; ChaEnd(3);
} } } } return 1; }

forward WinnerCha();
public WinnerCha() {
if(ChaStart == 1)
{
for(new i;i<MAX_PLAYERS;i++)
{
if(InCha[i] == 1)
{
if(PlayerToPoint(8.0,i,1626.7010,-2286.8787,94.1328))
{
ChaWinner = i; ChaEnd(1);
}
}
}
}
return 1;
}
//=[RoX]=
forward CloseHqRoX();
forward CloseHqRoX2();
forward CloseHqRoX3();

public CloseHqRoX()
{
MoveObject(RoX1, -2127.299805, -80.334839, 37.043701,2);
return 1;
}
public CloseHqRoX2()
{
MoveObject(RoX2,-2180.527344, -212.667587, 38.292458,2);
MoveObject(RoX3,-2180.498779, -217.493393, 38.292458,2);
MoveObject(RoX5,-2163.575439, -225.588898, 35.503658,2);
return 1;
}
public CloseHqRoX3()
{
MoveObject(RoX4,-2124.288818, -176.404907, 34.340195,2);
return 1;
}
//=[AirBreack]

public OnGetPlayerKeys()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		new Keys, UpDown, LeftRight;
		GetPlayerKeys(i, Keys, UpDown, LeftRight);

		if(IsPlayerInAnyVehicle(i) == 1)
		{
			if(AirBreakVar[i] == 1)
			{
				AirBreakVar[i] = 0;
				TogglePlayerControllable(i, 1);
			}
		}

		if(AirBreakVar[i] == 1)
		{
			new Float:X, Float:Y, Float:Z, Float:A;
			GetPlayerPos(i, X, Y, Z);
			GetPlayerFacingAngle(i, A);

			if(UpDown == KEY_UP)
			{
				X += (SetDistance[i] * floatsin(-A, degrees)); //Made by Y_Less
				Y += (SetDistance[i] * floatcos(-A, degrees)); //Made by Y_Less

				SetPlayerPos(i, X, Y, Z);
				SetCameraBehindPlayer(i);
				return 1;
			}

			if(UpDown == KEY_DOWN)
			{
				X -= (SetDistance[i] * floatsin(-A, degrees)); //Made by Y_Less
				Y -= (SetDistance[i] * floatcos(-A, degrees)); //Made by Y_Less

				SetPlayerPos(i, X, Y, Z);
				SetCameraBehindPlayer(i);
				return 1;
			}

			if(LeftRight == KEY_RIGHT)
			{
				A += -90;
				X += floatmul(floatsin(-A, degrees), SetDistance[i]); // Made by Nero_3D
				Y += floatmul(floatcos(-A, degrees), SetDistance[i]); // Made by Nero_3D

				SetPlayerPos(i, X, Y, Z);
				SetCameraBehindPlayer(i);
				return 1;
			}

			if(LeftRight == KEY_LEFT)
			{
				A += 90;
				X += floatmul(floatsin(-A, degrees), SetDistance[i]); // Made by Nero_3D
				Y += floatmul(floatcos(-A, degrees), SetDistance[i]); // Made by Nero_3D

				SetPlayerPos(i, X, Y, Z);
				SetCameraBehindPlayer(i);
				return 1;
			}

			if(Keys == KEY_JUMP)
			{
				SetPlayerPos(i, X, Y, Z + SetDistance[i]);
				SetCameraBehindPlayer(i);
				return 1;
			}

			if(Keys == KEY_SPRINT)
			{
				SetPlayerPos(i, X, Y, Z - SetDistance[i]);
				SetCameraBehindPlayer(i);
				return 1;
			}

			if(Keys == KEY_ANALOG_RIGHT)
			{
				SetPlayerFacingAngle(i, A - (SetDistance[i] * 4));
				SetCameraBehindPlayer(i);
				return 1;
			}

			if(Keys == KEY_ANALOG_LEFT)
			{
				SetPlayerFacingAngle(i, A + (SetDistance[i] * 4));
				SetCameraBehindPlayer(i);
				return 1;
			}
		}
	}
	return 1;
}


stock IsNickValid(const nick[])
{
	new strlen_nick = strlen(nick);
	if (strlen_nick > 16) return false;
	for (new i = 0; i < strlen_nick; ++i)
	{
		switch (nick[i])
		{
			case 'A' .. 'Z': { }
			case 'a' .. 'z': { }
			case '0' .. '9': { }
			case '[', ']', '_': { }
			default: return false;
		}
	}
	return true;
}

stock IsNameValid(const name[]) {
	if(strlen(name) > 16) return false;
	if(strlen(name) < 3) return false;
	new allow[] = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O',
	'P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o',
	'p','q','r','s','t','u','v','w','x','y','z','[',']','_',0,1,2,3,4,5,6,7,8,9};
	for(new n=0; n<sizeof(allow); n++) if(strfind(name,allow[n],false)!=-1) return false;
	return true;
}

/*
forward CloseHqIDF2();
forward CloseHqIDF();
forward CloseHqIDF3();
public CloseHqIDF()
{
MoveObject(IDF1,-1895.055664, 1344.116089, 8.960903,3);
return 1;
}
public CloseHqIDF2()
{
MoveObject(IDF2, -1917.389160, 1391.598145, 8.954241,3);
return 1;
}
public CloseHqIDF3()
{
MoveObject(IDF3,-1908.747437, 1376.474854, 6.204057,2);
return 1;
}
*/
forward SpawnWeaponAndGW(playerid);
public SpawnWeaponAndGW(playerid)
{
if(PlayerInfo[playerid][MP5] > 0)
{
GivePlayerWeapon(playerid,29,PlayerInfo[playerid][Knife]);
}
if(PlayerInfo[playerid][AK47] > 0)
{
GivePlayerWeapon(playerid,30,PlayerInfo[playerid][Knife]);
}

if(PlayerInfo[playerid][Katana] > 0)
{
GivePlayerWeapon(playerid,8,PlayerInfo[playerid][Katana]);
}

if(PlayerInfo[playerid][CombatShotGun] > 0)
{
GivePlayerWeapon(playerid,27,PlayerInfo[playerid][CombatShotGun]);
}
if(PlayerInfo[playerid][CRifle] > 0)
{
GivePlayerWeapon(playerid,34,PlayerInfo[playerid][CRifle]);
}
if(PlayerInfo[playerid][MicroSMG] > 0)
{
GivePlayerWeapon(playerid,28,PlayerInfo[playerid][MicroSMG]);
}
if(PlayerInfo[playerid][Tec9] > 0)
{
GivePlayerWeapon(playerid,32,PlayerInfo[playerid][Tec9]);
}
if(PlayerInfo[playerid][M4] > 0)
{
GivePlayerWeapon(playerid,31,PlayerInfo[playerid][M4]);
}
if(PlayerInfo[playerid][Knife] > 0)
{
GivePlayerWeapon(playerid,4,PlayerInfo[playerid][Knife]);
}
if(PlayerInfo[playerid][Colt] > 0)
{
GivePlayerWeapon(playerid,22,PlayerInfo[playerid][Colt]);
}
if(PlayerInfo[playerid][Sawn] > 0)
{
GivePlayerWeapon(playerid,26,PlayerInfo[playerid][Sawn]);
}
return 1;
}

//==============================================================================
stock GetPlayerXFile(playerid) {
	new string[256];
	format(string,256,"/xadmin/Users/%s.ini",udb_encode(GetName(playerid)));
	return string;
}
//==============================================================================
stock IsPlayerXAdmin(playerid) return (dini_Int(GetPlayerXFile(playerid),"Level") > 1)? 1 : 0;
//==[Trivia]================
public Maths()
{
	new string[256], addsubtext1[10], addsubtext2[10];

	new temp1;

	new number1 = random(100);
	new number2 = random(100);
	new number3 = random(100);
	new addsubnumb1 = random(2);
	new addsubnumb2 = random(2);

	if(addsubnumb1 == 0)
	{
		score = score + 10;

		format(addsubtext1, sizeof(addsubtext1), "-");
		temp1 = number1 - number2;
	}
	else if(addsubnumb1 == 1)
	{
	    score = score + 5;

		format(addsubtext1, sizeof(addsubtext1), "+");
		temp1 = number1 + number2;
	}

	if(addsubnumb2 == 0)
	{
	    score = score + 10;

		format(addsubtext2, sizeof(addsubtext2), "-");
		answer = temp1 - number3;
	}
	else if(addsubnumb2 == 1)
	{
		score = score + 5;

		format(addsubtext2, sizeof(addsubtext2), "+");
		answer = temp1 + number3;
	}
	
	format(string, sizeof(string), "Matematika - %d%s%d%s%d.",number1, addsubtext1, number2, addsubtext2, number3);
    SendClientMessageToAll(COLOR_GREEN, string);
    SendClientMessageToAll(COLOR_PINK,"/ha [Answer] :על מנת לענות על חידון החשבון בצע/י");
	answered = 0;
	return 1;
}

forward CountkilljumpJumpKill();
public CountkilljumpJumpKill()
{
    if(RaceJumpKill != -1 && IsPlayerInVehicle(RaceJumpKill, Motor))
        {
            Countkilljump++;
            if(Countkilljump == 1) GameTextForPlayer(RaceJumpKill, "~w~4", 3000, 6);
            if(Countkilljump == 2) GameTextForPlayer(RaceJumpKill, "~w~3", 3000, 6);
            if(Countkilljump == 3) GameTextForPlayer(RaceJumpKill, "~w~2", 3000, 6);
            if(Countkilljump == 4) GameTextForPlayer(RaceJumpKill, "~w~1", 3000, 6);
            if(Countkilljump == 5)
            {
                KillTimer(TimerJumpkill1);
                TimerJumpkill1 = -1;
                GameTextForPlayer(RaceJumpKill, "~y~Go!", 2000, 6);
                        TogglePlayerControllable(RaceJumpKill, 1);
                MaxTimer = SetTimer("MaxTime", 1000, 1);
                TimerJumpkill2 = SetTimer("CheckForLine", 100, 1);
                        TimeLeft = 20;
                }
        }
}

forward CheckForLine();
public CheckForLine()
{
    if(RaceJumpKill != -1 && IsPlayerInVehicle(RaceJumpKill, Motor))
        {
            new Float:X, Float:Y, Float:Z;
                GetPlayerPos(RaceJumpKill, X, Y, Z);
            if(X < 51.191391)
                {
                    if(IsBikeInArea(Motor, -100.0912, 2497.1504, 55.191391, 2508.6316))
                        {
                            KillTimer(TimerJumpkill2);
                            TimerJumpkill2 = -1;
                            KillTimer(MaxTimer);
                            MaxTimer = -1;
                            TimerJumpkill3 = SetTimer("CheckForLanding", 20, 1);
                        }
                }
        }
}


forward CheckForLanding();
public CheckForLanding()
{
        if(RaceJumpKill != -1 && IsPlayerInVehicle(RaceJumpKill, Motor))
        {
                new Float:X, Float:Y, Float:Z, tmpX;
                GetPlayerPos(RaceJumpKill, X, Y, Z);
            tmpX = floatround(X);
            if(tmpX != LasttmpX)
            {
                LasttmpX = tmpX;
                        ExplotionCheck(tmpX);
                }
                if(!IsBikeInArea(Motor, -100.0912, 2497.1504, 55.191391, 2508.6316))
                {
                    GameTextForPlayer(RaceJumpKill, "~r~Failed!", 5000, 6);
                        KillTimer(TimerJumpkill3);
                        SetTimer("EndJumpKill", 5000, 0);
                }
                format(TDS4, sizeof(TDS4), "Distance : %.4f~n~Time Left: 0:%02d", floatsub(51.191391, X), TimeLeft);
                TextDrawHideForPlayer(RaceJumpKill, TD3);
                TextDrawSetString(TD3, TDS4);
                TextDrawShowForPlayer(RaceJumpKill, TD3);
                if(Z < 17.53)
                {
                    KillTimer(TimerJumpkill3);
                    TimerJumpkill3 = -1;
                    Distance = floatsub(51.191391, X);
                        if(Distance > HS[0]) //Player = 1st
                        {
                            HS[2] = HS[1];
                            HS[1] = HS[0];
                            HS[0] = Distance;
                            HSN[2] = HSN[1];
                            HSN[1] = HSN[0];
                            GetPlayerName(RaceJumpKill, HSN[0], MAX_PLAYER_NAME);
                        }
                        else if(Distance > HS[1] && Distance <= HS[0]) //Player = 2nd
                        {
                            HS[2] = HS[1];
                            HS[1] = Distance;
                                HSN[2] = HSN[1];
                            GetPlayerName(RaceJumpKill, HSN[1], MAX_PLAYER_NAME);
                        }
                        else if(Distance > HS[2] && Distance <= HS[1]) //Player = 3rd
                        {
                            HS[2] = Distance;
                            GetPlayerName(RaceJumpKill, HSN[2], MAX_PLAYER_NAME);
                        }
                        if(Distance > dini_Float(PERSONALFILE, GetName(RaceJumpKill)))
                        {
                            dini_FloatSet(PERSONALFILE, GetName(RaceJumpKill), Distance);
                        }

						new str[256];
                SendClientMessage(RaceJumpKill, COLOR_WHITE, ":רשימת האנשים שעשו את קפיצה ההתאבדות בצורה הטובה ביותר");
                format(str, 128, "#1:   %.4f     %s", HS[0], HSN[0]);
                SendClientMessage(RaceJumpKill, COLOR_PINK, str);
                format(str, 128, "#2:   %.4f     %s", HS[1], HSN[1]);
                SendClientMessage(RaceJumpKill, COLOR_PINK, str);
                format(str, 128, "#3:   %.4f     %s", HS[2], HSN[2]);
                SendClientMessage(RaceJumpKill, COLOR_PINK, str);
                SendClientMessage(RaceJumpKill, COLOR_PINK, " ");
                format(str, 128, "%.4f :השיא שלך", dini_Float(PERSONALFILE, GetName(RaceJumpKill)));
                SendClientMessage(RaceJumpKill, COLOR_PINK, str);
                        SetTimer("EndJumpKill", 5*1000, 0);
                        SetPlayerCameraPos(RaceJumpKill, -121.3866, 2504.7371, 30.0306);
                        SetPlayerCameraLookAt(RaceJumpKill, X, Y, Z);
                }
        }
        return 1;
}

IsBikeInArea(Bike, Float:MinX, Float:MinY, Float:MaxX, Float:MaxY)
{
        new Float:X1, Float:Y1, Float:Z1;

        GetVehiclePos(Bike, X1, Y1, Z1);
        if(X1 >= MinX && X1 <= MaxX&& Y1 >= MinY && Y1 <= MaxY)
        {
                return 1;
        }
        return 0;
}

stock RemoveAllPlayersFromVehicle(vehicleID)
{
        for(new i; i<MAX_PLAYERS; i++)
        {
            if(IsPlayerConnected(i))
                {
                    if(IsPlayerInVehicle(i, vehicleID))
                        {
                            RemovePlayerFromVehicle(i);
                        }
                }
        }
}

forward EndJumpKill();
public EndJumpKill()
{
        if(TimerJumpkill1 != -1)
        {
        KillTimer(TimerJumpkill1);
        TimerJumpkill1 = -1;
        }
        if(TimerJumpkill2 != -1)
        {
        KillTimer(TimerJumpkill2);
        TimerJumpkill2 = -1;
        }
        if(TimerJumpkill3 != -1)
        {
        KillTimer(TimerJumpkill3);
        TimerJumpkill3 = -1;
        }
        if(MaxTimer != -1)
        {
            KillTimer(MaxTimer);
            MaxTimer = -1;
        }

        RemoveAllPlayersFromVehicle(Motor);
        DestroyVehicle(Motor);

        TextDrawHideForPlayer(RaceJumpKill, TD3);
        for(new i; i<45; i++)
        {
        DestroyPlayerObject(RaceJumpKill,DestroyPlayerObject2[i]);
        }
        SetCameraBehindPlayer(RaceJumpKill);
        RaceJumpKill = -1;
}

forward MaxTime();
public MaxTime()
{
        TimeLeft--;
        format(TDS4, sizeof(TDS4), "Distance : 0.0000~n~Time Left: 0:%02d", TimeLeft);
        TextDrawHideForPlayer(RaceJumpKill, TD3);
        TextDrawSetString(TD3, TDS4);
        TextDrawShowForPlayer(RaceJumpKill, TD3);
        if(TimeLeft == 0)
        {
            KillTimer(MaxTimer);
            MaxTimer = -1;
            KillTimer(TimerJumpkill3);
                GameTextForPlayer(RaceJumpKill, "~r~Time's Up!", 5000, 6);
                SetTimer("EndJumpKill", 5000, 0);
        }
}
ExplotionCheck(XX)
{
        if(48 < XX < 52){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
        else if(38 < XX < 42){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5);}
        else if(28 < XX < 32){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
        else if(18 < XX < 22){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
        else if(8 < XX < 12){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
        else if(-2 < XX < 2){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
        else if(-12 < XX < -8){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
        else if(-22 < XX < -18){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
        else if(-32 < XX < -28){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
        else if(-42 < XX < -38){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
        else if(-52 < XX < -48){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
        else if(-62 < XX < -58){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
        else if(-72 < XX < -68){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
        else if(-82 < XX < -78){ CreateExplosion(XX-30, 2508.6316, 18.0, 11, 5); CreateExplosion(XX-30, 2497.1504, 18.0, 11, 5); }
}






//==
stock ClanError(playerid,level){
if(level == 2)return SendClientMessage(playerid, WHITE,".פקודה זאתי משמשת שחקנים ברמה קלאן של 2 ומעלה");
if(level == 3)return SendClientMessage(playerid, WHITE,".פקודה זאתי משמשת שחקנים ברמה קלאן של 3 ומעלה");
SendClientMessage(playerid, WHITE,".אין לך גישה לפקודה זאתי");
return 1;
}


stock ReturnPlayerID(PlayerName[]) {
        for(new i = 0; i < GetMaxPlayers(); i++) if(IsPlayerConnected(i)) { new name[24]; GetPlayerName(i,name,24); if(strfind(name,PlayerName,true)!=-1) return i; }
        return INVALID_PLAYER_ID;
}
//stock IsNumeric(string[]) { for (new i = 0, j = strlen(string); i < j; i++) if (string[i] > '9' || string[i] < '0') return 0; return 1; }

forward ClanColor();
public ClanColor()
{
fnm
if(strcmp(dini_Get(GetPlayerFile(i),"Clan"),"None.",true)){
format(file,256,"Clans/%s.ini",dini_Get(GetPlayerFile(i),"Clan"));
if(dini_Int(file,"Color") == 1)SetPlayerColor(i,0xFF9900AA);
else if(dini_Int(file,"Color") == 2)SetPlayerColor(i,0x6DC5F3AA);
else if(dini_Int(file,"Color") == 3)SetPlayerColor(i,0xFF0000AA);
else if(dini_Int(file,"Color") == 4)SetPlayerColor(i,0x24FF0AAA);
else if(dini_Int(file,"Color") == 5)SetPlayerColor(i,0x330066AA);
else if(dini_Int(file,"Color") == 6)SetPlayerColor(i,0xFF66FFAA);
else if(dini_Int(file,"Color") == 7)SetPlayerColor(i,0x0000BBAA);
else if(dini_Int(file,"Color") == 8)SetPlayerColor(i,0x7CFC00AA);
else if(dini_Int(file,"Color") == 9)SetPlayerColor(i,0xDC143CAA);
else if(dini_Int(file,"Color") == 10)SetPlayerColor(i,0x00FFFFAA);
else if(dini_Int(file,"Color") == 11)SetPlayerColor(i,0x008D00AA);
else if(dini_Int(file,"Color") == 12)SetPlayerColor(i,0x00FFFFAA);
else if(dini_Int(file,"Color") == 13)SetPlayerColor(i,0x6495EDAA);
else if(dini_Int(file,"Color") == 14)SetPlayerColor(i,0xFFFF00AA);
else if(dini_Int(file,"Color") == 15)SetPlayerColor(i,0xEECFA1AA);
else if(dini_Int(file,"Color") == 16)SetPlayerColor(i,0xDDDD23AA);
else if(dini_Int(file,"Color") == 17)SetPlayerColor(i,0x4B00B0AA);
else if(dini_Int(file,"Color") == 18)SetPlayerColor(i,0x99FFFFAA);
else if(dini_Int(file,"Color") == 19)SetPlayerColor(i,0x006400AA);
else if(dini_Int(file,"Color") == 20)SetPlayerColor(i,0xC715FFAA);
}
}
return 1;
}


//------------------------------------------------------------------------------
forward CityRaceingStart();
public CityRaceingStart()
{
new string[256];
SendClientMessageToAll(0xFFFFFFAA,"»»»~ | מערכת המירוצים - מירוץ ערים מיוחד | »»»~");
SendClientMessageToAll(0x00FFFFAA, "! נפתחה הרשמה לקרב מירוצים, סוג מירוץ ערים: ערים הזדרזו להירשם");
format(string,sizeof(string),".$3000 :המנצח יזכה בפרס כספי של");
SendClientMessageToAll(0x00FFFFAA,string);
SendClientMessageToAll(0x16EB43FF, "/CityRace :יש לכם 15 שניות להצטרף, להצטרפות רשמו");
SendClientMessageToAll(0xFFFFFFAA,"»»»~ | מערכת המירוצים - מירוץ ערים מיוחד | »»»~");
//CityRaceingWinner = 1;
CityRaceingPlayers = 0;
 CountCityRaceingr = 15; CountCityRaceingrdown();
return 1;
}


forward CountCityRaceingrdown();
public CountCityRaceingrdown()
{
for(new i = 0; i < MAX_PLAYERS; i++) if (IsPlayerConnected(i) && InCityRaceing[i])  PlayerPlaySound(i,1058, 0.0, 0.0, 0.0);
if (CountCityRaceingr > 0)
{
new String[256];
format(String, 256,"~w~%d",CountCityRaceingr);
GameTextForAll(String,1000,6);
--CountCityRaceingr;
return SetTimer("CountCityRaceingrdown", 1000, 0);
}

if (CountCityRaceingr < 1)
{
for (new i=0; i<200; i++)
{
if (InCityRaceing[i] == 1 || InCityRaceing2[i] == 1)
{
TogglePlayerControllable(i, true);
CityRaceingOn = 5;
GameTextForPlayer(i,"~g~GO!",1000,6);
}
}
}

return 1;
}

forward RemovePlayerFromRaces(playerid);
public RemovePlayerFromRaces(playerid)
{
if(InCityRaceing[playerid] > 0)
{
InCityRaceing[playerid] = 0;
CityCP[playerid] = 0;
CityRaceingPlayers --;
DisablePlayerRaceCheckpoint(playerid);
SetPlayerVirtualWorld(playerid,1);
TogglePlayerControllable(playerid,1);
if(IsPlayerInAnyVehicle(playerid))
{
SetVehicleVirtualWorld(GetPlayerVehicleID(playerid),1);
}
}
//LOS SANTOS
if(InCityRaceing2[playerid] > 0)
{
InCityRaceing2[playerid] = 0;
CityCP[playerid] = 0;
CityRaceingPlayers --;
DisablePlayerRaceCheckpoint(playerid);
SetPlayerVirtualWorld(playerid,1);
TogglePlayerControllable(playerid,1);
if(IsPlayerInAnyVehicle(playerid))
{
SetVehicleVirtualWorld(GetPlayerVehicleID(playerid),1);
}
}
return 1;
}

//-=-=-=-=-=-=-=-


//==================================GreStart====================================
forward GreStart2();
public GreStart2() {
new string[256];

SendClientMessageToAll(COLOR_WHITE,"[_____________גאטר - רימונים_____________]");
SendClientMessageToAll(0xF6F658FF, "! נפתחה הרשמה לקרב מאורגן, הזדרזו להירשם");
format(string,sizeof(string),".$10,000 :פרס למנצח מתחיל מסכום של");
SendClientMessageToAll(0xF6F658FF,string);
SendClientMessageToAll(0x0F6A0FF, "/Gre :יש לכם 60 שניות להצטרף, להצטרפות רשמו");
SendClientMessageToAll(COLOR_WHITE,"----------------------------------");

GreOn = 1; GrePlayers = 0;
CountGrellenge = 60; CountGrellengedown(); CountGrellengeFuc = 1;
GreSECX = SetTimer("GreSECX",1000, 1);
return 1; }
//==================================CountGrellengedown===================================
forward CountGrellengedown();
public CountGrellengedown() {
if(CountGrellenge == 30) {
SendClientMessageToAll(COLOR_WHITE, "More 15 sec start the Gre Weapon to join do: /Gre");
} else if(CountGrellenge == 15) {
SendClientMessageToAll(COLOR_WHITE, "More 15 sec start the Gre Weapon to join do: /Gre"); }
new String[256];
format(String, 256,"~w~%d",CountGrellenge);
for(new i = 0; i < MAX_PLAYERS; i++)
PlayerPlaySound(i,1058, 0.0, 0.0, 0.0);
GameTextForAll(String,1000,6);
if(CountGrellenge > 0) {
--CountGrellenge;
SetTimer("CountGrellengedown", 1000, 0);
} else {
if(CountGrellengeFuc == 1) {
TeleportPlayerToGre();
if(GreKnoob == 1) {
CountGrellenge = 10; CountGrellengedown(); CountGrellengeFuc = 2;
} }
if(CountGrellengeFuc == 2 && CountGrellenge <= 0) {
UFALLGre();
} } }
//==================================UFALLGre====================================
forward UFALLGre();
public UFALLGre() {
for(new i;i<MAX_PLAYERS;i++) {
if(PGrein[i] == 1) {
TogglePlayerControllable(i, 1);
SetCameraBehindPlayer(i);
} } }
//=============================TeleportPlayerToGre==============================
forward TeleportPlayerToGre();
public TeleportPlayerToGre() {
if(GrePlayers < MinGrePlayers)
{
GreEnd(0);
return 1;
}
for(new i;i<MAX_PLAYERS;i++)
{
if(InGre[i] == 1)
{
SendClientMessage(i,lblue,".המלחמת רימונים תתחיל בעוד מספר שניות");
new rand = random(sizeof(GreSpawn));
SetPlayerPos(i, GreSpawn[rand][0], GreSpawn[rand][1], GreSpawn[rand][2]);
ResetPlayerWeapons(i);
ResetPlayerWeapons(i);
SetPlayerArmour(i, 100.0);
SetPlayerHealth(i, 100.0);
GivePlayerWeapon(i,16,10000);
GreStart = 1; PGrein[i] = 1; GreKnoob = 1;
TogglePlayerControllable(i, 0);
GreTIME = SetTimer("Greck",1000, 1);
} }
return 1; }

forward GreEnd(status);
public GreEnd(status) {
if(status == 0) {
SendClientMessageToAll(COLOR_WHITE, ".המלחמת רימונים בוטלה, סיבה: חוסר משתתפים ");
GreOn = 0; GrePlayers = 0;
KillTimer(GreTIME);
KillTimer(GreSECX);
for(new i;i<MAX_PLAYERS;i++) {
InGre[i] = 0;  PGrein[i] = 0; GreStart = 0; GreKnoob = 0;
} return 1; }
else if(status == 1) {
GreOn = 0; GrePlayers = 0;
LACY_GiveMoney(GreWinner, GrePras);
GetPlayerName(GreWinner, playername, sizeof(playername));
format(kboobGre, sizeof(kboobGre), "~W~ The Winner Is ~n~~r~%s", playername);
GameTextForAll(kboobGre, 4000, 1);
KillTimer(GreTIME);
KillTimer(GreSECX);
ResetPlayerWeapons(GreWinner);
SetPlayerInterior(GreWinner, 0);
new rand = random(sizeof(gRandomPlayerSpawns));
SetPlayerPos(GreWinner, gRandomPlayerSpawns[rand][0], gRandomPlayerSpawns[rand][1], gRandomPlayerSpawns[rand][2]); // Warp the player

SendClientMessageToAll(COLOR_WHITE,"[________ גאטר רימונים - מנצח ________]");
SendClientMessageToAll(0xE21E1EFF, "!הקרב הסתיים");
format(kboobGre, sizeof(kboobGre), "$%d :נישאר אחרון וקיבל פרס %s", GrePras, playername);
SendClientMessageToAll(0xE21E1EFF, kboobGre);
SendClientMessageToAll(COLOR_WHITE,"--------------------------------------");


format(kboobGre, sizeof(kboobGre), "$%d אתה ניצחת במלחמת רימונים, קיבלת", GrePras);
SendClientMessage(GreWinner, lblue, kboobGre);
for(new i;i<MAX_PLAYERS;i++) {
InGre[i] = 0; GreStart = 0; PGrein[i] = 0; GreKnoob = 0;
} return 1; }
else if(status == 2) {
format(kboobGre, sizeof(kboobGre), ".ביטל את המלחמת רימונים \"%s\" האדמין ", Greadminsname);
SendClientMessageToAll(lblue, kboobGre);
GrePlayers = 0;
GreKnoob = 0; GreStart = 0;
GreOn = 0;
CountGrellenge = 0; CountGrellengeFuc = 0;
KillTimer(GreTIME);
KillTimer(GreSECX);
for(new i;i<MAX_PLAYERS;i++) {
InGre[i] = 0; PGrein[i] = 0;
} return 1; }
return 1; }

//===================================Greck======================================
forward Greck();
public Greck() {
if(GreStart == 1) {
if(GrePlayers == 1) {
for(new i;i<MAX_PLAYERS;i++) {
if(InGre[i] == 1) {
GreWinner = i; GreEnd(1);
} } } } return 1; }


forward SaveFileRLSB();
public SaveFileRLSB()
{
fnm
if(dini_Exists(GetPlayerFile(i)) && IsPlayerLogged(i))
{
pia[i][CarID] = dini_Int(GetPlayerFile(i),"CarID");
pia[i][OwnCar] = dini_Int(GetPlayerFile(i),"OwnCar");
PlayerInfo[i][Bank] = dini_Int(GetPlayerFile(i),"Bank");
dini_IntSet(GetPlayerFile(i),"BSHIP",PlayerInfo[i][BSHIP]);
dini_IntSet(GetPlayerFile(i),"Tor",PlayerInfo[i][Tor]);
dini_IntSet(GetPlayerFile(i),"Dolphin",PlayerInfo[i][Dolp]);
dini_IntSet(GetPlayerFile(i),"Pets",PlayerInfo[i][Pets]);
dini_IntSet(GetPlayerFile(i),"Shark",PlayerInfo[i][Shark]);
dini_IntSet(GetPlayerFile(i),"SharkKills",PlayerInfo[i][SharkKills]);
dini_IntSet(GetPlayerFile(i),"TorKills",PlayerInfo[i][TorKills]);
dini_IntSet(GetPlayerFile(i),"DolphinKills",PlayerInfo[i][DolphinKills]);
dini_IntSet(GetPlayerFile(i),"ProfileLogeed",PlayerInfo[i][ProfileLogged]);
dini_IntSet(GetPlayerFile(i),"Kills",PlayerInfo[i][Kills]);
dini_IntSet(GetPlayerFile(i),"Deaths",PlayerInfo[i][Deaths]);
dini_IntSet(GetPlayerFile(i),"Level",PlayerInfo[i][Level]);
dini_IntSet(GetPlayerFile(i),"GemelLogin",PlayerInfo[i][GemelLogin]);
dini_IntSet(GetPlayerFile(i),"KopatGemel",PlayerInfo[i][KopatGemel]);
dini_IntSet(GetPlayerFile(i),"AggInfo",PlayerInfo[i][AggInfo]);
dini_IntSet(GetPlayerFile(i),"aLevelnl",PlayerInfo[i][aLevelnl]);
dini_IntSet(GetPlayerFile(i),"aKillsnl",PlayerInfo[i][aKillsnl]);
dini_IntSet(GetPlayerFile(i),"Adminl",PlayerInfo[i][AdminsLevel]);
dini_IntSet(GetPlayerFile(i),"Wars",PlayerInfo[i][Wars]);
dini_IntSet(GetPlayerFile(i),"Karts",PlayerInfo[i][Kart]);
dini_IntSet(GetPlayerFile(i),"MonsterWin",PlayerInfo[i][Monster]);
dini_IntSet(GetPlayerFile(i),"RPGWIN",PlayerInfo[i][RPGS]);
dini_IntSet(GetPlayerFile(i),"MiniWin",PlayerInfo[i][MINIGUN]);
dini_IntSet(GetPlayerFile(i),"mlg",PlayerInfo[i][Mlg]);
dini_IntSet(GetPlayerFile(i),"Warning",PlayerInfo[i][Warnings]);
dini_IntSet(GetPlayerFile(i),"pWeeds",PlayerInfo[i][Weeds]);
dini_IntSet(GetPlayerFile(i),"TimeOnServer",PlayerInfo[i][TimeOnServer]);
dini_IntSet(GetPlayerFile(i),"Money",GetPlayerMoney(i));
dini_IntSet(GetPlayerFile(i),"autologins",PlayerInfo[i][autologin]);
dini_IntSet(GetPlayerFile(i),"GetAloan",PlayerInfo[i][GetAloan]);
dini_IntSet(GetPlayerFile(i),"MoneyLoan",PlayerInfo[i][MoneyLoan]);
dini_IntSet(GetPlayerFile(i),"armour",PlayerInfo[i][armourT]);
dini_IntSet(GetPlayerFile(i),"VIP",PlayerInfo[i][VIPS]);
dini_IntSet(GetPlayerFile(i),"CC",PlayerInfo[i][CcMode]);
dini_IntSet(GetPlayerFile(i),"SaveStrika",PlayerInfo[i][AirStrikeSaved]);
dini_FloatSet(GetPlayerFile(i),"xAir",PlayerInfo[i][xAirStrike]);
dini_FloatSet(GetPlayerFile(i),"yAir",PlayerInfo[i][yAirStrike]);
dini_FloatSet(GetPlayerFile(i),"zAir",PlayerInfo[i][zAirStrike]);
dini_IntSet(GetPlayerFile(i),"CarID",pia[i][CarID] );
dini_IntSet(GetPlayerFile(i),"OwnCar",pia[i][OwnCar] );
dini_IntSet(GetPlayerFile(i),"CarID",pia[i][CarID] );
dini_IntSet(GetPlayerFile(i),"OwnCar",pia[i][OwnCar] );
}
}
return 1;
}
//=[Props]
stock LoadProperties()
{
	if(fexist("PropertySystem/ProPotion.txt"))
	{
	    CountProperties();
		new Argument[9][70];
		new entry[256], BoughtProps;
		new File: propfile = fopen("PropertySystem/ProPotion.txt", io_read);
	    if (propfile)
		{
		    for(new id; id<PropertiesAmount; id++)
			{
				fread(propfile, entry);
				splitprop(entry, Argument, ',');
				format(PropInfo[id][PropName], 64, "%s", Argument[0]);
				PropInfo[id][PropX] = floatstr(Argument[1]);
				PropInfo[id][PropY] = floatstr(Argument[2]);
				PropInfo[id][PropZ] = floatstr(Argument[3]);
				PropInfo[id][PropValue] = strval(Argument[4]);
				PropInfo[id][PropEarning] = strval(Argument[5]);
				format(PropInfo[id][PropOwner], MAX_PLAYER_NAME, "%s", Argument[6]);
				PropInfo[id][PropIsBought] = strval(Argument[7]);
				PropInfo[id][PropUnbuyableTime] = strval(Argument[8]);
				PropInfo[id][PickupNr] = CreatePickup(1273, 1, PropInfo[id][PropX], PropInfo[id][PropY], PropInfo[id][PropZ]);
    			if(PropInfo[id][PropIsBought] == 1)
				{
				    BoughtProps++;
				}
			}
			fclose(propfile);
			printf("===================================");
			printf("||    Created %d Properties     ||", PropertiesAmount);
			printf("||%d of the properties are bought||", BoughtProps);
			printf("===================================");
		}
	}
}

stock SaveProperties()
{
	new entry[256];
	new File: propfile = fopen("PropertySystem/ProPotion.txt", io_write);
	for(new id; id<PropertiesAmount; id++)
	{
	    format(entry, 128, "%s,%.2f,%.2f,%.2f,%d,%d,%s,%d,%d \r\n",PropInfo[id][PropName], PropInfo[id][PropX], PropInfo[id][PropY], PropInfo[id][PropZ], PropInfo[id][PropValue], PropInfo[id][PropEarning], PropInfo[id][PropOwner], PropInfo[id][PropIsBought], PropInfo[id][PropUnbuyableTime]);
		fwrite(propfile, entry);
	}
	printf("Saved %d Properties!", PropertiesAmount);
	fclose(propfile);
}

forward splitprop(const strsrc[], strdest[][], delimiter);
public splitprop(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc)){
	    if(strsrc[i]==delimiter || i==strlen(strsrc)){
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}

stock CountProperties()
{
    new entry[256];
	new File: propfile = fopen("PropertySystem/ProPotion.txt", io_read);
	while(fread(propfile, entry, 256))
	{
		PropertiesAmount++;
  	}
  	fclose(propfile);
}

forward IsPlayerNearProperty(playerid);
public IsPlayerNearProperty(playerid)
{
	new Float:Distances;
	for(new prop; prop<PropertiesAmount; prop++)
	{
	    Distances = GetDistanceToProperty(playerid, prop);
	    if(Distances < 1.0)
	    {
	        return prop;
		}
	}
	return -1;
}

forward Float:GetDistanceToProperty(playerid, Property);
public Float:GetDistanceToProperty(playerid, Property)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	GetPlayerPos(playerid,x1,y1,z1);
	x2 = PropInfo[Property][PropX];
	y2 = PropInfo[Property][PropY];
	z2 = PropInfo[Property][PropZ];
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}

stock GetPlayerID(const Name[])
{
	for(new i; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        new pName[MAX_PLAYER_NAME];
			GetPlayerName(i, pName, sizeof(pName));
	        if(strcmp(Name, pName, true)==0)
	        {
	            return i;
			}
		}
	}
	return -1;
}

stock SendClientMessageToAllEx(exeption, color, const message[])
{
	for(new i; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(i != exeption)
		    {
		        SendClientMessage(i, color, message);
			}
		}
	}
}

forward UpdateUnbuyableTime();
public UpdateUnbuyableTime()
{
	for(new propid; propid<PropertiesAmount; propid++)
	{
	    if(PropInfo[propid][PropIsBought] == 1)
	    {
			if(PropInfo[propid][PropUnbuyableTime] > 0)
			{
	        	PropInfo[propid][PropUnbuyableTime]--;
			}
		}
	}
}


forward MapIconStreamer();
public MapIconStreamer()
{
	for(new i; i<MaximuxPlayer; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        new Float:SmallestDistance = 99999.9;
	        new CP, Float:OldDistance;
	        for(new propid; propid<PropertiesAmount; propid++)
	        {
	            OldDistance = GetDistanceToProperty(i, propid);
	            if(OldDistance < SmallestDistance)
	            {
	                SmallestDistance = OldDistance;
	                CP = propid;
				}
			}
			RemovePlayerMapIcon(i, 31);
			if(PropInfo[CP][PropIsBought] == 1)
			{
                SetPlayerMapIcon(i, 31, PropInfo[CP][PropX], PropInfo[CP][PropY], PropInfo[CP][PropZ], 32, 0);
			}
			else
			{
			    SetPlayerMapIcon(i, 31, PropInfo[CP][PropX], PropInfo[CP][PropY], PropInfo[CP][PropZ], 31, 0);
			}
		}
	}
}

forward PropertyPayout();
public PropertyPayout()
{
	new str[64];
	for(new i; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(PlayerProps[i] > 0)
	        {
	            LACY_GiveMoney(i, EarningsForPlayer[i]);
				format(str, 64, ".$%d הרווחת מהנכסים שלך כ,", EarningsForPlayer[i]);
				SendClientMessage(i, COLOR_LIGHTGREEN, str);
			}
		}
	}
}
