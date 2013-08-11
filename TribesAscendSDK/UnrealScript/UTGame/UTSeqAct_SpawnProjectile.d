module UnrealScript.UTGame.UTSeqAct_SpawnProjectile;

import ScriptClasses;
import UnrealScript.Engine.SequenceAction;

extern(C++) interface UTSeqAct_SpawnProjectile : SequenceAction
{
	public @property final auto ref ScriptClass ProjectileClass() { return *cast(ScriptClass*)(cast(size_t)cast(void*)this + 232); }
	final void Activated()
	{
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[49146], cast(void*)0, cast(void*)0);
	}
}
