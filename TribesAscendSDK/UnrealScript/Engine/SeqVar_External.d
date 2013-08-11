module UnrealScript.Engine.SeqVar_External;

import ScriptClasses;
import UnrealScript.Engine.SequenceVariable;

extern(C++) interface SeqVar_External : SequenceVariable
{
	public @property final auto ref ScriptString VariableLabel() { return *cast(ScriptString*)(cast(size_t)cast(void*)this + 152); }
	public @property final auto ref ScriptClass ExpectedType() { return *cast(ScriptClass*)(cast(size_t)cast(void*)this + 148); }
}
