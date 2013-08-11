module UnrealScript.Engine.SeqVar_RandomInt;

import UnrealScript.Engine.SeqVar_Int;

extern(C++) interface SeqVar_RandomInt : SeqVar_Int
{
	public @property final auto ref int Max() { return *cast(int*)(cast(size_t)cast(void*)this + 156); }
	public @property final auto ref int Min() { return *cast(int*)(cast(size_t)cast(void*)this + 152); }
}
