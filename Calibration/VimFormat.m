(*=============*)
(*  VimFormat  *)
(*=============*)

Comment[InputExpr_?StringQ]:=Module[{Expr=InputExpr},
	Print@Style[Expr,Blue]];

Title[InputExpr_?StringQ]:=Module[{Expr=InputExpr},
	Print@Style[Expr,24,Blue]];
