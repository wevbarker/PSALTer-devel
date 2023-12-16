(*===========================*)
(*  MasslessAnalysisOfTotal  *)
(*===========================*)

MasslessAnalysisOfTotal[ValuesNumeratorFreeSourceCoefficientMatrix_]:=Module[{
	NumeratorFreeSourceCoefficientMatrix=ValuesNumeratorFreeSourceCoefficientMatrix,
	NumeratorFreeSourceEigenvalues},

	Diagnostic@NumeratorFreeSourceCoefficientMatrix;

	NumeratorFreeSourceEigenvalues=Eigenvalues@NumeratorFreeSourceCoefficientMatrix;
	NumeratorFreeSourceEigenvalues//=DeleteCases[#,0,Infinity]&;

NumeratorFreeSourceEigenvalues];
