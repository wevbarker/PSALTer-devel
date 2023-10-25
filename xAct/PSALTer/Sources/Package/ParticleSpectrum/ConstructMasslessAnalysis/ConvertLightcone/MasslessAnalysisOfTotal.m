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
(*
	LeafLength=LeafCount@NumeratorFreeSourceEigenvalues;
	If[LeafLength<=500,Expr=InputExpr,Expr="(Hidden for brevity)"];
*)
	SecularEquation=(Det@(#-PoleResidue*IdentityMatrix@Length@#))&@NumeratorFreeSourceCoefficientMatrix;
	Print@SecularEquation;

{NumeratorFreeSourceEigenvalues,SecularEquation}];
