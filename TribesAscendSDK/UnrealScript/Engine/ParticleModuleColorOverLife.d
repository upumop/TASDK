module UnrealScript.Engine.ParticleModuleColorOverLife;

import UnrealScript.Core.DistributionFloat;
import UnrealScript.Engine.ParticleModuleColorBase;
import UnrealScript.Core.DistributionVector;

extern(C++) interface ParticleModuleColorOverLife : ParticleModuleColorBase
{
	public @property final bool bClampAlpha() { return (*cast(uint*)(cast(size_t)cast(void*)this + 128) & 0x1) != 0; }
	public @property final bool bClampAlpha(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 128) |= 0x1; } else { *cast(uint*)(cast(size_t)cast(void*)this + 128) &= ~0x1; } return val; }
	public @property final auto ref DistributionFloat.RawDistributionFloat AlphaOverLife() { return *cast(DistributionFloat.RawDistributionFloat*)(cast(size_t)cast(void*)this + 100); }
	public @property final auto ref DistributionVector.RawDistributionVector ColorOverLife() { return *cast(DistributionVector.RawDistributionVector*)(cast(size_t)cast(void*)this + 72); }
}
