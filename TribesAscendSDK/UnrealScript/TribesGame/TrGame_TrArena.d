module UnrealScript.TribesGame.TrGame_TrArena;

import ScriptClasses;
import UnrealScript.Engine.Controller;
import UnrealScript.Engine.PlayerReplicationInfo;
import UnrealScript.TribesGame.TrPlayerController;
import UnrealScript.TribesGame.TrGame;
import UnrealScript.UTGame.UTTeamInfo;

extern(C++) interface TrGame_TrArena : TrGame
{
	public static immutable auto MAX_NUM_ARENA_PLAYERS_PER_TEAM = 8;
	public @property final auto ref int m_nGoalWonRounds() { return *cast(int*)(cast(size_t)cast(void*)this + 1468); }
	public @property final auto ref ubyte m_bHasTeamBenchedAPlayer() { return *cast(ubyte*)(cast(size_t)cast(void*)this + 1464); }
	public @property final auto ref int m_nNumEnemiesAliveAtLastManStanding() { return *cast(int*)(cast(size_t)cast(void*)this + 1456); }
	final void ApplyServerSettings()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90385], cast(void*)0, cast(void*)0);
	}
	final void ResetScores()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90389], cast(void*)0, cast(void*)0);
	}
	final void RepopulatePlayerLists()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90394], cast(void*)0, cast(void*)0);
	}
	final void SetTeam(Controller Other, UTTeamInfo NewTeam, bool bNewTeam)
	{
		ubyte params[12];
		params[] = 0;
		*cast(Controller*)params.ptr = Other;
		*cast(UTTeamInfo*)&params[4] = NewTeam;
		*cast(bool*)&params[8] = bNewTeam;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90402], params.ptr, cast(void*)0);
	}
	final void Logout(Controller Exiting)
	{
		ubyte params[4];
		params[] = 0;
		*cast(Controller*)params.ptr = Exiting;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90408], params.ptr, cast(void*)0);
	}
	final void PostBeginPlay()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90412], cast(void*)0, cast(void*)0);
	}
	final void ResetLevel()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90413], cast(void*)0, cast(void*)0);
	}
	final void RespawnPlayers()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90414], cast(void*)0, cast(void*)0);
	}
	final void ResetRound()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90416], cast(void*)0, cast(void*)0);
	}
	final void ScoreKill(Controller Killer, Controller Other)
	{
		ubyte params[8];
		params[] = 0;
		*cast(Controller*)params.ptr = Killer;
		*cast(Controller*)&params[4] = Other;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90424], params.ptr, cast(void*)0);
	}
	final bool CheckScore(PlayerReplicationInfo Scorer)
	{
		ubyte params[8];
		params[] = 0;
		*cast(PlayerReplicationInfo*)params.ptr = Scorer;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90439], params.ptr, cast(void*)0);
		return *cast(bool*)&params[4];
	}
	final int DetermineWinningTeam()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90442], params.ptr, cast(void*)0);
		return *cast(int*)params.ptr;
	}
	final int GetRoundWinningTeam()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90445], params.ptr, cast(void*)0);
		return *cast(int*)params.ptr;
	}
	final void EndTheRound(PlayerReplicationInfo RoundWinner)
	{
		ubyte params[4];
		params[] = 0;
		*cast(PlayerReplicationInfo*)params.ptr = RoundWinner;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90449], params.ptr, cast(void*)0);
	}
	final void GotoPendingRoundStartTimer()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90454], cast(void*)0, cast(void*)0);
	}
	final int GetNumRemainingAlivePlayers(int TeamIndex)
	{
		ubyte params[8];
		params[] = 0;
		*cast(int*)params.ptr = TeamIndex;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90455], params.ptr, cast(void*)0);
		return *cast(int*)&params[4];
	}
	final bool IsBloodEagleOutOfLives()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90461], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final bool IsDiamondSwordOutOfLives()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90465], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final bool CheckEndGame(PlayerReplicationInfo Winner, ScriptString Reason)
	{
		ubyte params[20];
		params[] = 0;
		*cast(PlayerReplicationInfo*)params.ptr = Winner;
		*cast(ScriptString*)&params[4] = Reason;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90469], params.ptr, cast(void*)0);
		return *cast(bool*)&params[16];
	}
	final void CheckForAutoBalance()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90477], cast(void*)0, cast(void*)0);
	}
	final void SendMatchCountdown(int Seconds)
	{
		ubyte params[4];
		params[] = 0;
		*cast(int*)params.ptr = Seconds;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90514], params.ptr, cast(void*)0);
	}
	final bool AllowRespawn(TrPlayerController TrPC)
	{
		ubyte params[8];
		params[] = 0;
		*cast(TrPlayerController*)params.ptr = TrPC;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90519], params.ptr, cast(void*)0);
		return *cast(bool*)&params[4];
	}
	final void OnServerSpawnedPlayer(TrPlayerController TrPC)
	{
		ubyte params[4];
		params[] = 0;
		*cast(TrPlayerController*)params.ptr = TrPC;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90525], params.ptr, cast(void*)0);
	}
	final int GetGameTypeId()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90530], params.ptr, cast(void*)0);
		return *cast(int*)params.ptr;
	}
	final void SendMatchOver()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[90532], cast(void*)0, cast(void*)0);
	}
}
