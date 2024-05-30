(*=========================*)
(*  PSALTerParallelSubmit  *)
(*=========================*)

PSALTerParallelSubmit~SetAttributes~HoldAll;

PSALTerParallelSubmit[Expr_]:=PSALTerParallelSubmit[{},Expr];
PSALTerParallelSubmit[{Vars___},Expr_]:={Vars}~ParallelSubmit~Block[{Print=Null&,PrintTemporary=Null&},Expr];
