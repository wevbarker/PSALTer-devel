(*=======================*)
(*  ManualPseudoInverse  *)
(*=======================*)

ManualPseudoInverse[TheInputMatrix_List?MatrixQ/;Precision[TheInputMatrix]===Infinity,TheConjecturedNullSpace_]:=Module[{
	DimensionsOfMatrix,
	OriginalNullSpace=TheConjecturedNullSpace,
	ColumnNullSpace,
	RowNullSpace,
	CompensatorMatrix,
	Similarity,
	RawInverse,
	PseudoInverseMatrix},
	
	LocalPropagator=" ** ManualPseudoInverse...";

	DimensionsOfMatrix=Length@TheInputMatrix;

	OriginalNullSpace=If[OriginalNullSpace==={},
			{Table[0,{DimensionsOfMatrix}]},OriginalNullSpace];

	Assuming[xAct`PSALTer`Def>0,
		OriginalNullSpace=FullSimplify@Orthogonalize@OriginalNullSpace];

	ColumnNullSpace=Transpose@OriginalNullSpace;
	RowNullSpace=Conjugate@OriginalNullSpace;


	(Diagnostic@#)&@"Checking orthonormality";
	(Diagnostic@#)&@(MatrixForm@Assuming[xAct`PSALTer`Def>0,
			FullSimplify@(RowNullSpace.ColumnNullSpace)]);

	CompensatorMatrix=ColumnNullSpace.RowNullSpace;
	Assuming[xAct`PSALTer`Def>0,CompensatorMatrix//=FullSimplify];
	(Diagnostic@#)&@(MatrixForm@CompensatorMatrix);

	Similarity=(IdentityMatrix@DimensionsOfMatrix)-CompensatorMatrix;

	(Diagnostic@#)&@"Checking annihilation";
	(Diagnostic@#)&@(MatrixForm@Assuming[xAct`PSALTer`Def>0,
			FullSimplify@(Similarity.ColumnNullSpace)]);

	PseudoInverseMatrix=Inverse[TheInputMatrix+CompensatorMatrix];
	(*Assuming[xAct`PSALTer`Def>0,PseudoInverseMatrix//=FullSimplify];*)

	PseudoInverseMatrix=PseudoInverseMatrix.Similarity;
	(*Assuming[xAct`PSALTer`Def>0,PseudoInverseMatrix//=FullSimplify];*)

	PseudoInverseMatrix=(ConjugateTranspose@Similarity).PseudoInverseMatrix;
	(*Assuming[xAct`PSALTer`Def>0,PseudoInverseMatrix//=FullSimplify];*)

	(*PseudoInverseMatrix=Inverse[(ConjugateTranspose@TheInputMatrix).TheInputMatrix+(ConjugateTranspose@CompensatorMatrix).CompensatorMatrix].(ConjugateTranspose@TheInputMatrix);*)
(*
	PseudoInverseMatrix=Inverse[(ConjugateTranspose@TheInputMatrix).TheInputMatrix+(ConjugateTranspose@CompensatorMatrix).CompensatorMatrix].(ConjugateTranspose@TheInputMatrix);
*)
PseudoInverseMatrix];
