(*================*)
(*  ParallelGrid  *)
(*================*)

IncludeHeader@"RaggedBlock";

ParallelGrid[Expr_]:=Quiet@Check[(RaggedBlock[#,Ceiling@(Sqrt@Length@#)]&@Flatten@{Expr}),Null];
