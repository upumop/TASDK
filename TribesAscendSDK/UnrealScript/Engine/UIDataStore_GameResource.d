module UnrealScript.Engine.UIDataStore_GameResource;

import ScriptClasses;
import UnrealScript.Core.UObject;
import UnrealScript.Engine.UIResourceDataProvider;
import UnrealScript.Engine.UIRoot;
import UnrealScript.Engine.UIDataStore;

extern(C++) interface UIDataStore_GameResource : UIDataStore
{
	struct GameResourceDataProvider
	{
		public @property final auto ref ScriptClass ProviderClass() { return *cast(ScriptClass*)(cast(size_t)&this + 24); }
		private ubyte __ProviderClass[4];
		public @property final bool bExpandProviders() { return (*cast(uint*)(cast(size_t)&this + 20) & 0x1) != 0; }
		public @property final bool bExpandProviders(bool val) { if (val) { *cast(uint*)(cast(size_t)&this + 20) |= 0x1; } else { *cast(uint*)(cast(size_t)&this + 20) &= ~0x1; } return val; }
		private ubyte __bExpandProviders[4];
		public @property final auto ref ScriptString ProviderClassName() { return *cast(ScriptString*)(cast(size_t)&this + 8); }
		private ubyte __ProviderClassName[12];
		public @property final auto ref ScriptName ProviderTag() { return *cast(ScriptName*)(cast(size_t)&this + 0); }
		private ubyte __ProviderTag[8];
	}
	public @property final auto ref ScriptArray!(UIDataStore_GameResource.GameResourceDataProvider) ElementProviderTypes() { return *cast(ScriptArray!(UIDataStore_GameResource.GameResourceDataProvider)*)(cast(size_t)cast(void*)this + 124); }
	public @property final auto ref UObject.MultiMap_Mirror ListElementProviders() { return *cast(UObject.MultiMap_Mirror*)(cast(size_t)cast(void*)this + 136); }
	public @property final auto ref UObject.Pointer VfTable_IUIListElementProvider() { return *cast(UObject.Pointer*)(cast(size_t)cast(void*)this + 120); }
	final int FindProviderTypeIndex(ScriptName ProviderTag)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptName*)params.ptr = ProviderTag;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[28526], params.ptr, cast(void*)0);
		return *cast(int*)&params[8];
	}
	final ScriptName GenerateProviderAccessTag(int ProviderIndex, int InstanceIndex)
	{
		ubyte params[16];
		params[] = 0;
		*cast(int*)params.ptr = ProviderIndex;
		*cast(int*)&params[4] = InstanceIndex;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[28529], params.ptr, cast(void*)0);
		return *cast(ScriptName*)&params[8];
	}
	final int GetProviderCount(ScriptName ProviderTag)
	{
		ubyte params[12];
		params[] = 0;
		*cast(ScriptName*)params.ptr = ProviderTag;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[28533], params.ptr, cast(void*)0);
		return *cast(int*)&params[8];
	}
	final bool GetResourceProviders(ScriptName ProviderTag, ScriptArray!(UIResourceDataProvider)* out_Providers)
	{
		ubyte params[24];
		params[] = 0;
		*cast(ScriptName*)params.ptr = ProviderTag;
		*cast(ScriptArray!(UIResourceDataProvider)*)&params[8] = *out_Providers;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[28536], params.ptr, cast(void*)0);
		*out_Providers = *cast(ScriptArray!(UIResourceDataProvider)*)&params[8];
		return *cast(bool*)&params[20];
	}
	final bool GetResourceProviderFields(ScriptName ProviderTag, ScriptArray!(ScriptName)* ProviderFieldTags)
	{
		ubyte params[24];
		params[] = 0;
		*cast(ScriptName*)params.ptr = ProviderTag;
		*cast(ScriptArray!(ScriptName)*)&params[8] = *ProviderFieldTags;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[28541], params.ptr, cast(void*)0);
		*ProviderFieldTags = *cast(ScriptArray!(ScriptName)*)&params[8];
		return *cast(bool*)&params[20];
	}
	final bool GetProviderFieldValue(ScriptName ProviderTag, ScriptName SearchField, int ProviderIndex, UIRoot.UIProviderScriptFieldValue* out_FieldValue)
	{
		ubyte params[108];
		params[] = 0;
		*cast(ScriptName*)params.ptr = ProviderTag;
		*cast(ScriptName*)&params[8] = SearchField;
		*cast(int*)&params[16] = ProviderIndex;
		*cast(UIRoot.UIProviderScriptFieldValue*)&params[20] = *out_FieldValue;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[28546], params.ptr, cast(void*)0);
		*out_FieldValue = *cast(UIRoot.UIProviderScriptFieldValue*)&params[20];
		return *cast(bool*)&params[104];
	}
	final int FindProviderIndexByFieldValue(ScriptName ProviderTag, ScriptName SearchField, UIRoot.UIProviderScriptFieldValue* ValueToSearchFor)
	{
		ubyte params[104];
		params[] = 0;
		*cast(ScriptName*)params.ptr = ProviderTag;
		*cast(ScriptName*)&params[8] = SearchField;
		*cast(UIRoot.UIProviderScriptFieldValue*)&params[16] = *ValueToSearchFor;
		(cast(ScriptObject)this).ProcessEvent(cast(ScriptFunction)(*ScriptObject.ObjectArray)[28552], params.ptr, cast(void*)0);
		*ValueToSearchFor = *cast(UIRoot.UIProviderScriptFieldValue*)&params[16];
		return *cast(int*)&params[100];
	}
}
