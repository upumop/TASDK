module UnrealScript.TribesGame.TrPlayerReplicationInfo;

import ScriptClasses;
import UnrealScript.TribesGame.TrObject;
import UnrealScript.UTGame.UTPlayerReplicationInfo;
import UnrealScript.Engine.Actor;
import UnrealScript.TribesGame.TrInventoryHelper;
import UnrealScript.Engine.ParticleSystem;
import UnrealScript.UTGame.UTCarriedObject;
import UnrealScript.Engine.PlayerReplicationInfo;
import UnrealScript.Engine.SkeletalMesh;
import UnrealScript.TribesGame.TrValueModifier;
import UnrealScript.TribesGame.TrStatsInterface;
import UnrealScript.Engine.TeamInfo;

extern(C++) interface TrPlayerReplicationInfo : UTPlayerReplicationInfo
{
	public static immutable auto THR_SPINFUSOR = 1;
	public static immutable auto THR_SMG = 2;
	public static immutable auto THR_RIFLE = 3;
	public static immutable auto THR_LOCKED_ON = 4;
	public static immutable auto THR_CROSSBOW = 5;
	public static immutable auto THR_FLAME_THROWER = 6;
	public static immutable auto THR_CHAIN_GUN = 7;
	public static immutable auto THR_MISSILE = 8;
	public static immutable auto THR_NANITE = 9;
	public static immutable auto THR_SHOTGUN = 10;
	public static immutable auto THR_UNKNOWN = 11;
	public static immutable auto THR_LASER = 12;
	public static immutable auto THR_CH_V13 = 13;
	public static immutable auto THR_SCOPE = 14;
	public static immutable auto THR_STANDARD = 15;
	public static immutable auto THR_GRENADE_LAUNCHER = 16;
	public static immutable auto THR_MELEE = 17;
	public static immutable auto THR_SHRIKE = 18;
	public static immutable auto THR_FREE_SPECTATOR = 19;
	public static immutable auto THR_RED_DOT = 20;
	public static immutable auto THR_BXT1 = 21;
	public static immutable auto THR_PHASERIFLE = 22;
	public static immutable auto THR_SAP20 = 23;
	public static immutable auto THR_PLASMAGUN = 24;
	public static immutable auto HAE_KILL_STREAK_LEVEL_1 = 1;
	public static immutable auto HAE_KILL_STREAK_LEVEL_2 = 2;
	public static immutable auto HAE_KILL_STREAK_LEVEL_3 = 3;
	public static immutable auto HAE_KILL_STREAK_LEVEL_4 = 4;
	public static immutable auto HAE_KILL_STREAK_LEVEL_5 = 5;
	public static immutable auto TRHUD_PACK_STEALTH = 1;
	public static immutable auto TRHUD_PACK_DAMAGE = 2;
	public static immutable auto TRHUD_PACK_OMNI = 3;
	public static immutable auto TRHUD_PACK_ERECHARGE = 4;
	public static immutable auto TRHUD_PACK_AIRTURRET = 5;
	public static immutable auto TRHUD_PACK_BLINK = 6;
	public static immutable auto TRHUD_PACK_ENERGY = 7;
	public static immutable auto TRHUD_PACK_SHIELD = 8;
	public static immutable auto TRHUD_PACK_JAMMER = 9;
	public static immutable auto TRHUD_PACK_LIGHTTURRET = 10;
	public static immutable auto TRHUD_PACK_FORCEFIELD = 11;
	public static immutable auto TRHUD_PACK_WALLTURRET = 12;
	public static immutable auto TRHUD_PACK_REGEN = 13;
	public static immutable auto TRHUD_PACK_DROPJAMMER = 14;
	public static immutable auto TRHUD_TBD1 = 15;
	public static immutable auto TRHUD_TBD2 = 16;
	public static immutable auto TRHUD_TBD3 = 17;
	public static immutable auto TRHUD_BELT_STICKYGREN = 18;
	public static immutable auto TRHUD_BELT_FRAG = 19;
	public static immutable auto TRHUD_BELT_CLAYMORE = 20;
	public static immutable auto TRHUD_BELT_NITRON = 21;
	public static immutable auto TRHUD_BELT_MOTIONALARM = 22;
	public static immutable auto TRHUD_BELT_SPIKEGREN = 23;
	public static immutable auto TRHUD_BELT_WHITEOUT = 24;
	public static immutable auto TRHUD_BELT_APGREN = 25;
	public static immutable auto TRHUD_BELT_STGREN = 26;
	public static immutable auto TRHUD_BELT_PRISMMINES = 27;
	public static immutable auto TRHUD_BELT_FLARE = 28;
	public static immutable auto TRHUD_BELT_EMPGREN = 29;
	public static immutable auto TRHUD_BELT_MINES = 30;
	public static immutable auto TRHUD_BELT_DISKTOSS = 31;
	public static immutable auto TRHUD_TBD4 = 32;
	public static immutable auto TRHUD_TBD5 = 33;
	public static immutable auto TRHUD_MEDAL_ASSIST = 34;
	public static immutable auto TRHUD_CLAYMOREMINE = 35;
	public static immutable auto TRHUD_PRISMMINE = 36;
	public static immutable auto TRHUD_LIGHTTURRET = 37;
	public static immutable auto TRHUD_AATURRET = 38;
	public static immutable auto TRHUD_MOTIONSENSOR = 39;
	public static immutable auto TRHUD_MINES = 40;
	public static immutable auto TRHUD_FORCESHIELD = 41;
	public static immutable auto TRHUD_DROPJAMMER = 42;
	public static immutable auto TRHUD_GENERATOR = 43;
	public static immutable auto TRHUD_SKIING = 44;
	public static immutable auto TRHUD_MEDAL_KILLINGSPREE = 45;
	public static immutable auto TRHUD_MEDAL_KILLINGRAMPAGE = 46;
	public static immutable auto TRHUD_MEDAL_UNSTOPPABLE = 47;
	public static immutable auto TRHUD_MEDAL_RELENTLESS = 48;
	public static immutable auto TRHUD_MEDAL_THESLAYER = 49;
	public static immutable auto TRHUD_MEDAL_SNIPINGSPREE = 50;
	public static immutable auto TRHUD_MEDAL_MARKSMAN = 51;
	public static immutable auto TRHUD_MEDAL_SHARPSHOOTER = 52;
	public static immutable auto TRHUD_MEDAL_AIRMAIL = 53;
	public static immutable auto TRHUD_MEDAL_DEMOLITIONSEXPERT = 54;
	public static immutable auto TRHUD_MEDAL_HURTLOCKER = 55;
	public static immutable auto TRHUD_MEDAL_CLASSICSPREE = 56;
	public static immutable auto TRHUD_MEDAL_DISKJOCKEY = 57;
	public static immutable auto TRHUD_MEDAL_TRIBALFANATIC = 58;
	public static immutable auto TRHUD_MEDAL_DOUBLEKILL = 59;
	public static immutable auto TRHUD_MEDAL_TRIPLEKILL = 60;
	public static immutable auto TRHUD_MEDAL_QUATRAKILL = 61;
	public static immutable auto TRHUD_MEDAL_ULTRAKILL = 62;
	public static immutable auto TRHUD_MEDAL_TEAMKILL = 63;
	public static immutable auto TRHUD_MEDAL_NOJOY = 64;
	public static immutable auto TRHUD_MEDAL_REVENGE = 65;
	public static immutable auto TRHUD_MEDAL_AFTERMATH = 66;
	public static immutable auto TRHUD_MEDAL_FIRSTBLOOD = 67;
	public static immutable auto TRHUD_MEDAL_BLUEPLATE = 68;
	public static immutable auto TRHUD_MEDAL_STICKYKILL = 69;
	public static immutable auto TRHUD_MEDAL_HEADSHOT = 70;
	public static immutable auto TRHUD_MEDAL_ARTILLERYSHOT = 71;
	public static immutable auto TRHUD_MEDAL_MARTIALART = 72;
	public static immutable auto TRHUD_MEDAL_SQUISH = 73;
	public static immutable auto TRHUD_MEDAL_FLAGGOLD = 74;
	public static immutable auto TRHUD_MEDAL_FLAGSILVER = 75;
	public static immutable auto TRHUD_MEDAL_FLAGBRONZE = 75;
	public static immutable auto TRHUD_MEDAL_FLAGLLAMA = 75;
	public static immutable auto TRHUD_MEDAL_GENERHATER = 76;
	public static immutable auto TRHUD_MEDAL_RABBITHUNTER = 77;
	public static immutable auto TRHUD_MEDAL_CAERBANNOG = 78;
	public static immutable auto TRHUD_MEDAL_FINALBLOW = 79;
	public static immutable auto TRHUD_MEDAL_GENDEFENSE = 76;
	public static immutable auto TRHUD_MEDAL_FLAGDEFENSE = 75;
	public static immutable auto TRHUD_MEDAL_VDESTROY = 73;
	public static immutable auto TRHUD_MEDAL_HOTAIR = 284;
	public static immutable auto TRICON_RANK_1 = 80;
	public static immutable auto TRICON_RANK_2 = 81;
	public static immutable auto TRICON_RANK_3 = 82;
	public static immutable auto TRICON_RANK_4 = 83;
	public static immutable auto TRICON_RANK_5 = 84;
	public static immutable auto TRICON_RANK_6 = 85;
	public static immutable auto TRICON_RANK_7 = 86;
	public static immutable auto TRICON_RANK_8 = 87;
	public static immutable auto TRICON_RANK_9 = 88;
	public static immutable auto TRICON_RANK_10 = 89;
	public static immutable auto TRICON_RANK_11 = 90;
	public static immutable auto TRICON_RANK_12 = 91;
	public static immutable auto TRICON_RANK_13 = 92;
	public static immutable auto TRICON_RANK_14 = 93;
	public static immutable auto TRICON_RANK_15 = 94;
	public static immutable auto TRICON_RANK_16 = 95;
	public static immutable auto TRICON_RANK_17 = 96;
	public static immutable auto TRICON_RANK_18 = 97;
	public static immutable auto TRICON_RANK_19 = 98;
	public static immutable auto TRICON_RANK_20 = 99;
	public static immutable auto TRICON_RANK_21 = 100;
	public static immutable auto TRICON_RANK_22 = 101;
	public static immutable auto TRICON_RANK_23 = 102;
	public static immutable auto TRICON_RANK_24 = 103;
	public static immutable auto TRICON_RANK_25 = 104;
	public static immutable auto TRICON_RANK_26 = 105;
	public static immutable auto TRICON_RANK_27 = 106;
	public static immutable auto TRICON_RANK_28 = 107;
	public static immutable auto TRICON_RANK_29 = 108;
	public static immutable auto TRICON_RANK_30 = 109;
	public static immutable auto TRICON_RANK_31 = 110;
	public static immutable auto TRICON_RANK_32 = 111;
	public static immutable auto TRICON_RANK_33 = 112;
	public static immutable auto TRICON_RANK_34 = 113;
	public static immutable auto TRICON_RANK_35 = 114;
	public static immutable auto TRICON_RANK_36 = 115;
	public static immutable auto TRICON_RANK_37 = 116;
	public static immutable auto TRICON_RANK_38 = 117;
	public static immutable auto TRICON_RANK_39 = 118;
	public static immutable auto TRICON_RANK_40 = 119;
	public static immutable auto TRICON_RANK_41 = 120;
	public static immutable auto TRICON_RANK_42 = 121;
	public static immutable auto TRICON_RANK_43 = 122;
	public static immutable auto TRICON_RANK_44 = 123;
	public static immutable auto TRICON_RANK_45 = 124;
	public static immutable auto TRICON_RANK_46 = 125;
	public static immutable auto TRICON_RANK_47 = 126;
	public static immutable auto TRICON_RANK_48 = 127;
	public static immutable auto TRICON_RANK_49 = 128;
	public static immutable auto TRICON_RANK_50 = 129;
	public static immutable auto TRICON_KILLTYPE_EXPLOSIVE = 130;
	public static immutable auto TRICON_KILLTYPE_STICKY = 131;
	public static immutable auto TRICON_KILLTYPE_SQUISH = 132;
	public static immutable auto TRICON_KILLTYPE_MELEE = 133;
	public static immutable auto TRICON_KILLTYPE_FALLING = 134;
	public static immutable auto TRICON_KILLTYPE_VEHICLE = 135;
	public static immutable auto TRICON_KILLTYPE_BULLET = 136;
	public static immutable auto TRICON_KILLTYPE_SNIPER = 137;
	public static immutable auto TRICON_KILLTYPE_BASE_TURRET = 138;
	public static immutable auto TRICON_KILLTYPE_HEADSHOT = 139;
	public static immutable auto TRICON_KILLTYPE_GENERIC = 140;
	public static immutable auto TRICON_KILLTYPE_SPINFUSOR = 141;
	public static immutable auto TRICON_KILLTYPE_TURRET = 142;
	public static immutable auto TRICON_ACCOLADE_BASE_DESTROY = 143;
	public static immutable auto TRICON_ACCOLADE_BASE_REPAIR = 144;
	public static immutable auto TRICON_ACCOLADE_MIRACLE = 145;
	public static immutable auto TRICON_ACCOLADE_ULTRAKILLNORED = 146;
	public static immutable auto TRICON_ACCOLADE_NOTAMONGEQUALS = 147;
	public static immutable auto TRICON_ACCOLADE_EXPLOSIVESPREE = 148;
	public static immutable auto TRICON_ACCOLADE_ULTRAFASTGRAB = 149;
	public static immutable auto TRICON_ACCOLADE_ONEMANARMY = 150;
	public static immutable auto TRICON_ACCOLADE_GAMEWINNER = 151;
	public static immutable auto TRICON_ACCOLADE_UNITEDWESTAND = 152;
	public static immutable auto TRICON_ACCOLADE_DOUBLEDOWN = 153;
	public static immutable auto TRICON_ACCOLADE_FASTFLAGGRAB = 154;
	public static immutable auto TRICON_ACCOLADE_SHRIKEDOWN = 155;
	public static immutable auto TRICON_ACCOLADE_GRAVCYCLEDOWN = 156;
	public static immutable auto TRICON_ACCOLADE_BEOWULFDOWN = 157;
	public static immutable auto TRICON_ACCOLADE_FINALBLOW = 158;
	public static immutable auto TRICON_ACCOLADE_BENCHEM = 159;
	public static immutable auto TRICON_ACCOLADE_LASTMANSTANDING = 160;
	public static immutable auto TRICON_ACCOLADE_TRIBALHONOR = 161;
	public static immutable auto TRICON_ACCOLADE_FLAGKILLER = 162;
	public static immutable auto TRICON_ACCOLADE_GAMECOMPLETE = 163;
	public static immutable auto TRICON_ACCOLADE_FLAGDEFENSE = 164;
	public static immutable auto TRICON_ACCOLADE_GENERATORDEFENSE = 165;
	public static immutable auto TRICON_ACCOLADE_LLAMAGRAB = 166;
	public static immutable auto TRICON_ACCOLADE_EGRAB = 167;
	public static immutable auto TRICON_ACCOLADE_TURRETDESTROYED = 168;
	public static immutable auto TRICON_ACCOLADE_ALTFLAGCARRY = 169;
	public static immutable auto TRICON_ACCOLADE_HOLDTHELINE = 281;
	public static immutable auto TRICON_ACCOLADE_CAPTUREANDHOLD = 282;
	public static immutable auto TRICON_BADGE_FLAGDEFENSE_4 = 170;
	public static immutable auto TRICON_BADGE_FLAGDEFENSE_3 = 171;
	public static immutable auto TRICON_BADGE_FLAGDEFENSE_2 = 172;
	public static immutable auto TRICON_BADGE_FLAGDEFENSE_1 = 173;
	public static immutable auto TRICON_BADGE_OPERATOR_4 = 174;
	public static immutable auto TRICON_BADGE_OPERATOR_3 = 175;
	public static immutable auto TRICON_BADGE_OPERATOR_2 = 176;
	public static immutable auto TRICON_BADGE_OPERATOR_1 = 177;
	public static immutable auto TRICON_BADGE_CALLINKILLS_4 = 178;
	public static immutable auto TRICON_BADGE_CALLINKILLS_3 = 179;
	public static immutable auto TRICON_BADGE_CALLINKILLS_2 = 180;
	public static immutable auto TRICON_BADGE_CALLINKILLS_1 = 181;
	public static immutable auto TRICON_BADGE_MELEEKILLS_4 = 182;
	public static immutable auto TRICON_BADGE_MELEEKILLS_3 = 183;
	public static immutable auto TRICON_BADGE_MELEEKILLS_2 = 184;
	public static immutable auto TRICON_BADGE_MELEEKILLS_1 = 185;
	public static immutable auto TRICON_BADGE_ONEMANARMY_4 = 186;
	public static immutable auto TRICON_BADGE_ONEMANARMY_3 = 187;
	public static immutable auto TRICON_BADGE_ONEMANARMY_2 = 188;
	public static immutable auto TRICON_BADGE_ONEMANARMY_1 = 189;
	public static immutable auto TRICON_BADGE_FLAGCAPPER_4 = 190;
	public static immutable auto TRICON_BADGE_FLAGCAPPER_3 = 191;
	public static immutable auto TRICON_BADGE_FLAGCAPPER_2 = 192;
	public static immutable auto TRICON_BADGE_FLAGCAPPER_1 = 193;
	public static immutable auto TRICON_BADGE_TOUROFDUTY_4 = 194;
	public static immutable auto TRICON_BADGE_TOUROFDUTY_3 = 195;
	public static immutable auto TRICON_BADGE_TOUROFDUTY_2 = 196;
	public static immutable auto TRICON_BADGE_TOUROFDUTY_1 = 197;
	public static immutable auto TRICON_BADGE_MULTIKILL_4 = 198;
	public static immutable auto TRICON_BADGE_MULTIKILL_3 = 199;
	public static immutable auto TRICON_BADGE_MULTIKILL_2 = 200;
	public static immutable auto TRICON_BADGE_MULTIKILL_1 = 201;
	public static immutable auto TRICON_BADGE_COMBATSTAR_4 = 202;
	public static immutable auto TRICON_BADGE_COMBATSTAR_3 = 203;
	public static immutable auto TRICON_BADGE_COMBATSTAR_2 = 204;
	public static immutable auto TRICON_BADGE_COMBATSTAR_1 = 205;
	public static immutable auto TRICON_BADGE_CROSSCOUNTRY_4 = 206;
	public static immutable auto TRICON_BADGE_CROSSCOUNTRY_3 = 207;
	public static immutable auto TRICON_BADGE_CROSSCOUNTRY_2 = 208;
	public static immutable auto TRICON_BADGE_CROSSCOUNTRY_1 = 209;
	public static immutable auto TRICON_BADGE_POWERPLAYER_4 = 210;
	public static immutable auto TRICON_BADGE_POWERPLAYER_3 = 211;
	public static immutable auto TRICON_BADGE_POWERPLAYER_2 = 212;
	public static immutable auto TRICON_BADGE_POWERPLAYER_1 = 213;
	public static immutable auto TRICON_BADGE_DEMOMAN_4 = 214;
	public static immutable auto TRICON_BADGE_DEMOMAN_3 = 215;
	public static immutable auto TRICON_BADGE_DEMOMAN_2 = 216;
	public static immutable auto TRICON_BADGE_DEMOMAN_1 = 217;
	public static immutable auto TRICON_BADGE_SPEEDRUNNER_4 = 218;
	public static immutable auto TRICON_BADGE_SPEEDRUNNER_3 = 219;
	public static immutable auto TRICON_BADGE_SPEEDRUNNER_2 = 220;
	public static immutable auto TRICON_BADGE_SPEEDRUNNER_1 = 221;
	public static immutable auto TRICON_BADGE_GOODDRIVER_4 = 222;
	public static immutable auto TRICON_BADGE_GOODDRIVER_3 = 223;
	public static immutable auto TRICON_BADGE_GOODDRIVER_2 = 224;
	public static immutable auto TRICON_BADGE_GOODDRIVER_1 = 225;
	public static immutable auto TRICON_BADGE_PURPLEHEART_4 = 226;
	public static immutable auto TRICON_BADGE_PURPLEHEART_3 = 227;
	public static immutable auto TRICON_BADGE_PURPLEHEART_2 = 228;
	public static immutable auto TRICON_BADGE_PURPLEHEART_1 = 229;
	public static immutable auto TRICON_BADGE_HAPPENSTOUSALL = 230;
	public static immutable auto TRICON_BADGE_INVSTATION = 231;
	public static immutable auto TRICON_BADGE_ANTIVEHICLE_4 = 232;
	public static immutable auto TRICON_BADGE_ANTIVEHICLE_3 = 233;
	public static immutable auto TRICON_BADGE_ANTIVEHICLE_2 = 234;
	public static immutable auto TRICON_BADGE_ANTIVEHICLE_1 = 235;
	public static immutable auto TRICON_BADGE_UTILITYBELT_4 = 236;
	public static immutable auto TRICON_BADGE_UTILITYBELT_3 = 237;
	public static immutable auto TRICON_BADGE_UTILITYBELT_2 = 238;
	public static immutable auto TRICON_BADGE_UTILITYBELT_1 = 239;
	public static immutable auto TRICON_BADGE_ONCALL_4 = 240;
	public static immutable auto TRICON_BADGE_ONCALL_3 = 241;
	public static immutable auto TRICON_BADGE_ONCALL_2 = 242;
	public static immutable auto TRICON_BADGE_ONCALL_1 = 243;
	public static immutable auto TRICON_BADGE_SUPPORT_4 = 244;
	public static immutable auto TRICON_BADGE_SUPPORT_3 = 245;
	public static immutable auto TRICON_BADGE_SUPPORT_2 = 246;
	public static immutable auto TRICON_BADGE_SUPPORT_1 = 247;
	public static immutable auto TRICON_BADGE_MARKSMAN_4 = 248;
	public static immutable auto TRICON_BADGE_MARKSMAN_3 = 249;
	public static immutable auto TRICON_BADGE_MARKSMAN_2 = 250;
	public static immutable auto TRICON_BADGE_MARKSMAN_1 = 251;
	public static immutable auto TRICON_BADGE_ASSISTOR_4 = 252;
	public static immutable auto TRICON_BADGE_ASSISTOR_3 = 253;
	public static immutable auto TRICON_BADGE_ASSISTOR_2 = 254;
	public static immutable auto TRICON_BADGE_ASSISTOR_1 = 255;
	public static immutable auto TRICON_BADGE_BUILDER_4 = 256;
	public static immutable auto TRICON_BADGE_BUILDER_3 = 257;
	public static immutable auto TRICON_BADGE_BUILDER_2 = 258;
	public static immutable auto TRICON_BADGE_BUILDER_1 = 259;
	public static immutable auto TRICON_BADGE_GOINGFAST_4 = 260;
	public static immutable auto TRICON_BADGE_GOINGFAST_3 = 261;
	public static immutable auto TRICON_BADGE_GOINGFAST_2 = 262;
	public static immutable auto TRICON_BADGE_GOINGFAST_1 = 263;
	public static immutable auto RANK_XP_1 = 0;
	public static immutable auto RANK_XP_2 = 1350;
	public static immutable auto RANK_XP_3 = 2781;
	public static immutable auto RANK_XP_4 = 4298;
	public static immutable auto RANK_XP_5 = 5906;
	public static immutable auto RANK_XP_6 = 11212;
	public static immutable auto RANK_XP_7 = 16836;
	public static immutable auto RANK_XP_8 = 22798;
	public static immutable auto RANK_XP_9 = 31741;
	public static immutable auto RANK_XP_10 = 41130;
	public static immutable auto RANK_XP_11 = 50990;
	public static immutable auto RANK_XP_12 = 61342;
	public static immutable auto RANK_XP_13 = 76870;
	public static immutable auto RANK_XP_14 = 93020;
	public static immutable auto RANK_XP_15 = 109815;
	public static immutable auto RANK_XP_16 = 127283;
	public static immutable auto RANK_XP_17 = 145449;
	public static immutable auto RANK_XP_18 = 172698;
	public static immutable auto RANK_XP_19 = 200765;
	public static immutable auto RANK_XP_20 = 229673;
	public static immutable auto RANK_XP_21 = 259449;
	public static immutable auto RANK_XP_22 = 290118;
	public static immutable auto RANK_XP_23 = 321707;
	public static immutable auto RANK_XP_24 = 369091;
	public static immutable auto RANK_XP_25 = 417896;
	public static immutable auto RANK_XP_26 = 468166;
	public static immutable auto RANK_XP_27 = 519943;
	public static immutable auto RANK_XP_28 = 573274;
	public static immutable auto RANK_XP_29 = 628205;
	public static immutable auto RANK_XP_30 = 684783;
	public static immutable auto RANK_XP_31 = 743059;
	public static immutable auto RANK_XP_32 = 803084;
	public static immutable auto RANK_XP_33 = 864909;
	public static immutable auto RANK_XP_34 = 928589;
	public static immutable auto RANK_XP_35 = 994179;
	public static immutable auto RANK_XP_36 = 1061737;
	public static immutable auto RANK_XP_37 = 1131321;
	public static immutable auto RANK_XP_38 = 1202994;
	public static immutable auto RANK_XP_39 = 1276816;
	public static immutable auto RANK_XP_40 = 1352853;
	public static immutable auto RANK_XP_41 = 1431171;
	public static immutable auto RANK_XP_42 = 1511839;
	public static immutable auto RANK_XP_43 = 1594926;
	public static immutable auto RANK_XP_44 = 1680507;
	public static immutable auto RANK_XP_45 = 1768654;
	public static immutable auto RANK_XP_46 = 1859447;
	public static immutable auto RANK_XP_47 = 1952963;
	public static immutable auto RANK_XP_48 = 2049284;
	public static immutable auto RANK_XP_49 = 2148495;
	public static immutable auto RANK_XP_50 = 2250682;
	public static immutable auto ACCOLADE_TYPE_MISC = 0;
	public static immutable auto ACCOLADE_TYPE_MULTIKILL = 1;
	public static immutable auto ACCOLADE_TYPE_KILLSTREAK = 2;
	public static immutable auto TRICON_PERK_ICON_WIP = 1;
	public static immutable auto TRICON_PERK_BONUS_KILL_CREDITS = 1;
	public static immutable auto TRICON_PERK_STICKY_HANDS = 2;
	public static immutable auto TRICON_PERK_REDUCED_VEHICLE_COST = 3;
	public static immutable auto TRICON_PERK_REDUCED_SELF_DAMAGE = 4;
	public static immutable auto TRICON_PERK_REDUCED_RUN_OVER = 5;
	public static immutable auto TRICON_PERK_REDUCED_BASE_UPGRADE_COST = 6;
	public static immutable auto TRICON_PERK_REDUCED_FALL_DMG = 7;
	public static immutable auto TRICON_PERK_REDUCED_AIR_VEHICLE_COST = 8;
	public static immutable auto TRICON_PERK_TRAP_DETECTION = 9;
	public static immutable auto TRICON_PERK_PICKUP_ENERGY_HEALTH = 10;
	public static immutable auto TRICON_PERK_MELEE_FLAG_DROP = 11;
	public static immutable auto TRICON_PERK_EXTRA_MINES = 12;
	public static immutable auto TRICON_PERK_EXTRA_ENERGY = 13;
	public static immutable auto TRICON_PERK_EXTRA_GRENADE_PICKUP = 14;
	public static immutable auto TRICON_PERK_EXTRA_AMMO = 15;
	public static immutable auto TRICON_PERK_EXTRA_GRENADE = 16;
	public static immutable auto TRICON_PERK_BEOWULF_HEALTH_INCREASE = 17;
	public static immutable auto TRICON_PERK_EJECTION_SEAT = 18;
	public static immutable auto TRICON_PERK_ORBITAL_STRIKE = 19;
	public static immutable auto TRICON_PERK_REDUCED_MELEE_DAMAGE = 20;
	public static immutable auto TRICON_PERK_MELEE_BACKSTAB = 21;
	public static immutable auto TRICON_PERK_DEMOLITIONS = 22;
	public static immutable auto TRICON_PERK_SQUIRRELLY = 23;
	public static immutable auto TRICON_PERK_STEALTHY = 24;
	public static immutable auto TRICON_PERK_ULTRA_CAPACITOR = 25;
	public static immutable auto TRICON_PERK_DETERMINATION = 26;
	public static immutable auto TRICON_SKILL_SPEED = 1;
	public static immutable auto TRICON_SKILL_ENERGY = 2;
	public static immutable auto TRICON_SKILL_PING = 3;
	public static immutable auto TRICON_SKILL_AMMO = 4;
	public static immutable auto TRICON_SKILL_ANTI_ARMOR = 5;
	public static immutable auto TRICON_SKILL_GRENADE = 6;
	public static immutable auto TRICON_SKILL_RADIUS = 7;
	public static immutable auto TRICON_SKILL_HEALTH = 8;
	public static immutable auto TRICON_SKILL_BOOT = 9;
	public static immutable auto TRICON_SKILL_TIMER = 10;
	public static immutable auto TRICON_CLASS_SENTINEL = 1;
	public static immutable auto TRICON_CLASS_PATHFINDER = 2;
	public static immutable auto TRICON_CLASS_JUMPER = 3;
	public static immutable auto TRICON_CLASS_INFILTRATOR = 4;
	public static immutable auto TRICON_CLASS_WARDER = 30;
	public static immutable auto TRICON_CLASS_TECHNICIAN = 31;
	public static immutable auto TRICON_CLASS_SOLDIER = 32;
	public static immutable auto TRICON_CLASS_SCRAMBLER = 33;
	public static immutable auto TRICON_CLASS_RANGER = 34;
	public static immutable auto TRICON_CLASS_RAIDER = 35;
	public static immutable auto TRICON_CLASS_ENGINEER = 36;
	public static immutable auto TRICON_CLASS_ROOK = 60;
	public static immutable auto TRICON_CLASS_MARAUDER = 61;
	public static immutable auto TRICON_CLASS_JUGGERNAUT = 62;
	public static immutable auto TRICON_CLASS_DOOMBRINGER = 63;
	public static immutable auto TRICON_CLASS_BRUTE = 64;
	public static immutable auto TRICON_CLASS_WIP = 88;
	public static immutable auto ICON_UPGRADE_NONE = 0;
	public static immutable auto MOD_TYPE_NONE = 1;
	public static immutable auto MOD_TYPE_HEALTH = 2;
	public static immutable auto MOD_TYPE_MASSPCT = 3;
	public static immutable auto MOD_TYPE_RADARLINK = 4;
	public static immutable auto MOD_TYPE_FLAGREACH = 5;
	public static immutable auto MOD_TYPE_BUILDUPPCT = 6;
	public static immutable auto MOD_TYPE_CLOTHESLINE = 7;
	public static immutable auto MOD_TYPE_STICKYHANDS = 8;
	public static immutable auto MOD_TYPE_MAXSKISPEED = 9;
	public static immutable auto MOD_TYPE_EXTRAENERGY = 10;
	public static immutable auto MOD_TYPE_EJECTIONSEAT = 11;
	public static immutable auto MOD_TYPE_SELFDAMAGEPCT = 12;
	public static immutable auto MOD_TYPE_REPAIRRATEPCT = 13;
	public static immutable auto MOD_TYPE_EXTRAMINESOUT = 14;
	public static immutable auto MOD_TYPE_VEHICLEEXTRAHEALTH = 15;
	public static immutable auto MOD_TYPE_GROUNDSPEEDPCT = 16;
	public static immutable auto MOD_TYPE_ENERGYDRAINPCT = 17;
	public static immutable auto MOD_TYPE_UPGRADECOSTPCT = 18;
	public static immutable auto MOD_TYPE_CANDETECTTRAPS = 19;
	public static immutable auto MOD_TYPE_SPLATDAMAGEPCT = 20;
	public static immutable auto MOD_TYPE_WEAPONSWITCHPCT = 21;
	public static immutable auto MOD_TYPE_POTENTIALENERGY = 22;
	public static immutable auto MOD_TYPE_MAXJETTINGSPEED = 23;
	public static immutable auto MOD_TYPE_CREDITSFROMKILLS = 24;
	public static immutable auto MOD_TYPE_TERMINALSKISPEED = 25;
	public static immutable auto MOD_TYPE_MAXSKICONTROLPCT = 26;
	public static immutable auto MOD_TYPE_HASDETERMINATION = 27;
	public static immutable auto MOD_TYPE_DEPLOYABLEHEALTH = 28;
	public static immutable auto MOD_TYPE_EXTRAOFFHANDAMMO = 29;
	public static immutable auto MOD_TYPE_EXTRAPRIMARYAMMO = 30;
	public static immutable auto MOD_TYPE_PRIMARYRELOADPCT = 31;
	public static immutable auto MOD_TYPE_SENSORDISTANCEPCT = 32;
	public static immutable auto MOD_TYPE_PACKENERGYCOSTPCT = 33;
	public static immutable auto MOD_TYPE_AMMOFROMPICKUPPCT = 34;
	public static immutable auto MOD_TYPE_TIMETOREGENENERGY = 35;
	public static immutable auto MOD_TYPE_SECONDARYRELOADPCT = 36;
	public static immutable auto MOD_TYPE_EXTRASECONDARYAMMO = 37;
	public static immutable auto MOD_TYPE_ENERGYREGENRATEPCT = 38;
	public static immutable auto MOD_TYPE_HEALTHREGENRATEPCT = 39;
	public static immutable auto MOD_TYPE_DEPLOYABLERANGEPCT = 40;
	public static immutable auto MOD_TYPE_JAMMERPACKRADIUSPCT = 41;
	public static immutable auto MOD_TYPE_BLINKPACKPOTENCYPCT = 42;
	public static immutable auto MOD_TYPE_PEAKSKICONTROLSPEED = 43;
	public static immutable auto MOD_TYPE_CANCALLINSUPPLYDROP = 44;
	public static immutable auto MOD_TYPE_EXTRADEPLOYABLESOUT = 45;
	public static immutable auto MOD_TYPE_HEALTHFROMPICKUPPCT = 46;
	public static immutable auto MOD_TYPE_ENERGYFROMPICKUPPCT = 47;
	public static immutable auto MOD_TYPE_TERMINALJETTINGSPEED = 48;
	public static immutable auto MOD_TYPE_TIMETOREGENHEALTHPCT = 49;
	public static immutable auto MOD_TYPE_VEHICLECOSTPCT = 50;
	public static immutable auto MOD_TYPE_SKICONTROLSIGMASQUARE = 51;
	public static immutable auto MOD_TYPE_RECEIVEMELEEDAMAGEPCT = 52;
	public static immutable auto MOD_TYPE_VICTIMDROPFLAGONMELEE = 53;
	public static immutable auto MOD_TYPE_PRIMARYWEAPONRANGEPCT = 54;
	public static immutable auto MOD_TYPE_OFFHANDDAMAGERADIUSPCT = 55;
	public static immutable auto MOD_TYPE_TURRETACQUIRETARGETPCT = 56;
	public static immutable auto MOD_TYPE_WHITEOUTINTERPSPEEDPCT = 57;
	public static immutable auto MOD_TYPE_BACKSTABMELEEDAMAGEPCT = 58;
	public static immutable auto MOD_TYPE_MAXSTOPPINGDISTANCEPCT = 59;
	public static immutable auto MOD_TYPE_SECONDARYWEAPONRANGEPCT = 60;
	public static immutable auto MOD_TYPE_EXTRAGRENADESFROMPICKUP = 61;
	public static immutable auto MOD_TYPE_SHIELDPACKEFFECTIVENESS = 62;
	public static immutable auto MOD_TYPE_STEALTHPACKPULSETIMEPCT = 63;
	public static immutable auto MOD_TYPE_PRIMARYINCREASEDCLIPSIZE = 64;
	public static immutable auto MOD_TYPE_EXTRACREDITSFROMBELTKILLS = 65;
	public static immutable auto MOD_TYPE_TURRETARMORPENETRATIONPCT = 66;
	public static immutable auto MOD_TYPE_SECONDARYINCREASEDCLIPSIZE = 67;
	public static immutable auto MOD_TYPE_OFFHANDARMORPENETRATIONPCT = 68;
	public static immutable auto MOD_TYPE_PRIMARYARMORPENETRATIONPCT = 69;
	public static immutable auto MOD_TYPE_RUNOVERDAMAGEPROTECTIONPCT = 70;
	public static immutable auto MOD_TYPE_PRIMARYWEAPONENERGYCOSTPCT = 71;
	public static immutable auto MOD_TYPE_ACQUIRETIMEBYENEMYTURRETPCT = 72;
	public static immutable auto MOD_TYPE_SECONDARYARMORPENETRATIONPCT = 73;
	public static immutable auto MOD_TYPE_VEHICLEEXTRAENERGY = 74;
	public static immutable auto MOD_TYPE_AMMOPICKUPREACH = 75;
	public static immutable auto MOD_TYPE_VEHICLEPASSENGERDMGPROTPCT = 76;
	public static immutable auto MOD_TYPE_DAMAGEREPAIRENEMYOBJECTIVES = 77;
	public static immutable auto MOD_TYPE_POTENTIALENERGYFALLDAMAGE = 78;
	public static immutable auto MOD_TYPE_FASTERTHROWBELTBUFFPCT = 79;
	public static immutable auto MOD_TYPE_IGNOREGRENADESECONDARYONSELF = 80;
	public static immutable auto MOD_TYPE_POTENTIALENERGYDMGTRANSFERPCT = 81;
	public static immutable auto MOD_TYPE_FLAGREACHTIER = 82;
	public static immutable auto MOD_TYPE_SONICPUNCH = 83;
	public static immutable auto MOD_TYPE_SONICPUNCHDIST = 84;
	public static immutable auto MOD_TYPE_SONICPUNCHKNOCKBACK = 85;
	public static immutable auto MOD_TYPE_RAGE = 86;
	public static immutable auto MOD_TYPE_RAGEENERGYREGEN = 87;
	public static immutable auto MOD_TYPE_RAGETIMELENGTH = 88;
	public static immutable auto MOD_TYPE_RAGEHEALTHRESTOREPCT = 89;
	public static immutable auto MOD_TYPE_IGNOREPULSESTEALTHTIME = 90;
	public static immutable auto MOD_TYPE_RAGEMASSREDUCTION = 91;
	public static immutable auto MOD_TYPE_REPAIRDEPLOYABLERATEPCT = 92;
	struct EquipLevel
	{
		public @property final auto ref ubyte UpgradeLevel() { return *cast(ubyte*)(cast(size_t)&this + 4); }
		private ubyte __UpgradeLevel[1];
		public @property final auto ref int EquipId() { return *cast(int*)(cast(size_t)&this + 0); }
		private ubyte __EquipId[4];
	}
	public @property final auto ref int m_nCreditsEarned() { return *cast(int*)(cast(size_t)cast(void*)this + 948); }
	public @property final auto ref int m_nKills() { return *cast(int*)(cast(size_t)cast(void*)this + 940); }
	public @property final auto ref int m_nAssists() { return *cast(int*)(cast(size_t)cast(void*)this + 944); }
	public @property final auto ref int r_nArenaSpawnsLeft() { return *cast(int*)(cast(size_t)cast(void*)this + 1128); }
	public @property final bool r_bIsCrossedOffArenaList() { return (*cast(uint*)(cast(size_t)cast(void*)this + 972) & 0x8) != 0; }
	public @property final bool r_bIsCrossedOffArenaList(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 972) |= 0x8; } else { *cast(uint*)(cast(size_t)cast(void*)this + 972) &= ~0x8; } return val; }
	public @property final auto ref Actor m_LockedTarget() { return *cast(Actor*)(cast(size_t)cast(void*)this + 976); }
	public @property final bool c_bIsBuddyToLocalPlayer() { return (*cast(uint*)(cast(size_t)cast(void*)this + 972) & 0x2) != 0; }
	public @property final bool c_bIsBuddyToLocalPlayer(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 972) |= 0x2; } else { *cast(uint*)(cast(size_t)cast(void*)this + 972) &= ~0x2; } return val; }
	public @property final bool c_bIsMutualBuddiesWithLocalPlayer() { return (*cast(uint*)(cast(size_t)cast(void*)this + 972) & 0x4) != 0; }
	public @property final bool c_bIsMutualBuddiesWithLocalPlayer(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 972) |= 0x4; } else { *cast(uint*)(cast(size_t)cast(void*)this + 972) &= ~0x4; } return val; }
	public @property final bool r_bIsLastManStanding() { return (*cast(uint*)(cast(size_t)cast(void*)this + 972) & 0x10) != 0; }
	public @property final bool r_bIsLastManStanding(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 972) |= 0x10; } else { *cast(uint*)(cast(size_t)cast(void*)this + 972) &= ~0x10; } return val; }
	public @property final auto ref int m_nFreeCredits() { return *cast(int*)(cast(size_t)cast(void*)this + 964); }
	public @property final auto ref int m_nCurrentCredits() { return *cast(int*)(cast(size_t)cast(void*)this + 968); }
	public @property final auto ref ScriptClass r_VoiceClass() { return *cast(ScriptClass*)(cast(size_t)cast(void*)this + 984); }
	public @property final auto ref int m_nRabbitRank() { return *cast(int*)(cast(size_t)cast(void*)this + 924); }
	public @property final auto ref int m_nPlayerIconIndex() { return *cast(int*)(cast(size_t)cast(void*)this + 936); }
	public @property final auto ref int r_bSkinId() { return *cast(int*)(cast(size_t)cast(void*)this + 1132); }
	public @property final auto ref ScriptClass c_Cached1PSkin() { return *cast(ScriptClass*)(cast(size_t)cast(void*)this + 1124); }
	public @property final auto ref ScriptClass c_Cached3PSkin() { return *cast(ScriptClass*)(cast(size_t)cast(void*)this + 1120); }
	public @property final auto ref TrValueModifier m_ValueModifier() { return *cast(TrValueModifier*)(cast(size_t)cast(void*)this + 1116); }
	public @property final auto ref TrPlayerReplicationInfo.EquipLevel r_EquipLevels() { return *cast(TrPlayerReplicationInfo.EquipLevel*)(cast(size_t)cast(void*)this + 1012); }
	public @property final auto ref float c_fRedFlagTimeStamp() { return *cast(float*)(cast(size_t)cast(void*)this + 1008); }
	public @property final auto ref float c_fRedFlagPingTime() { return *cast(float*)(cast(size_t)cast(void*)this + 1004); }
	public @property final auto ref float c_fRedFlagPingThreshold() { return *cast(float*)(cast(size_t)cast(void*)this + 1000); }
	public @property final auto ref float c_fCurrentPingMS() { return *cast(float*)(cast(size_t)cast(void*)this + 996); }
	public @property final auto ref TrInventoryHelper InvHelper() { return *cast(TrInventoryHelper*)(cast(size_t)cast(void*)this + 992); }
	public @property final auto ref TrStatsInterface Stats() { return *cast(TrStatsInterface*)(cast(size_t)cast(void*)this + 988); }
	public @property final auto ref TrObject.EArmorType m_ArmorType() { return *cast(TrObject.EArmorType*)(cast(size_t)cast(void*)this + 980); }
	public @property final bool bDevUpgrades() { return (*cast(uint*)(cast(size_t)cast(void*)this + 972) & 0x1) != 0; }
	public @property final bool bDevUpgrades(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 972) |= 0x1; } else { *cast(uint*)(cast(size_t)cast(void*)this + 972) &= ~0x1; } return val; }
	public @property final auto ref int m_nPlayerClassId() { return *cast(int*)(cast(size_t)cast(void*)this + 960); }
	public @property final auto ref int m_nBaseXP() { return *cast(int*)(cast(size_t)cast(void*)this + 956); }
	public @property final auto ref int m_nBaseGP() { return *cast(int*)(cast(size_t)cast(void*)this + 952); }
	public @property final auto ref int m_nRankIconIndex() { return *cast(int*)(cast(size_t)cast(void*)this + 932); }
	public @property final auto ref int m_nRankNum() { return *cast(int*)(cast(size_t)cast(void*)this + 928); }
	public @property final auto ref ScriptClass m_PendingBaseClass() { return *cast(ScriptClass*)(cast(size_t)cast(void*)this + 920); }
	public @property final auto ref ScriptClass m_CurrentBaseClass() { return *cast(ScriptClass*)(cast(size_t)cast(void*)this + 916); }
	public @property final auto ref ScriptClass m_Rank() { return *cast(ScriptClass*)(cast(size_t)cast(void*)this + 912); }
	public @property final auto ref int m_PendingLoadout() { return *cast(int*)(cast(size_t)cast(void*)this + 908); }
	public @property final auto ref int m_CurrentLoadout() { return *cast(int*)(cast(size_t)cast(void*)this + 904); }
	final ScriptClass GetPlayerRank()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[54012], params.ptr, cast(void*)0);
		return *cast(ScriptClass*)params.ptr;
	}
	final ScriptClass GetCurrentClass()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[54014], params.ptr, cast(void*)0);
		return *cast(ScriptClass*)params.ptr;
	}
	final ScriptClass GetEquipDevice(ScriptClass FamilyInfo, TrObject.TR_EQUIP_POINT equipSlot)
	{
		ubyte params[9];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = FamilyInfo;
		*cast(TrObject.TR_EQUIP_POINT*)&params[4] = equipSlot;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[54016], params.ptr, cast(void*)0);
		return *cast(ScriptClass*)&params[8];
	}
	final int GetRankIcon()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[63675], params.ptr, cast(void*)0);
		return *cast(int*)params.ptr;
	}
	final TrValueModifier GetCurrentValueModifier()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[67394], params.ptr, cast(void*)0);
		return *cast(TrValueModifier*)params.ptr;
	}
	final TrObject.TR_EQUIP_POINT GetEquipPointByWeaponId(int WeaponId)
	{
		ubyte params[5];
		params[] = 0;
		*cast(int*)params.ptr = WeaponId;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[67918], params.ptr, cast(void*)0);
		return *cast(TrObject.TR_EQUIP_POINT*)&params[4];
	}
	final TrObject.EArmorType GetArmorType()
	{
		ubyte params[1];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[72482], params.ptr, cast(void*)0);
		return *cast(TrObject.EArmorType*)params.ptr;
	}
	final ScriptClass GetCurrentSkinClass(ScriptClass FamilyInfo)
	{
		ubyte params[8];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = FamilyInfo;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[72524], params.ptr, cast(void*)0);
		return *cast(ScriptClass*)&params[4];
	}
	final SkeletalMesh GetGibMesh(ScriptClass FamilyInfo)
	{
		ubyte params[8];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = FamilyInfo;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[72526], params.ptr, cast(void*)0);
		return *cast(SkeletalMesh*)&params[4];
	}
	final SkeletalMesh Get3PSkin()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[72528], params.ptr, cast(void*)0);
		return *cast(SkeletalMesh*)params.ptr;
	}
	final SkeletalMesh GetBodyMesh()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[72530], params.ptr, cast(void*)0);
		return *cast(SkeletalMesh*)params.ptr;
	}
	final SkeletalMesh GetHandsMesh()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[73357], params.ptr, cast(void*)0);
		return *cast(SkeletalMesh*)params.ptr;
	}
	final ParticleSystem GetSkiThrust(ScriptClass FamilyInfo, ParticleSystem DefaultSystem)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = FamilyInfo;
		*cast(ParticleSystem*)&params[4] = DefaultSystem;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[73514], params.ptr, cast(void*)0);
		return *cast(ParticleSystem*)&params[8];
	}
	final int GetJetpackSocketCount(ScriptClass FamilyInfo)
	{
		ubyte params[8];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = FamilyInfo;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[73527], params.ptr, cast(void*)0);
		return *cast(int*)&params[4];
	}
	final ParticleSystem GetJetpackThrust(ScriptClass FamilyInfo)
	{
		ubyte params[8];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = FamilyInfo;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[73529], params.ptr, cast(void*)0);
		return *cast(ParticleSystem*)&params[4];
	}
	final ScriptName GetJetpackSocket(ScriptClass FamilyInfo, int Socket)
	{
		ubyte params[16];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = FamilyInfo;
		*cast(int*)&params[4] = Socket;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[73531], params.ptr, cast(void*)0);
		return *cast(ScriptName*)&params[8];
	}
	final ParticleSystem GetJetpackTrail(ScriptClass FamilyInfo)
	{
		ubyte params[8];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = FamilyInfo;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[73533], params.ptr, cast(void*)0);
		return *cast(ParticleSystem*)&params[4];
	}
	final bool RequestLoadoutChange(ScriptClass FamilyInfo, int Loadout)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = FamilyInfo;
		*cast(int*)&params[4] = Loadout;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[76834], params.ptr, cast(void*)0);
		return *cast(bool*)&params[8];
	}
	final bool VerifyCharacter(int ClassId)
	{
		ubyte params[8];
		params[] = 0;
		*cast(int*)params.ptr = ClassId;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101401], params.ptr, cast(void*)0);
		return *cast(bool*)&params[4];
	}
	final void GetCharacterEquip(int ClassId, int Loadout)
	{
		ubyte params[8];
		params[] = 0;
		*cast(int*)params.ptr = ClassId;
		*cast(int*)&params[4] = Loadout;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101404], params.ptr, cast(void*)0);
	}
	final void GetCharacterEquipLocal(int ClassId, int Loadout)
	{
		ubyte params[8];
		params[] = 0;
		*cast(int*)params.ptr = ClassId;
		*cast(int*)&params[4] = Loadout;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101407], params.ptr, cast(void*)0);
	}
	final int GetUpgradeLevel(int ClassId, int Type, ScriptArray!(int) UpgradeList)
	{
		ubyte params[24];
		params[] = 0;
		*cast(int*)params.ptr = ClassId;
		*cast(int*)&params[4] = Type;
		*cast(ScriptArray!(int)*)&params[8] = UpgradeList;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101410], params.ptr, cast(void*)0);
		return *cast(int*)&params[20];
	}
	final int GetUpgradeLevelLocal(int ClassId, int Type, ScriptArray!(int) UpgradeList)
	{
		ubyte params[24];
		params[] = 0;
		*cast(int*)params.ptr = ClassId;
		*cast(int*)&params[4] = Type;
		*cast(ScriptArray!(int)*)&params[8] = UpgradeList;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101416], params.ptr, cast(void*)0);
		return *cast(int*)&params[20];
	}
	final void UpdatePing(float TimeStamp)
	{
		ubyte params[4];
		params[] = 0;
		*cast(float*)params.ptr = TimeStamp;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101422], params.ptr, cast(void*)0);
	}
	final void RegisterBuddy()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101424], cast(void*)0, cast(void*)0);
	}
	final ScriptClass Load1PData(ScriptString ContentPath)
	{
		ubyte params[16];
		params[] = 0;
		*cast(ScriptString*)params.ptr = ContentPath;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101425], params.ptr, cast(void*)0);
		return *cast(ScriptClass*)&params[12];
	}
	final void ReplicatedEvent(ScriptName VarName)
	{
		ubyte params[8];
		params[] = 0;
		*cast(ScriptName*)params.ptr = VarName;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101428], params.ptr, cast(void*)0);
	}
	final void PostBeginPlay()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101433], cast(void*)0, cast(void*)0);
	}
	final void RegisterPlayerWithSession()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101434], cast(void*)0, cast(void*)0);
	}
	final void UpdateValueModifier()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101435], cast(void*)0, cast(void*)0);
	}
	final void Reset()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101441], cast(void*)0, cast(void*)0);
	}
	final void SetPlayerTeam(TeamInfo NewTeam)
	{
		ubyte params[4];
		params[] = 0;
		*cast(TeamInfo*)params.ptr = NewTeam;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101442], params.ptr, cast(void*)0);
	}
	final void SwapToPendingCharClass(bool bIsRespawn)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bIsRespawn;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101447], params.ptr, cast(void*)0);
	}
	final bool VerifyAndLoadCharacter(ScriptClass FamilyInfo, int Loadout)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = FamilyInfo;
		*cast(int*)&params[4] = Loadout;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101456], params.ptr, cast(void*)0);
		return *cast(bool*)&params[8];
	}
	final ScriptString GetSelectedLoadout()
	{
		ubyte params[12];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101469], params.ptr, cast(void*)0);
		return *cast(ScriptString*)params.ptr;
	}
	final bool ShouldVisitStation()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101471], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final void ResolveDefaultEquip(ScriptClass FamilyInfo)
	{
		ubyte params[4];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = FamilyInfo;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101473], params.ptr, cast(void*)0);
	}
	final void SetActiveEquip(TrObject.TR_EQUIP_POINT EquipId, int ItemId)
	{
		ubyte params[5];
		params[] = 0;
		*cast(TrObject.TR_EQUIP_POINT*)params.ptr = EquipId;
		*cast(int*)&params[4] = ItemId;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101486], params.ptr, cast(void*)0);
	}
	final void IncrementKills(bool bEnemyKill)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnemyKill;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101489], params.ptr, cast(void*)0);
	}
	final void CheckMultiKill()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101491], cast(void*)0, cast(void*)0);
	}
	final int GetPlayerClassId()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101493], params.ptr, cast(void*)0);
		return *cast(int*)params.ptr;
	}
	final ScriptClass GetPendingClass()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101495], params.ptr, cast(void*)0);
		return *cast(ScriptClass*)params.ptr;
	}
	final ScriptString GetCurrentClassAbb()
	{
		ubyte params[12];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101497], params.ptr, cast(void*)0);
		return *cast(ScriptString*)params.ptr;
	}
	final int GetPlayerRankNum()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101499], params.ptr, cast(void*)0);
		return *cast(int*)params.ptr;
	}
	final int GetBaseGP()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101501], params.ptr, cast(void*)0);
		return *cast(int*)params.ptr;
	}
	final int GetBaseXP()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101503], params.ptr, cast(void*)0);
		return *cast(int*)params.ptr;
	}
	final void SetPlayerGP(int GP)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = GP;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101505], params.ptr, cast(void*)0);
	}
	final void SetPlayerXP(int XP)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = XP;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101507], params.ptr, cast(void*)0);
	}
	final ScriptClass GetRankFromXP(int XP)
	{
		ubyte params[8];
		params[] = 0;
		*cast(int*)params.ptr = XP;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101509], params.ptr, cast(void*)0);
		return *cast(ScriptClass*)&params[4];
	}
	final ScriptClass GetPerkFromId(int PerkId)
	{
		ubyte params[8];
		params[] = 0;
		*cast(int*)params.ptr = PerkId;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101515], params.ptr, cast(void*)0);
		return *cast(ScriptClass*)&params[4];
	}
	final void SetFlag(UTCarriedObject NewFlag)
	{
		ubyte params[4];
		params[] = 0;
		*cast(UTCarriedObject*)params.ptr = NewFlag;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101521], params.ptr, cast(void*)0);
	}
	final PlayerReplicationInfo Duplicate()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101524], params.ptr, cast(void*)0);
		return *cast(PlayerReplicationInfo*)params.ptr;
	}
	final void CopyProperties(PlayerReplicationInfo PRI)
	{
		ubyte params[4];
		params[] = 0;
		*cast(PlayerReplicationInfo*)params.ptr = PRI;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101527], params.ptr, cast(void*)0);
	}
	final void SetCached3PSkin(ScriptClass NewCachedSkin)
	{
		ubyte params[4];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = NewCachedSkin;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101530], params.ptr, cast(void*)0);
	}
	final ScriptClass GetCurrentVoiceClass(ScriptClass FamilyInfo)
	{
		ubyte params[8];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = FamilyInfo;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101534], params.ptr, cast(void*)0);
		return *cast(ScriptClass*)&params[4];
	}
	final void UpdateCachedSkin()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101538], cast(void*)0, cast(void*)0);
	}
	final void On3PSkinContentLoaded(ScriptClass Skin3PDataClass)
	{
		ubyte params[4];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = Skin3PDataClass;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101546], params.ptr, cast(void*)0);
	}
	final void On1PSkinContentLoaded(ScriptClass Skin1PDataClass)
	{
		ubyte params[4];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = Skin1PDataClass;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101549], params.ptr, cast(void*)0);
	}
	final void Update1PMesh(ScriptClass FamilyInfo)
	{
		ubyte params[4];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = FamilyInfo;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101551], params.ptr, cast(void*)0);
	}
	final void OnPingRedFlagged()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101582], cast(void*)0, cast(void*)0);
	}
	final void ServerPingRedFlag(float CurrentPingMS)
	{
		ubyte params[4];
		params[] = 0;
		*cast(float*)params.ptr = CurrentPingMS;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[101583], params.ptr, cast(void*)0);
	}
}
