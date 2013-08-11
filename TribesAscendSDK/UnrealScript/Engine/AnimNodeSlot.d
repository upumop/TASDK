module UnrealScript.Engine.AnimNodeSlot;

import ScriptClasses;
import UnrealScript.Engine.AnimNodeSequence;
import UnrealScript.Engine.AnimNodeSynch;
import UnrealScript.Engine.AnimNodeBlendBase;

extern(C++) interface AnimNodeSlot : AnimNodeBlendBase
{
	public @property final auto ref ScriptArray!(float) TargetWeight() { return *cast(ScriptArray!(float)*)(cast(size_t)cast(void*)this + 260); }
	public @property final auto ref AnimNodeSynch SynchNode() { return *cast(AnimNodeSynch*)(cast(size_t)cast(void*)this + 276); }
	public @property final auto ref float BlendTimeToGo() { return *cast(float*)(cast(size_t)cast(void*)this + 272); }
	public @property final auto ref int TargetChildIndex() { return *cast(int*)(cast(size_t)cast(void*)this + 256); }
	public @property final auto ref int CustomChildIndex() { return *cast(int*)(cast(size_t)cast(void*)this + 252); }
	public @property final auto ref float PendingBlendOutTime() { return *cast(float*)(cast(size_t)cast(void*)this + 248); }
	public @property final bool bAdditiveAnimationsOverrideSource() { return (*cast(uint*)(cast(size_t)cast(void*)this + 244) & 0x8) != 0; }
	public @property final bool bAdditiveAnimationsOverrideSource(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 244) |= 0x8; } else { *cast(uint*)(cast(size_t)cast(void*)this + 244) &= ~0x8; } return val; }
	public @property final bool bSkipBlendWhenNotRendered() { return (*cast(uint*)(cast(size_t)cast(void*)this + 244) & 0x4) != 0; }
	public @property final bool bSkipBlendWhenNotRendered(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 244) |= 0x4; } else { *cast(uint*)(cast(size_t)cast(void*)this + 244) &= ~0x4; } return val; }
	public @property final bool bEarlyAnimEndNotify() { return (*cast(uint*)(cast(size_t)cast(void*)this + 244) & 0x2) != 0; }
	public @property final bool bEarlyAnimEndNotify(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 244) |= 0x2; } else { *cast(uint*)(cast(size_t)cast(void*)this + 244) &= ~0x2; } return val; }
	public @property final bool bIsPlayingCustomAnim() { return (*cast(uint*)(cast(size_t)cast(void*)this + 244) & 0x1) != 0; }
	public @property final bool bIsPlayingCustomAnim(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 244) |= 0x1; } else { *cast(uint*)(cast(size_t)cast(void*)this + 244) &= ~0x1; } return val; }
	final float PlayCustomAnim(ScriptName AnimName, float Rate, float BlendInTime, float BlendOutTime, bool bLooping, bool bOverride, float StartTime, float EndTime)
	{
		ubyte params[40];
		params[] = 0;
		*cast(ScriptName*)params.ptr = AnimName;
		*cast(float*)&params[8] = Rate;
		*cast(float*)&params[12] = BlendInTime;
		*cast(float*)&params[16] = BlendOutTime;
		*cast(bool*)&params[20] = bLooping;
		*cast(bool*)&params[24] = bOverride;
		*cast(float*)&params[28] = StartTime;
		*cast(float*)&params[32] = EndTime;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[11062], params.ptr, cast(void*)0);
		return *cast(float*)&params[36];
	}
	final bool PlayCustomAnimByDuration(ScriptName AnimName, float Duration, float BlendInTime, float BlendOutTime, bool bLooping, bool bOverride)
	{
		ubyte params[32];
		params[] = 0;
		*cast(ScriptName*)params.ptr = AnimName;
		*cast(float*)&params[8] = Duration;
		*cast(float*)&params[12] = BlendInTime;
		*cast(float*)&params[16] = BlendOutTime;
		*cast(bool*)&params[20] = bLooping;
		*cast(bool*)&params[24] = bOverride;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[11072], params.ptr, cast(void*)0);
		return *cast(bool*)&params[28];
	}
	final ScriptName GetPlayedAnimation()
	{
		ubyte params[8];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[11080], params.ptr, cast(void*)0);
		return *cast(ScriptName*)params.ptr;
	}
	final void StopCustomAnim(float BlendOutTime)
	{
		ubyte params[4];
		params[] = 0;
		*cast(float*)params.ptr = BlendOutTime;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[11082], params.ptr, cast(void*)0);
	}
	final void SetCustomAnim(ScriptName AnimName)
	{
		ubyte params[8];
		params[] = 0;
		*cast(ScriptName*)params.ptr = AnimName;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[11084], params.ptr, cast(void*)0);
	}
	final void SetActorAnimEndNotification(bool bNewStatus)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bNewStatus;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[11086], params.ptr, cast(void*)0);
	}
	final AnimNodeSequence GetCustomAnimNodeSeq()
	{
		ubyte params[4];
		params[] = 0;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[11088], params.ptr, cast(void*)0);
		return *cast(AnimNodeSequence*)params.ptr;
	}
	final void SetRootBoneAxisOption(AnimNodeSequence.ERootBoneAxis AxisX, AnimNodeSequence.ERootBoneAxis AxisY, AnimNodeSequence.ERootBoneAxis AxisZ)
	{
		ubyte params[3];
		params[] = 0;
		*cast(AnimNodeSequence.ERootBoneAxis*)params.ptr = AxisX;
		*cast(AnimNodeSequence.ERootBoneAxis*)&params[1] = AxisY;
		*cast(AnimNodeSequence.ERootBoneAxis*)&params[2] = AxisZ;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[11090], params.ptr, cast(void*)0);
	}
	final void SetRootBoneRotationOption(AnimNodeSequence.ERootRotationOption AxisX, AnimNodeSequence.ERootRotationOption AxisY, AnimNodeSequence.ERootRotationOption AxisZ)
	{
		ubyte params[3];
		params[] = 0;
		*cast(AnimNodeSequence.ERootRotationOption*)params.ptr = AxisX;
		*cast(AnimNodeSequence.ERootRotationOption*)&params[1] = AxisY;
		*cast(AnimNodeSequence.ERootRotationOption*)&params[2] = AxisZ;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[11094], params.ptr, cast(void*)0);
	}
	final void AddToSynchGroup(ScriptName GroupName)
	{
		ubyte params[8];
		params[] = 0;
		*cast(ScriptName*)params.ptr = GroupName;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[11098], params.ptr, cast(void*)0);
	}
}
