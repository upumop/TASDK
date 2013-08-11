module UnrealScript.TribesGame.TrGame;

import ScriptClasses;
import UnrealScript.TribesGame.TrSeekingMissileManager;
import UnrealScript.Engine.Controller;
import UnrealScript.Engine.Pawn;
import UnrealScript.UTGame.UTCharInfo;
import UnrealScript.Engine.OnlineSubsystem;
import UnrealScript.Engine.NavigationPoint;
import UnrealScript.Engine.PlayerController;
import UnrealScript.Engine.PlayerReplicationInfo;
import UnrealScript.Engine.Actor;
import UnrealScript.UTGame.UTPlayerReplicationInfo;
import UnrealScript.TribesGame.TrPlayerController;
import UnrealScript.UTGame.UTTeamGame;
import UnrealScript.TribesGame.TrStatsInterface;
import UnrealScript.UTGame.UTBot;
import UnrealScript.UTGame.UTTeamInfo;
import UnrealScript.TribesGame.TrPowerGenerator;

extern(C++) interface TrGame : UTTeamGame
{
	public static immutable auto MAX_CLASS_SLOTS = 10;
	public static immutable auto TR_QUERY_CTF = 0;
	public static immutable auto TR_QUERY_TDM = 1;
	public static immutable auto TR_QUERY_RABBIT = 2;
	public static immutable auto TR_QUERY_TEAMRABBIT = 3;
	public static immutable auto TR_QUERY_ARENA = 4;
	public static immutable auto TR_QUERY_DEFENDANDDESTROY = 5;
	public static immutable auto TR_QUERY_CTFBLITZ = 6;
	public static immutable auto CONTEXT_GAME_MODE_TRCTF = 0;
	public static immutable auto CONTEXT_GAME_MODE_TRTDM = 1;
	public static immutable auto CONTEXT_GAME_MODE_TRRABBIT = 2;
	public static immutable auto CONTEXT_GAME_MODE_TRSIEGE = 3;
	public static immutable auto CONTEXT_GAME_MODE_TRTRAINING = 4;
	public static immutable auto CONTEXT_GAME_MODE_TRSTORM = 5;
	public static immutable auto CONTEXT_GAME_MODE_TRTEAMRABBIT = 6;
	public static immutable auto CONTEXT_GAME_MODE_TRARENA = 7;
	public static immutable auto CONTEXT_GAME_MODE_TRDEFENDANDDESTROY = 8;
	public static immutable auto CONTEXT_GAME_MODE_TRCAPTUREANDHOLD = 9;
	public static immutable auto CONTEXT_GAME_MODE_TRCTFBLITZ = 10;
	public static immutable auto STAT_VIEW_BASE_PLAYER = 1;
	public static immutable auto STAT_VIEW_BASE_GAME = 101;
	public static immutable auto STAT_VIEW_BASE_WEAPON_TYPE = 1000;
	public static immutable auto GAME_SESSION_NAME = "Gam";
	public static immutable auto PROPERTY_CUSTOM_MAPNAME = 0x40000001;
	public static immutable auto PROPERTY_CUSTOM_GAMEMODE = 0x40000002;
	public static immutable auto PROPERTY_SERVER_DESCRIPTION = 0x40000003;
	public static immutable auto PROPERTY_CUSTOM_MUTATORS = 0x40000004;
	public static immutable auto CLASS_TYPE_UNKNOWN = 1668;
	public static immutable auto CLASS_TYPE_LIGHT_INFILTRATOR = 1682;
	public static immutable auto CLASS_TYPE_LIGHT_JUMPER = 1696;
	public static immutable auto CLASS_TYPE_LIGHT_ARCHITECT = 1697;
	public static immutable auto CLASS_TYPE_LIGHT_PATHFINDER = 1683;
	public static immutable auto CLASS_TYPE_LIGHT_NAKEDPATHFINDER = 1701;
	public static immutable auto CLASS_TYPE_LIGHT_WRAITH = 1685;
	public static immutable auto CLASS_TYPE_LIGHT_SENTINEL = 1686;
	public static immutable auto CLASS_TYPE_MEDIUM_ENGINEER = 1698;
	public static immutable auto CLASS_TYPE_MEDIUM_RANGER = 1687;
	public static immutable auto CLASS_TYPE_MEDIUM_SCRAMBLER = 1688;
	public static immutable auto CLASS_TYPE_MEDIUM_SOLDIER = 1693;
	public static immutable auto CLASS_TYPE_MEDIUM_RAIDER = 1699;
	public static immutable auto CLASS_TYPE_MEDIUM_TECHNICIAN = 1694;
	public static immutable auto CLASS_TYPE_MEDIUM_WARDER = 1700;
	public static immutable auto CLASS_TYPE_HEAVY_BRUTE = 1689;
	public static immutable auto CLASS_TYPE_HEAVY_ROOK = 1690;
	public static immutable auto CLASS_TYPE_HEAVY_DOOMBRINGER = 1691;
	public static immutable auto CLASS_TYPE_HEAVY_JUGGERNAUGHT = 1692;
	public static immutable auto CLASS_TYPE_HEAVY_MARAUDER = 1695;
	public static immutable auto CLASS_PURCHASE_LIGHT_INFILTRATOR = 7476;
	public static immutable auto CLASS_PURCHASE_LIGHT_PATHFINDER = 7466;
	public static immutable auto CLASS_PURCHASE_LIGHT_SENTINEL = 7478;
	public static immutable auto CLASS_PURCHASE_MEDIUM_SOLDIER = 7470;
	public static immutable auto CLASS_PURCHASE_MEDIUM_RAIDER = 7494;
	public static immutable auto CLASS_PURCHASE_MEDIUM_TECHNICIAN = 7472;
	public static immutable auto CLASS_PURCHASE_HEAVY_BRUTE = 7486;
	public static immutable auto CLASS_PURCHASE_HEAVY_DOOMBRINGER = 7488;
	public static immutable auto CLASS_PURCHASE_HEAVY_JUGGERNAUGHT = 7474;
	public static immutable auto CLASS_INFO_BIT_NONE = 0x00000000;
	public static immutable auto CLASS_INFO_BIT_INFILTRATOR = 0x00000001;
	public static immutable auto CLASS_INFO_BIT_JUMPER = 0x00000002;
	public static immutable auto CLASS_INFO_BIT_ARCHITECT = 0x00000004;
	public static immutable auto CLASS_INFO_BIT_PATHFINDER = 0x00000008;
	public static immutable auto CLASS_INFO_BIT_WRAITH = 0x00000010;
	public static immutable auto CLASS_INFO_BIT_SENTINEL = 0x00000020;
	public static immutable auto CLASS_INFO_BIT_ENGINEER = 0x00000040;
	public static immutable auto CLASS_INFO_BIT_RANGER = 0x00000080;
	public static immutable auto CLASS_INFO_BIT_SCRAMBLER = 0x00000100;
	public static immutable auto CLASS_INFO_BIT_SOLDIER = 0x00000200;
	public static immutable auto CLASS_INFO_BIT_RAIDER = 0x00000400;
	public static immutable auto CLASS_INFO_BIT_TECHNICIAN = 0x00000800;
	public static immutable auto CLASS_INFO_BIT_WARDER = 0x00001000;
	public static immutable auto CLASS_INFO_BIT_BRUTE = 0x00002000;
	public static immutable auto CLASS_INFO_BIT_ROOK = 0x00004000;
	public static immutable auto CLASS_INFO_BIT_DOOMBRINGER = 0x00008000;
	public static immutable auto CLASS_INFO_BIT_JUGGERNAUT = 0x00010000;
	public static immutable auto CLASS_INFO_BIT_MARAUDER = 0x00020000;
	public static immutable auto CLASS_INFO_BIT_NAKEDPATHFINDER = 0x00040000;
	public static immutable auto WEAPON_ID_UNKNOWN = 102000;
	public static immutable auto WEAPON_ID_AVMINE = 102003;
	public static immutable auto WEAPON_ID_DUALRHINO = 102024;
	public static immutable auto WEAPON_ID_LACERATOR = 102016;
	public static immutable auto WEAPON_ID_ARX_BUSTER = 7384;
	public static immutable auto WEAPON_ID_CHAINGUN = 7386;
	public static immutable auto WEAPON_ID_DROPJAMMER = 7456;
	public static immutable auto WEAPON_ID_FORCEFIELD = 7411;
	public static immutable auto WEAPON_ID_FORCEFIELD_PERSONAL = 7460;
	public static immutable auto WEAPON_ID_GRENADE = 7390;
	public static immutable auto WEAPON_ID_GRENADE_AP = 7434;
	public static immutable auto WEAPON_ID_GRENADE_AP_HEAVY = 7447;
	public static immutable auto WEAPON_ID_GRENADE_EMP = 7444;
	public static immutable auto WEAPON_ID_GRENADE_FLARE = 7389;
	public static immutable auto WEAPON_ID_GRENADE_NITRON = 7387;
	public static immutable auto WEAPON_ID_GRENADE_NITRON_HEAVY = 7450;
	public static immutable auto WEAPON_ID_GRENADE_SPIKE = 7428;
	public static immutable auto WEAPON_ID_GRENADE_ST = 7437;
	public static immutable auto WEAPON_ID_GRENADE_STICKY = 7402;
	public static immutable auto WEAPON_ID_GRENADE_STICKY_LIGHT = 7455;
	public static immutable auto WEAPON_ID_GRENADE_WHITEOUT = 7432;
	public static immutable auto WEAPON_ID_GRENADE_XL = 7430;
	public static immutable auto WEAPON_ID_GUNNER_BEOWULF = 7405;
	public static immutable auto WEAPON_ID_GUNNER_HERC = 7404;
	public static immutable auto WEAPON_ID_LAUNCHER_BOLT = 7425;
	public static immutable auto WEAPON_ID_LAUNCHER_BOLT_HEAVY = 7452;
	public static immutable auto WEAPON_ID_LAUNCHER_GRENADE = 7416;
	public static immutable auto WEAPON_ID_LAUNCHER_MIRV = 7457;
	public static immutable auto WEAPON_ID_LAUNCHER_MORTAR = 7393;
	public static immutable auto WEAPON_ID_LAUNCHER_SABER = 7398;
	public static immutable auto WEAPON_ID_MELEE = 7391;
	public static immutable auto WEAPON_ID_MINE = 7392;
	public static immutable auto WEAPON_ID_MINE_CLAYMORE = 7421;
	public static immutable auto WEAPON_ID_MINE_PRISM = 7440;
	public static immutable auto WEAPON_ID_MOTIONALARM = 7426;
	public static immutable auto WEAPON_ID_PILOT_BEOWULF = 7406;
	public static immutable auto WEAPON_ID_PILOT_GRAVCYCLE = 7410;
	public static immutable auto WEAPON_ID_PILOT_HAVOC = 7409;
	public static immutable auto WEAPON_ID_PILOT_HERC = 7403;
	public static immutable auto WEAPON_ID_PILOT_SHRIKE = 7407;
	public static immutable auto WEAPON_ID_PISTOL_EAGLE = 7388;
	public static immutable auto WEAPON_ID_PISTOL_EAGLE_CUSTOM = 7439;
	public static immutable auto WEAPON_ID_PISTOL_NOVA_COLT = 7394;
	public static immutable auto WEAPON_ID_PISTOL_NOVA_SLUG = 7431;
	public static immutable auto WEAPON_ID_PISTOL_FALCON = 7419;
	public static immutable auto WEAPON_ID_PISTOL_H1 = 7435;
	public static immutable auto WEAPON_ID_PISTOL_SN7 = 7418;
	public static immutable auto WEAPON_ID_PISTOL_SPARROW = 7433;
	public static immutable auto WEAPON_ID_TURRET_EXR = 7417;
	public static immutable auto WEAPON_ID_TURRET_BASE = 7412;
	public static immutable auto WEAPON_ID_TURRET_LIGHT = 7413;
	public static immutable auto WEAPON_ID_TURRET_WALL = 7445;
	public static immutable auto WEAPON_ID_REPAIR_TOOL = 7396;
	public static immutable auto WEAPON_ID_REPAIR_TOOL_SD = 7436;
	public static immutable auto WEAPON_ID_RIFLE_ASSAULT = 7385;
	public static immutable auto WEAPON_ID_RIFLE_ASSAULT_LIGHT = 7438;
	public static immutable auto WEAPON_ID_RIFLE_ASSAULT_S22 = 7424;
	public static immutable auto WEAPON_ID_RIFLE_ASSAULT_X1 = 7458;
	public static immutable auto WEAPON_ID_RIFLE_PHASE = 7395;
	public static immutable auto WEAPON_ID_RIFLE_SNIPER = 7400;
	public static immutable auto WEAPON_ID_SMG_NJ4 = 7441;
	public static immutable auto WEAPON_ID_SMG_RHINO = 7397;
	public static immutable auto WEAPON_ID_SMG_TCN4 = 7443;
	public static immutable auto WEAPON_ID_SHOTGUN = 7399;
	public static immutable auto WEAPON_ID_SHOTGUN_ARX = 7454;
	public static immutable auto WEAPON_ID_SHOTGUN_AUTO = 7449;
	public static immutable auto WEAPON_ID_SHOTGUN_SAWED_OFF = 7427;
	public static immutable auto WEAPON_ID_SPINFUSOR = 7401;
	public static immutable auto WEAPON_ID_SPINFUSOR_D = 7446;
	public static immutable auto WEAPON_ID_SPINFUSOR_HEAVY = 7448;
	public static immutable auto WEAPON_ID_SPINFUSOR_LIGHT = 7422;
	public static immutable auto WEAPON_ID_SPINFUSOR_TOSS = 7459;
	public static immutable auto WEAPON_ID_CALLIN_TACTICALSTRIKE = 7609;
	public static immutable auto WEAPON_ID_CALLIN_INVENTORYDROP = 7610;
	public static immutable auto WEAPON_ID_CALLIN_ORBITALSTRIKE = 7611;
	public static immutable auto WEAPON_ID_TCNG = 7736;
	public static immutable auto WEAPON_ID_FALLING = 7815;
	public static immutable auto WEAPON_ID_HITWALL = 7816;
	public static immutable auto WEAPON_ID_RANOVER = 7817;
	public static immutable auto WEAPON_ID_THUMPER = 7461;
	public static immutable auto WEAPON_ID_THUMPER_D = 7462;
	public static immutable auto WEAPON_ID_STEALTHLIGHTSPINFUSOR = 7902;
	public static immutable auto WEAPON_ID_GRENADE_T5 = 7914;
	public static immutable auto WEAPON_ID_PROXIMITY_GRENADE = 8222;
	public static immutable auto WEAPON_ID_INFILTRATORBLANK = 8230;
	public static immutable auto WEAPON_ID_ACCURIZEDSHOTGUN = 8239;
	public static immutable auto WEAPON_ID_MINE_ARMOREDCLAYMORE = 8240;
	public static immutable auto WEAPON_ID_BUCKLER = 8242;
	public static immutable auto WEAPON_ID_IMPACTBOMBLETS = 8244;
	public static immutable auto WEAPON_ID_LIGHTTWINFUSOR = 8245;
	public static immutable auto WEAPON_ID_LR1MORTAR = 8246;
	public static immutable auto WEAPON_ID_MIRV_GRENADE = 8247;
	public static immutable auto WEAPON_ID_GRENADE_NINJASMOKE = 8248;
	public static immutable auto WEAPON_ID_NJ5SMG = 8249;
	public static immutable auto WEAPON_ID_PLASMA_CANNON = 8250;
	public static immutable auto WEAPON_ID_PLASMA_GUN = 8251;
	public static immutable auto WEAPON_ID_REMOTE_ARX_BUSTER = 8252;
	public static immutable auto WEAPON_ID_ROCKETLAUNCHER = 8253;
	public static immutable auto WEAPON_ID_SAP20 = 8254;
	public static immutable auto WEAPON_ID_THROWINGKNIVES = 8256;
	public static immutable auto WEAPON_ID_TWINFUSOR = 8257;
	public static immutable auto WEAPON_ID_HEAVYTWINFUSOR = 8656;
	public static immutable auto WEAPON_ID_SPIKELAUNCHER = 8357;
	public static immutable auto WEAPON_ID_TARGETINGBEACON = 8358;
	public static immutable auto ITEM_PACK_AMMO = 7821;
	public static immutable auto ITEM_PACK_BLINK = 7822;
	public static immutable auto ITEM_PACK_DAMAGE = 7823;
	public static immutable auto ITEM_PACK_ENERGY_SOLDIER = 7824;
	public static immutable auto ITEM_PACK_ENERGY_JUGGERNAUT = 7901;
	public static immutable auto ITEM_PACK_ENERGY_BRUTE = 7830;
	public static immutable auto ITEM_PACK_RECHARGE_PATHFINDER = 7825;
	public static immutable auto ITEM_PACK_RECHARGE_SENTINEL = 7900;
	public static immutable auto ITEM_PACK_HEAVYSHIELD = 7826;
	public static immutable auto ITEM_PACK_JAMMER = 7827;
	public static immutable auto ITEM_PACK_LIGHTREGEN = 7828;
	public static immutable auto ITEM_PACK_POWERPOOL = 7829;
	public static immutable auto ITEM_PACK_MINORENERGY = 7830;
	public static immutable auto ITEM_PACK_REGEN = 7831;
	public static immutable auto ITEM_PACK_SHIELD = 7832;
	public static immutable auto ITEM_PACK_STEALTH = 7833;
	public static immutable auto ITEM_PACK_UTILITY_SOLDIER = 8223;
	public static immutable auto ITEM_PACK_HIGHSPEEDSTEALTH = 8243;
	public static immutable auto ITEM_PACK_SURVIVAL = 8255;
	public static immutable auto WEAPON_BASE_UNKNOWN = 0;
	public static immutable auto WEAPON_BASE_SPINFUSOR = 1;
	public static immutable auto WEAPON_BASE_PISTOL = 2;
	public static immutable auto WEAPON_BASE_SNIPERRIFLE = 3;
	public static immutable auto WEAPON_BASE_ASSAULTRIFLE = 4;
	public static immutable auto WEAPON_BASE_GRENADE = 5;
	public static immutable auto WEAPON_BASE_REPAIRTOOL = 6;
	public static immutable auto WEAPON_BASE_CALLIN = 7;
	public static immutable auto WEAPON_BASE_SMG = 8;
	public static immutable auto WEAPON_BASE_SHOTGUN = 9;
	public static immutable auto WEAPON_BASE_VEHICLE = 10;
	public static immutable auto WEAPON_TYPE_UNKNOWN = 0;
	public static immutable auto WEAPON_TYPE_PROJECTILE = 1;
	public static immutable auto WEAPON_TYPE_INSTANTFIRE = 2;
	public static immutable auto ITEM_PERK_BOUNTYHUNTER = 8153;
	public static immutable auto ITEM_PERK_CLOSECOMBAT = 8156;
	public static immutable auto ITEM_PERK_DETERMINATION = 8157;
	public static immutable auto ITEM_PERK_EGOCENTRIC = 7917;
	public static immutable auto ITEM_PERK_LOOTER = 8158;
	public static immutable auto ITEM_PERK_MECHANIC = 8170;
	public static immutable auto ITEM_PERK_PILOT = 8159;
	public static immutable auto ITEM_PERK_POTENTIALENERGY = 8160;
	public static immutable auto ITEM_PERK_QUICKDRAW = 8161;
	public static immutable auto ITEM_PERK_REACH = 7916;
	public static immutable auto ITEM_PERK_SAFEFALL = 8162;
	public static immutable auto ITEM_PERK_SAFETYTHIRD = 8163;
	public static immutable auto ITEM_PERK_STEALTHY = 8164;
	public static immutable auto ITEM_PERK_SUPERCAPACITOR = 8165;
	public static immutable auto ITEM_PERK_SUPERHEAVY = 8166;
	public static immutable auto ITEM_PERK_SURVIVALIST = 8167;
	public static immutable auto ITEM_PERK_ULTRACAPACITOR = 8168;
	public static immutable auto ITEM_PERK_WHEELDEAL = 8169;
	public static immutable auto ITEM_PERK_RAGE = 8232;
	public static immutable auto ITEM_PERK_SONICPUNCH = 8231;
	public static immutable auto ITEM_PERK_LIGHTWEIGHT = 8646;
	public static immutable auto ITEM_SKILL_PATHFINDER_PRIMARY_AMMO_I = 7508;
	public static immutable auto ITEM_SKILL_PATHFINDER_PRIMARY_AMMO_II = 7637;
	public static immutable auto ITEM_SKILL_PATHFINDER_PRIMARY_ANTIARMOR = 7509;
	public static immutable auto ITEM_SKILL_PATHFINDER_SECONDARY_AMMO_I = 7638;
	public static immutable auto ITEM_SKILL_PATHFINDER_SECONDARY_AMMO_II = 7640;
	public static immutable auto ITEM_SKILL_PATHFINDER_SECONDARY_CLIP = 7639;
	public static immutable auto ITEM_SKILL_PATHFINDER_SECONDARY_FALLOFF = 7641;
	public static immutable auto ITEM_SKILL_PATHFINDER_GRENADE_AMMO = 7504;
	public static immutable auto ITEM_SKILL_PATHFINDER_GRENADE_RADIUS = 7505;
	public static immutable auto ITEM_SKILL_PATHFINDER_HEALTH_POOL = 7636;
	public static immutable auto ITEM_SKILL_PATHFINDER_HEALTH_REGEN_RATE = 7507;
	public static immutable auto ITEM_SKILL_PATHFINDER_HEALTH_REGEN_DELAY = 7506;
	public static immutable auto ITEM_SKILL_PATHFINDER_ENERGY_REGEN_I = 7501;
	public static immutable auto ITEM_SKILL_PATHFINDER_ENERGY_REGEN_II = 7635;
	public static immutable auto ITEM_SKILL_PATHFINDER_SPEED_I = 7502;
	public static immutable auto ITEM_SKILL_PATHFINDER_SPEED_II = 7503;
	public static immutable auto ITEM_SKILL_PATHFINDER_GROUND_SPEED = 7754;
	public static immutable auto ITEM_SKILL_PATHFINDER_STOP_DISTANCE = 7755;
	public static immutable auto ITEM_SKILL_JUMPER_PRIMARY_AMMO_I = 7564;
	public static immutable auto ITEM_SKILL_JUMPER_PRIMARY_AMMO_II = 7646;
	public static immutable auto ITEM_SKILL_JUMPER_PRIMARY_ANTIARMOR = 7645;
	public static immutable auto ITEM_SKILL_JUMPER_SECONDARY_AMMO = 7647;
	public static immutable auto ITEM_SKILL_JUMPER_SECONDARY_RELOAD = 7565;
	public static immutable auto ITEM_SKILL_JUMPER_SECONDARY_FALLOFF = 7648;
	public static immutable auto ITEM_SKILL_JUMPER_GRENADE_AMMO = 7563;
	public static immutable auto ITEM_SKILL_JUMPER_PACK_COST_I = 7558;
	public static immutable auto ITEM_SKILL_JUMPER_PACK_COST_II = 7643;
	public static immutable auto ITEM_SKILL_JUMPER_PACK_POTENCY = 7560;
	public static immutable auto ITEM_SKILL_JUMPER_HEALTH_POOL = 7562;
	public static immutable auto ITEM_SKILL_JUMPER_HEALTH_REGEN_RATE = 7644;
	public static immutable auto ITEM_SKILL_JUMPER_HEALTH_REGEN_DELAY = 7561;
	public static immutable auto ITEM_SKILL_JUMPER_ENERGY_POOL = 7642;
	public static immutable auto ITEM_SKILL_JUMPER_CONTROL = 7557;
	public static immutable auto ITEM_SKILL_JUMPER_SPEED = 7559;
	public static immutable auto ITEM_SKILL_JUMPER_GROUND_SPEED = 7756;
	public static immutable auto ITEM_SKILL_JUMPER_STOP_DISTANCE = 7757;
	public static immutable auto ITEM_SKILL_SOLDIER_PRIMARY_AMMO_I = 7551;
	public static immutable auto ITEM_SKILL_SOLDIER_PRIMARY_AMMO_II = 7667;
	public static immutable auto ITEM_SKILL_SOLDIER_PRIMARY_ANTIARMOR = 7552;
	public static immutable auto ITEM_SKILL_SOLDIER_SECONDARY_AMMO = 7670;
	public static immutable auto ITEM_SKILL_SOLDIER_SECONDARY_CLIP = 7671;
	public static immutable auto ITEM_SKILL_SOLDIER_SECONDARY_RELOAD = 7556;
	public static immutable auto ITEM_SKILL_SOLDIER_GRENADE_AMMO = 7540;
	public static immutable auto ITEM_SKILL_SOLDIER_HEALTH_POOL_I = 7555;
	public static immutable auto ITEM_SKILL_SOLDIER_HEALTH_POOL_II = 7668;
	public static immutable auto ITEM_SKILL_SOLDIER_HEALTH_REGEN_RATE = 7669;
	public static immutable auto ITEM_SKILL_SOLDIER_HEALTH_REGEN_DELAY = 7554;
	public static immutable auto ITEM_SKILL_SOLDIER_ENERGY_POOL_I = 7541;
	public static immutable auto ITEM_SKILL_SOLDIER_ENERGY_POOL_II = 7665;
	public static immutable auto ITEM_SKILL_SOLDIER_CONTROL = 7664;
	public static immutable auto ITEM_SKILL_SOLDIER_SPEED_I = 7548;
	public static immutable auto ITEM_SKILL_SOLDIER_SPEED_II = 7666;
	public static immutable auto ITEM_SKILL_SOLDIER_GROUND_SPEED = 7759;
	public static immutable auto ITEM_SKILL_SOLDIER_STOP_DISTANCE = 7760;
	public static immutable auto ITEM_SKILL_SOLDIER_WEAPON_SWITCH = 7761;
	public static immutable auto ITEM_SKILL_JUGGERNAUGHT_PRIMARY_AMMO_I = 7568;
	public static immutable auto ITEM_SKILL_JUGGERNAUGHT_PRIMARY_AMMO_II = 7658;
	public static immutable auto ITEM_SKILL_JUGGERNAUGHT_PRIMARY_ANTIARMOR = 7569;
	public static immutable auto ITEM_SKILL_JUGGERNAUGHT_SECONDARY_AMMO_I = 7573;
	public static immutable auto ITEM_SKILL_JUGGERNAUGHT_SECONDARY_AMMO_II = 7660;
	public static immutable auto ITEM_SKILL_JUGGERNAUGHT_SECONDARY_ANTIARMOR = 7574;
	public static immutable auto ITEM_SKILL_JUGGERNAUGHT_GRENADE_AMMO_I = 7566;
	public static immutable auto ITEM_SKILL_JUGGERNAUGHT_GRENADE_AMMO_II = 7663;
	public static immutable auto ITEM_SKILL_JUGGERNAUGHT_GRENADE_RADIUS = 7662;
	public static immutable auto ITEM_SKILL_JUGGERNAUGHT_HEALTH_POOL_I = 7576;
	public static immutable auto ITEM_SKILL_JUGGERNAUGHT_HEALTH_POOL_II = 7661;
	public static immutable auto ITEM_SKILL_JUGGERNAUGHT_ENERGY_POOL_I = 7572;
	public static immutable auto ITEM_SKILL_JUGGERNAUGHT_ENERGY_POOL_II = 7659;
	public static immutable auto ITEM_SKILL_JUGGERNAUGHT_HEALTH_REGEN_DELAY = 7575;
	public static immutable auto ITEM_SKILL_JUGGERNAUGHT_CONTROL = 7657;
	public static immutable auto ITEM_SKILL_JUGGERNAUGHT_SPEED = 7570;
	public static immutable auto ITEM_SKILL_JUGGERNAUGHT_GROUND_SPEED = 7770;
	public static immutable auto ITEM_SKILL_JUGGERNAUGHT_WEAPON_SWITCH = 7771;
	public static immutable auto ITEM_SKILL_TECHNICIAN_PRIMARY_AMMO = 7685;
	public static immutable auto ITEM_SKILL_TECHNICIAN_PRIMARY_RELOAD = 7686;
	public static immutable auto ITEM_SKILL_TECHNICIAN_REPAIR_RATE_I = 7519;
	public static immutable auto ITEM_SKILL_TECHNICIAN_REPAIR_RATE_II = 7681;
	public static immutable auto ITEM_SKILL_TECHNICIAN_GRENADE_AMMO_I = 7518;
	public static immutable auto ITEM_SKILL_TECHNICIAN_GRENADE_AMMO_II = 7687;
	public static immutable auto ITEM_SKILL_TECHNICIAN_DEPLOY_ACQUIRE = 7512;
	public static immutable auto ITEM_SKILL_TECHNICIAN_DEPLOY_LIMIT = 7513;
	public static immutable auto ITEM_SKILL_TECHNICIAN_DEPLOY_ANTIARMOR = 7514;
	public static immutable auto ITEM_SKILL_TECHNICIAN_HEALTH_POOL_I = 7520;
	public static immutable auto ITEM_SKILL_TECHNICIAN_HEALTH_POOL_II = 7684;
	public static immutable auto ITEM_SKILL_TECHNICIAN_HEALTH_REGEN_DELAY = 7516;
	public static immutable auto ITEM_SKILL_TECHNICIAN_ENERGY_POOL = 7515;
	public static immutable auto ITEM_SKILL_TECHNICIAN_CONTROL = 7517;
	public static immutable auto ITEM_SKILL_TECHNICIAN_SPEED_I = 7682;
	public static immutable auto ITEM_SKILL_TECHNICIAN_SPEED_II = 7683;
	public static immutable auto ITEM_SKILL_TECHNICIAN_GROUND_SPEED = 7765;
	public static immutable auto ITEM_SKILL_TECHNICIAN_STOP_DISTANCE = 7766;
	public static immutable auto ITEM_SKILL_TECHNICIAN_WEAPON_SWITCH = 7767;
	public static immutable auto ITEM_SKILL_SENTINEL_PRIMARY_AMMO_I = 7528;
	public static immutable auto ITEM_SKILL_SENTINEL_PRIMARY_AMMO_II = 7655;
	public static immutable auto ITEM_SKILL_SENTINEL_PRIMARY_CLIP = 7654;
	public static immutable auto ITEM_SKILL_SENTINEL_PRIMARY_FALLOFF = 7529;
	public static immutable auto ITEM_SKILL_SENTINEL_SECONDARY_AMMO = 7651;
	public static immutable auto ITEM_SKILL_SENTINEL_SECONDARY_CLIP = 7652;
	public static immutable auto ITEM_SKILL_SENTINEL_GRENADE_AMMO = 7527;
	public static immutable auto ITEM_SKILL_SENTINEL_GRENADE_RADIUS = 7656;
	public static immutable auto ITEM_SKILL_SENTINEL_DEPLOY_HEALTH = 7649;
	public static immutable auto ITEM_SKILL_SENTINEL_DEPLOY_RADIUS_I = 7521;
	public static immutable auto ITEM_SKILL_SENTINEL_DEPLOY_RADIUS_II = 7650;
	public static immutable auto ITEM_SKILL_SENTINEL_HEALTH_REGEN_RATE = 7526;
	public static immutable auto ITEM_SKILL_SENTINEL_HEALTH_REGEN_DELAY = 7525;
	public static immutable auto ITEM_SKILL_SENTINEL_ENERGY_POOL_I = 7523;
	public static immutable auto ITEM_SKILL_SENTINEL_ENERGY_POOL_II = 7653;
	public static immutable auto ITEM_SKILL_SENTINEL_SPEED = 7524;
	public static immutable auto ITEM_SKILL_SENTINEL_WEAPON_SWITCH = 7758;
	public static immutable auto ITEM_SKILL_RANGER_PRIMARY_AMMO = 7679;
	public static immutable auto ITEM_SKILL_RANGER_PRIMARY_CLIP = 7680;
	public static immutable auto ITEM_SKILL_RANGER_PRIMARY_RELOAD = 7582;
	public static immutable auto ITEM_SKILL_RANGER_SECONDARY_AMMO_I = 7581;
	public static immutable auto ITEM_SKILL_RANGER_SECONDARY_AMMO_II = 7675;
	public static immutable auto ITEM_SKILL_RANGER_SECONDARY_ANTIARMOR = 7674;
	public static immutable auto ITEM_SKILL_RANGER_GRENADE_AMMO_I = 7580;
	public static immutable auto ITEM_SKILL_RANGER_GRENADE_AMMO_II = 7677;
	public static immutable auto ITEM_SKILL_RANGER_PACK_COST = 7583;
	public static immutable auto ITEM_SKILL_RANGER_HEALTH_POOL_I = 7585;
	public static immutable auto ITEM_SKILL_RANGER_HEALTH_POOL_II = 7676;
	public static immutable auto ITEM_SKILL_RANGER_HEALTH_REGEN_DELAY = 7584;
	public static immutable auto ITEM_SKILL_RANGER_ENERGY_POOL_I = 7577;
	public static immutable auto ITEM_SKILL_RANGER_ENERGY_POOL_II = 7678;
	public static immutable auto ITEM_SKILL_RANGER_CONTROL = 7672;
	public static immutable auto ITEM_SKILL_RANGER_SPEED_I = 7578;
	public static immutable auto ITEM_SKILL_RANGER_SPEED_II = 7673;
	public static immutable auto ITEM_SKILL_RANGER_GROUND_SPEED = 7762;
	public static immutable auto ITEM_SKILL_RANGER_STOP_DISTANCE = 7763;
	public static immutable auto ITEM_SKILL_RANGER_WEAPON_SWITCH = 7764;
	public static immutable auto ITEM_SKILL_DOOMBRINGER_PRIMARY_AMMO_I = 7598;
	public static immutable auto ITEM_SKILL_DOOMBRINGER_PRIMARY_AMMO_II = 7632;
	public static immutable auto ITEM_SKILL_DOOMBRINGER_PRIMARY_SPINUP = 7597;
	public static immutable auto ITEM_SKILL_DOOMBRINGER_GRENADE_AMMO_I = 7590;
	public static immutable auto ITEM_SKILL_DOOMBRINGER_GRENADE_AMMO_II = 7634;
	public static immutable auto ITEM_SKILL_DOOMBRINGER_DEPLOY_AMMO = 7591;
	public static immutable auto ITEM_SKILL_DOOMBRINGER_GRENADE_ANTIARMOR = 7633;
	public static immutable auto ITEM_SKILL_DOOMBRINGER_DEPLOY_HEALTH_I = 7592;
	public static immutable auto ITEM_SKILL_DOOMBRINGER_DEPLOY_HEALTH_II = 7629;
	public static immutable auto ITEM_SKILL_DOOMBRINGER_HEALTH_POOL_I = 7596;
	public static immutable auto ITEM_SKILL_DOOMBRINGER_HEALTH_POOL_II = 7631;
	public static immutable auto ITEM_SKILL_DOOMBRINGER_HEALTH_REGEN_DELAY = 7595;
	public static immutable auto ITEM_SKILL_DOOMBRINGER_ENERGY_POOL = 7628;
	public static immutable auto ITEM_SKILL_DOOMBRINGER_CONTROL = 7594;
	public static immutable auto ITEM_SKILL_DOOMBRINGER_SPEED_I = 7593;
	public static immutable auto ITEM_SKILL_DOOMBRINGER_SPEED_II = 7630;
	public static immutable auto ITEM_SKILL_DOOMBRINGER_GROUND_SPEED = 7772;
	public static immutable auto ITEM_SKILL_DOOMBRINGER_STOP_DISTANCE = 7773;
	public static immutable auto ITEM_SKILL_DOOMBRINGER_WEAPON_SWITCH = 7774;
	public static immutable auto ITEM_SKILL_INFILTRATOR_PRIMARY_AMMO_I = 7612;
	public static immutable auto ITEM_SKILL_INFILTRATOR_PRIMARY_AMMO_II = 7818;
	public static immutable auto ITEM_SKILL_INFILTRATOR_PRIMARY_RELOAD = 7614;
	public static immutable auto ITEM_SKILL_INFILTRATOR_PRIMARY_FALLOFF = 7613;
	public static immutable auto ITEM_SKILL_INFILTRATOR_SECONDARY_AMMO = 7623;
	public static immutable auto ITEM_SKILL_INFILTRATOR_SECONDARY_CLIP = 7625;
	public static immutable auto ITEM_SKILL_INFILTRATOR_SECONDARY_RELOAD = 7624;
	public static immutable auto ITEM_SKILL_INFILTRATOR_GRENADE_AMMO_I = 7615;
	public static immutable auto ITEM_SKILL_INFILTRATOR_GRENADE_AMMO_II = 7618;
	public static immutable auto ITEM_SKILL_INFILTRATOR_GRENADE_RADIUS = 7617;
	public static immutable auto ITEM_SKILL_INFILTRATOR_GRENADE_ANTIARMOR = 7616;
	public static immutable auto ITEM_SKILL_INFILTRATOR_PACK_COST_I = 7620;
	public static immutable auto ITEM_SKILL_INFILTRATOR_PACK_COST_II = 7622;
	public static immutable auto ITEM_SKILL_INFILTRATOR_PACK_POTENCY = 7621;
	public static immutable auto ITEM_SKILL_INFILTRATOR_HEALTH_REGEN_RATE = 7627;
	public static immutable auto ITEM_SKILL_INFILTRATOR_HEALTH_REGEN_DELAY = 7626;
	public static immutable auto ITEM_SKILL_INFILTRATOR_ENERGY_POOL = 7619;
	public static immutable auto ITEM_SKILL_RAIDER_PRIMARY_AMMO = 7688;
	public static immutable auto ITEM_SKILL_RAIDER_PRIMARY_RELOAD = 7690;
	public static immutable auto ITEM_SKILL_RAIDER_PRIMARY_FALLOFF = 7689;
	public static immutable auto ITEM_SKILL_RAIDER_SECONDARY_AMMO = 7691;
	public static immutable auto ITEM_SKILL_RAIDER_SECONDARY_CLIP = 7693;
	public static immutable auto ITEM_SKILL_RAIDER_SECONDARY_ANTIARMOR = 7692;
	public static immutable auto ITEM_SKILL_RAIDER_GRENADE_AMMO = 7694;
	public static immutable auto ITEM_SKILL_RAIDER_GRENADE_EFFECT = 7695;
	public static immutable auto ITEM_SKILL_RAIDER_GRENADE_RADIUS = 7696;
	public static immutable auto ITEM_SKILL_RAIDER_PACK_COST_I = 7700;
	public static immutable auto ITEM_SKILL_RAIDER_PACK_COST_II = 7703;
	public static immutable auto ITEM_SKILL_RAIDER_PACK_POTENCY = 7701;
	public static immutable auto ITEM_SKILL_RAIDER_HEALTH_POOL_I = 7698;
	public static immutable auto ITEM_SKILL_RAIDER_HEALTH_POOL_II = 7699;
	public static immutable auto ITEM_SKILL_RAIDER_HEALTH_REGEN_DELAY = 7697;
	public static immutable auto ITEM_SKILL_RAIDER_ENERGY_POOL = 7702;
	public static immutable auto ITEM_SKILL_BRUTE_ENERGY_POOL = 7723;
	public static immutable auto ITEM_SKILL_BRUTE_GRENADE_AMMO = 7720;
	public static immutable auto ITEM_SKILL_BRUTE_GRENADE_DURATION = 7721;
	public static immutable auto ITEM_SKILL_BRUTE_GRENADE_RADIUS = 7722;
	public static immutable auto ITEM_SKILL_BRUTE_HEALTH_POOL_I = 7729;
	public static immutable auto ITEM_SKILL_BRUTE_HEALTH_POOL_II = 7732;
	public static immutable auto ITEM_SKILL_BRUTE_HEALTH_REGEN_DELAY = 7730;
	public static immutable auto ITEM_SKILL_BRUTE_HEALTH_REGEN_RATE = 7731;
	public static immutable auto ITEM_SKILL_BRUTE_PRIMARY_AMMO_I = 7726;
	public static immutable auto ITEM_SKILL_BRUTE_PRIMARY_AMMO_II = 7728;
	public static immutable auto ITEM_SKILL_BRUTE_PRIMARY_ANTIARMOR = 7727;
	public static immutable auto ITEM_SKILL_BRUTE_SECONARY_AMMO = 7733;
	public static immutable auto ITEM_SKILL_BRUTE_SECONDARY_CLIP = 7735;
	public static immutable auto ITEM_SKILL_BRUTE_SECONDARY_RELOAD = 7734;
	public static immutable auto ITEM_SKILL_BRUTE_CONTROL = 7725;
	public static immutable auto ITEM_SKILL_BRUTE_SPEED = 7724;
	public static immutable auto ITEM_SKILL_BRUTE_GROUND_SPEED = 7775;
	public static immutable auto ITEM_SKILL_BRUTE_WEAPON_SWITCH = 7776;
	public static immutable auto ITEM_SKILL_SCRAMBLER_ENERGY_POOL = 7707;
	public static immutable auto ITEM_SKILL_SCRAMBLER_GRENADE_AMMO = 7704;
	public static immutable auto ITEM_SKILL_SCRAMBLER_GRENADE_DURATION = 7706;
	public static immutable auto ITEM_SKILL_SCRAMBLER_GRENADE_RADIUS = 7705;
	public static immutable auto ITEM_SKILL_SCRAMBLER_HEALTH_POOL_I = 7714;
	public static immutable auto ITEM_SKILL_SCRAMBLER_HEALTH_POOL_II = 7715;
	public static immutable auto ITEM_SKILL_SCRAMBLER_HEALTH_REGEN_DELAY = 7713;
	public static immutable auto ITEM_SKILL_SCRAMBLER_PACK_COST_I = 7716;
	public static immutable auto ITEM_SKILL_SCRAMBLER_PACK_COST_II = 7718;
	public static immutable auto ITEM_SKILL_SCRAMBLER_PACK_EFFECTIVENESS_I = 7717;
	public static immutable auto ITEM_SKILL_SCRAMBLER_PACK_EFFECTIVENESS_II = 7719;
	public static immutable auto ITEM_SKILL_SCRAMBLER_PRIMARY_AMMO_I = 7710;
	public static immutable auto ITEM_SKILL_SCRAMBLER_PRIMARY_AMMO_II = 7712;
	public static immutable auto ITEM_SKILL_SCRAMBLER_PRIMARY_ANTIARMOR = 7711;
	public static immutable auto ITEM_SKILL_SCRAMBLER_CONTROL = 7709;
	public static immutable auto ITEM_SKILL_SCRAMBLER_SPEED = 7708;
	public static immutable auto ITEM_SKILL_SCRAMBLER_GROUND_SPEED = 7768;
	public static immutable auto ITEM_SKILL_SCRAMBLER_WEAPON_SWITCH = 7769;
	public static immutable auto ITEM_SKILL_WRAITH_ENERGY_POOL = 7790;
	public static immutable auto ITEM_SKILL_WRAITH_ENERGY_REGEN_I = 7781;
	public static immutable auto ITEM_SKILL_WRAITH_ENERGY_REGEN_II = 7783;
	public static immutable auto ITEM_SKILL_WRAITH_GRENADE_AMMO = 7788;
	public static immutable auto ITEM_SKILL_WRAITH_GRENADE_RADIUS = 7789;
	public static immutable auto ITEM_SKILL_WRAITH_GROUND_SPEED = 7782;
	public static immutable auto ITEM_SKILL_WRAITH_HEALTH_REGEN_DELAY = 7791;
	public static immutable auto ITEM_SKILL_WRAITH_HEALTH_REGEN_RATE = 7792;
	public static immutable auto ITEM_SKILL_WRAITH_PRIMARY_AMMO_I = 7793;
	public static immutable auto ITEM_SKILL_WRAITH_PRIMARY_AMMO_II = 7796;
	public static immutable auto ITEM_SKILL_WRAITH_PRIMARY_CLIP = 7795;
	public static immutable auto ITEM_SKILL_WRAITH_PRIMARY_ENERGY_COST = 7794;
	public static immutable auto ITEM_SKILL_WRAITH_SECONDARY_AMMO = 7784;
	public static immutable auto ITEM_SKILL_WRAITH_SECONDARY_CLIP_I = 7785;
	public static immutable auto ITEM_SKILL_WRAITH_SECONDARY_CLIP_II = 7786;
	public static immutable auto ITEM_SKILL_WRAITH_WEAPON_SWITCH = 7787;
	public static immutable auto TR_MAX_CALLINS = 3;
	public static immutable auto PROPERTY_CALLIN_ORBITALSTRIKE = 10241;
	public static immutable auto PROPERTY_CALLIN_TACTICALSTRIKE = 10201;
	public static immutable auto PROPERTY_CALLIN_SUPPORTINVENTORY = 10234;
	public static immutable auto ITEM_SKIN_PATHFINDER = 7834;
	public static immutable auto ITEM_SKIN_PATHFINDER_MERC = 8326;
	public static immutable auto ITEM_SKIN_INFILTRATOR = 7835;
	public static immutable auto ITEM_SKIN_INFILTRATOR_ASSASSIN = 8337;
	public static immutable auto ITEM_SKIN_INFILTRATOR_MERC = 8336;
	public static immutable auto ITEM_SKIN_SENTINEL = 8327;
	public static immutable auto ITEM_SKIN_SENTINEL_MERC = 8665;
	public static immutable auto ITEM_SKIN_SOLDIER = 8328;
	public static immutable auto ITEM_SKIN_TECHNICIAN = 8329;
	public static immutable auto ITEM_SKIN_TECHNICIAN_MERC = 8731;
	public static immutable auto ITEM_SKIN_RAIDER = 8330;
	public static immutable auto ITEM_SKIN_RAIDER_GRIEVER = 8351;
	public static immutable auto ITEM_SKIN_RAIDER_MERC = 8352;
	public static immutable auto ITEM_SKIN_JUGGERNAUT = 8331;
	public static immutable auto ITEM_SKIN_DOOMBRINGER = 8332;
	public static immutable auto ITEM_SKIN_BRUTE = 8333;
	public static immutable auto ITEM_SKIN_BRUTE_MERC = 8663;
	public static immutable auto ITEM_VOICE_LIGHT_STANDARD = 7903;
	public static immutable auto ITEM_VOICE_MEDIUM_STANDARD = 7904;
	public static immutable auto ITEM_VOICE_HEAVY_STANDARD = 7905;
	public static immutable auto ITEM_ARMOR_MOD_PATHFINDER_1 = 7836;
	public static immutable auto ITEM_ARMOR_MOD_SENTINEL_1 = 7837;
	public static immutable auto ITEM_ARMOR_MOD_INFILTRATOR_1 = 7838;
	public static immutable auto ITEM_ARMOR_MOD_SOLDIER_1 = 7839;
	public static immutable auto ITEM_ARMOR_MOD_TECHNICIAN_1 = 7840;
	public static immutable auto ITEM_ARMOR_MOD_RAIDER_1 = 7841;
	public static immutable auto ITEM_ARMOR_MOD_JUGGERNAUT_1 = 7842;
	public static immutable auto ITEM_ARMOR_MOD_DOOMBRINGER_1 = 7843;
	public static immutable auto ITEM_ARMOR_MOD_BRUTE_1 = 7844;
	public static immutable auto WEAPON_ID_ARX_BUSTER_MKD = 8391;
	public static immutable auto WEAPON_ID_CHAINGUN_MKD = 8392;
	public static immutable auto WEAPON_ID_GRENADE_MKD = 8393;
	public static immutable auto WEAPON_ID_GRENADE_AP_HEAVY_MKD = 8394;
	public static immutable auto WEAPON_ID_GRENADE_EMP_MKD = 8395;
	public static immutable auto WEAPON_ID_GRENADE_NITRON_MKD = 8396;
	public static immutable auto WEAPON_ID_GRENADE_SPIKE_MKD = 8397;
	public static immutable auto WEAPON_ID_GRENADE_STICKY_MKD = 8398;
	public static immutable auto WEAPON_ID_GRENADE_XL_MKD = 8399;
	public static immutable auto WEAPON_ID_LAUNCHER_MORTAR_MKD = 8400;
	public static immutable auto WEAPON_ID_LAUNCHER_SABER_MKD = 8401;
	public static immutable auto WEAPON_ID_MINE_CLAYMORE_MKD = 8402;
	public static immutable auto WEAPON_ID_PISTOL_NOVA_COLT_MKD = 8403;
	public static immutable auto WEAPON_ID_PISTOL_SN7_MKD = 8404;
	public static immutable auto WEAPON_ID_REPAIR_TOOL_SD_MKD = 8405;
	public static immutable auto WEAPON_ID_RIFLE_ASSAULT_MKD = 8406;
	public static immutable auto WEAPON_ID_RIFLE_SNIPER_MKD = 8407;
	public static immutable auto WEAPON_ID_SMG_NJ4_MKD = 8408;
	public static immutable auto WEAPON_ID_SMG_RHINO_MKD = 8409;
	public static immutable auto WEAPON_ID_SMG_TCN4_MKD = 8410;
	public static immutable auto WEAPON_ID_SHOTGUN_MKD = 8411;
	public static immutable auto WEAPON_ID_SHOTGUN_AUTO_MKD = 8412;
	public static immutable auto WEAPON_ID_SPINFUSOR_D_MKD = 8413;
	public static immutable auto WEAPON_ID_SPINFUSOR_HEAVY_MKD = 8414;
	public static immutable auto WEAPON_ID_SPINFUSOR_LIGHT_MKD = 8415;
	public static immutable auto WEAPON_ID_TCNG_MKD = 8416;
	public static immutable auto WEAPON_ID_THUMPERD_MKD = 8417;
	public static immutable auto WEAPON_ID_REPAIR_DEPLOYABLE = 8698;
	public static immutable auto WEAPON_ID_SPINFUSOR_LIGHT_100X = 8696;
	public static immutable auto WEAPON_ID_SPINFUSOR_100X = 8697;
	public static immutable auto WEAPON_ID_TC24 = 8699;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_LIGHTSPINFUSOR_100X_1 = 8700;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_LIGHTSPINFUSOR_100X_2 = 8701;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_LIGHTSPINFUSOR_100X_3 = 8702;
	public static immutable auto ITEM_UPGRADE_SOLDIER_SPINFUSOR_100X_1 = 8703;
	public static immutable auto ITEM_UPGRADE_SOLDIER_SPINFUSOR_100X_2 = 8704;
	public static immutable auto ITEM_UPGRADE_SOLDIER_SPINFUSOR_100X_3 = 8705;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_REPAIR_DEPLOYABLE_1 = 8706;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_REPAIR_DEPLOYABLE_2 = 8707;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_REPAIR_DEPLOYABLE_3 = 8708;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_TC24_1 = 8709;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_TC24_2 = 8710;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_TC24_3 = 8711;
	public static immutable auto ACTIVITY_PATHFINDER_PRIMARY_LIGHTSPINFUSOR_100X = 265;
	public static immutable auto ACTIVITY_TECHNICIAN_BELT_REPAIR_DEPLOYABLE = 266;
	public static immutable auto ACTIVITY_SOLDIER_PRIMARY_SPINFUSOR_100X = 264;
	public static immutable auto ACTIVITY_TECHNICIAN_PRIMARY_TC24 = 267;
	public static immutable auto ACTIVITY_SENTINEL_PRIMARY_SAP20 = 268;
	public static immutable auto ACTIVITY_SENTINEL_SECONDARY_ACCURIZEDSHOTGUN = 269;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_LIGHTSPINFUSOR_MKD_1 = 8418;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_LIGHTSPINFUSOR_MKD_2 = 8419;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_LIGHTSPINFUSOR_MKD_3 = 8420;
	public static immutable auto ITEM_UPGRADE_SENTINEL_BXT1SNIPERRIFLE_MKD_1 = 8421;
	public static immutable auto ITEM_UPGRADE_SENTINEL_BXT1SNIPERRIFLE_MKD_2 = 8422;
	public static immutable auto ITEM_UPGRADE_SENTINEL_BXT1SNIPERRIFLE_MKD_3 = 8423;
	public static immutable auto ITEM_UPGRADE_SENTINEL_BXT1SNIPERRIFLE_MKD_4 = 8424;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_RHINOSMG_MKD_1 = 8425;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_RHINOSMG_MKD_2 = 8426;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_RHINOSMG_MKD_3 = 8427;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_RHINOSMG_MKD_4 = 8428;
	public static immutable auto ITEM_UPGRADE_SOLDIER_ASSAULTRIFLE_MKD_1 = 8429;
	public static immutable auto ITEM_UPGRADE_SOLDIER_ASSAULTRIFLE_MKD_2 = 8430;
	public static immutable auto ITEM_UPGRADE_SOLDIER_ASSAULTRIFLE_MKD_3 = 8431;
	public static immutable auto ITEM_UPGRADE_SOLDIER_ASSAULTRIFLE_MKD_4 = 8432;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_TCN4SMG_MKD_1 = 8433;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_TCN4SMG_MKD_2 = 8434;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_TCN4SMG_MKD_3 = 8435;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_TCN4SMG_MKD_4 = 8436;
	public static immutable auto ITEM_UPGRADE_RAIDER_ARXBUSTER_MKD_1 = 8437;
	public static immutable auto ITEM_UPGRADE_RAIDER_ARXBUSTER_MKD_2 = 8438;
	public static immutable auto ITEM_UPGRADE_RAIDER_ARXBUSTER_MKD_3 = 8439;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_FUSIONMORTAR_MKD_1 = 8440;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_FUSIONMORTAR_MKD_2 = 8441;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_FUSIONMORTAR_MKD_3 = 8442;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_CHAINGUN_MKD_1 = 8443;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_CHAINGUN_MKD_2 = 8444;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_CHAINGUN_MKD_3 = 8445;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_CHAINGUN_MKD_4 = 8446;
	public static immutable auto ITEM_UPGRADE_BRUTE_HEAVYSPINFUSOR_MKD_1 = 8447;
	public static immutable auto ITEM_UPGRADE_BRUTE_HEAVYSPINFUSOR_MKD_2 = 8448;
	public static immutable auto ITEM_UPGRADE_BRUTE_HEAVYSPINFUSOR_MKD_3 = 8449;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_HEAVYTWINFUSOR_1 = 8657;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_HEAVYTWINFUSOR_2 = 8658;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_HEAVYTWINFUSOR_3 = 8659;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_SHOTGUN_MKD_1 = 8450;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_SHOTGUN_MKD_2 = 8451;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_SHOTGUN_MKD_3 = 8452;
	public static immutable auto ITEM_UPGRADE_SENTINEL_NOVABLASTER_MKD_1 = 8453;
	public static immutable auto ITEM_UPGRADE_SENTINEL_NOVABLASTER_MKD_2 = 8454;
	public static immutable auto ITEM_UPGRADE_SENTINEL_NOVABLASTER_MKD_3 = 8455;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_SN7PISTOL_MKD_1 = 8456;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_SN7PISTOL_MKD_2 = 8457;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_SN7PISTOL_MKD_3 = 8458;
	public static immutable auto ITEM_UPGRADE_SOLDIER_THUMPERD_MKD_1 = 8459;
	public static immutable auto ITEM_UPGRADE_SOLDIER_THUMPERD_MKD_2 = 8460;
	public static immutable auto ITEM_UPGRADE_SOLDIER_THUMPERD_MKD_3 = 8461;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_REPAIRTOOLSD_MKD_1 = 8462;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_REPAIRTOOLSD_MKD_2 = 8463;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_REPAIRTOOLSD_MKD_3 = 8464;
	public static immutable auto ITEM_UPGRADE_RAIDER_NJ4SMG_MKD_1 = 8465;
	public static immutable auto ITEM_UPGRADE_RAIDER_NJ4SMG_MKD_2 = 8466;
	public static immutable auto ITEM_UPGRADE_RAIDER_NJ4SMG_MKD_3 = 8467;
	public static immutable auto ITEM_UPGRADE_RAIDER_NJ4SMG_MKD_4 = 8468;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_SPINFUSORD_MKD_1 = 8469;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_SPINFUSORD_MKD_2 = 8470;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_SPINFUSORD_MKD_3 = 8471;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_SABERLAUNCHER_MKD_1 = 8472;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_SABERLAUNCHER_MKD_2 = 8473;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_SABERLAUNCHER_MKD_3 = 8474;
	public static immutable auto ITEM_UPGRADE_BRUTE_AUTOSHOTGUN_MKD_1 = 8475;
	public static immutable auto ITEM_UPGRADE_BRUTE_AUTOSHOTGUN_MKD_2 = 8476;
	public static immutable auto ITEM_UPGRADE_BRUTE_AUTOSHOTGUN_MKD_3 = 8477;
	public static immutable auto ITEM_UPGRADE_BRUTE_AUTOSHOTGUN_MKD_4 = 8478;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_IMPACTNITRON_MKD_1 = 8479;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_IMPACTNITRON_MKD_2 = 8480;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_IMPACTNITRON_MKD_3 = 8481;
	public static immutable auto ITEM_UPGRADE_SENTINEL_CLAYMORE_MKD_1 = 8482;
	public static immutable auto ITEM_UPGRADE_SENTINEL_CLAYMORE_MKD_2 = 8483;
	public static immutable auto ITEM_UPGRADE_SENTINEL_CLAYMORE_MKD_3 = 8484;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_STICKYGRENADE_MKD_1 = 8486;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_STICKYGRENADE_MKD_2 = 8487;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_STICKYGRENADE_MKD_3 = 8488;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_STICKYGRENADE_MKD_4 = 8489;
	public static immutable auto ITEM_UPGRADE_SOLDIER_FRAGGRENADEXL_MKD_1 = 8490;
	public static immutable auto ITEM_UPGRADE_SOLDIER_FRAGGRENADEXL_MKD_2 = 8491;
	public static immutable auto ITEM_UPGRADE_SOLDIER_FRAGGRENADEXL_MKD_3 = 8492;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_TCNGGRENADE_MKD_1 = 8493;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_TCNGGRENADE_MKD_2 = 8494;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_TCNGGRENADE_MKD_3 = 8495;
	public static immutable auto ITEM_UPGRADE_RAIDER_EMPGRENADE_MKD_1 = 8496;
	public static immutable auto ITEM_UPGRADE_RAIDER_EMPGRENADE_MKD_2 = 8497;
	public static immutable auto ITEM_UPGRADE_RAIDER_EMPGRENADE_MKD_3 = 8498;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_HEAVYAPGRENADE_MKD_1 = 8499;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_HEAVYAPGRENADE_MKD_2 = 8500;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_HEAVYAPGRENADE_MKD_3 = 8501;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_GRENADE_MKD_1 = 8502;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_GRENADE_MKD_2 = 8503;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_GRENADE_MKD_3 = 8504;
	public static immutable auto ITEM_UPGRADE_BRUTE_FRACTALGRENADE_MKD_1 = 8505;
	public static immutable auto ITEM_UPGRADE_BRUTE_FRACTALGRENADE_MKD_2 = 8506;
	public static immutable auto ITEM_UPGRADE_BRUTE_FRACTALGRENADE_MKD_3 = 8507;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_BOLTLAUNCHER_1 = 7850;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_BOLTLAUNCHER_2 = 7851;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_BOLTLAUNCHER_3 = 7852;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_LIGHTSPINFUSOR_1 = 7855;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_LIGHTSPINFUSOR_2 = 7860;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_LIGHTSPINFUSOR_3 = 7857;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_LIGHTTWINFUSOR_1 = 8277;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_LIGHTTWINFUSOR_2 = 8278;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_LIGHTTWINFUSOR_3 = 8279;
	public static immutable auto ITEM_UPGRADE_SENTINEL_BXT1SNIPERRIFLE_1 = 7927;
	public static immutable auto ITEM_UPGRADE_SENTINEL_BXT1SNIPERRIFLE_2 = 7929;
	public static immutable auto ITEM_UPGRADE_SENTINEL_BXT1SNIPERRIFLE_3 = 7930;
	public static immutable auto ITEM_UPGRADE_SENTINEL_BXT1SNIPERRIFLE_4 = 7931;
	public static immutable auto ITEM_UPGRADE_SENTINEL_PHASERIFLE_1 = 7932;
	public static immutable auto ITEM_UPGRADE_SENTINEL_PHASERIFLE_2 = 7933;
	public static immutable auto ITEM_UPGRADE_SENTINEL_PHASERIFLE_3 = 7934;
	public static immutable auto ITEM_UPGRADE_SENTINEL_PHASERIFLE_4 = 7935;
	public static immutable auto ITEM_UPGRADE_SENTINEL_SAP20_1 = 8305;
	public static immutable auto ITEM_UPGRADE_SENTINEL_SAP20_2 = 8306;
	public static immutable auto ITEM_UPGRADE_SENTINEL_SAP20_3 = 8307;
	public static immutable auto ITEM_UPGRADE_SENTINEL_SAP20_4 = 8308;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_RHINOSMG_1 = 7960;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_RHINOSMG_2 = 7961;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_RHINOSMG_3 = 7962;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_RHINOSMG_4 = 7963;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_STEALTHLIGHTSPINFUSOR_1 = 7964;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_STEALTHLIGHTSPINFUSOR_2 = 7965;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_STEALTHLIGHTSPINFUSOR_3 = 7966;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_REMOTEARXBUSTER_1 = 8298;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_REMOTEARXBUSTER_2 = 8299;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_REMOTEARXBUSTER_3 = 8300;
	public static immutable auto ITEM_UPGRADE_SOLDIER_ASSAULTRIFLE_1 = 7985;
	public static immutable auto ITEM_UPGRADE_SOLDIER_ASSAULTRIFLE_2 = 7986;
	public static immutable auto ITEM_UPGRADE_SOLDIER_ASSAULTRIFLE_3 = 7987;
	public static immutable auto ITEM_UPGRADE_SOLDIER_ASSAULTRIFLE_4 = 7988;
	public static immutable auto ITEM_UPGRADE_SOLDIER_SPINFUSOR_1 = 7992;
	public static immutable auto ITEM_UPGRADE_SOLDIER_SPINFUSOR_2 = 7993;
	public static immutable auto ITEM_UPGRADE_SOLDIER_SPINFUSOR_3 = 7994;
	public static immutable auto ITEM_UPGRADE_SOLDIER_TWINFUSOR_1 = 8316;
	public static immutable auto ITEM_UPGRADE_SOLDIER_TWINFUSOR_2 = 8317;
	public static immutable auto ITEM_UPGRADE_SOLDIER_TWINFUSOR_3 = 8318;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_TCN4SMG_1 = 8012;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_TCN4SMG_2 = 8013;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_TCN4SMG_3 = 8014;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_TCN4SMG_4 = 8015;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_THUMPER_1 = 8016;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_THUMPER_2 = 8017;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_THUMPER_3 = 8018;
	public static immutable auto ITEM_UPGRADE_RAIDER_GRENADELAUNCHER_1 = 8045;
	public static immutable auto ITEM_UPGRADE_RAIDER_GRENADELAUNCHER_2 = 8046;
	public static immutable auto ITEM_UPGRADE_RAIDER_GRENADELAUNCHER_3 = 8047;
	public static immutable auto ITEM_UPGRADE_RAIDER_ARXBUSTER_1 = 8042;
	public static immutable auto ITEM_UPGRADE_RAIDER_ARXBUSTER_2 = 8043;
	public static immutable auto ITEM_UPGRADE_RAIDER_ARXBUSTER_3 = 8044;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_FUSIONMORTAR_1 = 8070;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_FUSIONMORTAR_2 = 8071;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_FUSIONMORTAR_3 = 8072;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_MIRVLAUNCHER_1 = 8073;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_MIRVLAUNCHER_2 = 8074;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_MIRVLAUNCHER_3 = 8075;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_LR1MORTAR_1 = 8280;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_LR1MORTAR_2 = 8281;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_LR1MORTAR_3 = 8282;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_CHAINGUN_1 = 8100;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_CHAINGUN_2 = 8101;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_CHAINGUN_3 = 8102;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_CHAINGUN_4 = 8103;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_HEAVYBOLTLAUNCHER_1 = 8104;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_HEAVYBOLTLAUNCHER_2 = 8105;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_HEAVYBOLTLAUNCHER_3 = 8106;
	public static immutable auto ITEM_UPGRADE_BRUTE_HEAVYSPINFUSOR_1 = 8124;
	public static immutable auto ITEM_UPGRADE_BRUTE_HEAVYSPINFUSOR_2 = 8125;
	public static immutable auto ITEM_UPGRADE_BRUTE_HEAVYSPINFUSOR_3 = 8126;
	public static immutable auto ITEM_UPGRADE_BRUTE_PLASMACANNON_1 = 8292;
	public static immutable auto ITEM_UPGRADE_BRUTE_PLASMACANNON_2 = 8293;
	public static immutable auto ITEM_UPGRADE_BRUTE_PLASMACANNON_3 = 8294;
	public static immutable auto ITEM_UPGRADE_BRUTE_SPIKELAUNCHER_1 = 8386;
	public static immutable auto ITEM_UPGRADE_BRUTE_SPIKELAUNCHER_2 = 8387;
	public static immutable auto ITEM_UPGRADE_BRUTE_SPIKELAUNCHER_3 = 8388;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_SHOTGUN_1 = 7861;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_SHOTGUN_2 = 7862;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_SHOTGUN_3 = 7863;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_LIGHTASSAULTRIFLE_1 = 7866;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_LIGHTASSAULTRIFLE_2 = 7867;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_LIGHTASSAULTRIFLE_3 = 7868;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_LIGHTASSAULTRIFLE_4 = 7869;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_BUCKLER_1 = 8265;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_BUCKLER_2 = 8266;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_BUCKLER_3 = 8267;
	public static immutable auto ITEM_UPGRADE_SENTINEL_NOVABLASTER_1 = 7936;
	public static immutable auto ITEM_UPGRADE_SENTINEL_NOVABLASTER_2 = 7937;
	public static immutable auto ITEM_UPGRADE_SENTINEL_NOVABLASTER_3 = 7938;
	public static immutable auto ITEM_UPGRADE_SENTINEL_FALCONAUTOPISTOL_1 = 7939;
	public static immutable auto ITEM_UPGRADE_SENTINEL_FALCONAUTOPISTOL_2 = 7940;
	public static immutable auto ITEM_UPGRADE_SENTINEL_FALCONAUTOPISTOL_3 = 7941;
	public static immutable auto ITEM_UPGRADE_SENTINEL_FALCONAUTOPISTOL_4 = 7942;
	public static immutable auto ITEM_UPGRADE_SENTINEL_ACCURIZEDSHOTGUN_1 = 8258;
	public static immutable auto ITEM_UPGRADE_SENTINEL_ACCURIZEDSHOTGUN_2 = 8259;
	public static immutable auto ITEM_UPGRADE_SENTINEL_ACCURIZEDSHOTGUN_3 = 8260;
	public static immutable auto ITEM_UPGRADE_SENTINEL_ACCURIZEDSHOTGUN_4 = 8261;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_SN7PISTOL_1 = 7967;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_SN7PISTOL_2 = 7968;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_SN7PISTOL_3 = 7969;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_THROWINGKNIVES_1 = 8312;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_THROWINGKNIVES_2 = 8313;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_THROWINGKNIVES_3 = 8314;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_THROWINGKNIVES_4 = 8315;
	public static immutable auto ITEM_UPGRADE_SOLDIER_EAGLEPISTOL_1 = 7995;
	public static immutable auto ITEM_UPGRADE_SOLDIER_EAGLEPISTOL_2 = 7996;
	public static immutable auto ITEM_UPGRADE_SOLDIER_EAGLEPISTOL_3 = 7997;
	public static immutable auto ITEM_UPGRADE_SOLDIER_THUMPERD_1 = 7989;
	public static immutable auto ITEM_UPGRADE_SOLDIER_THUMPERD_2 = 7990;
	public static immutable auto ITEM_UPGRADE_SOLDIER_THUMPERD_3 = 7991;
	public static immutable auto ITEM_UPGRADE_SOLDIER_PLASMAGUN_1 = 8295;
	public static immutable auto ITEM_UPGRADE_SOLDIER_PLASMAGUN_2 = 8296;
	public static immutable auto ITEM_UPGRADE_SOLDIER_PLASMAGUN_3 = 8297;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_REPAIRTOOLSD_1 = 8019;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_REPAIRTOOLSD_2 = 8020;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_REPAIRTOOLSD_3 = 8021;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_SAWEDOFFSHOTGUN_1 = 8022;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_SAWEDOFFSHOTGUN_2 = 8023;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_SAWEDOFFSHOTGUN_3 = 8024;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_SPARROWPISTOL_1 = 8025;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_SPARROWPISTOL_2 = 8026;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_SPARROWPISTOL_3 = 8027;
	public static immutable auto ITEM_UPGRADE_RAIDER_NJ4SMG_1 = 8048;
	public static immutable auto ITEM_UPGRADE_RAIDER_NJ4SMG_2 = 8049;
	public static immutable auto ITEM_UPGRADE_RAIDER_NJ4SMG_3 = 8050;
	public static immutable auto ITEM_UPGRADE_RAIDER_NJ4SMG_4 = 8051;
	public static immutable auto ITEM_UPGRADE_RAIDER_NJ5SMG_1 = 8289;
	public static immutable auto ITEM_UPGRADE_RAIDER_NJ5SMG_2 = 8290;
	public static immutable auto ITEM_UPGRADE_RAIDER_NJ5SMG_3 = 8291;
	public static immutable auto ITEM_UPGRADE_RAIDER_NJ5SMG_4 = 8304;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_SPINFUSORD_1 = 8076;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_SPINFUSORD_2 = 8077;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_SPINFUSORD_3 = 8078;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_LMG_1 = 8079;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_LMG_2 = 8080;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_LMG_3 = 8081;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_LMG_4 = 8082;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_SABERLAUNCHER_1 = 8107;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_SABERLAUNCHER_2 = 8108;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_SABERLAUNCHER_3 = 8109;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_ROCKETLAUNCHER_1 = 8301;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_ROCKETLAUNCHER_2 = 8302;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_ROCKETLAUNCHER_3 = 8303;
	public static immutable auto ITEM_UPGRADE_BRUTE_AUTOSHOTGUN_1 = 8127;
	public static immutable auto ITEM_UPGRADE_BRUTE_AUTOSHOTGUN_2 = 8128;
	public static immutable auto ITEM_UPGRADE_BRUTE_AUTOSHOTGUN_3 = 8129;
	public static immutable auto ITEM_UPGRADE_BRUTE_AUTOSHOTGUN_4 = 8130;
	public static immutable auto ITEM_UPGRADE_BRUTE_NOVACOLT_1 = 8131;
	public static immutable auto ITEM_UPGRADE_BRUTE_NOVACOLT_2 = 8132;
	public static immutable auto ITEM_UPGRADE_BRUTE_NOVACOLT_3 = 8133;
	public static immutable auto ITEM_UPGRADE_BRUTE_NOVACOLT_4 = 8134;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_IMPACTNITRON_1 = 7881;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_IMPACTNITRON_2 = 7882;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_IMPACTNITRON_3 = 7883;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_GRENADE_ST_1 = 7888;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_GRENADE_ST_2 = 7889;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_GRENADE_ST_3 = 7890;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_IMPACTBOMBLETS_1 = 8274;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_IMPACTBOMBLETS_2 = 8275;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_IMPACTBOMBLETS_3 = 8276;
	public static immutable auto ITEM_UPGRADE_SENTINEL_CLAYMORE_1 = 7943;
	public static immutable auto ITEM_UPGRADE_SENTINEL_CLAYMORE_2 = 7944;
	public static immutable auto ITEM_UPGRADE_SENTINEL_CLAYMORE_3 = 7945;
	public static immutable auto ITEM_UPGRADE_SENTINEL_GRENADEXL_1 = 7946;
	public static immutable auto ITEM_UPGRADE_SENTINEL_GRENADEXL_2 = 7947;
	public static immutable auto ITEM_UPGRADE_SENTINEL_GRENADEXL_3 = 7948;
	public static immutable auto ITEM_UPGRADE_SENTINEL_ARMOREDCLAYMORE_1 = 8262;
	public static immutable auto ITEM_UPGRADE_SENTINEL_ARMOREDCLAYMORE_2 = 8263;
	public static immutable auto ITEM_UPGRADE_SENTINEL_ARMOREDCLAYMORE_3 = 8264;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_STICKYGRENADE_1 = 7970;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_STICKYGRENADE_2 = 7971;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_STICKYGRENADE_3 = 7972;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_STICKYGRENADE_4 = 7973;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_PRISMMINES_1 = 7974;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_PRISMMINES_2 = 7975;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_PRISMMINES_3 = 7976;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_NINJASMOKE_1 = 8286;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_NINJASMOKE_2 = 8287;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_NINJASMOKE_3 = 8288;
	public static immutable auto ITEM_UPGRADE_SOLDIER_FRAGGRENADEXL_1 = 7998;
	public static immutable auto ITEM_UPGRADE_SOLDIER_FRAGGRENADEXL_2 = 7999;
	public static immutable auto ITEM_UPGRADE_SOLDIER_FRAGGRENADEXL_3 = 8000;
	public static immutable auto ITEM_UPGRADE_SOLDIER_APGRENADE_1 = 8001;
	public static immutable auto ITEM_UPGRADE_SOLDIER_APGRENADE_2 = 8002;
	public static immutable auto ITEM_UPGRADE_SOLDIER_APGRENADE_3 = 8003;
	public static immutable auto ITEM_UPGRADE_SOLDIER_PROXIMITYGRENADE_1 = 8227;
	public static immutable auto ITEM_UPGRADE_SOLDIER_PROXIMITYGRENADE_2 = 8228;
	public static immutable auto ITEM_UPGRADE_SOLDIER_PROXIMITYGRENADE_3 = 8229;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_TCNGGRENADE_1 = 8028;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_TCNGGRENADE_2 = 8029;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_TCNGGRENADE_3 = 8030;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_MOTIONALARM_1 = 8031;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_MOTIONALARM_2 = 8032;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_MOTIONALARM_3 = 8033;
	public static immutable auto ITEM_UPGRADE_RAIDER_EMPGRENADE_1 = 8052;
	public static immutable auto ITEM_UPGRADE_RAIDER_EMPGRENADE_2 = 8053;
	public static immutable auto ITEM_UPGRADE_RAIDER_EMPGRENADE_3 = 8054;
	public static immutable auto ITEM_UPGRADE_RAIDER_WHITEOUTGRENADE_1 = 8055;
	public static immutable auto ITEM_UPGRADE_RAIDER_WHITEOUTGRENADE_2 = 8056;
	public static immutable auto ITEM_UPGRADE_RAIDER_WHITEOUTGRENADE_3 = 8057;
	public static immutable auto ITEM_UPGRADE_RAIDER_MIRVGRENADE_1 = 8283;
	public static immutable auto ITEM_UPGRADE_RAIDER_MIRVGRENADE_2 = 8284;
	public static immutable auto ITEM_UPGRADE_RAIDER_MIRVGRENADE_3 = 8285;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_HEAVYAPGRENADE_1 = 8083;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_HEAVYAPGRENADE_2 = 8084;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_HEAVYAPGRENADE_3 = 8085;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_DISKTOSS_1 = 8086;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_DISKTOSS_2 = 8087;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_DISKTOSS_3 = 8088;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_GRENADE_1 = 8110;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_GRENADE_2 = 8111;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_GRENADE_3 = 8112;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_MINES_1 = 8113;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_MINES_2 = 8114;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_MINES_3 = 8115;
	public static immutable auto ITEM_UPGRADE_BRUTE_FRACTALGRENADE_1 = 8135;
	public static immutable auto ITEM_UPGRADE_BRUTE_FRACTALGRENADE_2 = 8136;
	public static immutable auto ITEM_UPGRADE_BRUTE_FRACTALGRENADE_3 = 8137;
	public static immutable auto ITEM_UPGRADE_BRUTE_STICKYGRENADE_1 = 8138;
	public static immutable auto ITEM_UPGRADE_BRUTE_STICKYGRENADE_2 = 8139;
	public static immutable auto ITEM_UPGRADE_BRUTE_STICKYGRENADE_3 = 8140;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_ENERGYRECHARGEPACK_1 = 7871;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_ENERGYRECHARGEPACK_2 = 7872;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_ENERGYRECHARGEPACK_3 = 7873;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_JUMPPACK_1 = 7876;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_JUMPPACK_2 = 7877;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_JUMPPACK_3 = 7878;
	public static immutable auto ITEM_UPGRADE_SENTINEL_DROPJAMMER_1 = 7949;
	public static immutable auto ITEM_UPGRADE_SENTINEL_DROPJAMMER_2 = 7950;
	public static immutable auto ITEM_UPGRADE_SENTINEL_DROPJAMMER_3 = 7951;
	public static immutable auto ITEM_UPGRADE_SENTINEL_ENERGYRECHARGEPACK_1 = 7952;
	public static immutable auto ITEM_UPGRADE_SENTINEL_ENERGYRECHARGEPACK_2 = 7953;
	public static immutable auto ITEM_UPGRADE_SENTINEL_ENERGYRECHARGEPACK_3 = 7954;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_STEALTHPACK_1 = 7977;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_STEALTHPACK_2 = 7978;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_STEALTHPACK_3 = 7979;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_HIGHSPEEDSTEALTH_1 = 8271;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_HIGHSPEEDSTEALTH_2 = 8272;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_HIGHSPEEDSTEALTH_3 = 8273;
	public static immutable auto ITEM_UPGRADE_SOLDIER_ENERGYPACK_1 = 8004;
	public static immutable auto ITEM_UPGRADE_SOLDIER_ENERGYPACK_2 = 8005;
	public static immutable auto ITEM_UPGRADE_SOLDIER_ENERGYPACK_3 = 8006;
	public static immutable auto ITEM_UPGRADE_SOLDIER_UTILITYPACK_1 = 8224;
	public static immutable auto ITEM_UPGRADE_SOLDIER_UTILITYPACK_2 = 8225;
	public static immutable auto ITEM_UPGRADE_SOLDIER_UTILITYPACK_3 = 8226;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_LIGHTTURRET_1 = 8034;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_LIGHTTURRET_2 = 8035;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_LIGHTTURRET_3 = 8036;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_EXRTURRET_1 = 8268;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_EXRTURRET_2 = 8269;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_EXRTURRET_3 = 8270;
	public static immutable auto ITEM_UPGRADE_RAIDER_SHIELDPACK_1 = 8058;
	public static immutable auto ITEM_UPGRADE_RAIDER_SHIELDPACK_2 = 8059;
	public static immutable auto ITEM_UPGRADE_RAIDER_SHIELDPACK_3 = 8060;
	public static immutable auto ITEM_UPGRADE_RAIDER_JAMMERPACK_1 = 8061;
	public static immutable auto ITEM_UPGRADE_RAIDER_JAMMERPACK_2 = 8062;
	public static immutable auto ITEM_UPGRADE_RAIDER_JAMMERPACK_3 = 8063;
	public static immutable auto ITEM_UPGRADE_RAIDER_JAMMERPACK_4 = 8064;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_HEALTHREGENPACK_1 = 8089;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_HEALTHREGENPACK_2 = 8090;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_HEALTHREGENPACK_3 = 8091;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_ENERGYPACK_1 = 8092;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_ENERGYPACK_2 = 8093;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_ENERGYPACK_3 = 8094;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_SURVIVALPACK_1 = 8309;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_SURVIVALPACK_2 = 8310;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_SURVIVALPACK_3 = 8311;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_FORCEFIELD_1 = 8116;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_FORCEFIELD_2 = 8117;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_FORCEFIELD_3 = 8118;
	public static immutable auto ITEM_UPGRADE_BRUTE_ENERGYPACK_1 = 8141;
	public static immutable auto ITEM_UPGRADE_BRUTE_ENERGYPACK_2 = 8142;
	public static immutable auto ITEM_UPGRADE_BRUTE_ENERGYPACK_3 = 8143;
	public static immutable auto ITEM_UPGRADE_BRUTE_SHIELDPACK_1 = 8144;
	public static immutable auto ITEM_UPGRADE_BRUTE_SHIELDPACK_2 = 8145;
	public static immutable auto ITEM_UPGRADE_BRUTE_SHIELDPACK_3 = 8146;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_ARMOR_1 = 7893;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_ARMOR_2 = 7894;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_ARMOR_3 = 7895;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_ARMOR_4 = 7896;
	public static immutable auto ITEM_UPGRADE_PATHFINDER_ARMOR_5 = 7897;
	public static immutable auto ITEM_UPGRADE_SENTINEL_ARMOR_1 = 7955;
	public static immutable auto ITEM_UPGRADE_SENTINEL_ARMOR_2 = 7956;
	public static immutable auto ITEM_UPGRADE_SENTINEL_ARMOR_3 = 7957;
	public static immutable auto ITEM_UPGRADE_SENTINEL_ARMOR_4 = 7958;
	public static immutable auto ITEM_UPGRADE_SENTINEL_ARMOR_5 = 7959;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_ARMOR_1 = 7980;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_ARMOR_2 = 7981;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_ARMOR_3 = 7982;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_ARMOR_4 = 7983;
	public static immutable auto ITEM_UPGRADE_INFILTRATOR_ARMOR_5 = 7984;
	public static immutable auto ITEM_UPGRADE_SOLDIER_ARMOR_1 = 8007;
	public static immutable auto ITEM_UPGRADE_SOLDIER_ARMOR_2 = 8008;
	public static immutable auto ITEM_UPGRADE_SOLDIER_ARMOR_3 = 8009;
	public static immutable auto ITEM_UPGRADE_SOLDIER_ARMOR_4 = 8010;
	public static immutable auto ITEM_UPGRADE_SOLDIER_ARMOR_5 = 8011;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_ARMOR_1 = 8037;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_ARMOR_2 = 8038;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_ARMOR_3 = 8039;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_ARMOR_4 = 8040;
	public static immutable auto ITEM_UPGRADE_TECHNICIAN_ARMOR_5 = 8041;
	public static immutable auto ITEM_UPGRADE_RAIDER_ARMOR_1 = 8065;
	public static immutable auto ITEM_UPGRADE_RAIDER_ARMOR_2 = 8066;
	public static immutable auto ITEM_UPGRADE_RAIDER_ARMOR_3 = 8067;
	public static immutable auto ITEM_UPGRADE_RAIDER_ARMOR_4 = 8068;
	public static immutable auto ITEM_UPGRADE_RAIDER_ARMOR_5 = 8069;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_ARMOR_1 = 8095;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_ARMOR_2 = 8096;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_ARMOR_3 = 8097;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_ARMOR_4 = 8098;
	public static immutable auto ITEM_UPGRADE_JUGGERNAUT_ARMOR_5 = 8099;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_ARMOR_1 = 8119;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_ARMOR_2 = 8120;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_ARMOR_3 = 8121;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_ARMOR_4 = 8122;
	public static immutable auto ITEM_UPGRADE_DOOMBRINGER_ARMOR_5 = 8123;
	public static immutable auto ITEM_UPGRADE_BRUTE_ARMOR_1 = 8147;
	public static immutable auto ITEM_UPGRADE_BRUTE_ARMOR_2 = 8148;
	public static immutable auto ITEM_UPGRADE_BRUTE_ARMOR_3 = 8149;
	public static immutable auto ITEM_UPGRADE_BRUTE_ARMOR_4 = 8150;
	public static immutable auto ITEM_UPGRADE_BRUTE_ARMOR_5 = 8151;
	public static immutable auto ITEM_PERK_UPGRADE_BOUNTYHUNTER_1 = 8188;
	public static immutable auto ITEM_PERK_UPGRADE_BOUNTYHUNTER_2 = 8189;
	public static immutable auto ITEM_PERK_UPGRADE_BOUNTYHUNTER_3 = 8190;
	public static immutable auto ITEM_PERK_UPGRADE_CLOSECOMBAT_1 = 8194;
	public static immutable auto ITEM_PERK_UPGRADE_CLOSECOMBAT_2 = 8195;
	public static immutable auto ITEM_PERK_UPGRADE_CLOSECOMBAT_3 = 8196;
	public static immutable auto ITEM_PERK_UPGRADE_EGOCENTRIC_1 = 8173;
	public static immutable auto ITEM_PERK_UPGRADE_EGOCENTRIC_2 = 8174;
	public static immutable auto ITEM_PERK_UPGRADE_EGOCENTRIC_3 = 8175;
	public static immutable auto ITEM_PERK_UPGRADE_LOOTER_1 = 8185;
	public static immutable auto ITEM_PERK_UPGRADE_LOOTER_2 = 8186;
	public static immutable auto ITEM_PERK_UPGRADE_LOOTER_3 = 8187;
	public static immutable auto ITEM_PERK_UPGRADE_MECHANIC_1 = 8215;
	public static immutable auto ITEM_PERK_UPGRADE_MECHANIC_2 = 8216;
	public static immutable auto ITEM_PERK_UPGRADE_MECHANIC_3 = 8217;
	public static immutable auto ITEM_PERK_UPGRADE_PILOT_1 = 8179;
	public static immutable auto ITEM_PERK_UPGRADE_PILOT_2 = 8180;
	public static immutable auto ITEM_PERK_UPGRADE_PILOT_3 = 8181;
	public static immutable auto ITEM_PERK_UPGRADE_POTENTIALENERGY_1 = 8200;
	public static immutable auto ITEM_PERK_UPGRADE_POTENTIALENERGY_2 = 8201;
	public static immutable auto ITEM_PERK_UPGRADE_POTENTIALENERGY_3 = 8202;
	public static immutable auto ITEM_PERK_UPGRADE_QUICKDRAW_1 = 8209;
	public static immutable auto ITEM_PERK_UPGRADE_QUICKDRAW_2 = 8210;
	public static immutable auto ITEM_PERK_UPGRADE_QUICKDRAW_3 = 8211;
	public static immutable auto ITEM_PERK_UPGRADE_REACH_1 = 8152;
	public static immutable auto ITEM_PERK_UPGRADE_REACH_2 = 8171;
	public static immutable auto ITEM_PERK_UPGRADE_REACH_3 = 8172;
	public static immutable auto ITEM_PERK_UPGRADE_SAFEFALL_1 = 8176;
	public static immutable auto ITEM_PERK_UPGRADE_SAFEFALL_2 = 8177;
	public static immutable auto ITEM_PERK_UPGRADE_SAFEFALL_3 = 8178;
	public static immutable auto ITEM_PERK_UPGRADE_SAFETYTHIRD_1 = 8212;
	public static immutable auto ITEM_PERK_UPGRADE_SAFETYTHIRD_2 = 8213;
	public static immutable auto ITEM_PERK_UPGRADE_SAFETYTHIRD_3 = 8214;
	public static immutable auto ITEM_PERK_UPGRADE_STEALTHY_1 = 8206;
	public static immutable auto ITEM_PERK_UPGRADE_STEALTHY_2 = 8207;
	public static immutable auto ITEM_PERK_UPGRADE_STEALTHY_3 = 8208;
	public static immutable auto ITEM_PERK_UPGRADE_SUPERHEAVY_1 = 8197;
	public static immutable auto ITEM_PERK_UPGRADE_SUPERHEAVY_2 = 8198;
	public static immutable auto ITEM_PERK_UPGRADE_SUPERHEAVY_3 = 8199;
	public static immutable auto ITEM_PERK_UPGRADE_SURVIVALIST_1 = 8191;
	public static immutable auto ITEM_PERK_UPGRADE_SURVIVALIST_2 = 8192;
	public static immutable auto ITEM_PERK_UPGRADE_SURVIVALIST_3 = 8193;
	public static immutable auto ITEM_PERK_UPGRADE_ULTRACAPACITOR_1 = 8203;
	public static immutable auto ITEM_PERK_UPGRADE_ULTRACAPACITOR_2 = 8204;
	public static immutable auto ITEM_PERK_UPGRADE_ULTRACAPACITOR_3 = 8205;
	public static immutable auto ITEM_PERK_UPGRADE_WHEELDEAL_1 = 8182;
	public static immutable auto ITEM_PERK_UPGRADE_WHEELDEAL_2 = 8183;
	public static immutable auto ITEM_PERK_UPGRADE_WHEELDEAL_3 = 8184;
	public static immutable auto ITEM_PERK_UPGRADE_RAGE_1 = 8236;
	public static immutable auto ITEM_PERK_UPGRADE_RAGE_2 = 8237;
	public static immutable auto ITEM_PERK_UPGRADE_RAGE_3 = 8238;
	public static immutable auto ITEM_PERK_UPGRADE_SONICPUNCH_1 = 8233;
	public static immutable auto ITEM_PERK_UPGRADE_SONICPUNCH_2 = 8234;
	public static immutable auto ITEM_PERK_UPGRADE_SONICPUNCH_3 = 8235;
	public static immutable auto ITEM_UPGRADE_TEMP = 99999;
	public static immutable auto SHOP_VENDOR_GOLD = 507;
	public static immutable auto SHOP_VENDOR_BUNDLES = 518;
	public static immutable auto SHOP_VENDOR_BOOSTERS = 508;
	public static immutable auto SHOP_VENDOR_NAMECHANGE = 512;
	public static immutable auto SHOP_VENDOR_CLANTAG = 545;
	public static immutable auto SKIN_INFILTRATOR_BE = 6;
	public static immutable auto SKIN_INFILTRATOR_DS = 7;
	public static immutable auto SKIN_SENTINEL_BE = 8;
	public static immutable auto SKIN_SENTINEL_DS = 9;
	public static immutable auto SKIN_RAIDER_BE = 10;
	public static immutable auto SKIN_RAIDER_DS = 11;
	public static immutable auto SKIN_TECHNICIAN_BE = 12;
	public static immutable auto SKIN_TECHNICIAN_DS = 13;
	public static immutable auto SKIN_DOOMBRINGER_BE = 14;
	public static immutable auto SKIN_DOOMBRINGER_DS = 15;
	public static immutable auto SKIN_JUGGERNAUT_BE = 16;
	public static immutable auto SKIN_JUGGERNAUT_DS = 17;
	public static immutable auto SKIN_BRUTE_BE = 18;
	public static immutable auto SKIN_BRUTE_DS = 19;
	public static immutable auto SKIN_SOLDIER_BE = 20;
	public static immutable auto SKIN_SOLDIER_DS = 21;
	public static immutable auto SKIN_PATHFINDER_BE = 22;
	public static immutable auto SKIN_PATHFINDER_DS = 23;
	public static immutable auto SKIN_PATHFINDER_MC = 24;
	public static immutable auto SKIN_INFILTRATOR_AS = 25;
	public static immutable auto SKIN_INFILTRATOR_MC = 26;
	public static immutable auto SKIN_RAIDER_GV = 25;
	public static immutable auto SKIN_RAIDER_MC = 26;
	public static immutable auto SKIN_SENTINEL_MC = 27;
	public static immutable auto SKIN_BRUTE_MC = 28;
	public static immutable auto SKIN_TECHNICIAN_MC = 29;
	public static immutable auto QUEUE_CONFIG_SERVERNAME = 1243;
	public static immutable auto QUEUE_CONFIG_ADMINPASSWORD = 1245;
	public static immutable auto QUEUE_CONFIG_GENPASSWORD = 1246;
	public static immutable auto QUEUE_CONFIG_SLOTS = 1247;
	public static immutable auto QUEUE_CONFIG_MATCHQUEUEID = 1253;
	public static immutable auto QUEUE_CONFIG_SERVERDESCRIPTION = 1255;
	public static immutable auto QUEUE_CONFIG_MAPROTATIONTYPE = 1256;
	public static immutable auto QUEUE_CONFIG_MAPSLOT1 = 1257;
	public static immutable auto QUEUE_CONFIG_MAPSLOT2 = 1258;
	public static immutable auto QUEUE_CONFIG_MAPSLOT3 = 1259;
	public static immutable auto QUEUE_CONFIG_MAPSLOT4 = 1260;
	public static immutable auto QUEUE_CONFIG_MAPSLOT5 = 1261;
	public static immutable auto QUEUE_CONFIG_MAPSLOT6 = 1262;
	public static immutable auto QUEUE_CONFIG_MAPSLOT7 = 1263;
	public static immutable auto QUEUE_CONFIG_MAPSLOT8 = 1264;
	public static immutable auto QUEUE_CONFIG_SITEID = 1272;
	public static immutable auto QUEUE_CONFIG_MINLEVEL = 1296;
	public static immutable auto QUEUE_CONFIG_MAXLEVEL = 1297;
	public static immutable auto GAME_CONFIG_TIMELIMIT = 1059;
	public static immutable auto GAME_CONFIG_MAXPLAYERS = 1060;
	public static immutable auto GAME_CONFIG_AUTOBALANCE = 1062;
	public static immutable auto GAME_CONFIG_OVERTIMELIMIT = 1063;
	public static immutable auto GAME_CONFIG_RESPAWNTIME = 1064;
	public static immutable auto GAME_CONFIG_FRIENDLYFIRE = 1065;
	public static immutable auto GAME_CONFIG_GENAUTOREGEN = 1066;
	public static immutable auto GAME_CONFIG_UPGRADES = 1067;
	public static immutable auto GAME_CONFIG_SPAWNNAKED = 1068;
	public static immutable auto GAME_CONFIG_BASEASSETS = 1070;
	public static immutable auto GAME_CONFIG_POWERDEPLOYS = 1072;
	public static immutable auto GAME_CONFIG_VEHICLELIMITS = 1075;
	public static immutable auto GAME_CONFIG_VGRAVCYCLELIMIT = 1268;
	public static immutable auto GAME_CONFIG_VBEOWULFLIMIT = 1269;
	public static immutable auto GAME_CONFIG_VSHRIKELIMIT = 1270;
	public static immutable auto GAME_CONFIG_VBEOWULFPRICE = 1076;
	public static immutable auto GAME_CONFIG_VGRAVPRICE = 1077;
	public static immutable auto GAME_CONFIG_VSHRIKEPRICE = 1080;
	public static immutable auto GAME_CONFIG_TEAMJOINTYPE = 1081;
	public static immutable auto GAME_CONFIG_FFMULTIPLIER = 1123;
	public static immutable auto GAME_CONFIG_CALLINSDENIED = 1233;
	public static immutable auto GAME_CONFIG_CALLINPRICETAC = 1234;
	public static immutable auto GAME_CONFIG_CALLINPRICESUP = 1235;
	public static immutable auto GAME_CONFIG_CALLINPRICEORB = 1236;
	public static immutable auto GAME_CONFIG_CALLINCLDWNTAC = 1237;
	public static immutable auto GAME_CONFIG_CALLINCLDWNSUP = 1238;
	public static immutable auto GAME_CONFIG_CALLINCLDWNORB = 1239;
	public static immutable auto GAME_CONFIG_CALLINBLDUPTAC = 1249;
	public static immutable auto GAME_CONFIG_CALLINBLDUPSUP = 1250;
	public static immutable auto GAME_CONFIG_CALLINBLDUPORB = 1251;
	public static immutable auto GAME_CONFIG_BASEDESTLIMIT = 1241;
	public static immutable auto GAME_CONFIG_WARMUPTIME = 1248;
	public static immutable auto GAME_CONFIG_TEAMDISPARITY = 1252;
	public static immutable auto GAME_CONFIG_CONFIGCASEID = 1254;
	public static immutable auto GAME_CONFIG_ARENAROUNDS = 1265;
	public static immutable auto GAME_CONFIG_SCORELIMIT_CTF = 1061;
	public static immutable auto GAME_CONFIG_SCORELIMIT_RAB = 1278;
	public static immutable auto GAME_CONFIG_SCORELIMIT_TDM = 1276;
	public static immutable auto GAME_CONFIG_SCORELIMIT_ARN = 1277;
	public static immutable auto GAME_CONFIG_SCORELIMIT_CAH = 1279;
	public static immutable auto GAME_CONFIG_GAMETYPE = 1244;
	public static immutable auto GAME_CONFIG_GENDESTROYABLE = 1280;
	public static immutable auto GAME_CONFIG_INVDESTROYABLE = 1281;
	public static immutable auto GAME_CONFIG_FFDEPLOYABLES = 1282;
	public static immutable auto GAME_CONFIG_FFBASEASSETS = 1283;
	public static immutable auto GAME_CONFIG_FFDMGLIMIT = 1284;
	public static immutable auto GAME_CONFIG_FFKILLLIMIT = 1285;
	public static immutable auto GAME_CONFIG_SUPPLYDROPAMMOONLY = 1286;
	public static immutable auto GAME_CONFIG_CLASSCOUNT_PTH = 1287;
	public static immutable auto GAME_CONFIG_CLASSCOUNT_SEN = 1289;
	public static immutable auto GAME_CONFIG_CLASSCOUNT_INF = 1288;
	public static immutable auto GAME_CONFIG_CLASSCOUNT_SLD = 1290;
	public static immutable auto GAME_CONFIG_CLASSCOUNT_TCN = 1291;
	public static immutable auto GAME_CONFIG_CLASSCOUNT_RDR = 1292;
	public static immutable auto GAME_CONFIG_CLASSCOUNT_JUG = 1293;
	public static immutable auto GAME_CONFIG_CLASSCOUNT_DMB = 1294;
	public static immutable auto GAME_CONFIG_CLASSCOUNT_BRT = 1295;
	public static immutable auto GAME_CONFIG_POWEREDCALLINS = 1298;
	public static immutable auto GAME_CONFIG_TEAMCREDITS = 1299;
	public static immutable auto GAME_CONFIG_VEHICLEHEALTHMULT = 1327;
	public static immutable auto GAME_CONFIG_SKIENABLED = 1373;
	public static immutable auto GAME_CONFIG_ENERGYMULTIPLIER = 1374;
	public static immutable auto GAME_CONFIG_AOESIZEMULTIPLIER = 1375;
	public static immutable auto GAME_CONFIG_AOEDAMAGEMULTIPLIER = 1376;
	public static immutable auto GAME_CONFIG_CTFBLITZALLFLAGSMOVE = 1377;
	public static immutable auto GAME_CONFIG_MAXSPEEDWITHFLAGLIGHT = 1391;
	public static immutable auto GAME_CONFIG_DECELERATIONRATEWITHFLAG = 1392;
	public static immutable auto GAME_CONFIG_MAXSPEEDWITHFLAGMEDIUM = 1395;
	public static immutable auto GAME_CONFIG_MAXSPEEDWITHFLAGHEAVY = 1396;
	public static immutable auto SERVER_RT_METHOD_RANDOM = 10070;
	public static immutable auto SERVER_RT_METHOD_LINEAR = 10071;
	public static immutable auto SERVER_RT_METHOD_LINEAR2 = 10072;
	public static immutable auto SERVER_RT_METHOD_LINEAR4 = 10073;
	public static immutable auto TR_MAX_GAMETYPES = 5;
	public static immutable auto SERVER_GAMECLASSID_CTF = 197;
	public static immutable auto SERVER_GAMECLASSID_RAB = 8012;
	public static immutable auto SERVER_GAMECLASSID_TDM = 8036;
	public static immutable auto SERVER_GAMECLASSID_ARN = 8086;
	public static immutable auto SERVER_GAMECLASSID_CAH = 8094;
	public static immutable auto SERVER_GAMECLASSID_BTZ = 8118;
	public static immutable auto SERVER_DEFAULT_MAP_CTF = 1462;
	public static immutable auto SERVER_DEFAULT_MAP_RAB = 1465;
	public static immutable auto SERVER_DEFAULT_MAP_TDM = 1488;
	public static immutable auto SERVER_DEFAULT_MAP_ARN = 1495;
	public static immutable auto SERVER_DEFAULT_MAP_CAH = 1519;
	public static immutable auto SERVER_DEFAULT_MAP_BTZ = 1539;
	public static immutable auto PTH_LOADOUT_ONE = 8359;
	public static immutable auto PTH_LOADOUT_TWO = 8360;
	public static immutable auto PTH_LOADOUT_THREE = 8361;
	public static immutable auto PTH_LOADOUT_FOUR = 8674;
	public static immutable auto PTH_LOADOUT_FIVE = 8675;
	public static immutable auto INF_LOADOUT_ONE = 8362;
	public static immutable auto INF_LOADOUT_TWO = 8363;
	public static immutable auto INF_LOADOUT_THREE = 8364;
	public static immutable auto INF_LOADOUT_FOUR = 8676;
	public static immutable auto INF_LOADOUT_FIVE = 8677;
	public static immutable auto SEN_LOADOUT_ONE = 8365;
	public static immutable auto SEN_LOADOUT_TWO = 8366;
	public static immutable auto SEN_LOADOUT_THREE = 8367;
	public static immutable auto SEN_LOADOUT_FOUR = 8678;
	public static immutable auto SEN_LOADOUT_FIVE = 8679;
	public static immutable auto SLD_LOADOUT_ONE = 8368;
	public static immutable auto SLD_LOADOUT_TWO = 8369;
	public static immutable auto SLD_LOADOUT_THREE = 8370;
	public static immutable auto SLD_LOADOUT_FOUR = 8680;
	public static immutable auto SLD_LOADOUT_FIVE = 8681;
	public static immutable auto TCN_LOADOUT_ONE = 8371;
	public static immutable auto TCN_LOADOUT_TWO = 8372;
	public static immutable auto TCN_LOADOUT_THREE = 8373;
	public static immutable auto TCN_LOADOUT_FOUR = 8682;
	public static immutable auto TCN_LOADOUT_FIVE = 8683;
	public static immutable auto RDR_LOADOUT_ONE = 8374;
	public static immutable auto RDR_LOADOUT_TWO = 8375;
	public static immutable auto RDR_LOADOUT_THREE = 8376;
	public static immutable auto RDR_LOADOUT_FOUR = 8684;
	public static immutable auto RDR_LOADOUT_FIVE = 8685;
	public static immutable auto JUG_LOADOUT_ONE = 8377;
	public static immutable auto JUG_LOADOUT_TWO = 8378;
	public static immutable auto JUG_LOADOUT_THREE = 8379;
	public static immutable auto JUG_LOADOUT_FOUR = 8686;
	public static immutable auto JUG_LOADOUT_FIVE = 8687;
	public static immutable auto DMB_LOADOUT_ONE = 8380;
	public static immutable auto DMB_LOADOUT_TWO = 8381;
	public static immutable auto DMB_LOADOUT_THREE = 8382;
	public static immutable auto DMB_LOADOUT_FOUR = 8688;
	public static immutable auto DMB_LOADOUT_FIVE = 8689;
	public static immutable auto BRT_LOADOUT_ONE = 8383;
	public static immutable auto BRT_LOADOUT_TWO = 8384;
	public static immutable auto BRT_LOADOUT_THREE = 8385;
	public static immutable auto BRT_LOADOUT_FOUR = 8690;
	public static immutable auto BRT_LOADOUT_FIVE = 8691;
	public static immutable auto ACTIVITY_DEVICE_NONE = 0;
	public static immutable auto ACTIVITY_SENTINEL_PRIMARY_BXT1 = 124;
	public static immutable auto ACTIVITY_SENTINEL_BELT_MINE_CLAYMORE_MKD = 125;
	public static immutable auto ACTIVITY_SENTINEL_PRIMARY_SNIPERRIFLE_MKD = 126;
	public static immutable auto ACTIVITY_BRUTE_PRIMARY_HEAVYSPINFUSOR = 127;
	public static immutable auto ACTIVITY_BRUTE_PRIMARY_HEAVYSPINFUSOR_MKD = 128;
	public static immutable auto ACTIVITY_BRUTE_PRIMARY_SPIKELAUNCHER = 129;
	public static immutable auto ACTIVITY_DOOMBRINGER_PRIMARY_CHAINGUN = 131;
	public static immutable auto ACTIVITY_DOOMBRINGER_PRIMARY_CHAINGUN_MKD = 132;
	public static immutable auto ACTIVITY_DOOMBRINGER_PRIMARY_HEAVYBOLTLAUNCHER = 133;
	public static immutable auto ACTIVITY_INFILTRATOR_PRIMARY_REMOTEARXBUSTER = 134;
	public static immutable auto ACTIVITY_INFILTRATOR_PRIMARY_RHINOSMG = 135;
	public static immutable auto ACTIVITY_INFILTRATOR_PRIMARY_RHINOSMG_MKD = 136;
	public static immutable auto ACTIVITY_INFILTRATOR_PRIMARY_STEALTHLIGHTSPINFUSOR = 137;
	public static immutable auto ACTIVITY_JUGGERNAUT_PRIMARY_FUSIONMORTAR = 138;
	public static immutable auto ACTIVITY_JUGGERNAUT_PRIMARY_FUSIONMORTAR_MKD = 139;
	public static immutable auto ACTIVITY_JUGGERNAUT_PRIMARY_MIRVLAUNCHER = 140;
	public static immutable auto ACTIVITY_PATHFINDER_PRIMARY_BOLTLAUNCHER = 141;
	public static immutable auto ACTIVITY_PATHFINDER_PRIMARY_LIGHTSPINFUSOR = 142;
	public static immutable auto ACTIVITY_PATHFINDER_PRIMARY_LIGHTSPINFUSOR_MKD = 143;
	public static immutable auto ACTIVITY_RAIDER_PRIMARY_ARXBUSTER = 144;
	public static immutable auto ACTIVITY_RAIDER_PRIMARY_ARXBUSTER_MKD = 145;
	public static immutable auto ACTIVITY_RAIDER_PRIMARY_GRENADELAUNCHER = 146;
	public static immutable auto ACTIVITY_RAIDER_PRIMARY_PLASMAGUN = 147;
	public static immutable auto ACTIVITY_SENTINEL_PRIMARY_PHASERIFLE = 148;
	public static immutable auto ACTIVITY_SOLDIER_PRIMARY_ASSAULTRIFLE = 149;
	public static immutable auto ACTIVITY_SOLDIER_PRIMARY_ASSAULTRIFLE_MKD = 150;
	public static immutable auto ACTIVITY_SOLDIER_PRIMARY_SPINFUSOR = 151;
	public static immutable auto ACTIVITY_TECHNICIAN_PRIMARY_TCN4 = 152;
	public static immutable auto ACTIVITY_TECHNICIAN_PRIMARY_TCN4_MKD = 153;
	public static immutable auto ACTIVITY_TECHNICIAN_PRIMARY_THUMPER = 154;
	public static immutable auto ACTIVITY_BRUTE_SECONDARY_AUTOSHOTGUN = 155;
	public static immutable auto ACTIVITY_BRUTE_SECONDARY_AUTOSHOTGUN_MKD = 156;
	public static immutable auto ACTIVITY_BRUTE_SECONDARY_NOVACOLT = 157;
	public static immutable auto ACTIVITY_BRUTE_SECONDARY_PLASMACANNON = 158;
	public static immutable auto ACTIVITY_DOOMBRINGER_SECONDARY_SABERLAUNCHER = 159;
	public static immutable auto ACTIVITY_DOOMBRINGER_SECONDARY_SABERLAUNCHER_MKD = 160;
	public static immutable auto ACTIVITY_INFILTRATOR_SECONDARY_SN7 = 161;
	public static immutable auto ACTIVITY_INFILTRATOR_SECONDARY_SN7_MKD = 162;
	public static immutable auto ACTIVITY_INFILTRATOR_SECONDARY_THROWINGKNIVES = 163;
	public static immutable auto ACTIVITY_JUGGERNAUT_SECONDARY_SPINFUSORD = 164;
	public static immutable auto ACTIVITY_JUGGERNAUT_SECONDARY_SPINFUSORD_MKD = 165;
	public static immutable auto ACTIVITY_JUGGERNAUT_SECONDARY_X1LMG = 166;
	public static immutable auto ACTIVITY_PATHFINDER_SECONDARY_LIGHTASSAULTRIFLE = 167;
	public static immutable auto ACTIVITY_PATHFINDER_SECONDARY_SHOTGUN = 168;
	public static immutable auto ACTIVITY_PATHFINDER_SECONDARY_SHOTGUN_MKD = 169;
	public static immutable auto ACTIVITY_RAIDER_SECONDARY_NJ4SMG = 170;
	public static immutable auto ACTIVITY_RAIDER_SECONDARY_NJ4SMG_MKD = 171;
	public static immutable auto ACTIVITY_RAIDER_SECONDARY_NJ5SMG = 172;
	public static immutable auto ACTIVITY_SENTINEL_SECONDARY_FALCON = 173;
	public static immutable auto ACTIVITY_SENTINEL_SECONDARY_NOVABLASTER = 174;
	public static immutable auto ACTIVITY_SENTINEL_SECONDARY_NOVABLASTER_MKD = 175;
	public static immutable auto ACTIVITY_SOLDIER_SECONDARY_EAGLE = 176;
	public static immutable auto ACTIVITY_SOLDIER_SECONDARY_THUMPERD = 177;
	public static immutable auto ACTIVITY_SOLDIER_SECONDARY_THUMPERD_MKD = 178;
	public static immutable auto ACTIVITY_TECHNICIAN_SECONDARY_REPAIRTOOLSD = 179;
	public static immutable auto ACTIVITY_TECHNICIAN_SECONDARY_REPAIRTOOLSD_MKD = 180;
	public static immutable auto ACTIVITY_TECHNICIAN_SECONDARY_SAWEDOFF = 181;
	public static immutable auto ACTIVITY_TECHNICIAN_SECONDARY_SPARROW = 182;
	public static immutable auto ACTIVITY_ARMOR_MOD_BRUTE_1 = 183;
	public static immutable auto ACTIVITY_ARMOR_MOD_DOOMBRINGER_1 = 184;
	public static immutable auto ACTIVITY_ARMOR_MOD_INFILTRATOR_1 = 185;
	public static immutable auto ACTIVITY_ARMOR_MOD_JUGGERNAUT_1 = 186;
	public static immutable auto ACTIVITY_ARMOR_MOD_PATHFINDER_1 = 187;
	public static immutable auto ACTIVITY_ARMOR_MOD_RAIDER_1 = 188;
	public static immutable auto ACTIVITY_ARMOR_MOD_SENTINEL_1 = 189;
	public static immutable auto ACTIVITY_ARMOR_MOD_TECHNICIAN_1 = 190;
	public static immutable auto ACTIVITY_ARMOR_MOD_SOLDIER_1 = 191;
	public static immutable auto ACTIVITY_BRUTE_BELT_FRACTALGRENADE = 192;
	public static immutable auto ACTIVITY_BRUTE_BELT_FRACTALGRENADE_MKD = 193;
	public static immutable auto ACTIVITY_BRUTE_BELT_LIGHTSTICKYGRENADE = 194;
	public static immutable auto ACTIVITY_DOOMBRINGER_BELT_MINE = 195;
	public static immutable auto ACTIVITY_DOOMBRINGER_BELT_STANDARDGRENADE = 196;
	public static immutable auto ACTIVITY_DOOMBRINGER_BELT_STANDARDGRENADE_MKD = 197;
	public static immutable auto ACTIVITY_INFILTRATOR_BELT_NINJASMOKE = 198;
	public static immutable auto ACTIVITY_INFILTRATOR_BELT_PRISMMINES = 199;
	public static immutable auto ACTIVITY_INFILTRATOR_BELT_STICKYGRENADE = 200;
	public static immutable auto ACTIVITY_INFILTRATOR_BELT_STICKYGRENADE_MKD = 201;
	public static immutable auto ACTIVITY_JUGGERNAUT_BELT_DISKTOSS = 202;
	public static immutable auto ACTIVITY_JUGGERNAUT_BELT_HEAVYAPGRENADE = 203;
	public static immutable auto ACTIVITY_JUGGERNAUT_BELT_HEAVYAPGRENADE_MKD = 204;
	public static immutable auto ACTIVITY_PATHFINDER_BELT_IMPACTNITRON = 205;
	public static immutable auto ACTIVITY_PATHFINDER_BELT_IMPACTNITRON_MKD = 206;
	public static immutable auto ACTIVITY_PATHFINDER_BELT_STGRENADE = 207;
	public static immutable auto ACTIVITY_RAIDER_BELT_EMPGRENADE = 208;
	public static immutable auto ACTIVITY_RAIDER_BELT_EMPGRENADE_MKD = 209;
	public static immutable auto ACTIVITY_RAIDER_BELT_MIRVGRENADE = 210;
	public static immutable auto ACTIVITY_RAIDER_BELT_WHITEOUT = 211;
	public static immutable auto ACTIVITY_SENTINEL_BELT_ARMOREDCLAYMORE = 212;
	public static immutable auto ACTIVITY_SENTINEL_BELT_CLAYMORE = 213;
	public static immutable auto ACTIVITY_SENTINEL_BELT_CLAYMORE_MKD = 214;
	public static immutable auto ACTIVITY_SENTINEL_BELT_GRENADET5 = 215;
	public static immutable auto ACTIVITY_SOLDIER_BELT_APGRENADE = 216;
	public static immutable auto ACTIVITY_SOLDIER_BELT_FRAGGRENADEXL = 217;
	public static immutable auto ACTIVITY_SOLDIER_BELT_FRAGGRENADEXL_MKD = 218;
	public static immutable auto ACTIVITY_SOLDIER_BELT_PROXIMITYGRENADE = 219;
	public static immutable auto ACTIVITY_TECHNICIAN_BELT_MOTIONALARM = 220;
	public static immutable auto ACTIVITY_TECHNICIAN_BELT_TCNG = 221;
	public static immutable auto ACTIVITY_TECHNICIAN_BELT_TCNG_MKD = 222;
	public static immutable auto ACTIVITY_BRUTE_PACK_HEAVYSHIELD = 223;
	public static immutable auto ACTIVITY_BRUTE_PACK_MINORENERGY = 224;
	public static immutable auto ACTIVITY_BRUTE_PACK_SURVIVALPACK = 225;
	public static immutable auto ACTIVITY_DOOMBRINGER_PACK_FORCEFIELD = 226;
	public static immutable auto ACTIVITY_INFILTRATOR_PACK_STEALTH = 227;
	public static immutable auto ACTIVITY_JUGGERNAUT_PACK_HEALTHREGEN = 228;
	public static immutable auto ACTIVITY_PATHFINDER_PACK_ENERGYRECHARGE = 229;
	public static immutable auto ACTIVITY_PATHFINDER_PACK_JUMPPACK = 230;
	public static immutable auto ACTIVITY_RAIDER_PACK_JAMMER = 231;
	public static immutable auto ACTIVITY_RAIDER_PACK_SHIELD = 232;
	public static immutable auto ACTIVITY_SENTINEL_PACK_DROPJAMMER = 233;
	public static immutable auto ACTIVITY_SENTINEL_PACK_ENERGYRECHARGE = 234;
	public static immutable auto ACTIVITY_SOLDIER_PACK_ENERGYPOOL = 235;
	public static immutable auto ACTIVITY_SOLDIER_PACK_UTILITY = 236;
	public static immutable auto ACTIVITY_TECHNICIAN_PACK_EXRTURRET = 237;
	public static immutable auto ACTIVITY_TECHNICIAN_PACK_LIGHTTURRET = 238;
	public static immutable auto ACTIVITY_PERK_BOUNTY_HUNTER = 239;
	public static immutable auto ACTIVITY_PERK_CLOSE_COMBAT = 240;
	public static immutable auto ACTIVITY_PERK_LOOTER = 241;
	public static immutable auto ACTIVITY_PERK_RAGE = 242;
	public static immutable auto ACTIVITY_PERK_REACH = 243;
	public static immutable auto ACTIVITY_PERK_SAFE_FALL = 244;
	public static immutable auto ACTIVITY_PERK_SAFETY_THIRD = 245;
	public static immutable auto ACTIVITY_PERK_STEALTHY = 246;
	public static immutable auto ACTIVITY_PERK_SUPER_CAPACITOR = 247;
	public static immutable auto ACTIVITY_PERK_WHEEL_DEAL = 248;
	public static immutable auto ACTIVITY_PERK_DETERMINATION = 249;
	public static immutable auto ACTIVITY_PERK_EGOCENTRIC = 250;
	public static immutable auto ACTIVITY_PERK_MECHANIC = 253;
	public static immutable auto ACTIVITY_PERK_PILOT = 254;
	public static immutable auto ACTIVITY_PERK_POTENTIAL_ENERGY = 255;
	public static immutable auto ACTIVITY_PERK_QUICKDRAW = 256;
	public static immutable auto ACTIVITY_PERK_SONIC_PUNCH = 257;
	public static immutable auto ACTIVITY_PERK_SUPER_HEAVY = 258;
	public static immutable auto ACTIVITY_PERK_SURVIVALIST = 259;
	public static immutable auto ACTIVITY_PERK_ULTRA_CAPACITOR = 260;
	public static immutable auto ACTIVITY_PATHFINDER_PRIMARY_LIGHTTWINFUSOR = 261;
	public static immutable auto ACTIVITY_SOLDIER_PRIMARY_TWINFUSOR = 262;
	public static immutable auto ACTIVITY_JUGGERNAUT_SECONDARY_HEAVYTWINFUSOR = 263;
	public static immutable auto BUNDLE_LOOT_ID_CAD_ASSASSIN = 8918;
	public static immutable auto BUNDLE_LOOT_ID_CAD_MERCENARY = 8919;
	public static immutable auto BUNDLE_LOOT_ID_CAD_PREMIUM = 8912;
	public static immutable auto BUNDLE_LOOT_ID_CAD_WEAPONS = 8920;
	public static immutable auto BUNDLE_LOOT_ID_RAP_GRIEVER = 8982;
	public static immutable auto BUNDLE_LOOT_ID_RAP_MERCENARY = 8983;
	public static immutable auto BUNDLE_LOOT_ID_RAP_PREMIUM = 8981;
	public static immutable auto BUNDLE_LOOT_ID_RAP_WEAPONS = 8984;
	public static immutable auto BUNDLE_LOOT_ID_NEWPLAYER = 9214;
	public static immutable auto BUNDLE_LOOT_ID_SHAZBUNDLE = 9213;
	public static immutable auto BUNDLE_LOOT_ID_STAYINALIVE = 9035;
	public static immutable auto BUNDLE_LOOT_ID_TWINFUSOR = 9449;
	public static immutable auto BUNDLE_LOOT_ID_SKINPACK = 9457;
	public static immutable auto BUNDLE_LOOT_ID_SPECIALIST = 9496;
	public static immutable auto BUNDLE_LOOT_ID_SENTINEL = 9510;
	public static immutable auto ITEM_VOICE_LIGHT = 8666;
	public static immutable auto ITEM_VOICE_MEDIUM = 8667;
	public static immutable auto ITEM_VOICE_HEAVY = 8668;
	public static immutable auto ITEM_VOICE_DARK = 8669;
	public static immutable auto ITEM_VOICE_FEM1 = 8670;
	public static immutable auto ITEM_VOICE_FEM2 = 8671;
	public static immutable auto ITEM_VOICE_AUS = 8695;
	public static immutable auto ITEM_VOICE_T2FEM01 = 8712;
	public static immutable auto ITEM_VOICE_T2FEM02 = 8714;
	public static immutable auto ITEM_VOICE_T2FEM03 = 8715;
	public static immutable auto ITEM_VOICE_T2FEM04 = 8716;
	public static immutable auto ITEM_VOICE_T2FEM05 = 8717;
	public static immutable auto ITEM_VOICE_T2MALE01 = 8719;
	public static immutable auto ITEM_VOICE_T2MALE02 = 8720;
	public static immutable auto ITEM_VOICE_T2MALE03 = 8721;
	public static immutable auto ITEM_VOICE_T2MALE04 = 8722;
	public static immutable auto ITEM_VOICE_T2MALE05 = 8723;
	public static immutable auto ITEM_VOICE_T2BDERM01 = 8724;
	public static immutable auto ITEM_VOICE_T2BDERM02 = 8725;
	public static immutable auto ITEM_VOICE_T2BDERM03 = 8726;
	public @property final auto ref TrStatsInterface Stats() { return *cast(TrStatsInterface*)(cast(size_t)cast(void*)this + 1364); }
	public @property final bool bFirstBloodAchieved() { return (*cast(uint*)(cast(size_t)cast(void*)this + 1328) & 0x8) != 0; }
	public @property final bool bFirstBloodAchieved(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 1328) |= 0x8; } else { *cast(uint*)(cast(size_t)cast(void*)this + 1328) &= ~0x8; } return val; }
	public @property final auto ref float m_fFriendlyFireDamageScale() { return *cast(float*)(cast(size_t)cast(void*)this + 1396); }
	public @property final bool m_bRoamingMap() { return (*cast(uint*)(cast(size_t)cast(void*)this + 1328) & 0x200) != 0; }
	public @property final bool m_bRoamingMap(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 1328) |= 0x200; } else { *cast(uint*)(cast(size_t)cast(void*)this + 1328) &= ~0x200; } return val; }
	public @property final auto ref float m_fForcedRespawnTime() { return *cast(float*)(cast(size_t)cast(void*)this + 1404); }
	public @property final auto ref TrSeekingMissileManager m_SeekingMissileManager() { return *cast(TrSeekingMissileManager*)(cast(size_t)cast(void*)this + 1400); }
	public @property final auto ref int m_nMinNetPlayers() { return *cast(int*)(cast(size_t)cast(void*)this + 1416); }
	public @property final auto ref int m_nRoundCountdownRemainingTime() { return *cast(int*)(cast(size_t)cast(void*)this + 1412); }
	public @property final auto ref int m_nRoundCountdownTime() { return *cast(int*)(cast(size_t)cast(void*)this + 1408); }
	public @property final auto ref int m_nAutoBalanceTeamDifference() { return *cast(int*)(cast(size_t)cast(void*)this + 1392); }
	public @property final auto ref float m_fAutoBalanceTime() { return *cast(float*)(cast(size_t)cast(void*)this + 1388); }
	public @property final auto ref int m_nPlayerTrackingInterval() { return *cast(int*)(cast(size_t)cast(void*)this + 1384); }
	public @property final auto ref int m_nPlayerTrackingCount() { return *cast(int*)(cast(size_t)cast(void*)this + 1380); }
	public @property final auto ref int CountdownWait() { return *cast(int*)(cast(size_t)cast(void*)this + 1376); }
	public @property final auto ref int SummaryWait() { return *cast(int*)(cast(size_t)cast(void*)this + 1372); }
	public @property final auto ref int EndGameWait() { return *cast(int*)(cast(size_t)cast(void*)this + 1368); }
	public @property final auto ref int MINIMUM_CREDITS_FOR_EXPERIENCE() { return *cast(int*)(cast(size_t)cast(void*)this + 1360); }
	public @property final auto ref float m_OvertimeTimeLimit() { return *cast(float*)(cast(size_t)cast(void*)this + 1356); }
	public @property final auto ref int m_nNextEffectInstanceId() { return *cast(int*)(cast(size_t)cast(void*)this + 1352); }
	public @property final auto ref int m_nEndMatchCounter() { return *cast(int*)(cast(size_t)cast(void*)this + 1348); }
	public @property final auto ref int m_nWinningTeam() { return *cast(int*)(cast(size_t)cast(void*)this + 1344); }
	public @property final auto ref ScriptString m_sWinnerName() { return *cast(ScriptString*)(cast(size_t)cast(void*)this + 1332); }
	public @property final bool m_bShouldAutoBalance() { return (*cast(uint*)(cast(size_t)cast(void*)this + 1328) & 0x100) != 0; }
	public @property final bool m_bShouldAutoBalance(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 1328) |= 0x100; } else { *cast(uint*)(cast(size_t)cast(void*)this + 1328) &= ~0x100; } return val; }
	public @property final bool PlayedEndOfGame() { return (*cast(uint*)(cast(size_t)cast(void*)this + 1328) & 0x80) != 0; }
	public @property final bool PlayedEndOfGame(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 1328) |= 0x80; } else { *cast(uint*)(cast(size_t)cast(void*)this + 1328) &= ~0x80; } return val; }
	public @property final bool bPlayedDSWinning() { return (*cast(uint*)(cast(size_t)cast(void*)this + 1328) & 0x40) != 0; }
	public @property final bool bPlayedDSWinning(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 1328) |= 0x40; } else { *cast(uint*)(cast(size_t)cast(void*)this + 1328) &= ~0x40; } return val; }
	public @property final bool bPlayedBEWinning() { return (*cast(uint*)(cast(size_t)cast(void*)this + 1328) & 0x20) != 0; }
	public @property final bool bPlayedBEWinning(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 1328) |= 0x20; } else { *cast(uint*)(cast(size_t)cast(void*)this + 1328) &= ~0x20; } return val; }
	public @property final bool bPlayTeamAudio() { return (*cast(uint*)(cast(size_t)cast(void*)this + 1328) & 0x10) != 0; }
	public @property final bool bPlayTeamAudio(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 1328) |= 0x10; } else { *cast(uint*)(cast(size_t)cast(void*)this + 1328) &= ~0x10; } return val; }
	public @property final bool bForceRoundStart() { return (*cast(uint*)(cast(size_t)cast(void*)this + 1328) & 0x4) != 0; }
	public @property final bool bForceRoundStart(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 1328) |= 0x4; } else { *cast(uint*)(cast(size_t)cast(void*)this + 1328) &= ~0x4; } return val; }
	public @property final bool bForceEndGame() { return (*cast(uint*)(cast(size_t)cast(void*)this + 1328) & 0x2) != 0; }
	public @property final bool bForceEndGame(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 1328) |= 0x2; } else { *cast(uint*)(cast(size_t)cast(void*)this + 1328) &= ~0x2; } return val; }
	public @property final bool m_bPostedStats() { return (*cast(uint*)(cast(size_t)cast(void*)this + 1328) & 0x1) != 0; }
	public @property final bool m_bPostedStats(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 1328) |= 0x1; } else { *cast(uint*)(cast(size_t)cast(void*)this + 1328) &= ~0x1; } return val; }
	final bool RequestTeam(ubyte RequestedTeamNum, Controller C)
	{
		ubyte params[9];
		params[] = 0;
		params[0] = RequestedTeamNum;
		*cast(Controller*)&params[4] = C;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76487], params.ptr, cast(void*)0);
		return *cast(bool*)&params[8];
	}
	final bool AutoAssignTeam(Controller C)
	{
		ubyte params[8];
		params[] = 0;
		*cast(Controller*)params.ptr = C;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76496], params.ptr, cast(void*)0);
		return *cast(bool*)&params[4];
	}
	final bool AllowRespawn(TrPlayerController TrPC)
	{
		ubyte params[8];
		params[] = 0;
		*cast(TrPlayerController*)params.ptr = TrPC;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76520], params.ptr, cast(void*)0);
		return *cast(bool*)&params[4];
	}
	final bool CanEnterSpectate(TrPlayerController TrPC, bool bNeutral)
	{
		ubyte params[12];
		params[] = 0;
		*cast(TrPlayerController*)params.ptr = TrPC;
		*cast(bool*)&params[4] = bNeutral;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77210], params.ptr, cast(void*)0);
		return *cast(bool*)&params[8];
	}
	final int CreditsSortViaPC(PlayerController A, PlayerController B)
	{
		ubyte params[12];
		params[] = 0;
		*cast(PlayerController*)params.ptr = A;
		*cast(PlayerController*)&params[4] = B;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90035], params.ptr, cast(void*)0);
		return *cast(int*)&params[8];
	}
	final int CreditSort(PlayerReplicationInfo A, PlayerReplicationInfo B)
	{
		ubyte params[12];
		params[] = 0;
		*cast(PlayerReplicationInfo*)params.ptr = A;
		*cast(PlayerReplicationInfo*)&params[4] = B;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90037], params.ptr, cast(void*)0);
		return *cast(int*)&params[8];
	}
	final int ScoreSort(PlayerReplicationInfo A, PlayerReplicationInfo B)
	{
		ubyte params[12];
		params[] = 0;
		*cast(PlayerReplicationInfo*)params.ptr = A;
		*cast(PlayerReplicationInfo*)&params[4] = B;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90039], params.ptr, cast(void*)0);
		return *cast(int*)&params[8];
	}
	final int GetNextEffectInstanceId()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90064], params.ptr, cast(void*)0);
		return *cast(int*)params.ptr;
	}
	final void LocalLeaveGame()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90066], cast(void*)0, cast(void*)0);
	}
	final void OnServerInitialized()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90067], cast(void*)0, cast(void*)0);
	}
	final void SetOnlinePlayerName(PlayerReplicationInfo PRI)
	{
		ubyte params[4];
		params[] = 0;
		*cast(PlayerReplicationInfo*)params.ptr = PRI;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90068], params.ptr, cast(void*)0);
	}
	final void ApplyServerSettings()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90070], cast(void*)0, cast(void*)0);
	}
	final void ReduceDamage(int* Damage, Pawn injured, Controller InstigatedBy, Vector HitLocation, Vector* Momentum, ScriptClass DamageType, Actor DamageCauser)
	{
		ubyte params[44];
		params[] = 0;
		*cast(int*)params.ptr = *Damage;
		*cast(Pawn*)&params[4] = injured;
		*cast(Controller*)&params[8] = InstigatedBy;
		*cast(Vector*)&params[12] = HitLocation;
		*cast(Vector*)&params[24] = *Momentum;
		*cast(ScriptClass*)&params[36] = DamageType;
		*cast(Actor*)&params[40] = DamageCauser;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90077], params.ptr, cast(void*)0);
		*Damage = *cast(int*)params.ptr;
		*Momentum = *cast(Vector*)&params[24];
	}
	final void PreBeginPlay()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90086], cast(void*)0, cast(void*)0);
	}
	final void AddInitialBots()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90087], cast(void*)0, cast(void*)0);
	}
	final UTBot AddBot(ScriptString BotName, bool bUseTeamIndex, int TeamIndex)
	{
		ubyte params[24];
		params[] = 0;
		*cast(ScriptString*)params.ptr = BotName;
		*cast(bool*)&params[12] = bUseTeamIndex;
		*cast(int*)&params[16] = TeamIndex;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90088], params.ptr, cast(void*)0);
		return *cast(UTBot*)&params[20];
	}
	final void AddBots(int Num)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Num;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90093], params.ptr, cast(void*)0);
	}
	final UTBot SpawnBot(ScriptString BotName, bool bUseTeamIndex, int TeamIndex)
	{
		ubyte params[24];
		params[] = 0;
		*cast(ScriptString*)params.ptr = BotName;
		*cast(bool*)&params[12] = bUseTeamIndex;
		*cast(int*)&params[16] = TeamIndex;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90095], params.ptr, cast(void*)0);
		return *cast(UTBot*)&params[20];
	}
	final void InitializeBot(UTBot NewBot, UTTeamInfo BotTeam, UTCharInfo.CharacterInfo* BotInfo)
	{
		ubyte params[120];
		params[] = 0;
		*cast(UTBot*)params.ptr = NewBot;
		*cast(UTTeamInfo*)&params[4] = BotTeam;
		*cast(UTCharInfo.CharacterInfo*)&params[8] = *BotInfo;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90100], params.ptr, cast(void*)0);
		*BotInfo = *cast(UTCharInfo.CharacterInfo*)&params[8];
	}
	final void StartBots()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90104], cast(void*)0, cast(void*)0);
	}
	final void KickIdler(PlayerController PC)
	{
		ubyte params[4];
		params[] = 0;
		*cast(PlayerController*)params.ptr = PC;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90105], params.ptr, cast(void*)0);
	}
	final PlayerController Login(ScriptString Portal, ScriptString Options, OnlineSubsystem.UniqueNetId UniqueId, ScriptString* ErrorMessage)
	{
		ubyte params[48];
		params[] = 0;
		*cast(ScriptString*)params.ptr = Portal;
		*cast(ScriptString*)&params[12] = Options;
		*cast(OnlineSubsystem.UniqueNetId*)&params[24] = UniqueId;
		*cast(ScriptString*)&params[32] = *ErrorMessage;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90108], params.ptr, cast(void*)0);
		*ErrorMessage = *cast(ScriptString*)&params[32];
		return *cast(PlayerController*)&params[44];
	}
	final Pawn SpawnDefaultPawnFor(Controller NewPlayer, NavigationPoint StartSpot)
	{
		ubyte params[12];
		params[] = 0;
		*cast(Controller*)params.ptr = NewPlayer;
		*cast(NavigationPoint*)&params[4] = StartSpot;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90115], params.ptr, cast(void*)0);
		return *cast(Pawn*)&params[8];
	}
	final int DetermineWinningTeam()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90122], params.ptr, cast(void*)0);
		return *cast(int*)params.ptr;
	}
	final void EndGame(PlayerReplicationInfo Winner, ScriptString Reason)
	{
		ubyte params[16];
		params[] = 0;
		*cast(PlayerReplicationInfo*)params.ptr = Winner;
		*cast(ScriptString*)&params[4] = Reason;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90125], params.ptr, cast(void*)0);
	}
	final void EndOnlineGame()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90133], cast(void*)0, cast(void*)0);
	}
	final void SetEndGameFocus(PlayerReplicationInfo Winner)
	{
		ubyte params[4];
		params[] = 0;
		*cast(PlayerReplicationInfo*)params.ptr = Winner;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90135], params.ptr, cast(void*)0);
	}
	final void TrackPlayerMovement()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90146], cast(void*)0, cast(void*)0);
	}
	final void RespawnPlayers()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90147], cast(void*)0, cast(void*)0);
	}
	final void ResetScores()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90149], cast(void*)0, cast(void*)0);
	}
	final void ResetRound()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90150], cast(void*)0, cast(void*)0);
	}
	final void ForceRoundStart()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90176], cast(void*)0, cast(void*)0);
	}
	final void NotifySpree(UTPlayerReplicationInfo Other, int Num)
	{
		ubyte params[8];
		params[] = 0;
		*cast(UTPlayerReplicationInfo*)params.ptr = Other;
		*cast(int*)&params[4] = Num;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90182], params.ptr, cast(void*)0);
	}
	final void EndSpree(UTPlayerReplicationInfo Killer, UTPlayerReplicationInfo Other)
	{
		ubyte params[8];
		params[] = 0;
		*cast(UTPlayerReplicationInfo*)params.ptr = Killer;
		*cast(UTPlayerReplicationInfo*)&params[4] = Other;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90186], params.ptr, cast(void*)0);
	}
	final void GenericPlayerInitialization(Controller C)
	{
		ubyte params[4];
		params[] = 0;
		*cast(Controller*)params.ptr = C;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90191], params.ptr, cast(void*)0);
	}
	final ScriptClass SetGameType(ScriptString MapName, ScriptString Options, ScriptString Portal)
	{
		ubyte params[40];
		params[] = 0;
		*cast(ScriptString*)params.ptr = MapName;
		*cast(ScriptString*)&params[12] = Options;
		*cast(ScriptString*)&params[24] = Portal;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90194], params.ptr, cast(void*)0);
		return *cast(ScriptClass*)&params[36];
	}
	final void PlayEndOfMatchMessage()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90205], cast(void*)0, cast(void*)0);
	}
	final void SendMatchOver()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90207], cast(void*)0, cast(void*)0);
	}
	final void SendShowSummary()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90209], cast(void*)0, cast(void*)0);
	}
	final void SendNextMatchCountdown(int Seconds)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Seconds;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90211], params.ptr, cast(void*)0);
	}
	final void SendMatchCountdown(int Seconds)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Seconds;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90214], params.ptr, cast(void*)0);
	}
	final void ScoreKill(Controller Killer, Controller Other)
	{
		ubyte params[8];
		params[] = 0;
		*cast(Controller*)params.ptr = Killer;
		*cast(Controller*)&params[4] = Other;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90218], params.ptr, cast(void*)0);
	}
	final bool ForceRespawn()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90239], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final void RestartPlayer(Controller aPlayer)
	{
		ubyte params[4];
		params[] = 0;
		*cast(Controller*)params.ptr = aPlayer;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90241], params.ptr, cast(void*)0);
	}
	final bool ChangeTeam(Controller Other, int Num, bool bNewTeam)
	{
		ubyte params[16];
		params[] = 0;
		*cast(Controller*)params.ptr = Other;
		*cast(int*)&params[4] = Num;
		*cast(bool*)&params[8] = bNewTeam;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90244], params.ptr, cast(void*)0);
		return *cast(bool*)&params[12];
	}
	final ubyte PickTeam(ubyte Num, Controller C)
	{
		ubyte params[12];
		params[] = 0;
		params[0] = Num;
		*cast(Controller*)&params[4] = C;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90250], params.ptr, cast(void*)0);
		return params[8];
	}
	final ubyte PickTeamForMigration(Controller C)
	{
		ubyte params[5];
		params[] = 0;
		*cast(Controller*)params.ptr = C;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90254], params.ptr, cast(void*)0);
		return params[4];
	}
	final void HandleSeamlessTravelPlayer(Controller* C)
	{
		ubyte params[4];
		params[] = 0;
		*cast(Controller*)params.ptr = *C;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90265], params.ptr, cast(void*)0);
		*C = *cast(Controller*)params.ptr;
	}
	final void SetPlayerDefaults(Pawn PlayerPawn)
	{
		ubyte params[4];
		params[] = 0;
		*cast(Pawn*)params.ptr = PlayerPawn;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90274], params.ptr, cast(void*)0);
	}
	final void Killed(Controller Killer, Controller KilledPlayer, Pawn KilledPawn, ScriptClass DamageType)
	{
		ubyte params[16];
		params[] = 0;
		*cast(Controller*)params.ptr = Killer;
		*cast(Controller*)&params[4] = KilledPlayer;
		*cast(Pawn*)&params[8] = KilledPawn;
		*cast(ScriptClass*)&params[12] = DamageType;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90278], params.ptr, cast(void*)0);
	}
	final bool AllowCheats(PlayerController P)
	{
		ubyte params[8];
		params[] = 0;
		*cast(PlayerController*)params.ptr = P;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90296], params.ptr, cast(void*)0);
		return *cast(bool*)&params[4];
	}
	final bool AreTeamsUnbalanced()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90299], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final void CheckForAutoBalance()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90304], cast(void*)0, cast(void*)0);
	}
	final void AutoBalanceInTwenty()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90305], cast(void*)0, cast(void*)0);
	}
	final void AutoBalanceInFive()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90306], cast(void*)0, cast(void*)0);
	}
	final void AutoBalanceTeams()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90307], cast(void*)0, cast(void*)0);
	}
	final void MoveRandomPlayerFromTeam(ScriptArray!(PlayerController) TeamList, int PlayersToMove)
	{
		ubyte params[16];
		params[] = 0;
		*cast(ScriptArray!(PlayerController)*)params.ptr = TeamList;
		*cast(int*)&params[12] = PlayersToMove;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90315], params.ptr, cast(void*)0);
	}
	final void InitGame(ScriptString Options, ScriptString* ErrorMessage)
	{
		ubyte params[24];
		params[] = 0;
		*cast(ScriptString*)params.ptr = Options;
		*cast(ScriptString*)&params[12] = *ErrorMessage;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90323], params.ptr, cast(void*)0);
		*ErrorMessage = *cast(ScriptString*)&params[12];
	}
	final void SetPRI(PlayerController PC, PlayerReplicationInfo NewPRI)
	{
		ubyte params[8];
		params[] = 0;
		*cast(PlayerController*)params.ptr = PC;
		*cast(PlayerReplicationInfo*)&params[4] = NewPRI;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90327], params.ptr, cast(void*)0);
	}
	final int GetRankFromXP(int XP)
	{
		ubyte params[8];
		params[] = 0;
		*cast(int*)params.ptr = XP;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90335], params.ptr, cast(void*)0);
		return *cast(int*)&params[4];
	}
	final bool CanSpectate(PlayerController Viewer, PlayerReplicationInfo ViewTarget)
	{
		ubyte params[12];
		params[] = 0;
		*cast(PlayerController*)params.ptr = Viewer;
		*cast(PlayerReplicationInfo*)&params[4] = ViewTarget;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90341], params.ptr, cast(void*)0);
		return *cast(bool*)&params[8];
	}
	final void BroadcastAccolade(ScriptString Message)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptString*)params.ptr = Message;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90346], params.ptr, cast(void*)0);
	}
	final void SendMessageToAll(ScriptClass InMessageClass, int Switch)
	{
		ubyte params[8];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = InMessageClass;
		*cast(int*)&params[4] = Switch;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90349], params.ptr, cast(void*)0);
	}
	final void OnServerSpawnedPlayer(TrPlayerController TrPC)
	{
		ubyte params[4];
		params[] = 0;
		*cast(TrPlayerController*)params.ptr = TrPC;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90353], params.ptr, cast(void*)0);
	}
	final int FindGameTypeId()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90355], params.ptr, cast(void*)0);
		return *cast(int*)params.ptr;
	}
	final int GetGameTypeId()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90357], params.ptr, cast(void*)0);
		return *cast(int*)params.ptr;
	}
	final void OnGeneratorPowerChange(TrPowerGenerator G)
	{
		ubyte params[4];
		params[] = 0;
		*cast(TrPowerGenerator*)params.ptr = G;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90361], params.ptr, cast(void*)0);
	}
	final void TgStartGame(ScriptString* Reason)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptString*)params.ptr = *Reason;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90363], params.ptr, cast(void*)0);
		*Reason = *cast(ScriptString*)params.ptr;
	}
	final void TgEndGame(ScriptString* Reason)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptString*)params.ptr = *Reason;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90365], params.ptr, cast(void*)0);
		*Reason = *cast(ScriptString*)params.ptr;
	}
	final void TgChangeScore(int nTeam, int nCount)
	{
		ubyte params[8];
		params[] = 0;
		*cast(int*)params.ptr = nTeam;
		*cast(int*)&params[4] = nCount;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90367], params.ptr, cast(void*)0);
	}
	final void TgChangeTime(int nSeconds)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = nSeconds;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90370], params.ptr, cast(void*)0);
	}
	final void TgGetSpectators(ScriptArray!(ScriptString)* List)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptArray!(ScriptString)*)params.ptr = *List;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90372], params.ptr, cast(void*)0);
		*List = *cast(ScriptArray!(ScriptString)*)params.ptr;
	}
	final NavigationPoint FindPlayerStart(Controller Player, ubyte InTeam, ScriptString IncomingName)
	{
		ubyte params[21];
		params[] = 0;
		*cast(Controller*)params.ptr = Player;
		params[4] = InTeam;
		*cast(ScriptString*)&params[8] = IncomingName;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90375], params.ptr, cast(void*)0);
		return *cast(NavigationPoint*)&params[20];
	}
}