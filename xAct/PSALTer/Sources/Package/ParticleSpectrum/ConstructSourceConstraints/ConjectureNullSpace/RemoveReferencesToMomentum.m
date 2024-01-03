(*==============================*)
(*  RemoveReferencesToMomentum  *)
(*==============================*)

RemoveReferencesToMomentum[InputMatrix_]:=Module[{
	FieldRescaleMatrix},
	FieldRescaleMatrix=DiagonalMatrix@((xAct`PSALTer`Def^#)&/@Table[
						ToExpression@("Power"<>ToString@ii),
						{ii,Length@InputMatrix}
						]);
	];
