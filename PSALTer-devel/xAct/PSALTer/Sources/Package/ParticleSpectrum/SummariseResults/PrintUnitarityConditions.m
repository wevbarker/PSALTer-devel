(*============================*)
(*  PrintUnitarityConditions  *)
(*============================*)

PrintUnitarityConditions[InputExpr_]:=If[Length@InputExpr==1,
						Text/@InputExpr,InputExpr];
