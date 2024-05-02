(*=======================*)
(*  DefPlaceholderSpins  *)
(*=======================*)

DefPlaceholderSpins[InputExpr_]:=Module[{
	PlaceholderSpin=<|Even->{},Odd->{}|>,
	Fields,
	Spins,
	Expr=InputExpr},

	Fields=Keys@Expr;
	Spins=Keys@((Expr/@Keys@Expr)~Merge~Total);
	Table[If[!((Keys@Expr@Field)~MemberQ~Spin),(Expr@Field)@Spin=PlaceholderSpin],
		{Spin,Spins},{Field,Fields}];	
Expr];
