module UnrealScript.Engine.AudioDevice;

import ScriptClasses;
import UnrealScript.Core.Subsystem;
import UnrealScript.Engine.ReverbVolume;
import UnrealScript.Core.UObject;
import UnrealScript.Engine.SoundClass;
import UnrealScript.Engine.PortalVolume;
import UnrealScript.Engine.SoundMode;
import UnrealScript.Engine.SoundNodeWave;

extern(C++) interface AudioDevice : Subsystem
{
	enum EDebugState : ubyte
	{
		DEBUGSTATE_None = 0,
		DEBUGSTATE_IsolateDryAudio = 1,
		DEBUGSTATE_IsolateReverb = 2,
		DEBUGSTATE_TestLPF = 3,
		DEBUGSTATE_TestStereoBleed = 4,
		DEBUGSTATE_TestLFEBleed = 5,
		DEBUGSTATE_DisableLPF = 6,
		DEBUGSTATE_DisableRadio = 7,
		DEBUGSTATE_MAX = 8,
	}
	enum ESoundClassName : ubyte
	{
		World_Props = 0,
		WeaponFoley = 1,
		WeaponFire = 2,
		WeaponExplosion = 3,
		Weapon = 4,
		VoxRadio = 5,
		VoxIngame = 6,
		VoxHelp = 7,
		VoxExceptions = 8,
		VoxAnnouncer = 9,
		Vox2 = 10,
		VOX = 11,
		Vehicle = 12,
		UI = 13,
		Tutorial_VOX_Reverb = 14,
		Tutorial_SFX_Reverb = 15,
		SFXExceptions = 16,
		SFX = 17,
		Music = 18,
		Master = 19,
		Concussion = 20,
		Character = 21,
		Ambient = 22,
		ESoundClassName_MAX = 23,
	}
	enum ETTSSpeaker : ubyte
	{
		TTSSPEAKER_Paul = 0,
		TTSSPEAKER_Harry = 1,
		TTSSPEAKER_Frank = 2,
		TTSSPEAKER_Dennis = 3,
		TTSSPEAKER_Kit = 4,
		TTSSPEAKER_Betty = 5,
		TTSSPEAKER_Ursula = 6,
		TTSSPEAKER_Rita = 7,
		TTSSPEAKER_Wendy = 8,
		TTSSPEAKER_MAX = 9,
	}
	struct Listener
	{
		public @property final auto ref Vector Front() { return *cast(Vector*)(cast(size_t)&this + 40); }
		private ubyte __Front[12];
		public @property final auto ref Vector Right() { return *cast(Vector*)(cast(size_t)&this + 28); }
		private ubyte __Right[12];
		public @property final auto ref Vector Up() { return *cast(Vector*)(cast(size_t)&this + 16); }
		private ubyte __Up[12];
		public @property final auto ref Vector Location() { return *cast(Vector*)(cast(size_t)&this + 4); }
		private ubyte __Location[12];
		// WARNING: Property 'PortalVolume' has the same name as a defined type!
	}
	struct AudioClassInfo
	{
		public @property final auto ref int SizeRealTime() { return *cast(int*)(cast(size_t)&this + 12); }
		private ubyte __SizeRealTime[4];
		public @property final auto ref int NumRealTime() { return *cast(int*)(cast(size_t)&this + 8); }
		private ubyte __NumRealTime[4];
		public @property final auto ref int SizeResident() { return *cast(int*)(cast(size_t)&this + 4); }
		private ubyte __SizeResident[4];
		public @property final auto ref int NumResident() { return *cast(int*)(cast(size_t)&this + 0); }
		private ubyte __NumResident[4];
	}
	public @property final auto ref ScriptArray!(
// ERROR: Unknown object class 'Class Core.ComponentProperty'~
void*) AudioComponents() { return *cast(ScriptArray!(
// ERROR: Unknown object class 'Class Core.ComponentProperty'~
void*)*)(cast(size_t)cast(void*)this + 128); }
	public @property final auto ref ScriptArray!(UObject.Pointer) Sources() { return *cast(ScriptArray!(UObject.Pointer)*)(cast(size_t)cast(void*)this + 140); }
	public @property final auto ref ScriptArray!(UObject.Pointer) FreeSources() { return *cast(ScriptArray!(UObject.Pointer)*)(cast(size_t)cast(void*)this + 152); }
	public @property final auto ref ScriptArray!(AudioDevice.Listener) Listeners() { return *cast(ScriptArray!(AudioDevice.Listener)*)(cast(size_t)cast(void*)this + 224); }
	public @property final auto ref float LastUpdateTime() { return *cast(float*)(cast(size_t)cast(void*)this + 704); }
	public @property final auto ref float TransientMasterVolume() { return *cast(float*)(cast(size_t)cast(void*)this + 700); }
	public @property final auto ref AudioDevice.EDebugState DebugState() { return *cast(AudioDevice.EDebugState*)(cast(size_t)cast(void*)this + 696); }
	public @property final auto ref UObject.Pointer TextToSpeech() { return *cast(UObject.Pointer*)(cast(size_t)cast(void*)this + 692); }
	public @property final auto ref float ExteriorLPFInterp() { return *cast(float*)(cast(size_t)cast(void*)this + 684); }
	public @property final auto ref float ExteriorVolumeInterp() { return *cast(float*)(cast(size_t)cast(void*)this + 680); }
	public @property final auto ref float InteriorLPFInterp() { return *cast(float*)(cast(size_t)cast(void*)this + 676); }
	public @property final auto ref float InteriorVolumeInterp() { return *cast(float*)(cast(size_t)cast(void*)this + 672); }
	public @property final auto ref UObject.Double ExteriorLPFEndTime() { return *cast(UObject.Double*)(cast(size_t)cast(void*)this + 664); }
	public @property final auto ref UObject.Double InteriorLPFEndTime() { return *cast(UObject.Double*)(cast(size_t)cast(void*)this + 656); }
	public @property final auto ref UObject.Double ExteriorEndTime() { return *cast(UObject.Double*)(cast(size_t)cast(void*)this + 648); }
	public @property final auto ref UObject.Double InteriorEndTime() { return *cast(UObject.Double*)(cast(size_t)cast(void*)this + 640); }
	public @property final auto ref UObject.Double InteriorStartTime() { return *cast(UObject.Double*)(cast(size_t)cast(void*)this + 632); }
	public @property final auto ref ReverbVolume.InteriorSettings ListenerInteriorSettings() { return *cast(ReverbVolume.InteriorSettings*)(cast(size_t)cast(void*)this + 596); }
	public @property final auto ref int ListenerVolumeIndex() { return *cast(int*)(cast(size_t)cast(void*)this + 592); }
	public @property final auto ref UObject.Double SoundModeEndTime() { return *cast(UObject.Double*)(cast(size_t)cast(void*)this + 584); }
	public @property final auto ref UObject.Double SoundModeFadeInEndTime() { return *cast(UObject.Double*)(cast(size_t)cast(void*)this + 576); }
	public @property final auto ref UObject.Double SoundModeFadeInStartTime() { return *cast(UObject.Double*)(cast(size_t)cast(void*)this + 568); }
	public @property final auto ref UObject.Double SoundModeStartTime() { return *cast(UObject.Double*)(cast(size_t)cast(void*)this + 560); }
	public @property final auto ref SoundMode CurrentMode() { return *cast(SoundMode*)(cast(size_t)cast(void*)this + 556); }
	public @property final auto ref ScriptName BaseSoundModeName() { return *cast(ScriptName*)(cast(size_t)cast(void*)this + 548); }
	public @property final auto ref UObject.Pointer Effects() { return *cast(UObject.Pointer*)(cast(size_t)cast(void*)this + 544); }
	public @property final auto ref QWord CurrentTick() { return *cast(QWord*)(cast(size_t)cast(void*)this + 236); }
	public @property final auto ref int CommonAudioPoolFreeBytes() { return *cast(int*)(cast(size_t)cast(void*)this + 124); }
	public @property final auto ref UObject.Pointer CommonAudioPool() { return *cast(UObject.Pointer*)(cast(size_t)cast(void*)this + 120); }
	public @property final bool bGameWasTicking() { return (*cast(uint*)(cast(size_t)cast(void*)this + 116) & 0x2) != 0; }
	public @property final bool bGameWasTicking(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 116) |= 0x2; } else { *cast(uint*)(cast(size_t)cast(void*)this + 116) &= ~0x2; } return val; }
	public @property final bool m_bEnableBassBoost() { return (*cast(uint*)(cast(size_t)cast(void*)this + 116) & 0x1) != 0; }
	public @property final bool m_bEnableBassBoost(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 116) |= 0x1; } else { *cast(uint*)(cast(size_t)cast(void*)this + 116) &= ~0x1; } return val; }
	public @property final auto ref SoundNodeWave ChirpOutSoundNodeWave() { return *cast(SoundNodeWave*)(cast(size_t)cast(void*)this + 112); }
	public @property final auto ref ScriptString ChirpOutSoundNodeWaveName() { return *cast(ScriptString*)(cast(size_t)cast(void*)this + 100); }
	public @property final auto ref SoundNodeWave ChirpInSoundNodeWave() { return *cast(SoundNodeWave*)(cast(size_t)cast(void*)this + 96); }
	public @property final auto ref ScriptString ChirpInSoundNodeWaveName() { return *cast(ScriptString*)(cast(size_t)cast(void*)this + 84); }
	public @property final auto ref float MinCompressedDurationGame() { return *cast(float*)(cast(size_t)cast(void*)this + 80); }
	public @property final auto ref float MinCompressedDurationEditor() { return *cast(float*)(cast(size_t)cast(void*)this + 76); }
	public @property final auto ref float LowPassFilterResonance() { return *cast(float*)(cast(size_t)cast(void*)this + 72); }
	public @property final auto ref int CommonAudioPoolSize() { return *cast(int*)(cast(size_t)cast(void*)this + 68); }
	public @property final auto ref int MaxChannels() { return *cast(int*)(cast(size_t)cast(void*)this + 64); }
	final bool SetSoundMode(ScriptName NewMode)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptName*)params.ptr = NewMode;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[9511], params.ptr, cast(void*)0);
		return *cast(bool*)&params[8];
	}
	final SoundClass FindSoundClass(ScriptName SoundClassName)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptName*)params.ptr = SoundClassName;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[10363], params.ptr, cast(void*)0);
		return *cast(SoundClass*)&params[8];
	}
}
