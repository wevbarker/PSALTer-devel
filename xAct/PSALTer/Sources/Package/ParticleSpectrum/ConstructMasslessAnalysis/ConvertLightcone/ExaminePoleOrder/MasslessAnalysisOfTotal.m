(*===========================*)
(*  MasslessAnalysisOfTotal  *)
(*===========================*)

MasslessAnalysisOfTotal[ValuesNumeratorFreeSourceCoefficientMatrix_]:=Module[{
	NumeratorFreeSourceCoefficientMatrix=ValuesNumeratorFreeSourceCoefficientMatrix,
	NumeratorFreeSourceEigenvalues},

	Diagnostic@NumeratorFreeSourceCoefficientMatrix;

	TimeConstrained[
	(
		NumeratorFreeSourceEigenvalues=Eigenvalues@NumeratorFreeSourceCoefficientMatrix;
		NumeratorFreeSourceEigenvalues//=DeleteCases[#,0,Infinity]&;
	)
	30,
	(
		NumeratorFreeSourceEigenvalues={};
	)
	];

NumeratorFreeSourceEigenvalues];
