(*===========================*)
(*  MasslessAnalysisOfTotal  *)
(*===========================*)

MasslessAnalysisOfTotal[RawMasslessPropagaorResidue_List,NullSpace_List]:=Module[{
	MasslessPropagaorResidue=RawMasslessPropagaorResidue,
	NullSpaceDimension,
	FreeSourceVariables,
	NumeratorFreeSourceCoefficientMatrix,
	NumeratorFreeSourceEigenvalues},

	LocalSpectrum=" ** MasslessAnalysisOfTotal...";

	Diagnostic@MasslessPropagaorResidue;
	MasslessPropagaorResidue//=Flatten;
	MasslessPropagaorResidue//=Total;
	MasslessPropagaorResidue//=Simplify;
	Diagnostic@MasslessPropagaorResidue;

	If[!(MasslessPropagaorResidue===0),
		NullSpaceDimension=(Dimensions@NullSpace)[[1]];
		FreeSourceVariables=Table[Symbol["X"<>ToString@i],{i,NullSpaceDimension}];

		NumeratorFreeSourceCoefficientMatrix=Last@CoefficientArrays[MasslessPropagaorResidue,FreeSourceVariables~Join~(Evaluate@Dagger[FreeSourceVariables]),"Symmetric"->False];
		NumeratorFreeSourceCoefficientMatrix=NumeratorFreeSourceCoefficientMatrix[[1;;(1/2)Length@#,(1/2)Length@#+1;;Length@#]]&@NumeratorFreeSourceCoefficientMatrix;
		NumeratorFreeSourceEigenvalues=Eigenvalues@NumeratorFreeSourceCoefficientMatrix;
		NumeratorFreeSourceEigenvalues//=DeleteCases[#,0,Infinity]&;,

		NumeratorFreeSourceEigenvalues={};
	];

{MasslessPropagaorResidue,NumeratorFreeSourceEigenvalues}];
