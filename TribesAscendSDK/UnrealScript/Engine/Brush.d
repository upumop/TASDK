module UnrealScript.Engine.Brush;

import ScriptClasses;
import UnrealScript.Engine.Actor;
import UnrealScript.Engine.Model;
import UnrealScript.Core.UObject;

extern(C++) interface Brush : Actor
{
	enum ECsgOper : ubyte
	{
		CSG_Active = 0,
		CSG_Add = 1,
		CSG_Subtract = 2,
		CSG_Intersect = 3,
		CSG_Deintersect = 4,
		CSG_MAX = 5,
	}
	struct GeomSelection
	{
		public @property final auto ref int SelectionIndex() { return *cast(int*)(cast(size_t)&this + 8); }
		private ubyte __SelectionIndex[4];
		public @property final auto ref int Index() { return *cast(int*)(cast(size_t)&this + 4); }
		private ubyte __Index[4];
		public @property final auto ref int Type() { return *cast(int*)(cast(size_t)&this + 0); }
		private ubyte __Type[4];
	}
	public @property final auto ref ScriptArray!(Brush.GeomSelection) SavedSelections() { return *cast(ScriptArray!(Brush.GeomSelection)*)(cast(size_t)cast(void*)this + 500); }
	// WARNING: Property 'Brush' has the same name as a defined type!
	public @property final bool bPlaceableFromClassBrowser() { return (*cast(uint*)(cast(size_t)cast(void*)this + 488) & 0x4) != 0; }
	public @property final bool bPlaceableFromClassBrowser(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 488) |= 0x4; } else { *cast(uint*)(cast(size_t)cast(void*)this + 488) &= ~0x4; } return val; }
	public @property final bool bSolidWhenSelected() { return (*cast(uint*)(cast(size_t)cast(void*)this + 488) & 0x2) != 0; }
	public @property final bool bSolidWhenSelected(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 488) |= 0x2; } else { *cast(uint*)(cast(size_t)cast(void*)this + 488) &= ~0x2; } return val; }
	public @property final bool bColored() { return (*cast(uint*)(cast(size_t)cast(void*)this + 488) & 0x1) != 0; }
	public @property final bool bColored(bool val) { if (val) { *cast(uint*)(cast(size_t)cast(void*)this + 488) |= 0x1; } else { *cast(uint*)(cast(size_t)cast(void*)this + 488) &= ~0x1; } return val; }
	public @property final auto ref int PolyFlags() { return *cast(int*)(cast(size_t)cast(void*)this + 484); }
	public @property final auto ref UObject.Color BrushColor() { return *cast(UObject.Color*)(cast(size_t)cast(void*)this + 480); }
	public @property final auto ref Brush.ECsgOper CsgOper() { return *cast(Brush.ECsgOper*)(cast(size_t)cast(void*)this + 476); }
}