module UnrealScript.TribesGame.TrPaperDoll;

import ScriptClasses;
import UnrealScript.TribesGame.TrObject;
import UnrealScript.Engine.MaterialInstanceConstant;
import UnrealScript.Engine.AnimNodeSequence;
import UnrealScript.Engine.SkeletalMeshActorMAT;
import UnrealScript.Engine.AnimNodePlayCustomAnim;
import UnrealScript.TribesGame.TrPlayerController;
import UnrealScript.Engine.SkeletalMesh;

extern(C++) interface TrPaperDoll : SkeletalMeshActorMAT
{
	public @property final auto ref ScriptClass m_LastFamilyClassRequest() { return *cast(ScriptClass*)(cast(size_t)cast(void*)this + 776); }
	public @property final auto ref ScriptClass m_LastDeviceOnlyRequest() { return *cast(ScriptClass*)(cast(size_t)cast(void*)this + 772); }
	public @property final auto ref TrPlayerController m_TrPlayerController() { return *cast(TrPlayerController*)(cast(size_t)cast(void*)this + 760); }
	public @property final auto ref ScriptClass m_LastDeviceClassRequest() { return *cast(ScriptClass*)(cast(size_t)cast(void*)this + 768); }
	public @property final auto ref ScriptArray!(
// ERROR: Unknown object class 'Class Core.ComponentProperty'~
void*) m_Lights() { return *cast(ScriptArray!(
// ERROR: Unknown object class 'Class Core.ComponentProperty'~
void*)*)(cast(size_t)cast(void*)this + 548); }
	public @property final auto ref ScriptClass m_DeviceContentDataClass() { return *cast(ScriptClass*)(cast(size_t)cast(void*)this + 904); }
	public @property final auto ref float m_fLastStreamingCheckTimestamp() { return *cast(float*)(cast(size_t)cast(void*)this + 900); }
	public @property final auto ref float m_fCheckStreamingFrequency() { return *cast(float*)(cast(size_t)cast(void*)this + 896); }
	public @property final auto ref TrObject.PaperDollInfo m_PendingPaperDollInfoSkin() { return *cast(TrObject.PaperDollInfo*)(cast(size_t)cast(void*)this + 840); }
	public @property final auto ref TrObject.PaperDollInfo m_PendingPaperDollInfoDevice() { return *cast(TrObject.PaperDollInfo*)(cast(size_t)cast(void*)this + 784); }
	public @property final auto ref int m_LastSkinIdRequest() { return *cast(int*)(cast(size_t)cast(void*)this + 780); }
	public @property final bool m_bWasLastMeshSwapRequestNonWeapon() { return (*cast(uint*)(cast(size_t)cast(void*)this + 764) & 0x1) != 0; }
	public @property final bool m_bWasLastMeshSwapRequestNonWeapon(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 764) |= 0x1; } else { *cast(uint*)(cast(size_t)cast(void*)this + 764) &= ~0x1; } return val; }
	public @property final auto ref TrObject.PaperDollInfo m_CurrentPaperDollInfo() { return *cast(TrObject.PaperDollInfo*)(cast(size_t)cast(void*)this + 704); }
	public @property final auto ref float m_fMaxCustomAnimTime() { return *cast(float*)(cast(size_t)cast(void*)this + 700); }
	public @property final auto ref float m_fMinCustomAnimTime() { return *cast(float*)(cast(size_t)cast(void*)this + 696); }
	public @property final auto ref AnimNodePlayCustomAnim m_SidekickCustomAnimNode() { return *cast(AnimNodePlayCustomAnim*)(cast(size_t)cast(void*)this + 692); }
	public @property final auto ref AnimNodePlayCustomAnim m_CharacterCustomAnimNode() { return *cast(AnimNodePlayCustomAnim*)(cast(size_t)cast(void*)this + 688); }
	public @property final auto ref Vector m_vOffsetHeavy() { return *cast(Vector*)(cast(size_t)cast(void*)this + 676); }
	public @property final auto ref Vector m_vOffsetMedium() { return *cast(Vector*)(cast(size_t)cast(void*)this + 664); }
	public @property final auto ref Vector m_vOffsetLight() { return *cast(Vector*)(cast(size_t)cast(void*)this + 652); }
	public @property final auto ref Vector m_vBackdropOffset() { return *cast(Vector*)(cast(size_t)cast(void*)this + 640); }
	public @property final auto ref float m_fBackdropScale16x10() { return *cast(float*)(cast(size_t)cast(void*)this + 636); }
	public @property final auto ref float m_fBackdropScale16x9() { return *cast(float*)(cast(size_t)cast(void*)this + 632); }
	public @property final auto ref float m_fBackdropScale4x3() { return *cast(float*)(cast(size_t)cast(void*)this + 628); }
	public @property final auto ref MaterialInstanceConstant m_DiamondSwordBackdropMaterial() { return *cast(MaterialInstanceConstant*)(cast(size_t)cast(void*)this + 624); }
	public @property final auto ref MaterialInstanceConstant m_BloodEagleBackdropMaterial() { return *cast(MaterialInstanceConstant*)(cast(size_t)cast(void*)this + 620); }
	public @property final auto ref ScriptClass m_TrDeviceClass() { return *cast(ScriptClass*)(cast(size_t)cast(void*)this + 600); }
	public @property final auto ref ScriptClass m_FamilyInfoClass() { return *cast(ScriptClass*)(cast(size_t)cast(void*)this + 596); }
	public @property final auto ref Vector m_vViewOffset16x10() { return *cast(Vector*)(cast(size_t)cast(void*)this + 584); }
	public @property final auto ref Vector m_vViewOffset16x9() { return *cast(Vector*)(cast(size_t)cast(void*)this + 572); }
	public @property final auto ref Vector m_vViewOffset4x3() { return *cast(Vector*)(cast(size_t)cast(void*)this + 560); }
	final bool IsFullyStreamed(TrObject.PaperDollInfo PaperDoll)
	{
		ubyte params[60];
		params[] = 0;
		*cast(TrObject.PaperDollInfo*)params.ptr = PaperDoll;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[100424], params.ptr, cast(void*)0);
		return *cast(bool*)&params[56];
	}
	final void PostBeginPlay()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[100427], cast(void*)0, cast(void*)0);
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
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[100429], params.ptr, cast(void*)0);
	}
	final SkeletalMesh GetCharacterSkeletalMesh(ScriptClass FamilyInfoClass, ubyte TeamNum)
	{
		ubyte params[9];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = FamilyInfoClass;
		params[4] = TeamNum;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[100432], params.ptr, cast(void*)0);
		return *cast(SkeletalMesh*)&params[8];
	}
	final void OnCharacterMeshContentDataClassLoaded(ScriptClass Skin3PDataClass)
	{
		ubyte params[4];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = Skin3PDataClass;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[100438], params.ptr, cast(void*)0);
	}
	final void OnSkeletalMeshFinishedStreaming(SkeletalMesh NewSkelMesh)
	{
		ubyte params[4];
		params[] = 0;
		*cast(SkeletalMesh*)params.ptr = NewSkelMesh;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[100442], params.ptr, cast(void*)0);
	}
	final void TryUpdatingPaperDoll()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[100444], cast(void*)0, cast(void*)0);
	}
	final void SetFamilyInfo(ScriptClass NewFamilyInfoClass, ScriptClass DeviceClass, ScriptClass skinClass, int TeamNum)
	{
		ubyte params[16];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = NewFamilyInfoClass;
		*cast(ScriptClass*)&params[4] = DeviceClass;
		*cast(ScriptClass*)&params[8] = skinClass;
		*cast(int*)&params[12] = TeamNum;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[100447], params.ptr, cast(void*)0);
	}
	final void PlayCustomAnimation()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[100453], cast(void*)0, cast(void*)0);
	}
	final void StopCustomAnimation(float FadeOutTime)
	{
		ubyte params[4];
		params[] = 0;
		*cast(float*)params.ptr = FadeOutTime;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[100454], params.ptr, cast(void*)0);
	}
	final void ResetCustomAnimTimer()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[100456], cast(void*)0, cast(void*)0);
	}
	final void OnAnimEnd(AnimNodeSequence SeqNode, float PlayedTime, float ExcessTime)
	{
		ubyte params[12];
		params[] = 0;
		*cast(AnimNodeSequence*)params.ptr = SeqNode;
		*cast(float*)&params[4] = PlayedTime;
		*cast(float*)&params[8] = ExcessTime;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[100457], params.ptr, cast(void*)0);
	}
	final void OnDeviceContentDataClassLoaded(ScriptClass DeviceContentDataClass)
	{
		ubyte params[4];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = DeviceContentDataClass;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[100461], params.ptr, cast(void*)0);
	}
	final void PlayLoadingGraphic()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[100467], cast(void*)0, cast(void*)0);
	}
	final void StopLoadingGraphic()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[100468], cast(void*)0, cast(void*)0);
	}
	final void OnWeaponFinishedStreaming(TrObject.PaperDollInfo NewPaperDollInfo)
	{
		ubyte params[56];
		params[] = 0;
		*cast(TrObject.PaperDollInfo*)params.ptr = NewPaperDollInfo;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[100469], params.ptr, cast(void*)0);
	}
	final void SetWeaponOnlyMesh(ScriptClass WeaponClass)
	{
		ubyte params[4];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = WeaponClass;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[100471], params.ptr, cast(void*)0);
	}
	final TrObject.PaperDollInfo GetDevicePaperDollInfo(ScriptClass WeaponClass)
	{
		ubyte params[60];
		params[] = 0;
		*cast(ScriptClass*)params.ptr = WeaponClass;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[100473], params.ptr, cast(void*)0);
		return *cast(TrObject.PaperDollInfo*)&params[4];
	}
	final void SetMainMesh(TrObject.PaperDollInfo NewInfo)
	{
		ubyte params[56];
		params[] = 0;
		*cast(TrObject.PaperDollInfo*)params.ptr = NewInfo;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[100476], params.ptr, cast(void*)0);
	}
	final void Destroyed()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[100481], cast(void*)0, cast(void*)0);
	}
}
