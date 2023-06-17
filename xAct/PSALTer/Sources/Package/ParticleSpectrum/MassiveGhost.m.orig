(*================*)
(*  MassiveGhost  *)
(*================*)

MassiveGhost[InverseBMatrix_,SquareMassesValues_]:=Module[{
	InverseBMatrixTrace,
	SquareDef,
	TraceResidue},

	If[!(Length@SquareMassesValues===0),
		InverseBMatrixTrace=Tr@InverseBMatrix;
		InverseBMatrixTrace//=Simplify;
		InverseBMatrixTrace=InverseBMatrixTrace/.{Def->Sqrt@SquareDef};
		InverseBMatrixTrace//=Simplify;
		TraceResidue=InverseBMatrixTrace~Residue~{SquareDef,First@SquareMassesValues};
		TraceResidue//=Simplify;
		TraceResidue//=List;,
		TraceResidue={};
	];
TraceResidue];
