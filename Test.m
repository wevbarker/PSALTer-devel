<<xAct`xPlain`;

Comment@"Now we will try to look for new solutions to the vector system.";

Expr=<|Field1-><|0-><|Even->{},Odd->{x}|>|>,Field2-><|0-><|Even->{},Odd->{z}|>,2-><|Even->{y},Odd->{}|>|>|>

DisplayExpression@Expr;

DefPlaceholderSpins[InputExpr_]:=Module[{
	PlaceholderSpin=<|Even->{},Odd->{}|>,
	Fields,
	Spins,
	Expr=InputExpr},

	Fields=Keys@Expr;
	Spins=Keys@((Expr/@Keys@Expr)~Merge~Total);
	Table[Print[Spin,Field,Keys@Expr@Field]If[!((Keys@Expr@Field)~MemberQ~Spin),Print[Spin,Field];(Expr@Field)@Spin=PlaceholderSpin],
		{Spin,Spins},{Field,Fields}];	
Expr];

Expr//=DefPlaceholderSpins;
DisplayExpression@Expr;

Quit[];
