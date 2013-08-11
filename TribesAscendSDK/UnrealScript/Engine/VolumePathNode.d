module UnrealScript.Engine.VolumePathNode;

import UnrealScript.Engine.PathNode;

extern(C++) interface VolumePathNode : PathNode
{
	public @property final auto ref float StartingHeight() { return *cast(float*)(cast(size_t)cast(void*)this + 696); }
	public @property final auto ref float StartingRadius() { return *cast(float*)(cast(size_t)cast(void*)this + 692); }
}
