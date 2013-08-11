module UnrealScript.Engine.SeqAct_WaitForLevelsVisible;

import ScriptClasses;
import UnrealScript.Engine.SeqAct_Latent;

extern(C++) interface SeqAct_WaitForLevelsVisible : SeqAct_Latent
{
	public @property final auto ref ScriptArray!(ScriptName) LevelNames() { return *cast(ScriptArray!(ScriptName)*)(cast(size_t)cast(void*)this + 248); }
	public @property final bool bShouldBlockOnLoad() { return (*cast(uint*)(cast(size_t)cast(void*)this + 260) & 0x1) != 0; }
	public @property final bool bShouldBlockOnLoad(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 260) |= 0x1; } else { *cast(uint*)(cast(size_t)cast(void*)this + 260) &= ~0x1; } return val; }
}
