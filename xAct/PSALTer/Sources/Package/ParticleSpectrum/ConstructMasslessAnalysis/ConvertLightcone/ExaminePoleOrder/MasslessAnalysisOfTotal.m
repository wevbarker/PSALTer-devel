(*===========================*)
(*  MasslessAnalysisOfTotal  *)
(*===========================*)

MasslessAnalysisOfTotal[ValuesNumeratorFreeSourceCoefficientMatrix_]:=Module[{
	NumeratorFreeSourceCoefficientMatrix=ValuesNumeratorFreeSourceCoefficientMatrix,
	NumeratorFreeSourceEigenvalues,
	SecularEquation},

	Diagnostic@NumeratorFreeSourceCoefficientMatrix;

	NumeratorFreeSourceEigenvalues=Eigenvalues@NumeratorFreeSourceCoefficientMatrix;
	NumeratorFreeSourceEigenvalues//=DeleteCases[#,0,Infinity]&;

	SecularEquation=(Det@(#-PoleResidue*IdentityMatrix@Length@#))&@NumeratorFreeSourceCoefficientMatrix;
	SecularEquation//=FullSimplify;
	(*Print@SecularEquation;*)

{NumeratorFreeSourceEigenvalues,SecularEquation}];
