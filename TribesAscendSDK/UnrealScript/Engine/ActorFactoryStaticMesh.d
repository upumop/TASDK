module UnrealScript.Engine.ActorFactoryStaticMesh;

import ScriptClasses;
import UnrealScript.Engine.ActorFactory;
import UnrealScript.Engine.StaticMesh;

extern(C++) interface ActorFactoryStaticMesh : ActorFactory
{
	public @property final auto ref Vector DrawScale3D() { return *cast(Vector*)(cast(size_t)cast(void*)this + 96); }
	// WARNING: Property 'StaticMesh' has the same name as a defined type!
}
