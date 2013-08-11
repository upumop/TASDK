module UnrealScript.TribesGame.TrDevice_RemoteArxBuster;

import ScriptClasses;
import UnrealScript.Engine.SoundCue;
import UnrealScript.Engine.AnimNodeAdditiveBlending;
import UnrealScript.Engine.AnimNodeSequence;
import UnrealScript.TribesGame.TrProj_RemoteArxBuster;
import UnrealScript.Engine.Projectile;
import UnrealScript.Engine.SkelControlSingleBone;
import UnrealScript.TribesGame.TrProjectile;
import UnrealScript.TribesGame.TrDevice;

extern(C++) interface TrDevice_RemoteArxBuster : TrDevice
{
	public @property final auto ref ScriptArray!(TrProj_RemoteArxBuster) RemoteArxRounds() { return *cast(ScriptArray!(TrProj_RemoteArxBuster)*)(cast(size_t)cast(void*)this + 2160); }
	public @property final auto ref SoundCue m_ArxIdleSound() { return *cast(SoundCue*)(cast(size_t)cast(void*)this + 2176); }
	public @property final auto ref AnimNodeAdditiveBlending DetReadyAdditiveAnimNode() { return *cast(AnimNodeAdditiveBlending*)(cast(size_t)cast(void*)this + 2172); }
	public @property final bool r_bIsLeftArmVisible() { return (*cast(uint*)(cast(size_t)cast(void*)this + 2156) & 0x1) != 0; }
	public @property final bool r_bIsLeftArmVisible(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 2156) |= 0x1; } else { *cast(uint*)(cast(size_t)cast(void*)this + 2156) &= ~0x1; } return val; }
	public @property final auto ref SkelControlSingleBone DetonatorChild() { return *cast(SkelControlSingleBone*)(cast(size_t)cast(void*)this + 2152); }
	public @property final auto ref SkelControlSingleBone DetonatorControl() { return *cast(SkelControlSingleBone*)(cast(size_t)cast(void*)this + 2148); }
	final void SetArxIdle(bool bEnabled)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bEnabled;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[85767], params.ptr, cast(void*)0);
	}
	final void ReplicatedEvent(ScriptName VarName)
	{
		ubyte params[8];
		params[] = 0;
		*cast(ScriptName*)params.ptr = VarName;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[85770], params.ptr, cast(void*)0);
	}
	final void SetLeftArmVisible(bool bVisible)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bVisible;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[85772], params.ptr, cast(void*)0);
	}
	final void DetPoseActive(bool bActive)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bActive;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[85774], params.ptr, cast(void*)0);
	}
	final void PostInitAnimTree(
// ERROR: Unknown object class 'Class Core.ComponentProperty'~
void* SkelComp)
	{
		ubyte params[4];
		params[] = 0;
		*cast(
// ERROR: Unknown object class 'Class Core.ComponentProperty'~
void**)params.ptr = SkelComp;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[85776], params.ptr, cast(void*)0);
	}
	final int AddAmmo(int Amount)
	{
		ubyte params[8];
		params[] = 0;
		*cast(int*)params.ptr = Amount;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[85778], params.ptr, cast(void*)0);
		return *cast(int*)&params[4];
	}
	final void PerformInactiveReload()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[85781], cast(void*)0, cast(void*)0);
	}
	final void RequestReload()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[85782], cast(void*)0, cast(void*)0);
	}
	final bool CanClientRequestReloadNow()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[85783], params.ptr, cast(void*)0);
		return *cast(bool*)params.ptr;
	}
	final void StartFire(ubyte FireModeNum)
	{
		ubyte params[1];
		params[] = 0;
		params[0] = FireModeNum;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[85785], params.ptr, cast(void*)0);
	}
	final void FireAmmunition()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[85788], cast(void*)0, cast(void*)0);
	}
	final Projectile ProjectileFire()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[85789], params.ptr, cast(void*)0);
		return *cast(Projectile*)params.ptr;
	}
	final void ActivateRemoteRounds(bool bDoNoDamage)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bDoNoDamage;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[85793], params.ptr, cast(void*)0);
	}
	final void HideArmTimer()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[85797], cast(void*)0, cast(void*)0);
	}
	final void Destroyed()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[85798], cast(void*)0, cast(void*)0);
	}
	final void OnRemoteProjectileDestroyedByOther(TrProjectile DestroyedProjectile)
	{
		ubyte params[4];
		params[] = 0;
		*cast(TrProjectile*)params.ptr = DestroyedProjectile;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[85809], params.ptr, cast(void*)0);
	}
	final void OnAnimPlay(AnimNodeSequence SeqNode)
	{
		ubyte params[4];
		params[] = 0;
		*cast(AnimNodeSequence*)params.ptr = SeqNode;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[85814], params.ptr, cast(void*)0);
	}
	final void OnAnimEnd(AnimNodeSequence SeqNode, float PlayedTime, float ExcessTime)
	{
		ubyte params[12];
		params[] = 0;
		*cast(AnimNodeSequence*)params.ptr = SeqNode;
		*cast(float*)&params[4] = PlayedTime;
		*cast(float*)&params[8] = ExcessTime;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[85816], params.ptr, cast(void*)0);
	}
	final void OnPlayRetrieveAnim()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[85820], cast(void*)0, cast(void*)0);
	}
	final void PlayWeaponEquip()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[85821], cast(void*)0, cast(void*)0);
	}
	final void PlayWeaponPutDown()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[85822], cast(void*)0, cast(void*)0);
	}
	final void PutDownFast()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[85823], cast(void*)0, cast(void*)0);
	}
	final void OnSwitchAwayFromWeapon()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[85824], cast(void*)0, cast(void*)0);
	}
}
