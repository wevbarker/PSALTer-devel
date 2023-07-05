(*=======================*)
(*  ManualPseudoInverse  *)
(*=======================*)

ManualPseudoInverse[TheInputMatrix_List?MatrixQ/;Precision[TheInputMatrix]===Infinity,TheConjecturedNullSpace_]:=Module[{
	CompensatorMatrix=TheConjecturedNullSpace,
	PseudoInverseMatrix},
	CompensatorMatrix=If[CompensatorMatrix==={},{Table[0,{Length[First[TheInputMatrix]]}]},CompensatorMatrix];
	PseudoInverseMatrix=Inverse[(Transpose@TheInputMatrix).TheInputMatrix+(Transpose@CompensatorMatrix).CompensatorMatrix].(Transpose@TheInputMatrix);
PseudoInverseMatrix];
