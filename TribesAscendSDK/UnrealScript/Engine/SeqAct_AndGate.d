module UnrealScript.Engine.SeqAct_AndGate;

import ScriptClasses;
import UnrealScript.Core.UObject;
import UnrealScript.Engine.SequenceAction;

extern(C++) interface SeqAct_AndGate : SequenceAction
{
	public @property final auto ref ScriptArray!(bool) LinkedOutputFiredStatus() { return *cast(ScriptArray!(bool)*)(cast(size_t)cast(void*)this + 236); }
	public @property final auto ref ScriptArray!(UObject.Pointer) LinkedOutputs() { return *cast(ScriptArray!(UObject.Pointer)*)(cast(size_t)cast(void*)this + 248); }
	public @property final bool bOpen() { return (*cast(uint*)(cast(size_t)cast(void*)this + 232) & 0x1) != 0; }
	public @property final bool bOpen(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 232) |= 0x1; } else { *cast(uint*)(cast(size_t)cast(void*)this + 232) &= ~0x1; } return val; }
}
