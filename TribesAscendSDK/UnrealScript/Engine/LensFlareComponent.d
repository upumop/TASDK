module UnrealScript.Engine.LensFlareComponent;

import ScriptClasses;
import UnrealScript.Engine.LensFlare;
import UnrealScript.Core.UObject;
import UnrealScript.Engine.PrimitiveComponent;
import UnrealScript.Engine.MaterialInterface;

extern(C++) interface LensFlareComponent : PrimitiveComponent
{
	struct LensFlareElementMaterials
	{
		public @property final auto ref ScriptArray!(MaterialInterface) ElementMaterials() { return *cast(ScriptArray!(MaterialInterface)*)(cast(size_t)&this + 0); }
		private ubyte __ElementMaterials[12];
	}
	struct LensFlareElementInstance
	{
	}
	public @property final auto ref ScriptArray!(LensFlareComponent.LensFlareElementMaterials) Materials() { return *cast(ScriptArray!(LensFlareComponent.LensFlareElementMaterials)*)(cast(size_t)cast(void*)this + 540); }
	public @property final auto ref float NextTraceTime() { return *cast(float*)(cast(size_t)cast(void*)this + 556); }
	public @property final auto ref UObject.Pointer ReleaseResourcesFence() { return *cast(UObject.Pointer*)(cast(size_t)cast(void*)this + 552); }
	public @property final auto ref UObject.LinearColor SourceColor() { return *cast(UObject.LinearColor*)(cast(size_t)cast(void*)this + 524); }
	public @property final auto ref float Radius() { return *cast(float*)(cast(size_t)cast(void*)this + 520); }
	public @property final auto ref float ConeFudgeFactor() { return *cast(float*)(cast(size_t)cast(void*)this + 516); }
	public @property final auto ref float InnerCone() { return *cast(float*)(cast(size_t)cast(void*)this + 512); }
	public @property final auto ref float OuterCone() { return *cast(float*)(cast(size_t)cast(void*)this + 508); }
	public @property final bool bVisibleForMobile() { return (*cast(uint*)(cast(size_t)cast(void*)this + 504) & 0x40) != 0; }
	public @property final bool bVisibleForMobile(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 504) |= 0x40; } else { *cast(uint*)(cast(size_t)cast(void*)this + 504) &= ~0x40; } return val; }
	public @property final bool bUsesSceneColor() { return (*cast(uint*)(cast(size_t)cast(void*)this + 504) & 0x20) != 0; }
	public @property final bool bUsesSceneColor(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 504) |= 0x20; } else { *cast(uint*)(cast(size_t)cast(void*)this + 504) &= ~0x20; } return val; }
	public @property final bool bHasUnlitDistortion() { return (*cast(uint*)(cast(size_t)cast(void*)this + 504) & 0x10) != 0; }
	public @property final bool bHasUnlitDistortion(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 504) |= 0x10; } else { *cast(uint*)(cast(size_t)cast(void*)this + 504) &= ~0x10; } return val; }
	public @property final bool bHasUnlitTranslucency() { return (*cast(uint*)(cast(size_t)cast(void*)this + 504) & 0x8) != 0; }
	public @property final bool bHasUnlitTranslucency(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 504) |= 0x8; } else { *cast(uint*)(cast(size_t)cast(void*)this + 504) &= ~0x8; } return val; }
	public @property final bool bHasTranslucency() { return (*cast(uint*)(cast(size_t)cast(void*)this + 504) & 0x4) != 0; }
	public @property final bool bHasTranslucency(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 504) |= 0x4; } else { *cast(uint*)(cast(size_t)cast(void*)this + 504) &= ~0x4; } return val; }
	public @property final bool bIsActive() { return (*cast(uint*)(cast(size_t)cast(void*)this + 504) & 0x2) != 0; }
	public @property final bool bIsActive(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 504) |= 0x2; } else { *cast(uint*)(cast(size_t)cast(void*)this + 504) &= ~0x2; } return val; }
	public @property final bool bAutoActivate() { return (*cast(uint*)(cast(size_t)cast(void*)this + 504) & 0x1) != 0; }
	public @property final bool bAutoActivate(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 504) |= 0x1; } else { *cast(uint*)(cast(size_t)cast(void*)this + 504) &= ~0x1; } return val; }
	public @property final auto ref LensFlare Template() { return *cast(LensFlare*)(cast(size_t)cast(void*)this + 488); }
	final void SetTemplate(LensFlare NewTemplate, bool bForceSet)
	{
		ubyte params[8];
		params[] = 0;
		*cast(LensFlare*)params.ptr = NewTemplate;
		*cast(bool*)&params[4] = bForceSet;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[19314], params.ptr, cast(void*)0);
	}
	final void SetSourceColor(UObject.LinearColor InSourceColor)
	{
		ubyte params[16];
		params[] = 0;
		*cast(UObject.LinearColor*)params.ptr = InSourceColor;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[19317], params.ptr, cast(void*)0);
	}
	final void SetIsActive(bool bInIsActive)
	{
		ubyte params[4];
		params[] = 0;
		*cast(bool*)params.ptr = bInIsActive;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[19319], params.ptr, cast(void*)0);
	}
}
