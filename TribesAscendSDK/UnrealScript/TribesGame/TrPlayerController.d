module UnrealScript.TribesGame.TrPlayerController;

import ScriptClasses;
import UnrealScript.UTGame.UTPlayerController;
import UnrealScript.Engine.CameraActor;
import UnrealScript.TribesGame.TrInventoryHelper;
import UnrealScript.TribesGame.TrWeatherVolume;
import UnrealScript.TribesGame.TrProjectile;
import UnrealScript.PlatformCommon.TgSupportCommands;
import UnrealScript.TribesGame.TrChatConsoleCommands;
import UnrealScript.Core.UObject;
import UnrealScript.TribesGame.TrSeqAct_GiveAccolade;
import UnrealScript.TribesGame.TrSeqAct_PlayVGSCommand;
import UnrealScript.Engine.Actor;
import UnrealScript.Engine.PlayerReplicationInfo;
import UnrealScript.UTGame.UTTeamInfo;
import UnrealScript.Engine.PlayerInput;
import UnrealScript.TribesGame.TrHelpTextManager;
import UnrealScript.TribesGame.TrCameraModifier_CameraShake;
import UnrealScript.TribesGame.TrDeployable_MotionSensor;
import UnrealScript.Engine.Input;
import UnrealScript.TribesGame.TrStation;
import UnrealScript.TribesGame.TrCTFBase;
import UnrealScript.UDKBase.UDKEmitCameraEffect;
import UnrealScript.TribesGame.TrSeqAct_GiveCredits;
import UnrealScript.TribesGame.TrVehicleStation;
import UnrealScript.Engine.ForceFeedbackWaveform;
import UnrealScript.TribesGame.TrPlayerReplicationInfo;
import UnrealScript.TribesGame.TrPowerGenerator;
import UnrealScript.TribesGame.TrFlagBase;
import UnrealScript.TribesGame.TrVGSCommandList;
import UnrealScript.TribesGame.TrAnnouncer;
import UnrealScript.TribesGame.TrPaperDoll;
import UnrealScript.TribesGame.TrAccoladeManager;
import UnrealScript.Engine.Pawn;
import UnrealScript.TribesGame.TrEquipInterface;
import UnrealScript.TribesGame.TrPlayerInput_Spectator;
import UnrealScript.TribesGame.TrContentLoader;
import UnrealScript.TribesGame.TrSeqAct_RefreshInventory;
import UnrealScript.TribesGame.TrFlagCTF;
import UnrealScript.TribesGame.TrCamera_SpectatorBookmark;
import UnrealScript.TribesGame.TrObject;
import UnrealScript.TribesGame.TrVehicle;
import UnrealScript.TribesGame.TrPawn;
import UnrealScript.TribesGame.TrStatsInterface;
import UnrealScript.TribesGame.AlienFXManager;
import UnrealScript.TribesGame.TrStrings;
import UnrealScript.TribesGame.TrMusicManager;
import UnrealScript.Engine.SoundCue;
import UnrealScript.Engine.CameraShake;
import UnrealScript.Engine.MaterialEffect;
import UnrealScript.Engine.PostProcessVolume;
import UnrealScript.TribesGame.TrDevice;
import UnrealScript.UTGame.UTWeapon;
import UnrealScript.Engine.Weapon;

