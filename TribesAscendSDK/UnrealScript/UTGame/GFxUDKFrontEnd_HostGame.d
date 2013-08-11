module UnrealScript.UTGame.GFxUDKFrontEnd_HostGame;

import ScriptClasses;
import UnrealScript.UTGame.GFxUDKFrontEnd_LaunchGame;

extern(C++) interface GFxUDKFrontEnd_HostGame : GFxUDKFrontEnd_LaunchGame
{
	public static immutable auto SERVERTYPE_LAN = 0;
	public static immutable auto SERVERTYPE_UNRANKED = 1;
	public static immutable auto SERVERTYPE_RANKED = 2;
	public static immutable auto MAXIMUM_PLAYER_COUNT = 24;
	final void OnViewActivated()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[38293], cast(void*)0, cast(void*)0);
	}
	final void OnTopMostView(bool bPlayOpenAnimation)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bPlayOpenAnimation;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[38295], params.ptr, cast(void*)0);
	}
	final ScriptString StripInvalidPasswordCharacters(ScriptString PasswordString, ScriptString InvalidChars)
	{
		ubyte params[36];
		params[] = 0;
		*cast(ScriptString*)params.ptr = PasswordString;
		*cast(ScriptString*)&params[12] = InvalidChars;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[38297], params.ptr, cast(void*)0);
		return *cast(ScriptString*)&params[24];
	}
	final void ValidateServerType()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[38302], cast(void*)0, cast(void*)0);
	}
	final ScriptString GenerateMutatorURLString()
	{
		ubyte params[12];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[38307], params.ptr, cast(void*)0);
		return *cast(ScriptString*)params.ptr;
	}
	final void SetupGameSettings()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[38315], cast(void*)0, cast(void*)0);
	}
	final void CreateOnlineGame(int PlayerIndex)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = PlayerIndex;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[38324], params.ptr, cast(void*)0);
	}
	final void OnGameCreated(ScriptName SessionName, bool bWasSuccessful)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptName*)params.ptr = SessionName;
		*cast(bool*)&params[8] = bWasSuccessful;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[38328], params.ptr, cast(void*)0);
	}
	final void FinishStartDedicated()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[38340], cast(void*)0, cast(void*)0);
	}
	final void OnStartGame_Confirm()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[38346], cast(void*)0, cast(void*)0);
	}
}
