(*=============*)
(*  VimFormat  *)
(*=============*)

Comment[Expr_?StringQ]:=Module[{},
	Print@Style[Expr,Blue]];

Title[Expr_?StringQ]:=Module[{},
	Print@Style[Expr,24,Blue]];

