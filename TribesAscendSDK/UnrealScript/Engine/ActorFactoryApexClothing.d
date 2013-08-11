module UnrealScript.Engine.ActorFactoryApexClothing;

import ScriptClasses;
import UnrealScript.Engine.ApexClothingAsset;
import UnrealScript.Engine.PrimitiveComponent;
import UnrealScript.Engine.ActorFactorySkeletalMesh;

extern(C++) interface ActorFactoryApexClothing : ActorFactorySkeletalMesh
{
	public @property final auto ref ScriptArray!(ApexClothingAsset) ClothingAssets() { return *cast(ScriptArray!(ApexClothingAsset)*)(cast(size_t)cast(void*)this + 108); }
	public @property final auto ref PrimitiveComponent.RBCollisionChannelContainer ClothingRBCollideWithChannels() { return *cast(PrimitiveComponent.RBCollisionChannelContainer*)(cast(size_t)cast(void*)this + 124); }
	public @property final auto ref PrimitiveComponent.ERBCollisionChannel ClothingRBChannel() { return *cast(PrimitiveComponent.ERBCollisionChannel*)(cast(size_t)cast(void*)this + 120); }
}