extern(C++) interface TrPlayerController : UTPlayerController
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
	struct TrCameraShakeInfo
	{
		public @property final auto ref ScriptName ShakeName() { return *cast(ScriptName*)(cast(size_t)&this + 4); }
		private ubyte __ShakeName[8];
		public @property final auto ref CameraShake Shake() { return *cast(CameraShake*)(cast(size_t)&this + 0); }
		private ubyte __Shake[4];
	}
	struct VGSAudioCommand
	{
		public @property final auto ref SoundCue QueuedSoundCue() { return *cast(SoundCue*)(cast(size_t)&this + 8); }
		private ubyte __QueuedSoundCue[4];
		public @property final auto ref TrPlayerReplicationInfo VGSInstigator() { return *cast(TrPlayerReplicationInfo*)(cast(size_t)&this + 0); }
		private ubyte __VGSInstigator[4];
	}
	struct SpectatorKeybindViewTargetMap
	{
		public @property final auto ref Actor ViewTarget() { return *cast(Actor*)(cast(size_t)&this + 24); }
		private ubyte __ViewTarget[4];
		public @property final auto ref Input.KeyBind KeyBinding() { return *cast(Input.KeyBind*)(cast(size_t)&this + 0); }
		private ubyte __KeyBinding[24];
	}
	struct PendingSkin
	{
		public @property final auto ref int skinId() { return *cast(int*)(cast(size_t)&this + 4); }
		private ubyte __skinId[4];
		public @property final auto ref TrPlayerReplicationInfo TrPRI() { return *cast(TrPlayerReplicationInfo*)(cast(size_t)&this + 0); }
		private ubyte __TrPRI[4];
	}
	public @property final bool m_bShowHUDCracks() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x100000) != 0; }
	public @property final bool m_bShowHUDCracks(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x100000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x100000; } return val; }
	public @property final auto ref TrEquipInterface m_TrEquipInterface() { return *cast(TrEquipInterface*)(cast(size_t)cast(void*)this + 3376); }
	public @property final bool m_bShowSpectatorHUD() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x10000000) != 0; }
	public @property final bool m_bShowSpectatorHUD(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x10000000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x10000000; } return val; }
	public @property final bool m_bShowSpectatorControls() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x8000000) != 0; }
	public @property final bool m_bShowSpectatorControls(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x8000000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x8000000; } return val; }
	public @property final bool m_bShowHUDVisor() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x100) != 0; }
	public @property final bool m_bShowHUDVisor(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x100; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x100; } return val; }
	public @property final bool m_bShowHUDHealthBar() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x80) != 0; }
	public @property final bool m_bShowHUDHealthBar(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x80; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x80; } return val; }
	public @property final bool m_bShowHUDHeroText() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x2000) != 0; }
	public @property final bool m_bShowHUDHeroText(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x2000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x2000; } return val; }
	public @property final bool m_bShowHUDKillbox() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x800) != 0; }
	public @property final bool m_bShowHUDKillbox(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x800; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x800; } return val; }
	public @property final bool m_bShowHUDCombatLog() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x400) != 0; }
	public @property final bool m_bShowHUDCombatLog(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x400; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x400; } return val; }
	public @property final bool m_bShowHUDSkiBars() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x10000) != 0; }
	public @property final bool m_bShowHUDSkiBars(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x10000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x10000; } return val; }
	public @property final bool m_bShowHUDCredits() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x8) != 0; }
	public @property final bool m_bShowHUDCredits(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x8; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x8; } return val; }
	public @property final bool m_bShowHUDReticule() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x4) != 0; }
	public @property final bool m_bShowHUDReticule(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x4; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x4; } return val; }
	public @property final bool m_bShowHUDChat() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x200) != 0; }
	public @property final bool m_bShowHUDChat(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x200; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x200; } return val; }
	public @property final bool m_bShowHUDPromptPanel() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x4000) != 0; }
	public @property final bool m_bShowHUDPromptPanel(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x4000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x4000; } return val; }
	public @property final bool m_bShowHUDDeathcam() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x1000) != 0; }
	public @property final bool m_bShowHUDDeathcam(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x1000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x1000; } return val; }
	public @property final bool m_bShowHUDRespawnTimer() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x8000) != 0; }
	public @property final bool m_bShowHUDRespawnTimer(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x8000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x8000; } return val; }
	public @property final auto ref float r_fRespawnTime() { return *cast(float*)(cast(size_t)cast(void*)this + 2372); }
	public @property final bool m_bIsRovingSpectating() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x20000000) != 0; }
	public @property final bool m_bIsRovingSpectating(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x20000000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x20000000; } return val; }
	public @property final bool m_bViewThroughDeathCamera() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x400000) != 0; }
	public @property final bool m_bViewThroughDeathCamera(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x400000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x400000; } return val; }
	public @property final auto ref AlienFXManager AlienFX() { return *cast(AlienFXManager*)(cast(size_t)cast(void*)this + 3344); }
	public @property final bool EnableAlienFX() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x800000) != 0; }
	public @property final bool EnableAlienFX(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x800000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x800000; } return val; }
	public @property final bool m_bShowHUDScores() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x40) != 0; }
	public @property final bool m_bShowHUDScores(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x40; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x40; } return val; }
	public @property final auto ref int m_nLastDamagerUpgradeLevel() { return *cast(int*)(cast(size_t)cast(void*)this + 2396); }
	public @property final auto ref int m_nLastDamagerHealthPercent() { return *cast(int*)(cast(size_t)cast(void*)this + 2392); }
	public @property final auto ref TrStrings Strings() { return *cast(TrStrings*)(cast(size_t)cast(void*)this + 3428); }
	public @property final auto ref TrInventoryHelper m_TrInventoryHelper() { return *cast(TrInventoryHelper*)(cast(size_t)cast(void*)this + 3380); }
	public @property final bool m_bShowHUDBadges() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x20) != 0; }
	public @property final bool m_bShowHUDBadges(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x20; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x20; } return val; }
	public @property final bool m_bShowHUDAccolades() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x10) != 0; }
	public @property final bool m_bShowHUDAccolades(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x10; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x10; } return val; }
	public @property final bool r_bNeedTeam() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x8000) != 0; }
	public @property final bool r_bNeedTeam(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x8000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x8000; } return val; }
	public @property final bool r_bNeedLoadout() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x10000) != 0; }
	public @property final bool r_bNeedLoadout(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x10000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x10000; } return val; }
	public @property final bool r_bDailyCompleted() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x2000000) != 0; }
	public @property final bool r_bDailyCompleted(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x2000000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x2000000; } return val; }
	public @property final auto ref int m_RequestedTeam() { return *cast(int*)(cast(size_t)cast(void*)this + 2240); }
	public @property final bool bAutoRevertSetting() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x2000000) != 0; }
	public @property final bool bAutoRevertSetting(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x2000000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x2000000; } return val; }
	public @property final auto ref float m_fLastHitEnemyTime() { return *cast(float*)(cast(size_t)cast(void*)this + 2356); }
	public @property final auto ref TrPlayerController m_LastKilledBy() { return *cast(TrPlayerController*)(cast(size_t)cast(void*)this + 2380); }
	public @property final auto ref ubyte r_nHitEnemyHeadshot() { return *cast(ubyte*)(cast(size_t)cast(void*)this + 2326); }
	public @property final bool m_bAllowSimulatedProjectiles() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x400000) != 0; }
	public @property final bool m_bAllowSimulatedProjectiles(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x400000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x400000; } return val; }
	public @property final bool c_bPressingZoomButton() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x200) != 0; }
	public @property final bool c_bPressingZoomButton(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x200; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x200; } return val; }
	public @property final auto ref TrHelpTextManager m_HelpTextManager() { return *cast(TrHelpTextManager*)(cast(size_t)cast(void*)this + 2944); }
	public @property final auto ref Rotator m_rCurrentKickbackDirection() { return *cast(Rotator*)(cast(size_t)cast(void*)this + 2220); }
	public @property final auto ref MaterialEffect m_ZoomedEffect() { return *cast(MaterialEffect*)(cast(size_t)cast(void*)this + 2340); }
	public @property final auto ref TrStatsInterface Stats() { return *cast(TrStatsInterface*)(cast(size_t)cast(void*)this + 3144); }
	public @property final auto ref TrAccoladeManager m_AccoladeManager() { return *cast(TrAccoladeManager*)(cast(size_t)cast(void*)this + 2348); }
	public @property final auto ref Vector m_vDeathCamOffset() { return *cast(Vector*)(cast(size_t)cast(void*)this + 3112); }
	public @property final auto ref float m_fDeathCameraCurrentScale() { return *cast(float*)(cast(size_t)cast(void*)this + 3104); }
	public @property final auto ref float m_fDeathCameraInnerScale() { return *cast(float*)(cast(size_t)cast(void*)this + 3100); }
	public @property final auto ref float m_fDeathCameraInterpSpeed() { return *cast(float*)(cast(size_t)cast(void*)this + 3108); }
	public @property final auto ref ScriptClass m_OldPossessedFamilyInfo() { return *cast(ScriptClass*)(cast(size_t)cast(void*)this + 2936); }
	public @property final auto ref int m_BeginPlayedTime() { return *cast(int*)(cast(size_t)cast(void*)this + 2416); }
	public @property final bool m_bPressingJetpack() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x4) != 0; }
	public @property final bool m_bPressingJetpack(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x4; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x4; } return val; }
	public @property final auto ref Actor m_LastDamagedBy() { return *cast(Actor*)(cast(size_t)cast(void*)this + 2388); }
	public @property final auto ref int FriendlyFireDamage() { return *cast(int*)(cast(size_t)cast(void*)this + 3412); }
	public @property final auto ref float m_fLastFlagGrabTimestamp() { return *cast(float*)(cast(size_t)cast(void*)this + 3080); }
	public @property final bool m_bShowHUDFriendColoring() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x20000) != 0; }
	public @property final bool m_bShowHUDFriendColoring(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x20000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x20000; } return val; }
	public @property final bool m_bEjectedFromVehicle() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x10000000) != 0; }
	public @property final bool m_bEjectedFromVehicle(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x10000000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x10000000; } return val; }
	public @property final bool m_bLastDeathWasUserSuicide() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x200000) != 0; }
	public @property final bool m_bLastDeathWasUserSuicide(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x200000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x200000; } return val; }
	public @property final auto ref int FriendlyFireKills() { return *cast(int*)(cast(size_t)cast(void*)this + 3408); }
	public @property final auto ref UTWeapon.EZoomState m_ZoomState() { return *cast(UTWeapon.EZoomState*)(cast(size_t)cast(void*)this + 2324); }
	public @property final auto ref float m_fFreeCamYawOffset() { return *cast(float*)(cast(size_t)cast(void*)this + 3024); }
	public @property final auto ref float m_fFreeCamPitchOffset() { return *cast(float*)(cast(size_t)cast(void*)this + 3028); }
	public @property final auto ref float m_fCallInCooldown() { return *cast(float*)(cast(size_t)cast(void*)this + 3328); }
	public @property final auto ref ubyte r_nCallinCooldownFlash() { return *cast(ubyte*)(cast(size_t)cast(void*)this + 2328); }
	public @property final auto ref TrChatConsoleCommands m_PlayerCommands() { return *cast(TrChatConsoleCommands*)(cast(size_t)cast(void*)this + 3324); }
	public @property final auto ref ScriptArray!(TrObject.TrEventCredits) m_EventCreditMap() { return *cast(ScriptArray!(TrObject.TrEventCredits)*)(cast(size_t)cast(void*)this + 2292); }
	public @property final auto ref ScriptArray!(TrPlayerController.TrCameraShakeInfo) m_CameraShakes() { return *cast(ScriptArray!(TrPlayerController.TrCameraShakeInfo)*)(cast(size_t)cast(void*)this + 2432); }
	public @property final auto ref ScriptArray!(TrWeatherVolume) m_CurrentWeatherVolumes() { return *cast(ScriptArray!(TrWeatherVolume)*)(cast(size_t)cast(void*)this + 2452); }
	public @property final auto ref ScriptArray!(float) m_fLastBroadcastTimes() { return *cast(ScriptArray!(float)*)(cast(size_t)cast(void*)this + 3040); }
	public @property final auto ref ScriptArray!(Actor) m_PotentialSeekingTargets() { return *cast(ScriptArray!(Actor)*)(cast(size_t)cast(void*)this + 3064); }
	public @property final auto ref ScriptArray!(TrProjectile) m_ProjectilesNeedingTethering() { return *cast(ScriptArray!(TrProjectile)*)(cast(size_t)cast(void*)this + 3084); }
	public @property final auto ref ScriptArray!(TrPlayerController.VGSAudioCommand) m_VGSAudioCommands() { return *cast(ScriptArray!(TrPlayerController.VGSAudioCommand)*)(cast(size_t)cast(void*)this + 3160); }
	public @property final auto ref ScriptArray!(CameraActor) m_SpectatorCameraBookmarks() { return *cast(ScriptArray!(CameraActor)*)(cast(size_t)cast(void*)this + 3176); }
	public @property final auto ref ScriptArray!(TrPowerGenerator) m_SpectatorGenerators() { return *cast(ScriptArray!(TrPowerGenerator)*)(cast(size_t)cast(void*)this + 3188); }
	public @property final auto ref ScriptArray!(TrCTFBase) m_SpectatorFlagStands() { return *cast(ScriptArray!(TrCTFBase)*)(cast(size_t)cast(void*)this + 3200); }
	public @property final auto ref ScriptArray!(TrFlagBase) m_SpectatorFlags() { return *cast(ScriptArray!(TrFlagBase)*)(cast(size_t)cast(void*)this + 3212); }
	public @property final auto ref ScriptArray!(TrVehicle) m_SpectatorVehicles() { return *cast(ScriptArray!(TrVehicle)*)(cast(size_t)cast(void*)this + 3224); }
	public @property final auto ref ScriptArray!(TrPlayerController.SpectatorKeybindViewTargetMap) m_SpectatorTransientKeybinds() { return *cast(ScriptArray!(TrPlayerController.SpectatorKeybindViewTargetMap)*)(cast(size_t)cast(void*)this + 3312); }
	public @property final auto ref ScriptArray!(ScriptClass) m_CachedPendingClassDeviceContentData() { return *cast(ScriptArray!(ScriptClass)*)(cast(size_t)cast(void*)this + 3352); }
	public @property final auto ref ScriptArray!(ScriptClass) m_PendingLoadoutDeviceClasses() { return *cast(ScriptArray!(ScriptClass)*)(cast(size_t)cast(void*)this + 3364); }
	public @property final auto ref ScriptArray!(TrPlayerController.PendingSkin) m_Pending3PSkins() { return *cast(ScriptArray!(TrPlayerController.PendingSkin)*)(cast(size_t)cast(void*)this + 3384); }
	public @property final auto ref ScriptArray!(TrPlayerController.PendingSkin) m_Pending1PSkins() { return *cast(ScriptArray!(TrPlayerController.PendingSkin)*)(cast(size_t)cast(void*)this + 3396); }
	public @property final auto ref float fSniperRespawnDelay() { return *cast(float*)(cast(size_t)cast(void*)this + 3424); }
	public @property final auto ref float m_fLastSuicideTimestamp() { return *cast(float*)(cast(size_t)cast(void*)this + 3420); }
	public @property final auto ref int VGSClassId() { return *cast(int*)(cast(size_t)cast(void*)this + 3416); }
	public @property final auto ref TrContentLoader c_ContentLoader() { return *cast(TrContentLoader*)(cast(size_t)cast(void*)this + 3348); }
	public @property final auto ref int m_WhisperFilter() { return *cast(int*)(cast(size_t)cast(void*)this + 3340); }
	public @property final auto ref Rotator r_rViewTargetViewRotation() { return *cast(Rotator*)(cast(size_t)cast(void*)this + 3300); }
	public @property final auto ref Vector r_vViewTargetViewLocation() { return *cast(Vector*)(cast(size_t)cast(void*)this + 3288); }
	public @property final auto ref PlayerReplicationInfo r_ViewTargetVehiclePassengerPRI() { return *cast(PlayerReplicationInfo*)(cast(size_t)cast(void*)this + 3284); }
	public @property final auto ref PlayerReplicationInfo r_ViewTargetVehicleDriverPRI() { return *cast(PlayerReplicationInfo*)(cast(size_t)cast(void*)this + 3280); }
	public @property final auto ref float r_fViewTargetVehicleMaxPowerPool() { return *cast(float*)(cast(size_t)cast(void*)this + 3276); }
	public @property final auto ref float r_fViewTargetVehicleCurrentPowerPool() { return *cast(float*)(cast(size_t)cast(void*)this + 3272); }
	public @property final auto ref int r_nViewTargetPackAmmoCount() { return *cast(int*)(cast(size_t)cast(void*)this + 3268); }
	public @property final auto ref int r_nViewTargetOffhandAmmoCount() { return *cast(int*)(cast(size_t)cast(void*)this + 3264); }
	public @property final auto ref int r_nViewTargetSecondaryMaxAmmoCount() { return *cast(int*)(cast(size_t)cast(void*)this + 3260); }
	public @property final auto ref int r_nViewTargetPrimaryMaxAmmoCount() { return *cast(int*)(cast(size_t)cast(void*)this + 3256); }
	public @property final auto ref int r_nViewTargetSecondaryAmmoCount() { return *cast(int*)(cast(size_t)cast(void*)this + 3252); }
	public @property final auto ref int r_nViewTargetPrimaryAmmoCount() { return *cast(int*)(cast(size_t)cast(void*)this + 3248); }
	public @property final auto ref float r_fViewTargetMaxPowerPool() { return *cast(float*)(cast(size_t)cast(void*)this + 3244); }
	public @property final auto ref float r_fViewTargetCurrentPowerpool() { return *cast(float*)(cast(size_t)cast(void*)this + 3240); }
	public @property final auto ref float r_fViewTargetNextRegenTimestamp() { return *cast(float*)(cast(size_t)cast(void*)this + 3236); }
	public @property final auto ref int m_nMaxVGSSoundChannels() { return *cast(int*)(cast(size_t)cast(void*)this + 3172); }
	public @property final auto ref int m_TeamRabbitAssistCredit() { return *cast(int*)(cast(size_t)cast(void*)this + 3156); }
	public @property final auto ref int m_TeamAssistCredit() { return *cast(int*)(cast(size_t)cast(void*)this + 3152); }
	public @property final auto ref int m_DamageNeededForCredit() { return *cast(int*)(cast(size_t)cast(void*)this + 3148); }
	public @property final auto ref MaterialEffect m_RoundEndedME() { return *cast(MaterialEffect*)(cast(size_t)cast(void*)this + 3140); }
	public @property final auto ref float m_fDeterminationAccumulator() { return *cast(float*)(cast(size_t)cast(void*)this + 3136); }
	public @property final auto ref float m_fDeterminationAmount() { return *cast(float*)(cast(size_t)cast(void*)this + 3132); }
	public @property final auto ref float LoadingScreenTimeout() { return *cast(float*)(cast(size_t)cast(void*)this + 3128); }
	public @property final auto ref TrPaperDoll m_PaperDoll() { return *cast(TrPaperDoll*)(cast(size_t)cast(void*)this + 3124); }
	public @property final auto ref float m_fDeathCameraOuterScale() { return *cast(float*)(cast(size_t)cast(void*)this + 3096); }
	public @property final auto ref float m_fUserSuicideTimePenalty() { return *cast(float*)(cast(size_t)cast(void*)this + 3076); }
	public @property final auto ref float m_fSpamLockoutTimeStamp() { return *cast(float*)(cast(size_t)cast(void*)this + 3060); }
	public @property final auto ref float m_fLockoutFromSpamTime() { return *cast(float*)(cast(size_t)cast(void*)this + 3056); }
	public @property final auto ref float m_fMessageSpamTime() { return *cast(float*)(cast(size_t)cast(void*)this + 3052); }
	public @property final auto ref int m_fMaxBroadcastSpamCount() { return *cast(int*)(cast(size_t)cast(void*)this + 3036); }
	public @property final auto ref float m_fLastSpotTargetTime() { return *cast(float*)(cast(size_t)cast(void*)this + 3032); }
	public @property final auto ref int s_nNewPlayerAssistPoints() { return *cast(int*)(cast(size_t)cast(void*)this + 3020); }
	public @property final auto ref int s_nMaxNewPlayerAssistPoints() { return *cast(int*)(cast(size_t)cast(void*)this + 3016); }
	public @property final auto ref float s_fNewPlayerAssistMitigateCauseDamageMultiplier() { return *cast(float*)(cast(size_t)cast(void*)this + 3012); }
	public @property final auto ref float s_fNewPlayerAssistMitigateTakeDamageMultiplier() { return *cast(float*)(cast(size_t)cast(void*)this + 3008); }
	public @property final auto ref float m_fFlagGrabSpeedRecord() { return *cast(float*)(cast(size_t)cast(void*)this + 3004); }
	public @property final auto ref float m_fFlagCapSpeedRecord() { return *cast(float*)(cast(size_t)cast(void*)this + 3000); }
	public @property final auto ref float m_fSkiSpeedRecord() { return *cast(float*)(cast(size_t)cast(void*)this + 2996); }
	public @property final auto ref float m_fSpeedCheckTotal() { return *cast(float*)(cast(size_t)cast(void*)this + 2992); }
	public @property final auto ref float m_fLastSpeedCheckCount() { return *cast(float*)(cast(size_t)cast(void*)this + 2988); }
	public @property final auto ref float m_fLastSpeedCheckTime() { return *cast(float*)(cast(size_t)cast(void*)this + 2984); }
	public @property final auto ref float m_fSpeedCheckInterval() { return *cast(float*)(cast(size_t)cast(void*)this + 2980); }
	public @property final auto ref float m_fHideJetpackHelpTextDistanceThresholdSq() { return *cast(float*)(cast(size_t)cast(void*)this + 2976); }
	public @property final auto ref float m_fTotalDistanceJetpackedSq() { return *cast(float*)(cast(size_t)cast(void*)this + 2972); }
	public @property final auto ref float m_fHideSkiHelpTextDistanceThresholdSq() { return *cast(float*)(cast(size_t)cast(void*)this + 2968); }
	public @property final auto ref float m_fLastDistanceSkiedSq() { return *cast(float*)(cast(size_t)cast(void*)this + 2964); }
	public @property final auto ref float m_fLastDistanceCheckTime() { return *cast(float*)(cast(size_t)cast(void*)this + 2960); }
	public @property final auto ref float m_fDistanceCheckInterval() { return *cast(float*)(cast(size_t)cast(void*)this + 2956); }
	public @property final auto ref float m_fTotalDistanceSkiedSq() { return *cast(float*)(cast(size_t)cast(void*)this + 2952); }
	public @property final auto ref ScriptClass m_HelpTextManagerClass() { return *cast(ScriptClass*)(cast(size_t)cast(void*)this + 2948); }
	public @property final auto ref TrVehicle m_LastAcknowledgedVehicle() { return *cast(TrVehicle*)(cast(size_t)cast(void*)this + 2940); }
	public @property final auto ref int m_ActiveClassId() { return *cast(int*)(cast(size_t)cast(void*)this + 2932); }
	public @property final auto ref int m_LastVGSUse() { return *cast(int*)(cast(size_t)cast(void*)this + 2928); }
	public @property final auto ref float m_fIdleCheckTimer() { return *cast(float*)(cast(size_t)cast(void*)this + 2924); }
	public @property final auto ref float m_RoundEndedVZeroSpeed() { return *cast(float*)(cast(size_t)cast(void*)this + 2920); }
	public @property final auto ref float m_RoundEndedPPTarget() { return *cast(float*)(cast(size_t)cast(void*)this + 2916); }
	public @property final auto ref float m_RoundEndedPPAlpha() { return *cast(float*)(cast(size_t)cast(void*)this + 2912); }
	public @property final auto ref float m_RoundEndedPPInterpSpeed() { return *cast(float*)(cast(size_t)cast(void*)this + 2908); }
	public @property final auto ref PostProcessVolume.PostProcessSettings m_RoundEndedPPSettings() { return *cast(PostProcessVolume.PostProcessSettings*)(cast(size_t)cast(void*)this + 2688); }
	public @property final auto ref PostProcessVolume.PostProcessSettings m_DefaultPPSettings() { return *cast(PostProcessVolume.PostProcessSettings*)(cast(size_t)cast(void*)this + 2468); }
	public @property final auto ref float m_fSpeedCameraSpeedSqared() { return *cast(float*)(cast(size_t)cast(void*)this + 2464); }
	public @property final auto ref UDKEmitCameraEffect m_WeatherCameraEffect() { return *cast(UDKEmitCameraEffect*)(cast(size_t)cast(void*)this + 2448); }
	public @property final auto ref UDKEmitCameraEffect m_SpeedCameraEffect() { return *cast(UDKEmitCameraEffect*)(cast(size_t)cast(void*)this + 2444); }
	public @property final auto ref int m_nLatestAccoladeIcon() { return *cast(int*)(cast(size_t)cast(void*)this + 2428); }
	public @property final auto ref TrCameraModifier_CameraShake m_CameraShake() { return *cast(TrCameraModifier_CameraShake*)(cast(size_t)cast(void*)this + 2424); }
	public @property final auto ref Weapon m_LastWeaponEquipped() { return *cast(Weapon*)(cast(size_t)cast(void*)this + 2420); }
	public @property final auto ref int m_VehicleSeatIndex() { return *cast(int*)(cast(size_t)cast(void*)this + 2412); }
	public @property final auto ref float m_LastPressedSkiTimeStamp() { return *cast(float*)(cast(size_t)cast(void*)this + 2408); }
	public @property final auto ref float m_fMinActiveSkiTimeToEnableFollowthough() { return *cast(float*)(cast(size_t)cast(void*)this + 2404); }
	public @property final auto ref float m_fSkiFollowthroughTime() { return *cast(float*)(cast(size_t)cast(void*)this + 2400); }
	public @property final auto ref Actor r_KilledBy() { return *cast(Actor*)(cast(size_t)cast(void*)this + 2384); }
	public @property final auto ref float m_LastLoadoutRequestTime() { return *cast(float*)(cast(size_t)cast(void*)this + 2376); }
	public @property final auto ref int m_nClientSpawnTimeRemaining() { return *cast(int*)(cast(size_t)cast(void*)this + 2368); }
	public @property final auto ref int m_nRespawnTimeRemaining() { return *cast(int*)(cast(size_t)cast(void*)this + 2364); }
	public @property final auto ref float m_fPlayBeginTime() { return *cast(float*)(cast(size_t)cast(void*)this + 2360); }
	public @property final auto ref TrAnnouncer m_Announcer() { return *cast(TrAnnouncer*)(cast(size_t)cast(void*)this + 2352); }
	public @property final auto ref TrMusicManager m_MusicManager() { return *cast(TrMusicManager*)(cast(size_t)cast(void*)this + 2344); }
	public @property final auto ref float c_fHUDZoomDuration() { return *cast(float*)(cast(size_t)cast(void*)this + 2336); }
	public @property final auto ref TrPawn.WalkingDeceleration m_CurrentDecelerationFactor() { return *cast(TrPawn.WalkingDeceleration*)(cast(size_t)cast(void*)this + 2334); }
	public @property final auto ref ubyte m_nCallinCooldownFlashStored() { return *cast(ubyte*)(cast(size_t)cast(void*)this + 2331); }
	public @property final auto ref ubyte m_nLastHitEnemyHeadshot() { return *cast(ubyte*)(cast(size_t)cast(void*)this + 2327); }
	public @property final auto ref ubyte r_nHitEnemy() { return *cast(ubyte*)(cast(size_t)cast(void*)this + 2325); }
	public @property final auto ref float c_fZoomButtonPressedTimeStamp() { return *cast(float*)(cast(size_t)cast(void*)this + 2320); }
	public @property final auto ref float m_fZoomRate() { return *cast(float*)(cast(size_t)cast(void*)this + 2316); }
	public @property final auto ref float m_fDesiredMagnifiedZoomFOV() { return *cast(float*)(cast(size_t)cast(void*)this + 2312); }
	public @property final auto ref float m_fDesiredZoomFOV() { return *cast(float*)(cast(size_t)cast(void*)this + 2308); }
	public @property final auto ref TrStation m_CurrentStation() { return *cast(TrStation*)(cast(size_t)cast(void*)this + 2304); }
	public @property final auto ref int r_nCurrentCredits() { return *cast(int*)(cast(size_t)cast(void*)this + 2288); }
	public @property final auto ref SoundCue m_RicochetSound3P() { return *cast(SoundCue*)(cast(size_t)cast(void*)this + 2284); }
	public @property final auto ref SoundCue m_MissileSeekingSelfCue() { return *cast(SoundCue*)(cast(size_t)cast(void*)this + 2280); }
	public @property final auto ref SoundCue m_MissileFiredCue() { return *cast(SoundCue*)(cast(size_t)cast(void*)this + 2276); }
	public @property final auto ref SoundCue m_MissileLockedCue() { return *cast(SoundCue*)(cast(size_t)cast(void*)this + 2272); }
	public @property final auto ref SoundCue m_MissileLockingCue() { return *cast(SoundCue*)(cast(size_t)cast(void*)this + 2268); }
	public @property final auto ref int m_OverwatchTeam() { return *cast(int*)(cast(size_t)cast(void*)this + 2236); }
	public @property final auto ref CameraActor m_OverwatchCam() { return *cast(CameraActor*)(cast(size_t)cast(void*)this + 2232); }
	public @property final auto ref Rotator m_rKickbackAim() { return *cast(Rotator*)(cast(size_t)cast(void*)this + 2208); }
	public @property final auto ref float m_fLastKickbackViewTime() { return *cast(float*)(cast(size_t)cast(void*)this + 2204); }
	public @property final auto ref float m_fKickbackViewBlendInTime() { return *cast(float*)(cast(size_t)cast(void*)this + 2200); }
	public @property final auto ref float m_fKickbackViewBlendOutTime() { return *cast(float*)(cast(size_t)cast(void*)this + 2196); }
	public @property final auto ref float m_fRemainingInitiatingJettingTime() { return *cast(float*)(cast(size_t)cast(void*)this + 2192); }
	public @property final bool bWarmingUp() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x20000000) != 0; }
	public @property final bool bWarmingUp(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x20000000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x20000000; } return val; }
	public @property final bool m_bAirSpeedBoundToGroundSpeed() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x8000000) != 0; }
	public @property final bool m_bAirSpeedBoundToGroundSpeed(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x8000000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x8000000; } return val; }
	public @property final bool m_bEnableChatFilter() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x4000000) != 0; }
	public @property final bool m_bEnableChatFilter(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x4000000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x4000000; } return val; }
	public @property final bool bBlockForAcquisition() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x1000000) != 0; }
	public @property final bool bBlockForAcquisition(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x1000000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x1000000; } return val; }
	public @property final bool m_bAnimMenu() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x200000) != 0; }
	public @property final bool m_bAnimMenu(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x200000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x200000; } return val; }
	public @property final bool m_bShowHUDFriendStateNotifications() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x80000) != 0; }
	public @property final bool m_bShowHUDFriendStateNotifications(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x80000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x80000; } return val; }
	public @property final bool m_bShowHUDNotifications() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x40000) != 0; }
	public @property final bool m_bShowHUDNotifications(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x40000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x40000; } return val; }
	public @property final bool m_bShowHUDObjectives() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x2) != 0; }
	public @property final bool m_bShowHUDObjectives(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x2; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x2; } return val; }
	public @property final bool m_bEnableOverheadDamageIndicators() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2188) & 0x1) != 0; }
	public @property final bool m_bEnableOverheadDamageIndicators(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2188) |= 0x1; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2188) &= ~0x1; } return val; }
	public @property final bool r_bViewTargetVehicleSecondaryWeaponReady() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x80000000) != 0; }
	public @property final bool r_bViewTargetVehicleSecondaryWeaponReady(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x80000000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x80000000; } return val; }
	public @property final bool r_bViewTargetVehiclePrimaryWeaponReady() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x40000000) != 0; }
	public @property final bool r_bViewTargetVehiclePrimaryWeaponReady(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x40000000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x40000000; } return val; }
	public @property final bool r_bWeeklyCompleted() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x4000000) != 0; }
	public @property final bool r_bWeeklyCompleted(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x4000000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x4000000; } return val; }
	public @property final bool m_bIsJumpJetting() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x1000000) != 0; }
	public @property final bool m_bIsJumpJetting(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x1000000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x1000000; } return val; }
	public @property final bool m_bJustJoined() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x800000) != 0; }
	public @property final bool m_bJustJoined(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x800000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x800000; } return val; }
	public @property final bool m_bMonkeyMode() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x100000) != 0; }
	public @property final bool m_bMonkeyMode(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x100000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x100000; } return val; }
	public @property final bool m_bJetpackHelpTextThresholdReached() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x80000) != 0; }
	public @property final bool m_bJetpackHelpTextThresholdReached(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x80000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x80000; } return val; }
	public @property final bool m_bSkiHelpTextThresholdReached() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x40000) != 0; }
	public @property final bool m_bSkiHelpTextThresholdReached(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x40000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x40000; } return val; }
	public @property final bool m_bEnableCameraSpeedEffect() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x20000) != 0; }
	public @property final bool m_bEnableCameraSpeedEffect(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x20000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x20000; } return val; }
	public @property final bool m_bLoadoutChangeAlerted() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x4000) != 0; }
	public @property final bool m_bLoadoutChangeAlerted(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x4000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x4000; } return val; }
	public @property final bool m_bRequestingSki() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x2000) != 0; }
	public @property final bool m_bRequestingSki(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x2000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x2000; } return val; }
	public @property final bool m_bPlayerSwappedTeams() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x1000) != 0; }
	public @property final bool m_bPlayerSwappedTeams(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x1000; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x1000; } return val; }
	public @property final bool m_bReturnTo3PAfterZoom() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x800) != 0; }
	public @property final bool m_bReturnTo3PAfterZoom(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x800; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x800; } return val; }
	public @property final bool m_bZoomMagnified() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x400) != 0; }
	public @property final bool m_bZoomMagnified(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x400; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x400; } return val; }
	public @property final bool m_bPlayCreditsSound() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x100) != 0; }
	public @property final bool m_bPlayCreditsSound(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x100; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x100; } return val; }
	public @property final bool bWasAutoBalanced() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x80) != 0; }
	public @property final bool bWasAutoBalanced(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x80; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x80; } return val; }
	public @property final bool m_bAftermathKill() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x40) != 0; }
	public @property final bool m_bAftermathKill(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x40; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x40; } return val; }
	public @property final bool m_bKickbackBlendingIn() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x20) != 0; }
	public @property final bool m_bKickbackBlendingIn(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x20; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x20; } return val; }
	public @property final bool m_bBlink() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x10) != 0; }
	public @property final bool m_bBlink(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x10; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x10; } return val; }
	public @property final bool m_bJumpJet() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x8) != 0; }
	public @property final bool m_bJumpJet(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x8; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x8; } return val; }
	public @property final bool m_bPressingJetpackButton() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x2) != 0; }
	public @property final bool m_bPressingJetpackButton(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x2; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x2; } return val; }
	public @property final bool m_bEditorMode() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2184) & 0x1) != 0; }
	public @property final bool m_bEditorMode(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2184) |= 0x1; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2184) &= ~0x1; } return val; }
	public @property final auto ref float m_fLastWeaponSwitchTimestamp() { return *cast(float*)(cast(size_t)cast(void*)this + 2180); }
	public @property final auto ref Actor m_aHoverActor() { return *cast(Actor*)(cast(size_t)cast(void*)this + 2176); }
	final int GetLanguageFontIndex()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[53555], params.ptr, cast(void*)0);
		return *cast(int*)params.ptr;
	}
	final bool InTraining()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[53578], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final ScriptClass GetFamilyInfoFromId(int ClassId)
	{
		ubyte params[8];
		params[] = 0;
		*cast(int*)params.ptr = ClassId;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[53589], params.ptr, cast(void*)0);
		return *cast(ScriptClass*)&params[4];
	}
	final TrDevice GetDeviceByEquipPoint(TrObject.TR_EQUIP_POINT EquipPoint)
	{
		ubyte params[5];
		params[] = 0;
		*cast(TrObject.TR_EQUIP_POINT*)params.ptr = EquipPoint;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[53730], params.ptr, cast(void*)0);
		return *cast(TrDevice*)&params[4];
	}
	final UTWeapon.EZoomState GetZoomedState()
	{
		ubyte params[1];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[53735], params.ptr, cast(void*)0);
		return *cast(UTWeapon.EZoomState*)params.ptr;
	}
	final bool InRovingSpectate()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[53743], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final bool IsTrPlayerMuted(ScriptString PlayerName)
	{
		ubyte params[16];
		params[] = 0;
		*cast(ScriptString*)params.ptr = PlayerName;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[54526], params.ptr, cast(void*)0);
		return *cast(bool*)&params[12];
	}
	final int GetActiveClassId()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[54706], params.ptr, cast(void*)0);
		return *cast(int*)params.ptr;
	}
	final int GetTeamClassCount(int ClassId)
	{
		ubyte params[8];
		params[] = 0;
		*cast(int*)params.ptr = ClassId;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[56812], params.ptr, cast(void*)0);
		return *cast(int*)&params[4];
	}
	final bool RegisterPendingClass(int ClassId, int Loadout)
	{
		ubyte params[12];
		params[] = 0;
		*cast(int*)params.ptr = ClassId;
		*cast(int*)&params[4] = Loadout;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[58333], params.ptr, cast(void*)0);
		return *cast(bool*)&params[8];
	}
	final int GetAllowedClassCount(TrObject.TrClassType ClassType)
	{
		ubyte params[5];
		params[] = 0;
		*cast(TrObject.TrClassType*)params.ptr = ClassType;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[58399], params.ptr, cast(void*)0);
		return *cast(int*)&params[4];
	}
	final bool SendPrivateChatMessage(ScriptString PlayerName, ScriptString Message)
	{
		ubyte params[28];
		params[] = 0;
		*cast(ScriptString*)params.ptr = PlayerName;
		*cast(ScriptString*)&params[12] = Message;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[58832], params.ptr, cast(void*)0);
		return *cast(bool*)&params[24];
	}
	final bool BroadcastChatMessage(TgSupportCommands.GC_CHAT_CHANNEL Channel, ScriptString Message)
	{
		ubyte params[17];
		params[] = 0;
		*cast(TgSupportCommands.GC_CHAT_CHANNEL*)params.ptr = Channel;
		*cast(ScriptString*)&params[4] = Message;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[59829], params.ptr, cast(void*)0);
		return *cast(bool*)&params[16];
	}
	final bool ServerRequestPickTeam(ubyte RequestedTeamNum)
	{
		ubyte params[5];
		params[] = 0;
		params[0] = RequestedTeamNum;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[65204], params.ptr, cast(void*)0);
		return *cast(bool*)&params[4];
	}
	final bool ChooseBloodEagle()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[65206], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final bool ChooseDiamondSword()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[65209], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final int GetVehicleCost(ScriptClass VehicleClass)
	{
		ubyte params[8];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = VehicleClass;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[65227], params.ptr, cast(void*)0);
		return *cast(int*)&params[4];
	}
	final int GetCurrentCredits()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[65231], params.ptr, cast(void*)0);
		return *cast(int*)params.ptr;
	}
	final bool IsBassBoostToggled()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[68991], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final bool AllowHelpTextToDisplay()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[69957], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final bool NeedToVisitInventoryStation()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[71606], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final float GetCurrentDetermination()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[72626], params.ptr, cast(void*)0);
		return *cast(float*)params.ptr;
	}
	final float GetNewPlayerAssistToApply()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[72751], params.ptr, cast(void*)0);
		return *cast(float*)params.ptr;
	}
	final void PlayReliableSound(SoundCue InSoundCue, bool bNotReplicated, bool bNoRepToOwner, bool bStopWhenOwnerDestroyed, Vector SoundLocation, bool bNoRepToRelevant)
	{
		ubyte params[32];
		params[] = 0;
		*cast(SoundCue*)params.ptr = InSoundCue;
		*cast(bool*)&params[4] = bNotReplicated;
		*cast(bool*)&params[8] = bNoRepToOwner;
		*cast(bool*)&params[12] = bStopWhenOwnerDestroyed;
		*cast(Vector*)&params[16] = SoundLocation;
		*cast(bool*)&params[28] = bNoRepToRelevant;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[74088], params.ptr, cast(void*)0);
	}
	final void SendCtrlRequest(ScriptString fsRequest)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptString*)params.ptr = fsRequest;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76203], params.ptr, cast(void*)0);
	}
	final void SendGameRequest(ScriptString fsRequest)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptString*)params.ptr = fsRequest;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76205], params.ptr, cast(void*)0);
	}
	final void TestSteamPurchase()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76207], cast(void*)0, cast(void*)0);
	}
	final void ShowAdminPage(ScriptString ServerURL)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptString*)params.ptr = ServerURL;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76208], params.ptr, cast(void*)0);
	}
	final void SetHitValidationMode(int loggingMode, int validationMode)
	{
		ubyte params[8];
		params[] = 0;
		*cast(int*)params.ptr = loggingMode;
		*cast(int*)&params[4] = validationMode;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76210], params.ptr, cast(void*)0);
	}
	final void KickPlayerFromMatch(int Reason)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Reason;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76213], params.ptr, cast(void*)0);
	}
	final bool MainMenuIsOpen()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76215], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final void SetMenuInGame()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76217], cast(void*)0, cast(void*)0);
	}
	final void SendMenuToLobby()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76218], cast(void*)0, cast(void*)0);
	}
	final void TweenSummaryScreen()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76219], cast(void*)0, cast(void*)0);
	}
	final void SetMenuSummaryScreen()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76220], cast(void*)0, cast(void*)0);
	}
	final void SetMenuEndOfMatch()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76221], cast(void*)0, cast(void*)0);
	}
	final void BeginExperienceTweens()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76222], cast(void*)0, cast(void*)0);
	}
	final void KickVoteReply(bool bVote)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bVote;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76223], params.ptr, cast(void*)0);
	}
	final void SetMenuMatchCountdown(int Seconds)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Seconds;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76225], params.ptr, cast(void*)0);
	}
	final int GetUserSelectedClass()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76227], params.ptr, cast(void*)0);
		return *cast(int*)params.ptr;
	}
	final void RevertSetting()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76229], cast(void*)0, cast(void*)0);
	}
	final void SendMenuBack()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76230], cast(void*)0, cast(void*)0);
	}
	final void FireAcquisition()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76231], cast(void*)0, cast(void*)0);
	}
	final void ForceFocus()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76232], cast(void*)0, cast(void*)0);
	}
	final void UpdateTVTimer()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76233], cast(void*)0, cast(void*)0);
	}
	final void UpdateDealTimer()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76234], cast(void*)0, cast(void*)0);
	}
	final void UpdateQueueTimer()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76235], cast(void*)0, cast(void*)0);
	}
	final void ToggleWorkingGraphic(bool bEnabled)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnabled;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76236], params.ptr, cast(void*)0);
	}
	final void EndHotkeyBlock()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76238], cast(void*)0, cast(void*)0);
	}
	final void MutePlayer(ScriptString PlayerName)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptString*)params.ptr = PlayerName;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76239], params.ptr, cast(void*)0);
	}
	final void UnmutePlayer(ScriptString PlayerName)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptString*)params.ptr = PlayerName;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76241], params.ptr, cast(void*)0);
	}
	final bool HaveMenu()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76244], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final bool IsChatFiltered(ScriptString PlayerName)
	{
		ubyte params[16];
		params[] = 0;
		*cast(ScriptString*)params.ptr = PlayerName;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76246], params.ptr, cast(void*)0);
		return *cast(bool*)&params[12];
	}
	final void RequestKickVote(ScriptString PlayerName)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptString*)params.ptr = PlayerName;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76249], params.ptr, cast(void*)0);
	}
	final void HideMenu()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76251], cast(void*)0, cast(void*)0);
	}
	final void OpenMenu()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76252], cast(void*)0, cast(void*)0);
	}
	final void OpenClasses()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76253], cast(void*)0, cast(void*)0);
	}
	final void ToggleFriends()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76254], cast(void*)0, cast(void*)0);
	}
	final void ToggleSettings()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76255], cast(void*)0, cast(void*)0);
	}
	final void ToggleMainMenu()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76256], cast(void*)0, cast(void*)0);
	}
	final void ClaimPromotion(ScriptString PromoCode)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptString*)params.ptr = PromoCode;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76257], params.ptr, cast(void*)0);
	}
	final void FireUILoadSummary()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76259], cast(void*)0, cast(void*)0);
	}
	final void FireRefreshPage()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76260], cast(void*)0, cast(void*)0);
	}
	final void ToggleBassBoost(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76261], params.ptr, cast(void*)0);
	}
	final void ForwardChatFlag()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76263], cast(void*)0, cast(void*)0);
	}
	final void ShowNotification(ScriptString Message, ScriptString Message2)
	{
		ubyte params[24];
		params[] = 0;
		*cast(ScriptString*)params.ptr = Message;
		*cast(ScriptString*)&params[12] = Message2;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76264], params.ptr, cast(void*)0);
	}
	final void HideNotification()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76267], cast(void*)0, cast(void*)0);
	}
	final void ChatMessageReceived(int Channel, ScriptString Sender, ScriptString Message)
	{
		ubyte params[28];
		params[] = 0;
		*cast(int*)params.ptr = Channel;
		*cast(ScriptString*)&params[4] = Sender;
		*cast(ScriptString*)&params[16] = Message;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76268], params.ptr, cast(void*)0);
	}
	final void ShowChat()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76272], cast(void*)0, cast(void*)0);
	}
	final void HideChat()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76273], cast(void*)0, cast(void*)0);
	}
	final void ToggleChat()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76274], cast(void*)0, cast(void*)0);
	}
	final void PushChat(ScriptString chatStr)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptString*)params.ptr = chatStr;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76275], params.ptr, cast(void*)0);
	}
	final void Bug()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76277], cast(void*)0, cast(void*)0);
	}
	final void _Crash()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76278], cast(void*)0, cast(void*)0);
	}
	final bool IsGameUsingSeekFreeLoading()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76279], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final void ResetRunaway()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76281], cast(void*)0, cast(void*)0);
	}
	final void ClearVehicleMenu()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76282], cast(void*)0, cast(void*)0);
	}
	final void ShowVehicleMenu(int Credits)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Credits;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76283], params.ptr, cast(void*)0);
	}
	final void AddVehicleMenuOption(ScriptString ClassName, ScriptString DisplayName, int Cost, int Icon, int CountSpawned, int CountAllowed)
	{
		ubyte params[40];
		params[] = 0;
		*cast(ScriptString*)params.ptr = ClassName;
		*cast(ScriptString*)&params[12] = DisplayName;
		*cast(int*)&params[24] = Cost;
		*cast(int*)&params[28] = Icon;
		*cast(int*)&params[32] = CountSpawned;
		*cast(int*)&params[36] = CountAllowed;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76285], params.ptr, cast(void*)0);
	}
	final void GetOnlineFriends(ScriptArray!(ScriptString)* vFriends)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptArray!(ScriptString)*)params.ptr = *vFriends;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76292], params.ptr, cast(void*)0);
		*vFriends = *cast(ScriptArray!(ScriptString)*)params.ptr;
	}
	final void PostBeginPlay()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76301], cast(void*)0, cast(void*)0);
	}
	final void InitHelpTextManager()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76310], cast(void*)0, cast(void*)0);
	}
	final void InitInputSystem()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76311], cast(void*)0, cast(void*)0);
	}
	final void PlayAnnouncerSound(SoundCue AnnouncementCue, bool bPlayRightNow)
	{
		ubyte params[8];
		params[] = 0;
		*cast(SoundCue*)params.ptr = AnnouncementCue;
		*cast(bool*)&params[4] = bPlayRightNow;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76312], params.ptr, cast(void*)0);
	}
	final void TestAnnouncement(bool bPlayRightNow)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bPlayRightNow;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76315], params.ptr, cast(void*)0);
	}
	final void ClientHearReliableSound(SoundCue ASound, Actor SourceActor, Vector SourceLocation, bool bStopWhenOwnerDestroyed, bool bIsOccluded)
	{
		ubyte params[28];
		params[] = 0;
		*cast(SoundCue*)params.ptr = ASound;
		*cast(Actor*)&params[4] = SourceActor;
		*cast(Vector*)&params[8] = SourceLocation;
		*cast(bool*)&params[20] = bStopWhenOwnerDestroyed;
		*cast(bool*)&params[24] = bIsOccluded;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76318], params.ptr, cast(void*)0);
	}
	final void ClientMySaberLauncherTargetingUpdated(TrObject.EMissileLock MissileLockValue)
	{
		ubyte params[1];
		params[] = 0;
		*cast(TrObject.EMissileLock*)params.ptr = MissileLockValue;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76325], params.ptr, cast(void*)0);
	}
	final void ClientSeekingMissileTargetingSelfEvent(int EventSwitch)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = EventSwitch;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76327], params.ptr, cast(void*)0);
	}
	final void OnMissileIntercepted()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76333], cast(void*)0, cast(void*)0);
	}
	final void ShowHUDNotification(ScriptString Message, ScriptString Message2)
	{
		ubyte params[24];
		params[] = 0;
		*cast(ScriptString*)params.ptr = Message;
		*cast(ScriptString*)&params[12] = Message2;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76334], params.ptr, cast(void*)0);
	}
	final void HideHUDNotification()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76339], cast(void*)0, cast(void*)0);
	}
	final void CheckBulletWhip(SoundCue BulletWhip, Vector FireLocation, Vector FireDir, Vector HitLocation)
	{
		ubyte params[40];
		params[] = 0;
		*cast(SoundCue*)params.ptr = BulletWhip;
		*cast(Vector*)&params[4] = FireLocation;
		*cast(Vector*)&params[16] = FireDir;
		*cast(Vector*)&params[28] = HitLocation;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76341], params.ptr, cast(void*)0);
	}
	final void ReplicatedEvent(ScriptName VarName)
	{
		ubyte params[8];
		params[] = 0;
		*cast(ScriptName*)params.ptr = VarName;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76349], params.ptr, cast(void*)0);
	}
	final void ProcessCreditEvent(TrObject.TrCreditEventType EventType, bool bProxyEvent)
	{
		ubyte params[5];
		params[] = 0;
		*cast(TrObject.TrCreditEventType*)params.ptr = EventType;
		*cast(bool*)&params[4] = bProxyEvent;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76352], params.ptr, cast(void*)0);
	}
	final void ModifyCredits(int Count, bool bFreeCredits)
	{
		ubyte params[8];
		params[] = 0;
		*cast(int*)params.ptr = Count;
		*cast(bool*)&params[4] = bFreeCredits;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76362], params.ptr, cast(void*)0);
	}
	final void UpdateCurrentCredits(int Count)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Count;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76370], params.ptr, cast(void*)0);
	}
	final void CreditsSoundFinished(
// ERROR: Unknown object class 'Class Core.ComponentProperty'~
void* AC)
	{
		ubyte params[4];
		params[] = 0;
		*cast(
// ERROR: Unknown object class 'Class Core.ComponentProperty'~
void**)params.ptr = AC;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76374], params.ptr, cast(void*)0);
	}
	final void ClientUpdateCredits(int Count)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Count;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76376], params.ptr, cast(void*)0);
	}
	final int GetLatestAccoladeIconIndex()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76378], params.ptr, cast(void*)0);
		return *cast(int*)params.ptr;
	}
	final void ClientShowAccoladeIcon(int IconIndex, ScriptString Description, ScriptString Points)
	{
		ubyte params[28];
		params[] = 0;
		*cast(int*)params.ptr = IconIndex;
		*cast(ScriptString*)&params[4] = Description;
		*cast(ScriptString*)&params[16] = Points;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76381], params.ptr, cast(void*)0);
	}
	final void ClientShowAccoladeText(ScriptString Message, int ShowTime)
	{
		ubyte params[16];
		params[] = 0;
		*cast(ScriptString*)params.ptr = Message;
		*cast(int*)&params[12] = ShowTime;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76385], params.ptr, cast(void*)0);
	}
	final void ResetStreaks()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76388], cast(void*)0, cast(void*)0);
	}
	final void GiveCredits(int Count)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Count;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76389], params.ptr, cast(void*)0);
	}
	final void ServerGiveCreditsCheat(int Count)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Count;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76391], params.ptr, cast(void*)0);
	}
	final bool AimingHelp(bool bInstantHit)
	{
		ubyte params[8];
		params[] = 0;
		*cast(bool*)params.ptr = bInstantHit;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76395], params.ptr, cast(void*)0);
		return *cast(bool*)&params[4];
	}
	final void NotifyChangedWeapon(Weapon PreviousWeapon, Weapon NewWeapon)
	{
		ubyte params[8];
		params[] = 0;
		*cast(Weapon*)params.ptr = PreviousWeapon;
		*cast(Weapon*)&params[4] = NewWeapon;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76398], params.ptr, cast(void*)0);
	}
	final void ReloadWeapon()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76402], cast(void*)0, cast(void*)0);
	}
	final void ServerReloadWeapon()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76409], cast(void*)0, cast(void*)0);
	}
	final void ServerSetCharFamily(ScriptString FamilyClassStr)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptString*)params.ptr = FamilyClassStr;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76410], params.ptr, cast(void*)0);
	}
	final void Suicide()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76414], cast(void*)0, cast(void*)0);
	}
	final void ServerSuicide()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76416], cast(void*)0, cast(void*)0);
	}
	final TrObject.EArmorType GetArmorType()
	{
		ubyte params[1];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76417], params.ptr, cast(void*)0);
		return *cast(TrObject.EArmorType*)params.ptr;
	}
	final float GetRespawnDelayTotalTime()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76420], params.ptr, cast(void*)0);
		return *cast(float*)params.ptr;
	}
	final Rotator LimitViewRotation(Rotator ViewRotation, float ViewPitchMin, float ViewPitchMax)
	{
		ubyte params[32];
		params[] = 0;
		*cast(Rotator*)params.ptr = ViewRotation;
		*cast(float*)&params[12] = ViewPitchMin;
		*cast(float*)&params[16] = ViewPitchMax;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76427], params.ptr, cast(void*)0);
		return *cast(Rotator*)&params[20];
	}
	final void PressedMelee()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76432], cast(void*)0, cast(void*)0);
	}
	final void PressedLaser()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76434], cast(void*)0, cast(void*)0);
	}
	final void PressedBelt()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76435], cast(void*)0, cast(void*)0);
	}
	final void PressedPack()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76438], cast(void*)0, cast(void*)0);
	}
	final void PressedDeployable()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76447], cast(void*)0, cast(void*)0);
	}
	final void SetShowEquip(bool bShow)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bShow;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76448], params.ptr, cast(void*)0);
	}
	final void PressedConsoleUse()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76450], cast(void*)0, cast(void*)0);
	}
	final void PressedWeaponSwitch(bool bFilterTimeStamp)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bFilterTimeStamp;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76451], params.ptr, cast(void*)0);
	}
	final void EquipPrimary()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76453], cast(void*)0, cast(void*)0);
	}
	final void EquipSecondary()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76456], cast(void*)0, cast(void*)0);
	}
	final void SwitchWeapon(ubyte T)
	{
		ubyte params[1];
		params[] = 0;
		params[0] = T;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76459], params.ptr, cast(void*)0);
	}
	final void PrevWeapon()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76462], cast(void*)0, cast(void*)0);
	}
	final void NextWeapon()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76463], cast(void*)0, cast(void*)0);
	}
	final void ActivateDevice(TrObject.TR_EQUIP_POINT EquipPoint)
	{
		ubyte params[1];
		params[] = 0;
		*cast(TrObject.TR_EQUIP_POINT*)params.ptr = EquipPoint;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76464], params.ptr, cast(void*)0);
	}
	final void StartFire(ubyte FireModeNum)
	{
		ubyte params[1];
		params[] = 0;
		params[0] = FireModeNum;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76470], params.ptr, cast(void*)0);
	}
	final void UpdateLockedTarget(Actor LockedActor)
	{
		ubyte params[4];
		params[] = 0;
		*cast(Actor*)params.ptr = LockedActor;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76473], params.ptr, cast(void*)0);
	}
	final void IdentifyTeamMessage()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76476], cast(void*)0, cast(void*)0);
	}
	final void PlayStartupMessage(ubyte StartupStage)
	{
		ubyte params[1];
		params[] = 0;
		params[0] = StartupStage;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76480], params.ptr, cast(void*)0);
	}
	final void FindValidGRI()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76482], cast(void*)0, cast(void*)0);
	}
	final void InitHUDObjects()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76483], cast(void*)0, cast(void*)0);
	}
	final void ClientStartSpawnTimer()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76484], cast(void*)0, cast(void*)0);
	}
	final void CompletePickTeam()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76489], cast(void*)0, cast(void*)0);
	}
	final void ServerRequestAutoAssignTeam()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76492], cast(void*)0, cast(void*)0);
	}
	final void ClientEndTeamSelect(int RequestedTeamNum)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = RequestedTeamNum;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76498], params.ptr, cast(void*)0);
	}
	final void ChangeTeam(ScriptString TeamName)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptString*)params.ptr = TeamName;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76501], params.ptr, cast(void*)0);
	}
	final void ViewAPlayer(int Dir)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Dir;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76522], params.ptr, cast(void*)0);
	}
	final void ServerPlayerTick(float DeltaTime)
	{
		ubyte params[4];
		params[] = 0;
		*cast(float*)params.ptr = DeltaTime;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76529], params.ptr, cast(void*)0);
	}
	final void PlayerTick(float DeltaTime)
	{
		ubyte params[4];
		params[] = 0;
		*cast(float*)params.ptr = DeltaTime;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76531], params.ptr, cast(void*)0);
	}
	final Rotator GetAdjustedAimFor(Weapon W, Vector StartFireLoc)
	{
		ubyte params[28];
		params[] = 0;
		*cast(Weapon*)params.ptr = W;
		*cast(Vector*)&params[4] = StartFireLoc;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76538], params.ptr, cast(void*)0);
		return *cast(Rotator*)&params[16];
	}
	final void StartWeather()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76543], cast(void*)0, cast(void*)0);
	}
	final void StopWeather()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76545], cast(void*)0, cast(void*)0);
	}
	final void PawnEnteredWeatherVolume(bool bDeactivatePawnCentricWeather, TrWeatherVolume WeatherVolume)
	{
		ubyte params[8];
		params[] = 0;
		*cast(bool*)params.ptr = bDeactivatePawnCentricWeather;
		*cast(TrWeatherVolume*)&params[4] = WeatherVolume;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76546], params.ptr, cast(void*)0);
	}
	final void PawnLeftWeatherVolume(bool bDeactivatePawnCentricWeather, TrWeatherVolume WeatherVolume)
	{
		ubyte params[8];
		params[] = 0;
		*cast(bool*)params.ptr = bDeactivatePawnCentricWeather;
		*cast(TrWeatherVolume*)&params[4] = WeatherVolume;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76549], params.ptr, cast(void*)0);
	}
	final void PlayLowHealthFX()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76552], cast(void*)0, cast(void*)0);
	}
	final void StopLowHealthFX()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76555], cast(void*)0, cast(void*)0);
	}
	final void PlayRechargeHealthFX()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76556], cast(void*)0, cast(void*)0);
	}
	final void StopRechargeHealthFX()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76559], cast(void*)0, cast(void*)0);
	}
	final void ToggleJetpack(bool bEnabled, bool bJump)
	{
		ubyte params[8];
		params[] = 0;
		*cast(bool*)params.ptr = bEnabled;
		*cast(bool*)&params[4] = bJump;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76560], params.ptr, cast(void*)0);
	}
	final void EnableJetpack(bool bEnabled, bool bJump, bool bForcedOff)
	{
		ubyte params[12];
		params[] = 0;
		*cast(bool*)params.ptr = bEnabled;
		*cast(bool*)&params[4] = bJump;
		*cast(bool*)&params[8] = bForcedOff;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76563], params.ptr, cast(void*)0);
	}
	final void IgnoreMoveInput(bool bNewMoveInput)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bNewMoveInput;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76573], params.ptr, cast(void*)0);
	}
	final void DoJump()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76575], cast(void*)0, cast(void*)0);
	}
	final void PerformBlink()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76576], cast(void*)0, cast(void*)0);
	}
	final void GetBlinkPackAccel(Vector* newAccel, float* BlinkPackPctEffectiveness)
	{
		ubyte params[16];
		params[] = 0;
		*cast(Vector*)params.ptr = *newAccel;
		*cast(float*)&params[12] = *BlinkPackPctEffectiveness;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76577], params.ptr, cast(void*)0);
		*newAccel = *cast(Vector*)params.ptr;
		*BlinkPackPctEffectiveness = *cast(float*)&params[12];
	}
	final void InitRespawnTimer()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76623], cast(void*)0, cast(void*)0);
	}
	final void UpdateRespawnTimer()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76624], cast(void*)0, cast(void*)0);
	}
	final void ServerRequestRespawn()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76627], cast(void*)0, cast(void*)0);
	}
	final void RequestRespawn()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76630], cast(void*)0, cast(void*)0);
	}
	final void Respawn()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76631], cast(void*)0, cast(void*)0);
	}
	final void PlayRespawnSoonSound()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76632], cast(void*)0, cast(void*)0);
	}
	final void CleanupGameplayEffectsOnDeath()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76635], cast(void*)0, cast(void*)0);
	}
	final void OnCrossedOffArenaList()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76638], cast(void*)0, cast(void*)0);
	}
	final void Possess(Pawn aPawn, bool bVehicleTransition)
	{
		ubyte params[8];
		params[] = 0;
		*cast(Pawn*)params.ptr = aPawn;
		*cast(bool*)&params[4] = bVehicleTransition;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76670], params.ptr, cast(void*)0);
	}
	final void RefreshHUD()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76675], cast(void*)0, cast(void*)0);
	}
	final bool GetAirVehicleInversion()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76676], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final void ServerSetAirVehicleControls(bool bInvert)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bInvert;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76678], params.ptr, cast(void*)0);
	}
	final void SetAirVehicleControls(bool bInvert)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bInvert;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76680], params.ptr, cast(void*)0);
	}
	final bool IsInVehicle()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76682], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final void ClientVehiclePhysUpdated(TrVehicle InVehicle)
	{
		ubyte params[4];
		params[] = 0;
		*cast(TrVehicle*)params.ptr = InVehicle;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76684], params.ptr, cast(void*)0);
	}
	final void ServerVehiclePhysUpdated(TrVehicle InVehicle)
	{
		ubyte params[4];
		params[] = 0;
		*cast(TrVehicle*)params.ptr = InVehicle;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76686], params.ptr, cast(void*)0);
	}
	final void ServerVerifyVehiclePhys(float TimeStamp, float InForward, float InStrafe, float InUp, int View, Actor.RigidBodyState InRBState)
	{
		ubyte params[84];
		params[] = 0;
		*cast(float*)params.ptr = TimeStamp;
		*cast(float*)&params[4] = InForward;
		*cast(float*)&params[8] = InStrafe;
		*cast(float*)&params[12] = InUp;
		*cast(int*)&params[16] = View;
		*cast(Actor.RigidBodyState*)&params[32] = InRBState;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76688], params.ptr, cast(void*)0);
	}
	final void ServerCorrectClientPhys(float TimeStamp)
	{
		ubyte params[4];
		params[] = 0;
		*cast(float*)params.ptr = TimeStamp;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76699], params.ptr, cast(void*)0);
	}
	final void ServerToggleVehicleJets(bool bEnabled)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnabled;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76703], params.ptr, cast(void*)0);
	}
	final void ToggleVehicleJets(bool bEnabled)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnabled;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76705], params.ptr, cast(void*)0);
	}
	final void ProcessRiding(Rotator ViewRotation)
	{
		ubyte params[12];
		params[] = 0;
		*cast(Rotator*)params.ptr = ViewRotation;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76741], params.ptr, cast(void*)0);
	}
	final void ServerRiding(float TimeStamp, int View)
	{
		ubyte params[8];
		params[] = 0;
		*cast(float*)params.ptr = TimeStamp;
		*cast(int*)&params[4] = View;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76743], params.ptr, cast(void*)0);
	}
	final void SwitchToCallIn(ubyte T)
	{
		ubyte params[1];
		params[] = 0;
		params[0] = T;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76795], params.ptr, cast(void*)0);
	}
	final void ServerRequestCallInChange(ubyte T)
	{
		ubyte params[1];
		params[] = 0;
		params[0] = T;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76803], params.ptr, cast(void*)0);
	}
	final void SwitchToSeat(ubyte T)
	{
		ubyte params[1];
		params[] = 0;
		params[0] = T;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76806], params.ptr, cast(void*)0);
	}
	final void ServerSwitchToSeat(ubyte T, TrVehicle V)
	{
		ubyte params[5];
		params[] = 0;
		params[0] = T;
		*cast(TrVehicle*)&params[4] = V;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76811], params.ptr, cast(void*)0);
	}
	final bool TriggerInteracted()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76816], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final void ServerRequestLoadoutChange(ScriptClass FamilyInfo, int Loadout)
	{
		ubyte params[8];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = FamilyInfo;
		*cast(int*)&params[4] = Loadout;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76827], params.ptr, cast(void*)0);
	}
	final void UpdatePaperDoll(ScriptClass FamilyInfo, ScriptClass DeviceClass, ScriptClass skinClass, int TeamNum)
	{
		ubyte params[16];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = FamilyInfo;
		*cast(ScriptClass*)&params[4] = DeviceClass;
		*cast(ScriptClass*)&params[8] = skinClass;
		*cast(int*)&params[12] = TeamNum;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76844], params.ptr, cast(void*)0);
	}
	final void UpdatePaperDoll_Device(ScriptClass DeviceClass)
	{
		ubyte params[4];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = DeviceClass;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76852], params.ptr, cast(void*)0);
	}
	final void SpawnVehicle(ScriptString vehicleClassStr)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptString*)params.ptr = vehicleClassStr;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76856], params.ptr, cast(void*)0);
	}
	final void RequestBuyVehicle(ScriptString vehicleClassStr)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptString*)params.ptr = vehicleClassStr;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76858], params.ptr, cast(void*)0);
	}
	final void PressedSki(bool bJump)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bJump;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76862], params.ptr, cast(void*)0);
	}
	final void ReleasedSki()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76866], cast(void*)0, cast(void*)0);
	}
	final void ToggleSki()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76869], cast(void*)0, cast(void*)0);
	}
	final void DelayReleasedSki()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76871], cast(void*)0, cast(void*)0);
	}
	final void SetBindSkiJet(int method)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = method;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76872], params.ptr, cast(void*)0);
	}
	final void ToggleShowObjectMarkers()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76874], cast(void*)0, cast(void*)0);
	}
	final void ServerStartSki(bool bJump)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bJump;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76876], params.ptr, cast(void*)0);
	}
	final void ServerStopSki()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76879], cast(void*)0, cast(void*)0);
	}
	final void ClientSetHUD(ScriptClass newHUDType)
	{
		ubyte params[4];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = newHUDType;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76881], params.ptr, cast(void*)0);
	}
	final void SwitchHud()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76884], cast(void*)0, cast(void*)0);
	}
	final void OnKickback(Rotator KickbackAim, float KickbackBlendOutTime)
	{
		ubyte params[16];
		params[] = 0;
		*cast(Rotator*)params.ptr = KickbackAim;
		*cast(float*)&params[12] = KickbackBlendOutTime;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76886], params.ptr, cast(void*)0);
	}
	final void UpdateKickbackDirection(float DeltaTime)
	{
		ubyte params[4];
		params[] = 0;
		*cast(float*)params.ptr = DeltaTime;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76889], params.ptr, cast(void*)0);
	}
	final void RestoreMoveInput()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76891], cast(void*)0, cast(void*)0);
	}
	final void ClientRestoreMoveInput()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76892], cast(void*)0, cast(void*)0);
	}
	final void ServerRequestSpawnVehicle(ScriptClass VehicleClass)
	{
		ubyte params[4];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = VehicleClass;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76893], params.ptr, cast(void*)0);
	}
	final bool PerformedUseAction()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76899], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final void PressedZoom()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76901], cast(void*)0, cast(void*)0);
	}
	final void ReleasedZoom()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76902], cast(void*)0, cast(void*)0);
	}
	final void MagnifyZoom()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76903], cast(void*)0, cast(void*)0);
	}
	final void DemagnifyZoom()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76906], cast(void*)0, cast(void*)0);
	}
	final void ReleaseZoom()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76909], cast(void*)0, cast(void*)0);
	}
	final void CheckZoomButton()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76910], cast(void*)0, cast(void*)0);
	}
	final void TrStartZoom()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76911], cast(void*)0, cast(void*)0);
	}
	final void TrStopZoom()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76918], cast(void*)0, cast(void*)0);
	}
	final void TrEndZoom()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76919], cast(void*)0, cast(void*)0);
	}
	final void ResetZoomDuration(bool bPlayRechargeSoundOnWeapon)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bPlayRechargeSoundOnWeapon;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76924], params.ptr, cast(void*)0);
	}
	final void ServerSetZoom(UTWeapon.EZoomState NewZoomState)
	{
		ubyte params[1];
		params[] = 0;
		*cast(UTWeapon.EZoomState*)params.ptr = NewZoomState;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76927], params.ptr, cast(void*)0);
	}
	final void ReceiveLocalizedMessage(ScriptClass Message, int Switch, PlayerReplicationInfo RelatedPRI_1, PlayerReplicationInfo RelatedPRI_2, UObject OptionalObject)
	{
		ubyte params[20];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = Message;
		*cast(int*)&params[4] = Switch;
		*cast(PlayerReplicationInfo*)&params[8] = RelatedPRI_1;
		*cast(PlayerReplicationInfo*)&params[12] = RelatedPRI_2;
		*cast(UObject*)&params[16] = OptionalObject;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76929], params.ptr, cast(void*)0);
	}
	final void ReceiveLocalizedNagMessage(ScriptClass Message, int Switch, float Time)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = Message;
		*cast(int*)&params[4] = Switch;
		*cast(float*)&params[8] = Time;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76935], params.ptr, cast(void*)0);
	}
	final void Destroyed()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76939], cast(void*)0, cast(void*)0);
	}
	final void TrClientMusicEvent(int EventIndex)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = EventIndex;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76942], params.ptr, cast(void*)0);
	}
	final void ClientRestart(Pawn NewPawn)
	{
		ubyte params[4];
		params[] = 0;
		*cast(Pawn*)params.ptr = NewPawn;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76944], params.ptr, cast(void*)0);
	}
	final void UpdateClientSpawnTimer()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76947], cast(void*)0, cast(void*)0);
	}
	final void GameHasEnded(Actor EndGameFocus, bool bIsWinner)
	{
		ubyte params[8];
		params[] = 0;
		*cast(Actor*)params.ptr = EndGameFocus;
		*cast(bool*)&params[4] = bIsWinner;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76948], params.ptr, cast(void*)0);
	}
	final void CheckJumpOrDuck()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76969], cast(void*)0, cast(void*)0);
	}
	final void ClientGameEnded(Actor EndGameFocus, bool bIsWinner)
	{
		ubyte params[8];
		params[] = 0;
		*cast(Actor*)params.ptr = EndGameFocus;
		*cast(bool*)&params[4] = bIsWinner;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76970], params.ptr, cast(void*)0);
	}
	final void ServerDropFlag()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76973], cast(void*)0, cast(void*)0);
	}
	final void GetPlayerViewPoint(Vector* POVLocation, Rotator* POVRotation)
	{
		ubyte params[24];
		params[] = 0;
		*cast(Vector*)params.ptr = *POVLocation;
		*cast(Rotator*)&params[12] = *POVRotation;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76974], params.ptr, cast(void*)0);
		*POVLocation = *cast(Vector*)params.ptr;
		*POVRotation = *cast(Rotator*)&params[12];
	}
	final void ActivateFreeCam()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76982], cast(void*)0, cast(void*)0);
	}
	final void DeactivateFreeCam()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76983], cast(void*)0, cast(void*)0);
	}
	final void SetViewTargetAsOverwatch(bool bForce)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bForce;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76984], params.ptr, cast(void*)0);
	}
	final void PlayCameraShake(ScriptName ShakeName, float Scale, CameraShake SourceShake)
	{
		ubyte params[16];
		params[] = 0;
		*cast(ScriptName*)params.ptr = ShakeName;
		*cast(float*)&params[8] = Scale;
		*cast(CameraShake*)&params[12] = SourceShake;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76987], params.ptr, cast(void*)0);
	}
	final void ClientPlayForceFeedbackWaveform(ForceFeedbackWaveform FFWaveform, Actor FFWaveformInstigator)
	{
		ubyte params[8];
		params[] = 0;
		*cast(ForceFeedbackWaveform*)params.ptr = FFWaveform;
		*cast(Actor*)&params[4] = FFWaveformInstigator;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76992], params.ptr, cast(void*)0);
	}
	final void UpdateSpeedCameraEffect(bool bEnabled)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnabled;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76995], params.ptr, cast(void*)0);
	}
	final void SpeedCamEffect(bool bEnabled)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnabled;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76997], params.ptr, cast(void*)0);
	}
	final void ClientPulseHUD(ubyte Reason)
	{
		ubyte params[1];
		params[] = 0;
		params[0] = Reason;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76999], params.ptr, cast(void*)0);
	}
	final void PulseShield()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77003], cast(void*)0, cast(void*)0);
	}
	final void AddTimePlayed()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77004], cast(void*)0, cast(void*)0);
	}
	final void AcknowledgePossession(Pawn P)
	{
		ubyte params[4];
		params[] = 0;
		*cast(Pawn*)params.ptr = P;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77011], params.ptr, cast(void*)0);
	}
	final void MatchEndSoundMode()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77021], cast(void*)0, cast(void*)0);
	}
	final void ResetSoundMode()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77022], cast(void*)0, cast(void*)0);
	}
	final void SuppressHelpText()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77024], cast(void*)0, cast(void*)0);
	}
	final void TalkVGS(ScriptString Command)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptString*)params.ptr = Command;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77026], params.ptr, cast(void*)0);
	}
	final void Say(ScriptString msg)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptString*)params.ptr = msg;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77030], params.ptr, cast(void*)0);
	}
	final bool IsPlayerCommand(ScriptString msg)
	{
		ubyte params[16];
		params[] = 0;
		*cast(ScriptString*)params.ptr = msg;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77032], params.ptr, cast(void*)0);
		return *cast(bool*)&params[12];
	}
	final void ShowFeedbackMessage(ScriptString Message)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptString*)params.ptr = Message;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77036], params.ptr, cast(void*)0);
	}
	final UObject.Color GetChatColor(TgSupportCommands.GC_CHAT_CHANNEL Channel, bool bSameTeam, int* ChatColorIdx)
	{
		ubyte params[13];
		params[] = 0;
		*cast(TgSupportCommands.GC_CHAT_CHANNEL*)params.ptr = Channel;
		*cast(bool*)&params[4] = bSameTeam;
		*cast(int*)&params[8] = *ChatColorIdx;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77047], params.ptr, cast(void*)0);
		*ChatColorIdx = *cast(int*)&params[8];
		return *cast(UObject.Color*)&params[12];
	}
	final void AddChatToConsole(ScriptString Sender, ScriptString ChatMessage, TgSupportCommands.GC_CHAT_CHANNEL Channel)
	{
		ubyte params[25];
		params[] = 0;
		*cast(ScriptString*)params.ptr = Sender;
		*cast(ScriptString*)&params[12] = ChatMessage;
		*cast(TgSupportCommands.GC_CHAT_CHANNEL*)&params[24] = Channel;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77059], params.ptr, cast(void*)0);
	}
	final ScriptString GetLastTellSender()
	{
		ubyte params[12];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77067], params.ptr, cast(void*)0);
		return *cast(ScriptString*)params.ptr;
	}
	final void ReplyTalk()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77069], cast(void*)0, cast(void*)0);
	}
	final bool CanCommunicate()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77073], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final void Talk()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77074], cast(void*)0, cast(void*)0);
	}
	final void ChatConsole(bool bTeam)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bTeam;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77078], params.ptr, cast(void*)0);
	}
	final void TalkConsole(bool bTeam)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bTeam;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77082], params.ptr, cast(void*)0);
	}
	final void TeamTalk()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77087], cast(void*)0, cast(void*)0);
	}
	final void TeamSay(ScriptString msg)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptString*)params.ptr = msg;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77090], params.ptr, cast(void*)0);
	}
	final bool AllowTextMessage(ScriptString msg)
	{
		ubyte params[16];
		params[] = 0;
		*cast(ScriptString*)params.ptr = msg;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77092], params.ptr, cast(void*)0);
		return *cast(bool*)&params[12];
	}
	final void WarnPlayerAboutSpam()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77095], cast(void*)0, cast(void*)0);
	}
	final void BeginVGS()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77096], cast(void*)0, cast(void*)0);
	}
	final void SpotTarget()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77098], cast(void*)0, cast(void*)0);
	}
	final void ServerRequestVGSContextCommand(TrVGSCommandList.EVGSContextActor ContextActor, TrVGSCommandList.EVGSContextLocation ContextLocation, bool bEnemyLocation, Actor SpottedActor)
	{
		ubyte params[10];
		params[] = 0;
		*cast(TrVGSCommandList.EVGSContextActor*)params.ptr = ContextActor;
		*cast(TrVGSCommandList.EVGSContextLocation*)&params[1] = ContextLocation;
		*cast(bool*)&params[4] = bEnemyLocation;
		*cast(Actor*)&params[8] = SpottedActor;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77102], params.ptr, cast(void*)0);
	}
	final void ServerRequestVGSCommand(TrVGSCommandList.VGSCommandType VGSCommandIndex, bool bGlobal)
	{
		ubyte params[5];
		params[] = 0;
		*cast(TrVGSCommandList.VGSCommandType*)params.ptr = VGSCommandIndex;
		*cast(bool*)&params[4] = bGlobal;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77108], params.ptr, cast(void*)0);
	}
	final void ClientReceiveVGSCommand(PlayerReplicationInfo PRI, TrVGSCommandList.VGSCommandType VGSCommandIndex)
	{
		ubyte params[5];
		params[] = 0;
		*cast(PlayerReplicationInfo*)params.ptr = PRI;
		*cast(TrVGSCommandList.VGSCommandType*)&params[4] = VGSCommandIndex;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77112], params.ptr, cast(void*)0);
	}
	final void ClientReceiveVGSContextCommand(PlayerReplicationInfo PRI, TrVGSCommandList.EVGSContextActor ContextActor, TrVGSCommandList.EVGSContextLocation ContextLocation, bool bEnemyLocation)
	{
		ubyte params[10];
		params[] = 0;
		*cast(PlayerReplicationInfo*)params.ptr = PRI;
		*cast(TrVGSCommandList.EVGSContextActor*)&params[4] = ContextActor;
		*cast(TrVGSCommandList.EVGSContextLocation*)&params[5] = ContextLocation;
		*cast(bool*)&params[8] = bEnemyLocation;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77121], params.ptr, cast(void*)0);
	}
	final void ShowMoveErrors(bool bEnabled)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnabled;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77128], params.ptr, cast(void*)0);
	}
	final void OnSkiHelpTextDistanceThresholdReached()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77130], cast(void*)0, cast(void*)0);
	}
	final void OnJetpackHelpTextDistanceThresholdReached()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77131], cast(void*)0, cast(void*)0);
	}
	final void LoadPlayerProfile()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77132], cast(void*)0, cast(void*)0);
	}
	final float GetNewPlayerAssistAmount()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77136], params.ptr, cast(void*)0);
		return *cast(float*)params.ptr;
	}
	final void UpdateNewPlayerAssistPoints(int AmoutToSubtract)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = AmoutToSubtract;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77138], params.ptr, cast(void*)0);
	}
	final void BehindView()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77142], cast(void*)0, cast(void*)0);
	}
	final void ServerSetBehindView(bool bNewBehindView)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bNewBehindView;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77143], params.ptr, cast(void*)0);
	}
	final void ClientSetBehindView(bool bNewBehindView)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bNewBehindView;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77145], params.ptr, cast(void*)0);
	}
	final PlayerInput GetEngineSettings(bool bUse)
	{
		ubyte params[8];
		params[] = 0;
		*cast(bool*)params.ptr = bUse;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77147], params.ptr, cast(void*)0);
		return *cast(PlayerInput*)&params[4];
	}
	final TrPlayerInput_Spectator GetSpectatorSettings()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77151], params.ptr, cast(void*)0);
		return *cast(TrPlayerInput_Spectator*)params.ptr;
	}
	final void ClientOnMotionSensorAlarmSounded(TrDeployable_MotionSensor MotionSensor)
	{
		ubyte params[4];
		params[] = 0;
		*cast(TrDeployable_MotionSensor*)params.ptr = MotionSensor;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77154], params.ptr, cast(void*)0);
	}
	final void ClientOnMotionSensorMineSounded()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77158], cast(void*)0, cast(void*)0);
	}
	final void LoadPendingLoadoutContentData(int ClassId, int Loadout)
	{
		ubyte params[8];
		params[] = 0;
		*cast(int*)params.ptr = ClassId;
		*cast(int*)&params[4] = Loadout;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77159], params.ptr, cast(void*)0);
	}
	final void LoadPendingDeviceContentData(ScriptClass DeviceClass)
	{
		ubyte params[4];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = DeviceClass;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77164], params.ptr, cast(void*)0);
	}
	final void HideHUDElements()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77180], cast(void*)0, cast(void*)0);
	}
	final void ClientShowFlagIcon(bool bShow)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bShow;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77182], params.ptr, cast(void*)0);
	}
	final void ClientSetPlayerClassObjects(ScriptString ClassName, int PerkIcon1, int PerkIcon2)
	{
		ubyte params[20];
		params[] = 0;
		*cast(ScriptString*)params.ptr = ClassName;
		*cast(int*)&params[12] = PerkIcon1;
		*cast(int*)&params[16] = PerkIcon2;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77184], params.ptr, cast(void*)0);
	}
	final void UpdatePotentialSeekingTargets(ScriptArray!(Actor) NewPotentialTargets)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptArray!(Actor)*)params.ptr = NewPotentialTargets;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77188], params.ptr, cast(void*)0);
	}
	final bool NotifyHitWall(Vector HitNormal, Actor Wall)
	{
		ubyte params[20];
		params[] = 0;
		*cast(Vector*)params.ptr = HitNormal;
		*cast(Actor*)&params[12] = Wall;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77193], params.ptr, cast(void*)0);
		return *cast(bool*)&params[16];
	}
	final void NotifyFallingHitWall(Vector HitNormal, Actor Wall)
	{
		ubyte params[16];
		params[] = 0;
		*cast(Vector*)params.ptr = HitNormal;
		*cast(Actor*)&params[12] = Wall;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77198], params.ptr, cast(void*)0);
	}
	final void Spectate(bool bNeutral)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bNeutral;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77202], params.ptr, cast(void*)0);
	}
	final void EndSpectate()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77204], cast(void*)0, cast(void*)0);
	}
	final void ClientSpectate(bool bNeutral)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bNeutral;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77205], params.ptr, cast(void*)0);
	}
	final void ServerSpectate(bool bNeutral)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bNeutral;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77208], params.ptr, cast(void*)0);
	}
	final void ServerViewFlags(int Dir)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Dir;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77212], params.ptr, cast(void*)0);
	}
	final void ServerViewFlagStands(int Dir)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Dir;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77214], params.ptr, cast(void*)0);
	}
	final void ServerViewGenerators(int Dir)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Dir;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77216], params.ptr, cast(void*)0);
	}
	final void ServerViewBookmark(int Dir)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Dir;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77218], params.ptr, cast(void*)0);
	}
	final void ServerViewVehicles(int Dir)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Dir;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77220], params.ptr, cast(void*)0);
	}
	final void ServerViewFastestPlayer()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77222], cast(void*)0, cast(void*)0);
	}
	final void ServerViewActor(Actor ActorToView)
	{
		ubyte params[4];
		params[] = 0;
		*cast(Actor*)params.ptr = ActorToView;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77223], params.ptr, cast(void*)0);
	}
	final void ClientOnViewTargetChange(Actor NewViewTarget)
	{
		ubyte params[4];
		params[] = 0;
		*cast(Actor*)params.ptr = NewViewTarget;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77225], params.ptr, cast(void*)0);
	}
	final void ServerIncreaseCamDistance(int Amount)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Amount;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77227], params.ptr, cast(void*)0);
	}
	final void ServerDecreaseCamDistance(int Amount)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Amount;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77229], params.ptr, cast(void*)0);
	}
	final void ServerSetMoveSpeed(float NewSpeed)
	{
		ubyte params[4];
		params[] = 0;
		*cast(float*)params.ptr = NewSpeed;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77231], params.ptr, cast(void*)0);
	}
	final void OnViewTargetCapturedFlag(TrFlagCTF NewFlagToWatch)
	{
		ubyte params[4];
		params[] = 0;
		*cast(TrFlagCTF*)params.ptr = NewFlagToWatch;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77233], params.ptr, cast(void*)0);
	}
	final void OnViewTargetFlagReturned()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77235], cast(void*)0, cast(void*)0);
	}
	final void OnViewTargetDroppedFlag(TrFlagBase NewFlagToWatch)
	{
		ubyte params[4];
		params[] = 0;
		*cast(TrFlagBase*)params.ptr = NewFlagToWatch;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77236], params.ptr, cast(void*)0);
	}
	final void OnViewTargetLeftVehicle(PlayerReplicationInfo NewPRIToWatch)
	{
		ubyte params[4];
		params[] = 0;
		*cast(PlayerReplicationInfo*)params.ptr = NewPRIToWatch;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77238], params.ptr, cast(void*)0);
	}
	final void GetViewTargetList(TrPawn* PawnViewTarget, TrVehicle* VehicleViewTarget, TrCamera_SpectatorBookmark* BookmarkViewTarget, Actor* ObjectiveViewTarget)
	{
		ubyte params[16];
		params[] = 0;
		*cast(TrPawn*)params.ptr = *PawnViewTarget;
		*cast(TrVehicle*)&params[4] = *VehicleViewTarget;
		*cast(TrCamera_SpectatorBookmark*)&params[8] = *BookmarkViewTarget;
		*cast(Actor*)&params[12] = *ObjectiveViewTarget;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77240], params.ptr, cast(void*)0);
		*PawnViewTarget = *cast(TrPawn*)params.ptr;
		*VehicleViewTarget = *cast(TrVehicle*)&params[4];
		*BookmarkViewTarget = *cast(TrCamera_SpectatorBookmark*)&params[8];
		*ObjectiveViewTarget = *cast(Actor*)&params[12];
	}
	final void ServerUnPossess()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77472], cast(void*)0, cast(void*)0);
	}
	final void ClientPlayTakeHit(Vector HitLoc, ubyte Damage, ScriptClass DamageType)
	{
		ubyte params[17];
		params[] = 0;
		*cast(Vector*)params.ptr = HitLoc;
		params[12] = Damage;
		*cast(ScriptClass*)&params[16] = DamageType;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77474], params.ptr, cast(void*)0);
	}
	final void ClientPlayReticuleHitSound()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77480], cast(void*)0, cast(void*)0);
	}
	final void ClientPlayBluePlateImpact()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77485], cast(void*)0, cast(void*)0);
	}
	final void ClientPlayAirMailImpact()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77488], cast(void*)0, cast(void*)0);
	}
	final void SummarizeAwards()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77489], cast(void*)0, cast(void*)0);
	}
	final void ClientMatchOver(int Winner, ScriptString WinnerName)
	{
		ubyte params[16];
		params[] = 0;
		*cast(int*)params.ptr = Winner;
		*cast(ScriptString*)&params[4] = WinnerName;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77490], params.ptr, cast(void*)0);
	}
	final void ClientSetEndOfMatch()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77494], cast(void*)0, cast(void*)0);
	}
	final void ClientFadeToSummary()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77495], cast(void*)0, cast(void*)0);
	}
	final void UpdateMatchCountdown(int Seconds)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Seconds;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77497], params.ptr, cast(void*)0);
	}
	final void UpdateRoundCountdown(int Seconds, int Round)
	{
		ubyte params[8];
		params[] = 0;
		*cast(int*)params.ptr = Seconds;
		*cast(int*)&params[4] = Round;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77499], params.ptr, cast(void*)0);
	}
	final void UpdateGameCountdown(int Seconds)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Seconds;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77502], params.ptr, cast(void*)0);
	}
	final void ServerKickPlayer(int Reason)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Reason;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77504], params.ptr, cast(void*)0);
	}
	final void ClientKickPlayer(int Reason)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Reason;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77506], params.ptr, cast(void*)0);
	}
	final void KickWarning()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77508], cast(void*)0, cast(void*)0);
	}
	final void FumbledFlag()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77509], cast(void*)0, cast(void*)0);
	}
	final void ClientOnFumbledFlag()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77510], cast(void*)0, cast(void*)0);
	}
	final void UpdateCallInAvailability()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77511], cast(void*)0, cast(void*)0);
	}
	final void UpdateCallInCooldown()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77516], cast(void*)0, cast(void*)0);
	}
	final void CalcCameraOnViewTarget(float fDeltaTime, Vector* out_CamLoc, Rotator* out_CamRot, float* out_FOV)
	{
		ubyte params[32];
		params[] = 0;
		*cast(float*)params.ptr = fDeltaTime;
		*cast(Vector*)&params[4] = *out_CamLoc;
		*cast(Rotator*)&params[16] = *out_CamRot;
		*cast(float*)&params[28] = *out_FOV;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77518], params.ptr, cast(void*)0);
		*out_CamLoc = *cast(Vector*)&params[4];
		*out_CamRot = *cast(Rotator*)&params[16];
		*out_FOV = *cast(float*)&params[28];
	}
	final bool IsGameTypeArena()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77528], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final bool IsGameTypeDaD()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77530], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final bool IsGameTypeCaH()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77533], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final void SwitchToDeathCamera()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77535], cast(void*)0, cast(void*)0);
	}
	final void AddProjectileToTetherList(TrProjectile P)
	{
		ubyte params[4];
		params[] = 0;
		*cast(TrProjectile*)params.ptr = P;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77538], params.ptr, cast(void*)0);
	}
	final void CheckTetherList(TrProjectile P)
	{
		ubyte params[4];
		params[] = 0;
		*cast(TrProjectile*)params.ptr = P;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77540], params.ptr, cast(void*)0);
	}
	final TrProjectile TetherProjectile(TrProjectile ProjectileFromServer)
	{
		ubyte params[8];
		params[] = 0;
		*cast(TrProjectile*)params.ptr = ProjectileFromServer;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77542], params.ptr, cast(void*)0);
		return *cast(TrProjectile*)&params[4];
	}
	final void ConfigureSkiSpeedSteps(float SoftCap)
	{
		ubyte params[4];
		params[] = 0;
		*cast(float*)params.ptr = SoftCap;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77547], params.ptr, cast(void*)0);
	}
	final void LoadingTimer(bool bStart)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bStart;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77551], params.ptr, cast(void*)0);
	}
	final void FlushAccumulatedDetermination()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77553], cast(void*)0, cast(void*)0);
	}
	final void ClearDetermination()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77554], cast(void*)0, cast(void*)0);
	}
	final void AddDetermination()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77560], cast(void*)0, cast(void*)0);
	}
	final void OnMenuMovieOpened()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77561], cast(void*)0, cast(void*)0);
	}
	final void OnMenuMovieClosed()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77563], cast(void*)0, cast(void*)0);
	}
	final void ClientPlayVGSAudio(SoundCue ASound, PlayerReplicationInfo InstigatorPRI)
	{
		ubyte params[8];
		params[] = 0;
		*cast(SoundCue*)params.ptr = ASound;
		*cast(PlayerReplicationInfo*)&params[4] = InstigatorPRI;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77565], params.ptr, cast(void*)0);
	}
	final void VGSAudioFinished(
// ERROR: Unknown object class 'Class Core.ComponentProperty'~
void* AC)
	{
		ubyte params[4];
		params[] = 0;
		*cast(
// ERROR: Unknown object class 'Class Core.ComponentProperty'~
void**)params.ptr = AC;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77570], params.ptr, cast(void*)0);
	}
	final void ClientSetLastDamagerInfo(int Health, int UpgradeLevel)
	{
		ubyte params[8];
		params[] = 0;
		*cast(int*)params.ptr = Health;
		*cast(int*)&params[4] = UpgradeLevel;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77573], params.ptr, cast(void*)0);
	}
	final void EnableTinyWeapons(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77576], params.ptr, cast(void*)0);
	}
	final bool GetTinyWeaponValue()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77580], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final void EnableChatFilter(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77583], params.ptr, cast(void*)0);
	}
	final bool GetChatFilterValue()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77585], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final void EnableDamageCounter(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77587], params.ptr, cast(void*)0);
	}
	final bool GetDamageCounterValue()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77589], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final void EnableHUDObjectives(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77591], params.ptr, cast(void*)0);
	}
	final void EnableHUDReticule(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77593], params.ptr, cast(void*)0);
	}
	final void EnableHUDCredits(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77595], params.ptr, cast(void*)0);
	}
	final void EnableHUDAccolades(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77597], params.ptr, cast(void*)0);
	}
	final void EnableHUDBadges(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77599], params.ptr, cast(void*)0);
	}
	final void EnableHUDScores(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77601], params.ptr, cast(void*)0);
	}
	final void EnableHUDHealthBar(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77603], params.ptr, cast(void*)0);
	}
	final void EnableHUDVisor(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77605], params.ptr, cast(void*)0);
	}
	final void EnableHUDChat(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77607], params.ptr, cast(void*)0);
	}
	final void EnableHUDCombatLog(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77609], params.ptr, cast(void*)0);
	}
	final void EnableHUDKillbox(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77611], params.ptr, cast(void*)0);
	}
	final void EnableHUDDeathcam(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77613], params.ptr, cast(void*)0);
	}
	final void EnableHUDHeroText(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77615], params.ptr, cast(void*)0);
	}
	final void EnableHUDPromptPanel(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77617], params.ptr, cast(void*)0);
	}
	final void EnableHUDRespawnTimer(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77619], params.ptr, cast(void*)0);
	}
	final void EnableHUDSkiBars(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77621], params.ptr, cast(void*)0);
	}
	final void EnableHUDFriendColoring(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77623], params.ptr, cast(void*)0);
	}
	final void EnableHUDNotifications(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77625], params.ptr, cast(void*)0);
	}
	final void EnableHUDFriendStateNotifications(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77627], params.ptr, cast(void*)0);
	}
	final void EnableHUDCracks(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77629], params.ptr, cast(void*)0);
	}
	final void ShowAlienFX(bool bEnable)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnable;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77631], params.ptr, cast(void*)0);
	}
	final bool GetHUDObjectivesValue()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77633], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final bool GetHUDNotifications()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77635], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final bool GetHUDFriendStateNotifications()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77637], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final int GetWhisperFilterValue()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77639], params.ptr, cast(void*)0);
		return *cast(int*)params.ptr;
	}
	final void SetWhisperFilter(int FilterValue)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = FilterValue;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77641], params.ptr, cast(void*)0);
	}
	final void SummaryTweenTimer(int Amount)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Amount;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77643], params.ptr, cast(void*)0);
	}
	final void VoteNo()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77645], cast(void*)0, cast(void*)0);
	}
	final void VoteYes()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77650], cast(void*)0, cast(void*)0);
	}
	final void FlashShooterHitReticule(int DamageAmount, bool isInstantHit, int TeamNum)
	{
		ubyte params[12];
		params[] = 0;
		*cast(int*)params.ptr = DamageAmount;
		*cast(bool*)&params[4] = isInstantHit;
		*cast(int*)&params[8] = TeamNum;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77652], params.ptr, cast(void*)0);
	}
	final void ServerShowOverheadNumber(int NumberToShow, Vector WorldLocation, float fScreenDepth)
	{
		ubyte params[20];
		params[] = 0;
		*cast(int*)params.ptr = NumberToShow;
		*cast(Vector*)&params[4] = WorldLocation;
		*cast(float*)&params[16] = fScreenDepth;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77656], params.ptr, cast(void*)0);
	}
	final void ClientShowOverheadNumber(int NumberToShow, Vector WorldLocation, float fScreenDepth)
	{
		ubyte params[20];
		params[] = 0;
		*cast(int*)params.ptr = NumberToShow;
		*cast(Vector*)&params[4] = WorldLocation;
		*cast(float*)&params[16] = fScreenDepth;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77660], params.ptr, cast(void*)0);
	}
	final int GetCreditsForDamageAmount(int DamageAmount)
	{
		ubyte params[8];
		params[] = 0;
		*cast(int*)params.ptr = DamageAmount;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77666], params.ptr, cast(void*)0);
		return *cast(int*)&params[4];
	}
	final void CashForDamage(int DamageAmount)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = DamageAmount;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77669], params.ptr, cast(void*)0);
	}
	final void AwardTeamAssistCredits()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77671], cast(void*)0, cast(void*)0);
	}
	final void AwardTeamRabbitAssistCredits(int Multiplier)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Multiplier;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77672], params.ptr, cast(void*)0);
	}
	final void TypeKeyPressed()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77674], cast(void*)0, cast(void*)0);
	}
	final void FOV(float F)
	{
		ubyte params[4];
		params[] = 0;
		*cast(float*)params.ptr = F;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77677], params.ptr, cast(void*)0);
	}
	final void FixFOV()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77679], cast(void*)0, cast(void*)0);
	}
	final void SetFOV(float NewFOV)
	{
		ubyte params[4];
		params[] = 0;
		*cast(float*)params.ptr = NewFOV;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77680], params.ptr, cast(void*)0);
	}
	final void ServerSetClassAffordable(int BitMask)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = BitMask;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77682], params.ptr, cast(void*)0);
	}
	final int GetClassBit(int ClassId)
	{
		ubyte params[8];
		params[] = 0;
		*cast(int*)params.ptr = ClassId;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77686], params.ptr, cast(void*)0);
		return *cast(int*)&params[4];
	}
	final void TestTrainingSlot(TrObject.TR_EQUIP_POINT equipType, int EquipId)
	{
		ubyte params[5];
		params[] = 0;
		*cast(TrObject.TR_EQUIP_POINT*)params.ptr = equipType;
		*cast(int*)&params[4] = EquipId;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77691], params.ptr, cast(void*)0);
	}
	final void TestSlot(TrObject.TR_EQUIP_POINT equipType, int EquipId, bool bTraining)
	{
		ubyte params[9];
		params[] = 0;
		*cast(TrObject.TR_EQUIP_POINT*)params.ptr = equipType;
		*cast(int*)&params[4] = EquipId;
		*cast(bool*)&params[8] = bTraining;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77695], params.ptr, cast(void*)0);
	}
	final void ServerTestSlot(TrObject.TR_EQUIP_POINT EquipId, int EquipItem)
	{
		ubyte params[5];
		params[] = 0;
		*cast(TrObject.TR_EQUIP_POINT*)params.ptr = EquipId;
		*cast(int*)&params[4] = EquipItem;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77703], params.ptr, cast(void*)0);
	}
	final void OnDeviceContentDataClassLoaded(ScriptClass DeviceContentDataClass)
	{
		ubyte params[4];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = DeviceContentDataClass;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77707], params.ptr, cast(void*)0);
	}
	final void On3PSkinContentLoaded(ScriptClass Skin3PDataClass)
	{
		ubyte params[4];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = Skin3PDataClass;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77712], params.ptr, cast(void*)0);
	}
	final void On1PSkinContentLoaded(ScriptClass Skin1PDataClass)
	{
		ubyte params[4];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = Skin1PDataClass;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77716], params.ptr, cast(void*)0);
	}
	final void AddPending3PSkin(TrPlayerReplicationInfo TrPRI, int skinId)
	{
		ubyte params[8];
		params[] = 0;
		*cast(TrPlayerReplicationInfo*)params.ptr = TrPRI;
		*cast(int*)&params[4] = skinId;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77718], params.ptr, cast(void*)0);
	}
	final void OnClassSelectedMainMenu()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77722], cast(void*)0, cast(void*)0);
	}
	final void OnGiveCredits(TrSeqAct_GiveCredits Action)
	{
		ubyte params[4];
		params[] = 0;
		*cast(TrSeqAct_GiveCredits*)params.ptr = Action;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77723], params.ptr, cast(void*)0);
	}
	final void OnGiveAccolade(TrSeqAct_GiveAccolade Action)
	{
		ubyte params[4];
		params[] = 0;
		*cast(TrSeqAct_GiveAccolade*)params.ptr = Action;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77727], params.ptr, cast(void*)0);
	}
	final void OnPlayVGSCommand(TrSeqAct_PlayVGSCommand Action)
	{
		ubyte params[4];
		params[] = 0;
		*cast(TrSeqAct_PlayVGSCommand*)params.ptr = Action;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77731], params.ptr, cast(void*)0);
	}
	final void OnRefreshInventory(TrSeqAct_RefreshInventory Action)
	{
		ubyte params[4];
		params[] = 0;
		*cast(TrSeqAct_RefreshInventory*)params.ptr = Action;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77737], params.ptr, cast(void*)0);
	}
	final void StartForceFocusTimer()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77741], cast(void*)0, cast(void*)0);
	}
	final void StartAcquisitionFireTimer()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77742], cast(void*)0, cast(void*)0);
	}
	final void StartSettingBlock()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77743], cast(void*)0, cast(void*)0);
	}
	final void AutoRevertSetting()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77744], cast(void*)0, cast(void*)0);
	}
	final void StartSendMenuBackTimer()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77745], cast(void*)0, cast(void*)0);
	}
	final void QueueTimer(bool bStart)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bStart;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77746], params.ptr, cast(void*)0);
	}
	final void TVTimer()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77748], cast(void*)0, cast(void*)0);
	}
	final void DealTimer()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77749], cast(void*)0, cast(void*)0);
	}
	final void StartHotkeyBlock()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77750], cast(void*)0, cast(void*)0);
	}
	final void ClientArenaRoundEnded(int WinningTeam)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = WinningTeam;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77759], params.ptr, cast(void*)0);
	}
	final void ClientPlayerResettingAndRespawning()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77770], cast(void*)0, cast(void*)0);
	}
	final void DestroyAllOwnedDeployables(ScriptClass DestroyIfNotOfType)
	{
		ubyte params[4];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = DestroyIfNotOfType;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77771], params.ptr, cast(void*)0);
	}
	final void DestroyAllOwnedMines(ScriptClass DestroyIfNotOfType)
	{
		ubyte params[4];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = DestroyIfNotOfType;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77775], params.ptr, cast(void*)0);
	}
	final void DestroyAllOwnedProjectiles()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77778], cast(void*)0, cast(void*)0);
	}
	final void QueueBadge(int Icon, ScriptString Title, ScriptString XPReward)
	{
		ubyte params[28];
		params[] = 0;
		*cast(int*)params.ptr = Icon;
		*cast(ScriptString*)&params[4] = Title;
		*cast(ScriptString*)&params[16] = XPReward;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77780], params.ptr, cast(void*)0);
	}
	final void ClientQueueAccolade(int Icon, ScriptString Title, ScriptString Subtitle, bool bIsBadge)
	{
		ubyte params[32];
		params[] = 0;
		*cast(int*)params.ptr = Icon;
		*cast(ScriptString*)&params[4] = Title;
		*cast(ScriptString*)&params[16] = Subtitle;
		*cast(bool*)&params[28] = bIsBadge;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77784], params.ptr, cast(void*)0);
	}
	final void ClassHotkeyPTH()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77789], cast(void*)0, cast(void*)0);
	}
	final void ClassHotkeySEN()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77790], cast(void*)0, cast(void*)0);
	}
	final void ClassHotkeyINF()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77791], cast(void*)0, cast(void*)0);
	}
	final void ClassHotkeySLD()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77792], cast(void*)0, cast(void*)0);
	}
	final void ClassHotkeyRDR()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77793], cast(void*)0, cast(void*)0);
	}
	final void ClassHotkeyTCN()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77794], cast(void*)0, cast(void*)0);
	}
	final void ClassHotkeyJUG()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77795], cast(void*)0, cast(void*)0);
	}
	final void ClassHotkeyDMB()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77796], cast(void*)0, cast(void*)0);
	}
	final void ClassHotkeyBRT()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77797], cast(void*)0, cast(void*)0);
	}
	final void QuickClasses()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77798], cast(void*)0, cast(void*)0);
	}
	final void QuickLoadouts(int ClassId)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = ClassId;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77800], params.ptr, cast(void*)0);
	}
	final void EndVGSInput()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77803], cast(void*)0, cast(void*)0);
	}
	final void StartUILoadSummaryTimer()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77805], cast(void*)0, cast(void*)0);
	}
	final void OpenVehicleMenu(TrVehicleStation VehicleStation)
	{
		ubyte params[4];
		params[] = 0;
		*cast(TrVehicleStation*)params.ptr = VehicleStation;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77806], params.ptr, cast(void*)0);
	}
	final void OnScoreChanged(UTTeamInfo T)
	{
		ubyte params[4];
		params[] = 0;
		*cast(UTTeamInfo*)params.ptr = T;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77825], params.ptr, cast(void*)0);
	}
	final void CheckFriendlyFireKills()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77832], cast(void*)0, cast(void*)0);
	}
	final void CheckFriendlyFireDamage()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77835], cast(void*)0, cast(void*)0);
	}
	final void StartRefreshPageTimer()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77838], cast(void*)0, cast(void*)0);
	}
	final void UpdateMainMenuPaperDoll_Mesh(TrObject.EContentDataType Type)
	{
		ubyte params[1];
		params[] = 0;
		*cast(TrObject.EContentDataType*)params.ptr = Type;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77839], params.ptr, cast(void*)0);
	}
	final void ClearMainMenuPaperDoll()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77841], cast(void*)0, cast(void*)0);
	}
	final void ClearPaperDoll()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77842], cast(void*)0, cast(void*)0);
	}
	final void SpecList()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77845], cast(void*)0, cast(void*)0);
	}
	final void SampleVoice(ScriptClass VoiceClass)
	{
		ubyte params[4];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = VoiceClass;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77850], params.ptr, cast(void*)0);
	}
	final ScriptString StripTag(ScriptString sValue)
	{
		ubyte params[24];
		params[] = 0;
		*cast(ScriptString*)params.ptr = sValue;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77852], params.ptr, cast(void*)0);
		return *cast(ScriptString*)&params[12];
	}
	final void SetAllowSimProjectiles(bool bAllow)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bAllow;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77856], params.ptr, cast(void*)0);
	}
	final void ServerSetAllowSimProjectiles(bool bAllow)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bAllow;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[77858], params.ptr, cast(void*)0);
	}
}
