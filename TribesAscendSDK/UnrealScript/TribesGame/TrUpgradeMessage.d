module UnrealScript.TribesGame.TrUpgradeMessage;

import ScriptClasses;
import UnrealScript.Helpers;
import UnrealScript.UTGame.UTLocalMessage;
import UnrealScript.Engine.SoundCue;
import UnrealScript.Engine.PlayerReplicationInfo;
import UnrealScript.Core.UObject;
import UnrealScript.Engine.PlayerController;

extern(C++) interface TrUpgradeMessage : UTLocalMessage
{
public extern(D):
	private static __gshared ScriptClass mStaticClass;
	@property final static ScriptClass StaticClass() { mixin(MGSCC("Class TribesGame.TrUpgradeMessage")); }
	private static __gshared TrUpgradeMessage mDefaultProperties;
	@property final static TrUpgradeMessage DefaultProperties() { mixin(MGDPC("TrUpgradeMessage", "TrUpgradeMessage TribesGame.Default__TrUpgradeMessage")); }
	static struct Functions
	{
		private static __gshared
		{
			ScriptFunction mGetString;
			ScriptFunction mClientReceive;
		}
		public @property static final
		{
			ScriptFunction GetString() { mixin(MGF("mGetString", "Function TribesGame.TrUpgradeMessage.GetString")); }
			ScriptFunction ClientReceive() { mixin(MGF("mClientReceive", "Function TribesGame.TrUpgradeMessage.ClientReceive")); }
		}
	}
	@property final auto ref
	{
		ScriptString ObjectiveUpgraded() { mixin(MGPC("ScriptString", 104)); }
		SoundCue UpgradeSound() { mixin(MGPC("SoundCue", 100)); }
	}
final:
	static ScriptString GetString(int* Switch = null, bool* bPRI1HUD = null, PlayerReplicationInfo* RelatedPRI_1 = null, PlayerReplicationInfo* RelatedPRI_2 = null, UObject* OptionalObject = null)
	{
		ubyte params[32];
		params[] = 0;
		if (Switch !is null)
			*cast(int*)params.ptr = *Switch;
		if (bPRI1HUD !is null)
			*cast(bool*)&params[4] = *bPRI1HUD;
		if (RelatedPRI_1 !is null)
			*cast(PlayerReplicationInfo*)&params[8] = *RelatedPRI_1;
		if (RelatedPRI_2 !is null)
			*cast(PlayerReplicationInfo*)&params[12] = *RelatedPRI_2;
		if (OptionalObject !is null)
			*cast(UObject*)&params[16] = *OptionalObject;
		StaticClass.ProcessEvent(Functions.GetString, params.ptr, cast(void*)0);
		return *cast(ScriptString*)&params[20];
	}
	static void ClientReceive(PlayerController P, int* Switch = null, PlayerReplicationInfo* RelatedPRI_1 = null, PlayerReplicationInfo* RelatedPRI_2 = null, UObject* OptionalObject = null)
	{
		ubyte params[20];
		params[] = 0;
		*cast(PlayerController*)params.ptr = P;
		if (Switch !is null)
			*cast(int*)&params[4] = *Switch;
		if (RelatedPRI_1 !is null)
			*cast(PlayerReplicationInfo*)&params[8] = *RelatedPRI_1;
		if (RelatedPRI_2 !is null)
			*cast(PlayerReplicationInfo*)&params[12] = *RelatedPRI_2;
		if (OptionalObject !is null)
			*cast(UObject*)&params[16] = *OptionalObject;
		StaticClass.ProcessEvent(Functions.ClientReceive, params.ptr, cast(void*)0);
	}
}
