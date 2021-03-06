module UnrealScript.Engine.ParticleModuleCollisionBase;

import ScriptClasses;
import UnrealScript.Helpers;
import UnrealScript.Engine.ParticleModule;

extern(C++) interface ParticleModuleCollisionBase : ParticleModule
{
public extern(D):
	private static __gshared ScriptClass mStaticClass;
	@property final static ScriptClass StaticClass() { mixin(MGSCC("Class Engine.ParticleModuleCollisionBase")); }
	private static __gshared ParticleModuleCollisionBase mDefaultProperties;
	@property final static ParticleModuleCollisionBase DefaultProperties() { mixin(MGDPC("ParticleModuleCollisionBase", "ParticleModuleCollisionBase Engine.Default__ParticleModuleCollisionBase")); }
	enum EParticleCollisionComplete : ubyte
	{
		EPCC_Kill = 0,
		EPCC_Freeze = 1,
		EPCC_HaltCollisions = 2,
		EPCC_FreezeTranslation = 3,
		EPCC_FreezeRotation = 4,
		EPCC_FreezeMovement = 5,
		EPCC_MAX = 6,
	}
}
