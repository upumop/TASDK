module UnrealScript.Engine.MaterialExpressionSubtract;

import UnrealScript.Engine.MaterialExpression;

extern(C++) interface MaterialExpressionSubtract : MaterialExpression
{
	public @property final auto ref MaterialExpression.ExpressionInput B() { return *cast(MaterialExpression.ExpressionInput*)(cast(size_t)cast(void*)this + 136); }
	public @property final auto ref MaterialExpression.ExpressionInput A() { return *cast(MaterialExpression.ExpressionInput*)(cast(size_t)cast(void*)this + 108); }
}
